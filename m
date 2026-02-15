Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C732690C0
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 20:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771186326; cv=none; b=Ea0iNV5zjD7/ziT5sImdA9JnWTqroq7Zrb6NHW0sOJetghlngKFt9JF3C23ErPgEb22SFFY3abRgNpUmy0+WT6VAXVt0PYhOjwJvjmiQlFmisgJWk6I0cL5J04VBr+7U9tU2TWAlk7MArKst/qV3uC4SGObuKI2hk8mZWz1ZoZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771186326; c=relaxed/simple;
	bh=R8UPeIRgcmpRqWIDwj2vTLy5WbWSPV+NMVoJqIL57Nw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=q4orJ/YrMsUv7kqJRo6oGuiJTIRDzwOl/Opw63QB1cJgojmuy/XnikfxjNt5n7aHjiJYovmsmujZFfRg4vO4F8pfz+F9ei7Voa6y9xiGl1SqVSp8qo1tsM3TrH/JhXEr2GhJOhPE9CGcmYwP0ksJihyww1jn9SrjtH4t6V/G+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AR8RXZX6; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AR8RXZX6"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270be4d125so610806c88.1
        for <git@vger.kernel.org>; Sun, 15 Feb 2026 12:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771186323; x=1771791123; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YzqfqCjB7dVMHX3gt7LTi+poqpEeyolvaG5Ff+A7I4s=;
        b=AR8RXZX62FuA7YFtBDFtZOw1j8OoHN+0XiX6dlUHZeiPCsyzchPM7E6h/M58C2xC//
         ijWVxZNgRQS/PkrGDld58n7ZPS5nwUxEYggAfKCbieB8xXWBZJN4vw9ugLTeL6cRfAOj
         doO2ka8S0YRGffRBdSbtOEQhePjwE5HvGVVbFKWgsYqpQUVV5wARW9cmJtOVdoKAoXdL
         eQBqyrvw8QtjWQ6tXhf4v5b/vJG/LxRAoDBrjrCVekWybCB3sHHoHhKH03WMpMnrjiH6
         YohlcqowxoHsiKaNrv09KKFf7lvOqDsYVbeUoKQ6ab9OcDdrI/KlKYrNqk5hwlWjzdKR
         c2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771186323; x=1771791123;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YzqfqCjB7dVMHX3gt7LTi+poqpEeyolvaG5Ff+A7I4s=;
        b=PWCcjlCU5Z+kPWHg+oxLJ81SVLytFQNlG2k2Bs4VKBvDfXFNwmOo/4nLH1WhV/0bsv
         sb+icwu2IVAEU58zQfiq7ctFfptH3RUo3gNhVcYH57GR/m6WJltF9/VJkYsdQiHvJFwA
         50v4TMWVzeRimuH6w/5Ty/i02umPdRU9+2yffUfC4sH0jOGys6AuqNXCHziWKHUKO2sV
         DylEDpb7j59Ou5nVO5WBjUKi2d/Z1rt3wDiOkv6GISf9Jrt7VLm+X1bBj9BC8drKeW6L
         O/dkshQyGGJu/zbdqz58icwS0TGkQB3DkPxWXdDV0maFdlKDMgR+wZ6hP8m4uFx9t7cy
         8xtw==
X-Gm-Message-State: AOJu0YwwJPJwadc8Os7uuyV34k3ysnDm0iEE+YwWHhMn1VjwbmxOmtNc
	HXEZbTplGmLgOr7a8XFJhwhBwWpiD5b3pVJ7E6V41S5Eq5wdQjBdZus5OBcXfw==
X-Gm-Gg: AZuq6aKR9BV7KE6MVWkmpaudkimoUykY24qgbGsPNQMftemnvvMtEkvUXpof58oldNH
	DBh8YZB6IK7j7gopXas1UEO5OTg9cih1SA7ob8opuo5wyFwBYTA1tsmuahLUTlegbjJ40M+ItXf
	rIUQJCEOfNSNVTpftr7+lmt2NiV1uxlT5z33NIjwI1Ksif3A9PHnodo4mTKsp6TBFZwXdhjIbvj
	NbIhvWNRAnkM26CsVHStZxSdKUu3Dgrh9trGuDjho8CejHvZVPQOM4o3QkFBOMKOTRXlVpOTFTd
	/mYb0X9ETKadTzHO1/vzSRRceuBSwnstKMTc1sbGhricAnm4SYZn5oxJxwNYA1qT9KL1R67NDik
	OlFfAjv1q3ErWovGU7oA87XUlmEgdY/ma6i5PIcvpJKlknS+KNAzpeJVhh04YjsVyx7tHKMcDt/
	dsXw+zdM/lnNb6afc/DytElsrDtkc=
X-Received: by 2002:a05:7022:227:b0:11b:ceee:b760 with SMTP id a92af1059eb24-12741bbf46bmr2721274c88.23.1771186323469;
        Sun, 15 Feb 2026 12:12:03 -0800 (PST)
Received: from [127.0.0.1] ([172.182.224.114])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cc83e6sm7256222c88.15.2026.02.15.12.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 12:12:02 -0800 (PST)
Message-Id: <8d48ba9cd16966ea717c019f151cddf27a09c555.1771186316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
References: <pull.2121.v4.git.git.1768602661.gitgitgadget@gmail.com>
	<pull.2121.v5.git.git.1771186316.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Feb 2026 20:11:56 +0000
Subject: [PATCH v5 2/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a
merged branch, we may end up with some shallows that are hidden behind
the reachable shallow commits. Added test 'fetching deepen beyond
merged branch' exposes that behaviour.

An example showing the problem based on added test:
0. Whole initial git repo to be cloned from
   Graph:
   *   033585d (HEAD -> main) Merge branch 'branch'
   |\
   | * 984f8b1 (branch) five
   | * ecb578a four
   |/
   * 0cb5d20 three
   * 2b4e70d two
   * 61ba98b one

1. Initial shallow clone --depth=3 (all good)
   Shallows:
   2b4e70da2a10e1d3231a0ae2df396024735601f1
   ecb578a3cf37198d122ae5df7efed9abaca17144
   Graph:
   *   033585d (HEAD -> main) Merge branch 'branch'
   |\
   | * 984f8b1 five
   | * ecb578a (grafted) four
   * 0cb5d20 three
   * 2b4e70d (grafted) two

2. Deepen shallow clone with fetch --deepen=1 (NOT OK)
   Shallows:
   0cb5d204f4ef96ed241feb0f2088c9f4794ba758
   61ba98be443fd51c542eb66585a1f6d7e15fcdae
   Graph:
   *   033585d (HEAD -> main) Merge branch 'branch'
   |\
   | * 984f8b1 five
   | * ecb578a four
   |/
   * 0cb5d20 (grafted) three
   ---
   Note that second shallow commit 61ba98be443fd51c542eb66585a1f6d7e15fcdae
   is not reachable.

On the other hand, it seems that equivalent absolute depth driven
fetches result in all the correct shallows. That led to this proposal,
which unifies absolute and relative deepening in a way that the same
get_shallow_commits() call is used in both cases. The difference is
only that depth is adapted for relative deepening by measuring
equivalent depth of current local shallow commits in the current remote
repo. Thus a new function get_shallows_depth() has been added and the
function get_reachable_list() became redundant / removed.

Same example showing the corrected second step:
2. Deepen shallow clone with fetch --deepen=1 (all good)
   Shallow:
   61ba98be443fd51c542eb66585a1f6d7e15fcdae
   Graph:
   *   033585d (HEAD -> main) Merge branch 'branch'
   |\
   | * 984f8b1 five
   | * ecb578a four
   |/
   * 0cb5d20 three
   * 2b4e70d two
   * 61ba98b (grafted) one

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of
each existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative
deepening anyway. That way we can always sum 'data->deepen_relative'
and 'depth' values, because 'data->deepen_relative' is always 0 in
absolute deepening.
To avoid duplicating logic between get_shallows_depth() and
get_shallow_commits(), get_shallow_commits() was modified so that
it is used by get_shallows_depth().

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>

Fixing v4

Fixing v4 again
---
 shallow.c             | 72 +++++++++++++++++++++++++++++++++++--------
 shallow.h             |  2 ++
 t/t5500-fetch-pack.sh | 23 ++++++++++++++
 upload-pack.c         | 72 ++-----------------------------------------
 4 files changed, 87 insertions(+), 82 deletions(-)

diff --git a/shallow.c b/shallow.c
index 497a25836b..a156006d88 100644
--- a/shallow.c
+++ b/shallow.c
@@ -130,11 +130,24 @@ static void free_depth_in_slab(int **ptr)
 {
 	FREE_AND_NULL(*ptr);
 }
-struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
-		int shallow_flag, int not_shallow_flag)
+/*
+ * This is a common internal function that can either return a list of
+ * shallow commits or calculate the current maximum depth of a shallow
+ * repository, depending on the input parameters.
+ *
+ * Depth calculation is triggered by passing the `shallows` parameter.
+ * In this case, the computed depth is stored in `max_cur_depth` (if it is
+ * provided), and the function returns NULL.
+ *
+ * Otherwise, `max_cur_depth` remains unchanged and the function returns
+ * a list of shallow commits.
+ */
+static struct commit_list *get_shallows_or_depth(struct object_array *heads,
+				struct object_array *shallows, int *max_cur_depth,
+				int depth, int shallow_flag, int not_shallow_flag)
 {
 	size_t i = 0;
-	int cur_depth = 0;
+	int cur_depth = 0, cur_depth_shallow = 0;
 	struct commit_list *result = NULL;
 	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
@@ -168,16 +181,30 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 		}
 		parse_commit_or_die(commit);
 		cur_depth++;
-		if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
-		    (is_repository_shallow(the_repository) && !commit->parents &&
-		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
-		     graft->nr_parent < 0)) {
-			commit_list_insert(commit, &result);
-			commit->object.flags |= shallow_flag;
-			commit = NULL;
-			continue;
+		if (shallows) {
+			for (size_t j = 0; j < shallows->nr; j++)
+				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
+					if (!cur_depth_shallow || cur_depth < cur_depth_shallow)
+						cur_depth_shallow = cur_depth;
+
+			if ((is_repository_shallow(the_repository) && !commit->parents &&
+			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
+			     graft->nr_parent < 0)) {
+				commit = NULL;
+				continue;
+			}
+		} else {
+			if ((depth != INFINITE_DEPTH && cur_depth >= depth) ||
+			    (is_repository_shallow(the_repository) && !commit->parents &&
+			     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
+			     graft->nr_parent < 0)) {
+				commit_list_insert(commit, &result);
+				commit->object.flags |= shallow_flag;
+				commit = NULL;
+				continue;
+			}
+			commit->object.flags |= not_shallow_flag;
 		}
-		commit->object.flags |= not_shallow_flag;
 		for (p = commit->parents, commit = NULL; p; p = p->next) {
 			int **depth_slot = commit_depth_at(&depths, p->item);
 			if (!*depth_slot) {
@@ -200,9 +227,30 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
 	object_array_clear(&stack);
 
+	if (shallows && max_cur_depth)
+		*max_cur_depth = cur_depth_shallow;
 	return result;
 }
 
+int get_shallows_depth(struct object_array *heads, struct object_array *shallows)
+{
+	int max_cur_depth = 0;
+	get_shallows_or_depth(heads, shallows, &max_cur_depth, 0, 0, 0);
+	return max_cur_depth;
+
+}
+
+struct commit_list *get_shallow_commits(struct object_array *heads,
+					struct object_array *shallows, int deepen_relative,
+					int depth, int shallow_flag, int not_shallow_flag)
+{
+	if (shallows && deepen_relative) {
+		depth += get_shallows_depth(heads, shallows);
+	}
+	return get_shallows_or_depth(heads, NULL, NULL,
+				     depth, shallow_flag, not_shallow_flag);
+}
+
 static void show_commit(struct commit *commit, void *data)
 {
 	commit_list_insert(commit, data);
diff --git a/shallow.h b/shallow.h
index ad591bd139..e3f0df57ad 100644
--- a/shallow.h
+++ b/shallow.h
@@ -35,7 +35,9 @@ int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
 /* rollback $GIT_DIR/shallow and reset stat-validity checks */
 void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
+int get_shallows_depth(struct object_array *heads, struct object_array *shallows);
 struct commit_list *get_shallow_commits(struct object_array *heads,
+					struct object_array *shallows, int deepen_relative,
 					int depth, int shallow_flag, int not_shallow_flag);
 struct commit_list *get_shallow_commits_by_rev_list(struct strvec *argv,
 						    int shallow_flag, int not_shallow_flag);
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..5a8b30e1fd 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -955,6 +955,29 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'fetching deepen beyond merged branch' '
+	test_create_repo shallow-deepen-merged &&
+	(
+		cd shallow-deepen-merged &&
+		git commit --allow-empty -m one &&
+		git commit --allow-empty -m two &&
+		git commit --allow-empty -m three &&
+		git switch -c branch &&
+		git commit --allow-empty -m four &&
+		git commit --allow-empty -m five &&
+		git switch main &&
+		git merge --no-ff branch &&
+		cd - &&
+		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-merged" deepen.git &&
+		git -C deepen.git fetch origin --deepen=1 &&
+		git -C deepen.git rev-list --all >actual &&
+		for commit in $(sed "/^$/d" deepen.git/shallow)
+		do
+			test_grep "$commit" actual || exit 1
+		done
+	)
+'
+
 test_negotiation_algorithm_default () {
 	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
diff --git a/upload-pack.c b/upload-pack.c
index 2d2b70cbf2..88dac1b65c 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -704,56 +704,6 @@ error:
 	return -1;
 }
 
-static int get_reachable_list(struct upload_pack_data *data,
-			      struct object_array *reachable)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i;
-	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
-	const unsigned hexsz = the_hash_algo->hexsz;
-	int ret;
-
-	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_uor) < 0) {
-		ret = -1;
-		goto out;
-	}
-
-	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
-		struct object_id oid;
-		const char *p;
-
-		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
-			break;
-
-		o = lookup_object(the_repository, &oid);
-		if (o && o->type == OBJ_COMMIT) {
-			o->flags &= ~TMP_MARK;
-		}
-	}
-	for (i = get_max_object_index(the_repository); 0 < i; i--) {
-		o = get_indexed_object(the_repository, i - 1);
-		if (o && o->type == OBJ_COMMIT &&
-		    (o->flags & TMP_MARK)) {
-			add_object_array(o, NULL, reachable);
-				o->flags &= ~TMP_MARK;
-		}
-	}
-	close(cmd.out);
-
-	if (finish_command(&cmd)) {
-		ret = -1;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	child_process_clear(&cmd);
-	return ret;
-}
-
 static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -881,29 +831,11 @@ static void deepen(struct upload_pack_data *data, int depth)
 			struct object *object = data->shallows.objects[i].item;
 			object->flags |= NOT_SHALLOW;
 		}
-	} else if (data->deepen_relative) {
-		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
-		struct commit_list *result;
-
-		/*
-		 * Checking for reachable shallows requires that our refs be
-		 * marked with OUR_REF.
-		 */
-		refs_head_ref_namespaced(get_main_ref_store(the_repository),
-					 check_ref, data);
-		for_each_namespaced_ref_1(check_ref, data);
-
-		get_reachable_list(data, &reachable_shallows);
-		result = get_shallow_commits(&reachable_shallows,
-					     depth + 1,
-					     SHALLOW, NOT_SHALLOW);
-		send_shallow(data, result);
-		free_commit_list(result);
-		object_array_clear(&reachable_shallows);
 	} else {
 		struct commit_list *result;
 
-		result = get_shallow_commits(&data->want_obj, depth,
+		result = get_shallow_commits(&data->want_obj, &data->shallows,
+					     data->deepen_relative, depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(data, result);
 		free_commit_list(result);
-- 
gitgitgadget
