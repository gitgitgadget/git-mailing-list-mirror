Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC477C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 20:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbiKGUut (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiKGUuq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 15:50:46 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3E327CC5
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 12:50:45 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id c8so8948189qvn.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 12:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d292BFttCGGlJb+3WMEsswVyNh2OkDxnlwAoBZ7vfRM=;
        b=ZPd3ML8cP/20n6aGHtD6LHNmH3G6zPFsJOFrCftTJT7lwn/V+Rq4GYIFqKxbTp4ud/
         wTvQb+sgFXTNWdNqdh9ek4KxTUX0MlEkKUJKqveW4Omjx3dljoATwIkFRpS6/9462fX5
         kYe8lXQioPq+/tFbREAQVPCFyHyCw7GwtgUS1vUvRClvYsqQenOvwGIefSbE8RYJZNz4
         W/VkqIPBzf6Y0eJEZa0JGjySReMqND23rNYQNJBVnFHWrRa/evhstq/Ggfopg0CTORDX
         O0juQzPCqYWvj+rKW/fbIiw+eeBOHWSdkWB1LQoKRPjy6CjDFh6qTqutIotFCTljKS46
         oeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d292BFttCGGlJb+3WMEsswVyNh2OkDxnlwAoBZ7vfRM=;
        b=ag1vk0pRIHpeduXB03jQLSsxBZPWzuBoIWou0ycjqLUoaKG2Xo9w9x6SREkLgzQsOP
         pYaEsSDm1wdJJj6fV+ySGnL11LtTXW+FNx73LZ5BN/NC+EyeQfNafDWueZCPJWv3LPwS
         IoloSMENa2Yfzg9yARvY8cGvRe+SGXT0n2YP6bWmDVlSgnxb+hh/zh2UQflUKH7PMZJl
         jML1ightCQEpxPhJ6maF+En4fl6Cro33FVcxQ3UljOEXbF4X2eeBcyw8B+ohvWD4fx8p
         DHzWAlxK/JKSWe9JpAivz1qW5+/GPrcsXukjO0Lz90mWyergGNwtkMrRLswrr+KmHHk6
         0/RA==
X-Gm-Message-State: ACrzQf3o3dCATEYbAcS/dD8JbiTEPJrLMxRUz7UrSm9/L+/J13sZEr8y
        H5nuXnecRqJTxq8sTK4CiJPs
X-Google-Smtp-Source: AMsMyM5DmqxA6zknvRlCMbQbv/gmGmIuNjq1tK82jm21uddOn4aB/VybVAaP81kLwGt9FHrd826jdQ==
X-Received: by 2002:a05:6214:260b:b0:4bf:e864:bdd1 with SMTP id gu11-20020a056214260b00b004bfe864bdd1mr21145869qvb.5.1667854244536;
        Mon, 07 Nov 2022 12:50:44 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id s26-20020a05622a1a9a00b0039a610a04b1sm6860072qtc.37.2022.11.07.12.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:50:44 -0800 (PST)
Message-ID: <b0483b03-518a-ee97-c561-cc941521451e@github.com>
Date:   Mon, 7 Nov 2022 15:50:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v4 0/2] index: add trace2 region for clear skip worktree
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Anh Le via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Timothy Jones <timothy@canva.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>, Anh Le <anh@canva.com>
References: <pull.1368.v3.git.git.1667177791591.gitgitgadget@gmail.com>
 <pull.1368.v4.git.git.1667516701.gitgitgadget@gmail.com>
 <Y2WuZfur3iorHxdt@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Y2WuZfur3iorHxdt@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/4/22 8:29 PM, Taylor Blau wrote:
> On Thu, Nov 03, 2022 at 11:04:59PM +0000, Anh Le via GitGitGadget wrote:
>> In large repository using sparse checkout, checking whether a file marked
>> with skip worktree is present on disk and its skip worktree bit should be
>> cleared can take a considerable amount of time. Add a trace2 region to
>> surface this information.
>>
>> Anh Le (2):
>>   index: add trace2 region for clear skip worktree
>>   index: raise a bug if the index is materialised more than once
>>
>>  sparse-index.c | 30 ++++++++++++++++++++++++------
>>  1 file changed, 24 insertions(+), 6 deletions(-)
> 
> This version is looking good. Thanks, will queue.

I also took a full re-read of this version and agree
that it is ready to merge.

Thanks,
-Stolee
