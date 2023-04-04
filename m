Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D8C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjDDBXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjDDBXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21272D5A
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q19so28067624wrc.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571369;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwPd9xbj6bIxxnpx9SW9S6fSLpH1pThrNZ6NWDy3RMM=;
        b=Nt+iTjbOczTSTWudgB/lD6Q5LIiMabqpWiSesMwcb13PuDfUN5cHoY4T9fNvSDHxri
         3CsJunPwBSEmGsDW+Xh0tFFI/fMSJHWfziYCFGqG3VBZocS7P+EyzX1UFMUoDfqguJeD
         2k09FnydmF+POX8La4JClgc5i4pu3uzh72kWfGrZWdnrr3Z3nSr4qymgjOv2rksGtTFa
         SbUm6+GiIyLZl6UO+Pz+tvtOaoO5Av4YSWvb7ASvFa3jtGywCedyGPUdJN6vLzSVgDCQ
         SYiX5mKXJyy+q9BQctALVgR2/TUR/yAmLLrfC2xF0B1oCMD39cx53JXfeEdz8lMBZ069
         pyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571369;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwPd9xbj6bIxxnpx9SW9S6fSLpH1pThrNZ6NWDy3RMM=;
        b=HZiyoho4aPzWnrcqFygZNDbx8Xk/31KL3k2hh/eRSMK1C4tVeyEBWZv24/zw4eGlKo
         sFwlGbsMRMZNYdQmQBTBiWrkeMfOEH//rGpCErMIFbTwRvo+WGV+mEvOY4czXIzgBP5a
         Ts1czKklzsfrqLPMbQ+VJqwLXitOeQRHlj9pfojguhSpoPc4OdpN9jVAI2cT+DoWGsxP
         TZq5ZbxXbaQG0sqF5nZ5auZOTJNGy/cAW+ivekZdldX8yz6Wh+PM3beRoua+3BusWUN5
         orWgl2430XwGV+cNufxFpWHScGEF6eyqjaH+WE8dem0YRPY2OceoyysTG1rjdl+7u+Va
         a1Zg==
X-Gm-Message-State: AAQBX9eKsP5ZONCaGPxh6VEh5M/HF+yzkzloDqRSy2uTwtyOzR+YBzqD
        1PA/83dlVW4HQ/KYJ4IKYSRb6CENanA=
X-Google-Smtp-Source: AKy350Ys1QjZWIqG+S3kGDAysT1xBHolQYau86wAxTbe4AUXCPUvQVQracMi3ABVVKuL8iGOq/2a/A==
X-Received: by 2002:a05:6000:1144:b0:2ce:92af:adbe with SMTP id d4-20020a056000114400b002ce92afadbemr244057wrx.59.1680571369059;
        Mon, 03 Apr 2023 18:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17-20020a5d5591000000b002eaac3a9beesm1234421wrv.8.2023.04.03.18.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:48 -0700 (PDT)
Message-Id: <6079c470cd1e0cd63109cdab00238f37a99643fb.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:26 +0000
Subject: [PATCH v2 22/24] treewide: remove double forward declaration of
 read_in_full
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

