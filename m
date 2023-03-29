Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A43C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjC2Rto (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjC2Rtl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 13:49:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714BFDC
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 10:49:40 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w4so15661038plg.9
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 10:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1680112180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jMhVeojwp7OV0xRsGJs/iD68IUnKExnvDov07jLTU0E=;
        b=aF8iVmy3kYOUB26d+8U4p53Lt1A0uG3Yr79hD4zn0GXIEO3ezF78eRr+BxjTGe531b
         uOrICF2OaCBp1NsD7Op4e0LY709ylB324ogHCjSdgvTrQFodnUoscB6QXoUomXCnslfo
         A3GpPi8SeVQMZ4O4OpuddmoqDY4tmW92UMWt2fj0v3Y/sd1dtlgOeeMqC8GQrtN4kg7K
         uh7wYizDgocwoskxNi8CHED4/ycX7Of/h+3PCl7VKCkZ9Zqbg3bxACG2jT4Bl+Fir1dl
         BFqspX5xW4wbziKGAIW7XzWtawv4nZQElrru5Wxv30Q6uBkV5ck2jn3/JbgAiCvgiirB
         Qv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680112180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMhVeojwp7OV0xRsGJs/iD68IUnKExnvDov07jLTU0E=;
        b=2mt03gZjDueIT/D5AlFw+dPOr8u6cHz7VmHmDIUTAw/9mQoMEhGXME4ftxIO6cqoSt
         AATmYD2Bm2u0833niqkbI2hnVsep58D71LTY2dIQ6RalyHJKaQ7TfdVgGclYIJjuoToP
         CMYdWVuBkEUM71YUxaHncUr9CVsAK6vM2T3SX9y+BtxaAV/oVYqQrEG3cQfaOgNzg2U5
         YDo2dY5nTlJLNybZ10YTkGwr6TfDUSBRvLH74meXwADtBzaphLkGYZ18wZtUyt5YcLd1
         wVWCq1LnlZW1pUThIAdg0uuAGaB6hoiXjLTL7dR9todsR+QcAsDqXSmv5Htyqqe3omdg
         cysA==
X-Gm-Message-State: AAQBX9fkNyAjoNDS1J02JCEyvIhK6Zs2SsoemdTMmphsm8D4X1TRSxkg
        Ozp0B764sw4HLR2RA0GlI47S
X-Google-Smtp-Source: AKy350YfBpLAZQlxotunddquMK8H1C/KSJuTvPN8Zx7cmKFWxz+0yg0V1JKEXuYlvy4Gf7bnXKn/lg==
X-Received: by 2002:a17:90a:198e:b0:237:9cc7:28a4 with SMTP id 14-20020a17090a198e00b002379cc728a4mr21754847pji.14.1680112179826;
        Wed, 29 Mar 2023 10:49:39 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id w15-20020a170902a70f00b0019a8468cbe7sm23229013plq.224.2023.03.29.10.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:49:39 -0700 (PDT)
Message-ID: <8cb2b7a2-78f2-9221-1234-62814557d2d3@github.com>
Date:   Wed, 29 Mar 2023 10:49:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2] describe: enable sparse index for describe
Content-Language: en-US
To:     Raghul Nanth A via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
 <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Raghul Nanth A via GitGitGadget wrote:
> From: Raghul Nanth A <nanth.raghul@gmail.com>

Hello! Thanks for working on this patch, it's always nice to get more sparse
index support. Since this is your first contribution to the mailing list,
though, it's unclear to me whether you're working on this as an independent
contributor or if you're interested in the Google Summer of Code project
"More Sparse Index Integrations" [1]. If you're doing this for GSoC, could
you please prefix the title of this patch with "[GSoC]" (as noted in the
application details [2])?

On the topic of GSoC applications - if you are submitting this for GSoC, I'm
a bit curious as to why you jumped right into sparse index rather than first
submitting a microproject [3]. This is a good first pass at a sparse index
integration, but the microproject is a better way to get acquainted with the
conventions and requirements of contributing to Git, hence the strong
recommendation to complete one first.

[1] https://git.github.io/SoC-2023-Ideas/
[2] https://git.github.io/General-Application-Information/
[3] https://git.github.io/General-Microproject-Information/

> 
> Add usage and performance tests for describe
> 
> Performance metrics
> 
>   Test                                                     HEAD~1            HEAD
>   -------------------------------------------------------------------------------------------------
>   2000.2: git describe --dirty (full-v3)                   0.08(0.09+0.01)   0.08(0.06+0.03) +0.0%
>   2000.3: git describe --dirty (full-v4)                   0.09(0.07+0.03)   0.08(0.05+0.04) -11.1%
>   2000.4: git describe --dirty (sparse-v3)                 0.88(0.82+0.06)   0.02(0.01+0.05) -97.7%
>   2000.5: git describe --dirty (sparse-v4)                 0.68(0.60+0.08)   0.02(0.02+0.04) -97.1%
>   2000.6: echo >>new && git describe --dirty (full-v3)     0.08(0.04+0.05)   0.08(0.05+0.04) +0.0%
>   2000.7: echo >>new && git describe --dirty (full-v4)     0.08(0.07+0.03)   0.08(0.05+0.04) +0.0%
>   2000.8: echo >>new && git describe --dirty (sparse-v3)   0.75(0.69+0.07)   0.02(0.03+0.03) -97.3%
>   2000.9: echo >>new && git describe --dirty (sparse-v4)   0.81(0.73+0.09)   0.02(0.01+0.05) -97.5%

As Junio noted [4], this description doesn't provide much information to a
reader. Commit messages should (at a minimum) explain what the code change
in a commit does, as well as why it's necessary. 

[4] https://lore.kernel.org/git/xmqq355nbii5.fsf@gitster.g/ 

> 
> Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
> ---
>     describe: enable sparse index for describe
>     
>      * Removed describe tests not concerned with sparse index
>     
>      * Added performance metric to commit message
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1480%2FNanthR%2Fdescribe-sparse-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1480/NanthR/describe-sparse-v2
> Pull-Request: https://github.com/git/git/pull/1480
> 
>  builtin/describe.c                       |  2 +
>  t/perf/p2000-sparse-operations.sh        |  3 ++
>  t/t1092-sparse-checkout-compatibility.sh | 11 ++++
>  t/t6121-describe-sparse.sh               | 67 ++++++++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100755 t/t6121-describe-sparse.sh
> 
> diff --git a/builtin/describe.c b/builtin/describe.c
> index 5b5930f5c8c..7ff9b5e4b20 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			int fd, result;
>  
>  			setup_work_tree();
> +			prepare_repo_settings(the_repository);
> +			the_repository->settings.command_requires_full_index = 0;

Looks good.

>  			repo_read_index(the_repository);
>  			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
>  				      NULL, NULL, NULL);
> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a0..db7887470f9 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -43,6 +43,7 @@ test_expect_success 'setup repo and indexes' '
>  	done &&
>  
>  	git sparse-checkout init --cone &&
> +	git tag -a v1.0 -m "Final" &&

This isn't disruptive to the existing performance tests, but allows you to
easily test 'git describe'. Nice!

>  	git sparse-checkout set $SPARSE_CONE &&
>  	git checkout -b wide $OLD_COMMIT &&
>  
> @@ -125,5 +126,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git describe --dirty
> +test_perf_on_all 'echo >>new && git describe --dirty'
>  
>  test_done
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 801919009e1..9a4db09178f 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -1514,6 +1514,17 @@ test_expect_success 'sparse-index is not expanded: stash' '
>  	ensure_not_expanded stash pop
>  '
>  
> +test_expect_success 'sparse-index is not expanded: describe' '
> +	init_repos &&
> +	# Add tag to be read by describe
> +	ensure_not_expanded tag -a v1.0 -m "Version 1" &&

The test you've added isn't verifying the sparse index compatibility of 'git
tag' (which doesn't use the index at all, IIRC), so 'ensure_not_expanded'
isn't needed on this line. You should use 'git -C sparse-index tag ...' to
perform the action instead.

> +	ensure_not_expanded describe --dirty &&
> +	ensure_not_expanded describe &&
> +	echo "test" >>sparse-index/extra.txt &&
> +	ensure_not_expanded describe --dirty &&
> +	ensure_not_expanded describe
> +'
> +
>  test_expect_success 'sparse index is not expanded: diff' '
>  	init_repos &&
>  
> diff --git a/t/t6121-describe-sparse.sh b/t/t6121-describe-sparse.sh
> new file mode 100755
> index 00000000000..ce53603c387
> --- /dev/null
> +++ b/t/t6121-describe-sparse.sh

Is there a specific reason you've created a new test file instead of adding
the tests to 't1092-sparse-checkout-compatibility.sh'? Historically, we've
used 't1092' for validating both the functional correctness of a command
with sparse index enable and the preservation of a sparse index with
'ensure_not_expanded'; you've done the latter in 't1092', but put the former
in this new 't6121'. 't1092' also uses a more "interesting" test repo &
includes comparison functions for full checkout/sparse-checkout/sparse
index, so the tests added for 'git describe' can be more thorough.

> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description='git describe in sparse checked out trees'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +check_describe () {
> +	indir= &&
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		-C)
> +			indir="$2"
> +			shift
> +			;;
> +		*)
> +			break
> +			;;
> +		esac
> +		shift
> +	done &&
> +	indir=${indir:+"$indir"/} &&
> +	expect="$1"
> +	shift
> +	describe_opts="$@"
> +	test_expect_success "describe $describe_opts" '
> +		git ${indir:+ -C "$indir"} describe $describe_opts >actual &&
> +		echo "$expect" >expect &&
> +		test_cmp expect actual
> +	'
> +}
> +
> +test_expect_success setup '
> +	test_commit initial file one &&
> +	test_commit --annotate A file A &&
> +
> +	test_tick &&
> +
> +	git sparse-checkout init --cone
> +'
> +
> +check_describe A HEAD
> +
> +test_expect_success 'describe --dirty with --work-tree' '
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
> +	) &&
> +	grep "A" out
> +'
> +
> +test_expect_success 'set-up dirty work tree' '
> +	echo >>file
> +'
> +
> +test_expect_success 'describe --dirty with --work-tree (dirty)' '
> +	git describe --dirty >expected &&
> +	(
> +		cd "$TEST_DIRECTORY" &&
> +		git --git-dir "$TRASH_DIRECTORY/.git" --work-tree "$TRASH_DIRECTORY" describe --dirty >"$TRASH_DIRECTORY/out"
> +	) &&
> +	test_cmp expected out
> +'
> +test_done
> 
> base-commit: 27d43aaaf50ef0ae014b88bba294f93658016a2e

