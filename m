Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8383C7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 16:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjCSQ12 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjCSQ1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 12:27:24 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA341B552
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id w11so4999951wmo.2
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679243241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvHGDGnKYwDe86ABHYb2rTQDp/whpO63UJhW/nG/WuM=;
        b=G4DAr/DDP1d04rnZrcepMoblxUFHky5tZDlcF4k5obLX+mstd3mBhrnUKJdQAqHpca
         pKrrF2LHFQI69zejCnulMMIDn8k0BgFRFMYMH2Z3Qw04SCa/2igqwHZK5fYUXKe1qTVr
         Sibcu9+cBEWJUYCGOBQcbO8XOe6osJ1yTbH4Vh6yy1f+4ER4+pFn6dinowRjbJlczNKB
         OL6+eASlWBTbP3W86190AElep9w6dWp7qSwfni+/l5xBFPV4+QE5dS2+++zrE/e+hGXz
         yF8PJhKwepZRhBd3mnbTVGLBVu6TVafDOpOYHi+wCuS/RVH955MaVPuwfcWcRi+srFT8
         L67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679243241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvHGDGnKYwDe86ABHYb2rTQDp/whpO63UJhW/nG/WuM=;
        b=5oKngV4tNMa0kvJD3M0A/5hsoYSWoW5U139fwtEMahi49SK3aSb85W4ziZDvQR0kme
         w0l56wc/yYR96a4jySyYxzV+FymOvZ1rCej2sI56HZUDmZdpK/M+UXLqjM2KCoRNbxsJ
         8O12hCIR+BS/R7pSD/fajbuRe9q8PxDVRctEuLzwk1ZynIb/py/OFErnzZIFDbv+HwC0
         9asGVmlHJj/wpv1OXEtpU9jOSjf2Ghp14VTqV+6ANOuvuykGqBwEeEMfwCZfbh42I7/s
         e4B9WxmAcCtyw59l+8QZhLUyd0NvUjrwIpQ+b96TqfMqDrfxulcJ8MJHJwVtt/2TU0mD
         cEMA==
X-Gm-Message-State: AO0yUKX3iUI4LNPhecLoDZVD696bZ2KV30Usvz3UAo4D5HDBmPgs9t2q
        6CC5jIW25w71us4DnvNmap5WIdNP1go=
X-Google-Smtp-Source: AK7set/ylwNbkuSN0zX4UtOUGKJoHcpzPIWDwdrooj/7nbl+yBoRdI4aibC6fOzqB4TS3kALOXBW/A==
X-Received: by 2002:a05:600c:1f0f:b0:3df:ef18:b0a1 with SMTP id bd15-20020a05600c1f0f00b003dfef18b0a1mr31176842wmb.12.1679243240709;
        Sun, 19 Mar 2023 09:27:20 -0700 (PDT)
Received: from localhost (62-165-236-170.pool.digikabel.hu. [62.165.236.170])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b003ebff290a52sm14397836wmo.28.2023.03.19.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 09:27:20 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 1/2] treewide: include parse-options.h in source files
Date:   Sun, 19 Mar 2023 17:27:11 +0100
Message-Id: <20230319162712.654137-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.40.0.499.g88fa0b00d2
In-Reply-To: <20230319162712.654137-1-szeder.dev@gmail.com>
References: <20230319162712.654137-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtins 'ls-remote', 'pack-objects', 'receive-pack', 'reflog' and
'send-pack' use parse_options(), but their source files don't directly
include 'parse-options.h'.  Furthermore, the source files
'diagnose.c', 'list-objects-filter-options.c', 'remote.c' and
'send-pack.c' define option parsing callback functions, while
'revision.c' defines an option parsing helper function, and thus need
access to various fields in 'struct option' and 'struct
parse_opt_ctx_t', but they don't directly include 'parse-options.h'
either.  They all can still be built, of course, because they include
one of the header files that does include 'parse-options.h' (though
unnecessarily, see the next commit).

Add those missing includes to these files, as our general rule is that
"a C file must directly include the header files that declare the
functions and the types it uses".

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 builtin/ls-remote.c           | 1 +
 builtin/pack-objects.c        | 1 +
 builtin/receive-pack.c        | 1 +
 builtin/reflog.c              | 1 +
 builtin/send-pack.c           | 1 +
 diagnose.c                    | 1 +
 list-objects-filter-options.c | 1 +
 remote.c                      | 1 +
 revision.c                    | 1 +
 send-pack.c                   | 1 +
 10 files changed, 10 insertions(+)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 2dfbd8ed9b..a9de0575ce 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,6 +5,7 @@
 #include "ref-filter.h"
 #include "remote.h"
 #include "refs.h"
+#include "parse-options.h"
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 545b8bddc8..7e9e20172a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -39,6 +39,7 @@
 #include "shallow.h"
 #include "promisor-remote.h"
 #include "pack-mtimes.h"
+#include "parse-options.h"
 
 /*
  * Objects we are going to pack are collected in the `to_pack` structure.
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index fe68c79ee3..fcc87595ac 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@
 #include "commit-reach.h"
 #include "worktree.h"
 #include "shallow.h"
+#include "parse-options.h"
 
 static const char * const receive_pack_usage[] = {
 	N_("git receive-pack <git-dir>"),
diff --git a/builtin/reflog.c b/builtin/reflog.c
index 270681dcdf..9b000bb6bc 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -4,6 +4,7 @@
 #include "reachable.h"
 #include "worktree.h"
 #include "reflog.h"
+#include "parse-options.h"
 
 #define BUILTIN_REFLOG_SHOW_USAGE \
 	N_("git reflog [show] [<log-options>] [<ref>]")
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index fb5b2bad2c..42a04ed6fc 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -16,6 +16,7 @@
 #include "gpg-interface.h"
 #include "gettext.h"
 #include "protocol.h"
+#include "parse-options.h"
 
 static const char * const send_pack_usage[] = {
 	N_("git send-pack [--mirror] [--dry-run] [--force]\n"
diff --git a/diagnose.c b/diagnose.c
index 5b398f0cff..998f517c48 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -8,6 +8,7 @@
 #include "strvec.h"
 #include "object-store.h"
 #include "packfile.h"
+#include "parse-options.h"
 
 struct archive_dir {
 	const char *path;
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 1d25a5737d..72aeb089cc 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -11,6 +11,7 @@
 #include "promisor-remote.h"
 #include "trace.h"
 #include "url.h"
+#include "parse-options.h"
 
 static int parse_combine_filter(
 	struct list_objects_filter_options *filter_options,
diff --git a/remote.c b/remote.c
index b04e5da338..641b083d90 100644
--- a/remote.c
+++ b/remote.c
@@ -17,6 +17,7 @@
 #include "commit-reach.h"
 #include "advice.h"
 #include "connect.h"
+#include "parse-options.h"
 
 enum map_direction { FROM_SRC, FROM_DST };
 
diff --git a/revision.c b/revision.c
index e4c066e90b..8b1ecf07fc 100644
--- a/revision.c
+++ b/revision.c
@@ -37,6 +37,7 @@
 #include "json-writer.h"
 #include "list-objects-filter-options.h"
 #include "resolve-undo.h"
+#include "parse-options.h"
 
 volatile show_early_output_fn_t show_early_output;
 
diff --git a/send-pack.c b/send-pack.c
index 423a5cfe22..0d05191162 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -17,6 +17,7 @@
 #include "gpg-interface.h"
 #include "cache.h"
 #include "shallow.h"
+#include "parse-options.h"
 
 int option_parse_push_signed(const struct option *opt,
 			     const char *arg, int unset)
-- 
2.40.0.499.g88fa0b00d2

