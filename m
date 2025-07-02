Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C8D24DD15
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751451290; cv=none; b=Fbxq2gjGFs/+AoYCb540BZNMUNA2QvJWLHsyHeUUnjPplzbA8pqCxX2uSpmlr6nxtUynttn3Ew5jtqCGD0fogf2y1vzusJsQ6zPaHIT/uo3NRNE25VXtQuFcxiwyiYapRusg6lmCb59JP7M8ouUGcpipC6WRbqsh79owDcY+v/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751451290; c=relaxed/simple;
	bh=vkUXyf7gDeaHU3xTiXnXBgOdXYtWeikeYdcpfGfQvPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HLe9DLiTKupyZyShylUEZPpOOXEIsQiIh/EFOnT3GF5GqBiLupdO/pa/UI4dRAfHdpxvGxhkZHeCaM1GFkVzPsC4OtXyL9n2Yvw9to2IJNOPg74UrITBbztGk/GLZbRXRx5NXYHWL9uBKJIDQAIr9sygKCtiry6dt7ywfzlzxBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TgaWJ6oH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=itzcSiKw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TgaWJ6oH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="itzcSiKw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 90F9DEC01C5;
	Wed,  2 Jul 2025 06:14:47 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 02 Jul 2025 06:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751451287;
	 x=1751537687; bh=j2eWDyJzx3GR6JioCMOUVdu0rEVN9KgV+1lWjLS9i2I=; b=
	TgaWJ6oHuaOG1ehu7ejElJDDGIwWM9Q/ua1DrfawU2te5PwQOLFEVUjMtnfCyDyn
	4O9JUEOIVmAbWC2cpD8rJioDBSxGQYni0vp+WMRM4WoaWA8pqp2VCvCqKWOhk/7I
	j6jQe75Gx0SQjbep7JO5zcMTsOCtPdvf+WohxzQm8MdF0BwVcFdjKgIkFHUi3gHN
	napOkx3HmF/qQgeKH0YLhdvBBj5bZT6r6Mh873K+YBDoSDsoZqsLYGkRGlnTTLi6
	L+weruoX1QMibedwqJusVa0Wd1GcNmmdCesQXYqhAfMCle0nVIMgptaJ4lDD1McM
	crKcvcbv7y8TtfrAKCxMOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751451287; x=
	1751537687; bh=j2eWDyJzx3GR6JioCMOUVdu0rEVN9KgV+1lWjLS9i2I=; b=i
	tzcSiKwpIepcWVFJZnsLwWaIaTkwNkeuTDpFhuEiXU5ndKZHr9/drCmVi1MGJBM0
	fmQLeUzosp23Ld759NjxLerw8KUr1oIVa46MlPTNnJflVgkqpsj7oRYMPD1W1xxZ
	wfggVefrIN1d4e2i450yArll6y5e/kggRTG1YaY//KSh9+7bL04WbdOrPW9LjYJu
	vjD8dsT53pC05PYbmB9Ns17l1cp7ZHgIcQHZtzUxli5F7ly1is+vfJa+2wa69eKE
	hKeN6w5YcN5YcttxRCMylXtE8huovTWtR+jkBWbxicqAXpTenBt877j8sXMbwPJS
	rozu73RMn7YTc8fHlrEMg==
X-ME-Sender: <xms:lwZlaKeIdrwGAy4Qe3LiQTN-3SeEHG0JXdjSTNGv5MzsRUy2uHJp9A>
    <xme:lwZlaENVKNHIdxONuyNOIc6A6yoUdvUv0nOA5x6LvCofuPQ8AIQ8olSESYKgBirbd
    SlACVulma1k2AiSog>
X-ME-Received: <xmr:lwZlaLjX6vVM-2wqdO8e2XfsUCAQu1Q37PBn2nkH4N3ZvTbgooRhn-HVHxhlv-_Nk_47-uaU-rqxbP2kGpGkUpF8RBnXhZ7We0mYWh1MeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehrhigvnhhush
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrg
    hilhdrtghomhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgr
    shhtvgdrnhgvthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:lwZlaH-VUGVStR4wHsAPAZZKC3BcTRQK3IuaieQ9-R5aq6fH77XYuw>
    <xmx:lwZlaGuF97hTrLGsxoNW0lU6CJrqFIa4GKKLX_oNLFkSjw03o1nZ6g>
    <xmx:lwZlaOGMzGxZcvaMV0EU59zUIfSIMhSAYk3n8jwNiqRk46X3lJLBqw>
    <xmx:lwZlaFOzs4mB48UoDzxEF8LYl3DvciXEq-Noha2F05XlvFqjCvyPHg>
    <xmx:lwZlaMEOYieS_0Ji_XS69HRPLEfbGmOx0uMrHhgLuIkGCyBJF4tiD7-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 06:14:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b9be9f8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 10:14:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Jul 2025 12:14:22 +0200
Subject: [PATCH 2/2] setup: use "reftable" format when experimental
 features are enabled
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-pks-reftable-default-backend-v1-2-84dbaddafb50@pks.im>
References: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
In-Reply-To: <20250702-pks-reftable-default-backend-v1-0-84dbaddafb50@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, ryenus@gmail.com, 
 Junio C Hamano <gitster@pobox.com>
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
index 3ab0f11fbfd..8e9c0ffa1fe 100644
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
index e0f27484192..df14d88ebb4 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -754,6 +754,40 @@ test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
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

