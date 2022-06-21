Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251B8CCA473
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351839AbiFUNeM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232707AbiFUNbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:01 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1191B2AC5F
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r66so7166967pgr.2
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTlS4nWfJ7TvnT8HtkO8kEvpLCRI9A5BzB8pCWJc7p4=;
        b=NABb7cyJmWZJiqpvUm59fc8LXiVqCV8WLN4NTSHBvI8PmAM/MZeiTL27bw5z2bdH/j
         ayjeT9qFMrT78ONIPpbrT3r/nJ83biH5pPvlrTxHixe02C/M6TdpmLNRed+7oYOB4YZE
         I2eJ70PNBH1rYbOZwdrR37ovQCyUplAdlQwZbO5uvGcVBPn7C8H0WcD7okfurdfk30Hr
         YKffXJoX8GnbAW8/n/t9m5yD2tziC2/xBCKoKaRz2MYmhOwX+OVMVjaiWvT0fA3Oa7N1
         UtnQB2ImF3hkhqkFcaHsutdaQC3NyImpQySstjhCSzM4NVfnRrkuEpGAf/DSL8TLXrPH
         Zy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTlS4nWfJ7TvnT8HtkO8kEvpLCRI9A5BzB8pCWJc7p4=;
        b=7pX8jeoHEUBixyGn54aZ/hXKeElHi+qnhyZokibQibU+nOnJae5c1GiIIRzIpGSKit
         69FKL+ZYVHaaPmY3t/X9ehoFA6MqQBDA+Fhzefm5z3POGQXd42xUUMzLkLFJTlAPHbf7
         xjx9MPkLpHiVqzwmZfZxyhXsO6bBMUeKZS9NxbAiP4Mg9Ow1TGJ0XHaO1o9kzUDAUD35
         TkSbfZEFUiRN719nHq6UO8BsxJrhp3ySPwHngGaN1w7PGH8t7dQbDi8QMX7yWFpIDH8v
         8kH+Rjmjj+Zv0/XYJp/OtAPjp07/XLCwkXG1SwZIK3fV/23XeiNZNuycnFoUITpZLMAk
         qWuw==
X-Gm-Message-State: AJIora8mnK6nc8+YYqa3p8d4Orz65P1yqdfHIXZg97RlryYUMrRZk3E0
        hXZl9ko0+2bp5YxQ8bApJdQ=
X-Google-Smtp-Source: AGRyM1uzYWQdHQ/lTTDO0TF2QLYTrqzWftJ0ZDKL0qFrxS7e+1jE98MyrL48+6FRthBNnfV74h8pKA==
X-Received: by 2002:a63:2a4e:0:b0:40c:6ff9:9978 with SMTP id q75-20020a632a4e000000b0040c6ff99978mr16614487pgq.447.1655817918566;
        Tue, 21 Jun 2022 06:25:18 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:18 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 2/5] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Tue, 21 Jun 2022 21:25:02 +0800
Message-Id: <b6b30047fc92933d254ee2034b946a10ac37bb31.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
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
2.35.1.582.g270d558070.dirty

