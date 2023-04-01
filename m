Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC08AC761AF
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjDAPLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDAPL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:11:26 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F192545C
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:10:56 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h17so25177074wrt.8
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680361855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwPd9xbj6bIxxnpx9SW9S6fSLpH1pThrNZ6NWDy3RMM=;
        b=QajmNPwVIDigHWyhEXLmdG8sPlUnTBGarndfWuwLwz+Ckr8Mzq6nF0jra5ywuwE7lG
         5gpSrectFo4TKwwnXUSXDRtfAd4sgwI8V/mPX4jYgVcUMXHXneUhaXTqdx43lVNdhUvb
         ALOoRFCdq54cHbTQhfVc0MviMCrNz9kYsYiSIF9z/RGyLYh80L5thPXLLkAJVZoLxVlc
         9KphBAHf9kQTkhdGWEeZzKqmG+xPL57PXrOBWttswG2iIrjFdfikWnOduywefzZ35JCV
         pqQyLp2aY4Vkqf8a2BUmUOrdp2XiTZw7E2psksaN9ixNw1ycL/pEKIRMrZtELiU9WQ6+
         JbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680361855;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwPd9xbj6bIxxnpx9SW9S6fSLpH1pThrNZ6NWDy3RMM=;
        b=Ywp6WSw5dB/4qsLAP8uEW7DN55w+bg8id4fjGDKj7cVJvVDyWWJvFZgZiXruLnoLC3
         ux16YY+1UdY9jXbUoy1nO4tTTdo7/ugV2CHa87fu1gMz+Q/dREt4tRQi9g0wAJHeUWkM
         etRd7Pd/WEwzU9exBt4JsLes4lwSWk0xSKDqIfQkRRTG3Njvj+aL02ILW05TkhRsTGPk
         4UmxWmkQR5pj3Csr1fD8tBJlSByWOl2uhp6Fb/f3bmCQUFHWEKpnVt4mNN7JKx6HPHLm
         XCtV8x/a4kOXUaEsj5IEtg5pLXmKaNlRWiHDFS1C+Br4METOLfgSUogSGTPmozRoTfPe
         mkAw==
X-Gm-Message-State: AAQBX9dEHcN8YvPh5e8SBpMeruOstCr5tRwtiCWDEDz4BF48wn9edFJf
        XibGAKgYm664g9/2Mg/07C2aJ3e1Ld4=
X-Google-Smtp-Source: AKy350Zf7e/e95+GhKYu0XfHx8mnmZOSEy6gRLu/P7hTciYo9WH7ULZ1+t9XrQvSVMY0hkDo8QbipA==
X-Received: by 2002:adf:f1d0:0:b0:2cf:eb5d:70b5 with SMTP id z16-20020adff1d0000000b002cfeb5d70b5mr22454752wro.15.1680361854859;
        Sat, 01 Apr 2023 08:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d68c1000000b002c59f18674asm5150807wrw.22.2023.04.01.08.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 08:10:54 -0700 (PDT)
Message-Id: <3a0d78e2f9306748892c235740bd787f7e00eab1.1680361840.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 01 Apr 2023 15:10:34 +0000
Subject: [PATCH 21/24] treewide: remove double forward declaration of
 read_in_full
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

cache.h's nature of a dumping ground of includes prevented it from
being included in some compat/ files, forcing us into a workaround
of having a double forward declaration of the read_in_full() function
(see commit 14086b0a13 ("compat/pread.c: Add a forward declaration to
fix a warning", 2007-11-17)).  Now that we have moved functions like
read_in_full() from cache.h to wrapper.h, and wrapper.h isn't littered
with unrelated and scary #defines, get rid of the extra forward
declaration and just have compat/pread.c include wrapper.h.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clone.c       | 1 +
 bulk-checkin.c        | 1 +
 combine-diff.c        | 1 +
 compat/pread.c        | 1 +
 git-compat-util.h     | 6 ------
 grep.c                | 1 +
 pack-write.c          | 1 +
 path.c                | 1 +
 refs/packed-backend.c | 1 +
 send-pack.c           | 1 +
 setup.c               | 1 +
 upload-pack.c         | 1 +
 12 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index c7fdffb484c..4ed0a1d5aad 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -42,6 +42,7 @@
 #include "hook.h"
 #include "bundle.h"
 #include "bundle-uri.h"
+#include "wrapper.h"
 
 /*
  * Overall FIXMEs:
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9192298db6a..d843279715c 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -17,6 +17,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-store.h"
+#include "wrapper.h"
 
 static int odb_transaction_nesting;
 
diff --git a/combine-diff.c b/combine-diff.c
index cd5f39f22f4..f7e9fb57473 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -16,6 +16,7 @@
 #include "userdiff.h"
 #include "oid-array.h"
 #include "revision.h"
+#include "wrapper.h"
 
 static int compare_paths(const struct combine_diff_path *one,
 			  const struct diff_filespec *two)
diff --git a/compat/pread.c b/compat/pread.c
index 978cac4ec91..484e6d4c716 100644
--- a/compat/pread.c
+++ b/compat/pread.c
@@ -1,4 +1,5 @@
 #include "../git-compat-util.h"
+#include "../wrapper.h"
 
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index 1e6592624d0..4fb771f42a5 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -859,12 +859,6 @@ int git_lstat(const char *, struct stat *);
 #define pread git_pread
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
-/*
- * Forward decl that will remind us if its twin in cache.h changes.
- * This function is used in compat/pread.c.  But we can't include
- * cache.h there.
- */
-ssize_t read_in_full(int fd, void *buf, size_t count);
 
 #ifdef NO_SETENV
 #define setenv gitsetenv
diff --git a/grep.c b/grep.c
index bb8796a829f..d144b374894 100644
--- a/grep.c
+++ b/grep.c
@@ -11,6 +11,7 @@
 #include "commit.h"
 #include "quote.h"
 #include "help.h"
+#include "wrapper.h"
 
 static int grep_source_load(struct grep_source *gs);
 static int grep_source_is_binary(struct grep_source *gs,
diff --git a/pack-write.c b/pack-write.c
index d9b460fab4c..9c37121be31 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -10,6 +10,7 @@
 #include "oidmap.h"
 #include "pack-objects.h"
 #include "pack-revindex.h"
+#include "wrapper.h"
 
 void reset_pack_idx_option(struct pack_idx_option *opts)
 {
diff --git a/path.c b/path.c
index dff215ac693..7c1cd8182a8 100644
--- a/path.c
+++ b/path.c
@@ -18,6 +18,7 @@
 #include "object-store.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
+#include "wrapper.h"
 
 static int get_st_mode_bits(const char *path, int *mode)
 {
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 1eba1015dd5..2333ed5a1f7 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -9,6 +9,7 @@
 #include "../iterator.h"
 #include "../lockfile.h"
 #include "../chdir-notify.h"
+#include "../wrapper.h"
 #include "../write-or-die.h"
 
 enum mmap_strategy {
diff --git a/send-pack.c b/send-pack.c
index 72ebb7b61ae..351037b07bc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -14,6 +14,7 @@
 #include "quote.h"
 #include "transport.h"
 #include "version.h"
+#include "wrapper.h"
 #include "oid-array.h"
 #include "gpg-interface.h"
 #include "shallow.h"
diff --git a/setup.c b/setup.c
index a546da755f1..59abc16ba6d 100644
--- a/setup.c
+++ b/setup.c
@@ -12,6 +12,7 @@
 #include "promisor-remote.h"
 #include "quote.h"
 #include "trace2.h"
+#include "wrapper.h"
 
 static int inside_git_dir = -1;
 static int inside_work_tree = -1;
diff --git a/upload-pack.c b/upload-pack.c
index 0305fb2fbdc..e16dee783dd 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -32,6 +32,7 @@
 #include "commit-graph.h"
 #include "commit-reach.h"
 #include "shallow.h"
+#include "wrapper.h"
 #include "write-or-die.h"
 
 /* Remember to update object flag allocation in object.h */
-- 
gitgitgadget

