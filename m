Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3EF1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730080AbeHMS6o (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:44 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeHMS6n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:43 -0400
Received: by mail-lj1-f196.google.com with SMTP id f1-v6so13014118ljc.9
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hNIP9ivZu6bMEZaC9ijJJrqbUzBtLqhogu9qd5mVAX8=;
        b=DW5R/YPx6fwtmND5Ohchcq7lzM1WogZquogP+YzLNFlnL/JeZApAdeHn4eAy0NFvUf
         8UPDM6Ey569M8ypak1JC8b7zxw4yX+onljY/AskNS0IbdNP099Q5R4LxnbdPaEQTbfh6
         h5GMvV4dRJeyNKqEyfowZAOkAXrnTFE9NOrnQUnciy8W1CEIFm60nl67AI2MNCb6toZ5
         2237v8ws6h6KvsxhfdGTVp0OOCWwYeujZL2mxrtzeRGQFBhWVZH8X7/XszDxPsHVozSx
         HvTq6c6oi0LKC7VQemk+/C+IViN2nLyr/FXD20CTnqTjUPSEt8Hc1ObyVbO9BrT1RPxj
         Gm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNIP9ivZu6bMEZaC9ijJJrqbUzBtLqhogu9qd5mVAX8=;
        b=A/ALsfNGkFDqL6Zgazas0agAr36nCpXVSp4fBO9VWbReuNlnZBYD5WxjotAQfIGr+z
         HQ5jSYevGBrDI5HMev98SCMULSysCCsB3sfY7dsAbrSHuRZNEuD37G2QZb7vZeti0snP
         gKiss41UZzn8rmJUk0sOBWhPpg76R+c+uNKKX2D5LUrvmYZ+S/i/FxGsiPAHgag0G6mZ
         yi1ubr5icIFd/Z/vXG3SzBP7dIZBzCghpuyZ/tYMBMHis6T6s4FTMpGie0xf/q+j4KPB
         iublyh2qF0GQlJP5340Fz0hSjPFd7Xs+eByTiLwDMWqv2ew6DlSEgBKv41TdY+KnhXyB
         kBfQ==
X-Gm-Message-State: AOUpUlFrAwuDjg6JXZXKuz0kUhDcG37mKXuBZDQ3pLrfqrmq2S9NjEuO
        hd6vvzaGiu2EQl7/uPmpJo52/HAJ
X-Google-Smtp-Source: AA+uWPzEmKZ192AoYMjYxF32PZublJLJ5Gi4j8oted0k2Mbmux4SEqqVZTGB/BJHdIapTN68cTpVeg==
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr13327740ljk.116.1534176947077;
        Mon, 13 Aug 2018 09:15:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 24/24] blame.c: remove implicit dependency on the_index
Date:   Mon, 13 Aug 2018 18:14:41 +0200
Message-Id: <20180813161441.16824-25-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Side note, since we gain access to the right repository, we can stop
rely on the_repository in this code as well.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 blame.c         | 52 +++++++++++++++++++++++++++++--------------------
 blame.h         |  1 +
 builtin/blame.c |  1 +
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/blame.c b/blame.c
index 58a7036847..08c0c6cf73 100644
--- a/blame.c
+++ b/blame.c
@@ -90,7 +90,8 @@ static struct blame_origin *get_origin(struct commit *commit, const char *path)
 
 
 
-static void verify_working_tree_path(struct commit *work_tree, const char *path)
+static void verify_working_tree_path(struct repository *repo,
+				     struct commit *work_tree, const char *path)
 {
 	struct commit_list *parents;
 	int pos;
@@ -101,15 +102,15 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 		unsigned mode;
 
 		if (!get_tree_entry(commit_oid, path, &blob_oid, &mode) &&
-		    oid_object_info(the_repository, &blob_oid, NULL) == OBJ_BLOB)
+		    oid_object_info(repo, &blob_oid, NULL) == OBJ_BLOB)
 			return;
 	}
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(repo->index, path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (-1 - pos < active_nr &&
-		 !strcmp(active_cache[-1 - pos]->name, path))
+	else if (-1 - pos < repo->index->cache_nr &&
+		 !strcmp(repo->index->cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
@@ -165,7 +166,8 @@ static void set_commit_buffer_from_strbuf(struct commit *c, struct strbuf *sb)
  * Prepare a dummy commit that represents the work tree (or staged) item.
  * Note that annotating work tree item never works in the reverse.
  */
-static struct commit *fake_working_tree_commit(struct diff_options *opt,
+static struct commit *fake_working_tree_commit(struct repository *repo,
+					       struct diff_options *opt,
 					       const char *path,
 					       const char *contents_from)
 {
@@ -181,7 +183,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_cache();
+	read_index(repo->index);
 	time(&now);
 	commit = alloc_commit_node(the_repository);
 	commit->object.parsed = 1;
@@ -193,7 +195,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 	parent_tail = append_parent(parent_tail, &head_oid);
 	append_merge_parents(parent_tail);
-	verify_working_tree_path(commit, path);
+	verify_working_tree_path(repo, commit, path);
 
 	origin = make_origin(commit, path);
 
@@ -251,7 +253,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		if (strbuf_read(&buf, 0, 0) < 0)
 			die_errno("failed to read from stdin");
 	}
-	convert_to_git(&the_index, path, buf.buf, buf.len, &buf, 0);
+	convert_to_git(repo->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
 	pretend_object_file(buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
@@ -262,27 +264,28 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 * bits; we are not going to write this index out -- we just
 	 * want to run "diff-index --cached".
 	 */
-	discard_cache();
-	read_cache();
+	discard_index(repo->index);
+	read_index(repo->index);
 
 	len = strlen(path);
 	if (!mode) {
-		int pos = cache_name_pos(path, len);
+		int pos = index_name_pos(repo->index, path, len);
 		if (0 <= pos)
-			mode = active_cache[pos]->ce_mode;
+			mode = repo->index->cache[pos]->ce_mode;
 		else
 			/* Let's not bother reading from HEAD tree */
 			mode = S_IFREG | 0644;
 	}
-	ce = make_empty_cache_entry(&the_index, len);
+	ce = make_empty_cache_entry(repo->index, len);
 	oidcpy(&ce->oid, &origin->blob_oid);
 	memcpy(ce->name, path, len);
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(repo->index, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 
-	cache_tree_invalidate_path(&the_index, path);
+	cache_tree_invalidate_path(repo->index, path);
 
 	return commit;
 }
@@ -519,13 +522,14 @@ static void queue_blames(struct blame_scoreboard *sb, struct blame_origin *porig
  *
  * This also fills origin->mode for corresponding tree path.
  */
-static int fill_blob_sha1_and_mode(struct blame_origin *origin)
+static int fill_blob_sha1_and_mode(struct repository *repo,
+				   struct blame_origin *origin)
 {
 	if (!is_null_oid(&origin->blob_oid))
 		return 0;
 	if (get_tree_entry(&origin->commit->object.oid, origin->path, &origin->blob_oid, &origin->mode))
 		goto error_out;
-	if (oid_object_info(the_repository, &origin->blob_oid, NULL) != OBJ_BLOB)
+	if (oid_object_info(repo, &origin->blob_oid, NULL) != OBJ_BLOB)
 		goto error_out;
 	return 0;
  error_out:
@@ -1767,7 +1771,9 @@ void init_scoreboard(struct blame_scoreboard *sb)
 	sb->copy_score = BLAME_DEFAULT_COPY_SCORE;
 }
 
-void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig)
+void setup_scoreboard(struct blame_scoreboard *sb,
+		      const char *path,
+		      struct blame_origin **orig)
 {
 	const char *final_commit_name = NULL;
 	struct blame_origin *o;
@@ -1779,6 +1785,9 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	if (sb->reverse && sb->contents_from)
 		die(_("--contents and --reverse do not blend well."));
 
+	if (!sb->repo)
+		BUG("repo is NULL");
+
 	if (!sb->reverse) {
 		sb->final = find_single_final(sb->revs, &final_commit_name);
 		sb->commits.compare = compare_commits_by_commit_date;
@@ -1800,7 +1809,8 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 		 * or "--contents".
 		 */
 		setup_work_tree();
-		sb->final = fake_working_tree_commit(&sb->revs->diffopt,
+		sb->final = fake_working_tree_commit(sb->repo,
+						     &sb->revs->diffopt,
 						     path, sb->contents_from);
 		add_pending_object(sb->revs, &(sb->final->object), ":");
 	}
@@ -1845,7 +1855,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	}
 	else {
 		o = get_origin(sb->final, path);
-		if (fill_blob_sha1_and_mode(o))
+		if (fill_blob_sha1_and_mode(sb->repo, o))
 			die(_("no such path %s in %s"), path, final_commit_name);
 
 		if (sb->revs->diffopt.flags.allow_textconv &&
diff --git a/blame.h b/blame.h
index 9b5240fb6d..be3a895043 100644
--- a/blame.h
+++ b/blame.h
@@ -102,6 +102,7 @@ struct blame_scoreboard {
 	struct commit *final;
 	/* Priority queue for commits with unassigned blame records */
 	struct prio_queue commits;
+	struct repository *repo;
 	struct rev_info *revs;
 	const char *path;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 5c93d169dd..cbbcb26f89 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -988,6 +988,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	sb.revs = &revs;
 	sb.contents_from = contents_from;
 	sb.reverse = reverse;
+	sb.repo = the_repository;
 	setup_scoreboard(&sb, path, &o);
 	lno = sb.num_lines;
 
-- 
2.18.0.1004.g6639190530

