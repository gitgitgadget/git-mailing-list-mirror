Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303120C00C
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772397365; cv=none; b=q3OVNuITSe7QeIuXS7eDcZaACoDoFC6pmWnHF/rx1STS3CtENmmMRrY5b5OIL7HMFca9nsA8B/gJwO9MwJiG1r1SsLt7g85+Ainl25ogy+b2Y5qRxkPcBLgX0wbh1cDrMSB/u8smngMABduEf7uLZU06XkCHOh2haRZ90NHCQsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772397365; c=relaxed/simple;
	bh=SBugYonDeNX84i5cUNcbyG+BVHsczNHFhFqkxzZZ0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV02RfakfngXLQVYI4z4PonmZRIrboeAASOZV3SQac7uiZsH1b3DQsmo97tlX+BFXRmpn8WCArZGSFaduqb5Mn3KWiGR2PGKNCceds2efp2vFVZrEiYG3OrMzE2VVYwobS5NwXqZkg5ctCTsiYxQVX4wek9tfdcS32DK0FTLfU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsNU7nVH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsNU7nVH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad2b375e58so6406935ad.3
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 12:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772397363; x=1773002163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RX4LIbil/pb/XffjHRgMNkFAsKBXuGES2sO8pBLc7c8=;
        b=gsNU7nVH+d1o/oKruHsjSThG7Q7y+ZGquK6dQ1l4xPQUtN2FObwcnmUWKKuiq57UdO
         KiE838/DN1xdSngNMJN1WSarPIYoe7FWkdON6RypPhN5joCw8+TODJW2ZMfMqIS7c3sP
         B09/dpgDQA8OxOa3yxOhWeqAunkWFaSHKhn2IQ3fj5NIB/wbV1K3NBDAU/LfzJAD1upE
         IFNNifbJ++XIvNFdO4fENKgQkULhdWIIZh4DSMpPL3a8LnoD/PcIxOSXgEeFzde47UAr
         9MAkXdDHsig/EnskcLXHmJWZHh7mOrbiCkvtgnc0ZSZIqnBycuAbOi86CGS3inUh/Fi+
         qubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772397363; x=1773002163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RX4LIbil/pb/XffjHRgMNkFAsKBXuGES2sO8pBLc7c8=;
        b=Na8M+OgCNeCFH79JIYehzFY9UcA47vYFLMq7ZjCVNY4KiPGmDMm1GOy7PVqUfbr3wh
         PFGPokURS7TjOdW+mA1OroXoM4LS+2pQNyUWaahGJlkq0RHsDROYGOdLodrE0Fd/hAe4
         7ujuiuLmCuRAqTfZjJYwW7ATdgQrmFuA79V/kJWX2Y8tEKgpwsWragEyXeF4dAr3thZp
         gZDeReO9wNdsEz/4j7H/CH+GJlQL0rg0eudv8uWviegO4BYdJfsU//B4fFnLW2D4bfLk
         OvH7ES2NWgYIQ0xzQ+cXhTqRLCUAHIl9SU4E2+A49xLHja8RhzzK1V6s9LCwMa6MlNxF
         nFMQ==
X-Gm-Message-State: AOJu0YwiVDP19e1Iq3PLMxVR9Mm/U8U91YE7MNa0lW3QkFlK8x3rA7zx
	IIVdUQIE6rDzenB44in/Q88MOQ+Yb6ocjv8HtRqBMQjYW+RxDf6VGKsjKQrkT5Uf
X-Gm-Gg: ATEYQzxdornKN31vy/DtPpaWTagR/mjlR4D7hky2jevw/DHPwlIVR+YhYQW28TZpBhz
	wqTScByTLHCFe6gaCm08SuQjN/nUqEw1qy35vD0c8D6iLtNoTISb0Q6ZwZxPyoR2YWVT8JbQSMC
	ehQCxOjJ4J076eQFz9DTFKhm90VZmINpVqfiQoXruFi2xMrhTb7tuxvLv5qn9EdaVQ6TG09WgW/
	2Bhz6l3exx6bz1vaiJmJX3BktXTGZjSGcJfI3T76g9kHkcBXnCob1J0CXU3keXuWe+C4gRD+M/I
	w+O/o++SFBHwO4obAxjzWJLUerWI8HzKPRZwX05CDwiN2t+NPKvxvXlrEMWfUCTBDq4e13RI3M7
	7+rYxz57re1B5qc7fVmwBOVugkB4um3x1HSS1jgPf6dRR/ScvDmgE78KFQ9FWA46vA6WU6d4Sy3
	PsE+7Odc3qPjALsheV4AfOt5EcPYrE3irOsvHEq3h/hvL1pl9W2EfrKN4EVl95q1AfIoL1a68xo
	8aaT5Asin9+0juH42YWhKg=
X-Received: by 2002:a05:6a20:431f:b0:38e:53ed:bc05 with SMTP id adf61e73a8af0-395c3b582ddmr7253533637.7.1772397362506;
        Sun, 01 Mar 2026 12:36:02 -0800 (PST)
Received: from malon-Yoga-14sARE-2020.. ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa5e4abcsm9496976a12.5.2026.03.01.12.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:36:02 -0800 (PST)
From: Tian Yuchen <a3205153416@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [PATCH v3 1/3] commit: plumb 'struct repository' into commit creation APIs
Date: Mon,  2 Mar 2026 04:35:37 +0800
Message-ID: <20260301203539.1421152-2-a3205153416@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301203539.1421152-1-a3205153416@gmail.com>
References: <20260228040727.2057192-1-a3205153416@gmail.com>
 <20260301203539.1421152-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pave the way for reducing the global state tied to commit encoding
in a subsequent patch, functions like 'commit_tree()' and
'commit_tree_extended()' must be able to access a repository instance.

Plumb the 'struct repository' pointer down the call chain for these
APIs. For built-ins or subsystems already dependent on global state
(e.g., 'notes_cache_write()'), fallback to 'the_repository'.

No functional changes are introduced in this preparatory step.

Signed-off-by: Tian Yuchen <a3205153416@gmail.com>
---
 builtin/am.c          |  2 +-
 builtin/commit-tree.c |  2 +-
 builtin/commit.c      |  2 +-
 builtin/history.c     |  2 +-
 builtin/merge.c       |  4 ++--
 builtin/rebase.c      |  2 +-
 builtin/stash.c       | 10 +++++-----
 commit.c              |  7 +++----
 commit.h              |  4 ++--
 notes-cache.c         |  2 +-
 notes-utils.c         |  2 +-
 replay.c              |  2 +-
 sequencer.c           |  4 ++--
 13 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index e0c767e223..5296124f84 100644
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
index 9e3a09d532..d619fd2ace 100644
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
index 8dcb9a6046..3d83ac021b 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -136,7 +136,7 @@ static int commit_tree_with_edited_message(struct repository *repo,
 
 	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
 
-	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
+	ret = commit_tree_extended(repo, commit_message.buf, commit_message.len, &original_tree_oid,
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
index f06cfa7989..785c1f9e5d 100644
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
+	if (commit_tree_extended(r, msg.buf, msg.len,
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
index d16ae73345..71a2b7bbe5 100644
--- a/commit.c
+++ b/commit.c
@@ -1534,7 +1534,7 @@ void free_commit_extra_headers(struct commit_extra_header *extra)
 	}
 }
 
-int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
+int commit_tree(struct repository *r, const char *msg, size_t msg_len, const struct object_id *tree,
 		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit)
 {
@@ -1542,7 +1542,7 @@ int commit_tree(const char *msg, size_t msg_len, const struct object_id *tree,
 	int result;
 
 	append_merge_tag_headers(parents, &tail);
-	result = commit_tree_extended(msg, msg_len, tree, parents, ret, author,
+	result = commit_tree_extended(r, msg, msg_len, tree, parents, ret, author,
 				      NULL, sign_commit, extra);
 	free_commit_extra_headers(extra);
 	return result;
@@ -1706,14 +1706,13 @@ static void write_commit_tree(struct strbuf *buffer, const char *msg, size_t msg
 	strbuf_add(buffer, msg, msg_len);
 }
 
-int commit_tree_extended(const char *msg, size_t msg_len,
+int commit_tree_extended(struct repository *r, const char *msg, size_t msg_len,
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
diff --git a/commit.h b/commit.h
index 1635de418b..d3d664d0ff 100644
--- a/commit.h
+++ b/commit.h
@@ -289,12 +289,12 @@ struct commit_extra_header {
 void append_merge_tag_headers(const struct commit_list *parents,
 			      struct commit_extra_header ***tail);
 
-int commit_tree(const char *msg, size_t msg_len,
+int commit_tree(struct repository *r, const char *msg, size_t msg_len,
 		const struct object_id *tree,
 		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit);
 
-int commit_tree_extended(const char *msg, size_t msg_len,
+int commit_tree_extended(struct repository *r, const char *msg, size_t msg_len,
 			 const struct object_id *tree,
 			 const struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *committer,
diff --git a/notes-cache.c b/notes-cache.c
index bf5bb1f6c1..5dbbd94ea3 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -66,7 +66,7 @@ int notes_cache_write(struct notes_cache *c)
 
 	if (write_notes_tree(&c->tree, &tree_oid))
 		return -1;
-	if (commit_tree(c->validity, strlen(c->validity), &tree_oid, NULL,
+	if (commit_tree(the_repository, c->validity, strlen(c->validity), &tree_oid, NULL,
 			&commit_oid, NULL, NULL) < 0)
 		return -1;
 	if (refs_update_ref(get_main_ref_store(the_repository), "update notes cache", c->tree.update_ref, &commit_oid,
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
index f97d652f33..8704547aa1 100644
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
index a3eb39bb25..627020d65b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1672,7 +1672,7 @@ static int try_to_commit(struct repository *r,
 		free(email);
 	}
 
-	if (commit_tree_extended(msg->buf, msg->len, &tree, parents, oid,
+	if (commit_tree_extended(r, msg->buf, msg->len, &tree, parents, oid,
 				 author, committer, opts->gpg_sign, extra)) {
 		res = error(_("failed to write commit object"));
 		goto out;
@@ -3989,7 +3989,7 @@ static int do_reset(struct repository *r,
 	if (len == 10 && !strncmp("[new root]", name, len)) {
 		if (!opts->have_squash_onto) {
 			const char *hex;
-			if (commit_tree("", 0, the_hash_algo->empty_tree,
+			if (commit_tree(r, "", 0, the_hash_algo->empty_tree,
 					NULL, &opts->squash_onto,
 					NULL, NULL))
 				return error(_("writing fake root commit"));
-- 
2.43.0

