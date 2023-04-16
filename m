Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03276C77B71
	for <git@archiver.kernel.org>; Sun, 16 Apr 2023 03:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDPDED (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 23:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjDPDDh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 23:03:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC34030E3
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f096839f72so7180075e9.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 20:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681614214; x=1684206214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VKzPjlOVt0ttQYRbSkQR33ViI/ZjrwE7RAdiLHPLZg=;
        b=iTq1jmSrIsxRgyKA01Cr+u0A4JS8ou/0jVXbQk5GwlUl09uSkTVkbKqgOo6BG+rPQL
         +dSz1xQsoPD7zMur/oOqRRwV78lJRQ7GCHINJoFugfX918L+1sqS94EEYOp2W1u5YYbO
         oOhfmg3ASYd6eOGMkWbBZHqvT1KtgJlrBp2aAssW414oNEIonUtV5UU+o9PtUyr5NhPn
         ymVMb4KfBTlIOYZmtXLbl/NxsAXjTD61Irf8fgm6X/QdzMTFfpNyNVpTzZ5lFJ9rd5uh
         Tq7762XrA+plbgYb+P+XB4Y/LNDq++ly5+ncnPgAINh0O5QzJk7GYsqGti2AKzUCT58C
         UP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681614214; x=1684206214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VKzPjlOVt0ttQYRbSkQR33ViI/ZjrwE7RAdiLHPLZg=;
        b=Jb6O4JtSlVj9E9xB1RTbT4aN2gEryagCJTP3y5d0aTllLGlNGtjg7Hm+Rblu9XrPUX
         HxjnHUG/YP+9nzMpHUq8xLkTOT0KZq90XwSsbBMMwYxH6EDd5DoUHWw9Ty1hpeYcrAiz
         dBdnPqLoxc3fe18jOygLYGDG3eWB6fhx7r3bYFzrQobaVUOfppimpdIxu85C9dq7PLfP
         nudfaDiESyoFHyKYB8RUqjEfK8r0G/mHT+aqfzZM7C6vEWhXItiDBRoUXlRszjOHjqqc
         KgNrNVNaAx2UTnhLqapuSbMQ2wkr9TZyOjQVrUWtsxTjOBfkTADxuA1aJYA7PiArQ9xb
         UReg==
X-Gm-Message-State: AAQBX9clupL4ULhpjDGxNp9bEi79raQxAUhwu1FiBzs8Qf6KU7I9PUEi
        aHn3CQlDVDT7geBIevFxBELdm+nF3dI=
X-Google-Smtp-Source: AKy350azazLcTgUgKxTSvACL4REC6UbDEZ7/x/MWiktF43kggvKAZQg6c7LDMoP4XQWoAzQpc1Wa5g==
X-Received: by 2002:adf:f852:0:b0:2f7:662:c87f with SMTP id d18-20020adff852000000b002f70662c87fmr2537052wrq.14.1681614214220;
        Sat, 15 Apr 2023 20:03:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d5343000000b002c55521903bsm7045882wrv.51.2023.04.15.20.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 20:03:34 -0700 (PDT)
Message-Id: <11c6cd13e2b15687034b041ac5abc5c9d3906454.1681614206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
References: <pull.1517.git.1681614205.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Apr 2023 03:03:11 +0000
Subject: [PATCH 09/23] match-trees.h: move declarations for match-trees.c
 functions from cache.h
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
 cache.h                     |  4 ----
 match-trees.c               |  1 +
 match-trees.h               | 10 ++++++++++
 merge-ort.c                 |  1 +
 merge-recursive.c           |  1 +
 t/helper/test-match-trees.c |  1 +
 6 files changed, 14 insertions(+), 4 deletions(-)
 create mode 100644 match-trees.h

diff --git a/cache.h b/cache.h
index fde782a96f0..0570f9ad07d 100644
--- a/cache.h
+++ b/cache.h
@@ -603,10 +603,6 @@ int add_files_to_cache(const char *prefix, const struct pathspec *pathspec, int
 /* diff.c */
 extern int diff_auto_refresh_index;
 
-/* match-trees.c */
-void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
-void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
-
 /*
  * whitespace rules.
  * used by both diff and apply
diff --git a/match-trees.c b/match-trees.c
index 5877fc64a8f..9b78d99507b 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "hex.h"
+#include "match-trees.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-store.h"
diff --git a/match-trees.h b/match-trees.h
new file mode 100644
index 00000000000..e3877acd583
--- /dev/null
+++ b/match-trees.h
@@ -0,0 +1,10 @@
+#ifndef MATCH_TREES_H
+#define MATCH_TREES_H
+
+struct object_id;
+struct repository;
+
+void shift_tree(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, int);
+void shift_tree_by(struct repository *, const struct object_id *, const struct object_id *, struct object_id *, const char *);
+
+#endif /* MATCH_TREES_H */
diff --git a/merge-ort.c b/merge-ort.c
index 2c6a9ed9a41..65837db77f0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -31,6 +31,7 @@
 #include "hex.h"
 #include "entry.h"
 #include "ll-merge.h"
+#include "match-trees.h"
 #include "mem-pool.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index d4d2ab05b2e..8e87b6386d9 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -22,6 +22,7 @@
 #include "hex.h"
 #include "ll-merge.h"
 #include "lockfile.h"
+#include "match-trees.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
diff --git a/t/helper/test-match-trees.c b/t/helper/test-match-trees.c
index 3808e1ac38b..a498fece7a3 100644
--- a/t/helper/test-match-trees.c
+++ b/t/helper/test-match-trees.c
@@ -1,6 +1,7 @@
 #include "test-tool.h"
 #include "cache.h"
 #include "hex.h"
+#include "match-trees.h"
 #include "object-name.h"
 #include "setup.h"
 #include "tree.h"
-- 
gitgitgadget

