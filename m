Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E20C77B7F
	for <git@archiver.kernel.org>; Wed,  3 May 2023 18:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjECSvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjECSuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 14:50:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6242683F6
        for <git@vger.kernel.org>; Wed,  3 May 2023 11:50:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-b9a7c45b8e1so9558796276.3
        for <git@vger.kernel.org>; Wed, 03 May 2023 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683139843; x=1685731843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMaY1aOrv7ibUhJTA50l5NAg8VCQzw7tODpfdgEpx6A=;
        b=ubQtfuuAuSBy9od3/FhtZzadU5kun9tOI/a4tQ4m3LLX6WVGfw31Qk5J3DALPWk8k9
         w9ZIY0bUsPrdaJ5aRhDRSlsK1mid86ACGcJ6gjqFpfYQdxbbudPgoupnN4zqMZ3J/2+S
         RjEFvAIpqtrMFP+kd8CdHolF+H4TyqNceBQRHbch20b6Gc+qSrbe4OAfejCq1UZo/6LJ
         NMHzyJHouArq3DOxdWUJx699H1PcI7pGDNH0HSCDPmZuzKCXW0jcibMRT+hy5l+FzUJs
         lJisT1/Hgu8UUHSAZQjc0UoKFEnENcqdNEXXvyEn58Gtb8Bj35W+kg8zkgUOGvZMLCCU
         V6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683139843; x=1685731843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yMaY1aOrv7ibUhJTA50l5NAg8VCQzw7tODpfdgEpx6A=;
        b=eJ7mZTbYcvrm7Vv25B2GE8rtcNF1RhevS5K+9GdQxqjcyoomEVgBluJmZ2CvGyBhLv
         jxKnOSGgT1PveVa+UUTyvPhnTbKtCn7cCVR6vwOaInt1bhyboubldI26DXnQ8QJhRJR1
         DggSSgj10O4+wzQwblasj9KIx2SONB500YqeaTrXKPUY/DJVxE0ZeJV9kp2WxyKtb5q/
         WjgCLQ2J8S4yGY3FxpS6FhU3s/BHg2eXrzxvH6l45z/0qohWtTtMujWbsEFwvZL3O7hT
         R/wkTU2VQtuTVvBSoqT8fsNK3GBRMT0CSQJ1WBbm5FE5Yemj39UcDf+KRx2COSd/bZnK
         Ck5g==
X-Gm-Message-State: AC+VfDxLz5300PF5YZQYOCFS6hFTBqB7eQ6mzUVwxqGmCBat2CJ4eGEt
        qILlAJYp01CXOjzCsKzmH9Mg1KlS4pNC2erM+4hypXqBKxgGSOJGVF7vabFum4+kWo7sRIKsAay
        9CzNYeciKre2aOyzIm2j9xg2+sOD9c97l443aSE4cASsn3r53ayECtT08f3b8mnm1+A==
X-Google-Smtp-Source: ACHHUZ5rg3llsQI2LqKDCxI/cLTTPaYqrFAl2QkKmopFUbOcLHj8hsPMgk897aV4ryoGEaOXmR3V1Gc6FlNz2S4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:c0ca:0:b0:b9a:7cd6:ba7a with SMTP id
 c193-20020a25c0ca000000b00b9a7cd6ba7amr8729685ybf.12.1683139843623; Wed, 03
 May 2023 11:50:43 -0700 (PDT)
Date:   Wed,  3 May 2023 18:50:29 +0000
In-Reply-To: <20230503184849.1809304-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230503184849.1809304-1-calvinwan@google.com>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
Message-ID: <20230503185031.1810078-5-calvinwan@google.com>
Subject: [PATCH v2 5/7] path: move related function to path
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, newren@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move path-related function from strbuf.[ch] to path.[ch] since path is
not a primitive object and therefore strbuf should not directly interact
with it.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 path.c   | 20 ++++++++++++++++++++
 path.h   |  5 +++++
 strbuf.c | 20 --------------------
 3 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/path.c b/path.c
index 7c1cd8182a..e17a2613c5 100644
--- a/path.c
+++ b/path.c
@@ -1213,6 +1213,26 @@ int normalize_path_copy(char *dst, const char *src)
 	return normalize_path_copy_len(dst, src, NULL);
 }
 
+int strbuf_normalize_path(struct strbuf *src)
+{
+	struct strbuf dst = STRBUF_INIT;
+
+	strbuf_grow(&dst, src->len);
+	if (normalize_path_copy(dst.buf, src->buf) < 0) {
+		strbuf_release(&dst);
+		return -1;
+	}
+
+	/*
+	 * normalize_path does not tell us the new length, so we have to
+	 * compute it by looking for the new NUL it placed
+	 */
+	strbuf_setlen(&dst, strlen(dst.buf));
+	strbuf_swap(src, &dst);
+	strbuf_release(&dst);
+	return 0;
+}
+
 /*
  * path = Canonical absolute path
  * prefixes = string_list containing normalized, absolute paths without
diff --git a/path.h b/path.h
index 60e83a49a9..639372edd9 100644
--- a/path.h
+++ b/path.h
@@ -191,6 +191,11 @@ const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
 int normalize_path_copy(char *dst, const char *src);
+/**
+ * Normalize in-place the path contained in the strbuf. If an error occurs,
+ * the contents of "sb" are left untouched, and -1 is returned.
+ */
+int strbuf_normalize_path(struct strbuf *src);
 int longest_ancestor_length(const char *path, struct string_list *prefixes);
 char *strip_path_suffix(const char *path, const char *suffix);
 int daemon_avoid_alias(const char *path);
diff --git a/strbuf.c b/strbuf.c
index 6533559e95..178d75f250 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1088,26 +1088,6 @@ void strbuf_stripspace(struct strbuf *sb, int skip_comments)
 	strbuf_setlen(sb, j);
 }
 
-int strbuf_normalize_path(struct strbuf *src)
-{
-	struct strbuf dst = STRBUF_INIT;
-
-	strbuf_grow(&dst, src->len);
-	if (normalize_path_copy(dst.buf, src->buf) < 0) {
-		strbuf_release(&dst);
-		return -1;
-	}
-
-	/*
-	 * normalize_path does not tell us the new length, so we have to
-	 * compute it by looking for the new NUL it placed
-	 */
-	strbuf_setlen(&dst, strlen(dst.buf));
-	strbuf_swap(src, &dst);
-	strbuf_release(&dst);
-	return 0;
-}
-
 void strbuf_strip_file_from_path(struct strbuf *sb)
 {
 	char *path_sep = find_last_dir_sep(sb->buf);
-- 
2.40.1.521.gf1e218fcd8-goog

