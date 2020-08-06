Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CAC433E0
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 15:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A6323117
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 15:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3O41b+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHFPFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHFOUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 10:20:17 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B0C0A3BFD
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 06:54:41 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id g18so8712143ooa.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=T8OjsaLgt2d+eO5xyoLZMNodNffysBg2pK5hXrrmkR8=;
        b=S3O41b+ejIgN+8n6bknNwN3/HCd6/m4CJWQi/WHAk6wIbZW8axlWYnRJfva/9f6jBU
         f4zoegXdVoy/6QmzmIWfoCXTEEnl0uFTNStCWQtMwVX1G7/Hy0xIUlIga0/OjVwWbnj3
         /ivcdVhjIaUeQXpdWpyouwClElR10D5w+beXKgJsPPb7osAC7c6mJIJyqsfIj2G8o0G8
         N7BZH3j7Gv1Uefa6oWieFb8JCDkM3GHfyAjN/+j0Vcs64MTmY4jp7zru3GfF6YUvUqU7
         6QO1D9vA0yTimTXxjdZIfgPuru8IefolkBTlIjiJcHVU8Y0FPEgK2s1ImqmC9AF/S8Nv
         yZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T8OjsaLgt2d+eO5xyoLZMNodNffysBg2pK5hXrrmkR8=;
        b=tlKov3ZlTPz69+c4QRF+QEU8Zg5LEIh6C3DHeJq/jKVhGLEYilRTuvGm3CREJzNDa8
         3C9G4P5WP6ed3XorLyKTDm15b0lmlnRGTZ5HpMGMhXFz8v7luvFM4wyxULZJ9447fswP
         PKX7XisVpC0hREaBnGO7TFAxsgr0ZPD7zPV2xm99WYAuXmjTNXB/qp4zZ95v3/MdakcC
         6rm6qhafCN7PEqCvVevYXuWR45LDhEkYO4Z1v+dBdG5a3SKGn11IxdldFV/kEuz00dwF
         zDFCiodGaIG/yS1V884/opC/lRSZbKNuwXLRkB94gmXXoCYP3kb0t0t2Hgk0Sv2nKuKq
         wO3g==
X-Gm-Message-State: AOAM5326twJgq3lUgfYK2l/sFeMcx6pb+YlJl0pUQe/lcseGGCaBdCga
        d3KtYexKieE19iDXwnLpViw=
X-Google-Smtp-Source: ABdhPJxrXmA6u06pI41W4yAVsnlhdmzOfgm5MvrYU0pjv9PKFXeXqWfw1pJ1g0MTX00czpX+k5Zw1w==
X-Received: by 2002:a4a:d04f:: with SMTP id x15mr7842090oor.87.1596722070135;
        Thu, 06 Aug 2020 06:54:30 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7c76:9d28:ed6d:5408? ([2600:1700:e72:80a0:7c76:9d28:ed6d:5408])
        by smtp.gmail.com with ESMTPSA id y73sm1132650ooa.25.2020.08.06.06.54.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:54:29 -0700 (PDT)
Subject: Re: [PATCH v2 11/18] maintenance: auto-size incremental-repack batch
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <478c7f1d0b858755c2c4b98605405214910b6f4c.1595527000.git.gitgitgadget@gmail.com>
 <20200729222334.GE2965447@google.com>
 <b374cb3a-f681-d514-c465-6b3f0b674bcf@gmail.com>
 <c0b9876a-9041-3400-25ac-e52568a02074@gmail.com>
 <20200805123721.GA23655@danh.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d02d5948-0b5a-2103-7a57-1bcb54db1231@gmail.com>
Date:   Thu, 6 Aug 2020 09:54:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200805123721.GA23655@danh.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/5/2020 8:37 AM, Đoàn Trần Công Danh wrote:
> On 2020-07-30 15:02:32-0400, Derrick Stolee <stolee@gmail.com> wrote:
>> On 7/30/2020 12:57 PM, Derrick Stolee wrote:
>>> On 7/29/2020 6:23 PM, Emily Shaffer wrote:
>>>> On Thu, Jul 23, 2020 at 05:56:33PM +0000, Derrick Stolee via GitGitGadget wrote:
>>>>> diff --git a/builtin/gc.c b/builtin/gc.c
>>>>> index eb4b01c104..889d97afe7 100644
>>>>> --- a/builtin/gc.c
>>>>> +++ b/builtin/gc.c
>>>>> @@ -1021,19 +1021,65 @@ static int multi_pack_index_expire(void)
>>>>>  	return result;
>>>>>  }
>>>>>  
>>>>> +#define TWO_GIGABYTES (2147483647)
>>>>
>>>> [jonathan tan] This would be easier to understand if it was expressed
>>>> with bitshift, e.g. 1 << 31
>>>
>>> This is actually ((1 << 31) - 1) because "unsigned long" is 32-bits
>>> on Windows. But it's better to not use magic numbers and instead use
>>> operations like this.
>>
>> Nevermind. This breaks the build on 32-bit machines (even adding a few
>> "L" characters). I'll replace my magic decimal number with a magic
>> hexadecimal number.
> 
> Would it be better if we use this C99 feature instead:
> 
> 	#define TWO_GIGABYTES INT32_MAX
> 
> But it seems like it's available everywhere, except (maybe) Windows.
> (judging from UINT32_MAX's usage)

Thanks for the recommendation. This appears to work in all of the
CI builds, including Windows. I'll use that constant in my next
version. Perhaps we will discover a platform that doesn't have it
by including it.

-Stolee
