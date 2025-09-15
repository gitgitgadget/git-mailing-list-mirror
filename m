Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECE30BBB7
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940782; cv=none; b=OnoetDx9gOKya5qSNBlZN4marGKFmoZajCoGGpoHaWCiPPUxGOWm2uV8rP7YaUcmBP2UMOS0MHw69lhTUywqXGVz6ieDYfrJFJ7CMNiTTppZDtpR1KVzvaaNquZkE383vTzUr0VCZKFJLsCth1XgHbFisyu34vGVBweDmnEbLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940782; c=relaxed/simple;
	bh=rSv/lX97UU9oGzlZ4oIcvahO8Exg6cfuQhW0Wdy1S4o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MGlBAR9Es3JmwlQvNMy9JFkr5jUSglGT0Er75/n2iu0YCKnk9XUkHuNO2B4kTeNdqaJ+c/v4UAdna9Ne4ouMDC0EdRLL0LmVY90VCZSKClpse3vPme6qXpMVgxKgam6QZ5S55oHeDGisZwgfXI3NGldzXByqPLFmIDVXvhi1j1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jqMw/syq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L+mSoWDg; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jqMw/syq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L+mSoWDg"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 53341EC02C8;
	Mon, 15 Sep 2025 08:52:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 15 Sep 2025 08:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940779;
	 x=1758027179; bh=gaQ85B+sfZ+fo6nn+QQJ/Idn8+ToB8St7gyiB0VMPtk=; b=
	jqMw/syq91ubIscnxWSKnx/XXCBiuNlCcMiS26zTf+uXwgFl8DjOzWpb9+D1G1Qr
	Zwo/Fgpe1mt97yaqzfiJH8Uq8WOKMcxps5x7nEic8S8YEfqIFS13fjdqPQdVwI9F
	8dKxRHE03v1z8z/wgqzDvHJwm8XNRPqJRggH7ZjNMPOLzEXL7wJcH9buNWTh11s/
	KMnhpo7jeQXQ+MMs3fxI0MrRw3oSKf5tGchUQCY7wm8WYYKWXRgKkU4ySZh20EVD
	X3BhoAd+CLzC+3UK13VW2GtQn2/TElfbGiTuF7IyYSxjzylvrvGXBev1mfBwAOtm
	qnL1JPUtC8k8IdgZesHFAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940779; x=
	1758027179; bh=gaQ85B+sfZ+fo6nn+QQJ/Idn8+ToB8St7gyiB0VMPtk=; b=L
	+mSoWDgMq6f4BR+iHdzwl2303xDEMpzxRjQkRMabAPeHpMF7+4qNDX57Ju6JKvrr
	cEo4f3C8CWYOyYnH58olgUdf76zyaRKwlM0wXOauQvtLHaz8rui9aacfcfPA3t16
	3iLNqSys48PDCUSEsip1DO9NNqDiSYe2CjQ3nyL7ITdt83iStbIUR2YLAza4OqJs
	sVG21jvhvl6yPhMTq4D3C9QX1B8wkEpvlg3xP7XO+wc1G0CAMvxlOuSWygnWTEo7
	yjWr9BlXlnwvwdbUBfPvrqEwYMtO6AbD9mLrAw5JaLAUedPvs1RJpWmIuMJBO0Mh
	JLWiHoH6HAXKuvT2uHTng==
X-ME-Sender: <xms:KwzIaGMxES0s4Lma3HAOWdl6CsYdvnPNCUsJkhV5xVO1hOWXN5Y7Dw>
    <xme:KwzIaPgG33FlKs8DtIDoTdjV7vrw6fsFf78xTlzwv1QUgLJKAXsPhFA7q91ThgEO9
    bb9HRbGOPppMvimow>
X-ME-Received: <xmr:KwzIaJ3V-DGB5SnE_POsR-Cc5zb9W9Z8aVMyE0r26C5-G_zNZE4F_Wxg2T7dmKjGMBxNkWRMRuaI31fkcTQvEmVW5hqdHMP-hSb6GQCNOS4jog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:KwzIaJg325YDHEo3nDmq5uiXHhdwI_oGEZYCIY3hG0u6mf59K4uFWw>
    <xmx:KwzIaJeJ_409cCpY3xCtahZqfh1Lbpym726MdIHIje22xGzTGFN9Cg>
    <xmx:KwzIaMlSilxPkN2nWCNaQOkvWcszrQbV7R2JVxgFdS3Kna1ENDGvjw>
    <xmx:KwzIaCu8vmfaIj8mWk334LZ6DbPZc0XYkufZHM7jHqjr1yj6-F-9lQ>
    <xmx:KwzIaO5rwwHhPMjZCM5qo9qV0sSVGxjDT5i55ADRlPTo_mALE2C47pVi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:52:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7ad1ebf7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:52:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 14:52:49 +0200
Subject: [PATCH v2 2/5] t1300: small style fixups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pks-config-color-v2-2-e4290bd8d13c@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
In-Reply-To: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
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
2.51.0.450.g87641ccf93.dirty

