From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 06/15] t3600 (rm): add lots of missing &&
Date: Sat, 2 Oct 2010 20:47:31 -0600
Message-ID: <AANLkTi=oyCFLYuBa6CPCC4PpDt6aPe1wXz98M_F+qary@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
	<1285542879-16381-7-git-send-email-newren@gmail.com>
	<20101001104823.GD6816@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 03 04:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Ec2-00088T-JD
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 04:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493Ab0JCCrg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Oct 2010 22:47:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:33445 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab0JCCrg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Oct 2010 22:47:36 -0400
Received: by fxm14 with SMTP id 14so1241374fxm.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 19:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/z3600Uc8aex1D9gzcy2Sw9t8JcARq2junsboD03nKE=;
        b=WmsBRBmpiqpFkTsB5zmFUt7Q3M5qTBYljPf1ud6LSRIj7IzueDCStDbYcAMNmkW9Hb
         YfHXBeWm3uTVmFiZmxqJGYJYUhJfNRlDFutoSoP0sk0MkFJtk7XvO0RpddP8+TolFGMX
         GZemIAV3GK2OB3rAQ1/c8+g3ZlVySV8pzOefM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JxYdrGwaufBymh0CTUcQKZXpskwdlDw84Mf8aSSdqEnWi0FIohKSjxlf6GOZoVYmCK
         reyRc5jXjUsCcR0WSb5DW/B8Nc9NYWgooSv3xaMp6cn5OIJhsaxkYybJ4HehpVB+yVKP
         HrB9TMkyylqgTIPeiIK6b5gks8b7BwjkNTPAM=
Received: by 10.223.1.144 with SMTP id 16mr4511795faf.32.1286074051736; Sat,
 02 Oct 2010 19:47:31 -0700 (PDT)
Received: by 10.223.126.70 with HTTP; Sat, 2 Oct 2010 19:47:31 -0700 (PDT)
In-Reply-To: <20101001104823.GD6816@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157816>

On Fri, Oct 1, 2010 at 4:48 AM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Elijah Newren wrote:
>
>> Also delete unnecessary, failing code and add some test_when_finishe=
d
>> calls to make sure tests clean up after themselves.
>
> I don't understand this one.
>
> If tests clean up after themselves, each will restore some pristine
> state as though (at least as far as the other tests care) it had neve=
r
> run at all, right?
>
>> --- a/t/t3600-rm.sh
>> +++ b/t/t3600-rm.sh
>> @@ -38,37 +38,33 @@ test_expect_success \
>>
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'Test that git rm --cached foo succeeds if the i=
ndex matches the file' \
>> - =C2=A0 =C2=A0'echo content > foo
>> - =C2=A0 =C2=A0 git add foo
>> + =C2=A0 =C2=A0'echo content > foo &&
>> + =C2=A0 =C2=A0 git add foo &&
>> =C2=A0 =C2=A0 =C2=A0 git rm --cached foo'
>
> Before this runs: foo is empty, absent from index.
> After it runs: foo has content, still absent from index.
> Requires: nothing.
>
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'Test that git rm --cached foo succeeds if the i=
ndex matches the file' \
>> - =C2=A0 =C2=A0'echo content > foo
>> - =C2=A0 =C2=A0 git add foo
>> - =C2=A0 =C2=A0 git commit -m foo
>> - =C2=A0 =C2=A0 echo "other content" > foo
>> + =C2=A0 =C2=A0'echo content > foo &&
>> + =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 git commit -m foo &&
>> + =C2=A0 =C2=A0 echo "other content" > foo &&
>> + =C2=A0 =C2=A0 test_when_finished "git checkout HEAD -- foo" &&
>> =C2=A0 =C2=A0 =C2=A0 git rm --cached foo'
>
> Before this runs: foo has content, absent from index.
> After this runs (without patch): foo has other content, absent from i=
ndex.
> After this runs (with patch): foo has content, matching index.
> Requires: nothing.
>
>> =C2=A0test_expect_success \
>> =C2=A0 =C2=A0 =C2=A0'Test that git rm --cached foo fails if the inde=
x matches neither the file nor HEAD' '
>> - =C2=A0 =C2=A0 echo content > foo
>> - =C2=A0 =C2=A0 git add foo
>> - =C2=A0 =C2=A0 git commit -m foo
>> - =C2=A0 =C2=A0 echo "other content" > foo
>> - =C2=A0 =C2=A0 git add foo
>> - =C2=A0 =C2=A0 echo "yet another content" > foo
>> + =C2=A0 =C2=A0 echo "other content" > foo &&
>> + =C2=A0 =C2=A0 git add foo &&
>> + =C2=A0 =C2=A0 echo "yet another content" > foo &&
>> + =C2=A0 =C2=A0 test_when_finished "git checkout HEAD -- foo" &&
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git rm --cached foo
>> =C2=A0'
>
> Before this runs: see above.
> After this runs (without patch): foo has yet another content, absent =
from index.
> After this runs (with patch): foo has content, matching index.
> Requires (without patch): nothing.
> Requires (with patch): HEAD:foo is content.
>
> [etc]
>
> So if I understand correctly, this sacrifices the ability to
> skip individual tests. =C2=A0What does one gain in return?

Good eye.  It does remove failing code and add correct && chaining,
but yes, it will fail if you skip sufficiently many individual tests.
I believe my original patch submission
(http://article.gmane.org/gmane.comp.version-control.git/157080) does
not suffer from this same problem.  Should I revert to it?

Elijah
