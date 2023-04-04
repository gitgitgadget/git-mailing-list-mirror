Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C57C76188
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjDDBXV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjDDBXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEDE2108
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:44 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so31124110wrt.8
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6BoD2S+5Sgd0qkRyM4bF0RaO0B9m/42qvmwhxLueZ0=;
        b=mkQYfw85VqmQdQgHLGm2N5LlO1RKZ0Ufs5pbRnWWq873Ga3ZnRftXX1b03tjzHQyaE
         oOtoSt2+mUGmjaZapUubmQm6cnU9BBx5UVJfVoK7jkT3PmEZ/qieToEENQaJuLLqXOjy
         HEUaPZzPyF2PLr2QTAPXuMzOegE4gvHlgZvu+HKs3IQTNZSrmYxpriiV63QMmX94HRdK
         szmCzRv14rOSC7iPss1ReQeQt5A2yPVvAW/ZplYaOm/CfX167qMyI66KLpatO68QATra
         WGmK3qI7qwy2Sr8S3gUfEPT5+2Jw3S5QxlNhEmJb+fqXZuUXg931mNbD+LKwyWonIfaq
         8fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571363;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6BoD2S+5Sgd0qkRyM4bF0RaO0B9m/42qvmwhxLueZ0=;
        b=vuwPqmrOXVm3LcmbKOGJXFlNkieXhSIuTaEFe7jKOw722vFVj3+puybECnbDaRJIyb
         uC1yNtujTrj2+4ZAgRNJBxBleRMM8Yuk644ynou16TkgDpkxRZtoxcpkXp4PQzTFI0dy
         tnDlvghRvTCeeeW2bvV5MPvUwIThCqaDMkdQJzG8xrTfLIsMKsHSHXKWH20LHMD4vH84
         CcXOP1UPhMpqnncyxTjQumrubk0ud2uoioTvMoRiM7r30OVTnb6jpUejwnC+R0HJSSsf
         ZM56v5WyD8ohzbj0Lbazcl9b5nkV2+bqqFoKf5l+N1ugyGa+YVd2kH8KfnaxzgwhRtk4
         anxQ==
X-Gm-Message-State: AAQBX9fyqXK9RnOFcbim9SYXNONWH0l818rgNuSBcIGB4sL6pNq4J/27
        k3eRLymVcHbTwE4Hvpq4Jd3F9lL2OBk=
X-Google-Smtp-Source: AKy350bgwNDqd+hI5RUxS2nSgUAqj9kaaM31B1GHxEn6tkaA4bf4jYhl/YKcuOAq6cuVbTB5P7DjqQ==
X-Received: by 2002:a5d:48c6:0:b0:2d8:81a9:4d75 with SMTP id p6-20020a5d48c6000000b002d881a94d75mr238516wrs.32.1680571363059;
        Mon, 03 Apr 2023 18:22:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020adfdc88000000b002de99432fc8sm10981769wrj.49.2023.04.03.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:42 -0700 (PDT)
Message-Id: <5efd49df148c08461c0a1a212212e768529648c6.1680571351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:16 +0000
Subject: [PATCH v2 12/24] object-file.h: move declarations for object-file.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 apply.c                            |   1 +
 builtin/bugreport.c                |   1 +
 builtin/cat-file.c                 |   1 +
 builtin/clone.c                    |   1 +
 builtin/credential-cache--daemon.c |   1 +
 builtin/diagnose.c                 |   1 +
 builtin/difftool.c                 |   1 +
 builtin/fast-export.c              |   1 +
 builtin/fast-import.c              |   1 +
 builtin/fetch-pack.c               |   1 +
 builtin/fsck.c                     |   1 +
 builtin/gc.c                       |   1 +
 builtin/grep.c                     |   1 +
 builtin/hash-object.c              |   1 +
 builtin/index-pack.c               |   1 +
 builtin/init-db.c                  |   1 +
 builtin/log.c                      |   1 +
 builtin/mktag.c                    |   1 +
 builtin/mv.c                       |   1 +
 builtin/pack-objects.c             |   1 +
 builtin/prune.c                    |   1 +
 builtin/rebase.c                   |   1 +
 builtin/replace.c                  |   1 +
 builtin/rev-list.c                 |   1 +
 builtin/sparse-checkout.c          |   1 +
 builtin/submodule--helper.c        |   1 +
 builtin/update-index.c             |   1 +
 builtin/worktree.c                 |   1 +
 bulk-checkin.c                     |   1 +
 cache-tree.c                       |   1 +
 cache.h                            | 123 ---------------------------
 commit-graph.c                     |   1 +
 diff.c                             |   1 +
 dir.c                              |   1 +
 environment.c                      |   1 +
 http.c                             |   1 +
 merge-recursive.c                  |   1 +
 midx.c                             |   1 +
 notes-merge.c                      |   1 +
 object-file.c                      |   1 +
 object-file.h                      | 129 +++++++++++++++++++++++++++++
 object.c                           |   1 +
 pack-bitmap.c                      |   1 +
 pack-check.c                       |   1 +
 pack-mtimes.c                      |   1 +
 pack-revindex.c                    |   1 +
 packfile.c                         |   1 +
 read-cache.c                       |   1 +
 refs/files-backend.c               |   1 +
 rerere.c                           |   1 +
 revision.c                         |   1 +
 sequencer.c                        |   1 +
 server-info.c                      |   1 +
 streaming.c                        |   1 +
 submodule.c                        |   1 +
 tmp-objdir.c                       |   1 +
 tree-walk.c                        |   1 +
 57 files changed, 184 insertions(+), 123 deletions(-)
 create mode 100644 object-file.h

diff --git a/apply.c b/apply.c
index 7e40f53ec4c..2868cef5ddd 100644
--- a/apply.c
+++ b/apply.c
@@ -23,6 +23,7 @@
 #include "ll-merge.h"
 #include "lockfile.h"
 #include "object-name.h"
+#include "object-file.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "rerere.h"
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 52955e1d389..03fb0536911 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -8,6 +8,7 @@
 #include "hook.h"
 #include "hook-list.h"
 #include "diagnose.h"
+#include "object-file.h"
 #include "setup.h"
 #include "wrapper.h"
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 60b7a55dfc1..0bafc14e6c0 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -20,6 +20,7 @@
 #include "tree-walk.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index f1e8aa3f27e..c7fdffb484c 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -21,6 +21,7 @@
 #include "fetch-pack.h"
 #include "refs.h"
 #include "refspec.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cache--daemon.c
index 62c09a271d6..4e571d9951b 100644
--- a/builtin/credential-cache--daemon.c
+++ b/builtin/credential-cache--daemon.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "alloc.h"
 #include "gettext.h"
+#include "object-file.h"
 #include "parse-options.h"
 
 #ifndef NO_UNIX_SOCKETS
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 0f8b64994c4..4f22eb2b55d 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "abspath.h"
 #include "gettext.h"
+#include "object-file.h"
 #include "parse-options.h"
 #include "diagnose.h"
 
diff --git a/builtin/difftool.c b/builtin/difftool.c
index e010a21bfbc..3ffb0524be7 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -25,6 +25,7 @@
 #include "strvec.h"
 #include "strbuf.h"
 #include "lockfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "dir.h"
 #include "entry.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 0bb779deb69..c7835ea0791 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -10,6 +10,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "refspec.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "commit.h"
 #include "object.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 31b8732128d..9f90f5b9e41 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "mem-pool.h"
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 60e5a10ffc5..664ac1ec0e8 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -2,6 +2,7 @@
 #include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "pkt-line.h"
 #include "fetch-pack.h"
 #include "remote.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 04bc71d148c..35a6de3cdb5 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index 000a2ef5e11..b95154fba16 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -25,6 +25,7 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-objects.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index f66e14389e1..fb11be6075a 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,6 +26,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index a15fe4fd3f4..a3801211666 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "blob.h"
 #include "quote.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5adfb2521cd..0f59cf8aa08 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -18,6 +18,7 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "pack-revindex.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "replace-object.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index ba6e0b20fa5..6183f3fb3ff 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "object-file.h"
 #include "parse-options.h"
 #include "setup.h"
 #include "worktree.h"
diff --git a/builtin/log.c b/builtin/log.c
index 5cdc2276cc4..b6246c7042c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -12,6 +12,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "color.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index f9d9a38452b..f33d267fcb6 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "tag.h"
 #include "replace-object.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "fsck.h"
 #include "config.h"
diff --git a/builtin/mv.c b/builtin/mv.c
index 8f7770aa32b..32935af48e6 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -11,6 +11,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-file.h"
 #include "pathspec.h"
 #include "lockfile.h"
 #include "dir.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69c65428614..68c914a8e1a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -33,6 +33,7 @@
 #include "strvec.h"
 #include "list.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "dir.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 09891832fb3..5dc9b207200 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -11,6 +11,7 @@
 #include "progress.h"
 #include "prune-packed.h"
 #include "replace-object.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "shallow.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index ff5dd77608d..34fea4d8220 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -21,6 +21,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "commit.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 134f738a450..f4b3a8efb23 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -17,6 +17,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c17f0282ae8..6dc8be492a2 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -11,6 +11,7 @@
 #include "list-objects-filter-options.h"
 #include "object.h"
 #include "object-name.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 34b9d92fb13..4de37d07fd9 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "pathspec.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1f087d7bed2..5d999f814e0 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -24,6 +24,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "advice.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 03cda5e60d2..33b00cef151 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -15,6 +15,7 @@
 #include "cache-tree.h"
 #include "tree-walk.h"
 #include "builtin.h"
+#include "object-file.h"
 #include "refs.h"
 #include "resolve-undo.h"
 #include "parse-options.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 69132bba319..0621f6f708e 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "strvec.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 6362b6aabc7..af15f8a9af4 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -15,6 +15,7 @@
 #include "string-list.h"
 #include "tmp-objdir.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 
 static int odb_transaction_nesting;
diff --git a/cache-tree.c b/cache-tree.c
index 39f0c744727..ebfe649b330 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -7,6 +7,7 @@
 #include "tree-walk.h"
 #include "cache-tree.h"
 #include "bulk-checkin.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/cache.h b/cache.h
index c06778b69cd..89987cca22a 100644
--- a/cache.h
+++ b/cache.h
@@ -3,7 +3,6 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
-#include "git-zlib.h"
 #include "hashmap.h"
 #include "list.h"
 #include "gettext.h"
@@ -596,13 +595,6 @@ int has_racy_timestamp(struct index_state *istate);
 int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
-#define HASH_WRITE_OBJECT 1
-#define HASH_FORMAT_CHECK 2
-#define HASH_RENORMALIZE  4
-#define HASH_SILENT 8
-int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
-
 /*
  * Record to sd the data from st that we use to check whether a file
  * might have changed.
@@ -664,107 +656,6 @@ extern int quote_path_fully;
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Create the directory containing the named path, using care to be
- * somewhat safe against races. Return one of the scld_error values to
- * indicate success/failure. On error, set errno to describe the
- * problem.
- *
- * SCLD_VANISHED indicates that one of the ancestor directories of the
- * path existed at one point during the function call and then
- * suddenly vanished, probably because another process pruned the
- * directory while we were working.  To be robust against this kind of
- * race, callers might want to try invoking the function again when it
- * returns SCLD_VANISHED.
- *
- * safe_create_leading_directories() temporarily changes path while it
- * is working but restores it before returning.
- * safe_create_leading_directories_const() doesn't modify path, even
- * temporarily. Both these variants adjust the permissions of the
- * created directories to honor core.sharedRepository, so they are best
- * suited for files inside the git dir. For working tree files, use
- * safe_create_leading_directories_no_share() instead, as it ignores
- * the core.sharedRepository setting.
- */
-enum scld_error {
-	SCLD_OK = 0,
-	SCLD_FAILED = -1,
-	SCLD_PERMS = -2,
-	SCLD_EXISTS = -3,
-	SCLD_VANISHED = -4
-};
-enum scld_error safe_create_leading_directories(char *path);
-enum scld_error safe_create_leading_directories_const(const char *path);
-enum scld_error safe_create_leading_directories_no_share(char *path);
-
-int mkdir_in_gitdir(const char *path);
-
-int git_open_cloexec(const char *name, int flags);
-#define git_open(name) git_open_cloexec(name, O_RDONLY)
-
-/**
- * unpack_loose_header() initializes the data stream needed to unpack
- * a loose object header.
- *
- * Returns:
- *
- * - ULHR_OK on success
- * - ULHR_BAD on error
- * - ULHR_TOO_LONG if the header was too long
- *
- * It will only parse up to MAX_HEADER_LEN bytes unless an optional
- * "hdrbuf" argument is non-NULL. This is intended for use with
- * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
- * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header(), ULHR_TOO_LONG will still be returned
- * from this function to indicate that the header was too long.
- */
-enum unpack_loose_header_result {
-	ULHR_OK,
-	ULHR_BAD,
-	ULHR_TOO_LONG,
-};
-enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
-						    unsigned char *map,
-						    unsigned long mapsize,
-						    void *buffer,
-						    unsigned long bufsiz,
-						    struct strbuf *hdrbuf);
-
-/**
- * parse_loose_header() parses the starting "<type> <len>\0" of an
- * object. If it doesn't follow that format -1 is returned. To check
- * the validity of the <type> populate the "typep" in the "struct
- * object_info". It will be OBJ_BAD if the object type is unknown. The
- * parsed <len> can be retrieved via "oi->sizep", and from there
- * passed to unpack_loose_rest().
- */
-struct object_info;
-int parse_loose_header(const char *hdr, struct object_info *oi);
-
-/**
- * With in-core object data in "buf", rehash it to make sure the
- * object name actually matches "oid" to detect object corruption.
- *
- * A negative value indicates an error, usually that the OID is not
- * what we expected, but it might also indicate another error.
- */
-int check_object_signature(struct repository *r, const struct object_id *oid,
-			   void *map, unsigned long size,
-			   enum object_type type);
-
-/**
- * A streaming version of check_object_signature().
- * Try reading the object named with "oid" using
- * the streaming interface and rehash it to do the same.
- */
-int stream_object_signature(struct repository *r, const struct object_id *oid);
-
-int finalize_object_file(const char *tmpfile, const char *filename);
-
-/* Helper to check and "touch" a file */
-int check_and_freshen_file(const char *fn, int freshen);
-
 int base_name_compare(const char *name1, size_t len1, int mode1,
 		      const char *name2, size_t len2, int mode2);
 int df_name_compare(const char *name1, size_t len1, int mode1,
@@ -772,12 +663,6 @@ int df_name_compare(const char *name1, size_t len1, int mode1,
 int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
 const char *git_editor(void);
 const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
@@ -819,14 +704,6 @@ struct pack_entry {
 	struct packed_git *p;
 };
 
-/*
- * Set this to 0 to prevent oid_object_info_extended() from fetching missing
- * blobs. This has a difference only if extensions.partialClone is set.
- *
- * Its default value is 1.
- */
-extern int fetch_if_missing;
-
 /* Dumb servers support */
 int update_server_info(int);
 
diff --git a/commit-graph.c b/commit-graph.c
index fe9a8b2342f..c20e73ceebf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -11,6 +11,7 @@
 #include "revision.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "alloc.h"
diff --git a/diff.c b/diff.c
index 9e6ad94bc66..f8e0d3b5c59 100644
--- a/diff.c
+++ b/diff.c
@@ -35,6 +35,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "setup.h"
 #include "strmap.h"
diff --git a/dir.c b/dir.c
index d1f1b1ef768..aa840995c40 100644
--- a/dir.c
+++ b/dir.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "attr.h"
 #include "refs.h"
diff --git a/environment.c b/environment.c
index e57292eccc9..39efa49fe31 100644
--- a/environment.c
+++ b/environment.c
@@ -19,6 +19,7 @@
 #include "fmt-merge-msg.h"
 #include "commit.h"
 #include "strvec.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "tmp-objdir.h"
diff --git a/http.c b/http.c
index 0212c0ad3b2..c3916ceb4d8 100644
--- a/http.c
+++ b/http.c
@@ -17,6 +17,7 @@
 #include "packfile.h"
 #include "protocol.h"
 #include "string-list.h"
+#include "object-file.h"
 #include "object-store.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
diff --git a/merge-recursive.c b/merge-recursive.c
index 748a6799a30..9875bdb11cb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,7 @@
 #include "hex.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/midx.c b/midx.c
index 9af3e5de889..2d0da573281 100644
--- a/midx.c
+++ b/midx.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "hash-lookup.h"
 #include "midx.h"
diff --git a/notes-merge.c b/notes-merge.c
index b496b77d9db..cc9538ac5c0 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "gettext.h"
 #include "refs.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
diff --git a/object-file.c b/object-file.c
index a4331e0da61..8163ddbaddd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -36,6 +36,7 @@
 #include "mergesort.h"
 #include "quote.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "setup.h"
diff --git a/object-file.h b/object-file.h
new file mode 100644
index 00000000000..e0cfc3a5db8
--- /dev/null
+++ b/object-file.h
@@ -0,0 +1,129 @@
+#ifndef OBJECT_FILE_H
+#define OBJECT_FILE_H
+
+#include "git-zlib.h"
+#include "object.h"
+
+/*
+ * Set this to 0 to prevent oid_object_info_extended() from fetching missing
+ * blobs. This has a difference only if extensions.partialClone is set.
+ *
+ * Its default value is 1.
+ */
+extern int fetch_if_missing;
+
+#define HASH_WRITE_OBJECT 1
+#define HASH_FORMAT_CHECK 2
+#define HASH_RENORMALIZE  4
+#define HASH_SILENT 8
+int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+
+/*
+ * Create the directory containing the named path, using care to be
+ * somewhat safe against races. Return one of the scld_error values to
+ * indicate success/failure. On error, set errno to describe the
+ * problem.
+ *
+ * SCLD_VANISHED indicates that one of the ancestor directories of the
+ * path existed at one point during the function call and then
+ * suddenly vanished, probably because another process pruned the
+ * directory while we were working.  To be robust against this kind of
+ * race, callers might want to try invoking the function again when it
+ * returns SCLD_VANISHED.
+ *
+ * safe_create_leading_directories() temporarily changes path while it
+ * is working but restores it before returning.
+ * safe_create_leading_directories_const() doesn't modify path, even
+ * temporarily. Both these variants adjust the permissions of the
+ * created directories to honor core.sharedRepository, so they are best
+ * suited for files inside the git dir. For working tree files, use
+ * safe_create_leading_directories_no_share() instead, as it ignores
+ * the core.sharedRepository setting.
+ */
+enum scld_error {
+	SCLD_OK = 0,
+	SCLD_FAILED = -1,
+	SCLD_PERMS = -2,
+	SCLD_EXISTS = -3,
+	SCLD_VANISHED = -4
+};
+enum scld_error safe_create_leading_directories(char *path);
+enum scld_error safe_create_leading_directories_const(const char *path);
+enum scld_error safe_create_leading_directories_no_share(char *path);
+
+int mkdir_in_gitdir(const char *path);
+
+int git_open_cloexec(const char *name, int flags);
+#define git_open(name) git_open_cloexec(name, O_RDONLY)
+
+/**
+ * unpack_loose_header() initializes the data stream needed to unpack
+ * a loose object header.
+ *
+ * Returns:
+ *
+ * - ULHR_OK on success
+ * - ULHR_BAD on error
+ * - ULHR_TOO_LONG if the header was too long
+ *
+ * It will only parse up to MAX_HEADER_LEN bytes unless an optional
+ * "hdrbuf" argument is non-NULL. This is intended for use with
+ * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
+ * reporting. The full header will be extracted to "hdrbuf" for use
+ * with parse_loose_header(), ULHR_TOO_LONG will still be returned
+ * from this function to indicate that the header was too long.
+ */
+enum unpack_loose_header_result {
+	ULHR_OK,
+	ULHR_BAD,
+	ULHR_TOO_LONG,
+};
+enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
+						    unsigned char *map,
+						    unsigned long mapsize,
+						    void *buffer,
+						    unsigned long bufsiz,
+						    struct strbuf *hdrbuf);
+
+/**
+ * parse_loose_header() parses the starting "<type> <len>\0" of an
+ * object. If it doesn't follow that format -1 is returned. To check
+ * the validity of the <type> populate the "typep" in the "struct
+ * object_info". It will be OBJ_BAD if the object type is unknown. The
+ * parsed <len> can be retrieved via "oi->sizep", and from there
+ * passed to unpack_loose_rest().
+ */
+struct object_info;
+int parse_loose_header(const char *hdr, struct object_info *oi);
+
+/**
+ * With in-core object data in "buf", rehash it to make sure the
+ * object name actually matches "oid" to detect object corruption.
+ *
+ * A negative value indicates an error, usually that the OID is not
+ * what we expected, but it might also indicate another error.
+ */
+int check_object_signature(struct repository *r, const struct object_id *oid,
+			   void *map, unsigned long size,
+			   enum object_type type);
+
+/**
+ * A streaming version of check_object_signature().
+ * Try reading the object named with "oid" using
+ * the streaming interface and rehash it to do the same.
+ */
+int stream_object_signature(struct repository *r, const struct object_id *oid);
+
+int finalize_object_file(const char *tmpfile, const char *filename);
+
+/* Helper to check and "touch" a file */
+int check_and_freshen_file(const char *fn, int freshen);
+
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
+				 enum object_type required_type,
+				 unsigned long *size,
+				 struct object_id *oid_ret);
+
+#endif /* OBJECT_FILE_H */
diff --git a/object.c b/object.c
index 45c9721b8c8..6d4ef1524de 100644
--- a/object.c
+++ b/object.c
@@ -3,6 +3,7 @@
 #include "hex.h"
 #include "object.h"
 #include "replace-object.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index eba838d24ee..1371f17d22f 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
diff --git a/pack-check.c b/pack-check.c
index 6974e40a958..40d88bc5ebe 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -6,6 +6,7 @@
 #include "pack-revindex.h"
 #include "progress.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 
 struct idx_entry {
diff --git a/pack-mtimes.c b/pack-mtimes.c
index afed6321906..0096ace080b 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "packfile.h"
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 9f9927d9471..22a1958a1fc 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "gettext.h"
 #include "pack-revindex.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "trace2.h"
diff --git a/packfile.c b/packfile.c
index 02afbe77137..9ae2278c22e 100644
--- a/packfile.c
+++ b/packfile.c
@@ -18,6 +18,7 @@
 #include "trace.h"
 #include "tree-walk.h"
 #include "tree.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "midx.h"
 #include "commit-graph.h"
diff --git a/read-cache.c b/read-cache.c
index cbbfc030da7..f225bf44cd0 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "cache-tree.h"
 #include "refs.h"
 #include "dir.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "tree.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e6a6971381e..d0581ee41ac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -12,6 +12,7 @@
 #include "../dir-iterator.h"
 #include "../lockfile.h"
 #include "../object.h"
+#include "../object-file.h"
 #include "../dir.h"
 #include "../chdir-notify.h"
 #include "../setup.h"
diff --git a/rerere.c b/rerere.c
index 5516e336d01..093c0f6f993 100644
--- a/rerere.c
+++ b/rerere.c
@@ -13,6 +13,7 @@
 #include "ll-merge.h"
 #include "attr.h"
 #include "pathspec.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "hash-lookup.h"
 #include "strmap.h"
diff --git a/revision.c b/revision.c
index 7438b50e267..3d86e07abb8 100644
--- a/revision.c
+++ b/revision.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/sequencer.c b/sequencer.c
index 22b287be984..be10249fd0a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "object.h"
diff --git a/server-info.c b/server-info.c
index 355b6e01a52..68098ddd1ad 100644
--- a/server-info.c
+++ b/server-info.c
@@ -9,6 +9,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "strbuf.h"
 #include "wrapper.h"
diff --git a/streaming.c b/streaming.c
index 27e014d8b23..b3415724ee4 100644
--- a/streaming.c
+++ b/streaming.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "streaming.h"
 #include "repository.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "packfile.h"
diff --git a/submodule.c b/submodule.c
index 4f403b9eeff..d09bc22d4b6 100644
--- a/submodule.c
+++ b/submodule.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "commit-reach.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 5adad1925d1..fff7ff42db7 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -4,6 +4,7 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "environment.h"
+#include "object-file.h"
 #include "sigchain.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/tree-walk.c b/tree-walk.c
index 59add24c8e9..2993c48c2f3 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-store.h"
 #include "trace2.h"
 #include "tree.h"
-- 
gitgitgadget

