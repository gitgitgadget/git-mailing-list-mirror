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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39460C4338F
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDE761165
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbhHTVy0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Aug 2021 17:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbhHTVyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Aug 2021 17:54:25 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F20C061575
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:53:47 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id x10-20020a056830408a00b004f26cead745so17229520ott.10
        for <git@vger.kernel.org>; Fri, 20 Aug 2021 14:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLTG2Wuj68VjyyXucBKh7NmCuexGY/TFVxzx0eLB2Nk=;
        b=SBb/ucnbR0zZfTZUPaBhLJ8XbeZc+xVqs6syAhSRewJmtWE242KNAtjK2cYVRRYFq1
         DFdZFgavuwe79khr/vesdTztdTujqHXMDZUZfmuy+o6XQb5nAzsR+FevP7ddUuVZZMvk
         9x5pL/PEIdIBVuqeXDc046nwOr1Ku1tvi+Jtc1elnQEJiUmT2C9tFWbOGZKTkr51Wh/s
         I8S+JOTlBPi4DyhEYwOixUW9l2JM/gDoa6iUTik6bJhh0/7Oq9JGvmnNr23qrj0KmOJ2
         ATALd4gOjMyZN1v++NHjqgsgMKwRmOuBQ/q+s62AXPIAjl2qHjosT1h9IaXOLZYQpxlh
         3pfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLTG2Wuj68VjyyXucBKh7NmCuexGY/TFVxzx0eLB2Nk=;
        b=awfXqWfAM+LTEnb21L9LX/2neh78oRJTKFc3M8ucr83Rfes9tV4oqv7eGPD1dzZJ1g
         P1Co51Sbwu/4sgqsUL5s2vriVfUmylo1sm8otOweycWnHRCbmPEps0ocVuJmWDhm8Ms9
         DSaSZ+5EC/9PUL1/pp3lLq5sFgiMeNT1xwxa0oMzWQijBHH8GEzWopcqW6ofvZor2eLp
         OykWmoFAtxR6jmdgPObukuqgNU5cchls6Bk1URRonofH/sD3mm3AVC85dKefRJydwYcS
         NvZMl/lIbNLVDk3kODKbVEmhMFZ148g1Ypjh9B7WlxqKJFsEqhoJh44/YNQV7iiP9c4a
         X5Yg==
X-Gm-Message-State: AOAM531BJPp79oL5Tu62jmoKkU6ky4prNOh8xxMSwvPXG0z1JE6cMYff
        xNHntTib3yLer2oksdPCtmbpeGYhFHTi6vAm9H4=
X-Google-Smtp-Source: ABdhPJw+U5xcGtoD4lqEhx1LPcxS7kQrjaONFuVs2S+fQ/Kyuce380MZdnqZ6+Ftlr0YifCEDo9Gj3sJsKsGKqdDldA=
X-Received: by 2002:a9d:630e:: with SMTP id q14mr18361663otk.316.1629496426675;
 Fri, 20 Aug 2021 14:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1019.git.1629220124.gitgitgadget@gmail.com> <e47b15554e3770571aafe44b4492d2f420f13919.1629220124.git.gitgitgadget@gmail.com>
In-Reply-To: <e47b15554e3770571aafe44b4492d2f420f13919.1629220124.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Aug 2021 14:53:35 -0700
Message-ID: <CABPp-BHZEVgNwd8ziCeAOOMU=Up-DVaOh7oG1ksCVAHT5r+0bg@mail.gmail.com>
Subject: Re: [PATCH 4/6] merge-ort: expand only for out-of-cone conflicts
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

If I had read ahead a little bit instead of responding as I went....  :-)

Awesome to see this.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  merge-ort.c                              | 14 ++++++++---
>  t/t1092-sparse-checkout-compatibility.sh | 30 ++++++++++++++++++++++--
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 8e754b769e1..590e52058cf 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -36,6 +36,7 @@
>  #include "tree.h"
>  #include "unpack-trees.h"
>  #include "xdiff-interface.h"
> +#include "dir.h"

dir.h was already included from merge-ort.c; no need to include it
again.  (Plus, the original line keeps the nice ordering of the
include list...)

>
>  /*
>   * We have many arrays of size 3.  Whenever we have such an array, the
> @@ -4060,11 +4061,18 @@ static int record_conflicted_index_entries(struct merge_options *opt)
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

Sweet, awesome that it was so simple to implement.

>
>         /* If any entries have skip_worktree set, we'll have to check 'em out */
>         state.force = 1;
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 781ebd9a656..a0ed2bec574 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -622,8 +622,21 @@ test_expect_success 'sparse-index is expanded and converted back' '
>  ensure_not_expanded () {
>         rm -f trace2.txt &&
>         echo >>sparse-index/untracked.txt &&
> -       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> -               git -C sparse-index "$@" &&
> +
> +       if test "$1" = "!"
> +       then
> +               shift &&
> +               (
> +                       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" &&
> +                       GIT_TRACE2_EVENT_NESTING=10 &&
> +                       export GIT_TRACE2_EVENT &&
> +                       export GIT_TRACE2_EVENT_NESTING &&
> +                       test_must_fail git -C sparse-index "$@" || return 1
> +               )

Could this be simplified to
          test_must_fail env \
                  GIT_TRACE2_EVENT="$(pwd)/trace2.txt"
GIT_TRACE2_EVENT_NESTING=10 \
                          git -C sparse-index "$@" || return 1
?
Especially if the lines can be indented to make it clear that the only
difference between this block and the one below is the "test_must_fail
env" being added at the front.



> +       else
> +               GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +                       git -C sparse-index "$@" || return 1
> +       fi &&
>         test_region ! index ensure_full_index trace2.txt
>  }
>
> @@ -659,6 +672,19 @@ test_expect_success 'sparse-index is not expanded' '
>         ensure_not_expanded merge -s ort -m merge update-folder2
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
> +       ensure_not_expanded ! merge -m merged expand-right
> +'
> +
>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> --
> gitgitgadget
>
