Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4780DCCA479
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244198AbiF1ITq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbiF1ITE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 04:19:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069DD30B
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:03 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id n12so11394399pfq.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 01:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiUbMhmj1oXboZpE0eEjX6N9mwXCNkRKVw15kAdhNtc=;
        b=QKousY00B+iNq12ef3nmaySU2OZi5CI9EJXgJ0Y8AZheJbTThc/oXLLXuow/jbtIFc
         3Uv5LKLKoZUgojnnlhAK76XZIlOgLbRjSDkjVUN8GBSGhDkYKZJl1ji/o4NBVUSVRdV6
         1LbtLJ7aTUwrbSJJwAxulhTKHLyHj0FKgb7HWCDWG9OKuoqNWCCkvWA+dcZpCym6ml4V
         4aLKHUdBnfD3dcExK5e7faw9CyI+M2c93Ula/ta5uovSSVyTzTib0kH1UyH7v6d76tdO
         RDAnj2wjrG1rw1L4LUQKQrhtuFXmJmX9WVsFTsLKsOFnnZdXXGUjPBkbhM0WhbhoGHFf
         oApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiUbMhmj1oXboZpE0eEjX6N9mwXCNkRKVw15kAdhNtc=;
        b=2NZI92KuwR4aVI9ri4iujRlQuedW+87qDFg9PIm9k1hrqj/2Vq4AnNQbtFJxsxvQUv
         SmQzaLB6hRSS1Dc99WaNRYzHoUW57YJhOlLipLmt96IGLlVWRGsES7qgE1FY3+Y9A1Tv
         uhjjo28DIrYrasM+qu6gdIWNE+RchOfG2RHRIkNMYgLvO4D4K9HFqiBxAg0NIG7Jh5Iw
         nE6HZjO0d1gnhVhlpOF5FRN2GUliiBWjLdytze++50PIo4SWbko+83PnD3Ca0sTmyiA9
         U3X+kl2orZ/VJofwq5ePSQqGqgGRB7PjPumaod7tlIwajzQwI67y0N/rebRpUpVTrmrX
         H88g==
X-Gm-Message-State: AJIora8B0Up8yKQy33LrVmOBa3EJQNjG0pFpKA/zevztq9cWvkBENlPC
        W3PqjdQb6Jp5DBdiO2AhMJ4=
X-Google-Smtp-Source: AGRyM1uvUlBDTQ3+ODdPEk9zH0j1KeHW7i0aqx6d570fES/Kt4kCmMzrOVkYW49qvfcGX8YFxLcGJw==
X-Received: by 2002:a63:4b49:0:b0:40d:dd27:7490 with SMTP id k9-20020a634b49000000b0040ddd277490mr10698657pgl.80.1656404282522;
        Tue, 28 Jun 2022 01:18:02 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.34])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b0016368840c41sm8551206plb.14.2022.06.28.01.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Jun 2022 01:18:02 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com,
        git@jeffhostetler.com
Subject: [PATCH v5 2/5] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Tue, 28 Jun 2022 16:17:47 +0800
Message-Id: <b6b30047fc92933d254ee2034b946a10ac37bb31.1656403084.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.gf3b87a33da
In-Reply-To: <cover.1656403084.git.dyroneteng@gmail.com>
References: <cover.1656403084.git.dyroneteng@gmail.com>
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
index 112c2b12c6..f13a6bfe3a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -313,10 +313,10 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
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
@@ -368,14 +368,14 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
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
2.35.1.582.gf3b87a33da

