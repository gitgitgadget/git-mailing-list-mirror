Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27B4582DC
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 11:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788780042; cv=none; b=coOAL6X0Di533g2YzSs81f+cWVpU4d3a1gG1Lnbkhip+MiCu6rOPDE6ByspHJVFMvCkBjL0Q07DM/s7HTLJLjSLoZguG5iFt34LD3QRUq7EM3IrOWFCOUMif9Ttl15KLKfzZkINhAVpumbIuS1Fw0yIR8ahzi/5bP15EZsHxuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788780042; c=relaxed/simple;
	bh=cxh+lZtwres2zCOIfLK0RCTJevAc0iop9+O6Ar69Ivo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OR7mJINe93/SAhPW+UWCHI0jypU/0kwRZwR7U3nM6A6EWP8887zKEn4Iu3t1r4y4ON/Zs4L0LtKoeVDPqI+1PhPsu29VEAj5Mtg+FOnRcoo/oQ+29rkd0SF0+to/ywntJN3QADijmOXZ1uis1TL2IC9nWAmnoBF2z6cZoTVUx3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dXo4lEwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eig28fZ1; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dXo4lEwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eig28fZ1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 601A514001C5;
	Mon,  7 Sep 2026 07:20:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 07 Sep 2026 07:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788780036;
	 x=1788866436; bh=snYcr/tcTnPF38fzxX8BaFNZXlaj5tV4DLGlnaT5YWQ=; b=
	dXo4lEwoXkzR4aT1Tgwy7SsfvQ0/Xg4Ial8UsJgrKaD3dxkqe3pUl2KLB6n2y7YQ
	4eePlAE/sYmUhC7oc8q0ASw2RZKsJTBFLqd79KeplX1bYQeBXr1yXxE54s8DzTHv
	B7NTz/MHymluoxuaUVJDOg2+C8kvDVwvaxKqthwIaACWQIe4awnFOZ8qg9tWQHh5
	oKrUqtL36f7UwiKIsmAPknc4demgeOZvO8zCr1bOiD8ZwVuPBX9sV+5gUgGYw7ig
	xUc4hRA4kzFsU5gIqhnUtbyA5696tIEW22suIGKah7Tmr6ltpqdft6O88RQ/YNYD
	iOPGKfjl5/pBWHlvuH8W6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788780036; x=
	1788866436; bh=snYcr/tcTnPF38fzxX8BaFNZXlaj5tV4DLGlnaT5YWQ=; b=e
	ig28fZ18JQte1q87EogNyMV5vyQbW4STAONGZBRRx6T1exQnLsViKzzbd4EQGIg6
	1LHPbt1GMHwXz4Z8ymKm9MH3jXAapDGHdFJtaCnK1AVYXv4uVvALF0tha/6AT0GI
	c+Lj1NVSPacyY9rlb8dsPg1L0jmCj8MZrWjtfwsKP3jfqy2zvVKyDYwK/MqN1XhY
	N2YslMlUuImjqaRFV1cbY7RtKdFBe12h5uYc5Y575aBcg395rKEG0wa3k/JlYhhG
	TSzy1OTTiEk8QyJDUn4Ekf+pbDXxVD/006NhZdKiZjIEuQbtVV3eEJ56akyyenTj
	dmTp+yZlOe5uD1pKnmqbA==
X-ME-Sender: <xms:BJ6eauCvNsT85bK0d3qWHHskL95bzlvu2SHyT5eJRto9TpvYN2B11A>
    <xme:BJ6eav8ZnsE_Q90LOF4Zi8O9j3G8YP54ioB7avp-B-1qdhEmQkdauQLtR5zEsUlMt
    8ohifKUc06XbAPT1voUYJLep9jzAbXt9OdMwhNU5b81h_ceAQKZag>
X-ME-Received: <xmr:BJ6eau8zPsmvuh9Xc_HpdttvvdI8pmVUL1kI4WMXc2iu4Vy4u0p_HQ>
X-ME-Proxy-Cause: dmFkZTEU+csHYvBo9fMYwV3wknAtUSE4SJO0BUQi53xPlseR/gNYI/1nqdGQqVSAlOZjQd
    4l4U+XllsvZqrni2Eec7ZpTaSCKzhBvzOVpCUnAc6LTxJe0zNbgTYyDSzDv3ROAKV1EFYH
    Bx7i+VjTkrj7+yADyLZfC+VgUeQR2ODyNHcvnBvS08LcP9yK0Ar5jOwFYHKPS7P+ZyrIU9
    43fHMkwpKPdLr84bgJ9NgnRDJ1cBOAz/SRYPOGgsns1KFSsbOTQ/K8oZhdQmsg4XqNJkVb
    xyo317as6nauYcrux5Qoi8NFl3mE7HjkjrBL9oDRSzbFL9MtMr+KveMXO0+iOMUks7hoaX
    vuXDJkMyNCPuYfOuI0w86yLlt5Q28qucYwxjsFwOR2YN79JvPoiqtN0c9iayUA++eDYZ5/
    35lG6a8u6/F2EfzwVUQCKFIkTUZGJu0GCsdFrYw23BNDbNC55YhAbo/WFYT+NVBRnHq9gH
    oY5yHLuLIodtwz8IDZ1Yaw+Te0MU5hgjG7BNmIO0eII0rbJe68sK8pIlDiEZrOBHTh/jwE
    9dYntVQ1o2q7s6CMucTonr3jyUIjfHqu/ET0SsdJPtRGWQ/Tjs2o/s0ZHeT4ca6ShbOGK/
    uM0mNhprKW4UKClLqLjcNFCvDxTAoPcYBksOcS9TSnVX+xrkkWhBp7K6HLBA
X-ME-Proxy: <xmx:BJ6eamdaQ53uJ-HPRXOO_T76chG052qpQ1cXlY6m46yRLpWfTfHo0g>
    <xmx:BJ6eanGDO4w4xJL5G3NFw8-s4IrTc1NsM7PM9YUAWOr2qSE8xG6wtA>
    <xmx:BJ6eakf-K2IeBzo1UkZBU0psuVxtSokujRPfOfy-r_8OjDQdmVSVgA>
    <xmx:BJ6eahEYdrz44WY5ieer4fvyvIBgThT7BgjHC7P-gA7fsAA53TA8dw>
    <xmx:BJ6eav-YUYWNnF2qc1bdhTYibSDTuHo8x4-dkoKcmP8piyx8LJ2yfoQi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 07:20:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 648c3877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Sep 2026 11:20:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Sep 2026 13:18:44 +0200
Subject: [PATCH v2 10/11] setup: rename "init.defaultRefFormat" to
 "init.defaultRefStorageFormat"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-b4-pks-unify-ref-storage-format-v2-10-6733c90ca5b0@pks.im>
References: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
In-Reply-To: <20260907-b4-pks-unify-ref-storage-format-v2-0-6733c90ca5b0@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

With the same reasoning as for git-init(1), rename the
"init.defaultRefFormat" config option to "init.defaultRefStorageFormat"
and keep the old name as an alias.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/config/feature.adoc  |  2 +-
 Documentation/config/init.adoc     |  2 +-
 setup.c                            |  8 +++++---
 t/t0001-init.sh                    | 16 ++++++++--------
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..c2cef3f528 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -156,7 +156,7 @@ Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
      "packed-refs" file.
 +
 Users that get immediate benefit from the "reftable" backend could continue to
-opt-in to the "reftable" format manually by setting the "init.defaultRefFormat"
+opt-in to the "reftable" format manually by setting the "init.defaultRefStorageFormat"
 config. But defaults matter, and we think that overall users will have a better
 experience with less platform-specific quirks when they use the new backend by
 default.
diff --git a/Documentation/config/feature.adoc b/Documentation/config/feature.adoc
index 924f5ff4e3..e258770591 100644
--- a/Documentation/config/feature.adoc
+++ b/Documentation/config/feature.adoc
@@ -25,7 +25,7 @@ reusing objects from multiple packs instead of just one.
 significantly smaller in the presence of certain filename collisions with Git's
 default name-hash.
 +
-* `init.defaultRefFormat=reftable` causes newly initialized repositories to use
+* `init.defaultRefStorageFormat=reftable` causes newly initialized repositories to use
 the reftable format for storing references. This new format solves issues with
 case-insensitive filesystems, compresses better and performs significantly
 better with many use cases. Refer to Documentation/technical/reftable.adoc for
diff --git a/Documentation/config/init.adoc b/Documentation/config/init.adoc
index f82fcf25e6..10d6aba3ff 100644
--- a/Documentation/config/init.adoc
+++ b/Documentation/config/init.adoc
@@ -13,7 +13,7 @@ endif::[]
 	`--object-format=` in linkgit:git-init[1]. Both the command line option
 	and the `GIT_DEFAULT_HASH` environment variable take precedence over
 	this config.
-`init.defaultRefFormat`::
+`init.defaultRefStorageFormat`::
 	Allows overriding the default ref storage format for new repositories.
 	See `--ref-storage-format=` in linkgit:git-init[1]. Both the command line
 	option and the `GIT_DEFAULT_REF_STORAGE_FORMAT` environment variable take
diff --git a/setup.c b/setup.c
index e2bb04410f..52ad0f417d 100644
--- a/setup.c
+++ b/setup.c
@@ -2697,7 +2697,8 @@ static int read_default_format_config(const char *key, const char *value,
 		goto out;
 	}
 
-	if (!strcmp(key, "init.defaultrefformat")) {
+	if (!strcmp(key, "init.defaultrefstorageformat") ||
+	    !strcmp(key, "init.defaultrefformat")) {
 		ret = git_config_string(&str, key, value);
 		if (ret)
 			goto out;
@@ -2709,7 +2710,7 @@ static int read_default_format_config(const char *key, const char *value,
 
 	/*
 	 * Enable the reftable format when "features.experimental" is enabled.
-	 * "init.defaultRefFormat" takes precedence over this setting.
+	 * "init.defaultRefStorageFormat" takes precedence over this setting.
 	 */
 	if (!strcmp(key, "feature.experimental") &&
 	    cfg->ref_storage_format == REF_STORAGE_FORMAT_UNKNOWN &&
@@ -2781,7 +2782,8 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 	 *      deprecated equivalent "GIT_DEFAULT_REF_FORMAT".
 	 *
 	 *   5. The default ref storage format for new repositories as
-	 *      configured via "init.defaultRefFormat"
+	 *      configured via "init.defaultRefStorageFormat" or its deprecated
+	 *      equivalent "init.defaultRefFormat".
 	 *
 	 *   6. Otherwise, we fall back to the default ref storage format
 	 *      compiled into Git.
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index af9a7ba958..fe5bc3d3e1 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -659,9 +659,9 @@ test_expect_success 'GIT_REF_STORAGE_FORMAT refuses to reinitialize with differe
 	test_cmp expect err
 '
 
-test_expect_success 'init warns about invalid init.defaultRefFormat' '
+test_expect_success 'init warns about invalid init.defaultRefStorageFormat' '
 	test_when_finished "rm -rf repo" &&
-	test_config_global init.defaultRefFormat garbage &&
+	test_config_global init.defaultRefStorageFormat garbage &&
 
 	echo "warning: unknown ref storage format ${SQ}garbage${SQ}" >expect &&
 	git init repo 2>err &&
@@ -714,9 +714,9 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "init with init.defaultRefFormat=$format" '
+	test_expect_success "init with init.defaultRefStorageFormat=$format" '
 		test_when_finished "rm -rf refformat" &&
-		test_config_global init.defaultRefFormat $format &&
+		test_config_global init.defaultRefStorageFormat $format &&
 		(
 			sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 			git init refformat
@@ -753,9 +753,9 @@ test_expect_success "--ref-storage-format= overrides GIT_DEFAULT_REF_STORAGE_FOM
 	test_cmp expect actual
 '
 
-test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefFormat" '
+test_expect_success "GIT_DEFAULT_REF_STORAGE_FORMAT= overrides init.defaultRefStorageFormat" '
 	test_when_finished "rm -rf refformat" &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorageFormat files &&
 
 	GIT_DEFAULT_REF_STORAGE_FORMAT=reftable git init refformat &&
 	echo reftable >expect &&
@@ -775,10 +775,10 @@ test_expect_success "init with feature.experimental=true" '
 	test_cmp expect actual
 '
 
-test_expect_success "init.defaultRefFormat overrides feature.experimental=true" '
+test_expect_success "init.defaultRefStorageFormat overrides feature.experimental=true" '
 	test_when_finished "rm -rf refformat" &&
 	test_config_global feature.experimental true &&
-	test_config_global init.defaultRefFormat files &&
+	test_config_global init.defaultRefStorageFormat files &&
 	(
 		sane_unset GIT_DEFAULT_REF_STORAGE_FORMAT &&
 		git init refformat

-- 
2.55.0.1007.g17ff1f9808.dirty

