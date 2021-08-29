Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A39BC432BE
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 10:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821AF60E90
	for <git@archiver.kernel.org>; Sun, 29 Aug 2021 10:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhH2KY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhH2KY0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Aug 2021 06:24:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BDEC061756
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 03:23:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eb14so7687037edb.8
        for <git@vger.kernel.org>; Sun, 29 Aug 2021 03:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOocCZWmJHxdGycuCw44hF1atT7wqrDlRwzHz9cRUIE=;
        b=t/nSe+ga23ye4jkmCPVBiWY4Qono/lboO+N4C8bsfwhuzZdIBnvIQnDUswYVol4e/B
         uTBmKNJqYtKk+xUe9AdP6hvVp4zem/q6SpTO+ZvK2RLB4VbvLZAI4qt8r7ksOVBNGw9w
         6vEjx9Ep4B46eBPuX+qZe4nt0MuglwybtYrYdCe/ExWrlXWnv3M5QI8ssKCzoHePAfO0
         PKwifHDlkhpEAIiyqZsbP49Hz9iEpLnFTxYhmppMBIknOS5lp2x26VTj1PBf7u53AkpM
         xSEUz8+zkY7d+cIKxJUWkMmzSqjTgsA0N87YnnDFOMd7faGPx3lewBdx4TmAXmsraSHW
         lixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOocCZWmJHxdGycuCw44hF1atT7wqrDlRwzHz9cRUIE=;
        b=UPc1MJxjOO24F4TnxKrCdut9mtTSUWd0h2jYDTeB9FucoQ1jgqUtEMVM3uOdwrnvD3
         Sh2nB7n5LB9f6VdU1ZcxC5xGpqoaw3jU9CCEtFibJJ/TRNQKalPg+ndA5sZlgyHRHVvS
         GOsRpCgXL2TkAp5+fBpDKhO3puCR+21RUWyQib8SnlYqbJ5qBBguEgiPEdERezW4+IV2
         n4ghVs4joAHs8SO/WgCDWeopoks1L6KK0PuuBUPi20mJkAcF2Fd7L70R6rrmDXS48cxr
         hzqlviU36gqP53279I4E1f4u0Uk2MJD3RVyhzOwODWQ6/kVGDTf2koiICQGOlnOBqb9J
         fW+g==
X-Gm-Message-State: AOAM5300JyDp3PTGJMWCIzgDuUHPTx2rwgLWDGGK3JJQaJmwSzsjeJRZ
        UF6vHKFa0f6gdIjgHVtvieoytBC4jYLBDccqh7AONCxV
X-Google-Smtp-Source: ABdhPJybwH7bxYBnIBRu/Jpn1LyLGuTPLVB7n4ZqxpiT0huyNquIaqk5hgFvsPZchJdzGy8M7HdqyvutgtlyLKurYPM=
X-Received: by 2002:aa7:cb8a:: with SMTP id r10mr18742882edt.237.1630232613355;
 Sun, 29 Aug 2021 03:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD197_XdFZ--khJa_E7bkG4VCsD0dPVP60AD=AfQU6Sz1w@mail.gmail.com>
In-Reply-To: <CAP8UFD197_XdFZ--khJa_E7bkG4VCsD0dPVP60AD=AfQU6Sz1w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 29 Aug 2021 12:23:21 +0200
Message-ID: <CAP8UFD2YgpjB4oMEE7X2G4f_hN4=-mKcwBEAXn=qpkXCCWjVWg@mail.gmail.com>
Subject: Re: Draft of Git Rev News edition 78
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        German Lashevich <german.lashevich@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 29, 2021 at 12:21 PM Christian Couder
<christian.couder@gmail.com> wrote:

> Jakub, Markus, Kaartic and I plan to publish this edition on Saturday July 31st.

Actually on Thursday August 31st. Sorry.
