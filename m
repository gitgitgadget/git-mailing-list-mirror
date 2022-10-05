Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0D4C433FE
	for <git@archiver.kernel.org>; Wed,  5 Oct 2022 11:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJELJx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Oct 2022 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJELJv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2022 07:09:51 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFCAD139
        for <git@vger.kernel.org>; Wed,  5 Oct 2022 04:09:45 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f11so22782953wrm.6
        for <git@vger.kernel.org>; Wed, 05 Oct 2022 04:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=LdORsUfvvM/rUMDBN8Fw7a1JPS2qwxoAPYgJT5NLI9Y=;
        b=MbJDxqh1I4t4DL7ZbJghXsBWCQ9rIAhAudT+EK2yvuNyVoYAwWluEzkrPmj1iZSTD0
         zJqLn5ups77ldJYa95UBLr80tIPHhd8UVmWVTD2FU1HOtfetI70lBaGxuBaNQuQ2VkqM
         H+E+YhIiREl2OoIZZ8ZYedJ7fO+U1k8R9o684jbhZEwcYiTPNBVUosUh8u9uJBkNA9YJ
         N/G0/Ek3bxVOgLLOXIL0WZIXXRYhz4qj0x9QihEQchl9IEeIkjSG+C7gwp/x7piaHfTs
         ZTJAFH0lnqBTKnixR/vJPM9MGK8VDoow5vbCMaJw6xhLyP0bvHUQ73K11D35mLt2B0CA
         kd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=LdORsUfvvM/rUMDBN8Fw7a1JPS2qwxoAPYgJT5NLI9Y=;
        b=mK19qperDYI8WFrJQdY6pfxUzXdNBVZoMwxs3jXVXt3M8fUKjpHHN6eUOMjMIMWJ8n
         ZmfUTWJy5XC6TT4Csu7UhhlYhqpv6owfRWunUmPHe226PtkHCOEUPXXx2gQYQVqQ7iAA
         CmcDenRjvVrPyev4ncXRQ8wJW1TwKKL4kT09Y7CkOlc7TmQ7AMRTJPb1rz3bxd7x3PMj
         zD5QsmhUD1dhhgUsfgbmUYdCehxsT0DtvtqyYUNeDJv8pWYXfb+UbhJAHzzo4+BoaRO1
         O4SgUiVTfyW9YI38HLW3tROMt5OZjgTHI0pUv0P/CetAfysvkASEjm3LmySe7SRlD4yW
         C1uQ==
X-Gm-Message-State: ACrzQf1zWX9awzyTHjANtvtdOFKf7E+QTvSyQXo9mZZqiP4iw0QhwCHi
        Wv5NS7Z2bZec8XUK8cMEhb4=
X-Google-Smtp-Source: AMsMyM7/NunME+cDXD0vXbMM4vDb2P857J73SOkrb1jkV7F4rFbFnPmJCA2j2TTsDonYXeZlCFgNiA==
X-Received: by 2002:a5d:6483:0:b0:22e:4804:8be4 with SMTP id o3-20020a5d6483000000b0022e48048be4mr6751835wri.528.1664968183874;
        Wed, 05 Oct 2022 04:09:43 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id fn8-20020a05600c688800b003a8434530bbsm1610984wmb.13.2022.10.05.04.09.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 04:09:43 -0700 (PDT)
Message-ID: <a2e2bf70-95cc-41ee-c129-ef2f2e38fe79@gmail.com>
Date:   Wed, 5 Oct 2022 12:09:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 06/10] evolve: add support for writing metacommits
Content-Language: en-US
To:     Chris P <christophe.poucet@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christophe Poucet <poucet@google.com>
References: <pull.1356.git.1663959324.gitgitgadget@gmail.com>
 <56c6770997bbdb1b3b87c2c410dd7f158b03f2d6.1663959325.git.gitgitgadget@gmail.com>
 <a7ddab8a-ddd6-a8bf-496d-4ce7757d89cf@dunelm.org.uk>
 <CAN84kKke+vSQ18wNM7h6BvTF9XBtSH96L0_qNOFn+V3fj2yNhg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAN84kKke+vSQ18wNM7h6BvTF9XBtSH96L0_qNOFn+V3fj2yNhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris

On 05/10/2022 10:40, Chris P wrote:
>>> +/**
>>> + * Produces the final form of a metacommit based on the current change refs.
>>> + */
>>> +static void resolve_metacommit(
>>> +     struct repository* repo,
>>> +     struct change_table* active_changes,
>>> +     const struct metacommit_data *to_resolve,
>>
>> [testing my understanding] This is the metacommit we want to update
> 
> Maybe you can help me find a bug.  If you run `git-change update`
> twice without changing commits, it prints that it created a second
> one, but then if you `git-change list` it doesn't show that last one
> because it doesn't create an extra one if there's already a change
> pointing at HEAD.

That's something I thought that we should add a test for but didn't get 
round to. I'll have a look and get back to you

> Also, thanks for all the comments, it's helping my understanding too.
> In general do you want all these comments added to the code?

Not unless you think the code needs them (from what I remember it is 
already fairly well commented), they're just me thinking out loud as I 
read the code.

I'm going to be offline for the rest of the day, I'll catch up with the 
rest of your comments tomorrow or Friday.

Phillip

