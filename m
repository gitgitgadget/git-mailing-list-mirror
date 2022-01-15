Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE02C433F5
	for <git@archiver.kernel.org>; Sat, 15 Jan 2022 01:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiAOBvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 20:51:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiAOBvG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 20:51:06 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EBBC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 17:51:06 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id 15so11773750qvp.12
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 17:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RbjUcBFgEYixWCRWNXfJF4xpchCQmqLmCjMhwtf8GzE=;
        b=e8OKLJrprwyOaabmMePVy5cA3iRh+FbHMP4oTx+2aoEqo3LblFaILLmosOOLpAee8K
         +yYskgVZSLAu8OaYxGtvmCmx/lDhGKVSmWTvVtlushJcf97cIuiwtTXeRr+Y1bGbrUUU
         dt2D1z9zs911JcTVBZ4FPICW/Gxdh4/JjG7mNxF27UN/ulpdHlCLreIokkZmAVOU7GND
         PPddod8kdh5c7umkbnZQk9VLngHuSUucwgXdEAjIrnY6Lp+Ih5P9H3f6WXHwTE5B5Csa
         0Aw8hNqAZs/TGkPkklJeIy6EVA7MrYGHJyPiN58Yijj35C+ZPxssZBvYWmz/4baEoyza
         0keA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RbjUcBFgEYixWCRWNXfJF4xpchCQmqLmCjMhwtf8GzE=;
        b=fpNQZLhXgZ8xofOD9KhjFRqWu5s4xc0Q5s4eD0btTr0GE6SJiX3rPZmY0e2hQUDmio
         GiVHh7QJmDncfkAHLlQfbAV00TuYiP4f0SwKYLGGDvhmJkGCLYSnnHLYN7q/eoCY05G6
         JmRiBMONcEfRAOji1758cOzPmpVBl69PmCOnURUKtx59WKrfRbkRmKR047xge/yJGnZb
         R242/OCpt8b570B78QVxrXucTlFOycjStDQ9U09JlsY3VFI4z2ovjjTBVgedjLRqjdba
         RKXBJVXEI3qj58LEvSjI4nxFwspirwINn1FkxvNKtGjWw/ekc22c4tXANLQWxcfwaoJQ
         H0VQ==
X-Gm-Message-State: AOAM5310Bzt72xuIZ0R/Woym8iBBibG6O0YkGa2/UoV2lXPRQGeNeltO
        Y0KcBgM/I8/zNScbp8xnHHBu
X-Google-Smtp-Source: ABdhPJwdRB0BFvCxMW8Oeto17dLpg0Nh7/PdZ9LO5qB1lxrteHg17DracFi02KF4YECEM51T3CcSdA==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr10522967qvs.69.1642211464344;
        Fri, 14 Jan 2022 17:51:04 -0800 (PST)
Received: from [192.168.1.45] (ool-2f1286a2.dyn.optonline.net. [47.18.134.162])
        by smtp.gmail.com with ESMTPSA id l15sm4998227qtx.20.2022.01.14.17.51.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 17:51:03 -0800 (PST)
Message-ID: <14b6dbeb-5a12-3ac0-9a0e-9cf2c3a381fe@github.com>
Date:   Fri, 14 Jan 2022 20:51:03 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v2 0/5] Remove the present-despite-SKIP_WORKTREE class of
 bugs (for sparse-checkouts)
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1114.git.1642092230.gitgitgadget@gmail.com>
 <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1114.v2.git.1642175983.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren via GitGitGadget wrote:
> (Maintainer note: This series builds on (v2 of) vd/sparse-clean-etc, because
> it tweaks one of the testcases added there.)
> 
> (Note 2: There was a previous RFC round of this series at
> https://lore.kernel.org/git/20220109045732.2497526-1-newren@gmail.com/.)
> 
> Files in the present-despite-SKIP_WORKTREE state have caused no ends of
> discussions and bugs[1,2,3,4,5,6,...and lots of others]. Trying to address
> the big issue of discovering & recovering from this state has befuddled me
> for over a year because I was worried we'd need additional code at every
> skip_worktree-checking path in the code (and they are all over the place),
> and that we'd make the code significantly slower unless we plumbed a bunch
> of additional information all over the place to allow some reasonable
> optimizations.
> 
> This series tries to solve the problem a bit differently by automatic early
> discovery and recovery; as a result, it greatly simplifies the landscape,
> reduces our testing matrix burden, and fixes a large swath of bugs. And I
> figured out how to get the perf cost down to essentially negligible.
> 
> Changes since v1 (or v2 if you count RFC as v1):
> 
>  * now includes some fixes for testcases from
>    ds/fetch-pull-with-sparse-index (which topic marked its own new tests as
>    potentially suboptimal; with my series, the sparse behavior now matches
>    the full tree behavior on that test. Wahoo!). Note that Junio's version
>    of vd/sparse-clean-etc already includes ds/fetch-pull-with-sparse-index,
>    so no need to merge in anything extra.
> 
> Changes since RFC version:
> 
>  * updated the commit messages as per suggestions from Victoria, including
>    adding performance measurements
>  * renamed the new function to use a clearer name
>  * replaced the final patch with a different optimization, which is both
>    simpler and performs quite a bit better (the cost for my previous patch 5
>    was already decent in many cases, but had a few cases where the cost was
>    significant).
> 
> Quick overview:
> 
>  * Patches 1 & 2 add a test to demonstrate accidental deletion of
>    possibly-modified files, and then fix the bug.
>  * Patch 3 is the crux of this series; a small amount of code with a huge
>    commit message
>  * Patch 4 updates the documentation
>  * Patch 5 adds an optimization to reduce the performance impact of patch 3
> 
Betwee the RFC and this version, you've made the changes I was looking for
and answered any remaining questions I had. This series (including patches
1, 2, and 4 - I didn't have anything substantial to say/ask/add to those)
looks good to me.

Thank you for working on this!

> [1]
> https://lore.kernel.org/git/CABPp-BFnFpzwGC11TLoLs8YK5yiisA5D5-fFjXnJsbESVDwZsA@mail.gmail.com/
> [2]
> https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/
> [3]
> https://lore.kernel.org/git/pull.809.git.git.1592356884310.gitgitgadget@gmail.com/
> [4] commit 66b209b ("merge-ort: implement CE_SKIP_WORKTREE handling with
> conflicted entries", 2021-03-20) [5] commit ba359fd ("stash: fix stash
> application in sparse-checkouts", 2020-12-01) [6]
> https://lore.kernel.org/git/CABPp-BH9tju7WVm=QZDOvaMDdZbpNXrVWQdN-jmfN8wC6YVhmw@mail.gmail.com/
> 
> Elijah Newren (5):
>   t1011: add testcase demonstrating accidental loss of user
>     modifications
>   unpack-trees: fix accidental loss of user changes
>   repo_read_index: clear SKIP_WORKTREE bit from files present in
>     worktree
>   Update documentation related to sparsity and the skip-worktree bit
>   Accelerate clear_skip_worktree_from_present_files() by caching
> 
>  Documentation/git-read-tree.txt          | 12 +++-
>  Documentation/git-sparse-checkout.txt    | 76 ++++++++++++++----------
>  Documentation/git-update-index.txt       | 57 +++++++++++++-----
>  repository.c                             |  7 +++
>  sparse-index.c                           | 73 +++++++++++++++++++++++
>  sparse-index.h                           |  1 +
>  t/t1011-read-tree-sparse-checkout.sh     | 23 ++++++-
>  t/t1092-sparse-checkout-compatibility.sh | 41 ++++++-------
>  t/t3705-add-sparse-checkout.sh           |  2 +
>  t/t6428-merge-conflicts-sparse.sh        | 23 ++-----
>  t/t7012-skip-worktree-writing.sh         | 44 +++-----------
>  t/t7817-grep-sparse-checkout.sh          | 11 +++-
>  unpack-trees.c                           |  4 +-
>  13 files changed, 246 insertions(+), 128 deletions(-)
> 
> 
> base-commit: 48609de3bf32befb69c40c1a2595a98dac0448b4
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1114%2Fnewren%2Ffix-present-despite-skip-worktree-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1114/newren/fix-present-despite-skip-worktree-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1114
> 
> Range-diff vs v1:
> 
>  1:  c553d558c2f = 1:  d50d804af4e t1011: add testcase demonstrating accidental loss of user modifications
>  2:  1e3958576e2 = 2:  206c638fa90 unpack-trees: fix accidental loss of user changes
>  3:  b263cc75b7d ! 3:  11d46a399d2 repo_read_index: clear SKIP_WORKTREE bit from files present in worktree
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'update-index modi
>        
>        	# When skip-worktree is disabled (even on files outside sparse cone), file
>        	# is updated in the index
>      +@@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'ls-files' '
>      + 	test_cmp dense sparse &&
>      + 
>      + 	# Set up a strange condition of having a file edit
>      +-	# outside of the sparse-checkout cone. This is just
>      +-	# to verify that sparse-checkout and sparse-index
>      +-	# behave the same in this case.
>      ++	# outside of the sparse-checkout cone. We want to verify
>      ++	# that all modes handle this the same, and detect the
>      ++	# modification.
>      + 	write_script edit-content <<-\EOF &&
>      +-	mkdir folder1 &&
>      ++	mkdir -p folder1 &&
>      + 	echo content >>folder1/a
>      + 	EOF
>      +-	run_on_sparse ../edit-content &&
>      ++	run_on_all ../edit-content &&
>      + 
>      +-	# ls-files does not currently notice modified files whose
>      +-	# cache entries are marked SKIP_WORKTREE. This may change
>      +-	# in the future, but here we test that sparse index does
>      +-	# not accidentally create a change of behavior.
>      +-	test_sparse_match git ls-files --modified &&
>      +-	test_must_be_empty sparse-checkout-out &&
>      +-	test_must_be_empty sparse-index-out &&
>      ++	test_all_match git ls-files --modified &&
>      + 
>      + 	git -C sparse-index ls-files --sparse --modified >sparse-index-out &&
>      +-	test_must_be_empty sparse-index-out &&
>      ++	cat >expect <<-\EOF &&
>      ++	folder1/a
>      ++	EOF
>      ++	test_cmp expect sparse-index-out &&
>      + 
>      + 	# Add folder1 to the sparse-checkout cone and
>      + 	# check that ls-files shows the expanded files.
>      + 	test_sparse_match git sparse-checkout add folder1 &&
>      +-	test_sparse_match git ls-files --modified &&
>      ++	test_all_match git ls-files --modified &&
>      + 
>      + 	test_all_match git ls-files &&
>      + 	git -C sparse-index ls-files --sparse >actual &&
>       
>        ## t/t3705-add-sparse-checkout.sh ##
>       @@ t/t3705-add-sparse-checkout.sh: setup_sparse_entry () {
>  4:  c74ad19616e = 4:  0af00779128 Update documentation related to sparsity and the skip-worktree bit
>  5:  e68028ebe0a = 5:  05ac964e630 Accelerate clear_skip_worktree_from_present_files() by caching
> 

