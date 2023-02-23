Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A330DC61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:06:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbjBWIGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjBWIFn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:43 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD24A46179
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:33 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j3so5872541wms.2
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWH+lbvYbZJRfMscZUM14OjSDoGZkbcyJPYWEsglvgs=;
        b=oK4EC0gtOXu7+QwRQmmUB0a3UJ1ri3uEFSUbvoxaOrlviStBlqYcFrAnePT6rZ+miF
         +2p6ir12NctwMpC080Qqwoxb3UlMds7fZZkiUnL18pppFf8t+UGm8dHA9SMEw5kUswvV
         tqVmtAmXxxTdxFIIwDZNWBcEzF7boQ6CpD/g/Z8jJf+ZCM4SZeWY/12NuCbFJndWjph4
         O8MWiy5r2l4UVL/ZhI3WIcr3y70iNSjD1hbIU1SJjjMhLm3tFpqxm6d+UIqUwU4X4uSw
         FRLxpV//ckmcNHsvnJ2pLinXsFxPOQ33T8PKYSx7Eldjr+2evZcJO6dHGBYZrk8rfXjE
         IQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWH+lbvYbZJRfMscZUM14OjSDoGZkbcyJPYWEsglvgs=;
        b=bak3dT45r85oUBL4mmOUhOPPTKwsOnkoEodBt/m0W0FVda5V4ltXdwd2u87MF+BiCF
         4sBVTI5jr3TMl8AOKpGzu0NV64NNu9NEwj5U0KseF3T8qKYk2DAQmwKKn0rO9E+AIeLm
         UnsYp2fNrVcfOQfvLT5a1wQQE5wl+LQAQ5xFH+WOqCcwjrjOnnBq5CjarJd7wXe6UcrP
         K6IJEPv+QDMK4rlUztUFCDQA4icnBx/ZZQxQ8PyK1Wb3jbtiNK9aEmrfkOHjbvS4L+if
         25Scl5wqpbH7TJDxy9WdheLJe/GZ3IasaUou/AIVBTCV1Nqvn+Y7ZTOWuX0oHUMksu94
         27pQ==
X-Gm-Message-State: AO0yUKV1wf4IjWtkeWXmdNb3c8rJu7RePZm8lTJxPpW8ovw/2oqAijnt
        u+4idVvikvFG6Ikg0ghkzuR7IYVW9eU=
X-Google-Smtp-Source: AK7set8n6JvEWFZ04eS+UR04Zwj2aCHDT8IEOlYFJxKNc2pBd9P1E5/C5zn3B1/Oid+3bgIga2YScA==
X-Received: by 2002:a05:600c:a695:b0:3df:f7db:9cdf with SMTP id ip21-20020a05600ca69500b003dff7db9cdfmr8354875wmb.0.1677139531682;
        Thu, 23 Feb 2023 00:05:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5-20020a05600c224500b003dc1a525f22sm7669589wmm.25.2023.02.23.00.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:31 -0800 (PST)
Message-Id: <0446ab61d6f1b72969aa6a5ee7fbbac4aee331cd.1677139522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:16 +0000
Subject: [PATCH 11/16] dir.h: refactor to no longer need to include cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Moving a few functions around allows us to make dir.h no longer need to
include cache.h.  This commit is best viewed with:
    git log -1 -p --color-moved

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 cache.h             | 31 +++++++++++--------------------
 dir.h               | 16 ++--------------
 pathspec.h          |  5 +++++
 statinfo.h          | 24 ++++++++++++++++++++++++
 trace2/tr2_sysenv.c |  2 +-
 5 files changed, 43 insertions(+), 35 deletions(-)
 create mode 100644 statinfo.h

diff --git a/cache.h b/cache.h
index af15701b063..774d8c6bdfd 100644
--- a/cache.h
+++ b/cache.h
@@ -15,9 +15,11 @@
 #include "hash.h"
 #include "hex.h"
 #include "path.h"
+#include "pathspec.h"
 #include "object.h"
 #include "oid-array.h"
 #include "repository.h"
+#include "statinfo.h"
 #include "mem-pool.h"
 
 typedef struct git_zstream {
@@ -120,26 +122,6 @@ struct cache_header {
 #define INDEX_FORMAT_LB 2
 #define INDEX_FORMAT_UB 4
 
-/*
- * The "cache_time" is just the low 32 bits of the
- * time. It doesn't matter if it overflows - we only
- * check it for equality in the 32 bits we save.
- */
-struct cache_time {
-	uint32_t sec;
-	uint32_t nsec;
-};
-
-struct stat_data {
-	struct cache_time sd_ctime;
-	struct cache_time sd_mtime;
-	unsigned int sd_dev;
-	unsigned int sd_ino;
-	unsigned int sd_uid;
-	unsigned int sd_gid;
-	unsigned int sd_size;
-};
-
 struct cache_entry {
 	struct hashmap_entry ent;
 	struct stat_data ce_stat_data;
@@ -295,6 +277,15 @@ static inline unsigned int canon_mode(unsigned int mode)
 	return S_IFGITLINK;
 }
 
+static inline int ce_path_match(struct index_state *istate,
+				const struct cache_entry *ce,
+				const struct pathspec *pathspec,
+				char *seen)
+{
+	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
+			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
+}
+
 #define cache_entry_size(len) (offsetof(struct cache_entry,name) + (len) + 1)
 
 #define SOMETHING_CHANGED	(1 << 0) /* unclassified changes go here */
diff --git a/dir.h b/dir.h
index 8acfc044181..fc4386ae50e 100644
--- a/dir.h
+++ b/dir.h
@@ -1,8 +1,9 @@
 #ifndef DIR_H
 #define DIR_H
 
-#include "cache.h"
 #include "hashmap.h"
+#include "pathspec.h"
+#include "statinfo.h"
 #include "strbuf.h"
 
 /**
@@ -363,10 +364,6 @@ int count_slashes(const char *s);
 int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
-int match_pathspec(struct index_state *istate,
-		   const struct pathspec *pathspec,
-		   const char *name, int namelen,
-		   int prefix, char *seen, int is_dir);
 int report_path_error(const char *ps_matched, const struct pathspec *pathspec);
 int within_depth(const char *name, int namelen, int depth, int max_depth);
 
@@ -533,15 +530,6 @@ int submodule_path_match(struct index_state *istate,
 			 const char *submodule_name,
 			 char *seen);
 
-static inline int ce_path_match(struct index_state *istate,
-				const struct cache_entry *ce,
-				const struct pathspec *pathspec,
-				char *seen)
-{
-	return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
-			      S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
-}
-
 static inline int dir_path_match(struct index_state *istate,
 				 const struct dir_entry *ent,
 				 const struct pathspec *pathspec,
diff --git a/pathspec.h b/pathspec.h
index 41f6adfbb42..a5b38e0907a 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -171,6 +171,11 @@ int match_pathspec_attrs(struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
 
+int match_pathspec(struct index_state *istate,
+		   const struct pathspec *pathspec,
+		   const char *name, int namelen,
+		   int prefix, char *seen, int is_dir);
+
 /*
  * Determine whether a pathspec will match only entire index entries (non-sparse
  * files and/or entire sparse directories). If the pathspec has the potential to
diff --git a/statinfo.h b/statinfo.h
new file mode 100644
index 00000000000..e49e3054eaa
--- /dev/null
+++ b/statinfo.h
@@ -0,0 +1,24 @@
+#ifndef STATINFO_H
+#define STATINFO_H
+
+/*
+ * The "cache_time" is just the low 32 bits of the
+ * time. It doesn't matter if it overflows - we only
+ * check it for equality in the 32 bits we save.
+ */
+struct cache_time {
+	uint32_t sec;
+	uint32_t nsec;
+};
+
+struct stat_data {
+	struct cache_time sd_ctime;
+	struct cache_time sd_mtime;
+	unsigned int sd_dev;
+	unsigned int sd_ino;
+	unsigned int sd_uid;
+	unsigned int sd_gid;
+	unsigned int sd_size;
+};
+
+#endif
diff --git a/trace2/tr2_sysenv.c b/trace2/tr2_sysenv.c
index a380dcf9105..069786cb927 100644
--- a/trace2/tr2_sysenv.c
+++ b/trace2/tr2_sysenv.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
 #include "tr2_sysenv.h"
-- 
gitgitgadget

