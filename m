Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C93C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 16:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjARQbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 11:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjARQbS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 11:31:18 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8073F47432
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:29:19 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id vm8so84529741ejc.2
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 08:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+31/qNT1KZJ6HGh3Df17N7ZHbJBLbZ3OBXwsLgAiJ/c=;
        b=H3abiiJZsTlbTXsGzVrS09bsmW2Odt+fvUrqsU/rjk/g7N8qpnqIMZL2Yz7tJFPs5C
         zyoIr4If+bJQfJz3g3aw5eAs7hbe8CBkElrqDrlViNONz4ltOYRUgOrZQcEB+E97Iaz3
         MfE5tXBQ7i5qPutXUNWbkHLzQBrvP7D5LkMsZw1kTYPAP0bIfyaDUl/lZgZv/lzjl9ob
         IsflMVRih+6Acl8f78uQlJ9EaWUFbjEypk+W6/WA/54Ds0QwttSowWl+7aYNq8x6Rtu7
         fNpxmy33F2Csqt9OM5KDTfn1CuCb0xF+rGGs2eBg9pb/9aLVvR0jD6qijJix1mxJvHQN
         o7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+31/qNT1KZJ6HGh3Df17N7ZHbJBLbZ3OBXwsLgAiJ/c=;
        b=qy1DU+E7Y+G0q8RaaCjwYo7ZXIRyGhCyaoeIvW2tDgWBeMpepp2XAliHI3j07oMhPK
         QRqFeJkBfMMSe19caseb7nBzjOhhaVUQSfrNfn7Pmtd1S3ac0TQ3Qr82GlYe59JnYc5L
         xq2I/SWnm0jq+eBaQvjMtcy+z7p+ghv8gUOM1HsYVAK6oQoss37Cu0OqWjBFvNPXKPQT
         /GU+qI+yQLIHnPW0s2CZDNQa+eoEd9mCLLetFT8887HJM8NQ6FILvaeEKYZmu6tfgq0q
         +w3sX+xCcI6aHzvTRG57W9195qSnMNhds8pOBEy3yO8fq65cgCpjLJ+IY2MhAWj7Yxnz
         97SQ==
X-Gm-Message-State: AFqh2koWK6yRnaS5VdqdNJfjgq/a/tLZw0CN5xC0Z2LcyN4Zv81dgJH0
        UIu6L+J0Pgnd6EVGZPMhhpzW01kMq0o=
X-Google-Smtp-Source: AMrXdXsygFKjo7HiT4047hglBaf+F09QMzUabFff5CHerJipRTdFk0oTZGh1JvnEAMD5MO8bQanSNg==
X-Received: by 2002:a17:907:d685:b0:86e:a761:c5ba with SMTP id wf5-20020a170907d68500b0086ea761c5bamr8183953ejc.37.1674059357813;
        Wed, 18 Jan 2023 08:29:17 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id t27-20020a170906179b00b008762e2b7004sm1464343eje.208.2023.01.18.08.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 08:29:17 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk>
Date:   Wed, 18 Jan 2023 16:29:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
Content-Language: en-US
To:     Adam Szkoda <adaszko@gmail.com>
Cc:     Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Fabian Stelzer <fs@gigacodes.de>
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
 <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
 <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
In-Reply-To: <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Adam

I've cc'd Fabian who knows more about the ssh signing code that I do.

On 18/01/2023 15:28, Adam Szkoda wrote:
> Hi Phillip,
> 
> Good point!  My first thought is to try doing a stat() syscall on the
> path from 'user.signingKey' to see if it exists and if not, treat it
> as a public key (and pass the -U option).  If that sounds reasonable,
> I can update the patch.

My reading of the documentation is that user.signingKey may point to a 
public or private key so I'm not sure how stat()ing would help. Looking 
at the code in sign_buffer_ssh() we have a function is_literal_ssh_key() 
that checks if the config value is a public key. When the user passes 
the path to a key we could read the file check use is_literal_ssh_key() 
to check if it is a public key (or possibly just check if the file 
begins with "ssh-"). Fabian - does that sound reasonable?

Best Wishes

Phillip

> Best
> — Adam
> 
> 
> On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> On 18/01/2023 11:10, Phillip Wood wrote:
>>>> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All
>>>> that
>>>> needs to be done is to pass an additional backward-compatible option
>>>> -U to
>>>> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets
>>>> the file
>>>> as public key and expects to find the private key in the agent.
>>>
>>> The documentation for user.signingKey says
>>>
>>>    If gpg.format is set to ssh this can contain the path to either your
>>> private ssh key or the public key when ssh-agent is used.
>>>
>>> If I've understood correctly passing -U will prevent users from setting
>>> this to a private key.
>>
>> If there is an easy way to tell if the user has given us a public key
>> then we could pass "-U" in that case.
>>
>> Best Wishes
>>
>> Phillip
