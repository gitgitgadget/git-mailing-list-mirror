Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641EB19DFAB
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 08:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708819; cv=none; b=sKd/mN/5FUzwe9GncrIkbUSQ1sBEzy9sSKiF+44pRz3lfTp9nfPQsTtf7TiwzMZjPhmTkv2dEons9wQzTY+ZWVMEE2MYQMKBeq2Hattgcug2Mai2z0Y8U0NxzWM7U87hasyaOZAH2iiVPlWSKaBH3DzH9cNMcaIObhIANY98NnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708819; c=relaxed/simple;
	bh=WHPEJkJn92AOSfXG46TnrB7VYRAEhz9IE4EbSX56Ty0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TG9JSMFo56KJOPWQDyO5WeSy2wK+dcllm7wYxVu8OIM46DFAmQZlgY37qri5bh033+aROleKDfOsUVlLOqAiqgEAvQeAUIH/4pafGCAXqOcU19WNLtSISxTtxvV/YOzDdR6KjofU/mTsaQ+UvOn9Xr/wyiwpSEsMG7AsOFXcN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZtWvv4fr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axhj6gem; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZtWvv4fr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axhj6gem"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 52267138FFAE;
	Thu, 15 Aug 2024 04:00:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 15 Aug 2024 04:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723708814; x=1723795214; bh=yq3F/B/N8p
	46GAsTJCi6Olt/7R02w2IgCgohVaGAgso=; b=ZtWvv4frXBXIUHU5qEX3ngYXIK
	TFNQFci1a1OjpOsVb7AEgNs9u4MX9raRVIml1R2TKUYas50GTF2bRbqyiVcf8R34
	osq7PDzK8lw+aR4BgtWJOrnyBl33tupZbQBPQ4kAwUHUL0ged8u07+EGV9zXQMzd
	rTh4lt7YIyK6CFxWV38I6k+NQg2DCcnJbjaNpWTSovoekeSO8wYyyeifHQL4XcTC
	7nmZhTyvQPlpS5tMezdxal7WltdRzNcKKLdVd+ALDVtrAI6LjxYUAJTabkOeB6KU
	JKy6PM/PMxdnf0/pj5vQOvwOUJ3L2llljoAFjfSRCktPjV+oz62Kqnfmo/Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723708814; x=1723795214; bh=yq3F/B/N8p46GAsTJCi6Olt/7R02
	w2IgCgohVaGAgso=; b=axhj6gemKwiYbmC8UgcuyLVvfabfF3ZydlrbSP3m+Nrm
	xfK397rYAdUn2uK4vQOyVlBKqUOOl8Ksxs/llJ0C8+MTvBAjUfi8MnCvqHCKZm0F
	OrZKN3MT7uvxximRLccyAe0WadWKlllWIXHDisw4KCtshi+dcw9eatZ82EZfmOVS
	6aX4gKA+RmbtwoPm9+iP/D9Dt7Jo6JNVHoTrtPOosl48kS19A7Rjh+HAXS/hQzI7
	/bQYk0LXb3N/Ee/GFQT+PET9tl2IhjzSuzXB5m+iZLzFf6Uk8uLGW43MRWNLva1H
	wU2qq3bpyqRO1n/5LPH90p4bTdG0IFEIFcUmor2EIg==
X-ME-Sender: <xms:jrW9ZgAgtQeJJ_F5ZndSFDFalkZm_7j7j3sKD0q-_IW3bOoT27b-vQ>
    <xme:jrW9Zii81MqspI6VAW90sqUDHyBdHsPkiX8w7YK5lUgFyn4mfHKrs-wzlaiW_bvgx
    PIyIqjKR2BH1Ykjzw>
X-ME-Received: <xmr:jrW9Zjll4JmrbhzzmhO1oxDNKRg4aVKa74k5oLEmc4KCNHx_4Q0_PrWSRnf4GhF2XBmTZdR7nOnl9h-D5OhvQSMP4WxHD6LKRT-IWknVQ6T9hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddthedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsshgthhhusggvrhhthhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jrW9Zmy76yJkdxGX8HsXt8RSl1ATGdpfum-24t_7nPnFeOGuRCJnvA>
    <xmx:jrW9ZlSZlVSGTkM9mAZqISp4OUVmtbwiPX8m8AlIsL3rjaZQVdF2uw>
    <xmx:jrW9ZhZdyh2exsTpzF5fqIi_kXmCeSv8EjSv0inxkUDqUS_mJCgBQw>
    <xmx:jrW9ZuT3sNWI2NfUkcallmPr4r05vITWPlR1-7uBLXeWdOAlxP7wLQ>
    <xmx:jrW9Zgf9cuM32RH1igamxhWfogEeHNn7g79iDf-0BydmaVRgxLuJV5kB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 04:00:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e4b751c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 07:59:52 +0000 (UTC)
Date: Thu, 15 Aug 2024 10:00:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH 5/5] setup: make ref storage format configurable via config
Message-ID: <a0417b7d1a8e96f71399117f3f7333c5a2920dce.1723708417.git.ps@pks.im>
References: <cover.1723708417.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723708417.git.ps@pks.im>

Similar as the preceding commit, introduce a new "init.defaultRefFormat"
config that allows the user to globally set the ref storage format used
by newly created repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/init.txt |  5 ++++
 setup.c                       | 14 +++++++++++
 t/t0001-init.sh               | 44 +++++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index d6f8b6e61b..9be97bcac8 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -13,3 +13,8 @@ endif::[]
 	`--object-format=` in linkgit:git-init[1]. Both the command line option
 	and the `GIT_DEFAULT_HASH` environment variable take precedence over
 	this config.
+`init.defaultRefFormat`::
+	Allows overriding the default object format for new repositories. See
+	`--ref-format=` in linkgit:git-init[1]. Both the command line option
+	and the `GIT_DEFAULT_REF_FORMAT` environment variable take precedence
+	over this config.
diff --git a/setup.c b/setup.c
index 770ad1393f..dd2251f655 100644
--- a/setup.c
+++ b/setup.c
@@ -2286,6 +2286,7 @@ static void separate_git_dir(const char *git_dir, const char *git_link)
 
 struct default_format_config {
 	int hash;
+	enum ref_storage_format ref_format;
 };
 
 static int read_default_format_config(const char *key, const char *value,
@@ -2306,6 +2307,16 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
+	if (!strcmp(key, "init.defaultrefformat")) {
+		ret = git_config_string(&str, key, value);
+		if (ret)
+			goto out;
+		cfg->ref_format = ref_storage_format_by_name(str);
+		if (cfg->ref_format == REF_STORAGE_FORMAT_UNKNOWN)
+			warning(_("unknown ref storage format '%s'"), str);
+		goto out;
+	}
+
 	ret = 0;
 out:
 	free(str);
@@ -2317,6 +2328,7 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 {
 	struct default_format_config cfg = {
 		.hash = GIT_HASH_UNKNOWN,
+		.ref_format = REF_STORAGE_FORMAT_UNKNOWN,
 	};
 	struct config_options opts = {
 		.respect_includes = 1,
@@ -2359,6 +2371,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		if (ref_format == REF_STORAGE_FORMAT_UNKNOWN)
 			die(_("unknown ref storage format '%s'"), env);
 		repo_fmt->ref_storage_format = ref_format;
+	} else if (cfg.ref_format != REF_STORAGE_FORMAT_UNKNOWN) {
+		repo_fmt->ref_storage_format = cfg.ref_format;
 	}
 	repo_set_ref_storage_format(the_repository, repo_fmt->ref_storage_format);
 }
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index cd34710f32..0178aa62a4 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -620,6 +620,19 @@ test_expect_success 'init with GIT_DEFAULT_REF_FORMAT=garbage' '
 	test_cmp expect err
 '
 
+test_expect_success 'init warns about invalid init.defaultRefFormat' '
+	test_when_finished "rm -rf repo" &&
+	test_config_global init.defaultRefFormat garbage &&
+
+	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
+	git init repo 2>err &&
+	test_cmp expect err &&
+
+	git -C repo rev-parse --show-ref-format >actual &&
+	echo $GIT_DEFAULT_REF_FORMAT >expected &&
+	test_cmp expected actual
+'
+
 backends="files reftable"
 for format in $backends
 do
@@ -650,6 +663,27 @@ do
 		git -C refformat rev-parse --show-ref-format >actual &&
 		test_cmp expect actual
 	'
+
+	test_expect_success "init with init.defaultRefFormat=$format" '
+		test_when_finished "rm -rf refformat" &&
+		test_config_global init.defaultRefFormat $format &&
+		(
+			sane_unset GIT_DEFAULT_REF_FORMAT &&
+			git init refformat
+		) &&
+
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "--ref-format=$format overrides GIT_DEFAULT_REF_FORMAT" '
+		test_when_finished "rm -rf refformat" &&
+		GIT_DEFAULT_REF_FORMAT=garbage git init --ref-format=$format refformat &&
+		echo $format >expect &&
+		git -C refformat rev-parse --show-ref-format >actual &&
+		test_cmp expect actual
+	'
 done
 
 test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
@@ -660,6 +694,16 @@ test_expect_success "--ref-format= overrides GIT_DEFAULT_REF_FORMAT" '
 	test_cmp expect actual
 '
 
+test_expect_success "GIT_DEFAULT_REF_FORMAT= overrides init.defaultRefFormat" '
+	test_when_finished "rm -rf refformat" &&
+	test_config_global init.defaultRefFormat files &&
+
+	GIT_DEFAULT_REF_FORMAT=reftable git init refformat &&
+	echo reftable >expect &&
+	git -C refformat rev-parse --show-ref-format >actual &&
+	test_cmp expect actual
+'
+
 for from_format in $backends
 do
 	test_expect_success "re-init with same format ($from_format)" '
-- 
2.46.0.46.g406f326d27.dirty

