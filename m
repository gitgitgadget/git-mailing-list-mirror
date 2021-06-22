Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD47C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9912B6100B
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 19:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhFVTvk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhFVTvj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 15:51:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C5C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 12:49:22 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f30so26218lfj.1
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRNu3Q83D+PLjmBXWD6rsLlL1xP0LW+K+pNAi7HSf/U=;
        b=hSZ+VrPtES4b9WHmnZ5bHC4SuldcYymXawmST6Oksv4nXT5G50AcBsCQwzQin+qmYY
         Asm3qSbMGtyGEK9OgzJBz7jcVeXuem9zQqgo1BCOBUKxx86cAgEh9SbBpzRDqoVojEs8
         2UlAy9Y8cTTJkIMdqH7/P1MLsXgHElfcdY2+l/HvuN/kLA4OCxytonISxxQadmnoUafH
         RKHpI0i7Ab10GuBk/CJtmbt2eNxGETj5x+mFSnHQo5DCnCtFGBhgcIKOMSQtuohDzxOS
         K3bkFZ9Sww7zK9o4nNNVTYd2U2pGOVZYQMbn0wv9ImQ7U7hc3i5qi63l6RLdXl66e1Z1
         f7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRNu3Q83D+PLjmBXWD6rsLlL1xP0LW+K+pNAi7HSf/U=;
        b=Efdia4gx6jds2Fky7wFOeUCIznDVQZtlKaI9m/2fOPOVdCT7GqCUlTpczBln6HhcbV
         1tzwul/u9x3wTkD6IGAm41T7x8L8pmTWiYORMCn4RhLLUDYbLmXmytenfppE+Hg1Z7Oz
         bY57aTz+mUk3KUvC6YovDD3XDaKvgaoq5rsu8LzmO3AxFG+mtKVSg/N1KgV0KM6GmWCF
         yuWb2amIPEyvUlmAWt5kJFzkzSvspX35Mqj9dqtsHk+rCxUQv8X/wtJPvgOrKfrezb2n
         C+PaCZ7UQas2Aa9gx6v7ToJ4582Si3E1hBi/B8NQphSTrn/YmYXACoiXBA4eHno39ddq
         sf1A==
X-Gm-Message-State: AOAM532VlYvLRLByCLB3lpFx6hKRyBx/k6Us3QtiTOLarbHZbQqDf4ga
        ymSzoWZH+YCLm+L4CK4+E8CA1nadxbdRGVv921o=
X-Google-Smtp-Source: ABdhPJxMzarbutbsgpLkpJmhvAz7160aLTesjTfp7W+fnDEY9+MmdMGyQgOiixFHw8LqSzUgZytdRF9eOeuwW+KKsQ4=
X-Received: by 2002:a05:6512:2393:: with SMTP id c19mr2309379lfv.242.1624391360594;
 Tue, 22 Jun 2021 12:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
 <patch-2.3-ea39f1f5cd2-20210622T141844Z-avarab@gmail.com> <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
In-Reply-To: <YNI5KVGT2mLlTrnz@coredump.intra.peff.net>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 22 Jun 2021 12:49:09 -0700
Message-ID: <CAPx1Gve+Zf4PHMVjv3gCTaW_0Fh6W7xL+J4bnAU0FA8OV7SR2w@mail.gmail.com>
Subject: Re: [PATCH 2/3] Makefile: fix "cscope" target to refer to cscope.out
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 12:26 PM Jeff King <peff@peff.net> wrote:
> (I wonder if anybody even really uses cscope. I wanted to love it as a
> better form of ctags, but I have always found it so baroque and
> complicated that it ends up being a waste of my time to try it).

I use cscope all the time, from vim.  If you use vim, you'll probably want
cscope_maps.vim.

(Sadly, cscope is not very good at C++.)

I think you're right about the xargs issue here.

Chris
