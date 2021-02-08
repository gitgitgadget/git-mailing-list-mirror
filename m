Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41397C433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0335C64E56
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 22:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhBHWhn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 17:37:43 -0500
Received: from mout.gmx.net ([212.227.17.21]:59659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBHWhm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 17:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612823759;
        bh=SRkoM82OmXdqKrgQe1OeSoEg1S6Xllv9vuIiIgaXVYQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=d+nA/x0YBx3wkVKdLrisVTk1DggCyvKx7idUAw10sQNoYDOq9pT6PXNCB4+zpnkEx
         2tV0xpd0Gi950eRSV/I1FJJt+wuFI1gQpmYCtoHl1BlgoRpOnftYqjMkyqWY26LfRV
         lPRLRhftY1LQAVTGnp4Lwe09xfO35B+T9EZ70yGE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([213.196.212.209]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYvY8-1lMSXn2F16-00UojG; Mon, 08
 Feb 2021 23:35:59 +0100
Date:   Mon, 8 Feb 2021 23:36:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
In-Reply-To: <YB0Z5JXbe22ko2Mj@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2102082329460.29765@tvgsbejvaqbjf.bet>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com> <xmqqtuqr4frw.fsf@gitster.c.googlers.com> <YBx5rmVsg1LJhSKN@nand.local> <xmqqtuqr2uz3.fsf@gitster.c.googlers.com> <YB0Z5JXbe22ko2Mj@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:scp87ngoSaoKLW1JKLnjs2KhtAXlNSciG/aUBrwDB425EnEeqqD
 XkXz5e9gYni8z+KxZVrNJkCKcI9I6yKwv6PBs319AbsWxMofw1g7UknHt/AFPK1iNKvsTj+
 UX73hRZUWTmCQiF4DfT8gcpeF0S7UWTGGcJ8YFfXZltYFeDuyaTf31kqlO+CYp/AA0PP5QJ
 T2FXa5gGK5rQapA3Stx+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3Lg2t/F3kdc=:DEWaA9gRPLRP7JydeU+Xyl
 hsTCyfYsYThqaIxDZieF9Q+mf2LsR8LxB235DeJz2wcLUzmsyz/rmxnpuhmNOz8veSSbjK8IO
 jVs7hjAI4yG1XwaIO5ZNVUym1r+XNyxSezeWUV7B+Ndh2YaW3bU+STAJDgJuzrfq4gNwUMKAy
 Z1vYMlhAip9HiFM77m1dyl1fVRcjf9MY7rJUJDmQUxF6KJ4bZGeSM8IZBSypdTY6gTQpKqNh7
 EolB0waMkLKTCu9aFki+ARVQ247MIgMIPLQ3GWeErpS7nHiH5USqipEscY0FVfzgw9owDTmgv
 vlPz6HrtyAEMSFXHI+QRvOM98sf4dSVzWVODZGntHbDWP4YnIt/oCRFh/6ayfxadudgIi8rNg
 kA2575vQj6QhJQdJnN/xqfqgU4R8ihAKWi7e7KlQ9mTT9duRWVwy++eNrHenuXN88V6Pyneif
 8dnpFgIHmf5Jgzv8cJs57yy9lTpPbuMQ653cf9OqIglDnM6AoLGkD2yHVpd9vJjYPmmmc82zd
 dtwdhzHpsoTAJY9r4uyohWJy5Ncz4YokaLxYqsTVmodDqHFY3XM3/9ot5WFDUhL3ekBmHUNs6
 gSMlUz2u5Ic3GtzKhY7Uj3jxGPywBTVXTBwinxcVKyVHjF5lgZ/pC1oUIUZMPU6u7sT17Scx8
 GhvkGoxbTjIlRmdfFoNwV95NeLL1uahB5vQFbruLTCftU+BDA2ovgtkAG5urI5yR+Cye2Lelm
 U2aT/qk8mI2o4snjfkRjFKBRX7jPFQLE+Q83YL46X6YlPf09JVlXRarhtRYkiUapJBuzJr/W2
 sjBNNB49HomjxoDM9rMJcCIfTP6Tyo7bi0upJ4+GHJsI2w2+rvkF8uKYw0/j1PHb6QR4dm1iS
 xYS3JqFuVS+v3o851QYrPh8a348/5ENgauK5tWKq8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 5 Feb 2021, Jeff King wrote:

> On Thu, Feb 04, 2021 at 04:56:16PM -0800, Junio C Hamano wrote:
>
> > > As an aside: I am curious if I'm missing something when you say the
> > > "only way" is to ask for a 'git range-diff ...@{u}'. IIUC what you'r=
e
> > > describing, I often resort to using 'git cherry' for that exact thin=
g.
> > > But, I may not be quite understanding your use-case (and why git-che=
rry
> > > doesn't do what you want already).
> > >
> > > My latter question is purely for satisfying my own curiosity; I don'=
t
> > > have any problem with a '--{left,right}-only' option in range-diff. =
From
> > > my quick read of the patches, it all looks pretty sane to me.
> >
> > The question is addressed to Dscho, and I am also somewhat curious.
> > Perhaps the reason would be that the output from cherry is not as
> > easy to read as range-diff, without any post-processing.
>
> I had the same curiosity; I'd use git-cherry (or rev-list --cherry) for
> this.
>
> I suspect the big difference is the quality of the matching. git-cherry
> is purely looking at patch-ids.

Indeed. Whenever I had tried `git cherry` in the past (which, admittedly,
has been with geometrically decreasing frequency given the results), it
completely failed to help me. And it's not only its reliance on perfect
matches of the diff _with context lines_, it is also that the commit
messages are completely ignored.

`git cherry`'s track record with me is so perfect that I want to put this
line into all my Bash profiles:

	eval "$(set | sed -n '/^__git_main /,/^}$/{s/--list-cmds=3Dlist-mainporce=
lain[^)]*/& | grep -v ^cherry\$/;p}')"

> So it is quite likely to say "this was not applied upstream" when what
> got applied differed slightly (e.g., fixups upstream, applied to a
> different base, etc). Whereas range-diff has some cost heuristics for
> deciding that two patches are basically the same thing.  So it would
> find more cases (and as a bonus, give you the diff to see what tweaks
> were made upstream).
>
> It does make me wonder if it would be useful for rev-list, etc to have
> an option to make "--cherry" use the more clever heuristics instead of
> just a patch-id. It would never show the same diff output as range-diff,
> but maybe more scripts would find the advanced heuristic useful.
>
> I know it would probably make rebase's "ignore if in upstream" feature
> less clunky when I rebase topics. But it would also make it more
> dangerous! E.g., right now I see any upstream tweaks as potential
> conflicts when I rebase, and I manually review them for sanity.

Yeah, I thought the same when I read the paragraphs before this one. It
might sound convenient, but there _are_ false positives in `git
range-diff`'s output, therefore I would recommend never using
`git range-diff --left-only` or `[...] --right-only` with `-s`. IOW
_always_ inspect the differences.

Ciao,
Dscho
