Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A905C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiCGLUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiCGLUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 06:20:11 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F59BB85
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 02:45:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id b5so22542091wrr.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 02:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YmPFxzAmsfDSpNaZ3Cm1tuReFgFwxCofGAs6igmwb/8=;
        b=NU3E6GkAQRRlq6GQ5lHE71AhvkoTtZD9G1Je9H72YJ0sHGg0MeVvmxxnedOsgqM/Z3
         SBqxLYs6Kzs+Spa1u3YKp0LLaPveA10tVF1IbhxUXCCJ0XVQQS22QI2nb0nCNVaPdByJ
         AZcOcllYf/a7Lr0STZLjYtGtzk/smyW7No8sb/kMksrigv6wQN4y1mmMNslDjzTZmRfw
         N8Qaep0JhcHUAvdMORvria11GXszbQD5+u+7ggnAm9dJYJjx8ifLbar70NFu4EXl/H1s
         t0J9HgXz+LoGtSEUtXAyYT9BGZzED8cVwIkARHQW9+9DHV1m2eRTgJFTiGsS1Jg3rzic
         l/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YmPFxzAmsfDSpNaZ3Cm1tuReFgFwxCofGAs6igmwb/8=;
        b=VyyNgnbA5i0yYASjOBBQhYX8KnM7qgmeFYVlDs5R8puma4JDllMEU8ikjZPW6LYFFp
         UDvQYG9qbTBqDN4iv2TM36kDwN5a4YgHOsDlt5WgvbOwmI2ZvK0f6rE4sC4U4/WLkvHQ
         Sdw7/9NSv7GGYVuVKeYpfDPdFFD2C4Ygti8lDfNZrMSZTV2KBPBrmKsa0DhExOCyhZT2
         aGglInTlu4yWvFRAq5oywP+md7roBoU1feq/6ZjzjUAXjdOK51MVwymWjN0Ust4lYgQg
         LCZtTLLsP/LCT8YW+8AfNR5/gywYYIbvvZdY27z1f3qL38ycxatVwS4+E+QUvLqJ8ZIg
         IKtQ==
X-Gm-Message-State: AOAM531z0XSTln6Yd2n2nXVdJH29GU/XtgQ9327PUh0T2je81PRXpk4E
        707OI8gSx8Ux9PeChD1yv7I=
X-Google-Smtp-Source: ABdhPJwkzyyszsEQaFUUmFMVii5iitj3GUHHQ28q1mUkViOXESObKrzWidVrFrCAhdyWDtCxESCUSQ==
X-Received: by 2002:adf:b74b:0:b0:1f0:52c:c7a9 with SMTP id n11-20020adfb74b000000b001f0052cc7a9mr7271148wre.688.1646649906115;
        Mon, 07 Mar 2022 02:45:06 -0800 (PST)
Received: from [192.168.1.201] (206.2.7.51.dyn.plus.net. [51.7.2.206])
        by smtp.googlemail.com with ESMTPSA id m11-20020adff38b000000b001ef879a5930sm10790186wro.61.2022.03.07.02.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:45:05 -0800 (PST)
Message-ID: <1351bb93-673e-817f-6911-d321217032ce@gmail.com>
Date:   Mon, 7 Mar 2022 10:45:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] terminal: use flags for save_term()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>, carenas@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220304131126.8293-2-phillip.wood123@gmail.com>
 <220305.867d984hsk.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220305.867d984hsk.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/03/2022 14:02, Ævar Arnfjörð Bjarmason wrote:
> 
> On Fri, Mar 04 2022, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> The next commit will add another flag in addition to the existing
>> full_duplex so change the function signature to take an unsigned flags
>> argument. Also alter the functions that call save_term() so that they
>> can pass flags down to it.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>   compat/terminal.c | 41 +++++++++++++++++++++--------------------
>>   compat/terminal.h |  5 ++++-
>>   2 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/compat/terminal.c b/compat/terminal.c
>> index d882dfa06e..bad8e04cd8 100644
>> --- a/compat/terminal.c
>> +++ b/compat/terminal.c
>> @@ -34,7 +34,7 @@ void restore_term(void)
>>   	sigchain_pop_common();
>>   }
>>   
>> -int save_term(int full_duplex)
>> +int save_term(unsigned flags)
> 
> Doing e.g.  ...
> 
>>   void restore_term(void)
>> diff --git a/compat/terminal.h b/compat/terminal.h
>> index 0fb9fa147c..f24b91390d 100644
>> --- a/compat/terminal.h
>> +++ b/compat/terminal.h
>> @@ -1,14 +1,17 @@
>>   #ifndef COMPAT_TERMINAL_H
>>   #define COMPAT_TERMINAL_H
>>   
>> +/* Save input and output settings */
>> +#define SAVE_TERM_DUPLEX (1u << 0)
> 	
> 	enum save_terminal_flags {
> 		SAVE_TERMINAL_FLAGS = 1 << 0,
> 	};
> 	
> Here would be better IMO. See 3f9ab7ccdea (parse-options.[ch]:
> consistently use "enum parse_opt_flags", 2021-10-08) for how it makes
> debugging better.

I'd remembered Junio objecting to enums for bit flags in the discussion 
of that patch but looking at the whole thread it seems like the debugger 
support lead him to change his mind. I'll update.

Best Wishes

Phillip
