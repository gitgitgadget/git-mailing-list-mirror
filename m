Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F97C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 15:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BD8A611BD
	for <git@archiver.kernel.org>; Sun, 30 May 2021 15:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhE3Pzh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhE3Pzg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 11:55:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3997DC061574
        for <git@vger.kernel.org>; Sun, 30 May 2021 08:53:58 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id b25so9895753oic.0
        for <git@vger.kernel.org>; Sun, 30 May 2021 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=zhc8+ghSDba/70Ylq0HgdfNYEpSpFm1AVAjgkOt6YDo=;
        b=gmsp+4oCHR0LQ9OwmKMnHvH25e7BI7C06w4GOJGAold9+sX9cbi6I//zukU6llmMgb
         Fju72KMKhSxEAolwKmTFBknw88eBF5SuA/n35Yo2XnLeRUkyuT/ZpPY2ivtdothMlFzr
         34ZVXJxgtAikumaETl2P3Pv86xPjLntVntS6CS7I0Rkff+lGnz+zHVsfiRbfzoEAs9r7
         5fjctr6MmOV/Zal+qBaizXes7vDSWbHW5fYkFNfcAS9l6T8mTKDiK7d87Ia0Kr1w39Og
         Dg0EHPC1vAHcdCS/9BJfBg+bB3SXzWzDxKgahpvixP6HI1KPvou2iIQlWFluzsFcE8vE
         CxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=zhc8+ghSDba/70Ylq0HgdfNYEpSpFm1AVAjgkOt6YDo=;
        b=Tic2qtuzYx9GHtdAr7UbTmTODAU7ncfYzRd22LXh+nQG4i2HdoZ03XDaMjOLxmEW39
         a0bKK5r8EOxWQqge+PypPtirQBuVuGbGVCt3Bo69B856tPiAY/nMUCa5ouGgj1CmRLqP
         V+vNGTDiUb05A6Yo8apx3f5tfM9N4puOkF3qFSj8KSEw4URA2T8Tvqx+ldxPM50LGmRN
         T3ni+BWJI8KB2Gju8r1RTwAm7Lez7YKRcooBNaxi4bnlAEMCkhUhFYKSHj55shWIbJX9
         g5iMP1n+0IP57fB/mAlL15Hi+7e9hIuCz3f3gysmj8gQ2CPdYYLzm02KEUXRHi/xwuHH
         FS8A==
X-Gm-Message-State: AOAM533R4xWg3Buf0OvOAdKTEEKgkC+Tzz56LRTs7C9vANmgJ7dO9euU
        RIC4IUUN5o3vK3/2AkqYxcI=
X-Google-Smtp-Source: ABdhPJx2Bsz15hYImyG74ewwFmzQuYSd/0cVKPahyBieWkgJiFGxhk2Sx1wehoQr+1qB41eHkNV7qQ==
X-Received: by 2002:a05:6808:b22:: with SMTP id t2mr14483983oij.67.1622390037379;
        Sun, 30 May 2021 08:53:57 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id t14sm2334630ooh.39.2021.05.30.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 08:53:56 -0700 (PDT)
Date:   Sun, 30 May 2021 10:53:55 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>, Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <60b3b513537ca_b8852081a@natae.notmuch>
In-Reply-To: <CAOLTT8T0XtmpH3cHDBOfcX5nmCzfyrKby4TrFkHtA9H3dDN63A@mail.gmail.com>
References: <CAOLTT8T0XtmpH3cHDBOfcX5nmCzfyrKby4TrFkHtA9H3dDN63A@mail.gmail.com>
Subject: RE: [GSOC] Git Blog 2
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu wrote:
> My second week blog finished:
> The web version is here:
> https://adlternative.github.io/GSOC-Git-Blog-2/
> 
> -------
> ## Week2: learning the slang of a new city
> 
> ### What happened this week
> - In [[PATCH 1/2] [GSOC] ref-filter: add %(raw)
> atom](https://lore.kernel.org/git/b3848f24f2d3f91fc96f20b5a08cbfbe721acbd6.1622126603.git.gitgitgadget@gmail.com/),
> I made a license-related mistake this week. When I was
> implementing `%(raw)` atom for ref-filter, I noticed that
> `glibc` did not provide us with `memcasecmp()` which
> can be used to compare two pieces of memory and
> ignore case, so I found `memcasecmp()` implemented
> by `gnulib` on the Internet, and copy it to git to use.
> But unfortunately, I should not copy it so "conveniently".
> Git use `gpl-v2` and `gunlib` use `gpl-v3`,

Minor nit: some projects are GPLv2+, and those projects are compatible
with GPLv3, but others (like Linux and Git) are GPLv2-only, those are
not compatible.

So say GPLv2-only.

(In practice I don't think it matters because at this point probably
most GPLv2 projects are GPLv2-only)

Cheers.

-- 
Felipe Contreras
