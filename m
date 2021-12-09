Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EACC433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbhLIFXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhLIFXg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:23:36 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BF7C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:20:03 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z5so15750871edd.3
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIhV0nkuIquCY2cXBn5/pID0jAl/shNi1UMiQTqrD5c=;
        b=i11i7i0df/x0jDpYfcxGuh/qwyHrB1+9q461/fXFWF3r2xBUNVffm2+qIfxiiF0/ka
         owRmxuyLBRw3JKKtcOF9jeqgphUhx2Nd8POdnvi/fabOo2QgjXVCx4RvSaMFRGV7mchx
         ptdpjrywcO0WopkoIx8ZtHeTm7hiOrXKFDjkEaLFNsCV8Kqt7kx1JV0KP3GilkF0bCoD
         LZA11yYNfGwSxiZK2AOLDqr+4hpnAwvAFOTNrVdpBmAaW0Vv2aNtDC14lHCWpfWlb5O2
         4ACHKVakDdN5IHKhVLyy1EYk7fZRNNlKnmR/q8s/B/rnULctaX8jUTYjC9xPvHWNcYl7
         4YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIhV0nkuIquCY2cXBn5/pID0jAl/shNi1UMiQTqrD5c=;
        b=xAekmXV0/mTxxQ2v249y3/CJA2TKNi95r076pQoPefjXFrIgAY3WTRWHTTZNhr3Q5o
         OfogCm5Fo+098t90pLcLrHTCHDCEAjpUYlGORwlbV9VperS+GSXCq+9HujUXnjl1kUiy
         SqHSgihbMVEuN0k+ZApO0t6WjD4e3y+WQG79nTmHYz/E0Q5vTS51QcZfJKcHi6WVdkbY
         00a73Iq7bZxCYFykb5xYpOxdDYc0nmnPUK7tuVXXBJlKZmCiAEyOEejx7U5dfNVf5kve
         NP+QJ24HvA265clCy3b9YZc2m1fC9hXE8nqMRvkV+ey3cHgVdSozKq2EqP3kp6Cu8eWn
         KiSA==
X-Gm-Message-State: AOAM533RKpxjsVo5HwoAjIyU4VEZnKtTOUh3gGvGTgfCrKmy7ZP3XIzC
        UkNLnqUBDrQax28Upd+C9PkeRN0wuErJu5IuLGs=
X-Google-Smtp-Source: ABdhPJzS9jS2IEpNYmrJB+iwtmCxRUopUor9FsPXK4PJ1hocohz8kc1dmAbWHhtSoJvLStx6OFGik8sFwnb0SSgC7vI=
X-Received: by 2002:a17:907:3fa0:: with SMTP id hr32mr12899823ejc.443.1639027201598;
 Wed, 08 Dec 2021 21:20:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com> <5ffae2a03ae3d00a1f128d7cf2a397081055a2fe.1638992396.git.gitgitgadget@gmail.com>
In-Reply-To: <5ffae2a03ae3d00a1f128d7cf2a397081055a2fe.1638992396.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 8 Dec 2021 21:19:49 -0800
Message-ID: <CABPp-BGQh2qNHKGmxr7rUqzyCjVpY=o2QB9qv6S8arz-mVm51Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] t1092: replace 'read-cache --table' with 'ls-files --sparse'
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 8, 2021 at 11:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Now that 'git ls-files --sparse' exists, we can use it to verify the
> state of a sparse index instead of 'test-tool read-cache table'. Replace
> these usages within t1092-sparse-checkout-compatibility.sh.
>
> The important changes are due to the different output format. We need to
> use the '--stage' output to get a file mode and OID, but it also
> includes a stage value and drops the object type. This leads to some
> differences in how we handle looking for specific entries.
>
> Some places where we previously looked for no 'tree' entries, we can
> instead directly compare the output across the repository with a sparse
> index and the one without.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 29 +++++++++++-------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index bf2c6b169b9..4a6832ea3c5 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -200,45 +200,42 @@ test_sparse_unstaged () {
>  test_expect_success 'sparse-index contents' '
>         init_repos &&
>
> -       test-tool -C sparse-index read-cache --table >cache &&
> +       git -C sparse-index ls-files --sparse --stage >cache &&
>         for dir in folder1 folder2 x
>         do
>                 TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> -               grep "040000 tree $TREE $dir/" cache \
> +               grep "040000 $TREE 0    $dir/" cache \
>                         || return 1
>         done &&
>
>         git -C sparse-index sparse-checkout set folder1 &&
>
> -       test-tool -C sparse-index read-cache --table >cache &&
> +       git -C sparse-index ls-files --sparse --stage >cache &&
>         for dir in deep folder2 x
>         do
>                 TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> -               grep "040000 tree $TREE $dir/" cache \
> +               grep "040000 $TREE 0    $dir/" cache \
>                         || return 1
>         done &&
>
>         git -C sparse-index sparse-checkout set deep/deeper1 &&
>
> -       test-tool -C sparse-index read-cache --table >cache &&
> +       git -C sparse-index ls-files --sparse --stage >cache &&
>         for dir in deep/deeper2 folder1 folder2 x
>         do
>                 TREE=$(git -C sparse-index rev-parse HEAD:$dir) &&
> -               grep "040000 tree $TREE $dir/" cache \
> +               grep "040000 $TREE 0    $dir/" cache \
>                         || return 1
>         done &&
>
>         # Disabling the sparse-index removes tree entries with full ones

Not the fault of this patch, but perhaps worth fixing "removes" ->
"replaces" while you're making fixes in this area?


>         git -C sparse-index sparse-checkout init --no-sparse-index &&
> -
> -       test-tool -C sparse-index read-cache --table >cache &&
> -       ! grep "040000 tree" cache &&
> -       test_sparse_match test-tool read-cache --table
> +       test_sparse_match git ls-files --stage --sparse
>  '
>
>  test_expect_success 'expanded in-memory index matches full index' '
>         init_repos &&
> -       test_sparse_match test-tool read-cache --expand --table
> +       test_sparse_match git ls-files --stage
>  '
>
>  test_expect_success 'status with options' '
> @@ -787,9 +784,9 @@ test_expect_success 'submodule handling' '
>
>         # having a submodule prevents "modules" from collapse
>         test_sparse_match git sparse-checkout set deep/deeper1 &&
> -       test-tool -C sparse-index read-cache --table >cache &&
> -       grep "100644 blob .*    modules/a" cache &&
> -       grep "160000 commit $(git -C initial-repo rev-parse HEAD)       modules/sub" cache
> +       git -C sparse-index ls-files --sparse --stage >cache &&
> +       grep "100644 .* modules/a" cache &&
> +       grep "160000 $(git -C initial-repo rev-parse HEAD) 0    modules/sub" cache
>  '
>
>  # When working with a sparse index, some commands will need to expand the
> @@ -1079,13 +1076,13 @@ test_expect_success 'reset mixed and checkout orphan' '
>         # the sparse checkouts skip "adding" the other side of
>         # the conflict.
>         test_sparse_match git reset --mixed HEAD~1 &&
> -       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git ls-files --stage &&
>         test_sparse_match git status --porcelain=v2 &&
>
>         # At this point, sparse-checkouts behave differently
>         # from the full-checkout.
>         test_sparse_match git checkout --orphan new-branch &&
> -       test_sparse_match test-tool read-cache --table --expand &&
> +       test_sparse_match git ls-files --stage &&
>         test_sparse_match git status --porcelain=v2
>  '
>
> --
> gitgitgadget
>
