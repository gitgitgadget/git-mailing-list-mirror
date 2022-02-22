Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FFFC433EF
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 12:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiBVM3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 07:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiBVM3C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 07:29:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96619107D94
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 04:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1645532911;
        bh=7Zd/dlmVQQfOJryJUykFeNSK1Ar9X9/oJ7o/pFCEURY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H1UPaidg669CuDtsfvVZpCLqBeZ0OUwHoech/Klj/JYUZ4WIOxni9TzDanmzZRFAH
         esKtryKC2ZBrMYevzww45UKzZRKxNE/IdISfurKJ2BtoTGZ2l0rgSm+5LS5TJ+fZxb
         p0j15He5YTGUB5mAkv4LQk1t+wf9MlcEMfAnXXa0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.212.236]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCtj-1nvGbA2Zrr-00bIoT; Tue, 22
 Feb 2022 13:28:31 +0100
Date:   Tue, 22 Feb 2022 13:28:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jose Lopes <jabolopes@google.com>,
        Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH] Provide config option to expect files outside sparse
 patterns
In-Reply-To: <CABPp-BGz0Y+Gk0uLy7K-pqBY955=rN-E2SJFofDaje60b-XZuw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2202221313400.11118@tvgsbejvaqbjf.bet>
References: <pull.1153.git.1645333542011.gitgitgadget@gmail.com> <54a0aa74-57c2-ee65-ae07-cb1b0daf947f@github.com> <CABPp-BGz0Y+Gk0uLy7K-pqBY955=rN-E2SJFofDaje60b-XZuw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3TBrZVkpc4MQJc1g89hca8AYu+U6AaRYG3mQf/fjz5KdZRgGDim
 E8bnbNITn6d9GkCwCwHA5re/d97wdReoo4Y1XpSfs4/jX3PdjNb6SHkAQ/ecuiu8ijoDHE0
 FppzUytbbIlh7bN0zQDD6X8l3p3HYU4vwJ/0UsG95KSeVM4XOX5Zl3EL4g10Ycm7UQ3uHP2
 cqQNsSIIB0Y75ooLWMG8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Stsxt5+fYzE=:MFfOgrMFv7eQIeXhBqbd0p
 4Dw9OukHN15Hv4Zj012tavi5aTe8piYIl+Jbv0dVv4RSsjmPeoMc/u29CX/1gXP3jBguh8pnA
 i3njYMB5bMqoBdKmbxQVP5Y3R1DZVB/6BeNyEsssyd7081ftK8byvnkSbtKGub3oiLNxKPNnF
 J73QJE2g5Oz6hsfYbDL98+kqLuKpOCoASLFUtcX+qXTONKZ6BKDoZE8A+5Y7o6VxdU03KjlOd
 fviuQ3K7Re07FSX/tv/SWPOvddweaMwtH0YzRg6tZKJ/pwW89IlhiA1Q+x5aPCyUA/F/z7INH
 eesYpdV9VfAL0jDFkq1ZyrYcAdfyJxsAuYvVMxgIE9aN8KCcGtTiJA9wXQ0Tiszj9sbz85v4M
 S/NhVVquYHFB8fva8zb3rxn4kkbaR4qk5yY8Rgr7HVXoVR2pE/3/oh5n39AP7qv+tYrnwe2vU
 p4Udj8UuSQSBwqSCp9LO5iIrFHHyfisThooAV2yXidjSxrA/F98MLve47o4Rrex8Yj6tGnnFg
 lBCB3W+mU7VIwueJ9hv5YzA48uA/LCdnpXhP2ltDq+NY/XykHpwPMpmUIxEMdolZBF7SXKX9z
 QVPepXvEEcJphCNtFwYtyV4nWF/9nLbT6qEvomsitaayVususVdvAJuIMyRq2ErJ0xL+chDus
 JUA4aWgA3bgpcJXWuZKllZLqgKnQVeWPiBUwFO9mFcingtNrzeeQZ7yC6yJ1rpmhL5kM6bjdU
 q/vToAg8a+1/wG+ASeHFJi34tSU01trsTLJH72HnCiT7VQd5Zp0RSTj3AXDO6nLMnCfZPuQ00
 lttcpD0Y6v69fs23EKJbCYm1vJz87Y+V2HBcP6+0CHjJJVx5pOWNiyiNuSmyt4liP/v8wgImE
 T9c9w6hLyH0zs+DGovPXe/f4beVvBzapgK0fgni5VJC09gAwIrbI89On/zvQoRislj/1laqwm
 +ALQcol5Zrgoa3rpk1sgd7jW0JcoYaIa8FfryLkTKvVzqlWta5ovCHruBDy6JPZq9/EPWAoZe
 58SWVoEzeS4KtjZcw/kaR7qEpR5u5K8+n1JOO91zX5guLS0Y7a5hQyaekZ6V4A1t9rAlUtbtT
 JMCrxtM6hiwEJU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Feb 2022, Elijah Newren wrote:

> On Sun, Feb 20, 2022 at 11:41 AM Derrick Stolee
> <derrickstolee@github.com> wrote:
>
> > The only concern here really is if we want to be picky about the "VFS
> > for Git" references instead of "vfsd" references in the commit
> > message.
>
> I'm not sure I'm understanding the distinction.  Was "VFS for Git"
> renamed to "vfsd"?  Is "vfsd" Google's modified version?  Something
> else?

VFS for Git is the existing project at
https://github.com/microsoft/VFSforGit which is pretty much in maintenance
mode.

vfsd was mentioned by Jonathan Tan in
https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google.=
com/.
=46rom what I gather, it is a completely separate implementation of the sa=
me
ideas of VFS for Git, but from what I see it does not share any code with
it (and it is unclear how much vfsd tries/tried to learn from VFS for Git,
it looks like it's being done from scratch but that impression could be
incorrect).

> Also, vfsd doesn't seem to be Google-able whereas "VFS for Git" is, and
> since it's not an internal git project, it might be nice to use a name
> that users can find.
>
> But anyway, I have no idea what the "correct" text here is (as
> probably evidenced by my questions), so if anyone wants to provide
> suggestions or corrections to the commit message, I'm happy to take
> them.

How about this?

	Typically with sparse checkouts, we expect files outside the
	sparsity patterns to be marked as SKIP_WORKTREE and be missing
	from the working tree.

	There is currently an effort code-named `vfsd` (see
	https://lore.kernel.org/git/20220207190320.2960362-1-jonathantanmy@google=
.com/
	for details) to implement a Git-aware virtual file system layer
	(similar in spirit to the VFS for Git project) that can be used to
	turn this expectation on its head: all files are considered
	present in the working copy, though they are not vivified until
	actually accessed.

	With such a virtual file system (VFS) layer, most of the files do
	not match the sparsity patterns at first, and the VFS layer
	automatically updates the sparsity patterns to add more files whenever
	files are written.

	Side note: VFS for Git itself requires the Microsoft fork of Git
	to work, therefore this patch would only be needed in that fork,
	as far as VFS for Git is concerned.

Ciao,
Dscho
