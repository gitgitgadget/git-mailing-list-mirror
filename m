Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D413C38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiJYM12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbiJYM1Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:27:25 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B38B152C4E
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:27:24 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o13so6665091ilc.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KMXYOMCTMSvvXI4E02WTAu9CMPxTDvJUOabw07mvVoU=;
        b=RcQNx4Iv+/iYyowfleD6qUFyr13K3fjpDIUsoG8QkM8KEbPgh6q8aOc2A+ERGrOoof
         4zlEvHT1FZrcAxGxEKN68p9wSiUyfY6ma3S5BWVqqPEBL3XvLvuhsPrWGjL42sFyZtxt
         I1MTtuknBfI804zP2P4QXGwpnuCSYFrCa3TIOV0iryS0LVn4mpNCkXwAvCW2+J+pSrsA
         2oFg3mybb1WICftzCa4rE2kZaPOet0ESToGu3uC0dlWmpfA19UWvHCd03MyI1nFIv2Tq
         XOoIA/RNdj9DjwSSXNfl4kwssluToePm2sieYaUOl1tRT3Q0LAcmkap/FwnXYZGDwRO+
         TLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMXYOMCTMSvvXI4E02WTAu9CMPxTDvJUOabw07mvVoU=;
        b=RmdcMeZTFuPzLTkYCmMU2AF6uLZ8zL3TfHHP3+EP/51nLd4Qtdj9059zKTuU+N2G/5
         ne1R0itbgbgomZsLHVxRRbo8oWz1is4CGEDPL/1pcqkMjEB45QNEReQw26o3Jcu2eufk
         KXVaL7YAcCYEkhyKmTSnNSkcukg6//r0H+95Ds/jG5WbwtPgC4czcdYZ/eGXxCbIcWQ/
         sQKct+mND7BpPMDq965t1W47C913MDqAeNUFtFK4Ehtoag9ALyh2wKQRKWSJsJZ+dE6m
         SPZULs6ni0ldCt1N8rOKpL6nbhQHiSD+dbWYyQDpMzbAeGxVVD7mHoHc53+J4IasogQ4
         iZSQ==
X-Gm-Message-State: ACrzQf3NBQCthyMzg4NadCuH7QkQPTJ2mIhp/zlJe0oRTAI/udHthSBB
        eY6cM0eBDVAU7zJVxAzSeWoL
X-Google-Smtp-Source: AMsMyM6pORXVY55TDwM1t6eN1Flygowz6qOqwOw88G4/FC6+WLldpQbx4cTrbyjLSOQlY5f6LLB2Qg==
X-Received: by 2002:a05:6e02:1549:b0:2fa:f6e3:e2c8 with SMTP id j9-20020a056e02154900b002faf6e3e2c8mr1032755ilu.252.1666700843553;
        Tue, 25 Oct 2022 05:27:23 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:880d:bbf9:8364:e715? ([2600:1700:e72:80a0:880d:bbf9:8364:e715])
        by smtp.gmail.com with ESMTPSA id w11-20020a056602034b00b0068a235db030sm1061553iou.27.2022.10.25.05.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:27:23 -0700 (PDT)
Message-ID: <0e58bd35-4f40-ce9e-1088-f7c004527aee@github.com>
Date:   Tue, 25 Oct 2022 08:27:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 0/8] Trace2 timers and counters and some cleanup
Content-Language: en-US
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
 <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1373.v4.git.1666618868.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/24/2022 9:40 AM, Jeff Hostetler via GitGitGadget wrote:
> Here is version 4 of this series to add timers and counters to Trace2.
> 
> Changes since V3:
> 
>  * Fixed typo in the new thread-name documentation.
>  * Use a simpler NS_TO_SEC() macro for reporting the timer values.
> 
> Jeff Hostetler (8):
>   trace2: use size_t alloc,nr_open_regions in tr2tls_thread_ctx
>   tr2tls: clarify TLS terminology
>   api-trace2.txt: elminate section describing the public trace2 API
>   trace2: rename the thread_name argument to trace2_thread_start
>   trace2: improve thread-name documentation in the thread-context
>   trace2: convert ctx.thread_name from strbuf to pointer
>   trace2: add stopwatch timers
>   trace2: add global counter mechanism

I re-read the series as well as looked at the range-diffs for the
previous two versions. I continue to think this is a high-quality
series and I've used it multiple times in my personal development
workflow to investigate certain performance things. I'm looking
forward to this being merged so we can all use it.

Thanks,
-Stolee
