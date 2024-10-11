Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93F20ADFF
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 08:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728635065; cv=none; b=MLemlOpXSKbyZ8ZbZu1RgH8G9PSLnsb25m4AkHKnE3XaeRNxbaEi3ErgfH79xlEZqNQ7npZSkpOFInRjkUbskiZ7iABCuOFBDJ+S0+9X6ECpXR9QTqhkCGMLUPW9lNLe6nb5/SxFn5GO7oLE15bwtVN7fPeJK66SUEt3mtNJusU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728635065; c=relaxed/simple;
	bh=Jm8GJC3TuFANCWFwNDzBSOO3SYtMDYBLDK6S/x3qO3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RI9XttKiynkgcvPnz7JreRifYHTzSBrTdH5mrYozadxmTt30fNO0aXlQkFPlVcNxof8Q57GvWD2LrmCExVJ9jHwIiVJc+nzs6zoMI+0YHOayyO4C20FI6ZxN7YeSkuG5yBax1UbD4APqtIrbs///YyMPYnC0/VDAPyF/Z0Mx9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=R34qpoxQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="R34qpoxQ"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20bc2970df5so14090045ad.3
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1728635062; x=1729239862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPsFZEvcX2s3Og4Yobni1TMwehCkK7UD+ta+1acy4Pk=;
        b=R34qpoxQs+m+E+SwW9Wv/fwEYoaXGHEu4XPW95bk+1F3yzekNGevEigtPwhLnkcOLp
         33/g4uPg5lit37OMcc9FF217nyMp1KN0KpQTZoBDfL7u/QfYjkOPTRg9AUkIodrSjCEq
         WlaOLCRCX5hykajlg4+DyoMAqvRGvhTA73PL74QAhoeT3zqA8gJeRdg3QUvcIu0SGxsd
         FDPH8qjbeUDaxCMO48Y/AdHpnwMQECiXM/yK0FOzNRxJ6arTy8muFTuLg8x7H9uoSznJ
         to++u5EmHuQ/Oo286wheirSYBqYJHblo0W1MlHvNpJ6L3rr+1nxYhaEFzh7s4V4hgvnV
         KWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728635062; x=1729239862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPsFZEvcX2s3Og4Yobni1TMwehCkK7UD+ta+1acy4Pk=;
        b=NbT1Ei0qRJIE3LFuGNmo0DpaQh4pWzz//LGDsACASfA56EWlBSyG/UV413EZJUWznN
         dFJufZ/dtcWPfcaicn95Z38BNBQPJLM0JQJ1K3lBAZ5P1clpugRsjp7NULhPuuHQlq3h
         rFCBx/Y2FKyMDzk6b2l1gliaM1hZBwsdjvFJzvGeD/BMU5etXcMDKMy5OmV+/iD01wim
         6sA7VmxyNIS9v5L8gw58Ej+krV/P420swpGtiQG/o03xlQxaT2AJyOW5PiY/QFO5n+Ka
         Bz5ZWtWGBWjM4RuhCCEKXBUTqby/1YnqntKmh8f55mo4EQNlx45vMdu0au0CIYGUaiif
         AuGg==
X-Gm-Message-State: AOJu0Yw7LSTP32zgZHUEkPuhtFXN4k7fnxHDHE19geCzXaAT+YSukwM5
	G9r7N9t/CUOcB0Onb2FX+giK/Hpkm5S6frqJyd5/afyOOAKstSlaqICmEKoFaC/3KaSTSY6mfqy
	Op38=
X-Google-Smtp-Source: AGHT+IFQc7dTsGEB404cjQhq0psZWivYw/K8swpbZngu289AOPm1NKmilan4f6trwkgajcO3T021Ug==
X-Received: by 2002:a17:902:da86:b0:20b:8325:5a2a with SMTP id d9443c01a7336-20ca1461fb0mr30426715ad.20.1728635061866;
        Fri, 11 Oct 2024 01:24:21 -0700 (PDT)
Received: from localhost.localdomain ([203.208.167.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5fa8ddesm2643121a91.39.2024.10.11.01.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 01:24:21 -0700 (PDT)
From: Han Young <hanyang.tony@bytedance.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	sokcevic@google.com,
	gitster@pobox.com,
	phillip.wood123@gmail.com,
	Han Young <hanyang.tony@bytedance.com>
Subject: [PATCH v3 2/3] repack: adapt tests to repack changes
Date: Fri, 11 Oct 2024 16:24:03 +0800
Message-ID: <20241011082404.88939-3-hanyang.tony@bytedance.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241011082404.88939-1-hanyang.tony@bytedance.com>
References: <20240802073143.56731-1-hanyang.tony@bytedance.com>
 <20241011082404.88939-1-hanyang.tony@bytedance.com>
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
 t/t0410-partial-clone.sh              | 68 +--------------------------
 t/t5616-partial-clone.sh              |  9 +---
 t/t5710-promisor-remote-capability.sh | 15 ++++--
 3 files changed, 14 insertions(+), 78 deletions(-)

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
index 2c2c50e3ff..19166cd4ce 100755
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
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index c2c83a5914..0912acae44 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -32,17 +32,26 @@ check_missing_objects () {
 }
 
 initialize_server () {
-	# Repack everything first
-	git -C server -c repack.writebitmaps=false repack -a -d &&
+	git -C server remote remove server2
+	has_promisor_remote=$?
 
 	# Remove promisor file in case they exist, useful when reinitializing
 	rm -rf server/objects/pack/*.promisor &&
 
+	# Repack everything first
+	git -C server -c repack.writebitmaps=false repack -a -d &&
+
 	# Repack without the largest object and create a promisor pack on server
 	git -C server -c repack.writebitmaps=false repack -a -d \
 	    --filter=blob:limit=5k --filter-to="$(pwd)" &&
 	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
-	touch "$promisor_file" &&
+	touch "$promisor_file"
+
+	# Configure server2 as promisor remote for server
+	if [[ $has_promisor_remote -eq 0 ]]; then
+	    	git -C server remote add server2 "file://$(pwd)/server2" &&
+	    	git -C server config remote.server2.promisor true
+	fi
 
 	# Check that only one object is missing on the server
 	check_missing_objects server 1 "$oid"
-- 
2.47.0.266.g0b04b6b485.dirty

