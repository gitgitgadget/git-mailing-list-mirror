Return-Path: <SRS0=jwDG=D4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D25C388F9
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 222D220BED
	for <git@archiver.kernel.org>; Wed, 21 Oct 2020 13:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grFR9p1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439134AbgJUNln (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Oct 2020 09:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410476AbgJUNlm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Oct 2020 09:41:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779DC0613CE
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:41:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so3096360wrp.10
        for <git@vger.kernel.org>; Wed, 21 Oct 2020 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q38srXjvVRm/NTpV8i0Y218ni3OvL/d+AYbsgHQgt3g=;
        b=grFR9p1dgnGEl4DzM2KvtKnARJlNKnvo9n1EWQ3Yt00yIKK0bGaTEV8M9MZxTIkfL+
         I9iimo+FMXfi3hOTE6haAXbEN6iylsK8xjwZW3B5FIFAthqkxY5PRBW5aOM+FM0KNY/z
         iTcej7Wp3bPZIv0PcPKV5W8SDykJvLZYZDbSy5BrXznxk7lB1+0AOdRsPnwBQy9dOHZz
         wt6YU1/7Mp8y2RSdCCGNqW8IuzcFPm64XyO2HeH+9rwKtLUiGvWkIeIYGfQ0IOncZM13
         ECsPDDUL7WqZK0QMPP2jpVlgZGdVkimyTXWXFRwAFZNYVTUnBjMgDTh59eauJ2QK+11z
         WwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Q38srXjvVRm/NTpV8i0Y218ni3OvL/d+AYbsgHQgt3g=;
        b=GfYg+vSx9Tgb0VRy7Jfgf2TuHiUu0eUxKbFobAOts9t0AC5Y9RQmrcRHT9OHg4CZ5Q
         b03iWOmHCpBDljt/U+TOWUwR6iKwKIQfASs52XLT1XpFsRSvTrgoLc+VjUgV13Cfn51L
         xMm2AxhkFB2/YTAfVeJKcJf4kHxoVjHusImGqOnhwU33vPDzabtp53x1Quc/ckpmGdRa
         3myUGeYaT4YT32IRsbVokgdzGE0R2J8Iw+KEwa9phHjMrIaRS9w711cDLM9fvNfrqqDz
         +jjZqYFHO/uETOLvTc7+a7dURRGr16Z9forr4vJCXkrkIzClPBOcWU4rza2UPkteV7GE
         6OTg==
X-Gm-Message-State: AOAM53388Vo0m0pZbN/hOYPXChb4QAVzxFklKW8aM9yZM+oLMv95XDME
        FwnfsnEWD3g1VuHMGtCioXk=
X-Google-Smtp-Source: ABdhPJyyTCOMsQ1t7NoqhWtlfYgr5d3qF2hDrySui3fDbL3YdzXYh3OssNTtIH8SnR4o7Nnou91PAw==
X-Received: by 2002:adf:f2d1:: with SMTP id d17mr4880187wrp.122.1603287701293;
        Wed, 21 Oct 2020 06:41:41 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id a3sm4431289wrh.94.2020.10.21.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 06:41:40 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH][OUTREACHY] bisect: allow `git bisect` to run from
 subdirectory
To:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Sangeeta <sangunb09@gmail.com>
References: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <2f71d0c4-a5de-c22b-9cbe-a9efcb3cd21d@gmail.com>
Date:   Wed, 21 Oct 2020 14:41:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.765.git.1603271344522.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

It's great to see you tackling another patch

On 21/10/2020 10:09, Sangeeta via GitGitGadget wrote:
> From: Sangeeta Jain <sangunb09@gmail.com>
> 
> As `git rebase` was never prevented to run from subdirectory we shouldn't
> prevent `git bisect` to run from subdirectories.

I'm not sure it's relevant to bisect whether or not rebase can be run 
from a subdirectory. What is important is that we want all commands to 
be able to be run from a subdirectory unless there is a good reason not 
to (and there isn't for bisect)

I'd recommend adding [Outreachy] to the beginning of the first line of 
the commit message as well.

> This commit removes the
> restriction on git bisect to run only from top level directory thereby
> allowing it to run from any subdirectory.
> 
> Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
> ---
>      [Outreachy] bisect: allow git bisect to run from subdirectory
>      
>      As git rebase was never prevented to run from subdirectory we shouldn't
>      prevent git bisect to run from subdirectories. This commit removes the
>      restriction on git bisect to run only from top level directory thereby
>      allowing it to run from any subdirectory.
>      
>      Signed-off-by: Sangeeta Jain sangunb09@gmail.com [sangunb09@gmail.com]
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-765%2Fsangu09%2Fbisect_fix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-765/sangu09/bisect_fix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/765
> 
>   git-bisect.sh               | 1 +
>   t/t6030-bisect-porcelain.sh | 7 +++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ea7e684ebb..9cd0fa0483 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -32,6 +32,7 @@ git bisect run <cmd>...
>   Please use "git help bisect" to get the full man page.'
>   
>   OPTIONS_SPEC=
> +SUBDIRECTORY_OK=Yes
>   . git-sh-setup

`git bisect run` takes an optional script that is run to determine if 
the current commit is good or bad. If the script is given with a 
relative path then we need to make sure it is invoked from the 
subdirectory that `git bisect run` was started from. As far as I can see 
git-bisect.sh does not change directory but it would be good to have a 
test for `git bisect run <cmd>` from a subdirectory.

Best Wishes

Phillip

>   _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
> index aa226381be..6b68cc01d0 100755
> --- a/t/t6030-bisect-porcelain.sh
> +++ b/t/t6030-bisect-porcelain.sh
> @@ -49,6 +49,13 @@ test_expect_success 'bisect starts with only one bad' '
>   	git bisect next
>   '
>   
> +test_expect_success 'bisect runs in a subdirectory' '
> +    mkdir -p subdir &&
> +    git -C subdir bisect start &&
> +    git -C subdir bisect good &&
> +    git -C subdir bisect reset
> +'
> +
>   test_expect_success 'bisect does not start with only one good' '
>   	git bisect reset &&
>   	git bisect start &&
> 
> base-commit: 69986e19ffcfb9af674ae5180689ab7bbf92ed28
> 
