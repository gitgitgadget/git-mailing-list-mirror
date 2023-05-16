Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B093DC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjEPGfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjEPGey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0AC4687
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so74961105e9.0
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218875; x=1686810875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBPpWher3Z6G3Eg3ZIpb21mdoi+CeEJK1lNQKJcIMlU=;
        b=EXFbm2qoeFhS3XR04YIaDwz+XnYnESnBVFhgvTZX2dZZAQJL6C+ht3OQJzo9x5TyWi
         g+vEnwwg3IMKJcy4OBZ0Xkdn1olhOYln5cl2qtygbgctpnuFioVT2HEpgmX3r4nd62Kd
         yw2G0GXxJB5EpP9jO7tXRZXEUVaCpWLcdoHErmwB4JBXC19BVKN+boS0+qChsmP6OPwe
         5Z+9M+c4Q8R6ATg29sMUTC8zfh3JxXxL1BGwxQaHpT9kR0+h3oRnB+xn+CjdqhweHRnh
         xDaQW0buhyD7XYpeFh4Lh9LzWg7SRT94+KJuFVqOdA5oLA2CCH19KeqIyZ+BNrxCqhzZ
         6TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218875; x=1686810875;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBPpWher3Z6G3Eg3ZIpb21mdoi+CeEJK1lNQKJcIMlU=;
        b=NaVI80fQ+unIi6SFDbaneDVzGQcSMyjGg+BpDC31A5hPI+q/cziW+Q5vWDBPfjkanT
         59QQo8y3lTa7T9WHvbupUl94SE/PAX4Eg/HKDBcF/UQ34XRcmb2Fx9jsNEzFKi6Tnf65
         kconTzbYQ07vYPAVYnmfDVzMZAI+XaMEmBQlKJZ+sr9dh/NwiUxHOzGyT6cLrHGjjOVZ
         /JmyMRiaiXI33HyJwD3ti5LsSNuFbUyao7VZE1jo/fNenlUSFOSG4Xp02D0bsabh1ls3
         YAYHdvudZ4EbjafJ2opYg1o/5FMTZ1aHevRwOaqlKPyoyAV8B6fxvcRcqoS9vS26Mlpk
         nj4A==
X-Gm-Message-State: AC+VfDxVOba9Wc9wNBlWxfCJXme5WrHm4OYxkpUBa9qrslB/frUXsykk
        QsWL7ErapD3VpwpK0zTeYV5alqBBWcw=
X-Google-Smtp-Source: ACHHUZ6ISNSlS7BVilDn90iYeCKIStIp1mH5TF+fcF9RHJPgB/K4DPSmUclpKEoG2sSWHNvtlKRSdw==
X-Received: by 2002:a5d:56c8:0:b0:2f5:83a8:a9a9 with SMTP id m8-20020a5d56c8000000b002f583a8a9a9mr26550516wrw.16.1684218875405;
        Mon, 15 May 2023 23:34:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1-20020adfe9c1000000b003021288a56dsm1340629wrn.115.2023.05.15.23.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:35 -0700 (PDT)
Message-Id: <3570337758078eecdc8a67e662dbc38371fa356d.1684218853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:34:04 +0000
Subject: [PATCH v3 24/28] merge-ll: rename from ll-merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

A long term (but rather minor) pet-peeve of mine was the name
ll-merge.[ch].  I thought it made it harder to realize what stuff was
related to merging when I was working on the merge machinery and trying
to improve it.

Further, back in d1cbe1e6d8a ("hash-ll.h: split out of hash.h to remove
dependency on repository.h", 2023-04-22), we have split the portions of
hash.h that do not depend upon repository.h into a "hash-ll.h" (due to
the recommendation to use "ll" for "low-level" in its name[1], but which
I used as a suffix precisely because of my distaste for "ll-merge").
When we discussed adding additional "*-ll.h" files, a request was made
that we use "ll" consistently as either a prefix or a suffix.  Since it
is already in use as both a prefix and a suffix, the only way to do so
is to rename some files.

Besides my distaste for the ll-merge.[ch] name, let me also note that
the files
  ll-fsmonitor.h, ll-hash.h, ll-merge.h, ll-object-store.h, ll-read-cache.h
would have essentially nothing to do with each other and make no sense
to group.  But giving them the common "ll-" prefix would group them.  Using
"-ll" as a suffix thus seems just much more logical to me.  Rename
ll-merge.[ch] to merge-ll.[ch] to achieve this consistency, and to
ensure we get a more logical grouping of files.

[1] https://lore.kernel.org/git/kl6lsfcu1g8w.fsf@chooglen-macbookpro.roam.corp.google.com/

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/technical/api-merge.txt | 4 ++--
 Makefile                              | 2 +-
 apply.c                               | 2 +-
 builtin/checkout.c                    | 2 +-
 convert.c                             | 2 +-
 diff.c                                | 2 +-
 merge-blobs.c                         | 2 +-
 ll-merge.c => merge-ll.c              | 2 +-
 ll-merge.h => merge-ll.h              | 0
 merge-ort.c                           | 2 +-
 merge-recursive.c                     | 2 +-
 notes-merge.c                         | 2 +-
 rerere.c                              | 2 +-
 13 files changed, 13 insertions(+), 13 deletions(-)
 rename ll-merge.c => merge-ll.c (99%)
 rename ll-merge.h => merge-ll.h (100%)

diff --git a/Documentation/technical/api-merge.txt b/Documentation/technical/api-merge.txt
index 487d4d83fff..c2ba01828c6 100644
--- a/Documentation/technical/api-merge.txt
+++ b/Documentation/technical/api-merge.txt
@@ -28,9 +28,9 @@ and `diff.c` for examples.
 
 * `struct ll_merge_options`
 
-Check ll-merge.h for details.
+Check merge-ll.h for details.
 
 Low-level (single file) merge
 -----------------------------
 
-Check ll-merge.h for details.
+Check merge-ll.h for details.
diff --git a/Makefile b/Makefile
index 2d180abc5ca..045e2187c41 100644
--- a/Makefile
+++ b/Makefile
@@ -1051,7 +1051,6 @@ LIB_OBJS += linear-assignment.o
 LIB_OBJS += list-objects-filter-options.o
 LIB_OBJS += list-objects-filter.o
 LIB_OBJS += list-objects.o
-LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
 LIB_OBJS += ls-refs.o
@@ -1060,6 +1059,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
+LIB_OBJS += merge-ll.o
 LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-ort-wrappers.o
 LIB_OBJS += merge-recursive.o
diff --git a/apply.c b/apply.c
index 801f2bcc99c..2f66f93fec5 100644
--- a/apply.c
+++ b/apply.c
@@ -21,7 +21,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "lockfile.h"
 #include "name-hash.h"
 #include "object-name.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 716dcd4cae1..11e2359c548 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -13,7 +13,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "hook.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "lockfile.h"
 #include "mem-pool.h"
 #include "merge-recursive.h"
diff --git a/convert.c b/convert.c
index 9e89f660308..1f2cfc5f457 100644
--- a/convert.c
+++ b/convert.c
@@ -15,7 +15,7 @@
 #include "sub-process.h"
 #include "trace.h"
 #include "utf8.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "wrapper.h"
 
 /*
diff --git a/diff.c b/diff.c
index 5e81dc0d02d..9d6b88ece90 100644
--- a/diff.c
+++ b/diff.c
@@ -26,7 +26,7 @@
 #include "submodule.h"
 #include "hashmap.h"
 #include "mem-pool.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "string-list.h"
 #include "strvec.h"
 #include "graph.h"
diff --git a/merge-blobs.c b/merge-blobs.c
index 5632ff6abb6..40c48e3eba6 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "run-command.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
 #include "object-store.h"
diff --git a/ll-merge.c b/merge-ll.c
similarity index 99%
rename from ll-merge.c
rename to merge-ll.c
index 1993530688e..c076d048407 100644
--- a/ll-merge.c
+++ b/merge-ll.c
@@ -10,7 +10,7 @@
 #include "attr.h"
 #include "xdiff-interface.h"
 #include "run-command.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "wrapper.h"
diff --git a/ll-merge.h b/merge-ll.h
similarity index 100%
rename from ll-merge.h
rename to merge-ll.h
diff --git a/merge-ort.c b/merge-ort.c
index eed71b04389..f4522951323 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -30,7 +30,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "entry.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "match-trees.h"
 #include "mem-pool.h"
 #include "object-name.h"
diff --git a/merge-recursive.c b/merge-recursive.c
index 527dbbd010a..35e1e7e1bef 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -20,7 +20,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "lockfile.h"
 #include "match-trees.h"
 #include "name-hash.h"
diff --git a/notes-merge.c b/notes-merge.c
index 4b328d852cd..4be11a01550 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -12,7 +12,7 @@
 #include "diffcore.h"
 #include "hex.h"
 #include "xdiff-interface.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "dir.h"
 #include "notes.h"
 #include "notes-merge.h"
diff --git a/rerere.c b/rerere.c
index 35b9785d573..3584fecb07c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -12,7 +12,7 @@
 #include "xdiff-interface.h"
 #include "dir.h"
 #include "resolve-undo.h"
-#include "ll-merge.h"
+#include "merge-ll.h"
 #include "attr.h"
 #include "path.h"
 #include "pathspec.h"
-- 
gitgitgadget

