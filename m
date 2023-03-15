Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565E7C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 16:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjCOQTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbjCOQT2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 12:19:28 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA711D921
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:18:55 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id t13so10103243qvn.2
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 09:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1678897135;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fySncD3ROp8oCWU3L/c8iuuVTxw3+FGP08jzrbWXHX8=;
        b=N3FSdmIn5EYw6bLvf2CRHFqftv2OeNui3Ym92cjrzk8XphbyJw8+plliRFoRxOeSvQ
         NeuK2NZs+6KnJGiHj+/2UIdndPwMNHFp7kJULJjTF5hb1UtaT7Darj33HwhETo4iBcuA
         Ag0SCTTVcKd8DdbwO9HHAgEnHQ9Y9ZqhXbGQVQX9WjuVJY0PXL2yuKOgqGCfq3rQRXou
         IMu/1bWPli1jFbPbychQ5zZul8fMW0OeCTlMgpSgnxl2KiFSUYkhuptGVA9gDEieAGWl
         KARUhL1CBPJulgUkfCmheJtQf3M3fKDnomuBHH/OBN2rqymVUr5Lb3T0r4vZ49gk36lE
         Sllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678897135;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fySncD3ROp8oCWU3L/c8iuuVTxw3+FGP08jzrbWXHX8=;
        b=CF1mjkkH2q8swxY6CQFpHdDn+QLTrmkD6CNcagxCpmWV/EmhpH0fuIbMFTqqBOmfQ6
         +XSwsRjJN5grjen6z8PZ781GH0I2dJZNb9aDFGSI+rLB25sM5pI/gowoybshx8MklpDM
         Bd5P2S3OEKRFT6RvD7IFHp0wQFNmvrUKHccBZ4dV7I+SB0dsornRFwS5euUhYirKvDC2
         oCrBWVO5yG3RETUQQEme2+hQu2kta04RqR7egbog7o77RMnFj3mXz4vvuW0F7ifrqS+7
         qKgc6yR9Pb2bv3lU71nxXqtgbNK62noplvk6VFxOwojsgUGdR/t5uIskatrsJJmmbQYD
         rf/g==
X-Gm-Message-State: AO0yUKVGURjzduLxgVbK/l8KjkzIq021Di0EtjUjlMW025wj6fHNsGvP
        p97JocBcz7QMi9G94IeSJLyP
X-Google-Smtp-Source: AK7set9JCWSEIIu0BlWwjR+bqIyDMVq1v41SO8TrzrPVI9/IpwEgZO/UJhjQJLYH1W6d6pZuW7WL2A==
X-Received: by 2002:a05:6214:27c6:b0:537:7f85:22bb with SMTP id ge6-20020a05621427c600b005377f8522bbmr24398032qvb.16.1678897134934;
        Wed, 15 Mar 2023 09:18:54 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:b4dd:42a2:285c:8312? ([2600:1700:e72:80a0:b4dd:42a2:285c:8312])
        by smtp.gmail.com with ESMTPSA id j5-20020a37b905000000b00745bca3c8a0sm3953836qkf.43.2023.03.15.09.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:18:54 -0700 (PDT)
Message-ID: <973033ff-940c-01d9-bb8f-5722591988de@github.com>
Date:   Wed, 15 Mar 2023 12:18:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 8/8] commit-reach: add tips_reachable_from_bases()
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        vdye@github.com, Jeff King <peff@peff.net>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <pull.1489.v2.git.1678468863.gitgitgadget@gmail.com>
 <f3fb6833bd71d559a3076d9617a235614ad9a5f8.1678468864.git.gitgitgadget@gmail.com>
 <230315.864jqmxfd9.gmgdl@evledraar.gmail.com>
 <bbf4921b-851b-7630-c185-f7235f6b28d4@github.com>
In-Reply-To: <bbf4921b-851b-7630-c185-f7235f6b28d4@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/15/2023 12:17 PM, Derrick Stolee wrote:
> On 3/15/2023 10:13 AM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Fri, Mar 10 2023, Derrick Stolee via GitGitGadget wrote:
>>
>>> From: Derrick Stolee <derrickstolee@github.com>

> Not only does the previous message note this perf test, it has this to say:
> 
>   The 'git rev-list' test exists in this change as a demonstration, but it
>   will be removed in the next change to avoid wasting time on this
>   comparison.
>  
>> And here for a supposed optimization commit you're adding new tests, but
>> when I try them with the C code at 7/8 they pass.
>>
>> So it seems we should add them earlier, and this is a pure-optimization
>> commit, but one that's a bit confused about what goes where? :)
> 
> I can make it more clear why we are removing it in this commit.

Oh wait, I did:

>> (Note that we remove the iterative 'git rev-list' test from p1500
>> because it no longer makes sense as a comparison to 'git for-each-ref'
>> and would just waste time running it for these comparisons.)

Thanks,
-Stolee
