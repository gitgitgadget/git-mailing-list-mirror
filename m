Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B57208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752752AbdHWAEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:04:51 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36934 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752533AbdHWAEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:04:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id r62so179289pfj.4
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DWIloBo9Jg5/iQEdU8fp5ugv6nWQbmXRrE9L8CePP5w=;
        b=tAysSLr86XciGx3fI27D9zVjhnBYlzRO7OgeQifDJb+BENth0pmKmL/75nEBqb1b79
         VNviJNHfWRQOFBFqgPoDw37T6dx1KLNsJwbAw2HUM05weplIGmGyVeMNkff8Kg5pOGku
         kERGbiACXAIouAbNJwLuzzU1huk4eTBAou9vdGIX4wlN2r1CJKyn+8jBZPZrYn4blNxn
         HjjLGhmA1T8KTj534Po5zGMsjQ+fBEEmeWTKKMl31kp+fvpR+WbbWY/qOoI3nPRpAKQx
         0AHoTmrMS2esgsyFsxJS7G+oPK144ps4axSBoMePp5b9CeaMihO5STjxv3+W9yqb/G1/
         fibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DWIloBo9Jg5/iQEdU8fp5ugv6nWQbmXRrE9L8CePP5w=;
        b=Myf0x9tJ9DZRQQzByv8YKzDou9qF9qdR1M7OpyG5oInsSCL8HNWCvmbyLo7tDXZfNB
         yrQ0pD1MhePuL43Ict+UwAHyqHZ+TFmQ9Ffstfpl+lof8ZC9Iu8Id8Uara3RbAOD5JlY
         8huQhVrEb0vXwDseap3+CJ3LgCZNmSApfbg8uwREe0WF6tfr5i0z1APQtO3ow4LHfU5O
         wNACtaG9XjheyPuPR5LNU4lV26vzQFDbHWdEek6UC/XamBaqjjbD73oifpdUb1a+jYgF
         tvVbf30nDhFCp53llQVKJckSX2cdcEW7wXLl74VKPZ7QR8h/jYVzFdZbjBcP8Ki+80yT
         agOA==
X-Gm-Message-State: AHYfb5jMxBTJ+KKiwwTX9qbm8QnYIGdBIyy4fPUEm+a8I8eFD3lwmick
        u/wToBbit3Nn9EUyero=
X-Received: by 10.84.229.9 with SMTP id b9mr970814plk.216.1503446689889;
        Tue, 22 Aug 2017 17:04:49 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id 74sm204013pfk.58.2017.08.22.17.04.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:04:48 -0700 (PDT)
Date:   Tue, 22 Aug 2017 17:04:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] vcs-svn: move remaining repo_tree functions to
 fast_export.h
Message-ID: <20170823000447.GH13924@aiede.mtv.corp.google.com>
References: <20170822233732.GX13924@aiede.mtv.corp.google.com>
 <20170823000007.GD13924@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823000007.GD13924@aiede.mtv.corp.google.com>
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

This way the function names do not start with a repo_ prefix that
would clash with the repository object introduced in
v2.14.0-rc0~38^2~16 (repository: introduce the repository object,
2017-06-22) or an svn_ prefix that would clash with libsvn (in case
someone wants to link this code with libsvn some day).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The only change is the commit message.  These functions are already
namespaced on the bc/vcs-svn-cleanup, so added a note about that.

That's the end of the series.  Thanks for reading.

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
index 46ad908ec5..9b00d5b219 100644
--- a/Makefile
+++ b/Makefile
@@ -1942,7 +1942,6 @@ XDIFF_OBJS += xdiff/xhistogram.o
 
 VCSSVN_OBJS += vcs-svn/line_buffer.o
 VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/repo_tree.o
 VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 6d133ed6bc..5bd455b8c8 100644
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
index c8b5adb811..ae8ab7e589 100644
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
index 5bd4977cb6..0000000000
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
-const char *svn_repo_read_path(const char *path, uint32_t *mode_out)
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
-void svn_repo_copy(uint32_t revision, const char *src, const char *dst)
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
index 0cd2761183..0000000000
--- a/vcs-svn/repo_tree.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef REPO_TREE_H_
-#define REPO_TREE_H_
-
-void svn_repo_copy(uint32_t revision, const char *src, const char *dst);
-const char *svn_repo_read_path(const char *path, uint32_t *mode_out);
-
-#endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 41113119bd..01b6ded400 100644
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
-		svn_repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
+		fast_export_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
@@ -249,7 +248,7 @@ static void handle_node(void)
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = svn_repo_read_path(node_ctx.dst.buf, &mode);
+		old_data = fast_export_read_path(node_ctx.dst.buf, &mode);
 		if (mode == S_IFDIR && type != S_IFDIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != S_IFDIR && type == S_IFDIR)
-- 
2.14.1.342.g6490525c54

