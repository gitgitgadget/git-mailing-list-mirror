Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B20C433EF
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 12:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiGKMpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 08:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiGKMoe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 08:44:34 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F74965544
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d10so4655396pfd.9
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 05:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mA4mfPf/cGs+eJTK2hCSg24spGNe4RXDPVvAx79OZUs=;
        b=WlRJPKvm5977SR6zX+ofKdjLJens0Vpo2iWmMsirDdgwyWhnzTYRiQG4Vbp6ByARWC
         m4JUY5ENcL/5l/fS0BEApmNolRinPY+iFkTnfABzUFo3kjAWynQQcOUmbCU0aZDt7vsx
         wC93cJvxlx3bta+l4NkW7TKhjGTo9efRjAfbWNCJUGr3kddw8vo6ZlWSaEZQC1cjvVKq
         BKuLpm8rG0le1iGIIGyTaGwd9GneIQ6yqw9fPwEYHrW8p75qUBcFpRhrQs9RQKajgHzf
         Wis/RWsh9jTEYIyUgDYSR0EVNgTTWzy9XFB9YuDMXjXdX99NpSx/uI7neHHJKzQqFiLp
         Ityw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mA4mfPf/cGs+eJTK2hCSg24spGNe4RXDPVvAx79OZUs=;
        b=feI12D1pIfEYHjOmKuZPo9T3LMNorOzoLZsVQ3wSIbUEy0Ae8QeMDA+v4px/4UgFel
         IPfWc/84EFoM6pnB7H2afOJ6aKo+rmD+rmz3Vhd7xYJYZPUMKbmx564pqTp8NLGziBU/
         7GhK6x69Xt54Z/9YvZ7uD4MxdMLMSdqLXAXlLF0VnJdT19Hs7zlcpBE6/odZZ3Dcu/od
         iYZmHVp8Jj9RDnKwf8Pn57wEzTJNV02nZgOIkJ0Y/p7x98o4LuS7xuj7xlWLf3aQQbcF
         bSQV8sohiGZTHmpc4oTxJyAzw/4d2OpPY80SFKVYCjNqce0wry3ZDQ9nkvGfgwd8ma4I
         FIxg==
X-Gm-Message-State: AJIora8h9BglngkG5kUd43GTrqqlQ4k2ekjHhRUVBKoOZ8dkJve2VH/W
        AtMOtICGSHGlv46K/tag9Lk=
X-Google-Smtp-Source: AGRyM1tIg0mDhZjKEQXubhG1hELVjpU4jKBRQUTHwB86E1Of755Xc/sHODKncWhy4fPY2YLFOkaEOw==
X-Received: by 2002:a05:6a00:1a86:b0:52a:d419:9552 with SMTP id e6-20020a056a001a8600b0052ad4199552mr4101373pfv.70.1657543465160;
        Mon, 11 Jul 2022 05:44:25 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id d22-20020a17090a02d600b001ef95232570sm6866084pjd.52.2022.07.11.05.44.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jul 2022 05:44:24 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v6 3/7] pack-bitmap.c: rename "idx_name" to "bitmap_name"
Date:   Mon, 11 Jul 2022 20:43:59 +0800
Message-Id: <d8a2235cb01a01f7f815db4055cf1aa3c0818cc9.1657540174.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.676.g60105b7097.dirty
In-Reply-To: <cover.1657540174.git.dyroneteng@gmail.com>
References: <cover.1657540174.git.dyroneteng@gmail.com>
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
2.35.0.rc0.676.g60105b7097.dirty

