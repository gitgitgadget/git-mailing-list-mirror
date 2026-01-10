Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4F27FB21
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 05:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768022024; cv=none; b=dWPdalRBXig0UCCeJCYplSKPHIlW5LKV/XAn52L0cjgrGXgpm+X57DHbbXcrgBmDKfjtvGcKKZ1V/f1XIk7WGKYKyZpp24uCOi0nFFTNhzaptHApwHpF+w/t8ufOhrHLrnN3ioEXjox4HPB81MR7/ogZaP2XkJrIzijoEPPWQa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768022024; c=relaxed/simple;
	bh=N+VQJHYG1H+wBoOHEpRA4Axiu7F+GrUbqRPw9wBIsG0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=NPLaLGTYQLB1DjoKMSpwrAwx+yjFLdz8Q9nbv1W2GRwaQuUEyXwIe7JRJMKm3Z7s1tHf+BOzR5uFWlit8Td5pcVvWUDpisgo3jb7F+l1XsVztUPeKsZVGbQ/wE8HE4ifmVOJ5zljmG8O/L/DkckOapfAgyBSddBbfAwIxQ4uCX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaUso8oG; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaUso8oG"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8bb6a27d3edso501018785a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 21:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768022022; x=1768626822; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKV+Qd8Z9bDuKjEPGf0m6uWd3gJiVMM4hSg1/6EY72Q=;
        b=PaUso8oGU76Z6JOYMeE1YB9IESmPgzNN0TUFnYlXn11i1ZsjRoYEszusQkkfv1QN9q
         hJOrdA3nRZsXVN1ZkQepPUxTCP1e40mDk4F3Zd2yIDHaakTRcP5oE6iFv/U/xWOiBHM9
         Koycb+qlp3SDvEmIkaEOOonad+UHVaAmiX029UHWDsrYp/GZwegsOnvr9X7cHfx1y2Pq
         Y4DocgV6ZOauaKUfOezE3TWmW3xFRBjS5UYaKLYfcxhvRzAlxOoDWBa1AGXKvFZiP0Ki
         ewNXMYoP2jWCz8bRN1+uSze0tzIA+cRAelhe9CLG5DeGNxYcoxqstfuq8QdlLgEYy9As
         f5pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768022022; x=1768626822;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKV+Qd8Z9bDuKjEPGf0m6uWd3gJiVMM4hSg1/6EY72Q=;
        b=UfnIo72HrOx6m6y29e9gW+bbg/wysXDBYL+2ixhPuXvVDagxEu46SsWvxOeyDSwhbl
         51Pl6EKzZAQ5fda8qSHkPdEt/ezq838hSkrkzLz87NpAtC3we26z204TdgBF6TxKpwlR
         2blcCCnWsTSKbbqml/3zoWTA57m/rrfK7etEEzaKErynKg5iyE7eXKUVjJa0Hh3FXlAU
         cOrbuT3tG1zRRE3xUPRwjCtZqX5ndnJTExoKejEFpcblhfnwPklr9271txYQ3oC/XJMJ
         zsh+6l/+h86+cuTY6PmLK0R+3WWEyPRx2OEB5q5LooiwH9fHhR+TRYaLsC1qce/RBaNx
         NJ2A==
X-Gm-Message-State: AOJu0YzNTHMqNNj2P489oIXVkG9u7yyAlfW/AKiRwie7sCdnMR0uu2J+
	48Fsvv9K/jLnBMbLVeT0sonpcuI2G4dWSFRr7f4t0suX07v1rNiU/+R+X/ByZTXS
X-Gm-Gg: AY/fxX7wo42AU9FfGl0s+9DSRs7hRAjEGU/CN4Rsd6skKNjbyABkzGUwYn4yFq9ZaU1
	9KxOQxaQSMWcA2K1paSlU9rAnq5rqLS2Zej9qh5snlXoO+4pLTEByNYVRHoLUoYfHU29AR7f0aC
	LDMqcBPH+sDpgPljFu44wKLs5q5nQQajGcN2XqcZyDT9iKmFWvgWXC4mnYtNlXfkW/46Eahm/FA
	VxD/5H4CRdKUBThwHfM6qm10zy7jtRmSBTr9qQy3ozl6ht0N7ZSh63SMI3bPzv/x4AvN0GNzYQL
	tFcDhXZwehPGfJ9zzmnIcWJcMqzCEibqlVFvVYL5qS6titte/rfjUFSPk2BUX8l5XKNespYfDvI
	8ZOe/0TQB1MFtT4ILXU46rc91Snf58wbF4oLTA64PpFhBBOaTPTA/DyTwyPKI2bgcdqQJNTTovJ
	ezADZ7ODP0vI7QnHqCWTzA1BeR
X-Google-Smtp-Source: AGHT+IHgd58SgeFve0yn63H8BKc5w21h0zaAswsGhaHlix0YXatuoEKw9c+YjP8eBW+54MZa0opYUw==
X-Received: by 2002:a05:620a:410e:b0:8a3:9a05:ec10 with SMTP id af79cd13be357-8c38938dc31mr1728880285a.14.1768022021623;
        Fri, 09 Jan 2026 21:13:41 -0800 (PST)
Received: from [127.0.0.1] ([172.172.153.32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89077267e14sm89603316d6.49.2026.01.09.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 21:13:41 -0800 (PST)
Message-Id: <e79ab6b7406e3472ed8816131d4e33f7d8e696f2.1768022018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
References: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
	<pull.2121.v3.git.git.1768022018.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Jan 2026 05:13:38 +0000
Subject: [PATCH v3 2/2] shallow: handling fetch relative-deepen
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
deepening anyway. That way we can allways summ 'data->deepen_relative'
and 'depth' values, because 'data->deepen_relative' is always 0 in
absolute deepening.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 shallow.c             | 44 +++++++++++++++++--------
 shallow.h             |  1 +
 t/t5500-fetch-pack.sh | 23 +++++++++++++
 upload-pack.c         | 76 +++++--------------------------------------
 4 files changed, 63 insertions(+), 81 deletions(-)

diff --git a/shallow.c b/shallow.c
index 497a25836b..1a32808865 100644
--- a/shallow.c
+++ b/shallow.c
@@ -130,11 +130,12 @@ static void free_depth_in_slab(int **ptr)
 {
 	FREE_AND_NULL(*ptr);
 }
-struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
-		int shallow_flag, int not_shallow_flag)
+struct commit_list *get_shallow_commits(struct object_array *heads,
+					struct object_array *shallows, int *deepen_relative,
+					int depth, int shallow_flag, int not_shallow_flag)
 {
-	size_t i = 0;
-	int cur_depth = 0;
+	size_t i = 0, j;
+	int cur_depth = 0, cur_depth_shallow = 0;
 	struct commit_list *result = NULL;
 	struct object_array stack = OBJECT_ARRAY_INIT;
 	struct commit *commit = NULL;
@@ -168,16 +169,30 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
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
+			for (j = 0; j < shallows->nr; j++)
+				if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
+					if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
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
@@ -199,7 +214,8 @@ struct commit_list *get_shallow_commits(struct object_array *heads, int depth,
 	}
 	deep_clear_commit_depth(&depths, free_depth_in_slab);
 	object_array_clear(&stack);
-
+	if (shallows && deepen_relative)
+		*deepen_relative = cur_depth_shallow;
 	return result;
 }
 
diff --git a/shallow.h b/shallow.h
index ad591bd139..d1b3878635 100644
--- a/shallow.h
+++ b/shallow.h
@@ -36,6 +36,7 @@ int commit_shallow_file(struct repository *r, struct shallow_lock *lk);
 void rollback_shallow_file(struct repository *r, struct shallow_lock *lk);
 
 struct commit_list *get_shallow_commits(struct object_array *heads,
+					struct object_array *shallows, int *deepen_relative,
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
index 2d2b70cbf2..4232eef34f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -704,54 +704,11 @@ error:
 	return -1;
 }
 
-static int get_reachable_list(struct upload_pack_data *data,
-			      struct object_array *reachable)
+static void get_shallows_depth(struct upload_pack_data *data)
 {
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
+	get_shallow_commits(&data->want_obj, &data->shallows,
+			    &data->deepen_relative, 0,
+			    SHALLOW, NOT_SHALLOW);
 }
 
 static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
@@ -881,29 +838,14 @@ static void deepen(struct upload_pack_data *data, int depth)
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
+		if (data->deepen_relative)
+			get_shallows_depth(data);
+
+		result = get_shallow_commits(&data->want_obj, NULL, NULL,
+					     data->deepen_relative + depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(data, result);
 		free_commit_list(result);
-- 
gitgitgadget
