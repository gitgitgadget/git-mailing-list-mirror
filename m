Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F1BC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A952206CB
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 17:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KHZS68IA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390751AbgJLRpL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 13:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389562AbgJLRpL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 13:45:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11173C0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 10:45:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n9so15019395pgf.9
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Kd0AbwI0Y/rAZ6GyBmXKRfroPQVDvEvW/zjyoqaiTw=;
        b=KHZS68IAHiytyPZVAsGX7gf4AKKnZxvvAfQFVeAPFjfUBp0v1AV0g0l8268Ix5X/+i
         s66BLb8DW3VPVqpY3V+hOA4sUjqQwQ3gjKU058kOPO9jFtCLqdtMw0wQj/SGiNuiJTJD
         RGhFy1TFG+/fjqqIbi8Eg9NyM3ZnEoDsqYok2ZbfrxBBoKZpOrpKSvGeRrU6YCxgR+wI
         oOGPF0Gr09rAjBW5F9arfujeMaFFLWJrqpjwY4MDSiwJiCpXmaphhhzZQ7h3EURqPYPb
         ad2TDJKB8jsPoGtFD/KkQLQT998Xneg5NxNc9o0vBUXmfcg+QGu85ZfH/kbz7MRRtIC4
         wkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Kd0AbwI0Y/rAZ6GyBmXKRfroPQVDvEvW/zjyoqaiTw=;
        b=tcdbxT2h0BQMdfHhGuUkD95YJpAifhyG1XSHj8hnPWZ9JZZw0dwuM6xKy9FI9DU/ue
         g3JpN0V0Yaodt+9Fbqb6u70vqJGghHfwqR8XGsDrbJlQ/yx5MC8cUWM6NDUwHHv8qoVQ
         nGrUSgAF028yyoDEKnEke76aJTs27txJ7c5cGklcgtcdxoZz6qxyXFXo4Sk/mZbtST9M
         MshJN/9eg8ZiZ76l3A/+r7oxcUDY2SYSViIzb+0vJd9jYO/st2hRRPItt+Lp5agWA4oQ
         +t/fOgHakS2Aw+5It/sjXJZM4Fk+kZukpsj2fq4goZGbZbQ6GJvvQJT3fzHA1ZjLYLuc
         SPQw==
X-Gm-Message-State: AOAM533blknwcIAoNWnNe2dfQ0PyjbjmzyjP5sQaGwlZ4gh9TU5FpIcU
        WI6eAB1VQoULxRNirQm1ra4=
X-Google-Smtp-Source: ABdhPJzsrilZg8q9NPA9AgcUSwKX5yOFLerWBYcJxfMixOoWgoMDBEzON+9MjX9ulWRf64I1b/s4rA==
X-Received: by 2002:aa7:8287:0:b029:142:2501:39ec with SMTP id s7-20020aa782870000b0290142250139ecmr23861709pfm.59.1602524710422;
        Mon, 12 Oct 2020 10:45:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id 15sm19599129pgt.24.2020.10.12.10.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 10:45:09 -0700 (PDT)
Date:   Mon, 12 Oct 2020 10:45:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
Message-ID: <20201012174507.GD3740546@google.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
 <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com>
 <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com>
 <20201012152505.GB3740546@google.com>
 <20201012170527.GA21606@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012170527.GA21606@xps>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:

> In order to be as thorough as possible, we thus also need to replace
> these function pointers for libgit2's dependencies. As registration of
> the allocator happens at runtime, we need to also be able to replace
> function pointers of dependencies at runtime. E.g. for OpenSSL, it
> provides an API `CRYPTO_set_mem_functions(malloc, realloc, free)` which
> we call on global initialization of the libgit2 library.
>
> So, to answer your questions:
>
>     - The allocator is global and cannot be changed after initialization
>       of libgit2.
>
>     - It is pluggable, users can set up their own allocators by filling
>       a structure with function pointers for `free`, `malloc`, `realloc`
>       etc.
>
>     - Due to the pluggable nature, we need to be able to set up those
>       pointers at runtime. We can provide a set of static wrappers
>       though which then call into the pluggable functions, so defines
>       would probably work for us, too.
>
> I hope that answers all of your questions.

Thanks!  Yes, that's very helpful.

Jonathan
