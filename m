Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728ADC636D3
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBFQ16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFQ14 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:27:56 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962C093F2
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:27:55 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o18so10937926wrj.3
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvGdNRINT63MyzYi9YoRfvJjV/E5kB7SRG53rLdW8XY=;
        b=Z4bNaHUZSuFduJunz+3O7sRImxaz5Ng0lqThEKwmpGaVAfynsBk1J56aSGgs/ue/C3
         XdRa4oHN7qCzzHin04xNMVJ8JBfkFMTuW2WXpMSyY4dKw6TzTdA1+t4vkzyJvF5m6TJK
         Qmmy62ue4nr9agyy6NuEWMnXBA2zWnDM4vkKMbRGd0J88QfjE/GFMKxqU46T+hbZoAXO
         c4migBu89xtWndxdu8w/yoYtFrCK8YDIa7Ymld6s2MpZg1zTZVIEcAexzGS97UASxrGp
         YuArq7qebO6aW5L7IdqgId4Uv84d4+LKhD0m6Zt1Rhaq53M5Jt+0ePn7FvB8gmNtbrVi
         Ka7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvGdNRINT63MyzYi9YoRfvJjV/E5kB7SRG53rLdW8XY=;
        b=RM7vNoMuhMD3IoaBzsfez8Xqo55Q7tfymzNDyyXPnMqU8MjYpfrrakpUZ+fJTALGVp
         M4oPlVHoRtXt8gxWTBVTSYWNedewgo9fKDet34EzGOmNo2/q2qb8jGrq7Wugm+IFIL7S
         HlCw0rY56+8AxjIZNfwUzWhNuuJodgWzLiF5ulOliweJx9b/AyIBkui9aWw7XPq6WyNj
         k7Pl+JC3rIXma8bMtpyJ4dDm1JlPoQpZ17BrQUV07yG34l99kGzZQKMb0W5yIWJLhGzM
         yOg94IlHWELi7a7Tpvp5Si/tbDPT91VTo0QL41UiOhbaCrIi7QZXLzDXbu0xHVqjTy1m
         s6Og==
X-Gm-Message-State: AO0yUKWErcxiKRkk30Jshy965ihnhTBjrImxZlqgCCHmxQD29Nen11+/
        o/1aQLPNycj5EDUnGIx/m64=
X-Google-Smtp-Source: AK7set8Si85xDcsqQUlNNRq57MbZniztg6TDkxta9p01KObQHlFZc3KsejPWEW7hPUU+cyRev4CXmw==
X-Received: by 2002:a5d:6312:0:b0:2c3:e8a3:adda with SMTP id i18-20020a5d6312000000b002c3e8a3addamr3972299wru.66.1675700874040;
        Mon, 06 Feb 2023 08:27:54 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4572000000b002c3e7474b0fsm3632871wrc.13.2023.02.06.08.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:27:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <19f6b40b-d8e8-e86c-5a9a-b35f42909118@dunelm.org.uk>
Date:   Mon, 6 Feb 2023 16:27:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
In-Reply-To: <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 05/02/2023 03:46, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> It can be useful to specify diff algorithms per file type. For example,
> one may want to use the minimal diff algorithm for .json files, another
> for .c files, etc.

Have you got any examples of why this is useful? I find myself 
occasionally changing the algorithm when the default gives a sub-optimal 
diff but I've not really noticed any pattern with respect to file types.

> Teach the diff machinery to check attributes for a diff algorithm.
> Enforce precedence by favoring the command line option, then looking at
> attributes, then finally the config.
> 
> To enforce precedence order, set the `xdl_opts_command_line` member
> during options pasing to indicate the diff algorithm was set via command
> line args.

I've only commented on the tests as it looks like Eric and had a careful 
look at the code

> diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
> index 8d1e408bb58..630c98ea65a 100644
> --- a/t/lib-diff-alternative.sh
> +++ b/t/lib-diff-alternative.sh
> @@ -107,8 +107,27 @@ EOF
>   
>   	STRATEGY=$1
>   
> +	test_expect_success "$STRATEGY diff from attributes" '
> +		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index file1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
>   	test_expect_success "$STRATEGY diff" '
> -		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
> +		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "$STRATEGY diff command line precedence before attributes" '
> +		echo "file* diff-algorithm=meyers" >.gitattributes &&
> +		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
> +		test_cmp expect output
> +	'
> +
> +	test_expect_success "$STRATEGY diff attributes precedence before config" '
> +		git config diff.algorithm default &&
> +		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&

This test passes with or without the code changes in this patch. I think 
you need to drop --diff-algorithm=$STRATEGY from the diff command.

>   		test_cmp expect output
>   	'
>   
> @@ -166,5 +185,11 @@ EOF
>   		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output &&
>   		test_cmp expect output
>   	'
> +
> +	test_expect_success "$STRATEGY diff from attributes" '
> +		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
> +		test_must_fail git diff --no-index uniq1 uniq2 > output &&
> +		test_cmp expect output

This test also passes with or without the code changes in this patch. It 
  is the same as the first test added above but with files that give the 
same diff irrespective of the algorithm chosen so I don't think it is 
doing anything useful. Unless I've missed something it should be dropped.

Best Wishes

Phillip

> +	'
>   }
>   
