Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2C1C433DF
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3364E20715
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Uc7pnX60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHYSLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgHYSLw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:11:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF3AC061574
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:11:51 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id e30so9254396pfj.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=7LGCNwlBbnCA1Dhw33QbXPohKlpEJofosX63hh9QE+E=;
        b=Uc7pnX60I7W1IhLsdXykjGtYLoDMOHfe8Ba1ssqQTzylg1K91hLBqJSXUDES8R2jF+
         YveCULPthKwQ3waDxN9C/MEL3QaCBIxg55dp4d5acFq5kIvVcLvZm68MpRvxILsh/aMz
         KUGeux0oRReuBxVtIEUL5t7tg5AfjCUh0dhIuviIMi6qrIrVxQVtRnxYjNFEPT5sSZ4K
         jA5heLa6CSlY4YOmos9H7RCitvCs1H43g7sKgi00YKepsOxUjNSiBXYev/4VKT1sSHzY
         KHGHGxLRWo2Mw1USRRtHOuPPxG1cLeCVINz4HeZdlDvpylAKTLlUXOzIuA8vruHTqjPu
         0uGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7LGCNwlBbnCA1Dhw33QbXPohKlpEJofosX63hh9QE+E=;
        b=rwu7tR9rlzJZ7eKqxc+AMQ+EHH2k58YNl70DsIj0Zb/BML5sKm25WWD+a9/eqy0Am1
         9MMPM1gbTt+8dS9Hk64eG3ZdvTH59bxkJJFHcEzB/VKOiUt2m+C1GdHgg/7Gu4PPNcQV
         tZU/hnsUjBF8mXzYCu9G/Z3BXO1wn5Km4wkYs6YzsRdnbdy/C4DXyLtyNpyGpvt4wFtl
         +eMY1eaSzFoCeBRe3AVhFpCEQqOCF6Yhqgyvfh4cxkUR9vpz4QZ+OmR30lb/JWTwlXb/
         xM2+uL4W87GtblEY88gCBWHI3qs1SUYeWsgmyZxERSQlVDVnXHVdjZuzo9kH7LIm3nuM
         RVPg==
X-Gm-Message-State: AOAM533/yG/nNR+oPmv2lDO/do1BwSEdxYNLVif9O3Jr2wezpEE8Nphx
        Ajqo1T3TIQSTo1MLyP1Rv6fe2Z4dNkRQFi8xxnFE
X-Google-Smtp-Source: ABdhPJxd5krpl6clFgoRV0Rk30jpKIaTWbSapJTZx7Wav8XclbLHDjiKlcGqfH/FlcDcNJ+oMgHdrcoadKLU5cradGMn
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:18d])
 (user=jonathantanmy job=sendgmr) by 2002:aa7:9ac2:: with SMTP id
 x2mr8758011pfp.57.1598379111371; Tue, 25 Aug 2020 11:11:51 -0700 (PDT)
Date:   Tue, 25 Aug 2020 11:11:45 -0700
In-Reply-To: <20200824220829.GA802799@coredump.intra.peff.net>
Message-Id: <20200825181145.1091378-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200824220829.GA802799@coredump.intra.peff.net>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: Re: [PATCH 0/7] Better threaded delta resolution in index-pack
 (another try)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     jonathantanmy@google.com, git@vger.kernel.org, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The overall time seems to get slightly worse, though (HEAD~7 is before
> your patch, HEAD is with it):
> 
>   Test                                           HEAD~7               HEAD                    
>   --------------------------------------------------------------------------------------------
>   5302.9: index-pack default number of threads   71.96(376.11+3.66)   74.18(390.62+6.08) +3.1%
> 
> There may be other cases that get better, though. A 3% increase here is
> probably OK if we get something for it. But if our primary goal here is
> increasing multithread efficiency, then we should be able to show some
> benchmark that improves. :)

Ah...good question. Cloning from
https://fuchsia.googlesource.com/third_party/vulkan-cts (mentioned in
patch 7), cd-ing to the pack dir, and running:

  git index-pack --stdin -o foo <*.pack

I got 8m2.878s with my patches and 12m6.365s without. But I ran this on
a cloud virtual machine (what I have access to right now) so the numbers
might look different on a dedicated machine.
