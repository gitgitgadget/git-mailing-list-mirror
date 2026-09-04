Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3146D545
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518201; cv=none; b=DfVn3SJ2ECHwSn1OcyNuBczT51f/J3PgzF5UQboDxY9aXBkDW2HoBxRLk/1Rv85D9ELZAuTTHzUVi+YzoGrlFpFAPK/DB5ZEqSes/NTZLmv0HAduoauF22r5QTCybIFb/mDqZzPFsYwrXlgdIAqk/vps1uHBr3ZbVwzZo+zV3hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518201; c=relaxed/simple;
	bh=ifn0+8J7nRSdHcIGaswEXEm5kOA4YBZzGTR89LQNRSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mc2SoJGeg4FIRfLtA+e82V8T7/KKc0DMb96zeUQcs2V9/rj69bjyDxvsoBgd9AOHcAQPmS4wo3GPjotwdcaWRYlCxI98aDFt8QLpYbSHA2bhS9fXI9ISYab35ZTe818vBL6kiyc9kYD5z76VTDXUKKi8es/G4BNocQ+I2j2rOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XuLJEtPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfcmIlGg; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XuLJEtPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfcmIlGg"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C3EB91D000D4;
	Fri,  4 Sep 2026 06:36:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Sep 2026 06:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788518198;
	 x=1788604598; bh=E+nDKIv2glHN989Y6F6L0cEsBlECTJzRP2i0udWsYP4=; b=
	XuLJEtPZ1q8F9U8kplRpMomkv8ZE4rtYtV1VlXR+hJfHSTPwW/UUKjVKuOaoK4AM
	ub1wlSXbpn47gFYjDXFUGP+SbF+Gq+Awr1ZmyYiQ2cR0oikBO+Jg0SEDcBWshvTG
	/WJ0VJIuyzdZQbgsnpqN5wSq9CqKAr0mZGIsoCRMOED14zS9mQZZZRGVZIMEQZ8V
	jcnfxy4aGlrVqVe/v2Fkd5C+KNWCO/PEpkccU2JJ5QLCWf9ozuzJh9AeqYs596eJ
	71iPm+3x3BS8dfZOnUCzxA0HQD6YegP80ZOzLS7HYXI9ze3b3KBv6KGwJ6AGpkyy
	Jvt51L+1qvKnP1X9z/6Erg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788518198; x=
	1788604598; bh=E+nDKIv2glHN989Y6F6L0cEsBlECTJzRP2i0udWsYP4=; b=v
	fcmIlGgyfDdD+CSCMIB56Qa92OHVXEbgMASpZ3UwSlk2fBUxWQaj9rYC8MIxB5zD
	JrwIohOhiiltG/ZRu5Fc6riiuihQ4kbmlbE013O8B1wAzlKDhYaXA88UAmtAr791
	9QsI4LFh2R+uP/GiwBvBUAa/DyDGDGj2znYFcMrlQzG56/ZpZx8zNLUiZ4zY55Dy
	SvumSSrcYy/CFoLe+3kmfWxiyCEqBDFdzMeiMi5kuHUqQREORHrdGtgXW4moUGOO
	PIlsE0YteBwlwt64C1xlLyprIs+j7bzhIbeq4Kp3tTTiYJHs/Mab2aEm4dvJGQmx
	J/9t5DGK4OD54CeFLTl1g==
X-ME-Sender: <xms:Np-aak5AVZCLJpgTVe8FcWvbnkfp05LRh1zYGryqP4Ws5qj9U7s_SQ>
    <xme:Np-aar4UjtB55oH-1ZZtwzDZHVz1yu4oY3ewvY0agDOAOljWtPPJAkFRbd6APfKR2
    3RvhGUPK9Kx05HYE3oOoo5Q0OjCrMBIecgpgG66RYc9-KGcg5KoIaE>
X-ME-Received: <xmr:Np-aahF_koqAYWz__qfi995W7U4-TAOl4MGhymsOat7K_s746hD857dj0lKQLDqWb_ywWQ>
X-ME-Proxy-Cause: dmFkZTFETADmBTAkBOERto0F1Zo9P5iLUivjhGLnNcuEYcIJWkG+RdF8TWDjfPsEvHgxPT
    8szfAnPXrDSCZtwaAgOGbi2GfUbNM7aoXs1oZ76L95pQ7PFFxiNTdWbZ0w0lwN3iOF1Idg
    vtdktiBy43c2K29Ip08RMJyzalXlyyskOqpHCau80MksRRU7iXcze+Rc/7fISh/PjjBUkz
    vsrrCZeEudgGUfxlnN9W8RYoa1qmjwIGsRMZea1sMI+0hrjAS6x6/7xxvuw5X4DKnNWATq
    IVcqLUe4RACIZ34HxghPsPpccUsySKfYqzscFSUdB/zgtkHraQNos8aYxi54Bw2Xc5Sicl
    ixC68W6zocA0zIELM2xR5EHIDw06dxOCqdMFV38XX/XhdOcVmTEYxLbI+K36cgj0635o1W
    TDB2COa7zr49qEz5PJ1WvYh80H9P7AjM/pZr4tGMIR+0RdiXT+tt86wN4dYf+MjhoOp0w0
    EUml+sknFR65jFFQzu4rLJNPP1QG59nV5fLokE7vJBMcLGl75LcWVZ6vIFSO/FTYLiPAKO
    gbpgXA4Xncr/U8S9e5VXab2y8Hf8sNMg45intXhTBVoyddwnrsPmahPNyZb3uK6N1zdGoD
    2pDUbIlj3qgxV8GRuiAlyObGdExjKJKyvyUq5NmfHAYvF+WznWZncinp53Fw
X-ME-Proxy: <xmx:Np-aakSpD6j7Z031Su9P7pI364Y2tGX0Oe-lwvSNCgW9PPL1-JF97w>
    <xmx:Np-aaqunNI1tk35Avyk64YXhgBlZ7xb0VbP2j6ddnsH5vsRZ_JG7qw>
    <xmx:Np-aajzxSuc5_T1gb6x6-bNE41vouzLuJUgG1R68vMGCBmvlKqcuzg>
    <xmx:Np-aak5RiRaXhH2Fux_kNryiOHQtB2730HwPDe9kcx-Ngvd_yX_elQ>
    <xmx:Np-aaioQS5jKdpYXAhc4zj723ie_FbK5KyD6g97-A08BhMfEocBsHJ9B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 06:36:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 264d82fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 4 Sep 2026 10:36:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 04 Sep 2026 12:36:11 +0200
Subject: [PATCH 10/11] setup: rename "init.defaultRefFormat" to
 "init.defaultRefStorage"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-b4-pks-unify-ref-storage-format-v1-10-08144e5004ff@pks.im>
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename the
"init.defaultRefFormat" config option to "init.defaultRefStorage" and
keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/feature.adoc  |  2 +-
 Documentation/config/init.adoc     |  2 +-
 setup.c                            |  8 +++++---
 t/t0001-init.sh                    | 16 ++++++++--------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..af69f5c1e2 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -156,7 +156,7 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
      "packed-refs" file.
 +
 Users that get immediate benefit from the "reftable" backend could continue to
-opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
+opt-in to the "reftable" format manually by setting the "init.defaultRefStorage"
 config. But defaults matter, and we think that overall users will have a better
 experience with less platform-specific quirks when they use the new backend by
 default.
diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index 924f5ff4e3..7687e1a89a 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -25,7 +25,7 @@ reusing objects from multiple packs instead of just one.
 significantly smaller in the presence of certain filename collisions with Git's
 default name-hash.
 +
-* `init.defaultRefFormat=reftable` causes newly initialized repositories to use
+* `init.defaultRefStorage=reftable` causes newly initialized repositories to use
 the reftable format for storing references. This new format solves issues with
 case-insensitive filesystems, compresses better and performs significantly
 better with many use cases. Refer to Documentation/technical/reftable.adoc for
diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index 3098e033ac..297c09cf43 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -13,7 +13,7 @@ endif::[]
 	`--object-format=` in linkgit:git-init[1]. Both the command line option
 	and the `GIT_DEFAULT_HASH` environment variable take precedence over
 	this config.
-`init.defaultRefFormat`::
+`init.defaultRefStorage`::
 	Allows overriding the default ref storage format for new repositories.
 	See `--ref-storage=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_STORAGE` environment variable take
diff --git a/setup.c b/setup.c
index 5de2aa0d2f..b81d4f134a 100644
--- a/setup.c
+++ b/setup.c
@@ -2697,7 +2697,8 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
-	if (!strcmp(key, "init.defaultrefformat")) {
+	if (!strcmp(key, "init.defaultrefstorage") ||
+	    !strcmp(key, "init.defaultrefformat")) {
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
@@ -2709,7 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
-	 * "init.defaultRefFormat" takes precedence over this setting.
+	 * "init.defaultRefStorage" takes precedence over this setting.
 	 */
 	if (!strcmp(key, "feature.experimental") &&
 	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
@@ -2781,7 +2782,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *      equivalent "GIT_DEFAULT_REF_FORMAT".
 	 *
 	 *   5. The default ref storage format for new repositories as
-	 *      configured via "init.defaultRefFormat"
+	 *      configured via "init.defaultRefStorage" or its deprecated
+	 *      equivalent "init.defaultRefFormat".
 	 *
 	 *   6. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index e4b9fae8bd..b481d763ff 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -659,9 +659,9 @@ test_expect_success 'GIT_REF_STORAGE refuses to reinitialize with different stor
 	test_cmp expect err
 '
 
-test_expect_success 'init warns about invalid init.defaultRefFormat' '
+test_expect_success 'init warns about invalid init.defaultRefStorage' '
 	test_when_finished "rm -rf repo" &&
-	test_config_global init.defaultRefFormat garbage &&
+	test_config_global init.defaultRefStorage garbage &&
 
 	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
 	git init repo 2>err &&
@@ -714,9 +714,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "init with init.defaultRefFormat=$format" '
+	test_expect_success "init with init.defaultRefStorage=$format" '
 		test_when_finished "rm -rf refformat" &&
-		test_config_global init.defaultRefFormat $format &&
+		test_config_global init.defaultRefStorage $format &&
 		(
 			sane_unset GIT_DEFAULT_REF_STORAGE &&
 			git init refformat
@@ -753,9 +753,9 @@ test_expect_success "--ref-storage= overrides GIT_DEFAULT_REF_STORAGE" '
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefFormat" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE= overrides init.defaultRefStorage" '
 	test_when_finished "rm -rf refformat" &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorage files &&
 
 	GIT_DEFAULT_REF_STORAGE=reftable git init refformat &&
 	echo reftable >expect &&
@@ -775,10 +775,10 @@ test_expect_success "init with feature.experimental=true" '
 	test_cmp expect actual
 '
 
-test_expect_success "init.defaultRefFormat overrides feature.experimental=true" '
+test_expect_success "init.defaultRefStorage overrides feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorage files &&
 	(
 		sane_unset GIT_DEFAULT_REF_STORAGE &&
 		git init refformat

-- 
2.55.0.1007.g17ff1f9808.dirty

