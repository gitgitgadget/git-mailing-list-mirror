Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4071031D371
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 22:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767997432; cv=none; b=uf86seKU8Kx2f9WDBgVX9gGxaWB48k3ANeMWKncr+VPRfBfz+5yQWsD8MUto41/HsUCj2xHId283hIIhtzQXk+08Q2XTf1v7nu3MLl4EEWIhtQ8cd2Royzw9ffqLc34niDRkUcuL1+sg9OAOIX7LrX7eI9mPv+N5sKKuYYEENlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767997432; c=relaxed/simple;
	bh=prwi29mZGejUnsP2MQ13PV6US8UTfrb80joFH4Ltd3E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=M2KksAs/V/UfGYHmr1jRxfguXP7WojWqta/D45x8fio+9C4dKYEbUQ5VtxGo08f7pZdfydqCFJsndoacqrtGv/sguc8Xrai3jhVYmGNuySf+Zz/C2IZJXvUqjioW47NXECTmSa0ldkeD3oHFSLkRBO933amdYetYbO1Nj9SiJI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aauOQ66S; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aauOQ66S"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8b2ea2b9631so537264185a.3
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 14:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767997430; x=1768602230; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2y1EnCEAdWwYYeA0TxHI09zRnAyqmDDWzDuFsS4n5vs=;
        b=aauOQ66S0BLrKIK6kf83B0dX58KD10gbyzTWyLMgkoJjqPlwKo7Uz3MVH/AjnPCOvK
         Y5FY3MFO75pqZwYOhb8yek5byxJj28d18Agm/O/7Y05K0CDjSiG8D2YwpaRPdgSNF+uf
         1Amt4lE6HAguQ3q9HpqR9f3FRuP8qKSC5rFdGjzs/S006VrHmSQ5xOEf/VGlFFJJJTYH
         oRe/lC225OjaKRbBpNGQ3eIazRfKBfVcVz1M9JG4EtDinHclgguslV9e/pco8izcLOE9
         C5F9WvWmKtwIq/3IkARMSh/0tPgzl2S9Sg9bq4XPcAm7HZiq2hCh4cmceNZNpQQ5zDH6
         9cWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767997430; x=1768602230;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2y1EnCEAdWwYYeA0TxHI09zRnAyqmDDWzDuFsS4n5vs=;
        b=cDjaFiVk96PDB0ba0JNPltMMp4jUliy6Sd/ENQuqL8jpTyfr+GVRfzQ72zYHnss96l
         pA/rekuFNVVFabeeTHs7BiRYaS+as4hOzJo55xKP4DVlKVOLiqeXqOzz4OMO+X4fcuSr
         y5O1ZgXmlO1wiW0lMY/53nD3st9Uiw92hbyrQeAr605xIXze2yJ8sbM3G6xsuMzard3J
         GSPcu0AAPUfTBQOaLCZq0iMINy6HMh2mUUxms6cMt0a5P7jcrqwh6DlO2F9XkyXSkCu3
         cvAMcCnIzYK39ALOeomHtAs43+yAwfeGG7ukhMI8rhBhpTqOesDH7cZ8BrvHFrr3rUX0
         kyTA==
X-Gm-Message-State: AOJu0Yx5X5TiTyPCg8UJHc0lz1aBOe1A0/x3gZyxQL5612V1VNxIIxgI
	y4M5nSNbkiHsK+o2iZ5sAKP2JRYwZ9jODKhwWihsxhC9+KqXjFlmM0/8vHIy1Q==
X-Gm-Gg: AY/fxX534gAWWniDFQ0eL3+b7RCDShPktfsc4G3VuoQTkdtwtSmAKZjV9lpLLuhzt+Y
	LC+1JodO8Unm5XPce1OK4uwWb5A5gGl+eqjiOrTdITYuA+x3Fb5sywSyaSr/w1VkrcfadP543sf
	LkK3lCmCPr6vVPeCIu2/8CsTBcDUhJ+/Q+7UrRxFIouL0rKJYm4s34uht+budp4OcmGqOrHxSp7
	iWeLkSTRSJZEhk3w/kltODQacYaNYIJZV3NQxGr3bGm2g/jcvrUYdjJChiqMznohvPPlthG+oUR
	Mf5aeB74ujU30D51YaLyIDj6BgbH+1CmJ82BGEcqB5VDmr+k0bBhXj88LzWSLNz3Mz7BaJgfems
	InO2l+06eX02dhWZCFm/k1K9GWcnKq53/Hi6wXo6haRhBaQPfbhcjG3SAxnt5TfQH8Jek6XyEBh
	gou7Eo4+J0xQuwiQ==
X-Google-Smtp-Source: AGHT+IG3cgChXrHZFaWamJ467ee9E6aAgSFOS95D7TJY0K1O63RuAnn+F3TotU8TIROrN8iKA6kzeg==
X-Received: by 2002:a05:620a:2913:b0:8b2:dd0a:8809 with SMTP id af79cd13be357-8c38941c43bmr1562830385a.89.1767997429590;
        Fri, 09 Jan 2026 14:23:49 -0800 (PST)
Received: from [127.0.0.1] ([135.119.237.71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a9a19sm920274785a.1.2026.01.09.14.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 14:23:49 -0800 (PST)
Message-Id: <ba1f80105f3e1c3dc6d133fb319e1df69a19bf8f.1767997426.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
	<pull.2121.v2.git.git.1767997426.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Jan 2026 22:23:46 +0000
Subject: [PATCH v2 2/2] shallow: handling fetch relative-deepen
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
