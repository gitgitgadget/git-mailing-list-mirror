Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1301D9A54
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564190; cv=none; b=a5SvRjvBsuXG7vJUBAqY+FUWkTEvv/wpssc7l2PvVS+7/uTJUQwVZ5LNWq8d9MPlDyZd8kaLQ+BuftwTib5k7YrMS3x3yAdnus8VlK6piDJIr0nUAXPseGBp26VOmeyZLdF9qvwwZwpTigrwLJLy8i8bcbiUr7vurtZmStNEnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564190; c=relaxed/simple;
	bh=FK+JBySU+E4cF1jULUXIRPkz1yRdw0jWDSSY7Gc/CWI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQCl4RULeeizgU+/CbAbPnf+xB3O1WYwdLR3vvinwYcoF3SMlk8dqa+oOOO6C6vqCT67OYs93tIjUwOxy0q91vs7p3F53tDsuHdwRSh1cr4M4vN6yvVytoOnavfTuMBXPd8MOGsrE+V7mamFnqBjBwJyBG5sXRmx6L0Zx3zhBbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RfxPSRZw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEWF29K/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RfxPSRZw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEWF29K/"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 27AAD114017A;
	Mon,  3 Feb 2025 01:29:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 01:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564188;
	 x=1738650588; bh=fAt7v//KG7U43weF+K6vSqkstjXvLbyLNtEAxS0OY+4=; b=
	RfxPSRZwS/ZkpQAI1ucRnT3k6BGvVFEga2gasI7Ajlzxl8LY7cLd9FZStEa0ZHIr
	U0fXKs91DDMkGr2TZd5w9B4tLcLI3n1b2UYvO2gp6PIz0GFSQqUSaSs2+j4cezfE
	5OGK2A4Zfc8ttSENkwXwcXxZNzEEzVuqkldx71agAdqjImUq/H72vIhJfUBK5ChJ
	PMFJIHkn9W6vl9pK1ECrispFvPdnl9gNUWEeT/DBoStWrhuHPkffXi6c25A3zA+9
	/J83ERaN5D/w/ogtPRYY0uQKHa+5cZdKaphYjJTjFAMXEM20zCVcVB+QsmRyuaM5
	JNKe79X14kVV/yEYw6aimA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564188; x=
	1738650588; bh=fAt7v//KG7U43weF+K6vSqkstjXvLbyLNtEAxS0OY+4=; b=U
	EWF29K/edcoJQrm9lj20p4oj2mfs93GK1OjDHWnLVSsCSJpcsu6HimSXNzNnYhme
	Nktk1ivabUam6fzDfbc61lXJ9DpVNMlM9AY4gStHoBtwWnWUv+F+ffmG26T1IUJF
	sgS9LPE6CgjW9vB3N/dsglFG0W1+mmhP5tTeJHqNwyjSWdOFVjTHMZRh4BniZCFR
	yLipv9I0WLhoBlajWO0fVmwIJDbglC3aCZMIHgcBVEEjg45Z485u1Raabfd7f6Rr
	GHtDAGS+/n1MDay6BPF+BjMf9LdtK5O2kLmPRwtsiLSdoFHeCIyhcwJE1aLbVQQZ
	Uui4z5gi6XEtT9kf2I5Jw==
X-ME-Sender: <xms:XGKgZ2DzRjbfn5VJCc6dfZjXiBgo_UpI6dM4Nd_NqtxiUVDfJkoJrw>
    <xme:XGKgZwj8U78eeyu_TCtx_ZZGVNBJOURfrEw7yRGhzXNaLAWGP4AKnM0dd2aiEw9jg
    iZe-O5oRcRew1NpQg>
X-ME-Received: <xmr:XGKgZ5nX8Sl_2baVER9-zGj87dfVIg-QyHh_fVqxv7JmlFkOjSUYT9L3KCiSNxSVbNrqyg02CtAPZsjg8YXB35_MlnSeETeIOoSLYwO5NCIXqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopeiihhhihihouh
    drjhigsegrlhhisggrsggrqdhinhgtrdgtohhm
X-ME-Proxy: <xmx:XGKgZ0yum9dummLvsPO9_QSFkmOQeB_a71CxWUEQnwiw_WjNkQc1VA>
    <xmx:XGKgZ7RCNX6y9ZmTbDyLsQ_6_SgjCImFdlnbnIR18JRNfiDr2vIdDQ>
    <xmx:XGKgZ_a6ca2uEFXR9SYtE4ffmBe7t-RLyuqCayz1e791F3UsyTeyYQ>
    <xmx:XGKgZ0QwyyidpAWy2j2SiX1nlbsg_yY3fzdTPnDPcDRx_bsr7CUtxA>
    <xmx:XGKgZ5MD8f_Y1TtoAfGPAVyZmMzlM0AfCSlu3bpThxiXlrwSts67foFr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f07915d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:34 +0100
Subject: [PATCH v5 4/8] t5548: add new porcelain test cases
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-4-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

Add two more test cases exercising git-push(1) with `--procelain`, one
exercising a non-atomic and one exercising an atomic push.

Based-on-patch-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 68 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index f9aeb5a9d9..5d724145d2 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -130,6 +130,40 @@ run_git_push_porcelain_output_test() {
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
+		format_and_save_expect <<-\EOF &&
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
@@ -240,6 +274,7 @@ run_git_push_porcelain_output_test() {
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)                          next(A)
 	test_expect_success ".. non-fastforward push ($PROTOCOL)" '
+		test_when_finished "setup_upstream \"$upstream\"" &&
 		(
 			cd workbench &&
 			test_must_fail git push --porcelain origin \
@@ -266,6 +301,39 @@ run_git_push_porcelain_output_test() {
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
+		format_and_save_expect <<-\EOF &&
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

