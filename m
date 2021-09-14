Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C70C433F5
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2704060FC1
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbhINRbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhINRbi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:31:38 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E37C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:30:20 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id b7so18179254iob.4
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 10:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t64Yg3vFja0L6weEO/jHuhR3UJyABFmRFbd856u5WcY=;
        b=Wi1Jd8vSxNb42/j5ZXVoAYxEJ7Gin8X83zs9BzuO6ic56iT2/v4EZCy4+fcfWKhvIL
         0T3JJdjb7Knady96Yd1eM8u58/aRgg74R06Kgb8IAm7qKCUcTdLHctRExM9Zvcfu2hek
         QwIWPzJg3NqgKPODwae7kdmJztRYl7pX/gJV1tMVlFrUxbJChUCqPUTAKa8DxDkW8HMq
         Ym5DJbqSy4zo1xwifLn2aE4J6yrfERL2mmKqC9eZV4grCUlnBkzYS7D1N+wJBokINZZS
         +e6LLlgMNZRJRYfLSuBQRIfOLBoiMlSM5mg39nMquiLltNCrzxEUusT9/gI4q6wtrDC9
         t3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t64Yg3vFja0L6weEO/jHuhR3UJyABFmRFbd856u5WcY=;
        b=sDXMxOJWttPjbl3tRqdy+TDQpjsPLH1dxxd+3iI73yRyOJYbS8it1ghCA7WYTo6ev5
         2XrDVWv6A9ApkgsuM5gFKXZzCvKDlBqF6e4pDChQsySl3fkh1N2yAB0Rr76Uj81A4pMD
         ofFReUGbIrX7IgstHIoiwdxB2xoRV66Uz6vp5GdXVrAbhDIkjRbtoGCBUZ9pLgtSus1o
         JawQ9DTuPEwI8dzTx74rEm/FU4vuu48EA8U5087O7ooUgUuDtLRcY+WN7OXG0omDRVpI
         zjZF+rNuaTk+u7M9ifQgNxHmdS+GVuXqn7EBleVxgueU2Rb9hxYjig+G6ZbYspgdq2vq
         tR+A==
X-Gm-Message-State: AOAM531Z4I/sEP9JAFS5OzNjEmntXQmtI7ZK0fycDRqBCtc1HDTib7hw
        TDzFjHaRzaJ4n8o/wOfs7B4zfQ==
X-Google-Smtp-Source: ABdhPJz5TfO9HHat4nlEWcZhxVuWTVtrmS66Q783/kNeMGLRz/PkPfUtOEoVyJTVgsO3cs0g8BxmEQ==
X-Received: by 2002:a5e:d80a:: with SMTP id l10mr14287351iok.36.1631640620027;
        Tue, 14 Sep 2021 10:30:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i14sm6776703iog.47.2021.09.14.10.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 10:30:19 -0700 (PDT)
Date:   Tue, 14 Sep 2021 13:30:19 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/9] reducing memory allocations for v2 servers
Message-ID: <YUDcK3/rCCybKk1w@nand.local>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 11:29:46AM -0400, Jeff King wrote:
> While looking at [1], I noticed that v2 servers will read a few bits of
> client input into strvecs. Even though we expect these to be small-ish,
> there's nothing preventing a client from sending us a bunch of junk and
> wasting memory.
>
> This series changes that, putting a cap on how much data we'll receive.
> The two spots are the "capabilities" list we receive (before we even
> dispatch to a particular command like ls-refs or fetch), and the
> ref-prefix list we receive for ls-refs.
>
> [...]

Thanks. I reviewed this series carefully and all of my comments were
either of the form "you could have written it this way, but I'm equally
happy with what you wrote here" or "this behavior change won't affect
real users and so I'm OK with it".

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
