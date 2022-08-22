Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F8C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 14:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbiHVOOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 10:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiHVOOG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 10:14:06 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9ABF63
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 07:14:01 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o3so5718010ilf.7
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 07:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=XWIiU7tCsy5bD2FJ3XID6U1S0ro0uVu4zOYcrj6plV0=;
        b=HKbc341l2ed7Jaa2KJ1UuycnA4d4jL+rlGwH6uY2TI6Z1j8bPqRJwC8B1TPQyPEsn0
         XTps3Gaso7xg/8qaVf1ntI0SkMUl7hbLpbG2DuyqT8WwLRn6mVeb1N28Fto5fWZnYgA/
         cR7Id+lBL4cxCOhf97zBzwCvq5LvXFE+JbPa+DpG8i1bTZJ586RYgnYkDxtUwJx/qTgN
         3BSKv7pRjQ2xGP6sP4Z3Q8I1j2zTQsVvGCKbFSchcWhY6vV0+MA/ecppic2GlapGTMlk
         8jFAmC4MIXwCZRYtsCQY7ZpcAWGNpA/SFiXPw6ummX7Qs2LRI9QPg4BEgO12YCxkRonG
         OTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=XWIiU7tCsy5bD2FJ3XID6U1S0ro0uVu4zOYcrj6plV0=;
        b=v09RdhftYV8h2KCBQqHPVnwb9BLmp19CGnHnA0feG27pr3gTXgi5Vj+hXmU5cqvbDs
         sciFmI2S4NslOo8ZxN+ZndiaLdrW9wKG55EEzID6uk18Qfiyeu32iYAI8mxNi20a7VTy
         FYqXl9GZ/TnJo2okQN/QF5Fr8CS2tANUZ3dz+sPiHS6JKfTt4ZiLshvMkGsgsSvkZUkx
         AlUCpxVSK4Ee57nkDr20B1Kw9MAMjUiFAvtHWXTfM53CfY0QLtFG33SJccDdXtqrdgLM
         Mi/hHTSpzBA20RewmF5JAxBzc9dDEpIGHxtWJI866dBhjae+Vtsk6a54Lxvmb+gJVajS
         JTDw==
X-Gm-Message-State: ACgBeo1mbHIK07yPzlGJ2jR7Ozi/Mpi1gZKkZXLQabCPNDgbwYyWT0sl
        uudEK+/DR2UGNrHUrWSELho0RMa3q8Oy
X-Google-Smtp-Source: AA6agR5gqQe70CBGXtT6TjazKdQ/VNDoDeq0p0CmweyvA4OKvRknRMWaUfXXJoJyHb4EBinOcvXpYg==
X-Received: by 2002:a05:6e02:194d:b0:2df:8893:90bb with SMTP id x13-20020a056e02194d00b002df889390bbmr9854726ilu.242.1661177641178;
        Mon, 22 Aug 2022 07:14:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id b8-20020a026f48000000b003436da41c78sm5179560jae.76.2022.08.22.07.14.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 07:14:00 -0700 (PDT)
Message-ID: <5181bfe9-a4d0-76ed-26ee-1f4400105e9e@github.com>
Date:   Mon, 22 Aug 2022 10:14:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/11] annotating unused function parameters
Content-Language: en-US
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
 <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
 <c22a8317-7d43-d84b-f63f-df2da31b4658@github.com>
 <220819.868rnk54ju.gmgdl@evledraar.gmail.com>
 <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <YwCtkwjWdJVHHZV0@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/20/2022 5:46 AM, Jeff King wrote:
> On Fri, Aug 19, 2022 at 10:58:08PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
>> Yes, I spoke too soon, sorry. We still need ((unused)). FWIW the below
>> on top of master and doing:
> 
> Right. Using ((deprecated)) is really just a substitute for the variable
> renaming part.
> 
> And I agree it works as advertised, though I think I prefer the
> variable-renaming version.
> 
> One, it feels like we're abusing the deprecated attribute here. The
> confusion in the compiler output I'm OK with, because we get a chance to
> put our own message there (so I agree the output is actually better than
> with my patch). But from time to time I've had to build with
> -Wno-deprecated-declarations to get around _actual_ deprecated warnings
> (e.g., compiling with OPENSSL_SHA1=Yes). And doing so would be cutting
> out half the protection of UNUSED() in that case.

The fact that we can't turn on -Wno-deprecated-declarations is enough
to convince me that we need to use the variable renaming trick.

Thanks,
-Stolee

