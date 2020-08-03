Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE31BC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5DE22BF3
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Li2BK2Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgHCRnM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCRnM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:43:12 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D08C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 10:43:12 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so12693564qvb.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 10:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pA4GsbNK4NT8+xfpnGuX7RDxrw25xceDeUTz7+6wYs0=;
        b=Li2BK2Im/E4/asg5Tzxkbk/GSIy9SDw6Jn2bQ9h40bjXWWGNwLSCItqbJdTDT19JhL
         JFge6hqwk+e8R72j2sNDbBVPMRPvLXQQs90ImnWTnzOYODY3yCtwbEJs78buI7d0po5J
         Sw3XH8JOmrw2JMyV6gcOQu8CT95i1r6uYavKSxhWrXisDOkehnnDfwVkBcTZ21ROny8W
         2YwQGE9XDnigbQCDfZOOZwLGpEebal0pIJ/jFboFcVHL4VkRn9zB4KKa2PGJ8FBh4quA
         z202lM0sd3NAbpwxLitUq55w9K0F1Jw+mQUwoioqCDcrHOfwbdrupsgZk149qzxxnFMY
         MYYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pA4GsbNK4NT8+xfpnGuX7RDxrw25xceDeUTz7+6wYs0=;
        b=AyS8ParPoB+AGP1kqhzTGeXXby7g+erVUIiyhMFPuQPuDRyZDA5bQ2WLAIlmlRt2cO
         WAHzP3t3+HkrqBXKIpaIIHvyyKgqd4EWejDcHQ8yBikVmi/LbyoxiJVHBiSyQUytw+ZQ
         Q94Qnvxkbm0J9EKMLyjw5is40nNmuh2ZQt81yEgiRXMnfnBDfLdk6aGw1LC+feOXoNI/
         7QCR+PcnOSWu2HyfVf4ty4karjjeI2lgDdLJT9E41j4iVJSxDnDSDfBdeesso0WJM1M0
         yE5umq8WuUbj4MNsBV21rN2Q2rFSDxjkiSZrs9Ge+CNcwzvum+abek8E2L/BpAPbUrep
         xutQ==
X-Gm-Message-State: AOAM531WOnHQlYLiai1ZfuajesgZqS0kfVa2/UmnBS8qTJKvt2XUz21h
        nX9/ho0uPZx8ZAwgxAQsnGw=
X-Google-Smtp-Source: ABdhPJw1JuaTporFi/VUnmAn1eDAc/BDBm2ac6I4jEa3ms94fCdesL/1L9JLcWinvTPN5SWqJK2xFg==
X-Received: by 2002:a0c:8f12:: with SMTP id z18mr2375302qvd.153.1596476591440;
        Mon, 03 Aug 2020 10:43:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:bdad:2336:408b:dfdf? ([2600:1700:e72:80a0:bdad:2336:408b:dfdf])
        by smtp.gmail.com with ESMTPSA id y3sm23069174qtj.55.2020.08.03.10.43.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 10:43:10 -0700 (PDT)
Subject: Re: [PATCH v3 13/20] maintenance: auto-size incremental-repack batch
To:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>, jrnieder@gmail.com,
        Jeff King <peff@peff.net>, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, Emily Shaffer <emilyshaffer@google.com>,
        sluongng@gmail.com, Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
 <ef2a2319565939bfbdbd2e898a980c61ecc39c6a.1596147867.git.gitgitgadget@gmail.com>
 <CAPx1GvcpOC2jeeB=CNR5cGh=q59j6J09J2+vRz4+8aH1_cQocQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <aead1ca7-0477-f46a-e2a6-f5b98c774d20@gmail.com>
Date:   Mon, 3 Aug 2020 13:43:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvcpOC2jeeB=CNR5cGh=q59j6J09J2+vRz4+8aH1_cQocQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2020 7:36 PM, Chris Torek wrote:
> On Thu, Jul 30, 2020 at 3:26 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 99ab1f5e9d..d94eb3e6ad 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -988,6 +988,46 @@ static int multi_pack_index_expire(void)
>>         return 0;
>>  }
>>
>> +#define TWO_GIGABYTES (0x7FFF)
> 
> You meant (0x7FFFFFFF) here, right?

Ugh. Of course. Thanks for being diligent here. I hadn't pulled
this branch into microsoft/git for testing with Scalar yet, where
I would have noticed this.

I'm tempted to create an EXPENSIVE test that actually checks this
condition. Let's see what I can do.

Thanks,
-Stolee

