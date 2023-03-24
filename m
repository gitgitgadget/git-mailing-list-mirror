Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D3C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 17:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjCXRxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjCXRxV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 13:53:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B2D22103
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:52:18 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id z83so3217474ybb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 10:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1679680337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xf5XmoWBm1lBVVWUabimbQW7FfYqGFlx9ZFMlO95vTo=;
        b=SC9fOBOqkAG4A0J6QphhusOVMQL7eGppENGypsQEnEGhM0ds6vJEE4+C0DNBlVozS/
         77WxZKdF4f+M8WaizmR8lq+MjoQPPVUqzqxwpe38u6KxesiHGNvYL6H7MYJpFYn0t77N
         OHi8on6sFXsC0kwQ2OUeK+qW9K2H8ppVYhiiBBrQzZhOoFohKF9mpmKr7tml7dup3nUe
         3h7eRUJLyLBBtXEd/dYWnJzEUN18PEdmzdaeau7KyNl4odAetMYg9oT/YFkdclsQzRSW
         Z4qLYrib8ExEklKqMaThnyX7Pz4Ly2A3YRvaQbUxCh9REGGcydE/kT0T7qeBZ4HBX1/H
         R6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf5XmoWBm1lBVVWUabimbQW7FfYqGFlx9ZFMlO95vTo=;
        b=CbN1nCReiSw26S6gqOntBkauC2+ch9ec50g0ceDKtFh48duq5QANCcKJZ2bmNFFuR3
         N2CE2rbDVOcupFAuIv+AqtVTYQwEYDQ5zNzNcc1LqHOrWefyoYMIbRG/1v29EiqXE3ZL
         HBnoLN9zI02aB6IDEtrXqU4QIoLREzv5hCj8/7sDWM6s4xB2M2P9x+AcY+sf9SD3s22i
         iTrUM7n/Vl40OujaNqHa63yzweTisXJ3YiZxHnSlvEYdeylMu00psdkai0Oek1sPlzlV
         ZxszGaOYdbu1IqjDkSx0UUs5a8CkqIUNFPCq2AE9nB+ZZoYd9vuTLd9rWyUsOws3/4Sp
         /c5A==
X-Gm-Message-State: AAQBX9dyeErd5XKv+QCAXWVnFq7Z6xjZhcrVykmjjyeIk1/BdruVPBmm
        xbRxA8jY70zxUbhO8kRpNnU1
X-Google-Smtp-Source: AKy350bp7bdb84LBrI5+VNAlc70gW+j8NXjNigZ69Ckdimw0MZQ8deFWfM0elGPkjjOcl63b35uVdw==
X-Received: by 2002:a25:4d43:0:b0:929:c1c5:6c35 with SMTP id a64-20020a254d43000000b00929c1c56c35mr2957034ybb.20.1679680336738;
        Fri, 24 Mar 2023 10:52:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55e4:a877:13cb:cca6? ([2600:1700:e72:80a0:55e4:a877:13cb:cca6])
        by smtp.gmail.com with ESMTPSA id v7-20020a2583c7000000b00b784b00772esm204170ybm.50.2023.03.24.10.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 10:52:16 -0700 (PDT)
Message-ID: <9e043d78-a225-4b6a-4567-83ac27b022b2@github.com>
Date:   Fri, 24 Mar 2023 13:52:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/6] pack-bitmap.c: hide bitmap internals in `read_u8()`
Content-Language: en-US
To:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <cover.1679342296.git.me@ttaylorr.com>
 <8c70c94a3f5f0463041dbaaa542fd69bd159428b.1679342296.git.me@ttaylorr.com>
 <20230321173556.GD3119834@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <20230321173556.GD3119834@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/21/2023 1:35 PM, Jeff King wrote:
> On Mon, Mar 20, 2023 at 04:02:40PM -0400, Taylor Blau wrote:
> 
>> So b5007211b6 got rid of the above convention and replaced it by reading
>> individual fields of that structure with a `read_u8()` helper that reads
>> from the region of memory pointed to by `->map`, and updates the
>> `->map_pos` pointer accordingly.
>>
>> But this forces callers to be intimately aware of `bitmap_git->map` and
>> `bitmap_git->map_pos`. Instead, teach `read_u8()` to take a `struct
>> bitmap_index *` directly, and avoid having callers deal with the
>> internals themselves.
> 
> OK. I always felt like this read_u8() and read_be32() were trying to
> match get_be32(), etc, just with an auto-incrementing "pos" pointer. And
> this patch makes them a lot less generic.
> 
> But that is probably OK. They are static-local to the bitmap file, and
> we have not found another caller who wanted them in the intervening
> years. Arguably they could be given more descriptive names, like
> read_bitmap_u8() or something, but again, being static-local to the
> file, the generic names are fine.

Since the names don't match the "get" of get_be32(), we don't run the
risk of a future public get_be8() colliding with these static-local
methods, so I agree.

Thanks,
-Stolee

