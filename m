Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A446E210F7F
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 11:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733830600; cv=none; b=bG2SASyNdD6Q5dU1t2eBz10O77N8muuCY4FMs7SnH680A7qDj2vM8ptNaoUgRsbc1zRJ95b2U9W/GkJtib0392ajeEaLPeYiRwYoCtp5hURYPVxlmJs5oSYprnZXc4tQdbE03Emcp9tn3Js6jA3PBdGs0EDS2BHb6+yxJ34qu8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733830600; c=relaxed/simple;
	bh=M8bV1CIlGHkSFEO0Am6Mp7hHFijEVzMy+ymwyThmHpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DEwN+RIh2NqhCmvUVQYADMJp2ANSdR7sbnFAVtin4OcqWr1c1xh9CCQqxv3qpnxjp8bM/YKM/4dYRUlh5S6JW4+VqJG8ILhJcPitacz3tqAVVo0mJrjoKynzMu0UFUXFAfUOJYYtNyKqFMTy5ZH2oaf6BCLUjjSXiFnToBzqGSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxdzutFJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxdzutFJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-725ee6f56b4so1741755b3a.3
        for <git@vger.kernel.org>; Tue, 10 Dec 2024 03:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733830598; x=1734435398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMz+P7c9fNk1zlAalcvH/pjmfqrBeaOCLQfZlN8gH34=;
        b=RxdzutFJcMYbDgih+Tnke/ZSnwNixFHOtDRQ0qlhf+qKqNPwgpNvXIoV9pk5B4rpB8
         ABGBxXG+WHY8bCp37PKSRbLKMbz7fX94t6r9Tbiihk9GxIAklrnWLTLxXv2PkFLBYhvZ
         QnwNMm0zjJ5kRlMvZ3sz6lF889RgcRT5GdexWScAmki+ozP2nd7E5FIN/47usYp32gdi
         Sybaz+Hma7rpG2HMxjMEM/S7Ax1wwsDgAq1PdU+/e2o+zTEMxBdVEUBYJLWNmQHRSlR0
         ruoDHQppS3f6nvZZwncRNARhgrkxW9/KprwliZ7QJG7PZ9UCvJgE1Z5vrnExjFUDlWbW
         eb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733830598; x=1734435398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zMz+P7c9fNk1zlAalcvH/pjmfqrBeaOCLQfZlN8gH34=;
        b=mSZLZZK7iUuUF9A/pX8L+hh8xFtmZiAYmH3pFXHMr1MyZ6igLty5qSYUjiKUjVthN6
         I+xYVbeeQSC/L8Jj4CWs5HowbNxoYBFtgzLD3MH1cJlNHtihd2V9/89KrTeHoJaJkUTW
         SBoPtEzQQDinpk8LDu5eE1+TTJf1olc8zFe/ARMH78wWn3KK1XkqfHhxzeg5zO+k57QV
         xg2ZSFVoGkuV68366tkwOdomZ+VEPuEW7eFozJQU8NUXuGW0WleKYaaBBGf1zm4GllaQ
         Hk5uqtG+58+DR7HjYqwbcUTw5+SDZZY82Gt4z+JAyYaD8xo7De/RXLRELQPvNQ9/y6f/
         czPg==
X-Gm-Message-State: AOJu0YyV95ORdhSQVfl/SwvZsJR1nCeCKakZaww5i1Lv9NbwyxVwv5xg
	tZEXeHeRSKtYX5zQ1A3GtXJsBDYh6CPo7KswHhUy1kGhRVRqmb291Xz4xg==
X-Gm-Gg: ASbGncu2dxXqFpTBtwdqG0/HVZtRo2SUGa/xGhKLB4pMdWbv6UGGzUtOW2zyDQK9zLz
	sjjm8MHQs7juzgrOUadYx3B9t+dcTk9NyPx02gbMrNxnqNTwiUZtx3IC+cbgc+pzNSDWn8771Fv
	MA+c3EUHAOOyEs93lr3xgVN8x9orbtxP6D+djqdZWWDTn7nvq9MznuFp8mfWYI5GNMF4pIDSVGj
	aG9Om/d54ExTPj9SY2zadvHmeVfcSslSU0syGMmMY3B9gLOGMJE1ngJv+7iI9H3d3Z5Kc86MHJO
	y4FMjSIFDihijyrdY2T4euFAqBpWXnKOwENQy037hN8p1A==
X-Google-Smtp-Source: AGHT+IH21tFgZuP4/eCVPT76AKFRIQicVQSTM50Grr0JBVEa2EQbLoJIwmoQrompHBC4QNa1eHJ2VQ==
X-Received: by 2002:a05:6a20:c78c:b0:1e0:d848:9e83 with SMTP id adf61e73a8af0-1e1870cc3c8mr28095204637.25.1733830597756;
        Tue, 10 Dec 2024 03:36:37 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd54aa2399sm2554532a12.39.2024.12.10.03.36.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 03:36:37 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 4/8] t5548: add new porcelain test cases
Date: Tue, 10 Dec 2024 19:36:24 +0800
Message-Id: <26248735e1b81df8d34cb692ddd9d5fb55e22329.1733830410.git.zhiyou.jx@alibaba-inc.com>
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

Change order of test cases and add new test cases:

 - git push --porcelain                  # failed: non-fast-forward
 - git push --porcelain --force
 - git push --porcelain --atomic         # failed: non-fast-forward
 - git push --porcelain --atomic --force
 - git push --porcelain --force          # failed: pre-receive declined

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5548-push-porcelain.sh | 90 ++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 25 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ededd8edb9..799f6066a3 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,6 +4,9 @@
 #
 test_description='Test git push porcelain output'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 . ./test-lib.sh
 
 # Create commits in <repo> and assign each commit's oid to shell variables
@@ -132,6 +135,40 @@ run_git_push_porcelain_output_test() {
 		;;
 	esac
 
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
+		test_must_fail git -C workbench push --porcelain origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-B> refs/heads/main
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
+
 	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
@@ -203,13 +240,9 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
-	test_expect_success ".. pre-receive hook declined ($PROTOCOL)" '
-		test_when_finished "rm -f \"$upstream/hooks/pre-receive\" &&
-			setup_upstream \"$upstream\"" &&
-		test_hook --setup -C "$upstream" pre-receive <<-EOF &&
-			exit 1
-		EOF
-		test_must_fail git -C workbench push --porcelain --force origin \
+	test_expect_success ".. git push --porcelain --atomic --force ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
+		git -C workbench push --porcelain --atomic --force origin \
 			main \
 			:refs/heads/foo \
 			$B:bar \
@@ -219,10 +252,10 @@ run_git_push_porcelain_output_test() {
 		format_and_save_expect <<-EOF &&
 		> To <URL/of/upstream.git>
 		> =	refs/heads/baz:refs/heads/baz	[up to date]
-		> !	<COMMIT-B>:refs/heads/bar	[remote rejected] (pre-receive hook declined)
-		> !	:refs/heads/foo	[remote rejected] (pre-receive hook declined)
-		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
-		> !	refs/heads/next:refs/heads/next	[remote rejected] (pre-receive hook declined)
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
 		> Done
 		EOF
 		test_cmp expect actual &&
@@ -230,29 +263,37 @@ run_git_push_porcelain_output_test() {
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
-		<COMMIT-A> refs/heads/bar
+		<COMMIT-B> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/foo
-		<COMMIT-B> refs/heads/main
+		<COMMIT-A> refs/heads/main
+		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
 	'
 
 	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
 	# Refs of workbench: main(A)                  baz(A)  next(A)
-	# git-push         : main(A)                          next(A)
-	test_expect_success ".. non-fastforward push ($PROTOCOL)" '
-		(
-			cd workbench &&
-			test_must_fail git push --porcelain origin \
-				main \
-				next
-		) >out &&
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. pre-receive hook declined ($PROTOCOL)" '
+		test_when_finished "rm -f \"$upstream/hooks/pre-receive\" &&
+			setup_upstream \"$upstream\"" &&
+		test_hook --setup -C "$upstream" pre-receive <<-EOF &&
+			exit 1
+		EOF
+		test_must_fail git -C workbench push --porcelain --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
 		> To <URL/of/upstream.git>
-		> *	refs/heads/next:refs/heads/next	[new branch]
-		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[remote rejected] (pre-receive hook declined)
+		> !	:refs/heads/foo	[remote rejected] (pre-receive hook declined)
+		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
+		> !	refs/heads/next:refs/heads/next	[remote rejected] (pre-receive hook declined)
 		> Done
 		EOF
 		test_cmp expect actual &&
@@ -264,7 +305,6 @@ run_git_push_porcelain_output_test() {
 		<COMMIT-A> refs/heads/baz
 		<COMMIT-A> refs/heads/foo
 		<COMMIT-B> refs/heads/main
-		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
 	'
-- 
2.47.0.rc1.21.g81e7bd6151

