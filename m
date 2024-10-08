Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747C71DDA15
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396733; cv=none; b=PF86M9i1+W5Njr7gp3uB53WxYKz3BGoTKMbLLtc/CMVJlodGuqBedZPi14kU7MdV5Hp/Q32IS2H48OuT2+SnaEG0m3/heEMXsgxESfKY8PN5SnS0RuKeFypxD6Vz5k786vQStPqVHUQvoE8wqANODvY8s5FkVVEUF6VNWcURVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396733; c=relaxed/simple;
	bh=uXduckztd3PZE/RnGEPYQ8ai4OnDRgIcdaDbV3djYWk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tuO6O8Dt9LPQY4eAdaIOepdSXo6A8uu2+R1l32V02JHe+qy7+CNSqvTRLtXh++XwKBfegFlAxINRFAIT86gWTC27+C29k0DOM6P1/trXmtY68/iAu1dFfISpF3VUsviqchORWY/fTZ7IgK/n7XtfnAN3F01AgrtFanIpjcrbOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnF044lp; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnF044lp"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a994277b38bso229312166b.2
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 07:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396729; x=1729001529; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3eAeDdt/7zLXTBEgPtnxnwp/4c3sd4okG7PblAnepA=;
        b=lnF044lpRBmSvcoF5ZcoTwh8Qc2hRXy6iz9r25DmafIwUU+jMxuM0ZXqx5CCcftEx1
         EkUleEqWRen0keSgZs3+S9cUuCHncPT+gBbvj2Hl6RJbYes0Mvd/hgyOEglLVTWWLmdw
         T4Ov+gH7ezt+saT7sWJODgmpkLckIGN33nrzPW6Gg12WWhXEO59vI9Rj7gZrz0u8MuID
         TubbW2XxSE7aNKFBY3xUut5Qjh+A4mfzZbfKMh8dFsGhXeYsZ7n0BhD1b6mLviKVXdH1
         Fh8PSQjywfwkQINlIySqacJeMspDJPziuGYsCfnnjNDe3NxDohl1y0a3YNhe9oJvkcHp
         s0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396729; x=1729001529;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z3eAeDdt/7zLXTBEgPtnxnwp/4c3sd4okG7PblAnepA=;
        b=igdeZ33jK7vL/l6VEzG3XodEcokegF2iTV0WIu5L06go1INXkaO1m6v8KDiwDrk8vi
         WbDYrrmmmTmgdjnkFc+rNWJbXQHxaKWOAF92GgbU0sjUE5l9gWP4Q3MESJdb/aK8tWPY
         JUlFDfVeCbJQMnnBqJgbaeGkWkqcQAKpXcD7/VW/LMGE07qsGHpK6P9Mqybe2/Hqw3tt
         4jxmtEJBEtf3pkLA89X9we5YmXMs6H1qio/pLy91x8tjG/B6/JUIgQJYvoNxR2A4oJk6
         qznRTXSPUuYmUzCD3Rr47GBiITnBKBS5PUXBbv9I3Z2WzBZQfEwMX2omJU6ICfjDkvUK
         Xa7g==
X-Gm-Message-State: AOJu0YxcKNOk3C4mAMrK/67Ra8Tof3/KYePW8+UJAYo8LFmUx3RJVfd6
	dskcX26SV9MGv7O3+KVyhWk1PAinu+iNVBEvoIL+acgAswE3vqsCXMb0DA==
X-Google-Smtp-Source: AGHT+IH3JjttUYRM1umBC0YTB4+kaJAAfCb3mvLVUC+xdRJq8vwr05+OaCQFU+GtlgirJiZBC3pdcw==
X-Received: by 2002:a05:6402:388b:b0:5c8:8381:bb8f with SMTP id 4fb4d7f45d1cf-5c8d2ea06aamr17185760a12.24.1728396729271;
        Tue, 08 Oct 2024 07:12:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e0594f55sm4368812a12.13.2024.10.08.07.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:12:08 -0700 (PDT)
Message-Id: <6f48cddadc0ad1a6dc3caec9d81e014b668c1f03.1728396724.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 08 Oct 2024 14:11:50 +0000
Subject: [PATCH 04/17] path-walk: allow visiting tags
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In anticipation of using the path-walk API to analyze tags or include
them in a pack-file, add the ability to walk the tags that were included
in the revision walk.

When these tag objects point to blobs or trees, we need to make sure
those objects are also visited. Treat tagged trees as root trees, but
put the tagged blobs in their own category.

Be careful about objects that are referred to by multiple references.

Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/technical/api-path-walk.txt |  2 +-
 path-walk.c                               | 76 ++++++++++++++++++++
 path-walk.h                               |  2 +
 t/helper/test-path-walk.c                 | 13 +++-
 t/t6601-path-walk.sh                      | 85 +++++++++++++++++++++--
 5 files changed, 170 insertions(+), 8 deletions(-)

diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index b7ae476ea0a..5fea1d1db17 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -48,7 +48,7 @@ If you want the path-walk API to emit `UNINTERESTING` objects based on the
 commit walk's boundary, be sure to set `revs.boundary` so the boundary
 commits are emitted.
 
-`commits`, `blobs`, `trees`::
+`commits`, `blobs`, `trees`, `tags`::
 	By default, these members are enabled and signal that the path-walk
 	API should call the `path_fn` on objects of these types. Specialized
 	applications could disable some options to make it simpler to walk
diff --git a/path-walk.c b/path-walk.c
index 22e1aa13f31..7cd461adf47 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -13,6 +13,7 @@
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
+#include "tag.h"
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -204,13 +205,88 @@ int walk_objects_by_path(struct path_walk_info *info)
 	CALLOC_ARRAY(commit_list, 1);
 	commit_list->type = OBJ_COMMIT;
 
+	if (info->tags)
+		info->revs->tag_objects = 1;
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
 	strmap_put(&ctx.paths_to_lists, root_path, root_tree_list);
+
+	/*
+	 * Set these values before preparing the walk to catch
+	 * lightweight tags pointing to non-commits.
+	 */
+	info->revs->blob_objects = info->blobs;
+	info->revs->tree_objects = info->trees;
+
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
 
+	info->revs->blob_objects = info->revs->tree_objects = 0;
+
+	if (info->tags) {
+		struct oid_array tagged_blob_list = OID_ARRAY_INIT;
+		struct oid_array tags = OID_ARRAY_INIT;
+
+		trace2_region_enter("path-walk", "tag-walk", info->revs->repo);
+
+		/*
+		 * Walk any pending objects at this point, but they should only
+		 * be tags.
+		 */
+		for (size_t i = 0; i < info->revs->pending.nr; i++) {
+			struct object_array_entry *pending = info->revs->pending.objects + i;
+			struct object *obj = pending->item;
+
+			if (obj->type == OBJ_COMMIT || obj->flags & SEEN)
+				continue;
+
+			obj->flags |= SEEN;
+
+			while (obj->type == OBJ_TAG) {
+				struct tag *tag = lookup_tag(info->revs->repo,
+							     &obj->oid);
+				if (oid_array_lookup(&tags, &obj->oid) < 0)
+					oid_array_append(&tags, &obj->oid);
+				obj = tag->tagged;
+			}
+
+			switch (obj->type) {
+			case OBJ_TREE:
+				if (info->trees &&
+				    oid_array_lookup(&root_tree_list->oids, &obj->oid) < 0)
+					oid_array_append(&root_tree_list->oids, &obj->oid);
+				break;
+
+			case OBJ_BLOB:
+				if (info->blobs &&
+				    oid_array_lookup(&tagged_blob_list, &obj->oid) < 0)
+					oid_array_append(&tagged_blob_list, &obj->oid);
+				break;
+
+			case OBJ_COMMIT:
+				/* Make sure it is in the object walk */
+				add_pending_object(info->revs, obj, "");
+				break;
+
+			default:
+				BUG("should not see any other type here");
+			}
+		}
+
+		info->path_fn("", &tags, OBJ_TAG, info->path_fn_data);
+
+		if (tagged_blob_list.nr && info->blobs)
+			info->path_fn("/tagged-blobs", &tagged_blob_list, OBJ_BLOB,
+				      info->path_fn_data);
+
+		trace2_data_intmax("path-walk", ctx.repo, "tags", tags.nr);
+		trace2_region_leave("path-walk", "tag-walk", info->revs->repo);
+		oid_array_clear(&tags);
+		oid_array_clear(&tagged_blob_list);
+	}
+
 	while ((c = get_revision(info->revs))) {
 		struct object_id *oid;
 		struct tree *t;
diff --git a/path-walk.h b/path-walk.h
index 6ef372d8942..3f3b63180ef 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -37,12 +37,14 @@ struct path_walk_info {
 	int commits;
 	int trees;
 	int blobs;
+	int tags;
 };
 
 #define PATH_WALK_INFO_INIT {   \
 	.blobs = 1,		\
 	.trees = 1,		\
 	.commits = 1,		\
+	.tags = 1,		\
 }
 
 /**
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 37c5e3e31e8..c6c60d68749 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -21,6 +21,7 @@ struct path_walk_test_data {
 	uintmax_t commit_nr;
 	uintmax_t tree_nr;
 	uintmax_t blob_nr;
+	uintmax_t tag_nr;
 };
 
 static int emit_block(const char *path, struct oid_array *oids,
@@ -45,6 +46,11 @@ static int emit_block(const char *path, struct oid_array *oids,
 		tdata->blob_nr += oids->nr;
 		break;
 
+	case OBJ_TAG:
+		typestr = "TAG";
+		tdata->tag_nr += oids->nr;
+		break;
+
 	default:
 		BUG("we do not understand this type");
 	}
@@ -66,6 +72,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of blob objects")),
 		OPT_BOOL(0, "commits", &info.commits,
 			 N_("toggle inclusion of commit objects")),
+		OPT_BOOL(0, "tags", &info.tags,
+			 N_("toggle inclusion of tag objects")),
 		OPT_BOOL(0, "trees", &info.trees,
 			 N_("toggle inclusion of tree objects")),
 		OPT_END(),
@@ -92,8 +100,9 @@ int cmd__path_walk(int argc, const char **argv)
 
 	printf("commits:%" PRIuMAX "\n"
 	       "trees:%" PRIuMAX "\n"
-	       "blobs:%" PRIuMAX "\n",
-	       data.commit_nr, data.tree_nr, data.blob_nr);
+	       "blobs:%" PRIuMAX "\n"
+	       "tags:%" PRIuMAX "\n",
+	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
 
 	return res;
 }
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index e4788664f93..7758e2529ee 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -7,24 +7,55 @@ test_description='direct path-walk API tests'
 test_expect_success 'setup test repository' '
 	git checkout -b base &&
 
+	# Make some objects that will only be reachable
+	# via non-commit tags.
+	mkdir child &&
+	echo file >child/file &&
+	git add child &&
+	git commit -m "will abandon" &&
+	git tag -a -m "tree" tree-tag HEAD^{tree} &&
+	echo file2 >file2 &&
+	git add file2 &&
+	git commit --amend -m "will abandon" &&
+	git tag tree-tag2 HEAD^{tree} &&
+
+	echo blob >file &&
+	blob_oid=$(git hash-object -t blob -w --stdin <file) &&
+	git tag -a -m "blob" blob-tag "$blob_oid" &&
+	echo blob2 >file2 &&
+	blob2_oid=$(git hash-object -t blob -w --stdin <file2) &&
+	git tag blob-tag2 "$blob2_oid" &&
+
+	rm -fr child file file2 &&
+
 	mkdir left &&
 	mkdir right &&
 	echo a >a &&
 	echo b >left/b &&
 	echo c >right/c &&
 	git add . &&
-	git commit -m "first" &&
+	git commit --amend -m "first" &&
+	git tag -m "first" first HEAD &&
 
 	echo d >right/d &&
 	git add right &&
 	git commit -m "second" &&
+	git tag -a -m "second (under)" second.1 HEAD &&
+	git tag -a -m "second (top)" second.2 second.1 &&
 
+	# Set up file/dir collision in history.
+	rm a &&
+	mkdir a &&
+	echo a >a/a &&
 	echo bb >left/b &&
-	git commit -a -m "third" &&
+	git add a left &&
+	git commit -m "third" &&
+	git tag -a -m "third" third &&
 
 	git checkout -b topic HEAD~1 &&
 	echo cc >right/c &&
-	git commit -a -m "topic"
+	git commit -a -m "topic" &&
+	git tag -a -m "fourth" fourth
 '
 
 test_expect_success 'all' '
@@ -40,19 +71,35 @@ test_expect_success 'all' '
 	TREE::$(git rev-parse base^{tree})
 	TREE::$(git rev-parse base~1^{tree})
 	TREE::$(git rev-parse base~2^{tree})
+	TREE::$(git rev-parse refs/tags/tree-tag^{})
+	TREE::$(git rev-parse refs/tags/tree-tag2^{})
+	TREE:a/:$(git rev-parse base:a)
 	TREE:left/:$(git rev-parse base:left)
 	TREE:left/:$(git rev-parse base~2:left)
 	TREE:right/:$(git rev-parse topic:right)
 	TREE:right/:$(git rev-parse base~1:right)
 	TREE:right/:$(git rev-parse base~2:right)
-	trees:9
+	TREE:child/:$(git rev-parse refs/tags/tree-tag^{}:child)
+	trees:13
 	BLOB:a:$(git rev-parse base~2:a)
+	BLOB:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
 	BLOB:left/b:$(git rev-parse base~2:left/b)
 	BLOB:left/b:$(git rev-parse base:left/b)
 	BLOB:right/c:$(git rev-parse base~2:right/c)
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
-	blobs:6
+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	BLOB:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	BLOB:child/file:$(git rev-parse refs/tags/tree-tag^{}:child/file)
+	blobs:10
+	TAG::$(git rev-parse refs/tags/first)
+	TAG::$(git rev-parse refs/tags/second.1)
+	TAG::$(git rev-parse refs/tags/second.2)
+	TAG::$(git rev-parse refs/tags/third)
+	TAG::$(git rev-parse refs/tags/fourth)
+	TAG::$(git rev-parse refs/tags/tree-tag)
+	TAG::$(git rev-parse refs/tags/blob-tag)
+	tags:7
 	EOF
 
 	sort expect >expect.sorted &&
@@ -83,6 +130,7 @@ test_expect_success 'topic only' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
 	blobs:5
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -106,6 +154,7 @@ test_expect_success 'topic, not base' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse topic:right/d)
 	blobs:4
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -126,6 +175,7 @@ test_expect_success 'topic, not base, only blobs' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse topic:right/d)
 	blobs:4
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -145,6 +195,7 @@ test_expect_success 'topic, not base, only commits' '
 	commits:1
 	trees:0
 	blobs:0
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -164,6 +215,7 @@ test_expect_success 'topic, not base, only trees' '
 	TREE:right/:$(git rev-parse topic:right)
 	trees:3
 	blobs:0
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -191,6 +243,7 @@ test_expect_success 'topic, not base, boundary' '
 	BLOB:right/c:$(git rev-parse topic:right/c)
 	BLOB:right/d:$(git rev-parse base~1:right/d)
 	blobs:5
+	tags:0
 	EOF
 
 	sort expect >expect.sorted &&
@@ -199,4 +252,26 @@ test_expect_success 'topic, not base, boundary' '
 	test_cmp expect.sorted out.sorted
 '
 
+test_expect_success 'trees are reported exactly once' '
+	test_when_finished "rm -rf unique-trees" &&
+	test_create_repo unique-trees &&
+	(
+		cd unique-trees &&
+		mkdir initial &&
+		test_commit initial/file &&
+
+		git switch -c move-to-top &&
+		git mv initial/file.t ./ &&
+		test_tick &&
+		git commit -m moved &&
+
+		git update-ref refs/heads/other HEAD
+	) &&
+
+	test-tool -C unique-trees path-walk -- --all >out &&
+	tree=$(git -C unique-trees rev-parse HEAD:) &&
+	grep "$tree" out >out-filtered &&
+	test_line_count = 1 out-filtered
+'
+
 test_done
-- 
gitgitgadget

