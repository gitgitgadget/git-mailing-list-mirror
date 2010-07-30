From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] checkout: add a test for creating a new branch with 
	regexp as a starting point
Date: Fri, 30 Jul 2010 11:54:00 +0000
Message-ID: <AANLkTikan0hnUa-p-U1dfRKq+bORmrn7A3YTPOPe2N_k@mail.gmail.com>
References: <20100729220111.GA28176@wo.int.altlinux.org>
	<201007300136.13501.trast@student.ethz.ch>
	<AANLkTi=Qf1OUmjkpL-6e8gT8MU9G=m37sxrdAoyj5=R0@mail.gmail.com>
	<20100730084428.GA9577@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Fri Jul 30 13:54:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeoAD-0007qK-E8
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 13:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178Ab0G3LyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 07:54:04 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42094 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab0G3LyB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 07:54:01 -0400
Received: by ywh1 with SMTP id 1so574326ywh.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 04:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=K6k/Fxj3MRrlj/6OjJhZfaSfYE18O9fmCOkjUgZHPRM=;
        b=bsw3ycF+I3oTL9v7XNmx4rEeD1GmAeeaZPBSInXO92CbIUPvgUwC6PMFlZ7kRTrQLf
         lxuoSzurHSC2m9Pf8W/t0kG1IiHFimXJiDlyEb9hZS7hAcuysIIMMa3Jegyll3gB9EZo
         20hVAiYScDo6X2njMsf7GHcSrRtkyONjNbc3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GJ9YwmSsDuSXyuXz2xUHduNeYSToXvxfksjns+bWbxNFWv1CT9HVn+tV3glc0PcWhI
         W75daYvN7qf6ugieZpuJWd34pQ9iPLJBZF+PXiVN1yqSJnUB0Ao6ZTWxBkVlPIjiAlc2
         3rwxzZObXgwmp77IV/fO52YPHzbW9YBd1l0Ug=
Received: by 10.150.73.9 with SMTP id v9mr3008846yba.119.1280490840687; Fri, 
	30 Jul 2010 04:54:00 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 30 Jul 2010 04:54:00 -0700 (PDT)
In-Reply-To: <20100730084428.GA9577@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152241>

On Fri, Jul 30, 2010 at 08:44, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> On Thu, Jul 29, 2010 at 11:07:20PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> On Thu, Jul 29, 2010 at 22:01, Dmitry V. Levin wrote:
> [...]
>> > +test_expect_success setup '
>> > + =C2=A0 =C2=A0 =C2=A0 echo a > a &&
>> > + =C2=A0 =C2=A0 =C2=A0 git add a &&
>> > + =C2=A0 =C2=A0 =C2=A0 test_tick &&
>> > + =C2=A0 =C2=A0 =C2=A0 git commit -m first &&
>> > + =C2=A0 =C2=A0 =C2=A0 echo b > b &&
>> > + =C2=A0 =C2=A0 =C2=A0 git add b &&
>> > + =C2=A0 =C2=A0 =C2=A0 test_tick &&
>> > + =C2=A0 =C2=A0 =C2=A0 git commit -m second
>> > +'
>>
>> This should use test_commit (see t/README), but...
>
> The peculiarity of this bug makes it impossible, because test_commit(=
)
> also creates a tag which spoils test conditions.

I didn't know that. It'd be good if the commit message or a comment
indicated that. And actually, we should probably have a
test_commit_notag() then.

>> > +test_expect_success checkout '
>> > + =C2=A0 =C2=A0 =C2=A0 git checkout -b new_branch :/first
>> > +'
>> > +
>> > +test_done
>>
>> ...it looks like this can just be added to the end of
>> t2018-checkout-branch.sh instead of creating a new test. Creating a
>> new file just for a single test for such a simple feature is a bit o=
f
>> an overkill.
>
> Well, I see no t2018-checkout-branch.sh yet. =C2=A0What file do you s=
uggest
> appending?

Ah, t2018-checkout-branch.sh only exists on the pu branch, not
master/next. It's probably worthwhile to patch it anyway rather than
adding a new one.
