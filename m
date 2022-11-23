Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D5FC4708D
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 15:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbiKWPHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238742AbiKWPHp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 10:07:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1606590
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:07:43 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id z4so15235598wrr.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WJc7Ttpo4NH9FIsogHjOIBOjExfl9UCmhKXAPHK3+A=;
        b=HniK+r9ZQ+W+NXRpCGhtFXnh5rH98MpYp8Q92BIUhAjCci7YQSwk1/wOk/Fe2Z0xGe
         3HN2x4YClfhCjWBdInYoJ+o67oHX2R8YGY/tQ+qGPXSKaEF4uHWgKS6dasQYq/YKx/yT
         itsE2DwQGpXZJJsHPuHFTMey0pGR12NXnzJeTgIBQQAtKoXk0TKmABBMKdjCxAtxuZ7s
         ibsFhaJCt5Jm7sWoW2XTZVZWdB8A9ku5BoKZoa3yXGZEEVdFX9KtCVYIKLsBR/YeSD7W
         REGqTva76uGBJdo2KnYIdJi5At3ejBg8AdpHIAdPIzIWQkiKW/WFAp49slhh3W1SNfAT
         jCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WJc7Ttpo4NH9FIsogHjOIBOjExfl9UCmhKXAPHK3+A=;
        b=wJCwV1Imr8jbreYX530N3wfa67D1/1rNMLFuTm5a41FvQYoWrgEyAl+RSaG/ZXa4e0
         DcghFKDHDVkKBs8lDWNA8fNVIjxTNpqNZ9Pycyk01pCIqUr+maE2fu4YCqiEQzRnPGyz
         /rQW39idcYX38GRjV/IaAjkEpRDAEiOAaUqYgKigfqU74hqxsaUnzjuVeHyOY/ZK+q+g
         +SOp0hVHDTqrACswUV+qguW+CBqLFaOBknPY/cRc1R3F5DQSYOSpDDivD1FH6eHSQfrk
         6WYmn1k9l8aboifJYp7HDAVuG8CoDNaYw8LkRQPeFgP/jsjs/Wa+U5rMI0/e/9ek8RaI
         7Kqw==
X-Gm-Message-State: ANoB5pmyhhiNhuCm4HQOqq0BDYK92KfoF+ZKYoWr/tGZl46w/gofZ680
        4X37u5rfyvgYNAOvHX1khj4=
X-Google-Smtp-Source: AA0mqf6zX+g4dd1l3WPGIEbNxsya2xVasvFP2PT55ntCELV3Kg5QOLSpDNpSUcscXfnjQHVTww0Mkg==
X-Received: by 2002:a5d:42d0:0:b0:241:d8e2:868d with SMTP id t16-20020a5d42d0000000b00241d8e2868dmr9042460wrr.671.1669216062333;
        Wed, 23 Nov 2022 07:07:42 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id e17-20020a05600c4e5100b003a3170a7af9sm2886770wmq.4.2022.11.23.07.07.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:07:41 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <a07b5cd7-7ada-7cdf-78cc-375ef21687b0@dunelm.org.uk>
Date:   Wed, 23 Nov 2022 15:07:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
 <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
 <221122.864juraxl2.gmgdl@evledraar.gmail.com>
 <9c0ecaff-3d66-2b83-eb78-64632d1fcddd@dunelm.org.uk>
 <xmqqilj6plta.fsf@gitster.g>
In-Reply-To: <xmqqilj6plta.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

Welcome back, I hope you enjoyed your time away from the list.

On 23/11/2022 00:16, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> All the other items listed in your table such as branch names are case
>> sensitive. The os name is not so it is of no benefit at all to the
> 
> You keep saying that you consider the OS name is case insensitive,
> but I doubt that is the case, not in the sense that MacOS and macOS
> are two different operating systems, but in the sense that OS
> publishers have a single preferred way to spell their ware (which is
> shown in "uname -s" output), and we should respect that.

I can see that we would want to respect the preferred spelling in our 
documentation but it seems a bit mean to penalize users who write

	[IncludeIf "os:windows"]

rather than

	[IncludeIf "os:Windows"]

Best Wishes

Phillip

