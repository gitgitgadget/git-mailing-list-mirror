Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98191D7E42
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564189; cv=none; b=UqOD+F23JcrVdGuHvYgOsbuxvU60NRR3FXKUktxij4PHQ1V0HT8L9PKW211iRWrWLKPOdULQbptevsXUU6HOM+Km3KLs+kjM1bYNX7bfXqmPvUHw2kt23t6rjpMZB1FCRVFXaVfDV9MAnZ4MZkyYFalb4K0JK80CuH4tIBQTKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564189; c=relaxed/simple;
	bh=gp9gr6f2CtR6JbaxnktAQHv/7LHu64nW4DNFKazr9og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kry2zM1Jc6fo5umf1/vqDLqD5dvWv5bmI/5ZSzeeKKSBkhFRaY1Ckn1SW61niSrTGvuxJS2aWawEt4pIzLNqmvmMQ51s0YUWgqvcodFTNUmtOCemiT2CUdVQslQBaTXAgAnHua8B3HnaCkp+3CnFhAQT5Fxv4F+YG+K6ltIIXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OMccnbbr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=of2sFEkM; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OMccnbbr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="of2sFEkM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 08AF3138063E;
	Mon,  3 Feb 2025 01:29:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 03 Feb 2025 01:29:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564187;
	 x=1738650587; bh=3mQwCzky9tzOZuX4icIW65uRoMfQop0ECEBd+QCpS7Y=; b=
	OMccnbbrLj/eypKHoNbIXRwIPAM3QJLh2X9xEPW1kvUjwe662hQ2N445pZB1rhaf
	kXnxBFFC/A5h+nSuNSvdNAiztKmqt6Fw2RHBcAS8+o33H7uTunHQlbayiNYNCFd0
	8016F2fLKmIBxlQvYAST8knt2A1+ivzvH2PYtqXgVL3u5zF5gOJ2nfreND809e6S
	gjLrRaCwt6wiEBPMXOrzU/KXxetHiqvKZS+SKX7iYNmmRV6KVJz+Ev1Bia/GHSZw
	y6meojv0DjLs16+mC35vUXdgr6lAmKT1j6PPUM3VEmPw6wVdjbYelzg2H/wamJL3
	qjn1AFILX57xKT2KgDup/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564187; x=
	1738650587; bh=3mQwCzky9tzOZuX4icIW65uRoMfQop0ECEBd+QCpS7Y=; b=o
	f2sFEkMxgFtb4gGvqZVrCzIbvY8OqDhyqRWymTs8if4ph5Eir0r58CxJ+1tBls/n
	bUIK5YH54OHlaRqTV4M0oTRxZ+PIO8+4Zfu9Vqi2rISjtaSgMcx28X/EOrPZsXA9
	EjSBsxpYwx7vtjkZEpQcqkB6HbQpDmEnTS0S7frFYNcuqrf5EQNaUKDwg79JCuNO
	q47kcK4JEU93D6zBfq6mb+G+8BeqazvgAY7hZG/89rUxfbpBWSeJC8C/ZaPeP8sx
	F5bfflG99HWTLmiApwki8ruV2ghbNeiDj7Z6Wlv0JWV01sSvBKgnNZkcKKs7UlrO
	pQYSznBFfP3Z1SOTz605g==
X-ME-Sender: <xms:WmKgZzoiz7OPdbMsjheGw0xR1ZLKe7ETw26C_Ckk_XI8aDYBGprEag>
    <xme:WmKgZ9rKX8meBzQb4xopEBXu1W3Nj5h53MPvHtEMaaM95ncsna-AtapNF2lRhctIb
    herTuoa46DmZesUkg>
X-ME-Received: <xmr:WmKgZwOTYdLzOqdjRHFJJ8pNkmVenD81qRzoSyLht67_PzlZr4n2dsiMSEufcIfl7jY_2SgWaX7qLkiV86cOS-vB7WKoFTLGvBPYxdDlTBoT8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:WmKgZ262R6MOU0Z6ih4LX8M3rSSkjxOEyHkZbW89W8z4SawlaaQjtA>
    <xmx:WmKgZy5FG8HUdsQqy9CBN20wmMeSGe91BAB8s5K_te4TepxBxeif_Q>
    <xmx:WmKgZ-hkEuRfKRkOjVrZoosmA8FFnIyzkp3fVkgfysFz3mhKZP8NrQ>
    <xmx:WmKgZ074-kqZNMHvaJeJkxvFfc-EHrQ7VwrvuMxYvU3hYlMuX9eWNA>
    <xmx:W2KgZ90CyjQTemkgrjRkpi4RPChOspMbEFeJMiAP_m70ee1imdqltR3S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88390498 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:33 +0100
Subject: [PATCH v5 3/8] t5548: refactor test cases by resetting upstream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-3-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
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
index 1bf4d48cd9..f9aeb5a9d9 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -94,8 +94,8 @@ setup_upstream_and_workbench () {
 	fi
 	upstream="$1"
 
-	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
-	# Workbench after setup : main(A)
+	# Upstream  after setup: main(B)  foo(A)  bar(A)  baz(A)
+	# Workbench after setup: main(A)                  baz(A)  next(A)
 	test_expect_success "setup upstream repository and workbench" '
 		setup_upstream "$upstream" &&
 		rm -rf workbench &&
@@ -103,6 +103,8 @@ setup_upstream_and_workbench () {
 		(
 			cd workbench &&
 			git update-ref refs/heads/main $A &&
+			git update-ref refs/heads/baz $A &&
+			git update-ref refs/heads/next $A &&
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
@@ -131,19 +133,14 @@ run_git_push_porcelain_output_test() {
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
@@ -167,115 +164,103 @@ run_git_push_porcelain_output_test() {
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

