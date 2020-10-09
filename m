Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A21C43457
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDB7F22284
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 18:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjbaVmWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390664AbgJISe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 14:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390445AbgJISdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 14:33:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF06C0613D2
        for <git@vger.kernel.org>; Fri,  9 Oct 2020 11:33:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t77so11181645oie.4
        for <git@vger.kernel.org>; Fri, 09 Oct 2020 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nYs0BB9o0o04Pe0mGWxDEjvm/zYblzfW/tpeSKyulOc=;
        b=hjbaVmWpNqfbVNYx2Z4a8dv/lQjWwzz+aM9synyVu9wRE+lGX5OJrJLyPuOERJySKB
         C1FFs5MTvOfhjoaeeu7xgxNdT2xsu5aQqIySIcpWeT/+InzHbo2FSzZyBiQ6/qL4M5gX
         MX0vp+57gys/DhW+AJqe017eXNib4MfHXS8JFks4TiN4a+6cld7Z7PBhVBIn5FraCs5d
         PTJMbpLOJ3/sPp3gPUqKLkaLD+XF9/MMI3YvfrWrrOSDo7UzS9Gl+DM/Gfm6UdBs6UqG
         rXqvK7zDKHgu4epKJj0sv/qoJaRSNf6zAdtxHOwIgGKDOiH/vC7HWBMD8Qgnpid1G8E1
         /rOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nYs0BB9o0o04Pe0mGWxDEjvm/zYblzfW/tpeSKyulOc=;
        b=SjKJXVR/5ZTIfFN1mxNAhIZ1rvspiJSrePrkU22DANGxn32zWqAIWKyEh2G3Mpv8uP
         jyfYcE/SreCOdY9klBUaPqGhjG6bKjpUv8yEA/s4auaggTiaRpSrNGQJ1jsFjPGOVnEP
         SN0h6yDwjGh0XzCfFcD+Lpc98Lp2DTmgbyCmDW5/g9mWo8TxBSjqWTTBEDReZC3NuSAa
         GAwKL0wMf7l8b8UMaqwbpUnsB7Xny+/osZA+X0dqiKveIvODJJ1koNuKhBkSZ9QG2o3v
         9lMfoL+PFCscjShBQ4pJUoyUvMM8Eyb/5ldNZJtIIjbNLYkmc1/nghxhy6yB9QClCGLp
         QGpQ==
X-Gm-Message-State: AOAM53044AvhiWr1fql688enLXRddBraVfAleRFoRIgQdSS5t+usURjQ
        dInWl3FP04wjk1bAc573U8U=
X-Google-Smtp-Source: ABdhPJw4f49CN65NhQNtUcoZtWsPOAE7uDLfKtHbz5HLmKqvwARNRAWdsaArSKMR9ISQVH60mXgvvA==
X-Received: by 2002:aca:5945:: with SMTP id n66mr3427935oib.11.1602268383334;
        Fri, 09 Oct 2020 11:33:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7515:c4a7:ed16:ef48? ([2600:1700:e72:80a0:7515:c4a7:ed16:ef48])
        by smtp.gmail.com with UTF8SMTPSA id t29sm6693206otd.51.2020.10.09.11.33.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:33:02 -0700 (PDT)
Subject: Re: 2.29.0.rc0.windows.1: Duplicate commit id error message when
 fetching
To:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        GIT Mailing-list <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
References: <20201007210609.GA1984296@coredump.intra.peff.net>
 <329d91ed-097f-38ac-f1b1-73b4d57ce8ad@virtuell-zuhause.de>
 <20201008120658.GA2689590@coredump.intra.peff.net>
 <52782500-274e-2c72-39e2-be4252959d47@gmail.com>
 <5bbdaed5-df29-8bfe-01c2-eb2462dcca22@gmail.com>
 <267a9f46-cce9-0bd3-f28d-55e71cc8a399@virtuell-zuhause.de>
 <0d25e0ab-31ab-54c2-b518-bd9c0b0c4b7a@gmail.com>
 <2f30099a-4a3d-00f7-bb08-ca6c1f76bcd4@virtuell-zuhause.de>
 <64de22fd-2e1b-aaab-3a8e-f6f1d630a46e@gmail.com>
 <20201009175506.GA957408@coredump.intra.peff.net>
 <20201009182833.GA437455@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4c138121-ef58-c870-60b2-8140e6e0cbee@gmail.com>
Date:   Fri, 9 Oct 2020 14:33:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20201009182833.GA437455@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/9/2020 2:28 PM, Taylor Blau wrote:
> On Fri, Oct 09, 2020 at 01:55:06PM -0400, Jeff King wrote:
>> On Fri, Oct 09, 2020 at 01:46:07PM -0400, Derrick Stolee wrote:
>>
>>>> Can you reproduce it if you do
>>>>
>>>> git config core.commitGraph false
>>>> git config fetch.writeCommitGraph true
>>>> ?
>>>
>>> I _can_ repro it in this case! I think there must be something
>>> very interesting going on where the commit-graph is parsed in
>>> _some_ places, but not in others. This is something that I can
>>> really start to dig into.
>>
>> Here's a much more minimal reproduction:
>>
>>   git init repo
>>   cd repo
>>
>>   git commit --allow-empty -m one
>>   git rev-parse HEAD |
>>   git -c core.commitGraph=false \
>>       commit-graph write --split=no-merge --stdin-commits
>>   git rev-parse HEAD |
>>   git -c core.commitGraph=false \
>>       commit-graph write --split=no-merge --stdin-commits
>>
>>   git commit --allow-empty -m two
>>   git rev-parse HEAD |
>>   git commit-graph write --split --stdin-commits
>>
>> The final write will die() with the "unexpected duplicate" message.
> 
> Makes sense; the second commit-graph write won't know that 'one' is
> already in the graph because 'core.commitGraph' prevents
> 'prepare_commit_graph()' from actually loading the graph (actually
> loading the graph would be enough to stop the second write from
> occurring at all.)

Right. We aren't parsing from the commit-graph, so we don't see
that these commits are already in the file.

> I'm of two minds about what we could be doing here:
> 
>   - On the one hand we could be ignoring `core.commitGraph` setting
>     during commit-graph writes and forcibly loading the commit-graph
>     anyway.
> 
>   - But on the other hand, writing a commit graph with `core.commitGraph` set
>     to false makes no sense. So, I'd almost rather have us die()
>     immediately if core.commitGraph is set to false.

I agree that we should just give up, but die() would not be correct.
We should just "return 0", possibly with a warning.

> I think I'd advocate for the latter, along with Stolee's patch to not
> die in the case of duplicate commits in multiple layers of the graph.

If we agree that writing a commit-graph makes no sense if the feature
is disabled, then I can include a patch that has a test similar to
Peff's and that change.

Thanks,
-Stolee
