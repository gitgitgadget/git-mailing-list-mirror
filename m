Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE45C77B6E
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 21:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjDMVOi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 17:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjDMVOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 17:14:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECDA172C
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:14:35 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id kh6so14783679plb.0
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681420475; x=1684012475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcZNp+HqsVfZFwgEso1JtSYobNWQhEDQwvBR3rQPNXA=;
        b=KLMvVnjGXGPfk9ky9XRSdy0aQ9u/elTahD9Tv/7OjjtdpoDkCRGuyQqafyPD0SKT5L
         FfHYAuBh+AMnuQTuXQlKyJf7i3oUOo8OqERExenbFhMFrBIeavto0u4EUHV2SEdY5kQC
         DXombx2Cx4fwG6YfguTJaxnnNBLp0Ln/4zBQd2l4J/Qux2e6xRSUrqpCEOkAGkHy6FYv
         rRvZyc51V9m8xUBRgEmX71OJVevgXysU30un7yz8r7+u/YnkCeufdVqL2hNcT/T9t/Zr
         6kh02yGoyuOmZFNIQ+xbHP3Qa2W9m3cnuO37Ul8xFG/eK7calCu/vbVyEZyGjEXbKYbT
         7yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681420475; x=1684012475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcZNp+HqsVfZFwgEso1JtSYobNWQhEDQwvBR3rQPNXA=;
        b=GBqIMwmX4W1rnQPHX1e73Mdlqn7iryLQH1n5147pKSf3sQkDtETGDhde5wBOpFtCtA
         5RKr7JcDzk1ZWUt85D5L2uOSZZEWZ/6Ov3xipGuyPyZgi7vB1Jkh139eN4HiYruicaD5
         BNc+CDM+3RVi0ak3wQuWkW8T9gYDXZVsmVTRwvc8+vEx3LfqYi7xUxCQE3JWeMagCrc8
         e6QKO26cesHD9MYBfEvk2fkC+X0c7Rlrvouxf16UP4sK6O1DB8htNWJNscnMI5Nae/FW
         Tz6Q5k60Rl6mNNHkqjKcKw0zQ4pdaicWdQ1STbth5Xl9ifDw/6mThxst+L/4AxhMj8yQ
         1Z0Q==
X-Gm-Message-State: AAQBX9dIM+oJdUhpjmmFLrFkg5qJnhTF0eL/3HHmR1x+Cajxi/toj7E4
        QqTrb2q9o6uNKGLWYp1anbZj
X-Google-Smtp-Source: AKy350aCZ4v68bka0WAcCfKTsYvBvB4Ai3xz9CksVQ5T84TL07vh8Y60qZ7MTXHb+pAECU/+1Z93gA==
X-Received: by 2002:a17:902:7fc3:b0:1a4:ee94:a7a4 with SMTP id t3-20020a1709027fc300b001a4ee94a7a4mr287151plb.41.1681420475238;
        Thu, 13 Apr 2023 14:14:35 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id i12-20020a63130c000000b004facdf070d6sm1784407pgl.39.2023.04.13.14.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 14:14:34 -0700 (PDT)
Message-ID: <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
Date:   Thu, 13 Apr 2023 14:14:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [GSOC][PATCH v2] diff-index: enable sparse index
To:     Raghul Nanth A <nanth.raghul@gmail.com>, git@vger.kernel.org
Cc:     derrickstolee@github.com
References: <20230403190538.361840-1-nanth.raghul@gmail.com>
 <20230408112342.404318-1-nanth.raghul@gmail.com>
Content-Language: en-US
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <20230408112342.404318-1-nanth.raghul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A wrote:
> diff-index uses the run_diff_index() function to generate its diff. This
> function has been made sparse-index aware in the series that led to
> 8d2c3732 (Merge branch 'ld/sparse-diff-blame', 2021-12-21). Hence we can
> just set the requires-full-index to false for "diff-index".
> 
> Performance metrics
> 
>   Test                                                  HEAD~1            HEAD
>   ----------------------------------------------------------------------------------------------
>   2000.2: echo >>a && git diff-index HEAD (full-v3)     0.09(0.06+0.04)   0.09(0.07+0.03) +0.0%
>   2000.3: echo >>a && git diff-index HEAD (full-v4)     0.09(0.06+0.04)   0.09(0.05+0.05) +0.0%
>   2000.4: echo >>a && git diff-index HEAD (sparse-v3)   0.37(0.31+0.06)   0.01(0.02+0.03) -97.3%
>   2000.5: echo >>a && git diff-index HEAD (sparse-v4)   0.30(0.26+0.05)   0.01(0.01+0.04) -96.7%
>   2000.6: git diff-index HEAD **a (full-v3)             0.06(0.05+0.01)   0.06(0.06+0.01) +0.0%
>   2000.7: git diff-index HEAD **a (full-v4)             0.06(0.05+0.01)   0.06(0.04+0.02) +0.0%
>   2000.8: git diff-index HEAD **a (sparse-v3)           0.29(0.25+0.03)   0.01(0.01+0.00) -96.6%
>   2000.9: git diff-index HEAD **a (sparse-v4)           0.37(0.34+0.02)   0.01(0.01+0.00) -97.3%
>   2000.10: git diff-index --cached HEAD (full-v3)       0.05(0.03+0.01)   0.05(0.03+0.02) +0.0%
>   2000.11: git diff-index --cached HEAD (full-v4)       0.05(0.03+0.01)   0.05(0.02+0.02) +0.0%
>   2000.12: git diff-index --cached HEAD (sparse-v3)     0.35(0.33+0.01)   0.01(0.00+0.00) -97.1%
>   2000.13: git diff-index --cached HEAD (sparse-v4)     0.35(0.32+0.02)   0.01(0.00+0.00) -97.1%
> ---
> 
> Sorry for the late reply. Got caught up in school work
>   * Fixed commit message
>   * Added check to expand index if needed (based on diff-files)
>   * Added pathspec based tests

Please include the range-diff comparing the previous version to the new one
in your future iterations & patch series in general. GitGitGadget adds it by
default, but if you're using 'send-email' you should be able to use the
'--range-diff' option to generate it (see MyFirstContribution [1] for more
information).

[1] https://git-scm.com/docs/MyFirstContribution#v2-git-send-email

> 
>  builtin/diff-index.c                     |  9 +++++
>  t/perf/p2000-sparse-operations.sh        |  3 ++
>  t/t1092-sparse-checkout-compatibility.sh | 44 ++++++++++++++++++++++++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/builtin/diff-index.c b/builtin/diff-index.c
> index 35dc9b23ee..e67cf5a1db 100644
> --- a/builtin/diff-index.c
> +++ b/builtin/diff-index.c
> @@ -24,6 +24,14 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  		usage(diff_cache_usage);
>  
>  	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
> +
> +	prepare_repo_settings(the_repository);
> +	the_repository->settings.command_requires_full_index = 0;
> +
> +	if (pathspec_needs_expanded_index(the_repository->index,
> +					  &rev.diffopt.pathspec))
> +		ensure_full_index(the_repository->index);

Re: my last review [2] - did you look into the behavior of 'diff' with
pathspecs and whether this 'pathspec_needs_expanded_index()' could be
centralized (in e.g. 'run_diff_index()')? What did you find?

[2] https://lore.kernel.org/git/91d3fd23-8120-db65-481a-e9f56017bb04@github.com/

> +
>  	repo_init_revisions(the_repository, &rev, prefix);
>  	rev.abbrev = 0;
>  	prefix = precompose_argv_prefix(argc, argv, prefix);
> @@ -69,6 +77,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
>  		perror("repo_read_index");
>  		return -1;
>  	}
> +
>  	result = run_diff_index(&rev, option);
>  	result = diff_result_code(&rev.diffopt, result);
>  	release_revisions(&rev);
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a..62499d3aa8 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -125,5 +125,8 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all 'echo >>a && git diff-index HEAD'
> +test_perf_on_all git diff-index HEAD "**a"
> +test_perf_on_all git diff-index --cached HEAD
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e..24bc716c48 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1996,6 +1996,50 @@ test_expect_success 'sparse index is not expanded: rm' '
>  	ensure_not_expanded rm -r deep
>  '
>  
> +test_expect_success 'sparse index is not expanded: diff-index' '
> +	init_repos &&
> +
> +	echo "new" >>sparse-index/g &&
> +	git -C sparse-index add g &&
> +	git -C sparse-index commit -m "dummy" &&
> +	ensure_not_expanded diff-index HEAD~1 &&
> +
> +	echo "text" >>sparse-index/deep/a &&
> +
> +	ensure_not_expanded diff-index HEAD deep/a &&
> +	ensure_not_expanded diff-index HEAD deep/*
> +'

nit: please add a newline here (after the 'sparse index is not expanded:
diff-index' test) to stay consistent with the other tests in the file.

> +test_expect_success 'diff-index pathspec expands index when necessary' '
> +	init_repos &&
> +
> +	echo "text" >>sparse-index/deep/a &&
> +
> +	# pathspec that should expand index
> +	! ensure_not_expanded diff-index "*/a" &&

Using '! ensure_not_expanded' will fail if the command expands the index
_or_ if the command fails altogether, which could inadvertently make these
tests pass even when there's a breakage in 'diff-index'. An
'ensure_expanded' function was created in [3] to test these types of cases;
you can use that here if you base your branch on 'sl/diff-files-sparse' (see
SubmittingPatches for more information [4]).

[3] https://lore.kernel.org/git/20230322161820.3609-3-cheskaqiqi@gmail.com/
[4] https://git-scm.com/docs/SubmittingPatches#base-branch

> +	! ensure_not_expanded diff-index "**a"

Git pathspec syntax [5] does not follow glob rules (without the ':(glob)'
prefix, at least), so the '**' doesn't do anything special here that a
single '*' wouldn't do. So, to make it clear that you aren't using glob
patterns, it might be better to use '*a' instead. 

Also, why are the wildcard pathspecs here in double-quotes, but the ones in
the previous test ('sparse index is not expanded: diff-index') aren't?

[5] https://git-scm.com/docs/gitglossary#Documentation/gitglossary.txt-aiddefpathspecapathspec

> +'
> +
> +test_expect_success 'diff-index with pathspec outside sparse definition' '
> +	init_repos &&
> +
> +	test_sparse_match test_must_fail git diff-index HEAD folder2/a
> +'
> +
> +test_expect_success 'match all: diff-index' '
> +	init_repos &&
> +
> +	test_all_match git diff-index HEAD &&
> +	write_script edit-contents <<-\EOF &&
> +	echo text >>$1
> +	EOF
> +	run_on_all ../edit-contents g &&
> +	run_on_all git add g &&
> +	run_on_all git commit -m "two" &&
> +	run_on_all rm g &&
> +	test_all_match git diff-index HEAD &&
> +	test_all_match git diff-index --cached HEAD~1
> +'
> +
>  test_expect_success 'grep with and --cached' '
>  	init_repos &&
>  

