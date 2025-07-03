Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F2E2DE706
	for <git@vger.kernel.org>; Thu,  3 Jul 2025 06:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751523346; cv=none; b=udHZ5e7sf+AjxTE+4HsMZdbuQW7y6x8SJ4McxxteKcSQDEYdO0mzLpwQuDrLqPdDVfFwjOO9gnKvQcR425hMBHkVRMCeYfIhVaYoMTbbgWEZbDI2bzCK88VfeyMjXdgXSZzds75SWtvVSezeLGNSetImWMzZ1M3OD1FktUPU2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751523346; c=relaxed/simple;
	bh=6M6wpZ05NsqajG9uUrkWoGtcndIusLHZAob4KLcl+ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jrBoLALZztxTW1FqjXH8EsOd5iXx2H8RarRfBNc19DJls4hMbwdjVZTRMpQSr4ewXmY+ZuozmsDgjiKCI56P74qg8oomA+fgeZBF5D47Yq6T+CAvkZhWLieqE4OxhSr6FHhRPhbTIh0B+DwH8+0CeqVbbamvAh4pSj8ihVCHrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J+G/1bgY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HL8LUVil; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J+G/1bgY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HL8LUVil"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id BB2B11D0006A;
	Thu,  3 Jul 2025 02:15:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 03 Jul 2025 02:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751523342;
	 x=1751609742; bh=k6Oil3XpGiojlWFPgh9/UwjlM78QACoOjWq5oBpvBJc=; b=
	J+G/1bgYQd5WhcJX2tcvjqJOSiXAaGmOUxfKnhFuZULWoU06dPtYhgwc6wnvDhhe
	12GLeMXW50R8UKP1cL7fGp4tSI10fl9qBOWOP4GLPvAx3Kogw16kADwKx6nEMP1l
	2nZGlsLfaEJKysnrcHaDdYZNJ3HJ64Yi8MlKbq6g+3GjCbzNBV3eS9xnvxN1DLxI
	+xJbwPUDrtKH7yKZBAsOmVSB8/MqVsTPuOLIbcTgOGqvY9Bz+0OthhN+5CsAB8Ly
	bHLh+uac3LiVNaqb9laniYwA09WYoAWJx89ulMnpu+nkYtHXiBYD5PZaHOeKQY7s
	zECsHemuYtMuDagFC+xX1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751523342; x=
	1751609742; bh=k6Oil3XpGiojlWFPgh9/UwjlM78QACoOjWq5oBpvBJc=; b=H
	L8LUVilAarZ8Eq11562fyXJ6JsIPD6mu5F0tVFGmiacofU9AmG5P8E8g1V0mbvzZ
	E67/7UVPNRx8k95+YwHzpJ3dB6BD+7gJUzRpFmWJ5MQrubhTMv4XmejlWBoofP6x
	2jO8BEVbGxQuFqfP5UummYXV9rYe2I4PSb4qScaj4/2+Lxg8t0rjPb5/pLdPMBiw
	X9CbBUdlNOLsHPfyu/t+4WiGQo1r5A2hNBvjj1RbrOJlAHcOMjkzGQJUrQGgyYqW
	eJXEJ3UoAt1OgxA1ZCtTM5kAW3oRPXz0eFZOyZcvTyrzLOACuEGA7vmS4/Xnhb2e
	Szju2qqIchz/OeHcbXItQ==
X-ME-Sender: <xms:DiBmaOHYM7d7lrEAXi1i1HqF7G3kScynUE-qJ42R5WqfrDYP_pGl7g>
    <xme:DiBmaPWZT-vcJzGpwCchIVRFXrw4BjpxzFf1c-qMIH_zIAsVs2NK_NDZn2r4z6xDr
    syZRa2sg-DiXtJaJg>
X-ME-Received: <xmr:DiBmaIIDcxDPCNre-EhNzdxGPJ2_k0YhVBiu9pcqbQi-X-0iupeSsIKuUnl9DgP9keff3xvFDe9zboSpjByYqI3BcrrnQ63q6zpXNxaIaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtoheprhihvghnuhhssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrgihrghthhgv
    vghrthhhkhhulhhkrghrnhhivddttdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:DiBmaIG22pKZAnXlWYj4berh6twMLimDq2Rtf_XF3XBNCNCuO-mzMQ>
    <xmx:DiBmaEVfR2BOD4957eH8xFpubn3l43KwM7l1hFjL5qSrHbOpR3Jw9A>
    <xmx:DiBmaLMqfkin0juPnJCBykMaZTXQz6FS_HZnUtZ0Cl0Fsa_WD5vwJA>
    <xmx:DiBmaL2RtkH3en2qlURvS5sOV8D0wAc0uNge0-EAEPy_60WszSesXw>
    <xmx:DiBmaGCnXpyuaNHcooWQ8kvtnwAspd6yrU0nj6Fhr_7C4EdZVDjFGvIp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Jul 2025 02:15:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 614e086f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 3 Jul 2025 06:15:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Jul 2025 08:15:31 +0200
Subject: [PATCH v2 2/2] setup: use "reftable" format when experimental
 features are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-pks-reftable-default-backend-v2-2-5a27e72a8c5e@pks.im>
References: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
In-Reply-To: <20250703-pks-reftable-default-backend-v2-0-5a27e72a8c5e@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

With the preceding commit we have announced the switch to the "reftable"
format in Git 3.0 for newly created repositories. The format is being
battle tested by GitLab and a couple of other developers, and except for
a small handful of issues exposed early after it has been merged it has
been rock solid. Regardless of that though the test user base is still
comparatively small, which increases the risk that we miss critical
bugs.

Address this by enabling the reftable format when experimental features
are enabled. This should increase the test user base by some margin and
thus give us more input before making the format the default.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/feature.adoc |  6 ++++++
 setup.c                           | 12 ++++++++++++
 t/t0001-init.sh                   | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index cb49ff2604a..924f5ff4e3c 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -24,6 +24,12 @@ reusing objects from multiple packs instead of just one.
 * `pack.usePathWalk` may speed up packfile creation and make the packfiles be
 significantly smaller in the presence of certain filename collisions with Git's
 default name-hash.
++
+* `init.defaultRefFormat=reftable` causes newly initialized repositories to use
+the reftable format for storing references. This new format solves issues with
+case-insensitive filesystems, compresses better and performs significantly
+better with many use cases. Refer to Documentation/technical/reftable.adoc for
+more information on this new storage format.
 
 feature.manyFiles::
 	Enable config options that optimize for repos with many files in the
diff --git a/setup.c b/setup.c
index f0c06c655a9..97d7824d07a 100644
--- a/setup.c
+++ b/setup.c
@@ -2481,6 +2481,18 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	/*
+	 * Enable the reftable format when "features.experimental" is enabled.
+	 * "init.defaultRefFormat" takes precedence over this setting.
+	 */
+	if (!strcmp(key, "feature.experimental") &&
+	    cfg->ref_format == REF_STORAGE_FORMAT_UNKNOWN &&
+	    git_config_bool(key, value)) {
+		cfg->ref_format = REF_STORAGE_FORMAT_REFTABLE;
+		ret = 0;
+		goto out;
+	}
+
 	ret = 0;
 out:
 	free(str);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 186664162fc..f593c536874 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -749,6 +749,40 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
 	test_cmp expect actual
 '
 
+test_expect_success "init with feature.experimental=true" '
+	test_when_finished "rm -rf refformat" &&
+	test_config_global feature.experimental true &&
+	(
+		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		git init refformat
+	) &&
+	echo reftable >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "init.defaultRefFormat overrides feature.experimental=true" '
+	test_when_finished "rm -rf refformat" &&
+	test_config_global feature.experimental true &&
+	test_config_global init.defaultRefFormat files &&
+	(
+		sane_unset GIT_DEFAULT_REF_FORMAT &&
+		git init refformat
+	) &&
+	echo files >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides feature.experimental=true" '
+	test_when_finished "rm -rf refformat" &&
+	test_config_global feature.experimental true &&
+	GIT_DEFAULT_REF_FORMAT=files git init refformat &&
+	echo files >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '

-- 
2.50.0.195.g74e6fc65d0.dirty

