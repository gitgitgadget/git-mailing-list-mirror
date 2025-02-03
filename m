Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1CA1D9A5F
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 06:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738564192; cv=none; b=MM47cKMU/7cE7caOrXbFQg/HUGVdWRtU/LPrGMzPC3Aq15PrXxlpGRQYE3UurXDgeHOt8pRdmnq3hBCzfjtpi1fJeV3+cIGWSGcVt5nMQFE5ESvj2ZcZdNUyS7qLZEZyE0GqUhsp5OZRq4n0iZiloV5TFYjXLaC3DpPWwPkYOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738564192; c=relaxed/simple;
	bh=NTOmsGM8xmN034R/UPQV0gYJu8kqrbRheaWavpkJevI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E8d+6OBds+bbtlCoz5ITv7nI+2XPfBMTHM2Hts6Lff1FlK0ZP23MR/LFgPvO4hNheUeXtMmLu8/gtGw+zVyDvj73HSQL8zIrRcZOd4XU9o1l92JOYwQBdXgkCkyx02Bnd+P13GPdaee4V0rCZBRotTAyC5QHG5FXO8Ge5CmZDus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rSp5fKWr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eFTK4qPp; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rSp5fKWr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eFTK4qPp"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 44981114017B;
	Mon,  3 Feb 2025 01:29:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 01:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738564188;
	 x=1738650588; bh=FxTLHu39iEYz0gDNNkWfppY6SFkGG4ioxu7UuR1iL0w=; b=
	rSp5fKWr4WlUAeTRl2NDiRrdS9t8cdvVbxA5CmjWVKdIvcJ4t4qBf94zum8Dyqfd
	QfUKO87D0A29ruZ/k57JZEzSefz9AuZxcmpIML4L3cSd9rQR5vj1LxmBeNwBbHF8
	A7a/s4gIaurEIuoMVAZPGXckppNZ7rrfP1IL9er4HhhRc8sQNhTaKhLfgvvRx3Pi
	rEHsb1X/zWA5qJRQwMguMg0RTeg7BsRJesimTe77RNB30tkRiCEtEGIJwxdp9MuF
	5OWgdHUVgnXCXUgur8Z87zjohAPu/qsA5smsF6t/Ddv+4kjDJy9mVB8QLZ7Egb1j
	3sV3nDzSo/bblgYFhPj81g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738564188; x=
	1738650588; bh=FxTLHu39iEYz0gDNNkWfppY6SFkGG4ioxu7UuR1iL0w=; b=e
	FTK4qPpSuMR/Bh25wNdLxq9jVNF8xdOFHUjaYsQRk1CzW5K6yqpliNB3E2eFbWc/
	ueBXk71XSlhznYYQUg1Oz5KzXOc1uVJhKKhg6cEZ33/TUWRF8ZpxUeWmJX+Rkm9A
	x40l+OwIVcz5cSglAcGlnMs9zSQwY6lcOBIj/DMAXUjy6iy9qEsnNYNCJ0qf8XGx
	98dv0QRoG8FRnXE62ufs1Kg7VY3WpLyIwlM10KC0JjNsXzXaArg0GH8p2O4KPots
	9pe7i5s/oJvwLl/guIgYFogVY7Bc/jASnPpEaJvW5/h9eiPGeK9QrNB5zjSXV+gR
	I4TdGFO1TKbujhBjYbEjA==
X-ME-Sender: <xms:XGKgZzv7NyoEBWAe-XvKLCqm-XXSKXXAGbixV_hCmMQMnL47H1VxfA>
    <xme:XGKgZ0cW51FsxqnnsSSu1gHbQ8bHvt3mty8u3lrnVxn6Rq6i9Wcu2Khwsxk9r4Mok
    4Hvj3LzmPTpqrbc9w>
X-ME-Received: <xmr:XGKgZ2yePJBQV-T_B5MgLhUH4yg7uYYEf3COzEo6cRleo0RwGxvPFjsF1M_oipOhvZBus1PV-_Hgjj4vHCFllR65pkZvMVMlwsl7UOz9NvliIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdejteetffehjeevledvffffffevhfffieejffel
    iefghfevieegffdvhedtkedunecuffhomhgrihhnpehhthhtphgurdhshhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuh
    hnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepiihhihihohhu
    rdhjgiesrghlihgsrggsrgdqihhntgdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:XGKgZyPol9j9DKBsH4enw_0RYH3SChn-7wC3dwwosnWEoylvKFy9Wg>
    <xmx:XGKgZz8NxUnQo3HMrsVCCPcQv6KY-_RbwYXpyeCScyNiPLIX54wYQQ>
    <xmx:XGKgZyXax8tGwD4hmQ68NdESoPlPUp1tCrkv-bVkWlVgdi5vx1tcBQ>
    <xmx:XGKgZ0exzvSpXAPJm4qR43aSUjOeDqW7TiYSaV-j2gQqJEA_XFvA5w>
    <xmx:XGKgZ_aB9Pv6tQnzJsVHftrmfefwRTqnM43OFCsseEe4xIP164tgGxPH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 01:29:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 393ca998 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 06:29:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 07:29:35 +0100
Subject: [PATCH v5 5/8] t5548: add porcelain push test cases for dry-run
 mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-push-atomic-respect-exit-code-v5-5-d66481e36622@pks.im>
References: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
In-Reply-To: <20250203-pks-push-atomic-respect-exit-code-v5-0-d66481e36622@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

New dry-run test cases:

 - git push --porcelain --dry-run
 - git push --porcelain --dry-run --force
 - git push --porcelain --dry-run --atomic
 - git push --porcelain --dry-run --atomic --force

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5548-push-porcelain.sh | 153 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index 5d724145d2..4c19404ebe 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -336,10 +336,159 @@ run_git_push_porcelain_output_test() {
 	'
 }
 
+run_git_push_dry_run_porcelain_output_test() {
+	case $1 in
+	http)
+		PROTOCOL="HTTP protocol"
+		URL_PREFIX="http://.*"
+		;;
+	file)
+		PROTOCOL="builtin protocol"
+		URL_PREFIX=".*"
+		;;
+	esac
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run origin \
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
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --force origin \
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
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --atomic ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run --atomic origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[rejected] (atomic push failed)
+		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success ".. git-push --porcelain --dry-run --atomic --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --atomic --force origin \
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
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+}
+
 setup_upstream_and_workbench upstream.git
 
 run_git_push_porcelain_output_test file
 
+setup_upstream_and_workbench upstream.git
+
+run_git_push_dry_run_porcelain_output_test file
+
 ROOT_PATH="$PWD"
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
@@ -351,4 +500,8 @@ setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
 
 run_git_push_porcelain_output_test http
 
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
+run_git_push_dry_run_porcelain_output_test http
+
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

