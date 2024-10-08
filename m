Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6E1DC046
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 08:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728375250; cv=none; b=sSiWyLNFK3l1xVHoiv9zQQc94XhqEzAAVJzd9J3eUJ8CfFPncSetvVGXVaniCFI8rjkcoyp13GgjoH0Xwv8nN1tQXg3WLlvbwOH4TWRMfUbP56/R0LqurPczyB3ws0SZCCVIEH9bAK6ZZ3hXRGuZZqsGFwbaQC7OSQcMQKm9mKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728375250; c=relaxed/simple;
	bh=cC0RZZIWkpyHuRJz3IoEoS7wQDuApojvG++sJnvsvQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r8OGghATUuWciJ2POnWbN3Aa8s69nT/yhjsb0jlx7uGixisYWjwfRT7unaKT7kyNrrwSMKKbgSlsP8d26ZSUCsMxS4v2iXAGrtJL+/3/DMh9mlirPdf0e7/RDokftY2tZDpL9LYTwSORl6S7KO0aCbbVqlI/9WornzYx+Al9J2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i5LfItdp; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i5LfItdp"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e18aa9f06dso3790667a91.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 01:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728375247; x=1728980047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGR3mW3SExbQVu2QHULPkFA06M+rTTCGJlowrDVvC74=;
        b=i5LfItdpleQB8H7pyMQMFp/TeZwIdia3qLeeVOUpp4w+xAeqC3Znvp+a0dvZRdny0p
         7JT0cDED6f4gr/wwBqqab7jtC8olg14Z0soZY4qYd0b5IQXQt+40ABCYtgsnAFbLJavB
         L/NaR03I3RdA/o5tDGRWN2CRmd0uHc1QfSCw2a/mPjhUcfh5fj2Cpm/UgH1IJjH7/Xxx
         kg9v5iRrOwbu7xCTjJc/twBEJiCTh1PEytjVrW2jCVw0bxZEt+7Z3OACO5gQPyMRjtUN
         4irqALhvx1d3s3sUK2lDCUZEe9cEntPC3l1KqCwHBZyWAen7VRaeqARabZQmBVdTEJ5d
         FRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728375247; x=1728980047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGR3mW3SExbQVu2QHULPkFA06M+rTTCGJlowrDVvC74=;
        b=ZNqayNDTC0vBikRusGAfQiu/bDwA5LyxZyJd9UnYqQTQhoKRqGks40nJ1f2E51DaZT
         qdk4k2aWaj3GesAj60D3iTaCHtlGuRg2i9er7vyxxHx7BnFSyhS+c8e//zzLVO9RMhnd
         2ul4dztYrJRD3+jvURpDEalIZmgvbd3chsouJXHHqcDSRbuCNWhItsqZbH9axBp6Hiwz
         ZlFWg4oX90w/7lXURnQYAPENFFJ1/PpbYjROXMIQ8l9x5R7axBgGgMg431Sx0v/i3qRV
         9wRqRGUyoBxM2xz8jh3pSzimyUg3C0A7DmnRG5XUOT1Z2HxwjBWTg+RgwGszoh1WBN6K
         eFQQ==
X-Gm-Message-State: AOJu0YxvYjC1ZNwvkJajQz43v307Pl12U53JKc2igB8Jy2O+DXcVmd/c
	xYF1M5+b7jjfI0rsrkAqcAE5Dj27LUYBWs333T1V6Mcln8vNlsXeQc0gb95WgP81cO2S3AS7Uha
	a
X-Google-Smtp-Source: AGHT+IGLEVPpO4QtbytIU5Sj6F12AKzYbjuWBX9Ru/gVQeJil3QriFKcR+OiRwZHTI9FJ+PVBwRtzA==
X-Received: by 2002:a17:90b:46cd:b0:2e2:85b8:14e with SMTP id 98e67ed59e1d1-2e285b801c0mr1924810a91.15.1728375247427;
        Tue, 08 Oct 2024 01:14:07 -0700 (PDT)
Received: from localhost.localdomain ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e1e83ca28fsm8739647a91.7.2024.10.08.01.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 01:14:06 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v2 2/3] t0410: adapt tests to repack changes
Date: Tue,  8 Oct 2024 16:13:49 +0800
Message-ID: <20241008081350.8950-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241008081350.8950-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241008081350.8950-1-hanyang.tony@bytedance.com>
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
index 34bdb3ab1f..c169b47160 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -499,46 +499,6 @@ test_expect_success 'single promisor remote can be re-initialized gracefully' '
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
@@ -569,7 +529,7 @@ repack_and_check () {
 	git -C repo2 cat-file -e $3
 }
 
-test_expect_success 'repack -d does not irreversibly delete promisor objects' '
+test_expect_success 'repack -d does not irreversibly delete objects' '
 	rm -rf repo &&
 	test_create_repo repo &&
 	git -C repo config core.repositoryformatversion 1 &&
@@ -583,40 +543,14 @@ test_expect_success 'repack -d does not irreversibly delete promisor objects' '
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

