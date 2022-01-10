Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1848C433F5
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 15:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbiAJPwp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 10:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiAJPwp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 10:52:45 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABC2C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 07:52:44 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i5so1717626edf.9
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 07:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J1fOSTUvetp7zYG6KfpHUDCe6mVaiAoq8PrioScuJXE=;
        b=NkNSmFW7ZPSWG0FVe4dJQJFfKv/NRZ8NutXBmoWZDa9h4CtL5vA5cCJcpHMZkQKljL
         PnFWEZDYmhW34EwVJ7FD8X1fgbHQcdT8gCd2gWnadiJqpjt5tUVCtfzMo4w2s6fgEPDT
         Os8sfKwrp0fAW1Z4/F8RlFVqa7wFgLDiOEkSpzjMhKY1MCUk1iWzlcrEQK9FK+swSbq6
         ryiF3Gz/IBGz+dNitXtTA1aCwaJgjJC0ys31HYg5pgfptoaWs4FsfYKstLvu3bsAgbIc
         Nbiy6lGjJDcZDAV4xCAVR7zQ4m7nIGwoOi7guxuxfpdjDJ2AMm3Cb7hcc/z/9C8mn3j8
         vVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J1fOSTUvetp7zYG6KfpHUDCe6mVaiAoq8PrioScuJXE=;
        b=sqy6hOmnbGmqpPLzbCt0hlPTNAK77zVgU9Vx4bpnWVVs8xuB+UBpUvrJeBnfrHfxOr
         q5JQNsREBnqlHanPidjw2GZKZu2knx8glbHFg6mOl5DPa/4Z+jqiZMUcNPQZTYgSuPZf
         ZPGRuq1TS4wFxWSPS/pm5nnwsQNnHVQWx3QeWSSsi3VQf7+nwFSzvyov6v6Q8oDnI45O
         GEhIcIokaQ1GETYbGv20++R1CVUkz5frLEH0rgcjtKNmbo0yopkFTmk8qzUAWkb2hH1+
         lc33TdRzkTpZEzkLlfD+guU3NQaULZkl6C6XQSTSYNJI6vpHb4UO7uigwCqi4vezRxui
         0X5Q==
X-Gm-Message-State: AOAM533VLOrthcC9mzyGkDfQQooNTGjdGJYq+OSBlD3c4Ln9LpAENbMm
        6PRp28CmKEN7f6qEipqH50gh+rSTxKDtX2a6rOE=
X-Google-Smtp-Source: ABdhPJz+dNfhJIGlCIwIW8zIPkNwQjOyMGkImcdAhcX4kMFv/nDc4M1f86gZcTMnH2yBMoBwi31qEQEXQTqJ0Oirukc=
X-Received: by 2002:a05:6402:34ca:: with SMTP id w10mr243439edc.359.1641829963117;
 Mon, 10 Jan 2022 07:52:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.1109.git.1641317820.gitgitgadget@gmail.com>
 <c5b98e36516b8f832576816c202be7581f261909.1641317820.git.gitgitgadget@gmail.com>
 <CABPp-BGmaKsvrO1Qxwuj+WgcvuE_NA4agY_HLQ8=csvddRafqw@mail.gmail.com> <556f6266-a79f-1d5c-6bd7-79d65223b403@github.com>
In-Reply-To: <556f6266-a79f-1d5c-6bd7-79d65223b403@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Jan 2022 07:52:31 -0800
Message-ID: <CABPp-BHi0N31TQY8Bt8dq6aWGNdOSFQuQPQ7TtqObZx+iwS_mQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] update-index: integrate with sparse index
To:     Victoria Dye <vdye@github.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 6:10 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Tue, Jan 4, 2022 at 9:37 AM Victoria Dye via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >>
> >> From: Victoria Dye <vdye@github.com>
> >>
> >> Enable usage of the sparse index with `update-index`. Most variations of
> >> `update-index` work without explicitly expanding the index or making any
> >> other updates in or outside of `update-index.c`.
> >>
> >> The one usage requiring additional changes is `--cacheinfo`; if a file
> >> inside a sparse directory was specified, the index would not be expanded
> >> until after the cache tree is invalidated, leading to a mismatch between the
> >> index and cache tree. This scenario is handled by rearranging
> >> `add_index_entry_with_check`, allowing `index_name_stage_pos` to expand the
> >> index *before* attempting to invalidate the relevant cache tree path,
> >> avoiding cache tree/index corruption.
> >>
> >> Signed-off-by: Victoria Dye <vdye@github.com>
> >> ---
> >>  builtin/update-index.c                   |  3 +++
> >>  read-cache.c                             | 10 +++++++---
> >>  t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++++
> >>  3 files changed, 22 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/builtin/update-index.c b/builtin/update-index.c
> >> index 187203e8bb5..605cc693bbd 100644
> >> --- a/builtin/update-index.c
> >> +++ b/builtin/update-index.c
> >> @@ -1077,6 +1077,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
> >>
> >>         git_config(git_default_config, NULL);
> >>
> >> +       prepare_repo_settings(r);
> >> +       the_repository->settings.command_requires_full_index = 0;
> >> +
> >>         /* we will diagnose later if it turns out that we need to update it */
> >>         newfd = hold_locked_index(&lock_file, 0);
> >>         if (newfd < 0)
> >> diff --git a/read-cache.c b/read-cache.c
> >> index cbe73f14e5e..b4600e954b6 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1339,9 +1339,6 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
> >>         int skip_df_check = option & ADD_CACHE_SKIP_DFCHECK;
> >>         int new_only = option & ADD_CACHE_NEW_ONLY;
> >>
> >> -       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> >> -               cache_tree_invalidate_path(istate, ce->name);
> >> -
> >>         /*
> >>          * If this entry's path sorts after the last entry in the index,
> >>          * we can avoid searching for it.
> >> @@ -1352,6 +1349,13 @@ static int add_index_entry_with_check(struct index_state *istate, struct cache_e
> >>         else
> >>                 pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce), EXPAND_SPARSE);
> >>
> >> +       /*
> >> +        * Cache tree path should be invalidated only after index_name_stage_pos,
> >> +        * in case it expands a sparse index.
> >> +        */
> >> +       if (!(option & ADD_CACHE_KEEP_CACHE_TREE))
> >> +               cache_tree_invalidate_path(istate, ce->name);
> >> +
> >>         /* existing match? Just replace it. */
> >>         if (pos >= 0) {
> >>                 if (!new_only)
> >> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> >> index 6804ab23a27..bc0741c970d 100755
> >> --- a/t/t1092-sparse-checkout-compatibility.sh
> >> +++ b/t/t1092-sparse-checkout-compatibility.sh
> >> @@ -1216,6 +1216,18 @@ test_expect_success 'sparse index is not expanded: blame' '
> >>         done
> >>  '
> >>
> >> +test_expect_success 'sparse index is not expanded: update-index' '
> >> +       init_repos &&
> >> +
> >> +       echo "test" >sparse-index/README.md &&
> >> +       echo "test2" >sparse-index/a &&
> >> +       rm -f sparse-index/deep/a &&
> >> +
> >> +       ensure_not_expanded update-index --add README.md &&
> >> +       ensure_not_expanded update-index a &&
> >> +       ensure_not_expanded update-index --remove deep/a
> >> +'
> >
> > The commit message said this change was about --cacheinfo, but this
> > test doesn't use that option.  I'm confused; was this a bad patch
> > splitting by chance?
> >
>
> It was not - the commit message title is "update-index: integrate with
> sparse index" and the message starts by saying that this patch enables use
> of the sparse index for *all* of `update-index` (where "[m]ost variations of
> `update-index` work without...making any other updates in or outside of
> `update-index.c`").
>
> It goes on to say that the `--cache-info` option is an exception to the
> above statement (that most variations work without updates outside
> `update-index.c`) because it requires a slight change to
> `add_index_entry_with_check(...)` to avoid index corruption. That change is
> also in this patch, but it's not the main "focus".
>
> The test added here is intended to broadly test `update-index` with a sparse
> index. I'll add a case for `--cacheinfo` in my next re-roll but, for
> context, the reason I didn't originally is because I focused on the (as far
> as I could tell) most commonly-used variations of `update-index`.

Ah, I see.  I didn't read closely enough and then saw the majority of
the commit message and code changes were about --cacheinfo, but the
testcase wasn't.  Sorry about that.

> >> +
> >>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> >>  # in this scenario, but it shouldn't.
> >>  test_expect_success 'reset mixed and checkout orphan' '
> >> --
> >> gitgitgadget
> >>
