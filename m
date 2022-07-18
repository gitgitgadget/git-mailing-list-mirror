Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7FBC43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 16:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiGRQrN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRQrM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 12:47:12 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E8724BDC
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 72so11123152pge.0
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 09:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bst8E8h+dF8iMucpBvTZiCuHwRVw+FPUE4OQZ4F98mQ=;
        b=N8PA3+fs0UlJxxn+LfJfQkG7ebKZoJlAcUAu22vDBSZZF5wwRzRI3Qx3/i/Tuct7j6
         i8VD9cnjOqj+SR5qQ3MaKhAIBLUbT6qUPeandNSIDUyFzXPzUCiRXvpg1XptGFiNN/1B
         8x1vdCOPfXb6GYyL668T8f9FX9lWKGooPra1i1/m6CVZMMVVssmnxkdODfTYWh2NYLWJ
         4h5xmnxBFP5/88ZBL0tOW2yHZcMsUD1T4vG0q8V/9QUapFBd1OkPKJ8fmOlgEpncNFkv
         qVtb93642nwK8CV4FLEeHtNQlrmizr+MDKw6zFf0a8boQAqw+b3qx07HK+Y3M67+MzkM
         bihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bst8E8h+dF8iMucpBvTZiCuHwRVw+FPUE4OQZ4F98mQ=;
        b=zgs6an5VrY3kKr5JfH9JO4PADFs7v+98bl8QT4mA9MMGECJU2kGbNqWa7mqUhtAsIp
         dahiQC7OobImQf+KM+oyXuhTd7AcE/qIbOBERdmw9YSrYP48jm1y11MGyj/XIGMzBC9s
         +g5f74V9FA4m0dfU3L6jKKVo0hPP9VEPb+xfC4Dqkllhh7ZBB7mZCvu4mHFmrl+2RXD7
         bevRYGc5Er2+SFr55edZ3A4IkYx1X+btC8WAP4gBPSD6GZWmqL/uvy1iLsIABBuF77bW
         ybUPVu1gK5PF9dPgwWjFWvMDZ0JvY4VMKOo/SXW0U3/NRW1Bwlif2efPW1DDMbCkBFVy
         MhHA==
X-Gm-Message-State: AJIora+bvBPW9oHd7JJCYNi5S0zQxboeZ9mM2JhHEBrQMT+kLYpseSZF
        BPOlvF2uUpHs9hIHBwqfuOs=
X-Google-Smtp-Source: AGRyM1s+SGqyKMIzJEhiWNcpgUogGLCcPcSzYLmhDcZ/LPIlbQb3IXdqLLghN0FmZ3ZYMUDCGjE3wQ==
X-Received: by 2002:aa7:8887:0:b0:52b:17e8:fc7 with SMTP id z7-20020aa78887000000b0052b17e80fc7mr25359124pfe.35.1658162831019;
        Mon, 18 Jul 2022 09:47:11 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.36])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm9671074pfd.90.2022.07.18.09.46.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jul 2022 09:47:04 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v7 3/7] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Tue, 19 Jul 2022 00:46:02 +0800
Message-Id: <263f45ba96c322665f102e22e1899c93541d87c4.1658159746.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "open_pack_bitmap_1()" and "open_midx_bitmap_1()" we use
a var named "idx_name" to represent the bitmap filename which
is computed by "midx_bitmap_filename()" or "pack_bitmap_filename()"
before we open it.

There may bring some confusion in this "idx_name" naming, which
might lead us to think of ".idx "or" multi-pack-index" files,
although bitmap is essentially can be understood as a kind of index,
let's define this name a little more accurate here.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index c970ab46dd..7d8cc063fc 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -314,10 +314,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 			      struct multi_pack_index *midx)
 {
 	struct stat st;
-	char *idx_name = midx_bitmap_filename(midx);
-	int fd = git_open(idx_name);
+	char *bitmap_name = midx_bitmap_filename(midx);
+	int fd = git_open(bitmap_name);
 
-	free(idx_name);
+	free(bitmap_name);
 
 	if (fd < 0)
 		return -1;
@@ -369,14 +369,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 {
 	int fd;
 	struct stat st;
-	char *idx_name;
+	char *bitmap_name;
 
 	if (open_pack_index(packfile))
 		return -1;
 
-	idx_name = pack_bitmap_filename(packfile);
-	fd = git_open(idx_name);
-	free(idx_name);
+	bitmap_name = pack_bitmap_filename(packfile);
+	fd = git_open(bitmap_name);
+	free(bitmap_name);
 
 	if (fd < 0)
 		return -1;
-- 
2.35.0.rc0.679.gc613175da2

