Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629CEC19F2A
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 03:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbiHEDGA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 23:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbiHEDFy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 23:05:54 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964F02DFA
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 20:05:53 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id f11so1562134pgj.7
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X469WROovn5VaE3OAc+dJxHmhUoHwaMuvoqvRtRENb8=;
        b=erA8JynEGO9T8HH69HtekDdHVWstwNmpmlw1uHPEBXYwNO08QpIctl0/Zpfru4O0IX
         yF3c0Wbxfic/IW+nO0AKw9XECqXG8H3f+L3Oam57O9u8XOS5djcDRZwWXB36mki5yuLB
         7Rc4GJ469qorgqEQpTIAl8g5kpvzJqNhprMpaR0UtzgdinXlQJB05JftXp1fr52XujL4
         k2FTyISuQjVVqw5RAEmUefAg0rMFclPZ3Ry3AIi0A8FA/ZkSPsQAYj8JgULaRe3qyAL+
         rU3ItIBkkFQ9+R0IcawuTv5PJlDXcznVvy4NY16rMaOboWn+ifJUTMKRY1TPLmZWZv3V
         4vwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X469WROovn5VaE3OAc+dJxHmhUoHwaMuvoqvRtRENb8=;
        b=rZL/T0fCltHzOXA5wHWQuI7CNjYZEsipMEe01ttdnjPELF/7b9yUXJcZBVwJr/zK4b
         o99LpU48Ujlpw0vWORNUsuHmZTa2/kMRRPr1HhQDUOK9eEEtYvft48wZN0Lw5fP4EE8Z
         upgq2tXcwZtNx9/Xyje+0SdOP/CexDFxXWTqjTq9HtZfp0dyBE63+m/l/rlGAAKt4wgp
         I4GfHE0A3FASF2j7RyAplBhAUBbS6dq7YFDQTduO1kE5Q4okdID12fLG5HXr+PhKfo3j
         eKg2M3pZGvV+6PFTHR1oVtBFnXqNRkefCl9B3VrLbFwWjhM9Q9/Ju4dTU7uo79l5PRKI
         aWcw==
X-Gm-Message-State: ACgBeo1+nKyqLGchKEfoEOGBzvWabksqq2Xwo8xp8mcWn8tEmF9WEytg
        rMb2qBkNtS7fvlfymlYSE09WJP4q+HBIEhLV
X-Google-Smtp-Source: AA6agR5uInSZpyBt1BkkyhQmW3EcUIfcVpaaFR8WWYNsm63K+KuD96LfhqS2Erhb492nblabyjH2XA==
X-Received: by 2002:a63:f809:0:b0:41b:4a4c:4fbf with SMTP id n9-20020a63f809000000b0041b4a4c4fbfmr4246147pgh.616.1659668752622;
        Thu, 04 Aug 2022 20:05:52 -0700 (PDT)
Received: from ffyuanda.localdomain ([113.65.229.239])
        by smtp.gmail.com with ESMTPSA id i6-20020a654d06000000b0040df0c9a1aasm570234pgt.14.2022.08.04.20.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 20:05:52 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v2 2/9] mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
Date:   Fri,  5 Aug 2022 11:05:21 +0800
Message-Id: <20220805030528.1535376-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
 <20220805030528.1535376-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Method check_dir_in_index() introduced in b91a2b6594 (mv: add
check_dir_in_index() and solve general dir check issue, 2022-06-30)
does not describe its intent and behavior well.

Change its name to empty_dir_has_sparse_contents(), which more
precisely describes its purpose.

Reverse the return values, check_dir_in_index() return 0 for success
and 1 for failure; reverse the values so empty_dir_has_sparse_contents()
return 1 for success and 0 for failure. These values are more intuitive
because 1 usually means "has" and 0 means "not found".

Also modify the documentation to better align with the method's
intent and behavior.

Helped-by: Derrick Stolee <derrickstolee@github.com>
Helped-by: Victoria Dye <vdye@github.com>
Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 4729bb1a1a..7c11b8f995 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -125,15 +125,13 @@ static int index_range_of_same_dir(const char *src, int length,
 }
 
 /*
- * Check if an out-of-cone directory should be in the index. Imagine this case
- * that all the files under a directory are marked with 'CE_SKIP_WORKTREE' bit
- * and thus the directory is sparsified.
- *
- * Return 0 if such directory exist (i.e. with any of its contained files not
- * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
- * Return 1 otherwise.
+ * Given the path of a directory that does not exist on-disk, check whether the
+ * directory contains any entries in the index with the SKIP_WORKTREE flag
+ * enabled.
+ * Return 1 if such index entries exist.
+ * Return 0 otherwise.
  */
-static int check_dir_in_index(const char *name)
+static int empty_dir_has_sparse_contents(const char *name)
 {
 	const char *with_slash = add_slash(name);
 	int length = strlen(with_slash);
@@ -144,14 +142,14 @@ static int check_dir_in_index(const char *name)
 	if (pos < 0) {
 		pos = -pos - 1;
 		if (pos >= the_index.cache_nr)
-			return 1;
+			return 0;
 		ce = active_cache[pos];
 		if (strncmp(with_slash, ce->name, length))
-			return 1;
-		if (ce_skip_worktree(ce))
 			return 0;
+		if (ce_skip_worktree(ce))
+			return 1;
 	}
-	return 1;
+	return 0;
 }
 
 int cmd_mv(int argc, const char **argv, const char *prefix)
@@ -232,7 +230,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 			if (pos < 0) {
 				const char *src_w_slash = add_slash(src);
 				if (!path_in_sparse_checkout(src_w_slash, &the_index) &&
-				    !check_dir_in_index(src)) {
+				    empty_dir_has_sparse_contents(src)) {
 					modes[i] |= SKIP_WORKTREE_DIR;
 					goto dir_check;
 				}
-- 
2.37.0

