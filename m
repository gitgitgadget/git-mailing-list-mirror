X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: bug: git-sh-setup should not be in $PATH
Date: Wed, 6 Dec 2006 15:51:51 +0100
Message-ID: <200612061551.51603.jnareb@gmail.com>
References: <el6c6o$oa7$1@sea.gmane.org> <el6eh6$vg7$2@sea.gmane.org> <4576D0CB.7090408@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 14:50:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gdFhEW5EvHJnxjhCTG7L5kqHZ+vXDa+7lqsodKetGJ0yXvx3YNZnNcE3xS2q2xkMvkHJrUKGtZADUrem+ZbGmzrvzW7tq25ezqg6+UK3UJBGLqu0OSgkrUq//XQ2S0Yhy07ld2vxJ7b7lap7jH5x71dI5qaWbrJ888KHUCJBxRg=
User-Agent: KMail/1.9.3
In-Reply-To: <4576D0CB.7090408@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33462>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gry65-00053l-MH for gcvg-git@gmane.org; Wed, 06 Dec
 2006 15:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760664AbWLFOts (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 09:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760669AbWLFOts
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 09:49:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:42093 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760664AbWLFOtr (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 09:49:47 -0500
Received: by ug-out-1314.google.com with SMTP id 44so161497uga for
 <git@vger.kernel.org>; Wed, 06 Dec 2006 06:49:45 -0800 (PST)
Received: by 10.67.97.18 with SMTP id z18mr900074ugl.1165416585689; Wed, 06
 Dec 2006 06:49:45 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id m1sm30270559ugc.2006.12.06.06.49.44; Wed, 06 Dec
 2006 06:49:45 -0800 (PST)
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org

Han-Wen Nienhuys wrote::
> Jakub Narebski escreveu:
>> Han-Wen Nienhuys wrote:
>> 
>>> Subject: [PATCH] Install git-sh-setup.sh into $(prefix)/share/git-core. Call with explicit path.
>> 
>> I like it... but could you check if you don't need to change
>> config.mak.in accordingly for ./configure script to generate proper
>> config.mak.autogen?
> 
> I couldn't see anything, but while I was looking at it, I also added
> support for non-srcdir builds.

[...]
> From 7bbd698891d9102fa26ae53848c9812f6d1b665e Mon Sep 17 00:00:00 2001
> From: Han-Wen Nienhuys <hanwen@lilypond.org>
> Date: Wed, 6 Dec 2006 15:14:08 +0100
> Subject: [PATCH] Allow non-srcdir builds using cd $builddir && $srcdir/configure

Please add some longer commit message.

> Signed-off-by: Han-Wen Nienhuys <hanwen@xs4all.nl>
> ---
>  Makefile            |   19 +++++++++++--------
>  config.mak.in       |    5 +----
>  configure.ac        |   31 ++++++++++++++++++++++++++++++-
>  generate-cmdlist.sh |    2 +-
>  perl/Makefile       |    2 +-
>  5 files changed, 44 insertions(+), 15 deletions(-)
[...]
> diff --git a/config.mak.in b/config.mak.in
> index 9a57840..902a392 100644
> --- a/config.mak.in
> +++ b/config.mak.in
[...]
> @@ -10,9 +10,6 @@ TAR = @TAR@
>  prefix = @prefix@
>  exec_prefix = @exec_prefix@
>  bindir = @bindir@
> -#gitexecdir = @libexecdir@/git-core/
> -datarootdir = @datarootdir@
> -template_dir = @datadir@/git-core/templates/
>  
>  mandir=@mandir@

Why have you removed setting datarootdir and template_dir? I would
have thought that you would rather change it to

  #gitexecdir = @libexecdir@/git-core/
  datarootdir = @datarootdir@
  GIT_datadir = @datadir@/git-core/
  template_dir= @datadir@/git-core/templates/
  
in config.mak.in

I have been told that setting 'datarootdir' is required to avoid
warnings with new versions of autoconf.

> diff --git a/configure.ac b/configure.ac
> index 34e3478..ccf9374 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -5,11 +5,13 @@ AC_PREREQ(2.59)
>  AC_INIT([git], [@@GIT_VERSION@@], [git@vger.kernel.org])
>  
>  AC_CONFIG_SRCDIR([git.c])
> -
> +srcdir=`cd $srcdir && pwd`
>  config_file=config.mak.autogen
>  config_append=config.mak.append

AC_CONFIG_SRCDIR should set 'srcdir' correctly.

> @@ -330,10 +332,37 @@ GIT_PARSE_WITH(iconv))
[...]
> +## generate subdirectories and sub Makefiles. 
> +for d in `cd $srcdir &&  find . -type d -print | grep -v '\.git'` ;
> +do
> +  if test ! -d  $d ; then
> +    echo creating $d 
> +    mkdir $d
> +  fi
> +  
> +  if test -f $srcdir/$d/Makefile ; then
> +    
> +    dnl [[]] is to keep m4 happy
> +    depth=`echo $d/ | sed -e 's!^\./!!g' -e 's![[^/]]*/!../!g'`
> +    echo creating $d/Makefile
> +    cat << EOF > $d/Makefile
> +include ${depth}config.mak.autogen
> +here-srcdir=\$(srcdir)/$d/
> +VPATH=\$(here-srcdir)
> +include \$(here-srcdir)/Makefile
> +EOF
> +
> +  fi 
> +done
> +exit 1

What is this for? The ./configure script, generated by autoconf from
configure.ac (by "make configure"), generates config.mak.autogen file
from config.mak.in, which is included in main (top) Makefile.

The variables defined in config.mak.autogen are of course visible in
make in subdirectories (make invoked from main makefile). Why the change?
What about user-generated config.mak?

This part IMHO has no sense, and has no place here.
-- 
Jakub Narebski
