Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8857C3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 19:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjAETY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 14:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbjAETYR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 14:24:17 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1783963F7D
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 11:20:25 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j16so30777972qtv.4
        for <git@vger.kernel.org>; Thu, 05 Jan 2023 11:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RWZiANnooLSWH84Ky1e6Elis3K4m0HHfCagv9d67b8E=;
        b=WM6VjwKh2gBG1nMHiBH46h1LD00HUREILD/e4u1k85DnoOjbzNm1fKnPkVh3aM0V+2
         oDkfKAKlG/NcXzEhruztx0eB524ikasfTjGZVia4YCgqktgoUFLgYOtdFJnfNz0j2JdW
         v/NKigiwoInipMXsHHc+mybjbMTdC1QvFXNMfOVJwRpZEbCkJz9ef56t72Vokv/1Vn12
         03RQ79Jq8686WhnNNLpWMsD+WZnc1pkjISZJY+qeMN1wPV5y4z7cWSRIJfkewAH/vzVC
         U0Hl2j+n5dM0TJPK+UpKNSpX+tdtml9fD6G48aibHr1N0nT7TTFBxq03xbxvnqFT1t2K
         wtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWZiANnooLSWH84Ky1e6Elis3K4m0HHfCagv9d67b8E=;
        b=6NnishpDPrab5136w1V/wbtgqWNRAgxxpK74zBUsr93eA55EoY6GDIAyilZLXC52pY
         hVXWYiqSqQNxKHUv++gC8PRutZcmUpKbs1vYRmKKKFi2Tze91ZRFCA+vBJ6Nk0kh4WEp
         2FSBvh2FMu96poYDgA5ezeKPvlI2dafO6okxMAhFOBrQ6jPd0nkzB50FYMw71Mg3i6GB
         ZiWRfmk3/a2IdM7pVql6BYG4+AlXRTKtFU/K2T0TPcBSb/hpzhT2ttZzo8M0VrXdamZ0
         Bq82SmTa5UrtnBF34f8qQNE25tdSigUeTLqthKZvxLq/AxRftDTXH4XHA6RvIVZ/hHdL
         4mJg==
X-Gm-Message-State: AFqh2koTGJmGd6wYiuKK36/BcKqZkoy7DyfDx4aGpTs9qV2zc6fPXDYy
        PrGXZWS2PteOPFFlyTwwqtfQ
X-Google-Smtp-Source: AMrXdXs/e70FJZWeK332an5Ba8ODWoB0AYFa9oSp8J5ws3qG33ru7IXopJCq7GTpuy/fAY2Ub9Rppw==
X-Received: by 2002:ac8:460c:0:b0:39c:da20:616 with SMTP id p12-20020ac8460c000000b0039cda200616mr78004883qtn.32.1672946352370;
        Thu, 05 Jan 2023 11:19:12 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:64ab:8abc:361c:e8c7? ([2600:1700:e72:80a0:64ab:8abc:361c:e8c7])
        by smtp.gmail.com with ESMTPSA id r12-20020ac8520c000000b0039a55f78792sm21984408qtn.89.2023.01.05.11.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 11:19:12 -0800 (PST)
Message-ID: <1f8493b0-3f96-c616-1e4e-98b6ed33e8c4@github.com>
Date:   Thu, 5 Jan 2023 14:19:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v2] scalar: show progress if stderr refer to a terminal
Content-Language: en-US
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.1441.git.1670436656379.gitgitgadget@gmail.com>
 <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1441.v2.git.1671974986363.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/25/22 8:29 AM, ZheNing Hu via GitGitGadget wrote:
> From: ZheNing Hu <adlternative@gmail.com>

Sorry for the long wait in getting back to reviewing.

> Sometimes when users use scalar to download a monorepo
> with a long commit history, they want to check the
> progress bar to know how long they still need to wait
> during the fetch process, but scalar suppresses this
> output by default.
> 
> So let's check whether scalar stderr refer to a terminal,
> if so, show progress, otherwise disable it.

Thanks for updating to this strategy. I think it's an
easier change to swallow. We can consider options like
--progress, --verbose, or --quiet later while this
change does the good work of showing terminal users
helpful progress.

> +	int full_clone = 0, single_branch = 0, show_progress = isatty(2);

> -	if ((res = run_git("fetch", "--quiet", "origin", NULL))) {
> +	if ((res = run_git("fetch", "--quiet",
> +				show_progress ? "--progress" : "--no-progress",
> +				"origin", NULL))) {
>  		warning(_("partial clone failed; attempting full clone"));
>  
>  		if (set_config("remote.origin.promisor") ||
> @@ -508,7 +510,9 @@ static int cmd_clone(int argc, const char **argv)
>  			goto cleanup;
>  		}
>  
> -		if ((res = run_git("fetch", "--quiet", "origin", NULL)))
> +		if ((res = run_git("fetch", "--quiet",
> +					show_progress ? "--progress" : "--no-progress",
> +					"origin", NULL)))
Implementation looks correct.

> +test_expect_success TTY 'progress with tty' '
> +	enlistment=progress1 &&
> +
> +	test_config -C to-clone uploadpack.allowfilter true &&
> +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
> +
> +	test_terminal env GIT_PROGRESS_DELAY=0 \
> +		scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&

Thank you for creating this test!

> +	grep --count "Enumerating objects" stderr >actual &&
> +	echo 2 >expected &&
> +	test_cmp expected actual &&

I think you could use "test_line_count = 2 actual" here.

> +	cleanup_clone $enlistment
> +'
> +
> +test_expect_success 'progress without tty' '
> +	enlistment=progress2 &&
> +
> +	test_config -C to-clone uploadpack.allowfilter true &&
> +	test_config -C to-clone uploadpack.allowanysha1inwant true &&
> +
> +	scalar clone "file://$(pwd)/to-clone" "$enlistment" 2>stderr &&
> +	! grep "Enumerating objects" stderr &&
> +	! grep "Updating files" stderr &&

Here, it would be good to still have the GIT_PROGRESS_DELAY=0
environment variable on the 'scalar clone' command to be sure
we are not getting these lines because progress is turned off
and not because it's running too quickly.

> +	cleanup_clone $enlistment
> +'
>  test_done

A nit: there should be an empty line between the end quote of
the last test and "test_done".

Thanks,
-Stolee
