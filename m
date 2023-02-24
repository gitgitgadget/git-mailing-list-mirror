Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CC0C64ED6
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 00:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBXAJz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:09:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBXAJt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 19:09:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6F1EBDF
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c12so12328008wrw.1
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 16:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPVXunMyrvoTVyAMRQrkj2BUDcUjSagNUbc7lYlhj8E=;
        b=QOxtmHyVPQ/H70zBJ6O2SNQ4kkQm6tJ2CzuT9LINbRK/PTFLs+3PZH8ceUS6JayBN7
         1nimPZlgT/hxuZS8hxtYNvsQgUor7GUW/HS0Wq4gvBwxoP4GP726rKgOv3Jt0hPiX4l/
         0TL/ARNK5q//dpMzX9PpqDwILtDLpUY7blu5Kj7ACkjF1VjjltCUhPlGCCrzDFVjjTyB
         zsKr1Edk5udpQwRZbukgUFkiVJ/AtlBvdzWCnLEDEgWkjRq+Bf3mTutjtVf0GY+B0zq2
         wvchr+hSXy/UOJC3L+5x+ya/c9gcmC4P5KxrF4R/HnZNREwRTvTJM/0BjEylVnaEhtMV
         EXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPVXunMyrvoTVyAMRQrkj2BUDcUjSagNUbc7lYlhj8E=;
        b=znpk03FrbUlN0Hml0rzsTRAJbf82bq1Zd1MQeOiSuVpEPfE4FOdDO5HN8v+HR8BM6/
         k1NNdV8AfgOXNZRUrDjfJJ+jOC1Q+XC0sSLTtXD3eh+tHIAkKphhfgQHCiljXdRi2Gow
         0v1FLK94+VRG/y6ISCO+Jka0MyzNTJHdq/fLjxaru6lEafbRz1PoRh9XDMoE9NtYmYyg
         DSDmmnIW2NRRvURjss77m7Kr3YDR67J7aPxxRW4OMKkBzRK1IqSIceDGaElpkdzkc498
         wQyQ6miuqttkFTLzn3aK9bQYnUjYyHgHLgchYyVvbHx27JFc+mKV2UNXcpmUQVE5TjHD
         Fu5Q==
X-Gm-Message-State: AO0yUKXbO4wQMsxEDWWJMWBFM46KWUc0wDSI3F4szQJpfDYhK0I/4e1x
        QnNJk/QJbMtqptaXtB16wm0xkFnSlF0=
X-Google-Smtp-Source: AK7set+raQlJIy4vagSc0kN2YyK/38njKrDwW29F7zFWQR+5vPVukXW1ITOlaiFFb7tkExtlPVLIug==
X-Received: by 2002:a05:6000:144e:b0:2c5:4ce5:2995 with SMTP id v14-20020a056000144e00b002c54ce52995mr12903951wrx.1.1677197382592;
        Thu, 23 Feb 2023 16:09:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g2-20020a5d4882000000b002c55521903bsm14546745wrq.51.2023.02.23.16.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 16:09:42 -0800 (PST)
Message-Id: <e1c2b55ac67391ea05c44703dc6f3c8bd27066c3.1677197377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
        <pull.1485.v2.git.1677197376.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Feb 2023 00:09:21 +0000
Subject: [PATCH v2 02/17] treewide: remove unnecessary git-compat-util.h
 includes in headers
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

For sanity, we should probably do one of the following:

(a) make C and header files both depend upon everything they need
(b) consistently exclude git-compat-util.h from headers and require it
    be the first include in C files

Currently, we have some of the headers following (a) and others
following (b), which makes things messy.  In the past I was pushed
towards (b), as per [1] and [2].  Further, during this series I
discovered that this mixture empirically will mean that we end up with C
files that do not directly include git-compat-util.h, and do include
headers that don't include git-compat-util.h, with the result that we
likely have headers included before an indirect inclusion of
git-compat-util.h.  Since git-compat-util.h has tricky platform-specific
stuff that is meant to be included before everything else, this state of
affairs is risky and may lead to things breaking in subtle ways (and
only on some platforms) as per [1] and [2].

Since including git-compat-util.h in existing header files makes it
harder for us to catch C files that are missing that include, let's
switch to (b) to make the enforcement of this rule easier.  Remove the
inclusion of git-compat-util.h from header files other than the ones
that have been approved as alternate first includes.

[1] https://lore.kernel.org/git/20180811173406.GA9119@sigill.intra.peff.net/
[2] https://lore.kernel.org/git/20180811174301.GA9287@sigill.intra.peff.net/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 advice.h           | 2 --
 cbtree.h           | 2 --
 chunk-format.h     | 1 -
 commit-graph.h     | 1 -
 commit-slab-impl.h | 2 --
 hash.h             | 1 -
 pack-mtimes.h      | 2 --
 pkt-line.h         | 1 -
 repository.h       | 1 -
 sub-process.h      | 1 -
 trace.h            | 1 -
 11 files changed, 15 deletions(-)

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

