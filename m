From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: Linear history *and* share a branch?
Date: Thu, 5 Apr 2012 14:57:36 -0700
Message-ID: <CAE1pOi3Xmv-P4FN-eDkauT2becvdj9rVyFh-hEmVKnnB_pu2ug@mail.gmail.com>
References: <CAE1pOi0-uSaQwgJHMTkw3nqp=idxZxMbyfKtLni0=Xwu-L-_hA@mail.gmail.com>
	<7vfwch51nn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 23:57:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFugY-0001qI-9o
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 23:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2DEV5h convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Apr 2012 17:57:37 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:63172 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab2DEV5h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Apr 2012 17:57:37 -0400
Received: by yhmm54 with SMTP id m54so1032583yhm.19
        for <git@vger.kernel.org>; Thu, 05 Apr 2012 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=0DTI2XU6klCTpH1N0biTFLdIIZ3dP6KRHLkY29a8XtU=;
        b=PCttIMMUOMC99SHigrNA2xs6TrmcnQoytlnfbo5zFKb32eMehlC/xPyVZoL0zWQQYX
         L+jT19KJnkAjCxFjyt1kFEWS2CX5uRdFkIlH0gI9ER3PnCgBPRcchSdcj3IPNu80zBYq
         yfClngXo5NpZvjD5+PO10BpUtEk3fphGtR0n9/KJzxnjJStpjbCt4f3SpKAawKWr9TwJ
         cQZT316goyhKlmgBzzhjMbZpzz64ayjwwVy3X2SIbAnuuwQew9rK1vCpctNz7fj9TxN8
         70mhQNmA3zckJtWZIi3B+9p5JB6GezGxoXqRYqkPFtm4GgIBYYjYZ4PZR+UqLy8tRFxd
         6Mqw==
Received: by 10.236.184.129 with SMTP id s1mr4334782yhm.21.1333663056550; Thu,
 05 Apr 2012 14:57:36 -0700 (PDT)
Received: by 10.236.154.104 with HTTP; Thu, 5 Apr 2012 14:57:36 -0700 (PDT)
In-Reply-To: <7vfwch51nn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194815>

On 5 April 2012 14:06, Junio C Hamano <gitster@pobox.com> wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
>> Hi all,
>>
>> We have been using Git for about a year now in a very small team. So
>> far, everyone has worked on their own local branches and been doing
>> "git rebase master" to make sure their local branches stay in synch.
>> This way we have a nice linear history in master.
>>
>> Recently, it has become useful to share one of these local branches
>> between two devs. Of course, when one of the devs does his usual "gi=
t
>> rebase master", he screws up the other dev's environment. Our soluti=
on
>> has been to keep rebasing the shared branch but to actually work on =
a
>> local branch that is rebased on the shared branch. By judiciously
>> using "git reset" and "git pull" on the shared branch the two devs c=
an
>> keep the shared branch in synch and then use "git rebase
>> shared-branch" on their local branch to keep it in synch to. While
>> this works, there is probably a better/simpler solution.
>>
>> Should we simply do "git merge master" instead of "git rebase master=
"?
>
> That certainly is a sensible thing to do.
>
> But if your people are used to rebasing their own 'master' on top of
> shared 'master', I would imagine that it wouldn't be hard at all for =
these
> two people that work on a topic branch to do the same for their 'topi=
c'
> branch, no? =C2=A0Just like rebasing their 'master' on shared 'master=
', they
> would rebase their own 'topic' on shared 'topic'.

I'm not sure I'm following you here. I agree with what you say but I'm
not clear on exactly how it applies to what I asked. :-/

Rebasing the 'local-topic' on 'shared-topic' branch is certainly
possible but that would not help with linear history with regards to
'master', right? And rebasing 'shared-topic' on 'master' (to get its
updates) would "break" one of the dev's environments. Unless you mean
they should both do that separately? I suppose that's possible. I'm
not clear on the consequences.

It seems that (as Aevar said) we should simply ignore linear history
while 'shared-topic' exists and only rebase on master when integrating
it back into master. But I get the impression that you might have a
slightly different approach in mind?
