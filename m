Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E09A1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 13:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbfAYNvd (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 08:51:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55751 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbfAYNvc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 08:51:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so6775077wmc.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 05:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iKEGhEQPw2Amcs03+/nsjVuz4S4QH4FVo1en20POaaI=;
        b=InDzbpwRv7VhAK572hGBYZY5siHdBEpCy6TfahhN3tZnhZ9Uqtw4bsgohn3rvk8DVR
         5jTpXS7L7o5YQ0IQqMJcP56x65MclWgsbVBTbjdnaNFspTqpJxElm5qWe4GHoGC5eDn8
         G/TYNai98ttR9xjtnGj9tkg8uhyr7BINPylDrY1y1NDqVLmdn4hEVS2Unak43nye9SMQ
         CqaBQFwZbe665hVanEqxmiK58UY/m/+TAnWhvH8GcaJkb7lflxRs2t4vD13BOCSJaIm3
         AH7DkjVzgaapUSf1nvcS3KD8XjuuTTViiB/SJG0GPj4t8FnfnAZmPtvTvv8OoOG61e5h
         w+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iKEGhEQPw2Amcs03+/nsjVuz4S4QH4FVo1en20POaaI=;
        b=l5dUq7KH4qlqLKAL9iYfbb86tJ4+jo2alFaFDvxqXmwCjjLbuEdKNmMW0o4fXUhHPW
         61IYp+xey4tIWehmbe8bQKvurN5lfLraol4eimjXLtEmtyBmS9kGYDn/znwq49AYMQTS
         k66bLCTNpdOTzTX42PoaD8TFmqbS8Vm6/wv++g7xgkRtW+Ey//nUEqUe647Z4Ku6Iv+w
         GtzDo6HKR9zKKctJL8NQc/ZQgd+NIcEXIoDXLPLDKmHKLiKrWQY9ZR3I03i+e5BRcJk/
         92iWhO/lD62lanWGalcpHW+Xvqmb4xpoTfFjV/8+LWSxkbxkFsgNnZELSjEDqzRWeb1R
         +qtQ==
X-Gm-Message-State: AJcUukf09tMzkuCLRC7G/EV0H02WdszWiTV2GNqDb3/8lAsfcLppehSC
        +y7SdYsLSPy0H6Vv+NYGiCTWElFa
X-Google-Smtp-Source: ALg8bN4xaTIxXD86zBCkYLLBB4rJm+7bG+lpgvPuebQ38KNZkhLxvAGYxgLdm27/0xUKXNtXwWTzOg==
X-Received: by 2002:a7b:c853:: with SMTP id c19mr6583197wml.61.1548424290634;
        Fri, 25 Jan 2019 05:51:30 -0800 (PST)
Received: from szeder.dev (x4db9b7c2.dyn.telefonica.de. [77.185.183.194])
        by smtp.gmail.com with ESMTPSA id t5sm72073010wmd.15.2019.01.25.05.51.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:51:29 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:51:27 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 03/21] ci/lib.sh: encapsulate Travis-specific things
Message-ID: <20190125135127.GE6702@szeder.dev>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
 <pull.31.v4.git.gitgitgadget@gmail.com>
 <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d0b62f1862d5fce3ac0d7b813399f560600917d.1548254412.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 23, 2019 at 06:40:16AM -0800, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The upcoming patches will allow building git.git via Azure Pipelines
> (i.e. Azure DevOps' Continuous Integration), where variable names and
> URLs look a bit different than in Travis CI.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

> diff --git a/ci/lib.sh b/ci/lib.sh
> index c26bb6a274..4456dbbcb0 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -1,8 +1,26 @@
>  # Library of functions shared by all CI scripts
>  
> -# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
> -# want here. We want the source branch instead.
> -CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> +if test true = "$TRAVIS"
> +then
> +	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
> +	# what we want here. We want the source branch instead.
> +	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
> +	CI_COMMIT="$TRAVIS_COMMIT"
> +	CI_JOB_ID="$TRAVIS_JOB_ID"
> +	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
> +	CI_OS_NAME="$TRAVIS_OS_NAME"
> +	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
> +
> +	cache_dir="$HOME/travis-cache"
> +
> +	url_for_job_id () {
> +		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
> +	}
> +
> +	BREW_INSTALL_PACKAGES="git-lfs gettext"
> +	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
> +	export GIT_TEST_OPTS="--verbose-log -x --immediate"
> +fi

Please set these variables after 'set -x' has been turned on, so the
values will be visible in the logs.

https://public-inbox.org/git/20181018220106.GU19800@szeder.dev/


> diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
> index 7aef39a2fd..d2045b63a6 100755
> --- a/ci/print-test-failures.sh
> +++ b/ci/print-test-failures.sh
> @@ -69,7 +69,7 @@ do
>  	fi
>  done
>  
> -if [ $combined_trash_size -gt 0 ]
> +if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]

Nit: if [ -n "$TRAVIS_JOB_ID" ] && [ $combined_trash_size -gt 0 ]

More importantly: is this necessary, because on Azure Pipelines there
is no URL from where the logs could be downloaded conveniently and
reliably?  I wonder whether it's worth to spend the extra effort in
preparing the base64-encoded trash directories of failed tests in the
first place.

>  then
>  	echo "------------------------------------------------------------------------"
>  	echo "Trash directories embedded in this log can be extracted by running:"
