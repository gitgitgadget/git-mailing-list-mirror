Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8242FCCA47C
	for <git@archiver.kernel.org>; Sun, 12 Jun 2022 07:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234751AbiFLHou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jun 2022 03:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiFLHoj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jun 2022 03:44:39 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B13152509
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u18so2649789plb.3
        for <git@vger.kernel.org>; Sun, 12 Jun 2022 00:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K9rTOKkIQBE+XLOmnUsAosMKFDpiE88muaLSSg70h3w=;
        b=c6Ii/cK/YX1zcEvjb3dpIJir/AoQPkDCIvoAnpv38kLjn/8SbEql9B8U94kEq+jPxh
         zRtMc6Amh35VjQX3l8gooQ0gECR/f+bxmn4oUmnWtTQFxedXUs868mQdXuIgXotghOGB
         B/WdzHj8Fj4vvBc1UIz7YQEl85hTyu22IYjMO/A2tRB8V5v9nhctg/6FExGZxG6EKDLj
         /j/Pa3AroGMYVmy37iBIRIyDT4yY55QmD/0Y89cenENNj/oJJt3F+UZxUQvhMS/FFmOP
         ztHX4lrV8ABGb55y4i9DzfYLGDX3EF6qefWbgekBSDKg84711xxpQHjSxdrMy4s17OQZ
         3gDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K9rTOKkIQBE+XLOmnUsAosMKFDpiE88muaLSSg70h3w=;
        b=b1E6HCFupVqMmRR6NHw92QFcdYgIjK0drh/0J9D07frytGGy2eo9c7y6bxTyFWviQg
         6tAdwnk0pOjqF1pdkNw6J8pXSI93bvKvP/6kXh4IVKaqac4PGPDL/R2LdwgQP3tUgaPG
         fG7foebbIao1exWd8T0hBpklCaqjJbhwOa6N19htzn5Dz5D5Wo5sX0JU4KswBa8yBk3M
         NCnGGqpnHU0yRulhj3tBArYW02KzeGlnCShY1g89IopA02R2rUMo9W0sk/lBhEg7Xn21
         rizVxZ+6LljRcG4M60CSoi4E1AP2mm1rbCRrfdWjH8XpphZOhPm94AlxXH08ALcCUk8s
         Jqtw==
X-Gm-Message-State: AOAM531T8L7wvYzgu7uB4AiJR4wvzIW0QuGX/tM+MbqO3Nqy4+r7aH14
        dbz+w9hdrKHEfNkjPWIWxt0=
X-Google-Smtp-Source: ABdhPJxe8JZhZzNTfU8JPY7p7nP/RvTTWwhQCBc/Nn1x7cnNEtkyFEMjiLsMfEGaPazp81u/XRgyXQ==
X-Received: by 2002:a17:90b:4c0e:b0:1e8:859c:6b56 with SMTP id na14-20020a17090b4c0e00b001e8859c6b56mr8940544pjb.121.1655019875269;
        Sun, 12 Jun 2022 00:44:35 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.44])
        by smtp.gmail.com with ESMTPSA id w14-20020a1709029a8e00b001676f87473fsm2559707plp.302.2022.06.12.00.44.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jun 2022 00:44:34 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 2/5] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Sun, 12 Jun 2022 15:44:17 +0800
Message-Id: <b6b30047fc92933d254ee2034b946a10ac37bb31.1655018322.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g320e881567
In-Reply-To: <cover.1655018322.git.dyroneteng@gmail.com>
References: <cover.1655018322.git.dyroneteng@gmail.com>
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
2.35.1.582.g320e881567

