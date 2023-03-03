Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDF5C678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 13:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjCCNzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 08:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCCNzD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 08:55:03 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD4218142
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 05:55:02 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id ce7so1579832pfb.9
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 05:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEh/mrFuwYJcYzq8nZba0bEInhRLM5mHTrN2xtd3V+g=;
        b=pkVhwBMKTx55BIUlRFXnnLjhEPNU0LN+kUF7HHxN3oXHaWvgFa0txq22Wd7LG2rdiZ
         jV2aP8ybfmbwh9mW89xFod/TsNXqoRVPzzNj7rfPhgUjfnt84ycG1AVxUT9XzVax+/2W
         wpvf56DsKOdNw7GvB3yXXIVXz0fcJAdegcwS0lvbYpNk6kOJReAEGvS/dRO3COvR4Tax
         O2MSZQvRCQIbKXtex9Wo3R/CLjoRvr0w0PkcDpNGJli9FNib2eFDIW6h4HWg65DKUjSU
         Xn72fRbDm9lC11i959JdCtYFOGFgBJCWZtnSMv4PypkQiJY9GzqgwqcE0e7v4WyB++q/
         GdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pEh/mrFuwYJcYzq8nZba0bEInhRLM5mHTrN2xtd3V+g=;
        b=SQ5rWSJyzis1YEieQJBr3SDZnVDuMYsiO6e2IPbQG9x4T2/pGXSolod7ded5+ClP5k
         g/Cs0UYQ+spHhTG4OeSjD5b3Wt+XN2KHaxDy2i2o++Qc7LvBPcIkgsXwYtdfqh2d7Vgv
         4Qg+SWReLJpQA/t9ysKcq/3apD4H74uzrK3cEg89wVaHv04B59uhLzC28B8uygiFlijN
         al/coWHnU6u0tI2GiyHgvl1UMtdyokdCWJmkBvVc+kx4X4ThIgvqMcJc4gDSEK9RQBUr
         N6AvRZsjwcsmJJBNQ3SM/RH62yjCqXYORBhLxMXw3plwaVKNHyGoZ2MJlpIZfurLp6Yi
         RyIQ==
X-Gm-Message-State: AO0yUKWxO6kyB83ub5cC2PfBXw9soMo+RatziDtFmye1g7nF6dtoBWAN
        6pD4MbU4S+45+7n3TpNTxx2d45rC5rM=
X-Google-Smtp-Source: AK7set+cgR636o/D/WSIoiPgQCsmeM7axvnBeGYQt/x+ltVUVkRHd0jX/iSmq2Oi1QB9GtB7GVe83A==
X-Received: by 2002:a05:6a00:796:b0:5a8:e3d5:d7d4 with SMTP id g22-20020a056a00079600b005a8e3d5d7d4mr5519584pfu.7.1677851701571;
        Fri, 03 Mar 2023 05:55:01 -0800 (PST)
Received: from localhost ([113.172.118.59])
        by smtp.gmail.com with ESMTPSA id 8-20020aa79208000000b005ccbe5346ebsm1617652pfo.163.2023.03.03.05.55.00
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 05:55:01 -0800 (PST)
Date:   Fri, 3 Mar 2023 20:54:57 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Subject: Re: [PATCH 4/4] ci: add arm64 CI environment via CircleCI
Message-ID: <ZAH8McPd56NSAzOx@danh.dev>
References: <cover.1677850517.git.congdanhqx@gmail.com>
 <db5c58fb3ee114b56f110dcd20f938e77d8b476f.1677850518.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db5c58fb3ee114b56f110dcd20f938e77d8b476f.1677850518.git.congdanhqx@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-03-03 20:46:06+0700, Đoàn Trần Công Danh <congdanhqx@gmail.com> wrote:
> Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
> ---
>  .circleci/config.yml | 17 +++++++++++++++++
>  ci/lib.sh            | 19 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 .circleci/config.yml
> 
> diff --git a/.circleci/config.yml b/.circleci/config.yml
> new file mode 100644
> index 0000000000..2f5e0966b7
> --- /dev/null
> +++ b/.circleci/config.yml
> @@ -0,0 +1,17 @@
> +# .circleci/config.yml
> +jobs:
> +  build:
> +    machine:
> +      image: ubuntu-2004:2022.04.1
> +    resource_class: arm.medium
> +    environment:
> +      jobname: linux-gcc
> +      runs_on_pool: ubuntu-arm64
> +    steps:
> +    - checkout
> +    - run: ci/install-dependencies.sh
> +    - run:
> +        name: Build and Tests
> +        command: ci/run-build-and-tests.sh
> +    - store_test_results:
> +        path: t/out
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 3c19267a56..8b0c727950 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -201,6 +201,25 @@ then
>  	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>  	test windows != "$CI_OS_NAME" ||
>  	GIT_TEST_OPTS="--no-chain-lint --no-bin-wrappers $GIT_TEST_OPTS"
> +elif test "$CIRCLECI" = true
> +then
> +	CI_TYPE=circleci
> +	CI_BRANCH="$CIRCLE_BRANCH"
> +	CI_COMMIT="$CIRCLE_SHA1"
> +	CI_JOB_ID="$CIRCLE_WORKFLOW_JOB_ID"
> +	CI_JOB_NUMBER="$CIRCLE_BUILD_NUM"
> +	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"

Oops, this is wrong, it should be:

	CI_OS_NAME="$(uname -s)-$(uname -m)"

> +	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
> +	CI_REPO_SLUG="$(expr "$CIRCLE_REPOSITORY_URL" : '.*:\([^/]*/[^/]*\)\.git$')"
> +	CC="${CC:-gcc}"
> +
> +	# use a subdirectory of the cache dir (because the file share is shared
> +	# among *all* phases)
> +	cache_dir="$HOME/none"
> +
> +	export GIT_PROVE_OPTS="--timer --jobs 10"
> +	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
> +	MAKEFLAGS="$MAKEFLAGS --jobs=10"
>  else
>  	echo "Could not identify CI type" >&2
>  	env >&2
> -- 
> 2.40.0.rc1.2.gd15644fe02
> 

-- 
Danh
