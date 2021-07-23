Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C56C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863C560C51
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 17:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGWRFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbhGWRF3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:05:29 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694AC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:46:02 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id y18so2671670oiv.3
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8777WODhwHoFxmW6JFVwaDSVVb+Ml95jG3P0nXRL0A=;
        b=IMl8g7EvH1Hdc7y64ocKXV0a9OgVVFAd2bZkN83VKLwSPu13U66zV9Nh3oAgsNXC4y
         TPQ4xLCt+9hdDEdKq9xGocG7x7Z2MFiYCEi/Ps2IP0sqKSQh77RACYAyuQ36uerPP25H
         pWGmgbKgQEd3KDb7pI86iSR9T4SeTxTw7H/Iflccq5lMz1UtzaX8jtGub4vT23QSfLo/
         xySp1SqGxNaiDjSchAmoM5M9jMb28Xq8zuVNEqhRWLRc6sM5XxJcxvdJIhvns/y98BFh
         kjy83IWEdD84p2CNHdDzIge7ASDqRsrbxISstrsK3hIePrLiWMDIwX21neCSzpoYtEPN
         v4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8777WODhwHoFxmW6JFVwaDSVVb+Ml95jG3P0nXRL0A=;
        b=MmLIcpJOBWCWsMcXVxlc+jJdNlsn6ZxQh1tft6yYkfBl++o7Uo9cvAULB/Qui3IF0a
         Hg6nFfMP/GRa+kZFnpDoMHhR6vrE15Y3QXsxsJVWKwtSVGzydLOCgGFBKD8tZxmfZ7EV
         r7QsFq8V1BgAMSygYXHd4zpdahyIbTGeAtmbuIPpJkg4Xu0lHaKA3jFo7HNBIAELey6z
         bqCwQXfhO06rzG/q5cHTR0heMdjGBbRQcvlVrCHhi5YmkhgJX7Bwv1vpO0XLEc4GKB6K
         C9eOgT8shFcE8Br0BBqWlmyHbKUwwebriDP8zgP2Eu5JGE2vqN851cwoU1+AJEph9bwB
         LrtA==
X-Gm-Message-State: AOAM5307KAoCPWNDfDqkCzSB+pCgjWHeOB+3+yDmICjh5gOulz22LFqp
        Qfj/VmowcXbJ3BflBBn9fOPksNcJeqSW/SQxtFU=
X-Google-Smtp-Source: ABdhPJyEWSReLCE8rrmB+GNzEH5gcNq+rJv3hRtLop0torxI4VqMwDo2YGlxZVpgLlYPMbbmDZB3QnM2ys4rPTYQ4ek=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr9337169oie.167.1627062361378;
 Fri, 23 Jul 2021 10:46:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <791c6c2c9ade5b065fc0f367e00c52a493d086ef.1626901619.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 10:45:50 -0700
Message-ID: <CABPp-BHQ52WpCKc8dxaV+u1QZCeT-YieQynTmK_w84r_Tc=VGQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] add: allow operating on a sparse-only index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Disable command_requires_full_index for 'git add'. This does not require
> any additional removals of ensure_full_index(). The main reason is that
> 'git add' discovers changes based on the pathspec and the worktree
> itself. These are then inserted into the index directly, and calls to
> index_name_pos() or index_file_exists() already call expand_to_path() at
> the appropriate time to support a sparse-index.

Nice.

> Add a test to check that 'git add -A' and 'git add <file>' does not
> expand the index at all, as long as <file> is not within a sparse
> directory. This does not help the global 'git add .' case.

Good idea.

> We can measure the improvement using p2000-sparse-operations.sh with
> these results:
>
> Test                                  HEAD~1           HEAD
> ------------------------------------------------------------------------------
> 2000.6: git add -A (full-index-v3)    0.35(0.30+0.05)  0.37(0.29+0.06) +5.7%
> 2000.7: git add -A (full-index-v4)    0.31(0.26+0.06)  0.33(0.27+0.06) +6.5%
> 2000.8: git add -A (sparse-index-v3)  0.57(0.53+0.07)  0.05(0.04+0.08) -91.2%
> 2000.9: git add -A (sparse-index-v4)  0.58(0.55+0.06)  0.05(0.05+0.06) -91.4%
>
> While the 91% improvement seems impressive, it's important to recognize
> that previously we had significant overhead for expanding the
> sparse-index. Comparing to the full index case, 'git add -A' goes from
> 0.37s to 0.05s, which is "only" an 86% improvement.

Hehe.  Yep, it's so "disappointing" to "only" have the code be 7x faster.  :-)

Out of curiosity, IIRC any operation involving the index took ~10s on
some of the Microsoft repos.  What does the speedup look like over
there for these changes to git-add?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c                            |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 14 ++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index b773b5a4993..c76e6ddd359 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -528,6 +528,9 @@ int cmd_add(int argc, const char **argv, const char *prefix)
>         add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
>         require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         hold_locked_index(&lock_file, LOCK_DIE_ON_ERROR);
>
>         /*
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a3c01d588d8..a11d9d7f35d 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -340,13 +340,6 @@ test_expect_success 'status/add: outside sparse cone' '
>
>         test_sparse_match git status --porcelain=v2 &&
>
> -       # This "git add folder1/a" fails with a warning
> -       # in the sparse repos, differing from the full
> -       # repo. This is intentional.
> -       test_sparse_match test_must_fail git add folder1/a &&
> -       test_sparse_match test_must_fail git add --refresh folder1/a &&
> -       test_all_match git status --porcelain=v2 &&
> -

Why was this chunk removed?  Nothing in the commit message mentions
this, and it's not clear to me the reason for it.

I tried adding it back in at the end of the series and it still works
(and further I can't change test_sparse_match to test_all_match and
have the test work).

>         test_all_match git add . &&
>         test_all_match git status --porcelain=v2 &&
>         test_all_match git commit -m folder1/new &&
> @@ -635,7 +628,12 @@ test_expect_success 'sparse-index is not expanded' '
>         git -C sparse-index reset --hard &&
>         ensure_not_expanded checkout rename-out-to-out -- deep/deeper1 &&
>         git -C sparse-index reset --hard &&
> -       ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1
> +       ensure_not_expanded restore -s rename-out-to-out -- deep/deeper1 &&
> +
> +       echo >>sparse-index/README.md &&
> +       ensure_not_expanded add -A &&
> +       echo >>sparse-index/extra.txt &&
> +       ensure_not_expanded add extra.txt

...and here's the extra test you mentioned in the commit message.  Looks good.

>  '
>
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> --
> gitgitgadget
