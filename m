Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6C2C7EE24
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240132AbjELHFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240088AbjELHEs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE865B9
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-30771c68a9eso8748427f8f.2
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875085; x=1686467085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6dG7AlPVVznMsyldRUr8JW9bbpEOQeRtR0Onz6ehVQ=;
        b=W418j3KXwmyiK3uFuCrpnzt+cZ+aAOVbQnhQyERGwjUxU5nhM7s1fUq2Qtgqy+gC7b
         9/7+32nFKX5pdgHYqcbw2bDzqGml8WGUEo/otg8LnxXpBMYTQZWLy/ydRtQeU3ZAyxTO
         VThcJMK7pRFC01KTS8UTqDa3ezbcOdailI2eYAcm+kdEA0ZfbLaeAcB+HVWb0IK9ULyQ
         W+o94u30yiY6iIIVFiJha0140M2yObVNFYvnMschzvXtb5E4JekjBA2qULX6OACdnLkH
         qhDxJxiKiqwHwCPYLIV0RgpCUEDHp1sbfjE7oZgophpXwAG5r0MeDbb5a/9tUua2U9DB
         TOsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875085; x=1686467085;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6dG7AlPVVznMsyldRUr8JW9bbpEOQeRtR0Onz6ehVQ=;
        b=Ip7Pa7DmH9WRUXpz9296uY36CPIebK7Qkq8SugZmHWCzPsju54clCFMpu98eRlfqJQ
         iIdQtON5Yb+tn0myjXZiGbrPgQPz/4n+SKkfUtJ6XjdwF+QkrSA3yIbXdY8ierdnb7uc
         8sOnARF9/K1I91zJJzUDekKGAX9RpXZQ4wKXUT278ftXiWrGWQ6MgfnLYeaf0ZSGX8Mk
         59agBpUQYVJ3WCeG1gR727jAz+QUZHXajQ8LAtz+NhJMY5Va/qahi0sx8CY+c/lu/qba
         gmoAsUQAz+i0/o12MtNEwVsHtI5lHCj1F/ACvneAGbLNak8Y+KI5rVrBGq60VnKNtRai
         MxqA==
X-Gm-Message-State: AC+VfDwGPBXIbOH2bYM1pEBIHRNTdY4r/ZT+KjTYAgSp/BpgISBOGw2D
        FMxLpSTJGJ3rONdn1pwGB5n+/7noM9o=
X-Google-Smtp-Source: ACHHUZ7CJCmga4rmpEongxcAJ+srPPpjHgWnNHYpfuGVbOH7jTDPzZSQtgKJFYRQElVdczPrrSgdrQ==
X-Received: by 2002:a5d:6401:0:b0:304:7237:729a with SMTP id z1-20020a5d6401000000b003047237729amr13960890wru.67.1683875084690;
        Fri, 12 May 2023 00:04:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18-20020a5d6b52000000b002ff2c39d072sm22630676wrw.104.2023.05.12.00.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:44 -0700 (PDT)
Message-Id: <7d48dbfe0aa9e54367cc32752d9f9d341e6bee35.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:11 +0000
Subject: [PATCH v2 10/27] name-hash.h: move declarations for name-hash.c from
 cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
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

