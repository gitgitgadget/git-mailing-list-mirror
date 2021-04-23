Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DDCC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4931461459
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 12:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbhDWMpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMpr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 08:45:47 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E759DC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 05:45:09 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d21so37226944edv.9
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zxDW4iHTVUc1ca5r0UTF0ykHn4sO5eF7rKKmXUEvmlY=;
        b=ex8IMxnftUBOLJFOLtEWeUqmg0HkQLEkrS8vTewg6mPsNs1G/Pa6iqPR9luYLgQGRA
         jzQi07M3wtchvgJN9ZMb7c8JfqRxY4s6rMx+fythhod2i3ag62GbyjmQOVrJieNun/2w
         8xgqF7S0bg0I9lIYlUgVWrvIZsyvuZxDWC5E6EwPlcYdAU6lwPFcWxfeiFsKaoGGA9fD
         kOE6vhA9CNqhiKIOKkdnCK+G3NweDj4cgue4BXk4kfhY1Ci6gum6znoWPSzpyCekQa/o
         ge25mwFMefeYDv5ro4NANFa+RGVpc3hy4hw97n/1hATisTOi7k1yebzzqklKDZPOfKN+
         drRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zxDW4iHTVUc1ca5r0UTF0ykHn4sO5eF7rKKmXUEvmlY=;
        b=fM/ATFK8uxtTLN8/UwQKVBD+LuznvvQQchx0dFZO6ttkQzSxpklS5WG+sa9uEF+Z93
         DidGUEFzA0Ml1lPIB9eELLlDDUrhzHViTgJ8ZlybMpmXiB7e3Ops2Zl0J8a0th9rxe7g
         yYYgyJ9FzIeROi/az80eCjO+JkXdPwNuhTG2Kyfs9GEP7lcDybkia0ESdsQ0W30tJHjv
         ImDqM1JjyNZQIGWB+NhmbsVGUsqToRdRz07cHwSiP3MaIqGJ3O3+0AnzXuOP6ABdcZsY
         NPzGFOsrZlfvWKZGtWz2pbE8LRMF79sHt2BWpgPvSDn2MxFr1blTaJ9c1I8dQowvo/Ob
         SP8w==
X-Gm-Message-State: AOAM530XtAmkD7p84Snl2+IvBvwRtV7pqZjHtm7q5zbgiWc5Mt15MkzD
        AMi7Gji+VVJDJ0u5KZnFbKqsBEjgghE=
X-Google-Smtp-Source: ABdhPJxdEzhY0p3LlwT3xtZaWhJO8DiGk+TCJgtIWlYM3SQNFK8xSOuCBH2SqNb3Az9qEftV/pe36g==
X-Received: by 2002:aa7:c3ca:: with SMTP id l10mr4273617edr.55.1619181908584;
        Fri, 23 Apr 2021 05:45:08 -0700 (PDT)
Received: from [192.168.1.201] (243.20.198.146.dyn.plus.net. [146.198.20.243])
        by smtp.googlemail.com with ESMTPSA id g12sm4720086edr.83.2021.04.23.05.45.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Apr 2021 05:45:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 3/4] t7006-pager.sh: more lenient trace checking
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
References: <20210423001539.4059524-1-emilyshaffer@google.com>
 <20210423001539.4059524-4-emilyshaffer@google.com>
 <f4c3688e-8316-7f66-3bcb-d8aaeef3a7d3@gmail.com>
Message-ID: <27d2ffe7-6f5b-726e-eed0-438a4efb8f9f@gmail.com>
Date:   Fri, 23 Apr 2021 13:45:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <f4c3688e-8316-7f66-3bcb-d8aaeef3a7d3@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily

On 23/04/2021 10:54, Phillip Wood wrote:
> Hi Emily
> [...]
>> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
>> index 0e7cf75435..ac2d91d56b 100755
>> --- a/t/t7006-pager.sh
>> +++ b/t/t7006-pager.sh
>> @@ -676,7 +676,9 @@ test_expect_success TTY 'git returns SIGPIPE on 
>> early pager exit' '
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep pager-used trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
> 
> If you want to save a process you could use sed to do the job of the 
> grep command. I think this should do it
> 
> sed -n -e "/child_exit/ {" -e "s/child_start\[\([0-9]\+\)\].*/\1/p" -e "}"

I must have been half asleep when I wrote that, there is no need for the 
braces and the initial match is wrong it should be

sed -n "/pager-used/s/child_start\[\([0-9]\+\)\].*/\1/p"


Best Wishes

Phillip

>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
> 
> Why is $PAGER_CHILD_ID unquoted?
> 
> Best Wishes
> 
> Phillip
> 
>>       test_line_count = 1 child-exits &&
>>       grep " code:0 " child-exits &&
>>       test_path_is_file pager-used
>> @@ -697,7 +699,9 @@ test_expect_success TTY 'git returns SIGPIPE on 
>> early pager non-zero exit' '
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep pager-used trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>>       test_line_count = 1 child-exits &&
>>       grep " code:1 " child-exits &&
>>       test_path_is_file pager-used
>> @@ -718,7 +722,9 @@ test_expect_success TTY 'git discards pager 
>> non-zero exit without SIGPIPE' '
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep pager-used trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>>       test_line_count = 1 child-exits &&
>>       grep " code:1 " child-exits &&
>>       test_path_is_file pager-used
>> @@ -739,7 +745,9 @@ test_expect_success TTY 'git discards nonexisting 
>> pager without SIGPIPE' '
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>>       test_line_count = 1 child-exits &&
>>       grep " code:127 " child-exits &&
>>       test_path_is_file pager-used
>> @@ -760,7 +768,9 @@ test_expect_success TTY 'git attempts to page to 
>> nonexisting pager command, gets
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep does-not-exist trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>>       test_line_count = 1 child-exits &&
>>       grep " code:-1 " child-exits
>>   '
>> @@ -780,7 +790,9 @@ test_expect_success TTY 'git returns SIGPIPE on 
>> propagated signals from pager' '
>>           test_terminal git log
>>       fi &&
>> -    grep child_exit trace.normal >child-exits &&
>> +    PAGER_CHILD_ID=$(grep pager-used trace.normal | \
>> +             sed -n "s/child_start\[\([0-9]\+\)\].*/\1/p") &&
>> +    grep -F "child_exit["$PAGER_CHILD_ID"]" trace.normal >child-exits &&
>>       test_line_count = 1 child-exits &&
>>       grep " code:143 " child-exits &&
>>       test_path_is_file pager-used
>>
> 

