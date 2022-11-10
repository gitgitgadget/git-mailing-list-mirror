Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14C0C433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 07:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiKJHKb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiKJHKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 02:10:30 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA9331DD8
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 23:10:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so810731pli.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 23:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NP8zGE3/BUhMRMBp6KTIc2o34V68sTKPlXWyoHB1Rwc=;
        b=nC9Zx6hEg2yn6SQO1eRXeuIfPJUGxVy5X4zS8voJOOsTR4xhqfqeYv5uBhIrGDODk3
         jhpD8ll2NqbE3kZItZRBHHAQHy35bOVgErvkU+rtNACJxo05nY5Rln+TulSbx9XHnIlO
         FTF0fCAjT3ihKMypmpIGo2/fiBvSGh/aFgRsJzgIg8wWRwVKOKW1YFFI8YoHe0xAun1k
         FK/Wd4K61NTsudsRBJEYLeNAMZrQ6K4e00RrYvReI9lddP5/duuGgu7OQCsq3i9N0NdN
         slnKlClMzr5kndpigm8YvInZQGQ7aiVpzAlsA9CsmgT6PdiH7BrhZJWVUKZ0HWAHfcpp
         oHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NP8zGE3/BUhMRMBp6KTIc2o34V68sTKPlXWyoHB1Rwc=;
        b=kSgOWD8F4DC5oz9Fci3gsfoaJcP4UXS+oy0AnLNsyyyHCPxaG/e4Lh/OmYDusnOJtb
         mh7Gr0hD9wmMbXUOFg/R0Vk5a79J6IJMrK4knbt4q+zriSlkeJuGvVXP7Gjv4E2I4BgT
         3fujx+gqNNDwPjdVdIYYjmSpwHj/q+t1zZ1lgAqmegUSWwrKs28EWMBt4KHFjeshcqni
         86sxytxOzcpJSaeIpm4XGz8Mjra0rRL0kyl1GQj1xnaJvyrV9VLSkqNcrvQ0a4YMLAnl
         ZwfYIrYYDmvLSnZcDNsrK7vQ/MApkGWhK3PQuQWozctGNXnz6NtyTHFqdFtPopqiidp9
         H8kQ==
X-Gm-Message-State: ACrzQf2hvFav4sbn0nItRPnL28U676C+QEXWJcJMTEwGs1OE+UqGtyxL
        x7gyvksFELW4Cf39Z+2q88/vPSAp7Ejuv4VI
X-Google-Smtp-Source: AMsMyM5r278iSwticfwiVpCdpqIrp1c7qlQhK65ilzQGsS0YMqXEK04O5EnYWoccNefl8WguWhDWFg==
X-Received: by 2002:a17:90b:2803:b0:210:3b5e:62eb with SMTP id qb3-20020a17090b280300b002103b5e62ebmr82108541pjb.95.1668064227304;
        Wed, 09 Nov 2022 23:10:27 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.52])
        by smtp.gmail.com with ESMTPSA id u14-20020a170902e5ce00b0017f778d4543sm10517161plf.241.2022.11.09.23.10.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Nov 2022 23:10:26 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com, XingXin <moweng.xx@antgroup.com>
Subject: [PATCH v3 2/2] pack-bitmap.c: avoid exposing absolute paths
Date:   Thu, 10 Nov 2022 15:10:12 +0800
Message-Id: <9d5a491887b57bbcc30010aa7efb63e316c6d190.1668063122.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.38.1.383.g7ac9b859f31.dirty
In-Reply-To: <cover.1668063122.git.dyroneteng@gmail.com>
References: <cover.1668063122.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

In "open_midx_bitmap_1()" and "open_pack_bitmap_1()", when we find that
there are multiple bitmaps, we will only open the first one and then
leave warnings about the remaining pack information, the information
will contain the absolute path of the repository, for example in a
alternates usage scenario. So let's hide this kind of potentially
sensitive information in this commit.

Found-by: XingXin <moweng.xx@antgroup.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c           | 10 ++++++----
 t/t5310-pack-bitmaps.sh |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 982e286bac..aaa2d9a104 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -354,8 +354,8 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 	if (bitmap_git->pack || bitmap_git->midx) {
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), buf.buf);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra midx bitmap file", buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -429,8 +429,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 	}
 
 	if (bitmap_git->pack || bitmap_git->midx) {
-		/* ignore extra bitmap file; we can only handle one */
-		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
+		trace2_data_string("bitmap", the_repository,
+				   "ignoring extra bitmap file", packfile->pack_name);
 		close(fd);
 		return -1;
 	}
@@ -455,6 +455,8 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 		return -1;
 	}
 
+	trace2_data_string("bitmap", the_repository, "opened bitmap file",
+			   packfile->pack_name);
 	return 0;
 }
 
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 6d693eef82..7d8dee41b0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -428,8 +428,9 @@ test_bitmap_cases () {
 			test_line_count = 2 packs &&
 			test_line_count = 2 bitmaps &&
 
-			git rev-list --use-bitmap-index HEAD 2>err &&
-			grep "ignoring extra bitmap file" err
+			GIT_TRACE2_EVENT=$(pwd)/trace2.txt git rev-list --use-bitmap-index HEAD &&
+			grep "opened bitmap" trace2.txt &&
+			grep "ignoring extra bitmap" trace2.txt
 		)
 	'
 }
-- 
2.38.1.383.g7ac9b859f31.dirty

