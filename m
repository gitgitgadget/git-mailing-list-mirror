Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD9447AF61
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523208; cv=none; b=qX68z8WDLl04gKU7PRC7288dRstMQJg84buFN0J0gW5liM0F6QzObAsn1GDoFqYcxqaGubALphRZlhwNr2QVHwCtWzRojlgkRbSGImAu0go2rOPZlCUN2CQiSyYaXNTkvCbtjBmDe6eiLmjKi9HJ1elO2FYhtI7CDG5K0vOcV2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523208; c=relaxed/simple;
	bh=Rpw6Pc+Aklt9mt/yi5B5JAEW6ZnHIxxJTPaGP2zYreg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j9CMbP2gd6s5sitXK9blS6ipOE4F8gHxIhgtgozqE1d50pwg9+p+cvNgxldwUyfBc6C+MWgrvhEYHoT72RpeL48cMwVak7tjKZXriEcheda95pzQR8D9MNN4PfVpMdIO7Qblk3PvC2xJE1bH40HWI/ooK51HF9THR+55VQL/Ujk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GXNGIKGx; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXNGIKGx"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7c0dea734bcso21393967b3.2
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523205; x=1779128005; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZMyTgK9/S/SZChT7kuJIMOH08UpfHHcBZ674ayKG6M=;
        b=GXNGIKGxoK9MXLXT7z3PDr/lHDJM5aEbJUnc6FpygZHGOvBxEt+UPzB1uDrQBR4DtD
         k9t3w3ApUaxM3BGmFeAW0WTyv5yCKd7L1YtxlCeTcwGTIvKg8+YClJOCPvse4gLnrIkn
         mb54SJrLJWpiClDchvWb4knfRPKMvF8IRRpvlqShYhls8QY/8DQMDEruOXxbraEQgqat
         /AWOEFabQgWRWWXso1yQNltu2KCsvVGb4j+tHKr/K8HG/rteg/pJnQdKnv6puzZAJ752
         Aif2XJtX+pQfl1sbJsqIvUt+9MzSm1/9VtvQhjzWt2EpnzAlW4oT9zXa921wKrjKGSfY
         WJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523205; x=1779128005;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KZMyTgK9/S/SZChT7kuJIMOH08UpfHHcBZ674ayKG6M=;
        b=k/S+RINqFCBfbQBYC+xbGi59oTrAVrTLEFPA18quuKE1UfVr4iYN1p4iGviJSYxdTe
         tNjZy91zw9jLH6Pd1LPkAzxwamNZw894aOynWgS09NUPlMjHMHQjSGZlIsdZDxQegyPE
         akiWHlEOOb1qitLASapa9YRIueuIC7qD4FrlCMEONrruxwasgDNYQSls5fg3v9SPFbAi
         PjGZef2JHcWPjPRDcX5ZRE8ErrOg6Dq4knpBBbLPtoDBsp+PEre1SMm6ekK/+e2dk7fD
         EkdukqCgT6cRxKh8nT2VrSYgjZ4y17kWhs8FjPZCBdzXkmS/APsKjvAuip5EQjDPTU8b
         0TxA==
X-Gm-Message-State: AOJu0YzKNRe4HbOcTVwvDd8k6dz409Xri31hsdFtX8Mu8pf56EUiREl2
	aDzxyeNR2MB2+W/AjlmPheVCo4Dvmvowj0PNaSGQJDoGcHz6UGDwYFf8/qmzsg==
X-Gm-Gg: Acq92OE07rg1zogFOBtrkD9VvB8WWZSZx4N1uAKRbZcMmK7I0LgqxN9kfRjdU/cXufV
	eUCoi+CsCyJRN7hvokBSyrdfasbVKvtOpUaRvesgNmMMyopwr4AV3gqaICK8MeOGAFgp/UNnTri
	IYVrFi8ApkqMJojV9Bgs4bFcBzso/0YSQLo+Ov9eV14j9qZD6zQN05k1RI1WOk7amO4qOYqSO95
	1w0o6jh4wbufvQnYEzZwtHtB0Kn6hitiBLM1Ws35caE2u/FckMfmEfgzzHVrjJavrRbwqxMm2FG
	zIaKI4t8OteSP0bu5rbvgwWlvfubEV+EgyL9ojp8TuSiwJEj5nEHLWKwQ4odiFmfVjLncvk0zPR
	G4O6bvTdyhmKb2uYIgAvB1y+1CsClgcqafjvSwelxrwLeSWkR7dcf1Ro1jevj1d3hgtE/2tL+0C
	VOc361Uu+QSmh5QvX4+NmBdE/DzQ==
X-Received: by 2002:a05:690c:6612:b0:7c0:56f:5b70 with SMTP id 00721157ae682-7c104ca7774mr112793487b3.29.1778523205225;
        Mon, 11 May 2026 11:13:25 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685bfd4sm151430857b3.33.2026.05.11.11.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:24 -0700 (PDT)
Message-Id: <c9efff0ea8d72d2d084957e1b099801b8d8727f3.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:07 +0000
Subject: [PATCH v3 10/12] path-walk: support `tree:0` filter
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
Cc: christian.couder@gmail.com,
    gitster@pobox.com,
    johannes.schindelin@gmx.de,
    johncai86@gmail.com,
    karthik.188@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    me@ttaylorr.com,
    newren@gmail.com,
    peff@peff.net,
    ps@pks.im,
    Taylor Blau <me@ttaylorr.com>,
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `tree:0` object filter omits all trees and blobs from the result,
keeping only commits and tags. Consequently, this filter type should
has a fairly straightforward integration with path-walk, as the decision
to include an object depends only on its type and does not depend on any
path-sensitive state.

Mapping it onto `path_walk_info` is direct: set `info->trees = 0` and
`info->blobs = 0` in `prepare_filters()` when the `LOFC_TREE_DEPTH`
choice is requested with depth zero. The existing code already plumbs
those flags through the rest of the walk:

 - 'walk_objects_by_path()' sets `revs->blob_objects = info->blobs` and
   `revs->tree_objects = info->trees` before `prepare_revision_walk()`,
   so the revision walk doesn't try to enumerate trees or blobs itself.

 - The commit-walk loop short-circuits the root-tree fetch with
   "if (!info->trees && !info->blobs) continue;", so we never even
   look up the root tree, let alone descend into it.

 - `setup_pending_objects()` skips pending trees and blobs based on
   the same flags.

This means the path-walk doesn't allocate or expand any tree structures
at all under `tree:0`, which matches the intended behavior of the
filter.

Non-zero tree-depth filters are not supported. Those depend on the depth
at which a tree is visited, which is a path-walk concept the filter
machinery doesn't currently share with the path-walk API. Reject them in
`prepare_filters()` with a helpful error and let pack-objects fall back
to the regular traversal, the same way it already does for unsupported
filters.

Add coverage in t6601 for both `--all` and a single-branch case to
confirm that no trees or blobs are emitted, and a separate test that
`tree:1` is rejected with the expected error message. Place the new
tests before "setup sparse filter blob" so they run on the original set
of refs, before the orphan branch that the sparse-tree tests create.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  4 +--
 path-walk.c                         | 42 +++++++++++++++++++++++--
 t/t6601-path-walk.sh                | 49 +++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index f0887ab5b9..4ebda0fa9e 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -404,8 +404,8 @@ will be automatically changed to version `1`.
 +
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
-supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`, and
-`sparse:<oid>`.
+supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
+`tree:0`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 1172385402..f6f95da550 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -389,8 +389,8 @@ static int walk_path(struct path_walk_context *ctx,
 					ctx->info->path_fn_data);
 	}
 
-	/* Expand data for children. */
-	if (list->type == OBJ_TREE) {
+	/* Expand data for children, unless this is a direct-object path. */
+	if (list->type == OBJ_TREE && !path_is_for_direct_objects(path)) {
 		for (size_t i = 0; i < list->oids.nr; i++) {
 			ret |= add_tree_entries(ctx,
 					    path,
@@ -441,11 +441,14 @@ static int setup_pending_objects(struct path_walk_info *info,
 {
 	struct type_and_oid_list *tags = NULL;
 	struct type_and_oid_list *tagged_blobs = NULL;
+	struct type_and_oid_list *tagged_trees = NULL;
 	struct type_and_oid_list *root_tree_list = NULL;
 
 	if (info->tags)
 		CALLOC_ARRAY(tags, 1);
 	CALLOC_ARRAY(tagged_blobs, 1);
+	if (!info->trees)
+		CALLOC_ARRAY(tagged_trees, 1);
 	root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
 
 	/*
@@ -490,7 +493,15 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (pending->path) {
+			if (tagged_trees) {
+				/*
+				 * Trees are disabled but pending trees
+				 * should still be emitted. Collect them
+				 * into a "/tagged-trees" list that
+				 * bypasses the object type filter.
+				 */
+				oid_array_append(&tagged_trees->oids, &obj->oid);
+			} else if (pending->path) {
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
 							    : xstrdup("");
 				add_path_to_list(ctx, path, OBJ_TREE, &obj->oid, 1);
@@ -534,6 +545,18 @@ static int setup_pending_objects(struct path_walk_info *info,
 			free(tagged_blobs);
 		}
 	}
+	if (tagged_trees) {
+		if (tagged_trees->oids.nr) {
+			const char *tagged_tree_path = "/tagged-trees";
+			tagged_trees->type = OBJ_TREE;
+			tagged_trees->maybe_interesting = 1;
+			strmap_put(&ctx->paths_to_lists, tagged_tree_path, tagged_trees);
+			push_to_stack(ctx, tagged_tree_path);
+		} else {
+			oid_array_clear(&tagged_trees->oids);
+			free(tagged_trees);
+		}
+	}
 	if (tags) {
 		if (tags->oids.nr) {
 			const char *tag_path = "/tags";
@@ -574,6 +597,19 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_TREE_DEPTH:
+		if (options->tree_exclude_depth) {
+			error(_("tree:%lu filter not supported by the path-walk API"),
+			      options->tree_exclude_depth);
+			return 0;
+		}
+		if (info) {
+			info->trees = 0;
+			info->blobs = 0;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index ac294867a5..deaeab9a3e 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -596,6 +596,55 @@ test_expect_success 'all, blob:limit=3 filter' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'all, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tag:/tags:$(git rev-parse refs/tags/first)
+	1:tag:/tags:$(git rev-parse refs/tags/second.1)
+	1:tag:/tags:$(git rev-parse refs/tags/second.2)
+	1:tag:/tags:$(git rev-parse refs/tags/third)
+	1:tag:/tags:$(git rev-parse refs/tags/fourth)
+	1:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	1:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag^{tree})
+	3:tree:/tagged-trees:$(git rev-parse refs/tags/tree-tag2)
+	blobs:2
+	commits:4
+	tags:7
+	trees:2
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'topic only, tree:0 filter' '
+	test-tool path-walk --filter=tree:0 -- topic >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	blobs:0
+	commits:3
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'tree:1 filter is rejected' '
+	test_must_fail test-tool path-walk --filter=tree:1 -- --all 2>err &&
+	test_grep "tree:1 filter not supported by the path-walk API" err
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget

