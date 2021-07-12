Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7745C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1E8661006
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 19:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbhGLTfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbhGLTfY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 15:35:24 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE86C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:32:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id w194so2455686oie.5
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWYQgJj9VPwyt2tkvnVwwvwMoXHQtEYjcQ2jULboyko=;
        b=A384+f7A9ubf+I6ADQVf9LHkDhxtK1YfdFyGRmRXAqqe/rMpB0E9A+sKUnnFOOqmz9
         ZfnXy3jp3KShHbGJ3MLo4Q4qRB1jFYWt2tSNXvhHUPUKO5VImou1Yr1QsstfDtWGrAlf
         +qDQ9jcdp6hh/OMxTWgxsJDpLIPs2qOISZf1fUX/cE9Krcc6fOfn3CwIu2CNVGGOwAB0
         CI4tKus0Gz4L/EogPhSdpkDl+641fdI2bszBh1C/7TXjKmNtFA7uGUH0CboK08mExWl5
         VxsLChAqYCJMDj/LGL6k4zcgagY7tTLTFGBC/sOLM13E/xShXklo5eYbAKNrbtx6LD9u
         iCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWYQgJj9VPwyt2tkvnVwwvwMoXHQtEYjcQ2jULboyko=;
        b=Q2iMigY+zRUY1KGugRBZVZQPIhfyL7AAWCi9EIQPwdYlBfSuOlkBHVO7OM07aNdNGj
         cn0Ys5vxpqiu/OhixL0nngcX7fIDDk16LcTg57I2O8Mxu9w1DeyXfpGETAtIa0ykZE0P
         MjU4HyLuD3M4AN1/ilTVrwI8K6mk1pc5wkwRJStNNqBVXu3LN4cek66qEs09U5iTc6zP
         X3mEVqmnbtWmjoG7X3AElkW/Nur1WzZuf6sPlcx7eMCivFgDJ7CIJhxrZf97Y5xWnxi1
         W40aFpk627aOJIea1j5acvnnImYyiLlZBb3Vz1ckygXBx5gbDGdqd+FasS7EgZfWC2xr
         Ny2g==
X-Gm-Message-State: AOAM532xaz9sHyBoJ3W2fAwSJKzRM41yFM7reQQD4m5FEBH5qAMujCN3
        FMC8RTNq7rB2LFm0DwrY7X+s11dSLNZDCg12DAI=
X-Google-Smtp-Source: ABdhPJz16N3FqrGAXx1bM97OLE/+qRoki/IUQvvdW58xDmUjGZXPO2geZ6UHQ2L7fPTi7cv+FiIhIsG+509LgfUykA0=
X-Received: by 2002:aca:d644:: with SMTP id n65mr278751oig.31.1626118353869;
 Mon, 12 Jul 2021 12:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <717a3f49f97753149d5c435a83b3f1773dd4b1bb.1624932294.git.gitgitgadget@gmail.com>
 <CABPp-BE=qw9pO89hggUFbu=eovfL=7Os5BY8DZNd5Z=qU==wFg@mail.gmail.com> <3cf96b5f-3a8d-c00c-5d9e-c7095c058059@gmail.com>
In-Reply-To: <3cf96b5f-3a8d-c00c-5d9e-c7095c058059@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Jul 2021 12:32:22 -0700
Message-ID: <CABPp-BGJ+LTubgS=zvGJjk3kgyfW-7UFEa=qg-0mdyrY32j0pQ@mail.gmail.com>
Subject: Re: [PATCH v7 15/16] wt-status: expand added sparse directory entries
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 6:56 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 7/8/2021 9:03 PM, Elijah Newren wrote:
> > On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> ...
> >> +test_expect_success 'reset mixed and checkout orphan' '
> >> +       init_repos &&
> >> +
> >> +       test_all_match git checkout rename-out-to-in &&
> >> +
> >> +       # Sparse checkouts do not agree with full checkouts about
> >> +       # how to report a directory/file conflict during a reset.
> >> +       # This command would fail with test_all_match because the
> >> +       # full checkout reports "T folder1/0/1" while a sparse
> >> +       # checkout reports "D folder1/0/1". This matches because
> >> +       # the sparse checkouts skip "adding" the other side of
> >> +       # the conflict.
> >
> > The same issue I highlighted last time is still present.  If you
> > insert an "exit 1" right here, then run
> >     ./t1092-sparse-checkout-compatibility.sh --ver --imm -x
> > until it stops, then
> >     cd t/trash directory.t1092-sparse-checkout-compatibility/sparse-checkout
> >     git ls-files -t | grep folder  # Note the files that are sparse
> >     git reset --mixed HEAD~1
> >     git ls-files -t | grep folder  # Note the files that are sparse --
> > there are some that aren't that should be
> >     git sparse-checkout reapply
> >     git ls-files -t | grep folder  # Note the files that are sparse
> >
> > Granted, this is a bug with sparse-checkout without sparse-index, so
> > not something new to your series.  But since you are using comparisons
> > between regular sparse-checkouts and sparse-index to verify
> > correctness, this seems problematic to me.
>
> I'll add it to the pile, but I want to continue having this series
> focus on making the sparse-index work quickly without a change in
> behavior from a normal index. Changing the behavior of the sparse-
> checkout feature should be a separate series.

Hmm..perhaps there's some middle ground?  I appreciate that you want
to have this series focus on making the sparse-index work without
worrying about behavioral changes to sparse-checkout.  I'm concerned,
though, that testcases tend to be treated as documentation of intended
behavior, even when the tests are testing something else.  These tests
are clearly triggering buggy behavior, and I think your comments and
subsequent command may be affected by it.  I don't want to leave
future folks (even ourselves) to have to try to explain away why the
behavior expected in this test should not be expected.

Perhaps we can just add a comment that this testcase is triggering a
bug in both sparse-checkout and sparse-index but we're only checking
that the two match, and that once the bug is fix, the testcase itself
may need tweaking?
