Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2ECC04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 11:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiG0Leg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiG0Lee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 07:34:34 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BCA13CDE
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 04:34:33 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id x11so12350739qts.13
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 04:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nBzcVeNo2FlySQ4w2LsVRHbUeDMQzrQ045JdtwROaUA=;
        b=c5CRhdZmOT37xWPaE5+gg5dO0Xk1N57jQTDRbKIN0jFskURPt2Bl1+KIoKDbdg2U1C
         YkBP3sASH7YdoACQxdptP3Q8WFW1K3uiAmPqUmEThjEMxD8oFKunz4MJchS/a1PAQKX7
         akUG1u6olQqVLKMZkZ2MO+hacqznwwSM+7G8vVP1UGXXPf3of6dUA6XZ39Z1HTnEwt87
         i5YIyyoOcbp6qNltUjaaA9BNf61FnRD208zjbyomcv59BUMILSch/qaUQMFSxsmV0fnV
         y8McpZ6pg04oJRAarP8t4cUqx0xV+6Wu7wwRi+KRhknJf/qurqOllNusl+U1H6LaL1Sq
         LCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nBzcVeNo2FlySQ4w2LsVRHbUeDMQzrQ045JdtwROaUA=;
        b=51NnXetUZGwlebOrVM8476CBZeXAFMBvfuLui8ykAf5HUCQSZGnpXQ5sh+IwfeHUfA
         vk8G5sGrBhzSwUS3Gwj3DK4P/QxR03MgzKTGM73yxWkMdnVR9P6WSYdl2zFfLgOkwIim
         RCfwH0HthrdBp553XQOk6PRsdHhI5Ts/vYLcjCLfEeGpx1NRrqny2a5mhBGtxDCa1///
         M8Gwmb3pt4EdFu/vOdBdIqmt3dWe4RL4b8uccnWoWnmUV+ibv0UEZV41URi0ApzZkqfw
         kVAp/fhXwXrV11rTT9EukmZDrA2LIuEHrs6hUpZg4zzfmsdOQg7MBgrz4pBfG3pxygDi
         BE0A==
X-Gm-Message-State: AJIora85T9W7Rumkv+a467csUdcYEhbUlB7PCgX0Mn+K9nlsveCSO92K
        XcyrkjAga+TTwbfNuHWdTw+vy1FCgHwb
X-Google-Smtp-Source: AGRyM1sZ7iWu/mscA2/yZaljMaDf0ZJMXw4hkai4gPEJ+KNm5avulUofYxVxgk/QSFtqSulS/qKGfg==
X-Received: by 2002:a05:622a:343:b0:31f:3383:3971 with SMTP id r3-20020a05622a034300b0031f33833971mr14423308qtw.276.1658921672965;
        Wed, 27 Jul 2022 04:34:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:85f5:c696:22d5:b5a5? ([2600:1700:e72:80a0:85f5:c696:22d5:b5a5])
        by smtp.gmail.com with ESMTPSA id az44-20020a05620a172c00b006a5d2eb58b2sm12831327qkb.33.2022.07.27.04.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 04:34:32 -0700 (PDT)
Message-ID: <483f9183-d7bb-4391-4299-d89f83d481d2@github.com>
Date:   Wed, 27 Jul 2022 07:34:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] CI: add SANITIZE=[address|undefined] jobs
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>, Jeff King <peff@peff.net>
References: <patch-1.1-e48b6853dd5-20220726T110716Z-avarab@gmail.com>
 <d4dcb1f6-6076-3725-d479-7e9f1fece2a3@github.com>
 <220726.867d40ng6j.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220726.867d40ng6j.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/26/22 9:33 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Jul 26 2022, Derrick Stolee wrote:
> 
>> On 7/26/2022 7:09 AM, Ævar Arnfjörð Bjarmason wrote:

>>>            - jobname: linux-leaks
>>>              cc: gcc
>>>              pool: ubuntu-latest
>>> +          - jobname: SANITIZE=address
>>> +            cc: gcc
>>> +            pool: ubuntu-latest
>>> +          - jobname: SANITIZE=undefined
>>> +            cc: gcc
>>> +            pool: ubuntu-latest
>>
>>> @@ -277,6 +277,12 @@ linux-leaks)
>>>  	export SANITIZE=leak
>>>  	export GIT_TEST_PASSING_SANITIZE_LEAK=true
>>>  	;;
>>> +SANITIZE=address)
>>> +	export SANITIZE=address
>>> +	;;
>>> +SANITIZE=undefined)
>>> +	export SANITIZE=undefined
>>> +	;;
>>
>> In both of these cases, we are breaking from the nearby pattern. These
>> jobs could be renamed to linux-address and linux-undefined to match the
>> linux-leaks job.
>>
>> Alternatively, we could rename linux-leaks to SANITIZE=leak[...]
> 
> I deliberately deviated from the "linux-leaks" pattern since it's a lot
> more than just:
> 
> 	make SANITIZE=leak test
> 
> I.e. we instrument what tests we run, skip some individual ones
> etc. These are different in that we can run the entire set. I'd think
> the reverse would make sense, i.e. one day if we run fully with
> SANITIZE=leak enabled to rename that job to "SANITIZE=leak".

Yes, SANITIZE=leak requires extra steps to make tests pass, but
as far as setting up the CI job it is extremely similar to the
two you are adding here. Their purpose is also very similar:
add compiler flags that would cause our test suite to fail when
certain memory issues occur. We just expect the SANITIZE=address
and SANITIZE=undefined to pass for every test in the test suite.

That's why I think renaming linux-leaks to SANITIZE=leak is the
best option.

Thanks,
-Stolee
