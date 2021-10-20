Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1AFAC433EF
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AE3361355
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 12:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhJTM1v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbhJTM1u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 08:27:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13B43C06161C
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:25:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so1259743wmg.2
        for <git@vger.kernel.org>; Wed, 20 Oct 2021 05:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=+TqnT4YE/1CYT3O9yueTdab+uUVk6WAQXDciz5Hp8IQ=;
        b=C+rcTjPpkf/td5AWIpidDnqbnKCmTZrS1stgcaTz/cKXjv1Pdit2ak3EGGwwl1dSWv
         WHok0iWUulXrIoNQqNRuziawipqrc2Y4UqoYxNqRIUOnI6Yxc6WdnonCgsNbzjzp8rSG
         DKEv3YVqeSemXO5pYHOvaBzp+3ywP2MrQk6EqJJt1hvSgrvh/TlRSg05Us5ZhffhZoo3
         nX4pb8vAWDmmzwyaaou1OAxuJbpWz261iSnsnzuWuoC87tkGWYBm1plNjnWFNGDmBBVR
         yJIvSXafxz33ydtFiqpSdbACCC6R1s6D23IFSxsfnsdkeuBOSYuaRnUAyUhAaYWc+CHZ
         mvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=+TqnT4YE/1CYT3O9yueTdab+uUVk6WAQXDciz5Hp8IQ=;
        b=EOr3JiR8YbZITVqTlta+Bi3enqzAyOUicREMXw61m7fjPKer1Y7pZ/uHylRvhq7f2e
         REbXnzDcNKKlUjDW+gRqWMpajBjjAuItFYCPVSuozNLZ5Kix7kqYqr5UMbezD7NstLer
         H6wJOHkgCHr95NRfWlt2ZFuhDQLQdyA1jhtw8dUg6wk0N5fV/upH6KlVHHITHblyKcdv
         wME28I1btorX+d1qNQyp/XTUjhepgnqmNA3n23nlGp57tjTDODotBrlfYun/GbIHA9/7
         orcDU0m/+9S9YgxIBc1FbvA1ywcoUspIZBhbGMb1bswiH+3Q/VXRBG2hyP2j2H6pa1eM
         eT+w==
X-Gm-Message-State: AOAM532watazZl4vWedAwT/T9qrvJvsD56/ffiNUQSufSofbRtxNGZML
        OjGjtN21jSIkErE7Yk6bggGS+YOVvQ==
X-Google-Smtp-Source: ABdhPJwmZHNJCKcTp3yQ7LzWh8lbw+8L5MOu31E3zbRatXw5a1ajB/dcKYlGTmxHUiYgzFc1Dv99qQ==
X-Received: by 2002:a1c:7f0a:: with SMTP id a10mr13525595wmd.60.1634732734575;
        Wed, 20 Oct 2021 05:25:34 -0700 (PDT)
Received: from [192.168.0.13] (dau94-2-82-66-65-160.fbx.proxad.net. [82.66.65.160])
        by smtp.gmail.com with ESMTPSA id l13sm1892475wrn.79.2021.10.20.05.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 05:25:33 -0700 (PDT)
Subject: Re: Questions, improvements
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com>
 <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
From:   =?UTF-8?B?QkFSRE9UIErDqXLDtG1l?= <bardot.jerome@gmail.com>
Message-ID: <9eafffc8-8576-f1ea-45a3-ae4c337db7f1@gmail.com>
Date:   Wed, 20 Oct 2021 14:25:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 19/10/2021 23:31, Jeff King wrote:
> On Tue, Oct 19, 2021 at 07:38:16PM +0200, BARDOT Jérôme wrote:
>
>> 1)
>>
>> Why git not embed by default some gitinore rules (and can be "disable"
>> after).
>> All the time i have to add all operating system stuff, all editor stuff.
> I think you may have a hard time getting people to agree on what should
> go into those rules. ;)

Yes but for certain things i think we will are most of us agree. (In
professional context)

Temp files for Operating System, file system, text editor and IDE.

It can be also a great way to improve interoperability (between tools)
and identify/improve tools without personnal and team configuration.

Keep repositories clean and easily usable with an abstraction layer of
tools used to do things (editor, OS, CI, etc) is what i want. 

> But you may find core.excludesFile (documented in "git help config")
> helpful. You can set up your personal set of files once, and they will
> be used in every repository.
>
>> 2)
>>
>> I need a domain name / uri / ip base way to choose auth information.
>> i find some examples in past but not as smart as what i want. (Maybe i
>> miss something)
>>
>> 3)
>>
>> For auth client side can we use tools like Pass and or identity manager.
> I'm not entirely sure I understand your questions here, but I think
> you're looking for credential helpers? Try "git help credentials" for an
> overview.
you understand well
> There are helpers which interact with common OS secure storage systems
> (like osxkeychain, libsecret, etc). But you can also write your own
> little scripts, and restrict them based on URLs.
>
> So for instance I use this config to pull a GitHub PAT out of the "pass"
> tool:
>
>   [credential "https://github.com"]
>   username = peff
>   helper = "!f() { test $1 = get && echo password=`pass github/token`; }; f"

Look great i will test

> -Peff
