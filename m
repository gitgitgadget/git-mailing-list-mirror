Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C67C433FE
	for <git@archiver.kernel.org>; Mon, 16 May 2022 21:01:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348922AbiEPVBr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349471AbiEPVBW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 17:01:22 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10174FC64
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:38:30 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n8so15567689plh.1
        for <git@vger.kernel.org>; Mon, 16 May 2022 13:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MrX8yONeUCi3ZOxXHu6dfrbvWrCQmD4DHpjt/E0Kzjs=;
        b=jl7MKfC//R4/r9Wt+UXI2zM+P5iFu6bis+B0U4DgsjWhdrpIiouVsZXwRqJGAxnEzE
         EBj4VZw/c0AfPR12XaRpOvuqOqX+eSn7DNNliqmNNFCwN/u+IOHkckfwHmiP4Oi0zrbK
         C3+vOdahYnF/rct4Voo0XyObpc2yhjVjczZm+NC+rnUVvsCaDqF5V0r8/YNpj7MMTs1H
         N/jcmIqk0CYCZEl3Zv4+qo51lsXjUnnhXvH9WoSL09AcacldUuuCfsGxASiQc1cfskki
         atPUvOb8ttp7rJ7A2tvoed1+D4Kigpp7WXDOJNLuNDLpOWjWivsPNtDIJwxEM34z30BW
         BiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MrX8yONeUCi3ZOxXHu6dfrbvWrCQmD4DHpjt/E0Kzjs=;
        b=R5Q3lSfzIMa2pk69HPd4dGc3v0osA1JaXX4QQL1Cf+fA2RXCbRMo939G61iTR9a0H8
         msU4sjqfUOaBbJAvnEG7bulBl7WF7AeKhn8ILj7PbJ/ltZV2DdTcH4Hflknr60zRxCQ1
         Kw+mky+ioSMVeMmBUyJG8LHzx3OvKszDGV00qXSOTcJWTPCzisXp4bNOCMPLD07I+2n3
         +4pO1HmchSnXSp2CLbFxwUV2bEZ0NMQyCzjxYroLbYIKH+hmj1hw4Mcf1mwHQtiDZhJJ
         cLaFTJrGxI7sgihiRS/I1k2jRJcYxBVN8jDquWI5tgDMqtst5VEquQP5LqOgh8EN0XuR
         dY5w==
X-Gm-Message-State: AOAM531DToKbKBRygj0OzFghzBj2Icag42eN6gc35Gg2ZyZtLl2I4BWU
        70jU/FWEYMIBAZ0V1AxMki08
X-Google-Smtp-Source: ABdhPJwnIOCZjudG6/UMU5wHx9oNj8ATbOle7KM+m8vXVkpQzg0q8pQx/KjhY5W5NWZtM9KAfNVmZQ==
X-Received: by 2002:a17:902:c409:b0:15e:bdd3:1fa3 with SMTP id k9-20020a170902c40900b0015ebdd31fa3mr19224583plk.67.1652733510475;
        Mon, 16 May 2022 13:38:30 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id n17-20020a17090ac69100b001df7612950dsm130267pjt.7.2022.05.16.13.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 13:38:30 -0700 (PDT)
Message-ID: <9191a98c-087a-39b9-cff3-eb7eccd198ea@github.com>
Date:   Mon, 16 May 2022 13:38:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH 8/8] sparse-checkout: integrate with sparse index
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <b8a349c6deeb4b970075629d0c292b2ae9f7d0d3.1652724693.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <b8a349c6deeb4b970075629d0c292b2ae9f7d0d3.1652724693.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When modifying the sparse-checkout definition, the sparse-checkout
> builtin calls update_sparsity() to modify the SKIP_WORKTREE bits of all
> cache entries in the index. Before, we needed the index to be fully
> expanded in order to ensure we had the full list of files necessary that
> match the new patterns.
> 
> Insert a call to reset_sparse_directories() that expands sparse
> directories that are within the new pattern list, but only far enough
> that every necessary file path now exists as a cache entry. The
> remaining logic within update_sparsity() will modify the SKIP_WORKTREE
> bits appropriately.
> 
> This allows us to disable command_requires_full_index within the
> sparse-checkout builtin. Add tests that demonstrate that we are not
> expanding to a full index unnecessarily.
> 
> We can see the improved performance in the p2000 test script:
> 
> Test                           HEAD~1            HEAD
> ------------------------------------------------------------------------
> 2000.24: git ... (sparse-v3)   2.14(1.55+0.58)   1.57(1.03+0.53) -26.6%
> 2000.25: git ... (sparse-v4)   2.20(1.62+0.57)   1.58(0.98+0.59) -28.2%
> 
> These reductions of 26-28% are small compared to most examples, but the
> time is dominated by writing a new copy of the base repository to the
> worktree and then deleting it again. The fact that the previous index
> expansion was such a large portion of the time is telling how important
> it is to complete this sparse index integration.
> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/sparse-checkout.c                |  3 +++
>  t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++++
>  unpack-trees.c                           |  4 ++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index cbff6ad00b0..0157b292b36 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -937,6 +937,9 @@ int cmd_sparse_checkout(int argc, const char **argv, const char *prefix)
>  
>  	git_config(git_default_config, NULL);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
>  	if (argc > 0) {
>  		if (!strcmp(argv[0], "list"))
>  			return sparse_checkout_list(argc, argv);
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 93bcfd20bbc..614357fc48c 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1552,6 +1552,31 @@ test_expect_success 'ls-files' '
>  	ensure_not_expanded ls-files --sparse
>  '
>  
> +test_expect_success 'sparse index is not expanded: sparse-checkout' '
> +	init_repos &&
> +
> +	ensure_not_expanded sparse-checkout set deep/deeper2 &&
> +	ensure_not_expanded sparse-checkout set deep/deeper1 &&
> +	ensure_not_expanded sparse-checkout set deep &&
> +	ensure_not_expanded sparse-checkout add folder1 &&
> +	ensure_not_expanded sparse-checkout set deep/deeper1 &&
> +	ensure_not_expanded sparse-checkout set folder2 &&
> +
> +	# Demonstrate that the checks that "folder1/a" is a file
> +	# do not cause a sparse-index expansion (since it is in the
> +	# sparse-checkout cone).
> +	echo >>sparse-index/folder2/a &&
> +	git -C sparse-index add folder2/a &&
> +
> +	ensure_not_expanded sparse-checkout add folder1 &&
> +
> +	# Skip checks here, since deep/deeper1 is inside a sparse directory
> +	# that must be expanded to check whether `deep/deeper1` is a file
> +	# or not.
> +	ensure_not_expanded sparse-checkout set --skip-checks deep/deeper1 &&
> +	ensure_not_expanded sparse-checkout set
> +'
> +

These tests look good for ensuring sparsity is preserved, but it'd be nice
to also have some "stress tests" of 'sparse-checkout (add|set)'. The purpose
would be to make sure the index has the right contents for various types of
pattern changes, e.g. running 'sparse-checkout (add|set) <path>', then
verifying index contents with 'ls-files --sparse'. Paths might be:

- in vs. out of (current) cone
- match an existing vs. nonexistent directory

etc.

>  # NEEDSWORK: a sparse-checkout behaves differently from a full checkout
>  # in this scenario, but it shouldn't.
>  test_expect_success 'reset mixed and checkout orphan' '
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 7f528d35cc2..9745e0dfc34 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -18,6 +18,7 @@
>  #include "promisor-remote.h"
>  #include "entry.h"
>  #include "parallel-checkout.h"
> +#include "sparse-index.h"
>  
>  /*
>   * Error messages expected by scripts out of plumbing commands such as
> @@ -2018,6 +2019,9 @@ enum update_sparsity_result update_sparsity(struct unpack_trees_options *o)
>  			goto skip_sparse_checkout;
>  	}
>  
> +	/* Expand sparse directories as needed */
> +	expand_to_pattern_list(o->src_index, o->pl);
> +
>  	/* Set NEW_SKIP_WORKTREE on existing entries. */
>  	mark_all_ce_unused(o->src_index);
>  	mark_new_skip_worktree(o->pl, o->src_index, 0,

