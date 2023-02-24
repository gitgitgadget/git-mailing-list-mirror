Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40388C64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBXAKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBXAJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90CC23674
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bw19so1693895wrb.13
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LjiROEw7t4k/UK8LW1YqtV8umnY5OClakiSdQxpUmY0=;
        b=GMOV94nyXfgBbjNT85xsK6Vk951i1qfay55iuHXPi/xO4Bwx0E3oKFrt143/HgYoXf
         MYEjnheUv/sdnnbOBU7AvY8bk8BEmdl+EWVWEBRBmac6bKfONdKFs8jbwhVVHpvaAs0f
         miwWT/k63bb/i5S/aasx1XtFgXV3fsDhEGOVHbENKqhEITznP2XrJZtfVAXnsEf00q6k
         Tji3h1voyfViGDVoi6nyZLN+zG6l2hwl6+fghMQr7QoPoHgsCIhjfKt7lX9lWmCFNlOO
         Qo0DbIee8OleNwjqrDvLWBs5c0Ci+Tu6Irl0hoHVyZJN9NU7OyIuClXTKSdYAQatfMsp
         SH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LjiROEw7t4k/UK8LW1YqtV8umnY5OClakiSdQxpUmY0=;
        b=PK160sYqEGDQIbuIcc2/dkQJh+UN2o6L4ofSnMTpmI5kr4LEG3G7nZImr8h0WWKZwM
         em0oifzs00yq4sN84yiXq9xCAgNDhAPyI5XRgjQ4eu+sIRIRlfoY4e1T+bK09hzkF8OX
         bDHPsRZfiNe/R1NmsLiKsuovWTwS2DCpoVjhVoYb4ns4Zbb+GfMdEv0aDCVVugaIpA/b
         rTnEGHcI7c4tuKJMzH+/xP373dmQDSrfY/y0jj1f0mc6+bTGs49GqMmRqk0JMhcgg755
         3rJQniErJq0ZCfhg0cwQ5p9U6rWet1sn1EEl3U4JSEO/KLwNQqiFoyCqhk0UiWmlwaNJ
         AXFw==
X-Gm-Message-State: AO0yUKVNlY6x1zsk1htE4xvoarvGG5C/lsjUraxxsCdgwVDfscfTg/uH
        g2PxRcGe+RqcK/xThaMvpRuax7/xQ2Y=
X-Google-Smtp-Source: AK7set8eIrvTEhtcxWMoHm+aOVnjzGE4T2d3IXLYls6izJDfxjY3dQOp9yjADH35I4GBk6ytFW4FJQ==
X-Received: by 2002:adf:e889:0:b0:2bf:ae19:d8e4 with SMTP id d9-20020adfe889000000b002bfae19d8e4mr13095268wrm.16.1677197390131;
        Thu, 23 Feb 2023 16:09:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003e20a6fd604sm852967wmc.4.2023.02.23.16.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:49 -0800 (PST)
Message-Id: <856d3dbcc6e91ae46af8db8596c6a222b6d60e4a.1677197378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:31 +0000
Subject: [PATCH v2 12/17] dir.h: refactor to no longer need to include cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
index d0e105ec58f..fdb3125f00d 100644
--- a/cache.h
+++ b/cache.h
@@ -14,9 +14,11 @@
 #include "pack-revindex.h"
 #include "hash.h"
 #include "path.h"
+#include "pathspec.h"
 #include "object.h"
 #include "oid-array.h"
 #include "repository.h"
+#include "statinfo.h"
 #include "mem-pool.h"
 
 typedef struct git_zstream {
@@ -119,26 +121,6 @@ struct cache_header {
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
@@ -294,6 +276,15 @@ static inline unsigned int canon_mode(unsigned int mode)
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

