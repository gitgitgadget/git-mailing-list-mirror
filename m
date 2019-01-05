Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08CD211B4
	for <e@80x24.org>; Sat,  5 Jan 2019 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbfAEWcw (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Jan 2019 17:32:52 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:34184 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfAEWcw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Jan 2019 17:32:52 -0500
Received: by mail-qt1-f172.google.com with SMTP id r14so44218074qtp.1
        for <git@vger.kernel.org>; Sat, 05 Jan 2019 14:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ID8l4Oy1/Ifs71d2Q5ZEpSrUkkcwEd3Fow57ig60ZoQ=;
        b=I8kSIQRHtaRdG09CSa3er72OEzgEWd5cVFYkODDhajb26NBc5CNN/3BEfnYq/OAK4I
         eDYk+1lTTHIcuBFuCj9gAO2eeX0FKKiRuoccSPpdCzYRb/tVqf6rCLZkwRen8QxECv54
         2TmFCQBJEvTYcZp2Awgq9eh6aG3HxY6n9okJSgz8TrM0Z1PdYmS1hHTm5NtPkSgwKPWT
         O8gsiHZJKKXEA6KmIGydcDfV+aEp6sLyiIDxkoqgjl7DHytc95q3cQPCRDf6x6wKzhOC
         mZZkdKXKhyNQNVX2RA5hzFZWYiy+23uEPp1uKFWY1qlpaZVOCLZ0LgkFALQi9SgtFBoK
         bJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ID8l4Oy1/Ifs71d2Q5ZEpSrUkkcwEd3Fow57ig60ZoQ=;
        b=A9vNHhrEerTTQn6TXWkD6yMOY1YwxHZPjAieVLIAotemOH4hMJAxi9EFqd7XCXYDb9
         JuK8edFkZ+tbNLRl2UUX3GW0NKiN0oWj4M888nrQTmB4X5mrf3Uwukv5FH+/RPpkYY5U
         837zOEn9Uo8jMBIlmyAg6yJMWYiPpYbptgKVbWjnJ7JODGOjNpLtYPWZc4oVTU5E3hVA
         r02G1brt0iwPo7IY5yGKZoO3KXnW3apXV40r5NV/DH92LThA+FKLtWEw2Ja7ZOR8WWp+
         oZvLTv+vqY/2TYLP0reXvqm2wMdAUYbF4LY8aJ50U567IQQFy5yZJVzuVNWqbcKHw15o
         fOfg==
X-Gm-Message-State: AA+aEWZvQzrFgGfvvyAAff6kqNApm27rgMUW/pVgFrcXIlbr4D/UvuA0
        fYUlPprkqcFm2IZ+1LbOdlLfWiEn
X-Google-Smtp-Source: ALg8bN6AMHrCjRwZLZ3km0tSOujE6mS1BMkju9cFIeh1Of+gLRZ+UNWa58iyoRGt0DxX1czWSzcWmA==
X-Received: by 2002:aed:3ff3:: with SMTP id w48mr53876049qth.214.1546727570607;
        Sat, 05 Jan 2019 14:32:50 -0800 (PST)
Received: from [192.168.4.2] (pool-96-241-220-104.washdc.fios.verizon.net. [96.241.220.104])
        by smtp.gmail.com with ESMTPSA id t43sm37847123qtc.53.2019.01.05.14.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 14:32:49 -0800 (PST)
Subject: Re: How DELTA objects values work and are calculated
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CAFd4kYBX+HrLxbga=VJgC5WjyeDZEznm2UCL+HF8A1YKVo3Trw@mail.gmail.com>
 <CACsJy8Da7+sNfxvTRz1DRn27TjvBXNAipKB=eumA6q+sVsVjcA@mail.gmail.com>
From:   Farhan Khan <khanzf@gmail.com>
Message-ID: <581076b0-95c5-9af9-dec5-5a9bccfe2634@gmail.com>
Date:   Sat, 5 Jan 2019 17:32:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Da7+sNfxvTRz1DRn27TjvBXNAipKB=eumA6q+sVsVjcA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/4/19 11:46 PM, Duy Nguyen wrote:
> On Sat, Jan 5, 2019 at 9:49 AM Farhan Khan <khanzf@gmail.com> wrote:
>>
>> Hi all,
>>
>> I'm having trouble understanding how OBJ_REF_DELTA and OBJ_REF_DELTA
>> (deltas) work in git. Where does git calculate the sha1 hash values
>> when doing "git index-pack" in builtin/index-pack.c. I think my lack
>> of understanding of the code is compounded the fact that I do not
>> understand what the two object types are.
>>
>>  From tracing the code starting from index-pack, all non-delta object
>> type hashes are calculated in index-pack.c:1131 (parse_pack_objects).
>> However, when the function ends, the delta objects hash values are set
>> to all 0's.
> 
> Delta objects depend on other objects (and even delta ones). To
> calculate its sha1 values we may need to recursively calculate sha1
> values of its base objects. This is why we do it in a separate phase
> because the calculation is more complicated than non-delta objects.
> 
>> My questions are:
>> A) How do Delta objects work?
> 
> A delta object consists of a reference to the base object (either an
> sha1 value, or the offset to where the object is) and a "delta" to be
> applied on (it's basically a binary diff).
> 
>> B) Where and how are the sha1 values calculated?
> 
> Start at threaded_second_pass() in index-pack.c, we go through all
> delta objects here and try to calculate their sha1 values. Eventually
> you'll hit resolve_delta(), where the delta is actually applied to the
> base object in the patch_delta() call, and the sha1 value calculated
> in the following hash_object_file() call.
> 
>>
>> I have read Documentation/technical/pack-format.txt, but am still not clear.
>>
>> Thank you!
>> --
>> Farhan Khan
>> PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE
> 
> 
> 


Hi Duy,

Thanks for explaining the Delta objects.

What does a OBJ_REF_DELTA object itself consist of? Do you have to 
uncompress it to parse its values? How do you get its size?

I read through resolve deltas which leads to threaded_second_pass, where 
you suggested to start, but I do not understand what is happening at a 
high level and get confused while reading the code.

 From threaded_second_pass, execution goes into a for-loop that runs 
resolve_base(), which runs runs find_unresolved_deltas(). Is this 
finding the unresolved deltas of the current object (The current 
OBJ_REF_DELTA we are going through)? This then runs 
find_unresolved_deltas() and shortly afterwards 
find_unresolved_deltas_1(). It seems that find_unresolved_deltas_1() is 
applying deltas, but I am not certain.

I do not understand what is happening in any of these functions. There 
are some comments on builtin/index-pack.c:883-904

Overall, I do not understand this entire process, what values to capture 
along the way, and how they are consumed. Please provide some guidance 
on how this process works.

Thank you!
Farhan
