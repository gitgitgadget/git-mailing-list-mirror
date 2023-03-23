Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD3EC6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCWQi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjCWQih (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:38:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B44039CD8
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:36:51 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i9so21279545wrp.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1679589405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZEo1hCZvdMKWhCOr8tlZM3lciyW9eO1Glwfp+KS5cc=;
        b=m2MUH1VtEc+69hLW2VTvamRMrAHnYDNmDnoTKOz5XQEfparX/u81y+fmDCQI0drhCm
         CbNo0OeXwnKKwCMbyH/mbAJ5CRAgAtOeIZgrjhELfCQqZ0TsY4fMr6zdl/415/u0rQtd
         sWLXrAOa1jhWxoKSfKJAhrZuV8y+xeBaw008k3JS2J74KnFYymqmCiYLpV1CwoO8X+hk
         gKoZqqFi+QdLxFUDuwCBYU//e8l80o0X9vKbvn1T0cwOU5/T9Byh0ROYu7tiGfIJZR6c
         2HWMlnotSstJF8IRaW4dJEGroRkwN6yJfx7Jpn8Yicyq8h0eOYPYfYTyHiGBbplBbpNQ
         /2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679589405;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZEo1hCZvdMKWhCOr8tlZM3lciyW9eO1Glwfp+KS5cc=;
        b=5kFX3c+N3281WYGDR3H6lvpUaJYB1rnjO3Ua4s0ITO9W73YMgK7z7aXn6Mdc7IqMZa
         AGZfRS72R5kO7bWsKjGvFsQZe75rCp85Rz3vZ6JnSj4VgCD3m3heeniRN1sfo2bkiq+i
         hnv7uZOFjzO/3exd7a0kqVnA24+ja3To2zw2gKqxOgq94T14PX013EhCbJqpvfWim3Ea
         X+edjsoGFAbzOTpXOG4gGwmmPSvhCziMCeP7L9TYWeQlH9iIrB3AxGMFza6fmC2lRxY1
         dXhM7KbIAmdjTCcDAXxmTZgls/LQJDUYjKPF2m3RkHjhL6SRXbazUhYodqaMTOg2ni/G
         3Jew==
X-Gm-Message-State: AAQBX9fmm6ofPOwCgmN/joOzFZ3NDsKXnOkAwfvuCH/y7TnpXK3rMTW9
        jNy07dDpNI1Fj+o8Jd+uZB9UCQ==
X-Google-Smtp-Source: AKy350Zuvr3AOnYsi80TQfnrkdDKjE46kV1BtrN1LTahQ4Ur63XLjTv+K3/3Rv38eby7oimVYP0rGA==
X-Received: by 2002:adf:e552:0:b0:2d8:e408:bdde with SMTP id z18-20020adfe552000000b002d8e408bddemr3142533wrm.2.1679589405646;
        Thu, 23 Mar 2023 09:36:45 -0700 (PDT)
Received: from ?IPV6:2003:f6:af15:6c00:305b:eb05:c4d4:88fb? (p200300f6af156c00305beb05c4d488fb.dip0.t-ipconnect.de. [2003:f6:af15:6c00:305b:eb05:c4d4:88fb])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d48cc000000b002d431f61b18sm14752858wrs.103.2023.03.23.09.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:36:45 -0700 (PDT)
Message-ID: <e3af033b-7ff6-f76f-a431-872d54289d57@grsecurity.net>
Date:   Thu, 23 Mar 2023 17:36:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Suspected git grep regression in git 2.40.0 - proposed fix
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Stephane Odul <stephane@clumio.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <7E83DAA1-F9A9-4151-8D07-D80EA6D59EEA@clumio.com>
 <xmqqttyejc7y.fsf@gitster.g>
 <b0f4b588-9871-8e59-e5a2-3f8745a7c4cd@grsecurity.net>
 <51078D7E-C325-4F57-96C1-601B4E102DD9@clumio.com>
 <4a103812-c4c6-a010-c2e5-4e42e9855c2e@grsecurity.net>
 <20230323144000.21146-1-minipli@grsecurity.net> <xmqq355va1a2.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqq355va1a2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23.03.23 17:19, Junio C Hamano wrote:
> Mathias Krause <minipli@grsecurity.net> writes:
> 
>> ... or fall-back to the previous behaviour and
>> ignore Unicode properties (and reintroduce the bug commit acabd2048ee0
>> ("grep: correctly identify utf-8 characters with \{b,w} in -P") wanted
>> to fix).
>>
>> I went with the second option and could confirm the below patch fixes
>> the segfault on Ubuntu 20.04 which is shipping the broken version.
>>
>> Junio, what's your call on it? Below patch or simply a revert of commit
>> acabd2048ee0? Other ideas?
> 
> Thanks for all the investigation and a prompt fix.  Very much
> appreciated.

As there was the slight chance it could be caused by my grep.c change, I
had the ambition to prove it either way. :D

> As you identified where the breakage ended in the versions of pcre,
> I think that the approach the patch I am responding to takes is more
> sensible than a straight revert.

Ok. It's really unfortunate that PCRE2 has so many bugs we need to work
around :/

> But I somehow suspect that it may be better to have the "workaround"
> independent of the line acabd204 (grep: correctly identify utf-8
> characters with \{b,w} in -P, 2023-01-08) touched, more like how we
> "Work around ... fixed in 10.36".
> 
> IOW, not like this
> 
>>  		options |= PCRE2_CASELESS;
>>  	}
>> -	if (!opt->ignore_locale && is_utf8_locale() && !literal)
>> +	if (!opt->ignore_locale && is_utf8_locale() && !literal) {
>>  		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
>> +#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
>> +		/*
>> +		 * Work around a JIT bug related to invalid Unicode character
>> +		 * handling fixed in 10.35:
>> +		 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
>> +		 */
>> +		options ^= PCRE2_UCP;
>> +#endif
>> +	}
> 
> but more like
> 
>  	if (!opt->ignore_locale && is_utf8_locale() && !literal)
>  		options |= (PCRE2_UTF | PCRE2_UCP | PCRE2_MATCH_INVALID_UTF);
>  
> +#ifndef GIT_PCRE2_VERSION_10_35_OR_HIGHER
> +	/*
> +	 * Work around a JIT bug related to invalid Unicode character
> +	 * handling fixed in 10.35:
> +	 * https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
> +	 */
> +	options ^= PCRE2_UCP;
> +#endif
> +
>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
>  	if (PCRE2_MATCH_INVALID_UTF && options & (PCRE2_UTF | PCRE2_CASELESS))
> 
> That way, no matter how we ended up setting the UCP bit in the
> options variable, we would avoid broken UCP handling on problematic
> versions, no?

Ah, sure! It's no issue with the current code base, as PCRE2_UCP only
gets set in that branch, but there's no need to narrow the workaround to
it as well.

I'll send a v2 in a few!

Thanks,
Mathias

> 
>>  #ifndef GIT_PCRE2_VERSION_10_36_OR_HIGHER
>>  	/* Work around https://bugs.exim.org/show_bug.cgi?id=2642 fixed in 10.36 */
>> diff --git a/grep.h b/grep.h
>> index 6075f997e68f..c59592e3bdba 100644
>> --- a/grep.h
>> +++ b/grep.h
>> @@ -7,6 +7,9 @@
>>  #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
>>  #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
>>  #endif
>> +#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 35) || PCRE2_MAJOR >= 11
>> +#define GIT_PCRE2_VERSION_10_35_OR_HIGHER
>> +#endif
>>  #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
>>  #define GIT_PCRE2_VERSION_10_34_OR_HIGHER
>>  #endif
