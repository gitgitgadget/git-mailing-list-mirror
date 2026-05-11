Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FF47CC8A
	for <git@vger.kernel.org>; Mon, 11 May 2026 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523210; cv=none; b=hkv+pz2Adhrpr89WX1cepvvMHQsIndIfJ41ze8PJCVCUu7yT6+Cf0fM/7YWs80kT9tw4wgqz3P57V1vm9otUEuxgqyxCItCb1WMvacO3IJtg5Y4/xdKVFNYWeJmy6OBX/zahUCxd/LcznKcWwAuRwTdndBiakJteSqe11fx/wX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523210; c=relaxed/simple;
	bh=RQJqbuQggwxhCcXLdjHUxZLdHWP3k/vaADcKTgNm7BM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=W/VtSpNHfo5euGE6stj2yO5MPDMbM1oCc2PPaKBIOJOTjJ7djTP+qdqkFv044SJXzDIvn55ZjkHH1aErsIZfddAwQyeMp81qRM92yDEJYbRn8f5JcieM0mQUEFsIV9Y5LYdKSlTqgTMfIbTWiw/O2FbrwLKYPuAxp1lI5fJsjEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jsrd8lCz; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jsrd8lCz"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bd87e5d8ffso60644957b3.1
        for <git@vger.kernel.org>; Mon, 11 May 2026 11:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523207; x=1779128007; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfI16zT9ZYZYwVIYnA1GHu/6z09N08+Z610slWvEOL8=;
        b=Jsrd8lCzwJOWeNTPMYIzUTkHBlyAgyiZopcDOZ6HB1YvmZvs4N4mSfa7oOlpq2FLMO
         mVqF1pFGflAx9A3FE4zpKjCOYMaoI8og+l6ge75RqQxv5CNnhBhmtxrz5BTbEs4ugPs7
         5akwyMXZMDDzB1l+H722aRJW/96VqnqYw7xIKlcrYD2uiad2y5YDgb2+ZoighLtCqcpF
         q3T0pEp/KJYs44TDJMPh0rj59rcq99FJ5dxJz2ZK3KhQ5rF4hRrrF57h8B7yUNIlz3+y
         JEURWS/ioGrg1eI4jIgbu0vcyAkf43hv7HlRvJidth+eFTUa6+kLaL9MoyG3IoQn7ZeM
         Xs7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523207; x=1779128007;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rfI16zT9ZYZYwVIYnA1GHu/6z09N08+Z610slWvEOL8=;
        b=DRlbdrlnNiiUzW8IvDtEW4jYMiA6iJ+zhAIjEr7GBuLM83zAutH3fIheli9XevL3dj
         JOtqVcH1sGo+5jtjO6V5ZTmge5XxVbv5KdI/+MeHi1XZvPdsjYNc39ArnWOh25YKI54+
         D97UOs0rnNgtUyXV731EjZzPOw2lB1Gsaj3VtIHQS+d7OSnIy+QaokJa9/GI0bo0fZy6
         lD8O0hX1+6MYB9jvIskms+zuc/hL/1reo8hLSSIvdugtd5Yek1PlPMZjx0ajWf1SqYai
         hnIdUdSfNmit+rQ09oCKs/4gnHQeb7jdYHfAK8e1bynZ7pUYuGMWhDFskyf4WEScJeYJ
         +WQA==
X-Gm-Message-State: AOJu0YztBKCAAkJLQP4CW2PdVx2xWq/n5ufzYJzIM5GCFiX1GcQU2k9I
	0S6JQSxWrHHez3cjAc+S1uKgX+36w2rAStAAhBqOwGBs+JPIrKY220XiQKQLtg==
X-Gm-Gg: Acq92OFZovpPHZBAVYhye1qaq8tIx53wGohdmJ8JFppp/SpOtF5J26YOaUjODR1Bg1u
	jKifVefupR5eGI9rrHEQHIBmU28vrtykxTL1ph7ZQnrLgoXhzHFqdQpACPrxwjBSP7cNcj0B0p9
	OJK6VNzExIWiWvq/rDt661AJtFRNgoRpDCcEfaNIRUpkWt/nSshM+wXf4XjlcZvJ9vbWHmoJ0E9
	v3MH5hxnJn1dhhil2poSZ9dL9KGVNrEt236QQDcyJM/w0hcPwLVo8Eek0NXqCnfGMM2JYnUNohl
	UW4q68EHvunhOAn7hdmWJvyF0TdVDxoRhkwjJrNk3eERQLUTQHwm4o8D+VC5OOGZp4z2h9BNvRB
	+NNaT69yz5BwmkZmZBn4PkHdaGddqCwpITe6IOv4qNjDIIbQMQDdAA1KmWxwFg+yY/jRIFsjaKg
	VTrnFTD3dFdcJlBlOhOT1W2yc8GA==
X-Received: by 2002:a05:690c:c50a:b0:7bd:a333:d9a5 with SMTP id 00721157ae682-7c5101a01e4mr5728207b3.21.1778523206668;
        Mon, 11 May 2026 11:13:26 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.78.164])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bda8203a25sm100027637b3.4.2026.05.11.11.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:13:25 -0700 (PDT)
Message-Id: <b221ea47125c1e095167acbc066fbb7baffca55a.1778523189.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
References: <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
	<pull.2101.v3.git.1778523189.gitgitgadget@gmail.com>
From: "Taylor Blau via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 May 2026 18:13:08 +0000
Subject: [PATCH v3 11/12] path-walk: support `object:type` filter
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
 path-walk.c                         | 13 ++++-
 path-walk.h                         |  6 +++
 t/t6601-path-walk.sh                | 84 +++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 4ebda0fa9e..e96d2c00b3 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -405,7 +405,7 @@ will be automatically changed to version `1`.
 Incompatible with `--delta-islands`. The `--use-bitmap-index` option is
 ignored in the presence of `--path-walk`. Whe `--path-walk` option
 supports the `--filter=<spec>` forms `blob:none`, `blob:limit=<n>`,
-`tree:0`, and `sparse:<oid>`.
+`tree:0`, `object:type=<type>`, and `sparse:<oid>`.
 
 
 DELTA ISLANDS
diff --git a/path-walk.c b/path-walk.c
index f6f95da550..839505839b 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -381,7 +381,7 @@ static int walk_path(struct path_walk_context *ctx,
 			ret = ctx->info->path_fn(path, &filtered, list->type,
 						 ctx->info->path_fn_data);
 		oid_array_clear(&filtered);
-	} else if (path_is_for_direct_objects(path) ||
+	} else if ((!ctx->info->strict_types && path_is_for_direct_objects(path)) ||
 		   (list->type == OBJ_TREE && ctx->info->trees) ||
 		   (list->type == OBJ_BLOB && ctx->info->blobs) ||
 		   (list->type == OBJ_TAG && ctx->info->tags)) {
@@ -610,6 +610,17 @@ static int prepare_filters(struct path_walk_info *info,
 		}
 		return 1;
 
+	case LOFC_OBJECT_TYPE:
+		if (info) {
+			info->commits &= options->object_type == OBJ_COMMIT;
+			info->tags &= options->object_type == OBJ_TAG;
+			info->trees &= options->object_type == OBJ_TREE;
+			info->blobs &= options->object_type == OBJ_BLOB;
+			info->strict_types = 1;
+			list_objects_filter_release(options);
+		}
+		return 1;
+
 	case LOFC_SPARSE_OID:
 		if (info) {
 			struct object_id sparse_oid;
diff --git a/path-walk.h b/path-walk.h
index 7e57ae5f65..a2652b2d46 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -47,6 +47,12 @@ struct path_walk_info {
 	int blobs;
 	int tags;
 
+	/**
+	 * If 'strict_types' is 0, then direct object requests will no longer
+	 * override the object type restrictions.
+	 */
+	int strict_types;
+
 	/**
 	 * If non-zero, specifies a maximum blob size. Blobs with a
 	 * size equal to or greater than this limit will not be
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index deaeab9a3e..0515aaddbf 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -645,6 +645,90 @@ test_expect_success 'tree:1 filter is rejected' '
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
+	2:blob:left/b:$(git rev-parse base:left/b)
+	2:blob:left/b:$(git rev-parse base~2:left/b)
+	3:blob:right/c:$(git rev-parse base~2:right/c)
+	3:blob:right/c:$(git rev-parse topic:right/c)
+	4:blob:right/d:$(git rev-parse base~1:right/d)
+	blobs:8
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

