Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83B8429029
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440542; cv=none; b=aRLEfVxHXxhNo5bfml7JtrxevynNzA6T5zRCUBs/i0TxLe/u1Ng5KZEe8JV6SBCGVaCeqpKLWGYuJwkbJyInBAV/SP67ZnakUGKW1xB4kvHTcorzsqL5VUrxwGnBDWtKyqLiBhiTDImc9GnuhHBW4oH5k3JDkoOU/jtbROOVWLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440542; c=relaxed/simple;
	bh=YP9TgszYxVmEG6Y8gzONCEWAhUyhzuKSOIy5SNY/N+E=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NYeGxt+GflXNmGFk+1RHDrceU+UhreE+7Tt04+ddAEulb+zXgb2E24h57YegDdLCrLU6cvwcErqsehy+wKFRad0XsQaQDfaqHg3mlzK108qQRv5GZKAHs6u9vTLd9is9b+N2FQU2ll2RlOXMivk0H6+pZQUQEOAO+YHA7ouRs+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grxQnvat; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grxQnvat"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84874b52eabso3596631b3a.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2026 02:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440539; x=1787045339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=POfcm+jQHHiPWCuqS6+ahjDNDFAIjJib/TojJiK1yFw=;
        b=grxQnvat8DT+YsKlTakQDjFlqIaQe+o8JwjTLF6ovdUxC6IWQT0GUXhxdZPTSR2fif
         IfH3ey/9zYHm2ULZfd7W8v/ikT6d6toFsaS+knWUNRoQla2o7TZE0GxZ7rcpInFQqxnJ
         7eBgIumqKfW9xgBCT9wB8vN/mmrxTL01WrOXK7RmbHD08OCYRy9HpKRru+WPzs77PpS0
         UOfgYUzw5h9eqqS/uawnfYPXbuhNHJJHBJMF+4ilaI1+3KjLEC4IIGKi9WYN3W1J6lxs
         Z34Gu9VjjU991R/G85UBbePaGHmpmM0Y1Y2ptkT7dfEQtmk2ShW7qUL5f/AC2t5pXPXb
         4x4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440539; x=1787045339;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=POfcm+jQHHiPWCuqS6+ahjDNDFAIjJib/TojJiK1yFw=;
        b=QikvQqo4/Qdx5UbMffYXqDyym3gCarHuhMOxVmcfQ2npwBQ2meF2QtdavcmLvQOlqY
         mGKt+hXuANe9MW+FTlKfNuoP3rUn/mtyOgPLoL/5bnoDK/uxKZewWmpH0nidMtUS51l7
         eho/F0Ala+Zqn4ek/olGPpk7l4HlsNTdur4EOZ5ODtGUOVkJCbd+bljDxgUZ7U8GRZcc
         JlgGvy+CJEIQSTnVMH/8mOmzCMVatMV7Sm+wX49nOFbWMzsLNH0dAubJPwydbhGwvZ2g
         JER/IRzOobZ+UdweHuCTmPlbg96+lIvAxLYelqX8TLJdajUdceCUwOniCDHOFCM6uMqM
         WKWA==
X-Gm-Message-State: AOJu0YzTS7FEy0ckpDUOK3a+jgE5fssOOpNwOS+opFbZdouUP3GhhLVL
	p4mO75vLVSRP9e7pPqVn6kJEkKmasCP3TNdtVXtRBCGf4LrNgW7R1lCYr/efNvm2
X-Gm-Gg: AR+sD12VHJOVXDFmcTvnzko7C4vskLtQTNnFhu3B7o9QGk+2nInITaTpUoqyDQUFpsv
	G1nXzL9GGxKmD3UIYZ72kKcmC+m1Fd5xELfyoA+HLIvv4FO1mjx7jQZB0dyxYBRptCbGLIlTUDu
	4iJ9pe1YjNER1v7nDgsp/c84PzRPrAeWqhUq36HmQ9ZIuXgaigZlygeDXFpItgxIOooFSKyWQT0
	X7bAaaVSgsRNfoQwMxL1xAE4e6v6wPllBdcaakWKbIEzYX/ldQ4lRGBSoJrqpkBK343lmxoWFCY
	yjp0g4/kyt+223TVZ8MTq+QEQyoUnSl31SGX30Aa76PD+uW975GpR6xShDeEc15z0c7R8NRpRmT
	14FUtK+tXjirU/Y+DV0POwGsf8m4/h29ICmKrfCdGOIR/rviS15Lbe93ALW8KcbMb0s3OP6co6m
	ySbpIVOcuC/VwWSv7/3vzyrDOfQm4SqMVnp021L0aJLLBvLiW+mu9o2GxWPX9ouowyiXAbbe4SQ
	Q==
X-Received: by 2002:a05:6a00:4c98:b0:847:902a:57b5 with SMTP id d2e1a72fcca58-84fa888f6b8mr2043201b3a.35.1786440538913;
        Tue, 11 Aug 2026 02:28:58 -0700 (PDT)
Received: from [127.0.0.1] ([4.155.196.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa954c125sm391992b3a.41.2026.08.11.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:28:58 -0700 (PDT)
Message-Id: <6208bcf3b3e908a8b9ac48248357c1447c052405.1786440533.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v8.git.1786440533.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 09:28:45 +0000
Subject: [PATCH v8 03/10] t6600: add test cases for side-exhaustion edge cases
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Add test cases to t6600-test-reach.sh that exercise edge cases in the
side-exhaustion optimization for paint_down_to_common():

 - in_merge_bases_many:self: commit is both A and one of the X inputs
 - get_merge_bases_many:duplicate-twos: duplicate entries in X list
 - get_merge_bases_many:pending-stale: STALE transition on an
   already-painted commit (ps-* diamond topology)
 - get_merge_bases_many:infinity-both-sides: both tips outside the
   commit-graph with non-monotonic dates (pi-* topology)

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 t/t6600-test-reach.sh | 110 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/t/t6600-test-reach.sh b/t/t6600-test-reach.sh
index 019fed9f5e..a113adfc8a 100755
--- a/t/t6600-test-reach.sh
+++ b/t/t6600-test-reach.sh
@@ -85,6 +85,61 @@ test_expect_success 'setup' '
 	git branch -f skew-P2 "$skew_P2" &&
 	git tag skew-M2 "$skew_M2" &&
 
+	# Build a small side topology to exercise the (PARENT1|PARENT2) ->
+	# (PARENT1|PARENT2|STALE) transition in paint_down_to_common(); the
+	# 10x10 grid above does not exercise it because no merge-base candidate
+	# there is a descendant of another, so STALE never reaches a
+	# still-pending candidate.
+	#
+	#       ps-X
+	#       /|\
+	#      / | \
+	#   ps-Z ps-B ps-W
+	#     |  / \  |
+	#     | /   \ |
+	#     |/     \|
+	#   ps-T1   ps-T2
+	#
+	# where ps-T1=merge(ps-Z,ps-B), ps-T2=merge(ps-W,ps-B), so
+	# merge-base(ps-T1,ps-T2) = ps-B.  During the walk, ps-X transitions
+	# to (PARENT1|PARENT2) via ps-Z and ps-W before ps-B is dequeued;
+	# then the STALE-walk from ps-B transitions ps-X to
+	# (PARENT1|PARENT2|STALE).
+	git checkout --orphan ps-orphan &&
+	test_commit ps-X &&
+	git checkout -b ps-B-br ps-X && test_commit ps-B &&
+	git checkout -b ps-Z-br ps-X && test_commit ps-Z &&
+	git checkout -b ps-W-br ps-X && test_commit ps-W &&
+	git checkout -b ps-T1 ps-Z &&
+	git merge --no-ff -m ps-T1 ps-B &&
+	git checkout -b ps-T2 ps-W &&
+	git merge --no-ff -m ps-T2 ps-B &&
+
+	# Build a side topology that lives entirely outside the half
+	# commit-graph and has non-monotonic commit dates, to exercise the
+	# INFINITY-gate in paint_down_to_common.  With both tips outside
+	# the graph, generation is INFINITY and the queue falls back to
+	# commit-date order, which here is non-monotonic.
+	#
+	#   pi-X (date 500, PARENT1 tip) --> pi-P, pi-D
+	#   pi-D (date 480) --> pi-C
+	#   pi-C (date 200) --> pi-B
+	#   pi-B (date 100, PARENT2 tip) --> pi-P
+	#   pi-P (date 450, root)
+	#
+	# merge-base(pi-X, pi-B) = pi-B (it is an ancestor of pi-X and is
+	# itself one of the queried tips).
+	git checkout --orphan pi-orphan &&
+	test_commit --date "@450 +0000" pi-P &&
+	test_commit --date "@100 +0000" pi-B &&
+	test_commit --date "@200 +0000" pi-C &&
+	test_commit --date "@480 +0000" pi-D &&
+	GIT_AUTHOR_DATE="@500 +0000" GIT_COMMITTER_DATE="@500 +0000" \
+		git commit-tree -p pi-D -p pi-P -m pi-X pi-D^{tree} >pi-X-oid &&
+	pi_x="$(cat pi-X-oid)" &&
+	git branch -f pi-X-br "$pi_x" &&
+	git tag pi-X "$pi_x" &&
+
 	git commit-graph write --reachable &&
 	mv .git/objects/info/commit-graph commit-graph-full &&
 	chmod u+w commit-graph-full &&
@@ -182,6 +237,16 @@ test_expect_success 'in_merge_bases_many:miss-heuristic' '
 	test_all_modes in_merge_bases_many
 '
 
+test_expect_success 'in_merge_bases_many:self' '
+	cat >input <<-\EOF &&
+	A:commit-6-8
+	X:commit-5-9
+	X:commit-6-8
+	EOF
+	echo "in_merge_bases_many(A,X):1" >expect &&
+	test_all_modes in_merge_bases_many
+'
+
 test_expect_success 'is_descendant_of:hit' '
 	cat >input <<-\EOF &&
 	A:commit-5-7
@@ -219,6 +284,51 @@ test_expect_success 'get_merge_bases_many' '
 	test_all_modes get_merge_bases_many
 '
 
+test_expect_success 'get_merge_bases_many:duplicate-twos' '
+	cat >input <<-\EOF &&
+	A:commit-5-7
+	X:commit-4-8
+	X:commit-4-8
+	X:commit-6-6
+	X:commit-6-6
+	X:commit-8-3
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse commit-5-6 \
+			      commit-4-7 | sort
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:pending-stale' '
+	# Exercises the (PARENT1|PARENT2) -> (...|STALE) transition path in
+	# paint_down_to_common().  See the topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:ps-T1
+	X:ps-T2
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse ps-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
+test_expect_success 'get_merge_bases_many:infinity-both-sides' '
+	# Exercises the push-time INFINITY-gate in paint_down_to_common().  See
+	# the pi-* topology comment in the setup test.
+	cat >input <<-\EOF &&
+	A:pi-X
+	X:pi-B
+	EOF
+	{
+		echo "get_merge_bases_many(A,X):" &&
+		git rev-parse pi-B
+	} >expect &&
+	test_all_modes get_merge_bases_many
+'
+
 test_expect_success 'reduce_heads' '
 	cat >input <<-\EOF &&
 	X:commit-1-10
-- 
gitgitgadget

