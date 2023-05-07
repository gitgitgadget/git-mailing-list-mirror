Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ABDC77B7D
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjEGDqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjEGDqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:46:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D61816B
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso32726535e9.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431160; x=1686023160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6dG7AlPVVznMsyldRUr8JW9bbpEOQeRtR0Onz6ehVQ=;
        b=R7J/wsA24sdrwmR7eWHTHHEFaifbIHkUK3OVvuO44VHzzJj1mWixM3I5xudfb5wZAu
         5MdQgOzLZ5yfneOk25GQqk6XCmbs3S4OXeU4UmX3UlaxHj1zfDFhW1d2A1Ukg9GvTU28
         afzWxjfPmc2s4Pul0Sih5hETdtnL7W3nmzc6DAqwSAix3R4zGTfoAjf5nVnGHr6h1cbx
         d6KgeS+GAKR3297Xj+XbHSEBHTNAUG1RiKH7JbURLTfTlVfO6+nwT0BYYQRPRCQ3B7US
         jfgYZFweGSLIF8eUfR8sdE1B3/9kknAq2JbLm9n+d8FxY/fcLc06TdVuT3Ba0PnqHQrz
         mc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431160; x=1686023160;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6dG7AlPVVznMsyldRUr8JW9bbpEOQeRtR0Onz6ehVQ=;
        b=k1W3xWhThshlmYBRXMd0RPFk/oqP7boZGJi6H3sKU1PiMnjcOqSywyj9JZlqghiHMe
         MoMGkFg4/yBtwkN7pARyGGSfX4w+NE9M2nvEv3mcENdt8mrkiPrR4OG3GPMPKF+B9t/4
         mwRplbOsZo7lVCyaJxV1irNO9Kihemh61w2vTJuQs3Sc7hdZfGmVER9cIcs6krN/jbHm
         lA+nx6k5pqxrc4x83ngaeE3Mo4ObKW2Nog77feUuH9qc9HErUylc2h3RA7MekRY+cYit
         9CsSLhEF6YbcFxJvgcUxzkNq14a/QVB70pwn+JMphNQLsu/tsz3BxkseR6Sj15RqfCY/
         v/5w==
X-Gm-Message-State: AC+VfDzp8BduoSCKVZQAbOX+g3Ow2fZUYmuih+gfzfEjGyrRUz+YaX2i
        2PhNfIOWvnY1WxPRQcs7MgmNgAq3vF4=
X-Google-Smtp-Source: ACHHUZ7I4PlPcUyRCMADrorvks/J//lWKRCZv1C68/8GoG0v4p4CwfI5E1sioUsbr1Ik3IpKKJQozg==
X-Received: by 2002:a1c:ed03:0:b0:3f3:468d:d00f with SMTP id l3-20020a1ced03000000b003f3468dd00fmr4097299wmh.20.1683431160466;
        Sat, 06 May 2023 20:46:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ed2c0a0f37sm12530709wmg.35.2023.05.06.20.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:00 -0700 (PDT)
Message-Id: <fe50a0d0e77d940779004d9327c5ccc98de3b3ba.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:34 +0000
Subject: [PATCH 09/24] name-hash.h: move declarations for name-hash.c from
 cache.h
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

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                             |  1 +
 builtin/mv.c                        |  1 +
 cache.h                             |  9 ---------
 dir.c                               |  1 +
 entry.c                             |  1 +
 merge-recursive.c                   |  1 +
 name-hash.c                         |  1 +
 name-hash.h                         | 16 ++++++++++++++++
 read-cache.c                        |  1 +
 sparse-index.c                      |  1 +
 t/helper/test-lazy-init-name-hash.c |  1 +
 unpack-trees.c                      |  1 +
 12 files changed, 26 insertions(+), 9 deletions(-)
 create mode 100644 name-hash.h

diff --git a/apply.c b/apply.c
index 6212ab3a1b3..3da33bb88fd 100644
--- a/apply.c
+++ b/apply.c
@@ -23,6 +23,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "name-hash.h"
 #include "object-name.h"
 #include "object-file.h"
 #include "parse-options.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 665bd274485..e058b574654 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "name-hash.h"
 #include "object-file.h"
 #include "pathspec.h"
 #include "lockfile.h"
diff --git a/cache.h b/cache.h
index d31b1515069..316904da392 100644
--- a/cache.h
+++ b/cache.h
@@ -245,12 +245,6 @@ struct index_state {
 void index_state_init(struct index_state *istate, struct repository *r);
 void release_index(struct index_state *istate);
 
-/* Name hashing */
-int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
-void add_name_hash(struct index_state *istate, struct cache_entry *ce);
-void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
-void free_name_hash(struct index_state *istate);
-
 /* Cache entry creation and cleanup */
 
 /*
@@ -377,9 +371,6 @@ int repo_index_has_changes(struct repository *repo,
 
 int verify_path(const char *path, unsigned mode);
 int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
-int index_dir_exists(struct index_state *istate, const char *name, int namelen);
-void adjust_dirname_case(struct index_state *istate, char *name);
-struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
 /*
  * Searches for an entry defined by name and namelen in the given index.
diff --git a/dir.c b/dir.c
index a7469df3ac7..029aab36fe8 100644
--- a/dir.c
+++ b/dir.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "name-hash.h"
 #include "object-file.h"
 #include "object-store.h"
 #include "attr.h"
diff --git a/entry.c b/entry.c
index 91a540bd29f..7791cc999cc 100644
--- a/entry.c
+++ b/entry.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "name-hash.h"
 #include "streaming.h"
 #include "submodule.h"
 #include "symlinks.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 8e87b6386d9..b341ba4f38d 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -23,6 +23,7 @@
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "match-trees.h"
+#include "name-hash.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/name-hash.c b/name-hash.c
index fb13716e430..52ce47ea394 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "environment.h"
 #include "gettext.h"
+#include "name-hash.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2.h"
diff --git a/name-hash.h b/name-hash.h
new file mode 100644
index 00000000000..b1b4b0fb337
--- /dev/null
+++ b/name-hash.h
@@ -0,0 +1,16 @@
+#ifndef NAME_HASH_H
+#define NAME_HASH_H
+
+struct cache_entry;
+struct index_state;
+
+int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+void adjust_dirname_case(struct index_state *istate, char *name);
+struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+
+int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
+void add_name_hash(struct index_state *istate, struct cache_entry *ce);
+void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
+void free_name_hash(struct index_state *istate);
+
+#endif /* NAME_HASH_H */
diff --git a/read-cache.c b/read-cache.c
index b99dbfd16b0..e1016ae0317 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
+#include "name-hash.h"
 #include "object-name.h"
 #include "resolve-undo.h"
 #include "revision.h"
diff --git a/sparse-index.c b/sparse-index.c
index 886054729e5..60451daae80 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
+#include "name-hash.h"
 #include "repository.h"
 #include "sparse-index.h"
 #include "tree.h"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index b83a75d19f6..6944b7e825f 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -2,6 +2,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "environment.h"
+#include "name-hash.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index e8c32a40dcb..078c53f7a13 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "name-hash.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
-- 
gitgitgadget

