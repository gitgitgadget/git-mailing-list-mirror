Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30ECFC38A2D
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 10:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiJYKGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 06:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiJYKFn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 06:05:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DFF61799BC
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:00:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m29-20020a05600c3b1d00b003c6bf423c71so11527556wms.0
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 03:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMC80kpxhr025gsYo7o7txGFVX2l6i5sBlsz2snaOdY=;
        b=hvNPkAQJINDqUed60lNX5kWcSnbkXBwdninmA0qEv+z2XQA++VZ7L+KoItv2b3vGk7
         jsvkh9S5DPUu3mldoa/EG65QaWq8iL2BrGB1VUyLLeoQqo+dVyJQDFllnTtF+jJ7WKzc
         L/W7V/4NiUuh9MODte2UN7EJohOhibIXUL6glPnEkY0WHCai4bsbDDmlJeqWPCa8yRA8
         TvRyHHRWKSDMw1Ys6tn1BlXUIWyqdx5GDFdO1HbZEZKfhKrNvYJlsJAnwaPuJIJ4tMCU
         9UMlZ+7yTeyDJAxFw3CeaSEkmbM+4Fnl45CIQxu8y81AXPthZwdIWAIApMeEgwlpe483
         uVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mMC80kpxhr025gsYo7o7txGFVX2l6i5sBlsz2snaOdY=;
        b=5WWCAHCkv3gzTIiycS0LFY2hdxz4oAGFavLDB9eF+Uw0aPnKpaEUuGsCU6+CC0lmLz
         fz3bkQmuVWmR6wo4gUnMc/0ZU75sOH1aZ+yK6frlHxouNYeuRHY5aEN+oEnwoEnmA74T
         K3sutcQz5CnaKjab4Q4/8xX14h6eiFWQttvUpX+JekNtxolU5G2b4S359xHIv6CJR/x7
         klfpNLnTjIlvf4399uXZpns8P0sxoOOF+PDSMq7k5xld9lr2fzk6pVTOu2B/Mie9ThZF
         g3VSNLqCtlt9gXOvtpPea24Gc/yyuTmskHBeD/EEdlacachnbg+7wI0BrPTNYNxxjG60
         EVpg==
X-Gm-Message-State: ACrzQf1zeHYVk5edM8xb/qb5koBCXZx1If3H5K/2sR8kmtH0pZuUmVDH
        4/O6kemzmpa1KMqw8QVJUnU=
X-Google-Smtp-Source: AMsMyM6qoc/LdUR6pw/rwTywSCmj2Grrq6AkA7Zc7tLT/zGy6EDX8Sex/afMTP/ldJZUsHeSoilvrA==
X-Received: by 2002:a05:600c:4e47:b0:3c6:fc59:5eff with SMTP id e7-20020a05600c4e4700b003c6fc595effmr26226861wmq.18.1666692004587;
        Tue, 25 Oct 2022 03:00:04 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id m64-20020a1c2643000000b003c5490ed8a6sm10545866wmm.8.2022.10.25.03.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 03:00:04 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <190de302-0898-50a1-1a9d-ab1ccc5c6bb8@dunelm.org.uk>
Date:   Tue, 25 Oct 2022 11:00:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
Content-Language: en-US
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
 <xmqqpmeljae9.fsf@gitster.g> <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de>
 <xmqqv8obhkeb.fsf@gitster.g> <c24c3ac9-0de6-62f6-607f-2d8f69ca9fa8@web.de>
In-Reply-To: <c24c3ac9-0de6-62f6-607f-2d8f69ca9fa8@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/10/2022 06:57, René Scharfe wrote:
> Am 22.10.22 um 18:51 schrieb Junio C Hamano:
>> René Scharfe <l.s.r@web.de> writes:
>>
>>>>> +		if (max < 0)
>>>>> +			BUG("max must be a positive integer");
>>>>
>>>> In parse_signed(), would we expect to accept end-user input that is
>>>> a negative integer?  We must.  Otherwise we would not be calling a
>>>> "signed" parser.  Now, are there cases where the valid value range
>>>> is bounded by a negative integer at the top?  No current callers may
>>>> pass such a value, but is it reasonable to add such a new constraints
>>>> to an existing API function?
>>>
>>> Hmm, if minimum and maximum are not symmetric, then we need to supply
>>> both, don't we?
>>
>> Ah, thanks for injecting doze of sanity---I totally missed that the
>> bound was about the absolute value, so we can say "this is signed,
>> and the allowed values are (-3, -2, -1, 0, 1, 2, 3).  If so, then the
>> "reject negative max" in the posted patch is not a problem as I said
>> above.  I somehow thought that giving -1 as "max" would allow callers
>> to say "non-negative numbers are not allowed".  But that is not what
>> is going on.
> 
> Right, currently the value of `max` is used to check the absolute value,
> i.e. it imposes a limit in both the positive and negative direction.
> 
>> Allowing callers to specify both lower and uppoer bounds so that
>> they can say "the allowed values are (-1, 0, 1, 2, 3)", while it
>> might make it more useful, is a separate new feature development and
>> outside the scope of "let's tighten the parsing of end user input"
>> Phillip has here.
> 
> Allowing arbitrary limits in both directions might be a new feature, but
> it's required if we want to support the full range of values.  E.g. on
> my system INT_MAX is 2147483647 and INT_MIN is -2147483647-1.  Currently
> git_parse_int() rejects INT_MIN as out of range.
> 
> In my eyes the assumption that a single limit can be used to check both
> directions of the signed number line is flawed and caused the undefined
> behavior.  Dropping it avoids tricky calculations that try to infer the
> lower limit somehow and opens the full range of values to us.
> 
> That said, I'm not sure how useful the values INT_MIN, INT64_MIN and
> SSIZE_MIN (which unlike SSIZE_MAX is not defined by POSIX [*]) actually
> are. But doing the checks properly requires separate min and max values.

I'm happy to go either way, while I agree passing separate limits to 
allow INT_MIN is technically correct I'm not sure anyone has complained 
that the current code is too restrictive.

Best Wishes

Phillip

> René
> 
> 
> [*] Perhaps git_parse_ssize_t() should reject values less than -1; only
> that single negative number is needed to represent errors or unlimited.
