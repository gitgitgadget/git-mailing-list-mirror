Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FEC6FA82
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 20:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiIZUt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIZUt4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 16:49:56 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C67A1B787
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 13:49:53 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id d8so6232166iof.11
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 13:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y2gNPgr8tprFBEAV+pByW9uX7xohgWElHJMjaT0GJ/4=;
        b=QOmAp1aOk69kIQD3/ci/8SoPtqiq9xTm25qDJtwL0uAQlttUs1lPHcRP7kKnrvdFXF
         QULU7zGbucjl1AFVvYUWYBGsUKy3VWiT0dicqI3JSGKNdWRgv+VtYXf9QmwXpLgQoSls
         M5xlbxscEjQiPQ/PGdBUkluYN+hnTFt9w6N+i07FT5DsGmzjkzaJeIP71QQa/5CkSJCy
         P5tid0uI1zVkpKLKoqtuBEPxQuBlRtNgXcERidjXvFoPd3n5RhudkYgMCKbNntKPoh4W
         CzJsoehcxxoPyt4nO1pt2pOJ1byg9rIHOvM/DjD32fW630kpOtvNecLzTshx/PeG0Wd1
         1qiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y2gNPgr8tprFBEAV+pByW9uX7xohgWElHJMjaT0GJ/4=;
        b=7F1nECXWUl4q4+b3H+l1/Rww/7GMMZukNUYYH1eHHJXWyCRPW52mtqAx9TXTmeM0dA
         rChMTFiQhrfvV2q92nlhVlX5Odr0M5iraw3AB/G/YTU23t7U2rxGaCJLb8neyXUDp1JY
         dZJtQkikNk3I8TodYBQxO/wNBlVmlNa6aCQ2Wlu9dtV+dOo1T2c+igYXGc9PI4tumT85
         8ZOvBvJa2GjhuXfE9371UUksGCgw5AjtWKxapOZJIs+dYWUhnWAbkWNV/amJS1pgxuyu
         TsFcDU2jffo7HwFB6iFVqK3aYwAvqfwMTwK1eUUEJ+bTqCWkuPMVyIob53pfPhkzakwX
         Fdig==
X-Gm-Message-State: ACrzQf1XIyM0YfT+laRzraiAZj9zPcKrCsCU7DuAvU1m1rJJvFPxf7gd
        ElJRoJ8dozO/nJxcNhJ9TR0lWiq1/A0O
X-Google-Smtp-Source: AMsMyM4ocybTKg+D8NDT20vGXJoFW8alBe0EIoeVF+i63Ac64YnTdFLMmvS+g9vxGvrTYYl75P7/yw==
X-Received: by 2002:a05:6638:1655:b0:35a:6ee2:402d with SMTP id a21-20020a056638165500b0035a6ee2402dmr12703088jat.138.1664225392948;
        Mon, 26 Sep 2022 13:49:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4177:874e:9632:3b2a? ([2600:1700:e72:80a0:4177:874e:9632:3b2a])
        by smtp.gmail.com with ESMTPSA id q4-20020a02a984000000b0034e9ceed07csm7534947jam.88.2022.09.26.13.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 13:49:52 -0700 (PDT)
Message-ID: <03f26dc6-85c7-1ce9-67d6-b4325e9e6d52@github.com>
Date:   Mon, 26 Sep 2022 16:49:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/3] maintenance: add 'unregister --force'
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <pull.1358.v2.git.1663853837.gitgitgadget@gmail.com>
 <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
 <8a8bffaec89e55da0c5bcac2f04331e0d4e69790.1664218087.git.gitgitgadget@gmail.com>
 <xmqq7d1qndn7.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq7d1qndn7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/26/2022 3:23 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> @@ -11,7 +11,7 @@ SYNOPSIS
>>  [verse]
>>  'git maintenance' run [<options>]
>>  'git maintenance' start [--scheduler=<scheduler>]
>> -'git maintenance' (stop|register|unregister)
>> +'git maintenance' (stop|register|unregister) [<options>]
> 
> An unrelated tangent, but should register complain when given in a
> repository that is already registered as well?  Just being curious.

Let's leave that as a #leftoverbits and perhaps as something to
consider next to something like 'git maintenance list' to list the
currently-registered repositories.

Thanks,
-Stolee
