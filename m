Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85892C61DA4
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBXAJu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjBXAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08921CF7D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:43 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id i11so6161983wrp.5
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nshe89PN1gzPqJKThCoxAFxeErNIqBa+ZXWzAXdMVEc=;
        b=a6H8YHY1I7DqdQsclJGa+qb9VF5m1n6bkR4HijX75locl5VSv9TN0h1F8M88QKQ5KM
         A/K+g3lQFkHZreciowabyULvypvP3c9xVn+CyDS4PxfIdO3FWpPOoTq+BG60hPS+KHqn
         z/tAK/aTp0aI9LkR3rTY7X1XxLJWk5YyliUkQtpqTrPijChGS6gQdCVcIu/hwdsw3YKB
         HbQ0LPKc3uocPFuPY9MoyOCeWkWxPQKuusPw7BKt6XSeHIywo2Z1NKMFrLszBclzprvn
         FLV4UaiHZs6lMdB++Xu6JsoW7vwTpNLjozjc7JlLwa0PVADMwuNnDbp0pcNv9+cCseeO
         277g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nshe89PN1gzPqJKThCoxAFxeErNIqBa+ZXWzAXdMVEc=;
        b=2B1xBvQU2T+FlX71wITFJ9JaSCyBbJt6eD5o2imdsukzX9zgra7bbm1f/NBIdxM0R1
         7kJFgtLAi5zjp+KGsrFl5VHCwqJqrqATCM8DgOKxZpcv0KAs0ISgoW2Subh+T0KRMCxv
         6+SbQch2AdHTzxj+z+TD/w2Cv0Y398M4UkhyjDGr8mE9NJIZCokxNF4g+mAg2nqA9s2P
         4bzGUQLs5F/IMa3HMxZPVakhWlpLGSPBNR5RHqiCX65K1dPJoTsy3XSo8hOOpOnrKb0z
         RVCh+vnK3YeNzgmj1A+/fsC6KCkdkAa2MZeqfJ2iaPKo4iocdMF0xky4k+aFBVe0Zh2a
         LeEA==
X-Gm-Message-State: AO0yUKW0pb/VwzcdIzrcacOMHLzPSMLLuOSFZIbW2+02QIHvX38kgrMF
        j3H5PElyJV3zUMVDswn4syYaUckKXok=
X-Google-Smtp-Source: AK7set+eN0jaTUZS+82Mz9oASLTvyMx1QUbqJlZ7tm0wMOTUWgBjn5Vs9JzU3/CwM3ESlMCjdivsng==
X-Received: by 2002:adf:f6c5:0:b0:2c7:17b8:575b with SMTP id y5-20020adff6c5000000b002c717b8575bmr1628657wrp.46.1677197381981;
        Thu, 23 Feb 2023 16:09:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fm16-20020a05600c0c1000b003dd1bd0b915sm867014wmb.22.2023.02.23.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:41 -0800 (PST)
Message-Id: <aede32dcb3002155568555a65e655404df39fc81.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:20 +0000
Subject: [PATCH v2 01/17] treewide: ensure one of the appropriate headers is
 sourced first
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
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
 Documentation/CodingGuidelines         | 8 ++++++--
 cbtree.c                               | 1 +
 compat/fsmonitor/fsm-ipc-win32.c       | 1 +
 compat/fsmonitor/fsm-settings-darwin.c | 1 +
 diff-merges.c                          | 1 +
 fmt-merge-msg.c                        | 1 +
 oidtree.c                              | 1 +
 oss-fuzz/fuzz-commit-graph.c           | 1 +
 oss-fuzz/fuzz-pack-headers.c           | 1 +
 oss-fuzz/fuzz-pack-idx.c               | 1 +
 prune-packed.c                         | 1 +
 rebase.c                               | 1 +
 refs/debug.c                           | 2 +-
 sub-process.c                          | 1 +
 14 files changed, 19 insertions(+), 3 deletions(-)

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

