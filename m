Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1565C004D4
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 15:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjAUPUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 10:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUPUh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 10:20:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F78298C3
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:20:35 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x10so9904368edd.10
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 07:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wFdr9+TqiA6IcijlSriDF4PPHl+NIArsW88BseQjRh8=;
        b=DY49k+48FSgCoTlaQBtQuP1+iRsOhLCLo84JzxvdJhg6Yio0gC2Pyb2HsOvE1MiYJt
         x5caejfPXSJ0oZzI4CAJQ5Oe8wljx0/9xl6DixKOn8glCAzqk0vDvMR807DbqrRLuOPi
         YTM7u3zk3oGyZE2OM3fkBrBhYxzSbTI8z5ZfdgT4Jbq5g6mtGwufjWLDraHwyaOZdemM
         LBRrjhm4vq1BA8PKDPMD5qjIB62McErcczDq8dl3z20ZfoYcV8fTe4Q+8jXz1Sw23+xN
         zeNEHbvPukaIMIVLBYxPInH9PykBf/Cz96bonrdb8FL8JrxhUJxA5RdqZ7Ux0cMkoj/f
         vVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFdr9+TqiA6IcijlSriDF4PPHl+NIArsW88BseQjRh8=;
        b=HM1+7J5RKmcDFm+SOTX+efLzvlYLLkj9O0TvN0MsJLBh31YR/b7F6H5CoGZaFq9fET
         e6t2qJBC2yAf0mryaC+Ey5qM4y9+N/+H3TpfXQgJ7OtUOSyJTwvCnP7h2Xx9W3hIfS5C
         8E5QMfdJr9VhL1Mdz9/Cd9T4uTo5J70mR5fIe00vkF0cjp+G9Vtf7Sj/i3T8BqVX+Ygc
         RQv+w4YaVNXPzcfUt940iO3Za0wAW8jZci4BYT8api/vJt90v9UVdoqCwJq1vOcSeRsj
         NieGYlraJgwF/qHK/HIvu+JV3BhvzYYO8CmqsPAv+qSpfdBnndd7Fkgrvx2swUmYoEgo
         lykw==
X-Gm-Message-State: AFqh2ko8cavF4wAi1FZ+nm4xL6kJ8hA+g8wVFj57IdH9UJsq33rtPR89
        Uhycxc5nR3ING0pqAua1NqPcO3Im6wg=
X-Google-Smtp-Source: AMrXdXs9ZLGbmR49eFKuYxeFe8zPWV2U9pBHpt/gRgkRRtydpGeRsPWqT0yx3LjaoQlH8HxAWIhhRg==
X-Received: by 2002:a05:6402:1764:b0:499:8849:5faf with SMTP id da4-20020a056402176400b0049988495fafmr19919893edb.26.1674314434541;
        Sat, 21 Jan 2023 07:20:34 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id r8-20020a05640251c800b0049df0f91b78sm10093332edd.78.2023.01.21.07.20.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 07:20:34 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <d5ef5870-baac-14d4-65a5-deb94a848011@dunelm.org.uk>
Date:   Sat, 21 Jan 2023 15:20:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/7] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v2.git.1674190573.gitgitgadget@gmail.com>
 <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <48c40c0dda00eeb8b9bdc5ba9372b46964eea14a.1674266126.git.gitgitgadget@gmail.com>
In-Reply-To: <48c40c0dda00eeb8b9bdc5ba9372b46964eea14a.1674266126.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 21/01/2023 01:55, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The git-rebase manual noted several sets of incompatible options, but
> we were missing tests for a few of these.  Further, we were missing
> code checks for some of these, which could result in command line
> options being silently ignored.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   builtin/rebase.c                       | 21 ++++++++++++++-------
>   t/t3422-rebase-incompatible-options.sh | 20 ++++++++++++++++++++
>   2 files changed, 34 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 2a5e0e8a7a0..6dcdb59bb02 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1238,6 +1238,17 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		if (options.fork_point < 0)
>   			options.fork_point = 0;
>   	}
> +	/*
> +	 * reapply_cherry_picks is slightly weird.  It starts out with a
> +	 * value of -1.  It will be assigned a value of keep_base below and
> +	 * then handled specially.  The apply backend is hardcoded to
> +	 * behave like reapply_cherry_picks==1,

I think it is hard coded to 0 not 1. We generate the patches with

	git format-patch --right-only $upstream...$head

so cherry-picks will not be reapplied. I'm hardly an impartial observer 
but I think the current check is correct. We support

	--whitespace=fix --no-reapply-cherry-picks
	--whitespace=fix --keep-base --reapply-cherry-picks

but not

	--whitespace=fix --reapply-cherry-picks

> @@ -1525,6 +1529,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.update_refs)
>   		imply_merge(&options, "--update-refs");
>   
> +	if (options.autosquash)
> +		imply_merge(&options, "--autosquash");

Thanks for adding this, it maybe merits a mention in the commit message 
though as it is a change in behavior for users who have 
rebase.autosquash set and try to use the apply backend.

Best Wishes

Phillip

>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
>   			imply_merge(&options, "--merge");
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index f86274990b0..c830025470f 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -50,6 +50,11 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --strategy-option=ours A
>   	"
>   
> +	test_expect_success "$opt incompatible with --autosquash" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --autosquash A
> +	"
> +
>   	test_expect_success "$opt incompatible with --interactive" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --interactive A
> @@ -60,6 +65,21 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --exec 'true' A
>   	"
>   
> +	test_expect_success "$opt incompatible with --keep-empty" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --keep-empty A
> +	"
> +
> +	test_expect_success "$opt incompatible with --empty=..." "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --empty=ask A
> +	"
> +
> +	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --no-reapply-cherry-picks A
> +	"
> +
>   	test_expect_success "$opt incompatible with --update-refs" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --update-refs A
