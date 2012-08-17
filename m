From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 5/5] vcs-svn: remove repo_tree
Date: Fri, 17 Aug 2012 22:40:10 +0200
Message-ID: <1345236010-1648-6-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345236010-1648-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345236010-1648-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 22:41:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2TLw-0006qS-Us
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 22:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513Ab2HQUlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 16:41:04 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:63674 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932474Ab2HQUke (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 16:40:34 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so2693950wey.19
        for <git@vger.kernel.org>; Fri, 17 Aug 2012 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NvAsXP2frhH1E9LM0WT2Jx99bUYIGQ9Lj3W4t2WZTqk=;
        b=RLNQw8mVXzd3o3v0YxAmWi+4vfpiYgX3Nj9DoF98Xp4zKRWbGofEVlhP4LuDtjj2f7
         w6l2N/nn/RArfrONVFjAGxBEkWBYgFYnWT482Y89G0eeMsYsHE5qIK97vaZ4t2NnHFEg
         STaWOplx359BnBoqw6QIVesX/G1o0jJyRdRLOLrndcLUdYID3dgd05jOEVL1UUOADnsG
         The7I6QePJrSEss2WZmItn+/s8enm5kOxHGXhW+7n6Y0YYj9gR++iZ99yV37faedUbCY
         RueXyMmf1D6RciZCcKpPrdormxXuGADkdxbWdfjzqS6uXOWp+qtCaolA0WGaVVbvggUs
         QGZg==
Received: by 10.216.42.65 with SMTP id i43mr3206297web.208.1345236033762;
        Fri, 17 Aug 2012 13:40:33 -0700 (PDT)
Received: from flobuntu.lan (91-115-81-15.adsl.highway.telekom.at. [91.115.81.15])
        by mx.google.com with ESMTPS id b7sm17480686wiz.9.2012.08.17.13.40.31
        (version=SSLv3 cipher=OTHER);
        Fri, 17 Aug 2012 13:40:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345236010-1648-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203663>

Rewritten svndump.c left only very little functionlity in repo_tree.c
which could easily be inlined. Let's remove it.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
---
 Makefile            |    1 -
 vcs-svn/repo_tree.c |   48 ------------------------------------------------
 vcs-svn/repo_tree.h |   14 --------------
 3 files changed, 63 deletions(-)
 delete mode 100644 vcs-svn/repo_tree.c

diff --git a/Makefile b/Makefile
index 6b0c961..aea877d 100644
--- a/Makefile
+++ b/Makefile
@@ -2187,7 +2187,6 @@ XDIFF_OBJS += xdiff/xhistogram.o
 
 VCSSVN_OBJS += vcs-svn/line_buffer.o
 VCSSVN_OBJS += vcs-svn/sliding_window.o
-VCSSVN_OBJS += vcs-svn/repo_tree.o
 VCSSVN_OBJS += vcs-svn/fast_export.o
 VCSSVN_OBJS += vcs-svn/svndiff.o
 VCSSVN_OBJS += vcs-svn/svndump.o
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
deleted file mode 100644
index 67d27f0..0000000
--- a/vcs-svn/repo_tree.c
+++ /dev/null
@@ -1,48 +0,0 @@
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
-		*mode_out = REPO_MODE_DIR;
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
-
-void repo_delete(const char *path)
-{
-	fast_export_delete(path);
-}
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 889c6a3..6d0f51e 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -1,23 +1,9 @@
 #ifndef REPO_TREE_H_
 #define REPO_TREE_H_
 
-struct strbuf;
-
 #define REPO_MODE_DIR 0040000
 #define REPO_MODE_BLB 0100644
 #define REPO_MODE_EXE 0100755
 #define REPO_MODE_LNK 0120000
 
-uint32_t next_blob_mark(void);
-void repo_copy(uint32_t revision, const char *src, const char *dst);
-void repo_add(const char *path, uint32_t mode, uint32_t blob_mark);
-const char *repo_read_path(const char *path, uint32_t *mode_out);
-void repo_delete(const char *path);
-void repo_commit(uint32_t revision, const char *author,
-		const struct strbuf *log, const char *uuid, const char *url,
-		long unsigned timestamp);
-void repo_diff(uint32_t r1, uint32_t r2);
-void repo_init(void);
-void repo_reset(void);
-
 #endif
-- 
1.7.9.5
