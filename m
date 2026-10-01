Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DE418A4E
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 04:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827905; cv=none; b=CSujEVybGTMazRAtPV5sf+Obv3a5YHg00Km8O70/i660FZoN3rS3j6Aa2bXI6tmu3hOxtP9JZfBiHE+LPTQu/X0GIRTFXO7/0HYd+UrxF+k2w6PD1QbA8/3xZ67y3IsiJfhGXZBB/GdhB9PuYgKX23kRUWGhJbpD6xdhhjOa9h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827905; c=relaxed/simple;
	bh=UlnjH0+Or16IjXWPZgT2Aup2Mx5kQt9rIqyAlAHzSc4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6ygdA8efD+MxSn7HzioYYdxORlJdUB4PMCXjSU/qGF/4xH7wnJQSAG+IvRDyjvSNClpmaeGckiKnPJZyZjbIspyGUV4YOoU8vL/yMWw3obsy5rJi2jd0oytH90KSbHelOwMeomliu6HQDtCV26wuew5Supmgl2sxGJ6QlEkxtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=DQr0atY2; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="DQr0atY2"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-47b8afe046dso3241628fac.2
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1790827903; x=1791432703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DVlcJ953gkr5Xll3kh5GNyQhfEjtUJSNdi9hV2apHe4=;
        b=DQr0atY2qfunYKHMl5cLQlvb05Bja3iBAfUihPDXwUb1a1BjaV0DyjYSw1/4GTFmzA
         oEkqQqlPOItlm8zEn5C7OKfAkedItqeigjgKLNZGu5GYBtjm1VsFamDqbOXMbesa5lX8
         X0cwctM0h8PbCgCKTtzSyC8fYk8A1LyXnacgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790827903; x=1791432703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVlcJ953gkr5Xll3kh5GNyQhfEjtUJSNdi9hV2apHe4=;
        b=FD6bc44GwKSvXEvxugeqF1GyqeP8pE4li89s1USrFy/9UXPlPi+GSO5ieCU2CxMGew
         rDqyMAlyzdId1v6yVo34lDIISOpwIcJPpwjCjIgUU5DE7fXAkDWouThftwrRuvJHzNuV
         XwuXze1vLqaL2bZUqeLu9D7skHeGCv2kI1owor7RdSpo2zw6gkCYPOaYh6B9AGqUOePo
         b5Wm71WkpPCe9rB3po/Ol6PKi+KjWUNkXTbD/3H1A03T/29S96xLUASIwWE7O6sWoyCj
         48WEGpTZXhrT1gKMMp7Tq2KQvsZWP+oLzI9q/H1zLIRhst//FAoYCZxoSeV2AgFHXDI0
         CBVA==
X-Gm-Message-State: AFuF++n7Y7olSvZzXUcgRqgU47cxcMeOzksl/Loo31+qct6J+C0bQUyi
	Opuvx7yTAEZ6r9IunMLoDcHv+1tyoXgXYTTH58CCBANRefvFu2wZXC7EdW7yxDF6GQX2Sy4hewp
	ihlNBsXU=
X-Gm-Gg: AYBFou0tzN2fa42SC1s1UAIvoB/4/IDfQiXPNvYiux4tRajj4uvUGzzEEBEGmofaVIx
	VYC55f7WH8oERQ6+Mq4fdOQB3hxtafhbhOTbyRWwM2pARr9aj3SZ1MHOYeThkB4x6zKzuxSPwJI
	Tm3lFMsC8u9vJikPmh8gJC8IdbXBx4WQ8U+4sh64PzgblLPzU6ZRa22JWyidU2QCu3M/6NtXP13
	Dvl/DdjC/UGCDmV9yFDQUWC2MACHANQvvJfpRU4TLrfI0LnAqF9Ip68peTsDbPDw9EAKhGGTfJG
	nRMDAg7GIYh+Oz7TrYbEGr9/Id2NBXIFH4a39mOhlK/s/fhK7elMqfJydqkThFXV053WYNShXxX
	ed+s83gblq1Bt2qgGu+mJ6uUNrDqgtjTPau4kARknIlxj3/SJprM2Ob0G4YBOrR7cCiOV2emD76
	XD+J6CyKI3tptOCR1fq4eIXiGgtL3NoxHqbPVO2QYl6jJPJ9JldmYT3A0HaBcFGH3GzTib4x967
	jUtLo4MXtaOzqgI24GbwJEo9xwEj9rQlgKyG3kUZVCSu7XbirW6gMIJuvyKq1+tacBdGpqrBm6G
	axXxumtK
X-Received: by 2002:a05:6870:be8c:b0:483:8eb8:71be with SMTP id 586e51a60fabf-49ddd533d4bmr3716152fac.32.1790827902835;
        Wed, 30 Sep 2026 21:11:42 -0700 (PDT)
Received: from com-79390 (vpn-centralus-02.tradc-corp.com. [20.98.136.114])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded1b53c0sm1923381fac.8.2026.09.30.21.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 21:11:42 -0700 (PDT)
From: Taylor Blau <ttaylorr@openai.com>
X-Google-Original-From: Taylor Blau <me@ttaylorr.com>
Date: Wed, 30 Sep 2026 23:11:39 -0500
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: [PATCH v2 2/8] pack-objects: ensure tree/tag closure with
 '--stdin-packs=follow'
Message-ID: <940953e5c407046ac6789367f3341dc8ea73d07a.1790827875.git.me@ttaylorr.com>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1790827875.git.me@ttaylorr.com>

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

A subsequent repack with '!' packs can stop at that tree in a retained
'^' pack even if a new commit reaches it. If the cruft pack remains
excluded, and the bitmap selection picks one or more commits which reach
that tree, the MIDX cannot generate a bitmap for that commit.

Add trees and tags from included and '!' packs (and loose ones with
'--unpacked') as roots in '--stdin-packs=follow' mode. This rescues
their descendants even when no input commit reaches them. Walk these
roots after the existing traversal, preserving the `SEEN` bit to avoid
redundant traversals. This gives directly enumerated commits priority
for the path prefixes used by name hashes and delta attributes. Tags can
introduce commits in the second walk, so path selection remains
best-effort.

Collect the extra roots in an oidset to avoid queuing duplicates. This
uses memory for each distinct root and walks its unvisited descendants.

Objects in '^' packs remain cutoffs to avoid rewalking packs that are
known to be closed under reachability, provided '!' packs are present.
This does not repair existing MIDXs lacking closure; those need a full
repack.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 Documentation/git-pack-objects.adoc |  2 +
 builtin/pack-objects.c              | 43 ++++++++++++++-
 t/t5331-pack-objects-stdin.sh       | 81 +++++++++++++++++++++++++++++
 t/t7704-repack-cruft.sh             | 20 +++++++
 4 files changed, 145 insertions(+), 1 deletion(-)

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
index a553064fcce..fb603059a92 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3807,6 +3807,7 @@ static int stdin_packs_hints_nr;
 struct stdin_packs_context {
 	struct rev_info *revs; /* must be non-NULL */
 	enum stdin_packs_mode mode;
+	struct oidset extra_roots;
 };
 
 static int add_object_entry_from_pack(const struct object_id *oid,
@@ -3846,6 +3847,9 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		 * list after checking `want_object_in_pack()` below.
 		 */
 		add_pending_oid(ctx->revs, NULL, oid, 0);
+	} else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
+		   (type == OBJ_TREE || type == OBJ_TAG)) {
+		oidset_insert(&ctx->extra_roots, oid);
 	}
 
 	if (!want_object_in_pack(oid, 0, &p, &ofs))
@@ -4103,7 +4107,10 @@ static void read_stdin_packs(struct repository *repo,
 	struct stdin_packs_context ctx = {
 		.revs = &revs,
 		.mode = mode,
+		.extra_roots = OIDSET_INIT,
 	};
+	struct oidset_iter iter;
+	const struct object_id *oid;
 
 	/*
 	 * The revision walk may hit objects that are promised, only. As the
@@ -4151,6 +4158,34 @@ static void read_stdin_packs(struct repository *repo,
 			     show_object_pack_hint,
 			     &mode);
 
+	/*
+	 * Trees and tags need closure even when no commit reaches them.
+	 * Defer adding these roots to revs.pending until the first walk
+	 * finishes. Otherwise a subtree may be visited and marked SEEN
+	 * before its commit's root tree, using "a" instead of "sub/a"
+	 * for a blob's namehash and delta attributes.
+	 *
+	 * Tags may introduce more commits in the second walk, so this
+	 * does not *always* guarantee that trees are always visited
+	 * with their full paths.
+	 */
+	oidset_iter_init(&ctx.extra_roots, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
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
+	oidset_clear(&ctx.extra_roots);
+
 	release_revisions(&revs);
 
 	trace2_data_intmax("pack-objects", the_repository, "stdin_packs_found",
@@ -4572,8 +4607,14 @@ static int add_loose_object(const struct object_id *oid, const char *path,
 		add_object_entry(oid, type, "", 0);
 	}
 
-	if (ctx && type == OBJ_COMMIT)
+	if (!ctx)
+		return 0;
+
+	if (type == OBJ_COMMIT)
 		add_pending_oid(ctx->revs, NULL, oid, 0);
+	else if (ctx->mode == STDIN_PACKS_MODE_FOLLOW &&
+		 (type == OBJ_TREE || type == OBJ_TAG))
+		oidset_insert(&ctx->extra_roots, oid);
 
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
2.56.0.8.ga42f775cbe2

