Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6128EC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 08:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiBZImP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZImP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 03:42:15 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E90B171ED7
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:41:41 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id gb39so15185703ejc.1
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NybsobLpbYbs6PCTirYaif/KKcC9o5SXEyDs5puoy8=;
        b=OWnQg0eNQhHd6ZtiVhHBhGdwVU9vjStHA4DZHkB8inRoOnM2BzxLXr2x4pSvJ3y8oS
         ebQgxJMs8ir7x19ycktt0376lfQVfr/d6dbQkJ5af0t3ivpzDxZ5uYlWN6hlJjFKpdOg
         BlCvaYzmJ1uBNHxTsqz/p5Xak1fHmuDQI318TCPNNr56RncJ6P/OsvG4DmakwPbauqo4
         nRMf2dpjjT1Ar/viN045vZT1VFJ/OxvJ1TkZbejafi3VTmECPbgc3rxZOTJ8LH2QKPv+
         ZJcjVRy3MXZb4YZhPWrjj+23A2BNAuRxpheu0ZhXU42FpoEany5AEW6Rmv0RBYd0JDry
         ZukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NybsobLpbYbs6PCTirYaif/KKcC9o5SXEyDs5puoy8=;
        b=IhwKTU99Q/CaqCyqcY9342WuLXmB6QfdegXRm7A8w9r7NZLtvINllMKnboiZKNg2ow
         pe8ZT/XPiPmd7G/T5gox9anVPJLVcW8KhGawvy3ONrWJgbMGlG5e9o+QU9trrGeM0pGt
         GetMidAnH2viCNzNgR9IZXYsUH91CVUHa+xotLTYpDm43z3KmZk1h6Rkfof17BIgnx+C
         e1LIeywDEsr58QmICKzrX/hJS3pJxnNdJn3E8MKfhHaLedp58MRYQSmUkFHUSck9LokZ
         0sAMFg234KT3pjpmVCZmrMm48OrbxeA8GtkD/We2t4/PV6CuD/SGhNB9O6FAfG8JhNZW
         IYnA==
X-Gm-Message-State: AOAM531ngWGFFKU4YALLUWN0HzQD+jD6wtahlcf512xkjnsFATjGUeRC
        vSQW7Ez30MbYYkTQt5Y3fd4Pj3hJhVdZqtFGxEc=
X-Google-Smtp-Source: ABdhPJx42wF+UFGGRwJl6XKyPdK9Q0ATxY53tUY9lZ2HNYbjr7YDZKGM15xqkU7iztzwKNS5s7FCuH379nqjD5l78mE=
X-Received: by 2002:a17:906:7e09:b0:6d6:80f5:e00f with SMTP id
 e9-20020a1709067e0900b006d680f5e00fmr688396ejr.192.1645864899522; Sat, 26 Feb
 2022 00:41:39 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
 <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com> <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
In-Reply-To: <ffe0b6aff2baee238f77ae57561a62ea5473321f.1645742073.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Feb 2022 00:41:28 -0800
Message-ID: <CABPp-BF4jtEzyUBEymhFJxaGOMRaUs-XyBdr89Fs7E_ehnwWMg@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] read-tree: expand sparse checkout test coverage
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
> emphasis is placed on interactions with files outside the sparse cone, e.g.
> merges with out-of-cone conflicts.
>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 2a7106b9495..382716cfca9 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -117,6 +117,7 @@ test_perf_on_all git diff
>  test_perf_on_all git diff --cached
>  test_perf_on_all git blame $SPARSE_CONE/a
>  test_perf_on_all git blame $SPARSE_CONE/f3/a
> +test_perf_on_all git read-tree -mu HEAD
>  test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index b1dcaa0e642..9d58da4e925 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
>         test_cmp expect sparse-checkout-out
>  '
>
> +test_expect_success 'read-tree --merge with files outside sparse definition' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b test-branch update-folder1 &&
> +       for MERGE_TREES in "base HEAD update-folder2" \
> +                          "update-folder1 update-folder2" \
> +                          "update-folder2"
> +       do
> +               # Clean up and remove on-disk files
> +               test_all_match git reset --hard HEAD &&
> +               test_sparse_match git sparse-checkout reapply &&
> +
> +               # Although the index matches, without --no-sparse-checkout, outside-of-
> +               # definition files will not exist on disk for sparse checkouts
> +               test_all_match git read-tree -mu $MERGE_TREES &&
> +               test_all_match git status --porcelain=v2 &&
> +               test_path_is_missing sparse-checkout/folder2 &&
> +               test_path_is_missing sparse-index/folder2 &&
> +
> +               test_all_match git read-tree --reset -u HEAD &&
> +               test_all_match git status --porcelain=v2 &&
> +
> +               test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
> +               test_all_match git status --porcelain=v2 &&
> +               test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
> +               test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
> +       done
> +'
> +
> +test_expect_success 'read-tree --merge with edit/edit conflicts in sparse directories' '
> +       init_repos &&
> +
> +       # Merge of multiple changes to same directory (but not same files) should
> +       # succeed
> +       test_all_match git read-tree -mu base rename-base update-folder1 &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset --hard &&
> +
> +       test_all_match git read-tree -mu rename-base update-folder2 &&
> +       test_all_match git status --porcelain=v2 &&
> +
> +       test_all_match git reset --hard &&
> +
> +       test_all_match test_must_fail git read-tree -mu base update-folder1 rename-out-to-in &&
> +       test_all_match test_must_fail git read-tree -mu rename-out-to-in update-folder1
> +'
> +
> +test_expect_success 'read-tree --prefix outside sparse definition' '
> +       init_repos &&
> +
> +       # Cannot read-tree --prefix with a single argument when files exist within
> +       # prefix

Given the comments in the cover letter about --prefix needing special
work, it's not clear to me whether the below is expected behavior or
current-but-buggy behavior that you are testing and documenting.
Could you clarify?

> +       test_all_match test_must_fail git read-tree --prefix=folder1/ -u update-folder1 &&
> +
> +       test_all_match git read-tree --prefix=folder2/0 -u rename-base &&
> +       test_path_is_missing sparse-checkout/folder2 &&
> +       test_path_is_missing sparse-index/folder2 &&
> +
> +       test_all_match git read-tree --reset -u HEAD &&
> +       test_all_match git read-tree --prefix=folder2/0 -u --no-sparse-checkout rename-base &&
> +       test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
> +       test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
> +'
> +
> +test_expect_success 'read-tree --merge with directory-file conflicts' '
> +       init_repos &&
> +
> +       test_all_match git checkout -b test-branch rename-base &&
> +
> +       # Although the index matches, without --no-sparse-checkout, outside-of-
> +       # definition files will not exist on disk for sparse checkouts
> +       test_sparse_match git read-tree -mu rename-out-to-out &&
> +       test_sparse_match git status --porcelain=v2 &&
> +       test_path_is_missing sparse-checkout/folder2 &&
> +       test_path_is_missing sparse-index/folder2 &&
> +
> +       test_sparse_match git read-tree --reset -u HEAD &&
> +       test_sparse_match git status --porcelain=v2 &&
> +
> +       test_sparse_match git read-tree -mu --no-sparse-checkout rename-out-to-out &&
> +       test_sparse_match git status --porcelain=v2 &&
> +       test_cmp sparse-checkout/folder2/0/1 sparse-index/folder2/0/1
> +'
> +
>  test_expect_success 'merge, cherry-pick, and rebase' '
>         init_repos &&
>
> --
> gitgitgadget
>
