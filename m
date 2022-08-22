Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3A2C28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 17:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235812AbiHVREg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 13:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiHVREf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 13:04:35 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E293D5B5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:04:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id de16so6230874qvb.12
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 10:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=VD5lxwy8miv2/7CkHmowMjv0AVwkxZA6ZVmlGxOrrXY=;
        b=es/zRWQ1RplRfNs8Wmh8bIXgQSUEMjoDlh4MU/PscO+43jZ2EQZTTrtD+Ypib8DOdU
         QMR9hfCZmcL+LrKMc/lyRgvjC4EeFWi8etAX2QqeLMkSAimgPXkeQUIxQ6PUSueyt5mX
         yhfLauyWFJuq/wtq8tKq5zllW/3PQM554Ifwae1xTRpRFVcdbrH30NYJtZUHTbf+2XH6
         SnGw3xm9mPHKAnPv7b+CNzBo0VCcF1lNoOr4zzZCNGg11W85sDsJGPgV8a/GMnQW1G0c
         pmfpiDbAL9/GvrnC3TGf04JGwD1Hq7SGLYKpyfddA8rHGA62j5Mm77olyeQ8zChl0Edm
         G5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=VD5lxwy8miv2/7CkHmowMjv0AVwkxZA6ZVmlGxOrrXY=;
        b=6HsW2nu8OS+ja8deE7rcaBu0uSnwhIvg8h5I/4Upu3Zn/W8XTWrSZzrQHZfAyE1wP5
         1WjPFsMzgs8moluBFfgC6bIGT+CUaRi+TPrHFiZ3xx4XrKJFmsruURTB/rFod7C4K2qx
         HsWxUpM9BIGgoLt45i9YEJxOgYU+l6Hl09UMAxGXnZdVI3uPY5N8fTRMaKlhy+RQD0uC
         pGCpsKHAQJ6n34OxNnsdyJSxEFVnp3bU8gQni5jQJ4fnhJ8US+xQT7oPBqmwapau7RAW
         GRmndSiMsx37a8E8LrEWoeacZbB+qRsBflPfdJuSVEuW3mmNXCA/1J6K0cnSUBkAufCB
         H4tQ==
X-Gm-Message-State: ACgBeo1SfJMxK5vIPF20So9/fTcITdCaTtBuazQSVb+cpHqQ6DgNUv98
        RKxiPtHn/NI3wOhaWJ6ewZXv
X-Google-Smtp-Source: AA6agR6xxXqvzOr0oy0UAy/mg+NnegyzVtpBi3ECz1XQNBrFxLzfKVczgTBS8v3h4F4BZ+AJ9awNeQ==
X-Received: by 2002:a05:6214:2424:b0:496:daea:e21c with SMTP id gy4-20020a056214242400b00496daeae21cmr6957752qvb.95.1661187872934;
        Mon, 22 Aug 2022 10:04:32 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:5550:8912:9500:397a? ([2600:1700:e72:80a0:5550:8912:9500:397a])
        by smtp.gmail.com with ESMTPSA id z4-20020ac875c4000000b0034454d0c8f3sm9079319qtq.93.2022.08.22.10.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 10:04:30 -0700 (PDT)
Message-ID: <6c146fa9-48da-5f74-c91a-29c54e1da6ce@github.com>
Date:   Mon, 22 Aug 2022 13:04:29 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 0/6] midx: permit changing the preferred pack when reusing
 the MIDX
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
References: <cover.1660944574.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <cover.1660944574.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 5:30 PM, Taylor Blau wrote:
> This series resolves a bug that was reported[1] by Johannes, and
> investigated by him, Abhradeep, and Stolee in that same sub-thread.
> 
> The crux of the issue is that a MIDX bitmap can enter a corrupt state
> when changing the preferred pack from its value in an existing MIDX in
> certain circumstances as described in the first and final patches.
> 
> This series is structured as follows:
> 
>   - The first patch of this series adds a test which demonstrates the
>     problem. (This is an improvement from the debugging in [1], where we
>     only noticed the problem racily in an existing test, and only in
>     SHA-256 mode).
> 
>   - The next small handful of patches refactor midx.c's
>     `get_sorted_entries()` function to make fixing this bug more
>     straightforward.
> 
>   - The final patch resolves the bug and updates the test to no longer
>     expect failure.

Thanks for putting this together. Definitely not an easy bug to find
and fix.

I mostly have nitpicks, but the overall structure is sound.

Thanks,
-Stolee
