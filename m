Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF003C636D7
	for <git@archiver.kernel.org>; Thu, 23 Feb 2023 08:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjBWIFl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Feb 2023 03:05:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjBWIFa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2023 03:05:30 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CAA34C2D
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:27 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p26so7816921wmc.4
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 00:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QwkNxqQ1aAfiwPys3A2H/JpmCw/ma/puEdHmDE3g0c=;
        b=SaSod6TRyPAg/wBmSFVJAaJyxdr3Eu2hppHrFZjLCIBRguqYQjFceIrg3NVC6hQwO5
         UdWcR9dnFTXlNOQpA3IUNy8Tgg+bUcayXqwnLOFaEr9a4C/Ybdgy00HpdHzgX8wDWcsH
         /LJ32rBvaNqbfc0yE/HdlYcDOi8xjtIhwRc1tVfa7CnUwM4SooDx38jQoUU0bTUsruIa
         soozKKOWJeA6707zYvLV0vK8yX+cVLPwTwOSBu+JcSLVLtb1zw5Fakt5BpVR2l5ufNMJ
         PfMkUfrFdZk24KkxgAfb2+OBOvIH5JtVF3xm+BtoYnoJD7gu31bO/GEAAtTK+mmhKu+N
         puaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8QwkNxqQ1aAfiwPys3A2H/JpmCw/ma/puEdHmDE3g0c=;
        b=i/YisDDEFyySs/i29nB4A+lRuW43SKS6u6YP7oT64e02rnFn4Q2TXDiZIPmZb4I4dO
         +QFxvVnhhgAyRFgPxkr6QScY/kFoRS3cKwh1SS7JcpxY9qm9iixW/jxqj00hUlo/k07z
         gCBA2mfPLDFNwIbYVgxTe9IgJRMyCODlhpsNSgZ6ifWv46D80MQw1xkivY0AsCuAkKSY
         hHvWH+3ITQCSCed7mkTVypaIhCLqcdWf/YFBcMd+5vEQg+1RllANkQtAZRQ7e9cnHSzv
         ySRFFrqBXV1d4MQ6GuDlvlp0PsqQErVwgXOd5JUdkKzm63DUgq0npuwc+4y1LhsBYYNt
         2ZwQ==
X-Gm-Message-State: AO0yUKXXyBa7RAtg9UOAjqyQJDFNlR1r6esB/Dlz/glS29sZWDwnscfq
        9lpNvhqxXCOC3GXAOGmX6m0j30xIc+4=
X-Google-Smtp-Source: AK7set9xE/jzJwvtS9d7PmKNkyp0xdBuVR3fSSHUCuxBVKIiiqF1+p9bqWGpdFU3HGfMVvvqqkLDZw==
X-Received: by 2002:a05:600c:b97:b0:3e2:22f9:c4b9 with SMTP id fl23-20020a05600c0b9700b003e222f9c4b9mr10122464wmb.4.1677139525852;
        Thu, 23 Feb 2023 00:05:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16-20020adfefd0000000b002c552c6c8c2sm7163775wrp.87.2023.02.23.00.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 00:05:25 -0800 (PST)
Message-Id: <73d012f631a8a5f93ab0c016a759f03d92a9c96d.1677139521.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
References: <pull.1485.git.1677139521.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Feb 2023 08:05:08 +0000
Subject: [PATCH 03/16] treewide: remove unnecessary cache.h includes
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

We had several header files include cache.h unnecessarily.  Remove
those.  These have all been verified via both ensuring that
    gcc -E $HEADER | grep '"cache.h"'
found no hits and that
    cat >temp.c <<EOF &&
    #include "git-compat-util.h"
    #include "$HEADER"
    int main() {}
    EOF
    gcc -c temp.c
successfully compiles without warnings.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 checkout.h           | 2 +-
 entry.h              | 4 +++-
 khash.h              | 1 -
 oidmap.h             | 1 -
 pretty.h             | 2 +-
 reflog-walk.h        | 2 --
 refs/refs-internal.h | 1 -
 remote.h             | 1 -
 sequencer.h          | 2 +-
 xdiff-interface.h    | 2 +-
 10 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/checkout.h b/checkout.h
index 1152133bd77..1917f3b3230 100644
--- a/checkout.h
+++ b/checkout.h
@@ -1,7 +1,7 @@
 #ifndef CHECKOUT_H
 #define CHECKOUT_H
 
-#include "cache.h"
+#include "hash.h"
 
 /*
  * Check if the branch name uniquely matches a branch name on a remote
diff --git a/entry.h b/entry.h
index 2d4fbb88c8f..7329f918a97 100644
--- a/entry.h
+++ b/entry.h
@@ -1,9 +1,11 @@
 #ifndef ENTRY_H
 #define ENTRY_H
 
-#include "cache.h"
 #include "convert.h"
 
+struct cache_entry;
+struct index_state;
+
 struct checkout {
 	struct index_state *istate;
 	const char *base_dir;
diff --git a/khash.h b/khash.h
index cb79bf88567..85362718c56 100644
--- a/khash.h
+++ b/khash.h
@@ -26,7 +26,6 @@
 #ifndef __AC_KHASH_H
 #define __AC_KHASH_H
 
-#include "cache.h"
 #include "hashmap.h"
 
 #define AC_VERSION_KHASH_H "0.2.8"
diff --git a/oidmap.h b/oidmap.h
index c66a83ab1d6..c1642927fa6 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -1,7 +1,6 @@
 #ifndef OIDMAP_H
 #define OIDMAP_H
 
-#include "cache.h"
 #include "hashmap.h"
 
 /*
diff --git a/pretty.h b/pretty.h
index f34e24c53a4..9508c22f030 100644
--- a/pretty.h
+++ b/pretty.h
@@ -1,11 +1,11 @@
 #ifndef PRETTY_H
 #define PRETTY_H
 
-#include "cache.h"
 #include "date.h"
 #include "string-list.h"
 
 struct commit;
+struct repository;
 struct strbuf;
 struct process_trailer_options;
 
diff --git a/reflog-walk.h b/reflog-walk.h
index 8076f10d9fb..4d93a269571 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -1,8 +1,6 @@
 #ifndef REFLOG_WALK_H
 #define REFLOG_WALK_H
 
-#include "cache.h"
-
 struct commit;
 struct reflog_walk_info;
 struct date_mode;
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index 69f93b0e2ac..a85d113123c 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -1,7 +1,6 @@
 #ifndef REFS_REFS_INTERNAL_H
 #define REFS_REFS_INTERNAL_H
 
-#include "cache.h"
 #include "refs.h"
 #include "iterator.h"
 
diff --git a/remote.h b/remote.h
index 1ebbe42792e..5b38ee20b84 100644
--- a/remote.h
+++ b/remote.h
@@ -1,7 +1,6 @@
 #ifndef REMOTE_H
 #define REMOTE_H
 
-#include "cache.h"
 #include "parse-options.h"
 #include "hashmap.h"
 #include "refspec.h"
diff --git a/sequencer.h b/sequencer.h
index 3bcdfa1b586..33dbaf5b66d 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -1,11 +1,11 @@
 #ifndef SEQUENCER_H
 #define SEQUENCER_H
 
-#include "cache.h"
 #include "strbuf.h"
 #include "wt-status.h"
 
 struct commit;
+struct index_state;
 struct repository;
 
 const char *git_path_commit_editmsg(void);
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 4301a7eef27..3750794afe9 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -1,7 +1,7 @@
 #ifndef XDIFF_INTERFACE_H
 #define XDIFF_INTERFACE_H
 
-#include "cache.h"
+#include "hash.h"
 #include "xdiff/xdiff.h"
 
 /*
-- 
gitgitgadget

