Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAD8C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbjELHHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbjELHFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:05:54 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3441FE73B
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:05:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41dceb9d1so68146435e9.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875098; x=1686467098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbZosHB9GA2REJQSr4iixKOgO8yipIgeEWJVWDTBTQc=;
        b=YCe2DMN47Z5d9kigY6nCxT3E5bHGfcTrFmljZUL+J6qSgXW6pZ35wJNqfraIRD6QgO
         dMBB8kIRIZeeoy5yMCZhLgtinJa9smus12wvztLFZTxyWrD5hVLXvm78FcZyeV6qzNRl
         ItbW4fhrlp9UR2JVd/NHevIRcwqICwo4g8dewAXMJooUTLlLLRmbSepuGT8vgRwJgXdf
         gugxzEsc/jhZpQSIIJ/VnQVaFwvIJjRr2J/X3TANnYgb3fGRs9Ep0OxAw6gN0q1eub03
         KB8IvfiAhg9ap2vOB+7Vl2ZczGfriSQhyEQJ7ey2ABKtf0Vr0/0LxbwhiRAfy0k5rcYi
         8fBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875098; x=1686467098;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbZosHB9GA2REJQSr4iixKOgO8yipIgeEWJVWDTBTQc=;
        b=EinSc2nvPCDzdlH+ntRjOjYUSf1y/PH8kgxM1cYD2zHZmbKIryWMiu0FaWV5eq021W
         ePK5sz+LdeuA8gv/fJvvMH7uTQZnnJ6rEnNw1+VkwRfW3UnV2eGjPXZN1JaGaC+e9I2K
         vUnRZBduFK4Rd2OYvNyGV5IBK6jWmdq2h0FVJTYs8/MS2+sh4mk7voWosti4GCuwiSRM
         x+yxQoWBeMucRvXEJUtY3PlfiQtl1BWaTPTBRZ956Vt9Mbva8UWyLDP8WcGRrfnJHT91
         TxtjA9ngWzOoOFnlIieqSIn9Dbx3iRS2LOtCClcexGZRIWEeZjVzXmp2EEuptotXAfVs
         a+sw==
X-Gm-Message-State: AC+VfDx6a8dxMP/6iII/718UuoOEiWnkLcJk+ZYOvPeqf9a3LqHF+zUX
        V5fRuOwfU8MBXsJ7OSWHgSRMUDihleY=
X-Google-Smtp-Source: ACHHUZ5ZeXurhAmM048QRblOm10ybqxb2JRElmQDfiv9Ih/9HV8ka5b5jzH03SwAJLfUkwQ7+NcLgQ==
X-Received: by 2002:a05:600c:cf:b0:3f4:9bee:b9c with SMTP id u15-20020a05600c00cf00b003f49bee0b9cmr6196370wmm.18.1683875096786;
        Fri, 12 May 2023 00:04:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f41bb52834sm18322503wmi.38.2023.05.12.00.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:56 -0700 (PDT)
Message-Id: <41d48379b3dc4b621b097e145fc3be6257466654.1683875072.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:27 +0000
Subject: [PATCH v2 26/27] hash-ll, hashmap: move oidhash() to hash-ll
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

oidhash() was used by both hashmap and khash, which makes sense.
However, the location of this function in hashmap.[ch] meant that
khash.h had to depend upon hashmap.h, making people unfamiliar with
khash think that it was built upon hashmap.  (Or at least, I personally
was confused for a while about this in the past.)

Move this function to hash-ll, so that khash.h can stop depending upon
hashmap.h.

This has another benefit as well: it allows us to remove hashmap.h's
dependency on hash-ll.h.  While some callers of hashmap.h were making
use of oidhash, most were not, so this change provides another way to
reduce the number of includes.

Diff best viewed with `--color-moved`.  Note that there's a small but
important change to khash.h in this patch as well to allow this move,
which is easy to overlook.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                       |   2 +-
 archive-tar.c                 |   2 +-
 archive-zip.c                 |   2 +-
 archive.c                     |   2 +-
 attr.c                        |   2 +-
 bisect.c                      |   2 +-
 blame.c                       |   2 +-
 builtin/blame.c               |   2 +-
 builtin/cat-file.c            |   2 +-
 builtin/checkout.c            |   2 +-
 builtin/clone.c               |   2 +-
 builtin/commit-graph.c        |   2 +-
 builtin/commit-tree.c         |   2 +-
 builtin/count-objects.c       |   2 +-
 builtin/describe.c            |   2 +-
 builtin/difftool.c            |   2 +-
 builtin/fast-export.c         |   2 +-
 builtin/fast-import.c         |   2 +-
 builtin/fetch.c               |   2 +-
 builtin/fsck.c                |   2 +-
 builtin/gc.c                  |   2 +-
 builtin/grep.c                |   2 +-
 builtin/hash-object.c         |   3 +-
 builtin/index-pack.c          |   3 +-
 builtin/log.c                 |   2 +-
 builtin/ls-tree.c             |   2 +-
 builtin/merge-tree.c          |   2 +-
 builtin/mktag.c               |   3 +-
 builtin/mktree.c              |   3 +-
 builtin/multi-pack-index.c    |   3 +-
 builtin/notes.c               |   2 +-
 builtin/pack-objects.c        |   2 +-
 builtin/pack-redundant.c      |   2 +-
 builtin/prune.c               |   3 +-
 builtin/receive-pack.c        |   2 +-
 builtin/remote.c              |   2 +-
 builtin/repack.c              |   2 +-
 builtin/replace.c             |   2 +-
 builtin/rev-list.c            |   2 +-
 builtin/show-ref.c            |   2 +-
 builtin/submodule--helper.c   |   2 +-
 builtin/tag.c                 |   2 +-
 builtin/unpack-file.c         |   2 +-
 builtin/unpack-objects.c      |   2 +-
 builtin/verify-commit.c       |   2 +-
 bulk-checkin.c                |   2 +-
 bundle-uri.c                  |   2 +-
 bundle.c                      |   2 +-
 cache-tree.c                  |   2 +-
 combine-diff.c                |   2 +-
 commit-graph.c                |   2 +-
 commit-graph.h                |   2 +-
 commit.c                      |   2 +-
 config.c                      |   2 +-
 connected.c                   |   2 +-
 convert.c                     |   2 +-
 decorate.c                    |   1 -
 diagnose.c                    |   2 +-
 diff.c                        |   2 +-
 diffcore-rename.c             |   2 +-
 dir.c                         |   2 +-
 dir.h                         |   1 +
 entry.c                       |   2 +-
 environment.c                 |   2 +-
 fetch-pack.c                  |   2 +-
 fmt-merge-msg.c               |   2 +-
 fsck.c                        |   3 +-
 grep.c                        |   2 +-
 hash-ll.h                     |  19 ++
 hashmap.h                     |  21 --
 http-backend.c                |   2 +-
 http-push.c                   |   2 +-
 http-walker.c                 |   2 +-
 http.c                        |   2 +-
 khash.h                       |   1 -
 list-objects-filter.c         |   2 +-
 list-objects.c                |   2 +-
 log-tree.c                    |   2 +-
 mailmap.c                     |   2 +-
 match-trees.c                 |   3 +-
 merge-blobs.c                 |   2 +-
 merge-ort.c                   |   2 +-
 merge-recursive.c             |   2 +-
 midx.c                        |   2 +-
 notes-cache.c                 |   3 +-
 notes-merge.c                 |   2 +-
 notes.c                       |   2 +-
 object-name.c                 |   2 +-
 object-store-ll.h             | 533 ++++++++++++++++++++++++++++++++++
 object-store.h                | 528 +--------------------------------
 oss-fuzz/fuzz-pack-idx.c      |   2 +-
 pack-bitmap-write.c           |   2 +-
 pack-bitmap.c                 |   2 +-
 pack-check.c                  |   2 +-
 pack-mtimes.c                 |   3 +-
 pack-objects.h                |   2 +-
 pack-revindex.c               |   3 +-
 pack-write.c                  |   1 +
 packfile.c                    |   2 +-
 path.c                        |   2 +-
 promisor-remote.c             |   2 +-
 protocol-caps.c               |   2 +-
 prune-packed.c                |   2 +-
 reachable.c                   |   2 +-
 read-cache.c                  |   2 +-
 ref-filter.c                  |   2 +-
 reflog.c                      |   2 +-
 refs.c                        |   2 +-
 remote.c                      |   2 +-
 remote.h                      |   1 +
 replace-object.c              |   2 +-
 replace-object.h              |   2 +-
 repository.c                  |   2 +-
 rerere.c                      |   2 +-
 revision.c                    |   2 +-
 send-pack.c                   |   2 +-
 sequencer.c                   |   2 +-
 serve.c                       |   1 +
 server-info.c                 |   2 +-
 shallow.c                     |   2 +-
 streaming.c                   |   2 +-
 submodule-config.c            |   2 +-
 submodule.c                   |   2 +-
 t/helper/test-pack-mtimes.c   |   2 +-
 t/helper/test-partial-clone.c |   2 +-
 t/helper/test-read-graph.c    |   2 +-
 t/helper/test-read-midx.c     |   2 +-
 t/helper/test-ref-store.c     |   3 +-
 t/helper/test-repository.c    |   2 +-
 tag.c                         |   2 +-
 tmp-objdir.c                  |   2 +-
 transport.c                   |   2 +-
 tree-walk.c                   |   2 +-
 tree.c                        |   2 +-
 unpack-trees.c                |   2 +-
 upload-pack.c                 |   2 +-
 walker.c                      |   3 +-
 xdiff-interface.c             |   3 +-
 138 files changed, 699 insertions(+), 678 deletions(-)
 create mode 100644 object-store-ll.h

diff --git a/apply.c b/apply.c
index 2f66f93fec5..8bd0109fcc8 100644
--- a/apply.c
+++ b/apply.c
@@ -12,7 +12,7 @@
 #include "alloc.h"
 #include "base85.h"
 #include "config.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "blob.h"
 #include "delta.h"
 #include "diff.h"
diff --git a/archive-tar.c b/archive-tar.c
index 4cd81d8161e..fc06ff4c5d6 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "streaming.h"
 #include "run-command.h"
 #include "write-or-die.h"
diff --git a/archive-zip.c b/archive-zip.c
index d0d065a312e..b4382640966 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "userdiff.h"
 #include "write-or-die.h"
 #include "xdiff-interface.h"
diff --git a/archive.c b/archive.c
index 802a34d6b91..0e5065fd505 100644
--- a/archive.c
+++ b/archive.c
@@ -10,7 +10,7 @@
 #include "pretty.h"
 #include "setup.h"
 #include "refs.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/attr.c b/attr.c
index 435b51e11ff..f178190c5de 100644
--- a/attr.c
+++ b/attr.c
@@ -19,7 +19,7 @@
 #include "quote.h"
 #include "read-cache-ll.h"
 #include "revision.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "setup.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/bisect.c b/bisect.c
index 9f7cf0be073..1be8e0a2711 100644
--- a/bisect.c
+++ b/bisect.c
@@ -18,7 +18,7 @@
 #include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "dir.h"
 
diff --git a/blame.c b/blame.c
index b74ee70decf..1d25cd29fce 100644
--- a/blame.c
+++ b/blame.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "refs.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "cache-tree.h"
 #include "mergesort.h"
 #include "convert.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 2df6039a6e0..e811e7fbfb1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -29,7 +29,7 @@
 #include "dir.h"
 #include "progress.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pager.h"
 #include "blame.h"
 #include "refs.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 9646e7209ca..48ccca95a1a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -21,7 +21,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 11e2359c548..fd6ee8c2723 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -18,7 +18,7 @@
 #include "mem-pool.h"
 #include "merge-recursive.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 6c5cb33f6a9..687a686269a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,7 +23,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 96a8a677327..48fa9f20c97 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -9,7 +9,7 @@
 #include "parse-options.h"
 #include "repository.h"
 #include "commit-graph.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "progress.h"
 #include "replace-object.h"
 #include "tag.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d2121f30d45..02625e71761 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "repository.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index c9f82d0bce9..97cdfb0ac57 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -14,7 +14,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/describe.c b/builtin/describe.c
index eb19ab0bbbe..7ce23e1b8e6 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -19,7 +19,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "wildmatch.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 4a22de3eddb..e2c9ab7d5d7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -28,7 +28,7 @@
 #include "strbuf.h"
 #include "lockfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 5f3ffd6912f..56dc69fac18 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -10,7 +10,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 5698b92ae7d..2ee19c73733 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -21,7 +21,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
 #include "khash.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4dbacd8f188..86d409a6de3 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -11,7 +11,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oidset.h"
 #include "oid-array.h"
 #include "commit.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index d707ca32a61..a04c15e5e81 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -20,7 +20,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 9ecc2513e9f..7484946c506 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -27,7 +27,7 @@
 #include "commit-graph.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "path.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 6bc8abcd3e1..72e70b3a48d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -27,7 +27,7 @@
 #include "submodule-config.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
 #include "pager.h"
 #include "path.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index a3801211666..5ffec99dcea 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -10,12 +10,13 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "write-or-die.h"
 
 /*
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bb67e166559..820860265d0 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -14,12 +14,13 @@
 #include "progress.h"
 #include "fsck.h"
 #include "exec-cmd.h"
+#include "strbuf.h"
 #include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
 #include "pack-revindex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/builtin/log.c b/builtin/log.c
index 676de107d61..d6543ba1f63 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pager.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index c06858de4bf..4e17f13648e 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -8,7 +8,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "blob.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index aa8040c2a6a..23d7e98db0d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -9,7 +9,7 @@
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "blob.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 44fa56eff38..43e2766db49 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -2,10 +2,11 @@
 #include "gettext.h"
 #include "hex.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "tag.h"
 #include "replace-object.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "fsck.h"
 #include "config.h"
 
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 09a7bd5c5c2..0eea810c7ea 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -8,9 +8,10 @@
 #include "gettext.h"
 #include "hex.h"
 #include "quote.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "parse-options.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 5bb71bce08d..a31dde1db9e 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -5,8 +5,9 @@
 #include "gettext.h"
 #include "parse-options.h"
 #include "midx.h"
+#include "strbuf.h"
 #include "trace2.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]" \
diff --git a/builtin/notes.c b/builtin/notes.c
index 0a870d90836..0a19796f734 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -14,7 +14,7 @@
 #include "hex.h"
 #include "notes.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
 #include "blob.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a5b466839ba..aa595f6a4a4 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,7 +34,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 43e9d12dfdc..4c735ba069c 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "repository.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 #define BLKSIZE 512
 
diff --git a/builtin/prune.c b/builtin/prune.c
index a46c5aa2b5b..cfb863ae848 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "commit.h"
 #include "diff.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
@@ -13,7 +14,7 @@
 #include "replace-object.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "shallow.h"
 
 static const char * const prune_usage[] = {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d1718a3ac90..91caaf87066 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -30,7 +30,7 @@
 #include "oidset.h"
 #include "packfile.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "protocol.h"
 #include "commit-reach.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 3794f13330d..7d96687ec74 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -11,7 +11,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index fe8d5810d48..6c896c9c805 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -16,7 +16,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "promisor-remote.h"
 #include "shallow.h"
 #include "pack.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index a2f57a56b3e..20c67a58890 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -20,7 +20,7 @@
 #include "run-command.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "replace-object.h"
 #include "repository.h"
 #include "tag.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 8029f3de53c..ff715d6918f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -12,7 +12,7 @@
 #include "object.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pack.h"
 #include "pack-bitmap.h"
 #include "log-tree.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index e07e9ca862f..5110814f796 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "object.h"
 #include "tag.h"
 #include "string-list.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6acba4ebb30..baf6ff88c3c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,7 +29,7 @@
 #include "diff.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 87963d2cc0e..076f832802c 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -15,7 +15,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b35a4b9dfee..6842a6c4996 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -2,7 +2,7 @@
 #include "config.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "wrapper.h"
 
 static char *create_temp_file(struct object_id *oid)
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 85baf6a131a..b4b46ae7291 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index aa34fb896ac..9680b587013 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -9,7 +9,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "repository.h"
 #include "commit.h"
 #include "run-command.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index d843279715c..e2f71db0f60 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -16,7 +16,7 @@
 #include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "wrapper.h"
 
 static int odb_transaction_nesting;
diff --git a/bundle-uri.c b/bundle-uri.c
index 1b62902f014..a70c8887fd1 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -4,7 +4,7 @@
 #include "copy.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "refs.h"
 #include "run-command.h"
 #include "hashmap.h"
diff --git a/bundle.c b/bundle.c
index a5505368de5..8d5936c4212 100644
--- a/bundle.c
+++ b/bundle.c
@@ -4,7 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "repository.h"
 #include "object.h"
 #include "commit.h"
diff --git a/cache-tree.c b/cache-tree.c
index 077932c2db5..84d7491420e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -8,7 +8,7 @@
 #include "cache-tree.h"
 #include "bulk-checkin.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/combine-diff.c b/combine-diff.c
index 1e3cd7fb170..11e9d7494a1 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "convert.h"
 #include "blob.h"
diff --git a/commit-graph.c b/commit-graph.c
index 25cbd66c33a..9e989f43491 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -12,7 +12,7 @@
 #include "hash-lookup.h"
 #include "commit-graph.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "path.h"
 #include "alloc.h"
diff --git a/commit-graph.h b/commit-graph.h
index 83aaa1dbb92..5e534f0fcc8 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
diff --git a/commit.c b/commit.c
index 10676165a1d..8dfc298d6e6 100644
--- a/commit.c
+++ b/commit.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "repository.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pkt-line.h"
 #include "utf8.h"
 #include "diff.h"
diff --git a/config.c b/config.c
index 0b2a9f1bd89..e08e2332a68 100644
--- a/config.c
+++ b/config.c
@@ -25,7 +25,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pager.h"
 #include "path.h"
 #include "utf8.h"
diff --git a/connected.c b/connected.c
index d672521da41..8f89376dbcf 100644
--- a/connected.c
+++ b/connected.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
diff --git a/convert.c b/convert.c
index 1f2cfc5f457..0010828386f 100644
--- a/convert.c
+++ b/convert.c
@@ -5,7 +5,7 @@
 #include "copy.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/decorate.c b/decorate.c
index 71e79daa825..a5c43c0c146 100644
--- a/decorate.c
+++ b/decorate.c
@@ -3,7 +3,6 @@
  * data.
  */
 #include "git-compat-util.h"
-#include "hashmap.h"
 #include "object.h"
 #include "decorate.h"
 
diff --git a/diagnose.c b/diagnose.c
index c8c7ebcfa39..8430064000b 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "write-or-die.h"
diff --git a/diff.c b/diff.c
index 9d6b88ece90..36451b444b8 100644
--- a/diff.c
+++ b/diff.c
@@ -20,7 +20,7 @@
 #include "attr.h"
 #include "run-command.h"
 #include "utf8.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "userdiff.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 8e2e7a3ad73..926b554bd59 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -6,7 +6,7 @@
 #include "alloc.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "hashmap.h"
 #include "mem-pool.h"
 #include "oid-array.h"
diff --git a/dir.c b/dir.c
index 3cf3d428c7b..fada2713b9e 100644
--- a/dir.c
+++ b/dir.c
@@ -15,7 +15,7 @@
 #include "gettext.h"
 #include "name-hash.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "attr.h"
 #include "refs.h"
diff --git a/dir.h b/dir.h
index 79b85a01ee4..279a0660801 100644
--- a/dir.h
+++ b/dir.h
@@ -1,6 +1,7 @@
 #ifndef DIR_H
 #define DIR_H
 
+#include "hash-ll.h"
 #include "hashmap.h"
 #include "pathspec.h"
 #include "statinfo.h"
diff --git a/entry.c b/entry.c
index 041f5cf212d..f9a7c726a4d 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "blob.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/environment.c b/environment.c
index 56e8742ea66..5e9b331279f 100644
--- a/environment.c
+++ b/environment.c
@@ -20,7 +20,7 @@
 #include "commit.h"
 #include "strvec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "replace-object.h"
 #include "tmp-objdir.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 207548b3e5a..a432eacab99 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -24,7 +24,7 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index f096b1ef549..4da6c7a8bda 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -4,7 +4,7 @@
 #include "environment.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "hex.h"
diff --git a/fsck.c b/fsck.c
index 04e729953b2..a219d6f2c0a 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,8 +1,9 @@
 #include "git-compat-util.h"
 #include "alloc.h"
 #include "date.h"
+#include "dir.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
 #include "object.h"
diff --git a/grep.c b/grep.c
index f00986c451a..ebcd6474788 100644
--- a/grep.c
+++ b/grep.c
@@ -3,7 +3,7 @@
 #include "gettext.h"
 #include "grep.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/hash-ll.h b/hash-ll.h
index 80509251370..8d7973769fd 100644
--- a/hash-ll.h
+++ b/hash-ll.h
@@ -270,6 +270,25 @@ static inline void oid_set_algo(struct object_id *oid, const struct git_hash_alg
 	oid->algo = hash_algo_by_ptr(algop);
 }
 
+/*
+ * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
+ * for use in hash tables. Cryptographic hashes are supposed to have
+ * uniform distribution, so in contrast to `memhash()`, this just copies
+ * the first `sizeof(int)` bytes without shuffling any bits. Note that
+ * the results will be different on big-endian and little-endian
+ * platforms, so they should not be stored or transferred over the net.
+ */
+static inline unsigned int oidhash(const struct object_id *oid)
+{
+	/*
+	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
+	 * platforms that don't support unaligned reads.
+	 */
+	unsigned int hash;
+	memcpy(&hash, oid->hash, sizeof(hash));
+	return hash;
+}
+
 const char *empty_tree_oid_hex(void);
 const char *empty_blob_oid_hex(void);
 
diff --git a/hashmap.h b/hashmap.h
index 2695f3d3a6e..c8216e47bb2 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -1,8 +1,6 @@
 #ifndef HASHMAP_H
 #define HASHMAP_H
 
-#include "hash-ll.h"
-
 /*
  * Generic implementation of hash-based key-value mappings.
  *
@@ -120,25 +118,6 @@ unsigned int memhash(const void *buf, size_t len);
 unsigned int memihash(const void *buf, size_t len);
 unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
-/*
- * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
- * for use in hash tables. Cryptographic hashes are supposed to have
- * uniform distribution, so in contrast to `memhash()`, this just copies
- * the first `sizeof(int)` bytes without shuffling any bits. Note that
- * the results will be different on big-endian and little-endian
- * platforms, so they should not be stored or transferred over the net.
- */
-static inline unsigned int oidhash(const struct object_id *oid)
-{
-	/*
-	 * Equivalent to 'return *(unsigned int *)oid->hash;', but safe on
-	 * platforms that don't support unaligned reads.
-	 */
-	unsigned int hash;
-	memcpy(&hash, oid->hash, sizeof(hash));
-	return hash;
-}
-
 /*
  * struct hashmap_entry is an opaque structure representing an entry in the
  * hash table.
diff --git a/http-backend.c b/http-backend.c
index ddb9549ecbc..e1969c05dc6 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -16,7 +16,7 @@
 #include "url.h"
 #include "strvec.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "protocol.h"
 #include "date.h"
 #include "wrapper.h"
diff --git a/http-push.c b/http-push.c
index 29cf9db34e3..9ab2383d2b4 100644
--- a/http-push.c
+++ b/http-push.c
@@ -18,7 +18,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit-reach.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
diff --git a/http-walker.c b/http-walker.c
index bba306b2d5e..78d99f7c4b0 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -7,7 +7,7 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index bb58bb3e6a3..25e4c8a1ae9 100644
--- a/http.c
+++ b/http.c
@@ -18,7 +18,7 @@
 #include "protocol.h"
 #include "string-list.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
 static int trace_curl_data = 1;
diff --git a/khash.h b/khash.h
index a0a08dad8b7..ff881631778 100644
--- a/khash.h
+++ b/khash.h
@@ -26,7 +26,6 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
 
-#include "hashmap.h"
 #include "hash.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 5d270ce5987..e075a66c99d 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -16,7 +16,7 @@
 #include "oidmap.h"
 #include "oidset.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/list-objects.c b/list-objects.c
index eecca721ac0..672a4cd5298 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -12,7 +12,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "trace.h"
 
 struct traversal_context {
diff --git a/log-tree.c b/log-tree.c
index 60b61597c42..f807e286c88 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -5,7 +5,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "repository.h"
 #include "tmp-objdir.h"
 #include "commit.h"
diff --git a/mailmap.c b/mailmap.c
index 5dc5223c430..3d6a5e9400f 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -3,7 +3,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "setup.h"
 
 const char *git_mailmap_file;
diff --git a/match-trees.c b/match-trees.c
index 6bc8eb76477..0885ac681cd 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,9 +1,10 @@
 #include "git-compat-util.h"
 #include "hex.h"
 #include "match-trees.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "tree-walk.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 static int score_missing(unsigned mode)
 {
diff --git a/merge-blobs.c b/merge-blobs.c
index 40c48e3eba6..9293cbf75c8 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -4,7 +4,7 @@
 #include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-ort.c b/merge-ort.c
index f4522951323..63786c81ece 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -34,7 +34,7 @@
 #include "match-trees.h"
 #include "mem-pool.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "path.h"
 #include "promisor-remote.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 35e1e7e1bef..43f6b2d0364 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -26,7 +26,7 @@
 #include "name-hash.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
 #include "revision.h"
diff --git a/midx.c b/midx.c
index b500174d1f3..db459e448b7 100644
--- a/midx.c
+++ b/midx.c
@@ -9,7 +9,7 @@
 #include "lockfile.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
diff --git a/notes-cache.c b/notes-cache.c
index 14288caf98f..0e1d5b1ac7a 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -1,10 +1,11 @@
 #include "git-compat-util.h"
 #include "notes-cache.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pretty.h"
 #include "repository.h"
 #include "commit.h"
 #include "refs.h"
+#include "strbuf.h"
 
 static int notes_cache_match_validity(struct repository *r,
 				      const char *ref,
diff --git a/notes-merge.c b/notes-merge.c
index 4be11a01550..071947894ed 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
 #include "diff.h"
diff --git a/notes.c b/notes.c
index 02f1aa39ae1..4d2836a7c76 100644
--- a/notes.c
+++ b/notes.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "notes.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "blob.h"
 #include "tree.h"
 #include "utf8.h"
diff --git a/object-name.c b/object-name.c
index 45f4d51305b..7e96c97051e 100644
--- a/object-name.c
+++ b/object-name.c
@@ -17,7 +17,7 @@
 #include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/object-store-ll.h b/object-store-ll.h
new file mode 100644
index 00000000000..e8f22cdb1b5
--- /dev/null
+++ b/object-store-ll.h
@@ -0,0 +1,533 @@
+#ifndef OBJECT_STORE_LL_H
+#define OBJECT_STORE_LL_H
+
+#include "hashmap.h"
+#include "object.h"
+#include "list.h"
+#include "thread-utils.h"
+#include "oidset.h"
+
+struct oidmap;
+struct oidtree;
+struct strbuf;
+
+struct object_directory {
+	struct object_directory *next;
+
+	/*
+	 * Used to store the results of readdir(3) calls when we are OK
+	 * sacrificing accuracy due to races for speed. That includes
+	 * object existence with OBJECT_INFO_QUICK, as well as
+	 * our search for unique abbreviated hashes. Don't use it for tasks
+	 * requiring greater accuracy!
+	 *
+	 * Be sure to call odb_load_loose_cache() before using.
+	 */
+	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
+	struct oidtree *loose_objects_cache;
+
+	/*
+	 * This is a temporary object store created by the tmp_objdir
+	 * facility. Disable ref updates since the objects in the store
+	 * might be discarded on rollback.
+	 */
+	int disable_ref_updates;
+
+	/*
+	 * This object store is ephemeral, so there is no need to fsync.
+	 */
+	int will_destroy;
+
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
+	char *path;
+};
+
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+	int is_finished;
+};
+
+void prepare_alt_odb(struct repository *r);
+int has_alt_odb(struct repository *r);
+char *compute_alternate_path(const char *path, struct strbuf *err);
+struct object_directory *find_odb(struct repository *r, const char *obj_dir);
+typedef int alt_odb_fn(struct object_directory *, void *);
+int foreach_alt_odb(alt_odb_fn, void*);
+typedef void alternate_ref_fn(const struct object_id *oid, void *);
+void for_each_alternate_ref(alternate_ref_fn, void *);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+void add_to_alternates_memory(const char *dir);
+
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary object directory.
+ */
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+
+/*
+ * Restore a previous ODB replaced by set_temporary_main_odb.
+ */
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+
+/*
+ * Populate and return the loose object cache array corresponding to the
+ * given object ID.
+ */
+struct oidtree *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid);
+
+/* Empty the loose object cache for the specified object directory. */
+void odb_clear_loose_cache(struct object_directory *odb);
+
+/* Clear and free the specified object directory */
+void free_object_directory(struct object_directory *odb);
+
+struct packed_git {
+	struct hashmap_entry packmap_ent;
+	struct packed_git *next;
+	struct list_head mru;
+	struct pack_window *windows;
+	off_t pack_size;
+	const void *index_data;
+	size_t index_size;
+	uint32_t num_objects;
+	uint32_t crc_offset;
+	struct oidset bad_objects;
+	int index_version;
+	time_t mtime;
+	int pack_fd;
+	int index;              /* for builtin/pack-objects.c */
+	unsigned pack_local:1,
+		 pack_keep:1,
+		 pack_keep_in_core:1,
+		 freshened:1,
+		 do_not_close:1,
+		 pack_promisor:1,
+		 multi_pack_index:1,
+		 is_cruft:1;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	struct revindex_entry *revindex;
+	const uint32_t *revindex_data;
+	const uint32_t *revindex_map;
+	size_t revindex_size;
+	/*
+	 * mtimes_map points at the beginning of the memory mapped region of
+	 * this pack's corresponding .mtimes file, and mtimes_size is the size
+	 * of that .mtimes file
+	 */
+	const uint32_t *mtimes_map;
+	size_t mtimes_size;
+	/* something like ".git/objects/pack/xxxxx.pack" */
+	char pack_name[FLEX_ARRAY]; /* more */
+};
+
+struct multi_pack_index;
+
+static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry2,
+				     const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
+struct raw_object_store {
+	/*
+	 * Set of all object directories; the main directory is first (and
+	 * cannot be NULL after initialization). Subsequent directories are
+	 * alternates.
+	 */
+	struct object_directory *odb;
+	struct object_directory **odb_tail;
+	struct kh_odb_path_map *odb_by_path;
+
+	int loaded_alternates;
+
+	/*
+	 * A list of alternate object directories loaded from the environment;
+	 * this should not generally need to be accessed directly, but will
+	 * populate the "odb" list when prepare_alt_odb() is run.
+	 */
+	char *alternate_db;
+
+	/*
+	 * Objects that should be substituted by other objects
+	 * (see git-replace(1)).
+	 */
+	struct oidmap *replace_map;
+	unsigned replace_map_initialized : 1;
+	pthread_mutex_t replace_mutex; /* protect object replace functions */
+
+	struct commit_graph *commit_graph;
+	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
+
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c
+	 */
+
+	struct packed_git *packed_git;
+	/* A most-recently-used ordered version of the packed_git list. */
+	struct list_head packed_git_mru;
+
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_pack_cache;
+
+	/*
+	 * A map of packfiles to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct hashmap pack_map;
+
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * repo_approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
+};
+
+struct raw_object_store *raw_object_store_new(void);
+void raw_object_store_clear(struct raw_object_store *o);
+
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified oid.
+ */
+const char *loose_object_path(struct repository *r, struct strbuf *buf,
+			      const struct object_id *oid);
+
+void *map_loose_object(struct repository *r, const struct object_id *oid,
+		       unsigned long *size);
+
+void *repo_read_object_file(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type *type,
+			    unsigned long *size);
+
+/* Read and unpack an object file into memory, write memory to an object file */
+int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		      unsigned long len, enum object_type type,
+		      struct object_id *oid);
+
+int write_object_file_flags(const void *buf, unsigned long len,
+			    enum object_type type, struct object_id *oid,
+			    unsigned flags);
+static inline int write_object_file(const void *buf, unsigned long len,
+				    enum object_type type, struct object_id *oid)
+{
+	return write_object_file_flags(buf, len, type, oid, 0);
+}
+
+int write_object_file_literally(const void *buf, unsigned long len,
+				const char *type, struct object_id *oid,
+				unsigned flags);
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid);
+
+/*
+ * Add an object file to the in-memory object store, without writing it
+ * to disk.
+ *
+ * Callers are responsible for calling write_object_file to record the
+ * object in persistent storage before writing any other new objects
+ * that reference it.
+ */
+int pretend_object_file(void *, unsigned long, enum object_type,
+			struct object_id *oid);
+
+int force_object_loose(const struct object_id *oid, time_t mtime);
+
+struct object_info {
+	/* Request */
+	enum object_type *typep;
+	unsigned long *sizep;
+	off_t *disk_sizep;
+	struct object_id *delta_base_oid;
+	struct strbuf *type_name;
+	void **contentp;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED,
+		OI_DBCACHED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT { 0 }
+
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
+/*
+ * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+ * nonzero).
+ */
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
+/*
+ * This is meant for bulk prefetching of missing blobs in a partial
+ * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
+ */
+#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
+
+/* Die if object corruption (not just an object being missing) was detected. */
+#define OBJECT_INFO_DIE_IF_CORRUPT 32
+
+int oid_object_info_extended(struct repository *r,
+			     const struct object_id *,
+			     struct object_info *, unsigned flags);
+
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
+		      void **contents,
+		      struct object_info *oi);
+
+/* Retry packed storage after checking packed and loose storage */
+#define HAS_OBJECT_RECHECK_PACKED 1
+
+/*
+ * Returns 1 if the object exists. This function will not lazily fetch objects
+ * in a partial clone.
+ */
+int has_object(struct repository *r, const struct object_id *oid,
+	       unsigned flags);
+
+/*
+ * These macros and functions are deprecated. If checking existence for an
+ * object that is likely to be missing and/or whose absence is relatively
+ * inconsequential (or is consequential but the caller is prepared to handle
+ * it), use has_object(), which has better defaults (no lazy fetch in a partial
+ * clone and no rechecking of packed storage). In the unlikely event that a
+ * caller needs to assert existence of an object that it fully expects to
+ * exist, and wants to trigger a lazy fetch in a partial clone, use
+ * oid_object_info_extended() with a NULL struct object_info.
+ *
+ * These functions can be removed once all callers have migrated to
+ * has_object() and/or oid_object_info_extended().
+ */
+int repo_has_object_file(struct repository *r, const struct object_id *oid);
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags);
+
+/*
+ * Return true iff an alternate object database has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+int has_loose_object_nonlocal(const struct object_id *);
+
+int has_loose_object(const struct object_id *);
+
+/**
+ * format_object_header() is a thin wrapper around s xsnprintf() that
+ * writes the initial "<type> <obj-len>" part of the loose object
+ * header. It returns the size that snprintf() returns + 1.
+ */
+int format_object_header(char *str, size_t size, enum object_type type,
+			 size_t objsize);
+
+void assert_oid_type(const struct object_id *oid, enum object_type expect);
+
+/*
+ * Enabling the object read lock allows multiple threads to safely call the
+ * following functions in parallel: repo_read_object_file(),
+ * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
+ *
+ * obj_read_lock() and obj_read_unlock() may also be used to protect other
+ * section which cannot execute in parallel with object reading. Since the used
+ * lock is a recursive mutex, these sections can even contain calls to object
+ * reading functions. However, beware that in these cases zlib inflation won't
+ * be performed in parallel, losing performance.
+ *
+ * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
+ * any of its callees end up calling it, this recursive call won't benefit from
+ * parallel inflation.
+ */
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+
+extern int obj_read_use_lock;
+extern pthread_mutex_t obj_read_mutex;
+
+static inline void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+static inline void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ *
+ * In the "buf" variant, "path" is a strbuf which will also be used as a
+ * scratch buffer, but restored to its original contents before
+ * the function returns.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+int for_each_loose_file_in_objdir_buf(struct strbuf *path,
+				      each_loose_object_fn obj_cb,
+				      each_loose_cruft_fn cruft_cb,
+				      each_loose_subdir_fn subdir_cb,
+				      void *data);
+
+/* Flags for for_each_*_object() below. */
+enum for_each_object_flags {
+	/* Iterate only over local objects, not alternates. */
+	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
+
+	/* Only iterate over packs obtained from the promisor remote. */
+	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+
+	/*
+	 * Visit objects within a pack in packfile order rather than .idx order
+	 */
+	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
+
+	/* Only iterate over packs that are not marked as kept in-core. */
+	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
+
+	/* Only iterate over packs that do not have .keep files. */
+	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
+};
+
+/*
+ * Iterate over all accessible loose objects without respect to
+ * reachability. By default, this includes both local and alternate objects.
+ * The order in which objects are visited is unspecified.
+ *
+ * Any flags specific to packs are ignored.
+ */
+int for_each_loose_object(each_loose_object_fn, void *,
+			  enum for_each_object_flags flags);
+
+/*
+ * Iterate over all accessible packed objects without respect to reachability.
+ * By default, this includes both local and alternate packs.
+ *
+ * Note that some objects may appear twice if they are found in multiple packs.
+ * Each pack is visited in an unspecified order. By default, objects within a
+ * pack are visited in pack-idx order (i.e., sorted by oid).
+ */
+typedef int each_packed_object_fn(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn, void *data,
+			    enum for_each_object_flags flags);
+int for_each_packed_object(each_packed_object_fn, void *,
+			   enum for_each_object_flags flags);
+
+#endif /* OBJECT_STORE_LL_H */
diff --git a/object-store.h b/object-store.h
index 12415e5ea73..1b3e3d7d014 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,537 +1,11 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-#include "object.h"
-#include "list.h"
-#include "thread-utils.h"
 #include "khash.h"
 #include "dir.h"
-#include "oidset.h"
-
-struct oidmap;
-struct oidtree;
-struct strbuf;
-
-struct object_directory {
-	struct object_directory *next;
-
-	/*
-	 * Used to store the results of readdir(3) calls when we are OK
-	 * sacrificing accuracy due to races for speed. That includes
-	 * object existence with OBJECT_INFO_QUICK, as well as
-	 * our search for unique abbreviated hashes. Don't use it for tasks
-	 * requiring greater accuracy!
-	 *
-	 * Be sure to call odb_load_loose_cache() before using.
-	 */
-	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oidtree *loose_objects_cache;
-
-	/*
-	 * This is a temporary object store created by the tmp_objdir
-	 * facility. Disable ref updates since the objects in the store
-	 * might be discarded on rollback.
-	 */
-	int disable_ref_updates;
-
-	/*
-	 * This object store is ephemeral, so there is no need to fsync.
-	 */
-	int will_destroy;
-
-	/*
-	 * Path to the alternative object store. If this is a relative path,
-	 * it is relative to the current working directory.
-	 */
-	char *path;
-};
-
-struct input_stream {
-	const void *(*read)(struct input_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
+#include "object-store-ll.h"
 
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct object_directory *, 1, fspathhash, fspatheq)
 
-void prepare_alt_odb(struct repository *r);
-int has_alt_odb(struct repository *r);
-char *compute_alternate_path(const char *path, struct strbuf *err);
-struct object_directory *find_odb(struct repository *r, const char *obj_dir);
-typedef int alt_odb_fn(struct object_directory *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-void add_to_alternates_memory(const char *dir);
-
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
-
-/*
- * Populate and return the loose object cache array corresponding to the
- * given object ID.
- */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid);
-
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
-
-/* Clear and free the specified object directory */
-void free_object_directory(struct object_directory *odb);
-
-struct packed_git {
-	struct hashmap_entry packmap_ent;
-	struct packed_git *next;
-	struct list_head mru;
-	struct pack_window *windows;
-	off_t pack_size;
-	const void *index_data;
-	size_t index_size;
-	uint32_t num_objects;
-	uint32_t crc_offset;
-	struct oidset bad_objects;
-	int index_version;
-	time_t mtime;
-	int pack_fd;
-	int index;              /* for builtin/pack-objects.c */
-	unsigned pack_local:1,
-		 pack_keep:1,
-		 pack_keep_in_core:1,
-		 freshened:1,
-		 do_not_close:1,
-		 pack_promisor:1,
-		 multi_pack_index:1,
-		 is_cruft:1;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	struct revindex_entry *revindex;
-	const uint32_t *revindex_data;
-	const uint32_t *revindex_map;
-	size_t revindex_size;
-	/*
-	 * mtimes_map points at the beginning of the memory mapped region of
-	 * this pack's corresponding .mtimes file, and mtimes_size is the size
-	 * of that .mtimes file
-	 */
-	const uint32_t *mtimes_map;
-	size_t mtimes_size;
-	/* something like ".git/objects/pack/xxxxx.pack" */
-	char pack_name[FLEX_ARRAY]; /* more */
-};
-
-struct multi_pack_index;
-
-static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
-				     const struct hashmap_entry *entry,
-				     const struct hashmap_entry *entry2,
-				     const void *keydata)
-{
-	const char *key = keydata;
-	const struct packed_git *pg1, *pg2;
-
-	pg1 = container_of(entry, const struct packed_git, packmap_ent);
-	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
-
-	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
-}
-
-struct raw_object_store {
-	/*
-	 * Set of all object directories; the main directory is first (and
-	 * cannot be NULL after initialization). Subsequent directories are
-	 * alternates.
-	 */
-	struct object_directory *odb;
-	struct object_directory **odb_tail;
-	kh_odb_path_map_t *odb_by_path;
-
-	int loaded_alternates;
-
-	/*
-	 * A list of alternate object directories loaded from the environment;
-	 * this should not generally need to be accessed directly, but will
-	 * populate the "odb" list when prepare_alt_odb() is run.
-	 */
-	char *alternate_db;
-
-	/*
-	 * Objects that should be substituted by other objects
-	 * (see git-replace(1)).
-	 */
-	struct oidmap *replace_map;
-	unsigned replace_map_initialized : 1;
-	pthread_mutex_t replace_mutex; /* protect object replace functions */
-
-	struct commit_graph *commit_graph;
-	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
-
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c and midx.c
-	 */
-	struct multi_pack_index *multi_pack_index;
-
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c
-	 */
-
-	struct packed_git *packed_git;
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
-
-	struct {
-		struct packed_git **packs;
-		unsigned flags;
-	} kept_pack_cache;
-
-	/*
-	 * A map of packfiles to packed_git structs for tracking which
-	 * packs have been loaded already.
-	 */
-	struct hashmap pack_map;
-
-	/*
-	 * A fast, rough count of the number of objects in the repository.
-	 * These two fields are not meant for direct access. Use
-	 * repo_approximate_object_count() instead.
-	 */
-	unsigned long approximate_object_count;
-	unsigned approximate_object_count_valid : 1;
-
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-};
-
-struct raw_object_store *raw_object_store_new(void);
-void raw_object_store_clear(struct raw_object_store *o);
-
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified oid.
- */
-const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const struct object_id *oid);
-
-void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
-
-void *repo_read_object_file(struct repository *r,
-			    const struct object_id *oid,
-			    enum object_type *type,
-			    unsigned long *size);
-
-/* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-
-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
-		      struct object_id *oid);
-
-int write_object_file_flags(const void *buf, unsigned long len,
-			    enum object_type type, struct object_id *oid,
-			    unsigned flags);
-static inline int write_object_file(const void *buf, unsigned long len,
-				    enum object_type type, struct object_id *oid)
-{
-	return write_object_file_flags(buf, len, type, oid, 0);
-}
-
-int write_object_file_literally(const void *buf, unsigned long len,
-				const char *type, struct object_id *oid,
-				unsigned flags);
-int stream_loose_object(struct input_stream *in_stream, size_t len,
-			struct object_id *oid);
-
-/*
- * Add an object file to the in-memory object store, without writing it
- * to disk.
- *
- * Callers are responsible for calling write_object_file to record the
- * object in persistent storage before writing any other new objects
- * that reference it.
- */
-int pretend_object_file(void *, unsigned long, enum object_type,
-			struct object_id *oid);
-
-int force_object_loose(const struct object_id *oid, time_t mtime);
-
-struct object_info {
-	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
-	off_t *disk_sizep;
-	struct object_id *delta_base_oid;
-	struct strbuf *type_name;
-	void **contentp;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-		OI_DBCACHED
-	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			unsigned int is_delta;
-		} packed;
-	} u;
-};
-
-/*
- * Initializer for a "struct object_info" that wants no items. You may
- * also memset() the memory to all-zeroes.
- */
-#define OBJECT_INFO_INIT { 0 }
-
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
-
-/* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT 32
-
-int oid_object_info_extended(struct repository *r,
-			     const struct object_id *,
-			     struct object_info *, unsigned flags);
-
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * use the "oi" argument to assert things about the object, or e.g. populate its
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      struct object_id *real_oid,
-		      void **contents,
-		      struct object_info *oi);
-
-/* Retry packed storage after checking packed and loose storage */
-#define HAS_OBJECT_RECHECK_PACKED 1
-
-/*
- * Returns 1 if the object exists. This function will not lazily fetch objects
- * in a partial clone.
- */
-int has_object(struct repository *r, const struct object_id *oid,
-	       unsigned flags);
-
-/*
- * These macros and functions are deprecated. If checking existence for an
- * object that is likely to be missing and/or whose absence is relatively
- * inconsequential (or is consequential but the caller is prepared to handle
- * it), use has_object(), which has better defaults (no lazy fetch in a partial
- * clone and no rechecking of packed storage). In the unlikely event that a
- * caller needs to assert existence of an object that it fully expects to
- * exist, and wants to trigger a lazy fetch in a partial clone, use
- * oid_object_info_extended() with a NULL struct object_info.
- *
- * These functions can be removed once all callers have migrated to
- * has_object() and/or oid_object_info_extended().
- */
-int repo_has_object_file(struct repository *r, const struct object_id *oid);
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags);
-
-/*
- * Return true iff an alternate object database has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int has_loose_object_nonlocal(const struct object_id *);
-
-int has_loose_object(const struct object_id *);
-
-/**
- * format_object_header() is a thin wrapper around s xsnprintf() that
- * writes the initial "<type> <obj-len>" part of the loose object
- * header. It returns the size that snprintf() returns + 1.
- */
-int format_object_header(char *str, size_t size, enum object_type type,
-			 size_t objsize);
-
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
-
-/*
- * Enabling the object read lock allows multiple threads to safely call the
- * following functions in parallel: repo_read_object_file(),
- * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
- *
- * obj_read_lock() and obj_read_unlock() may also be used to protect other
- * section which cannot execute in parallel with object reading. Since the used
- * lock is a recursive mutex, these sections can even contain calls to object
- * reading functions. However, beware that in these cases zlib inflation won't
- * be performed in parallel, losing performance.
- *
- * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
- * any of its callees end up calling it, this recursive call won't benefit from
- * parallel inflation.
- */
-void enable_obj_read_lock(void);
-void disable_obj_read_lock(void);
-
-extern int obj_read_use_lock;
-extern pthread_mutex_t obj_read_mutex;
-
-static inline void obj_read_lock(void)
-{
-	if(obj_read_use_lock)
-		pthread_mutex_lock(&obj_read_mutex);
-}
-
-static inline void obj_read_unlock(void)
-{
-	if(obj_read_use_lock)
-		pthread_mutex_unlock(&obj_read_mutex);
-}
-
-/*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-int for_each_loose_file_in_objdir(const char *path,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
-
-/* Flags for for_each_*_object() below. */
-enum for_each_object_flags {
-	/* Iterate only over local objects, not alternates. */
-	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
-
-	/* Only iterate over packs obtained from the promisor remote. */
-	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
-
-	/*
-	 * Visit objects within a pack in packfile order rather than .idx order
-	 */
-	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
-
-	/* Only iterate over packs that are not marked as kept in-core. */
-	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
-
-	/* Only iterate over packs that do not have .keep files. */
-	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
-};
-
-/*
- * Iterate over all accessible loose objects without respect to
- * reachability. By default, this includes both local and alternate objects.
- * The order in which objects are visited is unspecified.
- *
- * Any flags specific to packs are ignored.
- */
-int for_each_loose_object(each_loose_object_fn, void *,
-			  enum for_each_object_flags flags);
-
-/*
- * Iterate over all accessible packed objects without respect to reachability.
- * By default, this includes both local and alternate packs.
- *
- * Note that some objects may appear twice if they are found in multiple packs.
- * Each pack is visited in an unspecified order. By default, objects within a
- * pack are visited in pack-idx order (i.e., sorted by oid).
- */
-typedef int each_packed_object_fn(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data);
-int for_each_object_in_pack(struct packed_git *p,
-			    each_packed_object_fn, void *data,
-			    enum for_each_object_flags flags);
-int for_each_packed_object(each_packed_object_fn, void *,
-			   enum for_each_object_flags flags);
-
 #endif /* OBJECT_STORE_H */
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index 609a343ee3e..3e190214d14 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 623ee2a8197..d86f4e739a4 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -3,7 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "tag.h"
 #include "diff.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e0fad723bf3..3981655f3cf 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -17,7 +17,7 @@
 #include "repository.h"
 #include "trace2.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
diff --git a/pack-check.c b/pack-check.c
index 049f2f0bfc0..977f619618e 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -7,7 +7,7 @@
 #include "progress.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 struct idx_entry {
 	off_t                offset;
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 020a37f8fe3..cdf30b8d2b0 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -2,8 +2,9 @@
 #include "gettext.h"
 #include "pack-mtimes.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
+#include "strbuf.h"
 
 static char *pack_mtimes_filename(struct packed_git *p)
 {
diff --git a/pack-objects.h b/pack-objects.h
index 579476687c4..0d78db40cb2 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,7 +1,7 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "thread-utils.h"
 #include "pack.h"
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 1f51b712e87..7fffcad9125 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -2,8 +2,9 @@
 #include "gettext.h"
 #include "pack-revindex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
+#include "strbuf.h"
 #include "trace2.h"
 #include "config.h"
 #include "midx.h"
diff --git a/pack-write.c b/pack-write.c
index 45681e2d7db..af48813a9bb 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -11,6 +11,7 @@
 #include "pack-objects.h"
 #include "pack-revindex.h"
 #include "path.h"
+#include "strbuf.h"
 #include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
diff --git a/packfile.c b/packfile.c
index fd083c86e00..c60aeb05ece 100644
--- a/packfile.c
+++ b/packfile.c
@@ -19,7 +19,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "pack-revindex.h"
diff --git a/path.c b/path.c
index 7c1cd8182a8..c3b6618c77b 100644
--- a/path.c
+++ b/path.c
@@ -15,7 +15,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
 #include "wrapper.h"
diff --git a/promisor-remote.c b/promisor-remote.c
index 1adcd6fb0a5..db88d2064d4 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "promisor-remote.h"
 #include "config.h"
 #include "trace2.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index a90c48852e5..808a68c974a 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -7,7 +7,7 @@
 #include "hash-ll.h"
 #include "hex.h"
 #include "object.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "string-list.h"
 #include "strbuf.h"
 
diff --git a/prune-packed.c b/prune-packed.c
index 58412b4fb91..e54daf740a2 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
 #include "progress.h"
 #include "prune-packed.h"
diff --git a/reachable.c b/reachable.c
index 55bb1143530..434f09e9ebf 100644
--- a/reachable.c
+++ b/reachable.c
@@ -13,7 +13,7 @@
 #include "list-objects.h"
 #include "packfile.h"
 #include "worktree.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
 
diff --git a/read-cache.c b/read-cache.c
index 86ada403a83..b9a995e5a18 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -17,7 +17,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/ref-filter.c b/ref-filter.c
index 4991cd4f7a8..e0d03a9f8e9 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -8,7 +8,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/reflog.c b/reflog.c
index ee1bf5d032c..9ad50e7d93e 100644
--- a/reflog.c
+++ b/reflog.c
@@ -1,6 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
diff --git a/refs.c b/refs.c
index 5f76da35673..54a827b45b3 100644
--- a/refs.c
+++ b/refs.c
@@ -17,7 +17,7 @@
 #include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "object.h"
 #include "path.h"
 #include "tag.h"
diff --git a/remote.c b/remote.c
index 8550056db43..6538b6037de 100644
--- a/remote.c
+++ b/remote.c
@@ -10,7 +10,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/remote.h b/remote.h
index 73638cefeb1..929c7c676d3 100644
--- a/remote.h
+++ b/remote.h
@@ -1,6 +1,7 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
+#include "hash-ll.h"
 #include "hashmap.h"
 #include "refspec.h"
 
diff --git a/replace-object.c b/replace-object.c
index e98825d5852..ca4017635df 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -2,7 +2,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "oidmap.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "replace-object.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/replace-object.h b/replace-object.h
index 500482b02b3..a964db1670e 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -3,7 +3,7 @@
 
 #include "oidmap.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 /*
  * Do replace refs need to be checked this run?  This variable is
diff --git a/repository.c b/repository.c
index 87a7a27b665..8c77b7ed236 100644
--- a/repository.c
+++ b/repository.c
@@ -6,7 +6,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
diff --git a/rerere.c b/rerere.c
index 3584fecb07c..e2b8597f88c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -17,7 +17,7 @@
 #include "path.h"
 #include "pathspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "hash-lookup.h"
 #include "strmap.h"
 #include "wrapper.h"
diff --git a/revision.c b/revision.c
index d4b4b34fd80..84768565cef 100644
--- a/revision.c
+++ b/revision.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "tag.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/send-pack.c b/send-pack.c
index 0c7ccaef680..9510bef8561 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/sequencer.c b/sequencer.c
index eddd38d4bed..1b9607da268 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -11,7 +11,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "object.h"
 #include "pager.h"
 #include "commit.h"
diff --git a/serve.c b/serve.c
index 5329c91011f..a1d71134d49 100644
--- a/serve.c
+++ b/serve.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "repository.h"
 #include "config.h"
+#include "hash-ll.h"
 #include "pkt-line.h"
 #include "version.h"
 #include "ls-refs.h"
diff --git a/server-info.c b/server-info.c
index 85d17bbb151..382e481a2b0 100644
--- a/server-info.c
+++ b/server-info.c
@@ -11,7 +11,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "server-info.h"
 #include "strbuf.h"
 #include "wrapper.h"
diff --git a/shallow.c b/shallow.c
index 45343e6a78b..f3ef94d4c92 100644
--- a/shallow.c
+++ b/shallow.c
@@ -4,7 +4,7 @@
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/streaming.c b/streaming.c
index 21e39585e89..49791ab958d 100644
--- a/streaming.c
+++ b/streaming.c
@@ -7,7 +7,7 @@
 #include "streaming.h"
 #include "repository.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "replace-object.h"
 #include "packfile.h"
 #include "wrapper.h"
diff --git a/submodule-config.c b/submodule-config.c
index c67260a3e11..1efd5471698 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -11,7 +11,7 @@
 #include "submodule.h"
 #include "strbuf.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/submodule.c b/submodule.c
index 245300596ff..f0f8788d2e3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -27,7 +27,7 @@
 #include "parse-options.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 0f3fbeec532..67a964ef904 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "strbuf.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "packfile.h"
 #include "pack-mtimes.h"
 #include "setup.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 362bd64a4c2..910a1286144 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "setup.h"
 
 /*
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 3ac496e27e4..8c7a83f578f 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "bloom.h"
 #include "setup.h"
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 211addaa005..e9a444ddba5 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -2,7 +2,7 @@
 #include "hex.h"
 #include "midx.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 1b30a6cba8b..04d26fc2fef 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -3,9 +3,10 @@
 #include "refs.h"
 #include "setup.h"
 #include "worktree.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "path.h"
 #include "repository.h"
+#include "strbuf.h"
 
 struct flag_definition {
 	const char *name;
diff --git a/t/helper/test-repository.c b/t/helper/test-repository.c
index bafd2a5bf95..4cd8a952e5c 100644
--- a/t/helper/test-repository.c
+++ b/t/helper/test-repository.c
@@ -4,7 +4,7 @@
 #include "config.h"
 #include "environment.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "object.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/tag.c b/tag.c
index 96dbd5b2d55..c5426484b22 100644
--- a/tag.c
+++ b/tag.c
@@ -2,7 +2,7 @@
 #include "environment.h"
 #include "tag.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index db1f7038dae..5f9074ad1c0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -11,7 +11,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "quote.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 
 struct tmp_objdir {
 	struct strbuf path;
diff --git a/transport.c b/transport.c
index 67afdae57c1..4dc187a3885 100644
--- a/transport.c
+++ b/transport.c
@@ -27,7 +27,7 @@
 #include "transport-internal.h"
 #include "protocol.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "color.h"
 #include "bundle-uri.h"
 #include "wrapper.h"
diff --git a/tree-walk.c b/tree-walk.c
index d3c48e06df0..42ed86ef581 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "trace2.h"
 #include "tree.h"
 #include "pathspec.h"
diff --git a/tree.c b/tree.c
index 0dd2029a8a2..e118914a76a 100644
--- a/tree.c
+++ b/tree.c
@@ -3,7 +3,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "blob.h"
 #include "commit.h"
 #include "tag.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 4b620df3031..87517364dc0 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -23,7 +23,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "fsmonitor.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/upload-pack.c b/upload-pack.c
index 08633dc1216..2502dcb4699 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -7,7 +7,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "oid-array.h"
 #include "tag.h"
 #include "object.h"
diff --git a/walker.c b/walker.c
index 24ff7dfdc28..65002a7220a 100644
--- a/walker.c
+++ b/walker.c
@@ -3,8 +3,9 @@
 #include "hex.h"
 #include "walker.h"
 #include "repository.h"
-#include "object-store.h"
+#include "object-store-ll.h"
 #include "commit.h"
+#include "strbuf.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "tag.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 0460e03f5ed..abc7275a528 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -1,7 +1,8 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "hex.h"
-#include "object-store.h"
+#include "object-store-ll.h"
+#include "strbuf.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"
 #include "xdiff/xdiffi.h"
-- 
gitgitgadget

