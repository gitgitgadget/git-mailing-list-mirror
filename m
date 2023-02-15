Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D85C636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 09:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjBOJUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 04:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjBOJUI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 04:20:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451A7A9F
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 01:20:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id e17so10792502plg.12
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 01:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09+zVySE65qy+wqfstTAxf51lBtz+vARHutbbOw7Zsc=;
        b=PNp0tAiUAYNTQhXq/DYR9vx9jKKlsAVgaRztkHEG7QgFwDkKyFYdAYPPZLDzij0+Rr
         mIXuNEBBSDIf4ZeV84BuAmV/pg93vj+VU6BuwYcB4OaDloyfeHBKNArRaOsApZlJsxe4
         yy/cQRjf/2HQAJ/a5Dindr5jdTBZto8jPo7H1LwGklU8YeJT6XyBkXS88poFmNbiZczW
         FNraG84QtujouyJglr3jtwQUS1ZrDUlPLIUhIXQptiqQW/5kNBo63KCVCVTeVJ36hwxR
         SY+ze9FTVc78bfkvMjWb1gVyqe3kLwcz73QVZACSU8ANxLqccCabspOc23eo1tGtsMnc
         dqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=09+zVySE65qy+wqfstTAxf51lBtz+vARHutbbOw7Zsc=;
        b=k7hMfMkw53ByQI/wEhibU6yH/KfMnEv8Bv5EXav8NYhMhVcmGI1lWe77w7UgptNlC5
         g57Z4kbvMD2mm2+/FrTpz2cy7V7SeS1VcEEE9+FP9Fl3jLypLIJGrnkz8g40y3SxCn7Q
         eXvLsy/U43Zhq7tIZd1lzzVtRRKgwC/FTGOGaplvObhMqlOThmgd2WOx4c/DwekkeTZz
         FaOL8wq+aD7sgCbuoAnFHpLQfJV78D6+dl1IqnEcEBpY4qIf+K6Wp0Z4iZkQjQc2QA9o
         oS1GbJnQJQRpWFJI0+1h5MrlESxwXnghPUxyQb+iU7233m7m+JIsBucNKxRWw9LNpYPD
         zc5A==
X-Gm-Message-State: AO0yUKU5fwZOjaXF3YMulQ5ArHNwPIKdWuojq67Tewz/z+fdTuCx6QR+
        9vm5ITkpo/SIR4bj0YC3lKo=
X-Google-Smtp-Source: AK7set8dSlZ7HR94L9reBCpUAmd4T1AM40gxzVbR/vFKtRNIuoyLLiGbD5ekghPcPSqr7gqMFxudEw==
X-Received: by 2002:a17:902:db0b:b0:19a:8636:9e2c with SMTP id m11-20020a170902db0b00b0019a86369e2cmr2103140plx.57.1676452806591;
        Wed, 15 Feb 2023 01:20:06 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6805:205a:4159:d923:bb7e:2173])
        by smtp.gmail.com with ESMTPSA id w14-20020a170902d70e00b0019956488546sm5057165ply.277.2023.02.15.01.20.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Feb 2023 01:20:06 -0800 (PST)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     vinayakdev.sci@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
Subject: [GSoC][PATCH v3] apply: Change #define to enum and variable types from int to enum
Date:   Wed, 15 Feb 2023 14:49:50 +0530
Message-Id: <20230215091950.2976-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: vinayakdsci <vinayakdev.sci@gmail.com>

Change #define constants to enum and variable types from int to enum
in apply.c

Enum constants have an advantage over #define macro constants in that
modern debuggers are able to report them symbolically instead of just
as simple numbers. This makes debugging and catching undercover errors
easier, and can many a times save quite some time and inconvenience.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>

---
 apply.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/apply.c b/apply.c
index 5cc5479c9c..b2a03d9fc3 100644
--- a/apply.c
+++ b/apply.c
@@ -205,8 +205,10 @@ struct fragment {
  * or deflated "literal".
  */
 #define binary_patch_method leading
-#define BINARY_DELTA_DEFLATED	1
-#define BINARY_LITERAL_DEFLATED 2
+enum binary_type_deflated {
+	BINARY_DELTA_DEFLATED = 1,
+	BINARY_LITERAL_DEFLATED
+};
 
 static void free_fragment_list(struct fragment *list)
 {
@@ -918,14 +920,17 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
  * their names against any previous information, just
  * to make sure..
  */
-#define DIFF_OLD_NAME 0
-#define DIFF_NEW_NAME 1
+
+enum diff_name {
+	DIFF_OLD_NAME = 0,
+	DIFF_NEW_NAME
+};
 
 static int gitdiff_verify_name(struct gitdiff_data *state,
 			       const char *line,
 			       int isnull,
 			       char **name,
-			       int side)
+			       enum diff_name side)
 {
 	if (!*name && !isnull) {
 		*name = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
@@ -1910,7 +1915,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
 	int llen, used;
 	unsigned long size = *sz_p;
 	char *buffer = *buf_p;
-	int patch_method;
+	enum binary_type_deflated patch_method;
 	unsigned long origlen;
 	char *data = NULL;
 	int hunk_size = 0;

base-commit: b1485644f936ee83a995ec24d23f713f4230a1ae
-- 
2.39.1

