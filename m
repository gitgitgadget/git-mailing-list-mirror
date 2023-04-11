Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F352C77B61
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 03:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDKDBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 23:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjDKDBN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 23:01:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05831270E
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:10 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m8so17402911wmq.5
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 20:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dKH73lW+OoWbf1fWfeM9dZATaSANZZen/WSXwlmM7PY=;
        b=I/bXKIJcaWycoZU3y1Acg0EEdhUeqQ59GdVVci1YvFFBdn0UBZWX/q4l6ARPyQAHtZ
         lEhwHaF6s80Gw5iHNWyu2Tdf9GQpZgrfO086LvePVhjp0svr8/wjSBYtONXx6nxa+to8
         Mo3hsqQki4QzGkPL4p75r/9zFV+vAtruQw2ETcrtAuYA8EWN3w41QFDYgmqqXrYFPV2a
         OW/P9VrczwbOAdvqxKsnUWYH11FB12JbqJVSc0EqR7reC4rKdzBQFCgnN6gmODXXRzSl
         KAePyIg3KGrnvty4DDICTJxn0CxO94PXDxJlabCAD67lpMow6X7x82dn4hi+ehXWJY35
         k+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182068;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dKH73lW+OoWbf1fWfeM9dZATaSANZZen/WSXwlmM7PY=;
        b=uYaNzeOM0lYIF78OBZSwKjJXSwN0GI6vFIK3pQvmQKIzikz5OTJrVbr+lDMHQhS0cO
         yqoeKEcBSu6Bnd4+btbXTBP1ByH9Wd9DbqBPyZWJCqreS6p9YrPRqUNRdUlFmT2y0x0L
         9f/sGl87ce8WNiHj4SClpNAaE4ZwLkAVL6AsffI0Z1baH2z6xRq+GoFYRqnuM+0tFWNg
         voolZfjcDzLitw5DR6IQbMV+YDiDbBgO8TR9wqppd1m/13rQyndkN75hDQzKNSZK9znT
         i769ao2/M1/zGaPP9wPUAw8lxUsppgTlGEiQ8uIHU++x7HvR5EqONh4kjPnImtRT/wOm
         UEPg==
X-Gm-Message-State: AAQBX9cza+txNmcF2w0VoekVJxanuhUJbbyYRuq+cu+RdlcWiIArhTdm
        lAF5uLBzrA4Iy2d9tJuUtkykAlZbFJs=
X-Google-Smtp-Source: AKy350ZVOb4AGZhtr+sHxXuc3jQ32AJ8U3p/fp7lti231aKxm2t5+uXgtDY3u/eQLbmqsHNM4yU8yg==
X-Received: by 2002:a05:600c:364d:b0:3ef:acf6:f815 with SMTP id y13-20020a05600c364d00b003efacf6f815mr8649063wmq.32.1681182067984;
        Mon, 10 Apr 2023 20:01:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c4f5300b003f07eca7af2sm11458873wmq.40.2023.04.10.20.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 20:01:07 -0700 (PDT)
Message-Id: <eb90e25c53ef3db70e6d74061d1f33439a0ecf05.1681182062.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
References: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
        <pull.1509.v3.git.1681182060.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Apr 2023 03:00:38 +0000
Subject: [PATCH v3 01/23] treewide: be explicit about dependence on trace.h &
 trace2.h
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

Dozens of files made use of trace and trace2 functions, without
explicitly including trace.h or trace2.h.  This made it more difficult
to find which files could remove a dependence on cache.h.  Make C files
explicitly include trace.h or trace2.h if they are using them.

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Calvin Wan <calvinwan@google.com>
---
 blame.c                                  | 1 +
 builtin/checkout.c                       | 1 +
 builtin/commit-graph.c                   | 1 +
 builtin/fetch.c                          | 2 ++
 builtin/fsmonitor--daemon.c              | 1 +
 builtin/gc.c                             | 1 +
 builtin/push.c                           | 1 +
 builtin/rebase.c                         | 1 +
 builtin/receive-pack.c                   | 2 ++
 builtin/reset.c                          | 2 ++
 cache-tree.c                             | 2 ++
 cache.h                                  | 2 --
 chdir-notify.c                           | 1 +
 common-main.c                            | 1 +
 compat/fsmonitor/fsm-listen-win32.c      | 1 +
 compat/mingw.c                           | 1 +
 compat/simple-ipc/ipc-unix-socket.c      | 1 +
 compat/simple-ipc/ipc-win32.c            | 2 ++
 compat/win32/trace2_win32_process_info.c | 1 +
 config.c                                 | 1 +
 connect.c                                | 1 +
 convert.c                                | 1 +
 diff-lib.c                               | 1 +
 dir.c                                    | 1 +
 environment.c                            | 1 +
 exec-cmd.c                               | 2 ++
 fetch-pack.c                             | 1 +
 fsmonitor.c                              | 1 +
 fsmonitor.h                              | 1 +
 git.c                                    | 2 ++
 http.c                                   | 1 +
 merge-ort.c                              | 1 +
 name-hash.c                              | 1 +
 notes-merge.c                            | 1 +
 pack-bitmap.c                            | 1 +
 pack-revindex.c                          | 1 +
 packfile.c                               | 1 +
 pkt-line.c                               | 1 +
 preload-index.c                          | 1 +
 progress.c                               | 1 +
 promisor-remote.c                        | 1 +
 protocol.c                               | 1 +
 read-cache.c                             | 1 +
 remote-curl.c                            | 1 +
 repository.c                             | 1 +
 revision.c                               | 1 +
 run-command.c                            | 2 ++
 scalar.c                                 | 1 +
 setup.c                                  | 1 +
 shallow.c                                | 1 +
 submodule.c                              | 1 +
 t/helper/test-date.c                     | 1 +
 t/helper/test-lazy-init-name-hash.c      | 1 +
 t/helper/test-path-utils.c               | 1 +
 trace.c                                  | 1 +
 trace2.c                                 | 1 +
 transport.c                              | 1 +
 tree-walk.c                              | 1 +
 unpack-trees.c                           | 1 +
 upload-pack.c                            | 1 +
 wrapper.c                                | 1 +
 wt-status.c                              | 2 ++
 62 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/blame.c b/blame.c
index 62db9807640..3455f6a5ea3 100644
--- a/blame.c
+++ b/blame.c
@@ -9,6 +9,7 @@
 #include "hex.h"
 #include "setup.h"
 #include "tag.h"
+#include "trace2.h"
 #include "blame.h"
 #include "alloc.h"
 #include "commit-slab.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 38a8cd6a965..422ea768404 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -26,6 +26,7 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 90114269761..a3d00fa232b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -12,6 +12,7 @@
 #include "progress.h"
 #include "replace-object.h"
 #include "tag.h"
+#include "trace2.h"
 
 #define BUILTIN_COMMIT_GRAPH_VERIFY_USAGE \
 	N_("git commit-graph verify [--object-dir <dir>] [--shallow] [--[no-]progress]")
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 6a6a58d49c9..ffe0e214592 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -31,6 +31,8 @@
 #include "promisor-remote.h"
 #include "commit-graph.h"
 #include "shallow.h"
+#include "trace.h"
+#include "trace2.h"
 #include "worktree.h"
 #include "bundle-uri.h"
 
diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index a280d8bb14f..df876b41d65 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -14,6 +14,7 @@
 #include "simple-ipc.h"
 #include "khash.h"
 #include "pkt-line.h"
+#include "trace2.h"
 
 static const char * const builtin_fsmonitor__daemon_usage[] = {
 	N_("git fsmonitor--daemon start [<options>]"),
diff --git a/builtin/gc.c b/builtin/gc.c
index b291e23b13d..000a2ef5e11 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -37,6 +37,7 @@
 #include "gettext.h"
 #include "hook.h"
 #include "setup.h"
+#include "trace2.h"
 #include "wrapper.h"
 
 #define FAILED_RUN "failed to run %s"
diff --git a/builtin/push.c b/builtin/push.c
index fa550b8f80a..a99ba38a368 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -16,6 +16,7 @@
 #include "submodule.h"
 #include "submodule-config.h"
 #include "send-pack.h"
+#include "trace2.h"
 #include "color.h"
 
 static const char * const push_usage[] = {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index dbc8f90ef04..fb859f93a30 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -32,6 +32,7 @@
 #include "sequencer.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "trace2.h"
 #include "hook.h"
 #include "wrapper.h"
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 2ba5a74ba7b..aa5b6fe861f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -32,6 +32,8 @@
 #include "object-store.h"
 #include "protocol.h"
 #include "commit-reach.h"
+#include "trace.h"
+#include "trace2.h"
 #include "worktree.h"
 #include "shallow.h"
 #include "wrapper.h"
diff --git a/builtin/reset.c b/builtin/reset.c
index 0ed329236c8..4d639ec6b37 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -29,6 +29,8 @@
 #include "setup.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "trace.h"
+#include "trace2.h"
 #include "dir.h"
 #include "add-interactive.h"
 
diff --git a/cache-tree.c b/cache-tree.c
index ff14b527da3..39f0c744727 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -11,6 +11,8 @@
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "sparse-index.h"
+#include "trace.h"
+#include "trace2.h"
 
 #ifndef DEBUG_CACHE_TREE
 #define DEBUG_CACHE_TREE 0
diff --git a/cache.h b/cache.h
index 82d7b112b4e..c8ae80fded3 100644
--- a/cache.h
+++ b/cache.h
@@ -8,8 +8,6 @@
 #include "advice.h"
 #include "gettext.h"
 #include "convert.h"
-#include "trace.h"
-#include "trace2.h"
 #include "string-list.h"
 #include "pack-revindex.h"
 #include "hash.h"
diff --git a/chdir-notify.c b/chdir-notify.c
index 929ec01b3a2..8e38cd6f3ae 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -3,6 +3,7 @@
 #include "chdir-notify.h"
 #include "list.h"
 #include "strbuf.h"
+#include "trace.h"
 
 struct chdir_notify_entry {
 	const char *name;
diff --git a/common-main.c b/common-main.c
index b83cb5cf066..f3193173535 100644
--- a/common-main.c
+++ b/common-main.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "attr.h"
 #include "setup.h"
+#include "trace2.h"
 
 /*
  * Many parts of Git have subprograms communicate via pipe, expect the
diff --git a/compat/fsmonitor/fsm-listen-win32.c b/compat/fsmonitor/fsm-listen-win32.c
index 7b07b74ba5b..677b1bbdeca 100644
--- a/compat/fsmonitor/fsm-listen-win32.c
+++ b/compat/fsmonitor/fsm-listen-win32.c
@@ -4,6 +4,7 @@
 #include "fsm-listen.h"
 #include "fsmonitor--daemon.h"
 #include "gettext.h"
+#include "trace2.h"
 
 /*
  * The documentation of ReadDirectoryChangesW() states that the maximum
diff --git a/compat/mingw.c b/compat/mingw.c
index 94c5a1daa40..abbc3faf32f 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -12,6 +12,7 @@
 #include "win32/lazyload.h"
 #include "../config.h"
 #include "../environment.h"
+#include "../trace2.h"
 #include "../wrapper.h"
 #include "dir.h"
 #include "gettext.h"
diff --git a/compat/simple-ipc/ipc-unix-socket.c b/compat/simple-ipc/ipc-unix-socket.c
index 152db60a311..7064475b39f 100644
--- a/compat/simple-ipc/ipc-unix-socket.c
+++ b/compat/simple-ipc/ipc-unix-socket.c
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "pkt-line.h"
 #include "thread-utils.h"
+#include "trace2.h"
 #include "unix-socket.h"
 #include "unix-stream-server.h"
 
diff --git a/compat/simple-ipc/ipc-win32.c b/compat/simple-ipc/ipc-win32.c
index 997f6144344..6adce3c650e 100644
--- a/compat/simple-ipc/ipc-win32.c
+++ b/compat/simple-ipc/ipc-win32.c
@@ -5,6 +5,8 @@
 #include "strbuf.h"
 #include "pkt-line.h"
 #include "thread-utils.h"
+#include "trace.h"
+#include "trace2.h"
 #include "accctrl.h"
 #include "aclapi.h"
 
diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index a53fd924340..e3e895c78a2 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -1,5 +1,6 @@
 #include "../../cache.h"
 #include "../../json-writer.h"
+#include "../../trace2.h"
 #include "lazyload.h"
 #include <Psapi.h>
 #include <tlHelp32.h>
diff --git a/config.c b/config.c
index 5ad9ae91436..e5c2e477319 100644
--- a/config.c
+++ b/config.c
@@ -28,6 +28,7 @@
 #include "replace-object.h"
 #include "refs.h"
 #include "setup.h"
+#include "trace2.h"
 #include "worktree.h"
 #include "wrapper.h"
 #include "write-or-die.h"
diff --git a/connect.c b/connect.c
index 737dd906f72..929f72ec5d7 100644
--- a/connect.c
+++ b/connect.c
@@ -14,6 +14,7 @@
 #include "string-list.h"
 #include "oid-array.h"
 #include "transport.h"
+#include "trace2.h"
 #include "strbuf.h"
 #include "version.h"
 #include "protocol.h"
diff --git a/convert.c b/convert.c
index da06e2f51cb..126036ec330 100644
--- a/convert.c
+++ b/convert.c
@@ -9,6 +9,7 @@
 #include "sigchain.h"
 #include "pkt-line.h"
 #include "sub-process.h"
+#include "trace.h"
 #include "utf8.h"
 #include "ll-merge.h"
 #include "wrapper.h"
diff --git a/diff-lib.c b/diff-lib.c
index 4169dd8cb13..8b5cca96ace 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -13,6 +13,7 @@
 #include "unpack-trees.h"
 #include "refs.h"
 #include "submodule.h"
+#include "trace.h"
 #include "dir.h"
 #include "fsmonitor.h"
 #include "commit-reach.h"
diff --git a/dir.c b/dir.c
index 18fd14c46b2..10f6c38b930 100644
--- a/dir.c
+++ b/dir.c
@@ -23,6 +23,7 @@
 #include "fsmonitor.h"
 #include "setup.h"
 #include "submodule-config.h"
+#include "trace2.h"
 #include "wrapper.h"
 
 /*
diff --git a/environment.c b/environment.c
index 63c697e7e97..2254595e4a8 100644
--- a/environment.c
+++ b/environment.c
@@ -24,6 +24,7 @@
 #include "chdir-notify.h"
 #include "setup.h"
 #include "shallow.h"
+#include "trace.h"
 #include "wrapper.h"
 #include "write-or-die.h"
 
diff --git a/exec-cmd.c b/exec-cmd.c
index fae0d4b244a..6f618463896 100644
--- a/exec-cmd.c
+++ b/exec-cmd.c
@@ -5,6 +5,8 @@
 #include "gettext.h"
 #include "quote.h"
 #include "strvec.h"
+#include "trace.h"
+#include "trace2.h"
 
 #if defined(RUNTIME_PREFIX)
 
diff --git a/fetch-pack.c b/fetch-pack.c
index 368f2ed25a1..7d4f190fb1d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -17,6 +17,7 @@
 #include "remote.h"
 #include "run-command.h"
 #include "connect.h"
+#include "trace2.h"
 #include "transport.h"
 #include "version.h"
 #include "oid-array.h"
diff --git a/fsmonitor.c b/fsmonitor.c
index c956a347a27..28c083d4d84 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -7,6 +7,7 @@
 #include "fsmonitor-ipc.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "trace2.h"
 
 #define INDEX_EXTENSION_VERSION1	(1)
 #define INDEX_EXTENSION_VERSION2	(2)
diff --git a/fsmonitor.h b/fsmonitor.h
index edf7ce5203b..67faf592e12 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -4,6 +4,7 @@
 #include "cache.h"
 #include "dir.h"
 #include "fsmonitor-settings.h"
+#include "trace.h"
 
 extern struct trace_key trace_fsmonitor;
 
diff --git a/git.c b/git.c
index 77f920a6f6f..d2bb86e0d32 100644
--- a/git.c
+++ b/git.c
@@ -9,6 +9,8 @@
 #include "replace-object.h"
 #include "setup.h"
 #include "shallow.h"
+#include "trace.h"
+#include "trace2.h"
 
 #define RUN_SETUP		(1<<0)
 #define RUN_SETUP_GENTLY	(1<<1)
diff --git a/http.c b/http.c
index dbe4d29ef7a..0212c0ad3b2 100644
--- a/http.c
+++ b/http.c
@@ -12,6 +12,7 @@
 #include "version.h"
 #include "pkt-line.h"
 #include "gettext.h"
+#include "trace.h"
 #include "transport.h"
 #include "packfile.h"
 #include "protocol.h"
diff --git a/merge-ort.c b/merge-ort.c
index 5bf64354d16..ad7367179d9 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -37,6 +37,7 @@
 #include "strmap.h"
 #include "submodule-config.h"
 #include "submodule.h"
+#include "trace2.h"
 #include "tree.h"
 #include "unpack-trees.h"
 #include "xdiff-interface.h"
diff --git a/name-hash.c b/name-hash.c
index 2c2861efd1c..fb13716e430 100644
--- a/name-hash.c
+++ b/name-hash.c
@@ -9,6 +9,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "thread-utils.h"
+#include "trace.h"
 #include "trace2.h"
 #include "sparse-index.h"
 
diff --git a/notes-merge.c b/notes-merge.c
index c40107c3aa0..19405ec71ac 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -13,6 +13,7 @@
 #include "notes.h"
 #include "notes-merge.h"
 #include "strbuf.h"
+#include "trace.h"
 #include "notes-utils.h"
 #include "commit-reach.h"
 #include "wrapper.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 23d87e71bd9..eba838d24ee 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -15,6 +15,7 @@
 #include "pack-objects.h"
 #include "packfile.h"
 #include "repository.h"
+#include "trace2.h"
 #include "object-store.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 03c7e81f9da..9f9927d9471 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -3,6 +3,7 @@
 #include "pack-revindex.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "trace2.h"
 #include "config.h"
 #include "midx.h"
 
diff --git a/packfile.c b/packfile.c
index b120405ccc8..2d3dabb1aee 100644
--- a/packfile.c
+++ b/packfile.c
@@ -15,6 +15,7 @@
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
+#include "trace.h"
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-store.h"
diff --git a/pkt-line.c b/pkt-line.c
index 36ae0fea4a3..3561d853584 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,6 +3,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
+#include "trace.h"
 #include "wrapper.h"
 #include "write-or-die.h"
 
diff --git a/preload-index.c b/preload-index.c
index 52544d004e7..4abf9c983b2 100644
--- a/preload-index.c
+++ b/preload-index.c
@@ -11,6 +11,7 @@
 #include "progress.h"
 #include "thread-utils.h"
 #include "repository.h"
+#include "trace2.h"
 
 /*
  * Mostly randomly chosen maximum thread counts: we
diff --git a/progress.c b/progress.c
index 44c784d75f1..c5c8514737a 100644
--- a/progress.c
+++ b/progress.c
@@ -13,6 +13,7 @@
 #include "progress.h"
 #include "strbuf.h"
 #include "trace.h"
+#include "trace2.h"
 #include "utf8.h"
 #include "config.h"
 
diff --git a/promisor-remote.c b/promisor-remote.c
index a8dbb788e8f..9d83d2f4b9c 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -4,6 +4,7 @@
 #include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
+#include "trace2.h"
 #include "transport.h"
 #include "strvec.h"
 #include "packfile.h"
diff --git a/protocol.c b/protocol.c
index bdb32e1eeb6..4d8eb887e82 100644
--- a/protocol.c
+++ b/protocol.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "environment.h"
 #include "protocol.h"
+#include "trace2.h"
 
 static enum protocol_version parse_protocol_version(const char *value)
 {
diff --git a/read-cache.c b/read-cache.c
index e5e72169047..a744eb89e4e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -23,6 +23,7 @@
 #include "resolve-undo.h"
 #include "run-command.h"
 #include "strbuf.h"
+#include "trace2.h"
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
diff --git a/remote-curl.c b/remote-curl.c
index 0f2410da8e7..0ada1dd8026 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -21,6 +21,7 @@
 #include "setup.h"
 #include "protocol.h"
 #include "quote.h"
+#include "trace2.h"
 #include "transport.h"
 #include "write-or-die.h"
 
diff --git a/repository.c b/repository.c
index f6d9f5db08e..c53e480e326 100644
--- a/repository.c
+++ b/repository.c
@@ -14,6 +14,7 @@
 #include "setup.h"
 #include "submodule-config.h"
 #include "sparse-index.h"
+#include "trace2.h"
 #include "promisor-remote.h"
 
 /* The main repository */
diff --git a/revision.c b/revision.c
index cd3e841433a..7c34c93885e 100644
--- a/revision.c
+++ b/revision.c
@@ -31,6 +31,7 @@
 #include "worktree.h"
 #include "setup.h"
 #include "strvec.h"
+#include "trace2.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "prio-queue.h"
diff --git a/run-command.c b/run-command.c
index 614d48fa9a2..e64bb08a5bf 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,6 +8,8 @@
 #include "thread-utils.h"
 #include "strbuf.h"
 #include "string-list.h"
+#include "trace.h"
+#include "trace2.h"
 #include "quote.h"
 #include "config.h"
 #include "packfile.h"
diff --git a/scalar.c b/scalar.c
index 27635658c01..f7680463e1b 100644
--- a/scalar.c
+++ b/scalar.c
@@ -16,6 +16,7 @@
 #include "packfile.h"
 #include "help.h"
 #include "setup.h"
+#include "trace2.h"
 
 static void setup_enlistment_directory(int argc, const char **argv,
 				       const char * const *usagestr,
diff --git a/setup.c b/setup.c
index 6c5b85e96c1..3bb7a9fff62 100644
--- a/setup.c
+++ b/setup.c
@@ -10,6 +10,7 @@
 #include "chdir-notify.h"
 #include "promisor-remote.h"
 #include "quote.h"
+#include "trace2.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/shallow.c b/shallow.c
index b4d726bd595..128f56179ed 100644
--- a/shallow.c
+++ b/shallow.c
@@ -17,6 +17,7 @@
 #include "list-objects.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "trace.h"
 #include "wrapper.h"
 
 void set_alternate_shallow_file(struct repository *r, const char *path, int override)
diff --git a/submodule.c b/submodule.c
index d7d0a8a0834..58c9d5e5673 100644
--- a/submodule.c
+++ b/submodule.c
@@ -28,6 +28,7 @@
 #include "commit-reach.h"
 #include "setup.h"
 #include "shallow.h"
+#include "trace2.h"
 
 static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
 static int initialized_fetch_ref_tips;
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 45951b1df87..a01eec99f35 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "date.h"
+#include "trace.h"
 
 static const char *usage_msg = "\n"
 "  test-tool date relative [time_t]...\n"
diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
index 06ce3a47ccf..f23d983c118 100644
--- a/t/helper/test-lazy-init-name-hash.c
+++ b/t/helper/test-lazy-init-name-hash.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "setup.h"
+#include "trace.h"
 
 static int single;
 static int multi;
diff --git a/t/helper/test-path-utils.c b/t/helper/test-path-utils.c
index 4f5ac2fadce..6355c9e4b6d 100644
--- a/t/helper/test-path-utils.c
+++ b/t/helper/test-path-utils.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "setup.h"
 #include "string-list.h"
+#include "trace.h"
 #include "utf8.h"
 
 /*
diff --git a/trace.c b/trace.c
index 81318a2455d..d8eaa0a786a 100644
--- a/trace.c
+++ b/trace.c
@@ -26,6 +26,7 @@
 #include "environment.h"
 #include "quote.h"
 #include "setup.h"
+#include "trace.h"
 #include "wrapper.h"
 
 struct trace_key trace_default_key = { "GIT_TRACE", 0, 0, 0 };
diff --git a/trace2.c b/trace2.c
index e8ba62c0c3d..21264df71b7 100644
--- a/trace2.c
+++ b/trace2.c
@@ -7,6 +7,7 @@
 #include "thread-utils.h"
 #include "version.h"
 #include "trace.h"
+#include "trace2.h"
 #include "trace2/tr2_cfg.h"
 #include "trace2/tr2_cmd_name.h"
 #include "trace2/tr2_ctr.h"
diff --git a/transport.c b/transport.c
index d2a1af43b5c..11b38d16dcf 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "string-list.h"
 #include "oid-array.h"
 #include "sigchain.h"
+#include "trace2.h"
 #include "transport-internal.h"
 #include "protocol.h"
 #include "object-store.h"
diff --git a/tree-walk.c b/tree-walk.c
index 38b6556478d..59add24c8e9 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -5,6 +5,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-store.h"
+#include "trace2.h"
 #include "tree.h"
 #include "pathspec.h"
 #include "json-writer.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 4a5522bdb26..d41489b4adb 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -17,6 +17,7 @@
 #include "sparse-index.h"
 #include "submodule.h"
 #include "submodule-config.h"
+#include "trace2.h"
 #include "fsmonitor.h"
 #include "object-store.h"
 #include "promisor-remote.h"
diff --git a/upload-pack.c b/upload-pack.c
index e23f16dfdd2..71440c63806 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -22,6 +22,7 @@
 #include "version.h"
 #include "string-list.h"
 #include "strvec.h"
+#include "trace2.h"
 #include "prio-queue.h"
 #include "protocol.h"
 #include "quote.h"
diff --git a/wrapper.c b/wrapper.c
index ee837575902..c130d7518bf 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "config.h"
 #include "gettext.h"
+#include "trace2.h"
 #include "wrapper.h"
 
 static intmax_t count_fsync_writeout_only;
diff --git a/wt-status.c b/wt-status.c
index 4bef09de1ca..ccbfd9cc6de 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -18,6 +18,8 @@
 #include "column.h"
 #include "setup.h"
 #include "strbuf.h"
+#include "trace.h"
+#include "trace2.h"
 #include "utf8.h"
 #include "worktree.h"
 #include "lockfile.h"
-- 
gitgitgadget

