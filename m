Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55CD21A458
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711690; cv=none; b=urpI9DYoVPHy9dNu0N7moqgCiataPcHjy6blPwRanH2LWek7rNkTXnMlM8YzeiNLd+N6uAOKtHs3Ay8zR/IDOb2o0O8hTT07V8PyL0uoRJNwX8FCR1aLLoDckPsLEIT5h3CAvdJhhms2ALsrmgvdD9nfHE4insqsBsSnMtq4Hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711690; c=relaxed/simple;
	bh=iPj9apbad7G9Dkvr80M6Q8f1APNGa3ViPfHIy7aZGSU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=knpIdZc0QmK1517l9Yh8Bwwa8QYw3Ln6Kl+6WMjDO0oDHcnfWFWm8hrfoiMkA/aCbnJ04rWe56uONyzdMQKz3EinEBHrTndD2o1IjXVuDocpob3REm9zHqmO5C6+cjlfwbxkl00oJWcgu4DtTaJPnXEd4fxV55Q9LRX+1Q3sUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJq/ykx5; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJq/ykx5"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso20482985e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734711687; x=1735316487; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jS6IRldV0kXxDpzTrwX4vJ4Stv77WPjfZ/AiohQUSoE=;
        b=fJq/ykx5znX4do6z93Z0ItRuycgACduGJuNsaeDcmLX5m7BwcbjwTzqO4WcWWfSYKd
         Q4uWbHY4ejeqzcxwba21+2TpFGoQaImFdtU0Q5WDll8HUCZF1jtVLO4R+B/vHfzvvJec
         +VWQ8iusslTuxsY+43+7sHDHHdF0YWMy7PtjAKBk09de5gnric9qzuytNfuCMv+rSVy/
         EjKx8y1xUzpPERCjqpRARQzaUAw9fcO344vrnnVX8dIacJPkjqgwKLNHL8Ag4C1JO7GN
         rdaqBGvJwlo5BthezV9mY4342SzY8+F1sWKavKq4MaVl7lF0+RLDlNl/A4WZXaxZbjbj
         7wUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734711687; x=1735316487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS6IRldV0kXxDpzTrwX4vJ4Stv77WPjfZ/AiohQUSoE=;
        b=lykq+aZxIsn6Ba5H0t4X5NpuLiHaAfbOybizh8GTlo1/ih7hy8HnNcuEjLOzhIaofz
         dc+Web9iv4RkaOVgNzZ6SBgVlddvRcp1KvJxCbA5Y6OaKx/KSTK3iIy0VCdJGam+IlIq
         jWh5MQQtdyKaf043huPKK3ymkTcuyMDyTU0/HNVoP9aGDIlFCG1zFIEiO7oZKpFObcif
         OC2vnI9EpMkkxTVy+wyimcubceefpqxUyA4Kwzt3fqoexGoPiJ1ZbyMcUqYuLE/f0SE6
         2NT/bEJVoDQRtzDnUNcz4nU26kj2l+diNPE0e9MpCNZ+Z240Te4z4Lqbyy8HNSvzzrRb
         WT8Q==
X-Gm-Message-State: AOJu0YxlMSwjir/r08Y/Wa5DNBzmUXrLl40VZU5eq/1w3tR4Ilx3leJc
	VxcKlqMf+o3yF9U7e76e3WYC4EDn/3FlF5NHeQkTN0ntvNGlbSj8CkOvBg==
X-Gm-Gg: ASbGnctHP3+aHN/0h/Bu406xYnj9wztYhJAK4RDJzJngb93QYnHvNOa64dlo1PHs9dm
	NdNAwX1neRd5ilgVePD+23yZH/4PNhnvnXrCiB11ZvvAXlSLayKaA7EZmreNEPwHpuU6XcTP3LM
	QIkQo/hpLL3MjK1gpQgX1QS4O6YGJ+p/urqdrRN8y7ouYOartP2NwObzWm2c9prIZ9FkVxh7MHI
	PFcri3sLZ11g4a4+7POLKqZIO0Svm64gpiCoqTjgNtU0S0S1LpSWE4BDA==
X-Google-Smtp-Source: AGHT+IGMcsHfca3jvVKdSrZQD1kRuvyaC7AMhu5oDitjqs9rlDQnflKi5Hi9XOHf1brfOyRnKetUFg==
X-Received: by 2002:a5d:6da1:0:b0:385:e5d8:2bea with SMTP id ffacd0b85a97d-38a221fa065mr3587711f8f.20.1734711686432;
        Fri, 20 Dec 2024 08:21:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b013ecsm83873635e9.16.2024.12.20.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:21:25 -0800 (PST)
Message-Id: <ef543429ed9cb92e209900e7c7fc4f8e0698a306.1734711676.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
References: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
	<pull.1818.v4.git.1734711675.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:21:15 +0000
Subject: [PATCH v4 7/7] path-walk: reorder object visits
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
    jonathantanmy@google.com,
    karthik nayak <karthik.188@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The path-walk API currently uses a stack-based approach to recursing
through the list of paths within the repository. This guarantees that
after a tree path is explored, all paths contained within that tree path
will be explored before continuing to explore siblings of that tree
path.

The initial motivation of this depth-first approach was to minimize
memory pressure while exploring the repository. A breadth-first approach
would have too many "active" paths being stored in the paths_to_lists
map.

We can take this approach one step further by making sure that blob
paths are visited before tree paths. This allows the API to free the
memory for these blob objects before continuing to perform the
depth-first search. This modifies the order in which we visit siblings,
but does not change the fact that we are performing depth-first search.

To achieve this goal, use a priority queue with a custom sorting method.
The sort needs to handle tags, blobs, and trees (commits are handled
slightly differently). When objects share a type, we can sort by path
name. This will keep children of the latest path to leave the stack be
preferred over the rest of the paths in the stack, since they agree in
prefix up to and including a directory separator. When the types are
different, we can prefer tags over other types and blobs over trees.

This causes significant adjustments to t6601-path-walk.sh to rearrange
the order of the visited paths.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c          |  60 ++++++++++++++++-----
 t/t6601-path-walk.sh | 124 +++++++++++++++++++++----------------------
 2 files changed, 110 insertions(+), 74 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 4013569e9e4..136ec08fb0e 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "object.h"
 #include "oid-array.h"
+#include "prio-queue.h"
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
@@ -49,16 +50,50 @@ struct path_walk_context {
 	struct strmap paths_to_lists;
 
 	/**
-	 * Store the current list of paths in a stack, to
-	 * facilitate depth-first-search without recursion.
+	 * Store the current list of paths in a priority queue,
+	 * using object type as a sorting mechanism, mostly to
+	 * make sure blobs are popped off the stack first. No
+	 * other sort is made, so within each object type it acts
+	 * like a stack and performs a DFS within the trees.
 	 *
 	 * Use path_stack_pushed to indicate whether a path
 	 * was previously added to path_stack.
 	 */
-	struct string_list path_stack;
+	struct prio_queue path_stack;
 	struct strset path_stack_pushed;
 };
 
+static int compare_by_type(const void *one, const void *two, void *cb_data)
+{
+	struct type_and_oid_list *list1, *list2;
+	const char *str1 = one;
+	const char *str2 = two;
+	struct path_walk_context *ctx = cb_data;
+
+	list1 = strmap_get(&ctx->paths_to_lists, str1);
+	list2 = strmap_get(&ctx->paths_to_lists, str2);
+
+	/*
+	 * If object types are equal, then use path comparison.
+	 */
+	if (!list1 || !list2 || list1->type == list2->type)
+		return strcmp(str1, str2);
+
+	/* Prefer tags to be popped off first. */
+	if (list1->type == OBJ_TAG)
+		return -1;
+	if (list2->type == OBJ_TAG)
+		return 1;
+
+	/* Prefer blobs to be popped off second. */
+	if (list1->type == OBJ_BLOB)
+		return -1;
+	if (list2->type == OBJ_BLOB)
+		return 1;
+
+	return 0;
+}
+
 static void push_to_stack(struct path_walk_context *ctx,
 			  const char *path)
 {
@@ -66,7 +101,7 @@ static void push_to_stack(struct path_walk_context *ctx,
 		return;
 
 	strset_add(&ctx->path_stack_pushed, path);
-	string_list_append(&ctx->path_stack, path);
+	prio_queue_put(&ctx->path_stack, xstrdup(path));
 }
 
 static int add_tree_entries(struct path_walk_context *ctx,
@@ -378,8 +413,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 			const char *tagged_blob_path = "/tagged-blobs";
 			tagged_blobs->type = OBJ_BLOB;
 			tagged_blobs->maybe_interesting = 1;
-			push_to_stack(ctx, tagged_blob_path);
 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
+			push_to_stack(ctx, tagged_blob_path);
 		} else {
 			oid_array_clear(&tagged_blobs->oids);
 			free(tagged_blobs);
@@ -390,8 +425,8 @@ static int setup_pending_objects(struct path_walk_info *info,
 			const char *tag_path = "/tags";
 			tags->type = OBJ_TAG;
 			tags->maybe_interesting = 1;
-			push_to_stack(ctx, tag_path);
 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
+			push_to_stack(ctx, tag_path);
 		} else {
 			oid_array_clear(&tags->oids);
 			free(tags);
@@ -418,7 +453,10 @@ int walk_objects_by_path(struct path_walk_info *info)
 		.repo = info->revs->repo,
 		.revs = info->revs,
 		.info = info,
-		.path_stack = STRING_LIST_INIT_DUP,
+		.path_stack = {
+			.compare = compare_by_type,
+			.cb_data = &ctx
+		},
 		.path_stack_pushed = STRSET_INIT,
 		.paths_to_lists = STRMAP_INIT
 	};
@@ -504,8 +542,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
 	while (!ret && ctx.path_stack.nr) {
-		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
-		ctx.path_stack.nr--;
+		char *path = prio_queue_get(&ctx.path_stack);
 		paths_nr++;
 
 		ret = walk_path(&ctx, path);
@@ -522,8 +559,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 			push_to_stack(&ctx, entry->key);
 
 		while (!ret && ctx.path_stack.nr) {
-			char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
-			ctx.path_stack.nr--;
+			char *path = prio_queue_get(&ctx.path_stack);
 			paths_nr++;
 
 			ret = walk_path(&ctx, path);
@@ -537,7 +573,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	clear_paths_to_lists(&ctx.paths_to_lists);
 	strset_clear(&ctx.path_stack_pushed);
-	string_list_clear(&ctx.path_stack, 0);
+	clear_prio_queue(&ctx.path_stack);
 	return ret;
 }
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index a317cdf289e..5f04acb8a2f 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -84,20 +84,20 @@ test_expect_success 'all' '
 	3:tree::$(git rev-parse refs/tags/tree-tag^{})
 	3:tree::$(git rev-parse refs/tags/tree-tag2^{})
 	4:blob:a:$(git rev-parse base~2:a)
-	5:tree:right/:$(git rev-parse topic:right)
-	5:tree:right/:$(git rev-parse base~1:right)
-	5:tree:right/:$(git rev-parse base~2:right)
-	6:blob:right/d:$(git rev-parse base~1:right/d)
-	7:blob:right/c:$(git rev-parse base~2:right/c)
-	7:blob:right/c:$(git rev-parse topic:right/c)
-	8:tree:left/:$(git rev-parse base:left)
-	8:tree:left/:$(git rev-parse base~2:left)
-	9:blob:left/b:$(git rev-parse base~2:left/b)
-	9:blob:left/b:$(git rev-parse base:left/b)
-	10:tree:a/:$(git rev-parse base:a)
-	11:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
-	12:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
-	13:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	5:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	6:tree:a/:$(git rev-parse base:a)
+	7:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	8:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	9:tree:left/:$(git rev-parse base:left)
+	9:tree:left/:$(git rev-parse base~2:left)
+	10:blob:left/b:$(git rev-parse base~2:left/b)
+	10:blob:left/b:$(git rev-parse base:left/b)
+	11:tree:right/:$(git rev-parse topic:right)
+	11:tree:right/:$(git rev-parse base~1:right)
+	11:tree:right/:$(git rev-parse base~2:right)
+	12:blob:right/c:$(git rev-parse base~2:right/c)
+	12:blob:right/c:$(git rev-parse topic:right/c)
+	13:blob:right/d:$(git rev-parse base~1:right/d)
 	blobs:10
 	commits:4
 	tags:7
@@ -154,19 +154,19 @@ test_expect_success 'branches and indexed objects mix well' '
 	1:tree::$(git rev-parse base^{tree})
 	1:tree::$(git rev-parse base~1^{tree})
 	1:tree::$(git rev-parse base~2^{tree})
-	2:blob:a:$(git rev-parse base~2:a)
-	3:tree:right/:$(git rev-parse topic:right)
-	3:tree:right/:$(git rev-parse base~1:right)
-	3:tree:right/:$(git rev-parse base~2:right)
-	4:blob:right/d:$(git rev-parse base~1:right/d)
-	4:blob:right/d:$(git rev-parse :right/d)
-	5:blob:right/c:$(git rev-parse base~2:right/c)
-	5:blob:right/c:$(git rev-parse topic:right/c)
-	6:tree:left/:$(git rev-parse base:left)
-	6:tree:left/:$(git rev-parse base~2:left)
-	7:blob:left/b:$(git rev-parse base:left/b)
-	7:blob:left/b:$(git rev-parse base~2:left/b)
-	8:tree:a/:$(git rev-parse refs/tags/third:a)
+	2:tree:a/:$(git rev-parse refs/tags/third:a)
+	3:tree:left/:$(git rev-parse base:left)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:blob:left/b:$(git rev-parse base:left/b)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right)
+	5:tree:right/:$(git rev-parse base~2:right)
+	6:blob:right/c:$(git rev-parse base~2:right/c)
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:blob:right/d:$(git rev-parse base~1:right/d)
+	7:blob:right/d:$(git rev-parse :right/d)
+	8:blob:a:$(git rev-parse base~2:a)
 	blobs:7
 	commits:4
 	tags:0
@@ -186,15 +186,15 @@ test_expect_success 'topic only' '
 	1:tree::$(git rev-parse topic^{tree})
 	1:tree::$(git rev-parse base~1^{tree})
 	1:tree::$(git rev-parse base~2^{tree})
-	2:tree:right/:$(git rev-parse topic:right)
-	2:tree:right/:$(git rev-parse base~1:right)
-	2:tree:right/:$(git rev-parse base~2:right)
-	3:blob:right/d:$(git rev-parse base~1:right/d)
-	4:blob:right/c:$(git rev-parse base~2:right/c)
-	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse base~2:left)
-	6:blob:left/b:$(git rev-parse base~2:left/b)
-	7:blob:a:$(git rev-parse base~2:a)
+	2:blob:a:$(git rev-parse base~2:a)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right)
+	5:tree:right/:$(git rev-parse base~2:right)
+	6:blob:right/c:$(git rev-parse base~2:right/c)
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:blob:right/d:$(git rev-parse base~1:right/d)
 	blobs:5
 	commits:3
 	tags:0
@@ -210,12 +210,12 @@ test_expect_success 'topic, not base' '
 	cat >expect <<-EOF &&
 	0:commit::$(git rev-parse topic)
 	1:tree::$(git rev-parse topic^{tree})
-	2:tree:right/:$(git rev-parse topic:right)
-	3:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
-	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse topic:left):UNINTERESTING
-	6:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
-	7:blob:a:$(git rev-parse topic:a):UNINTERESTING
+	2:blob:a:$(git rev-parse topic:a):UNINTERESTING
+	3:tree:left/:$(git rev-parse topic:left):UNINTERESTING
+	4:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	5:tree:right/:$(git rev-parse topic:right)
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	blobs:4
 	commits:1
 	tags:0
@@ -233,12 +233,12 @@ test_expect_success 'fourth, blob-tag2, not base' '
 	1:tag:/tags:$(git rev-parse fourth)
 	2:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
 	3:tree::$(git rev-parse topic^{tree})
-	4:tree:right/:$(git rev-parse topic:right)
-	5:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
-	6:blob:right/c:$(git rev-parse topic:right/c)
-	7:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
-	8:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
-	9:blob:a:$(git rev-parse base~1:a):UNINTERESTING
+	4:blob:a:$(git rev-parse base~1:a):UNINTERESTING
+	5:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	6:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	7:tree:right/:$(git rev-parse topic:right)
+	8:blob:right/c:$(git rev-parse topic:right/c)
+	9:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:5
 	commits:1
 	tags:1
@@ -253,10 +253,10 @@ test_expect_success 'topic, not base, only blobs' '
 		-- topic --not base >out &&
 
 	cat >expect <<-EOF &&
-	0:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
-	1:blob:right/c:$(git rev-parse topic:right/c)
-	2:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
-	3:blob:a:$(git rev-parse topic:a):UNINTERESTING
+	0:blob:a:$(git rev-parse topic:a):UNINTERESTING
+	1:blob:left/b:$(git rev-parse topic:left/b):UNINTERESTING
+	2:blob:right/c:$(git rev-parse topic:right/c)
+	3:blob:right/d:$(git rev-parse topic:right/d):UNINTERESTING
 	blobs:4
 	commits:0
 	tags:0
@@ -289,8 +289,8 @@ test_expect_success 'topic, not base, only trees' '
 
 	cat >expect <<-EOF &&
 	0:tree::$(git rev-parse topic^{tree})
-	1:tree:right/:$(git rev-parse topic:right)
-	2:tree:left/:$(git rev-parse topic:left):UNINTERESTING
+	1:tree:left/:$(git rev-parse topic:left):UNINTERESTING
+	2:tree:right/:$(git rev-parse topic:right)
 	commits:0
 	blobs:0
 	tags:0
@@ -308,14 +308,14 @@ test_expect_success 'topic, not base, boundary' '
 	0:commit::$(git rev-parse base~1):UNINTERESTING
 	1:tree::$(git rev-parse topic^{tree})
 	1:tree::$(git rev-parse base~1^{tree}):UNINTERESTING
-	2:tree:right/:$(git rev-parse topic:right)
-	2:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
-	3:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
-	4:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
-	4:blob:right/c:$(git rev-parse topic:right/c)
-	5:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
-	6:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
-	7:blob:a:$(git rev-parse base~1:a):UNINTERESTING
+	2:blob:a:$(git rev-parse base~1:a):UNINTERESTING
+	3:tree:left/:$(git rev-parse base~1:left):UNINTERESTING
+	4:blob:left/b:$(git rev-parse base~1:left/b):UNINTERESTING
+	5:tree:right/:$(git rev-parse topic:right)
+	5:tree:right/:$(git rev-parse base~1:right):UNINTERESTING
+	6:blob:right/c:$(git rev-parse base~1:right/c):UNINTERESTING
+	6:blob:right/c:$(git rev-parse topic:right/c)
+	7:blob:right/d:$(git rev-parse base~1:right/d):UNINTERESTING
 	blobs:5
 	commits:2
 	tags:0
-- 
gitgitgadget
