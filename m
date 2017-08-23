Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95037208DB
	for <e@80x24.org>; Wed, 23 Aug 2017 00:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbdHWABj (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Aug 2017 20:01:39 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37257 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbdHWABi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2017 20:01:38 -0400
Received: by mail-pg0-f67.google.com with SMTP id 83so188490pgb.4
        for <git@vger.kernel.org>; Tue, 22 Aug 2017 17:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=szQEjyUshwecT+wrktjIyp/XhH2MMjWJjmmFNDYUP9I=;
        b=MVXohOf5GqZEo2yOrwkDV4bbwCCKamIjR5nyGMXSehQXqvt218byB4htb9hXjQLw4U
         mSpqeHpmVMmGORJ4Xmlv7xBHFB7ECWnqa1A8PpatZeo2ug1kMuPweImPFFVEraQsqNEB
         tY4z6NMVKHZyf5xghsUGhOQiX+yeoIRhhm7g04aJ5/4/LITrvXAvNQ8/8q7lB+sT1RHo
         WvkTgQnXCey10ECQgZC9V5wbrvKjmXFlX/8OnjwHntkQIoATxayK56S1qCR0AE3m8fEH
         QMPxOXEUaLaENjDgBEMg4CuHl9ZnjPwVtYKbS5mzghN2nMjeUSzefqj5o5WZLEVGSolc
         NyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=szQEjyUshwecT+wrktjIyp/XhH2MMjWJjmmFNDYUP9I=;
        b=PGD9C7gA43Kms0sC4h0BuJtiTdPSV0N1dsXFfHHKMvw+/gFRW7mr8FIQg0waW/M4fU
         74kCEM7zTpsfE19cO9uqyA4PKy5R/Zn2w+1COiOFaAAuVPt6ShpXJAcM0HV+hbE8DQaM
         r3xZp336+RnN1dVbbJ8bGE6fFYEMxoWJgQWt6I0qjinQBlFVaFauKLyEodVrVpK2uc6s
         bNxH7R9kFFBUKKy67FAJlKXzosMXfbKTGG7zLIY/Ti2OhMVdxXzj6CC+h2HZlFzBWjfg
         ZgLAhZNFJj9M58zdm+oKrbV+TQVCZUv4AcmsLk0ibiLkT8MDU2gBXRRjjlUeuzRUdgcQ
         OiEA==
X-Gm-Message-State: AHYfb5jbH/Hfq5HcpR2B5ECkuoceFDOtmqNXoY5mMGk7bfsUu0X8FI8n
        +Rx3CBjloHTmJsAlELk=
X-Received: by 10.84.174.67 with SMTP id q61mr877345plb.463.1503446497277;
        Tue, 22 Aug 2017 17:01:37 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:dc68:f470:52d1:2c63])
        by smtp.gmail.com with ESMTPSA id k9sm180223pfk.129.2017.08.22.17.01.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 22 Aug 2017 17:01:36 -0700 (PDT)
Date:   Tue, 22 Aug 2017 17:01:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] vcs-svn: remove custom mode constants
Message-ID: <20170823000134.GF13924@aiede.mtv.corp.google.com>
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

In the rest of Git, these modes are spelled as S_IFDIR,
S_IFREG | 0644, S_IFREG | 0755, and S_IFLNK.  Use the same constants
in svn-fe for simplicity and consistency.

No functional change intended.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Unchanged.

 vcs-svn/fast_export.c |  6 +++---
 vcs-svn/repo_tree.c   |  2 +-
 vcs-svn/repo_tree.h   |  5 -----
 vcs-svn/svndump.c     | 24 ++++++++++++------------
 4 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 97cba39cdf..6d133ed6bc 100644
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
index d77cb0ada7..1a6f32d7cb 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -19,7 +19,7 @@ const char *svn_repo_read_path(const char *path, uint32_t *mode_out)
 		if (errno != ENOENT)
 			die_errno("BUG: unexpected fast_export_ls error");
 		/* Treat missing paths as directories. */
-		*mode_out = REPO_MODE_DIR;
+		*mode_out = S_IFDIR;
 		return NULL;
 	}
 	return buf.buf;
diff --git a/vcs-svn/repo_tree.h b/vcs-svn/repo_tree.h
index 0d3bbb677d..c840bc9bae 100644
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
 void svn_repo_copy(uint32_t revision, const char *src, const char *dst);
 const char *svn_repo_read_path(const char *path, uint32_t *mode_out);
 void svn_repo_delete(const char *path);
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 7da84b2aab..c0fa4eb723 100644
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
 		old_data = svn_repo_read_path(node_ctx.dst.buf, &mode);
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

