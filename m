From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] git-am: Ignore whitespace before patches
Date: Wed, 9 Jun 2010 15:35:03 +0000
Message-ID: <AANLkTikIlGeIEDdCo35us_Ovfmw3Cj4TQwCgDWAf1ecB@mail.gmail.com>
References: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 09 17:35:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMNJK-0001lg-3m
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 17:35:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab0FIPfH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 11:35:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40255 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757295Ab0FIPfF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 11:35:05 -0400
Received: by fxm8 with SMTP id 8so3678078fxm.19
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=cuxIlOucZsCV4ciyzfHt2l1qzj47+Nu7YytZH7+dg8o=;
        b=bguFNwG1VqYGxUCdGFaGBbZlLI0JlUGaf7zlpEb5ulhVijMAOsMonyATt9wh4zyqn1
         XPAvaxpz6GcXCJIhqx1qk5svbVmBWRFAVqC/ukbhxdS5sYJNlEXZiNQOoqX/XtBj9FBh
         m3lJsXb2erHLJGYVbusCKPP6mPms/bnuztmEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UdeKUxJolv0lx7cwsnWTw3e9aHbNFRl31lu0chlX+px+qbJfj4XRgjBoCImAEhFCVh
         jvbuHsuSSMy3vSJ8p1XlfxOduyays3Ahlho5TXt5XYPAFa1CQkVQfGNv//WPTevydjbf
         /OMtAPkuQ7TiiztNG7x84mNfhoC+5Kcf1liO0=
Received: by 10.223.20.216 with SMTP id g24mr18115267fab.63.1276097703849; 
	Wed, 09 Jun 2010 08:35:03 -0700 (PDT)
Received: by 10.223.114.10 with HTTP; Wed, 9 Jun 2010 08:35:03 -0700 (PDT)
In-Reply-To: <1273944188-9472-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148788>

On Sat, May 15, 2010 at 17:23, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> Change git-am to ignore whitespace (as defined by sh's read) at the
> beginning of patches.
>
> Empty lines are wont to creep in at the beginning of patches, here's
> an example from a raw Gmail attachment:
>
> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 20 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> =C2=A0 =C2=A020 20 20 20 20 20 20 20 =C2=A020 20 20 20 20 20 20 0a =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .|
> =C2=A0 =C2=A052 65 74 75 72 6e 2d 50 =C2=A061 74 68 3a 20 3c 61 76 =C2=
=A0|Return-Path: <av|
>
> Whitespace is also likely to appear if the user copy/pastes the patch
> around, e.g. via a pastebin, or any any number of other cases. This
> harms nothing and makes git-am's detection more fault tolerant.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
> =C2=A0git-am.sh =C2=A0 =C2=A0 | =C2=A0 16 +++++++++++++++-
> =C2=A0t/t4150-am.sh | =C2=A0 30 ++++++++++++++++++++++++++++++
> =C2=A02 files changed, 45 insertions(+), 1 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 1056075..1b4baa8 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -172,7 +172,21 @@ check_patch_format () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# otherwise, check the first few lines of =
the first patch to try
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# to detect its format
> =C2=A0 =C2=A0 =C2=A0 =C2=A0{
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 read l1
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 while read -r line
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 case "$line" in
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "")
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Just =
skip whitespace
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # First=
 non-empty line
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 l1=3D$l=
ine
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 esac
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 done
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read l2
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read l3
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$l1" in
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 810b04b..3d089de 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -318,6 +318,36 @@ test_expect_success 'am without --committer-date=
-is-author-date' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test "$at" !=3D "$ct"
> =C2=A0'
>
> +test_expect_success 'am applying a patch that begins with an empty l=
ine' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout first &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 echo > patch1-white &&
> + =C2=A0 =C2=A0 =C2=A0 cat patch1 >> patch1-white &&
> + =C2=A0 =C2=A0 =C2=A0 git am patch1-white &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD | sed -e "/^\$/q" >he=
ad1 &&
> + =C2=A0 =C2=A0 =C2=A0 at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
> + =C2=A0 =C2=A0 =C2=A0 ct=3D$(sed -ne "/^committer /s/.*> //p" head1)=
 &&
> + =C2=A0 =C2=A0 =C2=A0 test "$at" !=3D "$ct"
> +'
> +
> +test_expect_success 'am applying a patch that begins with many empty=
 lines' '
> + =C2=A0 =C2=A0 =C2=A0 git checkout first &&
> + =C2=A0 =C2=A0 =C2=A0 test_tick &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0 " > patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0" >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo " " >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo "" >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo " " >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0" >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 echo " =C2=A0 " >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 cat patch1 >> patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 git am patch1-white2 &&
> + =C2=A0 =C2=A0 =C2=A0 git cat-file commit HEAD | sed -e "/^\$/q" >he=
ad1 &&
> + =C2=A0 =C2=A0 =C2=A0 at=3D$(sed -ne "/^author /s/.*> //p" head1) &&
> + =C2=A0 =C2=A0 =C2=A0 ct=3D$(sed -ne "/^committer /s/.*> //p" head1)=
 &&
> + =C2=A0 =C2=A0 =C2=A0 test "$at" !=3D "$ct"
> +'
> +
> =C2=A0# This checks for +0000 because TZ is set to UTC and that shoul=
d
> =C2=A0# show up when the current time is used. The date in message is=
 set
> =C2=A0# by test_tick that uses -0700 timezone; if this feature does n=
ot
> --
> 1.7.1.84.gd92f8
>
>

Adding Giuseppe Bilotta who wrote the original code I'm modifying to
the CC list.

It would be nice to get an ack or tested-by for this trivial patch. It
makes git-am & GMail integration much easier. Thanks.
