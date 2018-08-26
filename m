Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7C81F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbeHZNpl (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:41 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42924 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHZNpk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:40 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so9706516lff.9
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kz8m2YJY4ezm65T5jF9jynW0AWhB1wBtcgsaZf8Sg34=;
        b=K7/SbMSZCnYrkLSYgG79tK8wzPACAx0gSIKC+LTgPtTFcvQWHvSMRWM36wwpAuSHQm
         zWb3ZJXXtPVerVb5VJ/QCZLzgkIeyspxLxTwhLRw6Rcn2s6tN87Jug4SIhip6EZ50l3V
         Z2PueQ3TVdOAfahYld4VZ7UU8pJWMWphA5k/hxaermoUTudG/CON/GmFHrejuuST4B9V
         gTBQRX80pLDHwCKFPl4lVsBANzYFU3egfXet32E1SZMCF3dnD6vl8HaD67N52BqA3Nzc
         FljAVeFmdk46vN8kundgJJ/lMt8esYFs/ipD36SSHwqYiVu8u7pD8KMsMmkpuqkHOavO
         i2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kz8m2YJY4ezm65T5jF9jynW0AWhB1wBtcgsaZf8Sg34=;
        b=akDnqXHJM8xDYJBXKYKOZeW+bE2bN6bY1I0DkSvOm/vrSLIz9Rv6abPi0cDXQgky/r
         pm8XMLb8cKRFvZ3mYTS0MRUp+B4gLZBMIcxqSU8WEHJG8nGKx0vbsh2/XjIHuxYH2Ny1
         32sNm8iwnLDnjD3u7cDoO9Ml3c7Wg5h5BzGq99cpXyABtg+gF6YAbqCxdKTB8yjeWXxb
         I/ooFNQWQr3/3kOMrXQ/EQPqYU0hK/fw0OgWSYin/lNtzWSSfEzbAVNNAnrdIwaQHGeu
         wn/V6XJ5iqW3FXjnN5vn1zFNejmcHtE89mYjo7WSnNf27IfZMl2LwoOuQMqVvgu1clj3
         1rNA==
X-Gm-Message-State: APzg51AmNqtF4g7eUfPBw2g5pr7ch+lM9UF3oSRIBkdcOply5aW+qrp5
        04w+rANTPhnGXS3qrLl9bpT8iXKj
X-Google-Smtp-Source: ANB0VdaLGhvvMJY82O6UP5evrBJEnl6Qqz1dkcdxkID3oxryizbAVZ3IP8jqpWIYERV0UHF73XWThg==
X-Received: by 2002:a19:5517:: with SMTP id n23-v6mr5871506lfe.101.1535277811617;
        Sun, 26 Aug 2018 03:03:31 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:30 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/21] rerere.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:07 +0200
Message-Id: <20180826100314.5137-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reason rerere(), rerere_forget() and rerere_remaining() take a
struct repository instead of struct index_state is not obvious from
the patch:

deep in update_paths() and find_conflict(), hold_locked_index() and
read_index() are called. These functions assumes the index path at
$GIT_DIR/index which is not always true when you take an arbitrary
index state. Taking a repository will allow us to point to the right
index path later when we replace them with repo_ versions.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c          |   2 +-
 builtin/am.c     |   4 +-
 builtin/commit.c |   2 +-
 builtin/merge.c  |   2 +-
 builtin/rerere.c |   6 +--
 rerere.c         | 119 +++++++++++++++++++++++++----------------------
 rerere.h         |   9 ++--
 sequencer.c      |   4 +-
 8 files changed, 79 insertions(+), 69 deletions(-)

diff --git a/apply.c b/apply.c
index ea111ab13f..d80b3547c2 100644
--- a/apply.c
+++ b/apply.c
@@ -4630,7 +4630,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 		}
 		string_list_clear(&cpath, 0);
 
-		rerere(0);
+		rerere(state->repo, 0);
 	}
 
 	return errs;
diff --git a/builtin/am.c b/builtin/am.c
index 9f7ecf6ecb..9b2a2dd0ea 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1603,7 +1603,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		o.verbosity = 0;
 
 	if (merge_recursive_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
-		rerere(state->allow_rerere_autoupdate);
+		rerere(the_repository, state->allow_rerere_autoupdate);
 		free(their_tree_name);
 		return error(_("Failed to merge in the changes."));
 	}
@@ -1898,7 +1898,7 @@ static void am_resolve(struct am_state *state)
 			goto next;
 	}
 
-	rerere(0);
+	rerere(the_repository, 0);
 
 	do_commit(state);
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..731e98fd63 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1651,7 +1651,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		      "new_index file. Check that disk is not full and quota is\n"
 		      "not exceeded, and then \"git reset HEAD\" to recover."));
 
-	rerere(0);
+	rerere(the_repository, 0);
 	run_command_v_opt(argv_gc_auto, RUN_GIT_CMD);
 	run_commit_hook(use_editor, get_index_file(), "post-commit", NULL);
 	if (amend && !no_post_rewrite) {
diff --git a/builtin/merge.c b/builtin/merge.c
index a56754db5c..432dcbe4cd 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -899,7 +899,7 @@ static int suggest_conflicts(void)
 	fputs(msgbuf.buf, fp);
 	strbuf_release(&msgbuf);
 	fclose(fp);
-	rerere(allow_rerere_auto);
+	rerere(the_repository, allow_rerere_auto);
 	printf(_("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n"));
 	return 1;
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 0bc40298c2..d1fc472d13 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -70,7 +70,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return rerere(flags);
+		return rerere(the_repository, flags);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
@@ -78,7 +78,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 			warning("'git rerere forget' without paths is deprecated");
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
-		return rerere_forget(&pathspec);
+		return rerere_forget(the_repository, &pathspec);
 	}
 
 	if (!strcmp(argv[0], "clear")) {
@@ -91,7 +91,7 @@ int cmd_rerere(int argc, const char **argv, const char *prefix)
 		for (i = 0; i < merge_rr.nr; i++)
 			printf("%s\n", merge_rr.items[i].string);
 	} else if (!strcmp(argv[0], "remaining")) {
-		rerere_remaining(&merge_rr);
+		rerere_remaining(the_repository, &merge_rr);
 		for (i = 0; i < merge_rr.nr; i++) {
 			if (merge_rr.items[i].util != RERERE_RESOLVED)
 				printf("%s\n", merge_rr.items[i].string);
diff --git a/rerere.c b/rerere.c
index e65d8fc06f..4c5b343450 100644
--- a/rerere.c
+++ b/rerere.c
@@ -474,11 +474,12 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
  * Scan the path for conflicts, do the "handle_path()" thing above, and
  * return the number of conflict hunks found.
  */
-static int handle_file(const char *path, unsigned char *sha1, const char *output)
+static int handle_file(struct index_state *istate, const char *path,
+		       unsigned char *sha1, const char *output)
 {
 	int hunk_no = 0;
 	struct rerere_io_file io;
-	int marker_size = ll_merge_marker_size(&the_index, path);
+	int marker_size = ll_merge_marker_size(istate, path);
 
 	memset(&io, 0, sizeof(io));
 	io.io.getline = rerere_file_getline;
@@ -523,9 +524,9 @@ static int handle_file(const char *path, unsigned char *sha1, const char *output
  * stages we have already looked at in this invocation of this
  * function.
  */
-static int check_one_conflict(int i, int *type)
+static int check_one_conflict(struct index_state *istate, int i, int *type)
 {
-	const struct cache_entry *e = active_cache[i];
+	const struct cache_entry *e = istate->cache[i];
 
 	if (!ce_stage(e)) {
 		*type = RESOLVED;
@@ -533,13 +534,13 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	*type = PUNTED;
-	while (ce_stage(active_cache[i]) == 1)
+	while (ce_stage(istate->cache[i]) == 1)
 		i++;
 
 	/* Only handle regular files with both stages #2 and #3 */
-	if (i + 1 < active_nr) {
-		const struct cache_entry *e2 = active_cache[i];
-		const struct cache_entry *e3 = active_cache[i + 1];
+	if (i + 1 < istate->cache_nr) {
+		const struct cache_entry *e2 = istate->cache[i];
+		const struct cache_entry *e3 = istate->cache[i + 1];
 		if (ce_stage(e2) == 2 &&
 		    ce_stage(e3) == 3 &&
 		    ce_same_name(e, e3) &&
@@ -549,7 +550,7 @@ static int check_one_conflict(int i, int *type)
 	}
 
 	/* Skip the entries with the same name */
-	while (i < active_nr && ce_same_name(e, active_cache[i]))
+	while (i < istate->cache_nr && ce_same_name(e, istate->cache[i]))
 		i++;
 	return i;
 }
@@ -565,16 +566,17 @@ static int check_one_conflict(int i, int *type)
  * are identical to the previous round, might want to be handled,
  * though.
  */
-static int find_conflict(struct string_list *conflict)
+static int find_conflict(struct repository *repo, struct string_list *conflict)
 {
 	int i;
-	if (read_cache() < 0)
+
+	if (read_index(repo->index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < repo->index->cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
-		i = check_one_conflict(i, &conflict_type);
+		const struct cache_entry *e = repo->index->cache[i];
+		i = check_one_conflict(repo->index, i, &conflict_type);
 		if (conflict_type == THREE_STAGED)
 			string_list_insert(conflict, (const char *)e->name);
 	}
@@ -596,18 +598,19 @@ static int find_conflict(struct string_list *conflict)
  * NEEDSWORK: we may want to fix the caller that implements "rerere
  * remaining" to do this without abusing merge_rr.
  */
-int rerere_remaining(struct string_list *merge_rr)
+int rerere_remaining(struct repository *repo, struct string_list *merge_rr)
 {
 	int i;
+
 	if (setup_rerere(merge_rr, RERERE_READONLY))
 		return 0;
-	if (read_cache() < 0)
+	if (read_index(repo->index) < 0)
 		return error("Could not read index");
 
-	for (i = 0; i < active_nr;) {
+	for (i = 0; i < repo->index->cache_nr;) {
 		int conflict_type;
-		const struct cache_entry *e = active_cache[i];
-		i = check_one_conflict(i, &conflict_type);
+		const struct cache_entry *e = repo->index->cache[i];
+		i = check_one_conflict(repo->index, i, &conflict_type);
 		if (conflict_type == PUNTED)
 			string_list_insert(merge_rr, (const char *)e->name);
 		else if (conflict_type == RESOLVED) {
@@ -627,7 +630,8 @@ int rerere_remaining(struct string_list *merge_rr)
  * if that recorded conflict resolves cleanly what we
  * got in the "cur".
  */
-static int try_merge(const struct rerere_id *id, const char *path,
+static int try_merge(struct index_state *istate,
+		     const struct rerere_id *id, const char *path,
 		     mmfile_t *cur, mmbuffer_t *result)
 {
 	int ret;
@@ -642,7 +646,7 @@ static int try_merge(const struct rerere_id *id, const char *path,
 		 * low-level merge driver settings.
 		 */
 		ret = ll_merge(result, path, &base, NULL, cur, "", &other, "",
-			       &the_index, NULL);
+			       istate, NULL);
 
 	free(base.ptr);
 	free(other.ptr);
@@ -660,7 +664,7 @@ static int try_merge(const struct rerere_id *id, const char *path,
  * Returns 0 for successful replay of recorded resolution, or non-zero
  * for failure.
  */
-static int merge(const struct rerere_id *id, const char *path)
+static int merge(struct index_state *istate, const struct rerere_id *id, const char *path)
 {
 	FILE *f;
 	int ret;
@@ -671,13 +675,13 @@ static int merge(const struct rerere_id *id, const char *path)
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if ((handle_file(path, NULL, rerere_path(id, "thisimage")) < 0) ||
+	if ((handle_file(istate, path, NULL, rerere_path(id, "thisimage")) < 0) ||
 	    read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 		ret = 1;
 		goto out;
 	}
 
-	ret = try_merge(id, path, &cur, &result);
+	ret = try_merge(istate, id, path, &cur, &result);
 	if (ret)
 		goto out;
 
@@ -705,7 +709,7 @@ static int merge(const struct rerere_id *id, const char *path)
 	return ret;
 }
 
-static void update_paths(struct string_list *update)
+static void update_paths(struct repository *repo, struct string_list *update)
 {
 	struct lock_file index_lock = LOCK_INIT;
 	int i;
@@ -714,13 +718,13 @@ static void update_paths(struct string_list *update)
 
 	for (i = 0; i < update->nr; i++) {
 		struct string_list_item *item = &update->items[i];
-		if (add_file_to_cache(item->string, 0))
+		if (add_file_to_index(repo->index, item->string, 0))
 			exit(128);
 		fprintf(stderr, "Staged '%s' using previous resolution.\n",
 			item->string);
 	}
 
-	if (write_locked_index(&the_index, &index_lock,
+	if (write_locked_index(repo->index, &index_lock,
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die("Unable to write new index file");
 }
@@ -739,7 +743,8 @@ static void remove_variant(struct rerere_id *id)
  * only have the preimage for that conflict, in which case the result
  * needs to be recorded as a resolution in a postimage file.
  */
-static void do_rerere_one_path(struct string_list_item *rr_item,
+static void do_rerere_one_path(struct index_state *istate,
+			       struct string_list_item *rr_item,
 			       struct string_list *update)
 {
 	const char *path = rr_item->string;
@@ -751,7 +756,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 
 	/* Has the user resolved it already? */
 	if (variant >= 0) {
-		if (!handle_file(path, NULL, NULL)) {
+		if (!handle_file(istate, path, NULL, NULL)) {
 			copy_file(rerere_path(id, "postimage"), path, 0666);
 			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
 			fprintf(stderr, "Recorded resolution for '%s'.\n", path);
@@ -775,7 +780,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			continue;
 
 		vid.variant = variant;
-		if (merge(&vid, path))
+		if (merge(istate, &vid, path))
 			continue; /* failed to replay */
 
 		/*
@@ -800,7 +805,7 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	assign_variant(id);
 
 	variant = id->variant;
-	handle_file(path, NULL, rerere_path(id, "preimage"));
+	handle_file(istate, path, NULL, rerere_path(id, "preimage"));
 	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
 		const char *path = rerere_path(id, "postimage");
 		if (unlink(path))
@@ -811,13 +816,14 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 	fprintf(stderr, "Recorded preimage for '%s'\n", path);
 }
 
-static int do_plain_rerere(struct string_list *rr, int fd)
+static int do_plain_rerere(struct repository *repo,
+			   struct string_list *rr, int fd)
 {
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list update = STRING_LIST_INIT_DUP;
 	int i;
 
-	find_conflict(&conflict);
+	find_conflict(repo, &conflict);
 
 	/*
 	 * MERGE_RR records paths with conflicts immediately after
@@ -839,7 +845,7 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 		 * conflict ID.  No need to write anything out
 		 * yet.
 		 */
-		ret = handle_file(path, sha1, NULL);
+		ret = handle_file(repo->index, path, sha1, NULL);
 		if (ret < 1)
 			continue;
 
@@ -851,10 +857,10 @@ static int do_plain_rerere(struct string_list *rr, int fd)
 	}
 
 	for (i = 0; i < rr->nr; i++)
-		do_rerere_one_path(&rr->items[i], &update);
+		do_rerere_one_path(repo->index, &rr->items[i], &update);
 
 	if (update.nr)
-		update_paths(&update);
+		update_paths(repo, &update);
 
 	return write_rr(rr, fd);
 }
@@ -909,7 +915,7 @@ int setup_rerere(struct string_list *merge_rr, int flags)
  * perform mergy operations, possibly leaving conflicted index entries
  * and working tree files.
  */
-int rerere(int flags)
+int rerere(struct repository *repo, int flags)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 	int fd, status;
@@ -917,7 +923,7 @@ int rerere(int flags)
 	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
-	status = do_plain_rerere(&merge_rr, fd);
+	status = do_plain_rerere(repo, &merge_rr, fd);
 	free_rerere_dirs();
 	return status;
 }
@@ -954,29 +960,30 @@ static int rerere_mem_getline(struct strbuf *sb, struct rerere_io *io_)
 	return 0;
 }
 
-static int handle_cache(const char *path, unsigned char *sha1, const char *output)
+static int handle_cache(struct index_state *istate, const char *path,
+			unsigned char *sha1, const char *output)
 {
 	mmfile_t mmfile[3] = {{NULL}};
 	mmbuffer_t result = {NULL, 0};
 	const struct cache_entry *ce;
 	int pos, len, i, hunk_no;
 	struct rerere_io_mem io;
-	int marker_size = ll_merge_marker_size(&the_index, path);
+	int marker_size = ll_merge_marker_size(istate, path);
 
 	/*
 	 * Reproduce the conflicted merge in-core
 	 */
 	len = strlen(path);
-	pos = cache_name_pos(path, len);
+	pos = index_name_pos(istate, path, len);
 	if (0 <= pos)
 		return -1;
 	pos = -pos - 1;
 
-	while (pos < active_nr) {
+	while (pos < istate->cache_nr) {
 		enum object_type type;
 		unsigned long size;
 
-		ce = active_cache[pos++];
+		ce = istate->cache[pos++];
 		if (ce_namelen(ce) != len || memcmp(ce->name, path, len))
 			break;
 		i = ce_stage(ce) - 1;
@@ -997,7 +1004,7 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	ll_merge(&result, path, &mmfile[0], NULL,
 		 &mmfile[1], "ours",
 		 &mmfile[2], "theirs",
-		 &the_index, NULL);
+		 istate, NULL);
 	for (i = 0; i < 3; i++)
 		free(mmfile[i].ptr);
 
@@ -1021,7 +1028,9 @@ static int handle_cache(const char *path, unsigned char *sha1, const char *outpu
 	return hunk_no;
 }
 
-static int rerere_forget_one_path(const char *path, struct string_list *rr)
+static int rerere_forget_one_path(struct index_state *istate,
+				  const char *path,
+				  struct string_list *rr)
 {
 	const char *filename;
 	struct rerere_id *id;
@@ -1033,7 +1042,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * Recreate the original conflict from the stages in the
 	 * index and compute the conflict ID
 	 */
-	ret = handle_cache(path, sha1, NULL);
+	ret = handle_cache(istate, path, sha1, NULL);
 	if (ret < 1)
 		return error("Could not parse conflict hunks in '%s'", path);
 
@@ -1050,13 +1059,13 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 		if (!has_rerere_resolution(id))
 			continue;
 
-		handle_cache(path, sha1, rerere_path(id, "thisimage"));
+		handle_cache(istate, path, sha1, rerere_path(id, "thisimage"));
 		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
 			free(cur.ptr);
 			error("Failed to update conflicted state in '%s'", path);
 			goto fail_exit;
 		}
-		cleanly_resolved = !try_merge(id, path, &cur, &result);
+		cleanly_resolved = !try_merge(istate, id, path, &cur, &result);
 		free(result.ptr);
 		free(cur.ptr);
 		if (cleanly_resolved)
@@ -1082,7 +1091,7 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	 * conflict in the working tree, run us again to record
 	 * the postimage.
 	 */
-	handle_cache(path, sha1, rerere_path(id, "preimage"));
+	handle_cache(istate, path, sha1, rerere_path(id, "preimage"));
 	fprintf(stderr, "Updated preimage for '%s'\n", path);
 
 	/*
@@ -1100,13 +1109,13 @@ static int rerere_forget_one_path(const char *path, struct string_list *rr)
 	return -1;
 }
 
-int rerere_forget(struct pathspec *pathspec)
+int rerere_forget(struct repository *repo, struct pathspec *pathspec)
 {
 	int i, fd;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-	if (read_cache() < 0)
+	if (read_index(repo->index) < 0)
 		return error("Could not read index");
 
 	fd = setup_rerere(&merge_rr, RERERE_NOAUTOUPDATE);
@@ -1118,14 +1127,14 @@ int rerere_forget(struct pathspec *pathspec)
 	 * recover the original conflicted state and then
 	 * find the conflicted paths.
 	 */
-	unmerge_cache(pathspec);
-	find_conflict(&conflict);
+	unmerge_index(repo->index, pathspec);
+	find_conflict(repo, &conflict);
 	for (i = 0; i < conflict.nr; i++) {
 		struct string_list_item *it = &conflict.items[i];
-		if (!match_pathspec(&the_index, pathspec, it->string,
+		if (!match_pathspec(repo->index, pathspec, it->string,
 				    strlen(it->string), 0, NULL, 0))
 			continue;
-		rerere_forget_one_path(it->string, &merge_rr);
+		rerere_forget_one_path(repo->index, it->string, &merge_rr);
 	}
 	return write_rr(&merge_rr, fd);
 }
diff --git a/rerere.h b/rerere.h
index cd948f28f4..44773435a0 100644
--- a/rerere.h
+++ b/rerere.h
@@ -4,6 +4,7 @@
 #include "string-list.h"
 
 struct pathspec;
+struct repository;
 
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
@@ -22,8 +23,8 @@ struct rerere_id {
 	int variant;
 };
 
-int setup_rerere(struct string_list *, int);
-int rerere(int);
+extern int setup_rerere(struct string_list *, int);
+extern int rerere(struct repository *repo, int);
 /*
  * Given the conflict ID and the name of a "file" used for replaying
  * the recorded resolution (e.g. "preimage", "postimage"), return the
@@ -31,8 +32,8 @@ int rerere(int);
  * return the path to the directory that houses these files.
  */
 const char *rerere_path(const struct rerere_id *, const char *file);
-int rerere_forget(struct pathspec *);
-int rerere_remaining(struct string_list *);
+int rerere_forget(struct repository *, struct pathspec *);
+int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct string_list *);
 void rerere_gc(struct string_list *);
 
diff --git a/sequencer.c b/sequencer.c
index 83c1f0e42b..cb7fefde9c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1827,7 +1827,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 		      : _("could not apply %s... %s"),
 		      short_commit_name(commit), msg.subject);
 		print_advice(res == 1, opts);
-		rerere(opts->allow_rerere_auto);
+		rerere(the_repository, opts->allow_rerere_auto);
 		goto leave;
 	}
 
@@ -3146,7 +3146,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 
 	rollback_lock_file(&lock);
 	if (ret)
-		rerere(opts->allow_rerere_auto);
+		rerere(the_repository, opts->allow_rerere_auto);
 	else
 		/*
 		 * In case of problems, we now want to return a positive
-- 
2.19.0.rc0.337.ge906d732e7

