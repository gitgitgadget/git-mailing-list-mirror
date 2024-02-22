Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072E1332B7
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 13:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608126; cv=none; b=jZ5tvg2Lw67+KD/2F0Ic32LD6x6bzN+guadV8UXhZoGnJMLhr25KQSjK1BC+CX6SAiS3JeqC8Nz7DFt5YihswwtD+1eRsRVPTJC2kKi3GuYiJomO+v2I9zzuLpHhZi5dQJIYfe5C9Buya0iE/xaLX0X6xVOSqjlozQFiD6tpfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608126; c=relaxed/simple;
	bh=k82XXytIOf1iUdIbwqVKYDEdc+wyvr0BoBxa3J3j5h0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j7bVDiV5lLc17I+QPQ4h+KG1UsMRmrc3yZKR7DFSpWsJoxbGbZflQrw5Xc34rq39fuScsgjQEtTzh4xS7DfgzxOBb2XHVUieF/izSzcHHw66b9uExcsi8lbQldoLdNDqVJocL+Qqpd0i/tn7Q5Rl/HVlOhlNTirOyYx8PQmyTfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeJvBRl1; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeJvBRl1"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d094bc2244so107267761fa.1
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 05:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708608122; x=1709212922; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1P9ivwVvGfGXy67eLQ3BFxWbwUzX4jOeNotuFovadI=;
        b=JeJvBRl1DmWocjEgrx2LLfJAQW1LZiGTlJ62RvF6kFkV1DUehJyVMxHwLExGp9P3Bu
         IiqPy07+0j7ka03RTBlJxc3wTD5r9NJvNUPADho+moy5BlfZRAd1qHYLy+KReQudpUbN
         keQY76V4Be2k4ggf8VQ4ELYcEY+BnrOL1D82lpoQmOklHnI1BsM1gr9dYm6MZIp1HJb9
         dI7vjEhV35+l3ds0VHsWk/8+2Sat9EAPLiR5mc6REHwzL7acPb7uIGg2BN1sZj0ElwVD
         kbJbkEpJDF3jlS0PkqtLaP0zqt2MMeOuiVb5UBBJjqxNgeP4Ye0sS065z3h/dahMuNG4
         rrqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708608122; x=1709212922;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1P9ivwVvGfGXy67eLQ3BFxWbwUzX4jOeNotuFovadI=;
        b=YcV4t2t6QXeD4cRPrzXayy64JEDWoWohVl4D4s4i5xjx7YrDHSXo5+MHteUiICIb5g
         6JBhZQcO3BOVhCdRQHNdhFo/GOzPY8rN342ADB8GP0FaadrtRI2++ujproI5pt2pI9Li
         rA3RCoOQZS3xj1hBmimKZ6VhPHR01+KaxSlCeLEAsN2brxj2P1HXi2J51OJzX7t4XQM8
         QypB5Wpq/SuNuawoSqc4p2w8JGpTYQv5d9AJOMCRgFFO1L6KKhQVun8BihbLIpM7QUbu
         tq1SKNKfoX8FyXpuKnEEYVsYgj6MIJbkhLHFWyL4HwnS9+vh2p8Y934gqYCakcURG+fB
         UUeA==
X-Gm-Message-State: AOJu0YxUVr1xi3sUmTIb7kV+NZRdNBvYz7ap09+fwP1vXZpTk37Cx9pL
	h9r2U5o93JZ8+s/u+JhjoB3D5Yy3WOXWtJBcyIZgiGok6p4DaHoE5EYKxZ2S
X-Google-Smtp-Source: AGHT+IH8fVWY7okieSKGDhGI7kyZ+qGjWabC++hN775zgZR/hk56SCJqYPSnS7jjjbIaYXb/6uFNcQ==
X-Received: by 2002:a2e:8057:0:b0:2d2:3891:b43 with SMTP id p23-20020a2e8057000000b002d238910b43mr8036384ljg.27.1708608121569;
        Thu, 22 Feb 2024 05:22:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b004128c73beffsm1415835wmo.34.2024.02.22.05.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:22:00 -0800 (PST)
Message-ID: <9ca504525b96fdeb20adb41ef02626b8ed12bff8.1708608110.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
References: <pull.1657.git.1707813709.gitgitgadget@gmail.com>
	<pull.1657.v2.git.1708608110.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 13:21:47 +0000
Subject: [PATCH v2 08/11] repo_get_merge_bases(): pass on errors from
 `merge_bases_many()`
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

The `merge_bases_many()` function was just taught to indicate parsing
errors, and now the `repo_get_merge_bases()` function (which is also
surfaced via the `repo_get_merge_bases()` macro) is aware of that, too.

Naturally, there are a lot of callers that need to be adjusted now, too.

Next step: adjust the callers of `get_octopus_merge_bases()`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c                    | 10 +++++-----
 builtin/merge-tree.c             |  5 +++--
 builtin/merge.c                  | 20 ++++++++++++--------
 builtin/rebase.c                 |  8 +++++---
 builtin/rev-parse.c              |  5 +++--
 commit-reach.c                   | 23 +++++++++++------------
 commit-reach.h                   |  7 ++++---
 diff-lib.c                       |  5 +++--
 log-tree.c                       |  5 +++--
 merge-ort.c                      |  6 +++++-
 merge-recursive.c                |  4 +++-
 notes-merge.c                    |  3 ++-
 object-name.c                    |  7 +++++--
 revision.c                       | 12 ++++++++----
 sequencer.c                      |  8 ++++++--
 submodule.c                      |  7 ++++++-
 t/t4301-merge-tree-write-tree.sh | 12 ++++++++++++
 17 files changed, 96 insertions(+), 51 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 1705da71aca..befafd6ae04 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1702,11 +1702,11 @@ static struct commit *get_base_commit(const char *base_commit,
 	 */
 	while (rev_nr > 1) {
 		for (i = 0; i < rev_nr / 2; i++) {
-			struct commit_list *merge_base;
-			merge_base = repo_get_merge_bases(the_repository,
-							  rev[2 * i],
-							  rev[2 * i + 1]);
-			if (!merge_base || merge_base->next) {
+			struct commit_list *merge_base = NULL;
+			if (repo_get_merge_bases(the_repository,
+						 rev[2 * i],
+						 rev[2 * i + 1], &merge_base) < 0 ||
+			    !merge_base || merge_base->next) {
 				if (die_on_failure) {
 					die(_("failed to find exact merge base"));
 				} else {
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index a35e0452d66..76200250629 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -463,8 +463,9 @@ static int real_merge(struct merge_tree_options *o,
 		 * Get the merge bases, in reverse order; see comment above
 		 * merge_incore_recursive in merge-ort.h
 		 */
-		merge_bases = repo_get_merge_bases(the_repository, parent1,
-						   parent2);
+		if (repo_get_merge_bases(the_repository, parent1,
+					 parent2, &merge_bases) < 0)
+			exit(128);
 		if (!merge_bases && !o->allow_unrelated_histories)
 			die(_("refusing to merge unrelated histories"));
 		merge_bases = reverse_commit_list(merge_bases);
diff --git a/builtin/merge.c b/builtin/merge.c
index d748d46e135..ac9d58adc29 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1517,10 +1517,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 
 	if (!remoteheads)
 		; /* already up-to-date */
-	else if (!remoteheads->next)
-		common = repo_get_merge_bases(the_repository, head_commit,
-					      remoteheads->item);
-	else {
+	else if (!remoteheads->next) {
+		if (repo_get_merge_bases(the_repository, head_commit,
+					 remoteheads->item, &common) < 0) {
+			ret = 2;
+			goto done;
+		}
+	} else {
 		struct commit_list *list = remoteheads;
 		commit_list_insert(head_commit, &list);
 		common = get_octopus_merge_bases(list);
@@ -1631,7 +1634,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		struct commit_list *j;
 
 		for (j = remoteheads; j; j = j->next) {
-			struct commit_list *common_one;
+			struct commit_list *common_one = NULL;
 			struct commit *common_item;
 
 			/*
@@ -1639,9 +1642,10 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * merge_bases again, otherwise "git merge HEAD^
 			 * HEAD^^" would be missed.
 			 */
-			common_one = repo_get_merge_bases(the_repository,
-							  head_commit,
-							  j->item);
+			if (repo_get_merge_bases(the_repository, head_commit,
+						 j->item, &common_one) < 0)
+				exit(128);
+
 			common_item = common_one->item;
 			free_commit_list(common_one);
 			if (!oideq(&common_item->object.oid, &j->item->object.oid)) {
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 043c65dccd9..06a55fc7325 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -879,7 +879,8 @@ static int can_fast_forward(struct commit *onto, struct commit *upstream,
 	if (!upstream)
 		goto done;
 
-	merge_bases = repo_get_merge_bases(the_repository, upstream, head);
+	if (repo_get_merge_bases(the_repository, upstream, head, &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases || merge_bases->next)
 		goto done;
 
@@ -898,8 +899,9 @@ static void fill_branch_base(struct rebase_options *options,
 {
 	struct commit_list *merge_bases = NULL;
 
-	merge_bases = repo_get_merge_bases(the_repository, options->onto,
-					   options->orig_head);
+	if (repo_get_merge_bases(the_repository, options->onto,
+				 options->orig_head, &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases || merge_bases->next)
 		oidcpy(branch_base, null_oid());
 	else
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index fde8861ca4e..c97d0f6144c 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -297,7 +297,7 @@ static int try_difference(const char *arg)
 		show_rev(NORMAL, &end_oid, end);
 		show_rev(symmetric ? NORMAL : REVERSED, &start_oid, start);
 		if (symmetric) {
-			struct commit_list *exclude;
+			struct commit_list *exclude = NULL;
 			struct commit *a, *b;
 			a = lookup_commit_reference(the_repository, &start_oid);
 			b = lookup_commit_reference(the_repository, &end_oid);
@@ -305,7 +305,8 @@ static int try_difference(const char *arg)
 				*dotdot = '.';
 				return 0;
 			}
-			exclude = repo_get_merge_bases(the_repository, a, b);
+			if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0)
+				exit(128);
 			while (exclude) {
 				struct commit *commit = pop_commit(&exclude);
 				show_rev(REVERSED, &commit->object.oid, NULL);
diff --git a/commit-reach.c b/commit-reach.c
index 5fa0abc7d1e..10e625ff51b 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -189,9 +189,12 @@ struct commit_list *get_octopus_merge_bases(struct commit_list *in)
 		struct commit_list *new_commits = NULL, *end = NULL;
 
 		for (j = ret; j; j = j->next) {
-			struct commit_list *bases;
-			bases = repo_get_merge_bases(the_repository, i->item,
-						     j->item);
+			struct commit_list *bases = NULL;
+			if (repo_get_merge_bases(the_repository, i->item,
+						 j->item, &bases) < 0) {
+				free_commit_list(bases);
+				return NULL;
+			}
 			if (!new_commits)
 				new_commits = bases;
 			else
@@ -483,16 +486,12 @@ struct commit_list *repo_get_merge_bases_many_dirty(struct repository *r,
 	return result;
 }
 
-struct commit_list *repo_get_merge_bases(struct repository *r,
-					 struct commit *one,
-					 struct commit *two)
+int repo_get_merge_bases(struct repository *r,
+			 struct commit *one,
+			 struct commit *two,
+			 struct commit_list **result)
 {
-	struct commit_list *result = NULL;
-	if (get_merge_bases_many_0(r, one, 1, &two, 1, &result) < 0) {
-		free_commit_list(result);
-		return NULL;
-	}
-	return result;
+	return get_merge_bases_many_0(r, one, 1, &two, 1, result);
 }
 
 /*
diff --git a/commit-reach.h b/commit-reach.h
index 68f81549a44..2c6fcdd34f6 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -9,9 +9,10 @@ struct ref_filter;
 struct object_id;
 struct object_array;
 
-struct commit_list *repo_get_merge_bases(struct repository *r,
-					 struct commit *rev1,
-					 struct commit *rev2);
+int repo_get_merge_bases(struct repository *r,
+			 struct commit *rev1,
+			 struct commit *rev2,
+			 struct commit_list **result);
 struct commit_list *repo_get_merge_bases_many(struct repository *r,
 					      struct commit *one, int n,
 					      struct commit **twos);
diff --git a/diff-lib.c b/diff-lib.c
index 0e9ec4f68af..498224ccce2 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -565,7 +565,7 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 {
 	int i;
 	struct commit *mb_child[2] = {0};
-	struct commit_list *merge_bases;
+	struct commit_list *merge_bases = NULL;
 
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
@@ -592,7 +592,8 @@ void diff_get_merge_base(const struct rev_info *revs, struct object_id *mb)
 		mb_child[1] = lookup_commit_reference(the_repository, &oid);
 	}
 
-	merge_bases = repo_get_merge_bases(the_repository, mb_child[0], mb_child[1]);
+	if (repo_get_merge_bases(the_repository, mb_child[0], mb_child[1], &merge_bases) < 0)
+		exit(128);
 	if (!merge_bases)
 		die(_("no merge base found"));
 	if (merge_bases->next)
diff --git a/log-tree.c b/log-tree.c
index 504da6b519e..4f337766a39 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1010,7 +1010,7 @@ static int do_remerge_diff(struct rev_info *opt,
 			   struct object_id *oid)
 {
 	struct merge_options o;
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	struct merge_result res = {0};
 	struct pretty_print_context ctx = {0};
 	struct commit *parent1 = parents->item;
@@ -1035,7 +1035,8 @@ static int do_remerge_diff(struct rev_info *opt,
 	/* Parse the relevant commits and get the merge bases */
 	parse_commit_or_die(parent1);
 	parse_commit_or_die(parent2);
-	bases = repo_get_merge_bases(the_repository, parent1, parent2);
+	if (repo_get_merge_bases(the_repository, parent1, parent2, &bases) < 0)
+		exit(128);
 
 	/* Re-merge the parents */
 	merge_incore_recursive(&o, bases, parent1, parent2, &res);
diff --git a/merge-ort.c b/merge-ort.c
index 9f3af46333a..90d8495ca1f 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5066,7 +5066,11 @@ static void merge_ort_internal(struct merge_options *opt,
 	struct strbuf merge_base_abbrev = STRBUF_INIT;
 
 	if (!merge_bases) {
-		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
+		if (repo_get_merge_bases(the_repository, h1, h2,
+					 &merge_bases) < 0) {
+			result->clean = -1;
+			return;
+		}
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
 		merge_bases = reverse_commit_list(merge_bases);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index 0d931cc14ad..d609373d960 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3638,7 +3638,9 @@ static int merge_recursive_internal(struct merge_options *opt,
 	}
 
 	if (!merge_bases) {
-		merge_bases = repo_get_merge_bases(the_repository, h1, h2);
+		if (repo_get_merge_bases(the_repository, h1, h2,
+					 &merge_bases) < 0)
+			return -1;
 		merge_bases = reverse_commit_list(merge_bases);
 	}
 
diff --git a/notes-merge.c b/notes-merge.c
index 8799b522a55..51282934ae6 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -607,7 +607,8 @@ int notes_merge(struct notes_merge_options *o,
 	assert(local && remote);
 
 	/* Find merge bases */
-	bases = repo_get_merge_bases(the_repository, local, remote);
+	if (repo_get_merge_bases(the_repository, local, remote, &bases) < 0)
+		exit(128);
 	if (!bases) {
 		base_oid = null_oid();
 		base_tree_oid = the_hash_algo->empty_tree;
diff --git a/object-name.c b/object-name.c
index 0bfa29dbbfe..63bec6d9a2b 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1481,7 +1481,7 @@ int repo_get_oid_mb(struct repository *r,
 		    struct object_id *oid)
 {
 	struct commit *one, *two;
-	struct commit_list *mbs;
+	struct commit_list *mbs = NULL;
 	struct object_id oid_tmp;
 	const char *dots;
 	int st;
@@ -1509,7 +1509,10 @@ int repo_get_oid_mb(struct repository *r,
 	two = lookup_commit_reference_gently(r, &oid_tmp, 0);
 	if (!two)
 		return -1;
-	mbs = repo_get_merge_bases(r, one, two);
+	if (repo_get_merge_bases(r, one, two, &mbs) < 0) {
+		free_commit_list(mbs);
+		return -1;
+	}
 	if (!mbs || mbs->next)
 		st = -1;
 	else {
diff --git a/revision.c b/revision.c
index 00d5c29bfce..eb0d550842f 100644
--- a/revision.c
+++ b/revision.c
@@ -1965,7 +1965,7 @@ static void add_pending_commit_list(struct rev_info *revs,
 
 static void prepare_show_merge(struct rev_info *revs)
 {
-	struct commit_list *bases;
+	struct commit_list *bases = NULL;
 	struct commit *head, *other;
 	struct object_id oid;
 	const char **prune = NULL;
@@ -1980,7 +1980,8 @@ static void prepare_show_merge(struct rev_info *revs)
 	other = lookup_commit_or_die(&oid, "MERGE_HEAD");
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
-	bases = repo_get_merge_bases(the_repository, head, other);
+	if (repo_get_merge_bases(the_repository, head, other, &bases) < 0)
+		exit(128);
 	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING | BOTTOM);
 	add_pending_commit_list(revs, bases, UNINTERESTING | BOTTOM);
 	free_commit_list(bases);
@@ -2068,14 +2069,17 @@ static int handle_dotdot_1(const char *arg, char *dotdot,
 	} else {
 		/* A...B -- find merge bases between the two */
 		struct commit *a, *b;
-		struct commit_list *exclude;
+		struct commit_list *exclude = NULL;
 
 		a = lookup_commit_reference(revs->repo, &a_obj->oid);
 		b = lookup_commit_reference(revs->repo, &b_obj->oid);
 		if (!a || !b)
 			return dotdot_missing(arg, dotdot, revs, symmetric);
 
-		exclude = repo_get_merge_bases(the_repository, a, b);
+		if (repo_get_merge_bases(the_repository, a, b, &exclude) < 0) {
+			free_commit_list(exclude);
+			return -1;
+		}
 		add_rev_cmdline_list(revs, exclude, REV_CMD_MERGE_BASE,
 				     flags_exclude);
 		add_pending_commit_list(revs, exclude, flags_exclude);
diff --git a/sequencer.c b/sequencer.c
index d584cac8ed9..4417f2f1956 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3913,7 +3913,7 @@ static int do_merge(struct repository *r,
 	int run_commit_flags = 0;
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
-	struct commit_list *bases, *j;
+	struct commit_list *bases = NULL, *j;
 	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	const char *strategy = !opts->xopts.nr &&
 		(!opts->strategy ||
@@ -4139,7 +4139,11 @@ static int do_merge(struct repository *r,
 	}
 
 	merge_commit = to_merge->item;
-	bases = repo_get_merge_bases(r, head_commit, merge_commit);
+	if (repo_get_merge_bases(r, head_commit, merge_commit, &bases) < 0) {
+		ret = -1;
+		goto leave_merge;
+	}
+
 	if (bases && oideq(&merge_commit->object.oid,
 			   &bases->item->object.oid)) {
 		ret = 0;
diff --git a/submodule.c b/submodule.c
index e603a19a876..04931a5474b 100644
--- a/submodule.c
+++ b/submodule.c
@@ -595,7 +595,12 @@ static void show_submodule_header(struct diff_options *o,
 	     (!is_null_oid(two) && !*right))
 		message = "(commits not present)";
 
-	*merge_bases = repo_get_merge_bases(sub, *left, *right);
+	*merge_bases = NULL;
+	if (repo_get_merge_bases(sub, *left, *right, merge_bases) < 0) {
+		message = "(corrupt repository)";
+		goto output_header;
+	}
+
 	if (*merge_bases) {
 		if ((*merge_bases)->item == *left)
 			fast_forward = 1;
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index b2c8a43fce3..5d1e7aca4c8 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -945,4 +945,16 @@ test_expect_success 'check the input format when --stdin is passed' '
 	test_cmp expect actual
 '
 
+test_expect_success 'error out on missing commits as well' '
+	git init --bare missing-commit.git &&
+	git rev-list --objects side1 side3 >list-including-initial &&
+	grep -v ^$(git rev-parse side1^) <list-including-initial >list &&
+	git pack-objects missing-commit.git/objects/pack/missing-initial <list &&
+	side1=$(git rev-parse side1) &&
+	side3=$(git rev-parse side3) &&
+	test_must_fail git --git-dir=missing-commit.git \
+		merge-tree --allow-unrelated-histories $side1 $side3 >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

