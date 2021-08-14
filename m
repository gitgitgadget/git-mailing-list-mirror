Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEFAC4338F
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 05:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BE6604DC
	for <git@archiver.kernel.org>; Sat, 14 Aug 2021 05:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhHNFvK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Aug 2021 01:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbhHNFvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Aug 2021 01:51:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6AC061575
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:50:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id hv22-20020a17090ae416b0290178c579e424so19115927pjb.3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OkgvHkqA6j2lGG7vCEGEFnUFzbLN+ugsmtRS6ij6pE=;
        b=USwsiSlEn6BRGFtr/MDSJf1a5De1U0eyGxmvnZZ+Fzuz5M1s4lH99d+1BhINL7bCaA
         2F+iG0Vi5OYZ2s0fbf23A8Qkr6jDrQWhqAEi+mjygttxQ9SFm2308VsThcqrHT2f7BGA
         FNe7qEEKRy9JvPOQ7voAbI6Dt7NVqajoItZ/u72FDQEnBKLbDpFwWQDLAaLCD1maJ6N2
         DbQ+YQNkYMYsnJBqO1lSbdfho45E0n4wqIcCrVUTb2Swva9ddf4swjJ5KhSRpXKnKY0w
         aQGuAHwOLxvyo9+agXKj/QQVKrN6saY4Rhig0pYZdxMgaFBtuomqVGNAiMyDuKu9R67c
         8QvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OkgvHkqA6j2lGG7vCEGEFnUFzbLN+ugsmtRS6ij6pE=;
        b=GdI6NybONznuf352mj+IkzeFmuFT0CZ9+HCqTGVqFIY5sdoeDXGGR6t6/5Uc7I3jl3
         N0HxYQL592xa5xxLl/UII+wATT9uFiJlk0zUQxk6svwdqxRcLeWRE89bPX4tt6JeqRTL
         Frgb0YRPo69L0Hcwc09AEoMaD1860aJ9hpDvuZa3vWDT9y+KfVWENsmzepyOj3paDvnW
         Dpe99JhkQfIa559fNIGGARAQkgbJRF+sPlmSSqSWjL12Uej9xiOKYw2uyFG4FMatZk4d
         +kapUHczwrg9eI+y+bUMjqDI3hCMxbtSKe1gHOFe1LKvZT+kAu0q14sy6L9WwfgvRZ1p
         ktHQ==
X-Gm-Message-State: AOAM530j54PiuYll/mMZhIg92HE1sv8lQoVe0CjhVvRAM674WYNLB9GZ
        xHyAq7VBl20xmha1A41AD2U=
X-Google-Smtp-Source: ABdhPJz9k5iliS60GdtY4vovINWNK/0DaoTkyRCiWhIQdihKxCgfBEnQWz5w7kaAfK+vUFnrh2vukw==
X-Received: by 2002:a17:902:a503:b029:12b:2429:385e with SMTP id s3-20020a170902a503b029012b2429385emr4889703plq.64.1628920241262;
        Fri, 13 Aug 2021 22:50:41 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-2.three.co.id. [180.214.233.2])
        by smtp.gmail.com with ESMTPSA id 16sm4170388pfu.109.2021.08.13.22.50.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 22:50:40 -0700 (PDT)
Subject: Re: [PATCH v2] help.c: help.autocorrect=prompt waits for user action
To:     Azeem Bande-Ali via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     David Barr <b@rr-dav.id.au>, Azeem Bande-Ali <me@azeemba.com>,
        Azeem Bande-Ali <A.BandeAli@gmail.com>
References: <pull.1012.git.1628640954160.gitgitgadget@gmail.com>
 <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <c3b9aac8-992c-30de-c6a1-852b81ddecff@gmail.com>
Date:   Sat, 14 Aug 2021 12:50:37 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <pull.1012.v2.git.1628917872724.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/08/21 12.11, Azeem Bande-Ali via GitGitGadget wrote:
>   help.autoCorrect::
>   	If git detects typos and can identify exactly one valid command similar
> -	to the error, git will automatically run the intended command after
> -	waiting a duration of time defined by this configuration value in
> -	deciseconds (0.1 sec).  If this value is 0, the suggested corrections
> -	will be shown, but not executed. If it is a negative integer, or
> -	"immediate", the suggested command
> -	is run immediately. If "never", suggestions are not shown at all. The
> -	default value is zero.
> +	to the error, git will try to suggest the correct command or even
> +	run the suggestion automatically. Possible config values are:
> +	 - 0 (default): show the suggested command.
> +	 - positive number: run the suggested command after specified
> +deciseconds (0.1 sec).
> +	 - "immediate": run the suggested command immediately.
> +	 - "prompt": show the suggestion and prompt for confirmation to run
> +the command.
> +	 - "never": don't run or show any suggested command.

Looks OK.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
