Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F81C4363D
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94DE5206DC
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 12:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JKM1fzbA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387792AbgJBM5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 08:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBM5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 08:57:13 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E69C0613D0
        for <git@vger.kernel.org>; Fri,  2 Oct 2020 05:57:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id u25so1234675otq.6
        for <git@vger.kernel.org>; Fri, 02 Oct 2020 05:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+oW7FhNvwIsrb4J8mIsro+t49HptSAWI0DWefeitxGw=;
        b=JKM1fzbA7VhsWZAIOiWrSpYaEfcjMzwntTAmxp2O/ZAvEpiqIIVFbGej35zyudGhI7
         TgrPhy48Bsapv1sMBldHrJwcCMkiAlaWv9nLoswf/zHagnLgvOCmXV15V4RsDZpiKMDS
         Z+Mn0V7L+EgN6Bp9VKq5P2Vc/XsuOFOGwFCZKmtc35g/XoxHLOKsba1hToCqG26m3Mq3
         LaaOOkOgVcsnH9jpgK5o7kO2zFOqZEdTRFtcvWq53IOeMzwfVChuB68gpVn/HYL/T6K3
         dE1w/JQ9GGOfp28U+7DejVKpy4kktb51G64ysfR6lPF4CwpjmfGNj0hO7x3qnvM7OTlr
         8e2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+oW7FhNvwIsrb4J8mIsro+t49HptSAWI0DWefeitxGw=;
        b=bNP5vuNdza84I2xUw8MkTKAKYfQcyPGrm3sE4fhHhC6+VTthjkRUXEr0xieNukyWs2
         pL8d9P2Vl3YqKgF0Pot9o89C4Ic/L9WB4VX4POz0z1KwSlgliYu+dAErTEqVx4epSdVs
         u8l4Z4NIvgIbNH8NjI2LYXc0FQdR2ARa40P5pVe3YA4MZTxaZKa8VJzZteM2S3BvPrsC
         YBZ6H4LJYA1aZLqSGCpd08NcmwBvezzYmknu9t1XwygXzT2i4kU5WHTjg2ZCvyr6+35N
         1hn2SrxmLYYNT1grAXrjHPI3hqQ7PtF8LECVO1Wkq/5dPhp40FpAJk9eVYv7pChUq8Uc
         1IgA==
X-Gm-Message-State: AOAM533WntQAGgTGZFe/i13uA/WJXs2h1qnQp2mpsq1x1om51ssRQ/QO
        c2e90hXYX8yd3VAHtozWHF0=
X-Google-Smtp-Source: ABdhPJxKzcTFEEE+Npl5yvOANrdUJpNu4TIUYV89hxUyvsR41jb1vJn5lnnYLB5njnqoSTo7K8aDOA==
X-Received: by 2002:a05:6830:1509:: with SMTP id k9mr1491911otp.226.1601643432327;
        Fri, 02 Oct 2020 05:57:12 -0700 (PDT)
Received: from [10.0.0.16] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id d28sm403434ooa.7.2020.10.02.05.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 05:57:11 -0700 (PDT)
Subject: Re: [PATCH v3 0/7] clone: allow configurable default for -o/--origin
To:     Sean Barag via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>, Sean Barag <sean@barag.org>,
        Andrei Rybak <rybak.a.v@gmail.com>
References: <pull.727.v2.git.1601350615.gitgitgadget@gmail.com>
 <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3225fd9a-6b44-8c9c-52a9-614ee8470a8c@gmail.com>
Date:   Fri, 2 Oct 2020 08:56:55 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <pull.727.v3.git.1601523977.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/30/2020 11:46 PM, Sean Barag via GitGitGadget wrote:
> v3 (changes since v2):
> 
>  * [5/7] fix compilation error: validate option_origin since remote_name
>    doesn't exist yet
>  * [7/7] remove default_remote_name; apply default value inline if no other
>    value applied
> 
> v2 (changes since v1):
> 
>  * Convert Thanks-to trailer to Helped-by
>  * Rewrite several commit titles and messages
>  * Unify error reporting between clone.c and remote.c
>  * Add tests for git remote add and git remote rename with invalid remote
>    names
>  * Prevent leak of old remote_name

Sorry for being late to these versions, but I think
the changes across these two versions are excellent
improvements. I'm happy with this patch series!

Thanks,
-Stolee
