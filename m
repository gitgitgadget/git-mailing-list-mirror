From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH GSoC] gitweb: Add global installation target for gitweb
Date: Fri, 14 May 2010 17:07:25 +0200
Message-ID: <201005141707.26416.jnareb@gmail.com>
References: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	Eric Wong <normalperson@yhbt.net>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 14 17:07:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCwUK-0006Fw-I4
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756764Ab0ENPHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 11:07:36 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:38128 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756716Ab0ENPHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 11:07:32 -0400
Received: by ewy8 with SMTP id 8so905472ewy.28
        for <git@vger.kernel.org>; Fri, 14 May 2010 08:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=FF1qUaVu0stp64LUbNbrUbzsE0Bzz422dBPdQB0Uf9w=;
        b=ZK+9qTF+yBAi9DNuZT4tV+Vuc4wcuNkiQAmieOVzOV6Z0vcyxaBgscdKKClQuKLkox
         41UMz1MK1Heqxd9hgWcg9ttmSrVAcYUjHAzythaH7kgvYorwoJz/Mz+6TZGOwyKvCmTF
         rzBrTtcUueCa0b6tTZc7hyRhFShkySj9dQDxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=DxbDuhQEIqmoGwdCpfHpR/SWUI68Yb2urFHuYdYEZjlhOtczNrmRXC8AFf7Yhyvtqz
         zDU0K5xIhLTsRS8MCeITq0ymwjgEGdbJM0xnKCOyw2c0xgjxy0byrkhRgzzTK9c6HZAX
         35c/Qzrq9A3gV9UXCe42yj0d9blnE2u6EKcdI=
Received: by 10.103.205.23 with SMTP id h23mr1010739muq.88.1273849650597;
        Fri, 14 May 2010 08:07:30 -0700 (PDT)
Received: from [192.168.1.13] (abvp84.neoplus.adsl.tpnet.pl [83.8.213.84])
        by mx.google.com with ESMTPS id i7sm10919371mue.34.2010.05.14.08.07.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 08:07:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimzoa_B2UV-4J7DvndiLNp5bYhAeT9VU0PqzUWE@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147090>

Cc-ed Eric Wong, the main author and maintainer of git-instaweb

In short: I think that this patch should be split into two patches, one
which sets default value of 'gitwebdir' (in Makefile or gitweb/Makefile;
please explain why you chosen one or the other), and second that "fixes"
git-instaweb (and might include installing gitweb, in $(gitwebdir) or in
$(sharedir)/gitweb).


On Thu, 13 May 2010, Pavan Kumar Sunkara wrote:

> Subject: gitweb: Add global installation target for gitweb

The name "target" is here a bit misleading in the context of Makefile.
You meant that you set default installation destination (default
installation directory) for install-gitweb target in Makefile, by adding
default value of 'gitwebdir' variable.  To clarify this issue I think it
would be better to write:

  gitweb: Set default destination directory for installing gitweb

or something like that.

>
> The current installation of gitweb requires us to give it a
> target directory. But splitting of gitweb makes it difficult
> for git instaweb to continue with the current method.

This paragraph has not a best grammar, and is also slightly inaccurate.
Also having default value for build variables (for a destination
directories for install targets) is a good thing in itself, independent
of the issue of git-instaweb and splitting gitweb.

What about this?

  Currently installing gitweb requires to give a target directory
  (via 'gitwebdir' build variable).  Giving it a default value
  protects against user errors.

  Also git-instaweb in its current form (re)creates gitweb.cgi and
  (some of) required static files in $GIT_DIR/gitweb/ directory for
  each repository it is ran.  Splitting gitweb would make it difficult
  for git-instaweb to continue with this method.

See also comment about git-instaweb below.

> 
> This commit allow installation of gitweb files into the target
> '$(sharedir)/gitweb' by default when user type 'make install'.

I would phrase it a bit differently myself, emphasizing that 
"make install" would now also install gitweb (!):

  This commit sets default installation directory for gitweb files
  to "$(sharedir)/gitweb".  The 'install' target ("make install")
  now also installs gitweb. 

> This target act as root directory for instaweb servers.

It does not, as you have not provided required changes to
git-instaweb.sh and 'git-instaweb' target in main Makefile.

> 
> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>

Two things.

First, I think providing default value for 'gitwebdir' could be I good
idea.  I think that all other build variables containing installation
directories have default values.  But I do wonder whether the
"$(sharedir)/gitweb" is a good default value for 'gitwebdir' (see also
comment about git-instaweb below).


Second, the issue with git-instaweb in its current form, and splitting
gitweb is very important.  I am not sure though if this is correct
solution for this problem.  It is NOT A FULL SOLUTION, that is sure.

The gitweb.cgi file that git-instaweb puts into $GIT_DIR/gitweb/gitweb.cgi
is *modified* to browse given git repository; the gitweb_cgi() function
in git-instaweb that creates gitweb.cgi also changes $projectroot in it:

  script='
  s#^(my|our) \$projectroot =.*#$1 \$projectroot = "'$(dirname "$fqgitdir")'";#;
  s#(my|our) \$gitbin =.*#$1 \$gitbin = "'$GIT_EXEC_PATH'";#;
  s#(my|our) \$projects_list =.*#$1 \$projects_list = \$projectroot;#;
  s#(my|our) \$git_temp =.*#$1 \$git_temp = "'$fqgitdir/gitweb/tmp'";#;'

  gitweb_cgi () {
        cat > "$1.tmp" <<\EOFGITWEB
  @@GITWEB_CGI@@
  EOFGITWEB
        # Use the configured full path to perl to match the generated
        # scripts' 'hashpling' line
        "$PERL" -p -e "$script" "$1.tmp"  > "$1" # <------ '-e "$script"'
        chmod +x "$1"
        rm -f "$1.tmp"
  }

So in its current for git-instaweb wouldn't be able to use generic
gitweb.cgi that is installed in "$(sharedir)/gitweb".

Also git-instaweb when run (when starting server) puts appropriate
configuration into $GIT_DIR/gitweb/httpd.conf (the same file for any web
server chosen).  This configuration includes paths to static files that
gitweb requires, and that currently git-instaweb puts (installs) in
$GIT_DIR/gitweb (in $fqgitdir).  So you would need to change that for a
full solution of git-instaweb problem.

The solution to modifying gitweb.cgi in git-instaweb could be for
git-instaweb to put (install) appropriately configured
gitweb_config.perl file into $GIT_DIR/gitweb, and set GITWEB_CONFIG (and
export) environmental variable to it inside git-instaweb.


By the way, perhaps in the future split gitweb should install its
subpackages (the *.pm files) in the same place that Git.pm is installed,
and for gitweb.perl to have

  use lib (split(/:/, $ENV{GITPERLLIB}));

Or not.  Food for though.

> ---
> 
> This is necessary step to achieve the goals of my GSoC project.
> Currently instaweb script creates gitweb.* files in every repository
> which is unnecessary. So if we have global folder for gitweb files we
> can configure the instaweb server root to point to that direction.

*Can* configure, but you actually doesn't do this.

> 
>  Makefile |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index de7f680..0b262a9 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -269,6 +269,7 @@ mandir = share/man
>  infodir = share/info
>  gitexecdir = libexec/git-core
>  sharedir = $(prefix)/share
> +gitwebdir = $(sharedir)/gitweb

Why in Makefile, and not in gitweb/Makefile?

>  template_dir = share/git-core/templates
>  htmldir = share/doc/git-doc
>  ifeq ($(prefix),/usr)
> @@ -1971,6 +1972,7 @@ install: all
>  	$(MAKE) -C templates DESTDIR='$(DESTDIR_SQ)' install
>  ifndef NO_PERL
>  	$(MAKE) -C perl prefix='$(prefix_SQ)' DESTDIR='$(DESTDIR_SQ)' install
> +	$(MAKE) -C gitweb gitwebdir=$(gitwebdir) install

First, I think that gitwebdir=$(gitwebdir) is not necessary here. Make
automatically passes variables to invoked submakes. And then it would be
as easy as adding 'install-gitweb' (or new 'install-git-instaweb') as
additional dependency for 'install' target.

Second, why don't you set default value of 'gitwebdir' in gitweb/Makefile
instead?

The above are questions that needs to be answered, but not necessarily
require changes to patch.


Please also note that if user wants to install gitweb in for example
'/var/www/cgi-bin', and to do that sets "gitwebdir=/var/www/cgi-bin" in
config.mak file, so that it would be present for "make install" (and not
only "make install-gitweb"), gitweb files would be not present in
"$(sharedir)/gitweb" for git-instaweb to find (well, unless git-instaweb
search for them in "$(gitwebdir)" instead...).


Most important of all, without changes to git-instaweb.sh and
git-instaweb target in main Makefile, installing gitweb by default, be
it

  install: all install-gitweb

or

  	$(MAKE) -C gitweb gitwebdir="$(sharedir)/gitweb" install

doesn't make absoultely no sense.

NAK to this part of patch.

>  endif
>  ifndef NO_PYTHON
>  	$(MAKE) -C git_remote_helpers prefix='$(prefix_SQ)'
> DESTDIR='$(DESTDIR_SQ)' install
> -- 
> 1.7.1.16.g5d405c.dirty
> 

-- 
Jakub Narebski
Poland
