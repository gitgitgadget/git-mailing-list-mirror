Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDDC7EE24
	for <git@archiver.kernel.org>; Mon,  5 Jun 2023 19:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbjFETQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235349AbjFETQW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 15:16:22 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA53114
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 12:16:18 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-53f9a376f3eso4631575a12.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 12:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1685992578; x=1688584578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QbeEKTbXZSd5ySGnfYVkfDEuWY+j5ppJfSK0XOjxFCA=;
        b=EDyzNtd6DR2Wbjg849BSApGb7WIiq9tQDHIW5rhgnWY7TUiP5M3M0RpYS+wv5/dCU7
         DTKPijkf1j1pTksQ1RZey7IVcT3z5AKzfnBR+xgWzAE3JYCXfyp/Mk+QPnNspZQIn+YM
         K7TpMhKq2gQh1hiOtKQJDLuH3/LMiPmSCUNyxl2VEL/SncOK8NljLdiFYY9bHmGV1t4h
         0o+D+/HTfdmGD+D+RVK8Cl7gxO4HSPdVnClAm+iugejV4jG4LvwRiMmGxCeAjPWgQzyM
         PVqBILUX8SL6R8XjcPcORzOIHrcYv1sYlxBn7SmtqanQ4nwn65hPmFutmADO7R0JZz6Z
         bRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685992578; x=1688584578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QbeEKTbXZSd5ySGnfYVkfDEuWY+j5ppJfSK0XOjxFCA=;
        b=RsB6H1O98pZPYmkGlUkATpK908ARRcYlNBRw7+2tPr/+YRYybIU8+Hzar/Y0tqpcZV
         xyj35YP0WkDjPSe4vsYtHj4J/2pvnvi81lOtQp3SmLYmWKosaylpN012FllHe090RGZu
         qHClgD7N06iUKc//ecBn7Mm0NzGOgjpqG34bzo34dcFqEOQNOjsYBholj9UF+RKHMYAi
         ZM7Kq+1ef3GMkQOoU0B/ycrjhLz0Aq0UvO09Xz1gOQOUALueOnBrUK3S1aN2PK3nHBL8
         RkiezL7iaXMNrCy9rSfM//imA6RUZ5yc3cZ00YB0TcT/BWpFESH0qB2xMS6n9z3iKrT3
         N/AA==
X-Gm-Message-State: AC+VfDzEMMmOHCzXG9juBB+znR6kzMZbfGcWdQcIO5Yq/1E1elCMwko7
        fW9mcQJ8GULYljtTY4VDr49p
X-Google-Smtp-Source: ACHHUZ7XGGAJyKllCybR+i+yV2RX4OQW/m/AvPDRDZbzh0f8VeHgnwqnL81ZvrZCu28oejuUerOLVQ==
X-Received: by 2002:a17:903:11d0:b0:1a1:f5dd:2dce with SMTP id q16-20020a17090311d000b001a1f5dd2dcemr9941398plh.6.1685992578158;
        Mon, 05 Jun 2023 12:16:18 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id jj11-20020a170903048b00b001ac4e316b51sm6953359plb.109.2023.06.05.12.16.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:16:17 -0700 (PDT)
Message-ID: <773c2f7a-8637-ab0b-e0a8-ab553c90e88b@github.com>
Date:   Mon, 5 Jun 2023 12:16:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v1] worktree: integrate with sparse-index
To:     Shuqi Liang <cheskaqiqi@gmail.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com
References: <20230605161644.491424-1-cheskaqiqi@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230605161644.491424-1-cheskaqiqi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shuqi Liang wrote:
> The index is read in 'worktree.c' at two points:
> 
> 1.The 'validate_no_submodules' function, which checks if there are any
> submodules present in the worktree.
> 
> 2.The 'check_clean_worktree' function, which verifies if a worktree is
> 'clean', i.e., there are no untracked or modified but uncommitted files.
> This is done by running the 'git status' command, and an error message
> is thrown if the worktree is not clean. Given that 'git status' is
> already sparse-aware, the function is also sparse-aware.
> 
> Hence we can just set the requires-full-index to false for
> "git worktree".

Thanks for the detailed analysis! This lines up with my understanding of the
command as well; I'm glad the sparse index integration is so straightforward
here!

> 
> Add tests that verify that 'git worktree' behaves correctly when the
> sparse index is enabled and test to ensure the index is not expanded.
> 
> The `p2000` tests demonstrate a ~20% execution time reduction for
> 'git worktree' using a sparse index:
> 
> (Note:the p2000 test results did't reflect the huge speedup because of

s/did't/didn't

(not worth fixing if you don't end up re-rolling, though!)

> the index reading time is minuscule comparing to the filesystem
> operations.)
> 
> Test                                       before  after
> -----------------------------------------------------------------------
> 2000.102: git worktree add....(full-v3)    3.15    2.82  -10.5%
> 2000.103: git worktree add....(full-v4)    3.14    2.84  -9.6%
> 2000.104: git worktree add....(sparse-v3)  2.59    2.14  -16.4%
> 2000.105: git worktree add....(sparse-v4)  2.10    1.57  -25.2%
> 
> Helped-by: Victoria Dye <vdye@github.com>
> Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
> ---
>  builtin/worktree.c                       |  4 ++++
>  t/perf/p2000-sparse-operations.sh        |  1 +
>  t/t1092-sparse-checkout-compatibility.sh | 23 +++++++++++++++++++++++
>  3 files changed, 28 insertions(+)
> 
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index f3180463be..db14bff1a3 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -1200,5 +1200,9 @@ int cmd_worktree(int ac, const char **av, const char *prefix)
>  		prefix = "";
>  
>  	ac = parse_options(ac, av, prefix, options, git_worktree_usage, 0);
> +
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
>  	return fn(ac, av, prefix);
>  }
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 901cc493ef..1422136c73 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -131,5 +131,6 @@ test_perf_on_all git describe --dirty
>  test_perf_on_all 'echo >>new && git describe --dirty'
>  test_perf_on_all git diff-files
>  test_perf_on_all git diff-files -- $SPARSE_CONE/a
> +test_perf_on_all "git worktree add ../temp && git worktree remove ../temp"

This, like the 'git stash' performance tests, involves multiple steps to
ensure we return to a clean state after the test is executed. Makes sense.

>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index a63d0cc222..6ed691d338 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2180,4 +2180,27 @@ test_expect_success 'sparse index is not expanded: diff-files' '
>  	ensure_not_expanded diff-files -- "deep/*"
>  '
>  
> +test_expect_success 'worktree' '
> +	init_repos &&
> +
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>"$1"
> +	EOF
> +
> +	test_all_match git worktree add .worktrees/hotfix &&
> +	test_sparse_match ls .worktrees/hotfix &&

I see why you're comparing 'sparse-checkout' to 'sparse-index' here (their
worktrees should both contain only the files matched by the sparse-checkout
patterns, unlike 'full-checkout' which will contain all files), but this
won't catch bugs that apply to both sparse-checkout and sparse-index (e.g.,
if the sparse checkout patterns weren't applied and the full worktrees were
checked out). 

To make sure that doesn't happen, you could add a section that compares each 
test repo's default worktree to a new worktree, e.g.:

	for repo in full-checkout sparse-checkout sparse-index
	do
		worktree=${repo}-wt &&
		git -C $repo worktree add $worktree &&
		
		# Compare worktree content with 'ls'

		# Compare index content with 'ls-files --sparse'

		# Any other comparisons that are useful
		
		git worktree remove $worktree || return 1
	done

> +	test_all_match git worktree remove .worktrees/hotfix &&
> +
> +	test_all_match git worktree add .worktrees/hotfix &&
> +	run_on_all ../edit-contents .worktrees/hotfix/deep/a &&
> +	test_all_match test_must_fail git worktree remove .worktrees/hotfix
> +'
> +
> +test_expect_success 'worktree is not expanded' '
> +	init_repos &&
> +
> +	test_all_match git worktree add .worktrees/hotfix &&

Shouldn't 'git worktree add' not expand the index? Why use 'test_all_match'
instead of 'ensure_not_expanded'?

> +	ensure_not_expanded worktree remove .worktrees/hotfix> +'
> +
>  test_done

