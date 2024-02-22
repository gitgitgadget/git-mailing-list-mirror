Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9A6131E5C
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608121; cv=none; b=DfLLpcPod93jDH4BHB+n9Pdt3ps+pzUvFlkoQVXMd3G6Z00q/fZICtU564PPOt7Oi99lsH9jNlUO0ceF2iHss6E5bhsyTNpqiL1xq+cUa8uQ7Ls1ae/7n0rNYR7yJ5bIPVMOFUtpwX14P3s/KVj9f31N0ev6ASJ2HuZ38vz6VVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608121; c=relaxed/simple;
	bh=Syx4NjPcIpNtyrjzl3x0GGXEW0EPGqr71KjFZHHPZP8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=toSWsU+9qxneTYWQ6mGYn2PVUhZvxoLvho4K1hUTQ944ctwDrTGxK5aDFfgOhqdJIbpmeTdakRDMtYynxpiH1+OzYRlgnuS6fhAlDbsgl43KDZcNoRZBYXD8dLHhgZzVDrj3lQ0V3b5jzoGT4U6VNyOOrsjPqXT6aR/lQnNrNEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTeh5vkt; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTeh5vkt"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d244b28b95so40861111fa.0
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608116; x=1709212916; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH6ulL8Wd+r38HjTcw8+LwpCJD151OMvzfTEdbsLwa4=;
        b=gTeh5vktLZbMrEaEyQij1xQ3nHNDtVLeYHssuY/KzeAdWY+I/ohkD5RT5j6uKrj2Wz
         sXYGWv5yef0O1i3IGI7/I2ObP5lfT3KdrYe41jhTJeAR971VQxu+MODnWgABCT4oEi1E
         t1TN5k2wtGcntSWZr/l95taT9e37MiPKbKZALKdgBEd6/aIDsR4jBXmeUPqfUsJJoTos
         melF1QI3zYI2JDUhQhQ+Q6oKBVdVPjtFQ/bfBZXVTAYP6nhQhHD9wvohVOdKYkbxebI/
         okyuP9Wo2j8dbGcnITOMD7QVtbaYHYcea43owwFLQbeb/eFK3Uq5gGhTkqgL91TpQs6h
         HNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608116; x=1709212916;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH6ulL8Wd+r38HjTcw8+LwpCJD151OMvzfTEdbsLwa4=;
        b=H1a757u61TQIl76zGXfVOKFCkF+tYnaoIuJLSrs8VKnqA9ekZw7YOj03H+uwV3f6qh
         vKA++37sXmSfPDQMixPWd5yJT9FrYhT2mD4HLNO6zVgZyGecb+AqgcdmUFY41aLhiQV4
         vDuaKY1H7RhVAKsPlSe0t7d2xFSghB064x3KQecvw8ExHmRghQd7ef9a7CrOaUGYNEhQ
         oBcFszFg2ZObmE2+amUnjoVSAeamc939xj9QgejeOgbdhmQ0sdsVZlliGr2O5V3Czfjh
         a7zUOExu0L0tfyXwExuWmja+CS0AbTBbStCFjZlSOndkxID6pYxiGlebjr684bAua2Jy
         Ty/g==
X-Gm-Message-State: AOJu0YzBcx1fWHxCrt3ju8NlswnsIiP0cTjBeJGWbKb1gsBS3h/sHsny
	LXIosc2eoefvwXeejhGGtJtTYwHgv1yvkeuVOcW4bXWnZf2mUxNM/tRDkBwj
X-Google-Smtp-Source: AGHT+IGSWu0KQbour8rqQvT1yHrPsTFaYFNTBSPG+/FZHmJaWpjcT5MVZ8bJ+Mu1VPgD4zb7vF+sdg==
X-Received: by 2002:a2e:9d87:0:b0:2d2:32ac:21f6 with SMTP id c7-20020a2e9d87000000b002d232ac21f6mr8573694ljj.16.1708608115841;
        Thu, 22 Feb 2024 05:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s7-20020a7bc387000000b004107dfa6aebsm6002764wmj.28.2024.02.22.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:21:55 -0800 (PST)
Message-ID: <4dd214f91d4783f29b03908cc0034156253889a7.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:42 +0000
Subject: [PATCH v2 03/11] Start reporting missing commits in
 `repo_in_merge_bases_many()`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Some functions in Git's source code follow the convention that returning
a negative value indicates a fatal error, e.g. repository corruption.

Let's use this convention in `repo_in_merge_bases()` to report when one
of the specified commits is missing (i.e. when `repo_parse_commit()`
reports an error).

Also adjust the callers of `repo_in_merge_bases()` to handle such
negative return values.

Note: As of this patch, errors are returned only if any of the specified
merge heads is missing. Over the course of the next patches, missing
commits will also be reported by the `paint_down_to_common()` function,
which is called by `repo_in_merge_bases_many()`, and those errors will
be properly propagated back to the caller at that stage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch.c       | 12 +++++--
 builtin/fast-import.c  |  6 +++-
 builtin/fetch.c        |  2 ++
 builtin/log.c          |  7 ++--
 builtin/merge-base.c   |  6 +++-
 builtin/pull.c         |  4 +++
 builtin/receive-pack.c |  6 +++-
 commit-reach.c         | 12 ++++---
 http-push.c            |  5 ++-
 merge-ort.c            | 81 ++++++++++++++++++++++++++++++++++++------
 merge-recursive.c      | 54 +++++++++++++++++++++++-----
 shallow.c              | 18 ++++++----
 12 files changed, 175 insertions(+), 38 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index e7ee9bd0f15..7f9e79237f3 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -161,6 +161,8 @@ static int branch_merged(int kind, const char *name,
 
 	merged = reference_rev ? repo_in_merge_bases(the_repository, rev,
 						     reference_rev) : 0;
+	if (merged < 0)
+		exit(128);
 
 	/*
 	 * After the safety valve is fully redefined to "check with
@@ -169,9 +171,13 @@ static int branch_merged(int kind, const char *name,
 	 * any of the following code, but during the transition period,
 	 * a gentle reminder is in order.
 	 */
-	if ((head_rev != reference_rev) &&
-	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0) != merged) {
-		if (merged)
+	if (head_rev != reference_rev) {
+		int expect = head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) : 0;
+		if (expect < 0)
+			exit(128);
+		if (expect == merged)
+			; /* okay */
+		else if (merged)
 			warning(_("deleting branch '%s' that has been merged to\n"
 				"         '%s', but not yet merged to HEAD"),
 				name, reference_name);
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 444f41cf8ca..14c2efa88fc 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -1625,6 +1625,7 @@ static int update_branch(struct branch *b)
 		oidclr(&old_oid);
 	if (!force_update && !is_null_oid(&old_oid)) {
 		struct commit *old_cmit, *new_cmit;
+		int ret;
 
 		old_cmit = lookup_commit_reference_gently(the_repository,
 							  &old_oid, 0);
@@ -1633,7 +1634,10 @@ static int update_branch(struct branch *b)
 		if (!old_cmit || !new_cmit)
 			return error("Branch %s is missing commits.", b->name);
 
-		if (!repo_in_merge_bases(the_repository, old_cmit, new_cmit)) {
+		ret = repo_in_merge_bases(the_repository, old_cmit, new_cmit);
+		if (ret < 0)
+			exit(128);
+		if (!ret) {
 			warning("Not updating %s"
 				" (new tip %s does not contain %s)",
 				b->name, oid_to_hex(&b->oid),
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fd134ba74d9..0584a1f8b64 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -978,6 +978,8 @@ static int update_local_ref(struct ref *ref,
 		uint64_t t_before = getnanotime();
 		fast_forward = repo_in_merge_bases(the_repository, current,
 						   updated);
+		if (fast_forward < 0)
+			exit(128);
 		forced_updates_ms += (getnanotime() - t_before) / 1000000;
 	} else {
 		fast_forward = 1;
diff --git a/builtin/log.c b/builtin/log.c
index ba775d7b5cf..1705da71aca 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1623,7 +1623,7 @@ static struct commit *get_base_commit(const char *base_commit,
 {
 	struct commit *base = NULL;
 	struct commit **rev;
-	int i = 0, rev_nr = 0, auto_select, die_on_failure;
+	int i = 0, rev_nr = 0, auto_select, die_on_failure, ret;
 
 	switch (auto_base) {
 	case AUTO_BASE_NEVER:
@@ -1723,7 +1723,10 @@ static struct commit *get_base_commit(const char *base_commit,
 		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
-	if (!repo_in_merge_bases(the_repository, base, rev[0])) {
+	ret = repo_in_merge_bases(the_repository, base, rev[0]);
+	if (ret < 0)
+		exit(128);
+	if (!ret) {
 		if (die_on_failure) {
 			die(_("base commit should be the ancestor of revision list"));
 		} else {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e68b7fe45d7..0308fd73289 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -103,12 +103,16 @@ static int handle_octopus(int count, const char **args, int show_all)
 static int handle_is_ancestor(int argc, const char **argv)
 {
 	struct commit *one, *two;
+	int ret;
 
 	if (argc != 2)
 		die("--is-ancestor takes exactly two commits");
 	one = get_commit_reference(argv[0]);
 	two = get_commit_reference(argv[1]);
-	if (repo_in_merge_bases(the_repository, one, two))
+	ret = repo_in_merge_bases(the_repository, one, two);
+	if (ret < 0)
+		exit(128);
+	if (ret)
 		return 0;
 	else
 		return 1;
diff --git a/builtin/pull.c b/builtin/pull.c
index be2b2c9ebc9..e6f2942c0c5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -931,6 +931,8 @@ static int get_can_ff(struct object_id *orig_head,
 	merge_head = lookup_commit_reference(the_repository, orig_merge_head);
 	ret = repo_is_descendant_of(the_repository, merge_head, list);
 	free_commit_list(list);
+	if (ret < 0)
+		exit(128);
 	return ret;
 }
 
@@ -955,6 +957,8 @@ static int already_up_to_date(struct object_id *orig_head,
 		commit_list_insert(theirs, &list);
 		ok = repo_is_descendant_of(the_repository, ours, list);
 		free_commit_list(list);
+		if (ok < 0)
+			exit(128);
 		if (!ok)
 			return 0;
 	}
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8c4f0cb90a9..956fea6293e 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1546,6 +1546,7 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 	    starts_with(name, "refs/heads/")) {
 		struct object *old_object, *new_object;
 		struct commit *old_commit, *new_commit;
+		int ret2;
 
 		old_object = parse_object(the_repository, old_oid);
 		new_object = parse_object(the_repository, new_oid);
@@ -1559,7 +1560,10 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 		old_commit = (struct commit *)old_object;
 		new_commit = (struct commit *)new_object;
-		if (!repo_in_merge_bases(the_repository, old_commit, new_commit)) {
+		ret2 = repo_in_merge_bases(the_repository, old_commit, new_commit);
+		if (ret2 < 0)
+			exit(128);
+		if (!ret2) {
 			rp_error("denying non-fast-forward %s"
 				 " (you should pull first)", name);
 			ret = "non-fast-forward";
diff --git a/commit-reach.c b/commit-reach.c
index ba2df8b8f3a..5ff71d72d51 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -464,11 +464,13 @@ int repo_is_descendant_of(struct repository *r,
 	} else {
 		while (with_commit) {
 			struct commit *other;
+			int ret;
 
 			other = with_commit->item;
 			with_commit = with_commit->next;
-			if (repo_in_merge_bases_many(r, other, 1, &commit, 0))
-				return 1;
+			ret = repo_in_merge_bases_many(r, other, 1, &commit, 0);
+			if (ret)
+				return ret;
 		}
 		return 0;
 	}
@@ -486,10 +488,10 @@ int repo_in_merge_bases_many(struct repository *r, struct commit *commit,
 	timestamp_t generation, max_generation = GENERATION_NUMBER_ZERO;
 
 	if (repo_parse_commit(r, commit))
-		return ret;
+		return ignore_missing_commits ? 0 : -1;
 	for (i = 0; i < nr_reference; i++) {
 		if (repo_parse_commit(r, reference[i]))
-			return ret;
+			return ignore_missing_commits ? 0 : -1;
 
 		generation = commit_graph_generation(reference[i]);
 		if (generation > max_generation)
@@ -598,6 +600,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	commit_list_insert(old_commit, &old_commit_list);
 	ret = repo_is_descendant_of(the_repository,
 				    new_commit, old_commit_list);
+	if (ret < 0)
+		exit(128);
 	free_commit_list(old_commit_list);
 	return ret;
 }
diff --git a/http-push.c b/http-push.c
index a704f490fdb..24c16a4f5ff 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1576,8 +1576,11 @@ static int verify_merge_base(struct object_id *head_oid, struct ref *remote)
 	struct commit *head = lookup_commit_or_die(head_oid, "HEAD");
 	struct commit *branch = lookup_commit_or_die(&remote->old_oid,
 						     remote->name);
+	int ret = repo_in_merge_bases(the_repository, branch, head);
 
-	return repo_in_merge_bases(the_repository, branch, head);
+	if (ret < 0)
+		exit(128);
+	return ret;
 }
 
 static int delete_remote_branch(const char *pattern, int force)
diff --git a/merge-ort.c b/merge-ort.c
index 6491070d965..9f3af46333a 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -544,6 +544,7 @@ enum conflict_and_info_types {
 	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
 	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
 	CONFLICT_SUBMODULE_NULL_MERGE_BASE,
+	CONFLICT_SUBMODULE_CORRUPT,
 
 	/* Keep this entry _last_ in the list */
 	NB_CONFLICT_TYPES,
@@ -596,7 +597,9 @@ static const char *type_short_descriptions[] = {
 	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
 		"CONFLICT (submodule may have rewinds)",
 	[CONFLICT_SUBMODULE_NULL_MERGE_BASE] =
-		"CONFLICT (submodule lacks merge base)"
+		"CONFLICT (submodule lacks merge base)",
+	[CONFLICT_SUBMODULE_CORRUPT] =
+		"CONFLICT (submodule corrupt)"
 };
 
 struct logical_conflict_info {
@@ -1710,7 +1713,14 @@ static int find_first_merges(struct repository *repo,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (repo_in_merge_bases(repo, b, commit))
+		int ret = repo_in_merge_bases(repo, b, commit);
+
+		if (ret < 0) {
+			object_array_clear(&merges);
+			release_revisions(&revs);
+			return ret;
+		}
+		if (ret > 0)
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -1725,9 +1735,17 @@ static int find_first_merges(struct repository *repo,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && repo_in_merge_bases(repo, m2, m1)) {
-				contains_another = 1;
-				break;
+			if (i != j) {
+				int ret = repo_in_merge_bases(repo, m2, m1);
+				if (ret < 0) {
+					object_array_clear(&merges);
+					release_revisions(&revs);
+					return ret;
+				}
+				if (ret > 0) {
+					contains_another = 1;
+					break;
+				}
 			}
 		}
 
@@ -1749,7 +1767,7 @@ static int merge_submodule(struct merge_options *opt,
 {
 	struct repository subrepo;
 	struct strbuf sb = STRBUF_INIT;
-	int ret = 0;
+	int ret = 0, ret2;
 	struct commit *commit_o, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
@@ -1796,8 +1814,26 @@ static int merge_submodule(struct merge_options *opt,
 	}
 
 	/* check whether both changes are forward */
-	if (!repo_in_merge_bases(&subrepo, commit_o, commit_a) ||
-	    !repo_in_merge_bases(&subrepo, commit_o, commit_b)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_a);
+	if (ret2 < 0) {
+		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s "
+			   "(repository corrupt)"),
+			 path);
+		goto cleanup;
+	}
+	if (ret2 > 0)
+		ret2 = repo_in_merge_bases(&subrepo, commit_o, commit_b);
+	if (ret2 < 0) {
+		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s "
+			   "(repository corrupt)"),
+			 path);
+		goto cleanup;
+	}
+	if (!ret2) {
 		path_msg(opt, CONFLICT_SUBMODULE_MAY_HAVE_REWINDS, 0,
 			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s "
@@ -1807,7 +1843,16 @@ static int merge_submodule(struct merge_options *opt,
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
+	if (ret2 < 0) {
+		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s "
+			   "(repository corrupt)"),
+			 path);
+		goto cleanup;
+	}
+	if (ret2 > 0) {
 		oidcpy(result, b);
 		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
 			 path, NULL, NULL, NULL,
@@ -1816,7 +1861,16 @@ static int merge_submodule(struct merge_options *opt,
 		ret = 1;
 		goto cleanup;
 	}
-	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
+	if (ret2 < 0) {
+		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s "
+			   "(repository corrupt)"),
+			 path);
+		goto cleanup;
+	}
+	if (ret2 > 0) {
 		oidcpy(result, a);
 		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
 			 path, NULL, NULL, NULL,
@@ -1841,6 +1895,13 @@ static int merge_submodule(struct merge_options *opt,
 	parent_count = find_first_merges(&subrepo, path, commit_a, commit_b,
 					 &merges);
 	switch (parent_count) {
+	case -1:
+		path_msg(opt, CONFLICT_SUBMODULE_CORRUPT, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s "
+			   "(repository corrupt)"),
+			 path);
+		break;
 	case 0:
 		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE, 0,
 			 path, NULL, NULL, NULL,
diff --git a/merge-recursive.c b/merge-recursive.c
index e3beb0801b1..0d931cc14ad 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1144,7 +1144,13 @@ static int find_first_merges(struct repository *repo,
 		die("revision walk setup failed");
 	while ((commit = get_revision(&revs)) != NULL) {
 		struct object *o = &(commit->object);
-		if (repo_in_merge_bases(repo, b, commit))
+		int ret = repo_in_merge_bases(repo, b, commit);
+		if (ret < 0) {
+			object_array_clear(&merges);
+			release_revisions(&revs);
+			return ret;
+		}
+		if (ret)
 			add_object_array(o, NULL, &merges);
 	}
 	reset_revision_walk();
@@ -1159,9 +1165,17 @@ static int find_first_merges(struct repository *repo,
 		contains_another = 0;
 		for (j = 0; j < merges.nr; j++) {
 			struct commit *m2 = (struct commit *) merges.objects[j].item;
-			if (i != j && repo_in_merge_bases(repo, m2, m1)) {
-				contains_another = 1;
-				break;
+			if (i != j) {
+				int ret = repo_in_merge_bases(repo, m2, m1);
+				if (ret < 0) {
+					object_array_clear(&merges);
+					release_revisions(&revs);
+					return ret;
+				}
+				if (ret > 0) {
+					contains_another = 1;
+					break;
+				}
 			}
 		}
 
@@ -1197,7 +1211,7 @@ static int merge_submodule(struct merge_options *opt,
 			   const struct object_id *b)
 {
 	struct repository subrepo;
-	int ret = 0;
+	int ret = 0, ret2;
 	struct commit *commit_base, *commit_a, *commit_b;
 	int parent_count;
 	struct object_array merges;
@@ -1234,14 +1248,29 @@ static int merge_submodule(struct merge_options *opt,
 	}
 
 	/* check whether both changes are forward */
-	if (!repo_in_merge_bases(&subrepo, commit_base, commit_a) ||
-	    !repo_in_merge_bases(&subrepo, commit_base, commit_b)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_a);
+	if (ret2 < 0) {
+		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		goto cleanup;
+	}
+	if (ret2 > 0)
+		ret2 = repo_in_merge_bases(&subrepo, commit_base, commit_b);
+	if (ret2 < 0) {
+		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		goto cleanup;
+	}
+	if (!ret2) {
 		output(opt, 1, _("Failed to merge submodule %s (commits don't follow merge-base)"), path);
 		goto cleanup;
 	}
 
 	/* Case #1: a is contained in b or vice versa */
-	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_a, commit_b);
+	if (ret2 < 0) {
+		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		goto cleanup;
+	}
+	if (ret2) {
 		oidcpy(result, b);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
@@ -1254,7 +1283,12 @@ static int merge_submodule(struct merge_options *opt,
 		ret = 1;
 		goto cleanup;
 	}
-	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
+	ret2 = repo_in_merge_bases(&subrepo, commit_b, commit_a);
+	if (ret2 < 0) {
+		output(opt, 1, _("Failed to merge submodule %s (repository corrupt)"), path);
+		goto cleanup;
+	}
+	if (ret2) {
 		oidcpy(result, a);
 		if (show(opt, 3)) {
 			output(opt, 3, _("Fast-forwarding submodule %s to the following commit:"), path);
@@ -1402,6 +1436,8 @@ static int merge_mode_and_contents(struct merge_options *opt,
 							&o->oid,
 							&a->oid,
 							&b->oid);
+			if (result->clean < 0)
+				return -1;
 		} else if (S_ISLNK(a->mode)) {
 			switch (opt->recursive_variant) {
 			case MERGE_VARIANT_NORMAL:
diff --git a/shallow.c b/shallow.c
index dfcc1f86a7f..f71496f35c3 100644
--- a/shallow.c
+++ b/shallow.c
@@ -795,12 +795,16 @@ static void post_assign_shallow(struct shallow_info *info,
 		if (!*bitmap)
 			continue;
 		for (j = 0; j < bitmap_nr; j++)
-			if (bitmap[0][j] &&
-			    /* Step 7, reachability test at commit level */
-			    !repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1)) {
-				update_refstatus(ref_status, info->ref->nr, *bitmap);
-				dst++;
-				break;
+			if (bitmap[0][j]) {
+				/* Step 7, reachability test at commit level */
+				int ret = repo_in_merge_bases_many(the_repository, c, ca.nr, ca.commits, 1);
+				if (ret < 0)
+					exit(128);
+				if (!ret) {
+					update_refstatus(ref_status, info->ref->nr, *bitmap);
+					dst++;
+					break;
+				}
 			}
 	}
 	info->nr_ours = dst;
@@ -830,6 +834,8 @@ int delayed_reachability_test(struct shallow_info *si, int c)
 							    si->nr_commits,
 							    si->commits,
 							    1);
+		if (si->reachable[c] < 0)
+			exit(128);
 		si->need_reachability_test[c] = 0;
 	}
 	return si->reachable[c];
-- 
gitgitgadget

