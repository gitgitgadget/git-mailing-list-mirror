Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D27C678D4
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 10:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCBKIT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjCBKIC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 05:08:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E753582
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 02:08:01 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r18so15964326wrx.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 02:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677751679;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A8+jBg4uzspQQQZzmzpFxzi5yXQDWoCfDBHGXxMqsKw=;
        b=VNCkkXS4GZ4Z1oFeBpQStanq7NyPFFwauaPjIVW16R0uSsci3y3IGwnLhtnPq2b1Ls
         fm+6yrmIUMZsR0N8tXKDEg0HRSoQrnZFQjgn/DuujAVygbBBJSDQ0ZTsOiCRW5WFDieR
         e+dZ3yaH3bl/bqwl/SRdYu0FSmjkmLiPbvQaAolyX9VYTWrmDrs52KtL8uMqDdSX68JJ
         eAHPjuBIO5ljd9FoBl+dBLS8c+shkxz5collOr/4rSoAql/a9dDidKI8qvGSHlhAcs5i
         nEohoJoOt2fKrUueM0kv5Fm4fgtt+aQmwzNA3evI/WLXV0pZc2WA15O7y+sXrzSg+oBX
         6lhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677751679;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8+jBg4uzspQQQZzmzpFxzi5yXQDWoCfDBHGXxMqsKw=;
        b=0IxTmU1ktvuU93Ru+21GFHKNCJpmMyCab7XAteCq11dWVyn3jTjxYwG837udr03g1E
         i/dcVmlLCKZnZNY/XP19HbjiaIb4ejdPPEio88ad+r1QZWQpUbgdBkLonMMATuz6mQns
         srjCDIJhjHjimUuY2dk/Qoco/OhkvKDMeLR8I7jVoobw7BldXNqoup6xDBg8NrmROS0T
         iU9WDH2EDE+gsIdgotLyObP7K9wPpfOmJoPm9l63SrpgTpf5tbz2PAruUiG+oLpB4lXG
         PBBXCtynwv43bhjThsMc4jaZyzzAybM0WMCBdxBCoqQCSBDS8t8nZqO4PjTvW8y8OQOo
         QX4g==
X-Gm-Message-State: AO0yUKW4YqkZyBQbK1Erg6SEH7K7ue0/cwuaGYOD9+HkIGvYX16W+ApI
        +1vHY4QCcAOIw8biQA+/D8A=
X-Google-Smtp-Source: AK7set9n3IpyYb51N+Bwb2eWeq9Rqnk1J3k2vKwHY1j6tUkKHJsSv1oqiAMri3ueF4J/hanx8T0ZVQ==
X-Received: by 2002:a05:6000:18f:b0:2bd:d34e:5355 with SMTP id p15-20020a056000018f00b002bdd34e5355mr6573711wrx.20.1677751679008;
        Thu, 02 Mar 2023 02:07:59 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id z7-20020a05600c0a0700b003dc434b39c7sm7087708wmp.0.2023.03.02.02.07.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:07:58 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <5958167e-63ca-f0ef-3b6f-7dc523b523a6@dunelm.org.uk>
Date:   Thu, 2 Mar 2023 10:07:52 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/3] rebase: deprecate --rebase-merges=""
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        sorganov@gmail.com
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230225180325.796624-3-alexhenrie24@gmail.com>
In-Reply-To: <20230225180325.796624-3-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 25/02/2023 18:03, Alex Henrie wrote:
> The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
> empty string argument) has been an undocumented synonym of
> --rebase-merges=no-rebase-cousins. Deprecate that syntax to avoid
> confusion when a rebase.merges config option is introduced, where
> rebase.merges="" will be equivalent to --no-rebase-merges.

I think deprecating this rather than making it an error is a good idea. 
I don't think we need the test though. The test suite is incredibly slow 
to run on windows (I'd heard people complain about it but it was not 
until I tried running it myself I realized just how diabolically slow it 
really is) and so it is important to balance adding tests to catch 
regression vs test run time. Tests that catch bugs in the rebase 
implementation are useful, ones like this just make everything slower 
which makes it harder to catch real regressions.

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   builtin/rebase.c         | 8 ++++++--
>   t/t3430-rebase-merges.sh | 5 +++++
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6635f10d52..ccc13200b5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1140,7 +1140,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		{OPTION_STRING, 'r', "rebase-merges", &rebase_merges,
>   			N_("mode"),
>   			N_("try to rebase merges instead of skipping them"),
> -			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
> +			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
>   		OPT_BOOL(0, "fork-point", &options.fork_point,
>   			 N_("use 'merge-base --fork-point' to refine upstream")),
>   		OPT_STRING('s', "strategy", &options.strategy,
> @@ -1438,7 +1438,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   
>   	if (rebase_merges) {
>   		if (!*rebase_merges)
> -			; /* default mode; do nothing */
> +			warning(_("--rebase-merges with an empty string "
> +				  "argument is deprecated and will stop "
> +				  "working in a future version of Git. Use "
> +				  "--rebase-merges=no-rebase-cousins "
> +				  "instead."));
>   		else if (!strcmp("rebase-cousins", rebase_merges))
>   			options.rebase_cousins = 1;
>   		else if (strcmp("no-rebase-cousins", rebase_merges))
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index d46d9545f2..f50fbf1390 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -278,6 +278,11 @@ test_expect_success 'do not rebase cousins unless asked for' '
>   	EOF
>   '
>   
> +test_expect_success '--rebase-merges="" is deprecated' '
> +	git rebase --rebase-merges="" HEAD^ 2>actual &&
> +	grep deprecated actual
> +'
> +
>   test_expect_success 'refs/rewritten/* is worktree-local' '
>   	git worktree add wt &&
>   	cat >wt/script-from-scratch <<-\EOF &&
