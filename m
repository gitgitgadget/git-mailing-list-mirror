Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4A71F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752255AbeBFAXX (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:23:23 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39964 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeBFAXV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:23:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id g2so167391pgn.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIyubd0yDkqBiPWsHUIlvXmA0g7PLmMU50ZfnKvmScw=;
        b=qWSkkM9fv2pjC2wQN9qpvWAm0F6XUAGXHe+2+nOMeMbgKQdhmd2kL/racj4WGwAqw+
         NSa5VF1D1G/Gu0m2Shs2twevD+o+1tHnrbz6pbaC3il3w9XzII0bXO96gsXTqT3bA0aV
         sUdTuSWoX/TfDV16A4WCgSOaOVjF1T7WTiIPSWvYc3ftdbTcGFvj5P5wO3kVynkvrOdq
         J4sYYWmRjucEUCSv9yjGMDSC58Ppd07HOllnAdAY0zn79JAtQ/jDj4OUfykEtVggh6He
         oZQ1CYB9sKhQaIJpRmT44ZgNctbPtBky3T6KDbB4PEsXACvvKW+JoljHrJ7U7XW3jf8/
         pagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIyubd0yDkqBiPWsHUIlvXmA0g7PLmMU50ZfnKvmScw=;
        b=fEhi1MKtq4XBN1EIyeOLsTaGdI4pKlbv/H4MDhbYjF8adO8+MJp6t0tHiZB0XQMCN2
         /3YBtp+hEpOOnVyE9n2mcYH5y6H+wzY6261mo1Xrha0khSeCMdQoOldqjIBfo6pD80NK
         CLOSVYAhHQ6bf26SeiyxMUMtdhPS3Z5nJCPUV35loTNSRS86MFAEPBhEp6gxdcGDGOHh
         dkxJPxA2fCZrTCfvcUb0pzr+QtZeoJCIDbVQg46p16i6WZdfGhSOljtOj0Wi9b3zM2i6
         FTGsGJ5KM+o5Kyt5QhsXpHwHGN19C1F5gb9a7Kg3TP2dDwvwz4WxRhZGHmZzZnRQA2r0
         rpAw==
X-Gm-Message-State: APf1xPD/KKdHyaeEQoNMgQs5Bda4w4HW3b2yO6fFe/m6N5q2gltfR5z4
        ZtiGS15TW4QuUWH/s7iME+U/DldvTW0=
X-Google-Smtp-Source: AH8x226ETipGP8RtXlUI+IaLAkBwfJau3L6WmpOiUsiX3Ylp38823LMXNDcIJWrc4dfGBKKRd4fk7g==
X-Received: by 10.99.179.77 with SMTP id x13mr432802pgt.135.1517876599536;
        Mon, 05 Feb 2018 16:23:19 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id b66sm19179812pfd.182.2018.02.05.16.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:23:18 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 134/194] alloc: add repository argument to alloc_report
Date:   Mon,  5 Feb 2018 16:16:49 -0800
Message-Id: <20180206001749.218943-36-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 alloc.c | 2 +-
 cache.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/alloc.c b/alloc.c
index f031ce422d..28b85b2214 100644
--- a/alloc.c
+++ b/alloc.c
@@ -105,7 +105,7 @@ static void report(const char *name, unsigned int count, size_t size)
 #define REPORT(name, type)	\
     report(#name, name##_state.count, name##_state.count * sizeof(type) >> 10)
 
-void alloc_report(void)
+void alloc_report_the_repository(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
diff --git a/cache.h b/cache.h
index e0916d1a73..5c9807fa8f 100644
--- a/cache.h
+++ b/cache.h
@@ -1585,7 +1585,8 @@ extern void *alloc_commit_node_the_repository(void);
 extern void *alloc_tag_node_the_repository(void);
 #define alloc_object_node(r) alloc_object_node_##r()
 extern void *alloc_object_node_the_repository(void);
-extern void alloc_report(void);
+#define alloc_report(r) alloc_report_##r()
+extern void alloc_report_the_repository(void);
 extern unsigned int alloc_commit_index(void);
 
 /* pkt-line.c */
-- 
2.15.1.433.g936d1b9894.dirty

