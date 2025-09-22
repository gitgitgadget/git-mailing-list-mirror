Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A941309EF2
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 13:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758546392; cv=none; b=vDuZhsG0GZanpZPN1ELd/HXELMHVG/iM2R5vU2a8CvaE93OZkFbfWlbcrUwCcQkfQiSSZnVc9T7zoGiyD2ui6y8kxzTM5t6+EYOuoSXYPzrDCADVn1NSdV74KotwASUOeEAOAGIoaxi1zbHbgjKVB/hYnttlyQ6Sk4gT8ZT0uuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758546392; c=relaxed/simple;
	bh=mZSX880A1JsMYTNwP7znfDZmzT6AIOmAdusq3YAx7Dw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXhgPpg+6ocu5VAnCX5qzXsPmx6RKtAkkbw9uHhQ2ThXQVI6nTrbMFckar1I4rhQnJaxEUk09rymU6x84w1QATX8JsRNrgDIEkcFfYwd9E9aO8lDws0mjqA/o85oZo6+Fy2aHgLJ08zvWK8zN/rWWDxyVPrvjPSrUpyArGWzsGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RhZq8Wa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToI8qbgA; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RhZq8Wa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToI8qbgA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 57BA77A01EE;
	Mon, 22 Sep 2025 09:06:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 22 Sep 2025 09:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758546389;
	 x=1758632789; bh=WCcefz+oD2p/j0EzB+A9SIp7XkECVjE/D9kzmGDuwNE=; b=
	RhZq8Wa/u0/urfTCvS8pPiabJXygQE+WgK6orxLVy7Awf7AM1yEXqJEENGazWhvP
	I7WPQI9W21jsoiyyckjHvp4QC3FfH+WECc8ConDeg2W6QTpHNCKw17MAFMdoLFIw
	Gmgx7PyHGSf5zNp67fRfpAXrBOp9vKH4Q0ZoQuxrRdfrv8Gojq5nWe7sVBr3vRwk
	CLQkV0aPA0zRlBxR/kWyMRKp5SupWrWCNDIkfvLbXMTBAa8gtsBaX39L10PUTLx9
	GgbcmUqJ4ivL3EukTTFVGu7Cla13Wetg+SyermABOBIL0U4QliahOhe71TgkMxYY
	OY5oZLqWNc0eemxbjF+DMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758546389; x=
	1758632789; bh=WCcefz+oD2p/j0EzB+A9SIp7XkECVjE/D9kzmGDuwNE=; b=T
	oI8qbgAljNd3ZFBFlcKsOSc7JRFc/DEw1EYqDhZczFiy/BefPkLnAJddrHjAXo+s
	GJBvDUev9m5mg0+E0yQHIt723OhVXrOBfEAkUmjh8BxN+OuJWl3ufxQ8ufo+XQLh
	R/bmoQWTTvJ1IPePotZXBiIBicKIY3D+OFrCRpGvEauWFq5FK2JQ3ix0I6znhaRS
	ixmGl+JUmK4wld8nONpkASbnaLHkj887WMoVRTXKBQNIf8bY6m34DRsvTFd9eTcc
	xv0Y9uPfyPuc9JPL8BRLxZDNYzzZliA3zy/2qOXCjJmNEccs8DsvykcQtABuZBvp
	ZpUfMaDfr16Do/vv5dUEw==
X-ME-Sender: <xms:1UnRaLsp9A_ILGGBDZ3shi-qGUH-1BYs7d_-Y_yggFEpUrdiZ5jRaQ>
    <xme:1UnRaHDUwTitV0ZZwod58n9jVFD5YADVcK6Fhf5cch5Dvcco3hoHbv7Ks96VUszef
    EAT2W-E_bAihVFNxA>
X-ME-Received: <xmr:1UnRaLUhxB-QrUs8VfjFVz3q17nxIG-xAfoM5DMDzFN9g45VFgOTnUb74_WRKSDri4oW3Pi1aMQODE2PyD8rPkj68ui89xeT4ibYIkOvkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehs
    iigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1UnRaNAt6HI1mToxj4SE1taWpE7r81OgsbyFwz1BMqLSeQRcPYKKAg>
    <xmx:1UnRaG-vWnA7jdNtR8zDhP7xxzPsQ_XjRor4sD_-O2w7VvKOKX6hBQ>
    <xmx:1UnRaMF_edQOAD39zBuTqHJBLSnjjZxJ9WVC2jXL2GTnypLo71ZgnQ>
    <xmx:1UnRaMOxm98cs1rbDErUDfdrWPHKZtwagOKdA5f9wR1IEUOOM4RWSA>
    <xmx:1UnRaL-jFeeNQ2KS0A_R3GtNfJkoJ_2xZlEHzINUnRxxthXA5gWEe9Qm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 09:06:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e669ed1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 22 Sep 2025 13:06:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Sep 2025 15:06:19 +0200
Subject: [PATCH v4 2/5] t1300: small style fixups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-pks-config-color-v4-2-28b7d2697eed@pks.im>
References: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
In-Reply-To: <20250922-pks-config-color-v4-0-28b7d2697eed@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

We have a couple of small style violations in t1300:

  - An empty newline at the start of the test body.

  - The test command is sometimes on the same line as the test name.

  - The closing single-quote is sometimes on the same line as the last
    command of the test.

Fix these.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 538f2c9b8a..6d1015acfd 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -213,7 +213,9 @@ test_expect_success 'Prohibited LF in comment' '
 	test_must_fail git config ${mode_set} --comment="a${LF}b" section.k v
 '
 
-test_expect_success 'non-match result' 'test_cmp expect .git/config'
+test_expect_success 'non-match result' '
+	test_cmp expect .git/config
+'
 
 test_expect_success 'find mixed-case key by canonical name' '
 	test_cmp_config Second sections.whatever
@@ -455,9 +457,13 @@ EOF
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
@@ -490,6 +496,7 @@ test_expect_success 'working --list' '
 	git config ${mode_prefix}list > output &&
 	test_cmp expect output
 '
+
 test_expect_success '--list without repo produces empty output' '
 	git --git-dir=nonexistent config ${mode_prefix}list >output &&
 	test_must_be_empty output
@@ -887,16 +894,17 @@ test_expect_success bool '
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
 	cat >expect <<\EOF &&
@@ -999,7 +1007,8 @@ EOF
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
 	git config --path path.trailingtilde "foo~" &&
-	test_cmp expect .git/config'
+	test_cmp expect .git/config
+'
 
 if test_have_prereq !MINGW && test "${HOME+set}"
 then
@@ -1117,10 +1126,13 @@ EOF
 
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
@@ -1330,7 +1342,6 @@ test_expect_success 'multiple git -c appends config' '
 '
 
 test_expect_success 'last one wins: two level vars' '
-
 	# sec.var and sec.VAR are the same variable, as the first
 	# and the last level of a configuration variable name is
 	# case insensitive.
@@ -1349,7 +1360,6 @@ test_expect_success 'last one wins: two level vars' '
 '
 
 test_expect_success 'last one wins: three level vars' '
-
 	# v.a.r and v.A.r are not the same variable, as the middle
 	# level of a three-level configuration variable name is
 	# case sensitive.

-- 
2.51.0.536.g15c5d4f767.dirty

