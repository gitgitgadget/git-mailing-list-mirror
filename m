Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF860C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 08:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A419061364
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 08:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhFIINN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbhFIINI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 04:13:08 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFE6C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 01:11:14 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t140so19096609oih.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 01:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fLn+3TdovrAQMH05w5atFScB0HPjONmRAwZwN234tuE=;
        b=P2pDkf5Wdj8pXxyc+z770mGE7BxvrlWlmTh4wbvHPUwXZHO6n0v5CKxRW8MSMkxb2O
         SvIXTFm21joYcQMDqIvRq5Sq9A9UFBz7mCVaXiToqG1wnXjbq3J61HEhyfpKX7cPTlE9
         Qo14tjL4DQHBbQb8P4sg1aFXers12n+MP1SnHcDBpnlmqSLVzWSwA8NkarZOaSCV7lip
         cp2DmjVXPFKZivhC7wbropVkfrHCs8nb2fk4q/4jzl+cg3mjAUbzKVp9B8PlWJbAXxsG
         Y9/61imuSWS0YuCNWGm+1pTw6uc2NB12lfjj+f7bki6qAvV8823sS90nufubfqGWhDTH
         OUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fLn+3TdovrAQMH05w5atFScB0HPjONmRAwZwN234tuE=;
        b=VJd4ejBg5nA2rgl0WZmCR4ayfjNa68w1CG6aN3C7kZ0nJrM82t4nRumn5zcFgh01AR
         8ULSsvaukd4aVI8R/0zY4KmbzEumfT147XtCr5IaDGP3zfP+O2czNBDJoQLANIVvdeqM
         gOWscdX7/Fa4GdJt5AjW6ENG+TL+SwvaY82Ms7hClL0pU8YPxr+yUgY/dpzpq+O94k8I
         lehvADjvoHDGFC6nC8CkkVk3heVBbdAQwSdKs4bGyMsS+gKNj2Qrcnr42ZUQx3tbDXhl
         sK/hm0fotp2mnjr/92JTB/8Lhm//XMTAvYRhXGvSWP/NUSuNdl6LW1pPL6Il78eeDWmU
         JKqA==
X-Gm-Message-State: AOAM5312eioezI85uF4AHNmrz7rS4/3sYjIydBzXKYSW0TQXEwwTVNhD
        L4XivU9J1e5dtc4QVdvDvUTOF+vUOGG2tdQdu/w=
X-Google-Smtp-Source: ABdhPJyc/65mC1ajeDK23U3wSqouHpsk/Vtxejav2NHzaHx79Q3Eyv/rkcSXzrYXWN1Uothig/aKWVJWPo1v6hnT+go=
X-Received: by 2002:aca:f482:: with SMTP id s124mr5526625oih.167.1623226273876;
 Wed, 09 Jun 2021 01:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com> <xmqqfsxrk0oc.fsf@gitster.g>
In-Reply-To: <xmqqfsxrk0oc.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Jun 2021 01:11:02 -0700
Message-ID: <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 8, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> While comparing an index to a tree, we may see a sparse directory entry.
> >> In this case, we should compare that portion of the tree to the tree
> >> represented by that entry. This could include a new tree which needs to
> >> be expanded to a full list of added files. It could also include an
> >> existing tree, in which case all of the changes inside are important to
> >> describe, including the modifications, additions, and deletions. Note
> >> that the case where the tree has a path and the index does not remains
> >> identical to before: the lack of a cache entry is the same with a sparse
> >> index.
> >>
> >> In the case where a tree is modified, we need to expand the tree
> >> recursively, and start comparing each contained entry as either an
> >> addition, deletion, or modification. This causes an interesting
> >> recursion that did not exist before.
> >
> > So, I haven't read through this in detail yet...but there's a big
> > question I'm curious about:
> >
> > Git already has code for comparing an index to a tree, a tree to a
> > tree, or a tree to the working directory, right?  So, when comparing a
> > sparse-index to a tree...can't we re-use the compare a tree to a tree
> > code when we hit a sparse directory?
>
> Offhand I do not think of a reason why that cannot work.
>
> The tree-diff machinery takes two trees, walks them in parallel and
> repeatedly calls either diff_addremove() or diff_change(), which
> appends diff_filepair() to the diff_queue[] structure.  If you see
> an unexpanded tree on the index side, you should be able to pass
> that tree with the subtree you are comparing against to the tree-diff
> machinery to come up with a series of filepairs, and then tweak the
> pathnames of these filepairs (as such a two-tree comparison would be
> comparing two trees representing a single subdirectory of two different
> vintages) before adding them to the diff_queue[] you are collecting
> the index-vs-tree diff, for example.

Good to know it seems my idea might be reasonable.

> But if a part of the index is represented as a tree because it is
> outside the cone of interest, should we even be showing the
> difference in that part of the tree?  If t/ directory is outside the
> cone of interest, should "git diff HEAD~100 HEAD t/" show anything
> to begin with (the same question for "git diff --cached HEAD t/")?

Excellent question...and not just for diff, but log, grep with
revisions, and other commands.  We discussed this a while back[1] and
we seemed to lean towards eventually adding a flag because there are
usecases both for (1) viewing full history while having sparsity paths
restrict just the working copy, and (2) also restricting the view of
history to the sparsity paths.

[1] It's been discussed a few times, but there's a relatively
comprehensive discussion at the "Commands that would change for
behavior A" section from
https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
