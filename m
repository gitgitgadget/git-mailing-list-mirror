Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CACC1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 16:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeGRQmm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 12:42:42 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45502 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeGRQmm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 12:42:42 -0400
Received: by mail-qk0-f193.google.com with SMTP id c192-v6so2642733qkg.12
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=jJu3Jr1fUgu7OPEWFpRhyOjfzGyHrBWCmDyuMP2gO1M=;
        b=se4fCStpxDOmgUU4tb1cxSOaTZLsip/IKiAtHZwyd1xWgTBZiFUvCnPgKuvSDFFi0r
         rIhW7bxwZ+OARlU4KhkuO1fX1o8JB1nQn7OqhP5FlJI6oadGrPlYKQepW5OreZaW0HuZ
         +DjQUJPMi7jzidd3KKfSzn/6IBtTAepLot8CKKAwrEozHI4sb3i89RdUEmOE+HQ1V6iJ
         1bXpb4PmgTc+KAx7jU/ZDHGEKEIk3QU4trOhlc62/HzpxPDHelwOHhZVAgyGOrJcCY86
         qtZ+/LNIGfeuRjNX87qN06AroPPtJF1Jc9j6/t778lrkbSAyepNqaQfzwmqDJAWskjfc
         E/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=jJu3Jr1fUgu7OPEWFpRhyOjfzGyHrBWCmDyuMP2gO1M=;
        b=YjmEqDE5HilKwhKzcj8F+LWCGNnkX5+iYmjsO43iGMk4mHLy8b+ddDyjr9tnyTaayJ
         IfresuHDX3+pMGq5xsYhcri5ZjjfFTKDldS3O4C2X3zXF8XKhN574olWkxk/mGGhpZHs
         5964LfKRM04a8SgSLgluUKCX3GTRvu/aadVsg6Wo+v/LH+lZqj9XZYoURTj7BGAoYoo6
         y52TzA5Oom+zfUOQOjrRJhgD2D8La6C0PMS7K5xwRd/rPgYQCuzvK2qRAtAOxxueNYmF
         TZb3kjYqTNBt1Z5+x9xH4I1klX7kBoUG8a2ve5uhvC4n45xagIJ/0Ow850NzF08I2ujr
         5KNw==
X-Gm-Message-State: AOUpUlFgDECqB/DpKmPgaLtO/qlRwYDd9Kq3JBKWGGg8jgpn77Kmq2cj
        XNq9oTbIpWM7mtlqZmuVLt0=
X-Google-Smtp-Source: AAOMgpeRigytVwKnvrU5Z66jC2RbSxmH7hxXnLi/IlTzUnWYlo8gsmjgewe/Qp8U/bvmfQ2RxB4RZA==
X-Received: by 2002:a37:b943:: with SMTP id j64-v6mr5744815qkf.291.1531929847646;
        Wed, 18 Jul 2018 09:04:07 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d070:73be:3735:cf07? ([2001:4898:8010:0:b9a6:73be:3735:cf07])
        by smtp.gmail.com with ESMTPSA id i32-v6sm2502571qtb.21.2018.07.18.09.04.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 09:04:06 -0700 (PDT)
Subject: Re: [PATCH 06/16] upload-pack: generalize commit date cutoff
To:     Stefan Beller <sbeller@google.com>, gitgitgadget@gmail.com
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.10.git.gitgitgadget@gmail.com>
 <74b7352b580ae920d9d5f206b9389e207aada4fe.1531746010.git.gitgitgadget@gmail.com>
 <CAGZ79kZVyd1BgWGW85PxF_4Skv4pEB=a5iH_1i=5B6X07cfyoA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7ccf3170-dd7e-6322-a128-b31a29f6ac7b@gmail.com>
Date:   Wed, 18 Jul 2018 12:04:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZVyd1BgWGW85PxF_4Skv4pEB=a5iH_1i=5B6X07cfyoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/16/2018 3:38 PM, Stefan Beller wrote:
> On Mon, Jul 16, 2018 at 6:00 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> From: Derrick Stolee <dstolee@microsoft.com>
>>
>> The ok_to_give_up() method uses the commit date as a cutoff to avoid
>> walking the entire reachble set of commits. Before moving the
>> reachable() method to commit-reach.c, pull out the dependence on the
>> global constant 'oldest_have' with a 'min_commit_date' parameter.
>
>    'oldest_have' seems to be used in only one method after that
>    (function got_oid); but as that function is called many times
>    we either have to make it a function-global or pass around as a parameter,
>    we'll defer that to later.

There is a lot of global state involved in this negotiation code, and it 
lives between negotiation rounds when the transfer is stateful. Tread 
carefully!

I did not attempt to reduce the global state at all.

Thanks,

-Stolee

