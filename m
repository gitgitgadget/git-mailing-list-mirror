Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3B4C12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E24DB613C8
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 19:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhGNTf5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 15:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhGNTf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 15:35:56 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F82C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:33:03 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id o3-20020a4a84c30000b0290251d599f19bso911252oog.8
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/QZetDQ6pBvz4T8LEC87XVpEGzAhiqEvbxp7m2ZK2U=;
        b=Q+pZHQb4PHNs9qButWoxBOGOM2QiLpNi7bLe4JYv775ER0JmJAfWJk0MP1lOa9y5tM
         c+5Sul6kpyAdfB7oVAmmzcuDnDTGCmkrJvQW+7bnKrffDmBPqM0cmAJt/WSuBIhQsKa1
         h7tYrvJHNeJwG1tq5CQOaA4DIk7pA4EGawB6M8aiyKJHlrjYKfVx65fREz7mT8H2mso5
         2M9L5hLXmsMSaxZ4ntgK+zKWWuSi4N4go2fyaByScLgjDT017Ww3YM/Pd5xrvhkxpOve
         +gao1WEmJ3xZjKJePIc9sHK6fSkktXK97WgN4NdTDrSzVXeDzKoFHEbBGxm3stonObIN
         +4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/QZetDQ6pBvz4T8LEC87XVpEGzAhiqEvbxp7m2ZK2U=;
        b=unwXr01BcsyJu8nK9y+Cu0uf7G0Sy5c8SnJXNnrjHED3Pb0Ftsc4d/lKdHuduqAFGQ
         wNqeWDVfumwe7fBOuaakhZ2tkDmnRXjldsxGFE8tAF33fNmvY4EYWJ/u3ChGjzuEPhs1
         s0d9CPRbHUO9VMb2jfV6Ayha9LC4m8eg3iG5MnzBmnsYNYFIUVnByJDh8mG+EU2HzBBe
         xClVrM4Eo7yvSKZl8r01Giy2id0+oufj3QRY96lKarL+ML4qeI6/ez+EyjMsqqiyltHu
         XZEzoS5jFV47rnrqtPO0NC9eqfj5/FxO9C0BGPSNzKCdjDeeDbXS2kJgUTG7kwSn6Fyq
         83aQ==
X-Gm-Message-State: AOAM5323sX+O/CFeH64O+GO2SqMlBjspSPtIlGthGzZuiGN3Ts6gnCUJ
        LRY8sYsnMnHTIqSp1qcdMbrM1DobkBQnpA3ORYYdh6xx9LYyCg==
X-Google-Smtp-Source: ABdhPJyEC6EjJoIjDx9NRp/QYMesMeEPlcHqyVcWW+bg5TDS4CvjofzKKUwFO4oesKxDpeo+Tl1vSSKyt+rp6aGHMMk=
X-Received: by 2002:a4a:1b82:: with SMTP id 124mr9238369oop.32.1626291183216;
 Wed, 14 Jul 2021 12:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1044.git.git.1625964399.gitgitgadget@gmail.com>
 <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com> <6f5767607cd2ed9d7d9f45e6dc60b07b29d70236.1626225154.git.gitgitgadget@gmail.com>
 <YO8Ut9b+6D/wR6uf@coredump.intra.peff.net> <CABPp-BFu4-SJrGbeSQTum_JOq4PHAGwGPPLQA+sHZMP4wvqA1w@mail.gmail.com>
 <YO8f/A8qnTEDlnAr@coredump.intra.peff.net>
In-Reply-To: <YO8f/A8qnTEDlnAr@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 14 Jul 2021 12:32:52 -0700
Message-ID: <CABPp-BGtdUcz1M2BZCNmX9XG=pxr2tdywgCR=X3Lgt6-o7aMiQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] doc: document the special handling of -l0
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 10:33 AM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jul 14, 2021 at 10:17:21AM -0700, Elijah Newren wrote:
>
> > > > +Note that for backward compatibility reasons, a value of 0 is treated
> > > > +the same as if a large value was passed (currently, 32767).
> > >
> > > Given the confusion around what "32767" even means to users, I wonder if
> > > we could just say: a value of 0 removes any artificial limits (but Git
> > > still has some internal limits which real-world cases are not likely to
> > > hit).
> >
> > 32767 is not an internal limit; and as such, it is absolutely an
> > artificial limit.  I had to use 48941 just a few years ago, and that
> > value (and others larger than 32767) are fully supported.
>
> OK, I thought there was still some 32-bit m*n limits, but I guess not.

There was once upon a time, but not since 9f7e4bfa3b6d (diff: remove
silent clamp of renameLimit, 2017-11-13).

> > > Removing limits is after all the point of "0". I'm also not sure if it
> > > is simply for backwards compatibility. We commonly let "0" or "-1" mean
> > > "no limit" for convenience. It seems like something we'd want to
> > > support.
> >
> > Making 0 mean unlimited could be done, and I think it'd be a one-line
> > change, but that's not what commit 89973554b52c (diffcore-rename: make
> > diff-tree -l0 mean -l<large>, 2017-11-29) tried to do.
> >
> > I'm not opposed to such a change in the meaning of "0", but I am
> > opposed to documenting this value as unlimited unless we make it so.
>
> Thanks for clarifying. It does seem silly that "0" means "big, but kind
> of arbitrary". But I'm OK to punt on that change for now (and in the
> meantime, I have no real opinion on whether or how to document the
> current behavior).
>
> -Peff
