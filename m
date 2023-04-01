Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8279C6FD1D
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbjDAPLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDAPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:10:55 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8D1FD15
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:49 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v6-20020a05600c470600b003f034269c96so5348146wmo.4
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xrf/NwxaUG3/t75Tte5zp+av0w4XC24ysDDnwn4UyYg=;
        b=Yq7tfjHChqX44GzbjwWL28LAygLsCLJAfE47bGH4BIcc/sehamcyDJu5vjHbi6I+OV
         aTWJYn10a2BTtu/46hPsbiwEnG00BSk262ITMf3AK96B24A2xHbHgD2ALrLVWzac0qBD
         24POLSxqG5Jd3jGxsFoDhpJnnzZA6L+4frdRu4XLigOrC809KC9ZSJfB7QGWz8THRX72
         4SaF8UVu59IPIIwNtal8l/eB63cKL23qHbbBpue80Z0u6/lfMgA2cWxduykmevgYGY5X
         GPc1nPUeTZKIF7gYNXtCAaIvv+jSY6vAsmrP8FblefSymg7aV3lBBwjDG1/hREqTYffC
         PWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361847;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xrf/NwxaUG3/t75Tte5zp+av0w4XC24ysDDnwn4UyYg=;
        b=6ANrgQnEHQgku11i1b/WRGz/iCc2tOvcMxuSbdZ4dBGA8gSewNwHc3ZtlBPLyw5WM0
         UI2WwxJ8dVRUGeGwrFZ00AwDMV6NgR5hqzKsGcA4PJP+Pf8L/W30aEARcbGA6AjsopIn
         wEPm5ZKmBurYixbf4q5o54bu2P0DgdqOvj4Fw1RfroIEXf31KbhGuwo6j5rIdt047m8r
         QBfHSbSn0vvb5nmpVwERyNkgQieNAJ9RiNgtjA5VMB9lQ+5wqpdzDigwv84q6kvERApa
         4XFd3dZWsQBOdyWtHQAtutop5INcSU/pwX4qaJ9CUV5L3x7fedLAnj/pWWcZjiMRtjxl
         N/qg==
X-Gm-Message-State: AAQBX9egpZyyCV4we30DXKIcFcp/A0vfX3/wLNc9N4zjt8qv8/8d9O9Y
        hLH9HOu1JvMA5Zc41/HfvfhkCyQQKzk=
X-Google-Smtp-Source: AKy350bCv7jMH8ekpCaLo1/KZOcFFPEjTOlQ7vCRfKsF5cKoCYhrgXvMNWmZuigK9GSl85xfEaD4fg==
X-Received: by 2002:a7b:c444:0:b0:3ef:72e7:fce2 with SMTP id l4-20020a7bc444000000b003ef72e7fce2mr13583745wmi.17.1680361847128;
        Sat, 01 Apr 2023 08:10:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm13533657wmb.28.2023.04.01.08.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:46 -0700 (PDT)
Message-Id: <b513a6711ffb0f758e3d1a208d441dfe0faafbe9.1680361839.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:21 +0000
Subject: [PATCH 08/24] object-name.h: move declarations for object-name.c
 functions from cache.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 add-patch.c                      |  1 +
 apply.c                          |  1 +
 archive.h                        |  1 +
 branch.c                         |  1 +
 builtin/am.c                     |  1 +
 builtin/bisect.c                 |  1 +
 builtin/blame.c                  |  1 +
 builtin/branch.c                 |  1 +
 builtin/cat-file.c               |  1 +
 builtin/check-attr.c             |  1 +
 builtin/checkout.c               |  1 +
 builtin/commit-tree.c            |  1 +
 builtin/commit.c                 |  1 +
 builtin/describe.c               |  1 +
 builtin/fast-import.c            |  1 +
 builtin/fetch.c                  |  1 +
 builtin/fsck.c                   |  1 +
 builtin/grep.c                   |  1 +
 builtin/log.c                    |  1 +
 builtin/ls-files.c               |  1 +
 builtin/ls-tree.c                |  1 +
 builtin/merge-base.c             |  1 +
 builtin/merge-recursive.c        |  1 +
 builtin/merge-tree.c             |  1 +
 builtin/merge.c                  |  1 +
 builtin/name-rev.c               |  1 +
 builtin/notes.c                  |  1 +
 builtin/prune.c                  |  1 +
 builtin/pull.c                   |  1 +
 builtin/range-diff.c             |  1 +
 builtin/read-tree.c              |  1 +
 builtin/rebase.c                 |  1 +
 builtin/receive-pack.c           |  1 +
 builtin/replace.c                |  1 +
 builtin/reset.c                  |  1 +
 builtin/rev-list.c               |  1 +
 builtin/rev-parse.c              |  1 +
 builtin/rm.c                     |  1 +
 builtin/show-branch.c            |  1 +
 builtin/show-ref.c               |  1 +
 builtin/sparse-checkout.c        |  1 +
 builtin/stash.c                  |  1 +
 builtin/submodule--helper.c      |  1 +
 builtin/tag.c                    |  1 +
 builtin/unpack-file.c            |  1 +
 builtin/update-ref.c             |  1 +
 builtin/verify-commit.c          |  1 +
 builtin/verify-tag.c             |  1 +
 builtin/worktree.c               |  1 +
 cache.h                          | 88 ----------------------------
 checkout.c                       |  1 +
 combine-diff.c                   |  1 +
 commit.c                         |  1 +
 config.c                         |  1 +
 diff-lib.c                       |  1 +
 diff.c                           |  1 +
 fmt-merge-msg.c                  |  1 +
 list-objects-filter.c            |  1 +
 log-tree.c                       |  1 +
 mailmap.c                        |  1 +
 merge-ort.c                      |  1 +
 notes-merge.c                    |  1 +
 notes.c                          |  1 +
 object-name.c                    |  1 +
 object-name.h                    | 99 ++++++++++++++++++++++++++++++++
 parse-options-cb.c               |  1 +
 range-diff.c                     |  1 +
 read-cache.c                     |  1 +
 rebase-interactive.c             |  1 +
 ref-filter.c                     |  1 +
 refs.c                           |  1 +
 remote.c                         |  1 +
 reset.c                          |  1 +
 revision.c                       |  1 +
 sequencer.c                      |  1 +
 setup.c                          |  1 +
 strbuf.c                         |  1 +
 submodule-config.c               |  1 +
 submodule.c                      |  1 +
 t/helper/test-fast-rebase.c      |  1 +
 t/helper/test-match-trees.c      |  1 +
 t/helper/test-oidmap.c           |  1 +
 t/helper/test-reach.c            |  1 +
 t/helper/test-submodule-config.c |  1 +
 tag.c                            |  1 +
 transport-helper.c               |  1 +
 transport.c                      |  1 +
 tree.c                           |  1 +
 wt-status.c                      |  1 +
 89 files changed, 186 insertions(+), 88 deletions(-)
 create mode 100644 object-name.h

diff --git a/add-patch.c b/add-patch.c
index b381f14a7de..b01ba8fa81d 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -4,6 +4,7 @@
 #include "alloc.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "strbuf.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/apply.c b/apply.c
index 9b7288bc927..7e40f53ec4c 100644
--- a/apply.c
+++ b/apply.c
@@ -22,6 +22,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "rerere.h"
diff --git a/archive.h b/archive.h
index 7178e2a9a2d..f96839ef383 100644
--- a/archive.h
+++ b/archive.h
@@ -2,6 +2,7 @@
 #define ARCHIVE_H
 
 #include "cache.h"
+#include "object-name.h"
 #include "pathspec.h"
 
 struct repository;
diff --git a/branch.c b/branch.c
index 3a087b8b4c1..f29743b1619 100644
--- a/branch.c
+++ b/branch.c
@@ -6,6 +6,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "refs.h"
 #include "refspec.h"
 #include "remote.h"
diff --git a/builtin/am.c b/builtin/am.c
index 8d876f31546..0d7ee28bddc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -27,6 +27,7 @@
 #include "diffcore.h"
 #include "unpack-trees.h"
 #include "branch.h"
+#include "object-name.h"
 #include "sequencer.h"
 #include "revision.h"
 #include "merge-recursive.h"
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 7dc175c6570..4b2143d4557 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -3,6 +3,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "bisect.h"
 #include "refs.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index a8d2114adc9..a628388c2ce 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,6 +28,7 @@
 #include "line-log.h"
 #include "dir.h"
 #include "progress.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "blame.h"
 #include "refs.h"
diff --git a/builtin/branch.c b/builtin/branch.c
index 5706eb00974..7c1c872708f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -13,6 +13,7 @@
 #include "commit.h"
 #include "builtin.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "remote.h"
 #include "parse-options.h"
 #include "branch.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 1e4b4798f40..60b7a55dfc1 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -20,6 +20,7 @@
 #include "tree-walk.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 1dbe9d6ca88..037bf1aaa2a 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -5,6 +5,7 @@
 #include "attr.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "quote.h"
 #include "setup.h"
 #include "parse-options.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 65988fd8a3b..6f5d82ed3d3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -17,6 +17,7 @@
 #include "lockfile.h"
 #include "mem-pool.h"
 #include "merge-recursive.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "refs.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 15be167f87a..d1d251c3ded 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/builtin/commit.c b/builtin/commit.c
index b09017e04f9..682f47c8d5a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -27,6 +27,7 @@
 #include "log-tree.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "rerere.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 0125d4ddbac..d360b1d12af 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -11,6 +11,7 @@
 #include "refs.h"
 #include "builtin.h"
 #include "exec-cmd.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "revision.h"
 #include "diff.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 68b1a539870..31b8732128d 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -19,6 +19,7 @@
 #include "dir.h"
 #include "run-command.h"
 #include "packfile.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index e0936629213..8a8ab6799e8 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -10,6 +10,7 @@
 #include "repository.h"
 #include "refs.h"
 #include "refspec.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "oidset.h"
 #include "oid-array.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 095b39d3980..04bc71d148c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "streaming.h"
 #include "decorate.h"
 #include "packfile.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "resolve-undo.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index a1b68d90bdb..f66e14389e1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,6 +26,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "write-or-die.h"
diff --git a/builtin/log.c b/builtin/log.c
index 094897df236..5cdc2276cc4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -12,6 +12,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7f228353feb..ce083cb8efd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -13,6 +13,7 @@
 #include "dir.h"
 #include "builtin.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "strbuf.h"
 #include "tree.h"
 #include "cache-tree.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index f32e6be2198..077977a4610 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -7,6 +7,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 3f22273b400..854019a32dc 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "diff.h"
 #include "revision.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "repository.h"
 #include "commit-reach.h"
diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index 25f42f2be7e..fa1035405c3 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "tag.h"
 #include "merge-recursive.h"
+#include "object-name.h"
 #include "xdiff-interface.h"
 
 static const char builtin_merge_recursive_usage[] =
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 803e380856e..6b9f006ec19 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -8,6 +8,7 @@
 #include "commit.h"
 #include "commit-reach.h"
 #include "merge-ort.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/builtin/merge.c b/builtin/merge.c
index 225b7064066..693f185d4d3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -15,6 +15,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "builtin.h"
 #include "lockfile.h"
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 831d360a78a..41fd56b9ba9 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -8,6 +8,7 @@
 #include "commit.h"
 #include "tag.h"
 #include "refs.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "prio-queue.h"
 #include "hash-lookup.h"
diff --git a/builtin/notes.c b/builtin/notes.c
index 4ff44f1e3d0..896140b9055 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -13,6 +13,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
 #include "blob.h"
diff --git a/builtin/prune.c b/builtin/prune.c
index 5c0952f5c64..09891832fb3 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -11,6 +11,7 @@
 #include "progress.h"
 #include "prune-packed.h"
 #include "replace-object.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "shallow.h"
 
diff --git a/builtin/pull.c b/builtin/pull.c
index 636ce12c94d..967368ebc65 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -12,6 +12,7 @@
 #include "builtin.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "exec-cmd.h"
 #include "run-command.h"
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index b72af527f08..04339a92ea5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "builtin.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "range-diff.h"
 #include "config.h"
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index 600d4f748fc..d61cbad96de 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -11,6 +11,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "object.h"
+#include "object-name.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "cache-tree.h"
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fb859f93a30..ff5dd77608d 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -21,6 +21,7 @@
 #include "cache-tree.h"
 #include "unpack-trees.h"
 #include "lockfile.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index aa5b6fe861f..7d921170f1c 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -29,6 +29,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "protocol.h"
 #include "commit-reach.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index d2adc8ab613..134f738a450 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -17,6 +17,7 @@
 #include "refs.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "replace-object.h"
 #include "repository.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index d8c52cc6edf..f99f32d5802 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -24,6 +24,7 @@
 #include "diffcore.h"
 #include "tree.h"
 #include "branch.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "unpack-trees.h"
 #include "cache-tree.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index a3dbbb6338e..c17f0282ae8 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -10,6 +10,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "object.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "pack.h"
 #include "pack-bitmap.h"
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1af2089f9bd..852e49e3403 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -15,6 +15,7 @@
 #include "refs.h"
 #include "quote.h"
 #include "builtin.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/builtin/rm.c b/builtin/rm.c
index 6be92817429..d36072252e7 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -13,6 +13,7 @@
 #include "cache-tree.h"
 #include "gettext.h"
 #include "tree-walk.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "string-list.h"
 #include "setup.h"
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 463a8d11c31..20030b75e39 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -8,6 +8,7 @@
 #include "builtin.h"
 #include "color.h"
 #include "strvec.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "dir.h"
 #include "commit-slab.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 138d30a005e..a2243b42195 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -4,6 +4,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 090bf33510a..34b9d92fb13 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -4,6 +4,7 @@
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "pathspec.h"
 #include "repository.h"
diff --git a/builtin/stash.c b/builtin/stash.c
index 14194b13bd1..6442b5e20a6 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "refs.h"
 #include "lockfile.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 83377037155..1f087d7bed2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -24,6 +24,7 @@
 #include "revision.h"
 #include "diffcore.h"
 #include "diff.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "advice.h"
 #include "branch.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 3e801f54a07..88a25902309 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -14,6 +14,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "tag.h"
 #include "run-command.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 314761b0b4d..21082ceb601 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -1,6 +1,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "wrapper.h"
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 3ffd75b3e78..6ca85420c3b 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "refs.h"
 #include "builtin.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "quote.h"
 #include "strvec.h"
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 4d10aa98b10..5d99b82a64f 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -9,6 +9,7 @@
 #include "config.h"
 #include "builtin.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 28d0da68454..c6019a0ad8c 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -11,6 +11,7 @@
 #include "gettext.h"
 #include "tag.h"
 #include "run-command.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "gpg-interface.h"
 #include "ref-filter.h"
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 944dd40f94d..69132bba319 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "strvec.h"
 #include "branch.h"
diff --git a/cache.h b/cache.h
index 66705dd469e..dfae7d02c55 100644
--- a/cache.h
+++ b/cache.h
@@ -687,24 +687,6 @@ extern int quote_path_fully;
 #define DATA_CHANGED    0x0020
 #define TYPE_CHANGED    0x0040
 
-/*
- * Return an abbreviated sha1 unique within this repository's object database.
- * The result will be at least `len` characters long, and will be NUL
- * terminated.
- *
- * The non-`_r` version returns a static buffer which remains valid until 4
- * more calls to repo_find_unique_abbrev are made.
- *
- * The `_r` variant writes to a buffer supplied by the caller, which must be at
- * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of bytes
- * written (excluding the NUL terminator).
- *
- * Note that while this version avoids the static buffer, it is not fully
- * reentrant, as it calls into other non-reentrant git code.
- */
-const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
-int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
-
 /*
  * Create the directory containing the named path, using care to be
  * somewhat safe against races. Return one of the scld_error values to
@@ -828,72 +810,6 @@ struct object_context {
 	char *path;
 };
 
-int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
-__attribute__((format (printf, 2, 3)))
-int get_oidf(struct object_id *oid, const char *fmt, ...);
-int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
-int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
-int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
-int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
-int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
-int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid);
-void maybe_die_on_misspelt_object_name(struct repository *repo,
-				       const char *name,
-				       const char *prefix);
-enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
-					 unsigned flags, struct object_id *oid,
-					 struct object_context *oc);
-
-typedef int each_abbrev_fn(const struct object_id *oid, void *);
-int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
-
-int set_disambiguate_hint_config(const char *var, const char *value);
-
-/*
- * This reads short-hand syntax that not only evaluates to a commit
- * object name, but also can act as if the end user spelled the name
- * of the branch from the command line.
- *
- * - "@{-N}" finds the name of the Nth previous branch we were on, and
- *   places the name of the branch in the given buf and returns the
- *   number of characters parsed if successful.
- *
- * - "<branch>@{upstream}" finds the name of the other ref that
- *   <branch> is configured to merge with (missing <branch> defaults
- *   to the current branch), and places the name of the branch in the
- *   given buf and returns the number of characters parsed if
- *   successful.
- *
- * If the input is not of the accepted format, it returns a negative
- * number to signal an error.
- *
- * If the input was ok but there are not N branch switches in the
- * reflog, it returns 0.
- */
-#define INTERPRET_BRANCH_LOCAL (1<<0)
-#define INTERPRET_BRANCH_REMOTE (1<<1)
-#define INTERPRET_BRANCH_HEAD (1<<2)
-struct interpret_branch_name_options {
-	/*
-	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
-	 * expansions: local branches ("refs/heads/"), remote branches
-	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
-	 * allowed, even ones to refs outside of those namespaces.
-	 */
-	unsigned allowed;
-
-	/*
-	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
-	 * branch in question does not have such a reference, return -1 instead
-	 * of die()-ing.
-	 */
-	unsigned nonfatal_dangling_mark : 1;
-};
-int repo_interpret_branch_name(struct repository *r,
-			       const char *str, int len,
-			       struct strbuf *buf,
-			       const struct interpret_branch_name_options *options);
-
 int base_name_compare(const char *name1, size_t len1, int mode1,
 		      const char *name2, size_t len2, int mode2);
 int df_name_compare(const char *name1, size_t len1, int mode1,
@@ -907,10 +823,6 @@ void *read_object_with_reference(struct repository *r,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
 
-struct object *repo_peel_to_type(struct repository *r,
-				 const char *name, int namelen,
-				 struct object *o, enum object_type);
-
 const char *git_editor(void);
 const char *git_sequence_editor(void);
 const char *git_pager(int stdout_is_tty);
diff --git a/checkout.c b/checkout.c
index 1247b882248..9235073fc0d 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-name.h"
 #include "remote.h"
 #include "refspec.h"
 #include "checkout.h"
diff --git a/combine-diff.c b/combine-diff.c
index 6586e4508d6..cd5f39f22f4 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -7,6 +7,7 @@
 #include "diffcore.h"
 #include "environment.h"
 #include "hex.h"
+#include "object-name.h"
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "xdiff/xmacros.h"
diff --git a/commit.c b/commit.c
index 6d844da9a6b..bad31c423a4 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "repository.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "pkt-line.h"
 #include "utf8.h"
diff --git a/config.c b/config.c
index 9e74b5aec7f..aac439530e9 100644
--- a/config.c
+++ b/config.c
@@ -23,6 +23,7 @@
 #include "quote.h"
 #include "hashmap.h"
 #include "string-list.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "utf8.h"
 #include "dir.h"
diff --git a/diff-lib.c b/diff-lib.c
index 8b5cca96ace..d292405a262 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -8,6 +8,7 @@
 #include "diffcore.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "revision.h"
 #include "cache-tree.h"
 #include "unpack-trees.h"
diff --git a/diff.c b/diff.c
index 89cd0b17da5..9e6ad94bc66 100644
--- a/diff.c
+++ b/diff.c
@@ -35,6 +35,7 @@
 #include "help.h"
 #include "promisor-remote.h"
 #include "dir.h"
+#include "object-name.h"
 #include "setup.h"
 #include "strmap.h"
 #include "wrapper.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 1886c92ddb9..21019c932b3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "environment.h"
 #include "refs.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "diff.h"
 #include "diff-merges.h"
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 298ca08711e..8b2a45e507d 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -15,6 +15,7 @@
 #include "list-objects-filter-options.h"
 #include "oidmap.h"
 #include "oidset.h"
+#include "object-name.h"
 #include "object-store.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/log-tree.c b/log-tree.c
index 627c711f707..f0e885635e0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -4,6 +4,7 @@
 #include "diff.h"
 #include "environment.h"
 #include "hex.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
 #include "tmp-objdir.h"
diff --git a/mailmap.c b/mailmap.c
index 14f2c0f62ae..d62d7bf0e7f 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -2,6 +2,7 @@
 #include "environment.h"
 #include "string-list.h"
 #include "mailmap.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "setup.h"
 
diff --git a/merge-ort.c b/merge-ort.c
index 1008684fbbc..2c6a9ed9a41 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -32,6 +32,7 @@
 #include "entry.h"
 #include "ll-merge.h"
 #include "mem-pool.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "promisor-remote.h"
diff --git a/notes-merge.c b/notes-merge.c
index 0258f87d21f..b496b77d9db 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -3,6 +3,7 @@
 #include "commit.h"
 #include "gettext.h"
 #include "refs.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "repository.h"
 #include "diff.h"
diff --git a/notes.c b/notes.c
index 45fb7f22d1d..c07bcbe3486 100644
--- a/notes.c
+++ b/notes.c
@@ -3,6 +3,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "notes.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "blob.h"
 #include "tree.h"
diff --git a/object-name.c b/object-name.c
index ff647d6c7b5..3cd5b327293 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "object-name.h"
 #include "advice.h"
 #include "config.h"
 #include "environment.h"
diff --git a/object-name.h b/object-name.h
new file mode 100644
index 00000000000..65cb9a77b01
--- /dev/null
+++ b/object-name.h
@@ -0,0 +1,99 @@
+#ifndef OBJECT_NAME_H
+#define OBJECT_NAME_H
+
+#include "object.h"
+
+struct object_context;
+struct object_id;
+struct repository;
+struct strbuf;
+
+/*
+ * Return an abbreviated sha1 unique within this repository's object database.
+ * The result will be at least `len` characters long, and will be NUL
+ * terminated.
+ *
+ * The non-`_r` version returns a static buffer which remains valid until 4
+ * more calls to repo_find_unique_abbrev are made.
+ *
+ * The `_r` variant writes to a buffer supplied by the caller, which must be at
+ * least `GIT_MAX_HEXSZ + 1` bytes. The return value is the number of bytes
+ * written (excluding the NUL terminator).
+ *
+ * Note that while this version avoids the static buffer, it is not fully
+ * reentrant, as it calls into other non-reentrant git code.
+ */
+const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
+int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
+
+int repo_get_oid(struct repository *r, const char *str, struct object_id *oid);
+__attribute__((format (printf, 2, 3)))
+int get_oidf(struct object_id *oid, const char *fmt, ...);
+int repo_get_oid_commit(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_committish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_tree(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_treeish(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_blob(struct repository *r, const char *str, struct object_id *oid);
+int repo_get_oid_mb(struct repository *r, const char *str, struct object_id *oid);
+void maybe_die_on_misspelt_object_name(struct repository *repo,
+				       const char *name,
+				       const char *prefix);
+enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
+					 unsigned flags, struct object_id *oid,
+					 struct object_context *oc);
+
+
+typedef int each_abbrev_fn(const struct object_id *oid, void *);
+int repo_for_each_abbrev(struct repository *r, const char *prefix, each_abbrev_fn, void *);
+
+int set_disambiguate_hint_config(const char *var, const char *value);
+
+/*
+ * This reads short-hand syntax that not only evaluates to a commit
+ * object name, but also can act as if the end user spelled the name
+ * of the branch from the command line.
+ *
+ * - "@{-N}" finds the name of the Nth previous branch we were on, and
+ *   places the name of the branch in the given buf and returns the
+ *   number of characters parsed if successful.
+ *
+ * - "<branch>@{upstream}" finds the name of the other ref that
+ *   <branch> is configured to merge with (missing <branch> defaults
+ *   to the current branch), and places the name of the branch in the
+ *   given buf and returns the number of characters parsed if
+ *   successful.
+ *
+ * If the input is not of the accepted format, it returns a negative
+ * number to signal an error.
+ *
+ * If the input was ok but there are not N branch switches in the
+ * reflog, it returns 0.
+ */
+#define INTERPRET_BRANCH_LOCAL (1<<0)
+#define INTERPRET_BRANCH_REMOTE (1<<1)
+#define INTERPRET_BRANCH_HEAD (1<<2)
+struct interpret_branch_name_options {
+	/*
+	 * If "allowed" is non-zero, it is a treated as a bitfield of allowable
+	 * expansions: local branches ("refs/heads/"), remote branches
+	 * ("refs/remotes/"), or "HEAD". If no "allowed" bits are set, any expansion is
+	 * allowed, even ones to refs outside of those namespaces.
+	 */
+	unsigned allowed;
+
+	/*
+	 * If ^{upstream} or ^{push} (or equivalent) is requested, and the
+	 * branch in question does not have such a reference, return -1 instead
+	 * of die()-ing.
+	 */
+	unsigned nonfatal_dangling_mark : 1;
+};
+int repo_interpret_branch_name(struct repository *r,
+			       const char *str, int len,
+			       struct strbuf *buf,
+			       const struct interpret_branch_name_options *options);
+
+struct object *repo_peel_to_type(struct repository *r,
+				 const char *name, int namelen,
+				 struct object *o, enum object_type);
+#endif /* OBJECT_NAME_H */
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 666c2129797..b4df4bcebed 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -6,6 +6,7 @@
 #include "color.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "oid-array.h"
diff --git a/range-diff.c b/range-diff.c
index d1ed3b8ee56..a2994331a14 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -2,6 +2,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "range-diff.h"
+#include "object-name.h"
 #include "string-list.h"
 #include "run-command.h"
 #include "strvec.h"
diff --git a/read-cache.c b/read-cache.c
index 4ada6d62b90..cbbfc030da7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -22,6 +22,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "mem-pool.h"
+#include "object-name.h"
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "strbuf.h"
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 79ed61b9fa4..48467a7bc4a 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -8,6 +8,7 @@
 #include "commit-slab.h"
 #include "config.h"
 #include "dir.h"
+#include "object-name.h"
 #include "wrapper.h"
 
 static const char edit_todo_list_advice[] =
diff --git a/ref-filter.c b/ref-filter.c
index 1c6174c8aed..57a5884aec7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -6,6 +6,7 @@
 #include "parse-options.h"
 #include "refs.h"
 #include "wildmatch.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "oid-array.h"
 #include "repository.h"
diff --git a/refs.c b/refs.c
index cfced6f174a..979ed3fbedc 100644
--- a/refs.c
+++ b/refs.c
@@ -16,6 +16,7 @@
 #include "refs/refs-internal.h"
 #include "run-command.h"
 #include "hook.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "object.h"
 #include "tag.h"
diff --git a/remote.c b/remote.c
index 6599d52de20..3afedce593e 100644
--- a/remote.c
+++ b/remote.c
@@ -9,6 +9,7 @@
 #include "urlmatch.h"
 #include "refs.h"
 #include "refspec.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/reset.c b/reset.c
index ab300923e04..48da0adf851 100644
--- a/reset.c
+++ b/reset.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "object-name.h"
 #include "refs.h"
 #include "reset.h"
 #include "run-command.h"
diff --git a/revision.c b/revision.c
index 7c34c93885e..7438b50e267 100644
--- a/revision.c
+++ b/revision.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/sequencer.c b/sequencer.c
index eaba379e3ad..22b287be984 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -8,6 +8,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "dir.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "object.h"
 #include "commit.h"
diff --git a/setup.c b/setup.c
index 3bb7a9fff62..8a297b3cb5c 100644
--- a/setup.c
+++ b/setup.c
@@ -2,6 +2,7 @@
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
+#include "object-name.h"
 #include "repository.h"
 #include "config.h"
 #include "dir.h"
diff --git a/strbuf.c b/strbuf.c
index 70a83e7980e..1b93d9d3c47 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "refs.h"
 #include "string-list.h"
 #include "utf8.h"
diff --git a/submodule-config.c b/submodule-config.c
index ecf0fcf0074..252b90aa439 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -9,6 +9,7 @@
 #include "submodule-config.h"
 #include "submodule.h"
 #include "strbuf.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "parse-options.h"
 #include "tree-walk.h"
diff --git a/submodule.c b/submodule.c
index 58c9d5e5673..4f403b9eeff 100644
--- a/submodule.c
+++ b/submodule.c
@@ -24,6 +24,7 @@
 #include "remote.h"
 #include "worktree.h"
 #include "parse-options.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "commit-reach.h"
 #include "setup.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index fd48e0ee2c8..d1d63feaa9e 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -20,6 +20,7 @@
 #include "hex.h"
 #include "lockfile.h"
 #include "merge-ort.h"
+#include "object-name.h"
 #include "refs.h"
 #include "revision.h"
 #include "sequencer.h"
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 7066f3c71d2..3808e1ac38b 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "object-name.h"
 #include "setup.h"
 #include "tree.h"
 
diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index e2eb25ecdea..bf4fcfe6efb 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "object-name.h"
 #include "oidmap.h"
 #include "setup.h"
 #include "strbuf.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index b0deaa106a2..d4fa33ae751 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -6,6 +6,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "parse-options.h"
 #include "ref-filter.h"
 #include "setup.h"
diff --git a/t/helper/test-submodule-config.c b/t/helper/test-submodule-config.c
index 66063b58ded..4758c8654e0 100644
--- a/t/helper/test-submodule-config.c
+++ b/t/helper/test-submodule-config.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "config.h"
+#include "object-name.h"
 #include "setup.h"
 #include "submodule-config.h"
 #include "submodule.h"
diff --git a/tag.c b/tag.c
index 01ed67d6fa6..b9fc2fc9929 100644
--- a/tag.c
+++ b/tag.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "environment.h"
 #include "tag.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "commit.h"
 #include "tree.h"
diff --git a/transport-helper.c b/transport-helper.c
index 76d146ee88b..ca8bec04bb3 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -7,6 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "revision.h"
 #include "remote.h"
 #include "string-list.h"
diff --git a/transport.c b/transport.c
index 82bf2496ba7..7374cfd1fa9 100644
--- a/transport.c
+++ b/transport.c
@@ -26,6 +26,7 @@
 #include "trace2.h"
 #include "transport-internal.h"
 #include "protocol.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "color.h"
 #include "bundle-uri.h"
diff --git a/tree.c b/tree.c
index 2b78708766b..e9d51ce2e00 100644
--- a/tree.c
+++ b/tree.c
@@ -2,6 +2,7 @@
 #include "cache-tree.h"
 #include "hex.h"
 #include "tree.h"
+#include "object-name.h"
 #include "object-store.h"
 #include "blob.h"
 #include "commit.h"
diff --git a/wt-status.c b/wt-status.c
index 47f223c0f8d..97b9c1c0359 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -8,6 +8,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "revision.h"
 #include "diffcore.h"
 #include "quote.h"
-- 
gitgitgadget

