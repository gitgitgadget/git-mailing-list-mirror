Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF871E3779
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502906; cv=none; b=dzSIrJZ7DRBhJ1cck9Jwi6eudzvhTNPftwI6AFQNw4Tr/6+6EvMTZ1IwLyXNm6WD/1xrmyII9oxVte4+Z68jPCASECgEFkQ9UqSukGHxBe8RDZLum+87DNIKIpBJOrblerGcea69QNtUI2SoEJYr211TgJWv4y6bgPySu/CCkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502906; c=relaxed/simple;
	bh=C0vImniftHXXcujP3r/ygtW/0eYEl/2J2LdrOLKWGh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u63OUdYGQGa7CO3LwSIhzQmJjsxhrRJP3mbTREkq+DMqr0eFpoyddKqApf4DaJ+L3C3r2u+9eufIsyXmG4h0gqZEc4sINVbQ5ShVV/e/OZPL4RtcyegTrDKgQHPjfydVzTydHDd1MMeOknoc6VO8bUQAKEA14coAD0Wi/3sQA+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yg/QF9T4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffAO+YCY; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yg/QF9T4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffAO+YCY"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 39E7313800E9;
	Mon, 21 Oct 2024 05:28:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 05:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502904; x=1729589304; bh=7vdSWX9ttL
	OB6AAUP8Fl5GjrCSvMpr3ijM46+/B15YA=; b=Yg/QF9T4fg0GrdvdQkaMqHuA1O
	5D5hVGbdm3Mv3eh5E/1DUIOfz/l7W4LNoaAyxWhj8zYVVaMECKgblplfJ5NS/Fos
	nao+FjX1leKcmfuvvjjDN26G70TALHMGB5eot5vePrsbpdy6Pz03yauPmpnLHays
	uNe4qCkGgLjHRb1BHXzCO9T3xQn4OVvZZrX1vKRhgZ8+gZ7nVcT7Jt4YRQkTd9cD
	XlgGgdcHunoUCLCiRjGnxf/F4V2SITwxdbPR+yyIH+EV2PnsLsitXXL62SewbMNQ
	ZkVvUMMb8bDWc5M667emJifDlg2xaZKI6o3vGC8RSBpu6fKRGo9n7quFsDeg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502904; x=1729589304; bh=7vdSWX9ttLOB6AAUP8Fl5GjrCSvM
	pr3ijM46+/B15YA=; b=ffAO+YCY+kj453wwF3Sc8CUKmXAhDLxtkgYcYwQR9+24
	fajUDKL9ifdshmNTATDNOdeDjDS76AelI3eTwHDRElaXEF1RFDICIS5RKtFUNX8J
	dr9naEFS+8Vx5R8/afqtY9fd0fO9ncJJIudKpM3NqT5hDdQXA+aisVsHZnn8QNFY
	PXcExvealcccXq6Cxqwas/oGTGtrPewC62/Bqz4XokbkivFYXf9hOP6qvXwdNImF
	jT11T+u3hHeTpMNGjRnjReHW2MMoDpZkwTXeWyS+29tOudFrsGJYimrlcBCLamw9
	pUyBpZf9a5k+jKs4dvjIL4a/WKQYw/WbofD+w5aoPg==
X-ME-Sender: <xms:uB4WZ7L7INjZaKIKw9z9Mqvp_3T6-R9lHkpbbj_3UVI9y3KZvtOLzQ>
    <xme:uB4WZ_IyO1QYAYv5z45UHMujMeLs5pyXlJOLRO0-wCJ7xNjq-MJR4b02CoaD-I0sV
    n7elf5_sE0PrDyYLQ>
X-ME-Received: <xmr:uB4WZzt1ctebOXcV6jKPFY3DzNTLPQw3fswPTmTsKmBgL2oZAzYpMYBqauR8COa7hpEaQkPeDsWm7UochGOjiFtEnvtkQ-DxbGJx_OkSATar>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:uB4WZ0ZYVhLwtJ93WYe7b1cuKnwsveo_DRfc8cXDZV9EJPTLafOz8g>
    <xmx:uB4WZyY-3rKSnLcc1XQSVBJ8x7DzFRpCbjjjHbSbxfwGOQURNbS9zw>
    <xmx:uB4WZ4A2ZZTRbCToYsrBGu7unCCjLDj-YJWchK0bUmg6DuXwKkQc0Q>
    <xmx:uB4WZwbGrM5NzUPUDjmE3uQHS74EwGJGPOYk-u5vwfuQae4WXSX4eQ>
    <xmx:uB4WZyHsDUQTW_P5nY5WacIqpHGKihys6ujTKG7NqE2Zo52uGJgKVxEJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:28:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2396e0f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:26:56 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:28:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 07/22] pretty: clear signature check
Message-ID: <5d5f6867f918460001f62aaa78f24cf3cbe53a3c.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

The signature check in of the formatting context is never getting
released. Fix this to plug the resulting memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c                         | 1 +
 t/t4202-log.sh                   | 1 +
 t/t7031-verify-tag-signed-ssh.sh | 1 +
 t/t7510-signed-commit.sh         | 1 +
 t/t7528-signed-commit-ssh.sh     | 1 +
 5 files changed, 5 insertions(+)

diff --git a/pretty.c b/pretty.c
index 6403e268900..098378720a4 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2032,6 +2032,7 @@ void repo_format_commit_message(struct repository *r,
 
 	free(context.commit_encoding);
 	repo_unuse_commit_buffer(r, commit, context.message);
+	signature_check_clear(&context.signature_check);
 }
 
 static void pp_header(struct pretty_print_context *pp,
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 51f7beb59f8..35bec4089a3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -5,6 +5,7 @@ test_description='git log'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 . "$TEST_DIRECTORY/lib-terminal.sh"
diff --git a/t/t7031-verify-tag-signed-ssh.sh b/t/t7031-verify-tag-signed-ssh.sh
index 20913b37134..2ee62c07293 100755
--- a/t/t7031-verify-tag-signed-ssh.sh
+++ b/t/t7031-verify-tag-signed-ssh.sh
@@ -4,6 +4,7 @@ test_description='signed tag tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 0d2dd29fe6a..eb229082e40 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -4,6 +4,7 @@ test_description='signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
index 065f7806362..68e18856b66 100755
--- a/t/t7528-signed-commit-ssh.sh
+++ b/t/t7528-signed-commit-ssh.sh
@@ -4,6 +4,7 @@ test_description='ssh signed commit tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY/lib-gpg.sh"
-- 
2.47.0.72.gef8ce8f3d4.dirty

