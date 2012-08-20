From: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
Subject: [RFC 4/4] vcs-svn: remove repo_tree
Date: Mon, 20 Aug 2012 23:57:57 +0200
Message-ID: <1345499877-16024-5-git-send-email-florian.achleitner.2.6.31@gmail.com>
References: <1345499877-16024-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499877-16024-2-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499877-16024-3-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1345499877-16024-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 23:58:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3ZzV-0003JM-UC
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 23:58:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab2HTV6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 17:58:24 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59688 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab2HTV6V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 17:58:21 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so5691690wgb.1
        for <git@vger.kernel.org>; Mon, 20 Aug 2012 14:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wqI6UPkijMU+lmvqa6RCcicfrGI6vEpe/bVPpLnyZPs=;
        b=x7YSA+xnCdzmUQO7w6JMfvrNW34QP7wK0JE4GuAbAx6WPdkk9uipCyVqT4WWogIe5N
         448q7GV62zIIqc9oFDAnueJGlbO7dr3/K7PkRuic2Qq0hnRVHWI1vwHO6UNPHARfIHPs
         g8KXqSN5UPKBgJxgkdDha6jTk+AUImjqeK4PTXpSbDNqoJvFjU+qohsJqXjHiC3GqVxq
         B/AFhek9rJnWOmZ8tGOYWLDDOd/3AxSk0Ys1xasISYPTzARHiDeMYVd0mux2xu/8buU9
         6fTL65JsM7Qx+QbIZKbY66cvbhfc0Lg+1YBUx4yI4H3ZyqExpzt/zgp6LQkEvk67CamE
         FV9Q==
Received: by 10.216.133.200 with SMTP id q50mr7209252wei.166.1345499900714;
        Mon, 20 Aug 2012 14:58:20 -0700 (PDT)
Received: from flomedio.lan (91-115-90-54.adsl.highway.telekom.at. [91.115.90.54])
        by mx.google.com with ESMTPS id o2sm44859731wiz.11.2012.08.20.14.58.19
        (version=SSLv3 cipher=OTHER);
        Mon, 20 Aug 2012 14:58:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1345499877-16024-4-git-send-email-florian.achleitner.2.6.31@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203897>

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
index fb5cdcf..4e14903 100644
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
