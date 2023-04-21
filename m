Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586B3C77B76
	for <git@archiver.kernel.org>; Fri, 21 Apr 2023 21:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjDUVmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Apr 2023 17:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDUVmi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2023 17:42:38 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158461BC1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:42:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b73203e0aso16953265b3a.1
        for <git@vger.kernel.org>; Fri, 21 Apr 2023 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1682113356; x=1684705356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0VcyOlTVx99fvyZe0fa8TcqMHN0v6Kn3x8LU+rz580=;
        b=NhTYPVMN342myWy+EO+XI6AEQcZFHog26XDmtlYk369uS0bg666ApIWsPHuZmO5HlS
         MowfPNPIH4sjGyHtSHMAsiGgE15wGOmoxYP1N4hFoiNcgOMaJnpDxopb6qlj7hzi3sty
         BIm8dV1FVcK/T4vVEBMYZ6QjEqcShLLQFFIoyqSlhSmU3RfxskCr/WfdZO8u1ko7Bxny
         e7qhiG2AFgt71ZGm2Tl0nAAFoJEB8h9qy7aLp8cvU9fugkWgEKekG+7kVVeJ9+Ie9yyJ
         cL/ECRADM9bzuWwPypdbz9/01DLowQZEV7ysz6K0nh/PatpsrKR/h5GFgXsJxxMb/iCR
         p5Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682113356; x=1684705356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0VcyOlTVx99fvyZe0fa8TcqMHN0v6Kn3x8LU+rz580=;
        b=PDOm/bVfHm1YCsul49mFBHaVGPo4It//BRoOwB+5JIoy8sro/YHTa6xYS2j+svREa2
         TIpJdGFVNMu3BMnVKasuHkLs/M+ylu81MNdUInDcKOu++cmUUoJV5oBNd0XIdOieJLSm
         2huVdUaSDNUfQScDJNk+u50XU/Jp1XyGOncKS/bgT5QDce558lUugFvD7ERWqMoirXgQ
         a04N25qi3E3dLuL0pJU7FZARKeegkIXNgYekf6f+fNgP8K4FIsSMNtmUtBT4ZbQ/gx5O
         xFxAhLNhzJy0UBs+zvJ3LsPx6kIXX7H3rjKXJOaOfzTDN+cwG93WGr99ob6tw6gCLAv9
         2c2w==
X-Gm-Message-State: AAQBX9cbKq2TcK7fHrkZiisMdzb4rMwz6gMM+yeCF9ojhPoJrK57xq43
        1a1XEiiA4oTILYZs7JhVyqc3bK1JipWNyyEUIQ==
X-Google-Smtp-Source: AKy350YrpZjZc/85PG5Y5g2zZfrErKHWMvaxPp3Fw3CeC1+8xN8cfGjGNrnpGUQ7Y2uWvNiMk1i07w==
X-Received: by 2002:a17:90b:a04:b0:244:d441:8f68 with SMTP id gg4-20020a17090b0a0400b00244d4418f68mr12702266pjb.16.1682113356480;
        Fri, 21 Apr 2023 14:42:36 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id dw3-20020a17090b094300b00233df90227fsm4910449pjb.18.2023.04.21.14.42.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 14:42:36 -0700 (PDT)
Message-ID: <8b2a754c-6162-54d9-e9ba-fd994058066c@github.com>
Date:   Fri, 21 Apr 2023 14:42:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v4] write-tree: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230419072148.4297-1-cheskaqiqi@gmail.com>
 <20230421004108.32554-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230421004108.32554-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> Update 'git write-tree' to allow using the sparse-index in memory
> without expanding to a full one.
> 
> The recursive algorithm for update_one() was already updated in 2de37c5
> (cache-tree: integrate with sparse directory entries, 2021-03-03) to
> handle sparse directory entries in the index. Hence we can just set the
> requires-full-index to false for "write-tree".
> 
> The `p2000` tests demonstrate a ~96% execution time reduction for 'git
> write-tree' using a sparse index:
> 
> Test                                           before  after
> -----------------------------------------------------------------
> 2000.78: git write-tree (full-v3)              0.34    0.33 -2.9%
> 2000.79: git write-tree (full-v4)              0.32    0.30 -6.3%
> 2000.80: git write-tree (sparse-v3)            0.47    0.02 -95.8%
> 2000.81: git write-tree (sparse-v4)            0.45    0.02 -95.6%

Please update your commit message to explain only the incremental updates on
top of 1a65b41b38a (write-tree: integrate with sparse index, 2023-04-03);
that patch's message (what you have here) does not accurately describe what
_this_ patch is doing.

> diff --git a/builtin/write-tree.c b/builtin/write-tree.c
> index 32e302a813..a9d5c20cde 100644
> --- a/builtin/write-tree.c
> +++ b/builtin/write-tree.c
> @@ -38,12 +38,15 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
>  	};
>  
>  	git_config(git_default_config, NULL);
> +	
> +	if (the_repository->gitdir) {
> +		prepare_repo_settings(the_repository);
> +		the_repository->settings.command_requires_full_index = 0;
> +	}
> +
>  	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
>  			     write_tree_usage, 0);
>  
> -	prepare_repo_settings(the_repository);
> -	the_repository->settings.command_requires_full_index = 0;
> -

What is the functional benefit of this change? AFAICT, we don't need
'command_requires_full_index' to be set before 'parse_options' in this case,
so this won't have any effect on the behavior of 'write-tree'.

> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 9bbc0d646b..d3eb31326b 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,22 +2055,32 @@ test_expect_success 'grep sparse directory within submodules' '
>  	test_cmp actual expect
>  '
>  
> -test_expect_success 'write-tree on all' '
> +test_expect_success 'write-tree' '
>  	init_repos &&
>  
> +	test_all_match git write-tree &&
> +
>  	write_script edit-contents <<-\EOF &&
>  	echo text >>"$1"
>  	EOF
>  
> +	# make a change inside the sparse cone
>  	run_on_all ../edit-contents deep/a &&
> -	run_on_all git update-index deep/a &&
> +	test_all_match git update-index deep/a &&
>  	test_all_match git write-tree &&
> +	test_all_match git status --porcelain=v2 &&
>  
> +	# make a change outside the sparse cone
>  	run_on_all mkdir -p folder1 &&
>  	run_on_all cp a folder1/a &&
>  	run_on_all ../edit-contents folder1/a &&
> -	run_on_all git update-index folder1/a &&
> -	test_all_match git write-tree
> +	test_all_match git update-index folder1/a &&
> +	test_all_match git write-tree &&
> +	test_all_match git status --porcelain=v2 &&
> +	
> +	# check that SKIP_WORKTREE files are not materialized
> +	test_path_is_missing sparse-checkout/folder2/a &&
> +	test_path_is_missing sparse-index/folder2/a

Test updates look good!

>  '
>  
>  test_expect_success 'sparse-index is not expanded: write-tree' '
> @@ -2080,7 +2090,7 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
>  
>  	echo "test1" >>sparse-index/a &&
>  	git -C sparse-index update-index a &&
> -	ensure_not_expanded write-tree
> +	ensure_not_expanded write-tree 

nit: trailing whitespace should be removed

>  '
>  
>  test_done

