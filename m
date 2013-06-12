From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: New feature discussion: git rebase --status
Date: Wed, 12 Jun 2013 14:28:51 +0200
Message-ID: <CALWbr2xhhUNTo54u7K5iFr+wSMSiX6JrgTX=QJsDQ6E30uwDzQ@mail.gmail.com>
References: <fb379a75c6c1af6dcff2e65bef1f1836@ensibm.imag.fr>
	<20130611125521.GL22905@serenity.lan>
	<vpqbo7c4wen.fsf@anie.imag.fr>
	<CAE1pOi0azF1pFqhU1Dq3qeXXF+n9xBcAnHOHapTDjbNXop0d2g@mail.gmail.com>
	<CA+55aFwtBm2RPwgXNa48zQM7ONCgzOEN2XdA_MeHsGu4=BDq5w@mail.gmail.com>
	<fa9c12a81ef2e92ba75dd1271d9e0b2d@ensibm.imag.fr>
	<51B857B0.5030603@ensimag.fr>
	<3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?C=C3=A9lestin_Matte?= <celestin.matte@ensimag.fr>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Users <git@vger.kernel.org>,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: =?UTF-8?Q?Mathieu_Li=C3=A9nard=2D=2DMayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
X-From: git-owner@vger.kernel.org Wed Jun 12 14:29:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmkAg-0007cZ-SL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 14:29:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044Ab3FLM2x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 08:28:53 -0400
Received: from mail-qe0-f42.google.com ([209.85.128.42]:37781 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755905Ab3FLM2w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jun 2013 08:28:52 -0400
Received: by mail-qe0-f42.google.com with SMTP id s14so5648246qeb.29
        for <git@vger.kernel.org>; Wed, 12 Jun 2013 05:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Kgw76Kb1dOaqDb5Ohs6BgMCXQADJt/hpodz3MZ0bpL8=;
        b=rPt7WLTBxhFkaGDZHc54l+GhWn270YlU8AA+WWam1y4t67cgXq/V64d/nDGaXFoO83
         bpGCjzQOVCIoLOLg+JXcEKix+gj4/5mWrF0d9eSfl+UmqoY90RC1gvw0JlxoE8jJzC9P
         px54uAvSXijabC+9yPvwZ35C5F3XCaXc7QqT1bwpN8FtqtQAn/UKtr7Kag/jgpZw8CUh
         mNRjZfhDC9XGPgpL7//bSn1ZcPwYtlXTVDsWs1e5NUR3Oas66n6dLYara6fKl4VBuKP7
         llGljZYVSxRGXqdqMBgtl3n2uxSW/4UFEG0xXUSoMGFRc54eHCpb/mYizh8Kku1CdPKI
         3hfQ==
X-Received: by 10.224.79.209 with SMTP id q17mr23373930qak.88.1371040131517;
 Wed, 12 Jun 2013 05:28:51 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Wed, 12 Jun 2013 05:28:51 -0700 (PDT)
In-Reply-To: <3cafe99fe3b868e6fc025110d324b9c8@ensibm.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227606>

On Wed, Jun 12, 2013 at 1:23 PM, Mathieu Li=C3=A9nard--Mayor
<mathieu.lienard--mayor@ensimag.fr> wrote:
> Le 2013-06-12 13:12, C=C3=A9lestin Matte a =C3=A9crit :
>
>> Le 12/06/2013 12:17, Mathieu Li=C3=A9nard--Mayor a =C3=A9crit :
>>>
>>> Now, I'm not sure if we should always display the list of commits
>>> already applied and those left to apply. What I mean is that maybe =
it
>>> would be better to make status require a flag to display the two li=
sts.
>>> Something like (not sure about the flag's name):
>>>
>>> $ git status --rebase-state
>>> # HEAD detached from ecb9f3e
>>> # Already applied 2 patches:
>>> #     b170635... my_commit_message
>>> #     b170635... my_commit_message
>>> # You are currently editing a832578... my_commit_message [3/5] whil=
e
>>> rebasing.
>>> # 2 patches left to apply:
>>> #    b170635... my_commit_message
>>> #    b170635... my_commit_message
>>> #   (use "git commit --amend" to amend the current commit)
>>> #   (use "git rebase --continue" once you are satisfied with your
>>> changes)
>>> # ......
>>> # ......
>>>
>>> What do you guys think ?
>>
>>
>> I agree. When you're in the process of rebasing a big list of commit=
s,
>> it would produce a lot of not-so-useful output, when what you want t=
o
>> see is, most of the time, which commit you are currently editing.
>> So, in my opinion, whole lists should not be displayed by default.

Maybe we can display previous and next commits to provide some
context. Like we do for diff.
=46or example:

$ git status
# HEAD detached from ecb9f3e
# Already applied 330 patches (displaying next 3):
#     b170635... my_commit_message
#     b170635... my_commit_message
#     b170635... my_commit_message
# Already applied 119 (displaying last 3)
#     b170635... my_commit_message
#     b170635... my_commit_message
#     b170635... my_commit_message
# You are currently editing a832578... my_commit_message [120/450]
while rebasing.

Also, I'm not sure about the "--rebase-state" flag. We should probably
have some option to disable it (and re-enable if the default is
changed through a config variable), but my understanding from previous
messages was that not having to learn a new option to use that was
quite important. As a consequence, I removed it from my example.
