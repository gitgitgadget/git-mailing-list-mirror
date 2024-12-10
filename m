Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA4210F49
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830599; cv=none; b=TpW1CZw7cM7sirt+ACNLqjdetpH20OOhxEx4zrhFT5RZUkTBesWbwlk5TD7MP+Fp4p2TSNePHfOzh5tTCxdiLRy+6OvgR2XbwBPV/g8j9kJfcu8mX0aD6KkdZfy13hUf+cCjqtOra/whcgM8j07iAHdK0R4gMXECvCiPgAWjFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830599; c=relaxed/simple;
	bh=XyI3yJwfhZfLXUs9WUcLU56Qp5uDUYgMK6u6DC5bLdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IgkX9/ZOlt4nVQM/X8Z6vqsCb2Jlz7OAsuMX9a2rqkolrfiwmv8ZfYyrR9CYF9MPRJDdTOIpyyGGYkTPayaE3wGS+/X1A+f/nhSd/tlIp063GEO7e8sIVLi9t/hwhX9N9JJ1ABZAzd/npWhrFEunVBWMOTnea+qJr06cc0rUgMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPSuZt+o; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPSuZt+o"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-725f4623df7so1708579b3a.2
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830597; x=1734435397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MaQDXOV2INt7XeUbFA1pAr8j1RYrLRtYxcrbUoSUkoI=;
        b=UPSuZt+oEZsWN7DKAMFi/ia0Ea8tvZ9y52crZm4p5mUqBklH0Rw9wRIV8H4He/ESq2
         KOd1n3AVfDJkhKegJuyP+Y+Q0QeT/FmpAE6ArKuA6vIeK53aqUAt1ywU/YdZ3nGfdgWp
         vBAPHRHT/eQlbBv8IKioQL7g8qMLE8WkyieH9j/YIb/7HNIr219cwn7j+sovrKG7Fcjm
         nFCZ7H27h1/sRRH2NXZp0/r4bECBvBMC3ny0hsJ1qbEVZSverc6YurIbqBu1qpnwdClP
         BCb31Rwm+HHzWGQ9pVk3U1imp4ENhesiB98rEZ9NlHKIG17NgdHGAbwjFwapkkIDgqnB
         IAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830597; x=1734435397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaQDXOV2INt7XeUbFA1pAr8j1RYrLRtYxcrbUoSUkoI=;
        b=Z11dP70BU1z5imTzsfxpLeY4yp+9QWaE9Qi/F2XcpftbWb30oipYODG8sOZETgUrxL
         SIYvVzrMp3p/obYSHwpxpWj19X4FhLhWIcHB6H7uNXojXRKokN6M20kKxRgr735qWpyd
         rwkWewQilKAEFo00eqlbp4GHCsme4/44ikYo11zcIA1AyUvcOSBmmiyKcmF/D7VtlrYf
         Pgas18PRzOtXLz0MHL9gygi7sMGI6LmsLG/i5aOF43LrZs3BaWFnqzyF0ZmFxFKv09Jl
         SnvFejMtYaTzeUTmBWhCly+BuhjyVjc5aVA0ACSF9KRjUBPG5eGbK9c990bGAbjManBS
         5ijA==
X-Gm-Message-State: AOJu0YzibY6mm2o0ysCDjR+X7xYO9iHFh0EnXRSKqo9lSPrEdQXF9Tb7
	691WuV5azsGRHAlGPEBqYwPmPtqRRLRJPHBDZl+FJtQRXSki3BrW0nUFAg==
X-Gm-Gg: ASbGncsa3pHxW3Dt3lASeIRRuaKxmS9WhrSbhfKGT9I1teZBpAxfYOgqPxi55L4yHqk
	AJjS2SFJ1FZO1hDlTrAyBlnLY6u5tZMbh7q8EMEPERsDPFlQgnPDWqGTA1FpPDoq/cFKDZddtbo
	a3HV86xmkNrIUP/z590juCtV3R03IhdVTjF3vKy3BcVqFNBDlV/XpBR22Cm0xJ9dnggY7flWOS4
	MHqY3oaNAozCjWTnKSCbYWH9ny2xxrKRty2sgrP37ykOhQd1W+otetOk+BquZRLim2iLgBGw+dT
	9Mtfi0RdWzU15n2Z3S/ty8gD0SN7ZSs4+6OMjyclWK3cLw==
X-Google-Smtp-Source: AGHT+IH9omHcRGbqvN1HgSL51trii+iMaisxb1rRYTgmA7Rnce2BCHQw7PLSpUw4EyqlYxaV8HDmlA==
X-Received: by 2002:a05:6a00:809:b0:724:e75b:22d1 with SMTP id d2e1a72fcca58-7273cb7290cmr6090167b3a.16.1733830596863;
        Tue, 10 Dec 2024 03:36:36 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:36 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 3/8] t5548: refactor test cases by resetting upstream
Date: Tue, 10 Dec 2024 19:36:23 +0800
Message-Id: <db43ce7b75efab324ad5c348f70b851f841c9df0.1733830410.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
References: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com> <cover.1733830410.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor the test cases with the following changes:

 - Calling setup_upstream() to reset upstream after running each test
   case.

 - Change the initial branch tips of the workspace to reduce the branch
   setup operations in the workspace.

 - Reduced the two steps of setting up and cleaning up the pre-receive
   hook by moving the operations into the corresponding test case,

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5548-push-porcelain.sh | 149 +++++++++++++++++---------------------
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
2.47.0.rc1.21.g81e7bd6151

