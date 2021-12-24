Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1351C433F5
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 19:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353458AbhLXTFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 14:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353453AbhLXTFq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 14:05:46 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60026C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 11:05:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c7so7122936plg.5
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 11:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dH5cyxH4Hw3W5jdlJG0UqfbsHDYXhFmakFNObIVosng=;
        b=fR/SjGu2wAw5MaGY1HFihOSXbuOhVokxMFCuD/OYfXLv09dlCrLTzE0ziJXjzi1m4l
         sqahacxPKk0w2xt1rrT/VNKrP2MfuKqtiXm4rdesazrQPHZcyoKoKPBfwhDIjdTk3s8b
         4EsIUeyzUIchYI2wIwuamUwrdNEdWqosS93ojwEojiDhp9+jecULXtjZ9cQqVTEpgL2u
         lvgGVfY1ir+7PXZ6P/Uqf/ycR86S4cTxLIxyBt7ExGoqI9n+7R7Qck66495PB6wzfSV0
         lKzEx5JC1e8GjapxydzxcCud9mx7ywYCxJTmAcw+09rYhMlwQ1U4HkELvmrnkvI0e778
         AyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dH5cyxH4Hw3W5jdlJG0UqfbsHDYXhFmakFNObIVosng=;
        b=2TvVKdKPPYWbqA6z+Zq7K0ofcWAyFSIoHu5N3KssqdayBt9/QkjeUKfKFqaIVVkUnP
         Rdb9YIe5paSw+mUuG0G0NcYeK3dIzBm6GYiBS4ItdqF+hlkZ+ON6P/LbfmQjyXXVXyoQ
         WrmMXvROPtU+sSO8TLhgt/IvXhbLeq6tjYUgR26D8sSQYn+PZHSNY1tUazOvBS6/FKz5
         tMY9FhJ3Lbo4/v5ixgxTZPWfH6kpLS3Z6wG8P/FIf6G8lHpN9z58ipdBv16AAczPRdj+
         BoKdpqNh59YRnSKB/DLn5gtZJDZDJly6RmDHqVnq7DKtoSH0pLUwCocjKnwQK0VP2vLu
         9vTA==
X-Gm-Message-State: AOAM531FTS1J/SA2RUkpJs/N+QG4WYrnFiXNQfLXZLHqDipcPvz0P/p3
        LJnbSC2SGs34/WOTUkTrUx2pN+MPYDLcPA==
X-Google-Smtp-Source: ABdhPJx7f2uQZkmOdH306kEURioPmEs8NtIqxvhzudgXHvrT6N2BA+kAgU5vtLdpt7UnC2S1iaQg3Q==
X-Received: by 2002:a17:902:7593:b0:149:5535:9ec7 with SMTP id j19-20020a170902759300b0014955359ec7mr6862568pll.18.1640372745670;
        Fri, 24 Dec 2021 11:05:45 -0800 (PST)
Received: from [192.168.18.18] ([103.252.33.202])
        by smtp.gmail.com with ESMTPSA id mw8sm8915466pjb.42.2021.12.24.11.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Dec 2021 11:05:45 -0800 (PST)
Subject: Re: Git internal command line parser
To:     Philip Oakley <philipoakley@iee.email>, git@vger.kernel.org
References: <0347f273-f9e9-3ce6-2a95-f1ce71285c09@gmail.com>
 <e2726eaa-ba73-4141-bf61-89d5a7e9a9c2@iee.email>
 <0e0f78e9-2cde-a20e-cd47-8542bc7bd314@gmail.com>
 <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
From:   Lemuria <nekadek457@gmail.com>
Message-ID: <902f8da8-970f-0a5f-a88e-d75754b71440@gmail.com>
Date:   Sat, 25 Dec 2021 03:05:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <cc6fa52a-d782-d4a8-eb93-936b8d83fc2f@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 25/12/2021 2:36 am, Philip Oakley wrote:
> On 24/12/2021 18:30, Lemuria wrote:
>>
>>
>> On 25/12/2021 2:13 am, Philip Oakley wrote:
>>> On 24/12/2021 14:38, Lemuria wrote:
>>>> #=< TLDR: Where's the code for git's internal command line parser?
>>>>> ===#
>>>>
>>>> I'm interested in the internals of git, more specifically it's command
>>>> line parser.
>>>
>>> One place to start is https://github.com/git/git/blob/master/git.c
>>>
>>
>> Wait, is all of Git just one big executable or are there many
>> executables and `git` is just the front-end for accessing the
>> separate git executables, such as say, the one for processing
>> commits?
>>
> 
> Yes, `git` is a front end.
> 
> If you are on Windows, it gets even more interesting because all the
> individual sub-commands are just hard links back to the single git.exe
> that then links to those sub-command's code.
>

I'm on Ubuntu 20.04, just in case you ever want to know.

And I likely will consider this "front-end to many separate
executable apps" approach for my future large projects.

Thanks for your help! I've also cloned the git repository of
git, and I'll take a look through the source code.

I'm also a beginner to C, not quite an expert at it.

>>>>
>>>> Does Git use a library like getopt for it's command line handling, or
>>>> does it use a custom parser?
>>>>
>>>> If possible, I would appreciate being redirected to the source code
>>>> files that handle this.
>>>>
>>>> Sincerely,
>>>> Lemuria
>>>
>>> Philip
>>>
> 
