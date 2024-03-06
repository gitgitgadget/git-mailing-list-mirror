Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC678682
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724727; cv=none; b=SLxu1IBzFpBPymiuJurATv+iEskHxjJ2DxNVAon59E4q1Pt3ZLt6BWerUREZZp8MiaOpKRRx/4FXlDFUf4c+UETHJ/202nQPngUi9nrQCCUksNmuiYg9U3fOLbHS9fYfXc6wh6K4FJy7AZpcAHjDncrAsA3pgSxRONxvYqf4IIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724727; c=relaxed/simple;
	bh=MAH7nMaDfoC+tuE7RLGuSbDBqZkgrzNoisf/RxNB600=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsiG7KETOia6YU8mrg+iyEY9RAB0vRgaEi3wPiKvo7srMUdM02ux3ST2A71gRvzyHXip9Owq04ffBuDjrb1oXPQf2C8G0k104hncqv7GbWqQm0gZVG7oJasGWidr4VQKkPH85l6iJLdP4nGA6gaWQJlFG4/c6qXkLRuj69BlVng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CyL5XPnz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jahr4AQ3; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CyL5XPnz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jahr4AQ3"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D01D61140098
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:32:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 06 Mar 2024 06:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724721; x=1709811121; bh=Z4qG4epX/U
	n2UO8UTnbvWv353f1aU5hgiM1PqZ1IozA=; b=CyL5XPnz8MimS1ctbhKQMK1fLh
	lILU5xyNr65YpXcZ5JhBwokQPlvALnC5nM1ZTXMICSeGNG5qVhJBaZdhbF267E/6
	EQwSPGUHUUvJcqF4VGp58Hy5SpLX85sPHYxypX/7TPNUWe7wwEmeuobh0zt11i58
	e2blXBsCM5vjsRdeuy2LqZMj9iWM5sdt2YhwBSahVYSUz19yg5+8DcBrjUnUwZpQ
	AW6Zx+2OiaHIaaqn6MJ/qD9dE5cFaFOVPxYH2bCU4/9Z2+9UbXwaRz5V2nq0Xcu1
	pIBIj9IZC4b8YH8h84IXoWdo/oq1k7sS1Gr3BDAYAgTiYPB7qbYk33S11yCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724721; x=1709811121; bh=Z4qG4epX/Un2UO8UTnbvWv353f1a
	U5hgiM1PqZ1IozA=; b=Jahr4AQ3BQ6JbUAiFLjhF0v6qF1lQt8/PtGEdWDti+Ub
	i7Pd8wPO7mIV0xgiXK1lo513xFMJJ0FfD8JqnysI1WaWCEamAC5CzxCh5JPgOCPg
	2zUyLTA1l8vH2Hay+Fz+zpBWKIvmoKW4VVsDvwhSHWdl8yOYFxh5u8Dw+eDPgjis
	BiEqG1MHDS9m+r8DUwAmIyMkFHZq7wHxNEX316B/XtGccPQ6hBo1nigR4xiYBS5A
	XDkjNQVVIxlqSRx3oLb4C9UkxtHFb1d1GCWvTnaivI6DgcrD2rW2NWghASW9m8Mv
	/ChXbkXfJyWS2+J7hDkcyZR+Ar1idh4xkvC8Sx573w==
X-ME-Sender: <xms:MVToZezOJmBSyUtw3moqg6tf3PxIeDH1ZtmJsEN4TeuH1FOsGkD92w>
    <xme:MVToZaQ-9H9cfGLtvzlOLk6vZqzayX3vlIjkwdUo5Urz5Pm4B5J1oVmqdc7kUnCOh
    DMmWOTUnVEDNQ2gWA>
X-ME-Received: <xmr:MVToZQVc1tmgmsUpl7BvuSVJQ4OMoguD07ErGL5MsZK2HRHAePz1TOIBcZFJudSLnieyiZkrE8R6QIzaLpuNpBfnSdBs1PBNoRoOHW1PS4mqJ6vrgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddviecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecuuhhsvghruchinhculhhinhhkucdliedtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    ekvddvkeeileekhfdvhfekheefteevtdejhfeffeeltedvgedvlefhheetgeejnecuffho
    mhgrihhnpehunhhithdrihhnpdgvgigrmhhplhgvrdgtohhmpdgvgigrmhhplhgvrdhorh
    hgpdhgohhougdqvgigrghmphhlvgdrtghomhdpvgigrghmphhlvgdrtghomhdrrghunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:MVToZUgYccZtrYc85kENsYxgtEqNP8awzOqS9L44D3jyU_8hsEocgQ>
    <xmx:MVToZQDLmyiGTu9h423SW0VIAgrWBb6RAvR4v6UoMiaJx4tINJZXmw>
    <xmx:MVToZVILnuc7itMGo2UjtYft_2yCjf0szMWQV9xZAMoIfFh_v3WPdw>
    <xmx:MVToZZ7kZyj2ZHHXTItsyKZNy0U0VnxCTem1O24hxJ20N8hYxmPrlA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:32:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b24e2d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:31 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/8] t1300: exercise both old- and new-style modes
Message-ID: <4ad65cb8d6e325d8a14f8d81d0904f7819c76155.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IAgDz8puPWyiJQwX"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--IAgDz8puPWyiJQwX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert t1300 so that tests exercise both the old and new-style way to
specify the mode.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1300-config.sh | 721 ++++++++++++++++++++++++----------------------
 1 file changed, 375 insertions(+), 346 deletions(-)

diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 2d1bc1e27e..705c17a1fb 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -11,6 +11,24 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+for style in old new
+do
+
+case "$style" in
+old)
+	mode_prefix=3D"--"
+	mode_get=3D""
+	mode_set=3D""
+	mode_set_all=3D""
+	;;
+new)
+	mode_prefix=3D""
+	mode_get=3D"get"
+	mode_set=3D"set"
+	mode_set_all=3D"set-all"
+	;;
+esac
+
 test_expect_success 'clear default config' '
 	rm -f .git/config
 '
@@ -20,7 +38,7 @@ cat > expect << EOF
 	penguin =3D little blue
 EOF
 test_expect_success 'initial' '
-	git config section.penguin "little blue" &&
+	git config ${mode_set} section.penguin "little blue" &&
 	test_cmp expect .git/config
 '
=20
@@ -30,7 +48,7 @@ cat > expect << EOF
 	Movie =3D BadPhysics
 EOF
 test_expect_success 'mixed case' '
-	git config Section.Movie BadPhysics &&
+	git config ${mode_set} Section.Movie BadPhysics &&
 	test_cmp expect .git/config
 '
=20
@@ -42,7 +60,7 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'similar section' '
-	git config Sections.WhatEver Second &&
+	git config ${mode_set} Sections.WhatEver Second &&
 	test_cmp expect .git/config
 '
=20
@@ -55,16 +73,16 @@ cat > expect << EOF
 	WhatEver =3D Second
 EOF
 test_expect_success 'uppercase section' '
-	git config SECTION.UPPERCASE true &&
+	git config ${mode_set} SECTION.UPPERCASE true &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'replace with non-match' '
-	git config section.penguin kingpin !blue
+	git config ${mode_set_all} section.penguin kingpin !blue
 '
=20
 test_expect_success 'replace with non-match (actually matching)' '
-	git config section.penguin "very blue" !kingpin
+	git config ${mode_set_all} section.penguin "very blue" !kingpin
 '
=20
 cat > expect << EOF
@@ -102,7 +120,7 @@ test_missing_key () {
 	local key=3D"$1" &&
 	local title=3D"$2" &&
 	test_expect_success "value for $title is not printed" '
-		test_must_fail git config "$key" >out 2>err &&
+		test_must_fail git config ${mode_get} "$key" >out 2>err &&
 		test_must_be_empty out &&
 		test_must_be_empty err
 	'
@@ -125,7 +143,7 @@ foo =3D bar
 EOF
=20
 test_expect_success 'unset with cont. lines' '
-	git config --unset beta.baz
+	git config ${mode_prefix}unset beta.baz
 '
=20
 cat > expect <<\EOF
@@ -152,7 +170,7 @@ EOF
 cp .git/config .git/config2
=20
 test_expect_success 'multiple unset' '
-	git config --unset-all beta.haha
+	git config ${mode_prefix}unset-all beta.haha
 '
=20
 cat > expect << EOF
@@ -178,7 +196,7 @@ test_expect_success '--replace-all missing value' '
 rm .git/config2
=20
 test_expect_success '--replace-all' '
-	git config --replace-all beta.haha gamma
+	git config ${mode_prefix}replace-all beta.haha gamma
 '
=20
 cat > expect << EOF
@@ -220,7 +238,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'really really mean test' '
-	git config nextsection.nonewline wow &&
+	git config ${mode_set} nextsection.nonewline wow &&
 	test_cmp expect .git/config
 '
=20
@@ -238,7 +256,7 @@ noIndent=3D sillyValue ; 'nother silly comment
 	nonewline =3D wow
 EOF
 test_expect_success 'unset' '
-	git config --unset beta.haha &&
+	git config ${mode_prefix}unset beta.haha &&
 	test_cmp expect .git/config
 '
=20
@@ -258,15 +276,15 @@ test_expect_success 'multivar' '
 '
=20
 test_expect_success 'non-match' '
-	git config --get nextsection.nonewline !for
+	git config ${mode_prefix}get nextsection.nonewline !for
 '
=20
 test_expect_success 'non-match value' '
-	test_cmp_config wow --get nextsection.nonewline !for
+	test_cmp_config wow ${mode_prefix}get nextsection.nonewline !for
 '
=20
 test_expect_success 'multi-valued get returns final one' '
-	test_cmp_config "wow2 for me" --get nextsection.nonewline
+	test_cmp_config "wow2 for me" ${mode_prefix}get nextsection.nonewline
 '
=20
 test_expect_success 'multi-valued get-all returns all' '
@@ -274,7 +292,7 @@ test_expect_success 'multi-valued get-all returns all' '
 	wow
 	wow2 for me
 	EOF
-	git config --get-all nextsection.nonewline >actual &&
+	git config ${mode_prefix}get-all nextsection.nonewline >actual &&
 	test_cmp expect actual
 '
=20
@@ -289,16 +307,16 @@ noIndent=3D sillyValue ; 'nother silly comment
 	NoNewLine =3D wow2 for me
 EOF
 test_expect_success 'multivar replace' '
-	git config nextsection.nonewline "wow3" "wow$" &&
+	git config ${mode_set_all} nextsection.nonewline "wow3" "wow$" &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'ambiguous unset' '
-	test_must_fail git config --unset nextsection.nonewline
+	test_must_fail git config ${mode_prefix}unset nextsection.nonewline
 '
=20
 test_expect_success 'invalid unset' '
-	test_must_fail git config --unset somesection.nonewline
+	test_must_fail git config ${mode_prefix}unset somesection.nonewline
 '
=20
 cat > expect << EOF
@@ -312,16 +330,16 @@ noIndent=3D sillyValue ; 'nother silly comment
 EOF
=20
 test_expect_success 'multivar unset' '
-	git config --unset nextsection.nonewline "wow3$" &&
+	git config ${mode_prefix}unset nextsection.nonewline "wow3$" &&
 	test_cmp expect .git/config
 '
=20
-test_expect_success 'invalid key' 'test_must_fail git config inval.2key bl=
abla'
+test_expect_success 'invalid key' 'test_must_fail git config ${mode_set} i=
nval.2key blabla'
=20
-test_expect_success 'correct key' 'git config 123456.a123 987'
+test_expect_success 'correct key' 'git config ${mode_set} 123456.a123 987'
=20
 test_expect_success 'hierarchical section' '
-	git config Version.1.2.3eX.Alpha beta
+	git config ${mode_set} Version.1.2.3eX.Alpha beta
 '
=20
 cat > expect << EOF
@@ -350,11 +368,11 @@ version.1.2.3eX.alpha=3Dbeta
 EOF
=20
 test_expect_success 'working --list' '
-	git config --list > output &&
+	git config ${mode_prefix}list > output &&
 	test_cmp expect output
 '
 test_expect_success '--list without repo produces empty output' '
-	git --git-dir=3Dnonexistent config --list >output &&
+	git --git-dir=3Dnonexistent config ${mode_prefix}list >output &&
 	test_must_be_empty output
 '
=20
@@ -366,7 +384,7 @@ version.1.2.3eX.alpha
 EOF
=20
 test_expect_success '--name-only --list' '
-	git config --name-only --list >output &&
+	git config ${mode_prefix}list --name-only >output &&
 	test_cmp expect output
 '
=20
@@ -376,7 +394,7 @@ nextsection.nonewline wow2 for me
 EOF
=20
 test_expect_success '--get-regexp' '
-	git config --get-regexp in >output &&
+	git config ${mode_prefix}get-regexp in >output &&
 	test_cmp expect output
 '
=20
@@ -386,7 +404,7 @@ nextsection.nonewline
 EOF
=20
 test_expect_success '--name-only --get-regexp' '
-	git config --name-only --get-regexp in >output &&
+	git config ${mode_prefix}get-regexp --name-only in >output &&
 	test_cmp expect output
 '
=20
@@ -396,8 +414,8 @@ wow4 for you
 EOF
=20
 test_expect_success '--add' '
-	git config --add nextsection.nonewline "wow4 for you" &&
-	git config --get-all nextsection.nonewline > output &&
+	git config ${mode_prefix}add nextsection.nonewline "wow4 for you" &&
+	git config ${mode_prefix}get-all nextsection.nonewline > output &&
 	test_cmp expect output
 '
=20
@@ -409,45 +427,45 @@ cat > .git/config << EOF
 EOF
=20
 test_expect_success 'get variable with no value' '
-	git config --get novalue.variable ^$
+	git config ${mode_prefix}get novalue.variable ^$
 '
=20
 test_expect_success 'get variable with empty value' '
-	git config --get emptyvalue.variable ^$
+	git config ${mode_prefix}get emptyvalue.variable ^$
 '
=20
 echo novalue.variable > expect
=20
 test_expect_success 'get-regexp variable with no value' '
-	git config --get-regexp novalue > output &&
+	git config ${mode_prefix}get-regexp novalue > output &&
 	test_cmp expect output
 '
=20
 echo 'novalue.variable true' > expect
=20
 test_expect_success 'get-regexp --bool variable with no value' '
-	git config --bool --get-regexp novalue > output &&
+	git config ${mode_prefix}get-regexp --bool novalue > output &&
 	test_cmp expect output
 '
=20
 echo 'emptyvalue.variable ' > expect
=20
 test_expect_success 'get-regexp variable with empty value' '
-	git config --get-regexp emptyvalue > output &&
+	git config ${mode_prefix}get-regexp emptyvalue > output &&
 	test_cmp expect output
 '
=20
 echo true > expect
=20
 test_expect_success 'get bool variable with no value' '
-	git config --bool novalue.variable > output &&
+	git config ${mode_get} --bool novalue.variable > output &&
 	test_cmp expect output
 '
=20
 echo false > expect
=20
 test_expect_success 'get bool variable with empty value' '
-	git config --bool emptyvalue.variable > output &&
+	git config ${mode_get} --bool emptyvalue.variable > output &&
 	test_cmp expect output
 '
=20
@@ -469,7 +487,7 @@ cat > expect << EOF
 EOF
=20
 test_expect_success 'new section is partial match of another' '
-	git config a.x y &&
+	git config ${mode_set} a.x y &&
 	test_cmp expect .git/config
 '
=20
@@ -484,14 +502,14 @@ cat > expect << EOF
 EOF
=20
 test_expect_success 'new variable inserts into proper section' '
-	git config b.x y &&
-	git config a.b c &&
+	git config ${mode_set} b.x y &&
+	git config ${mode_set} a.b c &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'alternative --file (non-existing file should fail)' '
-	test_must_fail git config --file non-existing-config -l &&
-	test_must_fail git config --file non-existing-config test.xyzzy
+	test_must_fail git config ${mode_prefix}list --file non-existing-config &&
+	test_must_fail git config ${mode_get} --file non-existing-config test.xyz=
zy
 '
=20
 cat > other-config << EOF
@@ -504,29 +522,30 @@ ein.bahn=3Dstrasse
 EOF
=20
 test_expect_success 'alternative GIT_CONFIG' '
-	GIT_CONFIG=3Dother-config git config --list >output &&
+	GIT_CONFIG=3Dother-config git config ${mode_prefix}list >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'alternative GIT_CONFIG (--file)' '
-	git config --file other-config --list >output &&
+	git config ${mode_prefix}list --file other-config >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'alternative GIT_CONFIG (--file=3D-)' '
-	git config --file - --list <other-config >output &&
+	git config ${mode_prefix}list --file - <other-config >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'setting a value in stdin is an error' '
-	test_must_fail git config --file - some.value foo
+	test_must_fail git config ${mode_set} --file - some.value foo
 '
=20
 test_expect_success 'editing stdin is an error' '
-	test_must_fail git config --file - --edit
+	test_must_fail git config ${mode_prefix}edit --file -
 '
=20
 test_expect_success 'refer config from subdirectory' '
+	test_when_finished "rm -r x" &&
 	mkdir x &&
 	test_cmp_config -C x strasse --file=3D../other-config --get ein.bahn
 '
@@ -539,7 +558,7 @@ cat > expect << EOF
 EOF
=20
 test_expect_success '--set in alternative file' '
-	git config --file=3Dother-config anwohner.park ausweis &&
+	git config ${mode_set} --file=3Dother-config anwohner.park ausweis &&
 	test_cmp expect other-config
 '
=20
@@ -555,7 +574,7 @@ weird
 EOF
=20
 test_expect_success 'rename section' '
-	git config --rename-section branch.eins branch.zwei
+	git config ${mode_prefix}rename-section branch.eins branch.zwei
 '
=20
 cat > expect << EOF
@@ -574,7 +593,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename non-existing section' '
-	test_must_fail git config --rename-section \
+	test_must_fail git config ${mode_prefix}rename-section \
 		branch."world domination" branch.drei
 '
=20
@@ -583,7 +602,7 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'rename another section' '
-	git config --rename-section branch."1 234 blabl/a" branch.drei
+	git config ${mode_prefix}rename-section branch."1 234 blabl/a" branch.drei
 '
=20
 cat > expect << EOF
@@ -606,7 +625,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'rename a section with a var on the same line' '
-	git config --rename-section branch.vier branch.zwei
+	git config ${mode_prefix}rename-section branch.vier branch.zwei
 '
=20
 cat > expect << EOF
@@ -627,11 +646,11 @@ test_expect_success 'rename succeeded' '
 '
=20
 test_expect_success 'renaming empty section name is rejected' '
-	test_must_fail git config --rename-section branch.zwei ""
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei ""
 '
=20
 test_expect_success 'renaming to bogus section is rejected' '
-	test_must_fail git config --rename-section branch.zwei "bogus name"
+	test_must_fail git config ${mode_prefix}rename-section branch.zwei "bogus=
 name"
 '
=20
 test_expect_success 'renaming a section with a long line' '
@@ -640,7 +659,7 @@ test_expect_success 'renaming a section with a long lin=
e' '
 		printf "  c =3D d %1024s [a] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y b.e
 '
=20
@@ -650,7 +669,7 @@ test_expect_success 'renaming an embedded section with =
a long line' '
 		printf "  c =3D d %1024s [a] [foo] e =3D f\\n" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	git config -f y --rename-section a xyz &&
+	git config ${mode_prefix}rename-section -f y a xyz &&
 	test_must_fail git config -f y foo.e
 '
=20
@@ -660,7 +679,7 @@ test_expect_success 'renaming a section with an overly-=
long line' '
 		printf "  c =3D d %525000s e" " " &&
 		printf "[a] g =3D h\\n"
 	} >y &&
-	test_must_fail git config -f y --rename-section a xyz 2>err &&
+	test_must_fail git config ${mode_prefix}rename-section -f y a xyz 2>err &&
 	grep "refusing to work with overly long line in .y. on line 2" err
 '
=20
@@ -669,7 +688,7 @@ cat >> .git/config << EOF
 EOF
=20
 test_expect_success 'remove section' '
-	git config --remove-section branch.zwei
+	git config ${mode_prefix}remove-section branch.zwei
 '
=20
 cat > expect << EOF
@@ -693,20 +712,20 @@ EOF
=20
 test_expect_success 'section ending' '
 	rm -f .git/config &&
-	git config gitcvs.enabled true &&
-	git config gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
-	git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
+	git config ${mode_set} gitcvs.enabled true &&
+	git config ${mode_set} gitcvs.ext.dbname %Ggitcvs1.%a.%m.sqlite &&
+	git config ${mode_set} gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	test_cmp expect .git/config
=20
 '
=20
 test_expect_success numbers '
-	git config kilo.gram 1k &&
-	git config mega.ton 1m &&
+	git config ${mode_set} kilo.gram 1k &&
+	git config ${mode_set} mega.ton 1m &&
 	echo 1024 >expect &&
 	echo 1048576 >>expect &&
-	git config --int --get kilo.gram >actual &&
-	git config --int --get mega.ton >>actual &&
+	git config ${mode_prefix}get --int kilo.gram >actual &&
+	git config ${mode_prefix}get --int mega.ton >>actual &&
 	test_cmp expect actual
 '
=20
@@ -719,25 +738,25 @@ test_expect_success '--int is at least 64 bits' '
 test_expect_success 'invalid unit' '
 	git config aninvalid.unit "1auto" &&
 	test_cmp_config 1auto aninvalid.unit &&
-	test_must_fail git config --int --get aninvalid.unit 2>actual &&
+	test_must_fail git config ${mode_prefix}get --int aninvalid.unit 2>actual=
 &&
 	test_grep "bad numeric config value .1auto. for .aninvalid.unit. in file =
=2Egit/config: invalid unit" actual
 '
=20
 test_expect_success 'invalid unit boolean' '
 	git config commit.gpgsign "1true" &&
 	test_cmp_config 1true commit.gpgsign &&
-	test_must_fail git config --bool --get commit.gpgsign 2>actual &&
+	test_must_fail git config ${mode_prefix}get --bool commit.gpgsign 2>actua=
l &&
 	test_grep "bad boolean config value .1true. for .commit.gpgsign." actual
 '
=20
 test_expect_success 'line number is reported correctly' '
 	printf "[bool]\n\tvar\n" >invalid &&
-	test_must_fail git config -f invalid --path bool.var 2>actual &&
+	test_must_fail git config ${mode_get} -f invalid --path bool.var 2>actual=
 &&
 	test_grep "line 2" actual
 '
=20
 test_expect_success 'invalid stdin config' '
-	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
+	echo "[broken" | test_must_fail git config ${mode_prefix}list --file - >o=
utput 2>&1 &&
 	test_grep "bad config line 1 in standard input" output
 '
=20
@@ -765,19 +784,19 @@ test_expect_success bool '
 	rm -f result &&
 	for i in 1 2 3 4
 	do
-	    git config --bool --get bool.true$i >>result &&
-	    git config --bool --get bool.false$i >>result || return 1
+	    git config ${mode_prefix}get --bool bool.true$i >>result &&
+	    git config ${mode_prefix}get --bool bool.false$i >>result || return 1
 	done &&
 	test_cmp expect result'
=20
 test_expect_success 'invalid bool (--get)' '
=20
 	git config bool.nobool foobar &&
-	test_must_fail git config --bool --get bool.nobool'
+	test_must_fail git config ${mode_prefix}get --bool bool.nobool'
=20
 test_expect_success 'invalid bool (set)' '
=20
-	test_must_fail git config --bool bool.nobool foobar'
+	test_must_fail git config ${mode_set} --bool bool.nobool foobar'
=20
 cat > expect <<\EOF
 [bool]
@@ -794,14 +813,14 @@ EOF
 test_expect_success 'set --bool' '
=20
 	rm -f .git/config &&
-	git config --bool bool.true1 01 &&
-	git config --bool bool.true2 -1 &&
-	git config --bool bool.true3 YeS &&
-	git config --bool bool.true4 true &&
-	git config --bool bool.false1 000 &&
-	git config --bool bool.false2 "" &&
-	git config --bool bool.false3 nO &&
-	git config --bool bool.false4 FALSE &&
+	git config ${mode_set} --bool bool.true1 01 &&
+	git config ${mode_set} --bool bool.true2 -1 &&
+	git config ${mode_set} --bool bool.true3 YeS &&
+	git config ${mode_set} --bool bool.true4 true &&
+	git config ${mode_set} --bool bool.false1 000 &&
+	git config ${mode_set} --bool bool.false2 "" &&
+	git config ${mode_set} --bool bool.false3 nO &&
+	git config ${mode_set} --bool bool.false4 FALSE &&
 	test_cmp expect .git/config'
=20
 cat > expect <<\EOF
@@ -814,9 +833,9 @@ EOF
 test_expect_success 'set --int' '
=20
 	rm -f .git/config &&
-	git config --int int.val1 01 &&
-	git config --int int.val2 -1 &&
-	git config --int int.val3 5m &&
+	git config ${mode_set} --int int.val1 01 &&
+	git config ${mode_set} --int int.val2 -1 &&
+	git config ${mode_set} --int int.val3 5m &&
 	test_cmp expect .git/config
 '
=20
@@ -840,12 +859,12 @@ test_expect_success 'get --bool-or-int' '
 	-1
 	EOF
 	{
-		git config --bool-or-int bool.true1 &&
-		git config --bool-or-int bool.true2 &&
-		git config --bool-or-int bool.false &&
-		git config --bool-or-int int.int1 &&
-		git config --bool-or-int int.int2 &&
-		git config --bool-or-int int.int3
+		git config ${mode_get} --bool-or-int bool.true1 &&
+		git config ${mode_get} --bool-or-int bool.true2 &&
+		git config ${mode_get} --bool-or-int bool.false &&
+		git config ${mode_get} --bool-or-int int.int1 &&
+		git config ${mode_get} --bool-or-int int.int2 &&
+		git config ${mode_get} --bool-or-int int.int3
 	} >actual &&
 	test_cmp expect actual
 '
@@ -864,13 +883,13 @@ EOF
=20
 test_expect_success 'set --bool-or-int' '
 	rm -f .git/config &&
-	git config --bool-or-int bool.true1 true &&
-	git config --bool-or-int bool.false1 false &&
-	git config --bool-or-int bool.true2 yes &&
-	git config --bool-or-int bool.false2 no &&
-	git config --bool-or-int int.int1 0 &&
-	git config --bool-or-int int.int2 1 &&
-	git config --bool-or-int int.int3 -1 &&
+	git config ${mode_set} --bool-or-int bool.true1 true &&
+	git config ${mode_set} --bool-or-int bool.false1 false &&
+	git config ${mode_set} --bool-or-int bool.true2 yes &&
+	git config ${mode_set} --bool-or-int bool.false2 no &&
+	git config ${mode_set} --bool-or-int int.int1 0 &&
+	git config ${mode_set} --bool-or-int int.int2 1 &&
+	git config ${mode_set} --bool-or-int int.int3 -1 &&
 	test_cmp expect .git/config
 '
=20
@@ -883,9 +902,9 @@ EOF
=20
 test_expect_success !MINGW 'set --path' '
 	rm -f .git/config &&
-	git config --path path.home "~/" &&
-	git config --path path.normal "/dev/null" &&
-	git config --path path.trailingtilde "foo~" &&
+	git config ${mode_set} --path path.home "~/" &&
+	git config ${mode_set} --path path.normal "/dev/null" &&
+	git config ${mode_set} --path path.trailingtilde "foo~" &&
 	test_cmp expect .git/config'
=20
 if test_have_prereq !MINGW && test "${HOME+set}"
@@ -900,9 +919,9 @@ foo~
 EOF
=20
 test_expect_success HOMEVAR 'get --path' '
-	git config --get --path path.home > result &&
-	git config --get --path path.normal >> result &&
-	git config --get --path path.trailingtilde >> result &&
+	git config ${mode_prefix}get --path path.home > result &&
+	git config ${mode_prefix}get --path path.normal >> result &&
+	git config ${mode_prefix}get --path path.trailingtilde >> result &&
 	test_cmp expect result
 '
=20
@@ -914,10 +933,10 @@ EOF
 test_expect_success !MINGW 'get --path copes with unset $HOME' '
 	(
 		sane_unset HOME &&
-		test_must_fail git config --get --path path.home \
+		test_must_fail git config ${mode_prefix}get --path path.home \
 			>result 2>msg &&
-		git config --get --path path.normal >>result &&
-		git config --get --path path.trailingtilde >>result
+		git config ${mode_prefix}get --path path.normal >>result &&
+		git config ${mode_prefix}get --path path.trailingtilde >>result
 	) &&
 	test_grep "[Ff]ailed to expand.*~/" msg &&
 	test_cmp expect result
@@ -925,7 +944,7 @@ test_expect_success !MINGW 'get --path copes with unset=
 $HOME' '
=20
 test_expect_success 'get --path barfs on boolean variable' '
 	echo "[path]bool" >.git/config &&
-	test_must_fail git config --get --path path.bool
+	test_must_fail git config ${mode_prefix}get --path path.bool
 '
=20
 test_expect_success 'get --expiry-date' '
@@ -949,20 +968,20 @@ test_expect_success 'get --expiry-date' '
 	EOF
 	: "work around heredoc parsing bug fixed in dash 0.5.7 (in ec2c84d)" &&
 	{
-		echo "$rel_out $(git config --expiry-date date.valid1)" &&
-		git config --expiry-date date.valid2 &&
-		git config --expiry-date date.valid3 &&
-		git config --expiry-date date.valid4 &&
-		git config --expiry-date date.valid5
+		echo "$rel_out $(git config ${mode_get} --expiry-date date.valid1)" &&
+		git config ${mode_get} --expiry-date date.valid2 &&
+		git config ${mode_get} --expiry-date date.valid3 &&
+		git config ${mode_get} --expiry-date date.valid4 &&
+		git config ${mode_get} --expiry-date date.valid5
 	} >actual &&
 	test_cmp expect actual &&
-	test_must_fail git config --expiry-date date.invalid1
+	test_must_fail git config ${mode_get} --expiry-date date.invalid1
 '
=20
 test_expect_success 'get --type=3Dcolor' '
 	rm .git/config &&
 	git config foo.color "red" &&
-	git config --get --type=3Dcolor foo.color >actual.raw &&
+	git config ${mode_prefix}get --type=3Dcolor foo.color >actual.raw &&
 	test_decode_color <actual.raw >actual &&
 	echo "<RED>" >expect &&
 	test_cmp expect actual
@@ -975,17 +994,17 @@ EOF
=20
 test_expect_success 'set --type=3Dcolor' '
 	rm .git/config &&
-	git config --type=3Dcolor foo.color "red" &&
+	git config ${mode_set} --type=3Dcolor foo.color "red" &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'get --type=3Dcolor barfs on non-color' '
 	echo "[foo]bar=3Dnot-a-color" >.git/config &&
-	test_must_fail git config --get --type=3Dcolor foo.bar
+	test_must_fail git config ${mode_prefix}get --type=3Dcolor foo.bar
 '
=20
 test_expect_success 'set --type=3Dcolor barfs on non-color' '
-	test_must_fail git config --type=3Dcolor foo.color "not-a-color" 2>error =
&&
+	test_must_fail git config ${mode_set} --type=3Dcolor foo.color "not-a-col=
or" 2>error &&
 	test_grep "cannot parse color" error
 '
=20
@@ -998,18 +1017,18 @@ cat > expect << EOF
 EOF
 test_expect_success 'quoting' '
 	rm -f .git/config &&
-	git config quote.leading " test" &&
-	git config quote.ending "test " &&
-	git config quote.semicolon "test;test" &&
-	git config quote.hash "test#test" &&
+	git config ${mode_set} quote.leading " test" &&
+	git config ${mode_set} quote.ending "test " &&
+	git config ${mode_set} quote.semicolon "test;test" &&
+	git config ${mode_set} quote.hash "test#test" &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'key with newline' '
-	test_must_fail git config "key.with
+	test_must_fail git config ${mode_set} "key.with
 newline" 123'
=20
-test_expect_success 'value with newline' 'git config key.sub value.with\\\
+test_expect_success 'value with newline' 'git config ${mode_set} key.sub v=
alue.with\\\
 newline'
=20
 cat > .git/config <<\EOF
@@ -1029,7 +1048,7 @@ section.quotecont=3Dcont;inued
 EOF
=20
 test_expect_success 'value continued on next line' '
-	git config --list > result &&
+	git config ${mode_prefix}list > result &&
 	test_cmp expect result
 '
=20
@@ -1053,14 +1072,14 @@ Qsection.sub=3Dsection.val4
 Qsection.sub=3Dsection.val5Q
 EOF
 test_expect_success '--null --list' '
-	git config --null --list >result.raw &&
+	git config ${mode_prefix}list --null >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
 '
=20
 test_expect_success '--null --get-regexp' '
-	git config --null --get-regexp "val[0-9]" >result.raw &&
+	git config ${mode_prefix}get-regexp --null "val[0-9]" >result.raw &&
 	nul_to_q <result.raw >result &&
 	echo >>result &&
 	test_cmp expect result
@@ -1072,12 +1091,13 @@ test_expect_success 'inner whitespace kept verbatim=
' '
 '
=20
 test_expect_success SYMLINKS 'symlinked configuration' '
+	test_when_finished "rm myconfig" &&
 	ln -s notyet myconfig &&
-	git config --file=3Dmyconfig test.frotz nitfol &&
+	git config ${mode_set} --file=3Dmyconfig test.frotz nitfol &&
 	test -h myconfig &&
 	test -f notyet &&
-	test "z$(git config --file=3Dnotyet test.frotz)" =3D znitfol &&
-	git config --file=3Dmyconfig test.xyzzy rezrov &&
+	test "z$(git config ${mode_get} --file=3Dnotyet test.frotz)" =3D znitfol =
&&
+	git config ${mode_set} --file=3Dmyconfig test.xyzzy rezrov &&
 	test -h myconfig &&
 	test -f notyet &&
 	cat >expect <<-\EOF &&
@@ -1085,17 +1105,18 @@ test_expect_success SYMLINKS 'symlinked configurati=
on' '
 	rezrov
 	EOF
 	{
-		git config --file=3Dnotyet test.frotz &&
-		git config --file=3Dnotyet test.xyzzy
+		git config ${mode_get} --file=3Dnotyet test.frotz &&
+		git config ${mode_get} --file=3Dnotyet test.xyzzy
 	} >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success SYMLINKS 'symlink to nonexistent configuration' '
+	test_when_finished "rm linktonada linktolinktonada" &&
 	ln -s doesnotexist linktonada &&
 	ln -s linktonada linktolinktonada &&
-	test_must_fail git config --file=3Dlinktonada --list &&
-	test_must_fail git config --file=3Dlinktolinktonada --list
+	test_must_fail git config ${mode_prefix}list --file=3Dlinktonada &&
+	test_must_fail git config ${mode_prefix}list --file=3Dlinktolinktonada
 '
=20
 test_expect_success 'check split_cmdline return' '
@@ -1103,12 +1124,12 @@ test_expect_success 'check split_cmdline return' '
 	git init repo &&
 	(
 		cd repo &&
-		git config alias.split-cmdline-fix "echo \"" &&
+		git config ${mode_set} alias.split-cmdline-fix "echo \"" &&
 		test_must_fail git split-cmdline-fix &&
 		echo foo >foo &&
 		git add foo &&
 		git commit -m "initial commit" &&
-		git config branch.main.mergeoptions "echo \"" &&
+		git config ${mode_set} branch.main.mergeoptions "echo \"" &&
 		test_must_fail git merge main
 	)
 '
@@ -1122,10 +1143,10 @@ test_expect_success 'git -c "key=3Dvalue" support' '
 	{
 		git -c section.name=3Dvalue config section.name &&
 		git -c foo.CamelCase=3Dvalue config foo.camelcase &&
-		git -c foo.flag config --bool foo.flag
+		git -c foo.flag config ${mode_get} --bool foo.flag
 	} >actual &&
 	test_cmp expect actual &&
-	test_must_fail git -c name=3Dvalue config section.name
+	test_must_fail git -c name=3Dvalue config ${mode_get} section.name
 '
=20
 # We just need a type-specifier here that cares about the
@@ -1135,27 +1156,27 @@ test_expect_success 'git -c "key=3Dvalue" support' '
 # its semantics.
 test_expect_success 'git -c can represent empty string' '
 	echo >expect &&
-	git -c foo.empty=3D config --path foo.empty >actual &&
+	git -c foo.empty=3D config ${mode_get} --path foo.empty >actual &&
 	test_cmp expect actual
 '
=20
 test_expect_success 'key sanity-checking' '
-	test_must_fail git config foo=3Dbar &&
-	test_must_fail git config foo=3D.bar &&
-	test_must_fail git config foo.ba=3Dr &&
-	test_must_fail git config foo.1bar &&
-	test_must_fail git config foo."ba
+	test_must_fail git config ${mode_get} foo=3Dbar &&
+	test_must_fail git config ${mode_get} foo=3D.bar &&
+	test_must_fail git config ${mode_get} foo.ba=3Dr &&
+	test_must_fail git config ${mode_get} foo.1bar &&
+	test_must_fail git config ${mode_get} foo."ba
 				z".bar &&
-	test_must_fail git config . false &&
-	test_must_fail git config .foo false &&
-	test_must_fail git config foo. false &&
-	test_must_fail git config .foo. false &&
-	git config foo.bar true &&
-	git config foo."ba =3Dz".bar false
+	test_must_fail git config ${mode_set} . false &&
+	test_must_fail git config ${mode_set} .foo false &&
+	test_must_fail git config ${mode_set} foo. false &&
+	test_must_fail git config ${mode_set} .foo. false &&
+	git config ${mode_set} foo.bar true &&
+	git config ${mode_set} foo."ba =3Dz".bar false
 '
=20
 test_expect_success 'git -c works with aliases of builtins' '
-	git config alias.checkconfig "-c foo.check=3Dbar config foo.check" &&
+	git config ${mode_set} alias.checkconfig "-c foo.check=3Dbar config foo.c=
heck" &&
 	echo bar >expect &&
 	git checkconfig >actual &&
 	test_cmp expect actual
@@ -1167,7 +1188,7 @@ test_expect_success 'aliases can be CamelCased' '
 	(
 		cd repo &&
 		test_commit A &&
-		git config alias.CamelCased "rev-parse HEAD" &&
+		git config ${mode_set} alias.CamelCased "rev-parse HEAD" &&
 		git CamelCased >out &&
 		git rev-parse HEAD >expect &&
 		test_cmp expect out
@@ -1176,7 +1197,7 @@ test_expect_success 'aliases can be CamelCased' '
=20
 test_expect_success 'git -c does not split values on equals' '
 	echo "value with =3D in it" >expect &&
-	git -c section.foo=3D"value with =3D in it" config section.foo >actual &&
+	git -c section.foo=3D"value with =3D in it" config ${mode_get} section.fo=
o >actual &&
 	test_cmp expect actual
 '
=20
@@ -1193,7 +1214,7 @@ test_expect_success 'git -c complains about empty key=
 and value' '
 '
=20
 test_expect_success 'multiple git -c appends config' '
-	test_config alias.x "!git -c x.two=3D2 config --get-regexp ^x\.*" &&
+	test_config alias.x "!git -c x.two=3D2 config ${mode_prefix}get-regexp ^x=
\.*" &&
 	cat >expect <<-\EOF &&
 	x.one 1
 	x.two 2
@@ -1210,14 +1231,14 @@ test_expect_success 'last one wins: two level vars'=
 '
=20
 	echo VAL >expect &&
=20
-	git -c sec.var=3Dval -c sec.VAR=3DVAL config --get sec.var >actual &&
+	git -c sec.var=3Dval -c sec.VAR=3DVAL config ${mode_prefix}get sec.var >a=
ctual &&
 	test_cmp expect actual &&
-	git -c SEC.var=3Dval -c sec.var=3DVAL config --get sec.var >actual &&
+	git -c SEC.var=3Dval -c sec.var=3DVAL config ${mode_prefix}get sec.var >a=
ctual &&
 	test_cmp expect actual &&
=20
-	git -c sec.var=3Dval -c sec.VAR=3DVAL config --get SEC.var >actual &&
+	git -c sec.var=3Dval -c sec.VAR=3DVAL config ${mode_prefix}get SEC.var >a=
ctual &&
 	test_cmp expect actual &&
-	git -c SEC.var=3Dval -c sec.var=3DVAL config --get sec.VAR >actual &&
+	git -c SEC.var=3Dval -c sec.var=3DVAL config ${mode_prefix}get sec.VAR >a=
ctual &&
 	test_cmp expect actual
 '
=20
@@ -1228,9 +1249,9 @@ test_expect_success 'last one wins: three level vars'=
 '
 	# case sensitive.
=20
 	echo val >expect &&
-	git -c v.a.r=3Dval -c v.A.r=3DVAL config --get v.a.r >actual &&
+	git -c v.a.r=3Dval -c v.A.r=3DVAL config ${mode_prefix}get v.a.r >actual =
&&
 	test_cmp expect actual &&
-	git -c v.a.r=3Dval -c v.A.r=3DVAL config --get V.a.R >actual &&
+	git -c v.a.r=3Dval -c v.A.r=3DVAL config ${mode_prefix}get V.a.R >actual =
&&
 	test_cmp expect actual &&
=20
 	# v.a.r and V.a.R are the same variable, as the first
@@ -1238,13 +1259,13 @@ test_expect_success 'last one wins: three level var=
s' '
 	# case insensitive.
=20
 	echo VAL >expect &&
-	git -c v.a.r=3Dval -c v.a.R=3DVAL config --get v.a.r >actual &&
+	git -c v.a.r=3Dval -c v.a.R=3DVAL config ${mode_prefix}get v.a.r >actual =
&&
 	test_cmp expect actual &&
-	git -c v.a.r=3Dval -c V.a.r=3DVAL config --get v.a.r >actual &&
+	git -c v.a.r=3Dval -c V.a.r=3DVAL config ${mode_prefix}get v.a.r >actual =
&&
 	test_cmp expect actual &&
-	git -c v.a.r=3Dval -c v.a.R=3DVAL config --get V.a.R >actual &&
+	git -c v.a.r=3Dval -c v.a.R=3DVAL config ${mode_prefix}get V.a.R >actual =
&&
 	test_cmp expect actual &&
-	git -c v.a.r=3Dval -c V.a.r=3DVAL config --get V.a.R >actual &&
+	git -c v.a.r=3Dval -c V.a.r=3DVAL config ${mode_prefix}get V.a.R >actual =
&&
 	test_cmp expect actual
 '
=20
@@ -1259,7 +1280,7 @@ test_expect_success 'old-fashioned settings are case =
insensitive' '
 	[V.A]
 	Qr =3D value2
 	EOF
-	git config -f testConfig_actual "v.a.r" value2 &&
+	git config ${mode_set} -f testConfig_actual "v.a.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
=20
 	cat >testConfig_actual <<-EOF &&
@@ -1270,7 +1291,7 @@ test_expect_success 'old-fashioned settings are case =
insensitive' '
 	[V.A]
 	QR =3D value2
 	EOF
-	git config -f testConfig_actual "V.a.R" value2 &&
+	git config ${mode_set} -f testConfig_actual "V.a.R" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
=20
 	cat >testConfig_actual <<-EOF &&
@@ -1282,7 +1303,7 @@ test_expect_success 'old-fashioned settings are case =
insensitive' '
 	r =3D value1
 	Qr =3D value2
 	EOF
-	git config -f testConfig_actual "V.A.r" value2 &&
+	git config ${mode_set} -f testConfig_actual "V.A.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual &&
=20
 	cat >testConfig_actual <<-EOF &&
@@ -1294,7 +1315,7 @@ test_expect_success 'old-fashioned settings are case =
insensitive' '
 	r =3D value1
 	Qr =3D value2
 	EOF
-	git config -f testConfig_actual "v.A.r" value2 &&
+	git config ${mode_set} -f testConfig_actual "v.A.r" value2 &&
 	test_cmp testConfig_expect testConfig_actual
 '
=20
@@ -1324,21 +1345,21 @@ test_expect_success 'setting different case sensiti=
ve subsections ' '
 	Qf =3D v2
 	EOF
 	# exact match
-	git config -f testConfig_actual a.b.c v2 &&
+	git config ${mode_set} -f testConfig_actual a.b.c v2 &&
 	# match section and subsection, key is cased differently.
-	git config -f testConfig_actual K.E.y v2 &&
+	git config ${mode_set} -f testConfig_actual K.E.y v2 &&
 	# section and key are matched case insensitive, but subsection needs
 	# to match; When writing out new values only the key is adjusted
-	git config -f testConfig_actual v.A.r v2 &&
+	git config ${mode_set} -f testConfig_actual v.A.r v2 &&
 	# subsection is not matched:
-	git config -f testConfig_actual d.E.f v2 &&
+	git config ${mode_set} -f testConfig_actual d.E.f v2 &&
 	test_cmp testConfig_expect testConfig_actual
 '
=20
 for VAR in a .a a. a.0b a."b c". a."b c".0d
 do
 	test_expect_success "git -c $VAR=3DVAL rejects invalid '$VAR'" '
-		test_must_fail git -c "$VAR=3DVAL" config -l
+		test_must_fail git -c "$VAR=3DVAL" config ${mode_prefix}list
 	'
 done
=20
@@ -1346,20 +1367,20 @@ for VAR in a.b a."b c".d
 do
 	test_expect_success "git -c $VAR=3DVAL works with valid '$VAR'" '
 		echo VAL >expect &&
-		git -c "$VAR=3DVAL" config --get "$VAR" >actual &&
+		git -c "$VAR=3DVAL" config ${mode_prefix}get "$VAR" >actual &&
 		test_cmp expect actual
 	'
 done
=20
 test_expect_success 'git -c is not confused by empty environment' '
-	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config --list
+	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config ${mode_prefix}list
 '
=20
 test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
 	v=3D"${SQ}key.one=3Dfoo${SQ}" &&
 	v=3D"$v  ${SQ}key.two=3Dbar${SQ}" &&
 	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever=3Dvalue${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_prefix}get-regexp "key.*" >a=
ctual &&
 	cat >expect <<-EOF &&
 	key.one foo
 	key.two bar
@@ -1372,7 +1393,7 @@ test_expect_success 'GIT_CONFIG_PARAMETERS handles ne=
w-style entries' '
 	v=3D"${SQ}key.one${SQ}=3D${SQ}foo${SQ}" &&
 	v=3D"$v  ${SQ}key.two${SQ}=3D${SQ}bar${SQ}" &&
 	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever${SQ}=3D${SQ}value${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_prefix}get-regexp "key.*" >a=
ctual &&
 	cat >expect <<-EOF &&
 	key.one foo
 	key.two bar
@@ -1386,7 +1407,7 @@ test_expect_success 'old and new-style entries can mi=
x' '
 	v=3D"$v ${SQ}key.newone${SQ}=3D${SQ}newfoo${SQ}" &&
 	v=3D"$v ${SQ}key.oldtwo=3Doldbar${SQ}" &&
 	v=3D"$v ${SQ}key.newtwo${SQ}=3D${SQ}newbar${SQ}" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_prefix}get-regexp "key.*" >a=
ctual &&
 	cat >expect <<-EOF &&
 	key.oldone oldfoo
 	key.newone newfoo
@@ -1399,7 +1420,7 @@ test_expect_success 'old and new-style entries can mi=
x' '
 test_expect_success 'old and new bools with ambiguous subsection' '
 	v=3D"${SQ}key.with=3Dequals.oldbool${SQ}" &&
 	v=3D"$v ${SQ}key.with=3Dequals.newbool${SQ}=3D" &&
-	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	GIT_CONFIG_PARAMETERS=3D$v git config ${mode_prefix}get-regexp "key.*" >a=
ctual &&
 	cat >expect <<-EOF &&
 	key.with equals.oldbool
 	key.with=3Dequals.newbool
@@ -1413,7 +1434,7 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMETE=
RS' '
 	env.two two
 	EOF
 	GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ} ${SQ}env.two=3Dtwo${SQ}"=
 \
-		git config --get-regexp "env.*" >actual &&
+		git config ${mode_prefix}get-regexp "env.*" >actual &&
 	test_cmp expect actual &&
=20
 	cat >expect <<-EOF &&
@@ -1421,12 +1442,12 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAME=
TERS' '
 	env.two two
 	EOF
 	GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ}\\$SQ$SQ$SQ ${SQ}env.two=
=3Dtwo${SQ}" \
-		git config --get-regexp "env.*" >actual &&
+		git config ${mode_prefix}get-regexp "env.*" >actual &&
 	test_cmp expect actual &&
=20
 	test_must_fail env \
 		GIT_CONFIG_PARAMETERS=3D"${SQ}env.one=3Done${SQ}\\$SQ ${SQ}env.two=3Dtwo=
${SQ}" \
-		git config --get-regexp "env.*"
+		git config ${mode_prefix}get-regexp "env.*"
 '
=20
 test_expect_success 'git --config-env=3Dkey=3Denvvar support' '
@@ -1439,12 +1460,12 @@ test_expect_success 'git --config-env=3Dkey=3Denvva=
r support' '
 	false
 	EOF
 	{
-		ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config core.name &&
-		ENVVAR=3Dvalue git --config-env core.name=3DENVVAR config core.name &&
-		ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config foo.came=
lcase &&
-		ENVVAR=3Dvalue git --config-env foo.CamelCase=3DENVVAR config foo.camelc=
ase &&
-		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config --bool foo.flag &&
-		ENVVAR=3D git --config-env foo.flag=3DENVVAR config --bool foo.flag
+		ENVVAR=3Dvalue git --config-env=3Dcore.name=3DENVVAR config ${mode_get} =
core.name &&
+		ENVVAR=3Dvalue git --config-env core.name=3DENVVAR config ${mode_get} co=
re.name &&
+		ENVVAR=3Dvalue git --config-env=3Dfoo.CamelCase=3DENVVAR config ${mode_g=
et} foo.camelcase &&
+		ENVVAR=3Dvalue git --config-env foo.CamelCase=3DENVVAR config ${mode_get=
} foo.camelcase &&
+		ENVVAR=3D git --config-env=3Dfoo.flag=3DENVVAR config ${mode_get} --bool=
 foo.flag &&
+		ENVVAR=3D git --config-env foo.flag=3DENVVAR config ${mode_get} --bool f=
oo.flag
 	} >actual &&
 	test_cmp expect actual
 '
@@ -1452,17 +1473,17 @@ test_expect_success 'git --config-env=3Dkey=3Denvva=
r support' '
 test_expect_success 'git --config-env with missing value' '
 	test_must_fail env ENVVAR=3Dvalue git --config-env 2>error &&
 	grep "no config key given for --config-env" error &&
-	test_must_fail env ENVVAR=3Dvalue git --config-env config core.name 2>err=
or &&
+	test_must_fail env ENVVAR=3Dvalue git --config-env config ${mode_get} cor=
e.name 2>error &&
 	grep "invalid config format: config" error
 '
=20
 test_expect_success 'git --config-env fails with invalid parameters' '
-	test_must_fail git --config-env=3Dfoo.flag config --bool foo.flag 2>error=
 &&
+	test_must_fail git --config-env=3Dfoo.flag config ${mode_get} --bool foo.=
flag 2>error &&
 	test_grep "invalid config format: foo.flag" error &&
-	test_must_fail git --config-env=3Dfoo.flag=3D config --bool foo.flag 2>er=
ror &&
+	test_must_fail git --config-env=3Dfoo.flag=3D config ${mode_get} --bool f=
oo.flag 2>error &&
 	test_grep "missing environment variable name for configuration ${SQ}foo.f=
lag${SQ}" error &&
 	sane_unset NONEXISTENT &&
-	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config --bool fo=
o.flag 2>error &&
+	test_must_fail git --config-env=3Dfoo.flag=3DNONEXISTENT config ${mode_ge=
t} --bool foo.flag 2>error &&
 	test_grep "missing environment variable ${SQ}NONEXISTENT${SQ} for configu=
ration ${SQ}foo.flag${SQ}" error
 '
=20
@@ -1474,7 +1495,7 @@ test_expect_success 'git -c and --config-env work tog=
ether' '
 	ENVVAR=3Denv-value git \
 		-c bar.cmd=3Dcmd-value \
 		--config-env=3Dbar.env=3DENVVAR \
-		config --get-regexp "^bar.*" >actual &&
+		config ${mode_prefix}get-regexp "^bar.*" >actual &&
 	test_cmp expect actual
 '
=20
@@ -1484,8 +1505,8 @@ test_expect_success 'git -c and --config-env override=
 each other' '
 	cmd
 	EOF
 	{
-		ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR config=
 bar.bar &&
-		ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd config=
 bar.bar
+		ENVVAR=3Denv git -c bar.bar=3Dcmd --config-env=3Dbar.bar=3DENVVAR config=
 ${config_get} bar.bar &&
+		ENVVAR=3Denv git --config-env=3Dbar.bar=3DENVVAR -c bar.bar=3Dcmd config=
 ${config_get} bar.bar
 	} >actual &&
 	test_cmp expect actual
 '
@@ -1494,7 +1515,7 @@ test_expect_success '--config-env handles keys with e=
quals' '
 	echo value=3Dwith=3Dequals >expect &&
 	ENVVAR=3Dvalue=3Dwith=3Dequals git \
 		--config-env=3Dsection.subsection=3Dwith=3Dequals.key=3DENVVAR \
-		config section.subsection=3Dwith=3Dequals.key >actual &&
+		config ${config_get} section.subsection=3Dwith=3Dequals.key >actual &&
 	test_cmp expect actual
 '
=20
@@ -1502,7 +1523,7 @@ test_expect_success 'git config handles environment c=
onfig pairs' '
 	GIT_CONFIG_COUNT=3D2 \
 		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"foo" \
 		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"bar" \
-		git config --get-regexp "pair.*" >actual &&
+		git config ${mode_prefix}get-regexp "pair.*" >actual &&
 	cat >expect <<-EOF &&
 	pair.one foo
 	pair.two bar
@@ -1520,7 +1541,7 @@ test_expect_success 'git config ignores pairs exceedi=
ng count' '
 	GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
 		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value" \
-		git config --get-regexp "pair.*" >actual 2>error &&
+		git config ${mode_prefix}get-regexp "pair.*" >actual 2>error &&
 	cat >expect <<-EOF &&
 	pair.one value
 	EOF
@@ -1531,43 +1552,43 @@ test_expect_success 'git config ignores pairs excee=
ding count' '
 test_expect_success 'git config ignores pairs with zero count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=3D0 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D=
"value" \
-		git config pair.one 2>error &&
+		git config ${config_get} pair.one 2>error &&
 	test_must_be_empty error
 '
=20
 test_expect_success 'git config ignores pairs with empty count' '
 	test_must_fail env \
 		GIT_CONFIG_COUNT=3D GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"=
value" \
-		git config pair.one 2>error &&
+		git config ${config_get} pair.one 2>error &&
 	test_must_be_empty error
 '
=20
 test_expect_success 'git config fails with invalid count' '
-	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D10a git config ${mode_prefix}list 2=
>error &&
 	test_grep "bogus count" error &&
-	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config --list =
2>error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config ${mode_=
prefix}list 2>error &&
 	test_grep "too many entries" error
 '
=20
 test_expect_success 'git config fails with missing config key' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_VALUE_0=3D"value" \
-		git config --list 2>error &&
+		git config ${mode_prefix}list 2>error &&
 	test_grep "missing config key" error
 '
=20
 test_expect_success 'git config fails with missing config value' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3D"pair.one" \
-		git config --list 2>error &&
+		git config ${mode_prefix}list 2>error &&
 	test_grep "missing config value" error
 '
=20
 test_expect_success 'git config fails with invalid config pair key' '
 	test_must_fail env GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3D GIT_CONFIG_VALUE_0=3Dvalue \
-		git config --list &&
+		git config ${mode_prefix}list &&
 	test_must_fail env GIT_CONFIG_COUNT=3D1 \
 		GIT_CONFIG_KEY_0=3Dmissing-section GIT_CONFIG_VALUE_0=3Dvalue \
-		git config --list
+		git config ${mode_prefix}list
 '
=20
 test_expect_success 'environment overrides config file' '
@@ -1577,7 +1598,7 @@ test_expect_success 'environment overrides config fil=
e' '
 	one =3D value
 	EOF
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dove=
rride \
-		git config pair.one >actual &&
+		git config ${mode_get} pair.one >actual &&
 	cat >expect <<-EOF &&
 	override
 	EOF
@@ -1587,7 +1608,7 @@ test_expect_success 'environment overrides config fil=
e' '
 test_expect_success 'GIT_CONFIG_PARAMETERS overrides environment config' '
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
 		GIT_CONFIG_PARAMETERS=3D"${SQ}pair.one=3Doverride${SQ}" \
-		git config pair.one >actual &&
+		git config ${mode_get} pair.one >actual &&
 	cat >expect <<-EOF &&
 	override
 	EOF
@@ -1596,7 +1617,7 @@ test_expect_success 'GIT_CONFIG_PARAMETERS overrides =
environment config' '
=20
 test_expect_success 'command line overrides environment config' '
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
-		git -c pair.one=3Doverride config pair.one >actual &&
+		git -c pair.one=3Doverride config ${mode_get} pair.one >actual &&
 	cat >expect <<-EOF &&
 	override
 	EOF
@@ -1606,8 +1627,8 @@ test_expect_success 'command line overrides environme=
nt config' '
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
-	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	GIT_EDITOR=3D"echo [test]value=3Dyes >" git config ${mode_prefix}edit -f =
tmp &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -1615,8 +1636,8 @@ test_expect_success 'git config --edit respects core.=
editor' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
 	test_config core.editor "echo [test]value=3Dyes >" &&
-	git config -f tmp --edit &&
-	git config -f tmp --list >actual &&
+	git config ${mode_prefix}edit -f tmp &&
+	git config ${mode_prefix}list -f tmp >actual &&
 	test_cmp expect actual
 '
=20
@@ -1627,7 +1648,7 @@ test_expect_success 'barf on syntax error' '
 	[section]
 	key garbage
 	EOF
-	test_must_fail git config --get section.key 2>error &&
+	test_must_fail git config ${mode_prefix}get section.key 2>error &&
 	test_grep " line 3 " error
 '
=20
@@ -1637,7 +1658,7 @@ test_expect_success 'barf on incomplete section heade=
r' '
 	[section
 	key =3D value
 	EOF
-	test_must_fail git config --get section.key 2>error &&
+	test_must_fail git config ${mode_prefix}get section.key 2>error &&
 	test_grep " line 2 " error
 '
=20
@@ -1647,7 +1668,7 @@ test_expect_success 'barf on incomplete string' '
 	[section]
 	key =3D "value string
 	EOF
-	test_must_fail git config --get section.key 2>error &&
+	test_must_fail git config ${mode_prefix}get section.key 2>error &&
 	test_grep " line 3 " error
 '
=20
@@ -1660,22 +1681,22 @@ test_expect_success 'urlmatch' '
 		cookieFile =3D /tmp/cookie.txt
 	EOF
=20
-	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://=
good.example.com >actual &&
+	test_expect_code 1 git config ${mode_prefix}get-urlmatch --bool doesnt.ex=
ist https://good.example.com >actual &&
 	test_must_be_empty actual &&
=20
 	echo true >expect &&
-	git config --bool --get-urlmatch http.SSLverify https://good.example.com =
>actual &&
+	git config ${mode_prefix}get-urlmatch --bool http.SSLverify https://good.=
example.com >actual &&
 	test_cmp expect actual &&
=20
 	echo false >expect &&
-	git config --bool --get-urlmatch http.sslverify https://weak.example.com =
>actual &&
+	git config ${mode_prefix}get-urlmatch --bool http.sslverify https://weak.=
example.com >actual &&
 	test_cmp expect actual &&
=20
 	{
 		echo http.cookiefile /tmp/cookie.txt &&
 		echo http.sslverify false
 	} >expect &&
-	git config --get-urlmatch HTTP https://weak.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://weak.example.com >actu=
al &&
 	test_cmp expect actual
 '
=20
@@ -1690,7 +1711,7 @@ test_expect_success 'urlmatch with --show-scope' '
 	local	http.cookiefile /tmp/cookie.txt
 	local	http.sslverify false
 	EOF
-	git config --get-urlmatch --show-scope HTTP https://weak.example.com >act=
ual &&
+	git config ${mode_prefix}get-urlmatch --show-scope HTTP https://weak.exam=
ple.com >actual &&
 	test_cmp expect actual
 '
=20
@@ -1721,47 +1742,47 @@ test_expect_success 'urlmatch favors more specific =
URLs' '
 	EOF
=20
 	echo http.cookiefile /tmp/root.txt >expect &&
-	git config --get-urlmatch HTTP https://example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://example.com >actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
-	git config --get-urlmatch HTTP https://example.com/subdirectory >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://example.com/subdirecto=
ry >actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
-	git config --get-urlmatch HTTP https://example.com/subdirectory/nested >a=
ctual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://example.com/subdirecto=
ry/nested >actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/user.txt >expect &&
-	git config --get-urlmatch HTTP https://user@example.com/ >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://user@example.com/ >act=
ual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/subdirectory.txt >expect &&
-	git config --get-urlmatch HTTP https://averylonguser@example.com/subdirec=
tory >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://averylonguser@example.=
com/subdirectory >actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/preceding.txt >expect &&
-	git config --get-urlmatch HTTP https://preceding.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://preceding.example.com =
>actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/wildcard.txt >expect &&
-	git config --get-urlmatch HTTP https://wildcard.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://wildcard.example.com >=
actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/sub.txt >expect &&
-	git config --get-urlmatch HTTP https://sub.example.com/wildcardwithsubdom=
ain >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://sub.example.com/wildca=
rdwithsubdomain >actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/trailing.txt >expect &&
-	git config --get-urlmatch HTTP https://trailing.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://trailing.example.com >=
actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/sub.txt >expect &&
-	git config --get-urlmatch HTTP https://user@sub.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://user@sub.example.com >=
actual &&
 	test_cmp expect actual &&
=20
 	echo http.cookiefile /tmp/multiwildcard.txt >expect &&
-	git config --get-urlmatch HTTP https://wildcard.example.org >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://wildcard.example.org >=
actual &&
 	test_cmp expect actual
 '
=20
@@ -1774,34 +1795,34 @@ test_expect_success 'urlmatch with wildcard' '
 		cookieFile =3D /tmp/cookie.txt
 	EOF
=20
-	test_expect_code 1 git config --bool --get-urlmatch doesnt.exist https://=
good.example.com >actual &&
+	test_expect_code 1 git config ${mode_prefix}get-urlmatch --bool doesnt.ex=
ist https://good.example.com >actual &&
 	test_must_be_empty actual &&
=20
 	echo true >expect &&
-	git config --bool --get-urlmatch http.SSLverify https://example.com >actu=
al &&
+	git config ${mode_prefix}get-urlmatch --bool http.SSLverify https://examp=
le.com >actual &&
 	test_cmp expect actual &&
=20
 	echo true >expect &&
-	git config --bool --get-urlmatch http.SSLverify https://good-example.com =
>actual &&
+	git config ${mode_prefix}get-urlmatch --bool http.SSLverify https://good-=
example.com >actual &&
 	test_cmp expect actual &&
=20
 	echo true >expect &&
-	git config --bool --get-urlmatch http.sslverify https://deep.nested.examp=
le.com >actual &&
+	git config ${mode_prefix}get-urlmatch --bool http.sslverify https://deep.=
nested.example.com >actual &&
 	test_cmp expect actual &&
=20
 	echo false >expect &&
-	git config --bool --get-urlmatch http.sslverify https://good.example.com =
>actual &&
+	git config ${mode_prefix}get-urlmatch --bool http.sslverify https://good.=
example.com >actual &&
 	test_cmp expect actual &&
=20
 	{
 		echo http.cookiefile /tmp/cookie.txt &&
 		echo http.sslverify false
 	} >expect &&
-	git config --get-urlmatch HTTP https://good.example.com >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://good.example.com >actu=
al &&
 	test_cmp expect actual &&
=20
 	echo http.sslverify >expect &&
-	git config --get-urlmatch HTTP https://more.example.com.au >actual &&
+	git config ${mode_prefix}get-urlmatch HTTP https://more.example.com.au >a=
ctual &&
 	test_cmp expect actual
 '
=20
@@ -1828,7 +1849,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	# please be careful when you update the above variable
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_prefix}unset section.key &&
 	test_cmp expect .git/config &&
=20
 	cat >.git/config <<-\EOF &&
@@ -1841,7 +1862,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[next-section]
 	EOF
=20
-	git config --unset section.key &&
+	git config ${mode_prefix}unset section.key &&
 	test_cmp expect .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1851,7 +1872,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	key =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_prefix}unset two.key &&
 	! grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1861,7 +1882,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[one]
 	key =3D true
 	EOF
-	git config --unset-all one.key &&
+	git config ${mode_prefix}unset-all one.key &&
 	test_line_count =3D 0 .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1871,7 +1892,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[two]
 	Qkey =3D true
 	EOF
-	git config --unset two.key &&
+	git config ${mode_prefix}unset two.key &&
 	grep two .git/config &&
=20
 	q_to_tab >.git/config <<-\EOF &&
@@ -1883,7 +1904,7 @@ test_expect_success '--unset last key removes section=
 (except if commented)' '
 	[TWO "subsection"]
 	[one]
 	EOF
-	git config --unset two.subsection.key &&
+	git config ${mode_prefix}unset two.subsection.key &&
 	test "not [two subsection]" =3D "$(git config one.key)" &&
 	test_line_count =3D 3 .git/config
 '
@@ -1895,7 +1916,7 @@ test_expect_success '--unset-all removes section if e=
mpty & uncommented' '
 	key =3D value2
 	EOF
=20
-	git config --unset-all section.key &&
+	git config ${mode_prefix}unset-all section.key &&
 	test_line_count =3D 0 .git/config
 '
=20
@@ -1909,7 +1930,7 @@ test_expect_success 'adding a key into an empty secti=
on reuses header' '
 	Qkey =3D value
 	EOF
=20
-	git config section.key value &&
+	git config ${mode_set} section.key value &&
 	test_cmp expect .git/config
 '
=20
@@ -1918,7 +1939,7 @@ test_expect_success POSIXPERM,PERL 'preserves existin=
g permissions' '
 	git config imap.pass Hunter2 &&
 	perl -e \
 	  "die q(badset) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600" &&
-	git config --rename-section imap pop &&
+	git config ${mode_prefix}rename-section imap pop &&
 	perl -e \
 	  "die q(badrename) if ((stat(q(.git/config)))[2] & 07777) !=3D 0600"
 '
@@ -1967,7 +1988,7 @@ test_expect_success '--show-origin with --list' '
 	command line:	user.cmdline=3Dtrue
 	EOF
 	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.environ GIT_CONFIG_VALUE_0=
=3Dtrue\
-		git -c user.cmdline=3Dtrue config --list --show-origin >output &&
+		git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin >outp=
ut &&
 	test_cmp expect output
 '
=20
@@ -1984,7 +2005,7 @@ test_expect_success '--show-origin with --list --null=
' '
 	includeQcommand line:Quser.cmdline
 	trueQ
 	EOF
-	git -c user.cmdline=3Dtrue config --null --list --show-origin >output.raw=
 &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --null --show-origin=
 >output.raw &&
 	nul_to_q <output.raw >output &&
 	# The here-doc above adds a newline that the --null output would not
 	# include. Add it here to make the two comparable.
@@ -1998,7 +2019,7 @@ test_expect_success '--show-origin with single file' '
 	file:.git/config	user.override=3Dlocal
 	file:.git/config	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-origin >output &&
+	git config ${mode_prefix}list --local --show-origin >output &&
 	test_cmp expect output
 '
=20
@@ -2007,7 +2028,7 @@ test_expect_success '--show-origin with --get-regexp'=
 '
 	file:$HOME/.gitconfig	user.global true
 	file:.git/config	user.local true
 	EOF
-	git config --show-origin --get-regexp "user\.[g|l].*" >output &&
+	git config ${mode_prefix}get-regexp --show-origin "user\.[g|l].*" >output=
 &&
 	test_cmp expect output
 '
=20
@@ -2015,7 +2036,7 @@ test_expect_success '--show-origin getting a single k=
ey' '
 	cat >expect <<-\EOF &&
 	file:.git/config	local
 	EOF
-	git config --show-origin user.override >output &&
+	git config ${mode_get} --show-origin user.override >output &&
 	test_cmp expect output
 '
=20
@@ -2036,7 +2057,7 @@ test_expect_success !MINGW '--show-origin escape spec=
ial file name characters' '
 	cat >expect <<-\EOF &&
 	file:"file\" (dq) and spaces.conf"	user.custom=3Dtrue
 	EOF
-	git config --file "$WEIRDLY_NAMED_FILE" --show-origin --list >output &&
+	git config ${mode_prefix}list --file "$WEIRDLY_NAMED_FILE" --show-origin =
>output &&
 	test_cmp expect output
 '
=20
@@ -2044,7 +2065,7 @@ test_expect_success '--show-origin stdin' '
 	cat >expect <<-\EOF &&
 	standard input:	user.custom=3Dtrue
 	EOF
-	git config --file - --show-origin --list <"$CUSTOM_CONFIG_FILE" >output &&
+	git config ${mode_prefix}list --file - --show-origin <"$CUSTOM_CONFIG_FIL=
E" >output &&
 	test_cmp expect output
 '
=20
@@ -2057,7 +2078,7 @@ test_expect_success '--show-origin stdin with file in=
clude' '
 	file:$INCLUDE_DIR/stdin.include	include
 	EOF
 	echo "[include]path=3D\"$INCLUDE_DIR\"/stdin.include" |
-	git config --show-origin --includes --file - user.stdin >output &&
+	git config ${mode_get} --show-origin --includes --file - user.stdin >outp=
ut &&
=20
 	test_cmp expect output
 '
@@ -2071,7 +2092,7 @@ test_expect_success '--show-origin blob' '
 		cat >expect <<-EOF &&
 		blob:$blob	user.custom=3Dtrue
 		EOF
-		git config --blob=3D$blob --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3D$blob --show-origin >output &&
 		test_cmp expect output
 	)
 '
@@ -2087,13 +2108,13 @@ test_expect_success '--show-origin blob ref' '
 		cp "$CUSTOM_CONFIG_FILE" custom.conf &&
 		git add custom.conf &&
 		git commit -m "new config file" &&
-		git config --blob=3Dmain:custom.conf --show-origin --list >output &&
+		git config ${mode_prefix}list --blob=3Dmain:custom.conf --show-origin >o=
utput &&
 		test_cmp expect output
 	)
 '
=20
 test_expect_success '--show-origin with --default' '
-	git config --show-origin --default foo some.key >actual &&
+	git config ${mode_get} --show-origin --default foo some.key >actual &&
 	echo "command line:	foo" >expect &&
 	test_cmp expect actual
 '
@@ -2113,13 +2134,14 @@ test_expect_success '--show-scope with --list' '
 	worktree	user.worktree=3Dtrue
 	command	user.cmdline=3Dtrue
 	EOF
+	test_when_finished "git worktree remove wt1" &&
 	git worktree add wt1 &&
 	# We need these to test for worktree scope, but outside of this
 	# test, this is just noise
 	test_config core.repositoryformatversion 1 &&
 	test_config extensions.worktreeConfig true &&
-	git config --worktree user.worktree true &&
-	git -c user.cmdline=3Dtrue config --list --show-scope >output &&
+	git config ${mode_get} --worktree user.worktree true &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-scope >output=
 &&
 	test_cmp expect output
 '
=20
@@ -2128,7 +2150,7 @@ test_expect_success !MINGW '--show-scope with --blob'=
 '
 	cat >expect <<-EOF &&
 	command	user.custom=3Dtrue
 	EOF
-	git config --blob=3D$blob --show-scope --list >output &&
+	git config ${mode_prefix}list --blob=3D$blob --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2138,7 +2160,7 @@ test_expect_success '--show-scope with --local' '
 	local	user.override=3Dlocal
 	local	include.path=3D../include/relative.include
 	EOF
-	git config --local --list --show-scope >output &&
+	git config ${mode_prefix}list --local --show-scope >output &&
 	test_cmp expect output
 '
=20
@@ -2146,7 +2168,7 @@ test_expect_success '--show-scope getting a single va=
lue' '
 	cat >expect <<-\EOF &&
 	local	true
 	EOF
-	git config --show-scope --get user.local >output &&
+	git config ${mode_prefix}get --show-scope user.local >output &&
 	test_cmp expect output
 '
=20
@@ -2162,12 +2184,12 @@ test_expect_success '--show-scope with --show-origi=
n' '
 	local	file:.git/../include/relative.include	user.relative=3Dinclude
 	command	command line:	user.cmdline=3Dtrue
 	EOF
-	git -c user.cmdline=3Dtrue config --list --show-origin --show-scope >outp=
ut &&
+	git -c user.cmdline=3Dtrue config ${mode_prefix}list --show-origin --show=
-scope >output &&
 	test_cmp expect output
 '
=20
 test_expect_success '--show-scope with --default' '
-	git config --show-scope --default foo some.key >actual &&
+	git config ${mode_get} --show-scope --default foo some.key >actual &&
 	echo "command	foo" >expect &&
 	test_cmp expect actual
 '
@@ -2203,7 +2225,7 @@ test_expect_success 'override global and system confi=
g' '
 	global	home.config=3Dtrue
 	local	local.config=3Dtrue
 	EOF
-	git config --show-scope --list >output &&
+	git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
@@ -2212,20 +2234,20 @@ test_expect_success 'override global and system con=
fig' '
 	local	local.config=3Dtrue
 	EOF
 	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_=
CONFIG_GLOBAL=3Dcustom-global-config \
-		git config --show-scope --list >output &&
+		git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output &&
=20
 	cat >expect <<-EOF &&
 	local	local.config=3Dtrue
 	EOF
 	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOB=
AL=3D/dev/null \
-		git config --show-scope --list >output &&
+		git config ${mode_prefix}list --show-scope >output &&
 	test_cmp expect output
 '
=20
 test_expect_success 'override global and system config with missing file' '
-	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config --global --list &&
-	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config --system --list &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config ${mode_prefix}list --global &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config ${mode_prefix}list --system &&
 	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exist git=
 version
 '
=20
@@ -2251,10 +2273,10 @@ test_expect_success 'write to overridden global and=
 system config' '
 	key =3D value
 EOF
=20
-	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --global config.key value =
&&
+	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config ${mode_set} --global confi=
g.key value &&
 	test_cmp expect write-to-global &&
=20
-	GIT_CONFIG_SYSTEM=3Dwrite-to-system git config --system config.key value =
&&
+	GIT_CONFIG_SYSTEM=3Dwrite-to-system git config ${mode_set} --system confi=
g.key value &&
 	test_cmp expect write-to-system
 '
=20
@@ -2263,7 +2285,7 @@ do
 	test_expect_success "$opt requires a repo" '
 		# we expect 128 to ensure that we do not simply
 		# fail to find anything and return code "1"
-		test_expect_code 128 nongit git config $opt foo.bar
+		test_expect_code 128 nongit git config ${mode_get} $opt foo.bar
 	'
 done
=20
@@ -2287,17 +2309,17 @@ test_expect_success 'identical mixed --type specifi=
ers are allowed' '
 '
=20
 test_expect_success 'non-identical modern --type specifiers are not allowe=
d' '
-	test_must_fail git config --type=3Dint --type=3Dbool section.big 2>error =
&&
+	test_must_fail git config ${mode_get} --type=3Dint --type=3Dbool section.=
big 2>error &&
 	test_grep "only one type at a time" error
 '
=20
 test_expect_success 'non-identical legacy --type specifiers are not allowe=
d' '
-	test_must_fail git config --int --bool section.big 2>error &&
+	test_must_fail git config ${mode_get} --int --bool section.big 2>error &&
 	test_grep "only one type at a time" error
 '
=20
 test_expect_success 'non-identical mixed --type specifiers are not allowed=
' '
-	test_must_fail git config --type=3Dint --bool section.big 2>error &&
+	test_must_fail git config ${mode_get} --type=3Dint --bool section.big 2>e=
rror &&
 	test_grep "only one type at a time" error
 '
=20
@@ -2314,12 +2336,12 @@ test_expect_success 'unset type specifiers may be r=
eset to conflicting ones' '
 '
=20
 test_expect_success '--type rejects unknown specifiers' '
-	test_must_fail git config --type=3Dnonsense section.foo 2>error &&
+	test_must_fail git config ${mode_get} --type=3Dnonsense section.foo 2>err=
or &&
 	test_grep "unrecognized --type argument" error
 '
=20
 test_expect_success '--type=3Dint requires at least one digit' '
-	test_must_fail git config --type int --default m some.key >out 2>error &&
+	test_must_fail git config ${mode_get} --type int --default m some.key >ou=
t 2>error &&
 	grep "bad numeric config value" error &&
 	test_must_be_empty out
 '
@@ -2341,18 +2363,18 @@ test_expect_success '--replace-all does not invent =
newlines' '
 	[abc]
 	Qkey =3D b
 	EOF
-	git config --replace-all abc.key b &&
+	git config ${mode_prefix}replace-all abc.key b &&
 	test_cmp expect .git/config
 '
=20
 test_expect_success 'set all config with value-pattern' '
 	test_when_finished rm -f config initial &&
-	git config --file=3Dinitial abc.key one &&
+	git config ${mode_set} --file=3Dinitial abc.key one &&
=20
 	# no match =3D> add new entry
 	cp initial config &&
-	git config --file=3Dconfig abc.key two a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_set_all} --file=3Dconfig abc.key two a+ &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2360,12 +2382,12 @@ test_expect_success 'set all config with value-patt=
ern' '
 	test_cmp expect actual &&
=20
 	# multiple matches =3D> failure
-	test_must_fail git config --file=3Dconfig abc.key three o+ 2>err &&
+	test_must_fail git config ${mode_set_all} --file=3Dconfig abc.key three o=
+ 2>err &&
 	test_grep "has multiple values" err &&
=20
 	# multiple values, no match =3D> add
-	git config --file=3Dconfig abc.key three a+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_set_all} --file=3Dconfig abc.key three a+ &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2374,8 +2396,8 @@ test_expect_success 'set all config with value-patter=
n' '
 	test_cmp expect actual &&
=20
 	# single match =3D> replace
-	git config --file=3Dconfig abc.key four h+ &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_set_all} --file=3Dconfig abc.key four h+ &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Done
 	abc.key=3Dtwo
@@ -2386,11 +2408,11 @@ test_expect_success 'set all config with value-patt=
ern' '
=20
 test_expect_success '--replace-all and value-pattern' '
 	test_when_finished rm -f config &&
-	git config --file=3Dconfig --add abc.key one &&
-	git config --file=3Dconfig --add abc.key two &&
-	git config --file=3Dconfig --add abc.key three &&
-	git config --file=3Dconfig --replace-all abc.key four "o+" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}add --file=3Dconfig abc.key one &&
+	git config ${mode_prefix}add --file=3Dconfig abc.key two &&
+	git config ${mode_prefix}add --file=3Dconfig abc.key three &&
+	git config ${mode_prefix}replace-all --file=3Dconfig abc.key four "o+" &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	abc.key=3Dfour
 	abc.key=3Dthree
@@ -2403,33 +2425,33 @@ test_expect_success 'refuse --fixed-value for incom=
patible actions' '
 	git config --file=3Dconfig dev.null bogus &&
=20
 	# These modes do not allow --fixed-value at all
-	test_must_fail git config --file=3Dconfig --fixed-value --add dev.null bo=
gus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-urlmatch de=
v.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --rename-section =
dev null &&
-	test_must_fail git config --file=3Dconfig --fixed-value --remove-section =
dev &&
-	test_must_fail git config --file=3Dconfig --fixed-value --list &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-color dev.n=
ull &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-colorbool d=
ev.null &&
+	test_must_fail git config ${mode_prefix}add --file=3Dconfig --fixed-value=
 dev.null bogus &&
+	test_must_fail git config ${mode_prefix}get-urlmatch --file=3Dconfig --fi=
xed-value dev.null bogus &&
+	test_must_fail git config ${mode_prefix}get-urlmatch --file=3Dconfig --fi=
xed-value dev.null bogus &&
+	test_must_fail git config ${mode_prefix}rename-section --file=3Dconfig --=
fixed-value dev null &&
+	test_must_fail git config ${mode_prefix}remove-section --file=3Dconfig --=
fixed-value dev &&
+	test_must_fail git config ${mode_prefix}list --file=3Dconfig --fixed-valu=
e &&
+	test_must_fail git config ${mode_prefix}get-color --file=3Dconfig --fixed=
-value dev.null &&
+	test_must_fail git config ${mode_prefix}get-colorbool --file=3Dconfig --f=
ixed-value dev.null &&
=20
 	# These modes complain when --fixed-value has no value-pattern
-	test_must_fail git config --file=3Dconfig --fixed-value dev.null bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --replace-all dev=
=2Enull bogus &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get dev.null &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-all dev.nul=
l &&
-	test_must_fail git config --file=3Dconfig --fixed-value --get-regexp "dev=
=2E*" &&
-	test_must_fail git config --file=3Dconfig --fixed-value --unset dev.null =
&&
-	test_must_fail git config --file=3Dconfig --fixed-value --unset-all dev.n=
ull
+	test_must_fail git config ${mode_set} --file=3Dconfig --fixed-value dev.n=
ull bogus &&
+	test_must_fail git config ${mode_prefix}replace-all --file=3Dconfig --fix=
ed-value dev.null bogus &&
+	test_must_fail git config ${mode_prefix}get --file=3Dconfig --fixed-value=
 dev.null &&
+	test_must_fail git config ${mode_prefix}get-all --file=3Dconfig --fixed-v=
alue dev.null &&
+	test_must_fail git config ${mode_prefix}get-regexp --file=3Dconfig --fixe=
d-value "dev.*" &&
+	test_must_fail git config ${mode_prefix}unset --file=3Dconfig --fixed-val=
ue dev.null &&
+	test_must_fail git config ${mode_prefix}unset-all --file=3Dconfig --fixed=
-value dev.null
 '
=20
 test_expect_success '--fixed-value uses exact string matching' '
 	test_when_finished rm -f config initial &&
 	META=3D"a+b*c?d[e]f.g" &&
-	git config --file=3Dinitial fixed.test "$META" &&
+	git config ${mode_set} --file=3Dinitial fixed.test "$META" &&
=20
 	cp initial config &&
-	git config --file=3Dconfig fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_set_all} --file=3Dconfig fixed.test bogus "$META" &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
@@ -2437,34 +2459,34 @@ test_expect_success '--fixed-value uses exact strin=
g matching' '
 	test_cmp expect actual &&
=20
 	cp initial config &&
-	git config --file=3Dconfig --fixed-value fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_set_all} --file=3Dconfig --fixed-value fixed.test bogus=
 "$META" &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-\EOF &&
 	fixed.test=3Dbogus
 	EOF
 	test_cmp expect actual &&
=20
 	cp initial config &&
-	test_must_fail git config --file=3Dconfig --unset fixed.test "$META" &&
-	git config --file=3Dconfig --fixed-value --unset fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig fixed.test &&
+	test_must_fail git config ${mode_prefix}unset --file=3Dconfig fixed.test =
"$META" &&
+	git config ${mode_prefix}unset --file=3Dconfig --fixed-value fixed.test "=
$META" &&
+	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
 	cp initial config &&
-	test_must_fail git config --file=3Dconfig --unset-all fixed.test "$META" =
&&
-	git config --file=3Dconfig --fixed-value --unset-all fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig fixed.test &&
+	test_must_fail git config ${mode_prefix}unset-all --file=3Dconfig fixed.t=
est "$META" &&
+	git config ${mode_prefix}unset-all --file=3Dconfig --fixed-value fixed.te=
st "$META" &&
+	test_must_fail git config ${mode_get} --file=3Dconfig fixed.test &&
=20
 	cp initial config &&
-	git config --file=3Dconfig --replace-all fixed.test bogus "$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}replace-all --file=3Dconfig fixed.test bogus "$M=
ETA" &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3D$META
 	fixed.test=3Dbogus
 	EOF
 	test_cmp expect actual &&
=20
-	git config --file=3Dconfig --fixed-value --replace-all fixed.test bogus "=
$META" &&
-	git config --file=3Dconfig --list >actual &&
+	git config ${mode_prefix}replace-all --file=3Dconfig --fixed-value fixed.=
test bogus "$META" &&
+	git config ${mode_prefix}list --file=3Dconfig >actual &&
 	cat >expect <<-EOF &&
 	fixed.test=3Dbogus
 	fixed.test=3Dbogus
@@ -2475,23 +2497,23 @@ test_expect_success '--fixed-value uses exact strin=
g matching' '
 test_expect_success '--get and --get-all with --fixed-value' '
 	test_when_finished rm -f config &&
 	META=3D"a+b*c?d[e]f.g" &&
-	git config --file=3Dconfig fixed.test bogus &&
-	git config --file=3Dconfig --add fixed.test "$META" &&
+	git config ${mode_set} --file=3Dconfig fixed.test bogus &&
+	git config ${mode_prefix}add --file=3Dconfig fixed.test "$META" &&
=20
-	git config --file=3Dconfig --get fixed.test bogus &&
-	test_must_fail git config --file=3Dconfig --get fixed.test "$META" &&
-	git config --file=3Dconfig --get --fixed-value fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig --get --fixed-value fixed.test =
non-existent &&
+	git config ${mode_prefix}get --file=3Dconfig fixed.test bogus &&
+	test_must_fail git config ${mode_prefix}get --file=3Dconfig fixed.test "$=
META" &&
+	git config ${mode_prefix}get --file=3Dconfig --fixed-value fixed.test "$M=
ETA" &&
+	test_must_fail git config ${mode_prefix}get --file=3Dconfig --fixed-value=
 fixed.test non-existent &&
=20
-	git config --file=3Dconfig --get-all fixed.test bogus &&
-	test_must_fail git config --file=3Dconfig --get-all fixed.test "$META" &&
-	git config --file=3Dconfig --get-all --fixed-value fixed.test "$META" &&
-	test_must_fail git config --file=3Dconfig --get-all --fixed-value fixed.t=
est non-existent &&
+	git config ${mode_prefix}get-all --file=3Dconfig fixed.test bogus &&
+	test_must_fail git config ${mode_prefix}get-all --file=3Dconfig fixed.tes=
t "$META" &&
+	git config ${mode_prefix}get-all --file=3Dconfig --fixed-value fixed.test=
 "$META" &&
+	test_must_fail git config ${mode_prefix}get-all --file=3Dconfig --fixed-v=
alue fixed.test non-existent &&
=20
-	git config --file=3Dconfig --get-regexp fixed+ bogus &&
-	test_must_fail git config --file=3Dconfig --get-regexp fixed+ "$META" &&
-	git config --file=3Dconfig --get-regexp --fixed-value fixed+ "$META" &&
-	test_must_fail git config --file=3Dconfig --get-regexp --fixed-value fixe=
d+ non-existent
+	git config ${mode_prefix}get-regexp --file=3Dconfig fixed+ bogus &&
+	test_must_fail git config ${mode_prefix}get-regexp --file=3Dconfig fixed+=
 "$META" &&
+	git config ${mode_prefix}get-regexp --file=3Dconfig --fixed-value fixed+ =
"$META" &&
+	test_must_fail git config ${mode_prefix}get-regexp --file=3Dconfig --fixe=
d-value fixed+ non-existent
 '
=20
 test_expect_success 'includeIf.hasconfig:remote.*.url' '
@@ -2516,10 +2538,10 @@ test_expect_success 'includeIf.hasconfig:remote.*.u=
rl' '
 	EOF
=20
 	echo this-is-included >expect-this &&
-	git -C hasremoteurlTest config --get user.this >actual-this &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.this >actual-this &&
 	test_cmp expect-this actual-this &&
=20
-	test_must_fail git -C hasremoteurlTest config --get user.that
+	test_must_fail git -C hasremoteurlTest config ${mode_prefix}get user.that
 '
=20
 test_expect_success 'includeIf.hasconfig:remote.*.url respects last-config=
-wins' '
@@ -2546,13 +2568,13 @@ test_expect_success 'includeIf.hasconfig:remote.*.u=
rl respects last-config-wins'
 	echo main-config >expect-main-config &&
 	echo included-config >expect-included-config &&
=20
-	git -C hasremoteurlTest config --get user.one >actual &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.one >actual &&
 	test_cmp expect-main-config actual &&
=20
-	git -C hasremoteurlTest config --get user.two >actual &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.two >actual &&
 	test_cmp expect-included-config actual &&
=20
-	git -C hasremoteurlTest config --get user.three >actual &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.three >actual &&
 	test_cmp expect-main-config actual
 '
=20
@@ -2587,11 +2609,11 @@ test_expect_success 'includeIf.hasconfig:remote.*.u=
rl globs' '
 		path =3D "$(pwd)/no"
 	EOF
=20
-	git -C hasremoteurlTest config --get user.dss &&
-	git -C hasremoteurlTest config --get user.dse &&
-	git -C hasremoteurlTest config --get user.dsm &&
-	git -C hasremoteurlTest config --get user.ssm &&
-	test_must_fail git -C hasremoteurlTest config --get user.no
+	git -C hasremoteurlTest config ${mode_prefix}get user.dss &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.dse &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.dsm &&
+	git -C hasremoteurlTest config ${mode_prefix}get user.ssm &&
+	test_must_fail git -C hasremoteurlTest config ${mode_prefix}get user.no
 '
=20
 test_expect_success 'includeIf.hasconfig:remote.*.url forbids remote url i=
n such included files' '
@@ -2625,4 +2647,11 @@ test_expect_success 'specifying multiple modes cause=
s failure' '
 	test_cmp expect err
 '
=20
+test_expect_success 'specifying mode and subcommand causes failure' '
+	test_must_fail git config get --get 2>err &&
+	grep "subcommand and action modes are incompatible" err
+'
+
+done
+
 test_done
--=20
2.44.0


--IAgDz8puPWyiJQwX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVC4ACgkQVbJhu7ck
PpRxPw//UpOoLZFjBZzmrF8lcpV6VWdFmZNYmYu2vanFhFlMkuBMc8b8aCGEap+/
mcOMmrdRpNPkl/0aV2/N84622RbnrF7SLklpFbZ/+IAXwLtT6aJpW8IeR85T4hJw
ra609mWSzHDQTLZhHwN4zMh8Dp5HMS7o+RM85M/0LVOAK8DmzsASR99HSRMes1lT
wBbDaq06r4uML37qBjCAvs6TZf+WtGZNTpLT9gBvKJed6FCsOvgFGnxtbuZaLiR6
j5AqtkSt4el6oD9yxeXBndeTXpH4jriBOOnCFz/gcoak72ot7Vd5JszAGRZmje14
7CCotGj2quKXQmofgw7N/FThegZ2HDTgyO8R45REiE55oidcIPz1678rQx+homLU
dwZ4sYwL1t9fvn3H2PBrCnOpodE/y5sjmvwKwjIvqpKcZ7M1f408PQs26NC0f0+V
bpzHBowEY1+TT8R4nJ9/wORtjwcXs9atWAbxxWVcS0pwsVJ5HhHEpAgFU5RqiNIs
rjOP7S9knufBJfiGy+ChEq45vXbe4qXtLwZqsu+ds/+Yyrd12DvbdnfihHNpF8B+
y02qE+17+hN9OqK2XigdnHPS0ClC7lD7Zw8Ud+mDpGZy4AyGy5UZKXZ+irecFWTI
KADcX5G4P6jhW7ZXwB5SA/CUznU+EVUiNw9NwTqia1TqpkTo92g=
=Xu8i
-----END PGP SIGNATURE-----

--IAgDz8puPWyiJQwX--
