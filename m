Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3523C433DF
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B10A2225F
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 22:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmhZD6Ci"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgJSWZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 18:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729270AbgJSWZb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 18:25:31 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EF2C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:25:31 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m11so1329242otk.13
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 15:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cnxc6NqSf6GVAlQ6WyUuWAI2mw6SC5tiPSmrZKdUgWU=;
        b=dmhZD6CiiDgto/c7+qNYbfxPnFogK6yjSVDYnGnBkAOcuL4Lx00HRBCAykwJq9HggG
         0dm+0JGtcRAHjZovRzVPTIspK1h7ZCmie9qrnvfvK3VpGiV/8+rWq9yVs/vLPiV9omqS
         z+MksO84T50anYQf46HibUPP1HWep5Nqpt/2jq5umHYZQPI71JM7oFd/JfH5rI2lrfuD
         6o6mDfZrBZrZZExBC7aCdBLcaRZgKwKfZBJ5GJy9u3RTaCy+pV6i+sEphrinxA63QVuN
         I30UscE6e2KWkNHS9+2wHVpZEyNj2S4602ytl2GAhzB0/7SQHvhcxDgfQgQWqfMRNKXD
         4LFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cnxc6NqSf6GVAlQ6WyUuWAI2mw6SC5tiPSmrZKdUgWU=;
        b=QaKGxq94ymn5ZiliU2HuwAqZ690K6L4Q8MLZlr7K38LIVqHKtzVs9gpdXqVHp7u16D
         z4zEA/v/IfE5XmgRjsU3W5Xziq+7PT7yPvwYNxRwU4VyH6/5Xck35mvnEBffXbPEuMRm
         KgGZus9FLSwOGe2WwCAe5mvGu88IRuAJpv/E5gcWxNykQOcOrnlvIK+3/qabucqojR2J
         S5KiSAtAWBMl2crt7sXXciozVHdh3LKV7Frfo1bPxMzgl2CyEPJHqMuXmISChwwhxwjE
         zr6YlwAfiXudhkECNhtCksUu4OYX2pftaMwrNef6JfsFeZq1blJZS+P1jWJ5k+2gdPro
         SEWg==
X-Gm-Message-State: AOAM5335xome9ZVUy/X4W+iw79CIzxHr4qLvSWxjSxxz3OuHfqBPoZYf
        FD7Od1oAYAGCJPmq9Lzm/zewdaBwJAWJMLqdQQE=
X-Google-Smtp-Source: ABdhPJzPynb8UVMfSm/IESfsbcX8g4FOY2y9xhayvghpTJUaP/z0dypSQFqNVfPK8wE9bSG7R1AtgwPkqjBR92uLx/I=
X-Received: by 2002:a05:6830:2092:: with SMTP id y18mr1529702otq.19.1603146330568;
 Mon, 19 Oct 2020 15:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.756.git.1602968677.gitgitgadget@gmail.com>
 <pull.756.v2.git.1603143316.gitgitgadget@gmail.com> <f572e226bb5e4b67cc57f8d9d4732086f01190a2.1603143316.git.gitgitgadget@gmail.com>
 <20201019215438.GA49623@nand.local>
In-Reply-To: <20201019215438.GA49623@nand.local>
From:   Nipunn Koorapati <nipunn1313@gmail.com>
Date:   Mon, 19 Oct 2020 23:25:19 +0100
Message-ID: <CAN8Z4-VVx70ZDk8_pDH7cjoOZwVTCefEP1QCYCYpqRYhAn9SXQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] t/perf: add fsmonitor perf test for git diff
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Nipunn Koorapati via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Utsav Shah <utsav@dropbox.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> This reminds me; did you look at the 'git add' performance change? I
> recall Junio mentioning that 'git add' takes the same paths in the code.

I did look into it and didn't see a big perf change - and didn't dig into why.
I'll leave a perf test in the next roll of this patch series so you can see the
numbers.

--Nipunn
