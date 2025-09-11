Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C631327A0C
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597107; cv=none; b=g/ks9yP1SHcr+2mTx65HSdoPVbW/TNfZn5mSxl7gv5K4fqAvFATyGz+KEP8EQrA+yQPLzrypyISUrP2S/ZubYV+GRK0ojnQREfleRNe9mPGEUTA7q3rnRKo40JidB996gNMzLn4Z/1oDQQgCrdOu2lv67Kt2FKpw+cIkY4vly0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597107; c=relaxed/simple;
	bh=lwaJjxFTF2h0rdO1Bzkt7knHz2jSWvB/bJ+ShX5eeh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjYChIYmqazObIi/npNQKqCzF+X9oNXWz1QRHpj3LqM2ASAT8F66CbZzA1ilSTnhxxe4c82bX6ue4MBarVzWNWtdRW9+h+Ef2QbA1NpcOow0gNTRVKdeniPJtLYMXA4vlE5C+Tj7vRftphxd1/691oLWG64QrLymVc/a6hcR928=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mXl40Y7M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CoKDedu8; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mXl40Y7M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CoKDedu8"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7927A14000CA;
	Thu, 11 Sep 2025 09:25:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 11 Sep 2025 09:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757597104;
	 x=1757683504; bh=OoJRhljIapU4tx2ZMn+bhtDibdkebMZJLIt4mqMQ/tI=; b=
	mXl40Y7Md1kDE93SoilDHFbtW5Qf9NGqWNo1sjU3hMqOrTtRmtfmp22fneFo22J5
	9RxwNtrHJA//7gTpySTFX6GxHYIT0CH1joyOQPs4/HNoxjWzMJqT3lZofaVEGtlR
	u2pH7yOUvPTMhcQeOzLIp8rhSek4MiDCbB1mgScPafiD+wDiO4OEzeISw2SjevFx
	/gisq0ozSo3S8dHc1FEJk+Jf0QOtPdXUvbstktObpe020dR6PWXdagtdY2agrZ54
	OA0K3sEFLjb4Zmman72x/Ccc2De3uotgVlm2Ny9HVPZQIVQThgkPtQfTXz/l1RUf
	A16lc5f3wOxFWKuk99JxsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757597104; x=
	1757683504; bh=OoJRhljIapU4tx2ZMn+bhtDibdkebMZJLIt4mqMQ/tI=; b=C
	oKDedu8U2/dhdRr5ckKUGTroxUGn7lqH9Sc56Q/7erVRa24bDNAuoOkJu1p/Tnhx
	VxTicHjtC/Wb3w0Hgs8sdbhTaGIMDz++UseriW9g9LCnbSXPQXT0DvD3CdT5K2K+
	OTyNc2/v2xhphS6Hf/1Mt6bDTb+5V/p4Xb4GnVj1QdtiOzHyRbcELR8caVzU+Zq2
	9th1j1Mlx2iuzKgRo9dEV4jyFUaUWrOn2GYCkUeL+Jt6RE/zvWVC/b2BaqqoqWXy
	uujPJ8qWkWeXSBNnGLxbQRPdHsZKNtHWrZYXoIn394W5xvlcgEOHsQhKA8pHldCR
	sOjuqHqgyOGYjTA8NDVcw==
X-ME-Sender: <xms:sM3CaG1yFgHyeOLOYy5LYmO_k77iNRiNGVkJGsbo6E98S0d1SWE3UA>
    <xme:sM3CaMWuVtgeAkpBqL46C2pI6xpmt10v2VdIZ0YRQi9D5BCPzqa7-jStwS0OvAmNI
    PvvRhqUOcHcy6Z75Q>
X-ME-Received: <xmr:sM3CaIXrU9qmsQ3fuRYt3KC0IFGAzQJINrDMt5tgzvCISueu6Tq0jsnhAgEjbMun1V1xiS4Dse44WQzKV8KL_mIBs-rV-eq8HaiQBWzTkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddviedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sM3CaDdBUjoW9M3EU6hbovB1jBnAefDj0UEU444Fi2MTAbbZNnvCSA>
    <xmx:sM3CaJWv4pYQ-t4YjHn5prRkQ-E1AXe15QHZeoILEnBYRxVHQf0sNw>
    <xmx:sM3CaEeqc2lWAjeqx2NFWe2pcBZOp2ljwPc2QJB6Nt3BlsZTmx4WHQ>
    <xmx:sM3CaNMK3r-nvAm1uixE1jgpPo7Sl8ahHmFVBLmCe2rwwFFMceZeHw>
    <xmx:sM3CaI9ryuJw_5l26oGh08YfnQQnMcms3vFFVZIwp-D8qZfWTbuRZ21x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 09:25:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 07e9b748 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 13:25:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Sep 2025 15:24:55 +0200
Subject: [PATCH 2/5] t1300: small style fixups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-pks-config-color-v1-2-3a7c79df65b1@pks.im>
References: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
In-Reply-To: <20250911-pks-config-color-v1-0-3a7c79df65b1@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

We have a couple of small style violations in t1300:

  - An empty newline at the start of the test body.

  - The test command is sometimes on the same line as the test name.

  - The closing single-quote is sometimes on the same line as the last
    command of the test.

Fix these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index bde9bda234..9c405e9532 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -458,9 +458,13 @@ EOF
 	test_cmp expect .git/config
 '
 
-test_expect_success 'invalid key' 'test_must_fail git config inval.2key blabla'
+test_expect_success 'invalid key' '
+	test_must_fail git config inval.2key blabla
+'
 
-test_expect_success 'correct key' 'git config 123456.a123 987'
+test_expect_success 'correct key' '
+	git config 123456.a123 987
+'
 
 test_expect_success 'hierarchical section' '
 	git config Version.1.2.3eX.Alpha beta
@@ -493,6 +497,7 @@ test_expect_success 'working --list' '
 	git config ${mode_prefix}list > output &&
 	test_cmp expect output
 '
+
 test_expect_success '--list without repo produces empty output' '
 	git --git-dir=nonexistent config ${mode_prefix}list >output &&
 	test_must_be_empty output
@@ -890,16 +895,17 @@ test_expect_success bool '
 	    git config --bool --get bool.true$i >>result &&
 	    git config --bool --get bool.false$i >>result || return 1
 	done &&
-	test_cmp expect result'
+	test_cmp expect result
+'
 
 test_expect_success 'invalid bool (--get)' '
-
 	git config ${mode_set} bool.nobool foobar &&
-	test_must_fail git config --bool --get bool.nobool'
+	test_must_fail git config --bool --get bool.nobool
+'
 
 test_expect_success 'invalid bool (set)' '
-
-	test_must_fail git config --bool bool.nobool foobar'
+	test_must_fail git config --bool bool.nobool foobar
+'
 
 test_expect_success 'set --bool' '
 	cat >expect<<\EOF &&
@@ -1002,7 +1008,8 @@ EOF
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
 	git config --path path.trailingtilde "foo~" &&
-	test_cmp expect .git/config'
+	test_cmp expect .git/config
+'
 
 if test_have_prereq !MINGW && test "${HOME+set}"
 then
@@ -1120,10 +1127,13 @@ EOF
 
 test_expect_success 'key with newline' '
 	test_must_fail git config ${mode_get} "key.with
-newline" 123'
+newline" 123
+'
 
-test_expect_success 'value with newline' 'git config ${mode_set} key.sub value.with\\\
-newline'
+test_expect_success 'value with newline' '
+	git config ${mode_set} key.sub value.with\\\
+newline
+'
 
 cat > .git/config <<\EOF
 [section]
@@ -1333,7 +1343,6 @@ test_expect_success 'multiple git -c appends config' '
 '
 
 test_expect_success 'last one wins: two level vars' '
-
 	# sec.var and sec.VAR are the same variable, as the first
 	# and the last level of a configuration variable name is
 	# case insensitive.
@@ -1352,7 +1361,6 @@ test_expect_success 'last one wins: two level vars' '
 '
 
 test_expect_success 'last one wins: three level vars' '
-
 	# v.a.r and v.A.r are not the same variable, as the middle
 	# level of a three-level configuration variable name is
 	# case sensitive.

-- 
2.51.0.450.g87641ccf93.dirty

