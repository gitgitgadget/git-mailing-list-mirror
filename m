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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C43C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A736115A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhHTVlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTVk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:40:58 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B7C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:40:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id i3-20020a056830210300b0051af5666070so7440439otc.4
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sN+bqYJHCw0ITb3Sl53XdHnW6ufVt4/Ab4nodKjdy/0=;
        b=gHAaScSWv0lBOmHp8oabOp1x/iqWeMRM1KSAquPxRjagOSuyDgE6qo+uJuULvAIyrt
         j6U9+AfaXKQP45usAGzK2gZQb0oTx+68SRsooUNmmiqk+0cST8BIP/AHwbyQTMAAMWHM
         iBLmeaS2JCmlaDykqac94eLcR0GszRGre/RH3cgrgh43v17j2TkUGlPK8NQdt6yO+QH4
         m2xHwuI5EjnrRwq1P9rJJlDX61EZ37mzVWTiXOXvtvIKXzwjdY8J1QYrtdf//jzAcJPk
         0mhod3wSddZr2u8n1iFNJMXyd3mdD6TrPWikRy2zCwKcFqnRKNf8jA5EX0x6kOIYquQB
         wJSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sN+bqYJHCw0ITb3Sl53XdHnW6ufVt4/Ab4nodKjdy/0=;
        b=Rat6sDZCEqFbDQ0aDjYMT7IjI4scW0rui8yqdX5qeGXYgIKFLPJc98vySbyG7dCzZm
         L1f9czdv9za9o7GWONUBIjnUeeagQmb7oZKev73kdSiPVN0Zm1bYRA2rrD56v+86bFR1
         PKhTr9fppDTkHmOhyVFhxBi57AEMFy1CCRRazleayqSWlV8fo0YWxe36hstgMaj/qHWN
         4h9GA07ruzuxhxtPZ1DwvgZVbLIGcvgegTPGUZEQzNRSLGGyGbDGNbAA/GiNbsAkT4LW
         0/05NXbmmQS/64Tgwi4Amqgj8ITK20cUiG39Ze7Jta57DJK4NzElv5wGA2JZKNQZFQeZ
         Ro/A==
X-Gm-Message-State: AOAM531G3CjusMBGHPDqixPW3Vzx6BbAqO2VvIZrP0lNCHGX6K5C6o+s
        inDUaCpF9Cu6yBUWj6VQH0iHuUx6mZmveOgCpO0=
X-Google-Smtp-Source: ABdhPJz8uk0HDx3/ZqRIgIDotQdRarN49dMM63WiAf//6eMtBnM1GUbwv5qt0httm2wVigGYunOmq6FrL72H6ddAu/c=
X-Received: by 2002:a9d:448:: with SMTP id 66mr18701646otc.345.1629495619524;
 Fri, 20 Aug 2021 14:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <4c1104a0dd3af4a895df42f43306c24965a0323c.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <4c1104a0dd3af4a895df42f43306c24965a0323c.1629220124.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 14:40:08 -0700
Message-ID: <CABPp-BHHtbv7R7Z0kNYBsW_hJuHT76we9k6gZfZ0z8AJQYO3jw@mail.gmail.com>
Subject: Re: [PATCH 3/6] merge: make sparse-aware with ORT
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 17, 2021 at 10:08 AM Derrick Stolee via GitGitGadget
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

What about `resolve`, `octopus`, `subtree` (which technically could be
implemented via either recursive or ort, such fun...) or a
user-defined strategy?

`resolve` and `octopus` would absolutely need a full index.  `subtree`
would if implemented via merge-recursive, and not if implemented via
merge-ort.

I'm not sure what to assume about user-defined strategies; I guess for
safety reasons and backward compatibility, we should always expand?
Or maybe there are no backward compatibility concerns since no one who
uses a sparse-index will attempt to use any pre-existing external
merge strategies (are there even any known ones in the wild or is this
still a theoretical capability?), and we can assume they will only use
ones written in the future?  Hmm...

> 2. If the merge results in a conflicted file, then we expand the index
>    before updating the working tree. The loop that iterates over the
>    worktree replaces index entries and tracks 'origintal_cache_nr' which
>    can become completely wrong if the index expands in the middle of the
>    operation. This safety valve is important before that loop starts. A
>    later change will focus this to only expand if we indeed have a
>    conflict outside of the sparse-checkout cone.

From reading the patch below, this is specific to ort, but that wasn't
clear on reading the commit message.

> Some test updates are required, including a mistaken 'git checkout -b'
> that did not specify the base branch, causing merges to be fast-forward
> merges.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/merge.c                          | 3 +++
>  merge-ort.c                              | 8 ++++++++
>  merge-recursive.c                        | 3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 8 ++++++--
>  4 files changed, 20 insertions(+), 2 deletions(-)
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

s/preemtively/preemptively/

> +        * Also, we set original_cache_nr below, but that might change if
> +        * index_name_pos() calls ask for paths within sparse directories.
> +        */
> +       ensure_full_index(index);
> +

This seems somewhat pessimistic; what if all the conflicts are within
the sparse-checkout?  Having conflicts contains within the
sparse-checkout seems likely, since we'd only get conflicts for files
modified by both sides of history, and sparse-checkouts are used when
users aren't going to modify files outside the sparse-checkout.

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
> index 3e01e70fa0b..781ebd9a656 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -52,7 +52,7 @@ test_expect_success 'setup' '
>                 git checkout -b base &&
>                 for dir in folder1 folder2 deep
>                 do
> -                       git checkout -b update-$dir &&
> +                       git checkout -b update-$dir base &&
>                         echo "updated $dir" >$dir/a &&
>                         git commit -a -m "update $dir" || return 1
>                 done &&
> @@ -652,7 +652,11 @@ test_expect_success 'sparse-index is not expanded' '
>         echo >>sparse-index/extra.txt &&
>         ensure_not_expanded add extra.txt &&
>         echo >>sparse-index/untracked.txt &&
> -       ensure_not_expanded add .
> +       ensure_not_expanded add . &&
> +
> +       ensure_not_expanded checkout -f update-deep &&
> +       ensure_not_expanded merge -s ort -m merge update-folder1 &&
> +       ensure_not_expanded merge -s ort -m merge update-folder2

Can we just set GIT_TEST_MERGE_ALGORITHM=ort at the beginning of the
test file and then avoid repeating `-s ort`?


>  '
>
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
> --
> gitgitgadget
