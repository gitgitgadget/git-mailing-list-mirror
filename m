Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6BFC77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjEGDrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjEGDrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:47:08 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E301941F
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:46:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3063891d61aso3137953f8f.0
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=foYp9tDJ46gEyun0Rnww9pUSWkTmxCt/a0rYI0HoxZE=;
        b=OzOAA4ivirKdLjcY+9cBMO1FWJBbHAc8bzrDUFJ29gfIhKDdboY5ywFJnfGEAWxbrx
         ih3y7wKKdjPdlgEqYw05bAIa1LD5km1oN24Z5mDE2PlR3nK29HE3+WJGpq4o3jRHZ4SX
         Os4O+K4wFfsWa8RPsCyPtJm82GLv7WsRUIhK39EECiILv2cXuT31bSGNg3R2BUm1+sCd
         cgGRDb4PGVkvFll736CZc7xeSeEQHxpmQ2Pus1padCyy1MkvE5dawTWpNwePoeXbX8dp
         68bVfc4Nn67e/rM/UFSGiAt2o+xIOQw/ou0K6jwvtKSYVNFMwlC2vDV5OZVNo7rnwTTb
         dyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431166; x=1686023166;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foYp9tDJ46gEyun0Rnww9pUSWkTmxCt/a0rYI0HoxZE=;
        b=JU7L4PYZnxr0DSbgIZV2kN2hlbRL1nlhQlq7OhxWY9ZXT4KUXIb+pSEiw5snQYGx7H
         iFLTurUrVEKo5RpID2yQjLNihDh9LsS9p3I5rhaR6cYwvjN8+047P8dn3q09DCrsVQtD
         MI+tsS1cOUhspQtvzv66OeocD19grBwwFFAgZ8Sc4UUzfNlcTfh/D5ZvPbXuNVsEVSlC
         oTW7rniLDw4iXtScnFFpeFbDNJGO09G83uKZS42XTc0lK83H4in3A5BaGPINGYDoFbVK
         S2vETk0nwg1LHafoemih/YJraJF8ctGvjFtzjXZSl0OeB1VTNHqnpxJx2Lc5a5jjJsva
         Zvvw==
X-Gm-Message-State: AC+VfDxB7NBDF5PNQ/aeZs5vsxO7qPxH6B6orj66QJVrcjbiNpie1AIa
        BZj2AGWJQDyEDdjN50KRaCusEmEFrxA=
X-Google-Smtp-Source: ACHHUZ5bFgJqzUGCg7P2o0knbtiBtCEoCKC/7YCzGbRFTkdjtMmKxsTTFAmIw8Ci7BRacxBmyrgXOQ==
X-Received: by 2002:adf:e6c2:0:b0:307:7959:645b with SMTP id y2-20020adfe6c2000000b003077959645bmr3747752wrm.23.1683431165877;
        Sat, 06 May 2023 20:46:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o23-20020a05600c511700b003f07ef4e3e0sm14394795wms.0.2023.05.06.20.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:46:05 -0700 (PDT)
Message-Id: <2cf46f2fc8ebc821d9c8168f55da603e7485f1b9.1683431152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:41 +0000
Subject: [PATCH 16/24] cache.h: remove this no-longer-used header
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

Since this header showed up in some places besides just #include
statements, update/clean-up/remove those other places as well.

Note that compat/fsmonitor/fsm-path-utils-darwin.c previously got
away with violating the rule that all files must start with an include
of git-compat-util.h (or a short-list of alternate headers that happen
to include it first).  This change exposed the violation and caused it
to stop building correctly; fix it by having it include
git-compat-util.h first, as per policy.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/CodingGuidelines           |  2 +-
 Documentation/MyFirstObjectWalk.txt      |  2 +-
 Documentation/user-manual.txt            | 18 ++++++++----------
 Makefile                                 |  2 +-
 add-interactive.c                        |  2 +-
 add-patch.c                              |  2 +-
 apply.c                                  |  2 +-
 attr.c                                   |  2 +-
 blame.c                                  |  2 +-
 builtin.h                                |  1 -
 builtin/add.c                            |  3 +--
 builtin/am.c                             |  3 +--
 builtin/apply.c                          |  1 -
 builtin/archive.c                        |  1 -
 builtin/bisect.c                         |  1 -
 builtin/branch.c                         |  3 +--
 builtin/bundle.c                         |  1 -
 builtin/cat-file.c                       |  3 +--
 builtin/check-attr.c                     |  1 -
 builtin/check-ignore.c                   |  1 -
 builtin/check-ref-format.c               |  3 +--
 builtin/clean.c                          |  1 -
 builtin/column.c                         |  1 -
 builtin/commit-tree.c                    |  3 +--
 builtin/commit.c                         |  3 +--
 builtin/count-objects.c                  |  3 +--
 builtin/describe.c                       |  3 +--
 builtin/diff-files.c                     |  3 +--
 builtin/diff-index.c                     |  3 +--
 builtin/diff-tree.c                      |  3 +--
 builtin/diff.c                           |  3 +--
 builtin/difftool.c                       |  3 +--
 builtin/fast-export.c                    |  1 -
 builtin/fast-import.c                    |  1 -
 builtin/fetch.c                          |  3 +--
 builtin/for-each-ref.c                   |  1 -
 builtin/for-each-repo.c                  |  3 +--
 builtin/fsck.c                           |  1 -
 builtin/get-tar-commit-id.c              |  3 +--
 builtin/grep.c                           |  3 +--
 builtin/help.c                           |  3 +--
 builtin/hook.c                           |  1 -
 builtin/init-db.c                        |  3 +--
 builtin/interpret-trailers.c             |  1 -
 builtin/ls-files.c                       |  3 +--
 builtin/ls-remote.c                      |  1 -
 builtin/ls-tree.c                        |  3 +--
 builtin/mailinfo.c                       |  3 +--
 builtin/mailsplit.c                      |  1 -
 builtin/merge-base.c                     |  1 -
 builtin/merge-file.c                     |  1 -
 builtin/merge-recursive.c                |  1 -
 builtin/merge.c                          |  3 +--
 builtin/multi-pack-index.c               |  1 -
 builtin/notes.c                          |  3 +--
 builtin/patch-id.c                       |  1 -
 builtin/prune.c                          |  3 +--
 builtin/pull.c                           |  3 +--
 builtin/push.c                           |  3 +--
 builtin/range-diff.c                     |  1 -
 builtin/read-tree.c                      |  3 +--
 builtin/replace.c                        |  3 +--
 builtin/rerere.c                         |  1 -
 builtin/rev-list.c                       |  3 +--
 builtin/rev-parse.c                      |  3 +--
 builtin/shortlog.c                       |  1 -
 builtin/show-branch.c                    |  3 +--
 builtin/show-index.c                     |  1 -
 builtin/show-ref.c                       |  1 -
 builtin/sparse-checkout.c                |  1 -
 builtin/stripspace.c                     |  1 -
 builtin/submodule--helper.c              |  1 -
 builtin/symbolic-ref.c                   |  1 -
 builtin/tag.c                            |  3 +--
 builtin/unpack-objects.c                 |  1 -
 builtin/update-index.c                   |  3 +--
 builtin/update-ref.c                     |  3 +--
 builtin/update-server-info.c             |  3 +--
 builtin/upload-archive.c                 |  1 -
 builtin/upload-pack.c                    |  1 -
 builtin/verify-commit.c                  |  3 +--
 builtin/verify-pack.c                    |  1 -
 builtin/verify-tag.c                     |  3 +--
 builtin/worktree.c                       |  3 +--
 builtin/write-tree.c                     |  1 -
 cache-tree.c                             |  2 +-
 cache.h                                  |  6 ------
 compat/fsmonitor/fsm-health-win32.c      |  2 +-
 compat/fsmonitor/fsm-listen-win32.c      |  2 +-
 compat/fsmonitor/fsm-path-utils-darwin.c |  1 +
 compat/fsmonitor/fsm-path-utils-win32.c  |  2 +-
 compat/fsmonitor/fsm-settings-win32.c    |  2 +-
 compat/mingw.c                           |  1 -
 compat/precompose_utf8.c                 |  2 +-
 compat/sha1-chunked.c                    |  2 +-
 compat/simple-ipc/ipc-win32.c            |  2 +-
 compat/win32/trace2_win32_process_info.c |  2 +-
 convert.c                                |  2 +-
 diff-lib.c                               |  2 +-
 diff.c                                   |  2 +-
 entry.c                                  |  2 +-
 environment.c                            |  2 +-
 fsmonitor-ipc.c                          |  2 +-
 fsmonitor.c                              |  2 +-
 fsmonitor.h                              |  1 -
 hash-lookup.c                            |  2 +-
 merge-ort-wrappers.c                     |  2 +-
 merge-ort.c                              |  2 +-
 merge-recursive.c                        |  2 +-
 merge.c                                  |  2 +-
 name-hash.c                              |  2 +-
 object-name.c                            |  2 +-
 object.c                                 |  2 +-
 parallel-checkout.c                      |  2 +-
 pathspec.c                               |  2 +-
 preload-index.c                          |  2 +-
 read-cache.c                             |  2 +-
 refs/files-backend.c                     |  2 +-
 refs/packed-backend.c                    |  2 +-
 repository.c                             |  2 +-
 rerere.c                                 |  2 +-
 resolve-undo.c                           |  2 +-
 revision.c                               |  2 +-
 run-command.h                            |  2 +-
 sequencer.c                              |  2 +-
 shallow.c                                |  2 +-
 sparse-index.c                           |  2 +-
 split-index.c                            |  2 +-
 strbuf.h                                 |  4 ----
 submodule.c                              |  2 +-
 t/helper/test-cache-tree.c               |  1 -
 t/helper/test-dump-cache-tree.c          |  1 -
 t/helper/test-dump-fsmonitor.c           |  1 -
 t/helper/test-dump-split-index.c         |  1 -
 t/helper/test-dump-untracked-cache.c     |  1 -
 t/helper/test-fast-rebase.c              |  1 -
 t/helper/test-fsmonitor-client.c         |  1 -
 t/helper/test-hash-speed.c               |  1 -
 t/helper/test-index-version.c            |  1 -
 t/helper/test-lazy-init-name-hash.c      |  1 -
 t/helper/test-path-utils.c               |  1 -
 t/helper/test-read-cache.c               |  1 -
 t/helper/test-scrap-cache-tree.c         |  1 -
 t/helper/test-sha1.c                     |  1 -
 t/helper/test-sha256.c                   |  1 -
 t/helper/test-strcmp-offset.c            |  1 -
 t/helper/test-write-cache.c              |  1 -
 unpack-trees.c                           |  2 +-
 wt-status.c                              |  2 +-
 149 files changed, 99 insertions(+), 205 deletions(-)
 delete mode 100644 cache.h

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 003393ed161..2b472df29d5 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -444,7 +444,7 @@ For C programs:
  - The first #include in C files, except in platform specific compat/
    implementations and sha1dc/, must be either "git-compat-util.h" or
    one of the approved headers that includes it first for you.  (The
-   approved headers currently include "cache.h", "builtin.h",
+   approved headers currently include "builtin.h",
    "t/helper/test-tool.h", "xdiff/xinclude.h", or
    "reftable/system.h").  You do not have to include more than one of
    these.
diff --git a/Documentation/MyFirstObjectWalk.txt b/Documentation/MyFirstObjectWalk.txt
index eee513e86f4..200e628e301 100644
--- a/Documentation/MyFirstObjectWalk.txt
+++ b/Documentation/MyFirstObjectWalk.txt
@@ -124,7 +124,7 @@ parameters provided by the user over the CLI.
 
 `nr` represents the number of `rev_cmdline_entry` present in the array.
 
-`alloc` is used by the `ALLOC_GROW` macro. Check `cache.h` - this variable is
+`alloc` is used by the `ALLOC_GROW` macro. Check `alloc.h` - this variable is
 used to track the allocated size of the list.
 
 Per entry, we find:
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index dc9c6a663a9..100630ba3d2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -4102,13 +4102,11 @@ Note that terminology has changed since that revision.  For example, the
 README in that revision uses the word "changeset" to describe what we
 now call a <<def_commit_object,commit>>.
 
-Also, we do not call it "cache" any more, but rather "index"; however, the
-file is still called `cache.h`.  Remark: Not much reason to change it now,
-especially since there is no good single name for it anyway, because it is
-basically _the_ header file which is included by _all_ of Git's C sources.
+Also, we do not call it "cache" any more, but rather "index"; however,
+the file is still called `read-cache.h`.
 
 If you grasp the ideas in that initial commit, you should check out a
-more recent version and skim `cache.h`, `object.h` and `commit.h`.
+more recent version and skim `read-cache-ll.h`, `object.h` and `commit.h`.
 
 In the early days, Git (in the tradition of UNIX) was a bunch of programs
 which were extremely simple, and which you used in scripts, piping the
@@ -4119,11 +4117,11 @@ many of these parts have become builtins, and some of the core has been
 and to avoid code duplication.
 
 By now, you know what the index is (and find the corresponding data
-structures in `cache.h`), and that there are just a couple of object types
-(blobs, trees, commits and tags) which inherit their common structure from
-`struct object`, which is their first member (and thus, you can cast e.g.
-`(struct object *)commit` to achieve the _same_ as `&commit->object`, i.e.
-get at the object name and flags).
+structures in `read-cache-ll.h`), and that there are just a couple of
+object types (blobs, trees, commits and tags) which inherit their
+common structure from `struct object`, which is their first member
+(and thus, you can cast e.g.  `(struct object *)commit` to achieve the
+_same_ as `&commit->object`, i.e.  get at the object name and flags).
 
 Now is a good point to take a break to let this information sink in.
 
diff --git a/Makefile b/Makefile
index cbc7f212016..2d180abc5ca 100644
--- a/Makefile
+++ b/Makefile
@@ -1952,7 +1952,7 @@ endif
 	BASIC_CFLAGS += \
 		-DSHA1DC_NO_STANDARD_INCLUDES \
 		-DSHA1DC_INIT_SAFE_HASH_DEFAULT=0 \
-		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"cache.h\"" \
+		-DSHA1DC_CUSTOM_INCLUDE_SHA1_C="\"git-compat-util.h\"" \
 		-DSHA1DC_CUSTOM_INCLUDE_UBC_CHECK_C="\"git-compat-util.h\""
 endif
 endif
diff --git a/add-interactive.c b/add-interactive.c
index a9671e33491..40f88c02051 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "add-interactive.h"
 #include "color.h"
 #include "config.h"
diff --git a/add-patch.c b/add-patch.c
index 7d4d298286d..875b96e2274 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "add-interactive.h"
 #include "advice.h"
 #include "alloc.h"
diff --git a/apply.c b/apply.c
index f056c8f3bb9..e44a5dd7c50 100644
--- a/apply.c
+++ b/apply.c
@@ -7,7 +7,7 @@
  *
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "base85.h"
diff --git a/attr.c b/attr.c
index 57c813d8e77..5a32bfadb37 100644
--- a/attr.c
+++ b/attr.c
@@ -6,7 +6,7 @@
  * an insanely large number of attributes.
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/blame.c b/blame.c
index a29ae7c14b2..15bbf16057a 100644
--- a/blame.c
+++ b/blame.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "refs.h"
 #include "object-store.h"
 #include "cache-tree.h"
diff --git a/builtin.h b/builtin.h
index cb0db676814..3e6c22eef69 100644
--- a/builtin.h
+++ b/builtin.h
@@ -3,7 +3,6 @@
 
 #include "git-compat-util.h"
 #include "strbuf.h"
-#include "cache.h"
 #include "commit.h"
 
 /*
diff --git a/builtin/add.c b/builtin/add.c
index 9fe6b6ce290..50792c0d495 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -4,10 +4,9 @@
  * Copyright (C) 2006 Linus Torvalds
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "config.h"
-#include "builtin.h"
 #include "lockfile.h"
 #include "editor.h"
 #include "dir.h"
diff --git a/builtin/am.c b/builtin/am.c
index 0d8f46f8d5a..2f0f2337915 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -4,11 +4,10 @@
  * Based on git-am.sh by Junio C Hamano.
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
-#include "builtin.h"
 #include "editor.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/builtin/apply.c b/builtin/apply.c
index e3ff02a09e3..c18b7ea5d3d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/archive.c b/builtin/archive.c
index b0eaa3c14a3..90761fdfee0 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
-#include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 4812450c393..bce0ee6268a 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "copy.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 501c47657c9..5e9b0e4ea44 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -5,14 +5,13 @@
  * Based on git-branch.sh by Junio C Hamano.
  */
 
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "color.h"
 #include "editor.h"
 #include "environment.h"
 #include "refs.h"
 #include "commit.h"
-#include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
 #include "remote.h"
diff --git a/builtin/bundle.c b/builtin/bundle.c
index 44113389d7a..3f63631c039 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -6,7 +6,6 @@
 #include "parse-options.h"
 #include "pkt-line.h"
 #include "repository.h"
-#include "cache.h"
 #include "bundle.h"
 
 /*
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0bafc14e6c0..9646e7209ca 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -4,11 +4,10 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "alloc.h"
 #include "config.h"
 #include "convert.h"
-#include "builtin.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index b2b678847f5..869c04420d3 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "attr.h"
 #include "environment.h"
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index e4b78782a32..906cd967536 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 57f0505070f..5eb6bdc3f69 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -2,9 +2,8 @@
  * GIT - The information manager from hell
  */
 
-#include "cache.h"
-#include "refs.h"
 #include "builtin.h"
+#include "refs.h"
 #include "setup.h"
 #include "strbuf.h"
 
diff --git a/builtin/clean.c b/builtin/clean.c
index 49c7af45b03..66b4479356d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -9,7 +9,6 @@
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
-#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/builtin/column.c b/builtin/column.c
index de623a16c2d..ce13ff0baa2 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "strbuf.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d1d251c3ded..d2121f30d45 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
@@ -12,7 +12,6 @@
 #include "repository.h"
 #include "commit.h"
 #include "tree.h"
-#include "builtin.h"
 #include "utf8.h"
 #include "gpg-interface.h"
 #include "parse-options.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index 5be05c9d9e1..3b90cb748cd 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -6,7 +6,7 @@
  */
 
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "config.h"
 #include "lockfile.h"
@@ -15,7 +15,6 @@
 #include "dir.h"
 #include "editor.h"
 #include "environment.h"
-#include "builtin.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "commit.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f3d8f1bcbb0..b9e6b55a9a9 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -4,13 +4,12 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "repository.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index f1be7c36948..508e8df00ef 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -1,5 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
@@ -9,7 +9,6 @@
 #include "tag.h"
 #include "blob.h"
 #include "refs.h"
-#include "builtin.h"
 #include "exec-cmd.h"
 #include "object-name.h"
 #include "parse-options.h"
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 2e6b59a8bb3..b7036aa7c2b 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -3,14 +3,13 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
-#include "builtin.h"
 #include "submodule.h"
 
 static const char diff_files_usage[] =
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index 9b98db2e77e..1ab8f8b6dc5 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -1,11 +1,10 @@
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "commit.h"
 #include "preload-index.h"
 #include "revision.h"
-#include "builtin.h"
 #include "setup.h"
 #include "submodule.h"
 
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 5a1e5d6df7c..3e281150473 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -1,12 +1,11 @@
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "diff.h"
 #include "commit.h"
 #include "gettext.h"
 #include "hex.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "submodule.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/builtin/diff.c b/builtin/diff.c
index a9ce701ff97..b19530c996c 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -4,7 +4,7 @@
  * Copyright (c) 2006 Junio C Hamano
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "ewah/ewok.h"
 #include "lockfile.h"
@@ -20,7 +20,6 @@
 #include "read-cache-ll.h"
 #include "revision.h"
 #include "log-tree.h"
-#include "builtin.h"
 #include "setup.h"
 #include "submodule.h"
 #include "oid-array.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 88809976c53..4a22de3eddb 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -12,11 +12,10 @@
  * Copyright (C) 2016 Johannes Schindelin
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "config.h"
 #include "copy.h"
-#include "builtin.h"
 #include "run-command.h"
 #include "environment.h"
 #include "exec-cmd.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9a95f6a1a82..5f3ffd6912f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2007 Johannes E. Schindelin
  */
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index bbd9b2b3e71..67a2260a5eb 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "cache.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4d7c2897528..cbc991086cd 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1,7 +1,7 @@
 /*
  * "git fetch"
  */
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "config.h"
 #include "gettext.h"
@@ -15,7 +15,6 @@
 #include "oidset.h"
 #include "oid-array.h"
 #include "commit.h"
-#include "builtin.h"
 #include "string-list.h"
 #include "remote.h"
 #include "transport.h"
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 695fc8f4a5e..d0d6ab0fd34 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "refs.h"
diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
index 37daf7bec14..28186b30f54 100644
--- a/builtin/for-each-repo.c
+++ b/builtin/for-each-repo.c
@@ -1,6 +1,5 @@
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "path.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index e8c5fbca58f..f05617ceb14 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/builtin/get-tar-commit-id.c b/builtin/get-tar-commit-id.c
index 564cfcac4fb..9303e386cc7 100644
--- a/builtin/get-tar-commit-id.c
+++ b/builtin/get-tar-commit-id.c
@@ -1,10 +1,9 @@
 /*
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "tar.h"
-#include "builtin.h"
 #include "quote.h"
 #include "wrapper.h"
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 0d567575890..7638d779000 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2006 Junio C Hamano
  */
-#include "cache.h"
+#include "builtin.h"
 #include "alloc.h"
 #include "gettext.h"
 #include "hex.h"
@@ -14,7 +14,6 @@
 #include "commit.h"
 #include "tag.h"
 #include "tree-walk.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "run-command.h"
diff --git a/builtin/help.c b/builtin/help.c
index d3cf4af3f6e..e93533fb09e 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -1,9 +1,8 @@
 /*
  * Builtin help command
  */
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "exec-cmd.h"
 #include "gettext.h"
 #include "pager.h"
diff --git a/builtin/hook.c b/builtin/hook.c
index 88051795c7f..09b51a6487c 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/builtin/init-db.c b/builtin/init-db.c
index feb019a9dea..680ef7e1837 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -3,12 +3,11 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
-#include "builtin.h"
 #include "object-file.h"
 #include "parse-options.h"
 #include "path.h"
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 107ac28f0e8..c5e83452654 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -5,7 +5,6 @@
  *
  */
 
-#include "cache.h"
 #include "builtin.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index d8c1c62bcb0..a49c43864f7 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -5,13 +5,12 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "repository.h"
 #include "config.h"
 #include "convert.h"
 #include "quote.h"
 #include "dir.h"
-#include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
 #include "strbuf.h"
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index cb6cb77e086..a0aadc9b8ff 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "gettext.h"
 #include "hex.h"
 #include "transport.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 077977a4610..f4331c640fc 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
@@ -13,7 +13,6 @@
 #include "tree.h"
 #include "commit.h"
 #include "quote.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "pathspec.h"
 
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index a032a1c3881..53b55dd71c0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -2,9 +2,8 @@
  * Another stupid program, this one parsing the headers of an
  * email to figure out authorship and subject
  */
-#include "cache.h"
-#include "abspath.h"
 #include "builtin.h"
+#include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
 #include "utf8.h"
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 0b6193a0915..3af9ddb8ae5 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -4,7 +4,6 @@
  * It just splits a mbox into a list of files: "0001" "0002" ..
  * so you can process them further from there.
  */
-#include "cache.h"
 #include "builtin.h"
 #include "gettext.h"
 #include "string-list.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 854019a32dc..e68b7fe45d7 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "commit.h"
 #include "gettext.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 781818d08f5..d7eb4c65401 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "setup.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index b9e980384a4..3366699657c 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "advice.h"
 #include "commit.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 6e8f7b9bb53..d7ac108ce94 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -7,7 +7,7 @@
  */
 
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "advice.h"
 #include "alloc.h"
@@ -18,7 +18,6 @@
 #include "hex.h"
 #include "object-name.h"
 #include "parse-options.h"
-#include "builtin.h"
 #include "lockfile.h"
 #include "run-command.h"
 #include "hook.h"
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 1b5083f8b26..5bb71bce08d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "abspath.h"
-#include "cache.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index d5788352b6e..efdf2451486 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -7,9 +7,8 @@
  * and builtin/tag.c by Kristian Høgsberg and Carlos Rica.
  */
 
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "editor.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index 9d5585d3a72..27952f1a6fd 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 5dc9b207200..b3658b5b512 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -1,11 +1,10 @@
-#include "cache.h"
+#include "builtin.h"
 #include "commit.h"
 #include "diff.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "revision.h"
-#include "builtin.h"
 #include "reachable.h"
 #include "parse-options.h"
 #include "progress.h"
diff --git a/builtin/pull.c b/builtin/pull.c
index 8aeb5abc7fb..d4261804d76 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -6,10 +6,9 @@
  * Fetch one or more remote refs and merge it/them into the current HEAD.
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "config.h"
-#include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
 #include "merge.h"
diff --git a/builtin/push.c b/builtin/push.c
index 4e5780dd50d..62d44736500 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -1,7 +1,7 @@
 /*
  * "git push"
  */
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "branch.h"
 #include "config.h"
@@ -10,7 +10,6 @@
 #include "refs.h"
 #include "refspec.h"
 #include "run-command.h"
-#include "builtin.h"
 #include "remote.h"
 #include "transport.h"
 #include "parse-options.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 04339a92ea5..8610390d7c5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "gettext.h"
 #include "object-name.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index bd1ce1d963f..63c92936faa 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -5,7 +5,7 @@
  */
 
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
@@ -17,7 +17,6 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "dir.h"
-#include "builtin.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "resolve-undo.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 981f1894436..e0fbdc98ed3 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -8,9 +8,8 @@
  * git-tag.sh and mktag.c by Linus Torvalds.
  */
 
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/rerere.c b/builtin/rerere.c
index d4bd52797f4..0458db9cadf 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 6dc8be492a2..8029f3de53c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
@@ -15,7 +15,6 @@
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
-#include "builtin.h"
 #include "log-tree.h"
 #include "graph.h"
 #include "bisect.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ad93e5fad88..8d8c870421d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
@@ -14,7 +14,6 @@
 #include "hex.h"
 #include "refs.h"
 #include "quote.h"
-#include "builtin.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "diff.h"
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 46f4e0832ac..99be9dc417d 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 7ef4a642c17..cd215f89af8 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
@@ -6,7 +6,6 @@
 #include "hex.h"
 #include "pretty.h"
 #include "refs.h"
-#include "builtin.h"
 #include "color.h"
 #include "strvec.h"
 #include "object-name.h"
diff --git a/builtin/show-index.c b/builtin/show-index.c
index d839e55335d..540dc3dad1c 100644
--- a/builtin/show-index.c
+++ b/builtin/show-index.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "gettext.h"
 #include "hash.h"
 #include "hex.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index a2243b42195..e07e9ca862f 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 40d420f06cb..5c8ffb1f759 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/builtin/stripspace.c b/builtin/stripspace.c
index 9451eb69ff4..397d7fe2dcd 100644
--- a/builtin/stripspace.c
+++ b/builtin/stripspace.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 86324b829a7..17567d91c88 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -6,7 +6,6 @@
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
-#include "cache.h"
 #include "config.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 10198a74fae..a61fa3c0f81 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -1,6 +1,5 @@
 #include "builtin.h"
 #include "config.h"
-#include "cache.h"
 #include "gettext.h"
 #include "refs.h"
 #include "parse-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 1850a6a6fdc..ce298d08945 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -6,10 +6,9 @@
  * Based on git-tag.sh and mktag.c by Linus Torvalds.
  */
 
-#include "cache.h"
+#include "builtin.h"
 #include "advice.h"
 #include "config.h"
-#include "builtin.h"
 #include "editor.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 2c52c3a741f..85baf6a131a 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "bulk-checkin.h"
 #include "config.h"
 #include "environment.h"
diff --git a/builtin/update-index.c b/builtin/update-index.c
index 484a307df50..aee3cb8cbd3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -4,7 +4,7 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "builtin.h"
 #include "bulk-checkin.h"
 #include "config.h"
 #include "environment.h"
@@ -15,7 +15,6 @@
 #include "quote.h"
 #include "cache-tree.h"
 #include "tree-walk.h"
-#include "builtin.h"
 #include "object-file.h"
 #include "refs.h"
 #include "resolve-undo.h"
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 0c59b1c9eff..242102273ee 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "config.h"
 #include "gettext.h"
 #include "hash.h"
 #include "refs.h"
-#include "builtin.h"
 #include "object-name.h"
 #include "parse-options.h"
 #include "quote.h"
diff --git a/builtin/update-server-info.c b/builtin/update-server-info.c
index 19dce3c0655..1dc3971edeb 100644
--- a/builtin/update-server-info.c
+++ b/builtin/update-server-info.c
@@ -1,6 +1,5 @@
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
 #include "server-info.h"
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 44ad400e183..d4c7f162ff0 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -1,7 +1,6 @@
 /*
  * Copyright (c) 2006 Franck Bui-Huu
  */
-#include "cache.h"
 #include "builtin.h"
 #include "archive.h"
 #include "pkt-line.h"
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index beb9dd08610..ba5103a9331 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -1,4 +1,3 @@
-#include "cache.h"
 #include "builtin.h"
 #include "exec-cmd.h"
 #include "gettext.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 5d99b82a64f..aa34fb896ac 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -5,9 +5,8 @@
  *
  * Based on git-verify-tag
  */
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "gettext.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 190fd695409..aba92cf8af7 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -1,5 +1,4 @@
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "gettext.h"
 #include "run-command.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index c6019a0ad8c..d8753270ebe 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -5,9 +5,8 @@
  *
  * Based on git-verify-tag.sh
  */
-#include "cache.h"
-#include "config.h"
 #include "builtin.h"
+#include "config.h"
 #include "gettext.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 3c3d97ad5b0..b9a84988637 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,9 +1,8 @@
-#include "cache.h"
+#include "builtin.h"
 #include "abspath.h"
 #include "checkout.h"
 #include "config.h"
 #include "copy.h"
-#include "builtin.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index f98d54c1df2..5917085f429 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -5,7 +5,6 @@
  */
 #define USE_THE_INDEX_VARIABLE
 #include "builtin.h"
-#include "cache.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/cache-tree.c b/cache-tree.c
index 153217b47ff..077932c2db5 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "hex.h"
diff --git a/cache.h b/cache.h
deleted file mode 100644
index 9b4e8d16874..00000000000
--- a/cache.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef CACHE_H
-#define CACHE_H
-
-#include "git-compat-util.h"
-
-#endif /* CACHE_H */
diff --git a/compat/fsmonitor/fsm-health-win32.c b/compat/fsmonitor/fsm-health-win32.c
index fe11bdd9ce6..6c81d7ee5c2 100644
--- a/compat/fsmonitor/fsm-health-win32.c
+++ b/compat/fsmonitor/fsm-health-win32.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-health.h"
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 677b1bbdeca..3c0df5cff8c 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsm-listen.h"
diff --git a/compat/fsmonitor/fsm-path-utils-darwin.c b/compat/fsmonitor/fsm-path-utils-darwin.c
index 45eb4a9b9e7..ef0142e0fbf 100644
--- a/compat/fsmonitor/fsm-path-utils-darwin.c
+++ b/compat/fsmonitor/fsm-path-utils-darwin.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
diff --git a/compat/fsmonitor/fsm-path-utils-win32.c b/compat/fsmonitor/fsm-path-utils-win32.c
index 4024baafb97..27bb6945183 100644
--- a/compat/fsmonitor/fsm-path-utils-win32.c
+++ b/compat/fsmonitor/fsm-path-utils-win32.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "fsmonitor.h"
 #include "fsmonitor-path-utils.h"
 #include "gettext.h"
diff --git a/compat/fsmonitor/fsm-settings-win32.c b/compat/fsmonitor/fsm-settings-win32.c
index a8af31b71de..37288978643 100644
--- a/compat/fsmonitor/fsm-settings-win32.c
+++ b/compat/fsmonitor/fsm-settings-win32.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "repository.h"
 #include "fsmonitor.h"
diff --git a/compat/mingw.c b/compat/mingw.c
index d06cdc6254f..559abb1c617 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -6,7 +6,6 @@
 #include <wchar.h>
 #include "../strbuf.h"
 #include "../run-command.h"
-#include "../cache.h"
 #include "../abspath.h"
 #include "../alloc.h"
 #include "win32/lazyload.h"
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index fb08475bc64..0bd5c24250a 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -5,7 +5,7 @@
 
 #define PRECOMPOSE_UNICODE_C
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/compat/sha1-chunked.c b/compat/sha1-chunked.c
index 56729d92dcf..a4a6f930d7b 100644
--- a/compat/sha1-chunked.c
+++ b/compat/sha1-chunked.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hash-ll.h"
 
 int git_SHA1_Update_Chunked(platform_SHA_CTX *c, const void *data, size_t len)
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 6adce3c650e..8bfe51248e5 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "gettext.h"
 #include "simple-ipc.h"
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index a4e33768f43..a2b1506f9c9 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,4 +1,4 @@
-#include "../../cache.h"
+#include "../../git-compat-util.h"
 #include "../../json-writer.h"
 #include "../../repository.h"
 #include "../../trace2.h"
diff --git a/convert.c b/convert.c
index 236d5e3dc25..9e89f660308 100644
--- a/convert.c
+++ b/convert.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "config.h"
 #include "convert.h"
diff --git a/diff-lib.c b/diff-lib.c
index 36cd66ea237..f3aa7f93c78 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "quote.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/diff.c b/diff.c
index 61b4dc61e1e..5e81dc0d02d 100644
--- a/diff.c
+++ b/diff.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2005 Junio C Hamano
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "base85.h"
diff --git a/entry.c b/entry.c
index 53d00386748..041f5cf212d 100644
--- a/entry.c
+++ b/entry.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "blob.h"
 #include "object-store.h"
 #include "dir.h"
diff --git a/environment.c b/environment.c
index 28d18eaca8e..0cdd20a1589 100644
--- a/environment.c
+++ b/environment.c
@@ -110,7 +110,7 @@ char *git_work_tree_cfg;
 static char *git_namespace;
 
 /*
- * Repository-local GIT_* environment variables; see cache.h for details.
+ * Repository-local GIT_* environment variables; see environment.h for details.
  */
 const char * const local_repo_env[] = {
 	ALTERNATE_DB_ENVIRONMENT,
diff --git a/fsmonitor-ipc.c b/fsmonitor-ipc.c
index 6a6a89764a6..6ace978a1b4 100644
--- a/fsmonitor-ipc.c
+++ b/fsmonitor-ipc.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "fsmonitor.h"
 #include "gettext.h"
 #include "simple-ipc.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index 28c083d4d84..f670c509378 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/fsmonitor.h b/fsmonitor.h
index 8b7a521552a..7702301d214 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -1,7 +1,6 @@
 #ifndef FSMONITOR_H
 #define FSMONITOR_H
 
-#include "cache.h"
 #include "dir.h"
 #include "fsmonitor-settings.h"
 #include "object.h"
diff --git a/hash-lookup.c b/hash-lookup.c
index 8fec8939fd3..9f0f95e2b9e 100644
--- a/hash-lookup.c
+++ b/hash-lookup.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "hash.h"
 #include "hash-lookup.h"
 #include "read-cache-ll.h"
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index a0bedcb63bb..4acedf3c338 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
 #include "merge-ort.h"
diff --git a/merge-ort.c b/merge-ort.c
index 5512f40d321..c2d2ee73eaa 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -14,7 +14,7 @@
  * "cale", "peedy", or "ins" instead of "ort"?)
  */
 
-#include "cache.h"
+#include "git-compat-util.h"
 #include "merge-ort.h"
 
 #include "alloc.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 0e16e7a06df..4bef9b62fa8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3,7 +3,7 @@
  * Fredrik Kuivinen.
  * The thieves were Alex Riesen and Johannes Schindelin, in June/July 2006
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "merge-recursive.h"
 
 #include "advice.h"
diff --git a/merge.c b/merge.c
index fade6b203b3..83bcba6943e 100644
--- a/merge.c
+++ b/merge.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "gettext.h"
diff --git a/name-hash.c b/name-hash.c
index f2f3564cb20..251f036eef6 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -5,7 +5,7 @@
  *
  * Copyright (C) 2008 Linus Torvalds
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
diff --git a/object-name.c b/object-name.c
index 1eefeef746e..45f4d51305b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "object-name.h"
 #include "advice.h"
 #include "config.h"
diff --git a/object.c b/object.c
index 333e736fb24..60f954194f7 100644
--- a/object.c
+++ b/object.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
 #include "object.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 2b1439c0c5f..602fbf19d3c 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "entry.h"
diff --git a/pathspec.c b/pathspec.c
index 47d172fe414..0baa85384f8 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "config.h"
 #include "dir.h"
diff --git a/preload-index.c b/preload-index.c
index d037a951efa..e44530c80cf 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -1,7 +1,7 @@
 /*
  * Copyright (C) 2008 Linus Torvalds
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "pathspec.h"
 #include "dir.h"
 #include "environment.h"
diff --git a/read-cache.c b/read-cache.c
index 42f27b06642..edab96765df 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -3,7 +3,7 @@
  *
  * Copyright (C) Linus Torvalds, 2005
  */
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "bulk-checkin.h"
 #include "config.h"
diff --git a/refs/files-backend.c b/refs/files-backend.c
index bca7b851c5a..01c08207619 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1,4 +1,4 @@
-#include "../cache.h"
+#include "../git-compat-util.h"
 #include "../config.h"
 #include "../copy.h"
 #include "../environment.h"
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 085becf773e..713491a9e2c 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,4 @@
-#include "../cache.h"
+#include "../git-compat-util.h"
 #include "../alloc.h"
 #include "../config.h"
 #include "../gettext.h"
diff --git a/repository.c b/repository.c
index ebad755c2cc..67ec56a70c5 100644
--- a/repository.c
+++ b/repository.c
@@ -3,7 +3,7 @@
  * declaration matches the definition in this file.
  */
 #define USE_THE_INDEX_VARIABLE
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
 #include "object-store.h"
diff --git a/rerere.c b/rerere.c
index 3bc9aedc286..2fb93a51125 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/resolve-undo.c b/resolve-undo.c
index 59598877841..7817f5d6db1 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "dir.h"
 #include "hash.h"
 #include "read-cache.h"
diff --git a/revision.c b/revision.c
index 8d37ec9f495..66a1fece0df 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/run-command.h b/run-command.h
index 9e47f91d462..1f22cc3827d 100644
--- a/run-command.h
+++ b/run-command.h
@@ -503,7 +503,7 @@ void run_processes_parallel(const struct run_process_parallel_opts *opts);
  * exception of GIT_CONFIG_PARAMETERS and GIT_CONFIG_COUNT (which cause the
  * corresponding environment variables to be unset in the subprocess) and adds
  * an environment variable pointing to new_git_dir. See local_repo_env in
- * cache.h for more information.
+ * environment.h for more information.
  */
 void prepare_other_repo_env(struct strvec *env, const char *new_git_dir);
 
diff --git a/sequencer.c b/sequencer.c
index ec4a2e80a10..08bd0e81743 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "alloc.h"
diff --git a/shallow.c b/shallow.c
index a2ebf0af2ba..f1c93e74648 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/sparse-index.c b/sparse-index.c
index 60451daae80..2c47954d933 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/split-index.c b/split-index.c
index 0a8d3903d6f..0ee3865a553 100644
--- a/split-index.c
+++ b/split-index.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
 #include "gettext.h"
 #include "hash.h"
diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c2..e8dfab6ecd6 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -72,10 +72,6 @@ struct strbuf {
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .buf = strbuf_slopbuf }
 
-/*
- * Predeclare this here, since cache.h includes this file before it defines the
- * struct.
- */
 struct object_id;
 
 /**
diff --git a/submodule.c b/submodule.c
index e09722d6be3..20aa8ed0fb8 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "repository.h"
diff --git a/t/helper/test-cache-tree.c b/t/helper/test-cache-tree.c
index 9d64422b3cc..e7236392c81 100644
--- a/t/helper/test-cache-tree.c
+++ b/t/helper/test-cache-tree.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "gettext.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/t/helper/test-dump-cache-tree.c b/t/helper/test-dump-cache-tree.c
index 78aa11bb194..c38f546e4f0 100644
--- a/t/helper/test-dump-cache-tree.c
+++ b/t/helper/test-dump-cache-tree.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "hash.h"
 #include "hex.h"
 #include "tree.h"
diff --git a/t/helper/test-dump-fsmonitor.c b/t/helper/test-dump-fsmonitor.c
index e4357d65ec5..4f215fea025 100644
--- a/t/helper/test-dump-fsmonitor.c
+++ b/t/helper/test-dump-fsmonitor.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "read-cache-ll.h"
 #include "repository.h"
 #include "setup.h"
diff --git a/t/helper/test-dump-split-index.c b/t/helper/test-dump-split-index.c
index 59a24a842b4..5cf0b26dca1 100644
--- a/t/helper/test-dump-split-index.c
+++ b/t/helper/test-dump-split-index.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "hex.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index a1cbafd64f3..b4af9712fe5 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "dir.h"
 #include "hex.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index cbcf2419f9b..62c5b5d704b 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -12,7 +12,6 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "environment.h"
diff --git a/t/helper/test-fsmonitor-client.c b/t/helper/test-fsmonitor-client.c
index 386f4cdaee5..58d1dc5fc83 100644
--- a/t/helper/test-fsmonitor-client.c
+++ b/t/helper/test-fsmonitor-client.c
@@ -4,7 +4,6 @@
  */
 
 #include "test-tool.h"
-#include "cache.h"
 #include "parse-options.h"
 #include "fsmonitor-ipc.h"
 #include "read-cache-ll.h"
diff --git a/t/helper/test-hash-speed.c b/t/helper/test-hash-speed.c
index c1e82d5d028..b235da594f7 100644
--- a/t/helper/test-hash-speed.c
+++ b/t/helper/test-hash-speed.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hash-ll.h"
 
 #define NUM_SECONDS 3
diff --git a/t/helper/test-index-version.c b/t/helper/test-index-version.c
index b3cbaf6d2a8..f3c2dbe0a2c 100644
--- a/t/helper/test-index-version.c
+++ b/t/helper/test-index-version.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "read-cache-ll.h"
 
 int cmd__index_version(int argc UNUSED, const char **argv UNUSED)
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 8eb327b3b93..187a115d574 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "environment.h"
 #include "name-hash.h"
 #include "parse-options.h"
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 90e4d29a06f..70396fa3845 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "abspath.h"
 #include "environment.h"
 #include "path.h"
diff --git a/t/helper/test-read-cache.c b/t/helper/test-read-cache.c
index 0d548814e08..56c2d25f359 100644
--- a/t/helper/test-read-cache.c
+++ b/t/helper/test-read-cache.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "config.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/t/helper/test-scrap-cache-tree.c b/t/helper/test-scrap-cache-tree.c
index 7b7e2384043..0a816a96e28 100644
--- a/t/helper/test-scrap-cache-tree.c
+++ b/t/helper/test-scrap-cache-tree.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/t/helper/test-sha1.c b/t/helper/test-sha1.c
index dc6fb17f2a7..dcb7f6c0032 100644
--- a/t/helper/test-sha1.c
+++ b/t/helper/test-sha1.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hash-ll.h"
 
 int cmd__sha1(int ac, const char **av)
diff --git a/t/helper/test-sha256.c b/t/helper/test-sha256.c
index f50f64f1f22..08cf1490014 100644
--- a/t/helper/test-sha256.c
+++ b/t/helper/test-sha256.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "hash-ll.h"
 
 int cmd__sha256(int ac, const char **av)
diff --git a/t/helper/test-strcmp-offset.c b/t/helper/test-strcmp-offset.c
index d3f39207f14..d8473cf2fcf 100644
--- a/t/helper/test-strcmp-offset.c
+++ b/t/helper/test-strcmp-offset.c
@@ -1,5 +1,4 @@
 #include "test-tool.h"
-#include "cache.h"
 #include "read-cache-ll.h"
 
 int cmd__strcmp_offset(int argc UNUSED, const char **argv)
diff --git a/t/helper/test-write-cache.c b/t/helper/test-write-cache.c
index d27125eeacf..f084034d38e 100644
--- a/t/helper/test-write-cache.c
+++ b/t/helper/test-write-cache.c
@@ -1,6 +1,5 @@
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-#include "cache.h"
 #include "lockfile.h"
 #include "read-cache-ll.h"
 #include "repository.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index fdcc46e474f..4b620df3031 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "strvec.h"
 #include "repository.h"
diff --git a/wt-status.c b/wt-status.c
index 847b63c906e..6ee8567ac2d 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1,4 +1,4 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "advice.h"
 #include "wt-status.h"
 #include "object.h"
-- 
gitgitgadget

