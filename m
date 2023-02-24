Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA41C64ED8
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBXAKJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBXAJy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243FD1A4BB
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i11so6162053wrp.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cb6j7wBUkOCEnLCvXZkykQflIvfTvxXcIYDB/iHzWUM=;
        b=jnF7atqnBMuregfa67Jx0qdxScIUNtDpI5JLagORzUl9YtF8Ac0dQeN6Au/5dqne+j
         Vf5Niy8w9q3knqk/UKubWK0DdNUMSC0Sy0nktc95qJWvL2sCZ2MI6vc2AIO8k0OHAcTH
         5ut2aefVFuzVqTQKVW5Tf/UW4Nkcajx7BiFnoECFR93lZJG4yQyvcdyU/fVNxq1mQxcU
         z4LhBGLrCSeQo4INRole5x/HlY0oCE425qFjc3mKtGkZgMZt2PhR5AO1nDk40IBxwSsl
         y+XqXUhRi4HrGHH8ns7FJMEg6uYQDfJ85cWmwv73sA6bYafOeFCwgC/EF59lyNBe1LJ4
         S1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cb6j7wBUkOCEnLCvXZkykQflIvfTvxXcIYDB/iHzWUM=;
        b=XLW/Rq3yDN7oXXnl2F/UgU0G6WRs/itauDx3bnr3+6s4M9UgDZma9kPsdZZV4WeI7g
         wbXyJ2R+PTyoq9FzINF109xS4vWBzXIvc7n+us52DDTnp4TQzTHbPDyvJQDxuyh8fhSc
         aYxXNxWkdcRWOrtK9EKuuGPWNAZd0i3T+7fxbTwAQ5ETEVy4e7+Vbd8wSt15xKKrZFXj
         FiDCGpeK+X10szKyjwr+kXdadc3KprDank5px2bNmHBHiHgZuAUhlupOjXM+mco15RZK
         XvMrNjQxJurorR7yBU1YhLeH/fWILw6l1EDnl8U5XQY6nXHRChEMGHDJBBe3S34i4x8u
         iZhQ==
X-Gm-Message-State: AO0yUKXtcLD8DEAPur0jm786/1ijCbKKRG/0kzsI0IZ1s3oddhDrtBOy
        qBJFMRnIXvgOJCMXixggNPBJ/XPmhIU=
X-Google-Smtp-Source: AK7set/4SPYhn/rdKuvWx+fGhxe03qBrtKbMqHBTyRC+y7SZTbMJZJPgXznen2ntSiLXoK+2W6UeoA==
X-Received: by 2002:a05:6000:a17:b0:2c5:5938:e6d6 with SMTP id co23-20020a0560000a1700b002c55938e6d6mr11595623wrb.35.1677197384950;
        Thu, 23 Feb 2023 16:09:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r13-20020adfdc8d000000b002c557f82e27sm9741493wrj.99.2023.02.23.16.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:44 -0800 (PST)
Message-Id: <9344a94fd922919e513c308fed8130c56dac2504.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:24 +0000
Subject: [PATCH v2 05/17] alloc.h: move ALLOC_GROW() functions from cache.h
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

This allows us to replace includes of cache.h with includes of the much
smaller alloc.h in many places.  It does mean that we also need to add
includes of alloc.h in a number of C files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c                        |  1 +
 alias.c                            |  4 +-
 alloc.h                            | 75 ++++++++++++++++++++++++++++++
 apply.c                            |  1 +
 archive-tar.c                      |  3 +-
 archive.c                          |  3 +-
 attr.c                             |  1 +
 builtin/blame.c                    |  3 +-
 builtin/cat-file.c                 |  1 +
 builtin/checkout--worker.c         |  1 +
 builtin/config.c                   |  2 +-
 builtin/credential-cache--daemon.c |  1 +
 builtin/fetch-pack.c               |  1 +
 builtin/fsmonitor--daemon.c        |  1 +
 builtin/grep.c                     |  1 +
 builtin/index-pack.c               |  1 +
 builtin/log.c                      |  3 +-
 builtin/merge.c                    |  1 +
 builtin/mktree.c                   |  1 +
 builtin/mv.c                       |  1 +
 builtin/name-rev.c                 |  2 +-
 builtin/pack-objects.c             |  2 +-
 builtin/repack.c                   |  2 +-
 builtin/rev-parse.c                |  1 +
 builtin/revert.c                   |  3 +-
 builtin/rm.c                       |  1 +
 builtin/submodule--helper.c        |  1 +
 bulk-checkin.c                     |  3 +-
 cache-tree.c                       |  3 +-
 cache.h                            | 75 ------------------------------
 chunk-format.c                     |  3 +-
 commit-reach.c                     |  3 +-
 compat/mingw.c                     |  1 +
 config.c                           |  3 +-
 daemon.c                           |  1 +
 delta-islands.c                    |  3 +-
 diff.c                             |  1 +
 diffcore-rename.c                  |  1 +
 dir-iterator.c                     |  3 +-
 dir.c                              |  3 +-
 ewah/bitmap.c                      |  3 +-
 ewah/ewah_bitmap.c                 |  2 +-
 fetch-pack.c                       |  3 +-
 fmt-merge-msg.c                    |  1 +
 fsck.c                             |  3 +-
 fsmonitor-settings.c               |  3 +-
 help.c                             |  3 +-
 http-backend.c                     |  3 +-
 line-log.c                         |  1 +
 list-objects-filter-options.c      |  4 +-
 list-objects-filter.c              |  1 +
 midx.c                             |  3 +-
 object-file.c                      |  3 +-
 oid-array.c                        |  3 +-
 pack-bitmap-write.c                |  3 +-
 pack-bitmap.c                      |  3 +-
 pack-objects.c                     |  3 +-
 packfile.c                         |  3 +-
 parallel-checkout.c                |  1 +
 pretty.c                           |  1 +
 prio-queue.c                       |  3 +-
 quote.c                            |  1 +
 read-cache.c                       |  1 +
 ref-filter.c                       |  5 +-
 reflog-walk.c                      |  3 +-
 refs.c                             |  3 +-
 refs/packed-backend.c              |  3 +-
 refs/ref-cache.c                   |  3 +-
 refspec.c                          |  3 +-
 remote-curl.c                      |  3 +-
 remote.c                           |  3 +-
 rerere.c                           |  3 +-
 revision.c                         |  3 +-
 sequencer.c                        |  1 +
 server-info.c                      |  3 +-
 shallow.c                          |  3 +-
 sigchain.c                         |  3 +-
 sparse-index.c                     |  1 +
 split-index.c                      |  1 +
 strbuf.c                           |  3 +-
 string-list.c                      |  3 +-
 strvec.c                           |  3 +-
 submodule-config.c                 |  1 +
 submodule.c                        |  4 +-
 t/helper/test-reach.c              |  2 +-
 trace2/tr2_tls.c                   |  4 +-
 trailer.c                          |  1 +
 transport.c                        |  4 +-
 tree-walk.c                        |  1 +
 userdiff.c                         |  4 +-
 worktree.c                         |  3 +-
 91 files changed, 219 insertions(+), 134 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index a86a92e1646..c6e451c136c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "alloc.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/alias.c b/alias.c
index 00abde08173..e814948ced3 100644
--- a/alias.c
+++ b/alias.c
@@ -1,6 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alias.h"
+#include "alloc.h"
 #include "config.h"
+#include "gettext.h"
 #include "string-list.h"
 
 struct config_alias_data {
diff --git a/alloc.h b/alloc.h
index 3f4a0ad310a..4312db4bd08 100644
--- a/alloc.h
+++ b/alloc.h
@@ -17,4 +17,79 @@ void *alloc_object_node(struct repository *r);
 struct alloc_state *allocate_alloc_state(void);
 void clear_alloc_state(struct alloc_state *s);
 
+#define alloc_nr(x) (((x)+16)*3/2)
+
+/**
+ * Dynamically growing an array using realloc() is error prone and boring.
+ *
+ * Define your array with:
+ *
+ * - a pointer (`item`) that points at the array, initialized to `NULL`
+ *   (although please name the variable based on its contents, not on its
+ *   type);
+ *
+ * - an integer variable (`alloc`) that keeps track of how big the current
+ *   allocation is, initialized to `0`;
+ *
+ * - another integer variable (`nr`) to keep track of how many elements the
+ *   array currently has, initialized to `0`.
+ *
+ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
+ * alloc)`.  This ensures that the array can hold at least `n` elements by
+ * calling `realloc(3)` and adjusting `alloc` variable.
+ *
+ * ------------
+ * sometype *item;
+ * size_t nr;
+ * size_t alloc
+ *
+ * for (i = 0; i < nr; i++)
+ * 	if (we like item[i] already)
+ * 		return;
+ *
+ * // we did not like any existing one, so add one
+ * ALLOC_GROW(item, nr + 1, alloc);
+ * item[nr++] = value you like;
+ * ------------
+ *
+ * You are responsible for updating the `nr` variable.
+ *
+ * If you need to specify the number of elements to allocate explicitly
+ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
+ *
+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
+ * added niceties.
+ *
+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
+ */
+#define ALLOC_GROW(x, nr, alloc) \
+	do { \
+		if ((nr) > alloc) { \
+			if (alloc_nr(alloc) < (nr)) \
+				alloc = (nr); \
+			else \
+				alloc = alloc_nr(alloc); \
+			REALLOC_ARRAY(x, alloc); \
+		} \
+	} while (0)
+
+/*
+ * Similar to ALLOC_GROW but handles updating of the nr value and
+ * zeroing the bytes of the newly-grown array elements.
+ *
+ * DO NOT USE any expression with side-effect for any of the
+ * arguments.
+ */
+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
+	do { \
+		if (increase) { \
+			size_t new_nr = nr + (increase); \
+			if (new_nr < nr) \
+				BUG("negative growth in ALLOC_GROW_BY"); \
+			ALLOC_GROW(x, new_nr, alloc); \
+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
+			nr = new_nr; \
+		} \
+	} while (0)
+
 #endif
diff --git a/apply.c b/apply.c
index 5cc5479c9c3..7f12ebf04c5 100644
--- a/apply.c
+++ b/apply.c
@@ -8,6 +8,7 @@
  */
 
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "object-store.h"
 #include "blob.h"
diff --git a/archive-tar.c b/archive-tar.c
index f8fad2946ef..9406f03e804 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -1,7 +1,8 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "tar.h"
 #include "archive.h"
diff --git a/archive.c b/archive.c
index f2a8756d84f..35719e5e367 100644
--- a/archive.c
+++ b/archive.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/attr.c b/attr.c
index 1053dfcd4b6..657ee52229e 100644
--- a/attr.c
+++ b/attr.c
@@ -7,6 +7,7 @@
  */
 
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "exec-cmd.h"
 #include "attr.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 71f925e456c..4d1609c9ac0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -5,7 +5,8 @@
  * See COPYING for licensing conditions
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "color.h"
 #include "builtin.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index cc17635e765..5b8be7cb63b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "diff.h"
diff --git a/builtin/checkout--worker.c b/builtin/checkout--worker.c
index ede7dc32a43..0a7d762573c 100644
--- a/builtin/checkout--worker.c
+++ b/builtin/checkout--worker.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/builtin/config.c b/builtin/config.c
index 060cf9f3e05..ca006e9cc15 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "color.h"
 #include "parse-options.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index f3c89831d4a..590aefc6ead 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "alloc.h"
 #include "parse-options.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index afe679368de..113f22c09dd 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "alloc.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 0feef8caf6d..cae804a1908 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "alloc.h"
 #include "config.h"
 #include "parse-options.h"
 #include "fsmonitor.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index f7821c5fbba..a08e5841ddb 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #include "cache.h"
+#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "blob.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6648f2daef5..7e4b69f9a3e 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "alloc.h"
 #include "config.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/log.c b/builtin/log.c
index 04412dd9c93..85540963d95 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -4,7 +4,8 @@
  * (C) Copyright 2006 Linus Torvalds
  *		 2006 Junio Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 0a3c10a0966..716a23f880d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -8,6 +8,7 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "parse-options.h"
 #include "builtin.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 06d81400f55..ec721ffb947 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -4,6 +4,7 @@
  * Copyright (c) Junio C Hamano, 2006, 2009
  */
 #include "builtin.h"
+#include "alloc.h"
 #include "quote.h"
 #include "tree.h"
 #include "parse-options.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index edd7b931fdb..81290503775 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "alloc.h"
 #include "config.h"
 #include "pathspec.h"
 #include "lockfile.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 97959bfaf9e..29752e7afe6 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "cache.h"
+#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "commit.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 74a167a180c..72c33fd739a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "cache.h"
+#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "attr.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index f6493795318..545b368168f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -1,5 +1,5 @@
 #include "builtin.h"
-#include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "dir.h"
 #include "parse-options.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index e67999e5ebc..fd4f59ff2b9 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "commit.h"
 #include "refs.h"
diff --git a/builtin/revert.c b/builtin/revert.c
index 77d2035616e..62986a7b1b0 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "parse-options.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 8844f906557..dc198f79082 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -5,6 +5,7 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "alloc.h"
 #include "advice.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 4c173d8b37a..9edc785d8d2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1,5 +1,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
+#include "alloc.h"
 #include "repository.h"
 #include "cache.h"
 #include "config.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 855b68ec23b..62ed104c7e6 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -1,7 +1,8 @@
 /*
  * Copyright (c) 2011, Google Inc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "bulk-checkin.h"
 #include "lockfile.h"
 #include "repository.h"
diff --git a/cache-tree.c b/cache-tree.c
index 88c2c04f87f..256f98c3c33 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "lockfile.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/cache.h b/cache.h
index 12789903e88..0f1f9dde56b 100644
--- a/cache.h
+++ b/cache.h
@@ -656,81 +656,6 @@ void initialize_repository_version(int hash_algo, int reinit);
 void sanitize_stdfds(void);
 int daemonize(void);
 
-#define alloc_nr(x) (((x)+16)*3/2)
-
-/**
- * Dynamically growing an array using realloc() is error prone and boring.
- *
- * Define your array with:
- *
- * - a pointer (`item`) that points at the array, initialized to `NULL`
- *   (although please name the variable based on its contents, not on its
- *   type);
- *
- * - an integer variable (`alloc`) that keeps track of how big the current
- *   allocation is, initialized to `0`;
- *
- * - another integer variable (`nr`) to keep track of how many elements the
- *   array currently has, initialized to `0`.
- *
- * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
- * alloc)`.  This ensures that the array can hold at least `n` elements by
- * calling `realloc(3)` and adjusting `alloc` variable.
- *
- * ------------
- * sometype *item;
- * size_t nr;
- * size_t alloc
- *
- * for (i = 0; i < nr; i++)
- * 	if (we like item[i] already)
- * 		return;
- *
- * // we did not like any existing one, so add one
- * ALLOC_GROW(item, nr + 1, alloc);
- * item[nr++] = value you like;
- * ------------
- *
- * You are responsible for updating the `nr` variable.
- *
- * If you need to specify the number of elements to allocate explicitly
- * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
- *
- * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
- * added niceties.
- *
- * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
- */
-#define ALLOC_GROW(x, nr, alloc) \
-	do { \
-		if ((nr) > alloc) { \
-			if (alloc_nr(alloc) < (nr)) \
-				alloc = (nr); \
-			else \
-				alloc = alloc_nr(alloc); \
-			REALLOC_ARRAY(x, alloc); \
-		} \
-	} while (0)
-
-/*
- * Similar to ALLOC_GROW but handles updating of the nr value and
- * zeroing the bytes of the newly-grown array elements.
- *
- * DO NOT USE any expression with side-effect for any of the
- * arguments.
- */
-#define ALLOC_GROW_BY(x, nr, increase, alloc) \
-	do { \
-		if (increase) { \
-			size_t new_nr = nr + (increase); \
-			if (new_nr < nr) \
-				BUG("negative growth in ALLOC_GROW_BY"); \
-			ALLOC_GROW(x, new_nr, alloc); \
-			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
-			nr = new_nr; \
-		} \
-	} while (0)
-
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
diff --git a/chunk-format.c b/chunk-format.c
index 0275b74a895..f65e9a1e429 100644
--- a/chunk-format.c
+++ b/chunk-format.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "chunk-format.h"
 #include "csum-file.h"
 
diff --git a/commit-reach.c b/commit-reach.c
index 2e33c599a82..1f0ddc5c883 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "commit.h"
 #include "commit-graph.h"
 #include "decorate.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index e433740381b..3afbde78944 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -7,6 +7,7 @@
 #include "../strbuf.h"
 #include "../run-command.h"
 #include "../cache.h"
+#include "../alloc.h"
 #include "win32/lazyload.h"
 #include "../config.h"
 #include "dir.h"
diff --git a/config.c b/config.c
index 00090a32fc3..1d22f232516 100644
--- a/config.c
+++ b/config.c
@@ -5,7 +5,8 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "date.h"
 #include "branch.h"
 #include "config.h"
diff --git a/daemon.c b/daemon.c
index 0ae7d12b5c1..eb733d222fa 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "pkt-line.h"
 #include "run-command.h"
diff --git a/delta-islands.c b/delta-islands.c
index 8b234cb85b0..1cfdc2cc040 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "attr.h"
 #include "object.h"
 #include "blob.h"
diff --git a/diff.c b/diff.c
index 329eebf16a0..3c3565995d9 100644
--- a/diff.c
+++ b/diff.c
@@ -2,6 +2,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "tempfile.h"
 #include "quote.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index c0422d9e709..62c0299984e 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2005 Junio C Hamano
  */
 #include "cache.h"
+#include "alloc.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "object-store.h"
diff --git a/dir-iterator.c b/dir-iterator.c
index 3764dd81a18..87364d68a2e 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "dir.h"
 #include "iterator.h"
 #include "dir-iterator.h"
diff --git a/dir.c b/dir.c
index 4e99f0c868f..d3f1aeaca3b 100644
--- a/dir.c
+++ b/dir.c
@@ -5,7 +5,8 @@
  * Copyright (C) Linus Torvalds, 2005-2006
  *		 Junio Hamano, 2005-2006
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "dir.h"
 #include "object-store.h"
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index ac618641632..12d6aa398e9 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -16,7 +16,8 @@
  * You should have received a copy of the GNU General Public License
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "ewok.h"
 
 #define EWAH_MASK(x) ((eword_t)1 << (x % BITS_IN_EWORD))
diff --git a/ewah/ewah_bitmap.c b/ewah/ewah_bitmap.c
index 6fe48d3ae04..c6d4ffc87ca 100644
--- a/ewah/ewah_bitmap.c
+++ b/ewah/ewah_bitmap.c
@@ -17,9 +17,9 @@
  * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "git-compat-util.h"
+#include "alloc.h"
 #include "ewok.h"
 #include "ewok_rlw.h"
-#include "cache.h"
 
 static inline size_t min_size(size_t a, size_t b)
 {
diff --git a/fetch-pack.c b/fetch-pack.c
index 04016d1e325..271e2a6fbd6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "lockfile.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index f317f129904..d4d6fd3d9d9 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/fsck.c b/fsck.c
index 2b18717ee80..20e1aac39a9 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "object-store.h"
 #include "repository.h"
 #include "object.h"
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 899bfe9c813..b62acf44aee 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
+#include "gettext.h"
 #include "repository.h"
 #include "fsmonitor-ipc.h"
 #include "fsmonitor-settings.h"
diff --git a/help.c b/help.c
index 812af4cdea6..5f84a50b948 100644
--- a/help.c
+++ b/help.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "builtin.h"
 #include "exec-cmd.h"
diff --git a/http-backend.c b/http-backend.c
index 8ab58e55f85..d756d120dc9 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/line-log.c b/line-log.c
index a7f3e7f6ce4..4956eae748e 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "alloc.h"
 #include "line-range.h"
 #include "cache.h"
 #include "tag.h"
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index ee01bcd2cc3..1d25a5737db 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -1,6 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "commit.h"
 #include "config.h"
+#include "gettext.h"
 #include "revision.h"
 #include "strvec.h"
 #include "list-objects.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7ed21cb299c..e40ea9b0a8f 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "dir.h"
 #include "tag.h"
 #include "commit.h"
diff --git a/midx.c b/midx.c
index 7cfad04a240..84d7a53d66d 100644
--- a/midx.c
+++ b/midx.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "csum-file.h"
 #include "dir.h"
diff --git a/object-file.c b/object-file.c
index 939865c1ae0..18d65220d70 100644
--- a/object-file.c
+++ b/object-file.c
@@ -6,7 +6,8 @@
  * This handles basic git object files - packing, unpacking,
  * creation etc.
  */
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "string-list.h"
 #include "lockfile.h"
diff --git a/oid-array.c b/oid-array.c
index 73ba76e9e9a..e8228c777b1 100644
--- a/oid-array.c
+++ b/oid-array.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "oid-array.h"
 #include "hash-lookup.h"
 
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cfa67a510fd..155939e77b2 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d2a42abf28c..5a978341200 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tag.h"
diff --git a/pack-objects.c b/pack-objects.c
index 272e8d45173..ccab09fe654 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "object.h"
 #include "pack.h"
 #include "pack-objects.h"
diff --git a/packfile.c b/packfile.c
index 79e21ab18e7..3e3063de445 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "list.h"
 #include "pack.h"
 #include "repository.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 4f6819f2406..decdc8d8a1e 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/pretty.c b/pretty.c
index 1e1e21878c8..b6080844498 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "commit.h"
 #include "utf8.h"
diff --git a/prio-queue.c b/prio-queue.c
index d31b48e7250..dc2476be53a 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "prio-queue.h"
 
 static inline int compare(struct prio_queue *queue, int i, int j)
diff --git a/quote.c b/quote.c
index 26719d21d1e..2453397fbbd 100644
--- a/quote.c
+++ b/quote.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "quote.h"
 #include "strvec.h"
 
diff --git a/read-cache.c b/read-cache.c
index 35e5657877c..3cc8e312dce 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -4,6 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "diff.h"
 #include "diffcore.h"
diff --git a/ref-filter.c b/ref-filter.c
index f8203c6b052..c8230a08589 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,5 +1,5 @@
-#include "builtin.h"
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "wildmatch.h"
@@ -13,7 +13,6 @@
 #include "ref-filter.h"
 #include "revision.h"
 #include "utf8.h"
-#include "git-compat-util.h"
 #include "version.h"
 #include "trailer.h"
 #include "wt-status.h"
diff --git a/reflog-walk.c b/reflog-walk.c
index 8a4d8fa3bd5..4ba1a10c82c 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "commit.h"
 #include "refs.h"
 #include "diff.h"
diff --git a/refs.c b/refs.c
index e31dbcda599..f90f953551b 100644
--- a/refs.c
+++ b/refs.c
@@ -2,7 +2,8 @@
  * The backend-independent part of the reference module.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "hashmap.h"
 #include "lockfile.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 6f5a0709fba..186dcafcd00 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,5 @@
-#include "../cache.h"
+#include "../git-compat-util.h"
+#include "../alloc.h"
 #include "../config.h"
 #include "../refs.h"
 #include "refs-internal.h"
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 32afd8a40b0..dc1ca49c85f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -1,4 +1,5 @@
-#include "../cache.h"
+#include "../git-compat-util.h"
+#include "../alloc.h"
 #include "../refs.h"
 #include "refs-internal.h"
 #include "ref-cache.h"
diff --git a/refspec.c b/refspec.c
index 63e3112104a..ec336ec5e9c 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "strvec.h"
 #include "refs.h"
 #include "refspec.h"
diff --git a/remote-curl.c b/remote-curl.c
index a76b6405eb2..380ef3fccfb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "remote.h"
 #include "connect.h"
diff --git a/remote.c b/remote.c
index 60869beebe7..daade49a6f6 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "remote.h"
 #include "urlmatch.h"
diff --git a/rerere.c b/rerere.c
index 876ab435da9..d4bcb908531 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "lockfile.h"
 #include "string-list.h"
diff --git a/revision.c b/revision.c
index 21f5f572c22..b8f925f088c 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "object-store.h"
 #include "tag.h"
diff --git a/sequencer.c b/sequencer.c
index 65a34f9676c..fcf8740ce1c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/server-info.c b/server-info.c
index 0ec6c0c1654..f07daa16f36 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "dir.h"
 #include "repository.h"
 #include "refs.h"
diff --git a/shallow.c b/shallow.c
index 17f9bcdb5f3..7dc73fb8989 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
diff --git a/sigchain.c b/sigchain.c
index 022677b6aba..ee778c0580b 100644
--- a/sigchain.c
+++ b/sigchain.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "sigchain.h"
 
 #define SIGCHAIN_MAX_SIGNALS 32
diff --git a/sparse-index.c b/sparse-index.c
index 147a13386a4..63216b3e57f 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "repository.h"
 #include "sparse-index.h"
 #include "tree.h"
diff --git a/split-index.c b/split-index.c
index 5d0f04763ea..95ecfa53195 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "split-index.h"
 #include "ewah/ewok.h"
 
diff --git a/strbuf.c b/strbuf.c
index c383f41a3c5..bc4c2c09e60 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/string-list.c b/string-list.c
index 42bacaec55b..db473f273e1 100644
--- a/string-list.c
+++ b/string-list.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "string-list.h"
+#include "alloc.h"
 
 void string_list_init_nodup(struct string_list *list)
 {
diff --git a/strvec.c b/strvec.c
index 61a76ce6cb9..94d504e3805 100644
--- a/strvec.c
+++ b/strvec.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "strvec.h"
+#include "alloc.h"
 #include "strbuf.h"
 
 const char *empty_strvec[] = { NULL };
diff --git a/submodule-config.c b/submodule-config.c
index 4dc61b3a78a..bb7c35fc317 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "dir.h"
 #include "repository.h"
 #include "config.h"
diff --git a/submodule.c b/submodule.c
index 3a0dfc417c0..340ffad1c29 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,5 +1,5 @@
-
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "repository.h"
 #include "config.h"
 #include "submodule-config.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 2f65c7f6a55..883d8e20a8e 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,5 +1,5 @@
 #include "test-tool.h"
-#include "cache.h"
+#include "alloc.h"
 #include "commit.h"
 #include "commit-reach.h"
 #include "config.h"
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 04900bb4c3a..9f46ae12f50 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,5 +1,7 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "thread-utils.h"
+#include "trace.h"
 #include "trace2/tr2_tls.h"
 
 /*
diff --git a/trailer.c b/trailer.c
index 0fd5b142a37..72c3fed5c6e 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "alloc.h"
 #include "config.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/transport.c b/transport.c
index 77a61a9d7bb..ac9e06a6cea 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "transport.h"
 #include "hook.h"
@@ -10,6 +11,7 @@
 #include "walker.h"
 #include "bundle.h"
 #include "dir.h"
+#include "gettext.h"
 #include "refs.h"
 #include "refspec.h"
 #include "branch.h"
diff --git a/tree-walk.c b/tree-walk.c
index 74f4d710e8f..d22f3fe5b05 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "tree-walk.h"
+#include "alloc.h"
 #include "dir.h"
 #include "object-store.h"
 #include "tree.h"
diff --git a/userdiff.c b/userdiff.c
index 94cca1a2a8e..7f0ecbffbb5 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,7 +1,9 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "config.h"
 #include "userdiff.h"
 #include "attr.h"
+#include "strbuf.h"
 
 static struct userdiff_driver *drivers;
 static int ndrivers;
diff --git a/worktree.c b/worktree.c
index aa43c641191..c99939a4d1f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,5 @@
-#include "cache.h"
+#include "git-compat-util.h"
+#include "alloc.h"
 #include "repository.h"
 #include "refs.h"
 #include "strbuf.h"
-- 
gitgitgadget

