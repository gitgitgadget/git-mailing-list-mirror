Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39FC6FD1D
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 06:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCUG0Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 02:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCUG0X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 02:26:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A677231E18
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e18so958945wra.9
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 23:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679379979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiWQ36N1DxkDHPV5AyHoBZ0z2j8zVcji30xULB36B3w=;
        b=k6B6MeLoop3EdMbSmSAbXa9R/l1H2Idi7xHC40pCkSTyfpx1z2lfjk57jJks2tjlP+
         X16LK3RbccEL2SdVG4OlsGIVe22T4s0Wu8YORMwGJzt18dnSb4fg63C5tpgueYjD8cU/
         +q1h0A8plC6nReg59ZS/SGFi/MoV8wvhqkESEre82/9CMguA62Zar/Xi0WjE8vveuPjT
         LWWMI7iRjp8ei0HItKjZRN7G8gj+Uv5BeJ7WdmrhYYxN7te5bGrpd7kMAJzICx7dI8qT
         aEMuiW1j6Le1P91+aRUBQOTEBbfm+wOnCfP0nh0BQY+7ICxjFj7d0FcNpikQgchzkKvh
         kXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679379979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiWQ36N1DxkDHPV5AyHoBZ0z2j8zVcji30xULB36B3w=;
        b=55zENRNBMrInOr9Q/Y3EDleroccFf6U4NPuIXFij73OWRNsSbsYAN+4o5U171sZqDU
         wxCVUc4T2n7zBzm9TfittymawvMiL/gWPeS8q6daIp2kyxQpiQYooOLiGu66TseqOED7
         BK2kEcPt1bF0ivCW0lIfVdvDCR8j0Hcntw8Wy8llfrI7rEyoIReA4yK6LWgz9hKHpCVw
         U1XU4UtlO+bRaEbjO4tq6bzrAH2okWZBfGKRaPGNRavHqrBc3CcDmC6PFDIEcOn/upPU
         rU2P1EFHsF+E8nI/F90o42RwJKVXsSLsh+F5tyhWY3PzvoSlC486wzncdk2Pz4q3zAN5
         FF8g==
X-Gm-Message-State: AO0yUKVO2A70Z7gDi7ll/gDk/w6Q75H+YZG6uU+9osW6aoJs7Ugzwo3P
        CtIgNS2V/QZd09q8zcgscwrrGATs+64=
X-Google-Smtp-Source: AK7set/cQTeiyAMaYfLg4/MujHFk9ryfaXliuO0CZM2eUdbQwV05A/soRHqGFzfTWsOjuhzO7qIxdg==
X-Received: by 2002:a5d:4fd1:0:b0:2c7:c9e:2c41 with SMTP id h17-20020a5d4fd1000000b002c70c9e2c41mr1186966wrw.57.1679379978855;
        Mon, 20 Mar 2023 23:26:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm10565093wrq.76.2023.03.20.23.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:26:18 -0700 (PDT)
Message-Id: <a1be63930c43c9c7980fa37815985898426111c6.1679379970.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
References: <pull.1493.git.1679207282.gitgitgadget@gmail.com>
        <pull.1493.v2.git.1679379968.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Mar 2023 06:25:53 +0000
Subject: [PATCH v2 01/16] treewide: remove unnecessary cache.h inclusion from
 a few headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Ever since a64215b6cd ("object.h: stop depending on cache.h; make
cache.h depend on object.h", 2023-02-24), we have a few headers that
could have replaced their include of cache.h with an include of
object.h.  Make that change now.

Some C files had to start including cache.h after this change (or some
smaller header it had brought in), because the C files were depending
on things from cache.h but were only formerly implicitly getting
cache.h through one of these headers being modified in this patch.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 bulk-checkin.h              | 2 +-
 bundle.h                    | 1 -
 cache-tree.c                | 2 +-
 config.c                    | 2 +-
 fmt-merge-msg.c             | 2 +-
 fsck.c                      | 2 +-
 http-backend.c              | 2 +-
 pack-mtimes.c               | 2 +-
 packfile.h                  | 4 +++-
 prune-packed.c              | 2 +-
 ref-filter.c                | 2 +-
 refs.c                      | 2 +-
 refs.h                      | 1 -
 refs/packed-backend.c       | 2 +-
 refspec.c                   | 1 +
 remote.c                    | 2 +-
 server-info.c               | 2 +-
 shallow.c                   | 2 +-
 strbuf.c                    | 2 +-
 streaming.h                 | 4 +++-
 submodule.c                 | 2 +-
 t/helper/test-bundle-uri.c  | 1 +
 t/helper/test-fast-rebase.c | 2 +-
 t/helper/test-pack-mtimes.c | 2 +-
 t/helper/test-reach.c       | 1 +
 transport.c                 | 2 +-
 transport.h                 | 1 -
 worktree.c                  | 2 +-
 28 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/bulk-checkin.h b/bulk-checkin.h
index 8281b9cb159..48fe9a6e917 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -4,7 +4,7 @@
 #ifndef BULK_CHECKIN_H
 #define BULK_CHECKIN_H
 
-#include "cache.h"
+#include "object.h"
 
 void prepare_loose_object_bulk_checkin(void);
 void fsync_loose_object_bulk_checkin(int fd, const char *filename);
diff --git a/bundle.h b/bundle.h
index 9f2bd733a6a..021adbdcbb3 100644
--- a/bundle.h
+++ b/bundle.h
@@ -2,7 +2,6 @@
 #define BUNDLE_H
 
 #include "strvec.h"
-#include "cache.h"
 #include "string-list.h"
 #include "list-objects-filter-options.h"
 
diff --git a/cache-tree.c b/cache-tree.c
index 9d46ecef091..6f899beb041 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "hex.h"
 #include "lockfile.h"
diff --git a/config.c b/config.c
index d0aff55fa66..983c45fc37b 100644
--- a/config.c
+++ b/config.c
@@ -5,7 +5,7 @@
  * Copyright (C) Johannes Schindelin, 2005
  *
  */
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "date.h"
 #include "branch.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 24cc44bdbc9..c870cb95b9d 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "refs.h"
diff --git a/fsck.c b/fsck.c
index 871c0a9a252..70e12497878 100644
--- a/fsck.c
+++ b/fsck.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "hex.h"
 #include "object-store.h"
diff --git a/http-backend.c b/http-backend.c
index 9cfc6f25414..7e7c19e66b3 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "hex.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 0f9785fc5e4..cd92fc1d86c 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "pack-mtimes.h"
 #include "object-store.h"
 #include "packfile.h"
diff --git a/packfile.h b/packfile.h
index a3f6723857b..648be62bf22 100644
--- a/packfile.h
+++ b/packfile.h
@@ -1,11 +1,13 @@
 #ifndef PACKFILE_H
 #define PACKFILE_H
 
-#include "cache.h"
+#include "object.h"
 #include "oidset.h"
 
 /* in object-store.h */
 struct packed_git;
+struct pack_entry;
+struct pack_window;
 struct object_info;
 
 /*
diff --git a/prune-packed.c b/prune-packed.c
index d2813f6a405..e02f466c2ee 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "progress.h"
diff --git a/ref-filter.c b/ref-filter.c
index ed802778da7..38141bce8db 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "hex.h"
 #include "parse-options.h"
diff --git a/refs.c b/refs.c
index 53240bcc07b..4e5cc73fb10 100644
--- a/refs.c
+++ b/refs.c
@@ -2,7 +2,7 @@
  * The backend-independent part of the reference module.
  */
 
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "hashmap.h"
diff --git a/refs.h b/refs.h
index 935cdd1ece3..5741b69d0d1 100644
--- a/refs.h
+++ b/refs.h
@@ -1,7 +1,6 @@
 #ifndef REFS_H
 #define REFS_H
 
-#include "cache.h"
 #include "commit.h"
 
 struct object_id;
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b665d0f7d9b..6f975185995 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1,4 +1,4 @@
-#include "../git-compat-util.h"
+#include "../cache.h"
 #include "../alloc.h"
 #include "../config.h"
 #include "../hex.h"
diff --git a/refspec.c b/refspec.c
index 28d90911aa5..7b5c305514d 100644
--- a/refspec.c
+++ b/refspec.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 #include "alloc.h"
+#include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
 #include "refs.h"
diff --git a/remote.c b/remote.c
index b04e5da3383..2daddb85cb7 100644
--- a/remote.c
+++ b/remote.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "hex.h"
diff --git a/server-info.c b/server-info.c
index 40436892023..78643377057 100644
--- a/server-info.c
+++ b/server-info.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "dir.h"
 #include "hex.h"
diff --git a/shallow.c b/shallow.c
index 1cbb05ba0e4..c5433a4fd30 100644
--- a/shallow.c
+++ b/shallow.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "hex.h"
 #include "repository.h"
diff --git a/strbuf.c b/strbuf.c
index 1c57ac6574f..8800830ebf8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "hex.h"
 #include "refs.h"
diff --git a/streaming.h b/streaming.h
index 5e4e6acfd0d..bd27f59e576 100644
--- a/streaming.h
+++ b/streaming.h
@@ -3,10 +3,12 @@
  */
 #ifndef STREAMING_H
 #define STREAMING_H 1
-#include "cache.h"
+
+#include "object.h"
 
 /* opaque */
 struct git_istream;
+struct stream_filter;
 
 struct git_istream *open_istream(struct repository *, const struct object_id *,
 				 enum object_type *, unsigned long *,
diff --git a/submodule.c b/submodule.c
index 2a057c35b74..0baf97cf770 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "repository.h"
 #include "config.h"
diff --git a/t/helper/test-bundle-uri.c b/t/helper/test-bundle-uri.c
index b18e7603103..475058592d1 100644
--- a/t/helper/test-bundle-uri.c
+++ b/t/helper/test-bundle-uri.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "parse-options.h"
 #include "bundle-uri.h"
+#include "gettext.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "transport.h"
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index b1edb92a032..1e975df9041 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -12,7 +12,7 @@
 
 #define USE_THE_INDEX_VARIABLE
 #include "test-tool.h"
-
+#include "cache.h"
 #include "cache-tree.h"
 #include "commit.h"
 #include "hex.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index f68b3761b68..0e53dee9e57 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -1,5 +1,5 @@
-#include "git-compat-util.h"
 #include "test-tool.h"
+#include "cache.h"
 #include "hex.h"
 #include "strbuf.h"
 #include "object-store.h"
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index de8f26639d4..05d56267a9f 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -1,4 +1,5 @@
 #include "test-tool.h"
+#include "cache.h"
 #include "alloc.h"
 #include "commit.h"
 #include "commit-reach.h"
diff --git a/transport.c b/transport.c
index 906dbad5a08..80059124c0a 100644
--- a/transport.c
+++ b/transport.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "hex.h"
diff --git a/transport.h b/transport.h
index 85150f504fb..6393cd9823c 100644
--- a/transport.h
+++ b/transport.h
@@ -1,7 +1,6 @@
 #ifndef TRANSPORT_H
 #define TRANSPORT_H
 
-#include "cache.h"
 #include "run-command.h"
 #include "remote.h"
 #include "list-objects-filter-options.h"
diff --git a/worktree.c b/worktree.c
index e10594ef336..cbb0db2d7cc 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "repository.h"
 #include "refs.h"
-- 
gitgitgadget

