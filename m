Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC6E204564
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514372; cv=none; b=kYbmk0zS8XMeqcE7Dfgi2MFrSQx6i93Uvq4pCFMJX/ZPuBz+Q4/UCyCpSIT+guX7hoygcmt8mqX3eWRP9cnmcZIeaDBHFIK6zF3dvsfMzjFtpvkb6xu71ngfeLkXBDZT+9ojWttOguajk9O4cEKk+sWMaf0VzU4E5FRAUmHLW3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514372; c=relaxed/simple;
	bh=wgirCaqzhIn7DEnoeZ4103AqxtLupneOjv31ZXYuunU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OLrZ1Yr4Rjp3e0kQ3J600PODt/jGc4u0wQEkRNFBq+jRiTifuBbV4pgL8Gaxs3FOrgyA+b5w9lwqAqzB7l3CI4X4cKd936AQrtfYVWm+Y8nJBe8FGvr++M/TnUz00iZofWDkOwNMrYAnuVGn2yy96uu/rmJ0q7b++ZOuoPyELpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJWa/AUR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJWa/AUR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43494a20379so23222935e9.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 11:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733514368; x=1734119168; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nUoNUVZhp2X/K+lyPKOKreIkzuDEhzLtrHnBQukIBRI=;
        b=cJWa/AURWl1V0v3U/7F5chu5GcIf37VIvI1tP0FkxZQhHuf157Huq74Gby+zyxNiEf
         Oxk1rJYk2mrpB7CO/tIvb+MlyBUUeEyxe8S+TL/GqH3m1iT/QVeIgfWKubhNIkSB7MFr
         4qdON91zmq3eDFYZ67IS09NKQB9Kyx+MLrFNLmR8a9UQ9Fyay38ksXob/u8Q+Hbkf/bp
         gETB6TpspJhLwFCMJ6wHBc5uo+W5VD3llOs5Txwt7oAy1ZcXiSqcAFpAqesBlZLLh+vL
         IxzdhLt9jiqtAEobBHXkG9vYdQ2guLj55yH4qHbzByMqcico+dTzXpclQFnHXr5Fury3
         1tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733514368; x=1734119168;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUoNUVZhp2X/K+lyPKOKreIkzuDEhzLtrHnBQukIBRI=;
        b=BAQ5A/sWuqVgrufTP5y1t+rLc0kB6iy7Sop1y8SoWZQwKMZoNyt8/m4NRivNT76lr1
         4p/2PlVbPbKOHNWvmnmfBNXGlMMfiEvsYLe55HrUGwn6RCNOhcUMX4c4vuww2UaX9llH
         MzbrHNS1834QlwYz+L5gPtfDhGTu0vj/I0gqoh6c51xg0ck3yyDNW5enVVAAzXOHRNfX
         ocF9Iiofkm1x+0fRmo5BMki7bpm5yY4HvWk2eBcDiL2XhvY7IqeGTjTTKbhHZSOIlyJy
         a1W3GleLScNCuEDjM4QtUqwEs7FqkAGp4Tm9eM4AzfWJMpoS3FoxqVc11BPm5P5nscC0
         FEeA==
X-Gm-Message-State: AOJu0YxLxp2ZcpisM8i1xMQu8eq9FYtNornsgWuYWEIpSfHoRfPpsifp
	z/96WK5FPVtKaYqHgStL4pcN2G4sRPd2NAu3sOsyaRqNLDkGxbfo6sT8ZA==
X-Gm-Gg: ASbGncuMe0mJEfBjtbOva1ccpfymuI6lG8Hq6l4MTTH7xCg+XBZ057QdxHkaCdvE1oF
	ElZ8ry9XFk4uK4o5xViz2R0HYdL7ICexbnAfjZfth2C0IXCX244osZx8WkKJZDSeglFFOrn/FkM
	3l+4lbiO2s9nctzsgpez0cY+sYJnvA/XRj56RbYbwed6XNW8sMn70rNqxjmnGGW0xzwonv+6kYc
	q7s9drf6+Nq7ilSGybPkyLGIps6ndzG0rzctXDQVJfTcd8HI5E=
X-Google-Smtp-Source: AGHT+IET32QvB85AMWt2xUXzWKfFKu9u1t3ifBvxxfEW1BaxQXGhP1j2Qox757OQ5fEAAk2VY3BX0g==
X-Received: by 2002:a05:600c:548b:b0:434:a71f:f804 with SMTP id 5b1f17b1804b1-434ddeae72fmr40882515e9.3.1733514367339;
        Fri, 06 Dec 2024 11:46:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da0d6961sm64593015e9.12.2024.12.06.11.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:46:06 -0800 (PST)
Message-Id: <e716672c041473dd2bf257b7532b86696fef32a0.1733514359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
References: <pull.1818.v2.git.1731181272.gitgitgadget@gmail.com>
	<pull.1818.v3.git.1733514358.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 19:45:58 +0000
Subject: [PATCH v3 7/7] path-walk: reorder object visits
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
 t/t6601-path-walk.sh | 122 +++++++++++++++++++++----------------------
 2 files changed, 109 insertions(+), 73 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 896ec0c4779..b31924df52e 100644
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
@@ -50,16 +51,50 @@ struct path_walk_context {
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
@@ -67,7 +102,7 @@ static void push_to_stack(struct path_walk_context *ctx,
 		return;
 
 	strset_add(&ctx->path_stack_pushed, path);
-	string_list_append(&ctx->path_stack, path);
+	prio_queue_put(&ctx->path_stack, xstrdup(path));
 }
 
 static int add_children(struct path_walk_context *ctx,
@@ -372,8 +407,8 @@ static void setup_pending_objects(struct path_walk_info *info,
 			const char *tagged_blob_path = "/tagged-blobs";
 			tagged_blobs->type = OBJ_BLOB;
 			tagged_blobs->maybe_interesting = 1;
-			push_to_stack(ctx, tagged_blob_path);
 			strmap_put(&ctx->paths_to_lists, tagged_blob_path, tagged_blobs);
+			push_to_stack(ctx, tagged_blob_path);
 		} else {
 			oid_array_clear(&tagged_blobs->oids);
 			free(tagged_blobs);
@@ -384,8 +419,8 @@ static void setup_pending_objects(struct path_walk_info *info,
 			const char *tag_path = "/tags";
 			tags->type = OBJ_TAG;
 			tags->maybe_interesting = 1;
-			push_to_stack(ctx, tag_path);
 			strmap_put(&ctx->paths_to_lists, tag_path, tags);
+			push_to_stack(ctx, tag_path);
 		} else {
 			oid_array_clear(&tags->oids);
 			free(tags);
@@ -410,7 +445,10 @@ int walk_objects_by_path(struct path_walk_info *info)
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
@@ -493,8 +531,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	trace2_region_enter("path-walk", "path-walk", info->revs->repo);
 	while (!ret && ctx.path_stack.nr) {
-		char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
-		ctx.path_stack.nr--;
+		char *path = prio_queue_get(&ctx.path_stack);
 		paths_nr++;
 
 		ret = walk_path(&ctx, path);
@@ -511,8 +548,7 @@ int walk_objects_by_path(struct path_walk_info *info)
 			push_to_stack(&ctx, entry->key);
 
 		while (!ret && ctx.path_stack.nr) {
-			char *path = ctx.path_stack.items[ctx.path_stack.nr - 1].string;
-			ctx.path_stack.nr--;
+			char *path = prio_queue_get(&ctx.path_stack);
 			paths_nr++;
 
 			ret = walk_path(&ctx, path);
@@ -526,6 +562,6 @@ int walk_objects_by_path(struct path_walk_info *info)
 
 	clear_strmap(&ctx.paths_to_lists);
 	strset_clear(&ctx.path_stack_pushed);
-	string_list_clear(&ctx.path_stack, 0);
+	clear_prio_queue(&ctx.path_stack);
 	return ret;
 }
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index a317cdf289e..7d765ffe907 100755
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
@@ -155,18 +155,18 @@ test_expect_success 'branches and indexed objects mix well' '
 	1:tree::$(git rev-parse base~1^{tree})
 	1:tree::$(git rev-parse base~2^{tree})
 	2:blob:a:$(git rev-parse base~2:a)
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
+	3:tree:a/:$(git rev-parse refs/tags/third:a)
+	4:tree:left/:$(git rev-parse base:left)
+	4:tree:left/:$(git rev-parse base~2:left)
+	5:blob:left/b:$(git rev-parse base:left/b)
+	5:blob:left/b:$(git rev-parse base~2:left/b)
+	6:tree:right/:$(git rev-parse topic:right)
+	6:tree:right/:$(git rev-parse base~1:right)
+	6:tree:right/:$(git rev-parse base~2:right)
+	7:blob:right/c:$(git rev-parse base~2:right/c)
+	7:blob:right/c:$(git rev-parse topic:right/c)
+	8:blob:right/d:$(git rev-parse base~1:right/d)
+	8:blob:right/d:$(git rev-parse :right/d)
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
