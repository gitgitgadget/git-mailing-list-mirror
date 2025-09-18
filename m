Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF012D838A
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 06:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758176074; cv=none; b=B1i7ita6NvYIQzzZm689y1x2CbaPCcayg23aKIgnX96cqr0+eRivNywc/S9YwolFXB5FqLrHYS+gTgf9K9MUzEYSKIhq12iB0XHRggePNpYDNbnshCgomlN6BKno7QIQH4MVeCYLK67RntBmcsLDWIfIkm94ABkWH68VLGPWN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758176074; c=relaxed/simple;
	bh=PFZqC6x+glGY7pWXBc9nWtV5/69ojoUCez/lKAC3scs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fszv3BahFxlN7oZKIqAHIVXDm1nVO+/4HW6FTTJikMN6c89rn6Ob1DW+UBqw/5cYNwXS9Bdre78Xy6Ii6XBzyLW01Phzy8DUVtFNoaSptIwB6pUHenKX1h2+BO77Sq93VTfl+88XiMakzpH1YfJOmEp88QskOLZaKgcfl4vQXZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QE+G98dc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CSfTOcvC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QE+G98dc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CSfTOcvC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E90C4EC023A;
	Thu, 18 Sep 2025 02:14:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Sep 2025 02:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758176071;
	 x=1758262471; bh=2kBNyW/5CDBR+HOsyihyRj3RBIXum48MNxx1metnASE=; b=
	QE+G98dcDkYYqfeK55+eVehS9yJLLa3NVolr4uraaAUoxA6cQGuukpnxnoLjOjmz
	8AQVDyxLNEmLSdlp1pEUOaVRiDAeYS+3Hk6k8opB5QB8OL9J5E99LKB9mxJtiiXd
	olqG0ejBqZAoJX76306NIj1xjI/KxTFhVDH9HGcHRU5Zvs541L7Xna+KEF+uabRb
	omawp08fi82+JSVnMhg72M9xFxr8nHGyMq4+odD4OXWB6hb1qw13+MoaUBiKl9tv
	5ZPpK3jYt7G/sAixp+m/S+s9zZcZ066SwbMH0syRnkgDbWIx6QPu0SH6bApd0PRu
	PTnizrww33Qj2DC33UABYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758176071; x=
	1758262471; bh=2kBNyW/5CDBR+HOsyihyRj3RBIXum48MNxx1metnASE=; b=C
	SfTOcvCZiyREPis7PbFMujCPrBjvjiyNhsGHobPBiJ/rB8znsl3WJoz6alTjxEvv
	E3+Y/QZby5clhUBwvYiZ9EL2B4REBTkvjv5E6H6ahBPFpA+bHWSVj0PnfFclMOv6
	2/uMO5e270Q1xHp7EXYmRpEVTTlI8mqctvn7koUqZyZjYrPMzAAtrWGefJJipcM/
	bEk72XqVqRicVmCDn22LkzjsPILF89oPEqh2bm5Abu22yYWSqqv5Md/+wCLYrPvm
	7nFTzTi5iCyJ15iMkB9G1NFfWB4AkD1BdkKkEUVFPlc8IBqzaHa8VMTmr7IizlBH
	JbxLjAXWnuqNODN2lEM3Q==
X-ME-Sender: <xms:R6PLaK0Qv5N25QFMHnba-Vrh4fgT0-93EVyWD2eS031i-VxbbURVjQ>
    <xme:R6PLaHqVu2R1pJ8AEM90-EozxEQvExxOjjRiLqy_XFcU67o_15h2o4olnowF54q5x
    y6E2hIzxuWOliyslg>
X-ME-Received: <xmr:R6PLaPdOwt1U7wkh7iDdU8gEBWyHNLYLrWDTYMFGCdi1UvucEAD8ysgcbwI0iJ56xgH3cfVxcb7DbU8PSIwvB2SdBxD6U3xxFcdNB4d1pA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegheehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:R6PLaOq-oqkrGOylPNTH458oO1AZLFtGmqXTSPXrLxUjj7GW6_D3ZA>
    <xmx:R6PLaIHTH6wH5lnKoPihJ3ZRJnxvGsTCnNZRujGbA2LIzXQzIsES4A>
    <xmx:R6PLaGsHakIMQtFFfEUIO5W1OwQ9c7c6ak7jgY-YRUG78XYQsDE2kQ>
    <xmx:R6PLaCUxoEWEmCfhbLG19Dbb37M-KETxFZ9tOQ0alw3vbL6K7DNPIg>
    <xmx:R6PLaIE3FgVZ0xOJhkpSfNvm6KWGvzH-lQZr4d3GKsTDyZOyLY28MNXo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Sep 2025 02:14:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bec3c3b0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 18 Sep 2025 06:14:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 18 Sep 2025 08:14:20 +0200
Subject: [PATCH v3 2/5] t1300: small style fixups
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-pks-config-color-v3-2-08ea618cae26@pks.im>
References: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
In-Reply-To: <20250918-pks-config-color-v3-0-08ea618cae26@pks.im>
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
2.51.0.534.gc79095c0ca.dirty

