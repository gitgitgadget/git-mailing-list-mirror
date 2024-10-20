Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D043E1946A0
	for <git@vger.kernel.org>; Sun, 20 Oct 2024 13:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729431830; cv=none; b=VmgcORFJO5PPVxZmqdo50Kz9P5ef/sHqhKabpo7JGCOS/RjHsk6ZNdJDPyBCFNvrbDifUSEZ9MLic492u90lCudi8js/JrDT6yrNy0l4C5u18JL8rxLGjOclm5ZflyYlCApeTRHf/pJTucLmbU/Urd7DUjo6mAyjdC3i1fS//Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729431830; c=relaxed/simple;
	bh=BosW+xsb4gKfJpYBMEilY71+Vdtz4N4Gaen7sFQefXA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=WD1ZzvmXfJGUzyoJT42VWw96jixAni6F1rChO2bZWbtzvnlxyxwYm3zFXALTt/g9kN8LWHUO7Nx6Xa8vBSVSig9sSLTUVb25j9GIgo4Vz1Iky3BB0nJIJlQ2m+u0lFG7AuTAm3Kztr+58sDGiFJ2HORc0MKhqt7LKkXXHEqnYM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIjL7rMQ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIjL7rMQ"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso4508375a12.3
        for <git@vger.kernel.org>; Sun, 20 Oct 2024 06:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729431826; x=1730036626; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5x4Q5oTxzLsnvqjEzJ1FZ7CP8QEDGXyreDYrCK4IAk=;
        b=JIjL7rMQldKt1RWiuFLcbgxUoFTqanBX9ME+ddZtjFCbT0eKco+PcdHJthXQkYW4IC
         vX/x/Uk7R51fNQxIM3MGHMKuDS6vIxtQOjNCNVBmuPGXi+niGjLkbabPTU3F4YRbusgL
         P8aw05tN2ezUmGGxD4TfVWRP2IpdC9TzBLi/dn02ZSy3b55HUegVgABTfIBDqPMW53NA
         Fataa0tZKqXY7b/7PVOCNRE51kEsUj/6roxjtZpB1w7hxWxwAFnd7amsSWDtncd3nTMP
         VAPV9DrjwXJH6BtepS0kycUINj86Hm/miPfAcOuNgugYo/QkdunpjqMj+C+L/7sebTgo
         G3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729431826; x=1730036626;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5x4Q5oTxzLsnvqjEzJ1FZ7CP8QEDGXyreDYrCK4IAk=;
        b=q4poKvh8wGRz7/yZNGnWGxfVnzUh+MRaCfpcCd8pJ/FSFYcTKU/7IoZs81edgeWmvG
         gje2hsTJp1r/SXEvcnxTpYE2P5KcHGy+6dcKWLd2klkb7p2g0hnhYwZ/hbOZh+FzVxFc
         UCU5DsV3a8RWFXOxJIz5bNs09n04kbvh8L5Q/nqrWGal7HhUXPcrs7E7aaiVdR4SYPQa
         JIfNE/PSgJQziL9iIPKGZYYZoxMpu+1D+19uB3T6TpNSc68NCRs+OxHhRcZRDSyQxAGN
         u9on9g13jIWDUtUAS3iv+mhD7m0Qve9PpB7zzXkOZpbneI9vent7NQGr5Qk9vHSgdIK3
         HgiA==
X-Gm-Message-State: AOJu0Yyc1nw/kd214kzag2VAw42cDsTQzmSvzLE8hZ2MBJhJMQDl9FxV
	+qAWik84UnYGkgab3lQ1y2X6r6kwW/k/OIn27N29ZMtOMrucn/k5hGbwKw==
X-Google-Smtp-Source: AGHT+IGJatgfKAe7ROG529eeayE5ZJKdc9kdkqS3da5LgEMJVxFPXk0oEtC38qr2Ue/rC4lAjSmQ5Q==
X-Received: by 2002:a17:907:7b85:b0:a9a:b70:2a7c with SMTP id a640c23a62f3a-a9a69a7627fmr916073466b.25.1729431825518;
        Sun, 20 Oct 2024 06:43:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a912ee125sm92218866b.75.2024.10.20.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 06:43:45 -0700 (PDT)
Message-Id: <6f96b1c227a98dfd2a1980e6784577b0d97f0ac8.1729431810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
References: <pull.1813.git.1728396723.gitgitgadget@gmail.com>
	<pull.1813.v2.git.1729431810.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 20 Oct 2024 13:43:24 +0000
Subject: [PATCH v2 11/17] pack-objects: introduce GIT_TEST_PACK_PATH_WALK
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

There are many tests that validate whether 'git pack-objects' works as
expected. Instead of duplicating these tests, add a new test environment
variable, GIT_TEST_PACK_PATH_WALK, that implies --path-walk by default
when specified.

This was useful in testing the implementation of the --path-walk
implementation, especially in conjunction with test such as:

 - t0411-clone-from-partial.sh : One test fetches from a repo that does
   not have the boundary objects. This causes the path-based walk to
   fail. Disable the variable for this test.

 - t5306-pack-nobase.sh : Similar to t0411, one test fetches from a repo
   without a boundary object.

 - t5310-pack-bitmaps.sh : One test compares the case when packing with
   bitmaps to the case when packing without them. Since we disable the
   test variable when writing bitmaps, this causes a difference in the
   object list (the --path-walk option adds an extra object). Specify
   --no-path-walk in both processes for the comparison. Another test
   checks for a specific delta base, but when computing dynamically
   without using bitmaps, the base object it too small to be considered
   in the delta calculations so no base is used.

 - t5316-pack-delta-depth.sh : This script cares about certain delta
   choices and their chain lengths. The --path-walk option changes how
   these chains are selected, and thus changes the results of this test.

 - t5322-pack-objects-sparse.sh : This demonstrates the effectiveness of
   the --sparse option and how it combines with --path-walk.

 - t5332-multi-pack-reuse.sh : This test verifies that the preferred
   pack is used for delta reuse when possible. The --path-walk option is
   not currently aware of the preferred pack at all, so finds a
   different delta base.

 - t7406-submodule-update.sh : When using the variable, the --depth
   option collides with the --path-walk feature, resulting in a warning
   message. Disable the variable so this warning does not appear.

I want to call out one specific test change that is only temporary:

 - t5530-upload-pack-error.sh : One test cares specifically about an
   "unable to read" error message. Since the current implementation
   performs delta calculations within the path-walk API callback, a
   different "unable to get size" error message appears. When this
   is changed in a future refactoring, this test change can be reverted.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/pack-objects.c        | 12 ++++++++++--
 ci/run-build-and-tests.sh     |  1 +
 t/README                      |  4 ++++
 t/t0411-clone-from-partial.sh |  6 ++++++
 t/t5306-pack-nobase.sh        |  5 +++++
 t/t5310-pack-bitmaps.sh       | 13 +++++++++++--
 t/t5316-pack-delta-depth.sh   |  9 ++++++---
 t/t5332-multi-pack-reuse.sh   |  7 +++++++
 t/t5530-upload-pack-error.sh  |  6 ++++++
 t/t7406-submodule-update.sh   |  4 ++++
 10 files changed, 60 insertions(+), 7 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 77fb1217b2e..b97bec5661e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -224,7 +224,7 @@ static int delta_search_threads;
 static int pack_to_stdout;
 static int sparse;
 static int thin;
-static int path_walk;
+static int path_walk = -1;
 static int num_preferred_base;
 static struct progress *progress_state;
 
@@ -4182,7 +4182,7 @@ static int add_objects_by_path(const char *path,
 		struct object_id *oid = &oids->oid[i];
 
 		/* Skip objects that do not exist locally. */
-		if (exclude_promisor_objects &&
+		if ((exclude_promisor_objects || arg_missing_action != MA_ERROR) &&
 		    oid_object_info_extended(the_repository, oid, &oi,
 					     OBJECT_INFO_FOR_PREFETCH) < 0)
 			continue;
@@ -4583,6 +4583,14 @@ int cmd_pack_objects(int argc,
 	if (pack_to_stdout != !base_name || argc)
 		usage_with_options(pack_usage, pack_objects_options);
 
+	if (path_walk < 0) {
+		if (use_bitmap_index > 0 ||
+		    !use_internal_rev_list)
+			path_walk = 0;
+		else
+			path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
+	}
+
 	if (depth < 0)
 		depth = 0;
 	if (depth >= (1 << OE_DEPTH_BITS)) {
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 2e28d02b20f..7c75492f366 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -30,6 +30,7 @@ linux-TEST-vars)
 	export GIT_TEST_NO_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
 	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
+	export GIT_TEST_PACK_PATH_WALK=1
 	;;
 linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha1
diff --git a/t/README b/t/README
index 8dcb778e260..bec31955d2d 100644
--- a/t/README
+++ b/t/README
@@ -436,6 +436,10 @@ GIT_TEST_PACK_SPARSE=<boolean> if disabled will default the pack-objects
 builtin to use the non-sparse object walk. This can still be overridden by
 the --sparse command-line argument.
 
+GIT_TEST_PACK_PATH_WALK=<boolean> if enabled will default the pack-objects
+builtin to use the path-walk API for the object walk. This can still be
+overridden by the --no-path-walk command-line argument.
+
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
diff --git a/t/t0411-clone-from-partial.sh b/t/t0411-clone-from-partial.sh
index 932bf2067da..342d8d2997c 100755
--- a/t/t0411-clone-from-partial.sh
+++ b/t/t0411-clone-from-partial.sh
@@ -63,6 +63,12 @@ test_expect_success 'pack-objects should fetch from promisor remote and execute
 
 test_expect_success 'clone from promisor remote does not lazy-fetch by default' '
 	rm -f script-executed &&
+
+	# The --path-walk feature of "git pack-objects" is not
+	# compatible with this kind of fetch from an incomplete repo.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	test_must_fail git clone evil no-lazy 2>err &&
 	test_grep "lazy fetching disabled" err &&
 	test_path_is_missing script-executed
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 0d50c6b4bca..429be5ce724 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -60,6 +60,11 @@ test_expect_success 'indirectly clone patch_clone' '
 	 git pull ../.git &&
 	 test $(git rev-parse HEAD) = $B &&
 
+	# The --path-walk feature of "git pack-objects" is not
+	# compatible with this kind of fetch from an incomplete repo.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	 git pull ../patch_clone/.git &&
 	 test $(git rev-parse HEAD) = $C
 	)
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index a6de7c57643..881b3f9c8d1 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -128,8 +128,9 @@ test_bitmap_cases () {
 		ls .git/objects/pack/ | grep bitmap >output &&
 		test_line_count = 1 output &&
 		# verify equivalent packs are generated with/without using bitmap index
-		packasha1=$(git pack-objects --no-use-bitmap-index --all packa </dev/null) &&
-		packbsha1=$(git pack-objects --use-bitmap-index --all packb </dev/null) &&
+		# Be careful to not use the path-walk option in either case.
+		packasha1=$(git pack-objects --no-use-bitmap-index --no-path-walk --all packa </dev/null) &&
+		packbsha1=$(git pack-objects --use-bitmap-index --no-path-walk --all packb </dev/null) &&
 		list_packed_objects packa-$packasha1.idx >packa.objects &&
 		list_packed_objects packb-$packbsha1.idx >packb.objects &&
 		test_cmp packa.objects packb.objects
@@ -358,6 +359,14 @@ test_bitmap_cases () {
 		git init --bare client.git &&
 		(
 			cd client.git &&
+
+			# This test relies on reusing a delta, but if the
+			# path-walk machinery is engaged, the base object
+			# is considered too small to use during the
+			# dynamic computation, so is not used.
+			GIT_TEST_PACK_PATH_WALK=0 &&
+			export GIT_TEST_PACK_PATH_WALK &&
+
 			git config transfer.unpackLimit 1 &&
 			git fetch .. delta-reuse-old:delta-reuse-old &&
 			git fetch .. delta-reuse-new:delta-reuse-new &&
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index eb4ef3dda4d..12a6901fecb 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -90,15 +90,18 @@ max_chain() {
 # adjusted (or scrapped if the heuristics have become too unreliable)
 test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
-	# not computing a new long chain.
-	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
+	# not computing a new long chain. (Also avoid the --path-walk
+	# option as it may break delta chains.)
+	pack=$(git pack-objects --all --window=0 --no-path-walk </dev/null pack) &&
 	echo 9 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success '--depth limits depth' '
-	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
+	# Avoid --path-walk to avoid breaking delta chains across path
+	# boundaries.
+	pack=$(git pack-objects --all --depth=5 --no-path-walk </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769b..df7dcb4b487 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -8,6 +8,13 @@ TEST_PASSES_SANITIZE_LEAK=true
 
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
+# The --path-walk option does not consider the preferred pack
+# at all for reusing deltas, so this variable changes the
+# behavior of this test, if enabled.
+GIT_TEST_PACK_PATH_WALK=0
+export GIT_TEST_PACK_PATH_WALK
+
 objdir=.git/objects
 packdir=$objdir/pack
 
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 7172780d550..356b96cb741 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -35,6 +35,12 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
 	hexsz=$(test_oid hexsz) &&
 	printf "%04xwant %s\n00000009done\n0000" \
 		$(($hexsz + 10)) $head >input &&
+
+	# The current implementation of path-walk causes a different
+	# error message. This will be changed by a future refactoring.
+	GIT_TEST_PACK_PATH_WALK=0 &&
+	export GIT_TEST_PACK_PATH_WALK &&
+
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
 	test_grep "unable to read" output.err &&
 	test_grep "pack-objects died" output.err
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 297c6c3b5cc..d2284e67d3d 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1093,12 +1093,16 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	) &&
 	git clone super4 super5 &&
 	(cd super5 &&
+	 # This test variable will create a "warning" message to stderr
+	 GIT_TEST_PACK_PATH_WALK=0 \
 	 git submodule update --quiet --init --depth=1 submodule3 >out 2>err &&
 	 test_must_be_empty out &&
 	 test_must_be_empty err
 	) &&
 	git clone super4 super6 &&
 	(cd super6 &&
+	 # This test variable will create a "warning" message to stderr
+	 GIT_TEST_PACK_PATH_WALK=0 \
 	 git submodule update --init --depth=1 submodule3 >out 2>err &&
 	 test_file_not_empty out &&
 	 test_file_not_empty err
-- 
gitgitgadget

