From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2] test-lib.sh: introduce 4th argument to test_commit() 
	specifying a tag name
Date: Sat, 31 Jul 2010 00:39:43 +0000
Message-ID: <AANLkTik3KBCh6Xn8r8odfdEfH=1Uf1bMKW6ic4UQPRsw@mail.gmail.com>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
	<20100731001845.GA24129@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 02:39:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of07D-0005UR-Vc
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 02:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab0GaAjp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 20:39:45 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39791 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0GaAjp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 20:39:45 -0400
Received: by iwn7 with SMTP id 7so1835234iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+aq8qjU6yokEeYq95vKYVq9RQ9aruMHORIF7jRTT4d8=;
        b=ouuJO5ssDd0wIujiHQ1hjY3lu5OkTI8zb7014oUb4lwMHHkz71y5XiTk/EClm29r8f
         hm+x8gsf6B7Hu0Aa6GdnNTUDg6hQWn7/g1EewEFmdFsmKfdzgsXMz5Jq5kqIp0rf+Je5
         15YSIKDcYZbDEC4AEIivee1sFfDyFrF5UBvSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JZ3HKCfFeLKM9Ce1YRPMwpfK8ioW4yN8QbDLpRS64vjDBtpGzazEzETGDVkQr2XKjH
         xZLNoLhuz5i6Q3ykR7M9yv1NUzpZ46IZCLrv7mCuuLcvE8Tngo7mHhWpJlGon7BefIof
         DzuoUWkVPSEufxbMb7mDB7REiLsd/gzsrsKBE=
Received: by 10.231.170.21 with SMTP id b21mr2612887ibz.122.1280536784022; 
	Fri, 30 Jul 2010 17:39:44 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 30 Jul 2010 17:39:43 -0700 (PDT)
In-Reply-To: <20100731001845.GA24129@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152275>

On Sat, Jul 31, 2010 at 00:18, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> When fourth argument to test_commit() is specified, use it as a tag
> name, unless it equals to empty string. =C2=A0In the latter case, ski=
p tag
> creation.

Looks good, mostly.

> Suggested-by: =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason <avarab@gmail.co=
m>

Seems like you sent a ISO-8859-1 E-Mail with UTF-8 content.

My name also doubles as a UUID and a UTF-8 canary, you see.

> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> =C2=A0t/test-lib.sh | =C2=A0 =C2=A08 +++++---
> =C2=A01 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 367f053..a203383 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -277,10 +277,12 @@ test_tick () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
> =C2=A0}
>
> -# Call test_commit with the arguments "<message> [<file> [<contents>=
]]"
> +# Call test_commit with the arguments
> +# "<message> [<file> [<contents> [<tagname>]]]"
> =C2=A0#
> =C2=A0# This will commit a file with the given contents and the given=
 commit
> -# message. =C2=A0It will also add a tag with <message> as name.
> +# message. =C2=A0It will also add a tag with the given name unless t=
he latter
> +# is the empty string.

You should also patch t/README, which documents this function.

> =C2=A0# Both <file> and <contents> default to <message>.
>
> @@ -290,7 +292,7 @@ test_commit () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add "$file" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "$1" &&
> - =C2=A0 =C2=A0 =C2=A0 git tag "$1"
> + =C2=A0 =C2=A0 =C2=A0 if test -n "${4-$1}"; then git tag "${4-$1}"; =
fi

This is just a nit, but I'd write this on 4 lines:

if test..
then
    git tag
fi
