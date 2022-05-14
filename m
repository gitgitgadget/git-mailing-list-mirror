Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479E1C433FE
	for <git@archiver.kernel.org>; Sat, 14 May 2022 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiENPAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbiENPAW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 11:00:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC54E08;
        Sat, 14 May 2022 08:00:18 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so14848640wrv.10;
        Sat, 14 May 2022 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=vv+o+55YXAM2c6OUCRW2q6ii8idb0X1t9nLPOtCUUZQ=;
        b=jzwA06VJmmXnaSxDmJLTAqHI8qmB3Cvtoe3lfLfzqZihTf6lNK0UzWs7r6zWAbLYU3
         GWclQV3Tepl3fiVPcVtlV2BLzAQzUJL3Kug2M/FihPL95MsXDcQ1QrMg39JfOoTYJKaS
         Tqf0F2FYNmEGosOfVPGscy3P5QPzxov8MRPhC8VzMjLGgUVP2am2Q6OI7KEr3U1+bk1G
         eHxFSNNJi1ygGOdbN3HB+zJ0822MCklsTKXMET5AfW0onmjIlAxbHGa80Czy81TAPd3a
         sOFw0IDHVmEqlOLMzSh75x5eMJveaDglvEKrq4F/pIRWASOJGvh2gcjM5oyMjX4CG7IO
         qSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=vv+o+55YXAM2c6OUCRW2q6ii8idb0X1t9nLPOtCUUZQ=;
        b=lOaDP0smB+9cWCy6Mq8dUEO1AHWiE/iSVwpIy5TXNDRbesVsyAabhZ0UFZnw9GveAl
         OYQnSuEoiafP1cqgZpKM3mimwNwz2w7tXf46zhXEUdIMS/fOBs+yEF/DQi84IP8NDJkj
         eylIjCUCYo8gyFq7pmXtjDEGfsEYT9Xc02BMc6MYmaMA7dLjnzCd9lICHvT84byl8JC2
         nT8cnUrgNJNB/Bq1Kpg7N6cIC1qfU5cZIeU5vO14KkFJhSTiRdjI0CHIzDp1Z4Vzf9RC
         3uZLS0GSJx6TiBdGZX9ulORBvYR3H+P8BPHB7/0zodhBbzjQvgpeU3HzqDJsVMLcoNc2
         uWEw==
X-Gm-Message-State: AOAM531vZR2/yCLTwsVcwiGAWUJr19U8P7XmA8ARJWuIZT+rsmBc7y0G
        uaOlvH6N6YjDpmf+m0T8DW8=
X-Google-Smtp-Source: ABdhPJzjBKMRRSWA2z5JWZ324rwFI0/FzSJJzD/7eX9uAEIQDCFKRonJDM2Bj0vhY06lM5LvGw9Xzg==
X-Received: by 2002:a5d:618f:0:b0:20c:ffa0:95a8 with SMTP id j15-20020a5d618f000000b0020cffa095a8mr1741344wru.306.1652540417081;
        Sat, 14 May 2022 08:00:17 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600c4e0c00b003948f4e750fsm8453090wmq.23.2022.05.14.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 08:00:16 -0700 (PDT)
Message-ID: <76ff060f-a3f2-2e60-5b1a-4a59cf3f3d8c@gmail.com>
Date:   Sat, 14 May 2022 17:00:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] getpriority: Only getpriority translation the priority
 values
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     Theodore Dubois <tbodt@google.com>
Cc:     linux-man@vger.kernel.org, mtk.manpages@gmail.com,
        git@vger.kernel.org, nick black <dankamongmen@gmail.com>
References: <20220510220821.1481801-1-tbodt@google.com>
 <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
In-Reply-To: <0fc70bd3-5883-47e4-1814-6ed6c756a400@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[CC += nick]

On 5/14/22 16:37, Alejandro Colomar wrote:
> Hi Theodore,
> 
> On 5/11/22 00:08, Theodore Dubois wrote:
>> The translation is needed to avoid returning a negative number from a
>> successful syscall, and this requirement doesn't apply to setpriority.
>> See the implementation of getpriority in kernel/sys.c.
>>
>> Signed-off-by: Theodore Dubois <tbodt@google.com>
> 
> Patch applied.
> 
> BTW, I had to manually edit the patch.
> It's the second time I see this (I can't find the other one), your patch 

The other one:

<https://lore.kernel.org/linux-man/809c40c4-068b-8296-57d9-024e6623362d@gmail.com/T/#u>

nick, I finally found it again!

> didn't apply for the following reason: the a/ and b/ prefixes in the 
> file paths are missing.  Did you use git-format-patch(1) to produce the 
> patch?  Can you reproduce this?
> 
> I CCd the git mailing list in case they know what's going on.
> 
> Thanks,
> 
> Alex
> 
>> ---
>>   man2/getpriority.2 | 17 ++++-------------
>>   1 file changed, 4 insertions(+), 13 deletions(-)
>>
>> diff --git man2/getpriority.2 man2/getpriority.2
> 
> Should have been:
> diff --git a/man2/getpriority.2 b/man2/getpriority.2
> 
>> index 3e1be3e6c..24c1b7f11 100644
>> --- man2/getpriority.2
>> +++ man2/getpriority.2
> 
> Should have been:
> 
> --- a/man2/getpriority.2
> +++ b/man2/getpriority.2
> 
> 
>> @@ -206,20 +206,11 @@ All BSD-like systems (SunOS 4.1.3, Ultrix 4.2,
>>   manner as Linux 2.6.12 and later.
>>   .\"
>>   .SS C library/kernel differences
>> -Within the kernel, nice values are actually represented
>> -using the range 40..1
>> -(since negative numbers are error codes) and these are the values
>> -employed by the
>> -.BR setpriority ()
>> -and
>> -.BR getpriority ()
>> -system calls.
>> -The glibc wrapper functions for these system calls handle the
>> -translations between the user-land and kernel representations
>> -of the nice value according to the formula
>> +The getpriority system call returns nice values translated to the 
>> range 40..1,
>> +since a negative return value would be interpreted as an error.
>> +The glibc wrapper function for getpriority translates the value back 
>> according to the formula
>>   .IR "unice\ =\ 20\ \-\ knice" .
>> -(Thus, the kernel's 40..1 range corresponds to the
>> -range \-20..19 as seen by user space.)
>> +(Thus, the 40..1 range returned by the kernel corresponds to the 
>> range \-20..19 as seen by user space.)
>>   .SH BUGS
>>   According to POSIX, the nice value is a per-process setting.
>>   However, under the current Linux/NPTL implementation of POSIX threads,
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
