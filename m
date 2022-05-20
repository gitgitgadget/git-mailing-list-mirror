Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C35C433F5
	for <git@archiver.kernel.org>; Fri, 20 May 2022 19:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353225AbiETT3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 15:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353217AbiETT3R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 15:29:17 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F164018C052
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:16 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id j3so7674466qvn.0
        for <git@vger.kernel.org>; Fri, 20 May 2022 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M6UZvZePw0rluP7P29X2B5EqGMbybIzBz2JJCndW2/Y=;
        b=e8eqHhLIEBitv8gPxxrwf5db1GkLKw3BijLEc+G8P/fbcI5xzMDhCuwH65Q2H086GS
         doSI7wFYBfXTamhaFHPa3G69r2JF3jCFxPmLmMxd9btjZOCFR90ZQzSsqiMS8NEy6JTL
         rHGw9veU1yWowUUlBfO/rcsOvc0P4KUjxPD9ATShY14G1+gwN5x9EHN+4A4MO/jdHRKk
         NrZdyOeiyAECEEUvtlXdVhU+4b4qPeuWTTp6wh+EEXtp2FER9l28nKzzULkyBp/VKh3X
         KYXI1474JUvK60pIWi14mpBP3qVVzwVqYrzrJNrZIs26E3LKMnxNzGF1jiWoeyMlNz4C
         fmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M6UZvZePw0rluP7P29X2B5EqGMbybIzBz2JJCndW2/Y=;
        b=lv5ioxSXysrzarzlPFmAs05rbSyBoBXOQZ9TMqs24tiOj8s0yVMcHPQIaWAmNsP8Ot
         JT2wFoGrOwZ/BkKvwN5LOADlv9zdPc8NqFcANkt1s0stc+wBqAy7f/Fop9/f2iMar1lt
         BVJlyHkyporRxKgvE85PXpO6djIIPBc83dFKo1KD7cmHmIcztiDZgHZn3KJeBclQoeWu
         z0MdXOOGFrUp7IcuSbzuSX0N2vHP89fiSPnhVs9ekqi6L6kINt68ldXHjufdgep9YYUO
         B9FTepVZxCSU61qw2/Aewqpf6wu99l1KwWhcBGx/XIhy3nsOgatBPKhmq36JPPIEmchi
         7lSg==
X-Gm-Message-State: AOAM532kfJe6HVqJZpF9MTKxH5na9HM0dkiXp899UQVZeTuBClPBPLMn
        oSqlLoAp9L1IHXQplMX+0erG/e2AowUEsg==
X-Google-Smtp-Source: ABdhPJxom1q91EfuczFfmLfGG1/94LDKkT9jxccOWaismzOp34ufrWS8GjUyb5c4zj9YDLuQt4I2KQ==
X-Received: by 2002:a05:6214:20ef:b0:45a:9ad8:5036 with SMTP id 15-20020a05621420ef00b0045a9ad85036mr9079942qvk.5.1653074956423;
        Fri, 20 May 2022 12:29:16 -0700 (PDT)
Received: from localhost.localdomain ([108.29.205.134])
        by smtp.gmail.com with ESMTPSA id v19-20020ae9e313000000b006a059f1d8b8sm142379qkf.124.2022.05.20.12.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 12:29:16 -0700 (PDT)
From:   Goss Geppert <gg.oss.dev@gmail.com>
X-Google-Original-From: Goss Geppert <ggossdev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        christian w <usebees@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v3 3/3] dir: minor refactoring / clean-up
Date:   Fri, 20 May 2022 19:28:40 +0000
Message-Id: <20220520192840.8942-4-ggossdev@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220520192840.8942-1-ggossdev@gmail.com>
References: <20220505203234.21586-1-ggossdev@gmail.com>
 <20220520192840.8942-1-ggossdev@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Narrow the scope of the `nested_repo` variable and conditional return
statement to the block where the variable is set.

Signed-off-by: Goss Geppert <ggossdev@gmail.com>
---
 dir.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 45b89560fc..92bdd4daf8 100644
--- a/dir.c
+++ b/dir.c
@@ -1874,7 +1874,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 	 */
 	enum path_treatment state;
 	int matches_how = 0;
-	int nested_repo = 0, check_only, stop_early;
+	int check_only, stop_early;
 	int old_ignored_nr, old_untracked_nr;
 	/* The "len-1" is to strip the final '/' */
 	enum exist_status status = directory_exists_in_index(istate, dirname, len-1);
@@ -1914,6 +1914,7 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 		 *    manually configured by the user; see t2205 testcases 1-3 for
 		 *    examples where this matters
 		 */
+		int nested_repo;
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addstr(&sb, dirname);
 		nested_repo = is_nonbare_repository_dir(&sb);
@@ -1929,12 +1930,13 @@ static enum path_treatment treat_directory(struct dir_struct *dir,
 			free(real_dirname);
 		}
 		strbuf_release(&sb);
-	}
-	if (nested_repo) {
-		if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
-		    (matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
-			return path_none;
-		return excluded ? path_excluded : path_untracked;
+
+		if (nested_repo) {
+			if ((dir->flags & DIR_SKIP_NESTED_GIT) ||
+				(matches_how == MATCHED_RECURSIVELY_LEADING_PATHSPEC))
+				return path_none;
+			return excluded ? path_excluded : path_untracked;
+		}
 	}
 
 	if (!(dir->flags & DIR_SHOW_OTHER_DIRECTORIES)) {
-- 
2.36.0

