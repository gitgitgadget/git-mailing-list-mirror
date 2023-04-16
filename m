Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039CEC77B70
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDPDEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjDPDEN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:04:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E335BC
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f16ecaad2eso2701915e9.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614222; x=1684206222;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCC7pl/0MUm3RZQQbRwL8UeA/97RAGRt1GddcT9luo=;
        b=jAhOYTVHzKaRRmp7UOKn+9m7t9bjydOj5KBGj7nuhZlaHox+f83pGLyrTGl2STqtvs
         0kkNDJu00LzWhHT8NOvkCKLFD/DAPIKwCHi7g/pEofxLUEJxwJI3ZIGg1pQmiSQnOzYQ
         oUgN5VSac5yg60uCl+6ZMJYzuQrZObcbcfoAs686FdkbJsMmHXXHrKQeqmKyq1hEbiwt
         2ThXnjGcScTndjNwuvFEI8y4hGM4NP3mo1ubZn1Rbmf+GUbisN9Jnx1MH9b8YGjhJXXD
         i82CvVsqJIuS686riAZmQ+QDOrTw5yixUUebsrlnLhNzoZb4Tz0IMNUsVYLOHvhCoS1A
         tnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614222; x=1684206222;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHCC7pl/0MUm3RZQQbRwL8UeA/97RAGRt1GddcT9luo=;
        b=k4bLcvuwAIULezI8GCo0NNe+f6XZWfSDBgUmANd2iG6ooC7RKGLemB9nPv1hKec9c1
         UXXK+m0xxofue1PZmwuyGi6G+IlyDAaODsP0oTD2ePr7hE0c7Ph34Eymi9RskUzB29fJ
         wmnyuTB4LRS99cJ6weQG7jVdpp2TzATCFhglW+jynOECHmzQqI+gzwJ2sqtATlEhal+V
         RzvdAY1Cmy7odcUgl/7cpz9JMObWtcs8LOUKnL0xy8QbQKR8dqcnJwJ8bQuDN6Ozsz9e
         XnsKuk9hBBoigJHeWPdVN1jaZjiBVogrxtxACAbOrmec+uwpcBet/KHQhxP4PiBFSvLt
         pt2g==
X-Gm-Message-State: AAQBX9e2kZgWMJjMVeUKgV+jIs1YF7OLMCUGEe1OnSPUfnvCljCjdF8/
        zBLI/O2XLRgIeDgeDDzDAAcxm0NydUw=
X-Google-Smtp-Source: AKy350aS+gXz3Mg0ASVRUADkAUDMnPQvRD+2k/4MNaaBVCd8ZYQ7+oKd9V6O1aLgq4nVFxDmVw/org==
X-Received: by 2002:adf:ef83:0:b0:2f8:4d7c:c3a9 with SMTP id d3-20020adfef83000000b002f84d7cc3a9mr2546751wro.43.1681614221944;
        Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003f046ad52efsm11826468wmq.31.2023.04.15.20.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:41 -0700 (PDT)
Message-Id: <d70e3b99daef23aa9064cb2d55240aa5e08cb8e4.1681614207.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:24 +0000
Subject: [PATCH 22/23] diff.h: reduce unnecessary includes
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
 attr.c              | 1 +
 diff.h              | 1 -
 http-push.c         | 1 +
 line-log.c          | 1 +
 pack-bitmap-write.c | 1 +
 reflog.c            | 1 +
 tree-diff.c         | 1 +
 7 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 2d8aeb8b58c..ddf2b0cbc2e 100644
--- a/attr.c
+++ b/attr.c
@@ -20,6 +20,7 @@
 #include "object-store.h"
 #include "setup.h"
 #include "thread-utils.h"
+#include "tree-walk.h"
 
 const char git_attr__true[] = "(builtin)true";
 const char git_attr__false[] = "\0(builtin)false";
diff --git a/diff.h b/diff.h
index 53aeb02a54b..69e574f4315 100644
--- a/diff.h
+++ b/diff.h
@@ -4,7 +4,6 @@
 #ifndef DIFF_H
 #define DIFF_H
 
-#include "tree-walk.h"
 #include "pathspec.h"
 #include "oidset.h"
 #include "strbuf.h"
diff --git a/http-push.c b/http-push.c
index 3f184986362..866ba243a89 100644
--- a/http-push.c
+++ b/http-push.c
@@ -16,6 +16,7 @@
 #include "sigchain.h"
 #include "strvec.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "packfile.h"
 #include "object-store.h"
 #include "commit-reach.h"
diff --git a/line-log.c b/line-log.c
index 10c19daec4a..6a7ac312a43 100644
--- a/line-log.c
+++ b/line-log.c
@@ -18,6 +18,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "bloom.h"
+#include "tree-walk.h"
 
 static void range_set_grow(struct range_set *rs, size_t extra)
 {
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 3d3fd380654..cdffe2ce47d 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -19,6 +19,7 @@
 #include "prio-queue.h"
 #include "trace2.h"
 #include "tree.h"
+#include "tree-walk.h"
 
 struct bitmapped_commit {
 	struct commit *commit;
diff --git a/reflog.c b/reflog.c
index 57dc7c0d051..ee1bf5d032c 100644
--- a/reflog.c
+++ b/reflog.c
@@ -5,6 +5,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "tree.h"
+#include "tree-walk.h"
 #include "worktree.h"
 
 /* Remember to update object flag allocation in object.h */
diff --git a/tree-diff.c b/tree-diff.c
index 9ea2dd7a6c3..20bb15f38d9 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -5,6 +5,7 @@
 #include "diff.h"
 #include "diffcore.h"
 #include "tree.h"
+#include "tree-walk.h"
 
 /*
  * Some mode bits are also used internally for computations.
-- 
gitgitgadget

