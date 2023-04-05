Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787FEC7619A
	for <git@archiver.kernel.org>; Wed,  5 Apr 2023 17:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjDERbn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Apr 2023 13:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDERbm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Apr 2023 13:31:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4735BA1
        for <git@vger.kernel.org>; Wed,  5 Apr 2023 10:31:39 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ml21so12757028pjb.4
        for <git@vger.kernel.org>; Wed, 05 Apr 2023 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680715898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QIEC+Vqv0IgRZZugZqn3f8Tp6Z+52LjBS/UGIOkXcKs=;
        b=L6JVA7QuWoFH3Th2Owv3zxekqLNYVmADr0jzbPtsYTvZ8u90ZX+flJMD5t6XgCRwsh
         8PPTQM7qQOyIr/2d2vETGydq5zAgXgL1691m7uEcS1wFXQU2PpR206GL3KULxc2ecoY/
         4IqX1R8GWbidCObqqNfjvlvk7C1GpcZLj7Go1r1RUbLD2MpjwsAPXavg8GpuRLfnfZcU
         sxYSufkzt1wMtMcJM8cS7fCJYZCrYdqpkyG6nWLeTI+PaOyLWkwNrJZ8LW978R20Tkw/
         6ir2GCat5f+4QiulnE0JU9DWnu/Guo0WWInfBcW1VGxmnuDFUSI1X+Xw4EsHEQLQMeN2
         GAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680715898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QIEC+Vqv0IgRZZugZqn3f8Tp6Z+52LjBS/UGIOkXcKs=;
        b=7lfFdegiXquWQQgaD6fzDYapGhC/u9mhu5J7hbot1ufF4JZ2u2AQFOFxQem3oP2+ks
         z90CFoMdHTcNwBupaPBSmmvje7pIcuvp3L56QIPdngm9Kp3rp1mYYKblloSn7dCYIibA
         yh678Zbl2qXrwFRt2pOA75tCrf9b4FM7TCbrOcdksAxkhEl9eSSVdoMcc7+b3PJPza8N
         bIJIx/GlumFBGaYWcYdLxF3/MpM7koaS89CA/oNbdWLby2UxrSf1fimLQD1XcwSWYYgk
         XdVXADlCwffghTkYd6J4gikNdIgbOj0IXkEeelEcTNoArW5u10+nBwZy4FO6Wscj9fhk
         ejcw==
X-Gm-Message-State: AAQBX9es2I0fMif8xPjSKgUGRsP00zSuqEVBRfVUMa+EZFBPlTDmaNsH
        wcMFf8fttgNblTb6Ts1xmOiL
X-Google-Smtp-Source: AKy350Y7d499qaNbdfLyV8osQcPi27hdE0SlzOxpfRb/rCYKdORpmYlH400MZxFmcRzI6pCrCsw6cQ==
X-Received: by 2002:a17:90a:46c2:b0:240:40ac:bed9 with SMTP id x2-20020a17090a46c200b0024040acbed9mr3225705pjg.20.1680715898609;
        Wed, 05 Apr 2023 10:31:38 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090ab10a00b00233b18e6fb3sm1668350pjq.1.2023.04.05.10.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 10:31:38 -0700 (PDT)
Message-ID: <9d0309bd-943c-dd51-97cf-59721eda78f7@github.com>
Date:   Wed, 5 Apr 2023 10:31:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2] write-tree: integrate with sparse index
Content-Language: en-US
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230402000117.313171-1-cheskaqiqi@gmail.com>
 <20230404003539.1578245-1-cheskaqiqi@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230404003539.1578245-1-cheskaqiqi@gmail.com>
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
> 
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
> 
> * change the position of "settings.command_requires_full_index = 0"

Could you describe why you made this change? You don't need to re-roll, but
in the future please make sure to describe the reasoning for changes like
this in these version notes if the context can't be gathered from other
discussions in the thread. 

> 
> Range-diff against v1:
> 1:  d8a9ccd0b3 ! 1:  8873c79759 write-tree: integrate with sparse index
>     @@ Commit message
>      
>       ## builtin/write-tree.c ##
>      @@ builtin/write-tree.c: int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
>     - 	};
>     - 
>     - 	git_config(git_default_config, NULL);
>     -+	
>     -+	prepare_repo_settings(the_repository);
>     -+	the_repository->settings.command_requires_full_index = 0;
>     -+
>       	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
>       			     write_tree_usage, 0);
>       
>     ++	prepare_repo_settings(the_repository);
>     ++	the_repository->settings.command_requires_full_index = 0;
>     ++	
>     + 	ret = write_cache_as_tree(&oid, flags, tree_prefix);
>     + 	switch (ret) {
>     + 	case 0:
>      
>       ## t/perf/p2000-sparse-operations.sh ##
>      @@ t/perf/p2000-sparse-operations.sh: test_perf_on_all git checkout-index -f --all
> 
> 
>  builtin/write-tree.c                     |  3 +++
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 28 ++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/builtin/write-tree.c b/builtin/write-tree.c
> index 45d61707e7..4492da0912 100644
> --- a/builtin/write-tree.c
> +++ b/builtin/write-tree.c
> @@ -38,6 +38,9 @@ int cmd_write_tree(int argc, const char **argv, const char *cmd_prefix)
>  	argc = parse_options(argc, argv, cmd_prefix, write_tree_options,
>  			     write_tree_usage, 0);
>  
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +	
>  	ret = write_cache_as_tree(&oid, flags, tree_prefix);
>  	switch (ret) {
>  	case 0:
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a..9924adfc26 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -125,5 +125,6 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git write-tree 
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..3b8191b390 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2055,4 +2055,32 @@ test_expect_success 'grep sparse directory within submodules' '
>  	test_cmp actual expect
>  '
>  
> +test_expect_success 'write-tree on all' '

It's not clear what "on all" means in this context. If it's "write-tree with
changes both inside and outside the cone", then please either make that
explicit in the test name or simplify the name to just 'write-tree' (like
'clean').

> +	init_repos &&

It would be nice to have a baseline 'test_all_match git write-tree' before
making any changes to the index (as you do in the 'sparse-index is not
expanded: write-tree' test). 

> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	run_on_all ../edit-contents deep/a &&
> +	run_on_all git update-index deep/a &&
> +	test_all_match git write-tree &&

First you make a change inside the sparse cone and 'write-tree'...

> +
> +	run_on_all mkdir -p folder1 &&
> +	run_on_all cp a folder1/a &&
> +	run_on_all ../edit-contents folder1/a &&
> +	run_on_all git update-index folder1/a &&
> +	test_all_match git write-tree

...then make a change outside the cone and 'write-tree' again. Makes sense.

However, there isn't any test of the working tree after 'write-tree' exits.
For example, I'd be interested in seeing a comparison of the output of 'git
status --porcelain=v2', as well as ensuring that SKIP_WORKTREE files weren't
materialized on disk in 'sparse-checkout' and 'sparse-index' (e.g.,
'folder2/a' shouldn't exist).

It also wouldn't hurt to 'test_all_match' on the 'git update-index' calls,
but I don't feel too strongly either way.

> +'
> +
> +test_expect_success 'sparse-index is not expanded: write-tree' '
> +	init_repos &&
> +
> +	ensure_not_expanded write-tree &&
> +
> +	echo "test1" >>sparse-index/a &&
> +	git -C sparse-index update-index a &&
> +	ensure_not_expanded write-tree 

This also looks good. 

> +'
> +
>  test_done

