Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ED3C32771
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 02:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E472073A
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 02:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQcQOeAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgAJCfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jan 2020 21:35:39 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41477 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgAJCfj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jan 2020 21:35:39 -0500
Received: by mail-ot1-f42.google.com with SMTP id r27so529457otc.8
        for <git@vger.kernel.org>; Thu, 09 Jan 2020 18:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76xxiNt7qD35BhmRyt/RzCamaHXOszCq7LyHGw1ctOs=;
        b=qQcQOeAZ/giyr9Vojb5LDOQsXa5ppOhZIYPJwNWdwJwAe8Xvdd/HiwmMAjuiAQm0xM
         lhBasmsswB+RhaHypvlCGR+0f2rL23463tGucVrv+1MdNETUMbm40rZYVtshUD42fvqZ
         wQlz6vUbC7C01zz3jm7WTES483ms4s6B8FqngxcykV4WBwyprI5NEKVTtLAe20iBQ4mH
         +dOnNbCPhXKHQ80VriEArW8sNfeEqNLgg93firTeLjNvutfVPHWJHBn8NqAUJ4GXUXpg
         VxaztyksdkTKZeZG62H6qYS+2edZKWuHvFJ3xoSAv7wAJfToOBLiQPqhaPbsWuearhjL
         +0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76xxiNt7qD35BhmRyt/RzCamaHXOszCq7LyHGw1ctOs=;
        b=JAxFYfBBMnxTyNK4PswvgN6k5BuTSfgAXGlRp22Ep+PiVjGW9xQbr68SxY61WSWFFf
         tJP0RviktwkAufYhuwCgGnhlqBzXZ35wv1QLH37GzqaIy1MdDKzh3KCQ4K7niEi6Zqru
         5s+Os91lmccPXDOFWd/YTjCp/sJhJX4jApGPEYMPh2PXfBIchsJoZ8OHmcZbRch8kKHq
         BFvEiLpBeQDOnCHPlJ7x6o4mnRMX3CkdiQhe122Igj07wkWEmAmTVgOLNyAFLvR7DdUY
         DhlyvnyTCWe6Zp/zAswBxOXS7k0C+i8uF6C7Ag9ErSZDcn2S2x3grSnBQMY8HkPMYioy
         4BkA==
X-Gm-Message-State: APjAAAUbsTprZHh6U1+ficeV3uaVgD3VmCA5pbYsaTEGyAj2QLXUgW5m
        OOD2AZKosfubedUDs6fEXuHoVedtPjT8X8HSwvI=
X-Google-Smtp-Source: APXvYqxtyCHUpO98xAtW+bwn/pE//vwx2AGD2UaDle9nvhd0xC91PxgQtaxIpxs/5AgVB3ADYnQpKBisGejf1wC3Qaw=
X-Received: by 2002:a05:6830:158:: with SMTP id j24mr781409otp.316.1578623738566;
 Thu, 09 Jan 2020 18:35:38 -0800 (PST)
MIME-Version: 1.0
References: <20200108214349.GA17624@lxhi-065.adit-jv.com> <CABPp-BHsyMOz+hi7EYoAnAWfzms7FRfwqCoarnu8H+vyDoN6SQ@mail.gmail.com>
 <20200109105307.GA1349@lxhi-065.adit-jv.com> <CABPp-BFiDNb18m8geTCxKLXg0fOd0DS1dWRVWCfnTG0suwGRHg@mail.gmail.com>
 <20200110000603.GA19040@erosca>
In-Reply-To: <20200110000603.GA19040@erosca>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Jan 2020 18:35:27 -0800
Message-ID: <CABPp-BHvJHpSJT7sdFwfNcPn_sOXwJi3=o14qjZS3M8Rzcxe2A@mail.gmail.com>
Subject: Re: Unreliable 'git rebase --onto'
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eugeniu,

On Thu, Jan 9, 2020 at 4:06 PM Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
>
> Hi Elijah,
>
> On Thu, Jan 09, 2020 at 10:05:52AM -0800, Elijah Newren wrote:
> > On Thu, Jan 9, 2020 at 2:53 AM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > > Some years ago I was hit by 'git merge' producing slightly different
> > > results compared to 'git rebase --onto' and 'git cherry-pick A..B'
> > > (maybe I can come up with a reproduction scenario for that too).
> >
> > If you can, I'd be interested to see it and take a look.  I'd normally
> > assume it was just some case where A..B included "evil" merge commits
> > (merge commits that made additional changes not part of the actual
> > merging) since rebasing or cherry-picking such a range would exclude
> > the merge commits and thus drop those changes -- but you identified a
> > real bug with the default rebase backend so I'm interested to see if
> > you happen to have more bugs I should know about.
>
> Here is a _simplified_ scenario to get a totally unexpected result from
> 'git merge' (initially reproduced years ago, but still happening on
> 2.25.0.rc2):
>
>    ## Preparation
> 0. git --version
>    git version 2.25.0.rc2
> 1. git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 2. git remote add linux-stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> 3. git fetch linux-stable
>
>    # Reproduction
> 4. git checkout f7a8e38f07a1
> 5. git merge --no-edit e18da11fc0f959
>    ## Merge v4.4.3 commit
>    https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=e18da11fc0f959
>    which is a linux-stable backport of vanilla v4.5-rc1 commit
>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7a8e38f07a1
>    the latter being checked out at step 4.
>
> 6. git show HEAD
>    ## Inspect the _automatic_ conflict resolution performed by git in
>    drivers/mtd/nand/nand_base.c. Git decided to integrate e18da11fc0f959
>    alongside f7a8e38f07a1, while essentially they are the same commit.
>    We end up with two times commit f7a8e38f07a1.
>
> What do you think about that?

Ooh, interesting case; thanks for sending it along.  I think this is
the same as https://lore.kernel.org/git/20190816184051.GB13894@sigill.intra.peff.net/
, which struck git itself not that long back.  It didn't do any actual
harm, though, it was just surprising.  I'm not familiar with the xdiff
part of the codebase, so I don't know if this is a heuristic thing, or
something more along the lines of the diff3 issues mentioned at
https://www.cis.upenn.edu/~bcpierce/papers/diff3-short.pdf.  I read up
on this area a little bit a few months ago and I'd like to dig more at
the diff3 stuff in general, but it may be a little while.  If you see
more issues like this, though, I'm definitely interested in saving and
cataloging them for when I get back to this.

Elijah
