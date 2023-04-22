Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBABC7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 20:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjDVUSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 16:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDVUR4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 16:17:56 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC822110
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-2f7db354092so1772425f8f.2
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 13:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682194669; x=1684786669;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHCC7pl/0MUm3RZQQbRwL8UeA/97RAGRt1GddcT9luo=;
        b=HsXYFW+xxbIg+/668TFe/h1U8VTpUsyPWPGt4v0vHUzYxKCTsYHhQO15aNNKSkfoj3
         p0bzot/D5k/QlkV7+ESR+mnbXn03XNJIxvVSR2xjz1B2hXG9xDC1idyUvrZV6qlv4ZVT
         EeEUJ34epqfAsTx//UGgkcpDUI6WccSLAE7Zjb7hpFfAr8TfX+wAU76FyBi0W0wRWCR8
         pa9XarkOgGXqkIacsII/vr1NIMPY95FGi/a31EcXiSNf6SprfTauOWJQcQS628F/MHVy
         4ngfUwUr0SK4MCX/J2OZ4llArZGqUiwucPL4KNM17YW5hfE8iSlvz1q+xcW2g4vGtXy8
         GEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682194669; x=1684786669;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHCC7pl/0MUm3RZQQbRwL8UeA/97RAGRt1GddcT9luo=;
        b=djML0v0SsUpbzQoJkNlZf6h6/a/zexy7s7Wv0mKe4c8T1Cu35u8epwka1iBFXX3KFQ
         ZIdKhd62aJRmG8G3gWR0cvgFyeLEXPSEvSFA2zuQAZGwbbONgIso6ciuLjRtD00W2ugO
         rzlD4EhAGSu10D/Ysca3ol90u/Lxg4KLF5Up3xWG2avg/ZZ55lkdm/zPh96haMQriEwx
         7+6KME9BusL+ct9zXt1n1xM/z68dPmudYUMs2SrpGmU6mR83qXWL+jSciaLxekn5dv3p
         tUYI4RLChXmvB0TzeUSLJ50takdI+LYWWHr2v5+aqqnKY1CQBZH4jRw2FTUM3Je08THs
         trYA==
X-Gm-Message-State: AAQBX9dyFy0d3UF4BC57YR48d43lw23Rm8bsBa8pViNQuEgYwHmwG1bj
        a9Qc7Dt2zFirmZbAaY9Y6AznKPeJ4IY=
X-Google-Smtp-Source: AKy350Y5b5qc78Vdaks/ctLJkH8+gqtyaJxTIyzs0vqrgzZW1b56prl1aZmacFe+w1oNjf9M9U/gqQ==
X-Received: by 2002:a5d:508c:0:b0:2f4:bc68:3493 with SMTP id a12-20020a5d508c000000b002f4bc683493mr6848178wrt.34.1682194669119;
        Sat, 22 Apr 2023 13:17:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d43cb000000b002ff77b033b1sm7241114wrr.33.2023.04.22.13.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Apr 2023 13:17:48 -0700 (PDT)
Message-Id: <b7a96a08d1463ec51f0d8384012d812fd5f43537.1682194652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
        <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 22 Apr 2023 20:17:28 +0000
Subject: [PATCH v2 21/22] diff.h: reduce unnecessary includes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
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

