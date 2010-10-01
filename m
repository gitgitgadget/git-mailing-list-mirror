From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv4 02/15] t4017 (diff-retval): replace manual exit code
 check with test_expect_code
Date: Fri, 1 Oct 2010 10:38:32 +0000
Message-ID: <AANLkTinqVTqxiHL5tEv+-SS6YURGUoWaPxCgpccZgjEq@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-3-git-send-email-newren@gmail.com>
	<7vd3rwo22t.fsf@alter.siamese.dyndns.org>
	<AANLkTiksEBVUyJnrUETxManHa+ZMCT6+V3C83K75KW2A@mail.gmail.com>
	<20101001102315.GA6816@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 12:38:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1d0k-0005I3-42
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 12:38:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0JAKie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 06:38:34 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64020 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755348Ab0JAKie convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 06:38:34 -0400
Received: by iwn5 with SMTP id 5so3661760iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UXV/2wD34/Fa5w9j44YyKuszRuLfaQvOwy84otLlLmk=;
        b=f9A2ZOqcaN47sZ/OCBD6/33Uz+I60l7lUlcLYGAF7ne3NdNWd+PJ63tlCmWnmfnmHY
         sx6cUGHWVo6dkJsgyPNYezSOfNobOhmbocYesFRqYDKum0QrS1fsOuG2H5Zgpaij3iA8
         dkxPYq9xjw2IhQGWw9UxjRrAf4k4OXfDfRIxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MrcHfRttbwAOwlmvuIpUJh7fWVWeVzUoxXro7iUY641mM5Xnx2Ab60bO0M9sqD8K7w
         LQnMIaxtEi0XS/qJMmUM30hDAquHuvzgolkShu8pNIbO4gRumbrXfz6unhuvVXU9KyZg
         xohX2SbXxB5kG72gRL5XXBKus0CQKmfnxIuhM=
Received: by 10.231.169.149 with SMTP id z21mr5496425iby.11.1285929512816;
 Fri, 01 Oct 2010 03:38:32 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Fri, 1 Oct 2010 03:38:32 -0700 (PDT)
In-Reply-To: <20101001102315.GA6816@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157741>

On Fri, Oct 1, 2010 at 10:23, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Wed, Sep 29, 2010 at 18:07, Junio C Hamano <gitster@pobox.com> wr=
ote:
>>> Elijah Newren <newren@gmail.com> writes:
>
>>>> -test_expect_success 'git diff-tree HEAD^ HEAD' '
>>>> +test_expect_code 1 'git diff-tree HEAD^ HEAD' '
>>>> =C2=A0 =C2=A0 =C2=A0 git diff-tree --exit-code HEAD^ HEAD
>>>> - =C2=A0 =C2=A0 test $? =3D 1
>>>> =C2=A0'
>>
>> It also looks like this will pass for for all exit codes that *aren'=
t*
>> 1, because if $? !=3D 1 +test_expect_code will get the exit code of
>> 1.
>
> You probably missed the - indicating that the "test $? =3D 1" was bei=
ng
> removed.

Correct. I misread that.

> +check_exit_status () {
> + =C2=A0 =C2=A0 =C2=A0 echo "$1" >expect.status
> + =C2=A0 =C2=A0 =C2=A0 shift
> + =C2=A0 =C2=A0 =C2=A0 "$@"
> + =C2=A0 =C2=A0 =C2=A0 echo "$?" >actual.status
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expect.status actual.status
> +}

If we add this it should be in the test-lib.sh, it'll probably be
useful for other tests.

> =C2=A0test_expect_success 'setup' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo "1 " >a &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git add . &&
> @@ -21,110 +29,81 @@ test_expect_success 'git diff --quiet -w =C2=A0H=
EAD^^ HEAD^' '
> =C2=A0'
>
> =C2=A0test_expect_success 'git diff --quiet HEAD^^ HEAD^' '
> - =C2=A0 =C2=A0 =C2=A0 test_must_fail git diff --quiet HEAD^^ HEAD^
> + =C2=A0 =C2=A0 =C2=A0 check_exit_status 1 git diff --quiet HEAD^^ HE=
AD^
> =C2=A0'

In most uses of check_exit_status you're using it is the very last
command within a test_expect_success. Isn't it redundant to using just
"test_expect_code $code ..." there?

> =C2=A0test_expect_success 'check detects leftover conflict markers' '
> @@ -133,10 +112,8 @@ test_expect_success 'check detects leftover conf=
lict markers' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo binary >>b &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git commit -m "side" b &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail git merge master &&
> - =C2=A0 =C2=A0 =C2=A0 git add b && (
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git --no-pager dif=
f --cached --check >test.out
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test $? =3D 2
> - =C2=A0 =C2=A0 =C2=A0 ) &&
> + =C2=A0 =C2=A0 =C2=A0 git add b &&
> + =C2=A0 =C2=A0 =C2=A0 check_exit_status 2 git --no-pager diff --cach=
ed --check >test.out &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test 3 =3D $(grep "conflict marker" test.o=
ut | wc -l) &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git reset --hard
> =C2=A0'

But of course in cases like these it's needed.

In any case, we only use test_expect_code for two tests in the whole
test suite now, and checking the exit status for individual commands
is more self-documenting and less prone to break if we add more tests
to a given test.

So IMO the best thing to do would be to re-appropriate
"test_expect_code" so that it runs inside a test (i.e. does what your
check_exit_status does), and not at the top-level.

Then do s/check_exit_status/test_expect_code/g on your patch, and
change the tests using test_expect_code in t1504-ceiling-dirs.sh and
t6020-merge-df.sh to use test_expect_success + test_expect_code.
