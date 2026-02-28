Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813A3E5565
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305568; cv=none; b=sZtFKxGirsMrcEFlXU/gN5XmleCwu4AqE5MzCUAiQs970lwEAWiTKni6oHhAPDbSkZxIOLykm6sOqt8ZvgFidndmiQjQo5H8OMhmdeayQW3Fq+/W8eKULFKAKYbXGIPBBTHOnYpgImWIbHT7slx6G6bqwDAZWNTmbl/YsRMUD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305568; c=relaxed/simple;
	bh=Thi/aOzABcnljaOrH+94VTkqA3sKXjwEDbgsBeI6paY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCdPB9APqABOIBKs7VxmxsxuUyA7BijXoEut6lVyYyc9s16mnpx9c6jgV+IFqt87nnlVJLCHn+nJqhtYHeXF/fYQZUnvf9lXctv116E40BDqmOUSyrluKXkFmVWBPg1cPYxNOMmduOzobfXZ54d0ir7ds/nPKnTASCQ7zC8aC70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWWtMyuZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWWtMyuZ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c70fdc3742fso498876a12.0
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 11:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772305565; x=1772910365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I78gVxUDxt6YkKP7gLVocPnY7sNkcna2FFopSYIXzMk=;
        b=dWWtMyuZNcrjsX/zOvu5NzrFbPVXtC6kL49IriUMcVltJ9YHTNPmVg6065hwi/5Ql6
         r635GilIqxHIDZv7+LTfHsm8PykYHQoklB5Kq+qElR4ED2QlYLqxyksfiwjv616LLPJs
         DSrfWss/9dZ9OkvW78+2L7MMOFaZBapzRmnh1W50JKO0kJVHMkTtCgToIdcnvbLsjYq9
         d59nWpjtdNUevNj3JfSZ9Fkz2HTqkOY4xeDKwAHwIcQjFMcuEXlmI4rgNvnWzXBlL8FX
         3TBZYbZFTdp5aSx6S5gMCmHRJth3tllfyxhad78s/+TmJ7fZ2t9SjKj8kxbeHWK+ZDKe
         NR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772305565; x=1772910365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I78gVxUDxt6YkKP7gLVocPnY7sNkcna2FFopSYIXzMk=;
        b=EvbwtaLfxMzU6m5XQKNbOJ3R2woqyI1whuA6bDj9rpTx0CbEoQJ2T32n6TjBu+Iy24
         dMsk6DCHMV0+Sqv0lN/JEph4DyMhxP3ycBFqpFb/q+PZebxjWMbnAE+x3nOxyWyWR5ok
         /JN5bbEBO+8bU84wM2haBEEBq164IyMSTCd8zRWyzGIZBw1fwl9ghidTLULwORus4qxv
         60YiBpt60ouRgSL7H0Q/7WW7S/mDCN6gwymQmUTmNvshiUWCs4jOTGNrajOBAp076a4z
         Vnj+vOmuYN9eA5yFS/fKrcczoKgTU3i+78KTj8gLG2T7mG2Jy+pheMJios9VSVVL9HPG
         5rPA==
X-Gm-Message-State: AOJu0Yx7yqOOBmaE7KAHehODBFKJAAj+ZiO2onJYkm2zdMmEtx0bsb1d
	v+mxpAtL3uJIb14ELBH2Y/AJuW/Ir/Bv343/V+wFP3frl5HHaH6bsu8PrKnaeyss
X-Gm-Gg: ATEYQzzpgagBzb8U0Ja5ATU8ORBoubwnQonHOM0SnCL/5k1nNfMHZUFtZ4DuDLwMDUM
	W8x2GisCzddNmxP0pI8S4jQCx9wxqMGnKcvWEy3prWURYWdVQp3lh8hVY6529XXefQo8m4DUhEa
	V8B2QYEqSVbm+tEO85TCMrpMPEq2GdgKZfVeDmMhaGhEK+LvcFxEBPCrJW87iL1BQwGINkSOvS+
	qvyFtUVhGMbJanfnH21/k9tvgoB7Z0PX/S8kpS9g02N7qGBfRx81DSQQc6p+Yux3z+3pn1yML/r
	dl8x+WTGrbvV+ld/szHCZ2Kgq4f9aLOcki/daFS+XoSyGqEk7qwImZGNSaHVQH7wOnMpRwfu3uj
	qAxojRcau3eMYQcXCS+7JO+K345d3v6GcC+trDcNh/ikdcYD37Mp6gq4DUmKy2BuSQf+EhMYHoH
	BhNHg045RhAMVD2tgqcBCGSyzLP9QB9HB39V1RtJwf/8g3L8GSL038RAXlb6rge7Lea3pLUh1l8
	/XBpxLzE8bhkeqHFw1wa2A=
X-Received: by 2002:a05:6a00:2d85:b0:81e:baa3:1fd6 with SMTP id d2e1a72fcca58-8274da3a595mr4384853b3a.4.1772305565269;
        Sat, 28 Feb 2026 11:06:05 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3e4asm8556644b3a.28.2026.02.28.11.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:06:04 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	gitster@pobox.com
Subject: [PATCH v2 2/3] commit: pass 'struct repository' to commit creation APIs
Date: Sun,  1 Mar 2026 03:02:00 +0800
Message-ID: <20260228190201.3684705-3-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260228190201.3684705-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
 <20260228190201.3684705-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following the migration of encoding settings into 'struct repo_settings',
core commit creation functions in 'commit.c' now require a repository
context to query the commit output encoding.

Update the signatures of 'commit_tree()' and 'commit_tree_extended()',
as well as the internal 'write_commit_tree()', to accept 'struct
repository *' as their first argument so they can call
'repo_get_commit_output_encoding(r)/(repo)' without relying on the global
'the_repository' macro.

Consequently, update all callers across the codebase to pass the
repository context down the call chain. To facilitate this dependency
bubbling, update the signatures of several intermediate helper functions,
explicitly 'notes_cache_write()' and 'get_message()' (in sequencer.c).

For callers in the 'builtin/' directory, fallback to using
'the_repository'.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/am.c          |  2 +-
 builtin/commit-tree.c |  2 +-
 builtin/commit.c      |  2 +-
 builtin/history.c     |  2 +-
 builtin/merge.c       |  4 ++--
 builtin/rebase.c      |  2 +-
 builtin/stash.c       | 10 +++++-----
 commit.c              | 31 +++++++++++++++++--------------
 commit.h              |  6 ++++--
 diff.c                |  2 +-
 notes-cache.c         |  4 ++--
 notes-cache.h         |  2 +-
 notes-utils.c         |  2 +-
 replay.c              |  2 +-
 sequencer.c           | 12 ++++++------
 15 files changed, 45 insertions(+), 40 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 96b8c00007..eee3c9864c 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1699,7 +1699,7 @@ static void do_commit(const struct am_state *state)
 							 : state->author_date,
 				      IDENT_STRICT);
 
-	if (commit_tree_extended(state->msg, state->msg_len, &tree, parents,
+	if (commit_tree_extended(the_repository, state->msg, state->msg_len, &tree, parents,
 				 &commit, author, committer, state->sign_commit,
 				 NULL))
 		die(_("failed to write commit object"));
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 30535db131..c489749588 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -144,7 +144,7 @@ int cmd_commit_tree(int argc,
 			die_errno(_("git commit-tree: failed to read"));
 	}
 
-	if (commit_tree(buffer.buf, buffer.len, &tree_oid, parents, &commit_oid,
+	if (commit_tree(the_repository, buffer.buf, buffer.len, &tree_oid, parents, &commit_oid,
 			NULL, sign_commit)) {
 		ret = 1;
 		goto out;
diff --git a/builtin/commit.c b/builtin/commit.c
index 2bbdd4c4c3..da2b8ce541 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1931,7 +1931,7 @@ int cmd_commit(int argc,
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, &the_repository->index->cache_tree->oid,
+	if (commit_tree_extended(the_repository, sb.buf, sb.len, &the_repository->index->cache_tree->oid,
 				 parents, &oid, author_ident.buf, NULL,
 				 sign_commit, extra)) {
 		rollback_index_files();
diff --git a/builtin/history.c b/builtin/history.c
index 8dcb9a6046..ca36d065a5 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -136,7 +136,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 
 	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
 
-	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
+	ret = commit_tree_extended(the_repository, commit_message.buf, commit_message.len, &original_tree_oid,
 				   original->parents, &rewritten_commit_oid, original_author,
 				   NULL, NULL, original_extra_headers);
 	if (ret < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 4e456a381c..7c944fe179 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1000,7 +1000,7 @@ static int merge_trivial(struct commit *head, struct commit_list *remoteheads)
 	pptr = commit_list_append(head, pptr);
 	pptr = commit_list_append(remoteheads->item, pptr);
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, &result_tree, parents,
+	if (commit_tree(the_repository, merge_msg.buf, merge_msg.len, &result_tree, parents,
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, &result_commit, "In-index merge");
@@ -1027,7 +1027,7 @@ static int finish_automerge(struct commit *head,
 	if (!head_subsumed || fast_forward == FF_NO)
 		commit_list_insert(head, &parents);
 	prepare_to_commit(remoteheads);
-	if (commit_tree(merge_msg.buf, merge_msg.len, result_tree, parents,
+	if (commit_tree(the_repository, merge_msg.buf, merge_msg.len, result_tree, parents,
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c487e10907..7b9ab85cc0 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1647,7 +1647,7 @@ int cmd_rebase(int argc,
 		options.upstream_arg = options.upstream_name;
 	} else {
 		if (!options.onto_name) {
-			if (commit_tree("", 0, the_hash_algo->empty_tree, NULL,
+			if (commit_tree(the_repository, "", 0, the_hash_algo->empty_tree, NULL,
 					&squash_onto, NULL, NULL) < 0)
 				die(_("Could not create new root commit"));
 			options.squash_onto = &squash_onto;
diff --git a/builtin/stash.c b/builtin/stash.c
index f06cfa7989..3d94726251 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1258,7 +1258,7 @@ static int save_untracked_files(struct stash_info *info, struct strbuf *msg,
 		goto done;
 	}
 
-	if (commit_tree(untracked_msg.buf, untracked_msg.len,
+	if (commit_tree(the_repository, untracked_msg.buf, untracked_msg.len,
 			&info->u_tree, NULL, &info->u_commit, NULL, NULL)) {
 		ret = -1;
 		goto done;
@@ -1486,7 +1486,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 	commit_list_insert(head_commit, &parents);
 	if (write_index_as_tree(&info->i_tree, the_repository->index,
 				repo_get_index_file(the_repository), 0, NULL) ||
-	    commit_tree(commit_tree_label.buf, commit_tree_label.len,
+	    commit_tree(the_repository, commit_tree_label.buf, commit_tree_label.len,
 			&info->i_tree, parents, &info->i_commit, NULL, NULL)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot save the current "
@@ -1551,7 +1551,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 			   &parents);
 	commit_list_insert(head_commit, &parents);
 
-	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
+	if (commit_tree(the_repository, stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot record "
@@ -2035,7 +2035,7 @@ static int write_commit_with_parents(struct repository *r,
 	author = xmemdupz(orig_author, author_len);
 	committer = xmemdupz(orig_committer, committer_len);
 
-	if (commit_tree_extended(msg.buf, msg.len,
+	if (commit_tree_extended(the_repository, msg.buf, msg.len,
 				 r->hash_algo->empty_tree, parents,
 				 out, author, committer,
 				 NULL, NULL)) {
@@ -2258,7 +2258,7 @@ static int do_export_stash(struct repository *r,
 			      "2001-09-17T00:00:00Z", 0);
 
 	/* First, we create a single empty commit. */
-	if (commit_tree_extended("", 0, r->hash_algo->empty_tree, NULL,
+	if (commit_tree_extended(the_repository, "", 0, r->hash_algo->empty_tree, NULL,
 				 &base, author, committer, NULL, NULL))
 		return error(_("unable to write base commit"));
 
diff --git a/commit.c b/commit.c
index d558db52dc..b05cd8d9da 100644
--- a/commit.c
+++ b/commit.c
@@ -1534,7 +1534,8 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 	}
 }
 
-int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
+int commit_tree(struct repository *r,
+		const char *msg, size_t msg_len, const struct object_id *tree,
 		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit)
 {
@@ -1542,7 +1543,7 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
 	int result;
 
 	append_merge_tag_headers(parents, &tail);
-	result = commit_tree_extended(msg, msg_len, tree, parents, ret, author,
+	result = commit_tree_extended(r, msg, msg_len, tree, parents, ret, author,
 				      NULL, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
@@ -1663,17 +1664,18 @@ N_("Warning: commit message did not conform to UTF-8.\n"
    "You may want to amend it after fixing the message, or set the config\n"
    "variable i18n.commitEncoding to the encoding your project uses.\n");
 
-static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg_len,
-			      const struct object_id *tree,
-			      const struct object_id *parents, size_t parents_len,
-			      const char *author, const char *committer,
-			      const struct commit_extra_header *extra)
+static void write_commit_tree(struct repository *r, 
+			struct strbuf *buffer, const char *msg, size_t msg_len,
+			const struct object_id *tree,
+			const struct object_id *parents, size_t parents_len,
+			const char *author, const char *committer,
+			const struct commit_extra_header *extra)
 {
 	int encoding_is_utf8;
 	size_t i;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(the_repository));
+	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(r));
 
 	strbuf_grow(buffer, 8192); /* should avoid reallocs for the headers */
 	strbuf_addf(buffer, "tree %s\n", oid_to_hex(tree));
@@ -1694,7 +1696,7 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 		committer = git_committer_info(IDENT_STRICT);
 	strbuf_addf(buffer, "committer %s\n", committer);
 	if (!encoding_is_utf8)
-		strbuf_addf(buffer, "encoding %s\n", repo_get_commit_output_encoding(the_repository));
+		strbuf_addf(buffer, "encoding %s\n", repo_get_commit_output_encoding(r));
 
 	while (extra) {
 		add_extra_header(buffer, extra);
@@ -1706,14 +1708,15 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 	strbuf_add(buffer, msg, msg_len);
 }
 
-int commit_tree_extended(const char *msg, size_t msg_len,
+int commit_tree_extended(
+			 struct repository *r,
+			 const char *msg, size_t msg_len,
 			 const struct object_id *tree,
 			 const struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *committer,
 			 const char *sign_commit,
 			 const struct commit_extra_header *extra)
 {
-	struct repository *r = the_repository;
 	int result = 0;
 	int encoding_is_utf8;
 	struct strbuf buffer = STRBUF_INIT, compat_buffer = STRBUF_INIT;
@@ -1723,7 +1726,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	size_t i, nparents;
 
 	/* Not having i18n.commitencoding is the same as having utf-8 */
-	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(the_repository));
+	encoding_is_utf8 = is_encoding_utf8(repo_get_commit_output_encoding(r));
 
 	odb_assert_oid_type(the_repository->objects, tree, OBJ_TREE);
 
@@ -1736,7 +1739,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 	for (const struct commit_list *p = parents; p; p = p->next)
 		oidcpy(&parent_buf[i++], &p->item->object.oid);
 
-	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
+	write_commit_tree(r, &buffer, msg, msg_len, tree, parent_buf, nparents, author, committer, extra);
 	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
 		result = -1;
 		goto out;
@@ -1764,7 +1767,7 @@ int commit_tree_extended(const char *msg, size_t msg_len,
 			free(mapped_parents);
 			goto out;
 		}
-		write_commit_tree(&compat_buffer, msg, msg_len, &mapped_tree,
+		write_commit_tree(r, &compat_buffer, msg, msg_len, &mapped_tree,
 				  mapped_parents, nparents, author, committer, compat_extra);
 		free_commit_extra_headers(compat_extra);
 		free(mapped_parents);
diff --git a/commit.h b/commit.h
index 1635de418b..b8aa748fbb 100644
--- a/commit.h
+++ b/commit.h
@@ -289,12 +289,14 @@ struct commit_extra_header {
 void append_merge_tag_headers(const struct commit_list *parents,
 			      struct commit_extra_header ***tail);
 
-int commit_tree(const char *msg, size_t msg_len,
+int commit_tree(struct repository *r, 
+		const char *msg, size_t msg_len,
 		const struct object_id *tree,
 		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit);
 
-int commit_tree_extended(const char *msg, size_t msg_len,
+int commit_tree_extended(struct repository *r,
+			 const char *msg, size_t msg_len,
 			 const struct object_id *tree,
 			 const struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *committer,
diff --git a/diff.c b/diff.c
index 35b903a9a0..f0244c14f1 100644
--- a/diff.c
+++ b/diff.c
@@ -7513,7 +7513,7 @@ size_t fill_textconv(struct repository *r,
 		 * Since generating a cache entry is the slow path anyway,
 		 * this extra overhead probably isn't a big deal.
 		 */
-		notes_cache_write(driver->textconv_cache);
+		notes_cache_write(r, driver->textconv_cache);
 	}
 
 	return size;
diff --git a/notes-cache.c b/notes-cache.c
index bf5bb1f6c1..f14e0308af 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -54,7 +54,7 @@ void notes_cache_init(struct repository *r, struct notes_cache *c,
 	strbuf_release(&ref);
 }
 
-int notes_cache_write(struct notes_cache *c)
+int notes_cache_write(struct repository *r, struct notes_cache *c)
 {
 	struct object_id tree_oid, commit_oid;
 
@@ -66,7 +66,7 @@ int notes_cache_write(struct notes_cache *c)
 
 	if (write_notes_tree(&c->tree, &tree_oid))
 		return -1;
-	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
+	if (commit_tree(r, c->validity, strlen(c->validity), &tree_oid, NULL,
 			&commit_oid, NULL, NULL) < 0)
 		return -1;
 	if (refs_update_ref(get_main_ref_store(the_repository), "update notes cache", c->tree.update_ref, &commit_oid,
diff --git a/notes-cache.h b/notes-cache.h
index 56f8c98e24..f268425fd7 100644
--- a/notes-cache.h
+++ b/notes-cache.h
@@ -12,7 +12,7 @@ struct notes_cache {
 
 void notes_cache_init(struct repository *r, struct notes_cache *c,
 		      const char *name, const char *validity);
-int notes_cache_write(struct notes_cache *c);
+int notes_cache_write(struct repository *r, struct notes_cache *c);
 
 char *notes_cache_get(struct notes_cache *c, struct object_id *oid, size_t
 		      *outsize);
diff --git a/notes-utils.c b/notes-utils.c
index 5c1c75d5b8..4671a11993 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -36,7 +36,7 @@ void create_notes_commit(struct repository *r,
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
 
-	if (commit_tree(msg, msg_len, &tree_oid, parents, result_oid, NULL,
+	if (commit_tree(r, msg, msg_len, &tree_oid, parents, result_oid, NULL,
 			NULL))
 		die("Failed to commit notes tree to database");
 
diff --git a/replay.c b/replay.c
index 45d539f8fc..69a69deab4 100644
--- a/replay.c
+++ b/replay.c
@@ -68,7 +68,7 @@ static struct commit *create_commit(struct repository *repo,
 	strbuf_addstr(&msg, orig_message);
 	author = get_author(message);
 	reset_ident_date();
-	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
+	if (commit_tree_extended(repo, msg.buf, msg.len, &tree->object.oid, parents,
 				 &ret, author, NULL, sign_commit, extra)) {
 		error(_("failed to write commit object"));
 		goto out;
diff --git a/sequencer.c b/sequencer.c
index 612f47fd12..b9a4f75c5f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -480,13 +480,13 @@ static const char *short_commit_name(struct repository *r, struct commit *commit
 	return repo_find_unique_abbrev(r, &commit->object.oid, DEFAULT_ABBREV);
 }
 
-static int get_message(struct commit *commit, struct commit_message *out)
+static int get_message(struct repository *r, struct commit *commit, struct commit_message *out)
 {
 	const char *abbrev, *subject;
 	int subject_len;
 
 	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
-					    repo_get_commit_output_encoding(the_repository));
+					    repo_get_commit_output_encoding(r));
 	abbrev = short_commit_name(the_repository, commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -1672,7 +1672,7 @@ static int try_to_commit(struct repository *r,
 		free(email);
 	}
 
-	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
+	if (commit_tree_extended(r, msg->buf, msg->len, &tree, parents, oid,
 				 author, committer, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
 		goto out;
@@ -2324,7 +2324,7 @@ static int do_pick_commit(struct repository *r,
 	else
 		parent = commit->parents->item;
 
-	if (get_message(commit, &msg) != 0)
+	if (get_message(r, commit, &msg) != 0)
 		return error(_("cannot get commit message for %s"),
 			oid_to_hex(&commit->object.oid));
 
@@ -3989,7 +3989,7 @@ static int do_reset(struct repository *r,
 	if (len == 10 && !strncmp("[new root]", name, len)) {
 		if (!opts->have_squash_onto) {
 			const char *hex;
-			if (commit_tree("", 0, the_hash_algo->empty_tree,
+			if (commit_tree(r, "", 0, the_hash_algo->empty_tree,
 					NULL, &opts->squash_onto,
 					NULL, NULL))
 				return error(_("writing fake root commit"));
@@ -4831,7 +4831,7 @@ static int stopped_at_head(struct repository *r)
 
 	if (repo_get_oid(r, "HEAD", &head) ||
 	    !(commit = lookup_commit(r, &head)) ||
-	    repo_parse_commit(r, commit) || get_message(commit, &message))
+	    repo_parse_commit(r, commit) || get_message(r, commit, &message))
 		fprintf(stderr, _("Stopped at HEAD\n"));
 	else {
 		fprintf(stderr, _("Stopped at %s\n"), message.label);
-- 
2.43.0

