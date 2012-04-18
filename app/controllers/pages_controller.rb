class PagesController < ApplicationController
  def login
    logging = false
    if params[:login] == nil
      username = password = ""
    else
      logging = true
      username = params[:login][:username]
      password = params[:login][:password]
    end
    conn = ActiveRecord::Base.connection
    user_id = conn.select_value("select getID('" + username + "','" + password + "')").to_i
    if logging
      cookies.signed[:uid] = user_id
      redirect_to :controller => "user", :action => "index"
    end
  end
end
