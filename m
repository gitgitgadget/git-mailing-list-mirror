From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH/RFC v3 0/7] Add internationalization support to Git
Date: Wed, 2 Jun 2010 00:11:06 +0000
Message-ID: <AANLkTimhxqGRPjYz-k5f-LTIk6KajEwUuGJWt-dAKZQT@mail.gmail.com>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275435597-4017-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jeff Epler <jepler@unpythonic.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 02 02:11:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJbYQ-00071n-EV
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 02:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151Ab0FBALJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 20:11:09 -0400
Received: from mail-yw0-f179.google.com ([209.85.211.179]:34019 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754855Ab0FBALI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 20:11:08 -0400
Received: by ywh9 with SMTP id 9so4393714ywh.17
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 17:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mzs2oEqGwsVeR+Px0PIfueXFJGKtETHI5dqvJxWuDH8=;
        b=w34cZrC5G45Y73/9wzL05DzDwo85/PkQQd6ZnGDnh7xWn/OA/Qcj7LmD7F8w5yjwiS
         H+uUS0ZOstI3S9ni0aR1bJSV/sH/5FKNTsaPvM58XDK58xt8zLH0Xg7+CAmuATCKHtGY
         F5bbLLMh5W015IS5ZG0utwq87hHrfSeP+/Ii8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XJ5hUS5Fi5X+QYFWC6DRboZ+w1aAhVcpJWxmZ8isku3KuIeW6b2GAqUJDh5P4pX5XG
         HSu2f0f/6SAKXIXKexeyypvKET6H6LLpMG4lfAZ3xFKmuvT4yqrRQ/tX+hCeffKzO3qe
         EPTN8bl/1QAQUgCwjmb4KpxCg+Ru0r/5rZo/c=
Received: by 10.231.120.76 with SMTP id c12mr8724009ibr.92.1275437466158; Tue, 
	01 Jun 2010 17:11:06 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Tue, 1 Jun 2010 17:11:06 -0700 (PDT)
In-Reply-To: <1275435597-4017-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148173>

On Tue, Jun 1, 2010 at 23:39, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:
> Here's version 3 of the patch series begun by Jeff Epler to make Git
> optionally translatable with GNU gettext.
>
> This version contains a lot of fixes to issues pointe out by Jakub
> Narebski, and other misc.
> [...]
> =C2=A0* The GIT_TEXTDOMAINDIR environment variable can be set to over=
ride
> =C2=A0 =C2=A0where the C/Perl/Shell locale files are found. This is i=
ntended to
> =C2=A0 =C2=A0be set by the test suite.

I made a silly error in my rebases and rewrote this commit out of my
tree. Instead of sending new commits here's the `git diff -w` below:

    diff --git a/git-sh-setup.sh b/git-sh-setup.sh
    index d67901c..379c9a1 100644
    --- a/git-sh-setup.sh
    +++ b/git-sh-setup.sh
    @@ -219,7 +219,12 @@ if test $? -eq 0
     then
         TEXTDOMAIN=3Dgit
         export TEXDTOMAIN
    +	if [ -z "$GIT_TEXTDOMAINDIR" ]
    +	then
         TEXTDOMAINDIR=3D"@@LOCALEDIR@@"
    +	else
    +		TEXTDOMAINDIR=3D$GIT_TEXTDOMAINDIR
    +	fi
         export TEXTDOMAINDIR
     else
         # Since GNU gettext.sh isn't available we'll have to define ou=
r
    diff --git a/perl/Git/I18N.pm b/perl/Git/I18N.pm
    index 568fd3d..e19d99b 100644
    --- a/perl/Git/I18N.pm
    +++ b/perl/Git/I18N.pm
    @@ -11,7 +11,7 @@ our @EXPORT_OK =3D @EXPORT;

     sub __bootstrap_locale_messages {
     	our $TEXTDOMAIN =3D 'git';
    -	our $TEXTDOMAINDIR =3D '++LOCALEDIR++';
    +	our $TEXTDOMAINDIR =3D $ENV{GIT_TEXTDOMAINDIR} || '++LOCALEDIR++'=
;

     	require POSIX;
     	POSIX->import(qw(setlocale));
    diff --git a/t/t0200-gettext.sh b/t/t0200-gettext.sh
    index a8f9edd..7c2a4cb 100755
    --- a/t/t0200-gettext.sh
    +++ b/t/t0200-gettext.sh
    @@ -1,5 +1,7 @@
     #!/bin/sh

    +export GIT_TEXTDOMAINDIR=3D`pwd`/../share/locale
    +
     test_description=3D'Gettext support for Git'
     . ./test-lib.sh
     . ../../git-sh-setup
    @@ -9,7 +11,8 @@ test_expect_success 'sanity: $TEXTDOMAIN is git' '
     '

     test_expect_success 'sanity: $TEXTDOMAINDIR exists' '
    -	test -d $TEXTDOMAINDIR
    +	test -d $TEXTDOMAINDIR &&
    +	test $TEXTDOMAINDIR =3D $GIT_TEXTDOMAINDIR
     '

     test_expect_success 'sanity: Icelandic locale was compiled' '

Along with another silly error:

    diff --git a/git-sh-setup.sh b/git-sh-setup.sh
    index 379c9a1..da8c47f 100644
    --- a/git-sh-setup.sh
    +++ b/git-sh-setup.sh
    @@ -218,7 +218,7 @@ esac
     if test $? -eq 0
     then
         TEXTDOMAIN=3Dgit
    -       export TEXDTOMAIN
    +       export TEXTDOMAIN
            if [ -z "$GIT_TEXTDOMAINDIR" ]
            then
                    TEXTDOMAINDIR=3D"@@LOCALEDIR@@"


These fixes will be included (along with any other fixes) in my next
series. Which'll be submitted after soliciting more RFC
comments. Sorry everyone.
