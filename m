Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 766CC20899
	for <e@80x24.org>; Mon, 21 Aug 2017 00:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753451AbdHUAAt (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Aug 2017 20:00:49 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:57052 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753422AbdHUAAa (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 20 Aug 2017 20:00:30 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E1018280AF
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 00:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1503273629;
        bh=gYVP7aqSdojgacCS5my/L/gRD5oSiUQG+eHB/HtnIZg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bsl2jbdEfIZvNTYcx7tDxPJuyKgCyfn7vtPLWgApdfMmejMtfOueF8gMleRTV0lkL
         CBiUQDFK16eiklHtWkrHjNa8hM5TjeC5Ah4De0ihtqb4YtrRTfB3Ei57tl/sU4pK0l
         tBTtNaTUwfWTQ70chnviNukwK96dE/x/x//0TCPbLpv+UvgATMfnaxNXhij6U3jG8C
         0YcWvVyhh0qjg3ImJ2eS2yVo3lcUlLIu3k+TQcSda6dwsEprhnDLRZuX3W8nofJGQU
         851DZPlNGOZ9y/znNbBLzC/VOq2hdpHsBZeSjCnJl9JKZ6Sah1U1Vqbj+mq43pL2sU
         F4fHyEDhQoPWel1gfivWBJYlS54W8HlD90Hhs5vRea+mPegs5XVUeUTi9rp0kyWezW
         8gqaFu7RnS9tCBxt6h3dBHtgsK3Rb/p3Bye6IoEiSmrHd4zTU68lNRbXKotPk/2bf7
         3dDzXazNXU31xH+UoleEW3nZYTGZeRWH5I5JVhALEHCq8VBMN4H
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: [RFC PATCH 2/6] vcs-svn: rename repo functions to "svn_repo"
Date:   Mon, 21 Aug 2017 00:00:18 +0000
Message-Id: <20170821000022.26729-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.14.1.480.gb18f417b89
In-Reply-To: <20170821000022.26729-1-sandals@crustytoothpaste.net>
References: <20170821000022.26729-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There were several functions in the Subversion code that started with
"repo_".  This namespace is also used by the Git struct repository code.
Rename these functions to start with "svn_repo" to avoid any future
conflicts.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 vcs-svn/repo_tree.c | 6 +++---
 vcs-svn/repo_tree.h | 6 +++---
 vcs-svn/svndump.c   | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 67d27f0b6c..d77cb0ada7 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -8,7 +8,7 @@
 #include "repo_tree.h"
 #include "fast_export.h"
 
-const char *repo_read_path(const char *path, uint32_t *mode_out)
+const char *svn_repo_read_path(const char *path, uint32_t *mode_out)
 {
 	int err;
 	static struct strbuf buf = STRBUF_INIT;
@@ -25,7 +25,7 @@ const char *repo_read_path(const char *path, uint32_t *mode_out)
 	return buf.buf;
 }
 
-void repo_copy(uint32_t revision, const char *src, const char *dst)
+void svn_repo_copy(uint32_t revision, const char *src, const char *dst)
 {
 	int err;
 	uint32_t mode;
@@ -42,7 +42,7 @@ void repo_copy(uint32_t revision, const char *src, const char *dst)
 	fast_export_modify(dst, mode, data.buf);
 }
 
-void repo_delete(const char *path)
+void svn_repo_delete(const char *path)
 {
 	fast_export_delete(path);
 }
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index d0f5690dca..555b64bbb6 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -9,8 +9,8 @@ struct strbuf;
 #define REPO_MODE_LNK 0120000
 
 uint32_t next_blob_mark(void);
-void repo_copy(uint32_t revision, const char *src, const char *dst);
-const char *repo_read_path(const char *path, uint32_t *mode_out);
-void repo_delete(const char *path);
+void svn_repo_copy(uint32_t revision, const char *src, const char *dst);
+const char *svn_repo_read_path(const char *path, uint32_t *mode_out);
+void svn_repo_delete(const char *path);
 
 #endif
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 1846685a21..37c4a36b92 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -225,15 +225,15 @@ static void handle_node(void)
 		if (have_text || have_props || node_ctx.srcRev)
 			die("invalid dump: deletion node has "
 				"copyfrom info, text, or properties");
-		repo_delete(node_ctx.dst.buf);
+		svn_repo_delete(node_ctx.dst.buf);
 		return;
 	}
 	if (node_ctx.action == NODEACT_REPLACE) {
-		repo_delete(node_ctx.dst.buf);
+		svn_repo_delete(node_ctx.dst.buf);
 		node_ctx.action = NODEACT_ADD;
 	}
 	if (node_ctx.srcRev) {
-		repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
+		svn_repo_copy(node_ctx.srcRev, node_ctx.src.buf, node_ctx.dst.buf);
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
@@ -249,7 +249,7 @@ static void handle_node(void)
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
-		old_data = repo_read_path(node_ctx.dst.buf, &mode);
+		old_data = svn_repo_read_path(node_ctx.dst.buf, &mode);
 		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
 			die("invalid dump: cannot modify a directory into a file");
 		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
