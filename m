From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-instaweb: pass through invoking user's path to
	gitweb CGI scripts
Date: Thu, 15 Apr 2010 23:34:32 -0700
Message-ID: <20100416063432.GA27115@dcvr.yhbt.net>
References: <59ee8c7a3052ed747b5dbaa0a1d0e51aded9c413.1271337968.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 08:34:56 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2f8U-0001WU-Hn
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 08:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0DPGeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 02:34:37 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:43484 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753288Ab0DPGeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 02:34:36 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2FD1F505;
	Fri, 16 Apr 2010 06:34:32 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <59ee8c7a3052ed747b5dbaa0a1d0e51aded9c413.1271337968.git.chris@arachsys.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145052>

Chris Webb <chris@arachsys.com> wrote:
> When used with lighttpd or mongoose, git-instaweb previously passed a
> hard-coded, default value of PATH to the gitweb CGI script. Use the invoking
> user's value for PATH for this instead. (This is already implicitly the
> behaviour for other web servers supported by git-instaweb.)
> 
> Signed-off-by: Chris Webb <chris@arachsys.com>

Looks good to me, thanks Chris.

Acked-by: Eric Wong <normalperson@yhbt.net>

> ---
>  git-instaweb.sh |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index d4941a9..f608014 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -212,7 +212,7 @@ server.errorlog = "$fqgitdir/gitweb/error.log"
>  # variable above and uncomment this
>  #accesslog.filename = "$fqgitdir/gitweb/access.log"
>  
> -setenv.add-environment = ( "PATH" => "/usr/local/bin:/usr/bin:/bin" )
> +setenv.add-environment = ( "PATH" => env.PATH )
>  
>  cgi.assign = ( ".cgi" => "" )
>  
> @@ -361,7 +361,7 @@ error_log	$fqgitdir/gitweb/error.log
>  access_log	$fqgitdir/gitweb/access.log
>  
>  #cgi setup
> -cgi_env		PATH=/usr/local/bin:/usr/bin:/bin,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
> +cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
>  cgi_interp	$PERL
>  cgi_ext		cgi,pl
>  
> -- 
> 1.7.0.3
> 
