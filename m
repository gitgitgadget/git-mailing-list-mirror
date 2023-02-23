Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC60C61DA4
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjBWIFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjBWIFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24FD3D0A6
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:26 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i11so3745332wrp.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OahwylFSuFVh75SWtV1jtNAo8uK09U25UM+V+A1RSbI=;
        b=p3BOSy6cBb9ansZEHNBYgwZrQe1GVoEXFyAyzELeh7D6P5YQaZnZE06Wvqz+dD31Nn
         FFIiF040m/JeA4qkukqIzVFqxJVtwIup07C51ViyPBU+uPK8gWjwQqZqkEgAqeLsb5J/
         WjmE+fhAhEuiZY7TbDsGiVyBazVGAlMbiQv9k2N/XbLRx5Z5CBrJWmHj/d5qfjlN9Yxf
         OXkAYm67w07ljt/dwdG4SBNcHG3+Gw2eDWUdjje91j2T3qSAz8Aa4BeY39X4Nf4CpHtI
         6ZKDUSnlyzEgZuE12KduSAJzxbDXMSRJhmG6+pgmBo/FqVJ90inzXFcEtd1bFGJtpxIn
         M7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OahwylFSuFVh75SWtV1jtNAo8uK09U25UM+V+A1RSbI=;
        b=eQgLTUloI/R4Q7RLJKn0aXjc8ll6K2W9kVMZr+B/8jWCVRrjiAuqBIhH5jTFO0OJZm
         rToYl0pvAyvBPziVxrz1B9mfhb8Zh8ZLJ9AMtZ2E0XfO/46t/UgxZUhvC2+4ezc2GvDr
         JD6SsRnAwVCs0qdRQchkovZEyX2K33ZCRhKCnTBpR9Uqt5Kb7TAXztQ1Wh60+Y+2zpDs
         rpaSw8QAyzxDZjqoZMe7K1HNr4TTGo6IIK7jNAaWuzUFWv5d9HxZsM8I6zALa3UYUItX
         X2B5HbWA5EWKyne9H8LqZlBum6GkN0rffTQS3hbYkkhl2x1b1CswA7HR0MbuPlCmYlSp
         i6sA==
X-Gm-Message-State: AO0yUKUi43GpPX0DCFRa/s4eSIjPMU/sWfiJTyG/sFI6qUq05VfNA4uT
        XLSoKrCyypPRMu8G/Lkixqp0t4X2FCc=
X-Google-Smtp-Source: AK7set8j8oxsLadNCmJMRGrs+8YTVgN5mBq06YyQabaV23UdOM4p7vpn/fMRVwxSaam8lR5rK0F8Nw==
X-Received: by 2002:a05:6000:1cd:b0:2c5:8575:c37 with SMTP id t13-20020a05600001cd00b002c585750c37mr9779469wrx.66.1677139525168;
        Thu, 23 Feb 2023 00:05:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c225600b003e2058a7109sm10601092wmm.14.2023.02.23.00.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:24 -0800 (PST)
Message-Id: <adafa655432dd13d1c727522377ac9a4b515b76a.1677139521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:07 +0000
Subject: [PATCH 02/16] treewide: remove unnecessary git-compat-util.h includes
 in headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since git-compat-util.h needs to be included first in C files, having it
appear in header files is unnecessary.  More importantly, having it
included in header files seems to lead to folks leaving it out of C
files, which makes it harder to verify that the rule is being followed.
Remove it from header files, other than the ones that have been approved
as alternate first includes.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 advice.h                               | 2 --
 cbtree.h                               | 2 --
 chunk-format.h                         | 1 -
 commit-graph.h                         | 1 -
 commit-slab-impl.h                     | 2 --
 compat/fsmonitor/fsm-ipc-win32.c       | 1 +
 compat/fsmonitor/fsm-settings-darwin.c | 1 +
 hash.h                                 | 1 -
 pack-mtimes.h                          | 2 --
 pkt-line.h                             | 1 -
 repository.h                           | 1 -
 sub-process.h                          | 1 -
 trace.h                                | 1 -
 13 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/advice.h b/advice.h
index 07e0f76833e..3e1b48bf68d 100644
--- a/advice.h
+++ b/advice.h
@@ -1,8 +1,6 @@
 #ifndef ADVICE_H
 #define ADVICE_H
 
-#include "git-compat-util.h"
-
 struct string_list;
 
 /*
diff --git a/cbtree.h b/cbtree.h
index 0be14fb7ee4..43193abdda2 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -14,8 +14,6 @@
 #ifndef CBTREE_H
 #define CBTREE_H
 
-#include "git-compat-util.h"
-
 struct cb_node;
 struct cb_node {
 	struct cb_node *child[2];
diff --git a/chunk-format.h b/chunk-format.h
index 7885aa08487..025c38f938e 100644
--- a/chunk-format.h
+++ b/chunk-format.h
@@ -1,7 +1,6 @@
 #ifndef CHUNK_FORMAT_H
 #define CHUNK_FORMAT_H
 
-#include "git-compat-util.h"
 #include "hash.h"
 
 struct hashfile;
diff --git a/commit-graph.h b/commit-graph.h
index 37faee6b66d..bb88bec7aa3 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,7 +1,6 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "git-compat-util.h"
 #include "object-store.h"
 #include "oidset.h"
 
diff --git a/commit-slab-impl.h b/commit-slab-impl.h
index 557738df271..4a414ee905d 100644
--- a/commit-slab-impl.h
+++ b/commit-slab-impl.h
@@ -1,8 +1,6 @@
 #ifndef COMMIT_SLAB_IMPL_H
 #define COMMIT_SLAB_IMPL_H
 
-#include "git-compat-util.h"
-
 #define implement_static_commit_slab(slabname, elemtype) \
 	implement_commit_slab(slabname, elemtype, MAYBE_UNUSED static)
 
diff --git a/compat/fsmonitor/fsm-ipc-win32.c b/compat/fsmonitor/fsm-ipc-win32.c
index e08c505c148..c9536dfb666 100644
--- a/compat/fsmonitor/fsm-ipc-win32.c
+++ b/compat/fsmonitor/fsm-ipc-win32.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor-ipc.h"
 
diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 6abbc7af3ab..58b623fbb9a 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "config.h"
 #include "fsmonitor.h"
 #include "fsmonitor-ipc.h"
diff --git a/hash.h b/hash.h
index 36b64165fc9..351afc2ce3b 100644
--- a/hash.h
+++ b/hash.h
@@ -1,7 +1,6 @@
 #ifndef HASH_H
 #define HASH_H
 
-#include "git-compat-util.h"
 #include "repository.h"
 
 #if defined(SHA1_APPLE)
diff --git a/pack-mtimes.h b/pack-mtimes.h
index cc957b3e852..107327cec0b 100644
--- a/pack-mtimes.h
+++ b/pack-mtimes.h
@@ -1,8 +1,6 @@
 #ifndef PACK_MTIMES_H
 #define PACK_MTIMES_H
 
-#include "git-compat-util.h"
-
 #define MTIMES_SIGNATURE 0x4d544d45 /* "MTME" */
 #define MTIMES_VERSION 1
 
diff --git a/pkt-line.h b/pkt-line.h
index 79c538b99e4..8e9846f3151 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -1,7 +1,6 @@
 #ifndef PKTLINE_H
 #define PKTLINE_H
 
-#include "git-compat-util.h"
 #include "strbuf.h"
 #include "sideband.h"
 
diff --git a/repository.h b/repository.h
index e8c67ffe165..15a8afc5fb5 100644
--- a/repository.h
+++ b/repository.h
@@ -1,7 +1,6 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
 
-#include "git-compat-util.h"
 #include "path.h"
 
 struct config_set;
diff --git a/sub-process.h b/sub-process.h
index e85f21fa1a7..6a61638a8ac 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -1,7 +1,6 @@
 #ifndef SUBPROCESS_H
 #define SUBPROCESS_H
 
-#include "git-compat-util.h"
 #include "hashmap.h"
 #include "run-command.h"
 
diff --git a/trace.h b/trace.h
index 4e771f86ac2..1a75824b15e 100644
--- a/trace.h
+++ b/trace.h
@@ -1,7 +1,6 @@
 #ifndef TRACE_H
 #define TRACE_H
 
-#include "git-compat-util.h"
 #include "strbuf.h"
 
 /**
-- 
gitgitgadget

