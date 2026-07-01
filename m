Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F941378812
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782923849; cv=none; b=J/9yR260khSUZDPFGx7+dNCSDQrM7sp1iHmU8a5BwBYH3hj+sTtsgnCTawxx0OtYqhJg7Cq8yACeC7WHt4G10JZhdWnl3Z9QCKprMuwWjab+nap4M754OmduWYUQZYch1+RNh5qXABuP7tvjARzbbrsywUwknpo0n7LbJ1iMjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782923849; c=relaxed/simple;
	bh=crILwDu7kXwHGnJEq2b4+KrFYIq5UA3F2fN+RLBpOOM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Tj3DR+UWiBRdKuh+7wY2BXqv6EDqWq82NPPO8PhoU6HzAHqwI3Y814JtQlyqAm8NNIHEYSNIXg5nG1mhnqb7mDGAuHH7yPnnXgxU/bff/lZlSYiQQfWkBfKAo4hNyClxZBtN8VM3ouXOWi5Oc4JnQnhD6EsUzlm1pHKzAJ59ibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cA1ObzcN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cA1ObzcN"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-847a483e344so554591b3a.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782923846; x=1783528646; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVxJ+ZW6NatIWjljrdJ1twkMQ9mh7f9e1u9Y/N1LepE=;
        b=cA1ObzcNqvPsstUYugB/l24WuoZKp7aucEckKVA+GAJFpLCgW6n74hrQEF6wuJL+iv
         IqG9PPpIE2KyvQjoVAYXVvH6hnXxg78DluE76mHAXDPksqAZD7G/8uKazxPjf817kYA0
         kuNHYa9pywwmbN0cG+80hhH8fXN3THpJgA2RszOqJAWoq6FBSBTG27ADpNJNvQVNrXVa
         fvnj4SLfoGmoZJLC22SXamrBRTF1pXeR09uEtnuVHmdE1yAq1joPhUA1ravV1AzaIH+3
         peoZmmP9QIHxpLnA2o0DGnTWfQmzAiHNhh+a2pWU/UYqTKeAmyjHbA/WLf/8t6HaE3tH
         Stxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782923846; x=1783528646;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVxJ+ZW6NatIWjljrdJ1twkMQ9mh7f9e1u9Y/N1LepE=;
        b=PSKSB/nG3warBhdugndCnLTzIq0Nge20lDuNgb2tvK0ngdq55KdMPTwbJCqJdxZ9Sz
         nCzwt92r1mRy5Nu3VQzi0mJy1KgISxdG42iRHu0fXuZLcm60RsQS8/2dOWusWmVh/YUZ
         azuEMm2AdrlV/BVm1exSvI7pmtCHrUEKsTj6XGtTkkFyc+uIsJEtMrTwuncem24s3cL5
         EfxxBYg3U2rpZG4obSFKyCUBLc1H8k1DjeGm/m3k8ZtlGRiQ0BsWzlNCS1KFukYJsL2P
         eUkqUtHWXhjKri+0cPS5gVrStN6xjIM5UtMKHzbiVODeaPIk5dYrL12ndeZHg0KmvvQg
         PRRw==
X-Gm-Message-State: AOJu0Yy8qPyYLZp9kdwn+IUwRmu3gdMWogR378nsNDAZ5mL/Ir0B+mm2
	nPVDjOmd/vQCTkEo04w7/dNCykA2/RX3IlSvPR6LjXS9ix8kArQ60jKd5yNyjA==
X-Gm-Gg: AfdE7cmw4vRU0uj8WgxHNfa0Ji3MlgPNA4SOV4/9Q1UAd86289neBM0OKJRctcGfhnp
	8kvPXwBQrxl88Pj91Ylk+h9xw52fF8yNAX7uRubnIADGiXKyhcEp229M/oBbaNZPYsenydY2DIA
	A8WYeRIdsuSpaHW+M/O3TeOtOKBqvup/23W7Pajm6/ELRClSnSxlLBFmOt3DC7ivvClkHWTd19g
	bFaNF2fIyONeBkUwXG7qlhD+lz10JGIQy87tBw4orcHhG2BFOmQlacfNNsqQIPLUycoTUfkuOCs
	799BN0DqfNkjeXEHSwIe2vRVq1uPmes293GVzPPxFQdnAuFNSCWlxcA6eNKPZiYE9kP9Vu3jXkE
	vwY2GcABlRK1cXS4dr424LFIzuZsTjjSXhfg5WXvVOS2AieLuJfhGcxeKJasHrzDg+zBSNRe2Zt
	+UirhtLOtbunqqT3wh65WlHOhzrg==
X-Received: by 2002:a05:6a00:2986:b0:847:b45b:fef3 with SMTP id d2e1a72fcca58-847bfa4ab29mr2170401b3a.27.1782923845325;
        Wed, 01 Jul 2026 09:37:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.198.170])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb79b9adsm81048b3a.27.2026.07.01.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:37:24 -0700 (PDT)
Message-Id: <c6e3cc13f702344b1d20ae7005b02b90b6677979.1782923832.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
References: <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com>
	<pull.2149.v5.git.1782923832.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 16:37:07 +0000
Subject: [PATCH v5 06/10] t6600: add clock-skew topologies and step counts for
 edge cases
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Add topologies and tests exercising paint_down_to_common() under
clock skew, where commit-date ordering (v1 commit-graph without
corrected commit dates) violates the topological invariant that
children are dequeued before parents:

 - se-*: side-exhaustion fires too early when one paint side fully
   drains from the queue while a low-date ancestor on the other
   side is still queued

 - se2-*: side-exhaustion returns a too-deep merge base because
   the correct (closer) base never receives both paint sides

Also add step counts to the edge-case tests from the previous
commit, a mixed finite/INFINITY generation topology exercising
the transition from INFINITY-generation commits to graph-backed
commits, and step counts for the grid-based merge-base test.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 141 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 2 deletions(-)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 7a9a35023f..26a2a0a62f 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -104,6 +104,85 @@ test_expect_success 'setup' '
 	pi_x="$(cat pi-X-oid)" &&
 	git branch -f pi-X-br "$pi_x" &&
 	git tag pi-X "$pi_x" &&
+
+	# Build a topology with clock skew to test the !FIND_ALL early
+	# exit in paint_down_to_common().  M2 is the correct merge base
+	# of P1 and P2, but its ancestor M1 has a higher committer date
+	# due to clock skew.  With date-only ordering (v1 commit graph
+	# without corrected commit dates), M1 pops from the queue first,
+	# gets both paint sides, and the early exit fires before M2 is
+	# ever visited.
+	#
+	#        P1     P2          @7000
+	#        |     /  \
+	#        A    B    D        @6000
+	#       / \   |    |
+	#      |  M2--+    |        @2000 (correct merge base)
+	#       \ |        |
+	#        M1--------+        @5000 (clock skew: date > M2)
+	#        |
+	#       root                @1000
+	#
+	git checkout --orphan skew-orphan &&
+	skew_tree=$(git mktree </dev/null) &&
+	skew_commit () {
+		GIT_COMMITTER_DATE="@$1 +0000" GIT_AUTHOR_DATE="@$1 +0000" \
+			git commit-tree -m "$2" "$skew_tree" $3 $4 $5 $6
+	} &&
+	skew_root=$(skew_commit 1000 root) &&
+	skew_M1=$(skew_commit 5000 M1 -p "$skew_root") &&
+	skew_M2=$(skew_commit 2000 M2 -p "$skew_M1") &&
+	skew_A=$(skew_commit 6000 A -p "$skew_M1" -p "$skew_M2") &&
+	skew_B=$(skew_commit 6000 B -p "$skew_M2") &&
+	skew_D=$(skew_commit 6000 D -p "$skew_M1") &&
+	skew_P1=$(skew_commit 7000 P1 -p "$skew_A") &&
+	skew_P2=$(skew_commit 7000 P2 -p "$skew_B" -p "$skew_D") &&
+	git branch -f skew-P1 "$skew_P1" &&
+	git branch -f skew-P2 "$skew_P2" &&
+	git tag skew-M2 "$skew_M2" &&
+
+	# Build a topology where clock skew causes the side-exhaustion
+	# optimization to fire too early with date ordering (v1 graph).
+	# D is the correct merge base but has a higher committer date
+	# than C (its child), so D is dequeued before C.  The P2 side
+	# (B -> D -> root) fully drains while C (P1-only) is still
+	# queued.  Side-exhaustion fires, missing D as a merge base.
+	#
+	#   se-A (date 7000) --> se-C (date 3000) --> se-D (date 5000) --> se-root (date 4000)
+	#   se-B (date 6000) --> se-D
+	#
+	se_root=$(skew_commit 4000 se-root) &&
+	se_D=$(skew_commit 5000 se-D -p "$se_root") &&
+	se_C=$(skew_commit 3000 se-C -p "$se_D") &&
+	se_A=$(skew_commit 7000 se-A -p "$se_C") &&
+	se_B=$(skew_commit 6000 se-B -p "$se_D") &&
+	git branch -f se-A "$se_A" &&
+	git branch -f se-B "$se_B" &&
+	git tag se-D "$se_D" &&
+
+	# Build a topology where side-exhaustion with date ordering
+	# returns a wrong (too-deep) merge base.  MB1 is the correct
+	# merge base; MB2 is its parent and should be filtered as
+	# redundant.  A reaches MB2 via E (high date) and MB1 via C
+	# (low date).  B reaches MB1 via D.  With date ordering, the
+	# P2 side drains after MB2 is found but before C is dequeued,
+	# so MB1 never receives P1 paint.  Result: MB2 (wrong).
+	#
+	#   se2-A (date 8000) --> se2-C (date 2000) --> se2-MB1 (date 5000) --> se2-MB2 (date 4000) --> se2-root (date 1000)
+	#   se2-A              --> se2-E (date 6500) --> se2-MB2
+	#   se2-B (date 7000) --> se2-D (date 6000) --> se2-MB1
+	#
+	se2_root=$(skew_commit 1000 se2-root) &&
+	se2_MB2=$(skew_commit 4000 se2-MB2 -p "$se2_root") &&
+	se2_MB1=$(skew_commit 5000 se2-MB1 -p "$se2_MB2") &&
+	se2_C=$(skew_commit 2000 se2-C -p "$se2_MB1") &&
+	se2_D=$(skew_commit 6000 se2-D -p "$se2_MB1") &&
+	se2_E=$(skew_commit 6500 se2-E -p "$se2_MB2") &&
+	se2_A=$(skew_commit 8000 se2-A -p "$se2_C" -p "$se2_E") &&
+	se2_B=$(skew_commit 7000 se2-B -p "$se2_D") &&
+	git branch -f se2-A "$se2_A" &&
+	git branch -f se2-B "$se2_B" &&
+	git tag se2-MB1 "$se2_MB1" &&
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -287,7 +366,8 @@ test_expect_success 'get_merge_bases_many:pending-stale' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse ps-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 6 6 6 6
 '
 
 test_expect_success 'get_merge_bases_many:infinity-both-sides' '
@@ -301,7 +381,34 @@ test_expect_success 'get_merge_bases_many:infinity-both-sides' '
 		echo "get_merge_bases_many(A,X):" &&
 		git rev-parse pi-B
 	} >expect &&
-	test_all_modes get_merge_bases_many
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 5 5 5 5
+'
+
+test_expect_success 'setup mixed finite/INFINITY topology' '
+	# Create a commit outside all saved commit-graph files so it always
+	# has INFINITY generation, while its parent (ps-X) is in the graph
+	# with a finite generation. Use the ps-* orphan topology so we do
+	# not pollute the grid-based rev-list tests.
+	git checkout ps-X &&
+	test_env GIT_TEST_COMMIT_GRAPH= test_commit pm-INF
+'
+
+test_expect_success 'get_merge_bases_many:mixed-finite-infinity' '
+	# One tip (pm-INF) is outside the commit-graph with INFINITY
+	# generation; the other (ps-B) is in the graph with finite
+	# generation. The walk starts in the INFINITY region and crosses
+	# into the finite region where side-exhaustion can fire.
+	cat >input <<-\EOF &&
+	A:pm-INF
+	X:ps-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-X
+	} >expect &&
+	test_all_modes get_merge_bases_many &&
+	test_paint_down_steps 3 3 3 3
 '
 
 test_expect_success 'merge-base --all commit-walk steps' '
@@ -311,6 +418,36 @@ test_expect_success 'merge-base --all commit-walk steps' '
 	test_paint_down_steps 81 80 81 81
 '
 
+test_expect_success 'merge-base --all with clock skew and v1 commit-graph (side-exhaustion)' '
+	# With date ordering (v1 graph), the side-exhaustion
+	# optimization can fire too early.  In this topology, the P2
+	# side (se-B -> se-D -> se-root) fully drains from the queue
+	# while se-C (P1-only, low date) is still queued.  With
+	# generation ordering, se-C would be dequeued before se-D
+	# (child before parent), propagating P1 to se-D and
+	# discovering the merge base.  Date ordering violates this.
+	>input &&
+	git rev-parse se-D >expect &&
+	run_all_modes git merge-base --all se-A se-B &&
+	test_paint_down_steps 6 4 6 6
+'
+
+test_expect_success 'merge-base --all with clock skew returns wrong merge base (side-exhaustion)' '
+	# With date ordering (v1 graph), side-exhaustion causes
+	# merge-base --all to return MB2 (too deep) instead of MB1
+	# (the correct closest merge base).  P1 paint reaches MB2
+	# via E (high date) before it reaches MB1 via C (low date).
+	# After MB2 is found as P1|P2, the P2 side drains and
+	# side-exhaustion fires while C is still in the queue.
+	# MB1 never receives P1 paint, so it is never identified
+	# as a merge base.  remove_redundant cannot discard MB2
+	# because MB1 was never found.
+	>input &&
+	git rev-parse se2-MB1 >expect &&
+	run_all_modes git merge-base --all se2-A se2-B &&
+	test_paint_down_steps 8 7 8 8
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

