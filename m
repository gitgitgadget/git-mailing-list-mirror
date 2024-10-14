Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE9A93D
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728876365; cv=none; b=crSl7HeCjeg6Ap5/Ckrr/iwIfHd7J4mhGjC1l2EdzR3VRetzfADWzrn1h9zsyrJCt4FR6B74ERuZscBXk2RAwQn35r6cbGyUXmj2xbptw5hKdredHpqUbPAF6fe45KmSLw+nMkIcFpjWcdYEpQVfwSOIvjY1x+QpnjkmBgyKxF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728876365; c=relaxed/simple;
	bh=cPEPiA/WBzZiHogfhy0Jw+e1sKsnf2IJk8fToPYMpCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuyzZIIVKCgPE8kNQwAoGXG0bUrcoicQWKNn/CEOWUAXdAvIF3sTci5KwqFANYneP370sVrIMKc/62NMqydDBGcoOxJpBy3qaJEUY8hfST1HEbFGSH3svePN6MPqGQsOA7rzWyujQf4vl+vJOz5SHOr2WrxcYd3O4hXFv5bSEeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=U4a0NmeW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="U4a0NmeW"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2bb1efe78so2554872a91.1
        for <git@vger.kernel.org>; Sun, 13 Oct 2024 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728876362; x=1729481162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uft6wGwVoDRs2b+bEK9bPDOAgaxJ1YdU3y9uGW5mBY8=;
        b=U4a0NmeWYNdHOFGa5cNo3fdkyi0NONlxxM1D75zGTbrYy2tuexbEIBjvUoOlJbLis/
         1hrS0HZvPdnLOBLwJO+jTvaq4fcJR3MuhFyGpA7xr20pkQ1sxFVhgMygxjvIZKtmd/rq
         juw1DEd//p/r32JsbAGZP+0m+SUmsV2+feeNhrtWRPOFIU4rXRBzWRGL57gPGpOhCqF3
         nrUz8JKnlnATvFJ/x1SJ4Z/Jk6NjGb3w2f/aIMesSkGNZSASPFVOClHYKMHgDTV5dVp6
         IvuhFKOD/bxQZvg5k2uNveM2FlOf7eGEXQK0kPNNv6tcsF+j2JXsL/bkBorZAY9WVTyG
         qYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728876362; x=1729481162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uft6wGwVoDRs2b+bEK9bPDOAgaxJ1YdU3y9uGW5mBY8=;
        b=gw1qzQNIMsLPfPWHUCjMTfFhvFOgAt23nm1H3UN+qXdhJAw0OMicqafbFl5eDRJhhD
         RHZJSCUCkeKobp3n4t3jrFSNxBF2+gXpq90qE5RYEM2lZ6JfImHMBMxfN4PyOnRGtcAD
         TRsZVK74b6A8B4tHDq4CLwssfUikaisZhfMNRHWKH+/oqA8Ki1i6uWVw+KpH94JHaL2h
         z/CcUi4a6mCrQ2CSZWCrj3i11KD01QX1DFzh24HM4TY43i8jVYj3PItKglogrRSQlJyw
         1uuiCIvdF39VRNNeJMPaM+ZXfRtZZxLq7YCFNPSTYNaMxVxxBrQul2C+kdpRHl6VEX+0
         bgCA==
X-Gm-Message-State: AOJu0YysDSGBDt4Uz6Y3tMmqJta/sjqkY7FAkVrQcewKKTCFtESSL95R
	5Gdv7caCfZ6f/syM8mRK0AimkVskxHBByFuHFUU6wvUueVcFloQMST5mesxFUUjbQ5lkA4emN/C
	N
X-Google-Smtp-Source: AGHT+IE0UzqDBfGiIOHUCgTsv4gm2TgqG4gwJTk8UrcJfm5NM8VgaD7Y3OWBonSjPlTZus9UZEyynQ==
X-Received: by 2002:a17:90b:4a0b:b0:2e0:7580:6853 with SMTP id 98e67ed59e1d1-2e2f0d9c0e7mr14427482a91.17.1728876362367;
        Sun, 13 Oct 2024 20:26:02 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2ea9d4145sm6256480a91.18.2024.10.13.20.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 20:26:01 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v4 2/3] t0410: adapt tests to repack changes
Date: Mon, 14 Oct 2024 11:25:44 +0800
Message-ID: <20241014032546.68427-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241014032546.68427-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241014032546.68427-1-hanyang.tony@bytedance.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the previous commit, we changed how partial repo is cloned.
Adapt tests to these changes. Also check gc does not delete normal
objects too.

Signed-off-by: Han Young <hanyang.tony@bytedance.com>
---
 t/t0410-partial-clone.sh | 68 +---------------------------------------
 t/t5616-partial-clone.sh |  9 +-----
 2 files changed, 2 insertions(+), 75 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 818700fbec..c87102fcb7 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -500,46 +500,6 @@ test_expect_success 'single promisor remote can be re-initialized gracefully' '
 	git -C repo fetch --filter=blob:none foo
 '
 
-test_expect_success 'gc repacks promisor objects separately from non-promisor objects' '
-	rm -rf repo &&
-	test_create_repo repo &&
-	test_commit -C repo one &&
-	test_commit -C repo two &&
-
-	TREE_ONE=$(git -C repo rev-parse one^{tree}) &&
-	printf "$TREE_ONE\n" | pack_as_from_promisor &&
-	TREE_TWO=$(git -C repo rev-parse two^{tree}) &&
-	printf "$TREE_TWO\n" | pack_as_from_promisor &&
-
-	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo gc &&
-
-	# Ensure that exactly one promisor packfile exists, and that it
-	# contains the trees but not the commits
-	ls repo/.git/objects/pack/pack-*.promisor >promisorlist &&
-	test_line_count = 1 promisorlist &&
-	PROMISOR_PACKFILE=$(sed "s/.promisor/.pack/" <promisorlist) &&
-	git verify-pack $PROMISOR_PACKFILE -v >out &&
-	grep "$TREE_ONE" out &&
-	grep "$TREE_TWO" out &&
-	! grep "$(git -C repo rev-parse one)" out &&
-	! grep "$(git -C repo rev-parse two)" out &&
-
-	# Remove the promisor packfile and associated files
-	rm $(sed "s/.promisor//" <promisorlist).* &&
-
-	# Ensure that the single other pack contains the commits, but not the
-	# trees
-	ls repo/.git/objects/pack/pack-*.pack >packlist &&
-	test_line_count = 1 packlist &&
-	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse one)" out &&
-	grep "$(git -C repo rev-parse two)" out &&
-	! grep "$TREE_ONE" out &&
-	! grep "$TREE_TWO" out
-'
-
 test_expect_success 'gc does not repack promisor objects if there are none' '
 	rm -rf repo &&
 	test_create_repo repo &&
@@ -570,7 +530,7 @@ repack_and_check () {
 	git -C repo2 cat-file -e $3
 }
 
-test_expect_success 'repack -d does not irreversibly delete promisor objects' '
+test_expect_success 'repack -d does not irreversibly delete objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	git -C repo config core.repositoryformatversion 1 &&
@@ -584,40 +544,14 @@ test_expect_success 'repack -d does not irreversibly delete promisor objects' '
 	TWO=$(git -C repo rev-parse HEAD^^) &&
 	THREE=$(git -C repo rev-parse HEAD^) &&
 
-	printf "$TWO\n" | pack_as_from_promisor &&
 	printf "$THREE\n" | pack_as_from_promisor &&
 	delete_object repo "$ONE" &&
 
-	repack_and_check --must-fail -ab "$TWO" "$THREE" &&
 	repack_and_check -a "$TWO" "$THREE" &&
 	repack_and_check -A "$TWO" "$THREE" &&
 	repack_and_check -l "$TWO" "$THREE"
 '
 
-test_expect_success 'gc stops traversal when a missing but promised object is reached' '
-	rm -rf repo &&
-	test_create_repo repo &&
-	test_commit -C repo my_commit &&
-
-	TREE_HASH=$(git -C repo rev-parse HEAD^{tree}) &&
-	HASH=$(promise_and_delete $TREE_HASH) &&
-
-	git -C repo config core.repositoryformatversion 1 &&
-	git -C repo config extensions.partialclone "arbitrary string" &&
-	git -C repo gc &&
-
-	# Ensure that the promisor packfile still exists, and remove it
-	test -e repo/.git/objects/pack/pack-$HASH.pack &&
-	rm repo/.git/objects/pack/pack-$HASH.* &&
-
-	# Ensure that the single other pack contains the commit, but not the tree
-	ls repo/.git/objects/pack/pack-*.pack >packlist &&
-	test_line_count = 1 packlist &&
-	git verify-pack repo/.git/objects/pack/pack-*.pack -v >out &&
-	grep "$(git -C repo rev-parse HEAD)" out &&
-	! grep "$TREE_HASH" out
-'
-
 test_expect_success 'do not fetch when checking existence of tree we construct ourselves' '
 	rm -rf repo &&
 	test_create_repo repo &&
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index c53e93be2f..2c6f10026f 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -643,16 +643,9 @@ test_expect_success 'fetch from a partial clone, protocol v2' '
 	grep "version 2" trace
 '
 
-test_expect_success 'repack does not loosen promisor objects' '
-	rm -rf client trace &&
-	git clone --bare --filter=blob:none "file://$(pwd)/srv.bare" client &&
-	test_when_finished "rm -rf client trace" &&
-	GIT_TRACE2_PERF="$(pwd)/trace" git -C client repack -A -d &&
-	grep "loosen_unused_packed_objects/loosened:0" trace
-'
-
 test_expect_success 'lazy-fetch in submodule succeeds' '
 	# setup
+	rm -rf client &&
 	test_config_global protocol.file.allow always &&
 
 	test_when_finished "rm -rf src-sub" &&
-- 
2.46.0

