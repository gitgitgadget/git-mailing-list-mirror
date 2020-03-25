Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABECC2D0E5
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75ED42076F
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 19:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IqHHCSE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbgCYT05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:26:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:50839 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbgCYT05 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 15:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585164410;
        bh=zY+pCf9J7oKzIUa+SOWWKcreL8Xtvz9Am35ewzmykao=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IqHHCSE1TMlQ9EQ5pRjZtqfaK3TynTu+0/ae2efT+rkOYzsIu/xyEfap2Rj6KKgaI
         PR7A0tUx+itHphVpE91N7r+OrsWoJJNXE/CoIOjWzrgfIOTvRf3Kp6KWiuLL0k+Mq0
         Avy+tx0Sc9Qa2aFW0845Osz4JX7dpIIFTLBtwYBw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.214.37]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Ml6qM-1jgKLF3uzU-00lRj7; Wed, 25 Mar 2020 20:26:50 +0100
Date:   Wed, 25 Mar 2020 20:26:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     George Spelvin <lkml@SDF.ORG>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: rebase -i inside of rebase -i
In-Reply-To: <20200321175612.GC19579@SDF.ORG>
Message-ID: <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
References: <20200320223015.GA19579@SDF.ORG> <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG> <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet> <20200321175612.GC19579@SDF.ORG>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wErFdB5lK2IHGvwz/YGRr5wDEbiZhxyINtdNwgrdCEgFyRojrPc
 0kw1EyHhZoHjZQVXDPuvZkgOgFZ0U2qJuOquB9Tgq5XnIjTWbgm/AhzsI89sJ+RQ4NI3/mu
 kUg8PcdO/4GQGuzuDavvkErp7zC7Hy+ADNYP3E4f2Igg5UBLRlCJmyZ3DuBlOxR/6VCjxPG
 EqLSiq+U/x6QoMxy/58Gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k5xum1As5GA=:R9t5Vug5UfyuKlUCbefP+5
 mNecXIhkLxGPcGB5iQengBPNOICt8hJ+joPmj9/Vm4ulm0vuMrTZntGM4G3+cuDH78/P6MSr4
 aGK4pQb+Qq1WNjp0GQmn+Mcpv5cABqZE91ss4EvSFUSn+q+XWmVC14HHHhrqsEvt22Kc/JWt5
 SRIEdPJaZ1CZWFrJlnE2jZzThFB0eNlyJGjg+aqgwFAy/OX47bn6Mm3ACafjSQfuXmLdQuW9P
 j+qMf6sOcsvReRl+J6QLOlydDTKEUm/igCUS08khRRLwysCYK40KYSuEiSeslamzeUCkFtfLD
 lAWH24/tEefHdaK2bBUB0RuTa7SRykGJnyNMxMgy+34IaFfSNcmQyQmKXzAgAUJJZ+Cl0+1gZ
 WMHLFglBxvKhMjBuzHUGg/W1Zfp7N4qqOJi+Pl0Yj7/UasCT6jHHl+IPMHp5LXtxu1OrN89ib
 dQXXy79XGdEKOEbwUWbg6XTxqrYFCrjPIruhFAZP6nQF7TKZ1+FumLpMdNLD+9UKOLm8pIldN
 OxLPd/NETrR52/bst9qoCLDUXtu3iVv5JYcVwcbnWo/yYYFaaSvKmeVzSTTUcU9c9EBlE8xl/
 B2TTNEVkay9BmvEybk479UFYmm5ah3AkS+N0x6tL1vU7+3Az+M28VBT12dxd4BU0Jfj3RRjjN
 7m0tmjYw8Bs5YMVeXXuOR9FC1oTpWgj3okExu9/rUN/prRE7Nj+PFSRnpRJWAUH0K82rh6uBi
 Z8r3+99OHUPYVdPNFF6Zog0dsuKrqLAgDGhiZhSXkIWraOcg0+KYTnK8X+ML2+AJfoNE92SPh
 X6ke1XLcFAc+169buPmT7i0zHw/jb8t38lVu73StzS0kFdnhb8YIw89bmePoC3GHMIzjMPzo6
 /2u6saG3BfWr3hlW4d/CIjGQmu5gJ62GRSloyTU7zkiBsEB1tLx3UrE+ydSlfQS75RsiT4rep
 rhLYfr8K5kwWztMjf9B+MqNtiKUQEJ0+8y1j0EvY+nZ9l20xsTQEH6PcgOT65/qD+jV/wSPGP
 HzyzlWSbpAnBLXSgFSnoh3Sj68xKRRtStbA9ejtilNdaF/U4LNpDCrEKXcW3LxAgdHB7iB5mS
 ffTlwD0yB9M6kEEsIqQ36GK3Vxf2ZPU++V1WEaLAWrhHqGKx5o+bECMlSKX1XmgTlb/AlO6Tv
 EIReF1zow/958cQPamOBiehegtQg9gIqRwxwzh/ArWtO6Qd1q+IL3rH+1QX4qcTjLKgJ/TwSe
 qGZjlFCbtsrkl0XPQ
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi George,

On Sat, 21 Mar 2020, George Spelvin wrote:

> On Sat, Mar 21, 2020 at 11:51:10AM +0100, Johannes Schindelin wrote:
> > My biggest caveat is that I had to force-exit the rebase at some stage
> > due to reasons I only vaguely remember. It had something to do with th=
e
> > replacement cache not being updated when an `exec` is executed that ad=
ds a
> > replacement object via `git replace` [*1*]. This issue might have
> > _nothing_ to do with nested rebases, but as I said, my recollection is
> > vague.
>
> This is the sort of internal implementation gotcha I worry about.

There's plenty more gotchas like that ;-)

> > There are a couple more concerns, of course, such as: what to do if th=
e
> > user deletes the entire todo list (which is traditionally the only way=
 to
> > abort a rebase)? My gut feeling is that it should go back to the
> > _previous_ version of the todo list.
>
> My assumption has been that, for simplicity, there would only be one
> commit in progress, and aborting it aborts everything.

But that does not necessarily make sense. Imagine that you rebase the
latest three commits, interactively. Then a merge conflict in the third
makes you realize that the first commit is no longer needed.

Enter the nested rebase. You manually re-schedule the failed `pick` via
`git rebase --edit-todo` and then run the nested rebase: `git reset --hard
&& git rebase -i --nested HEAD~2`.

Except that you made a typo and said `HEAD~3` instead of `HEAD~2`. You
delete the entire todo list to get a chance to restart the nested rebase.

But now the entire rebase gets aborted?

If that would happen to me, I would unleash a whole slew of rarely used
words in the vague direction of whoever implemented the nested rebase
feature...

> > Another big concern is what to do about `rebase.missingCommitsCheck`: =
with
> > nested rebases, this will get increasingly tricky. Like, imagine you a=
re
> > rebasing 5 commits, the third of them results in merge conflicts, you
> > realize that it is obsolete and so is now the first, already rebased
> > commit. You do a nested rebase of the latest two commits to drop them,=
 but
> > they don't have their original commit hashes any longer. So it gets a =
bit
> > finicky to keep track of what commit has been dropped on purpose and w=
hat
> > was forgotten to pick instead.
>
> This doesn't *seem* difficult, but I don't know how the current mechanis=
m
> works.

The implementation details do not matter at this stage. You have to get
the design of the feature right.

I am unfamiliar with the design of the feature as it is implemented right
now, but I imagine that it needs to be adjusted for nested rebases, as we
no longer have a single original todo list to roll back to.

> It just checks that all commits that were on the to-do list when the
> editor started are still listed (possibly marked "drop") when it exits.
>
> When you do a nested commit, additional commits are prepended to the to-=
do
> list, you're dropped into the editor, and the same check is made when th=
e
> editor returns.
>
> If rebase.missingCommitsCheck =3D error is triggered, you end up with th=
e
> <upstream> tree state with nothing applied and may either --continue to
> ignore the error or --edit-todo to put back the missing commits.
>
>
> Let me give an example.  Suppose I have commits a-b-c-d-e, and start
> with rebase -i b.
>
> My to-do list starts out as c-d-e, but suppose I decide to cherry-pick
> z and add it to the list, so it's now z-c-d-e.
>
> So I start rebasing, and it turns out that d creates a merge conflict
> because I forgot a prerequisite patch y.  And I really want y and z befo=
re
> b, anyway.
>
> So the tree state is currently a-b-z'-c', with d in progress and e yet t=
o
> do.  In my simple model, I have to resolve and commit d, so the tree
> state is a-b-z'-c'-d'.  Then I can rebase -i a, and am presented with
> a to-do list of b-z'-c'-d'-e.
>
> If I delete any of those five commits, then rebase.missingCommitsCheck
> will trigger.  If I put y in the list, save it, then change my mind and
> --edit-todo and delete y, it will also trigger.

As I said, I am not using that feature myself, so I do not even know what
"trigger" means in this context. It might totally be okay to use the
existing code as-is in the context of a nested rebase. That remains to be
verified, though, I think.

> Now, it sould be nice if there were a way to say "screw this mess; just
> check out HEAD and put d back on the to-do list", but that could
> create a bit of a mess if I've split d and already committed half of
> it.  If I used that after doung that, I'd have a to-do list of
> b-z'-c'-d'-d-e which might be awkward, but maybe it wouldn't be too bad.

There is all kind of opportunity for messes, all right.

Ciao,
Johannes
