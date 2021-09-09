Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785DAC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F23F61222
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 14:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242558AbhIIOnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 10:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbhIIOng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 10:43:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DDC06114D
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 07:16:41 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id r26so2667785oij.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 07:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpngAkVqpQ2c0VUocW3sZlcxwMYzXArq0oJ1VKruaRo=;
        b=dTpJLowsrvi8qgAlUDtMf3ghVLU62629HmO1y0ZlWH4EZTEMO3sKQ7dDjMKqPsAFFq
         8rlUFzQmIp9FFrdXZcQbswXsyRDSCcxM8Jr1NuvxA9wXXfn6WJXUaMD5HZv1v8qXrl3a
         XP+aIm6s0Qyl/tLjsim/3bvJIY95/AzsMbt5CkNpBu+RBMgnfn9UbScYG9fcBGmICuLO
         dc9UzHX8pqeAuf0ynugMV9oamIK/WOZ3n4KOpYL0DXDrGrRD4ej6bY/IcEPRja6Apm+B
         AUhbSwgsiB0/onXf+DxGZLkZU7bRyphDvfhvpccTzgwvcZnP8Ob6lhgE5wTmU2ksVcS8
         C48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpngAkVqpQ2c0VUocW3sZlcxwMYzXArq0oJ1VKruaRo=;
        b=ZZ910CZCvGa4pyNQF4v6CAM+UiSIukVHZKh2ZPHba3Cg+oJY5SOv9VYzJa2UUXmD4O
         V8PvTY4TIrP+VunLDAU/as7f9QCwBWGCYvXEXoCB+qu4TB/0VC2+HeBReJTiBBEwHDeG
         iRgqYjpj9ZZKJSYtDyuOGXsISYgucXDSR0j+kbanBxC6kAbp+YBnGHIS4Jtw0zweW5K7
         SUFuqmw1R/nPA+shDZRhA3xXFdxYY9a5zpE+3FyMydw5Iaxqa4ewMZQat822scGY8/My
         yEavAxGlTzwYyWBjYxZQkLxHvJrE8LaEfAl8LTR83u0/llIzrxliLSAsviNm08IsQwen
         +4Mw==
X-Gm-Message-State: AOAM530Iudq1SNokB2b/FCmvVUvJwmWVZJJo9LymQlHnE6IR5ImONa5E
        ZdDQNWT9u/FetrpxbRBtkmr/UxUVi7t3/gFoz+Y=
X-Google-Smtp-Source: ABdhPJywkO3U4JH4w+DEgeaw5qyCsRAj7htZgzKi6SkAj71xAzVJvAXL9NCydaXzoUJNe8MEG/g1CueLC3cOJF4W4/M=
X-Received: by 2002:a05:6808:2084:: with SMTP id s4mr49482oiw.31.1631197001087;
 Thu, 09 Sep 2021 07:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com> <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
In-Reply-To: <pull.1019.v3.git.1631100241.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 9 Sep 2021 07:16:29 -0700
Message-ID: <CABPp-BE0PL4xn1kKjbxtGvntdd8UJemfn3g4i5cd27nJOB7CHg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Sparse Index: Integrate with merge, cherry-pick,
 rebase, and revert
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 8, 2021 at 4:24 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series integrates the sparse index with commands that perform merges
> such as 'git merge', 'git cherry-pick', 'git revert' (free with
> cherry-pick), and 'git rebase'.
>
> When the ORT merge strategy is enabled, this allows most merges to succeed
> without expanding the sparse index, leading to significant performance
> gains. I tested these changes against an internal monorepo with over 2
> million paths at HEAD but with a sparse-checkout that only has ~60,000 files
> within the sparse-checkout cone. 'git merge' commands went from 5-6 seconds
> to 0.750-1.250s.
>
> In the case of the recursive merge strategy, the sparse index is expanded
> before the recursive algorithm proceeds. We expect that this is as good as
> we can get with that strategy. When the strategy shifts to ORT as the
> default, then this will not be a problem except for users who decide to
> change the behavior.
>
> Most of the hard work was done by previous series, such as
> ds/sparse-index-ignored-files (which this series is based on).
>
>
> Updates in V3
> =============
>
>  * Fixed a typo in patch 2 (it is then moved in patch 3, affecting the
>    range-diff)
>
>  * There was a recommendation to use test_config over git config, but that
>    is not possible in a subshell. So, it got moved outside of the subshell
>    and that works just fine.
>
>  * The other comments were about the use of GIT_TEST_MERGE_ALGORITHM in the
>    test script, but the tests that isolate that environment variable are
>    only for the 'ensure_not_expanded' tests, not the rest of the tests that
>    already exist and are beneficial to cover the 'recursive' mode.

This round addresses all my feedback and looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>

>
>
> Updates in V2
> =============
>
>  * The tests no longer specify GIT_TEST_MERGE_ALGORITHM or directly
>    reference "-s ort". By relaxing this condition, I found an issue with
>    'git cherry-pick' and 'git rebase' when using the 'recursive' algorithm
>    which is fixed in a new patch.
>
>  * Use the pull.twohead config to specify the ORT merge algorithm to avoid
>    expanding the sparse index when that is what we are testing.
>
>  * Corrected some misstatements in my commit messages.
>
> Thanks, -Stolee
>
> Derrick Stolee (6):
>   diff: ignore sparse paths in diffstat
>   merge: make sparse-aware with ORT
>   merge-ort: expand only for out-of-cone conflicts
>   t1092: add cherry-pick, rebase tests
>   sequencer: ensure full index if not ORT strategy
>   sparse-index: integrate with cherry-pick and rebase
>
>  builtin/merge.c                          |  3 +
>  builtin/rebase.c                         |  6 ++
>  builtin/revert.c                         |  3 +
>  diff.c                                   |  8 +++
>  merge-ort.c                              | 15 ++++
>  merge-recursive.c                        |  3 +
>  sequencer.c                              |  9 +++
>  t/t1092-sparse-checkout-compatibility.sh | 92 +++++++++++++++++++++---
>  8 files changed, 129 insertions(+), 10 deletions(-)
>
>
> base-commit: 91b53f20109fe55635b1815f87afd5d5da68a182
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1019%2Fderrickstolee%2Fsparse-index%2Fmerge-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1019/derrickstolee/sparse-index/merge-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1019
>
> Range-diff vs v2:
>
>  1:  c5ae705648c = 1:  a6963182fe0 diff: ignore sparse paths in diffstat
>  2:  bb150483bcf ! 2:  141f7fb26d6 merge: make sparse-aware with ORT
>      @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
>
>       + /*
>       +  * We are in a conflicted state. These conflicts might be inside
>      -+  * sparse-directory entries, so expand the index preemtively.
>      ++  * sparse-directory entries, so expand the index preemptively.
>       +  * Also, we set original_cache_nr below, but that might change if
>       +  * index_name_pos() calls ask for paths within sparse directories.
>       +  */
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
>       + ensure_not_expanded add . &&
>       +
>       + ensure_not_expanded checkout -f update-deep &&
>      ++ test_config -C sparse-index pull.twohead ort &&
>       + (
>       +         sane_unset GIT_TEST_MERGE_ALGORITHM &&
>      -+         git -C sparse-index config pull.twohead ort &&
>       +         ensure_not_expanded merge -m merge update-folder1 &&
>       +         ensure_not_expanded merge -m merge update-folder2
>       + )
>  3:  815b1b1cfbf ! 3:  c3c9ffd855c merge-ort: expand only for out-of-cone conflicts
>      @@ merge-ort.c: static int record_conflicted_index_entries(struct merge_options *op
>
>         /*
>          * We are in a conflicted state. These conflicts might be inside
>      --  * sparse-directory entries, so expand the index preemtively.
>      +-  * sparse-directory entries, so expand the index preemptively.
>       -  * Also, we set original_cache_nr below, but that might change if
>       +  * sparse-directory entries, so check if any entries are outside
>       +  * of the sparse-checkout cone preemptively.
>  4:  8032154bc8a = 4:  7aae5727fb7 t1092: add cherry-pick, rebase tests
>  5:  90ac85500b8 = 5:  20f5bbae546 sequencer: ensure full index if not ORT strategy
>  6:  df4bbec744f ! 6:  36cecb22330 sparse-index: integrate with cherry-pick and rebase
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'merge with confli
>         init_repos &&
>
>       @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is not expanded' '
>      +  test_config -C sparse-index pull.twohead ort &&
>         (
>                 sane_unset GIT_TEST_MERGE_ALGORITHM &&
>      -          git -C sparse-index config pull.twohead ort &&
>       -         ensure_not_expanded merge -m merge update-folder1 &&
>       -         ensure_not_expanded merge -m merge update-folder2
>       +         for OPERATION in "merge -m merge" cherry-pick rebase
>
> --
> gitgitgadget
