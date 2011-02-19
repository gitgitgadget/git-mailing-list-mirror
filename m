From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 1/3] t/gitweb-lib.sh: print to stderr when gitweb_run
 has errors
Date: Sat, 19 Feb 2011 20:11:36 +0100
Message-ID: <AANLkTinwV0zFTR3zYtN53JJOZYDhtAkhoY4TC1RstZHC@mail.gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com>
	<201102191646.02543.jnareb@gmail.com>
	<AANLkTimFyue2F6aRg7KdqOJZw9dOHY+B0XWCiVBYNOeg@mail.gmail.com>
	<201102191916.21164.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 20:11:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqsDX-0002yp-8F
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 20:11:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755480Ab1BSTLi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 14:11:38 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33302 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119Ab1BSTLi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 14:11:38 -0500
Received: by bwz15 with SMTP id 15so29337bwz.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 11:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=32JjdvA4mPdE0F6AXM2CG7xvtLLTEZc0DV24Ld5XyGM=;
        b=kTT7OepIz9rKLKIkMoqVPth9UFjEOOqDEbKpjz9vFX+GaePSY69rvAlSI4WuNGo1SZ
         Uj0a+azw7sMeBy7Iaztdcl3+U4tjm6vUxhGg8YzLhJEvViVVuidT4xK+AGsNyAzvQuo7
         bYE1SPSCyjSgmgCnUXtF27ZkykrbpESuCTDdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uyuanEy5cknvJWfxblo80MjQirsZKlMt4UE8qdXnPVfpQu1LDgZa4CcOYHjoYxqnzD
         UAzT5+6vteZyZHexh+dmpYIGUaQSCaSVz6+5cBKZv4SoohR4+EYEmDdz+g6I3YtVoL04
         ZdYRzNy5t8R3GGuqiU8xyZJa5eIurEQnn1vuQ=
Received: by 10.204.123.5 with SMTP id n5mr1926179bkr.58.1298142696616; Sat,
 19 Feb 2011 11:11:36 -0800 (PST)
Received: by 10.204.24.6 with HTTP; Sat, 19 Feb 2011 11:11:36 -0800 (PST)
In-Reply-To: <201102191916.21164.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167306>

On Sat, Feb 19, 2011 at 19:16, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Sat, Feb 19, 2011 at 16:46, Jakub Narebski <jnareb@gmail.com> wro=
te:
>>> On Sat, 19 Feb 2011, =C4=98var Arnfj=C3=B6r=C5=A1 Bjarmason wrote:
>>>
>>>> Change the gitweb_run test subroutine to spew errors to stderr if
>>>> there are any, previously it would just silently fail, which made
>>>> tests very hard to debug.
>>>>
>>>> Before you'd get this output, when running tests under `--verbose
>>>> --immediate --debug`:
>>>
>>> Which test?
>>>
>>> [...]
>>>> --- a/t/gitweb-lib.sh
>>>> +++ b/t/gitweb-lib.sh
>>>> @@ -82,7 +82,12 @@ gitweb_run () {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 close O;
>>>> =C2=A0 =C2=A0 =C2=A0 ' gitweb.output &&
>>>> - =C2=A0 =C2=A0 if grep '^[[]' gitweb.log>/dev/null 2>&1; then fal=
se; else true; fi
>>>> + =C2=A0 =C2=A0 if grep '^[[]' gitweb.log>/dev/null 2>&1; then
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cat gitweb.log>&2
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 false
>>>> + =C2=A0 =C2=A0 else
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 true
>>>> + =C2=A0 =C2=A0 fi
>>>
>>> I don't understand this change. =C2=A0Either it is not necessary, b=
ecause
>>> test suite (or at least t9500) has
>>>
>>> =C2=A0test_debug 'cat gitweb.log'
>>>
>>> after each test, so that error messages would be printed with `--de=
bug`,
>>> or it doesn't go far enough: if the above is used then those test_d=
ebug
>>> should be removed.
>>
>> The way you're using test_debug() is incompatible with
>> --immediate. The test dies, but I'll never see your debug message
>> because I'm using --immediate.
>
> Ah, so that is what it is about: using --immediate negates --debug.

Yeah, I didn't realize that when I submitted my patch, I just thought
it would never be printed, period.

> Note that it is *much* wider issue; it is not only gitweb tests that =
use
> test_debug in such way. =C2=A0See for example t/t4114-apply-typechang=
e.sh
> where you have

Indeed, it's all over the test suite.

> =C2=A0test_expect_success SYMLINKS 'directory becomes symlink' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git checkout -f foo-becomes-a-directory &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-tree -p HEAD foo-symlinked-to-bar=
 > patch &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git apply --index < patch
> =C2=A0 =C2=A0 =C2=A0 =C2=A0'
> =C2=A0test_debug 'cat patch'
>
> This causes the same problem.
>
>> It would be better to just use test_debug in gitweb_run (instead of =
my
>> "cat gitweb.log").
>>
>> Anyway, if you feel like fixing that feel free, I wan't pursue this
>> further (going to hack on what I was going to do before gitweb tests
>> started failing).
>>
>> Junio, you can drop this patch since it'll produce duplicate output =
if
>> the test fails and the user *doesn't* use --immediate, but IMO this
>> should be fixed by doing the debug output differently.
>
> Below there is proposed patch that removes duplication of --debug out=
put...
> but does not solve issue for other places where we use test_debug in =
test
> suite and incompatibility with --immediate run.

This patch looks good to me.
