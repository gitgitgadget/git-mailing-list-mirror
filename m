Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B541443B
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566415; cv=none; b=OGfxA/dmNbdhin9slXIKqgZjhNURIpkl4jnvvsQLZwYfl6ZkYyNV8BZWgxpC/xJ/Qo6jVNJ9D0hfyrWgP0ZUGQGAOKc+lyRUf0GjrfIl93RGLVTvblR7RwMd+fQflQG67VVEfOg4pjxDjd5EnrGU/ndvq2+41EWgYrWIU88AOkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566415; c=relaxed/simple;
	bh=jhp4/vLTplitrmfYw/BWhpRIJbroAqTBhcRibXrVuxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kEgwjrzjKmXkzz/Zlw02IfSfXb6fujCFCaWTUO8fN00CEYMnqzUkyfBktOKGHgkGhmkWt6x6LMmi/24daskGeuOzWYgblGZpW0m4k8pbx8wOIayevdEUhcfd6SgQ6753WP5u3up6DeFdwBqasniymHeZDo3sJZ9C6X4HnjePKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UC9CxsUJ; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UC9CxsUJ"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7d2bb404so3148935e9.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 06:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789566401; x=1790171201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PE8xVFMZrxRECtSuYK+QGG8o2Ut6/SELroLG3eB54aI=;
        b=UC9CxsUJnxSM0lu1kCAQ2cj7MSHhfjJ24Jp1VHXfkpOSi42/SX/BQ7dSrl5r5ueRRN
         0F9ZUhgcR/H/bu0cv9x3Insb6aHEmI435uON/hJAvBx14TDn1Dujnz3XZfQLqOmVr+nU
         FX+6RjV6v2HbN1Wwj2JiInP189w8P6ltSDBcbrHupSQXGvWAmkWMRwPsXmJAQ6nNYhIi
         W7sHOW8WPn95O3C0HjSm2nmVzNkD3Q8iaCO303xk7AsZNdH8iJSjJWRg9Diq8JyaIWhI
         K0+194K2hfsV84Uv4ukr8nS2xIaTMVqPe6fgqbPHbm9winHa9VLX4FO/5MVDnJkN1ARV
         +lYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789566401; x=1790171201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PE8xVFMZrxRECtSuYK+QGG8o2Ut6/SELroLG3eB54aI=;
        b=vM6DScSD3wqklF4NTRZXurqnxFsrwaD635439msvUclMGdnVrWKZEwKol+m5memjJL
         M8GPlf9+4WwRo5dWh+xNRNGhgCHB9KuD32dqgrsAUVEFuWXz179S3qyKKE5fIn/Do5rR
         D50upZStuJvld1RuTRvx4CRzC5hZMEoiOn9N1b7mguvjPrASCxzk097YkLP/sF5xM/1g
         TxP63SePMGCxXhiC4ZMcEFkeQk0dciB4rikz8zaUdNbMlVt7fVFG6tzjIMSll6/4nWud
         XIKWKeFX1fZejUixidyIKkjsOKu7d0RG6h/RHtgJ3gxScdvXBYJG5A5KLmD1wE53n3oV
         QMLw==
X-Gm-Message-State: AFuF++n1wlRvpeXerDCTxMDUuoD0dfM909uzzeOKcacThuBPCz+28g5u
	N3QvEvYUmffteQHRk6LOWRWFf1fUATwKENkNQpNYrmcM1T0793FzRv0lrhOPQ7g=
X-Gm-Gg: AYBFou0xdvAd4mOO8R1zPNydMGDWb+xCvt9lFl+Op4ct5t6TwZW8xXvNhoIYtrFoHn/
	qXQ1KujTkD3QxAKA+qjH5CcHIroV5PEVSgzPhktdZqp4rTlNRxBL1J+cNbj28OKOn5/iTch57YS
	ciRpuGnnAe16gK2TFRelV1CwkGLGfz5nX1+1WQRTNQwj2pn+9JvKvA3xHAr8XDKQ6SGmJptt1Vq
	Cd750Xn+/eg/OxqeZ4cLU/Oz+fGoSdKbQxqHTMpIfyRwgJOU6kSorrW09UszYEsOt1Y/fk4yQs6
	wBZIYQBAVCfAltEl4B70fwdS/4SE1ucaNuyd1WEGRuu342ltoa0E53nRbi/G8zUSeEAl/IU6bzT
	aIkQ02yk5SaDu8hC0Z30m0wUUCBIJwQL/g74rdjpcpCYXPllf+MvC3+40we48o5geMGfk9G/ieI
	3d8Qh424ZmrKzYrvPuur+xAFfhKieJ4m5mu6Dnp/anzLvqlvAKLQBzznSVGu3sZf4+v8MBmvz7t
	8Ay7c9SyhZcc25MOkaRgfRND9s2xFy/3o05b4BWTWAo0FoapsgKt6q/bSpejKxH8Kq3d9kmmtEe
	Niq6DlQ1AZc=
X-Received: by 2002:a05:600c:4f84:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e96676c4emr29498275e9.8.1789566401116;
        Wed, 16 Sep 2026 06:46:41 -0700 (PDT)
Received: from carbon.fritz.box (i689777B6.versanet.de. [104.151.119.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e847eab65sm41671875e9.2.2026.09.16.06.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:46:40 -0700 (PDT)
From: Orestis Floros <orestisflo@gmail.com>
To: git@vger.kernel.org
Cc: Florian Schmidt <flosch@nutanix.com>,
	Patrick Steinhardt <ps@pks.im>,
	Philippe Blain <levraiphilippeblain@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Orestis Floros <orestisflo@gmail.com>
Subject: [PATCH] commit-reach: parse commits in the given repository
Date: Wed, 16 Sep 2026 15:46:31 +0200
Message-ID: <20260916134632.1424829-1-orestisflo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
References: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`can_all_from_reach()` and `can_all_from_reach_with_flag()` parse the
commits they walk in `the_repository`, even though their caller may be
working in a different repository. `repo_is_descendant_of()` is such a
caller: it is told which repository to work in, but as soon as
generation numbers are enabled it hands the commits over to
`can_all_from_reach()`, which then parses them elsewhere.

This breaks merging a superproject whose submodule pointer advanced on
both sides. merge-ort resolves it by calling `repo_in_merge_bases()` on
the submodule, and with a commit-graph in both the superproject and the
submodule the merge dies:

    $ git merge side
    fatal: invalid commit position. commit-graph is likely corrupt

`merge_submodule()` looks the submodule commits up in the submodule, so
walking their ancestry pulls in parents whose commit-graph position was
recorded while reading the submodule's commit-graph. The walk then
parses those parents in `the_repository`, where the recorded position
indexes the superproject's commit-graph instead: `fill_commit_graph_info()`
dies when the position is out of bounds, and quietly returns another
commit's date, generation and parents when it is not.

The latter used to be the only symptom. Before bb5da75d61 (commit: use
commit graph in `lookup_commit_reference_gently()`, 2026-02-16) the
initial lookup did not record commit-graph positions, so the walk simply
failed to find the submodule commits in the superproject:

    error: Could not read <commit>
    Failed to merge submodule sub (commits don't follow merge-base)

Pass the repository into both functions. git-fetch-pack(1) and
git-upload-pack(1) keep passing `the_repository`.

Reported-by: Florian Schmidt <flosch@nutanix.com>
Signed-off-by: Orestis Floros <orestisflo@gmail.com>
---
 commit-reach.c             | 22 ++++++++++-----------
 commit-reach.h             |  7 ++++---
 fetch-pack.c               |  4 ++--
 t/helper/test-reach.c      |  5 +++--
 t/t6437-submodule-merge.sh | 39 ++++++++++++++++++++++++++++++++++++++
 upload-pack.c              |  6 +++---
 6 files changed, 62 insertions(+), 21 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 5df471a313..3d579d8f7f 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -572,7 +572,7 @@ int repo_is_descendant_of(struct repository *r,
 		struct commit_list *from_list = NULL;
 		int result;
 		commit_list_insert(commit, &from_list);
-		result = can_all_from_reach(from_list, with_commit, 0);
+		result = can_all_from_reach(r, from_list, with_commit, 0);
 		commit_list_free(from_list);
 		return result;
 	} else {
@@ -853,7 +853,8 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
 	return repo_is_descendant_of(the_repository, commit, list);
 }
 
-int can_all_from_reach_with_flag(struct object_array *from,
+int can_all_from_reach_with_flag(struct repository *r,
+				 struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 timestamp_t min_commit_date,
@@ -872,8 +873,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		if (!from_one || from_one->flags & assign_flag)
 			continue;
 
-		from_one = deref_tag(the_repository, from_one,
-				     "a from object", 0);
+		from_one = deref_tag(r, from_one, "a from object", 0);
 		if (!from_one || from_one->type != OBJ_COMMIT) {
 			/*
 			 * no way to tell if this is reachable by
@@ -886,7 +886,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		}
 
 		list[nr_commits] = (struct commit *)from_one;
-		if (repo_parse_commit(the_repository, list[nr_commits]) ||
+		if (repo_parse_commit(r, list[nr_commits]) ||
 		    commit_graph_generation(list[nr_commits]) < min_generation) {
 			result = 0;
 			goto cleanup;
@@ -921,7 +921,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				if (!(parent->item->object.flags & assign_flag)) {
 					parent->item->object.flags |= assign_flag;
 
-					if (repo_parse_commit(the_repository, parent->item) ||
+					if (repo_parse_commit(r, parent->item) ||
 					    parent->item->date < min_commit_date ||
 					    commit_graph_generation(parent->item) < min_generation)
 						continue;
@@ -955,8 +955,8 @@ int can_all_from_reach_with_flag(struct object_array *from,
 	return result;
 }
 
-int can_all_from_reach(struct commit_list *from, struct commit_list *to,
-		       int cutoff_by_min_date)
+int can_all_from_reach(struct repository *r, struct commit_list *from,
+		       struct commit_list *to, int cutoff_by_min_date)
 {
 	struct object_array from_objs = OBJECT_ARRAY_INIT;
 	struct commit_list *from_iter = from, *to_iter = to;
@@ -967,7 +967,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
 
-		if (!repo_parse_commit(the_repository, from_iter->item)) {
+		if (!repo_parse_commit(r, from_iter->item)) {
 			timestamp_t generation;
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
@@ -981,7 +981,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	}
 
 	while (to_iter) {
-		if (!repo_parse_commit(the_repository, to_iter->item)) {
+		if (!repo_parse_commit(r, to_iter->item)) {
 			timestamp_t generation;
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
@@ -996,7 +996,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 		to_iter = to_iter->next;
 	}
 
-	result = can_all_from_reach_with_flag(&from_objs, PARENT2, PARENT1,
+	result = can_all_from_reach_with_flag(r, &from_objs, PARENT2, PARENT1,
 					      min_commit_date, min_generation);
 
 	while (from) {
diff --git a/commit-reach.h b/commit-reach.h
index 3f3a563d8a..5e2b82655b 100644
--- a/commit-reach.h
+++ b/commit-reach.h
@@ -88,13 +88,14 @@ int commit_contains(struct ref_filter *filter, struct commit *commit,
  * commits with date below 'min_commit_date' or generation below
  * 'min_generation'.
  */
-int can_all_from_reach_with_flag(struct object_array *from,
+int can_all_from_reach_with_flag(struct repository *r,
+				 struct object_array *from,
 				 unsigned int with_flag,
 				 unsigned int assign_flag,
 				 timestamp_t min_commit_date,
 				 timestamp_t min_generation);
-int can_all_from_reach(struct commit_list *from, struct commit_list *to,
-		       int commit_date_cutoff);
+int can_all_from_reach(struct repository *r, struct commit_list *from,
+		       struct commit_list *to, int commit_date_cutoff);
 
 
 /*
diff --git a/fetch-pack.c b/fetch-pack.c
index 120e01f3cf..26dbbdc4f6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -2330,8 +2330,8 @@ void negotiate_using_fetch(const struct oid_array *negotiation_restrict_tips,
 			die(_("unexpected 'ready' from remote"));
 		else
 			do_check_stateless_delimiter(stateless_rpc, &reader);
-		if (can_all_from_reach_with_flag(&nt_object_array, COMMON,
-						 REACH_SCRATCH, 0,
+		if (can_all_from_reach_with_flag(the_repository, &nt_object_array,
+						 COMMON, REACH_SCRATCH, 0,
 						 min_generation))
 			last_iteration = 1;
 		trace2_region_leave_printf("negotiation", "round",
diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
index 5d86a96c17..8ea77a782c 100644
--- a/t/helper/test-reach.c
+++ b/t/helper/test-reach.c
@@ -127,7 +127,7 @@ int cmd__reach(int ac, const char **av)
 		print_sorted_commit_ids(list);
 		commit_list_free(list);
 	} else if (!strcmp(av[1], "can_all_from_reach")) {
-		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(X, Y, 1));
+		printf("%s(X,Y):%d\n", av[1], can_all_from_reach(r, X, Y, 1));
 	} else if (!strcmp(av[1], "can_all_from_reach_with_flag")) {
 		struct commit_list *iter = Y;
 
@@ -136,7 +136,8 @@ int cmd__reach(int ac, const char **av)
 			iter = iter->next;
 		}
 
-		printf("%s(X,_,_,0,0):%d\n", av[1], can_all_from_reach_with_flag(&X_obj, 2, 4, 0, 0));
+		printf("%s(X,_,_,0,0):%d\n", av[1],
+		       can_all_from_reach_with_flag(r, &X_obj, 2, 4, 0, 0));
 	} else if (!strcmp(av[1], "commit_contains")) {
 		struct ref_filter filter = REF_FILTER_INIT;
 		struct contains_cache cache;
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index a564758f52..afb484b963 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -517,4 +517,43 @@ test_expect_success 'merging should fail with no merge base' '
 	)
 '
 
+test_expect_success 'setup for commit-graphs in superproject and submodule' '
+	git init commit-graph &&
+	(cd commit-graph &&
+	git init sub &&
+	for i in 1 2 3 4 5 6 7 8 9 10
+	do
+		test_commit -C sub "sub-$i" || return 1
+	done &&
+
+	git -C sub checkout --detach sub-1 &&
+	git add sub &&
+	git commit -m base &&
+
+	# Write the commit-graph of the superproject while it only
+	# contains a single commit. Any commit-graph position of the
+	# submodule is thus out of bounds for the superproject.
+	git commit-graph write --reachable &&
+
+	git checkout -b side &&
+	git -C sub checkout --detach sub-5 &&
+	git add sub &&
+	git commit -m side &&
+
+	git checkout main &&
+	git -C sub checkout --detach sub-10 &&
+	git add sub &&
+	git commit -m main &&
+
+	git -C sub commit-graph write --reachable)
+'
+
+test_expect_success 'merge does not mix up superproject and submodule commit-graphs' '
+	(cd commit-graph &&
+	git merge side &&
+	git rev-parse HEAD:sub >actual &&
+	git -C sub rev-parse sub-10^{commit} >expect &&
+	test_cmp expect actual)
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index a52856d869..550fea6763 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -565,9 +565,9 @@ static int ok_to_give_up(struct upload_pack_data *data)
 	if (!data->have_obj.nr)
 		return 0;
 
-	return can_all_from_reach_with_flag(&data->want_obj, THEY_HAVE,
-					    COMMON_KNOWN, data->oldest_have,
-					    min_generation);
+	return can_all_from_reach_with_flag(the_repository, &data->want_obj,
+					    THEY_HAVE, COMMON_KNOWN,
+					    data->oldest_have, min_generation);
 }
 
 static int get_common_commits(struct upload_pack_data *data,

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
2.55.0

