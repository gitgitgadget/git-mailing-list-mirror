Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A78FC7EE24
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjEGDqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjEGDqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:04 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CA52D6D
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3062c1e7df8so2109600f8f.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431159; x=1686023159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bAh+FLTlGAu0Alzmqma5PD7e5PEfAs+N6kkIkvSEL58=;
        b=hrR9U01c6div58IuDd1luGNxtWqBqCYLctp/5lqjPjDtrIWpnQuXYy4K0ExkCmb8PN
         MF1O9Nlujiuu7o92D7WxdQSZQdxZ1j5RqwH6hZH0UTwbfP0UYluStQWWtBhqQn6nywCW
         L+02Y/J7KSZeEgdVBKh58iChkw2ZOXBhBQP/OoKdwUmT/tC/pUEJnBfHwbhpxHglvcIR
         ZZsZbu+uv/mV+wpAGjtlr/21F1dKXGkHCr5CPhfs1kFkT+DEoOCqE11JeO1y7K+icbFC
         VOpukxWvjY6gxvOQ3MyDokdsH3r5JFew20vKDnAmXK4W1gSEfk9bmEt4U0OpQZGR0fX9
         CTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431159; x=1686023159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAh+FLTlGAu0Alzmqma5PD7e5PEfAs+N6kkIkvSEL58=;
        b=fxmWkQ9durQRHydjNFD5RJcS/0fJ9DyfS67cco11sci1c1WFmysQt0VbulhYy0s3l2
         A5Xlwtawh+IMlz2g649JJujqlGOD9uDqSCntbyayXzF07YA/a7GhnJGYhW8XpXAJr3PT
         nMYYbFDyKEWDiJu8+I7miIgV1ybyJCIXaf+1fFuAc6scFt9Klo0ka57r3al2zKpZ5QfL
         lK42yRiBGa9pIqaz3che8N+kGK/rXLLk7KBpz9M/W9YTNW5z1O9vnehWShDYqEq/B4GP
         I9Gy1MLjO/jCle3WRVku2w5mCCSZ4d7Agoth45NTmhgRQZx4mZtcajAEdjgooBlCDWUx
         7kQQ==
X-Gm-Message-State: AC+VfDwF7Ny4zgtLUCn5Z7M1wR3vAo2GnLz9l+YiQvIDfleP8ADcz0Hk
        haWU/i6kCxCO7pPHsa2nAeuGb8MKCb8=
X-Google-Smtp-Source: ACHHUZ7Kw3IkPjFNpePCbCXQfbmpuzJejjwWuPpvRFUm0YkCkIokwnNcS58IpCidUARNfpu2YdFjjw==
X-Received: by 2002:a5d:4578:0:b0:306:31e0:958 with SMTP id a24-20020a5d4578000000b0030631e00958mr4531511wrc.15.1683431159403;
        Sat, 06 May 2023 20:45:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e7-20020a5d65c7000000b00307925ff35bsm354817wrw.49.2023.05.06.20.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:58 -0700 (PDT)
Message-Id: <e7b5b66c10c97098c2ea24d8cb3e9252bd3d82be.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:32 +0000
Subject: [PATCH 07/24] statinfo: move stat_{data,validity} functions from
 cache/read-cache
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

These functions do not depend upon struct cache_entry or struct
index_state in any way, and it seems more logical to break them out into
this file, especially since statinfo.h already has the struct stat_data
declaration.

Diff best viewed with `--color-moved`.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile              |  1 +
 cache.h               | 48 ------------------------
 object.c              |  1 +
 read-cache.c          | 84 -----------------------------------------
 refs/packed-backend.c |  1 +
 shallow.c             |  1 +
 statinfo.c            | 87 +++++++++++++++++++++++++++++++++++++++++++
 statinfo.h            | 51 +++++++++++++++++++++++++
 8 files changed, 142 insertions(+), 132 deletions(-)
 create mode 100644 statinfo.c

diff --git a/Makefile b/Makefile
index e440728c246..cbc7f212016 100644
--- a/Makefile
+++ b/Makefile
@@ -1142,6 +1142,7 @@ LIB_OBJS += sigchain.o
 LIB_OBJS += sparse-index.o
 LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
+LIB_OBJS += statinfo.o
 LIB_OBJS += strbuf.o
 LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
diff --git a/cache.h b/cache.h
index 02d69c24cd6..891e5fec744 100644
--- a/cache.h
+++ b/cache.h
@@ -488,19 +488,6 @@ int has_racy_timestamp(struct index_state *istate);
 int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
-/*
- * Record to sd the data from st that we use to check whether a file
- * might have changed.
- */
-void fill_stat_data(struct stat_data *sd, struct stat *st);
-
-/*
- * Return 0 if st is consistent with a file not having been changed
- * since sd was filled.  If there are differences, return a
- * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
- * INODE_CHANGED, and DATA_CHANGED.
- */
-int match_stat_data(const struct stat_data *sd, struct stat *st);
 int match_stat_data_racy(const struct index_state *istate,
 			 const struct stat_data *sd, struct stat *st);
 
@@ -539,14 +526,6 @@ void set_alternate_index_output(const char *);
 extern int verify_index_checksum;
 extern int verify_ce_order;
 
-#define MTIME_CHANGED	0x0001
-#define CTIME_CHANGED	0x0002
-#define OWNER_CHANGED	0x0004
-#define MODE_CHANGED    0x0008
-#define INODE_CHANGED   0x0010
-#define DATA_CHANGED    0x0020
-#define TYPE_CHANGED    0x0040
-
 int cmp_cache_name_compare(const void *a_, const void *b_);
 
 /* add */
@@ -579,31 +558,4 @@ int checkout_fast_forward(struct repository *r,
 
 int sane_execvp(const char *file, char *const argv[]);
 
-/*
- * A struct to encapsulate the concept of whether a file has changed
- * since we last checked it. This uses criteria similar to those used
- * for the index.
- */
-struct stat_validity {
-	struct stat_data *sd;
-};
-
-void stat_validity_clear(struct stat_validity *sv);
-
-/*
- * Returns 1 if the path is a regular file (or a symlink to a regular
- * file) and matches the saved stat_validity, 0 otherwise.  A missing
- * or inaccessible file is considered a match if the struct was just
- * initialized, or if the previous update found an inaccessible file.
- */
-int stat_validity_check(struct stat_validity *sv, const char *path);
-
-/*
- * Update the stat_validity from a file opened at descriptor fd. If
- * the file is missing, inaccessible, or not a regular file, then
- * future calls to stat_validity_check will match iff one of those
- * conditions continues to be true.
- */
-void stat_validity_update(struct stat_validity *sv, int fd);
-
 #endif /* CACHE_H */
diff --git a/object.c b/object.c
index 6d4ef1524de..333e736fb24 100644
--- a/object.c
+++ b/object.c
@@ -6,6 +6,7 @@
 #include "object-file.h"
 #include "object-store.h"
 #include "blob.h"
+#include "statinfo.h"
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/read-cache.c b/read-cache.c
index bfbd531ea60..b99dbfd16b0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -177,61 +177,6 @@ void rename_index_entry_at(struct index_state *istate, int nr, const char *new_n
 		add_index_entry(istate, new_entry, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
 }
 
-void fill_stat_data(struct stat_data *sd, struct stat *st)
-{
-	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
-	sd->sd_mtime.sec = (unsigned int)st->st_mtime;
-	sd->sd_ctime.nsec = ST_CTIME_NSEC(*st);
-	sd->sd_mtime.nsec = ST_MTIME_NSEC(*st);
-	sd->sd_dev = st->st_dev;
-	sd->sd_ino = st->st_ino;
-	sd->sd_uid = st->st_uid;
-	sd->sd_gid = st->st_gid;
-	sd->sd_size = st->st_size;
-}
-
-int match_stat_data(const struct stat_data *sd, struct stat *st)
-{
-	int changed = 0;
-
-	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
-
-#ifdef USE_NSEC
-	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && check_stat &&
-	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
-#endif
-
-	if (check_stat) {
-		if (sd->sd_uid != (unsigned int) st->st_uid ||
-			sd->sd_gid != (unsigned int) st->st_gid)
-			changed |= OWNER_CHANGED;
-		if (sd->sd_ino != (unsigned int) st->st_ino)
-			changed |= INODE_CHANGED;
-	}
-
-#ifdef USE_STDEV
-	/*
-	 * st_dev breaks on network filesystems where different
-	 * clients will have different views of what "device"
-	 * the filesystem is on
-	 */
-	if (check_stat && sd->sd_dev != (unsigned int) st->st_dev)
-			changed |= INODE_CHANGED;
-#endif
-
-	if (sd->sd_size != (unsigned int) st->st_size)
-		changed |= DATA_CHANGED;
-
-	return changed;
-}
-
 /*
  * This only updates the "non-critical" parts of the directory
  * cache, ie the parts that aren't tracked by GIT, and only used
@@ -3536,35 +3481,6 @@ void *read_blob_data_from_index(struct index_state *istate,
 	return data;
 }
 
-void stat_validity_clear(struct stat_validity *sv)
-{
-	FREE_AND_NULL(sv->sd);
-}
-
-int stat_validity_check(struct stat_validity *sv, const char *path)
-{
-	struct stat st;
-
-	if (stat(path, &st) < 0)
-		return sv->sd == NULL;
-	if (!sv->sd)
-		return 0;
-	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
-}
-
-void stat_validity_update(struct stat_validity *sv, int fd)
-{
-	struct stat st;
-
-	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode))
-		stat_validity_clear(sv);
-	else {
-		if (!sv->sd)
-			CALLOC_ARRAY(sv->sd, 1);
-		fill_stat_data(sv->sd, &st);
-	}
-}
-
 void move_index_extensions(struct index_state *dst, struct index_state *src)
 {
 	dst->untracked = src->untracked;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 704424f55c0..085becf773e 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -10,6 +10,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../statinfo.h"
 #include "../wrapper.h"
 #include "../write-or-die.h"
 
diff --git a/shallow.c b/shallow.c
index 128f56179ed..a2ebf0af2ba 100644
--- a/shallow.c
+++ b/shallow.c
@@ -17,6 +17,7 @@
 #include "list-objects.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "statinfo.h"
 #include "trace.h"
 #include "wrapper.h"
 
diff --git a/statinfo.c b/statinfo.c
new file mode 100644
index 00000000000..17bb8966c33
--- /dev/null
+++ b/statinfo.c
@@ -0,0 +1,87 @@
+#include "git-compat-util.h"
+#include "environment.h"
+#include "statinfo.h"
+
+void fill_stat_data(struct stat_data *sd, struct stat *st)
+{
+	sd->sd_ctime.sec = (unsigned int)st->st_ctime;
+	sd->sd_mtime.sec = (unsigned int)st->st_mtime;
+	sd->sd_ctime.nsec = ST_CTIME_NSEC(*st);
+	sd->sd_mtime.nsec = ST_MTIME_NSEC(*st);
+	sd->sd_dev = st->st_dev;
+	sd->sd_ino = st->st_ino;
+	sd->sd_uid = st->st_uid;
+	sd->sd_gid = st->st_gid;
+	sd->sd_size = st->st_size;
+}
+
+int match_stat_data(const struct stat_data *sd, struct stat *st)
+{
+	int changed = 0;
+
+	if (sd->sd_mtime.sec != (unsigned int)st->st_mtime)
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    sd->sd_ctime.sec != (unsigned int)st->st_ctime)
+		changed |= CTIME_CHANGED;
+
+#ifdef USE_NSEC
+	if (check_stat && sd->sd_mtime.nsec != ST_MTIME_NSEC(*st))
+		changed |= MTIME_CHANGED;
+	if (trust_ctime && check_stat &&
+	    sd->sd_ctime.nsec != ST_CTIME_NSEC(*st))
+		changed |= CTIME_CHANGED;
+#endif
+
+	if (check_stat) {
+		if (sd->sd_uid != (unsigned int) st->st_uid ||
+			sd->sd_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+		if (sd->sd_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
+	}
+
+#ifdef USE_STDEV
+	/*
+	 * st_dev breaks on network filesystems where different
+	 * clients will have different views of what "device"
+	 * the filesystem is on
+	 */
+	if (check_stat && sd->sd_dev != (unsigned int) st->st_dev)
+			changed |= INODE_CHANGED;
+#endif
+
+	if (sd->sd_size != (unsigned int) st->st_size)
+		changed |= DATA_CHANGED;
+
+	return changed;
+}
+
+void stat_validity_clear(struct stat_validity *sv)
+{
+	FREE_AND_NULL(sv->sd);
+}
+
+int stat_validity_check(struct stat_validity *sv, const char *path)
+{
+	struct stat st;
+
+	if (stat(path, &st) < 0)
+		return sv->sd == NULL;
+	if (!sv->sd)
+		return 0;
+	return S_ISREG(st.st_mode) && !match_stat_data(sv->sd, &st);
+}
+
+void stat_validity_update(struct stat_validity *sv, int fd)
+{
+	struct stat st;
+
+	if (fstat(fd, &st) < 0 || !S_ISREG(st.st_mode))
+		stat_validity_clear(sv);
+	else {
+		if (!sv->sd)
+			CALLOC_ARRAY(sv->sd, 1);
+		fill_stat_data(sv->sd, &st);
+	}
+}
diff --git a/statinfo.h b/statinfo.h
index e49e3054eaa..bb9b61bc471 100644
--- a/statinfo.h
+++ b/statinfo.h
@@ -1,6 +1,8 @@
 #ifndef STATINFO_H
 #define STATINFO_H
 
+struct index_state;
+
 /*
  * The "cache_time" is just the low 32 bits of the
  * time. It doesn't matter if it overflows - we only
@@ -21,4 +23,53 @@ struct stat_data {
 	unsigned int sd_size;
 };
 
+/*
+ * A struct to encapsulate the concept of whether a file has changed
+ * since we last checked it. This uses criteria similar to those used
+ * for the index.
+ */
+struct stat_validity {
+	struct stat_data *sd;
+};
+
+#define MTIME_CHANGED	0x0001
+#define CTIME_CHANGED	0x0002
+#define OWNER_CHANGED	0x0004
+#define MODE_CHANGED    0x0008
+#define INODE_CHANGED   0x0010
+#define DATA_CHANGED    0x0020
+#define TYPE_CHANGED    0x0040
+
+/*
+ * Record to sd the data from st that we use to check whether a file
+ * might have changed.
+ */
+void fill_stat_data(struct stat_data *sd, struct stat *st);
+
+/*
+ * Return 0 if st is consistent with a file not having been changed
+ * since sd was filled.  If there are differences, return a
+ * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
+ * INODE_CHANGED, and DATA_CHANGED.
+ */
+int match_stat_data(const struct stat_data *sd, struct stat *st);
+
+void stat_validity_clear(struct stat_validity *sv);
+
+/*
+ * Returns 1 if the path is a regular file (or a symlink to a regular
+ * file) and matches the saved stat_validity, 0 otherwise.  A missing
+ * or inaccessible file is considered a match if the struct was just
+ * initialized, or if the previous update found an inaccessible file.
+ */
+int stat_validity_check(struct stat_validity *sv, const char *path);
+
+/*
+ * Update the stat_validity from a file opened at descriptor fd. If
+ * the file is missing, inaccessible, or not a regular file, then
+ * future calls to stat_validity_check will match iff one of those
+ * conditions continues to be true.
+ */
+void stat_validity_update(struct stat_validity *sv, int fd);
+
 #endif
-- 
gitgitgadget

