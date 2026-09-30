Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82814312831
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731736; cv=none; b=eB9dmhUOCixWw5mUF/n4z898t76jdpNqHTQ2Ij+pchwIsHbgExSJXoiM5SVMwzzHrDMoX0m3Ej9s/hAzp/rSNtSClXePiMYhVswLdz+kbIYWY5ZsdYZr7lVMQSoqHAIe43k+TgAf2+DZPMie5eJvy1as3+AtGWLOD4waZrRD7Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731736; c=relaxed/simple;
	bh=j4MudGv8l3HyBYaEF9EbLwzyrbjDhFZ8rY6o3xbk7jU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO48OtO9vLlfZAutnAicccNI7BC8HbD7XOg9cZOu1A/Qvd1Y/+zcb3NWsJnY8hd+pRvAASbp7YDL+sXnGPffj+VeDY5gQR7nfD8YJ2HCjgfhzScWXe5X3F/oJgK+Cu4ASLmo+kjyE1P/BpkHIGyoMnPpD/GyDDizz42tDkvsM4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=AV3wGDOm; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="AV3wGDOm"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8144632e066so2621536a34.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790731733; x=1791336533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bi8Vyjj64PKtK3wM+icSdLgIKb/mZqei5MiBOLa0lvk=;
        b=AV3wGDOmQ5U6/2/jK4IgLttex3HyG+Y3uE+BCbK1I8FwQOrxPTPFBuNtNeWyggiJ4D
         drD+NXDZ/0yiZ8z38bwNF91YlUbLPxSJ/wMr//buXzxbkDgH9yk+NhLDIk6ZI3SFYkXE
         7lxB+NqRjqi/n5hRUFEb/mq0sIH3yi6DPXA/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790731733; x=1791336533;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bi8Vyjj64PKtK3wM+icSdLgIKb/mZqei5MiBOLa0lvk=;
        b=nH7ThxB7AhMo7e0Dx4oprvujnZMgvmZcaHspiJ2p0aQoLxMxn2EW5Ld9Vd5nFwGIg2
         u0R8mdQVyzK6Y++LS4guF3edohzL8AVyPstzAiJPkzEjpVvLGJat6nAPMMsBIEgMLzM0
         LCXnMZVsI6e8+4Kn0nwYSguJRnAEmQG29R8YIMxDlLkqOq/OtW15JM8uaV1WfqMtKwl9
         5/adgFn/mYgsbRclQ85Aew3MBVk+ZmtINv8IGXKsJjGaEyhOhIkRWNHhyKSh22MgAO50
         4eMxRimGA92vAc04NexTvX/6V1iYyl6fl+WoeYJ2funl1pJX2QWSgalG6Kvd2Zst7Fs7
         DRdw==
X-Gm-Message-State: AFuF++mImogOWra6OXEcVZohmble8llvXxMKZwdWl22OjyZsLJZPiF1V
	0Z3H5ftYBSOdej8Gzj3sWYuuEWEQM6zvlahc5Rnr0B5UMRdItlI6Ua/nMpWk2cQVTlz/n4mtyhg
	8X4klF94=
X-Gm-Gg: AYBFou3YOQBGDS/lG5U1XARZB0YIHS3iOKOo4IVbI89ClmC4NO4SXYvNdHrDPxoUGrx
	8nNq7dX1AGsti9cC0JdBWHbaCJiNPl+26dY/N+MwkbB//f1kSve/OIUyTcOKqWdJnab39ewmAt8
	XfJaZ8JfhpmOk0+LPtyG9WZtyIFSY9KKk3Nfx8Sh8RNntg2u+R4fGZECt6RVfmQJtiJx9BwbLNs
	ufKvQzIwPrBxcQ2+BNPK/abgPXzpEP3M4d7qm6RCobdXOz75U+20SFKVoPOtAqupR/AttZFAMDW
	ScnqP76Kz3xjeg30TZa/NdtKagRc3PsNwDrbgzXYj9hr2ZaelBpoeznwu8knuY2ulNyZh9lYoe3
	kqaoDXf+uYChXl+xPqOoYzQba07IjzmmslGQLA/mD0U60EgwqICQXaNSaHXFW9osPBohsmUMWHq
	bkU8ArriIumNFZFKMvZAOVJla9JHYgzY5KrhReYltaZQWkTgefHE9LYEAmw/e9/Vf9x+cfNg+vj
	KMlLLckLKbySe5jdlP0/WHHaOKe+jCSXLaMw8o6ZhmOWC29y+SC2k/iTNPWUedRsD2G+Ha/pGqb
	HRx+eet1
X-Received: by 2002:a05:6820:60f:b0:6cd:3ffc:e328 with SMTP id 006d021491bc7-6dc78f3ed38mr955389eaf.70.1790731732947;
        Tue, 29 Sep 2026 18:28:52 -0700 (PDT)
Received: from com-79390 (vpn-centralus-01.tradc-corp.com. [172.169.249.3])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49dd14986fasm1048186fac.17.2026.09.29.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 18:28:52 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Tue, 29 Sep 2026 20:28:49 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH 2/4] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <6348667e2e3fe63aeb139888e877dd8447570253.1790731662.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790731662.git.me@ttaylorr.com>

Since 5ee86c273bf (repack: exclude cruft pack(s) from the MIDX where
possible, 2025-06-23), when the 'repack.midxMustContainCruft'
configuration is set to "false", geometric repacks use
'--stdin-packs=follow' to copy needed objects out of cruft packs so the
MIDX can omit those packs.

In cd846bacc7d (pack-objects: introduce '--stdin-packs=follow',
2025-06-23), this behavior changed such that whenever excluded-open
('!') packs are present, the walk stops at objects in excluded-closed
('^') packs. Geometric repacks use '^' for retained packs already in the
MIDX, relying on the indexed object set being closed under reachability.

However, the walk introduced in cd846bacc7d starts only from commit
objects. A geometric repack can therefore produce a MIDX that does not
maintain reachability closure for lone trees (that are not reachable
from any commit otherwise in the closure).

A later walk with '!' packs can stop at that tree in a retained '^'
pack even if a new commit reaches it. If the cruft pack remains
excluded, and the bitmap selection picks one or more commits which reach
that tree, the MIDX cannot generate a bitmap for that commit.

Add trees and tags from included and '!' packs (and loose ones with
'--unpacked') as roots in '--stdin-packs=follow' mode. This rescues
their descendants even when no input commit reaches them. Walk these
roots after the existing traversal, preserving the `SEEN` bit to avoid
redundant traversals. Ensure that the walk takes place *after* the
existing traversal so that we don't lose the path prefix used for trees
and blobs wherever possible.

Objects in '^' packs remain cutoffs to avoid rewalking packs that are
known to be closed under reachability.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 Documentation/git-pack-objects.adoc |  2 +
 builtin/pack-objects.c              | 32 ++++++++++++
 t/t5331-pack-objects-stdin.sh       | 81 +++++++++++++++++++++++++++++
 t/t7704-repack-cruft.sh             | 20 +++++++
 4 files changed, 135 insertions(+)

diff --git a/Documentation/git-pack-objects.adoc b/Documentation/git-pack-objects.adoc
index 65cd00c152f..1564d44f49d 100644
--- a/Documentation/git-pack-objects.adoc
+++ b/Documentation/git-pack-objects.adoc
@@ -112,6 +112,8 @@ pack may include additional objects based on the following:
 This mode is useful, for example, to resurrect once-unreachable
 objects found in cruft packs to generate packs which are closed under
 reachability up to the boundary set by the excluded packs.
+Trees and tags in included or `!` packs are followed even when no
+commit reaches them, as are loose trees and tags with `--unpacked`.
 +
 Incompatible with `--revs`, or options that imply `--revs` (such as
 `--all`), with the exception of `--unpacked`, which is compatible.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 01adf80a2bc..05a94305265 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3807,6 +3807,7 @@ static int stdin_packs_hints_nr;
 struct stdin_packs_context {
 	struct rev_info *revs;
 	enum stdin_packs_mode mode;
+	struct oid_array extra_roots;
 };
 
 static int add_object_entry_from_pack(const struct object_id *oid,
@@ -3846,6 +3847,9 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		 * list after checking `want_object_in_pack()` below.
 		 */
 		add_pending_oid(ctx->revs, NULL, oid, 0);
+	} else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
+		   (type == OBJ_TREE || type == OBJ_TAG)) {
+		oid_array_append(&ctx->extra_roots, oid);
 	}
 
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
@@ -4103,6 +4107,7 @@ static void read_stdin_packs(struct repository *repo,
 	struct stdin_packs_context ctx = {
 		.revs = &revs,
 		.mode = mode,
+		.extra_roots = OID_ARRAY_INIT,
 	};
 
 	/*
@@ -4151,6 +4156,30 @@ static void read_stdin_packs(struct repository *repo,
 			     show_object_pack_hint,
 			     &mode);
 
+	/*
+	 * Trees and tags need closure even when no commit reaches them.
+	 * Defer adding these roots to revs.pending until the commit walk
+	 * finishes. Otherwise a subtree may be visited and marked SEEN
+	 * before its commit's root tree, using "a" instead of "sub/a" for
+	 * a blob's namehash and delta attributes.
+	 */
+	for (size_t i = 0; i < ctx.extra_roots.nr; i++) {
+		const struct object_id *oid = &ctx.extra_roots.oid[i];
+		struct object *obj = lookup_object(repo, oid);
+
+		if (!obj || !(obj->flags & SEEN))
+			add_pending_oid(&revs, NULL, oid, 0);
+	}
+	if (revs.pending.nr) {
+		if (prepare_revision_walk(&revs))
+			die(_("revision walk setup failed"));
+		traverse_commit_list(&revs,
+				     show_commit_pack_hint,
+				     show_object_pack_hint,
+				     &mode);
+	}
+	oid_array_clear(&ctx.extra_roots);
+
 	release_revisions(&revs);
 
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
@@ -4574,6 +4603,9 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 
 	if (ctx && type == OBJ_COMMIT)
 		add_pending_oid(ctx->revs, NULL, oid, 0);
+	else if (ctx && ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
+		 (type == OBJ_TREE || type == OBJ_TAG))
+		oid_array_append(&ctx->extra_roots, oid);
 
 	return 0;
 }
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index c74b5861af3..aa79ecdf13c 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -520,4 +520,85 @@ test_expect_success '--stdin-packs with !-delimited pack without follow' '
 	)
 '
 
+test_expect_success '--stdin-packs=follow traverses a tree-only input pack' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		tree=$(git rev-parse HEAD^{tree}) &&
+		P=$(echo "$tree" | git pack-objects $packdir/pack) &&
+		echo "pack-$P.pack" >in &&
+
+		# Only --stdin-packs=follow should start a walk from the tree.
+		: >trace.txt &&
+		GIT_TRACE2_EVENT="$(pwd)/trace.txt" git pack-objects \
+			--stdin-packs --stdout <in >/dev/null &&
+
+		test_trace2_data pack-objects stdin_packs_hints 0 <trace.txt &&
+
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <in) &&
+		git rev-parse "$tree" "$tree:base.t" >expect.raw &&
+		sort expect.raw >expect &&
+		objects_in_packs $P >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs=follow traverses an excluded-open tag' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit --annotate base &&
+
+		# Put the commit, tree, and blob in one pack, and the tag in another.
+		# Give only the second pack as input with a "!" prefix. The result
+		# must contain the commit, tree, and blob, but not the tag.
+		P=$(echo HEAD | git pack-objects --revs $packdir/pack) &&
+		objects_in_packs $P >expect &&
+
+		git rev-parse base >in &&
+		P=$(git pack-objects $packdir/pack <in) &&
+		git prune-packed &&
+
+		echo "!pack-$P.pack" >in &&
+		P=$(git pack-objects --stdin-packs=follow $packdir/pack <in) &&
+		objects_in_packs $P >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '--stdin-packs=follow respects delta attributes for subtree contents' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		echo "sub/* -delta" >.gitattributes &&
+		mkdir sub &&
+		test-tool genrandom seed 8192 >sub/a &&
+		cp sub/a sub/b &&
+		echo modified >>sub/b &&
+		git add sub &&
+		git commit -m base &&
+
+		# If the subtree is visited first, the blobs are found as a and
+		# b, so the sub/* attribute does not apply.
+		git rev-parse HEAD HEAD:sub >in &&
+		P=$(git pack-objects $packdir/pack <in) &&
+		echo "pack-$P.pack" >in &&
+
+		git pack-objects --stdin-packs=follow $packdir/pack <in &&
+		git prune-packed &&
+
+		printf "%s\n" HEAD:sub/a HEAD:sub/b |
+			git cat-file --batch-check="%(deltabase)" >actual &&
+		printf "%s\n" "$ZERO_OID" "$ZERO_OID" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index b342e82447d..b49f22878f7 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -767,6 +767,26 @@ test_expect_success 'repack --write-midx excludes cruft where possible' '
 	)
 '
 
+test_expect_success 'geometric repack rescues descendants of loose trees' '
+	git init loose-tree-cruft &&
+	(
+		cd loose-tree-cruft &&
+		git config repack.midxMustContainCruft false &&
+		test_commit base &&
+		blob=$(echo cruft | git hash-object -w --stdin) &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack --cruft -d &&
+
+		printf "100644 blob %s\tfile\n" "$blob" | git mktree &&
+		GIT_TEST_MULTI_PACK_INDEX=0 git repack -d --geometric=2 \
+			--write-midx --write-bitmap-index &&
+
+		test-tool read-midx --show-objects $objdir >midx &&
+		cruft=$(ls $packdir/*.mtimes) &&
+		test_grep ! "$(basename "$cruft" .mtimes).idx" midx &&
+		test_grep "^$blob " midx
+	)
+'
+
 test_expect_success 'repack --write-midx includes cruft when instructed' '
 	setup_cruft_exclude_tests exclude-cruft-when-instructed &&
 	(
-- 
2.56.0.4.gbee41d2fc68

