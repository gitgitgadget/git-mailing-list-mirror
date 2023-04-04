Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A398C76196
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 01:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbjDDBYF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 21:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjDDBXT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 21:23:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57FDE3AB8
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 18:22:51 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so20870263wmq.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680571369;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fK+r8mnA24uK6iRPH+kij2kFJOKntNx89h8MnE5IZI=;
        b=eYXu5SUzheJCpuAIis7aM7y6rXMj3qz0gfRx8mEBIdOt495CvbwmA6ozwBqRaRsuXe
         HAWqWuWZnebu6087na6/Zo4V4vnkCo8mapeE2zTBomzQltDjI4yhkgvyjz4hZiHxVJm3
         4byFhjllqW16fIGdNFbOU9EoF19vjmb7ZjcDCaX7WkaVscrwPRybw5GRUkHMR4JVD22X
         TOkQF3ejrDwCNR+0iBYt62e5QBtS8tyZRcfdbz5fCUHylp2s+xJT228c68aZ68LNa/QN
         LJmq9hmg6GzxFOd/fnUL1EMnYhC3KVN7PD5wx586OkdwEeapQffCulqkBnaHT/WHNpDB
         KPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571369;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3fK+r8mnA24uK6iRPH+kij2kFJOKntNx89h8MnE5IZI=;
        b=z53ynbzQuzDYLlyUMHZ+fnxVtKZNijN0x0rrwmG0TcLALcq5ijcQRkcqpusepdDiSZ
         EWQ36G63wmpZRo5fJW2xTrSMTTNRmFxP+2+7EZMw8XxMhjxlEZz+6K2aH1D0CIIC6mDh
         r8SRzKYAwuxnVTljK86eq96iS1nkmrZEtTUMZxIZ+A6Fb8Gh2wok/ayAKjtcHujZdVQR
         2zBCkDeUluo7FCvaix02GfpdGbc711Gb8XRq5SXXgCmw2RHdrb8uab9hsfANzNturdDu
         n2X81k4kJRQE+4N3gvi/eFZtAjPNHrw5/zz7fLNMTAGT0HoAa8kNtxoCcgpa98ZYhb8Q
         7t8g==
X-Gm-Message-State: AAQBX9cq+WeTTqB5itv1O1t/JBf1rJSYkKoWeAcAeWs7L5qQ/LGqAwIk
        3uFteJNLlOLxFzm81xOPWR2WgQ0U0mw=
X-Google-Smtp-Source: AKy350YIxZQJFDm2bX/yB8lCJg1XZT33Xwg76qDK/saNZBinn/rVr8NpmvKd1yBDLSFVEKlr4jblpA==
X-Received: by 2002:a7b:c7d6:0:b0:3df:eecc:de2b with SMTP id z22-20020a7bc7d6000000b003dfeeccde2bmr833020wmk.11.1680571369718;
        Mon, 03 Apr 2023 18:22:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g25-20020a7bc4d9000000b003eae73f0fc1sm13433078wmk.18.2023.04.03.18.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:22:49 -0700 (PDT)
Message-Id: <538d95833a279e1693ab590fb9bb43f72fe97b2b.1680571352.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
References: <pull.1509.git.1680361837.gitgitgadget@gmail.com>
        <pull.1509.v2.git.1680571348.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 04 Apr 2023 01:22:27 +0000
Subject: [PATCH v2 23/24] treewide: reduce includes of cache.h in other
 headers
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

We had a handful of headers including cache.h that didn't need to
anymore.  Drop those includes and replace them with includes of
smaller files, or forward declarations.  However, note that two .c
files now need to directly include cache.h, though they should have
been including it all along given they are directly using structs
defined in it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 archive.h        | 2 +-
 chdir-notify.c   | 3 ++-
 quote.c          | 3 ++-
 refs/ref-cache.h | 2 +-
 rerere.c         | 2 +-
 resolve-undo.h   | 7 ++++++-
 revision.c       | 2 +-
 split-index.h    | 2 +-
 8 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/archive.h b/archive.h
index f96839ef383..3a4bdfbd078 100644
--- a/archive.h
+++ b/archive.h
@@ -1,9 +1,9 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "cache.h"
 #include "object-name.h"
 #include "pathspec.h"
+#include "string-list.h"
 
 struct repository;
 struct pretty_print_context;
diff --git a/chdir-notify.c b/chdir-notify.c
index 8e38cd6f3ae..0d7bc046074 100644
--- a/chdir-notify.c
+++ b/chdir-notify.c
@@ -1,7 +1,8 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "list.h"
+#include "path.h"
 #include "strbuf.h"
 #include "trace.h"
 
diff --git a/quote.c b/quote.c
index 7ccb5a06cd1..43c739671ed 100644
--- a/quote.c
+++ b/quote.c
@@ -1,5 +1,6 @@
-#include "cache.h"
+#include "git-compat-util.h"
 #include "alloc.h"
+#include "path.h"
 #include "quote.h"
 #include "strbuf.h"
 #include "strvec.h"
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 850d9d3744e..cf4ad9070b9 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -1,7 +1,7 @@
 #ifndef REFS_REF_CACHE_H
 #define REFS_REF_CACHE_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct ref_dir;
 struct ref_store;
diff --git a/rerere.c b/rerere.c
index 093c0f6f993..7abc94bf444 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "abspath.h"
 #include "alloc.h"
 #include "config.h"
diff --git a/resolve-undo.h b/resolve-undo.h
index 2b3f0f901e6..d1ea9727712 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -1,7 +1,12 @@
 #ifndef RESOLVE_UNDO_H
 #define RESOLVE_UNDO_H
 
-#include "cache.h"
+struct cache_entry;
+struct index_state;
+struct pathspec;
+struct string_list;
+
+#include "hash.h"
 
 struct resolve_undo_info {
 	unsigned int mode[3];
diff --git a/revision.c b/revision.c
index 3d86e07abb8..43f88eaf56c 100644
--- a/revision.c
+++ b/revision.c
@@ -1,4 +1,4 @@
-#include "git-compat-util.h"
+#include "cache.h"
 #include "alloc.h"
 #include "config.h"
 #include "environment.h"
diff --git a/split-index.h b/split-index.h
index 7a435ca2c97..1a153f47ba3 100644
--- a/split-index.h
+++ b/split-index.h
@@ -1,7 +1,7 @@
 #ifndef SPLIT_INDEX_H
 #define SPLIT_INDEX_H
 
-#include "cache.h"
+#include "hash.h"
 
 struct index_state;
 struct strbuf;
-- 
gitgitgadget

