Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5E3C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbjBWIFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjBWIF2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:28 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAFF43467
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:26 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so8943857wms.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzX04it5y4U5u1z7dnjykdrOr76kSmwW89WHbeh+wac=;
        b=cMgHQYlp931Dos0YlA6aKkma8yXGlEQmHInOdXuWAqesaiaXvRch2BNxncjQ9/jhYh
         r4aXYK46s3Z8kJnqEdo2yvVIog7vDWLO0xwYUEs1fxQWSQ2EOy2SUaQXUxVfc6vyuObJ
         cm+Pkf+pyoYLYBLOYbu4xhBEHegQgvap22lV0q9RCt4+FGCzKFsqMOkMjssUYqW+ivBi
         RwN3Z2b44T9sic3NNM+CyyfcI2iSaiiWCoDGGhRA03XMkM5In9UNPW4tl1RpPr+GUxmw
         r3hpNgvGU546pVY7cR9kNcZxIonaTKIW8OPmCtUVrtSPWuwCjjCzjE8JW7JeDQCaGFvc
         49wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzX04it5y4U5u1z7dnjykdrOr76kSmwW89WHbeh+wac=;
        b=5yFL+O7TOAhUBtaougPF+BvFlNjpqOWO6RvPmkgOrLWmCVHeSFS6uZoawb7oIuKyND
         3ImxvEGpD9FxjFvXqnBRScSIMWxlFmfKhOHcRT253rW6IQ5z8ruefNRs8xjLSIwcV81q
         xOIlKuB4YE6WY/abCgs+mIEt8mXu2y/itqm6Rz30Dir4QR7KsH74nClD+alETzGw2YOT
         B+MufStD1fyDQA552HplmrmXKPhTjor3bFuazZYmu0aI5j1Ac6JSVR8EUDgP29HHtoNR
         7w89TxgKSe42CtGrK3nIWXWfx1+iOuwmr0qQCAcD3OVADROQHREi+xhJ0M/sWClwCbD5
         gGUg==
X-Gm-Message-State: AO0yUKWgcxJ2rOVj4QxA7XZXUU18I2BEm5gXEh3f1Ed+gzRpw6ivsGfN
        oYKlLeBkG+viP1OnrYO8SSo399Lb1TI=
X-Google-Smtp-Source: AK7set/dxqeyun4qdrUZc60JSKQagcEFb0X+pW7clyBai+8iGsLkGNxBIIQjocvoEwZf+K3pq1J0Pw==
X-Received: by 2002:a05:600c:1693:b0:3e2:1f00:bd02 with SMTP id k19-20020a05600c169300b003e21f00bd02mr4266426wmn.5.1677139524458;
        Thu, 23 Feb 2023 00:05:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c458800b003db01178b62sm4022196wmo.40.2023.02.23.00.05.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:24 -0800 (PST)
Message-Id: <a143d62472422e11537b68ab6e87cfafdc8e0c7c.1677139521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:06 +0000
Subject: [PATCH 01/16] treewide: ensure one of the appropriate headers is
 sourced first
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

We had several C files ignoring the rule to include one of the
appropriate headers first; fix that.

While at it, the rule in Documentation/CodingGuidelines about which
header to include has also fallen out of sync, so update the wording to
mention other allowed headers.

Unfortunately, C files in reftable/ don't actually follow the previous
or updated rule.  If you follow the #include chain in its C files,
reftable/system.h _tends_ to be first (i.e. record.c first includes
record.h, which first includes basics.h, which first includees
system.h), but not always (e.g. publicbasics.c includes another header
first that does not include system.h).  However, I'm going to punt on
making actual changes to the C files in reftable/ since I do not want to
risk bringing it out-of-sync with any version being used externally.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/CodingGuidelines | 8 ++++++--
 cbtree.c                       | 1 +
 diff-merges.c                  | 1 +
 fmt-merge-msg.c                | 1 +
 oidtree.c                      | 1 +
 oss-fuzz/fuzz-commit-graph.c   | 1 +
 oss-fuzz/fuzz-pack-headers.c   | 1 +
 oss-fuzz/fuzz-pack-idx.c       | 1 +
 prune-packed.c                 | 1 +
 rebase.c                       | 1 +
 refs/debug.c                   | 2 +-
 sub-process.c                  | 1 +
 12 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 9d5c27807a4..003393ed161 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -442,8 +442,12 @@ For C programs:
    detail.
 
  - The first #include in C files, except in platform specific compat/
-   implementations, must be either "git-compat-util.h", "cache.h" or
-   "builtin.h".  You do not have to include more than one of these.
+   implementations and sha1dc/, must be either "git-compat-util.h" or
+   one of the approved headers that includes it first for you.  (The
+   approved headers currently include "cache.h", "builtin.h",
+   "t/helper/test-tool.h", "xdiff/xinclude.h", or
+   "reftable/system.h").  You do not have to include more than one of
+   these.
 
  - A C file must directly include the header files that declare the
    functions and the types it uses, except for the functions and types
diff --git a/cbtree.c b/cbtree.c
index 336e46dbba5..c1cc30a5dc7 100644
--- a/cbtree.c
+++ b/cbtree.c
@@ -4,6 +4,7 @@
  * Based on Adam Langley's adaptation of Dan Bernstein's public domain code
  * git clone https://github.com/agl/critbit.git
  */
+#include "git-compat-util.h"
 #include "cbtree.h"
 
 static struct cb_node *cb_node_of(const void *p)
diff --git a/diff-merges.c b/diff-merges.c
index 85cbefa5afd..faa7bc73a34 100644
--- a/diff-merges.c
+++ b/diff-merges.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "diff-merges.h"
 
 #include "revision.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index f48f44f9cd1..f317f129904 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "config.h"
 #include "refs.h"
 #include "object-store.h"
diff --git a/oidtree.c b/oidtree.c
index 0d39389bee2..7d57b7b19e3 100644
--- a/oidtree.c
+++ b/oidtree.c
@@ -2,6 +2,7 @@
  * A wrapper around cbtree which stores oids
  * May be used to replace oid-array for prefix (abbreviation) matches
  */
+#include "git-compat-util.h"
 #include "oidtree.h"
 #include "alloc.h"
 #include "hash.h"
diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 914026f5d80..2992079dd97 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "commit-graph.h"
 #include "repository.h"
 
diff --git a/oss-fuzz/fuzz-pack-headers.c b/oss-fuzz/fuzz-pack-headers.c
index 99da1d0fd38..150c0f5fa2d 100644
--- a/oss-fuzz/fuzz-pack-headers.c
+++ b/oss-fuzz/fuzz-pack-headers.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index 0c3d777aac8..609a343ee3e 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "object-store.h"
 #include "packfile.h"
 
diff --git a/prune-packed.c b/prune-packed.c
index 261520b472c..d2813f6a405 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "object-store.h"
 #include "packfile.h"
 #include "progress.h"
diff --git a/rebase.c b/rebase.c
index 6775cddb284..17a570f1ff9 100644
--- a/rebase.c
+++ b/rebase.c
@@ -1,3 +1,4 @@
+#include "git-compat-util.h"
 #include "rebase.h"
 #include "config.h"
 #include "gettext.h"
diff --git a/refs/debug.c b/refs/debug.c
index eed8bc94b04..ff7766bc636 100644
--- a/refs/debug.c
+++ b/refs/debug.c
@@ -1,4 +1,4 @@
-
+#include "git-compat-util.h"
 #include "refs-internal.h"
 #include "trace.h"
 
diff --git a/sub-process.c b/sub-process.c
index 6d4232294db..1daf5a97525 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -1,6 +1,7 @@
 /*
  * Generic implementation of background process infrastructure.
  */
+#include "git-compat-util.h"
 #include "sub-process.h"
 #include "sigchain.h"
 #include "pkt-line.h"
-- 
gitgitgadget

