Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C841C433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 00:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C3822BF3
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 00:57:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbhAYA5S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jan 2021 19:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbhAYA5B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jan 2021 19:57:01 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F00C061573
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 16:56:17 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id j13so157622qvu.10
        for <git@vger.kernel.org>; Sun, 24 Jan 2021 16:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Be8vYSL+E3YxRAPVLK0Rp1+PvZBCnPSldawMTU8rg9I=;
        b=GivxRTbM4OtfAuwSJ2j9xAi4sEdK+8LBqC2ouhJgXMnKWfA7IjUXVZ43zX3tIB8y7u
         /LFT8ov6hsoUIfT8VKsjEjD0u0azIV1UXYTMczOj9mUisAe2koLiRidfuapVHSPq5NGg
         ynBrlSbKRGqFuelhmZbRZaeyLijzrxwTMTDTmlLBrsvAZkWnJVmgivPkcqEO1LGxLCwu
         5aIwNpVexn8wj/PJbMfD3+1dhP9bQBhLF7ODc8I+P+11CydoE8P72TtpKwqu8ceV/QTn
         h5gkkYljHsI91xWFI7zmRlvVoxW8/KndS4O4vq3FI6/3VpP9QjYWD525X9zfVWLOdu1S
         23CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Be8vYSL+E3YxRAPVLK0Rp1+PvZBCnPSldawMTU8rg9I=;
        b=nyLwbEwlg2/gUMniKN7ahSaxrRfFHpJlnwXSqPLedGGd/v01Lx8b7pPGM2UHxNlnau
         4BzBKLl9VHOnFpt48ht5A+sbVsCmD6CjqxOIeIS2kElPp7ce9x3BiUvYoHgi6RZQGEn+
         ZNfQBbWqGIFWE7Q1DzBEQBPL2kRteew2n6Jyl7xdMpmgls+wtSOfsS2VYCww9topwfa/
         XpeN4Lyr4//WF4f2rRhULFfEcBHZrbxbJ1nEEGY8ZUYau1zBaiBv9SiFAT4+eivqDZZd
         njyTqF63COZaZLm5NOi/6JJgH+dr8E7jXhqsnh3iZ0184Au6/VzYRXINWLe2KbAPtmuu
         G3gA==
X-Gm-Message-State: AOAM531gR6Zil7RlHr5lFZJfmyi5wayl4etPhIrXcIJoMcGvZLRNNDFH
        tNj/LsG/ncYdgTDVa+76nuF7pA==
X-Google-Smtp-Source: ABdhPJwqMkOSxYnN8dDk1rbVQICmtJs16GdJmuY7pF1pxFQcite0jCLG8JdzzUgtewT55e6+NSqbsQ==
X-Received: by 2002:a0c:f582:: with SMTP id k2mr17373qvm.55.1611536176187;
        Sun, 24 Jan 2021 16:56:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d8ad:42c:f23b:d0ef])
        by smtp.gmail.com with ESMTPSA id p26sm3250537qkk.6.2021.01.24.16.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 16:56:15 -0800 (PST)
Date:   Sun, 24 Jan 2021 19:56:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci/install-depends: attempt to fix "brew cask" stuff
Message-ID: <YA4XLedWCwrnzMp7@nand.local>
References: <xmqqk0sevqlh.fsf@gitster.c.googlers.com>
 <YAH0G+Y4fIxoTeZa@coredump.intra.peff.net>
 <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <830a88ce-1728-a6a5-f60d-59328f85932c@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 23, 2021 at 09:41:29PM -0500, Philippe Blain wrote:
> I've CC-ed Dscho regarding if we also want this for the Windows tests,
> (I don't see why not) and if we feel it's a good idea I can
> send a proper patch.

:-). The first thought I had when I read your email was: "shouldn't we
turn this on in those sharded Windows tests, too?"

So, yeah, I think that this is a good idea for the windows- and
vs-build tests, too.

Thanks,
Taylor
