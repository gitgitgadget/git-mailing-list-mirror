Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE6C77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 19:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239545AbjFFTtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 15:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjFFTs4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 15:48:56 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343B10EC
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 12:48:54 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-65fd8267042so586401b3a.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 12:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686080933; x=1688672933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JLwJPLnEZ3/zrMEJGdaz9Us+UEY0SRoC+u4/9wL+WfY=;
        b=DPnfS6lhMk2ASVcv2e6BBHqG9qCLenpIzqwmcdYircuFv7CvO0kPjSVLTHrVSEfcJU
         SJde85vkMQIWxrhXoCuHzQ9AMrlxH6em3LiK3iFsPk6UHq0pVVCVdhG3p8NLq6XDfzE8
         nu5X1zLjAA1cj9t5TdpgKMRof/UMxUsgb1rfWYtDUfA/NOkRrPEt5jUf1IZB/O1XGJyS
         42flEyxEiGCpKK0lTDnv6EIqnvOmK9QFTbyB6fpjL4je2j6LEfwy2/6S11lxxfASkvru
         kdZXZzl/gIdTX4100fsTp6RP9L1tyzYRBgqAUvG7QGxSDCfn3P7dnw6K8+D7xzuNN/+Y
         JocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686080933; x=1688672933;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLwJPLnEZ3/zrMEJGdaz9Us+UEY0SRoC+u4/9wL+WfY=;
        b=XvFm4Lh5SD0xfdPUzPLRhoLivtksHGbhKaIYE5JEgaVMvOB3xlyKErYatQIedT8tLy
         XkbiKfeRjq3NF4FUqrcbCNlJyX/DY5/XQ2qY4UTxx2aqVWUF0P4T1A3XpWe4ZcLdOkiH
         CldNfmYHjcmfnqpyTC5Q3Ho8ws2SXAA6iwM74YAb7h2rWah+V5a1bdkF5RrpDgXGc/lm
         Zx1sUMr6rXzGruzKF+o1MGN6tI5iQ1IpqAofmjpF9dIw6566ImVa+n910a8P5Ou08rWn
         pgtIFwjKBPi1Y3eyyR/YlKlEJtUGv7rWCA3zrvyCp9IyJ6hoZPtrxXzNIBKHj6TrRfZx
         uyPA==
X-Gm-Message-State: AC+VfDw8J39lIKtT0dEqPHcKHsJUXVobkJPgIsvC0RAVeaWGCEnyot9I
        gm+VI1fGR6LINHEbPggUYqewCD09itktpV/N/ZeLY5rbm/WZT3qKrybOuRzKrOVS8Q2LpT1FZrt
        L7Z1H3QLCCezKlV8hKVl2FIGKP/VHHaNzpf/h8ZfseSV231Q50vEBN7RKIqKf7pTAQg==
X-Google-Smtp-Source: ACHHUZ51fPbfd0PaF7zY9geaCgEpF2/yEXRcYJQZnUK5pk8LlIBMAxXg8SdsOh07rxs2EegXAG1P3Hr9PGbp7/Q=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6a00:2d18:b0:653:3fbc:3188 with SMTP
 id fa24-20020a056a002d1800b006533fbc3188mr1135286pfb.6.1686080933500; Tue, 06
 Jun 2023 12:48:53 -0700 (PDT)
Date:   Tue,  6 Jun 2023 19:48:41 +0000
In-Reply-To: <20230606194720.2053551-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606194720.2053551-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230606194843.2054314-5-calvinwan@google.com>
Subject: [PATCH v7 5/7] object-name: move related functions to object-name
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move object-name-related functions from strbuf.[ch] to object-name.[ch]
so that strbuf is focused on string manipulation routines with minimal
dependencies.

dir.h relied on the forward declration of the repository struct in
strbuf.h. Since that is removed in this patch, add the forward
declaration to dir.h.

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 dir.h         |  2 ++
 object-name.c | 15 +++++++++++++++
 object-name.h |  9 +++++++++
 pretty.c      |  1 +
 strbuf.c      | 16 ----------------
 strbuf.h      | 10 ----------
 6 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/dir.h b/dir.h
index 79b85a01ee..4d83febe9e 100644
--- a/dir.h
+++ b/dir.h
@@ -40,6 +40,8 @@
  *
  */
 
+struct repository;
+
 struct dir_entry {
 	unsigned int len;
 	char name[FLEX_ARRAY]; /* more */
diff --git a/object-name.c b/object-name.c
index 6fc3fa595b..34e0f56703 100644
--- a/object-name.c
+++ b/object-name.c
@@ -768,6 +768,21 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 		find_abbrev_len_for_pack(p, mad);
 }
 
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len)
+{
+	int r;
+	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
+	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
+	strbuf_setlen(sb, sb->len + r);
+}
+
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len)
+{
+	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
+}
+
 int repo_find_unique_abbrev_r(struct repository *r, char *hex,
 			      const struct object_id *oid, int len)
 {
diff --git a/object-name.h b/object-name.h
index 1d63698f42..9ae5223071 100644
--- a/object-name.h
+++ b/object-name.h
@@ -40,6 +40,15 @@ struct object_context {
 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
 
+/**
+ * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
+ * the strbuf `sb`.
+ */
+void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
+				   const struct object_id *oid, int abbrev_len);
+void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
+			      int abbrev_len);
+
 int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
 __attribute__((format (printf, 2, 3)))
 int get_oidf(struct object_id *oid, const char *fmt, ...);
diff --git a/pretty.c b/pretty.c
index 0bb938021b..78bac2d818 100644
--- a/pretty.c
+++ b/pretty.c
@@ -18,6 +18,7 @@
 #include "gpg-interface.h"
 #include "trailer.h"
 #include "run-command.h"
+#include "object-name.h"
 
 /*
  * The limit for formatting directives, which enable the caller to append
diff --git a/strbuf.c b/strbuf.c
index 5244029d91..80b7e051cd 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -3,7 +3,6 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-name.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
@@ -1024,21 +1023,6 @@ void strbuf_addftime(struct strbuf *sb, const char *fmt, const struct tm *tm,
 	strbuf_setlen(sb, sb->len + len);
 }
 
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len)
-{
-	int r;
-	strbuf_grow(sb, GIT_MAX_HEXSZ + 1);
-	r = repo_find_unique_abbrev_r(repo, sb->buf + sb->len, oid, abbrev_len);
-	strbuf_setlen(sb, sb->len + r);
-}
-
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len)
-{
-	strbuf_repo_add_unique_abbrev(sb, the_repository, oid, abbrev_len);
-}
-
 /*
  * Returns the length of a line, without trailing spaces.
  *
diff --git a/strbuf.h b/strbuf.h
index 114ad0c024..5d97e27b99 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -616,16 +616,6 @@ void strbuf_add_separated_string_list(struct strbuf *str,
  */
 void strbuf_list_free(struct strbuf **list);
 
-/**
- * Add the abbreviation, as generated by repo_find_unique_abbrev(), of `sha1` to
- * the strbuf `sb`.
- */
-struct repository;
-void strbuf_repo_add_unique_abbrev(struct strbuf *sb, struct repository *repo,
-				   const struct object_id *oid, int abbrev_len);
-void strbuf_add_unique_abbrev(struct strbuf *sb, const struct object_id *oid,
-			      int abbrev_len);
-
 /*
  * Remove the filename from the provided path string. If the path
  * contains a trailing separator, then the path is considered a directory
-- 
2.41.0.162.gfafddb0af9-goog

