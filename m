Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D183EE49A8
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 06:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjHVGPG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjHVGPF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 02:15:05 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48611C
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 23:15:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3a412653335so3094447b6e.1
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 23:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692684902; x=1693289702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E0JpuAm7xpSrUvHNWxUfAJQnxUQuurm7pBVtXrpq0Y0=;
        b=Hfjh2a20GFOvjcvZLWV975aFCagTwb1m/tv/qzkpH5yW0uWdmHN7SSHLXXrK24IJcI
         +qHcAlgMotpuFVTJx4DzebN+m49Ml20u+PwbRw1YexgcQQgUz5QEzPK1vWkfvwSjZ8Lp
         480a+TlO20uTn93+/yfHMyHzB4Tdp5ZIP8FTolimIfrFIVvWQo/fvmP0tTFNxnCu10T+
         V/EtZSOaZAf/vN+olxni6jbfOrh4nCJYLqnFzOL5IucFkeyDWM8HEF4Q4gU7UJf46f9v
         SJQrPHl87lgyN+FPCIfmBymFyv27dZ31dFkQHSDCmXGf5pneprHQYjUfMPWoMWvcZ5OJ
         ePjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692684902; x=1693289702;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E0JpuAm7xpSrUvHNWxUfAJQnxUQuurm7pBVtXrpq0Y0=;
        b=hH3c8yYdXZB4wWNISE1vu62kX5gQm3tbiiq9p7BBtrJJF7lZd6U+95mXOQ8CImYD31
         9ZvsO0O/MBgtaBDyE5VpVymtku1REnzzAcH64C5Nndc3BppmZyx9ibe8bjiUIY7LZ/C9
         FEXv0tCO2WuAljXzaABpIyeM8CYcxCc2g/P9TncrLzbRc7hpAD3qMOVLFvRU+6yWGDak
         24uvb6CQeJfnqL4xfiVaPpGiHny9ZJAoXcR/Y84TlTuqMTfx/NYcTeifCl0Senz7HYdF
         8ndU4m5DsOk3ecwXP+VucZWDkRKBXe2OMjzo/FEQupyHpdZjz/ahZ6mG5m5tBlTp/sdP
         XoUA==
X-Gm-Message-State: AOJu0Yzj7hfQEzH6s+KuSjyrpvv857K23XEKMadWZ5wTWC80pRNlRjyw
        yLFMSDwdiGB+rURYxdnBLNA=
X-Google-Smtp-Source: AGHT+IGhOG5uswK+N35mp4I7Oikg1pylXvWzEIDGZB1qRK/Gw1/mLisBvDysWEpSsRoDB9hJjsJTmw==
X-Received: by 2002:a05:6358:990e:b0:135:3f5c:9675 with SMTP id w14-20020a056358990e00b001353f5c9675mr9584452rwa.19.1692684902337;
        Mon, 21 Aug 2023 23:15:02 -0700 (PDT)
Received: from [192.168.10.148] ([103.136.137.241])
        by smtp.gmail.com with ESMTPSA id c6-20020a637246000000b00553d42a7cb5sm7099925pgn.68.2023.08.21.23.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 23:15:02 -0700 (PDT)
Message-ID: <2c31a3d4-59f7-d036-0c6b-5fd62cc7a2fa@gmail.com>
Date:   Tue, 22 Aug 2023 11:44:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: Git in Outreachy? (December, 2023)
To:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>,
        Victoria Dye <vdye@github.com>
References: <ZNwhVOggObU7aVTr@nand.local>
 <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAP8UFD2Yw1XazomxEj0QB20FoaxkO16t_xgRurtnqCCOuhX-eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 18 August 2023 8:40:25 pm IST, Christian Couder 
<christian.couder@gmail.com> wrote:
>(Adding a few people who could be interested in helping with this in Cc:)
>

Thanks, Christian!

>> I think it would be good to participate in this year's December cohort.
>> September 1, 2023 at 4pm UTC is the initial community application
>> deadline.
>
>I agree it would be nice, and I am willing to mentor, or if possible
>co-mentor, someone.
>
>> If we're interested, the project submission deadline is September 29th.
>> By then, we'd need:
>>
>>   - Volunteers to act as mentors

Depending on the projects that we'll be proposing, I may be able to 
co-mentor for one. Though, my timeline looks uncertain now. So, I'm 
unsure about it. I should be able to mention for sure after before the 
mentor sign-up deadline.

> I wonder if we need a few Org Admins too.

Regardless, I should be able to help us an Org Admin if there's a need :-)

>
>>   - Updates to our applicant materials on git.github.io (project ideas,
>>     as well as potential microprojects).
>
>Yeah, I can start working on the applicant material after my current vacation.
>

That's great, Christian. Let me know in case you need any help with it.

>> If folks are interested, I'd be more than happy to answer any questions
>> about participating, and overall logistics of the program.
>

I'm guessing the mentor sign up deadline aligns with the project 
submission timeline. Could you kindly confirm the same, Taylor?

--
Sivaraam
