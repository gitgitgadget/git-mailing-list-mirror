Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E97C7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 17:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLRjX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 13:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjDLRjW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 13:39:22 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B961BE
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:39:21 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id k101-20020a9d19ee000000b006a14270bc7eso3421065otk.6
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 10:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681321160; x=1683913160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q7g/WzKP6Fc/IqOp87A5r8+xCw2XRYOAWz8G7FFv2+Y=;
        b=eGQROuzZwu672QUl3D58MMJkVB7Lig2z+QXy8ZCzHu0GRAI8scTDrENhbQ1iKBV4cR
         dd2O8JX/BOtSCL2IzGIfZ6QpFTMXPYM1JfO0WVoHseFRbtnL3/9ts/OQbcMoUEPZj3Ik
         C4DL1nIl/drrQGcNkbS7FtweIbBb+ZP0Cbq/u0Ttlz7SWauOLT4nMvR3+vejDgT2PVvA
         LJe8I7FAjkO7bWdRmZuytt7nlz9utbIadyrX5BR9Rg0yCVEJyWVKIOYJOOlZ/0c7RBHg
         7mH7OJ+PJyBqS2wfqRoSqGk9hGo0U83sRVOWquucouX+HPWaCxv2L/jCKe9NCdLLbh4Y
         vxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321160; x=1683913160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7g/WzKP6Fc/IqOp87A5r8+xCw2XRYOAWz8G7FFv2+Y=;
        b=VSOXiMrGgnF2S1V2jhW2hRpZ05kcjop7jNIod8P2k+sUYCV3DyAiSzPV0hy2FEDr4a
         euEQ1o4x876V2rlt5/UsuNkt+8PuRFV9k8HUHjsaLdzjAaMz8BcuBfpzQu1OVMyXjxJo
         NrzK3PujAHnnWUHOgwJKN0WBJHLfg/xrBG8jli1CT9SVe6aQRgkq0euHAjL1Q4UMzFd3
         J297kHOSFavfE9gyVO4IfkESkuzadG84kEuSFrEDCES9vbC8legCAOa0maYCRQN5+mbA
         b+8Sv0tHRptuC0oKHfnv9Zfqs2EgyoeqNwN4Vvvqo1eXoE49Rd5SMvjjUn0ZwrSeKATE
         5BQw==
X-Gm-Message-State: AAQBX9fZpdHWHranY9Ii+qXLDwGvnNtxz40mj9NHamL7znvZaIgmtjPV
        XYr+g3Y97ELEnPiAdffLGDgwhkVHvuUcxDT86g==
X-Google-Smtp-Source: AKy350YoL9UHpIs+HBtm396eE80mtuKjJkw9EL0W2vquwBR04/1TNQPjFq6EEW4TjImC6Cu2A6B//A==
X-Received: by 2002:a05:6830:4d:b0:69c:497:50f9 with SMTP id d13-20020a056830004d00b0069c049750f9mr1552840otp.4.1681321160446;
        Wed, 12 Apr 2023 10:39:20 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id n18-20020a9d6f12000000b006a0ae1c4263sm6818766otq.48.2023.04.12.10.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:39:20 -0700 (PDT)
Message-ID: <a4154bd2-3f71-42ba-e21d-097811169a99@github.com>
Date:   Wed, 12 Apr 2023 13:39:19 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/7] pack-revindex: enable on-disk reverse indexes by
 default
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1681166596.git.me@ttaylorr.com>
 <bfa4c23d-8b38-7505-fb57-a02e0a028292@github.com>
 <ZDXTwZcRx7rGa5vW@nand.local>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZDXTwZcRx7rGa5vW@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2023 5:40 PM, Taylor Blau wrote:
> On Tue, Apr 11, 2023 at 09:54:08AM -0400, Derrick Stolee wrote:
>> On 4/10/2023 6:53 PM, Taylor Blau wrote:
>>> In the vast majority of cases, this trade-off favors the on-disk ".rev"
>>> files. But in certain cases, the in-memory variant performs more
>>> favorably. Since these cases are narrow, and performance is machine- and
>>> repository-dependent, this series also introduces a new configuration
>>> option to disable reading ".rev" files in the third commit.
>>
>> I agree that the performance trade-off indicates that having the .rev
>> files is preferred. It makes operations that _can_ be very fast as fast
>> as possible (inspecting a small number of objects is much faster because
>> we don't generate the in-memory index in O(N) time) and you create a knob
>> for disabling it in the case that we are already doing something that
>> inspects almost-all objects.
> 
> Sweet; I'm glad that you agree.
> 
> FWIW for non-GitHub folks, observing a slow-down here has never been an
> issue for us. So much so that I wrote the pack.readReverseIndex knob
> yesterday for the purpose of sending this series.
> 
> That said, I think that including it here is still worthwhile, since the
> cases where performance really suffers (e.g., `git cat-file
> --batch-all-objects --batch-check='%(objectsize:disk)'`) isn't something
> that GitHub runs regularly if at all.
> 
> To accommodate different workflows, I think having the option to opt-out
> of reading the on-disk ".rev" files is worthwhile.

The only thing I can think of that would actually use this kind of
behavior is git-sizer, but even that doesn't actually report the on-disk
size (yet) and instead inflates all deltas when reporting size counts. The
difference in performance here is likely minimal for that tool.
 
>> This was an easy series to read. I applied the patches locally and poked
>> around in the resulting code as I went along. This led to a couple places
>> where I recommend a few changes, including a new patch that wires
>> repository pointers through a few more method layers.
> 
> Thanks for taking a look. Based on your review, there are only a couple
> of things on my mind:
> 
>   - I amended the last patch to more clearly state when we would want to
>     run the suite GIT_TEST_NO_WRITE_REV_INDEXES=1 set, and kept it in
>     the linux-TEST-vars configuration.

I think this is the right thing to do. Thanks.

>   - How do you want to handle that extra patch? As I noted in [1], I
>     think squashing the two together in one way or another makes sense.
>     So really we have to figure out (a) if you think that is the right
>     way to go, and (b) if so, how to handle attribution / the commit
>     message.

Squashing makes sense. You could make me a co-author, or not. It's the
natural thing to do once the problem to solve is identified.

Thanks,
-Stolee
