Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F112DAFC7
	for <git@vger.kernel.org>; Fri,  4 Jul 2025 09:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622194; cv=none; b=ZP7n97WPLRLtmMH4XFGvxDSL4lJmE9JmHEYG161hc38hjvPfQSrbeVimeZGm6W6MvGKBKIzVOfezrKriqvTgSSlD8bRAxl+nUUWNlJp0pqRQar2xfEwW4Iwisc6F5dJ+lQL0yAT+JvP5yLCYykTVSRucRdSzVYTBgjnlxkXBaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622194; c=relaxed/simple;
	bh=6M6wpZ05NsqajG9uUrkWoGtcndIusLHZAob4KLcl+ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A4+6swdVAIBET2MXH9TFzLe06bKJz3yI7KANeQ4MvWMqmMdhbzzqz0JbKnNVcdjvJj2EiCGS4oxwDRkegy9UNZ++uhIrP542Ayd7LYkfIAHybY93/D11f5ZgL3y8OGgqfkbApm4dKJNfshsssL3lgmEv83ZCBCGPHB/G4merv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eotr7Q9i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hBHZldPi; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eotr7Q9i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hBHZldPi"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E1D071D000E3;
	Fri,  4 Jul 2025 05:43:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 04 Jul 2025 05:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751622191;
	 x=1751708591; bh=k6Oil3XpGiojlWFPgh9/UwjlM78QACoOjWq5oBpvBJc=; b=
	eotr7Q9imjqWWfiasVWUHc3AWSCyC569RUWf2ok5jRTLulGPCaP9u+eIqBxxwPYX
	drRKvI9XVFkmo/m3JFHLtgqs0KJK2jSAXMOs8P5jhQ3rpPVBcGol0cmrAjZ8lVzd
	tgVohYC2YYsgDytfKB8OfO/YGAjb1gvjtx6H5Vgvk3YcqLfM6omvysREiSfXvjik
	62EIzwreUKqSE1P+QVLB6Mrm5cxUa3sW6OyCxk53WTTLSbmOMnroDY0h2192BGwg
	ljIJEh33AGMgfiSaC4LH5sGs8jwHGP2SlTC6T6SECHGIBk6nLI90fMvkxDBL6a4U
	CzgqFgDUVt6ZZCDn1vtk9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751622191; x=
	1751708591; bh=k6Oil3XpGiojlWFPgh9/UwjlM78QACoOjWq5oBpvBJc=; b=h
	BHZldPixbJQs7g5Fc3OpPwpD4amCjGdyLqPmqtjVMzGqfGsA66hKLjN6oizZHR97
	Sq5KhzP9T1CdfDg4SV5fWE4eRle9oARa4tAglwRhUFQ25TeK/rxrx8VIMwyix1vq
	KH8SfsHbgLRhQafwtbM+K13DyxNDVuZ2YB4Ld1E8rkyz1Jo5H5O2uV1/ckkGryb2
	8C3ml02pMr3h9nxeEI1NdALkZD7t0+hHQBDF53UQ1tM3AZykrBm6bWBlxGn2bse6
	frwSr/JLBhare4iapaLikP2gm1eEnbPW1b5qLYmOGOfqeJ+JTySvobZsgL6rpkvw
	mommOkiFqNjT0DDKGwEiQ==
X-ME-Sender: <xms:L6JnaEeHvBsI3PnzLy5v--B3MdVD4rfzI2mKcYuvfSD9ub3sdm1CXw>
    <xme:L6JnaGN_OcBJ5XKcoodz3OdA_Pcb_OYOMbJfZ6wUYzJqhk8t9enws4EDzmztS3Oy0
    rwjiWE_fRTBNVoLEg>
X-ME-Received: <xmr:L6JnaFiHksGnkoQ7PpH8Z7tEiJocD1BCPI8pKmoTqQ_bxAGHRiIrcAAHrXen9EXj69D_aFEPc4zeuaU1cfdV4pEm_50JsEmKrRwl1lbiti3S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvvdekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprhihvghnuhhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrhigrthhhvggvrh
    hthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:L6JnaJ8cAGtNr4_oHlNTE95yEQp6iISCxP999S4wRYy3x3JKPOcfpQ>
    <xmx:L6JnaAvOmikgb8TBXE6YfABhMwZRfei5H8gcPbeF9U7qJehtpKUC7w>
    <xmx:L6JnaAE5Esmf53l3inG7sH6-xzNwTLx3saEqinwx2Ngb4j5hVwd9ww>
    <xmx:L6JnaPO8gtmofOvYYel2ap3vnh7ehp2QcLcTyKAJAWS4-GBf2dYWWQ>
    <xmx:L6JnaL6012JdfnsAbNwLKYxhBj3EFY1VHL_wyH3C6NEwVsxIFSaoMbn_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 05:43:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e9979c6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 4 Jul 2025 09:43:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Jul 2025 11:42:57 +0200
Subject: [PATCH v3 2/2] setup: use "reftable" format when experimental
 features are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-pks-reftable-default-backend-v3-2-a1eb63e8442a@pks.im>
References: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
In-Reply-To: <20250704-pks-reftable-default-backend-v3-0-a1eb63e8442a@pks.im>
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

