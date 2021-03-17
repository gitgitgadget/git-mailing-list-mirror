Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233CC433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C66F64F0F
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233385AbhCQU13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbhCQU1I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:27:08 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8669C06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:27:08 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id l23-20020a05683004b7b02901b529d1a2fdso3056295otd.8
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J/shlYI0CPTqn0FGs5OpX3KtAy/0VUTsAvgamUaPwA0=;
        b=gmmOleRGfKYPp2DAd6s8CX+TuWglcwl8kjn8bowW5YGnC2FNb+rSYWpIv4O6rOSKyD
         6zss9f2qW5pFjZgJZT6YtQDP6TBnn2exRNE3vuSa8uG/qpWRlCuKND5DrtfkWIUYftdR
         /uRwfOBXgu/FeCpvW9tifyPLztH6WPlDsPBrSCN1Lr6ePH3UEJc5jaCCkwaP2zMauQjW
         YPjwbzYBgVaH+RMZhLwnhK1dW5aTxwprjNwZ0zz/nfeSAoUPSK9qwQLeftERdFdRU4dg
         xeVAHtN9a0M1sEnae9M9XcRfNd8E9+CXsrhPArCY3TszOfmKKkbs12iH4CAbFwTLm2gO
         n7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J/shlYI0CPTqn0FGs5OpX3KtAy/0VUTsAvgamUaPwA0=;
        b=Xd/Hmd/JdzT4NlNsLLMC3mnb7JjBpQ05Ytqa1uFl7eehhoXTsSuHEWLBXqPnAIoJK7
         Ra74SYS2z/UOTT+yQmHAwUGG+MeIzmyNd+TvhakP7FFFc1WEYo5DyYSOJaJS8nSbZoh5
         lJ7VjVhD9Dxp0sMu9IQlfMGmnsmOMK48uYCRi4rKXIz64yWCuiBcLNcSpxqup9dXrnqF
         B59Vwqw69xpczqfik7cfQ8wqSPE97Z8ome6CLpmosG3Za0vPKcfO5Fu4UvlQI9SKD22C
         PGsQ2Bpguo1V0AU0gWoiBz14GQUBurB+y/Cs3djbd8Njhv7Nsh/4XTWDeP/VDsKs24Es
         6u9g==
X-Gm-Message-State: AOAM533T6kOhlRxa4WbXbjrXNF/wlNhhJf3o2BAvbeN1GoGqgnXu5Jnc
        Xm4Wz4NJtz5c1D/YaQurXGY=
X-Google-Smtp-Source: ABdhPJxl8udJKNp3tY/JnOxAyxhMmuBp7PfcE67MkIZ92eSwHVTjTin89tOLwWmeQdEpIlwmm/pTuw==
X-Received: by 2002:a9d:67c2:: with SMTP id c2mr4828656otn.343.1616012828159;
        Wed, 17 Mar 2021 13:27:08 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:5df9:6440:37ca:197f? ([2600:1700:e72:80a0:5df9:6440:37ca:197f])
        by smtp.gmail.com with ESMTPSA id v1sm41409ooh.3.2021.03.17.13.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 13:27:07 -0700 (PDT)
Subject: Re: [PATCH v4 22/22] fetch-pack: use new fsck API to printing
 dangling submodules
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20210306110439.27694-1-avarab@gmail.com>
 <20210316161738.30254-23-avarab@gmail.com>
 <72b6e263-1e53-cc00-9545-cddd11820fe4@gmail.com>
 <87tup9zybl.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9424d5c1-68d4-f6dc-7fb1-3b5617d3ad48@gmail.com>
Date:   Wed, 17 Mar 2021 16:27:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87tup9zybl.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/17/2021 9:47 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Mar 16 2021, Derrick Stolee wrote:
> 
>> On 3/16/2021 12:17 PM, Ævar Arnfjörð Bjarmason wrote:
>>> I expect that there won't be many of these fsck utility functions in
>>> the future, so just having a single fsck-cb.c makes sense.
>>
>> I'm not convinced that having a single cb function merits its
>> own file. But, if you expect this pattern to be expanded a
>> couple more times, then I would say it is worth it. Do you have
>> such plans?
> 
> Not really, well. Vague ones, but nothing I have even local patches for.
> 
> It just seemed odd to stick random callback functions shared by related
> programs into fsck.h's interface, but I guess with
> FSCK_OPTIONS_MISSING_GITMODULES I already did that.
> 
> Do you suggest just putting it into fsck.c?

Yeah, if it is frequently paired with fsck operations, I think it
makes the most sense there.

And looking at it again, I'm not sure parse-options-cb.c has a
good excuse for being separate from parse-options.c, but that's
the current state so I wouldn't change it now.

Thanks,
-Stolee
