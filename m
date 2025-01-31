Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D01B6D15
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320818; cv=none; b=n1Za7gM3wYYsJILeA99ZEKy4pDvMM/VsTOSi6O81VCAu4lo+MT1CFNPzzTOuvsGuzEB7xKhk3+P2kJyCrii4sj95NS5d86U+R6VqNSPq6CionA6AIUS45Ijs/rzAvt+tjDQQwuUTT8Ecf21V3NdE//Kw8NuNsTh4Ho/y1ngnFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320818; c=relaxed/simple;
	bh=NZAEqcda03KMD4751hwnIPd2IvMxgJJbkqyfr7cCcbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kfKDXSNksfLeHz8a/xcrxxw3/t5WE6+Rw3tbBny+zCp4Hbasnw0Kf7hlxHO0rvFaNKJxjcLGGqr1D5N5KAAhj1cCMM5gV2pjEC86udZupFt3oabDTdHGyb6ynVDChO5owKa+K5UJcZEgtrVx1Yeu4wz/fPH+LYgfPTleFqx5kRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eIZEoo9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xjFwprKR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eIZEoo9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xjFwprKR"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4CD5E13801AD;
	Fri, 31 Jan 2025 05:53:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 31 Jan 2025 05:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320814;
	 x=1738407214; bh=NL/aSjUGctRTgM/tGKGtfUnBT0kPLUTyWnUFrJ0otio=; b=
	eIZEoo9dttOZ4wqU3ibNSifAk7JSYK/s08qv+GmCBYJPWM4cspGn8fAnZFe9DuaR
	dimhMdMVXiZ2mklRDb7B2EXG6i/w6eiAaNp0+XGQKrP+iJlz4TO42WjkFhHkxOsG
	fhDJPzD/51TH6p0txWwhFHUtInr0hxfUfWZxWHf4v2f79HvKeM+q6LKu34bVs5Pv
	qvlGwcU0kYo5lmQsj7qNwVB9H0T9S6Jq4JEGi/zNqkNuFLIQ07kqn/WVdbWzUlEV
	SI/+16wbpheHTktmeCyaIPjBKBEz8UThgsbUcC6+f72HyxnstMms8LuRbenZdF/H
	30RYDZGu0XcSPa+FFbSptA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320814; x=
	1738407214; bh=NL/aSjUGctRTgM/tGKGtfUnBT0kPLUTyWnUFrJ0otio=; b=x
	jFwprKRwT2e2DU2zEPsVL1RU1CkZ5jqihIkGtDolnxSTYLEW9I4v1areVjClov+u
	srH1jGJcRI6nXFiCR9xgkRxy7thuIDRnc0d37tz0kU1DSlk41rjnyeKvSEevJOmR
	JvWGBPtyyRPSUlxHgraIksSeZBSEF+45oB+M+g2uWlv2nrSLIDcR21RAyVS0V8vL
	lwJN728dKMcUvmn5XH9bz8SaJIWA4IuodL7ILKKRxHGHbhFTnr+An8ozJdOra7I4
	pChIfe/4jwNMQDghUCzx+up5e2vtHw6V/18kV18hx8bq5LqFBfGCo29EqnF54yMO
	yplYRR1fEt+OKmGD/bANg==
X-ME-Sender: <xms:rqucZ_dvPJXckrtIxKll-u4-hlZgoO6MyaXf6zy5_0HGCHbSdrO7SQ>
    <xme:rqucZ1Oy_YiEP6HvCZxOgqdl0ySrZbpEA6bqn3VxpqnyJO0IoRkfbg5bpDo9H9VHn
    xwNdHlFDJUQbLpEaA>
X-ME-Received: <xmr:rqucZ4jXH5jyUuXoa-W0cU1Of9gBR9hnjFYagb8h_466VfPvJSsyfEqr2LHlIksylzkei-SAQ6g0F0KMrs13gHbskVC2uLmvV0Ec68uYjsfyGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdr
    tghomh
X-ME-Proxy: <xmx:rqucZw9hdkcrmhEy0fYegxZoO8vaDs2fWtZU8vI-mK26fQFzph68Cw>
    <xmx:rqucZ7uRsoALDeyLViC__gXHHw-76PJzAIWDmsZEYwuGypGSOl2p1w>
    <xmx:rqucZ_GqQD7q-oZkpthfOj8UByTFtFgFI0i0x4Ma8y6uvJ_Q48KKUg>
    <xmx:rqucZyPg5qGY0NejHO2ZQ4fYSbYj9g1AERKy2xIEsswBgw0EIkcgEQ>
    <xmx:rqucZ7Id_3k5iWoQUH-zFMnuq61d6x8OksiSPL9eWXQ4giq6cAAa1MKL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9de03c54 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:27 +0100
Subject: [PATCH v4 3/8] t5548: refactor test cases by resetting upstream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-3-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor the test cases with the following changes:

 - Calling setup_upstream() to reset upstream after running each test
   case.

 - Change the initial branch tips of the workspace to reduce the branch
   setup operations in the workspace.

 - Reduced the two steps of setting up and cleaning up the pre-receive
   hook by moving the operations into the corresponding test case,

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 149 +++++++++++++++++++++-------------------------
 1 file changed, 67 insertions(+), 82 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index a3defd5b75..ededd8edb9 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -96,8 +96,8 @@ setup_upstream_and_workbench () {
 	# we will use it in the subsequent test cases.
 	upstream="$1"
 
-	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
-	# Workbench after setup : main(A)
+	# Upstream  after setup: main(B)  foo(A)  bar(A)  baz(A)
+	# Workbench after setup: main(A)                  baz(A)  next(A)
 	test_expect_success "setup upstream repository and workbench" '
 		setup_upstream "$upstream" &&
 		rm -rf workbench &&
@@ -105,6 +105,8 @@ setup_upstream_and_workbench () {
 		(
 			cd workbench &&
 			git update-ref refs/heads/main $A &&
+			git update-ref refs/heads/baz $A &&
+			git update-ref refs/heads/next $A &&
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
@@ -133,19 +135,14 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
-	test_expect_success "porcelain output of successful git-push ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $A &&
-			git update-ref refs/heads/baz $A &&
-			git update-ref refs/heads/next $A &&
-			git push --porcelain --force origin \
-				main \
-				:refs/heads/foo \
-				$B:bar \
-				baz \
-				next
-		) >out &&
+	test_expect_success ".. git-push --porcelain --force ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
+		git -C workbench push --porcelain --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
 		> To <URL/of/upstream.git>
@@ -169,115 +166,103 @@ run_git_push_porcelain_output_test() {
 		test_cmp expect actual
 	'
 
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "atomic push failed ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $B &&
-			git update-ref refs/heads/bar $A &&
-			test_must_fail git push --atomic --porcelain origin \
-				main \
-				bar \
-				:baz \
-				next
-		) >out &&
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git push --porcelain --atomic ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
+		test_must_fail git -C workbench push --porcelain --atomic origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
-		> !	(delete):refs/heads/baz	[rejected] (atomic push failed)
-		> !	refs/heads/main:refs/heads/main	[rejected] (atomic push failed)
-		Done
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[rejected] (atomic push failed)
+		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
+		> Done
 		EOF
 		test_cmp expect actual &&
 
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
-		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/main
-		<COMMIT-A> refs/heads/next
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
 		EOF
 		test_cmp expect actual
 	'
 
-	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
-		test_hook --setup -C "$upstream" pre-receive <<-EOF
-		exit 1
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. pre-receive hook declined ($PROTOCOL)" '
+		test_when_finished "rm -f \"$upstream/hooks/pre-receive\" &&
+			setup_upstream \"$upstream\"" &&
+		test_hook --setup -C "$upstream" pre-receive <<-EOF &&
+			exit 1
 		EOF
-	'
-
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $B &&
-			git update-ref refs/heads/bar $A &&
-			test_must_fail git push --porcelain --force origin \
-				main \
-				bar \
-				:baz \
-				next
-		) >out &&
+		test_must_fail git -C workbench push --porcelain --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> !	refs/heads/bar:refs/heads/bar	[remote rejected] (pre-receive hook declined)
-		> !	:refs/heads/baz	[remote rejected] (pre-receive hook declined)
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[remote rejected] (pre-receive hook declined)
+		> !	:refs/heads/foo	[remote rejected] (pre-receive hook declined)
 		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
-		Done
+		> !	refs/heads/next:refs/heads/next	[remote rejected] (pre-receive hook declined)
+		> Done
 		EOF
 		test_cmp expect actual &&
 
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
-		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/main
-		<COMMIT-A> refs/heads/next
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
 		EOF
 		test_cmp expect actual
 	'
 
-	test_expect_success "remove pre-receive hook ($PROTOCOL)" '
-		rm "$upstream/hooks/pre-receive"
-	'
-
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "non-fastforward push ($PROTOCOL)" '
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)                          next(A)
+	test_expect_success ".. non-fastforward push ($PROTOCOL)" '
 		(
 			cd workbench &&
 			test_must_fail git push --porcelain origin \
 				main \
-				bar \
-				:baz \
 				next
 		) >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> -	:refs/heads/baz	[deleted]
-		>  	refs/heads/main:refs/heads/main	<COMMIT-A>..<COMMIT-B>
-		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
-		Done
+		> To <URL/of/upstream.git>
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> Done
 		EOF
 		test_cmp expect actual &&
 
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
-		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
 		<COMMIT-B> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF

-- 
2.48.1.502.g6dc24dfdaf.dirty

