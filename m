Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373BF1F667
	for <e@80x24.org>; Tue, 22 Aug 2017 23:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbdHVXjj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 19:39:39 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:37541 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbdHVXji (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 19:39:38 -0400
Received: by mail-pg0-f65.google.com with SMTP id 83so158375pgb.4
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 16:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fmjbAXFEqBfZpNEPhAKQZw2CEFjxs2tSduVm/IajOL0=;
        b=BcGm9yJSzYPWd6Q7J+F60HIbxCju/jzdAH+aSEvRZU23QPHeC4y44lZ1Mp9730K4me
         nUSHyDtAeOSrWceT+nxFWQx8AxszWdTquf6q8OXuSGvgDFZO6POQpJg4+aO4+syWD8ms
         Dqpfna1qMPpLc1Ivz1iHYTgDyad50sgAqOh0URy42u8Z5pIQJ1nhwT+k8TrdlOIBeYkG
         YbwGc6I0VtY6YYGt9YklIn0SY4FElt/TVPyknxTjEbrTKhADzC0ZxKFvpF4IkprYyAQ1
         ZHbNMj51Ikd7nxiYm+sZKqL8gi/Ol9zprBhOvDgV+IQ73sgzD126Z2Xkhevp4pTNlTDq
         oaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fmjbAXFEqBfZpNEPhAKQZw2CEFjxs2tSduVm/IajOL0=;
        b=Q39qqlAZRBUTyQL9Kl6cCU2K0queokp88vUgm9U04Pi+Fchcr8usTDdzdh0alozEV5
         rHzAKPsDT/enVZmkRps6w4oZQDW6DQLENVZ8HkofAYBRaeoMwS/ulLGFmeW88YVtB6rz
         0jzj4hJIRj3cvYtgmAzqIa/9GOyhwiP/ty+wcfu3svk6+FKOyTC2hv6lbQruq8+TSDMb
         elZto+u11PVur/TWg9zt9ngSIuAWY3KyACOHHFqhbGmMQ7cdTzit5RUFTt+cZJ8Zq/Zl
         FK5V2JZx0QUyxfcuq09Zi6T4pANKT73H04ANpdCi8dEyjzYw1oD1Z2q94ICSUUBaSOwk
         5dBw==
X-Gm-Message-State: AHYfb5gfbuzH+5qTqKOKgHSFV3seCw2jiOmRkzYIzZ3Swj1/d/Fp6PyH
        FNVkPO2iBnxljUEk9tM=
X-Received: by 10.99.97.149 with SMTP id v143mr779068pgb.215.1503445177371;
        Tue, 22 Aug 2017 16:39:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id t123sm158370pfb.73.2017.08.22.16.39.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 16:39:36 -0700 (PDT)
Date:   Tue, 22 Aug 2017 16:39:35 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] vcs-svn: remove custom mode constants
Message-ID: <20170822233935.GZ13924@aiede.mtv.corp.google.com>
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

In the rest of Git, these modes are spelled as S_IFDIR,
S_IFREG | 0644, S_IFREG | 0755, and S_IFLNK.  Use the same constants
in svn-fe for simplicity and consistency.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |  6 +++---
 vcs-svn/repo_tree.c   |  2 +-
 vcs-svn/repo_tree.h   |  5 -----
 vcs-svn/svndump.c     | 24 ++++++++++++------------
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 5a89db30e3..7790f8e1d1 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -210,7 +210,7 @@ static long apply_delta(off_t len, struct line_buffer *input,
 			die("invalid cat-blob response: %s", response);
 		check_preimage_overflow(preimage.max_off, 1);
 	}
-	if (old_mode == REPO_MODE_LNK) {
+	if (old_mode == S_IFLNK) {
 		strbuf_addstr(&preimage.buf, "link ");
 		check_preimage_overflow(preimage.max_off, strlen("link "));
 		preimage.max_off += strlen("link ");
@@ -244,7 +244,7 @@ void fast_export_buf_to_data(const struct strbuf *data)
 void fast_export_data(uint32_t mode, off_t len, struct line_buffer *input)
 {
 	assert(len >= 0);
-	if (mode == REPO_MODE_LNK) {
+	if (mode == S_IFLNK) {
 		/* svn symlink blobs start with "link " */
 		if (len < 5)
 			die("invalid dump: symlink too short for \"link\" prefix");
@@ -320,7 +320,7 @@ void fast_export_blob_delta(uint32_t mode,
 
 	assert(len >= 0);
 	postimage_len = apply_delta(len, input, old_data, old_mode);
-	if (mode == REPO_MODE_LNK) {
+	if (mode == S_IFLNK) {
 		buffer_skip_bytes(&postimage, strlen("link "));
 		postimage_len -= strlen("link ");
 	}
diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 67d27f0b6c..9107f9663d 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -19,7 +19,7 @@ const char *repo_read_path(const char *path, uint32_t *mode_out)
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
 		/* Treat missing paths as directories. */
-		*mode_out = REPO_MODE_DIR;
+		*mode_out = S_IFDIR;
 		return NULL;
 	}
 	return buf.buf;
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 6c2f5f8a00..7f59fd9148 100644
--- a/vcs-svn/repo_tree.h
+++ b/vcs-svn/repo_tree.h
@@ -1,11 +1,6 @@
 #ifndef REPO_TREE_H_
 #define REPO_TREE_H_
 
-#define REPO_MODE_DIR 0040000
-#define REPO_MODE_BLB 0100644
-#define REPO_MODE_EXE 0100755
-#define REPO_MODE_LNK 0120000
-
 void repo_copy(uint32_t revision, const char *src, const char *dst);
 const char *repo_read_path(const char *path, uint32_t *mode_out);
 void repo_delete(const char *path);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 1846685a21..dc42ae3316 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -134,13 +134,13 @@ static void handle_property(const struct strbuf *key_buf,
 			die("invalid dump: sets type twice");
 		}
 		if (!val) {
-			node_ctx.type = REPO_MODE_BLB;
+			node_ctx.type = S_IFREG | 0644;
 			return;
 		}
 		*type_set = 1;
 		node_ctx.type = keylen == strlen("svn:executable") ?
-				REPO_MODE_EXE :
-				REPO_MODE_LNK;
+				(S_IFREG | 0755) :
+				S_IFLNK;
 	}
 }
 
@@ -219,7 +219,7 @@ static void handle_node(void)
 	 */
 	static const char *const empty_blob = "::empty::";
 	const char *old_data = NULL;
-	uint32_t old_mode = REPO_MODE_BLB;
+	uint32_t old_mode = S_IFREG | 0644;
 
 	if (node_ctx.action == NODEACT_DELETE) {
 		if (have_text || have_props || node_ctx.srcRev)
@@ -237,27 +237,27 @@ static void handle_node(void)
 		if (node_ctx.action == NODEACT_ADD)
 			node_ctx.action = NODEACT_CHANGE;
 	}
-	if (have_text && type == REPO_MODE_DIR)
+	if (have_text && type == S_IFDIR)
 		die("invalid dump: directories cannot have text attached");
 
 	/*
 	 * Find old content (old_data) and decide on the new mode.
 	 */
 	if (node_ctx.action == NODEACT_CHANGE && !*node_ctx.dst.buf) {
-		if (type != REPO_MODE_DIR)
+		if (type != S_IFDIR)
 			die("invalid dump: root of tree is not a regular file");
 		old_data = NULL;
 	} else if (node_ctx.action == NODEACT_CHANGE) {
 		uint32_t mode;
 		old_data = repo_read_path(node_ctx.dst.buf, &mode);
-		if (mode == REPO_MODE_DIR && type != REPO_MODE_DIR)
+		if (mode == S_IFDIR && type != S_IFDIR)
 			die("invalid dump: cannot modify a directory into a file");
-		if (mode != REPO_MODE_DIR && type == REPO_MODE_DIR)
+		if (mode != S_IFDIR && type == S_IFDIR)
 			die("invalid dump: cannot modify a file into a directory");
 		node_ctx.type = mode;
 		old_mode = mode;
 	} else if (node_ctx.action == NODEACT_ADD) {
-		if (type == REPO_MODE_DIR)
+		if (type == S_IFDIR)
 			old_data = NULL;
 		else if (have_text)
 			old_data = empty_blob;
@@ -280,7 +280,7 @@ static void handle_node(void)
 	/*
 	 * Save the result.
 	 */
-	if (type == REPO_MODE_DIR)	/* directories are not tracked. */
+	if (type == S_IFDIR)	/* directories are not tracked. */
 		return;
 	assert(old_data);
 	if (old_data == empty_blob)
@@ -385,9 +385,9 @@ void svndump_read(const char *url, const char *local_ref, const char *notes_ref)
 				continue;
 			strbuf_addf(&rev_ctx.note, "%s\n", t);
 			if (!strcmp(val, "dir"))
-				node_ctx.type = REPO_MODE_DIR;
+				node_ctx.type = S_IFDIR;
 			else if (!strcmp(val, "file"))
-				node_ctx.type = REPO_MODE_BLB;
+				node_ctx.type = S_IFREG | 0644;
 			else
 				fprintf(stderr, "Unknown node-kind: %s\n", val);
 			break;
-- 
2.14.1.342.g6490525c54

