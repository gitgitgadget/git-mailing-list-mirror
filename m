Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353E5C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiCDM3I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 07:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiCDM3H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 07:29:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D96951322
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 04:28:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id z4so7376744pgh.12
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 04:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=utUqpLVtBrb3MrIfBYtwlaQ27UcW27TpdVW8CYY3TeM=;
        b=fn3VapQsNnGi25JOEMiqf2VankDCmhsGFPPFTJU6Pi6A8xZ1os6BpfU6bpoCxVZZhX
         BXfO513i6T4Z33GjwEylCE4zzy+Jo+HLtdDHTmIEAKLQRCZkmXvWJdJ0n/o6auaMxS2B
         cPIGt3yr/UxZCmv+qAD21G3/V+IcWdGgWMC0gDSaVy6VogH3qqyfzNP7PiLUdVBnhLBr
         zvXJ8Rp+/onOVxjKjsQlHIw+rQSfHB0UhBzx5Z17yU2DM7Q+YXkbdq0/0BAnh5nAadb3
         1ffjF3xCL+sG714qaHxOmHLnXAovwVvvtGrwr4Gc1NEm4D52TF9ARH2kRpYLII846pBP
         2xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=utUqpLVtBrb3MrIfBYtwlaQ27UcW27TpdVW8CYY3TeM=;
        b=keUKV9ygph2QWhjDci5d+zoF0oHA9QUCLwetYEGEkZy3pqFUxIauAPrjcQIOo6K/wH
         HLFgDoR0dA1gjCoQ3YCpA18Redu3RBAJZuuxownzJ21J01Pm8zK17BaJT5Sydp1/gKXt
         VtnXCnDc8r+PdUbDgHtwe2k6ssD1r7j5te14hX7P992xpeTBATgiDi4nkpwKxl8mPoC8
         E9qyDnUYhBvcoe5VKq67Gi/rWxNuvHTbhowFJSjiydJzktYNoZ7rVVkuvJgdlURlP1rH
         ZyldIoKpkm6AGIJT0wQH40qk2KZZckDKPDmjbKPq0Hn1M4jxTsUUkslWkb9RObTrfwrx
         uHgg==
X-Gm-Message-State: AOAM5321Ck2hvtVsKiZ6CATPVUP3sNvcMAs269NXOCiqsIZWWRqwWN2O
        594jsDu5wSWrfNfKGKjL5QHTZY3p4cVHJg==
X-Google-Smtp-Source: ABdhPJyhiepS2Jqsm1OOSLnwiXmrEXAAl2U/PZ2x+hy+hCiXiOlkv3lSGqHFp/H7YPtToxlHWqOv/g==
X-Received: by 2002:a63:90c4:0:b0:37c:7f95:2fb9 with SMTP id a187-20020a6390c4000000b0037c7f952fb9mr4322777pge.267.1646396899590;
        Fri, 04 Mar 2022 04:28:19 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id d7-20020a056a00244700b004e1300a2f7csm5870268pfj.212.2022.03.04.04.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 04:28:19 -0800 (PST)
Message-ID: <90596af6-0158-beb9-7fa7-9237e7cff4fb@gmail.com>
Date:   Fri, 4 Mar 2022 17:58:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] userdiff: add builtin driver for kotlin language
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-1-jaydeepjd.8914@gmail.com>
 <20220302142608.2754709-2-jaydeepjd.8914@gmail.com>
 <fe93dfb2-7c0d-11cb-09a0-9ccc7fcc2507@kdbg.org>
 <76d46b15-f6c0-b8da-87e8-a992047b9a6a@gmail.com>
 <c1298c9d-0f4a-40b8-b337-896f4d4777f3@kdbg.org>
From:   Jaydeep Das <jaydeepjd.8914@gmail.com>
In-Reply-To: <c1298c9d-0f4a-40b8-b337-896f4d4777f3@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/4/22 01:34, Johannes Sixt wrote:
> Am 03.03.22 um 12:41 schrieb Jaydeep Das:
>> How about modifying the number match regex to:
>>
>> `[0-9._]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]` ?
>>
>> The `[^a-zA-Z]` in the end would make sure to not match
>> the `.F` in `X.Find`.
  
> No, you cannot do that, because then in X.u+1 you have three tokens X
> .u+ 1, which you do not want, either.

If X is an integer here, then

In C/C++ 2.f is equivalent to 2.000000
However in Kotlin 2.f is invalid syntax. 2.0f is valid.

So is implementing a proper regex for invalid syntax really
necessary?


> But then you can use the regex you had in the first round:
> 
>     [a-zA-Z_][a-zA-Z0-9_]*

Right. I will change that.
  
>> Numbers: `[0-9_.]+([Ee][-+]?[0-9]+)?[fFlLuU]*[^a-zA-Z]`
>> (It makes sure that in X.Find, .F is not matched )
>>
>> Additionally, An extra regex for method calls:
>>
>> `[.][a-zA-Z()0-9]+`
>>
>> What do you think?
> 
> Have a look at the regex in the cpp driver. I think we need something
> like this:
> 
>    /* integers floatingpoint numbers */
>    "|[0-9][0-9_.]*([Ee][*-]?[0-9]+)?[FfLl]*"
>    /* floatingpoint numbers that begin with a decimal point */
>    "|[.][0-9][0-9_]*([Ee][*-]?[0-9]+)?[FfLl]*"


> Drop the second option if numbers such as .5 are invalid syntax in Kotlin.
.5 is valid syntax in Kotlin.

--
Thanks,
Jaydeep.

  



