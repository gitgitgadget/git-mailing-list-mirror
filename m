Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15809C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 19:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351079AbiHSTIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351133AbiHSTIF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 15:08:05 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3410A762
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:08:05 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d68so3984153iof.11
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=LY3qh6RYn++HvZxVKqqTRk6/OFrr1C+WJS6PoVH9KCg=;
        b=WLHpBHWO9goeotquEFVkhp8ppVOkmyLQpGTItPU6Ph4Xnj+DrtH5yEPL+Re6B0qHfc
         SvIJaYU1IvV8JKCCKPeBD+OUArA4VDlPEXc/dy8UINm1UHB7IxJGsu21RbIfOv92IkZY
         xm2VRsGzf719/pJQ1mUUMKvGqEDpoxd9SU+WUAbX9JcQZGhSdcoFhMaT1nuT7ltqnDgx
         E9a1vwc/4ptwS+DjsXH2eQmLuHjE5goMPdV/ymPjlxLzNFxXnEQHwJv1+5DsSJ3W6YqU
         2nQ9Fc9gr6gEXc4HRC0eS3YQHksllbYxLt6d5ztSvoYVJIEJ4BnlWEn2eyRBkhW7mjDq
         pXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=LY3qh6RYn++HvZxVKqqTRk6/OFrr1C+WJS6PoVH9KCg=;
        b=ukefe0DoCsBPcfWvKEnbI/OGkPa2dhu4tZx2qxfZsmOjgpQcXSbT0K2ft3c231f1rH
         Lz7EWG+FyYz+kQpxY3BQs+guauwGAyjsm6xOxzqRiRxtYxI5pLv+uglfCAwLalLpZPKe
         8lEOjUKXU0Ar+wAYK5MAnZ7QSbpVcwa5uWM3MdsnYynxXmSERqLKitV306yDzzNjAXp6
         7w8+oXgCZlgLMq12yVACTThZCe/9U8Snw8YkSzc6LSIx/nCPwtJKI7x6mVvl8UrUPUot
         c8Jj3uOPyJpW0YN+5soNV3tp4FRo7Cky/6D6rkVsx1uO/r1+wTnYQT3CDXatiHSjF/rq
         AoaA==
X-Gm-Message-State: ACgBeo0eZV5jOpTR0gFOJ5cOokb/2EYpn9puCq5FLvWKs4VpxU6DGAmy
        ZX9/JfonruvXy1emxz1EXW7QyGIvZ42G
X-Google-Smtp-Source: AA6agR7tl6ioV7qHIrlaW49JqhgmnhifCeL3qX/a+Jp+I3hPUp/GsPVB/kNyBy9zonmp2qCzpUhFgw==
X-Received: by 2002:a05:6638:dd1:b0:346:af08:6ed2 with SMTP id m17-20020a0566380dd100b00346af086ed2mr4294505jaj.97.1660936084539;
        Fri, 19 Aug 2022 12:08:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id s6-20020a92cb06000000b002e9627d9a60sm159091ilo.75.2022.08.19.12.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 12:08:04 -0700 (PDT)
Message-ID: <892b2a45-1b6b-aa87-4902-471793135183@github.com>
Date:   Fri, 19 Aug 2022 15:08:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] unused function parameter potpourri
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 4:48 AM, Jeff King wrote:
> Here are a few small cleanups of unused function parameters. The first
> five just drop the unused parameters. These are all trivially correct,
> since otherwise the compiler would complain. But I tried to make sure
> that dropping was the right thing in each (rather than it being a bug
> where the parameter should have been used).
> 
> The final one just uses the parameters for an assertion, following a
> pattern we've used before.
> 
> I'll try to cc the individual authors for each patch.
> 
>   [1/6]: xdiff: drop unused mmfile parameters from xdl_do_histogram_diff()
>   [2/6]: log-tree: drop unused commit param in remerge_diff()
>   [3/6]: match_pathname(): drop unused "flags" parameter
>   [4/6]: verify_one_sparse(): drop unused repository parameter
>   [5/6]: reftable: drop unused parameter from reader_seek_linear()
>   [6/6]: reflog: assert PARSE_OPT_NONEG in parse-options callbacks

Thanks for doing this cleanup. It all looks correct to me.

Patch 5 mentioned some choice as to modifying the parameter list
versus using the UNUSED() macro. I think renaming the method can
solve the uncertainty there, but it's also not necessary for the
change to be correct.

Thanks,
-Stolee
