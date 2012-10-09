From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH] configure.ac: Add missing comma to CC_LD_DYNPATH
Date: Tue, 09 Oct 2012 23:10:46 +0200
Message-ID: <507492D6.3090207@gmail.com>
References: <1349800026-10717-1-git-send-email-sunny@sunbase.org> <1349800572-2963-1-git-send-email-sunny@sunbase.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: =?UTF-8?B?IsOYeXZpbmQgQS4gSG9sbSI=?= <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:11:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLh4w-00037H-M5
	for gcvg-git-2@plane.gmane.org; Tue, 09 Oct 2012 23:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756809Ab2JIVKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2012 17:10:52 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59558 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab2JIVKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2012 17:10:51 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2918261bkc.19
        for <git@vger.kernel.org>; Tue, 09 Oct 2012 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=JSMzoIk/Nieai3jbIHpHoTGmlOICmg47YyH523bNjIs=;
        b=jL4B/VGyij6Hp5EtmCsoBN1vkAoLIHNA2dGrzPGjIapRIuheQPRbX9utdlEDaIOx/E
         SBCKzLyjg4QxMJdaYKLA37Hl5k7BwnMtCWb97xVokfTEP+jgulVy66Uunx2N2bk2x5bd
         kraIppzVAT+TR+3n5ypHEEKaIMuzndrsJwxeC17iUjyn7CVSsycqyQmpol3YQnMapmmP
         HG4bPnhYz9WWYn+h34wLDEEgLzE1RC2rEfvelE17MDtooSkKjgNoaAiBHOMYr8RCXe/j
         lffTkbSOiWpRHZImF2QiHAZIdpppaHeynNnSVBnzLJUp/O9DbTJ8FvssdfKjT1GuRUNS
         vHJA==
Received: by 10.204.9.136 with SMTP id l8mr7214988bkl.78.1349817050053;
        Tue, 09 Oct 2012 14:10:50 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id z22sm15781878bkw.2.2012.10.09.14.10.48
        (version=SSLv3 cipher=OTHER);
        Tue, 09 Oct 2012 14:10:49 -0700 (PDT)
In-Reply-To: <1349800572-2963-1-git-send-email-sunny@sunbase.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207347>

[Re-sending because I forgot to CC: the list, sorry]

On 10/09/2012 06:36 PM, =C3=98yvind A. Holm wrote:
> From: "=C3=98yvind A. Holm" <sunny@sunbase.org>
>
> 40bfbde ("build: don't duplicate substitution of make variables",
> 2012-09-11)
>
Oops, stupid copy and paste error on my part.  Sorry.

> breaks make by removing a necessary comma at the end of
> "CC_LD_DYNPATH=3D-rpath" in line 414 and 423.
>
Here, s/-rpath/-Wl,-rpath/, as you've noted yourself in a follow-up
message.  And the reference to "line 423" should be removed.

Also, as a very minor nit, I'd write "might break make" rather then
"breaks make", because the breakage depends on which code path is
taken at configure time (and that's why I hadn't noticed the error
until now -- I never ran configure with the '--with-zlib' option).

> When executing "./configure --with-zlib=3DPATH", this resulted in
>
>       [...]
>       CC xdiff/xhistogram.o
>       AR xdiff/lib.a
>       LINK git-credential-store
>   /usr/bin/ld: bad -rpath option
>   collect2: ld returned 1 exit status
>   make: *** [git-credential-store] Error 1
>   $
>
> during make.
>
Indeed, I can reproduce and confirm this error :-(

> Signed-off-by: =C3=98yvind A. Holm <sunny@sunbase.org>
> ---
>  configure.ac | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/configure.ac b/configure.ac
> index da1f41f..ea79ea2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -411,7 +411,7 @@ else
>        LDFLAGS=3D"${SAVE_LDFLAGS}"
>     ])
>     if test "$git_cv_ld_wl_rpath" =3D "yes"; then
> -      CC_LD_DYNPATH=3D-Wl,-rpath
> +      CC_LD_DYNPATH=3D-Wl,-rpath,
>     else
>        AC_CACHE_CHECK([if linker supports -rpath], git_cv_ld_rpath, [
>           SAVE_LDFLAGS=3D"${LDFLAGS}"
> @@ -420,7 +420,7 @@ else
>           LDFLAGS=3D"${SAVE_LDFLAGS}"
>        ])
>        if test "$git_cv_ld_rpath" =3D "yes"; then
> -         CC_LD_DYNPATH=3D-rpath
> +         CC_LD_DYNPATH=3D-rpath,
>
And as Junio noted, this second hunk is unneeded, and in fact wrong.
Just remove it please.

With that done,
Acked-by: Stefano Lattarini <stefano.lattarini@gmail.com>

>        else
>           CC_LD_DYNPATH=3D
>           AC_MSG_WARN([linker does not support runtime path to dynami=
c libraries])
Thanks,
  Stefano
