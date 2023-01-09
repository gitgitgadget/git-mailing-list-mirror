Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353DC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 14:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjAIOmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjAIOmG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 09:42:06 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE72E1AA07
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 06:42:02 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id i82so3773552vki.8
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=585u5MgN5nit8mzeOIUGJktSbAJapU9C6XV/5bCTxGk=;
        b=UqsovaRHSldjq4VHxoHmdbl1ShJXmqDsdkWgCPL/2lMc+cyB3fYDFY5Qb2O8wyeQCl
         BTLQl6JZkmC+a5L8SGC4J4Lg2S+SR+EP/f5PuTj2qUxbFNn8FW19R/q5OA2tozqJtpaN
         gjyOEJPyzRhsVBCP7fmM1ePbi1VSPoipJFAGnuDA4VdI1o6WNU8jwQ3Z7pJXvrZz7c+1
         jCcS2q1UsaH6s2NhjcapzkTB6d8zI4HHDPhcb4GLJluTvYQppOZHbK5g/oIfVP0EI94R
         OIqDcLMK5r1sZG5BFWQR4lyJHAZhTONIjbLQICDNNu1f4LohOYFnTOWFtQ6kwttnrFgO
         7ZaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=585u5MgN5nit8mzeOIUGJktSbAJapU9C6XV/5bCTxGk=;
        b=CJie49fI9EL7j0NfzHfSoRue27ZnKN53h/SY6lKWi/ubHUBxPPGgnOKJZ03mAs62RW
         80M7bL2GnVdoJcv2dtJC5izZMfleDzIIu5YH3oh/oEN1x7CSZgJpxULcMPXvKbBS4M7C
         r4/xsoy8MQ1DyBX9FViRv77cLOX/FxZ1FH0OcfPTX0ILDa675oKJTXtYjS7A+LXxiVUO
         Mh3XSB8UwcPlIOL3EOJQ54t3nduq7SIkL8ouBHuU6PbfTb1QD22MHZ6z7frghH/eA9qU
         +5QXwHzzRWAZ6ES6EeQiGmW48NZPilE691s6iL0vuZuWWBs+D4LbLZs7Q+iLynsUCKQm
         oglA==
X-Gm-Message-State: AFqh2kooacm5I7Ygd4/ae4ONPreEeEptdPpLEjRwV7L7iYmGntpiDSji
        iG2Tb80rJHaFeLGlrHmwu50S
X-Google-Smtp-Source: AMrXdXsS/uck8pORAao5Wm7yGEqSUCY79J7wJTax3IPM2AxjRe/UlRFYgR08mFmOENnir9v7VjMVjQ==
X-Received: by 2002:a1f:1f04:0:b0:3da:7734:2e9 with SMTP id f4-20020a1f1f04000000b003da773402e9mr2524039vkf.16.1673275321879;
        Mon, 09 Jan 2023 06:42:01 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:9803:bdc5:6740:d9fa? ([2600:1700:e72:80a0:9803:bdc5:6740:d9fa])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a254f00b007056237b41bsm5454459qko.67.2023.01.09.06.42.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 06:42:01 -0800 (PST)
Message-ID: <3c0db749-5040-24eb-1b26-969e7c768906@github.com>
Date:   Mon, 9 Jan 2023 09:41:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/8] bundle-uri: parse bundle.<id>.creationToken values
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <a1808f0b10cfb519613bc292e30b884962a83275.1673037405.git.gitgitgadget@gmail.com>
 <xmqq8ricxv52.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqq8ricxv52.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2023 10:08 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	if (!strcmp(subkey, "creationtoken")) {
>> +		if (sscanf(value, "%"PRIu64, &bundle->creationToken) != 1)
>> +			warning(_("could not parse bundle list key %s with value '%s'"),
>> +				"creationToken", value);
>> +		return 0;
>> +	}
> 
> We tend to avoid sscanf() to parse out integral values, as it is a
> bit too permissive to our liking (especially while parsing the
> object header), but here it probably is OK, I guess.

I tried to find another way to parse uint64ts, but could not find
another example in the codebase. I'd be happy to change it if we
have a preferred method.
 
>> +	/**
>> +	 * If the bundle is part of a list with the creationToken
>> +	 * heuristic, then we use this member for sorting the bundles.
>> +	 */
>> +	uint64_t creationToken;
>>  };
> 
> Is the idea behind the type is that creationTokens, while we leave
> up to the bundle providers what the actual values (other than zero)
> mean, must be comparable to give them a total order, and uint64
> would be a usable type for bundle providers to come up with such
> values easily?

One easy way to create the total order is to use Unix epoch
timestamps (on the same machine, to avoid clock skew). We cannot
use the machine-local width of the timestamp types, though. And
there is no need to use timestamp-like values. The bundle provider
could keep an integer count.

I did add a test that ensures we test a creationToken that would
not fit within 32 bits.

Thanks,
-Stolee
