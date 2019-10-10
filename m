Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F8071F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 18:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfJJSQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 14:16:29 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41232 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJSQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 14:16:29 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so3177911plr.8
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 11:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9ElgnF9D7flWfKHIhx4vwhF9n02t8UglrAMR0hdKs8=;
        b=leO17HwDGRXnBJoztxSF/ptCeD8fdRitpZphuiDYIhdsArA73ek/FdqOrQkq4si01H
         Rb6/9mcmvXrbg09L35m+xciH2iBL0otcG5plqLhD3iHFDlfCti8IP+Txfjt+m1iv/C4U
         SmNIaHsevDRJ5xMNqaATi7qV8nbuUohXhIY3ExwVUgunqAcaXvWrW4EhxW12kDNHZo5T
         ihcaT3UKuRwFmZOmexmfE5k0wlblEOdcrVqgZg1JEfhnYsoe2XIKzqQgUUL+DnmvFC+q
         NB16HIPVR2j8UtDF81W0uodfg8YEJKOMxkic9GaqdPE9rUp4fmhmlCxkUTfK4TGMTQ3X
         r4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9ElgnF9D7flWfKHIhx4vwhF9n02t8UglrAMR0hdKs8=;
        b=Ewe46pjBXw47IqghIysjrecyzu+KyyTSqcQKjDf7S2KUC2CnfY2CggqWWYCNmDQJr9
         vbtR1LrcRao9SPPlp+UOpCboq3fy56SLn5ynNjIy3Y6WwfLMGQnLLmZmURpEcsndSDYn
         uv2U6bRACU54kD0fjq9OCYWomatIBpnlQQdKgxMEw1z3fgdECnw+/CVIdBza2Po4RctJ
         VoZxmLGYFMxp//VG+SV2kO7Njb5ATxXQ3TnzaDhq5dOkqMijnpcqRu2NtJ5XCXELafQ/
         eLmDs1D3MLC4y8M2FERuci00cm3Aal+2MnxUfILSsqN4ZUIudReFwyx9mvNrDUA9y7XB
         1QUQ==
X-Gm-Message-State: APjAAAVPSGXjP6uLicQXwA7ixQp4ru4xItjZYjryFBCuSbmWH8T59JmW
        w/9fLcEKJGlFqpnC0SHWkVI=
X-Google-Smtp-Source: APXvYqyHtbWtGYMYZosIyFn2V53VtmgL9mXgK6R00GEHW+2e3euW0Wc+NIg0slGhnAGNghERWOW2/Q==
X-Received: by 2002:a17:902:7591:: with SMTP id j17mr10398665pll.293.1570731388137;
        Thu, 10 Oct 2019 11:16:28 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id l6sm6026183pje.28.2019.10.10.11.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:16:26 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:16:24 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     James Coglan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        James Coglan <jcoglan@gmail.com>
Subject: Re: [PATCH 11/11] graph: fix coloring of octopus dashes
Message-ID: <20191010181624.GA97861@generichostname>
References: <pull.383.git.gitgitgadget@gmail.com>
 <ea0df1d94aa6c42eb00d59b268a90a8724322452.1570724021.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea0df1d94aa6c42eb00d59b268a90a8724322452.1570724021.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi James,

Nicely done! This issue was bugging me for a while!

On Thu, Oct 10, 2019 at 09:13:52AM -0700, James Coglan via GitGitGadget wrote:

[...]

> diff --git a/t/t4214-log-graph-octopus.sh b/t/t4214-log-graph-octopus.sh
> index 9ada687628..fbd485d83a 100755
> --- a/t/t4214-log-graph-octopus.sh
> +++ b/t/t4214-log-graph-octopus.sh
> @@ -42,23 +42,74 @@ test_expect_success 'set up merge history' '
>  	test_tick &&
>  	git merge -m octopus-merge 1 2 3 4 &&
>  	git checkout 1 -b L &&
> -	test_commit left
> +	test_commit left &&
> +	git checkout 4 -b R &&
> +	test_commit right
>  '
>  
>  test_expect_success 'log --graph with tricky octopus merge with colors' '
>  	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
> -	git log --color=always --graph --date-order --pretty=tformat:%s --all >actual.colors.raw &&
> +	git log --color=always --graph --date-order --pretty=tformat:%s L merge >actual.colors.raw &&
>  	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
>  	test_cmp expect.colors actual.colors
>  '
>  
>  test_expect_success 'log --graph with tricky octopus merge, no color' '
> -	git log --color=never --graph --date-order --pretty=tformat:%s --all >actual.raw &&
> +	git log --color=never --graph --date-order --pretty=tformat:%s L merge >actual.raw &&
>  	sed "s/ *\$//" actual.raw >actual &&
>  	test_cmp expect.uncolored actual
>  '
>  
> -# Repeat the previous two tests with "normal" octopus merge (i.e.,
> +# Repeat the previous two tests with an octopus merge whose final parent skews left
> +
> +test_expect_success 'log --graph with left-skewed final parent, no color' '
> +	cat >expect.uncolored <<-\EOF &&
> +	* right
> +	| *---.   octopus-merge
> +	| |\ \ \
> +	| |_|_|/
> +	|/| | |
> +	* | | | 4
> +	| | | * 3
> +	| |_|/
> +	|/| |
> +	| | * 2
> +	| |/
> +	|/|
> +	| * 1
> +	|/
> +	* initial
> +	EOF
> +	git log --color=never --graph --date-order --pretty=tformat:%s R merge >actual.raw &&
> +	sed "s/ *\$//" actual.raw >actual &&
> +	test_cmp expect.uncolored actual
> +'
> +
> +test_expect_success 'log --graph with left-skewed final parent with colors' '
> +	cat >expect.colors <<-\EOF &&
> +	* right
> +	<RED>|<RESET> *<BLUE>-<RESET><BLUE>-<RESET><RED>-<RESET><RED>.<RESET>   octopus-merge
> +	<RED>|<RESET> <GREEN>|<RESET><YELLOW>\<RESET> <BLUE>\<RESET> <RED>\<RESET>
> +	<RED>|<RESET> <GREEN>|<RESET><RED>_<RESET><YELLOW>|<RESET><RED>_<RESET><BLUE>|<RESET><RED>/<RESET>
> +	<RED>|<RESET><RED>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET>
> +	* <GREEN>|<RESET> <YELLOW>|<RESET> <BLUE>|<RESET> 4
> +	<MAGENTA>|<RESET> <GREEN>|<RESET> <YELLOW>|<RESET> * 3
> +	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>_<RESET><YELLOW>|<RESET><MAGENTA>/<RESET>
> +	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET> <YELLOW>|<RESET>
> +	<MAGENTA>|<RESET> <GREEN>|<RESET> * 2
> +	<MAGENTA>|<RESET> <GREEN>|<RESET><MAGENTA>/<RESET>
> +	<MAGENTA>|<RESET><MAGENTA>/<RESET><GREEN>|<RESET>
> +	<MAGENTA>|<RESET> * 1
> +	<MAGENTA>|<RESET><MAGENTA>/<RESET>
> +	* initial
> +	EOF
> +	test_config log.graphColors red,green,yellow,blue,magenta,cyan &&
> +	git log --color=always --graph --date-order --pretty=tformat:%s R merge >actual.colors.raw &&
> +	test_decode_color <actual.colors.raw | sed "s/ *\$//" >actual.colors &&
> +	test_cmp expect.colors actual.colors
> +'
> +
> +# Repeat the first two tests with "normal" octopus merge (i.e.,
>  # without the first parent skewing to the "left" branch column).
>  
>  test_expect_success 'log --graph with normal octopus merge, no color' '

So, I decided to merge 'dl/octopus-graph-bug' with your branch and I
couldn't be happier! I had to make a couple of minor tweaks to the
existing test cases but most of them only involved flipping
`test_expect_failure` to `test_expect_success`.

You can see the results of this by doing:

	$ git fetch https://github.com/Denton-L/git.git testing/graph-output
	$ git diff FETCH_HEAD^2 t/t4214-log-graph-octopus.sh

and the resulting diff is very pleasing imo.

Junio, when you pick this topic up, that branch should contain the
correct conflict resolution if that can help you out in any way.

Anyway, thanks for the work, James!

I'll give this patch my:

	Tested-by: Denton Liu <liu.denton@gmail.com>

> -- 
> gitgitgadget
