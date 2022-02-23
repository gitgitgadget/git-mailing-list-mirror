Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC48C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 14:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbiBWO0j (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 09:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbiBWO0i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 09:26:38 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1309B238D
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:26:10 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id y7so18441484oih.5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WqbKQ7Bv8wQP84iKzOQH9fIUxd6lTQwjVzCObkczIaM=;
        b=B66y6A6d1OlyU2N11A65kI8ZgJywlcV6dJqakhKJ/iGMDY/JA3D/vnWR/2S5+EPT3a
         kZ6plB1A/Tnv2R8nRSUzDKwEU/sjemwZhd/q2IfLC/g2Q2gptq7iluteRebKP4kW0W7y
         6kyCqh5QelS6XVpBcKgTBF/Id+aUV++HDReyWg1pFrtV7qFu9KmvTYQh42zK59AqU4WC
         L5VXTkmTDNl3fpy48KeoSKQ4ms0/mq56G3YEaI6/lVHKWSwt4LeFcYTeeu2L81cNVxWw
         b9annUX9/9S8Jy07F6GussMMinHxCYINvnTccx5waC9yE+0hX4NF+9Fz89c9wof3nRpQ
         pQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WqbKQ7Bv8wQP84iKzOQH9fIUxd6lTQwjVzCObkczIaM=;
        b=fiIc0ysaadf1mKTqMd6WmUjbFNQ+1FeBQW0EYNJlO552dVLabl6rUz4sBIPKwKBZV8
         6bKcDX3iaffUzYtcuO8HqvnxjDmkuOWicd8GtOTVcTZZRjAD7lIfskvbTPnEGk3H4zR3
         Zl5OE4lzIYO8Ypq/wEoL/ajWGpn1yjLhKIs78RJAhmp/mJFxM9RzYTvUfzeL16nev05T
         5Gjs1AxvbrvuDemzK9gw+lwzzP7VfCEZmPKRHAzh0P3pSiSgly/gmlfM70FqNsK9GjsY
         cBskFeo/SNjODcpb6anBeE9eZ3UIdn1oVgfnL/RiR0rWzBw3CwQXYMNGEyH+QR1hoINC
         MGVQ==
X-Gm-Message-State: AOAM5321em9MuheVWQzQ5IQkpYHdtm5tq6drhx+kR4juDR4xF8UoCFiv
        GyR/LE+GVCJWMcZGkXl+aQSL
X-Google-Smtp-Source: ABdhPJzY/4jIRwjEkNjA9aIlH/BGkS5dOTgoGfjj/zTTOX83GMNbK2fanEE5Gl8LkyXQT4u8EBvtOg==
X-Received: by 2002:a05:6808:3084:b0:2d4:c36a:4d27 with SMTP id bl4-20020a056808308400b002d4c36a4d27mr4698335oib.66.1645626370158;
        Wed, 23 Feb 2022 06:26:10 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id fq40sm4207221oab.5.2022.02.23.06.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 06:26:09 -0800 (PST)
Message-ID: <c37318bd-2b11-4054-9754-70c33f4d2d7e@github.com>
Date:   Wed, 23 Feb 2022 09:26:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 00/11] Updates to worktree code and docs
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1154.git.1645379667.gitgitgadget@gmail.com>
 <pull.1154.v2.git.1645489080.gitgitgadget@gmail.com>
 <CABPp-BFPND3kCkHGxztpXRJRLeu=BJPFm7tbCrr0rVp4M0rHeg@mail.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CABPp-BFPND3kCkHGxztpXRJRLeu=BJPFm7tbCrr0rVp4M0rHeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/23/2022 1:51 AM, Elijah Newren wrote:
> On Mon, Feb 21, 2022 at 4:18 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> This is built on top of ds/sparse-checkout-requires-per-worktree-config and
>> includes some forward fixes for comments from that series.
>>
>>  * Patch 1 combines two translatable messages into one. (Thanks, Jean-Noël)
>>  * Patches 2-4 extract methods from the already-busy add_worktree() method.
>>    (Thanks, Eric)
>>  * Patches 5-11 update git-worktree.txt to use 'worktree' over 'working
>>    tree'. This involves some rewrapping of the paragraphs, so the diffs are
>>    not obviously just a find and replace. I split the changes mostly by
>>    section of the file to keep the diffs from being too large.
>>
>>
>> Updates in v2
>> =============
>>
>> Based on Junio and Taylor's review, I updated some language in the docs:
>>
>>  * Some uses of "worktree" should have stayed as "working tree"
>>  * Some adjacent wording was improved.
> 
> I read through the series.  Looks like the only thing I caught was
> typos that others caught -- though one of them was a typo flagged by
> Taylor in v1 that went uncorrected in v2 ("metada").  Otherwise, looks
> good; thanks for fixing this all up.

Thanks, all. There were enough typos in this version that I'll send
a v3 that fixes them all.

Thanks,
-Stolee
