From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2 GSoC] git-instaweb: Configure it to work with new gitweb structure
Date: Sat, 22 May 2010 17:57:37 +0200
Message-ID: <201005221757.38376.jnareb@gmail.com>
References: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 17:57:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFr5G-0003Z9-JD
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 17:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755361Ab0EVP5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 11:57:49 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41912 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab0EVP5s (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 11:57:48 -0400
Received: by fxm5 with SMTP id 5so1556959fxm.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 08:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cMtZ/26cAW/iaz2CeViOiW3gqgXhjj1HHrx34E4P3GQ=;
        b=dcJawZdXSf2cYpD1W9labcVxONOT8omL0roCBiFfIhvQpoi85IQZApNMqmQ1z79JzG
         PICRf76w2Vl3tVcoIRvOhojS7D3JEcwGFMIB6d45tmun34j7LCgkYeIlgnyfPpailRJC
         FN+yR3bIBzMx/+gndHhCD/YLwV6m/4wC7Zcjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=eWIsDBx0rUv7hchtSTdhqi4yl/qdmLsyea3QDCUYfv73a0ac7mJ06jRXrinQ7UB0zw
         WIs+i8zuF+6LENHuH/vdurwsgMVRYPTxZkBIgdgv7XbuuYli1NvH+96H0Uoxpjz1modE
         cGxc3o7lEZpEjP4DWmdl7q/weP6IKDiakIm0A=
Received: by 10.204.9.23 with SMTP id j23mr542045bkj.132.1274543866629;
        Sat, 22 May 2010 08:57:46 -0700 (PDT)
Received: from [192.168.1.15] (abwk129.neoplus.adsl.tpnet.pl [83.8.234.129])
        by mx.google.com with ESMTPS id 24sm9943871bkr.0.2010.05.22.08.57.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 08:57:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1274523105-3327-1-git-send-email-pavan.sss1991@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147529>

On Sat, 22 May 2010, Pavan Kumar Sunkara wrote:

> git-instaweb in its current form (re)creates gitweb.cgi and
> (some of) required static files in $GIT_DIR/gitweb/ directory.
> Splitting gitweb would make it difficult for git-instaweb to
> continue with this method.
> 
> Use the instaweb.gitwebdir config variable to point git-instaweb script
> to a global directory which contains gitweb files as server root
> and the httpd.conf along with server logs and pid go into
> '$(GIT_DIR)/gitweb' directory.

That's not all this patch changes, isn't it?

  While at it, change apache2 configuration to use the same access log
  and error log files as the rest of web servers supported by
  git-instaweb.

While it would be better to have it as a separate commit, I think it
doesn't matter much, and having it in this patch is acceptable as
"while at it" change.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

I like this change, because it simplifies greatly git-instaweb
generation; besides the fact that it is necessary for future splitting
gitweb for better maintability, and for write functionality for gitweb.


Acked-by: Jakub Narebski <jnareb@gmail.com>

_If_ there is no problem with $(gitwebdir) and not $(gitwebdir_SQ),
see below for details.

> ---
> 
> This patch is based on commit 'jn/gitweb-install' in the next branch.

I think it is based on your earlier patches:

* gitweb: Move static files into seperate subdirectory
  http://article.gmane.org/gmane.comp.version-control.git/147321 
* gitweb: Set default destination directory for installing gitweb in Makefile
  http://article.gmane.org/gmane.comp.version-control.git/147160

Those are necessary for this patch to be applied.  Well, the second is
necessary for it to make sense...


BTW. which web servers supported by git-instaweb: lighttpd, apache2,
webrick, mongoose you have tested your change with?

>  Makefile        |   10 +------
>  git-instaweb.sh |   71 ++++++++++++++++++++----------------------------------
>  2 files changed, 28 insertions(+), 53 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index caf2f64..91cd726 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1592,15 +1592,8 @@ git-instaweb: git-instaweb.sh gitweb/gitweb.cgi gitweb/static/gitweb.css gitweb/
>  	sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
[...]
> +	    -e 's|@@GITWEBDIR@@|$(gitwebdir)|g' \
>  	    -e 's|@@PERL@@|$(PERL_PATH_SQ)|g' \
> -            -e 's|@@GITWEB_CSS_NAME@@|$(GITWEB_CSS)|' \
> -            -e 's|@@GITWEB_JS_NAME@@|$(GITWEB_JS)|' \
>  	    $@.sh > $@+ && \
>  	chmod +x $@+ && \
>  	mv $@+ $@
> @@ -1972,6 +1965,7 @@ install: all
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> +	$(MAKE) -C gitweb gitwebdir=$(gitwebdir) install
>  endif

Have you checked that you can use $(gitwebdir) and don't need
$(gitwebdir_SQ) here?  Does git-instaweb installs and works correctly
if 'gitwebdir' contains spaces and single or double quote characters?

But perhaps that doesn't matter in practice, and this is good enough.

> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index f608014..b3e9192 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -24,6 +24,7 @@ restart        restart the web server
>  fqgitdir="$GIT_DIR"
>  local="$(git config --bool --get instaweb.local)"
>  httpd="$(git config --get instaweb.httpd)"
> +root="$(git config --get instaweb.gitwebdir)"
>  port=$(git config --get instaweb.port)
>  module_path="$(git config --get instaweb.modulepath)"
>  
> @@ -34,6 +35,9 @@ conf="$GIT_DIR/gitweb/httpd.conf"
>  # if installed, it doesn't need further configuration (module_path)
>  test -z "$httpd" && httpd='lighttpd -f'
>  
> +# Default is @@GITWEBDIR@@
> +test -z "$root" && root='@@GITWEBDIR@@'
> +

Nice.

> @@ -57,7 +61,7 @@ resolve_full_httpd () {
>  		# these days and those are not in most users $PATHs
>  		# in addition, we may have generated a server script
>  		# in $fqgitdir/gitweb.
> -		for i in /usr/local/sbin /usr/sbin "$fqgitdir/gitweb"
> +		for i in /usr/local/sbin /usr/sbin "$root" "$fqgitdir/gitweb"
>  		do
>  			if test -x "$i/$httpd_only"
>  			then

You probably want to update comment above this loop.  But this is not
something very important.

Alternatively, if e.g. webrick.rb and webrick (shell script) are
installed in "$fqgitdir/gitweb" directory, there is no need to check
"$root".

>  webrick_conf () {
[...]
> -:DocumentRoot: "$fqgitdir/gitweb"
> +:DocumentRoot: "$root"

>  lighttpd_conf () {
>  	cat > "$conf" <<EOF
> -server.document-root = "$fqgitdir/gitweb"
> +server.document-root = "$root"
[...]
> -setenv.add-environment = ( "PATH" => env.PATH )
> +setenv.add-environment = ( "PATH" => env.PATH, "GITWEB_CONFIG" => env.GITWEB_CONFIG )

>  apache2_conf () {
[...]
> -ServerRoot "$fqgitdir/gitweb"
> -DocumentRoot "$fqgitdir/gitweb"
> +ServerRoot "$root"
> +DocumentRoot "$root"
[...]
>  PerlPassEnv GIT_DIR
>  PerlPassEnv GIT_EXEC_DIR
> +PerlPassEnv GITWEB_CONFIG

> @@ -353,7 +359,7 @@ mongoose_conf() {
>  # For detailed description of every option, visit
>  # http://code.google.com/p/mongoose/wiki/MongooseManual
>  
> -root		$fqgitdir/gitweb
> +root		$root
[...]
> -cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH
> +cgi_env		PATH=$PATH,GIT_DIR=$GIT_DIR,GIT_EXEC_PATH=$GIT_EXEC_PATH,GITWEB_CONFIG=$GITWEB_CONFIG

All right, those changes are pretty clear.

> @@ -277,14 +281,15 @@ EOF
>  
>  apache2_conf () {
>  	test -z "$module_path" && module_path=/usr/lib/apache2/modules
> -	mkdir -p "$GIT_DIR/gitweb/logs"
>  	bind=
>  	test x"$local" = xtrue && bind='127.0.0.1:'
>  	echo 'text/css css' > "$fqgitdir/mime.types"
>  	cat > "$conf" <<EOF
>  ServerName "git-instaweb"
> -ServerRoot "$fqgitdir/gitweb"
> -DocumentRoot "$fqgitdir/gitweb"
> +ServerRoot "$root"
> +DocumentRoot "$root"
> +ErrorLog "$fqgitdir/gitweb/error.log"
> +CustomLog "$fqgitdir/gitweb/access.log" combined
>  PidFile "$fqgitdir/pid"
>  Listen $bind$port
>  EOF

This is independent change, modifying configuration of apache2 web
server to use the same files for access log and for error log
("$fqgitdir/gitweb/access.log" and "$fqgitdir/gitweb/error.log",
respectively) as the rest of web servers.

Isn't it?

> @@ -370,41 +376,16 @@ mime_types	.gz=application/x-gzip,.tar.gz=application/x-tgz,.tgz=application/x-t
>  EOF
>  }
>  
> -
> -script='
> -s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
> -s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
> -s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
> -s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'
> -
> -gitweb_cgi () {
[...]

> +gitweb_conf() {
> +	cat > "$fqgitdir/gitweb/gitweb_config.perl" <<EOF
> +#!/usr/bin/perl
> +our \$projectroot = "$(dirname "$fqgitdir")";
> +our \$git_temp = "$fqgitdir/gitweb/tmp";
> +our \$projects_list = \$projectroot;
> +EOF
>  }

Right, $GIT (formerly $gitbin) is set when generating gitweb.cgi from
gitweb.perl.

Actually $git_temp is not needed by modern gitweb (from quite some time,
since using external /usr/bin/diff was replaced by git-diff-tree), so
setting it could be removed from gitweb_config.perl.  Nevertheless it is
not a problem having it.

> -gitweb_cgi "$GIT_DIR/gitweb/gitweb.cgi"
> -gitweb_css "$GIT_DIR/@@GITWEB_CSS_NAME@@"
> -gitweb_js  "$GIT_DIR/@@GITWEB_JS_NAME@@"
> +gitweb_conf
>  
>  case "$httpd" in
>  *lighttpd*)
> -- 
> 1.7.1.18.g74211d.dirty


-- 
Jakub Narebski
Poland
