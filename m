Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D930EC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBEC60C3F
	for <git@archiver.kernel.org>; Thu, 20 May 2021 18:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhETSBl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 14:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhETSBl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 14:01:41 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FBBC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:00:19 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so5764299wmg.3
        for <git@vger.kernel.org>; Thu, 20 May 2021 11:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m9Bf67NcgW+bvpJhkPP4tzQqtqKA+ijIGoIRF3VAIzQ=;
        b=IcPKzt4qx82iHxpWbyzt2g5bdU/uaIx9e/bDUr0bXdUetFEKWuWYisE8tx1rmUxYeV
         2KroCnr9L+ln6pdF4yBfLjuc7CRi71AeQ3o0CilbMiKFWjM8v6E7iUHDHwMloXfw0LwA
         01FLmlUlJ8NSjW8Hva9bm75jIaz8B577WtilraIIjUvKTVW5dRFYVKUtpAb7l2zT0Fas
         4YhR+B6iuD5QEMAoqlZIohdD0Pu3RksocgAyKtBFw62jZeD4CyYLuGTUfcp8bw9Zfi+9
         PFSAYlm5Ol9orgJxExK+I6Dwzc2jv55x+lmepGKD9Gzuo+X/LAj9L18ngsNPH5UEKvIz
         NAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m9Bf67NcgW+bvpJhkPP4tzQqtqKA+ijIGoIRF3VAIzQ=;
        b=LDqUW/YNevHq3bUWk3ArbNRKsYtIAelEQ/QaiP1GPsS6bxdMqJKcYJgLDln1cWGt5c
         c3ztnWBmfcaeHwABC8CGs6gAC2AMnvbmK2HFJ2xoUmZS3iHv+r7lGxwOymyBhU8clGQQ
         uAlIN1ddpbbtguhMvi796J0tL0Zd+zggtkYnFVn/AvibQq60xl/41BVqIEJlaRoDgPcz
         w3wmq/CkLHy+Z2QwfcpFDwAF4qHzZPW+Rymh4bVQv0najPPWRe+yDAePKuz0AXYI88nQ
         BE/O9i/KfhFwgWSvIlc/4NMiXFwCHaRfglJZJKqFmPUy/xi+FJdOctneOrdqhUvAIIni
         3fEg==
X-Gm-Message-State: AOAM531xXhRcvbBscygnFy96mqPPOjaQR9b5fYOyhtJz3VrY5aN1qXUv
        XPEBcIGUxjcvsyemMjd7vxg=
X-Google-Smtp-Source: ABdhPJz0VqwHkfoSxmF5Yu6Drihy7U8oB9KEE2RPDd6BF8L7td4bUWBVzuTEnc2mZ7CbFmRFlMromA==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr5434116wme.12.1621533617836;
        Thu, 20 May 2021 11:00:17 -0700 (PDT)
Received: from [192.168.1.201] (88.22.198.146.dyn.plus.net. [146.198.22.88])
        by smtp.googlemail.com with ESMTPSA id r11sm4025856wrp.46.2021.05.20.11.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 May 2021 11:00:17 -0700 (PDT)
Subject: Re: [PATCH v4] help: colorize man pages
To:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Leah Neukirchen <leah@vuxu.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>
References: <20210520040725.133848-1-felipe.contreras@gmail.com>
 <842221d6-51c4-e08a-4299-c4efb8bf1dcb@gmail.com>
 <60a66b11d6ffd_2448320885@natae.notmuch>
 <b58cbdcc-abd3-ec82-7d8d-771f47c484ff@gmail.com>
 <60a6877fa8389_2747c20842@natae.notmuch>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6dc0fcee-3415-e6f9-df30-c97de4385f56@gmail.com>
Date:   Thu, 20 May 2021 19:00:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <60a6877fa8389_2747c20842@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/05/2021 16:59, Felipe Contreras wrote:
> Phillip Wood wrote:
>> On 20/05/2021 14:58, Felipe Contreras wrote:
>>> Phillip Wood wrote:
>>>> On 20/05/2021 05:07, Felipe Contreras wrote:
>>>>> [...]
>>>>> If the user has already set the LESS variable in his/her environment,
>>>>> that is respected, and nothing changes.
>>>>
>>>> However if they have specified the colors they would like by using the
>>>> LESS_TERMCAP_xx environment variables that the previous versions of this
>>>> patch used their choice is overridden by this new patch.
>>>
>>> That is true. We could add a check for that:
>>>
>>>     if (getenv("LESS_TERMCAP_md"))
>>>             return;
>>>
>>> However, it may not be necessary since many of the tips online set these
>>> variables inside a function.
>>
>> The only person who has tested this patch has reported a problem with
>> it, it seems unlikely that no other users will have similar issues.
> 
> The check above will fix your problem, will it not?

Yes it will if it is implemented which was not clear as your message 
suggested it may not be necessary. I think it would be safer to check 
LESS_TERMCAP_{md,us,so} and not set LESS if any of them are set as it is 
possible a user may only override some of them.

Best Wishes

Phillip

