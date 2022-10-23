class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :destroy]


  def create
    @book = Book.new (book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] =  "You have created book successfully."
      redirect_to books_path
    else
      render :new
    end
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def destroy

    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path

  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
     book = Book.find(params[:id])
     user = book.user

    if(current_user != user)
      redirect_to books_path
    end
  end

end
