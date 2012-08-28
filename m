From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC v2 4/4] vcs-svn: remove repo_tree
Date: Tue, 28 Aug 2012 11:15:04 +0200
Message-ID: <1346145304-27149-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1346145304-27149-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346145304-27149-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346145304-27149-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1346145304-27149-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 28 11:15:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6Htj-0003Ak-FP
	for gcvg-git-2@plane.gmane.org; Tue, 28 Aug 2012 11:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab2H1JPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Aug 2012 05:15:30 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:34395 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab2H1JP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Aug 2012 05:15:29 -0400
Received: by mail-bk0-f46.google.com with SMTP id j10so1542990bkw.19
        for <git@vger.kernel.org>; Tue, 28 Aug 2012 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=83odgeuQj43sobuC0B1O3QNKhYVgXDA5ImmgqmQgOak=;
        b=Nnwn/Od3sdvfsv9kTdKy9MgCbcmVndZkhfLiCNCG+vH71iF6MeWfyr2xW93C+FNC6v
         7+QPksfcS1Dtu3+xXH3YBgx9KRfDEE9dKagAzHlakYhyv4MiWzlnV8IjjAieAVtWfrAZ
         pcqNcGLFbYkFFhRx2diQ9ANKwh1yONietTGkRk0b1Q2kYHGJt5Bk0bcnNHbdZbwK5nq+
         Be3mMyfqc8OV3spVuu17nYqjiwoNoPbA/nG2l2D2ofMzNS7RF9rh6nMDSxltclyoFNJc
         QLl3gJ8ecpHVzq8K/Vsiv7MWfi9nDA6Rmewaae+NBMSisqTyQ9+dgrEoFaQwZs1Qjqw2
         JmpA==
Received: by 10.204.136.205 with SMTP id s13mr4617121bkt.22.1346145328501;
        Tue, 28 Aug 2012 02:15:28 -0700 (PDT)
Received: from flobuntu.lan (91-115-85-203.adsl.highway.telekom.at. [91.115.85.203])
        by mx.google.com with ESMTPS id c18sm12120186bkv.8.2012.08.28.02.15.25
        (version=SSLv3 cipher=OTHER);
        Tue, 28 Aug 2012 02:15:26 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1346145304-27149-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204423>

Rewritten svndump.c left only very little functionality in repo_tree.c
which could easily be inlined. Let's remove it.

Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile            |    1 -
 vcs-svn/repo_tree.c |   48 ------------------------------------------------
 vcs-svn/repo_tree.h |   14 --------------
 3 files changed, 63 deletions(-)
 delete mode 100644 vcs-svn/repo_tree.c

diff --git a/Makefile b/Makefile
index 1b09454..5f72a65 100644
--- a/Makefile
+++ b/Makefile
@@ -2188,7 +2188,6 @@ XDIFF_OBJS += xdiff/xhistogram.o
 
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
