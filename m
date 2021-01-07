Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612B3C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A901216FD
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 11:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbhAGLJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 06:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGLJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 06:09:55 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204BCC0612F4
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 03:08:30 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id l7so2576733qvt.4
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 03:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bNvGn4tr1Ho0nQIFeW6Y+TGXUzk4fhju7xACeSuRmCI=;
        b=BxrBi7So25sDQdM8L3yxmgzLwNoyMpTH24A2nMcSJUcAV/u7ID+ULyN+IaV8GHumXC
         8t3kXNJRxQpkyRW7f1/zU2+Nf0O9OaX3wFS3DnoUA+Y9MZ6LAl7IBilNlLR3OuJqAELn
         5zSjdWYpROOoc7TkshBgGXuF9+KPhAbRRHLpibY+mkSguQ7k7HvIq9F2Lkp5KADGjp/d
         dSBeZTKwCguD2Z82rEPXHppulEs03L84qsjFwGhAR5eYTwTAUmIBanqzTx/nUsqhGql3
         faaVhLFQxMGH7L/Q+gJ8DE2p+3VVjzXfr5PrRSDbtTmIqIrCccxkNFFLKJBLKv2/KOsB
         psbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bNvGn4tr1Ho0nQIFeW6Y+TGXUzk4fhju7xACeSuRmCI=;
        b=JWNI7K8S4ChQpCEqo5/62+DJQXXAvoXyYlMmN54LmpqxLE9aajNw//LCD+XN32zWfb
         iILd7VOdg1lP+pqUXtZUR+d+Y/m+biLaGmWShhwZsU4eU5l5YJMVm9aUDbY/iu09+zC+
         gU8+zwTvY+6dGgHR+P/wrg5pwZsJHxWZxyyC2a/mPWPpa1tljCUIH4C03OvMX0cmFDzI
         lMedDa7F3I0mctieyCcoCgq8EJu7ElBVj/fzX923vTTmZpPIA2oimLynrO8i/lR2/J24
         JHPpiNBRHBwkqxlweFm6SNangJhch+FKUE3F6IkDJBbT8Ar3YnYS+P7KfguabgPCiFYR
         T+AA==
X-Gm-Message-State: AOAM532AKnayhuJFSe1JI9ik7i6ZyTYngDNpDmAyRuiEBao2KSuSOiuU
        RJ4iW2B3BGYOeuzbXxc6M8k=
X-Google-Smtp-Source: ABdhPJyBaN3Njoe7dWr+GX5E7JeTHShH0qm7h67eof+MSHQD1TscNNfG0BVLic7oULDZaQW0i2SjMg==
X-Received: by 2002:a0c:df94:: with SMTP id w20mr8057734qvl.33.1610017708939;
        Thu, 07 Jan 2021 03:08:28 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id x20sm2881022qkj.18.2021.01.07.03.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 03:08:28 -0800 (PST)
Subject: Re: [PATCH] revision: trace topo-walk statistics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.828.git.1609302714183.gitgitgadget@gmail.com>
 <xmqqh7nto7ck.fsf@gitster.c.googlers.com>
 <cbc17f1b-57fc-497f-f1ab-baa8cc84620d@gmail.com>
 <xmqq7dopo4xb.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ed723456-fb5d-74f4-26f0-0b37071ff212@gmail.com>
Date:   Thu, 7 Jan 2021 06:08:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <xmqq7dopo4xb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/6/2021 9:29 PM, Junio C Hamano wrote:
> But different subsystems would have different "per-invocation"
> structure (e.g. "diff" uses "struct diff_options") and some may not
> even have an appropriate structure to hang these stats on.  We may
> want to design a more general mechanism that can be used to annotate
> the subsystems uniformly.  While that could be a worthy longer term
> goal, it certainly does not have to be part of this single-patch
> topic, I would think.
 
I will give this further thought.

Thanks,
-Stolee
