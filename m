Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DDF81F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbdHVXmV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:42:21 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38500 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752556AbdHVXmU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:42:20 -0400
Received: by mail-pg0-f68.google.com with SMTP id t3so160860pgt.5
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZmS01CwIiQiJfWOqRlvsJob6QzvlVpIxhQ34MnrpdxE=;
        b=s61AW8COT/8PqYc6TjJHJ495xBKkDuKBKBq8G227hM9ZmBOPLQQ7QhCwwwhLfIBAB0
         6qGQRCEmYhjAvrAk4qNldVEpARC0mOxQ/4oBq44gAz3Cm/ulvgZLE96DeC1+lgp36yvN
         sMnb1wfndZWOjJNckdUZc06fTFvAcblj0JgM/3ivDl+ziQRwZFYA83u0d6/2wzEnTjd7
         Y4XZZ0gnIxmb1UYhK3xc6C5mdkV35SyiUad5qK/9aZmV9yPI+YN3R/O711939s+rvkHW
         lpowZzWedsDVfYHX/jSG0CesHzKE1eKwBa+foIdrdOb/AUTgtffV+Gqhw6ZLJcerqj+0
         WaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZmS01CwIiQiJfWOqRlvsJob6QzvlVpIxhQ34MnrpdxE=;
        b=FRj1ywXzt2iAwklAPhkH2UNa3J0nakthXoGGqufOCJnMWQ31uwyYeKE561Ji+TqzKo
         7TAUoq3O5zwhBw3kGQXH1mrBXhTy2nyUp1Ntl9aQAfH40Lu3RsR+xfKZarBUeCmS3HVi
         eTYqnMtVEoD1jimOlFqt5tjoEZ9erSqfhF+M7uNVB3oF7gU66MfDWPQcUbLRbBbdEWNk
         xnVUWzq2CgXPWaW7dalcZ/qRSueffCs0UJL34BCLaTmWu/kzDN55t27AThQ+Gzgu9Yn4
         kKOvUqA9q7FcHK5iIxVtUmIBljh64FJipot+YKcT8s1gKRV1gz6fZsM7khb2Qf5Gd2KF
         GZvQ==
X-Gm-Message-State: AHYfb5gNcXKKZJbNhHxbt7/SsiiwumW30P4iSoLeXpeehekkUBzjqDKd
        /Xuy+eB8H+5d3M6Wung=
X-Received: by 10.98.59.193 with SMTP id w62mr758822pfj.335.1503445338924;
        Tue, 22 Aug 2017 16:42:18 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id k81sm147442pfb.152.2017.08.22.16.42.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:42:18 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:42:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] vcs-svn: move remaining repo_tree functions to
 fast_export.h
Message-ID: <20170822234216.GB13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170822233732.GX13924@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These used to be for manipulating the in-memory repo_tree structure,
but nowadays they are convenience wrappers to handle a few git-vs-svn
mismatches:

 1. Git does not track empty directories but Subversion does.  When
    looking up a path in git that Subversion thinks exists and finding
    nothing, we can safely assume that the path represents a
    directory.  This is needed when a later Subversion revision
    modifies that directory.

 2. Subversion allows deleting a file by copying.  In Git fast-import
    we have to handle that more explicitly as a deletion.

These are details of the tool's interaction with git fast-import.
Move them to fast_export.c, where other such details are handled.

This way the functions do not start with a repo_ prefix that would
clash with the repository object introduced in v2.14.0-rc0~38^2~16
(repository: introduce the repository object, 2017-06-22).

Reported-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile              |  1 -
 vcs-svn/fast_export.c | 35 ++++++++++++++++++++++++++++++++++-
 vcs-svn/fast_export.h |  3 +++
 vcs-svn/repo_tree.c   | 43 -------------------------------------------
 vcs-svn/repo_tree.h   |  7 -------
 vcs-svn/svndump.c     |  5 ++---
 6 files changed, 39 insertions(+), 55 deletions(-)
 delete mode 100644 vcs-svn/repo_tree.c
 delete mode 100644 vcs-svn/repo_tree.h

diff --git a/Makefile b/Makefile
index 86ec29202b..493b8f5d2d 100644
--- a/Makefile
+++ b/Makefile
@@ -2038,7 +2038,6 @@ XDIFF_OBJS += xdiff/xhistogram.o
 
 VCSSVN_OBJS += vcs-svn/line_buffer.o
 VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/repo_tree.o
 VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 7790f8e1d1..3fd047a8b8 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -6,7 +6,6 @@
 #include "cache.h"
 #include "quote.h"
 #include "fast_export.h"
-#include "repo_tree.h"
 #include "strbuf.h"
 #include "svndiff.h"
 #include "sliding_window.h"
@@ -312,6 +311,40 @@ int fast_export_ls(const char *path, uint32_t *mode, struct strbuf *dataref)
 	return parse_ls_response(get_response_line(), mode, dataref);
 }
 
+const char *fast_export_read_path(const char *path, uint32_t *mode_out)
+{
+	int err;
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	err = fast_export_ls(path, mode_out, &buf);
+	if (err) {
+		if (errno != ENOENT)
+			die_errno("BUG: unexpected fast_export_ls error");
+		/* Treat missing paths as directories. */
+		*mode_out = S_IFDIR;
+		return NULL;
+	}
+	return buf.buf;
+}
+
+void fast_export_copy(uint32_t revision, const char *src, const char *dst)
+{
+	int err;
+	uint32_t mode;
+	static struct strbuf data = STRBUF_INIT;
+
+	strbuf_reset(&data);
+	err = fast_export_ls_rev(revision, src, &mode, &data);
+	if (err) {
+		if (errno != ENOENT)
+			die_errno("BUG: unexpected fast_export_ls_rev error");
+		fast_export_delete(dst);
+		return;
+	}
+	fast_export_modify(dst, mode, data.buf);
+}
+
 void fast_export_blob_delta(uint32_t mode,
 				uint32_t old_mode, const char *old_data,
 				off_t len, struct line_buffer *input)
diff --git a/vcs-svn/fast_export.h b/vcs-svn/fast_export.h
index b9a3b71c99..60b79c35b9 100644
--- a/vcs-svn/fast_export.h
+++ b/vcs-svn/fast_export.h
@@ -28,4 +28,7 @@ int fast_export_ls_rev(uint32_t rev, const char *path,
 int fast_export_ls(const char *path,
 			uint32_t *mode_out, struct strbuf *dataref_out);
 
+void fast_export_copy(uint32_t revision, const char *src, const char *dst);
+const char *fast_export_read_path(const char *path, uint32_t *mode_out);
+
 #endif
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
deleted file mode 100644
index 99747e373a..0000000000
--- a/vcs-svn/repo_tree.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Licensed under a two-clause BSD-style license.
- * See LICENSE for details.
- */
-
-#include "git-compat-util.h"
-#include "strbuf.h"
-#include "repo_tree.h"
-#include "fast_export.h"
-
-const char *repo_read_path(const char *path, uint32_t *mode_out)
-{
-	int err;
-	static struct strbuf buf = STRBUF_INIT;
-
-	strbuf_reset(&buf);
-	err = fast_export_ls(path, mode_out, &buf);
-	if (err) {
-		if (errno != ENOENT)
-			die_errno("BUG: unexpected fast_export_ls error");
-		/* Treat missing paths as directories. */
-		*mode_out = S_IFDIR;
-		return NULL;
-	}
-	return buf.buf;
-}
-
-void repo_copy(uint32_t revision, const char *src, const char *dst)
-{
-	int err;
-	uint32_t mode;
-	static struct strbuf data = STRBUF_INIT;
-
-	strbuf_reset(&data);
-	err = fast_export_ls_rev(revision, src, &mode, &data);
-	if (err) {
-		if (errno != ENOENT)
-			die_errno("BUG: unexpected fast_export_ls_rev error");
-		fast_export_delete(dst);
-		return;
-	}
-	fast_export_modify(dst, mode, data.buf);
-}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
deleted file mode 100644
index 56a3209d01..0000000000
--- a/vcs-svn/repo_tree.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef REPO_TREE_H_
-#define REPO_TREE_H_
-
-void repo_copy(uint32_t revision, const char *src, const char *dst);
-const char *repo_read_path(const char *path, uint32_t *mode_out);
-
-#endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index d51136fac5..ec6b350611 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -8,7 +8,6 @@
  */
 
 #include "cache.h"
-#include "repo_tree.h"
 #include "fast_export.h"
 #include "line_buffer.h"
 #include "strbuf.h"
@@ -233,7 +232,7 @@ static void handle_node(void)
 		node_ctx.action = NODEACT_ADD;
 	}
 	if (node_ctx.srcRev) {
-		repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
+		fast_export_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
@@ -249,7 +248,7 @@ static void handle_node(void)
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst.buf, &mode);
+		old_data = fast_export_read_path(node_ctx.dst.buf, &mode);
 		if (mode == S_IFDIR && type != S_IFDIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != S_IFDIR && type == S_IFDIR)
-- 
2.14.1.342.g6490525c54

