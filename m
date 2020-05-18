Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC5DC433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B652081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 10:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dtucker-net.20150623.gappssmtp.com header.i=@dtucker-net.20150623.gappssmtp.com header.b="ODcVLzcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgERKEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgERKEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 06:04:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D437C061A0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:16 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id n11so4578770pgl.9
        for <git@vger.kernel.org>; Mon, 18 May 2020 03:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dtucker-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6TrMpi371lGQtdTKRmHEfosyMBpd+gtetYujo3m36oA=;
        b=ODcVLzcdQsUeYdo96ZB0N14TUdIC5GYLjppqJ7x7n7Vgq8HaAE4ROc0CAkPbOLlSnz
         B9fmXYRn4CXNIuMz5irIK47b3t8jKbGr+8cxEB8l1MWpyLfVGkbj4adgz3T39teZRR+u
         aCTuY0zL+xEySglZYe1mehaZqTrFQf6AsyQmA7orDEQZc19BqdbF4Gffa9ZGn49VwbnO
         rdIr0O7xQb5pER22L9V8HiOrOhGcwfJGncWgauIZbzTxAg+EvOaw2cFoSkjf2vtUBjlF
         CrVp7k+nZSxg2JlDDRyKm/lUdZLdfZh4jePTruqW5ef4ukADgqfrdBwvLqMANtufpSJA
         IxbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6TrMpi371lGQtdTKRmHEfosyMBpd+gtetYujo3m36oA=;
        b=aTBIqW4b6tvGpfCKBkP/kYp8QNLjiIjV+st4xS4P5EH1r+a5ITfL2REa6//+lRapfx
         JI8w+QxMkwMoYG3VzS0j1CNcLjUgNP4lCdrpyDowcSVWWkvhRUSHgAQSZNDAccGt4zSC
         vED2Z49vu0t6uEiX+zlUafLNFT0ZrtrGDCE64PIuxPkkXCGhgzpmT+GNOEiCcRnXTShh
         8mvZRy/fv8pbs51ArqAKF04QA8uxLt1n5aVMS3Sf5Bf2/yFbv7u3DpSZY9r13/Tmw4An
         i4sniHydWohqqx/d7uthy1btLLyU7Tqz69TB6jHA5iVW58mFcOcDiFWgvzOy537/eMqN
         3gvg==
X-Gm-Message-State: AOAM532n3akSgev1xj8adBsnrLego4ga9iq+kAJvBkeJQkxxN6am7YDj
        hGubLgCy0grvKyt2NbBDcaJVH2I6BpqoRhzZ3CwyPVwvos6TSaHaDz6UnmnUoutazIxzmmGAW7L
        zR9ZWab2cltvsn6tFtpzQvGC8dt5rfV2wO6/w3I8dCa/bScYS8w1egNq2jturHFo=
X-Google-Smtp-Source: ABdhPJx7+yARI0plUxReFvR53lqMM7/U5ttqgUSpHMnEuzKOrtbBtD20x0fLnvPpJb3facQu7s16/Q==
X-Received: by 2002:a63:555c:: with SMTP id f28mr14609704pgm.80.1589796255224;
        Mon, 18 May 2020 03:04:15 -0700 (PDT)
Received: from fw.dtucker.net (ppp59-167-129-32.static.internode.on.net. [59.167.129.32])
        by smtp.gmail.com with ESMTPSA id k7sm7467966pga.87.2020.05.18.03.04.13
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 May 2020 03:04:14 -0700 (PDT)
Received: from gate.dtucker.net (2001-44b8-3110-fb01-0000-0000-0000-0001.static.ipv6.internode.on.net [2001:44b8:3110:fb01::1])
        by fw.dtucker.net (OpenSMTPD) with ESMTP id 9981a7d5
        for <git@vger.kernel.org>;
        Mon, 18 May 2020 20:04:02 +1000 (AEST)
Received: from gate.dtucker.net (localhost.localdomain [127.0.0.1])
        by gate.dtucker.net (8.15.2/8.15.2) with ESMTP id 04IA41CI029499;
        Mon, 18 May 2020 20:04:01 +1000
Received: (from dtucker@localhost)
        by gate.dtucker.net (8.15.2/8.15.2/Submit) id 04IA41mO029493;
        Mon, 18 May 2020 20:04:01 +1000
From:   Darren Tucker <dtucker@dtucker.net>
To:     git@vger.kernel.org
Cc:     Darren Tucker <dtucker@dtucker.net>
Subject: [PATCH 7/7] Define SCNuMAX if not already defined.
Date:   Mon, 18 May 2020 20:03:56 +1000
Message-Id: <20200518100356.29292-7-dtucker@dtucker.net>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200518100356.29292-1-dtucker@dtucker.net>
References: <20200518100356.29292-1-dtucker@dtucker.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Darren Tucker <dtucker@dtucker.net>
---
 git-compat-util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index aa221eba1b..2bc468fbd0 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -342,6 +342,10 @@ typedef uintmax_t timestamp_t;
 #define TIME_MAX UINTMAX_MAX
 #define TIME_MIN 0
 
+#if !defined(SCNuMAX) && defined(SCNu64)
+#define SCNuMAX SCNu64
+#endif
+
 #ifndef PATH_SEP
 #define PATH_SEP ':'
 #endif
-- 
2.21.3

