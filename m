Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A26C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 08:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbiCHIcG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 03:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiCHIcF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 03:32:05 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEFE3F892
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 00:31:09 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y12so3677573edc.13
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 00:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onDEVNOcpyvR7SJH1D4U50XPUoKxAPnYyUUShKHVmGQ=;
        b=ZHGv9rWRzQs6GKOr2IXDpo/NsstLnomRiMgTAzW1wC9yUZfZSymodvNbLLuf07p25j
         /66ekmJLLbEFSP68p2k11Skj26PrWRyN3y26PTBzL1FxGY9pXVr0pKxn/4fcJSfTWyVr
         saoueXh7A2sH3SsAxOFR8OpjnLw/ZzJTTYfwyhDQEma9armpjIhTckl5VR1H20nCqozO
         Vdksa3QMDHY390DrPka6ZpfwsVylGtg2RO2bSI5oqVvXIUEs3KJIp/O5XkVTAmTQKmcH
         j/29/gPxD1V7idwYg9VyJ7tmxBOGETexd3nE5zLrZ6Myqnvmq93f4gsXA9nHts0Ro6Dd
         LEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onDEVNOcpyvR7SJH1D4U50XPUoKxAPnYyUUShKHVmGQ=;
        b=2pfaDiSo9d3xayaglVrd/96vp6EUM3ioi37wpbMiXlo9NxQCIawYbncE/dQkSczChF
         ItW3tiYVGR5jyjEB1Ry62gbMMddUhxwXiPklCDKSHFJoNivbPCljvmJDQpCCUrA1MKU1
         8qYIXNWjIPWr84xjPZRc2set4KLuKeGDMk55IHrTFkcuevn8QWzU0PRU+uudxNGmdM/J
         S+NFE6QkXz2wIe91GAaZ7hsc0I/iS+G42wVIElyCL3HkDKuSklJ7nIDBwV3Zez+nDd5M
         iRnBr4zqFUwBlnfFfIzYXTE+QZxGk745Gt1OBkwrfYQtxG9GhaufGwAB3SnlYWeTfvl+
         i0GA==
X-Gm-Message-State: AOAM533VSHCS+khRvICCIgSTSzA8GhpCLZBUeEQ55uuFpapbJ+asjd2O
        rZjadCF5Zbtg3bvICET24lGD7YnkMkx4qz5fzv8SJO07wxM=
X-Google-Smtp-Source: ABdhPJzb3Wq0i7E3thp2uaSlX8hYH6SBP7BcsGUWFGhWOL+cpyjIPfQEQXGlfTRkPcIeQ3mmI2/hwQ3EzgLfBMQzyhU=
X-Received: by 2002:a50:da47:0:b0:410:a39a:c43b with SMTP id
 a7-20020a50da47000000b00410a39ac43bmr15114329edk.33.1646728267298; Tue, 08
 Mar 2022 00:31:07 -0800 (PST)
MIME-Version: 1.0
References: <xmqqmti9ssah.fsf@gitster.g> <CABPp-BGZ7OAYRR5YKRsxJSo-C=ho+qcNAkqwkim8CkhCfCeHsA@mail.gmail.com>
 <nycvar.QRO.7.76.6.2203071728410.11118@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2203071728410.11118@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Mar 2022 00:30:55 -0800
Message-ID: <CABPp-BFW7sAJSpbE2Ukm_0G1h3o2oY=AnyqErbUakAtwqqwYMA@mail.gmail.com>
Subject: Re: en/merge-tree (Was: Re: What's cooking in git.git (Feb 2022, #08;
 Mon, 28))
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 7, 2022 at 8:31 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Tue, 1 Mar 2022, Elijah Newren wrote:
>
> > On Tue, Mar 1, 2022 at 7:26 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > * en/merge-tree (2022-02-23) 13 commits
> > >  - git-merge-tree.txt: add a section on potentional usage mistakes
> > >  - merge-tree: add a --allow-unrelated-histories flag
> > >  - merge-tree: allow `ls-files -u` style info to be NUL terminated
> > >  - merge-tree: provide easy access to `ls-files -u` style info
> > >  - merge-tree: provide a list of which files have conflicts
> > >  - merge-ort: provide a merge_get_conflicted_files() helper function
> > >  - merge-tree: support including merge messages in output
> > >  - merge-ort: split out a separate display_update_messages() function
> > >  - merge-tree: implement real merges
> > >  - merge-tree: add option parsing and initial shell for real merge function
> > >  - merge-tree: move logic for existing merge into new function
> > >  - merge-tree: rename merge_trees() to trivial_merge_trees()
> > >  - Merge branch 'en/remerge-diff' into en/merge-trees
> > >
> > >  A new command is introduced that takes two commits and computes a
> > >  tree that would be contained in the resulting merge commit, if the
> > >  histories leading to these two commits were to be merged, and is
> > >  added as a new mode of "git merge-tree" subcommand.
> > >
> > >  Will merge to 'next'.
> > >  source: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
> >
> > As I mentioned on the last "What's cooking", let's not.  Please mark
> > it as expecting a reroll instead.  I'm waiting to hear back from Dscho
> > on whether my latest proposal at [1] would solve his usecase.  That
> > proposal suggests output format and various code changes.
> >
> > [1] https://lore.kernel.org/git/CABPp-BGnqXdFBNAyKRXgvCHv+aUZTMg-CgcQf95dKAR-e1zSjQ@mail.gmail.com/
>
> I am _so sorry_! I didn't expect you to wait for me (and even then, I
> cannot take time where there is no time to take, I am unfortunately quite
> short on time these days).
>
> From my side, this patch series is totally ready to be merged to `next`!
>
> In the interest of heeding the matra "the perfect is the enemy of the
> good", let's avoid adding more concerns that this patch series needs to
> address.
>
> Whatever machine-parseable info we want to provide can be made optional,
> and we can iterate on the design by marking that option as experimental.
>
> Thank you so much for your hard work!

Thanks, and while I usually am glad to see folks want to merge stuff
of mine down, this one suggests core changes to the existing output
sections rather than a new output section, and makes me wonder how to
handle the new info without -z[2].  Since this command is meant for
the plumbing-level, I'd like to avoid solidifying it too early -- at
least until we can handle the current usecases.  So even though
everyone else is saying to merge it down, I'd rather not quite yet.

[2] https://lore.kernel.org/git/CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com/
