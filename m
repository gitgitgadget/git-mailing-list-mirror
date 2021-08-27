Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5AADC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B370060FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhH0WoC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0WoB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:44:01 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40560C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:43:12 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id p2so11891983oif.1
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QTDfTrgWPR6yX7opNlpxai2tw0tn3k+LaIZcpBXPLHg=;
        b=TQu6YyBU+MZwoB8rMIIcnGYNzXVUsg+6oy217j2xQEtdQnpjFomVuNuxVcdM33XYM6
         QWy7mvZffKyC+kmhKYcmrzAqDxhxTfeqiQkkFZuKSgV3IF3PegiAeStUYaNwbedcaniH
         2im8dhNwDzn9X+A234BF1krQZNBrCjjXiE3i9dn4/CgljhBYf3eu8SCbjyIvxDtcmhGQ
         /bn3OiG5O4tdxQbFCdWhxFplwKaOgsjy+7VVXdOZsftG0mB9tzeNve+0B5Sm7M1aCa4J
         tXpIoRdHiqH1FchfUoAoXazaXfIUrb9vnkECmeW4lk7MkqrFpw/ijBxhsNjp6bIQgkrm
         pJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QTDfTrgWPR6yX7opNlpxai2tw0tn3k+LaIZcpBXPLHg=;
        b=VSv1WFsSzGesUzsEpYk35eM46y/RDyGFtaro2R3Zdsf/6+Mj9oM2Ch+zUjFxJfrJxk
         emgRgRm8mOH1gNV6C75vNc58AuSWEb0shKndWfdqO3YTT358Q6Yf0CxxBCeG1I3ox9+t
         H68mT/ivB2i7LrSLaEYJmh62Bo63on2ZJBjjwm65gEDatq6JmvpY+ZksTZqFtH8d/ha+
         Vv/fjtpLVuwpkV2se0522zhldvvctkwXGKH9uCXYX100eu9BnBg/SSsDcEwrENxrU76B
         JlF1h5TDYakbsRrWDx5i0ObZbaLhqlmZ07QnmpQPoR5rzDAsTIVVXrkbIiiwLzSW4Nm6
         yPZA==
X-Gm-Message-State: AOAM532wZT84ew8+EXkxCIYnOhltiuSGYkTr3tiiRW91AiKBTMWyEICn
        /48bRNMcdhXLvlEJYw2oFIK4ROMXmvX/9aFN5PQ=
X-Google-Smtp-Source: ABdhPJxtvjJiwCcBWKfxKB9XMy2qbFIz6F9Rm9bHq1tGAL5ed4FA9gn22GyIdEKb/ET5azBNX6NZhGzCWPBjdp8DuXU=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr8351533oiw.31.1630104191571;
 Fri, 27 Aug 2021 15:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com> <bb150483bcfd0469cd88bab735bc1178fb6628f5.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <bb150483bcfd0469cd88bab735bc1178fb6628f5.1629841966.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 15:43:00 -0700
Message-ID: <CABPp-BEF0htk-Q-+wiF+XgTWRRtDc5FPJKauWZAivLGuMgWeAQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] merge: make sparse-aware with ORT
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 2:52 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Allow 'git merge' to operate without expanding a sparse index, at least
> not immediately. The index still will be expanded in a few cases:
>
> 1. If the merge strategy is 'recursive', then we enable
>    command_requires_full_index at the start of the merge_recursive()
>    method. We expect sparse-index users to also have the 'ort' strategy
>    enabled.
>
> 2. With the 'ort' strategy, if the merge results in a conflicted file,
>    then we expand the index before updating the working tree. The loop
>    that iterates over the worktree replaces index entries and tracks
>    'origintal_cache_nr' which can become completely wrong if the index
>    expands in the middle of the operation. This safety valve is
>    important before that loop starts. A later change will focus this
>    to only expand if we indeed have a conflict outside of the
>    sparse-checkout cone.
>
> 3. Other merge strategies are executed as a 'git merge-X' subcommand,
>    and those strategies are currently protected with the
>    'command_requires_full_index' guard.

Oh, indeed, it appears ag/merge-strategies-in-c didn't complete but
was discarded, as per the July 6 "What's cooking in git.git" email.
Well, that certainly makes things easier for you; thanks for
mentioning them in this item #3.

>
> Some test updates are required, including a mistaken 'git checkout -b'
> that did not specify the base branch, causing merges to be fast-forward
> merges.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/merge.c                          |  3 +++
>  merge-ort.c                              |  8 ++++++++
>  merge-recursive.c                        |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 12 ++++++++++--
>  4 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 22f23990b37..926de328fbb 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1276,6 +1276,9 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
>         if (argc == 2 && !strcmp(argv[1], "-h"))
>                 usage_with_options(builtin_merge_usage, builtin_merge_options);
>
> +       prepare_repo_settings(the_repository);
> +       the_repository->settings.command_requires_full_index = 0;
> +
>         /*
>          * Check if we are _not_ on a detached HEAD, i.e. if there is a
>          * current branch.
> diff --git a/merge-ort.c b/merge-ort.c
> index 6eb910d6f0c..8e754b769e1 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4058,6 +4058,14 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>         if (strmap_empty(&opt->priv->conflicted))
>                 return 0;
>
> +       /*
> +        * We are in a conflicted state. These conflicts might be inside
> +        * sparse-directory entries, so expand the index preemtively.

Same typo I pointed out in v1.

> +        * Also, we set original_cache_nr below, but that might change if
> +        * index_name_pos() calls ask for paths within sparse directories.
> +        */
> +       ensure_full_index(index);
> +
>         /* If any entries have skip_worktree set, we'll have to check 'em out */
>         state.force = 1;
>         state.quiet = 1;
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 3355d50e8ad..1f563cd6874 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3750,6 +3750,9 @@ int merge_recursive(struct merge_options *opt,
>         assert(opt->ancestor == NULL ||
>                !strcmp(opt->ancestor, "constructed merge base"));
>
> +       prepare_repo_settings(opt->repo);
> +       opt->repo->settings.command_requires_full_index = 1;
> +
>         if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
>                 return -1;
>         clean = merge_recursive_internal(opt, h1, h2, merge_bases, result);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index ddc86bb4152..dc56252865c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -47,7 +47,7 @@ test_expect_success 'setup' '
>                 git checkout -b base &&
>                 for dir in folder1 folder2 deep
>                 do
> -                       git checkout -b update-$dir &&
> +                       git checkout -b update-$dir base &&
>                         echo "updated $dir" >$dir/a &&
>                         git commit -a -m "update $dir" || return 1
>                 done &&
> @@ -647,7 +647,15 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/extra.txt &&
>         ensure_not_expanded add extra.txt &&
>         echo >>sparse-index/untracked.txt &&
> -       ensure_not_expanded add .
> +       ensure_not_expanded add . &&
> +
> +       ensure_not_expanded checkout -f update-deep &&
> +       (
> +               sane_unset GIT_TEST_MERGE_ALGORITHM &&
> +               git -C sparse-index config pull.twohead ort &&
> +               ensure_not_expanded merge -m merge update-folder1 &&
> +               ensure_not_expanded merge -m merge update-folder2
> +       )
>  '

Should you use test_config rather than git config here?

More importantly, why the subshell and unsetting of
GIT_TEST_MERGE_ALGORITHM and the special worrying about pull.twohead?
Wouldn't it be simpler to just set GIT_TEST_MERGE_ALGORITHM=ort,
perhaps at the beginning of the file?
