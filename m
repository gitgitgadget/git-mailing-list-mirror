Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959F306B23
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940779; cv=none; b=FdNwVN6gugVfAkcrMDIznIEmuOf1vyNQjyjU2UCrWNTaw/zH+nAkO0VDhv56qTgOlPqgeKRJCPZebm3dc9hwej/3TbYe1z+GlPvojB4j4mFWOXy0+Z5wNCVq2ePMcnDT/JKspadW1X6dx2RdGj9lgv2e0iQ2yAVCVVM9Pb1HCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940779; c=relaxed/simple;
	bh=zfw0UqPwtu4BxU/PiuxxbqS8a2FU1tmWrfSgj9zGHI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c62HELgv5uIMuldgUnFiEPb5XePaHKPbw1JXRAHHKwSBmouRGiQnqeGGRUYHm5flf3u4ZCCBcphXIa65X1Nms/tVlKLPqgmYXJANDN+j8HQHOQ/F64dMJ9OyCH4m0kpEeYOnL/7aW915bIhyOfD3W6U3sDAtV2dot94jlx02OOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KF3Ka3+p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZFs3WJ6P; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KF3Ka3+p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZFs3WJ6P"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2A3B514001C1;
	Mon, 15 Sep 2025 08:52:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 15 Sep 2025 08:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757940776;
	 x=1758027176; bh=2bCE59IhFlI1W6/10xCqUqczljj/6vi0qi2PhVGiOO4=; b=
	KF3Ka3+pQq3WFWW316kdCsx/GO/rk9hoP6lso+EAnlbDQyEAwDGLrnl1AAR+Xqx9
	f6QG/AB3s/CDC2cWhRpm1f7dvbvfFwF4xDRKdF1zG7g0wwl8N1HxRT94oiLotvKS
	RLzAwS576h9s3EgojBGv5R1+6uVEX+7JVvKb50EgRh2CZgCizy0njcpSK6ZSSiYL
	DFPyR2CkoDuuoBEDHOBKzXdaVC5quejGiCMjYg3PUSH02f9nXQs3olp9QBUBsXSU
	4nj8Csy/lL9kAYMJWn5N7l1rMddbj0eITBDirJk4YOH3PzgQh+k+TVhi11hhIqc9
	Cb7nVRC57hfeoBjfyeGppg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757940776; x=
	1758027176; bh=2bCE59IhFlI1W6/10xCqUqczljj/6vi0qi2PhVGiOO4=; b=Z
	Fs3WJ6PP7PUUEcrexS15JMvPgz6XCGUIh73doSz92fLSgEFdbWIzc78Q0N5rqzMj
	lJuvlX39hsYPqfFIfVdAY3BR6jM6BeuSeCB2UWhRQsdbnh2ejB3kxh3taEqKKpNE
	b9lT2pzruv0hno7v3uTym1bSPHGTBA3ew/3UWEQw5xLJkuHJpa3LJy6QXw+DT1qu
	/whausrVp3uAFwWRpiA9QSgj5MuNGGyLw2tAprSbnq1gVt8ylV2yvzRgo7Gre6ZD
	ftGSLq+eZ+wBuKlcLDfYtlJ2877/E054UJnEGNjEfHB6+MxJMggL0BkAUq6pDHHW
	3IUlgs4RIokiMDPwxdlIw==
X-ME-Sender: <xms:JwzIaLe6xS6afFBjj-pAcPlfc4pdpoDAteN-cPiBWHg0c5O-O5Ye1w>
    <xme:JwzIaLz3jtAICH5iK6QDcXuzTCP_LpN_q_cGBcSe6xYxryHbcFCPmS8q-Jb_BjUxH
    2GFovaI6V53uu0ofA>
X-ME-Received: <xmr:JwzIaBFx4oG8zArvwAR46QQ2RrDgp0Eojo-doBtBOBQsqT_4t6T-DqanhyCjlPROZTyTE2MiNad_2XkZj56pCYV05iRF6gdHFWqW9RUNMy-wkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdguvghvse
    hgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:JwzIaPyf7GUpVwBuE9ZN2578SISr7BVEkyCAZY8yhpxvZv5gaNsmDw>
    <xmx:KAzIaCvUYlCUVnkasbQ4ojNjPdqkZHba8a6W9YCR8Y4KXA_Y_YqU-A>
    <xmx:KAzIaM0LQm72ocm-GHiDdXDnNQXQpFT3C3FQMY7ZrEo6X3Aj7BxUpA>
    <xmx:KAzIaN8a4grzJ66YvwFKBL-Fh6HNk9KwZmlDxnLrbpg6rlKCGVO3IQ>
    <xmx:KAzIaBs-kp8-RJ8PrK8Wqh_niI4H6sv1OVVxkdPFez3r65ug_5kgEQAE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 08:52:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2609ec79 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 15 Sep 2025 12:52:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 15 Sep 2025 14:52:48 +0200
Subject: [PATCH v2 1/5] t1300: write test expectations in the test's body
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pks-config-color-v2-1-e4290bd8d13c@pks.im>
References: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
In-Reply-To: <20250915-pks-config-color-v2-0-e4290bd8d13c@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.2

There are a bunch of tests in t1300 where we write the test expectation
handed over to `test_cmp ()` outside of the test body. This does not
match our modern test style, and there isn't really a reason why this
would need to happen outside of the test bodies.

Convert those to instead do so as part of the test itself. While at it,
normalize these tests to use `<<\EOF` for those that don't use variable
expansion and `<<-EOF` for those that aren't sensitive to indentation.

Note that there are two exceptions that we leave as-is for now since
they are reused across tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 291 ++++++++++++++++++++++++------------------------------
 1 file changed, 128 insertions(+), 163 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f856821839..538f2c9b8a 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -134,38 +134,39 @@ test_expect_success 'clear default config' '
 	rm -f .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'initial' '
+	cat >expect <<\EOF &&
 [section]
 	penguin = little blue
 EOF
-test_expect_success 'initial' '
 	git config ${mode_set} section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'mixed case' '
+	cat >expect <<\EOF &&
 [section]
 	penguin = little blue
 	Movie = BadPhysics
 EOF
-test_expect_success 'mixed case' '
 	git config ${mode_set} Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'similar section' '
+	cat >expect <<\EOF &&
 [section]
 	penguin = little blue
 	Movie = BadPhysics
 [Sections]
 	WhatEver = Second
 EOF
-test_expect_success 'similar section' '
 	git config ${mode_set} Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'uppercase section' '
+	cat >expect <<\EOF &&
 [section]
 	penguin = little blue
 	Movie = BadPhysics
@@ -173,7 +174,6 @@ cat > expect << EOF
 [Sections]
 	WhatEver = Second
 EOF
-test_expect_success 'uppercase section' '
 	git config ${mode_set} SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
@@ -186,7 +186,8 @@ test_expect_success 'replace with non-match (actually matching)' '
 	git config section.penguin "very blue" !kingpin
 '
 
-cat > expect << EOF
+test_expect_success 'append comments' '
+	cat >expect <<\EOF &&
 [section]
 	Movie = BadPhysics
 	UPPERCASE = true
@@ -198,8 +199,6 @@ cat > expect << EOF
 [Sections]
 	WhatEver = Second
 EOF
-
-test_expect_success 'append comments' '
 	git config --replace-all --comment="Pygoscelis papua" section.penguin gentoo &&
 	git config ${mode_set} --comment="find fish" section.disposition peckish &&
 	git config ${mode_set} --comment="#abc" section.foo bar &&
@@ -265,14 +264,15 @@ test_expect_success 'unset with cont. lines' '
 	git config ${mode_unset} beta.baz
 '
 
-cat > expect <<\EOF
-[alpha]
-bar = foo
-[beta]
-foo = bar
-EOF
-
-test_expect_success 'unset with cont. lines is correct' 'test_cmp expect .git/config'
+test_expect_success 'unset with cont. lines is correct' '
+	cat >expect <<-\EOF &&
+	[alpha]
+	bar = foo
+	[beta]
+	foo = bar
+	EOF
+	test_cmp expect .git/config
+'
 
 cat > .git/config << EOF
 [beta] ; silly comment # another comment
@@ -292,16 +292,15 @@ test_expect_success 'multiple unset' '
 	git config ${mode_unset_all} beta.haha
 '
 
-cat > expect << EOF
+test_expect_success 'multiple unset is correct' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
 [nextSection] noNewline = ouch
 EOF
-
-test_expect_success 'multiple unset is correct' '
 	test_cmp expect .git/config
 '
 
@@ -318,37 +317,37 @@ test_expect_success '--replace-all' '
 	git config ${mode_replace_all} beta.haha gamma
 '
 
-cat > expect << EOF
+test_expect_success 'all replaced' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
 	haha = gamma
 [nextSection] noNewline = ouch
 EOF
-
-test_expect_success 'all replaced' '
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'really mean test' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
 	haha = alpha
 [nextSection] noNewline = ouch
 EOF
-test_expect_success 'really mean test' '
 	git config ${mode_set} beta.haha alpha &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'really really mean test' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
@@ -356,7 +355,6 @@ noIndent= sillyValue ; 'nother silly comment
 [nextSection]
 	nonewline = wow
 EOF
-test_expect_success 'really really mean test' '
 	git config ${mode_set} nextsection.nonewline wow &&
 	test_cmp expect .git/config
 '
@@ -365,23 +363,24 @@ test_expect_success 'get value' '
 	test_cmp_config alpha beta.haha
 '
 
-cat > expect << EOF
+test_expect_success 'unset' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
 [nextSection]
 	nonewline = wow
 EOF
-test_expect_success 'unset' '
 	git config ${mode_unset} beta.haha &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'multivar' '
+	cat  >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
@@ -389,7 +388,6 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow
 	NoNewLine = wow2 for me
 EOF
-test_expect_success 'multivar' '
 	git config nextsection.NoNewLine "wow2 for me" "for me$" &&
 	test_cmp expect .git/config
 '
@@ -415,9 +413,10 @@ test_expect_success 'multi-valued get-all returns all' '
 	test_cmp expect actual
 '
 
-cat > expect << EOF
+test_expect_success 'multivar replace' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
@@ -425,7 +424,6 @@ noIndent= sillyValue ; 'nother silly comment
 	nonewline = wow3
 	NoNewLine = wow2 for me
 EOF
-test_expect_success 'multivar replace' '
 	git config nextsection.nonewline "wow3" "wow$" &&
 	test_cmp expect .git/config
 '
@@ -438,17 +436,16 @@ test_expect_success 'invalid unset' '
 	test_must_fail git config ${mode_unset} somesection.nonewline
 '
 
-cat > expect << EOF
+test_expect_success 'multivar unset' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
 [nextSection]
 	NoNewLine = wow2 for me
 EOF
-
-test_expect_success 'multivar unset' '
 	case "$mode" in
 	legacy)
 		git config --unset nextsection.nonewline "wow3$";;
@@ -466,9 +463,10 @@ test_expect_success 'hierarchical section' '
 	git config Version.1.2.3eX.Alpha beta
 '
 
-cat > expect << EOF
+test_expect_success 'hierarchical section value' '
+	cat >expect <<EOF &&
 [beta] ; silly comment # another comment
-noIndent= sillyValue ; 'nother silly comment
+noIndent= sillyValue ; ${SQ}nother silly comment
 
 # empty line
 		; comment
@@ -479,19 +477,16 @@ noIndent= sillyValue ; 'nother silly comment
 [Version "1.2.3eX"]
 	Alpha = beta
 EOF
-
-test_expect_success 'hierarchical section value' '
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
-beta.noindent=sillyValue
-nextsection.nonewline=wow2 for me
-123456.a123=987
-version.1.2.3eX.alpha=beta
-EOF
-
 test_expect_success 'working --list' '
+	cat >expect <<-\EOF &&
+	beta.noindent=sillyValue
+	nextsection.nonewline=wow2 for me
+	123456.a123=987
+	version.1.2.3eX.alpha=beta
+	EOF
 	git config ${mode_prefix}list > output &&
 	test_cmp expect output
 '
@@ -500,44 +495,40 @@ test_expect_success '--list without repo produces empty output' '
 	test_must_be_empty output
 '
 
-cat > expect << EOF
-beta.noindent
-nextsection.nonewline
-123456.a123
-version.1.2.3eX.alpha
-EOF
-
 test_expect_success '--name-only --list' '
+	cat >expect <<-\EOF &&
+	beta.noindent
+	nextsection.nonewline
+	123456.a123
+	version.1.2.3eX.alpha
+	EOF
 	git config ${mode_prefix}list --name-only >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-beta.noindent sillyValue
-nextsection.nonewline wow2 for me
-EOF
-
 test_expect_success '--get-regexp' '
+	cat >expect <<-\EOF &&
+	beta.noindent sillyValue
+	nextsection.nonewline wow2 for me
+	EOF
 	git config ${mode_get_regexp} in >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-beta.noindent
-nextsection.nonewline
-EOF
-
 test_expect_success '--name-only --get-regexp' '
+	cat >expect <<-\EOF &&
+	beta.noindent
+	nextsection.nonewline
+	EOF
 	git config ${mode_get_regexp} --name-only in >output &&
 	test_cmp expect output
 '
 
-cat > expect << EOF
-wow2 for me
-wow4 for you
-EOF
-
 test_expect_success '--add' '
+	cat >expect <<-\EOF &&
+	wow2 for me
+	wow4 for you
+	EOF
 	git config --add nextsection.nonewline "wow4 for you" &&
 	git config ${mode_get_all} nextsection.nonewline > output &&
 	test_cmp expect output
@@ -558,37 +549,32 @@ test_expect_success 'get variable with empty value' '
 	git config --get emptyvalue.variable ^$
 '
 
-echo novalue.variable > expect
-
 test_expect_success 'get-regexp variable with no value' '
+	echo novalue.variable >expect &&
 	git config ${mode_get_regexp} novalue > output &&
 	test_cmp expect output
 '
 
-echo 'novalue.variable true' > expect
-
 test_expect_success 'get-regexp --bool variable with no value' '
+	echo "novalue.variable true" >expect &&
 	git config ${mode_get_regexp} --bool novalue > output &&
 	test_cmp expect output
 '
 
-echo 'emptyvalue.variable ' > expect
-
 test_expect_success 'get-regexp variable with empty value' '
+	echo "emptyvalue.variable " >expect &&
 	git config ${mode_get_regexp} emptyvalue > output &&
 	test_cmp expect output
 '
 
-echo true > expect
-
 test_expect_success 'get bool variable with no value' '
+	echo true >expect &&
 	git config --bool novalue.variable > output &&
 	test_cmp expect output
 '
 
-echo false > expect
-
 test_expect_success 'get bool variable with empty value' '
+	echo false >expect &&
 	git config --bool emptyvalue.variable > output &&
 	test_cmp expect output
 '
@@ -604,19 +590,19 @@ cat > .git/config << EOF
 	c = d
 EOF
 
-cat > expect << EOF
+test_expect_success 'new section is partial match of another' '
+	cat >expect <<\EOF &&
 [a.b]
 	c = d
 [a]
 	x = y
 EOF
-
-test_expect_success 'new section is partial match of another' '
 	git config a.x y &&
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'new variable inserts into proper section' '
+	cat >expect <<\EOF &&
 [a.b]
 	c = d
 [a]
@@ -625,8 +611,6 @@ cat > expect << EOF
 [b]
 	x = y
 EOF
-
-test_expect_success 'new variable inserts into proper section' '
 	git config b.x y &&
 	git config a.b c &&
 	test_cmp expect .git/config
@@ -642,11 +626,10 @@ cat > other-config << EOF
 	bahn = strasse
 EOF
 
-cat > expect << EOF
-ein.bahn=strasse
-EOF
-
 test_expect_success 'alternative GIT_CONFIG' '
+	cat >expect <<-\EOF &&
+	ein.bahn=strasse
+	EOF
 	GIT_CONFIG=other-config git config ${mode_prefix}list >output &&
 	test_cmp expect output
 '
@@ -675,14 +658,13 @@ test_expect_success 'refer config from subdirectory' '
 	test_cmp_config -C x strasse --file=../other-config --get ein.bahn
 '
 
-cat > expect << EOF
+test_expect_success '--set in alternative file' '
+	cat >expect <<\EOF &&
 [ein]
 	bahn = strasse
 [anwohner]
 	park = ausweis
 EOF
-
-test_expect_success '--set in alternative file' '
 	git config --file=other-config anwohner.park ausweis &&
 	test_cmp expect other-config
 '
@@ -730,7 +712,8 @@ test_expect_success 'rename another section' '
 	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branch.drei
 '
 
-cat > expect << EOF
+test_expect_success 'rename succeeded' '
+	cat >expect <<\EOF &&
 # Hallo
 	#Bello
 [branch "zwei"]
@@ -740,8 +723,6 @@ cat > expect << EOF
 [branch "drei"]
 weird
 EOF
-
-test_expect_success 'rename succeeded' '
 	test_cmp expect .git/config
 '
 
@@ -753,7 +734,8 @@ test_expect_success 'rename a section with a var on the same line' '
 	git config ${mode_prefix}rename-section branch.vier branch.zwei
 '
 
-cat > expect << EOF
+test_expect_success 'rename succeeded' '
+	cat >expect <<\EOF &&
 # Hallo
 	#Bello
 [branch "zwei"]
@@ -765,8 +747,6 @@ weird
 [branch "zwei"]
 	z = 1
 EOF
-
-test_expect_success 'rename succeeded' '
 	test_cmp expect .git/config
 '
 
@@ -816,32 +796,29 @@ test_expect_success 'remove section' '
 	git config ${mode_prefix}remove-section branch.zwei
 '
 
-cat > expect << EOF
+test_expect_success 'section was removed properly' '
+	cat >expect <<\EOF &&
 # Hallo
 	#Bello
 [branch "drei"]
 weird
 EOF
-
-test_expect_success 'section was removed properly' '
 	test_cmp expect .git/config
 '
 
-cat > expect << EOF
+test_expect_success 'section ending' '
+	cat >expect <<\EOF &&
 [gitcvs]
 	enabled = true
 	dbname = %Ggitcvs2.%a.%m.sqlite
 [gitcvs "ext"]
 	dbname = %Ggitcvs1.%a.%m.sqlite
 EOF
-
-test_expect_success 'section ending' '
 	rm -f .git/config &&
 	git config ${mode_set} gitcvs.enabled true &&
 	git config ${mode_set} gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
 	git config ${mode_set} gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	test_cmp expect .git/config
-
 '
 
 test_expect_success numbers '
@@ -885,19 +862,17 @@ test_expect_success 'invalid stdin config' '
 	test_grep "bad config line 1 in standard input" output
 '
 
-cat > expect << EOF
-true
-false
-true
-false
-true
-false
-true
-false
-EOF
-
 test_expect_success bool '
-
+	cat >expect <<-\EOF &&
+	true
+	false
+	true
+	false
+	true
+	false
+	true
+	false
+	EOF
 	git config ${mode_set} bool.true1 01 &&
 	git config ${mode_set} bool.true2 -1 &&
 	git config ${mode_set} bool.true3 YeS &&
@@ -923,7 +898,8 @@ test_expect_success 'invalid bool (set)' '
 
 	test_must_fail git config --bool bool.nobool foobar'
 
-cat > expect <<\EOF
+test_expect_success 'set --bool' '
+	cat >expect <<\EOF &&
 [bool]
 	true1 = true
 	true2 = true
@@ -934,9 +910,6 @@ cat > expect <<\EOF
 	false3 = false
 	false4 = false
 EOF
-
-test_expect_success 'set --bool' '
-
 	rm -f .git/config &&
 	git config --bool bool.true1 01 &&
 	git config --bool bool.true2 -1 &&
@@ -948,15 +921,13 @@ test_expect_success 'set --bool' '
 	git config --bool bool.false4 FALSE &&
 	test_cmp expect .git/config'
 
-cat > expect <<\EOF
+test_expect_success 'set --int' '
+	cat >expect <<\EOF &&
 [int]
 	val1 = 1
 	val2 = -1
 	val3 = 5242880
 EOF
-
-test_expect_success 'set --int' '
-
 	rm -f .git/config &&
 	git config --int int.val1 01 &&
 	git config --int int.val2 -1 &&
@@ -994,7 +965,8 @@ test_expect_success 'get --bool-or-int' '
 	test_cmp expect actual
 '
 
-cat >expect <<\EOF
+test_expect_success 'set --bool-or-int' '
+	cat >expect <<\EOF &&
 [bool]
 	true1 = true
 	false1 = false
@@ -1005,8 +977,6 @@ cat >expect <<\EOF
 	int2 = 1
 	int3 = -1
 EOF
-
-test_expect_success 'set --bool-or-int' '
 	rm -f .git/config &&
 	git config --bool-or-int bool.true1 true &&
 	git config --bool-or-int bool.false1 false &&
@@ -1018,14 +988,13 @@ test_expect_success 'set --bool-or-int' '
 	test_cmp expect .git/config
 '
 
-cat >expect <<\EOF
+test_expect_success !MINGW 'set --path' '
+	cat >expect <<\EOF &&
 [path]
 	home = ~/
 	normal = /dev/null
 	trailingtilde = foo~
 EOF
-
-test_expect_success !MINGW 'set --path' '
 	rm -f .git/config &&
 	git config --path path.home "~/" &&
 	git config --path path.normal "/dev/null" &&
@@ -1037,25 +1006,23 @@ then
 	test_set_prereq HOMEVAR
 fi
 
-cat >expect <<EOF
-$HOME/
-/dev/null
-foo~
-EOF
-
 test_expect_success HOMEVAR 'get --path' '
+	cat >expect <<-EOF &&
+	$HOME/
+	/dev/null
+	foo~
+	EOF
 	git config --get --path path.home > result &&
 	git config --get --path path.normal >> result &&
 	git config --get --path path.trailingtilde >> result &&
 	test_cmp expect result
 '
 
-cat >expect <<\EOF
-/dev/null
-foo~
-EOF
-
 test_expect_success !MINGW 'get --path copes with unset $HOME' '
+	cat >expect <<-\EOF &&
+	/dev/null
+	foo~
+	EOF
 	(
 		sane_unset HOME &&
 		test_must_fail git config --get --path path.home \
@@ -1112,12 +1079,11 @@ test_expect_success 'get --type=color' '
 	test_cmp expect actual
 '
 
-cat >expect << EOF
+test_expect_success 'set --type=color' '
+	cat >expect <<\EOF &&
 [foo]
 	color = red
 EOF
-
-test_expect_success 'set --type=color' '
 	rm .git/config &&
 	git config --type=color foo.color "red" &&
 	test_cmp expect .git/config
@@ -1133,14 +1099,14 @@ test_expect_success 'set --type=color barfs on non-color' '
 	test_grep "cannot parse color" error
 '
 
-cat > expect << EOF
+test_expect_success 'quoting' '
+	cat >expect <<\EOF &&
 [quote]
 	leading = " test"
 	ending = "test "
 	semicolon = "test;test"
 	hash = "test#test"
 EOF
-test_expect_success 'quoting' '
 	rm -f .git/config &&
 	git config ${mode_set} quote.leading " test" &&
 	git config ${mode_set} quote.ending "test " &&
@@ -1166,13 +1132,12 @@ inued
 inued"
 EOF
 
-cat > expect <<\EOF
-section.continued=continued
-section.noncont=not continued
-section.quotecont=cont;inued
-EOF
-
 test_expect_success 'value continued on next line' '
+	cat >expect <<-\EOF &&
+	section.continued=continued
+	section.noncont=not continued
+	section.quotecont=cont;inued
+	EOF
 	git config ${mode_prefix}list > result &&
 	test_cmp expect result
 '

-- 
2.51.0.450.g87641ccf93.dirty

