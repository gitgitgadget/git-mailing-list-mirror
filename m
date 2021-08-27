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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA5A2C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B546C60F5B
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbhH0Wsp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0Wso (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:48:44 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24CCC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:47:54 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id o185so11511434oih.13
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pdHgJNHsl42A7a5LeCyqwdclbG1xHiZ6y/tKSa85ZLs=;
        b=T6Vd1lvMDni3/I/bTxsrY2MfECKeDbkPVbYbUnp/f05nM0rcFht1ZJSdHkOXz6J4OW
         2/8ywbZHeQwCIOnx92HxxBO7aTcz5WajxR01FrZpGb+d4pIqiqwdZI+CTMVRz7gGllks
         gKLLAhBhmMhysnLyn9W2R8pZUGZnz8rhHA94UsjjY+ftnYWbwOPLqzBugtuLosFi9UMQ
         nAUIqeaJYRFgu5ucwz9B1OT2mZH9U2rBTAajj8BiuTdIk+YkkvO86Tnta5iprI+haIp9
         G7MU+ywpoK5S6POFBFJIwFGVCfK9nZ/MreTGAAQ7AuuKjziLvA/83NsxRoL44Uzr5Yvy
         eFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pdHgJNHsl42A7a5LeCyqwdclbG1xHiZ6y/tKSa85ZLs=;
        b=N/ajSHC1oVuCQChNdxnOH+OoeGZNzb0ovteNd/BHrR+mUbtD8J782Az8khU4QPIxqd
         rEqA7Fw0NvD4pH8ufXPf5PVasYiLNRbfn2US7J0akmRs54d4LnrtXESXjTQIYRQ5D4O2
         wxEBE3UZi6nICYulDYYeM12aYrfoGjTQ3Y4m4Mr/EljtrZ+IvXP8L/wYSg9f3Txw1Guv
         4DM0b/9Vug7QzPiTpBw0/1nsUWVNxIPH42xFkSnf3h8jIdsRNvbhUyDXwUtgzCXodZPx
         jNvQkv7U6twnin+XDnQIAoPLRXn9yWy7hCFUM+8iDAwMULCJ8ttYm0/LYoaFXI9aDqNl
         yj1g==
X-Gm-Message-State: AOAM533H9EyqOVCwyf5Dy6muE2XR6eUCPReigDCA+rsgW6/+DCoziWkN
        qiO019k8Iqcz2ZdvxXVtujohw62ScCo9ADcsVYptPC9M
X-Google-Smtp-Source: ABdhPJw8E1ZeHl5sYsNJF9RPMyKKSME9TzYs6S35NniVMTfc2bX0TYkEWlBP+kd56xYxzZEDzzY1vGkRL9nixHKDQHg=
X-Received: by 2002:a05:6808:1787:: with SMTP id bg7mr16484804oib.39.1630104474047;
 Fri, 27 Aug 2021 15:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com>
 <pull.1019.v2.git.1629841965.gitgitgadget@gmail.com> <815b1b1cfbfedae7ccbec51b382053e3dcf197de.1629841966.git.gitgitgadget@gmail.com>
In-Reply-To: <815b1b1cfbfedae7ccbec51b382053e3dcf197de.1629841966.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Aug 2021 15:47:43 -0700
Message-ID: <CABPp-BHzbg0tghxOncOVtLr44R1W45_PoLBk_Mztg8LaVv5hBQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] merge-ort: expand only for out-of-cone conflicts
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
> Merge conflicts happen often enough to want to avoid expanding a sparse
> index when they happen, as long as those conflicts are within the
> sparse-checkout cone. If a conflict exists outside of the
> sparse-checkout cone, then we still need to expand before iterating over
> the index entries. This is critical to do in advance because of how the
> original_cache_nr is tracked to allow inserting and replacing cache
> entries.
>
> Iterate over the conflicted files and check if any paths are outside of
> the sparse-checkout cone. If so, then expand the full index.
>
> Add a test that demonstrates that we do not expand the index, even when
> we hit a conflict within the sparse-checkout cone.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  merge-ort.c                              | 13 +++++++---
>  t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++--
>  2 files changed, 38 insertions(+), 5 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8e754b769e1..805f7c41397 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -4060,11 +4060,18 @@ static int record_conflicted_index_entries(struct merge_options *opt)
>
>         /*
>          * We are in a conflicted state. These conflicts might be inside
> -        * sparse-directory entries, so expand the index preemtively.
> -        * Also, we set original_cache_nr below, but that might change if
> +        * sparse-directory entries, so check if any entries are outside
> +        * of the sparse-checkout cone preemptively.
> +        *
> +        * We set original_cache_nr below, but that might change if
>          * index_name_pos() calls ask for paths within sparse directories.
>          */
> -       ensure_full_index(index);
> +       strmap_for_each_entry(&opt->priv->conflicted, &iter, e) {
> +               if (!path_in_sparse_checkout(e->key, index)) {
> +                       ensure_full_index(index);
> +                       break;
> +               }
> +       }
>
>         /* If any entries have skip_worktree set, we'll have to check 'em out */
>         state.force = 1;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index dc56252865c..38afdf689a2 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -617,8 +617,17 @@ test_expect_success 'sparse-index is expanded and converted back' '
>  ensure_not_expanded () {
>         rm -f trace2.txt &&
>         echo >>sparse-index/untracked.txt &&
> -       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -               git -C sparse-index "$@" &&
> +
> +       if test "$1" = "!"
> +       then
> +               shift &&
> +               test_must_fail env \
> +                       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +                       git -C sparse-index "$@" || return 1
> +       else
> +               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +                       git -C sparse-index "$@" || return 1
> +       fi &&
>         test_region ! index ensure_full_index trace2.txt
>  }
>
> @@ -658,6 +667,23 @@ test_expect_success 'sparse-index is not expanded' '
>         )
>  '
>
> +test_expect_success 'sparse-index is not expanded: merge conflict in cone' '
> +       init_repos &&
> +
> +       for side in right left
> +       do
> +               git -C sparse-index checkout -b expand-$side base &&
> +               echo $side >sparse-index/deep/a &&
> +               git -C sparse-index commit -a -m "$side" || return 1
> +       done &&
> +
> +       (
> +               sane_unset GIT_TEST_MERGE_ALGORITHM &&
> +               git -C sparse-index config pull.twohead ort &&
> +               ensure_not_expanded ! merge -m merged expand-right
> +       )

These last five lines could just be replaced with the fourth, if you
just set GIT_TEST_MERGE_ALGORITHM=ort at the beginning of the file.

Are you worrying about testing with recursive in some of the testcases?
