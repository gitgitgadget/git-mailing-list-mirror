Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE5FC433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 12:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347327AbiDZM5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 08:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235085AbiDZM5E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 08:57:04 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327A017D4A0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:53:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id z26so1230037iot.8
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 05:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XNUB13pcEHeQQpo/o7T7E83KsQVA6bvuJ5kCZP/dnLM=;
        b=GGKgQJ8WdRWhBZeoqREa8pbcsRDteCf2Y3AI6e4gbI52k4bRD0TqRCkNbRhmnNeuy3
         CVUGWh4iMuRVMjoFA7slnsmu3qeVRWMJVf9Z79/MbTvwzPCa10s0Ii6lQ9FFg+gxqTXi
         3fnxaKfGzemcENWE/cu4Q83f1iPP9b4st9PEqKvUOrqCiZNXddqW7taTVlq1Snb4sde9
         AYow1jHtUnPDJ6tKiQ3w24RAlzSvUSQ9p8n82NG4xKnRE3TSkuq8ha0q3GzKC8N80y0c
         x0xzkZJCDnD/hJaIHVyAqU354eJiZmvhOS/atag/YF77gwYKgiD7PdITwcmKohYy48CV
         n98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XNUB13pcEHeQQpo/o7T7E83KsQVA6bvuJ5kCZP/dnLM=;
        b=PrIrX0RpsKx3HTbWqFQ3+auic/dSHyFQXmVMoBpVOB2b6CYVaZwKARqRsCpM0GKe+h
         tmnoY+Ri91pO9Vcs2716CmMriZ/lYNwC8+P2X7lX+zrHppI9AuUD7tjv7zM0cUiZseU3
         7+lFq1lj2ybmqhB2MiqptszBG9uuR9jmHapD6aFXRrgIOVgpb/BOepDZyJQAJ3B5/C3+
         jZ5iLYh1Qd3y0Fa78h/huwjj2RwKQ/yZ5gfb+8eTu2TjiyFcw+OWhMCs7MU2arN58+e9
         pAa6xBsLUR17RJWo2jSbNnCf+hYGF/CxRp3fLoFe51s2/vDf5uYzGakOHqvkeKUFkBvl
         8GNg==
X-Gm-Message-State: AOAM532I6iulo1LPE0233W//Ek36t3J/csd4w3NShJLIrxriFpzLIDQu
        AUcl/zZYSbFrr4BYJ5WgWc4q
X-Google-Smtp-Source: ABdhPJxZbpO1J7J4Mod9BTrdrOSzhQ/xhVDCaFs66rsFfDFvkaUK4QOX4Hmtl0L4kHDOTAMXWPR5VQ==
X-Received: by 2002:a05:6602:2dd0:b0:657:38e8:3b36 with SMTP id l16-20020a0566022dd000b0065738e83b36mr9773505iow.201.1650977634498;
        Tue, 26 Apr 2022 05:53:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a3:141e:f20d:6edf? ([2600:1700:e72:80a0:a3:141e:f20d:6edf])
        by smtp.gmail.com with ESMTPSA id x186-20020a6bc7c3000000b00648deae6630sm9741177iof.54.2022.04.26.05.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Apr 2022 05:53:53 -0700 (PDT)
Message-ID: <f332fec9-da00-0063-4c88-765fa3639ea1@github.com>
Date:   Tue, 26 Apr 2022 08:53:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/7] stash: integrate with sparse index
Content-Language: en-US
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, Victoria Dye <vdye@github.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
 <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <f6cf05a5bee9e4ebc174bab0385a13cc1cdb4014.1650908958.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/2022 1:49 PM, Victoria Dye via GitGitGadget wrote:
> From: Victoria Dye <vdye@github.com>
> 
> Enable sparse index in 'git stash' by disabling
> 'command_requires_full_index'.

>  ensure_not_expanded () {
>  	rm -f trace2.txt &&
> -	echo >>sparse-index/untracked.txt &&
> +	if test -z $WITHOUT_UNTRACKED_TXT

Do we need quotes around "$WITHOUT_UNTRACKED_TXT"?

I mean, I suppose we don't since the tests pass when this variable
is unset, but I think it is a good practice to be careful about
empty variables. Or am I wrong?

> +	then
> +		echo >>sparse-index/untracked.txt
> +	fi &&


> -	ensure_not_expanded checkout-index -f a &&
> -	ensure_not_expanded checkout-index -f --all &&
> -	for ref in update-deep update-folder1 update-folder2 update-deep
> -	do
> -		echo >>sparse-index/README.md &&
> -		ensure_not_expanded reset --hard $ref || return 1
> -	done &&
> -

Moving these to be within the stash tests is interesting.

> +test_expect_success 'sparse-index is not expanded: stash' '
> +	init_repos &&
> +
> +	echo >>sparse-index/a &&
> +	ensure_not_expanded stash &&
> +	ensure_not_expanded stash list &&
> +	ensure_not_expanded stash show stash@{0} &&
> +	! ensure_not_expanded stash apply stash@{0} &&
> +	ensure_not_expanded stash drop stash@{0} &&
> +
> +	echo >>sparse-index/deep/new &&
> +	! ensure_not_expanded stash -u &&
> +	(
> +		WITHOUT_UNTRACKED_TXT=1 &&
> +		! ensure_not_expanded stash pop
> +	) &&
> +
> +	ensure_not_expanded stash create &&
> +	oid=$(git -C sparse-index stash create) &&
> +	ensure_not_expanded stash store -m "test" $oid &&
> +	ensure_not_expanded reset --hard &&
> +	! ensure_not_expanded stash pop &&
> +
> +	ensure_not_expanded checkout-index -f a &&
> +	ensure_not_expanded checkout-index -f --all &&
> +	for ref in update-deep update-folder1 update-folder2 update-deep
> +	do
> +		echo >>sparse-index/README.md &&
> +		ensure_not_expanded reset --hard $ref || return 1
> +	done

It is not obvious why that's necessary here. Perhaps a later
change will build upon these checkout-index commands within
this test?

Thanks,
-Stolee
