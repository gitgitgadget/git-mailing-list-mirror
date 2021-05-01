Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D037CC433ED
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1CFC610A6
	for <git@archiver.kernel.org>; Sat,  1 May 2021 17:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbhEARJK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 May 2021 13:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhEARJK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 May 2021 13:09:10 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1669C06174A
        for <git@vger.kernel.org>; Sat,  1 May 2021 10:08:19 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id t4so1771064ejo.0
        for <git@vger.kernel.org>; Sat, 01 May 2021 10:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSx0e9zuPG+9mIefLX+8QIpCBrSuDKmIa4Lrmk5Ea2k=;
        b=GNjOeH6sbNT6RcLOY54eYDIvV9P3Wv9HKw9sXo3tlaj4WWa5zJJXCd6CPungcT+bBW
         TafRtUWw/O3EsG+BBUkhA7XOrhIrofvpqLxuJqhzjUY32STwD5MNUVbrYjSimvRTLMJB
         pxt6ejQ22/d3kz8mlHsnOgc0a3BH7G0P5Q0LEW5FdUw7jSinC9Q+aJGHnifdPAMyu1XA
         dnH1pvz1WefMCExMtYKpepUCD9NtKZZdePomMbhQvh/OEIs431E14DvT/bDxAzeMXEd/
         wFZRgF5G2UfsSlAYmiZ6XDIyHTcycM3kammHhrmeEejiub5mm2CPkeMYALGw4Bz5jevs
         bL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSx0e9zuPG+9mIefLX+8QIpCBrSuDKmIa4Lrmk5Ea2k=;
        b=WzNo1ruZIO01sHh7qYQ9Se/u4/O7AQxGGeePzC2//9wo2OfEspXxo4fXaR8c70QyEh
         R22U5S+fRiu9Fc/eridt+a30VIUCHKn39AbbH3qYMY8neYHw38LFMLRHjnMvZixwF/qQ
         p6eYpxikSUkA0AzN+ZzUZIbGteUwtowEcT9zrUg3lv374k7kCxoOMUckb36CjxlW3edn
         u7HJbzlWnVU3+I9ckBlJZiec5eEXG9gsMlM51g2x/q9C+oiUibCfz1voVthGXMUFZ+2R
         Ak8xV9mOVCuJP4dxL1KLFwcpIaz05QgxUP9MsuRVfh2QUHiq0/K1m/jNvhXDFxzD54Tb
         jxsw==
X-Gm-Message-State: AOAM5313qjpI7mNuACyydqyKXhYj/WUVd8JKryAyDDU9GXeZp0uasxtG
        ewT2cYOTRaIYiJFBtXdcDFrZGrky8xX2AL6W8a4=
X-Google-Smtp-Source: ABdhPJxmMXfVjGfx9zx9wnXn9bFVfbd2n80atfuYcRbc8jIyOqgVKB6AqS4IuA6/wfwcfYXAveUOEUeq2xvgx6YVBhY=
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr9541620ejz.160.1619888898659;
 Sat, 01 May 2021 10:08:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br> <e2d82c4337dc002d7296454c59d4006c3bb43c27.1619818517.git.matheus.bernardino@usp.br>
In-Reply-To: <e2d82c4337dc002d7296454c59d4006c3bb43c27.1619818517.git.matheus.bernardino@usp.br>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 May 2021 19:08:07 +0200
Message-ID: <CAP8UFD16N3MiYawrRLCxsrYuo4KkvD3SS5F4UqyEF37j4T9yVA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] builtin/checkout.c: complete parallel checkout support
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 11:40 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> Pathspec-limited checkouts (like `git checkout *.txt`) are performed by
> a code path that doesn't yet support parallel checkout because it calls
> checkout_entry() directly, instead of unpack_trees(). Let's add parallel
> checkout support for this code path too.
>
> Note: the transient cache entries allocated in checkout_merged() are now

s/Note: the/The/

> allocated in a mem_pool which is only discarded after parallel checkout
> finishes. This is done because the entries need to be valid when
> run_parallel_checkout() is called.

> -static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
> +static int checkout_merged(int pos, const struct checkout *state,
> +                          int *nr_checkouts, struct mem_pool *ce_mem_pool)

For consistency with the previous patch, maybe: s/ce_mem_pool/ce_mp/
