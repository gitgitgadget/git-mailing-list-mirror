Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE72FC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5734364ED6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhBBDxE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhBBDw4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:52:56 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44395C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:52:16 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id h192so21376020oib.1
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=V7HwSitKbbE7/msQr2KRN2dtRQ8CyDQsogBtTnulVgY=;
        b=Cvi6Z+tDwIxCQmr4oIF0XBhK7PhfnQNLpBxdusW7/t4C74geZXk4P+gav8Eg0FXSw8
         RJE0bRny7nQ5cFOFNsOF/3vBv4RLVL82L0de1ZPDihGhQNl0UD+ISu/y4b08ZzR0Ghqr
         B9X4Ol250hk3CAPYXsozTOxsZS8Oe7fMcCUk15iUa7TP3klZ5fZKmqiXyx5S3VhOv/9p
         gHwUW09C71kEzffoCxbqlfufH2+ee5T6gR9QFZJ/6yasSmqbAE7zHYBWFqDrq5nkPhbj
         O2eonMPb4yToFtgWwLkqUqj0NNoe2gNC7JpnaDHpikyUxkZBXmvyN9YM1RnLtDtS4u0P
         UdvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=V7HwSitKbbE7/msQr2KRN2dtRQ8CyDQsogBtTnulVgY=;
        b=eQ6Cu5FeZdFCZ4kSBsAC0GwY3Br1aOrD3sidcCBNnYzRaE2ahxbySemFL3p7FACU6/
         TxmA9kNdTIPaVAhumceRSQ1sdyNUhFAuUkPSIoYCOyP7D8MsY0YT4TGez8vmt96OwBkr
         bgLjIQ6rBBtdvN+Slxi6ObnFGiLKhprHIltJ7vO0TqUqHDNOOzyZBRe5+1Rt4maGz4F5
         DPUlP9VTQRi2z2fMeUfLAujDZhn7D/BZpe0GDMTWpPkxkhUkvwWxOOEVNtpWkbd6RgMQ
         qgfIJwnXJhQ42Qx1iBcTxclNCtiWbfYGP8cej6T77jT1UZeM3bO2wbv8kkaQ61/YuDCw
         xCfg==
X-Gm-Message-State: AOAM530PZkqwLWWttoQSy1dWkzJiks7EhZAmRyeNmlOAkmbsAJ4Zb2BC
        EnU/AWovj8DmX38Wg8TW4iNb9+68zDGeTzq7eFlUlRlmEOf/Dw==
X-Google-Smtp-Source: ABdhPJwzSFsnJbKLclk7SPUxOFgemLLECOJBTpbrVxcvZWyMj2DlL2IOfcj5kDK6JNJffPYd0Oe/rI0LqDOYVVlt/ns=
X-Received: by 2002:a54:4790:: with SMTP id o16mr1388298oic.39.1612237935318;
 Mon, 01 Feb 2021 19:52:15 -0800 (PST)
MIME-Version: 1.0
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 19:52:04 -0800
Message-ID: <CABPp-BHvk5RLq3OOYhcQZJ_9w6hbQUVurJiRrks8kcGq5-rn0g@mail.gmail.com>
Subject: RFC -- making a plan for remainder of merge-ort
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

There will be ~11 more series (with about ~6-7 patches per series)
before merge-ort is complete.  Now that gitster/en/merge-ort-perf has
merged to next, I can start submitting the next series.  Some
questions before I do so, though:

* What's the right rate to submit them to not overwhelm reviewers? One
per week?  I didn't get much feedback on this for the past series.
[One per week, assuming the git-2.32 cycle is 3 months long, would
mean finishing in about 3 months, i.e. just a few weeks before
git-2.32-rc0.]

* My focus for the next few series is on diffcore-rename.c, which will
also affect things other than merge-ort.  While each series is
self-contained, given that 2.31-rc0 is just over 3 weeks away I'm
wondering if it makes sense to hold my future diffcore-rename series
out of 2.31 and start merging them in the 2.32 cycle.  Thoughts?


Thanks,
Elijah
