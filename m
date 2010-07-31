From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/2 v2] test-lib.sh: introduce 4th argument to 
	test_commit() specifying a tag name
Date: Sat, 31 Jul 2010 10:23:15 +0000
Message-ID: <AANLkTi=gNtq1fd4_QPZZX4+nLqUfVJhSA2zA_=0gfKLF@mail.gmail.com>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
	<20100731001845.GA24129@wo.int.altlinux.org>
	<AANLkTik3KBCh6Xn8r8odfdEfH=1Uf1bMKW6ic4UQPRsw@mail.gmail.com>
	<20100731015601.GB19956@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 12:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of9E6-00026O-5i
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 12:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201Ab0GaKXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 06:23:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:62924 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab0GaKXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Jul 2010 06:23:16 -0400
Received: by iwn7 with SMTP id 7so2203279iwn.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 03:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=k/Hc3Hza1Zo+pd82mktAmdbEEkf2EqtLHnSB7hNyz60=;
        b=spW6Zmt+fjxgmNeBGzXgxw5bElF42UYYzuAvWgqCismiOtvCcP0wT6z+XRtv8EYr3v
         JsMvE9TYf7auiKu9ggbts4j4yF2WUWmxkty6j1P7Z+uLXJP2hAkfoQt/2HCOF6LSCmlF
         t+mfGHZ4KFD5s/iNXxkiMoAQpEmr6qC4aYFn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Bmc5j3W7lrvrM/JpCfpXZifJfBK03F2s8NrZjLx80yUK4OgkPpRjee5RxfehLq7zC0
         WmE1qPYZY8ZgaJwmEr+w3DMqW4UxWgCPOKFf0jSis1EGAi+I6+Dn6I8zdME+Bs1LoPMM
         rGLKeQHL2zKo6EMA4BVZCimfI2M4ufMRRSzLQ=
Received: by 10.231.154.73 with SMTP id n9mr3635533ibw.10.1280571795662; Sat, 
	31 Jul 2010 03:23:15 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 31 Jul 2010 03:23:15 -0700 (PDT)
In-Reply-To: <20100731015601.GB19956@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152318>

On Sat, Jul 31, 2010 at 01:56, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> When fourth argument to test_commit() is specified, use it as a tag
> name, unless it equals to empty string. =C2=A0In the latter case, ski=
p tag
> creation.
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> =C2=A0t/README =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A08 ++++----
> =C2=A0t/test-lib.sh | =C2=A0 11 ++++++++---
> =C2=A02 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/t/README b/t/README
> index 0d1183c..18f5810 100644
> --- a/t/README
> +++ b/t/README
> @@ -388,13 +388,13 @@ library for your script to use.
> =C2=A0 =C2=A0committer times to defined stated. =C2=A0Subsequent call=
s will
> =C2=A0 =C2=A0advance the times by a fixed amount.
>
> - - test_commit <message> [<filename> [<contents>]]
> + - test_commit <message> [<filename> [<contents> [<tagname>]]]
>
> =C2=A0 =C2=A0Creates a commit with the given message, committing the =
given
> =C2=A0 =C2=A0file with the given contents (default for both is to reu=
se the
> - =C2=A0 message string), and adds a tag (again reusing the message
> - =C2=A0 string as name). =C2=A0Calls test_tick to make the SHA-1s
> - =C2=A0 reproducible.
> + =C2=A0 message string), and adds a tag with the given name (default=
 again
> + =C2=A0 is to reuse the message string as name) unless this name is =
the
> + =C2=A0 empty string. =C2=A0Calls test_tick to make the SHA-1s repro=
ducible.
>
> =C2=A0- test_merge <message> <commit-or-tag>
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index e5523dd..ebb6215 100644
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
> =C2=A0#
> =C2=A0# Both <file> and <contents> default to <message>.
>
> @@ -290,7 +292,10 @@ test_commit () {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add "$file" &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_tick &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "$1" &&
> - =C2=A0 =C2=A0 =C2=A0 git tag "$1"
> + =C2=A0 =C2=A0 =C2=A0 if test -n "${4-$1}"
> + =C2=A0 =C2=A0 =C2=A0 then
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git tag "${4-$1}"
> + =C2=A0 =C2=A0 =C2=A0 fi
> =C2=A0}
>
> =C2=A0# Call test_merge with the arguments "<message> <commit>", wher=
e <commit>

This one looks good, thanks.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
