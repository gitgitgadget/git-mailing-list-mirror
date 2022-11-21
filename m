Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF58C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 12:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiKUMQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiKUMQj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 07:16:39 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB82606AA
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w3-20020a17090a460300b00218524e8877so11928560pjg.1
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 04:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BuA69/HRvMKAi5QsqtJadbrEkBskc2HlGl9tcR/ytU=;
        b=d8mSCvZW6K/lzs9Y2nDwQNgH6h/zBaYJUe/l1sKH0HiMOn7CP1/Ix6Q3y5F49KRLxz
         ET05NusojU7seT1Mi+uptud1Aqvtbf8SU0AaceRsbQ5hO29e+5DH49Ahd/a64wIDc+ho
         E7s7C7NAlHeRGxPJ/kq5Z0279r9UaHZkxM1vlp9FjAhSWhEuShoZZUzeZPjBiOSIs0RK
         VguuLy6hAHKkhrKiZA/+iOUw0X6T4Sc84pnIOd9t5Xhuqr6uMP332S4Qodx+F54d7eOC
         MXNDTenw7RzH+JQld+SNa1fKoGJ5US8sUAGfaCmTrOBq7o/o3FLRq9dCrXP35kJlexIc
         DRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BuA69/HRvMKAi5QsqtJadbrEkBskc2HlGl9tcR/ytU=;
        b=xjeW6k/RfmF+y5WSIN/gXMtnGxf1Xx5EfWqkLJZLcIFDbZZTHBNiiaoBdISVi2g/3Z
         WNUPKmWWTD4t6MEOMnZ7sBGf0DKHzbfhibH1m0AEsP71bxgOPIs7YSh/w4wEuBNmxTmg
         WdWp8rR+a7MACboHOzvDGOtnaqDQRn9TbtOtdVFk+2uIbztadcaHIOREGmFyvcjj9J2q
         KXZ9raHxmPT40S//XBmLE/zabZQylz82PjGV7gXQbtP96TWsxaLRmO7mDE+xctlr9hMf
         KTioEBRUgbzsa+0blrp3tM21yZY3N4o6lBCRyGicJlLL0yZ5tmxrNhDOLa3rkx1SgLPc
         vGmA==
X-Gm-Message-State: ANoB5pnYT5RJkzuGpUhPwzqjz3qPZr/e0XoU7fdGZiyF/sUI/bffy/Bb
        44YA034PGNJeF5bt2xZw4rs=
X-Google-Smtp-Source: AA0mqf5Td/DFjBBKKqPGiN6oA8Gp/4ZbHy0Bp/vu6DmfSnDXtEgBRAXmAF3nuN76/X6EtltHx3z55A==
X-Received: by 2002:a17:902:aa07:b0:186:a97d:6bcc with SMTP id be7-20020a170902aa0700b00186a97d6bccmr11674096plb.121.1669032997175;
        Mon, 21 Nov 2022 04:16:37 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b00176b63535adsm9630098plh.260.2022.11.21.04.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:16:36 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v4 4/4] pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
Date:   Mon, 21 Nov 2022 20:16:15 +0800
Message-Id: <2acaa3f097e0ab08a63ae1719454f5e11bb15a44.1669032426.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <cover.1669032425.git.dyroneteng@gmail.com>
References: <cover.1669032425.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

We retained pack bitmaps as a quick recovery mechanism while
test-deploying midx bitmaps. This is an internal mechanism, and we
want to expose this rule externally through trace2 so that end users,
repo-maintainers, and debuggers know what is happening in the process.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3b6c2f804a..44a80ed8f2 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -524,8 +524,6 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	assert(!bitmap_git->map);
-
 	for (p = get_all_packs(r); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
@@ -559,11 +557,20 @@ static int open_midx_bitmap(struct repository *r,
 static int open_bitmap(struct repository *r,
 		       struct bitmap_index *bitmap_git)
 {
+	int found = 0;
+
 	assert(!bitmap_git->map);
 
-	if (!open_midx_bitmap(r, bitmap_git))
-		return 0;
-	return open_pack_bitmap(r, bitmap_git);
+	found = !open_midx_bitmap(r, bitmap_git);
+
+	/*
+	 * these will all be skipped if we opened a midx bitmap; but run it
+	 * anyway if tracing is enabled to report the duplicates
+	 */
+	if (!found || trace2_is_enabled())
+		found |= !open_pack_bitmap(r, bitmap_git);
+
+	return found ? 0 : -1;
 }
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r)
-- 
2.38.1.383.g9d5a491887b

