Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A965C433F5
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 01:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiAVBI6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 20:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiAVBI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 20:08:58 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0559FC06173B
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 17:08:58 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r11so9499542pgr.6
        for <git@vger.kernel.org>; Fri, 21 Jan 2022 17:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=A/fnfI9BrNjQxL67SoiezenhzBGMkzjCGpzGilAYo7c=;
        b=oPNqDiup/qPoQ7/OFlw5SjxCC8vLJ97Bbd8hq6o9NNcdjMFgsxMqlsLub/RpwN5cQE
         UnfdB6fYtfbrek46dBt0nvRkofrB/sLixAQPkGFJIr3WP0e6JZSYFd9gBVgy98WJ1RLS
         n3FL8wDoYszofM0DhtiobGZHvUtQfi26UdCXA8Rk5CiQJghs25Oj+j92dwkiBiMDM7BU
         r1aojjAkzlTFNTczV3q5YCYxAvdn2hhGNRaaGjLzUUHsQ3/MgxjQrR1iRO2n1NQJ46+d
         rQWUjbMWHTtNPTOTp6QpHYtLSY2mNEpbPNK7g5uTfrzs5SyFyJS8WEAO2DuTJYhH4Ayu
         lE+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=A/fnfI9BrNjQxL67SoiezenhzBGMkzjCGpzGilAYo7c=;
        b=xtfqVZ/aDF+BSTxte0P+aGS4m8tYJHNMv/t6ZRqpVRi3Rlh5cquraxcxAmXn1RepG6
         ur6AyGr0m6EPnWEG9OrNVkQsafN7AIVlvB1/z77ihVoyV2WGhkXJcIgZbZYAe4iiX0ZK
         +K9MxYqDmBnSyk3FKuRao/DMcC7oc7z03BDVQoj4H7p0ZdG+GdgrmG6cjVtl+Rg72nIO
         SanD33wdbAcr9UBmHYvk/SphTXA3JPA6Ln+ucpD+q27D3wxLGIZRSAxDYUIQoeZM118J
         7Xb11fPijy1qkMtdVkWflEC374S/hTD561/UzZjjfV1tSNLMjy8LfQasnO83DzHym1YI
         5dBw==
X-Gm-Message-State: AOAM532gtAvWmu+JLAgnzhg0upsl12DXR+zK6xBWt/MLB77FCI6YOodx
        mHHAEh/4GgzbemfZSl0H1oD+oNoco9I=
X-Google-Smtp-Source: ABdhPJykiPGbmwmmMY7EG5+mFMm6dSPchxTrXXJWRxH4Utm41Z9ft/htrtOaCKD2v7f5jfJFkc7Kgw==
X-Received: by 2002:a05:6a00:1589:b0:4c3:cc45:58e2 with SMTP id u9-20020a056a00158900b004c3cc4558e2mr5724816pfk.86.1642813737498;
        Fri, 21 Jan 2022 17:08:57 -0800 (PST)
Received: from ?IPV6:2601:602:9e81:12c0:2d18:26b4:c539:428e? ([2601:602:9e81:12c0:2d18:26b4:c539:428e])
        by smtp.gmail.com with ESMTPSA id 20sm5362554pgz.59.2022.01.21.17.08.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 17:08:57 -0800 (PST)
Message-ID: <5e7e4858-10ea-06d4-0406-84b83c26dc43@gmail.com>
Date:   Fri, 21 Jan 2022 17:08:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] sparse-checkout: custom tab completion
Content-Language: en-US
From:   Lessley Dennington <lessleydennington@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        johannes.schindelin@gmail.com
References: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
 <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
 <256e5f034c6072b6e3621adfa96c5c6319752fae.1641841193.git.gitgitgadget@gmail.com>
 <20220115095725.GA1738@szeder.dev>
 <CABPp-BGR+UrW5ej-8+XXHPkjMfFgURycd9rWC+2awUvYcr_PXA@mail.gmail.com>
 <xmqqv8yjz5us.fsf@gitster.g>
 <CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com>
 <xmqq7dayup5d.fsf@gitster.g> <ee58a0d5-5773-238d-706f-3fb264b6e8db@gmail.com>
 <78956982-f5fc-1681-1efe-42e408132a4f@gmail.com>
In-Reply-To: <78956982-f5fc-1681-1efe-42e408132a4f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/21/22 5:07 PM, Lessley Dennington wrote:
>>> I know it is your preference to complete only directories and
>>> exclude filenames, but I question if the confusion such a design
>>> causes to end-users is worth it.
>>
>> I think perhaps we're a little caught up in exemplifying commands that
>> are unrelated to sparse-checkout. As Elijah said in [1], the documentation
>> states that directories and patterns are acceptable to sparse-checkout but
>> not files. While it is not reasonable to try to offer every pattern a user
>> could possibly pass to sparse-checkout, it is reasonable to offer
>> directories and (in my opinion) will help guide users toward correct usage
>> of the command.
>>
>> However, since completion on directories is cone-mode-specific, I am
>> willing to accept the suggestion to only complete directories if we are in
>> a cone-mode sparse-checkout and apply it in v4 of this series.
>>
>> [1]: 
>> https://lore.kernel.org/git/CABPp-BErg-RtyycXaRXYfQHEQXA4q-FU9Q6nYkSHJsqL-04oXw@mail.gmail.com/ 
>>
> 
> In light of non-cone mode being removed in the near future (see [1]), it
> actually seems it does not make sense to add different behaviors for cone
> mode and non-cone mode. I also ran this by some other contributors, who
> thought it would be best to complete on both files and directories so as
> not to confuse users (as Junio and Szeder have indicated). So, instead of
> differentiating between cone mode and non-cone mode in V4, I will plan to
> remove directory completion.
> 
> [1]: 
> https://lore.kernel.org/git/CABPp-BEwMAPHGt5xD9jDU58grbrAqCdqNY9Nh8UJGLKuLbArXQ@mail.gmail.com/ 
> 
My apologies, I will not remove directory completion, but rather will
return to completing on both files and directories.
