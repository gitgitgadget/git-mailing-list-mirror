Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D73C6A39
	for <git@vger.kernel.org>; Mon,  4 May 2026 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777926096; cv=none; b=fu8lljGBmOY0eYzyEVRjS03b89HLI5GJ8TAawrYniXf2o5s30kH+zwI275hwHdXCX0Hn4YwqWBuAAo0ufoAccMEclZJedXSx+eMwlLQjPBXsh4R7xGqdXp15TzXXS8oQ0M/vKRfMDhz6GBdsbaIodTewIj8GcfZNq791mmZdVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777926096; c=relaxed/simple;
	bh=2RpOt7D9X/ngZruR8EZjx23vXQ7xs3Tclej6Xn8uuCk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ikkkTQI3wpu+1jy4CoyjwS8FxM1cHCW3M6sEzoUegctoBK1ZLBsXTmDfo/7XEplZxTYXEYczDTbwvnTUAH1wNEHMCYsdOXy8wIf8Yk9n1aQF9JrtBKZL3RQWiyOSiihXGE+sPT9FpNrOf2C/IQfgu3+iZ2kT4A04J9aQbtWCxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/nwTnMb; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/nwTnMb"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ee9ec26edaso469938085a.2
        for <git@vger.kernel.org>; Mon, 04 May 2026 13:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777926093; x=1778530893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PfJYSMQZi6y/NHLld6PooiwMr6EruADQ24+xvpCfuMQ=;
        b=c/nwTnMbJWEI3WpLkgAB5atiQjteHYx+Pv3IZp83ogzdWXNgLj7yku23x18Uc6AQyb
         UdS8APVdk7iCAmDhPOLWo/GuEQQsxbHOu3wng7a0KzHA9K0psSinW2yYp76SQhH4H4eo
         pVEWjayzxxIoTp4q58H60Eo260+wEiOMcCk0UOPSwmOF/aaJPZAovIIR374GcJaedy3d
         hwUKYNoytMNTxs7F+3MeV85jyS8QezVIyMn24pDdgwcTwhgNptPdT0ISSma0jFZdB5Zt
         8lKxCsYCaV+/WSjPrnqE6Qa27FlvSDod8yJMWYGOqYrlLYzI7xSQ7DPlHkZXTb7LsUCw
         khlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777926093; x=1778530893;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PfJYSMQZi6y/NHLld6PooiwMr6EruADQ24+xvpCfuMQ=;
        b=XSp4w7TP1KmO9JYcaTjhxTBv3gWZGgJXkNh+nWg19gNSvsv2dWW0eQN67Lw0WGMyaR
         igyDQs5n+Ggk/w3ZE/AbKOSTTJ2kzU1VFOL4WLeanQuwmv2oki09vRP2i7mV58h8Kzal
         8IEp+wjB5IwybNiHTS7JZp22cmoE3OsHBBJp6Yvei0Zk1DP/4dErOQnZavDJFroMcqLu
         qDue91+6p4P4TBia2wVphT2oHBaX2VhvzwsrL81VxtCHToJVqapVuLGc+7TyZqHJEks3
         Are0VECcrQgJv+YsO/B9Z64VB4JnBH+jB+I+pZr2GwRfesjtz8iWBVv5qdZjgMxOa7Fn
         o8Sw==
X-Gm-Message-State: AOJu0Yz860/wO47XH+YgCouHSYiboG20ZhgHRAH6QUSMNGNlLwo41cbp
	3OsIEfFDk4XzMS8sCWA9XiltOud2zWcbXg1vbYVgp+tRHPeH56xocgaRvcmrzw==
X-Gm-Gg: AeBDiev9CuLTL9mIIn6OdUHEnKJwd+r4SPRS3/tQdZ/b+rni7P/OJ8c58yBb+4e0bhp
	bRjXzaBvSnqc25e3C0cYstWEdFRwccaehPmoXb/SSolTpXVbxVaDjtUJrObToqklkBuUNhSVRhW
	hpWMhja4t2gihaPOaUmzrWKR2SJ6G6A0Wcrabbs17dKvJ/ZzrIWEtkwPv+V+aD5w1QU5c05ys5U
	eQqWjGb5vAsSkbt9KyjwQTfkQRNcY9utKrOHVfmylMAywWz416GcM/KbTJcnfjl/us7lSK0C4EZ
	2tSMQySHbMoPMu+f1lt4kGKpIYfMCEyWW2DAAp5/fl8xj6JqicfFh0o5mZZPxrTPpfV+EQhk7Xh
	j0lBGO67UnsQnqLhTGgcUd9M1x09DDiv9qCMA+uOBkt2Uuw0++gWZ1pOzrnKGoTtyHY3Mp9D+Ig
	zKrq3Y2Rxq9r8HuJ8+LgVGvkSC4xpCHQ4fC+Dk
X-Received: by 2002:a05:620a:444f:b0:8dd:b4fc:d561 with SMTP id af79cd13be357-902e48b9a7emr75861785a.10.1777926092836;
        Mon, 04 May 2026 13:21:32 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91c807sm1257600685a.32.2026.05.04.13.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:21:32 -0700 (PDT)
Message-Id: <c557f3c59d8cca51c0669d5463a7e032f9f8ab72.1777926079.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
	<pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 20:21:18 +0000
Subject: [PATCH v2 09/10] path-walk: support `object:type` filter
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
    Derrick Stolee <stolee@gmail.com>,
    Taylor Blau <me@ttaylorr.com>

From: Taylor Blau <me@ttaylorr.com>

The `object:type` filter accepts only objects of a single type; it is
the second member of the object-info-only filter family that bitmap
traversal already supports.

Like `blob:none` and `tree:0`, it can be evaluated with nothing more
than the object's type, which is exactly the granularity path-walk's
existing info->{commits,trees,blobs,tags} flags already control.

Map `LOFC_OBJECT_TYPE` in `prepare_filters()` by AND-ing each flag
against the filtered type. A single `object:type=X` filter
applied to the default info (all flags = 1) leaves `info->X = 1` and
all the others 0, which is what we want.

Using an AND rather than straight assignment prepares us for a
subsequent change to implement combined object filters.

The path-walk machinery is mostly already wired for the per-type
distinction:

 - `walk_path()` calls `path_fn` for a batch only when the corresponding
   `info->X` flag is set, so unwanted types are silently not reported.

 - `add_tree_entries()` skips tree entries of type `OBJ_BLOB` when
   `info->blobs` is unset, so we don't even allocate paths for them.

 - The commit-walk loop short-circuits the root-tree fetch when
   `!info->trees && !info->blobs`, so commit-only filters don't descend
   into trees at all.

But there are a couple of side effects of the "trees off, blobs on" case
that need fixing:

 1. 'setup_pending_objects()' previously skipped pending trees as soon
    as `info->trees` was zero. For 'object:type=blob' the call site
    needs those pending trees: a lightweight tag pointing to a tree, or
    an annotated tag whose peeled target is a tree, can both reach
    blobs that are otherwise unreachable from any commit's root tree.
    Loosen the gate to "if (!info->trees && !info->blobs) continue" and
    similarly retrieve the root_tree_list whenever either trees or
    blobs are wanted.

 2. The revision machinery's `handle_commit()` drops pending trees when
    `revs->tree_objects` is zero (see the 'OBJ_TREE' handler in
    revision.c), so by the time path-walk sees the pending list
    after `prepare_revision_walk()` the tree-bearing pendings would
    already be gone. Fix this by setting

        revs->tree_objects = info->trees || info->blobs

    so pending trees survive `prepare_revision_walk()` whenever we
    need to walk into them. Path-walk still resets tree_objects to
    zero immediately after `prepare_revision_walk()` returns, so the
    rev-walk itself never enumerates trees redundantly with
    path-walk's own descent.

Add coverage in t6601 for each of the four `object:type` values. The
'object:type=blob' test in particular asserts that file2 and child/file
(both reachable only through tag-pointed trees) show up in the output,
exercising the pending-tree fix.

Update Documentation/git-pack-objects.adoc to add object:type to
the list of supported --filter forms.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-pack-objects.adoc |  2 +-
 path-walk.c                         | 23 +++++++-
 t/t6601-path-walk.sh                | 86 +++++++++++++++++++++++++++++
 3 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 3e26f57b92..bd7c808eef 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,7 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
 supports the `--filter=<spec>` form `blob:none`, `blob:limit=<n>`,
-`tree:0`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index 36a1e5b967..b9902abbb7 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -430,7 +430,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 		CALLOC_ARRAY(tags, 1);
 	if (info->blobs)
 		CALLOC_ARRAY(tagged_blobs, 1);
-	if (info->trees)
+	if (info->trees || info->blobs)
 		root_tree_list = strmap_get(&ctx->paths_to_lists, root_path);
 
 	/*
@@ -475,7 +475,7 @@ static int setup_pending_objects(struct path_walk_info *info,
 
 		switch (obj->type) {
 		case OBJ_TREE:
-			if (!info->trees)
+			if (!info->trees && !info->blobs)
 				continue;
 			if (pending->path) {
 				char *path = *pending->path ? xstrfmt("%s/", pending->path)
@@ -577,6 +577,16 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_OBJECT_TYPE:
+		if (info) {
+			info->commits &= options->object_type == OBJ_COMMIT;
+			info->tags &= options->object_type == OBJ_TAG;
+			info->trees &= options->object_type == OBJ_TREE;
+			info->blobs &= options->object_type == OBJ_BLOB;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
@@ -683,9 +693,16 @@ int walk_objects_by_path(struct path_walk_info *info)
 	/*
 	 * Set these values before preparing the walk to catch
 	 * lightweight tags pointing to non-commits and indexed objects.
+	 *
+	 * Keep tree_objects set whenever blobs are wanted: blobs may
+	 * be reachable through trees that show up as pending objects
+	 * (e.g., via lightweight tags pointing to trees, or annotated
+	 * tags whose peeled target is a tree). Without tree_objects,
+	 * prepare_revision_walk() would discard those pending trees
+	 * and we would never descend into them.
 	 */
 	info->revs->blob_objects = info->blobs;
-	info->revs->tree_objects = info->trees;
+	info->revs->tree_objects = info->trees || info->blobs;
 
 	if (prepare_revision_walk(info->revs))
 		die(_("failed to setup revision walk"));
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 72e09211e6..13016e62ab 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -635,6 +635,92 @@ test_expect_success 'tree:1 filter is rejected' '
 	test_grep "tree:1 filter not supported by the path-walk API" err
 '
 
+test_expect_success 'all, object:type=commit filter' '
+	test-tool path-walk --filter=object:type=commit -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	blobs:0
+	commits:4
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=tag filter' '
+	test-tool path-walk --filter=object:type=tag -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:tag:/tags:$(git rev-parse refs/tags/first)
+	0:tag:/tags:$(git rev-parse refs/tags/second.1)
+	0:tag:/tags:$(git rev-parse refs/tags/second.2)
+	0:tag:/tags:$(git rev-parse refs/tags/third)
+	0:tag:/tags:$(git rev-parse refs/tags/fourth)
+	0:tag:/tags:$(git rev-parse refs/tags/tree-tag)
+	0:tag:/tags:$(git rev-parse refs/tags/blob-tag)
+	blobs:0
+	commits:0
+	tags:7
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=tree filter' '
+	test-tool path-walk --filter=object:type=tree -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:tree::$(git rev-parse topic^{tree})
+	0:tree::$(git rev-parse base^{tree})
+	0:tree::$(git rev-parse base~1^{tree})
+	0:tree::$(git rev-parse base~2^{tree})
+	0:tree::$(git rev-parse refs/tags/tree-tag^{})
+	0:tree::$(git rev-parse refs/tags/tree-tag2^{})
+	1:tree:a/:$(git rev-parse base:a)
+	2:tree:child/:$(git rev-parse refs/tags/tree-tag:child)
+	3:tree:left/:$(git rev-parse base:left)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:tree:right/:$(git rev-parse topic:right)
+	4:tree:right/:$(git rev-parse base~1:right)
+	4:tree:right/:$(git rev-parse base~2:right)
+	blobs:0
+	commits:0
+	tags:0
+	trees:13
+	EOF
+
+	test_cmp_sorted expect out
+'
+
+test_expect_success 'all, object:type=blob filter' '
+	test-tool path-walk --filter=object:type=blob -- --all >out &&
+
+	cat >expect <<-EOF &&
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag^{})
+	0:blob:/tagged-blobs:$(git rev-parse refs/tags/blob-tag2^{})
+	1:blob:a:$(git rev-parse base~2:a)
+	2:blob:file2:$(git rev-parse refs/tags/tree-tag2^{}:file2)
+	3:blob:child/file:$(git rev-parse refs/tags/tree-tag:child/file)
+	4:blob:left/b:$(git rev-parse base:left/b)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	5:blob:right/c:$(git rev-parse base~2:right/c)
+	5:blob:right/c:$(git rev-parse topic:right/c)
+	6:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:10
+	commits:0
+	tags:0
+	trees:0
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'setup sparse filter blob' '
 	# Cone-mode patterns: include root, exclude all dirs, include left/
 	cat >patterns <<-\EOF &&
-- 
gitgitgadget

