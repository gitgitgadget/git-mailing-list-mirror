Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAC11EE021
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254275; cv=none; b=MUROEtBP30yG41HAaiCHq6puC6VdzVCKQ053FDDeuC67GoKL6VGehwMdkNqk2uRHnFb3mgUrOkwFXDEuWTUg9oPXw8IifLXFi9EDDN3Rmj/uN1scHFfFKwQQaIj9gKs2Uu24OnusyGEE5MRETQXIAC3aCaM3Plf14SV40ctTLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254275; c=relaxed/simple;
	bh=7pramfWLmv4Ys56BhtQx6RrUF63xnFQRLeF7rcB0F+E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9pF1UOIO9iEUqWGpCF7rsU/MlBP6m2UcWAPzOoX447nmQ3iWOhwhxXKJ6IV/bCVekecNIWrbi+QFxzbvp+utLR7hkUEskBUiwO+zvcJNR4GvbwAV3e5O+08zPxoGoh3d0XMPynOSncjGp02Q4mCF4az9GE9vn39KQQHzaLyO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NFOrVUlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kPw1iG3E; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NFOrVUlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kPw1iG3E"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 96F401140102
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:31 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 30 Jan 2025 11:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738254271;
	 x=1738340671; bh=74R58twNDF/tT+P3ltzQ6Vtv5dHabjHLoygdBeWI2pI=; b=
	NFOrVUlzjm081TyDpVvC35KiUAH0oY3RkXeG23javbhQ+bUZ7WhT9QbKR98GE/NL
	7Mz5LofQ2fZM0nY9Ng71n1O1md1y6wsjCNcr8yseRfh9DpsgB12uAwD4R1ntItQE
	M9Hk3RO7bM2Btxk4ynXUAf6kyVs1ebsa2HFXFGIFDBy4cNhh3vJktD9eJZmyiJmz
	Q0A+VbNhMPsx5SUITnDOJm1RdBeBX2leTp2Xjx7Y2atEbRE4O/lpVsX8hXjBB6tr
	U1Aj1FRRUJp2pceJRe1zbKDLV4NZT3JcQOf8CafdxdSeq4KIbI+BgNtDqn5JAghq
	++m2rwoIcz31LU1mJBONBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738254271; x=
	1738340671; bh=74R58twNDF/tT+P3ltzQ6Vtv5dHabjHLoygdBeWI2pI=; b=k
	Pw1iG3EkF8BbsrFywpGCvBlVkQXvWQBmojZJ6yZqwPVwLjZVGlkaG7xy5/LtXzma
	SqgkO6HpTrEOf/joIT/tB3Ds0rTPCtglSpK4xSKdfwMZ4f4CMbu2GZgeMhE3lbVj
	/jtSDB5Dugfk0rZAXs7LHwUTRkv63ne/q2Sr67ZKjFlq6T3qgiI9hSDPkfr5DFKa
	eq9Rz3rp/2V+gQevlbZm8PpvNbNQvqRIZslkMh8toH1vp6LkV9VD7hzWq6x/D8W4
	DkACu0STk3MavCM1zaNV1gS6x+T18woDnG6JDnanye9p3GRoiXulCtRpyK0ZW6R5
	iBGSQ8p/Em3z0iHJ+MfBA==
X-ME-Sender: <xms:v6ebZ6QrzFYyCer_8sAuYVEmqQtitcqtqL9NHnZDiUnlK9qcaf5-Tg>
    <xme:v6ebZ_wISh9qkeeSSxtBdFKpt-yDkB1UlaHCyW1ouPR21PwvCLvmLrnJkXnisPGdh
    h_F3jFhGsu0GpSkHA>
X-ME-Received: <xmr:v6ebZ32TSJ5Vs_sL2_Aw0QWIaV24osuR4lEGsw2DeLOoK4Obx7nFQjaB-C2s4Dq8cWQXbRV74G651Ix-2ad3yzlTbmoJ0tJ3I1wN71f89PTJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v6ebZ2CGiDvdiXKkCUEaxX42ZdCyM_QoYSic7BMFkFPC37qTaiuJZw>
    <xmx:v6ebZzg7n14tK1AoGUmj35B7cU8vTCA8OuAGP1tnZ5lFXBxPBF0f8g>
    <xmx:v6ebZyojhwE0lGzQzZUtUH5v6UHw2_OCKeY7M_xog4USIIaGaBaLfA>
    <xmx:v6ebZ2hGd1lI0O_Rnr_a66mkURr6jNC1wI1SniJ3ZkCcWWPX9RTPSA>
    <xmx:v6ebZ7b9RZ8BRVxEbgaXZ_2-x8JJ3_O30twKotNP2zsvlw77kkverskY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b830ed92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 30 Jan 2025 16:24:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 17:24:18 +0100
Subject: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The GIT_DEFAULT_REF_FORMAT environment variable can be set to influence
the default ref format that new repostiories shall be initialized with.
While this is the expected behaviour when creating a new repository, it
is not when reinitializing a repository: we should retain the ref format
currently used by it in that case.

This doesn't work correctly right now:

    $ git init --ref-format=files repo
    Initialized empty Git repository in /tmp/repo/.git/
    $ GIT_DEFAULT_REF_FORMAT=reftable git init repo
    fatal: could not open '/tmp/repo/.git/refs/heads' for writing: Is a directory

Instead of retaining the current ref format, the reinitialization tries
to reinitialize the repository with the different format. This action
fails when git-init(1) tries to write the ".git/refs/heads" stub, which
in the context of the reftable backend is always written as a file so
that we can detect clients which inadvertently try to access the repo
with the wrong ref format. Seems like the protection mechanism works for
this case, as well.

Fix the issue by ignoring the environment variable in case the repo has
already been initialized with a ref storage format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         | 4 +++-
 t/t0001-init.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 8a488f3e7c..53ffeabc5b 100644
--- a/setup.c
+++ b/setup.c
@@ -2534,7 +2534,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		ref_format = ref_storage_format_by_name(env);
 		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), env);
-		repo_fmt->ref_storage_format = ref_format;
+		if (repo_fmt->version < 0 ||
+		    repo_fmt->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN)
+			repo_fmt->ref_storage_format = ref_format;
 	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
 		repo_fmt->ref_storage_format = cfg.ref_format;
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 213d5984b1..6dff8b75f1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -697,6 +697,15 @@ do
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "reinit repository with GIT_DEFAULT_REF_FORMAT=$format does not change format" '
+		test_when_finished "rm -rf refformat" &&
+		git init refformat &&
+		git -C refformat rev-parse --show-ref-format >expect &&
+		GIT_DEFAULT_REF_FORMAT=$format git init refformat &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
 done
 
 test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '

-- 
2.48.1.468.gbf5f394be8.dirty

