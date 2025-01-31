Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8340C1B6D1B
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320817; cv=none; b=aWNWTzpEhEqg+5mbOdq8HR/fN+G3c9S4PFYrwE4gHWIN8nmJ727JdC4TjjmrqcOIB3jmmXbAs8SaoSeIprCED7MXx0ctg3fZRpG6GA6P2ltGK/2Jlz4NSHXo9rYF1hGngLYPr+hM8dx7/E03re3O78tQ7HMZiTL7RNLR47pK9TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320817; c=relaxed/simple;
	bh=u3f+6I6r2DTl81Wnq/zztSHiuFm3592QvyK2t/HrwE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sZgT2dIdITh0Tu2nGJIyeq+/NLaluU1FsVs/K+rlMopPE6TSq71QfebCGGyucJ7YsmtEKJ4WVK0DNVL4rWg1SZnPpUZI9xPi18KJ1U14MAI7UNrMnZvI6md11c0Hv/0pX7q7lqVKa+hfAlV1jwmptC4rcAWn5qnjyExlSYJnjag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Laos1QxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VnQ6u+2W; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Laos1QxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VnQ6u+2W"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8CA3613801B7;
	Fri, 31 Jan 2025 05:53:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 31 Jan 2025 05:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320814;
	 x=1738407214; bh=uruxXdZwC0GLLPwQWwThl4IPR9cIs7hrndedBKpmKdQ=; b=
	Laos1QxOWdmIzS3pMWwYcU5wjzKvtfEVRUB5qWKlgac/eIeH6DZX+Qu2lTdEfMik
	mIi89HMAFeEEV0lLYpMBgwvsWkAK0Vqt+5+JtFThNQIWz3zus1DOSpUpNyvnrwA6
	CdBL7AO4oJobCcNW5Dy7VBPK0Lzqr9NUXkbzJ4W7ZumEg6BURU59EKYxf9xWtgZt
	OzOcpTCGVjhSwUSxze3fj5Ny5JB+w/14iSw8L8DxH0WUg5MTexiFdPzvI8xgyMun
	4wG4t2EVFfZJruMF44CSNKfz2dJuv8cajltW50YltcPVsYqU9Rl7UzFJAl9JTOKj
	4EKkq7glc+YdiI1BJsNedA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320814; x=
	1738407214; bh=uruxXdZwC0GLLPwQWwThl4IPR9cIs7hrndedBKpmKdQ=; b=V
	nQ6u+2WtTtSK3cc0Buvt9LiB/ozA/o5FAyHJp84UPtHocfSwAVpMfwg7/U/UFVDN
	VVq3mbL1vOFwInTTsBbPIGoH9QXrYVNceEWVjffu5kDLxNhtESuHiMM66bc5xmiF
	xucAbRVB9RuDMz3IClyo/Itwnnr81Gb+U/LR/g/L0706R/nzqdAZN7MdMeU45zoU
	XD6e4ql8rLbxvqZVZLAm8CXqo1eNVQKeQV/SSyJ5T/hjIFgUOC0SE0A1bY1QPhU6
	KQAtbQktwoMvnvJME/riCoRt/w9sdiqOPLWP6fSnemen58vsKe4tG7bqBbfkrg6N
	NYQD7kHJQCNP4GAsQ8Idw==
X-ME-Sender: <xms:rqucZ1UKmJYtq-qD32kFulnJ3rg1LQcd_FTTpKq-b3jEA9DM_DfZ3w>
    <xme:rqucZ1ngVjx4HxnQ6uSGj-9Aa5ocVAf_TXQYq0cqrP_3i8bb91AB_N2z52_AcfRM8
    th94JjUfW7LYc2O6A>
X-ME-Received: <xmr:rqucZxbU-bUS9B0wwtga1AZ3C6_5THMaIFf-TswI9z4-uUMew7GqiIb922eL4WmnpAqInhJzhB9BfepiyK520wtIX1X1B2xuN_jT07x2QEVPJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:rqucZ4V9Fs1j9ns-xYh0WDfmVoxRO8vSCG8ubUiChBD2LDRVzRN5LQ>
    <xmx:rqucZ_mzONBcDq0WpACkO39FHcowWJ9fgIWAOuu_fgXfyC61N9tqCA>
    <xmx:rqucZ1fzSPInG_yLjAPTtLu3py5Tfowk6cOG-UFWw6DeRxvVBu32Vg>
    <xmx:rqucZ5FXgey7Sf_nAg2LqwMgsXhIUsdPvsQ7u66P3t9OLS0W8zu2bg>
    <xmx:rqucZ9jMxaTMKhmV5S84CARZOC2o4vDgc3Tvoc6a2CsjMRJy5fUYr62g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6177aaf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:28 +0100
Subject: [PATCH v4 4/8] t5548: add new porcelain test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-4-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Add two more test cases exercising git-push(1) with `--procelain`, one
exercising a non-atomic and one exercising an atomic push.

Based-on-patch-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ededd8edb9..b510a2e6bb 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -132,6 +132,40 @@ run_git_push_porcelain_output_test() {
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
@@ -242,6 +276,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)                          next(A)
 	test_expect_success ".. non-fastforward push ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
 		(
 			cd workbench &&
 			test_must_fail git push --porcelain origin \
@@ -268,6 +303,39 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual
 	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git push --porcelain --atomic --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --atomic --force origin \
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
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/main
+		<COMMIT-A> refs/heads/next
+		EOF
+		test_cmp expect actual
+	'
 }
 
 setup_upstream_and_workbench upstream.git

-- 
2.48.1.502.g6dc24dfdaf.dirty

