Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549E2C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiGOQRA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiGOQQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:16:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B54461D77
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:16:57 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j1so2919110wrs.4
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z+tVMzPf9EERMDokgHcLTzrBGHuCi4OMlwVSuKMjXDE=;
        b=Oi1zLPv+4sEdgfGY2gLcDxCZC4LoiPYPHlMMDKBWCCEmhPHuK6dRTjxaRmaDHITHM4
         CajRYs3tn9fgaAZKcoZWuCD7sOWRkUPKwGC8DI4+LMBnOd29KUusjrfTJCVEYQWHiMJZ
         FGasySUlH8Vd6mJt+jIQdTmAKsjxy17TPTbh9kSoA8IVkfoQ45uWUDXmwh636zyiXcPa
         4zDMUCVBmAvJy6b+t4aADf/YU1JxRvPmaW5Ydh+CPlqwPgUbdftNamoF3uRqziqk3E6K
         /RKyVhJtZ6R4w9vBVejZQDsG4FZCIcQy1GFWVa1Ht7+DM/mx9pXfl8O89HMCNDRsGbAS
         qXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z+tVMzPf9EERMDokgHcLTzrBGHuCi4OMlwVSuKMjXDE=;
        b=NETbB9hY6n/FhDSBwXjgZIZzDLeL1EITrbTX8Cu0yeicoGHMqQ1J5bJiGzS7+qj7yQ
         MSYb8GaoPuUPbURFvW3KQ0IZB3W8bQYJ5rximjZIdhpgrFx6mJwEK7ohTc2BlxfMnaGe
         0NeidLW/kjhZLFfJFUVgSdeB9WsEayNXOR4Kvld7tjelxjMpP7YbGPwBn/G1DAYBx8hR
         3P+kUsIeswRXIb84XsStmm8m7EuncLSvRLl6+m+NdqqVtfVGY74ilKYyo3qfcQ+mUk3V
         KdJhzwx/YTXNl8IzFPyLQ/S/0CHVWIi4/76cnrv2EWoBPmDR682t1iav6px0RSb3gT28
         4AGA==
X-Gm-Message-State: AJIora+R1cxi/ufeFhqEFh0FCvdPvUM/iGYbe/KvQ5LA3hgADD5kXWgb
        N5os9g94+jG+XFDb8LCbc5g=
X-Google-Smtp-Source: AGRyM1u4mr98OgA96oTizvqZHZiHHMJfaN1i/kKr8VjPJZxc/lkS5Uzh4t1mUhxLmqtMPJGc5H6Icw==
X-Received: by 2002:a05:6000:1a87:b0:21d:b5b9:7666 with SMTP id f7-20020a0560001a8700b0021db5b97666mr13567422wry.1.1657901816163;
        Fri, 15 Jul 2022 09:16:56 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id r18-20020a05600c35d200b003a310631750sm1242611wmq.35.2022.07.15.09.16.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:16:55 -0700 (PDT)
Message-ID: <14d7e4f5-e8da-d8f7-05f3-a30faf25f8c8@gmail.com>
Date:   Fri, 15 Jul 2022 17:16:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/3] Remove use of "whitelist"
Content-Language: en-GB-large
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1274.git.1657718450.gitgitgadget@gmail.com>
 <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
 <xmqq5yjy3n2c.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq5yjy3n2c.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/07/2022 07:30, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> The word "whitelist" has cultural implications that make its use
>> non-inclusive.
>>
>> A previous version of this series recommended the replacement of
>> "allowlist", but that term is still new and not accepted by some common
>> dictionaries.
>>
>> Instead, this version avoids the use of "whitelist" by rewording the
>> sentences that use it. In many cases, this improves readability since the
>> term is used suddenly without other context (and in some cases, is not
>> necessary at all).
>>
>> There is one case where "whitelist" is replaced with "allow_list" but that
>> is because we are operating on a string list parsed from the
>> GIT_ALLOW_PROTOCOL environment variable.
>>
>> Thanks, -Stolee
> 
> Maybe I am biased, but for all the changes in these patches, I find
> the updated text far easier to understand than a mere replacing of
> the words s/white/allow/,

I was struck by that as well, the new wording is definitely an 
improvement, thanks for working on it Stolee

Best Wishes

Phillips.
