Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DF5C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 18:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiI1Si0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiI1SiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 14:38:25 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9595C3120F
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:38:23 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 64so2293807iov.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 11:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=mhRCG9v6qTJsxktWlfp4FuGDKyuER0TEKAhinIk9uh8=;
        b=HoKsbPIRjFw7xneB1HDz8u11cBZRzdccqJJPvz1zheqAqlHpPl6w6QUx211f7fSJe+
         W+leQwn4AU2/3bZ3AMmXJ3OyTqQLaJD5B7NgPe63kPEZ4DiM5JlujqADwt13UAafisG+
         kjv1Rj4qEd1wcBw413fBMoBiX4wgqpnN5NvAjZFZSljSfAXhdxWf0GPFUGzUAc5pfTzc
         W8FcfggBL0twa0JRTxTp9XyPManrcAqJXeSnpzEwM+9aFFd81Y9+eFL7cSKepsnEX2Fs
         FHLzd0li50kix6nkKHr0ZbUlw5xWmjZfwhXMGsYgjQhms2+ThKxcCD1R8QTeF8hipOMj
         uTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mhRCG9v6qTJsxktWlfp4FuGDKyuER0TEKAhinIk9uh8=;
        b=3xZ+PktQeCC0AZpxCqkAad2QnvN9KbP2U9FAh/A8VsBK8JqBzGyG3o9AuDHNP/90Tc
         4QdzXYIjhYdzMlndIofuacH6ZwM+tkP1xOX2RqU+0SqBG3Y8FKDSnyJAVZZgrBGd3WOe
         F/Wx3hx5urKpeamBwQSst1TmNrOq/aQWzPDVpxDJqMFZHfr1HNmSaxbywUURNyMOtNb8
         JV3FcXzop9KBvB5qdUp0nWH8IVkfst0cPRj1/dJRq6BO+Mi3taDaDiQOSBGaYTR34dZ7
         rrHgFdrormMsEKSvaRaOk8myG6NYxGsKR/B2vXJanstMtfCmrS6qQApQW+knwA5ovfcK
         ivHQ==
X-Gm-Message-State: ACrzQf0Cc4v3h2whWbjCAR2jmM46dq4NHboUZWxm6bV5HRRnhVsZ523g
        LzY8EpyzyZ6nYEl75ULVlPFo
X-Google-Smtp-Source: AMsMyM6ePYTtWkppNVKNxHhcgOOn6+YKQ3f1vKKyTWv1nXmLquCBIBw37pB+/6IFIiBNrUu0y1jVFw==
X-Received: by 2002:a05:6638:370d:b0:35a:91f0:e358 with SMTP id k13-20020a056638370d00b0035a91f0e358mr17393748jav.84.1664390302948;
        Wed, 28 Sep 2022 11:38:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:e862:ab6a:f799:c583? ([2600:1700:e72:80a0:e862:ab6a:f799:c583])
        by smtp.gmail.com with ESMTPSA id y41-20020a02952c000000b0035672327fe5sm2061813jah.149.2022.09.28.11.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 11:38:22 -0700 (PDT)
Message-ID: <35f6d380-f7a5-558d-1cfc-f5eb6ea6c818@github.com>
Date:   Wed, 28 Sep 2022 14:38:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/5] [RFC] config API: return empty list, not NULL
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <xmqq35cc1arp.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq35cc1arp.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/2022 10:40 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This work changes the behavior of asking for a multi-valued config key to
>> return an empty list instead of a NULL value. This simplifies the handling
>> of the result and is safer for development in the future.
>>
>> This is based on v4 of my unregister series [1]
>>
>> [1]
>> https://lore.kernel.org/git/pull.1358.v4.git.1664287021.gitgitgadget@gmail.com/
>>
>> This idea came about due to a bug in the git maintenance unregister work
>> where the result from git_config_get_value_multi() was sent directly to
>> for_each_string_list_item() without checking for a NULL value first.
>>
>> I'm sending this as an RFC mostly because I'm not 100% sure this shift is
>> worth the refactoring pain and effort. I personally think getting an empty
>> list is a safer choice, but I can also understand if someone has a different
>> opinion.
> 
> Thanks.
> 
> I actually am in favor of the idea that a NULL can be passed around
> to signal the lack of a string_list (or the lack of a instance of
> any "collection" type), and the current code is structured as such,
> and it gives us extra flexibility.  Of course, we need to see if
> that extra flexibility is worth it.
> 
> With a colleciton col, "if (col && col->nr)" checks if we have
> something to work on.  But a code like this (which is a longhand for
> the for_each_string_list_item() issue we just reencountered):
> 
>     col = git_get_some_collection(...);
>     if (!col)
> 	return; /* no collection */
>     if (!col->nr)
> 	git_add_to_some_collection(col, the default item);
>     for (i = 0; i < col->nr; i++)
> 	do things on col.stuff[i];
> 
> can react differently to cases where we have an empty collection
> and where we do not have any collection to begin with.  
> 
> The other side of the coin is that it would make it harder to treat
> the lack of collection itself and the collection being empty the
> same way.  The above code might need to become
> 
>     col = git_get_some_collection(...);
>     if (!col)
> 	col = git_get_empty_collection();
>     if (!col->nr)
> 	git_add_to_some_collection(col, the default item);
>     for (i = 0; i < col->nr; i++)
> 	do things on col.stuff[i];
> 
> but if the "get the collection" thing returns an empty collection
> when there is actually no collection, we can lose two lines from
> there.

I'm all for conveying more information when possible, but how can
the config API provide a distinction between an empty list and a
NULL list? The only thing I can think about is a case where the
empty value clears the list and no new values are added, such as

	[bogus "key"]
		item = one
		item = two
		item =

With this, the key exists in the config file, but the multi-valued
list is empty. Is that an important distinction? I don't think so.

> Between these two positions, I am in favor of the flexibility that
> we can use NULL to signal the lack of collection, not a presence of
> a collection with zero items, as it feels conceptually cleaner.
> 
> Counting the hunks in [2/5] and [5/5], it seems that "when no
> variable with given key is defined, we return an empty set" makes us
> to have more code in 7 places in [PATCH 2/5], while allowing us to
> lose code in 10 places in [PATCH 5/5].

Outside of the "if (sl && sl->nr) {" that I forgot to convert into
"if (sl->nr) {" in patch 5, all of those 7 places that have "more code"
end up with only that extra "->nr". The code looks uglier temporarily
in patch 2 to create the compatibility mode so patch 4 can change only
the config API without test failures.

Thanks,
-Stolee
