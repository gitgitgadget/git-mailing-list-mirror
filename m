Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002621B6D1F
	for <git@vger.kernel.org>; Fri, 31 Jan 2025 10:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738320817; cv=none; b=LitX7RQ7XQmgd1FlA8uiTA/9ErOTjUIzIv631IFo+v4m8RAMlxZ7vrVxJgk/VJRK+7bzKZrImF1bkmT6ZRNEm6Dfq64y3YPfJKCbouF9ktBSy498bPVhueM47wgNgm35NzIsv5osk6YHCDLyAUv1EdNOk2ED+HfPjpLvPaV9ksw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738320817; c=relaxed/simple;
	bh=BxaGaNwMPyqbN2YVWW94P7YOFwIHStEaIPI/RRWhDPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BmNOMXYVSjGTAas/FLDPW8Qcb2U2F217lM2ZgorvdaJA0u/xCWC+/Uk6LV8DYfNelCWVMP4EHPBjB4ejwrA/PJFv7N81Eqq5OsC1ihCaaz1b8PoJj6FhkSnL2SPCwF10VIPVI6GILMNR/XeuoNyM3FFArsVB3HGV3AgWX5KCvSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RTi6NUh7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zSoQBNT0; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RTi6NUh7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zSoQBNT0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030E71140107;
	Fri, 31 Jan 2025 05:53:35 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 31 Jan 2025 05:53:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738320814;
	 x=1738407214; bh=dWeYN1qxvt6KYhDtZdynsaIVCK26iXI8noqfCnSrcvw=; b=
	RTi6NUh7Khru6Rfz8Qx0P6V7064tAcDNL8eIcd8aYweJTJ7RFYB2XdMySd41YbK6
	U7BTxTfDEakyH/ImZs2qRwa8hPr8wE5XUzi1/orohahYC4GzIk/ygEhEgZeU5yrG
	MxY7Mdwj1EufX9TMWOWPbubOY45OYNg1z18l9zKfYGPJ2XIhXHUFwdzJYE5zgHX/
	xifaG6tbMO7yfRQz5a7M9jdA3OFpkY1RZDqN5eP6gMm3OtTehPAR4BrIwdK9UE6W
	9migk/DRiF5rehKr5poZd5FlTcTuUbS/6cmpQCYboyL0+AK8AipEuTTeam6LqnQ2
	797H6gQo3gk9YmEYOEDeOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738320814; x=
	1738407214; bh=dWeYN1qxvt6KYhDtZdynsaIVCK26iXI8noqfCnSrcvw=; b=z
	SoQBNT0cSUjzDt2QbpyxswT87FCdQwmOUA6pr3aRlBOeDYHzdMzHUjm/BQJmRIEA
	NsOMrAeyKZ+0Wd8ytk6yzGJ/na+kbUDFkUE930U74vYlHWpEcNesocj0LlWWTMN8
	d7M45JYQEssoXZ3rdIPtfOJ3eROFFfKu0GQi2t8mLoN8Aoyou+8NXCY2HaguUc6a
	2qns6J6lIt27vExNJnhQAHEvXOmwpDpCyBDsci1iC0Q/6vGUvGTmWa6+TMBI8Ek7
	ol30FabrxUl6A3XwAem8Dv56xISHSMdbDfcWAUyMIOzgoqHmWr3pdofgaNa263fN
	b/CR3jL/yDFrV1WRcAC5w==
X-ME-Sender: <xms:rqucZ3Li_BwfYl37nBMfcpliDuCJp1KnNwwdBgN7tLWywIcvqEGDKA>
    <xme:rqucZ7LyLHD40AiNFBBIhUwZT8v-w57sULpKhLPyT9OrxfInf--ENwSlD3chkos-b
    WypNcx3jFuH42RoZg>
X-ME-Received: <xmr:rqucZ_uZpzRY4tLENsbVUCj4ZIm5Q2dzNL99dZvQamCXMDdMwFrdUZ3kDsCRQ5Lb9CPPIYfQ4-LOsnmdpcCe57IC_44OIfS-dpfRlCEJneaBYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdejteetff
    ehjeevledvffffffevhfffieejffeliefghfevieegffdvhedtkedunecuffhomhgrihhn
    pehhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepiihhihihohhurdhjgiesrghlihgsrggsrgdqihhntgdrtghomhdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rqucZwZ---FC8xV9k73-kjVd2Wa7bR_5WlioP3rxVz5MEVPiBZ3iYw>
    <xmx:rqucZ-bQGcncpGjKyqhrP83KsaeuvKB7Lv3JjBjWQ9w3wiy16bcvzw>
    <xmx:rqucZ0Aym1qmtT2KsUAyWIOwY47dpky8Ea2YGW8zp5wZJDCy09rHDg>
    <xmx:rqucZ8Z210iwVnA39aWfCh4SlF-cC2rDp7N00XA9Pet_E4zxu_iUCg>
    <xmx:rqucZ-GfH_tCZ8OE0HoZP2iYrCmm7XuUvnzHkay7PvrAtHTj_uiUV7H7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jan 2025 05:53:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3437fe41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 31 Jan 2025 10:53:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Jan 2025 11:53:29 +0100
Subject: [PATCH v4 5/8] t5548: add porcelain push test cases for dry-run
 mode
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250131-pks-push-atomic-respect-exit-code-v4-5-a8b41f01a676@pks.im>
References: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
In-Reply-To: <20250131-pks-push-atomic-respect-exit-code-v4-0-a8b41f01a676@pks.im>
To: git@vger.kernel.org
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>, 
 Junio C Hamano <gitster@pobox.com>
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
index b510a2e6bb..c20e4ddc01 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -338,10 +338,159 @@ run_git_push_porcelain_output_test() {
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
@@ -353,4 +502,8 @@ setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
 
 run_git_push_porcelain_output_test http
 
+setup_upstream_and_workbench "$HTTPD_DOCUMENT_ROOT_PATH/upstream.git"
+
+run_git_push_dry_run_porcelain_output_test http
+
 test_done

-- 
2.48.1.502.g6dc24dfdaf.dirty

