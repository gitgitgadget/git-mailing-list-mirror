Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4491FC07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CE6F61154
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhGLR50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232912AbhGLR5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:57:25 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A097C0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:54:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l7so25874767wrv.7
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 10:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0WQvthQKA6MJXu5gf5Tsd3IDqSdoweahUmDvbo3WIZQ=;
        b=Ype8cVdTHEXwqmXFMNdNEien1rQKh1LIY+XdUElya1WuUKnvFnMLn0rEBNMCJkAMTx
         WRjX/UefE6oUI75PjCJXQfswFiuAeyNGwsGCFSjPe45bVclmkPWiM8C/yLdCwwk9gcyY
         JEhPSExm4t2VK3LW7TnUFZCJ8Z1SB/qJfZZZOgsPz/IcxQ9wfIUfLUiF4cGPPw4oDXpU
         5bgSWUeS+dCrR90EIV52Jpt39bPNTveXpuAPg9tOve4P47Zmqh69TpTn8tqPQjwiJqRJ
         CGk5yF8wFY9icnPuEEX3N5bgqgvqDnqHBvlwJIhfnjtMxtXKtc1P5gcvOCtlYWjrjLV9
         2kRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0WQvthQKA6MJXu5gf5Tsd3IDqSdoweahUmDvbo3WIZQ=;
        b=FRQfuVkUZ2jAhzThtIbhVJOcHUtwKFFKucngnK27qg2KIE00pipThqDKx1T+jPtqiv
         Gep72vYbfchTAV3uvr6D10XifWYI+huAF9Zu2kilqLrMiPaJzm0kkSzazUsssW6Bip5f
         yVq2G6U5gzWPXbMk9yu8EnvZwJ+pndRNgLiGzXxzeaVufn6uRJub9fYv7KDektwta7y1
         WxvHX1wIpJLxjQgeEZbyBlTX83UsPHuz9s8q1fqTEbMKKS/NVZzY8FOayOSms6iivO4E
         xV0XZLPjVS26dXpBf2hY9c1vduO20f0ApPy5TARNYZkrwiMBQCa47VwQztTnomtuUhvr
         cIjQ==
X-Gm-Message-State: AOAM531tIERIUeLYlYTrREOHILnto9NVXokUuNvjz9FtvKchYc0PUMxg
        4xX7lAIQTXbm0cJW6vA4LOk=
X-Google-Smtp-Source: ABdhPJxxznfdWOIFfN9TbO23uTUTukbP1Y+GVbyI73tjivY9Wd4GLL+gOfHUQ+FGLPXjPIL+wX3mhA==
X-Received: by 2002:adf:b307:: with SMTP id j7mr196429wrd.243.1626112475733;
        Mon, 12 Jul 2021 10:54:35 -0700 (PDT)
Received: from [192.168.1.201] (136.2.7.51.dyn.plus.net. [51.7.2.136])
        by smtp.googlemail.com with ESMTPSA id y23sm13523359wmi.28.2021.07.12.10.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 10:54:35 -0700 (PDT)
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is
 impossible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, felipe.contreras@gmail.com, newren@gmail.com
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <e63d65f4-048e-464b-439c-4f8f48e72216@gmail.com>
Date:   Mon, 12 Jul 2021 18:54:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqpmvn5ukj.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/07/2021 18:08, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Thanks for revising this patch, I like this approach much better. I do
>> however have some concerns about the interaction of pull.ff with the
>> rebase config and command line options. I'd naively expect the
>> following behavior (where rebase can fast-forward if possible)
>>
>>    pull.ff  pull.rebase  commandline  action
>>     only     not false                rebase
>>     only     not false   --no-rebase  fast-forward only
>>      *       not false    --ff-only   fast-forward only
>>     only     not false    --ff        merge --ff
>>     only     not false    --no-ff     merge --no-ff
>>     only       false                  fast-forward only
>>     only       false      --rebase    rebase
>>     only       false      --ff        merge --ff
>>     only       false      --no-ff     merge --no-ff
> 
> Do you mean by "not false" something other than "true"?

I mean pull.rebase is set to true/interactive/merges/preserve

>  Are you
> trying to capture what should happen when these configuration
> options are unspecified as well (and your "not false" is "either set
> to true or unspecified")?  I ask because the first row does not make
> any sense to me.  It seems to say
> 
>      "If pull.ff is set to 'only', pull.rebase is not set to 'false',
>      and the command line does not say anything, we will rebase".

Yes because if pull.rebase is not false then the user wants to rebase.

> I do agree with you that the command line options
> 
>      --ff-only
>      --ff (aka "allow ff")
>      --no-ff
> 
> should override pull.ff and
> 
>      --rebase
>      --no-rebase (aka "merge")
> 
> should override pull.rebase configuration settings and also override
> pull.ff set to 'only' (i.e. the user explicitly wants intregration
> of the two histories and at that point "I usually just follow along"
> which is "pull.ff=only" no longer applies).

I'd assumed --no-rebase just meant "merge respecting pull.ff instead of 
rebasing" rather than "merge ignoring pull.ff instead of rebasing"

Best Wishes

Phillip
