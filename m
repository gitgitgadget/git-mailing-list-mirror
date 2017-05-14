Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9703820188
	for <e@80x24.org>; Sun, 14 May 2017 03:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758864AbdENDQi (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:38 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33512 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758734AbdENDQa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:30 -0400
Received: by mail-oi0-f65.google.com with SMTP id h4so14344414oib.0
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZbQ+ACbpmdLLjV1Wjfc/DXYinkY/iLEx1ooy042MgvA=;
        b=lnnaEPOT6m4FlkF32egDqwVHFnYsj0oStZn+u0UEL5ncmW/q7Bf3ZODSravHu9oDxD
         +e+vbxYuwEfU7Bf3GY2pIDeuJIoq58SZa+ZFD/bZfFp02Qk2khxMPUTswlNQTvimVG81
         iyVDwZIwFwjHn6C9U//KBbpKUGLxMTZQvm0zISz55xVYFsObZ6WEknvDmNCvlguJZGyg
         y+c6oQUsYy10Guf7NwgzP9xUg5cZPjl41FhmOR013r4E/2cnyJkLJSskxs2Er6xk5sAN
         P6yOnYPWv1X3VkCrfc7CXfomEdui/SMTiWLi1WC4vy7PpurgJhLdn3xRFMtARCyy0gx3
         35Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZbQ+ACbpmdLLjV1Wjfc/DXYinkY/iLEx1ooy042MgvA=;
        b=fMcgGwg8ySQJKSd4u1TJRuOYTKi8wr0o1gIKWivrso2QeD+CLTMBTpcKN8AjRXBBJj
         7homfPLdoUnzTvxU7twzCt2mBtww/kwDnZFyjFmeM77Jx1nZUcQ8Eoy66netHSHKTubD
         Z8YmXHUGXeviXRCYMV+GWrRRnIqXXPumgk04YCKREJHK4RZNKdmY4lpbglxXmUYzOH8i
         xIWiI5zhTclCHckWQANBOI9RCf55IiS9/2RKBEgS8O5mvOhiQTquuGkdVuaCFQvGmPt0
         +lPt7my8UmVRISSPgtxn5yPZ0Xij+vOB+sLC54esOApBwPYwAMZxBApfRjluVtnr19Ze
         whQA==
X-Gm-Message-State: AODbwcCRFBC0sRJ/UTDxCZzMq93VYD3kwPT8sANlmsLoNh/t3UIx4k1o
        2mJxKTrDS1uLEQ==
X-Received: by 10.157.84.26 with SMTP id j26mr5224319oth.193.1494731789155;
        Sat, 13 May 2017 20:16:29 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:28 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 18/22] blame: move fake-commit-related methods to libgit
Date:   Sat, 13 May 2017 22:15:09 -0500
Message-Id: <20170514031513.9042-19-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 203 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 blame.h         |   4 +-
 builtin/blame.c | 197 ------------------------------------------------------
 3 files changed, 205 insertions(+), 199 deletions(-)

diff --git a/blame.c b/blame.c
index 4855d6d..8c025bc 100644
--- a/blame.c
+++ b/blame.c
@@ -1,3 +1,6 @@
+#include "cache.h"
+#include "refs.h"
+#include "cache-tree.h"
 #include "blame.h"
 
 void blame_origin_decref(struct blame_origin *o)
@@ -28,7 +31,7 @@ void blame_origin_decref(struct blame_origin *o)
  * get_origin() to obtain shared, refcounted copy instead of calling
  * this function directly.
  */
-struct blame_origin *make_origin(struct commit *commit, const char *path)
+static struct blame_origin *make_origin(struct commit *commit, const char *path)
 {
 	struct blame_origin *o;
 	FLEX_ALLOC_STR(o, path, path);
@@ -60,3 +63,201 @@ struct blame_origin *get_origin(struct commit *commit, const char *path)
 	}
 	return make_origin(commit, path);
 }
+
+
+
+static void verify_working_tree_path(struct commit *work_tree, const char *path)
+{
+	struct commit_list *parents;
+	int pos;
+
+	for (parents = work_tree->parents; parents; parents = parents->next) {
+		const struct object_id *commit_oid = &parents->item->object.oid;
+		struct object_id blob_oid;
+		unsigned mode;
+
+		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
+		    sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
+			return;
+	}
+
+	pos = cache_name_pos(path, strlen(path));
+	if (pos >= 0)
+		; /* path is in the index */
+	else if (-1 - pos < active_nr &&
+		 !strcmp(active_cache[-1 - pos]->name, path))
+		; /* path is in the index, unmerged */
+	else
+		die("no such path '%s' in HEAD", path);
+}
+
+static struct commit_list **append_parent(struct commit_list **tail, const struct object_id *oid)
+{
+	struct commit *parent;
+
+	parent = lookup_commit_reference(oid->hash);
+	if (!parent)
+		die("no such commit %s", oid_to_hex(oid));
+	return &commit_list_insert(parent, tail)->next;
+}
+
+static void append_merge_parents(struct commit_list **tail)
+{
+	int merge_head;
+	struct strbuf line = STRBUF_INIT;
+
+	merge_head = open(git_path_merge_head(), O_RDONLY);
+	if (merge_head < 0) {
+		if (errno == ENOENT)
+			return;
+		die("cannot open '%s' for reading", git_path_merge_head());
+	}
+
+	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
+		struct object_id oid;
+		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
+			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
+		tail = append_parent(tail, &oid);
+	}
+	close(merge_head);
+	strbuf_release(&line);
+}
+
+/*
+ * This isn't as simple as passing sb->buf and sb->len, because we
+ * want to transfer ownership of the buffer to the commit (so we
+ * must use detach).
+ */
+static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
+{
+	size_t len;
+	void *buf = strbuf_detach(sb, &len);
+	set_commit_buffer(c, buf, len);
+}
+
+/*
+ * Prepare a dummy commit that represents the work tree (or staged) item.
+ * Note that annotating work tree item never works in the reverse.
+ */
+struct commit *fake_working_tree_commit(struct diff_options *opt,
+					const char *path,
+					const char *contents_from)
+{
+	struct commit *commit;
+	struct blame_origin *origin;
+	struct commit_list **parent_tail, *parent;
+	struct object_id head_oid;
+	struct strbuf buf = STRBUF_INIT;
+	const char *ident;
+	time_t now;
+	int size, len;
+	struct cache_entry *ce;
+	unsigned mode;
+	struct strbuf msg = STRBUF_INIT;
+
+	read_cache();
+	time(&now);
+	commit = alloc_commit_node();
+	commit->object.parsed = 1;
+	commit->date = now;
+	parent_tail = &commit->parents;
+
+	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
+		die("no such ref: HEAD");
+
+	parent_tail = append_parent(parent_tail, &head_oid);
+	append_merge_parents(parent_tail);
+	verify_working_tree_path(commit, path);
+
+	origin = make_origin(commit, path);
+
+	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
+	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
+	for (parent = commit->parents; parent; parent = parent->next)
+		strbuf_addf(&msg, "parent %s\n",
+			    oid_to_hex(&parent->item->object.oid));
+	strbuf_addf(&msg,
+		    "author %s\n"
+		    "committer %s\n\n"
+		    "Version of %s from %s\n",
+		    ident, ident, path,
+		    (!contents_from ? path :
+		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
+	set_commit_buffer_from_strbuf(commit, &msg);
+
+	if (!contents_from || strcmp("-", contents_from)) {
+		struct stat st;
+		const char *read_from;
+		char *buf_ptr;
+		unsigned long buf_len;
+
+		if (contents_from) {
+			if (stat(contents_from, &st) < 0)
+				die_errno("Cannot stat '%s'", contents_from);
+			read_from = contents_from;
+		}
+		else {
+			if (lstat(path, &st) < 0)
+				die_errno("Cannot lstat '%s'", path);
+			read_from = path;
+		}
+		mode = canon_mode(st.st_mode);
+
+		switch (st.st_mode & S_IFMT) {
+		case S_IFREG:
+			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
+				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
+			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
+				die_errno("cannot open or read '%s'", read_from);
+			break;
+		case S_IFLNK:
+			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
+				die_errno("cannot readlink '%s'", read_from);
+			break;
+		default:
+			die("unsupported file type %s", read_from);
+		}
+	}
+	else {
+		/* Reading from stdin */
+		mode = 0;
+		if (strbuf_read(&buf, 0, 0) < 0)
+			die_errno("failed to read from stdin");
+	}
+	convert_to_git(path, buf.buf, buf.len, &buf, 0);
+	origin->file.ptr = buf.buf;
+	origin->file.size = buf.len;
+	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
+
+	/*
+	 * Read the current index, replace the path entry with
+	 * origin->blob_sha1 without mucking with its mode or type
+	 * bits; we are not going to write this index out -- we just
+	 * want to run "diff-index --cached".
+	 */
+	discard_cache();
+	read_cache();
+
+	len = strlen(path);
+	if (!mode) {
+		int pos = cache_name_pos(path, len);
+		if (0 <= pos)
+			mode = active_cache[pos]->ce_mode;
+		else
+			/* Let's not bother reading from HEAD tree */
+			mode = S_IFREG | 0644;
+	}
+	size = cache_entry_size(len);
+	ce = xcalloc(1, size);
+	oidcpy(&ce->oid, &origin->blob_oid);
+	memcpy(ce->name, path, len);
+	ce->ce_flags = create_ce_flags(0);
+	ce->ce_namelen = len;
+	ce->ce_mode = create_ce_mode(mode);
+	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+
+	cache_tree_invalidate_path(&the_index, path);
+
+	return commit;
+}
diff --git a/blame.h b/blame.h
index 39f8865..f831dec 100644
--- a/blame.h
+++ b/blame.h
@@ -6,6 +6,7 @@
 #include "xdiff-interface.h"
 #include "revision.h"
 #include "prio-queue.h"
+#include "diff.h"
 
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40
@@ -155,7 +156,8 @@ static inline struct blame_origin *blame_origin_incref(struct blame_origin *o)
 }
 extern void blame_origin_decref(struct blame_origin *o);
 
-extern struct blame_origin *make_origin(struct commit *commit, const char *path);
 extern struct blame_origin *get_origin(struct commit *commit, const char *path);
 
+extern struct commit *fake_working_tree_commit(struct diff_options *opt, const char *path, const char *contents_from);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index b60d604..33ede4f 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -16,7 +16,6 @@
 #include "revision.h"
 #include "quote.h"
 #include "xdiff-interface.h"
-#include "cache-tree.h"
 #include "string-list.h"
 #include "mailmap.h"
 #include "mergesort.h"
@@ -2004,202 +2003,6 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static void verify_working_tree_path(struct commit *work_tree, const char *path)
-{
-	struct commit_list *parents;
-	int pos;
-
-	for (parents = work_tree->parents; parents; parents = parents->next) {
-		const struct object_id *commit_oid = &parents->item->object.oid;
-		struct object_id blob_oid;
-		unsigned mode;
-
-		if (!get_tree_entry(commit_oid->hash, path, blob_oid.hash, &mode) &&
-		    sha1_object_info(blob_oid.hash, NULL) == OBJ_BLOB)
-			return;
-	}
-
-	pos = cache_name_pos(path, strlen(path));
-	if (pos >= 0)
-		; /* path is in the index */
-	else if (-1 - pos < active_nr &&
-		 !strcmp(active_cache[-1 - pos]->name, path))
-		; /* path is in the index, unmerged */
-	else
-		die("no such path '%s' in HEAD", path);
-}
-
-static struct commit_list **append_parent(struct commit_list **tail, const struct object_id *oid)
-{
-	struct commit *parent;
-
-	parent = lookup_commit_reference(oid->hash);
-	if (!parent)
-		die("no such commit %s", oid_to_hex(oid));
-	return &commit_list_insert(parent, tail)->next;
-}
-
-static void append_merge_parents(struct commit_list **tail)
-{
-	int merge_head;
-	struct strbuf line = STRBUF_INIT;
-
-	merge_head = open(git_path_merge_head(), O_RDONLY);
-	if (merge_head < 0) {
-		if (errno == ENOENT)
-			return;
-		die("cannot open '%s' for reading", git_path_merge_head());
-	}
-
-	while (!strbuf_getwholeline_fd(&line, merge_head, '\n')) {
-		struct object_id oid;
-		if (line.len < GIT_SHA1_HEXSZ || get_oid_hex(line.buf, &oid))
-			die("unknown line in '%s': %s", git_path_merge_head(), line.buf);
-		tail = append_parent(tail, &oid);
-	}
-	close(merge_head);
-	strbuf_release(&line);
-}
-
-/*
- * This isn't as simple as passing sb->buf and sb->len, because we
- * want to transfer ownership of the buffer to the commit (so we
- * must use detach).
- */
-static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
-{
-	size_t len;
-	void *buf = strbuf_detach(sb, &len);
-	set_commit_buffer(c, buf, len);
-}
-
-/*
- * Prepare a dummy commit that represents the work tree (or staged) item.
- * Note that annotating work tree item never works in the reverse.
- */
-static struct commit *fake_working_tree_commit(struct diff_options *opt,
-					       const char *path,
-					       const char *contents_from)
-{
-	struct commit *commit;
-	struct blame_origin *origin;
-	struct commit_list **parent_tail, *parent;
-	struct object_id head_oid;
-	struct strbuf buf = STRBUF_INIT;
-	const char *ident;
-	time_t now;
-	int size, len;
-	struct cache_entry *ce;
-	unsigned mode;
-	struct strbuf msg = STRBUF_INIT;
-
-	read_cache();
-	time(&now);
-	commit = alloc_commit_node();
-	commit->object.parsed = 1;
-	commit->date = now;
-	parent_tail = &commit->parents;
-
-	if (!resolve_ref_unsafe("HEAD", RESOLVE_REF_READING, head_oid.hash, NULL))
-		die("no such ref: HEAD");
-
-	parent_tail = append_parent(parent_tail, &head_oid);
-	append_merge_parents(parent_tail);
-	verify_working_tree_path(commit, path);
-
-	origin = make_origin(commit, path);
-
-	ident = fmt_ident("Not Committed Yet", "not.committed.yet", NULL, 0);
-	strbuf_addstr(&msg, "tree 0000000000000000000000000000000000000000\n");
-	for (parent = commit->parents; parent; parent = parent->next)
-		strbuf_addf(&msg, "parent %s\n",
-			    oid_to_hex(&parent->item->object.oid));
-	strbuf_addf(&msg,
-		    "author %s\n"
-		    "committer %s\n\n"
-		    "Version of %s from %s\n",
-		    ident, ident, path,
-		    (!contents_from ? path :
-		     (!strcmp(contents_from, "-") ? "standard input" : contents_from)));
-	set_commit_buffer_from_strbuf(commit, &msg);
-
-	if (!contents_from || strcmp("-", contents_from)) {
-		struct stat st;
-		const char *read_from;
-		char *buf_ptr;
-		unsigned long buf_len;
-
-		if (contents_from) {
-			if (stat(contents_from, &st) < 0)
-				die_errno("Cannot stat '%s'", contents_from);
-			read_from = contents_from;
-		}
-		else {
-			if (lstat(path, &st) < 0)
-				die_errno("Cannot lstat '%s'", path);
-			read_from = path;
-		}
-		mode = canon_mode(st.st_mode);
-
-		switch (st.st_mode & S_IFMT) {
-		case S_IFREG:
-			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
-			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
-				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
-			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
-				die_errno("cannot open or read '%s'", read_from);
-			break;
-		case S_IFLNK:
-			if (strbuf_readlink(&buf, read_from, st.st_size) < 0)
-				die_errno("cannot readlink '%s'", read_from);
-			break;
-		default:
-			die("unsupported file type %s", read_from);
-		}
-	}
-	else {
-		/* Reading from stdin */
-		mode = 0;
-		if (strbuf_read(&buf, 0, 0) < 0)
-			die_errno("failed to read from stdin");
-	}
-	convert_to_git(path, buf.buf, buf.len, &buf, 0);
-	origin->file.ptr = buf.buf;
-	origin->file.size = buf.len;
-	pretend_sha1_file(buf.buf, buf.len, OBJ_BLOB, origin->blob_oid.hash);
-
-	/*
-	 * Read the current index, replace the path entry with
-	 * origin->blob_sha1 without mucking with its mode or type
-	 * bits; we are not going to write this index out -- we just
-	 * want to run "diff-index --cached".
-	 */
-	discard_cache();
-	read_cache();
-
-	len = strlen(path);
-	if (!mode) {
-		int pos = cache_name_pos(path, len);
-		if (0 <= pos)
-			mode = active_cache[pos]->ce_mode;
-		else
-			/* Let's not bother reading from HEAD tree */
-			mode = S_IFREG | 0644;
-	}
-	size = cache_entry_size(len);
-	ce = xcalloc(1, size);
-	oidcpy(&ce->oid, &origin->blob_oid);
-	memcpy(ce->name, path, len);
-	ce->ce_flags = create_ce_flags(0);
-	ce->ce_namelen = len;
-	ce->ce_mode = create_ce_mode(mode);
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
-
-	cache_tree_invalidate_path(&the_index, path);
-
-	return commit;
-}
-
 static struct commit *find_single_final(struct rev_info *revs,
 					const char **name_p)
 {
-- 
2.9.3

