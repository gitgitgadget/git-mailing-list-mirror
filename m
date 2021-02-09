Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2AEC433E0
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D582564EB6
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 17:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhBIRqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 12:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhBIRnK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 12:43:10 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15CC061574
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 09:42:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id u66so18366537oig.9
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 09:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NkD0ABj/PhkApahZ4Y8+SLvMjfXzVEgMmL6RE0Qvuik=;
        b=JTPJGu9bLZaWPG+ZmRpflCgWRaicQb/m2yGGisqAaOnpNJ17U79n3PTTVPx3/lzabd
         cSMM4FHDFJ/pA5KVT5TpKLXDWM5SowR1qe626YZaBRIDoXrRndXQBwBiC7/XBOAA2dRD
         Ra265IiRmRlt689yPNwmC2hN0+C4K//iacuxg5Q5MScNPcmBR5fzr5K6mo0jwJCNFvhN
         TqTZOb5z2iE85Vhby2S3Eev7lq85d+jl3BxEKmolRPIP97N3bPhM40HSHUSIiz4XUIT7
         Vq1wRxpPTjNzAtkfJFwixuaYUEbcbBlzr/C3t5X+c0lzs4cw4sUZezODTjHgUCr41F52
         9KJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NkD0ABj/PhkApahZ4Y8+SLvMjfXzVEgMmL6RE0Qvuik=;
        b=H1bXYnObiiFFUvfBx4lN2j3nbI14lx1PRhc1M50/f76NpQf1FJNxoBw538D2WvqmBD
         8zjIUnPQmYI60GXTfiTQ8WKA8Epp3KC+8citJzgDFcu2tFKuJ17gtYbl5MfpNFWbwCUG
         562Q6tZyaDT23tv69hHRJUFUp2r+I0jzby1r2Q04bpd96fkdPcuzBLMIe8ZRW4vYMC7s
         4TWCs9W9jgJziB+z+POLbfuMU2N6ZP8NG8yDH4CGJj5QbEnZbxC17YucLfLGP7OsOpj9
         4y7hslrvJtCXBmOS4MhnoPnoy3G5Ihsz5C2oYC1vm+t/og5TRYIyn9NE5QB4hadfxrdm
         YbSQ==
X-Gm-Message-State: AOAM533Zf8SM6mYGP4SUQYVLvGGCE+JR/1mpwNu3Ut3BZlOoJS6X3kUg
        O7szYXC6SbySFTwB+kER48v/vrQO9Eu6PNtt3N4=
X-Google-Smtp-Source: ABdhPJxYIN849155iAcaJO8Bjq6hPhK1KUhauO1kTXXqz3fDeg3cEEwxkmrj1ANtm6Ts+wv5lg7v8QMhurnsc0M1hsc=
X-Received: by 2002:aca:5a04:: with SMTP id o4mr3167189oib.167.1612892549907;
 Tue, 09 Feb 2021 09:42:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.git.1612651937.gitgitgadget@gmail.com>
 <pull.843.v2.git.1612870326.gitgitgadget@gmail.com> <381a45d239bb52a70373c385d8978005c9cb4800.1612870326.git.gitgitgadget@gmail.com>
 <dfbffe97-51de-9e8b-37a4-417909358323@gmail.com> <CABPp-BEsuOiUyvbkwPC384eho8pgSWuRdcvw9t5gkXhf+_j-3A@mail.gmail.com>
 <9d8ee4be-33d7-6c50-f14b-0b92a4ebe949@gmail.com>
In-Reply-To: <9d8ee4be-33d7-6c50-f14b-0b92a4ebe949@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 9 Feb 2021 09:42:18 -0800
Message-ID: <CABPp-BEfCLRAgCy3x3Dm_RM=U2q9sNWX7YO4OVLrqvsvzhPxfw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] diffcore-rename: compute basenames of all source
 and dest candidates
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 9, 2021 at 9:02 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/9/2021 11:56 AM, Elijah Newren wrote:
> >> Also, this is used here and below. Perhaps it's worth pulling out as a
> >> helper? I see similar code being duplicated in these existing spots:
> >>
> >> * diff-no-index.c:append_basename()
> >> * help.c:append_similar_ref()
> >> * packfile.c:pack_basename()
> >> * replace-object.c:register_replace_ref()
> >> * setup.c:read_gitfile_gently()
> >> * builtin/rebase.c:cmd_rebase()
> >> * builtin/stash.c:do_create_stash()
> >> * builtin/worktree.c:add_worktree()
> >> * contrib/credential/gnome-keyring/git-credential-gnome-keyring.c:usage()
> >> * contrib/credential/libsecret/git-credential-libsecret.c:usage()
> >> * trace2/tr2_dst.c:tr2_dst_try_auto_path()
> > Honestly asking: would anyone ever search for such a two-line helper
> > function?  I wouldn't have even thought to look, since it seems so
> > simple.
> >
> > However, my real concern here is that this type of change would risk
> > introducing conflicts with unrelated series.  This series is the
> > second in what will be a 9-series deep dependency chain of
> > optimizations[1], and the later series are going to be longer than
> > these first two were (the latter ones are 6-11 patches each).  We've
> > already discussed previously whether we possibly want to hold the
> > first couple optimization series out of the upcoming git-2.31 release
> > in order to keep the optimizations all together, but that might
> > increase the risk of conflicts with unrelated patches if we try a
> > bigger tree refactor like this.  (Junio never commented on that,
> > though.)  It might be better to keep the series touching only
> > merge-ort.c & diffcore-rename.c, and then do cleanups like the one you
> > suggest here after the whole series.
> >
> > That said, it's not a difficult initial change, so I'm mostly
> > expressing this concern out of making things harder for Junio.  It'd
> > be best to get his opinion -- Junio, your thoughts?
> >
> > [1] https://github.com/gitgitgadget/git/pulls?q=is%3Apr+author%3Anewren+Optimization+batch
>
> I don't consider the step of "go put the helper in all these other
> places" necessary for the current series. However, the "get basename"
> code appears a total of three times in this series, so it would be
> good to at least extract it to a static inline method to reduce
> the duplication isolated to this change.

Sounds good; will do.
