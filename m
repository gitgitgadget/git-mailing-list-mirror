Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C592C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 09:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjAWJdQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 04:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjAWJdP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 04:33:15 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB75B15C8F
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 01:33:13 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ud5so28842300ejc.4
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 01:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Hln4zBM0WWS4VsjgLshxI7WghzVLj2DowAzM1FP1I=;
        b=ExAAk0eAAn993ygnWtp56J52k281BWQPwjSafQg7J2IgFtVwMxou3Shod1Tr9nr7lM
         JMmKYwidZ4BOPUrN4pl//XnIDh0EJs/VG9TqWTgIU2jlazGs44cWqV5wzeTzmWxwx9ho
         VGOD0vl+sWvLYh+w66K+MSJ2kBUyot5HcG+Wf8khLQXkiE0wXJ8wqQuFHaGBVGZ41mYQ
         xRniNt6Z4cbb1qLlEDAjAv8oAjnR31jwo6jv2ceO+B3KfUjuw/qIr4mdeSYZdR4/KPtv
         7TGjtzRbe9erFvrp1Wo7bHor8HrHhZkAbDTZQGMIOfqi0Swu68VIKREuUqGZov4f0i6D
         ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0Hln4zBM0WWS4VsjgLshxI7WghzVLj2DowAzM1FP1I=;
        b=s7SwuNS1AZbMO7isgeHFeEozBNkEJ+mLlvWaaZzG6Xvo7dz5tyPmeq9TwZaRoR65g7
         k1A2P80q/YsTNI40jAUMac/6dbFirTgwgHNTt8BBatqD/zHn9LnmVzyIzAz7wpph54wp
         /jVuNDGQh/QFLlv6a+4flB7feCDQhSGfOpJBXGu9iCW65kGovGaUClMCFxPwqyFJvBF9
         ARRJq3aMd8H80JWVCKMV08eNnYIHDwjuR7zPAra3EiSByz16N1Kx38bIrXtn1SBtsfFm
         cWZ2BaQ0dfZbHGaQNM9RuYmNAiJVjWqbEVYgTBA+69TmBkBFRlr5GeiwO6pO9Py3D1hK
         8r7A==
X-Gm-Message-State: AFqh2koUNKt3HbQgw1yRXY8924pOUHsBLtyzvtTT3Dqk7i3eKo2sPRNV
        d3cq0UYyY4bfs+2N1WGYKRS+/1rMAAI=
X-Google-Smtp-Source: AMrXdXui9JwIM4o2e0BMhPIzd04Hlc/7tlDgDGGbcRSP5xD0XzvjSmdlUdH6I3Uv8wthQTWRAaPvrg==
X-Received: by 2002:a17:907:1759:b0:85e:c4e4:cfbf with SMTP id lf25-20020a170907175900b0085ec4e4cfbfmr25144304ejc.15.1674466392258;
        Mon, 23 Jan 2023 01:33:12 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id d22-20020a50fe96000000b0049c6c7670easm13515081edt.70.2023.01.23.01.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:33:11 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6e57bef8-7387-3341-5ed5-4bcfa7ded7a0@dunelm.org.uk>
Date:   Mon, 23 Jan 2023 09:33:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ssh signing: better error message when key not in agent
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     Adam Szkoda <adaszko@gmail.com>,
        Adam Szkoda via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1270.git.git.1674029874363.gitgitgadget@gmail.com>
 <abec912c-065d-2098-962e-41f9646dd046@dunelm.org.uk>
 <8025d5c7-ab55-c533-1997-05b4c7339d61@dunelm.org.uk>
 <CAEroKagqxC86X0SD8=tK0w+yXL7QecZ+z_7sja-K6ajs0=Z=BQ@mail.gmail.com>
 <55282dec-825f-8c4b-1fb0-6e26ec326db1@dunelm.org.uk>
 <20230120090331.37dxkko6bgxbjae7@fs>
Content-Language: en-US
In-Reply-To: <20230120090331.37dxkko6bgxbjae7@fs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/01/2023 09:03, Fabian Stelzer wrote:
> On 18.01.2023 16:29, Phillip Wood wrote:
>> Hi Adam
>>
>> I've cc'd Fabian who knows more about the ssh signing code that I do.
>>
>> On 18/01/2023 15:28, Adam Szkoda wrote:
>>> Hi Phillip,
>>>
>>> Good point!  My first thought is to try doing a stat() syscall on the
>>> path from 'user.signingKey' to see if it exists and if not, treat it
>>> as a public key (and pass the -U option).  If that sounds reasonable,
>>> I can update the patch.
>>
>> My reading of the documentation is that user.signingKey may point to a 
>> public or private key so I'm not sure how stat()ing would help. 
>> Looking at the code in sign_buffer_ssh() we have a function 
>> is_literal_ssh_key() that checks if the config value is a public key. 
>> When the user passes the path to a key we could read the file check 
>> use is_literal_ssh_key() to check if it is a public key (or possibly 
>> just check if the file begins with "ssh-"). Fabian - does that sound 
>> reasonable?
> 
> Hi,
> I have encountered the mentioned problem before as well and tried to fix 
> it but did not find a good / reasonable way to do so. Git just passes 
> the user.signingKey to ssh-keygen which states:
> `The key used for signing is specified using the -f option and may refer 
> to either a private key, or a public key with the private half available 
> via ssh-agent(1)`
> 
> I don't think it's a good idea for git to parse the key and try to 
> determine if it's public or private. The fix should probably be in 
> openssh (different error message) but when looking into it last time i 
> remember that the logic for using the key is quite deeply embedded into 
> the ssh code and not easily adjusted for the signing use case. At the 
> moment I don't have the time to look into it but the openssh code for 
> signing is quite readable so feel free to give it a try. Maybe you find 
> a good way.

Thanks Fabian, perhaps the easiest way forward is for us to only pass 
"-U" when we have a literal key in user.signingKey as we know it must a 
be public key in that case.

Best Wishes

Phillip

> Best regards,
> Fabian
> 
>>
>> Best Wishes
>>
>> Phillip
>>
>>> Best
>>> — Adam
>>>
>>>
>>> On Wed, Jan 18, 2023 at 3:34 PM Phillip Wood 
>>> <phillip.wood123@gmail.com> wrote:
>>>>
>>>> On 18/01/2023 11:10, Phillip Wood wrote:
>>>>>> the agent [1].  A fix is scheduled to be released in OpenSSH 9.1. All
>>>>>> that
>>>>>> needs to be done is to pass an additional backward-compatible option
>>>>>> -U to
>>>>>> 'ssh-keygen -Y sign' call.  With '-U', ssh-keygen always interprets
>>>>>> the file
>>>>>> as public key and expects to find the private key in the agent.
>>>>>
>>>>> The documentation for user.signingKey says
>>>>>
>>>>>   If gpg.format is set to ssh this can contain the path to either your
>>>>> private ssh key or the public key when ssh-agent is used.
>>>>>
>>>>> If I've understood correctly passing -U will prevent users from 
>>>>> setting
>>>>> this to a private key.
>>>>
>>>> If there is an easy way to tell if the user has given us a public key
>>>> then we could pass "-U" in that case.
>>>>
>>>> Best Wishes
>>>>
>>>> Phillip
