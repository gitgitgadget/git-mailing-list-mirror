Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39D2C77B78
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 14:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbjDZOoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbjDZOoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 10:44:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6687A91
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 07:44:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso50895725e9.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 07:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682520256; x=1685112256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7sqbKjWXw2V4dFoG3LUPYAYtVZNafhEhx7h2ymtleQM=;
        b=TKxykrqi5t5MwXzBZ3dvkn1A8hPfo5D/IjUxmXHpqy/zJXs9ccFFoDoZLy1WSFwNhS
         pyJ5fxtUfWN5FLnvmtBcsHU1ggCXVCsWrDexf8IjYgV8ZB3lFA3OocpQg+SwZVViiysC
         pLuMBIp/gFeWfV3pefp7kWq7cY/9ukulgd0Yc0f+0f9jrBsbE+qo/bn9J/63t8+v9EO/
         ZORlo6NTwAeebRcQowLedzG5BbuPFlr0Y2xqOfGaxz6K5pOjd97NlJBFrVA8ftslI3Xv
         PzwpEpc6WUPZXU0NVYOFXsjAO3phdsamVeiB3IgXwwSuhXhgN3kFzPUoSxhsHrinjUhw
         uXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682520256; x=1685112256;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sqbKjWXw2V4dFoG3LUPYAYtVZNafhEhx7h2ymtleQM=;
        b=i+BmiMI8H6ErO+lgnvR1WEMJFa+JvBF/SFpvVK1/sDxZLQKtv8G0HF81K094IMwf6q
         BGQoGIOC7pFruxmtspCDY4wifqQxaHscv2F2vxHJTLxrw2VoIc38QwnIp+5vgSLX4Zph
         c8kV3CRXCvfQzVGr/vMOkn9WXPLxgPuvZUqhH6KlJhNqAXX+Rez9HRVopgzHJ3vlIqgy
         qJgHTGzypHgdLnCWCPf0DhVmtNEQn6WeBgOCHd6WzNp8PhELnGvJfbPLFEgQ2+qJPIT9
         87FP/+SUSV6UOrIeKe+s/YbWwIJeoAoRe+JrRA//REP5+6otsqGDORqo5RaEtpFEpoH5
         ri8w==
X-Gm-Message-State: AAQBX9fZ//i72vO+nCW5mYmcqepHoEQ3bpG7gRPEos1y038vNzlM+AgN
        XgGvELH7EitB+fitE1un6xM=
X-Google-Smtp-Source: AKy350ZCKX85RiAdgkqaQ3ZvAHFjZi+Ovj+ZXYYUr8xR7jgZVdjhh6HsDVCfFmfMEGlIPwpSymWvhA==
X-Received: by 2002:a1c:7c13:0:b0:3f0:7f4f:2aa8 with SMTP id x19-20020a1c7c13000000b003f07f4f2aa8mr13001821wmc.9.1682520255848;
        Wed, 26 Apr 2023 07:44:15 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id iv18-20020a05600c549200b003f17b91c3adsm21996128wmb.28.2023.04.26.07.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:44:15 -0700 (PDT)
Message-ID: <01709d21-d641-cfcd-c389-da9aaf84f5be@gmail.com>
Date:   Wed, 26 Apr 2023 15:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Content-Language: en-US
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
 <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com> <xmqqttx43q08.fsf@gitster.g>
 <a6ce9393-331c-3ee0-648b-182614a7d275@gmail.com> <87mt2u3eav.fsf@igel.home>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <87mt2u3eav.fsf@igel.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas

On 26/04/2023 15:31, Andreas Schwab wrote:
> On Apr 26 2023, Phillip Wood wrote:
> 
>> On 25/04/2023 17:06, Junio C Hamano wrote:
>>> Phillip Wood <phillip.wood123@gmail.com> writes:
>>>
>>>> This probably doesn't matter in practice but we define our own
>>>> isspace() that does not treat '\v' and '\f' as whitespace. However
>>>> parse_timestamp() (which is just strtoumax()) uses the standard
>>>> library's isspace() which does treat those characters as whitespace
>>>> and is locale dependent. This means we can potentially stop at a
>>>> character that parse_timestamp() treats as whitespace and if there are
>>>> no digits after it we'll still walk past the end of the line. Using
>>>> Rene's suggestion of testing the character with isdigit() would fix
>>>> that. It would also avoid parsing negative timestamps as positive
>>>> numbers
>>
>>>> and reject any timestamps that begin with a locale dependent
>>>> digit.
>>
>> Sorry, that bit is not correct, I've since checked the C standard and I
>> think strtoul() and friends expect ascii digits (isdigit() and isxdigit()
>> are also locale independent unlike isspace(), isalpha() etc.)
> 
> The standard says:
> 
>      In other than the "C" locale, additional locale-specific subject
>      sequence forms may be accepted.

Thanks, looking at the standard again I don't know how I managed to miss 
that, my initial recollection was correct after all.

Best Wishes

Phillip
