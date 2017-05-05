Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0D8207D6
	for <e@80x24.org>; Fri,  5 May 2017 05:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755213AbdEEF1t (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 01:27:49 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33866 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755165AbdEEF1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 01:27:47 -0400
Received: by mail-io0-f195.google.com with SMTP id 12so2185904iol.1
        for <git@vger.kernel.org>; Thu, 04 May 2017 22:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=We6QcuYGFklv7F1B9x+f85LW/vXZz3s2u6dhRuBIJo4=;
        b=YSbuBgNOy9H1GXDFzezN3UbDBFI+Xuh9Dwdi1hHorYYCaloH3sNXO7dRxEVcR6Z1BU
         XIOFl4bBWqJ83paczS+jA1ZfGvzWzGI4Mf2cjLgLQYx9KP7rMo8GLHbFMl/yYyxnxD7t
         MGul4pvIzpYzdbRY7cHVrgb3ciHzw7pshJtWuE/R2O4IkMdLcJfVoZzVZ1VLnub04h1h
         fDdYDvYNrVa+7p6eh9ndyikPulC6KXNfSAnU0VRM7ScW16SVI8HnHWx5sTxcxtfmVc4T
         lEYA1BuxQUB+J+PJSVs1mi0jY8fTcxi4iPvUoT8FFIPpK0ZXx+dxCbTHi/kepcbKruwr
         Qdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=We6QcuYGFklv7F1B9x+f85LW/vXZz3s2u6dhRuBIJo4=;
        b=YQzmRc1tGC2/n2tPTpGoCfyp/OutMJHcTwQO+xWvwDJM3blugKazWBcJFwOExnxaQ5
         ibj5W5/DBQakE4Zbp5L7UoLozM6Z8n4P9GGTdP3G7fXzw9nnYPUV5VyBndUS1Ofx8Gar
         faf6019YyJsuSn48gyMb+vEqK6f0KpiPLdrdvprbgiw6QzWUVksuDd1qsMQXz7rLDorZ
         ht4nkPQKvKSCLSPdSXkcuIihZkhGpoXLWw6Z7BpvBGI5JOd5uwyY0aURsOGOQfDDcF05
         66zZrFD8qwgdJXPwZWk1b0bEufTUB0kdqM5OOBkXjJJXPObpWCc10273pxzBWXtR2v8/
         LheQ==
X-Gm-Message-State: AN3rC/6GGVsO55kUBAAV8bRHj29Ull3QcGKQ1UN52ZyqHq4392k541Hk
        69fvnhAKSgPmuQ==
X-Received: by 10.202.62.196 with SMTP id l187mr15145533oia.132.1493962061614;
        Thu, 04 May 2017 22:27:41 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 2sm2179586ota.46.2017.05.04.22.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 22:27:40 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH 06/10] Move fake_working_tree_commit() to lib
Date:   Fri,  5 May 2017 00:27:25 -0500
Message-Id: <20170505052729.7576-7-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170505052729.7576-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 Makefile        |   1 +
 builtin/blame.c | 198 +------------------------------------------------------
 commit-fake.c   | 200 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 commit-fake.h   |   9 +++
 4 files changed, 211 insertions(+), 197 deletions(-)
 create mode 100644 commit-fake.c
 create mode 100644 commit-fake.h

diff --git a/Makefile b/Makefile
index 8cbb56c..b197a37 100644
--- a/Makefile
+++ b/Makefile
@@ -727,6 +727,7 @@ LIB_OBJS += color.o
 LIB_OBJS += column.o
 LIB_OBJS += combine-diff.o
 LIB_OBJS += commit.o
+LIB_OBJS += commit-fake.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += config.o
diff --git a/builtin/blame.c b/builtin/blame.c
index 7ee84c1..c873cc2 100644
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
@@ -29,6 +28,7 @@
 #include "dir.h"
 #include "progress.h"
 #include "origin.h"
+#include "commit-fake.h"
 
 static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] <file>");
 
@@ -2044,202 +2044,6 @@ static int git_blame_config(const char *var, const char *value, void *cb)
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
-	struct origin *origin;
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
diff --git a/commit-fake.c b/commit-fake.c
new file mode 100644
index 0000000..d73e0d8
--- /dev/null
+++ b/commit-fake.c
@@ -0,0 +1,200 @@
+#include "refs.h"
+#include "cache-tree.h"
+#include "origin.h"
+#include "commit-fake.h"
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
+	struct origin *origin;
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
diff --git a/commit-fake.h b/commit-fake.h
new file mode 100644
index 0000000..8232714
--- /dev/null
+++ b/commit-fake.h
@@ -0,0 +1,9 @@
+#ifndef COMMIT_FAKE_H
+#define COMMIT_FAKE_H
+
+#include "commit.h"
+#include "diff.h"
+
+struct commit *fake_working_tree_commit(struct diff_options *opt, const char *path, const char *contents_from);
+
+#endif /* COMMIT_FAKE_H */
-- 
2.9.3

