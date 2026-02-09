Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16F2371056
	for <git@vger.kernel.org>; Mon,  9 Feb 2026 12:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640961; cv=none; b=WOu6qUJb6VF4DlErqMVCzxY9A9lYBE0oDVpIpmBHOd1D8ZkpAF/AROnLNvGg12OZzSWuNei207v2N6fty8iMePHJDBrPaGQeAbqtUGt8aTpJpUkJY30s2bCtRQGt4RB63L4vVeN79hb5rGxS4NFBcPlNwsJX+spYTcChEbLgqjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640961; c=relaxed/simple;
	bh=O4o0+GTDD7AQUgLmJuZWEDWN1tEXtRKS7W/HFLQFX7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GaLxY2y7W0B4LEQQT+2xeRCaLghBTXVJ4CwlMwLbZI3yjl7/NCQETTEtkvLpp+v5SgO5iGtWXqect7XChM+/iO7nJJh+RCiJ3vNr71Sk0ED/uFg2PAiZUk1gog0cH2SuTxWfbnrZNb676nJftzHMh4auBLNtbYgFZHjmuPBwze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RICJWW28; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t7YV+t/f; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RICJWW28";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t7YV+t/f"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 574B51D00084;
	Mon,  9 Feb 2026 07:42:40 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 09 Feb 2026 07:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770640960;
	 x=1770727360; bh=UWfl/itSfymHityAPq4ZaemHCaYHexeU5deBZSASrw0=; b=
	RICJWW282Y/f79Rwrf7BY2oIrlrpL1Y6XPBUxX7FPMdlWH1IFzJb8q/cSib4Jfbj
	Ji1NxvB1hNRRIN//2YTE9m49QuAkaZ6m7rGgFFQmjLZzYf+Tcc+pAmVEA5aX+8tY
	b+OnatmTM9urDPBlrW62U8z1bCRpFJdRP42AZEX7ftgNBabhTZnb19uV+a6JpEpQ
	niYGEW9486e9zfwvONwM6qroKbjpbJjBaTIccnpySAn69wsOGyElQ2t/MealpPwh
	JAoxCgiC3WVjjEeHYa8K2swbIbDZ2qRbyZQF2OaUz+f0MuXLOPT/RI9d2QHuIhaY
	e6Fh/Uc0SPBZ5A4tYEyNpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770640960; x=
	1770727360; bh=UWfl/itSfymHityAPq4ZaemHCaYHexeU5deBZSASrw0=; b=t
	7YV+t/fYz4FB6wCgFOIN1JRuKARWnSfSVpj6HYWIBLt2O8d8TXF2b70APCywqole
	c6QC6CbKr9303fw7WjrqbBDPWJJG5oeuccLS+OKHWR41gqAUQaQi7rdJsxAlvYrK
	iEWXd7N2j0YRdptDq6sFOcoSaI9+TcmMZ32redIvlIx4QcwoGhseYT1+JhfPv0HF
	g895u7Ol8McdgzgoCSRSG4yVgWbSUPFSVzaSN1DLLWc8cj6zvRMjRkSsJWYFrdDJ
	OBfaaFlWjMgmO51/fyfonuSMVRem9nVxnRJpoSH5WotUWX7qm9XaSAE1+r8gid3p
	alxdiuWg8g9ULfR7V+fjQ==
X-ME-Sender: <xms:QNaJacLILK0Oz-fA6RbRzJngfX_3fi9JXmSqe4zEOh1un75xUuqpUQ>
    <xme:QNaJaSJm2x-n04X1s8MFroFTMp1CBwprKgXW6zCMo9OI_fvYuYZ56lkyRbOHE6tZJ
    fEi5kbAh-Ho-k78CBgkaYbh0xVgHsQjVUHQHaJj3np5sccgDz9CvQ>
X-ME-Received: <xmr:QNaJaaX-zYUaV47sfapc2YoYyNnJVamDyqqJHKVVHb_9AeI4g-dYyVF21Vl8TfWvSsTpT3C-jBmKXwKaU6pEH1crgSYrgymJDaSgI8EuKYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduleeikeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:QNaJaUjzcwlts1CB4UnsN5WHZi2IyJwb8dIOXNP5Q6IobLyCJ50ryQ>
    <xmx:QNaJaV_DF9OqJgqsP1BzgxJ16uq_gT9h0xZgrcLPvhGZtuLSVR1weg>
    <xmx:QNaJaeB00VWXA9gFn3S-A0n6spiMMca80swTNXBlTK0g4P98bJnXrg>
    <xmx:QNaJaSK2RJNnWPTJ-5LxAbVWqjWmyUp4CCTc0152uXA1kfNzEolhaw>
    <xmx:QNaJafhfL1kHfls7aMTSEYLL6HvSHs6yYDG0CUgauhZInVjjFjIlM4pL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Feb 2026 07:42:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a7fa4e1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Feb 2026 12:42:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Feb 2026 13:42:05 +0100
Subject: [PATCH 2/4] t4205: improve handling of ICONV prerequisite
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-2-1e3167cd8828@pks.im>
References: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
In-Reply-To: <20260209-b4-pks-ci-msvc-iconv-fixes-v1-0-1e3167cd8828@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.3

In t4205 we have a bunch of tests that depend on the iconv prereq. This
is for most of the part because we format commit messages that have been
encoded in an encoding different than UTF-8.

Those tests fall into two classes though:

  - One class of tests outputs the data as-is without reencoding.

  - One class of tests outputs the data with "i18n.logOutputEncoding" to
    reencode it.

Curiously enough, both of these classes are marked with the ICONV
prereq, even though one might expect that the first class wouldn't need
the prereq. This is because we unconditionally use ISO-8859-1 encoding
for the initial commit message, and thus we depend on converting to
UTF-8 indeed.

This creates another problem though: when the iconv(1) executable does
not exist the test setup fails, even in the case where the ICONV prereq
has not been set.

Fix these issues by making the test encoding conditional on ICONV: if
it's available we use ISO-8859-1, otherwise we use UTF-8. This fixes the
test setup on platforms without iconv(1), and it allows us to drop the
ICONV prereq from a bunch of tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4205-log-pretty-formats.sh | 50 ++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 8f2ba98963..3865f6abc7 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -9,7 +9,12 @@ test_description='Test pretty formats'
 . ./test-lib.sh
 
 # Tested non-UTF-8 encoding
-test_encoding="ISO8859-1"
+if test_have_prereq ICONV
+then
+	test_encoding="ISO8859-1"
+else
+	test_encoding="UTF-8"
+fi
 
 sample_utf8_part=$(printf "f\303\244ng")
 
@@ -18,7 +23,7 @@ commit_msg () {
 	# (translated with Google Translate),
 	# encoded in UTF-8, used as a commit log message below.
 	msg="initial. an${sample_utf8_part}lich\n"
-	if test -n "$1"
+	if test -n "$1" && test "$1" != "UTF-8"
 	then
 		printf "$msg" | iconv -f utf-8 -t "$1"
 	else
@@ -113,19 +118,19 @@ test_expect_success 'alias loop' '
 	test_must_fail git log --pretty=test-foo
 '
 
-test_expect_success ICONV 'NUL separation' '
+test_expect_success 'NUL separation' '
 	printf "add bar\0$(commit_msg)" >expected &&
 	git log -z --pretty="format:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'NUL termination' '
+test_expect_success 'NUL termination' '
 	printf "add bar\0$(commit_msg)\0" >expected &&
 	git log -z --pretty="tformat:%s" >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'NUL separation with --stat' '
+test_expect_success 'NUL separation with --stat' '
 	stat0_part=$(git diff --stat HEAD^ HEAD) &&
 	stat1_part=$(git diff-tree --no-commit-id --stat --root HEAD^) &&
 	printf "add bar\n$stat0_part\n\0$(commit_msg)\n$stat1_part\n" >expected &&
@@ -180,7 +185,7 @@ test_expect_success 'setup more commits' '
 	head4=$(git rev-parse --verify --short HEAD~3)
 '
 
-test_expect_success ICONV 'left alignment formatting' '
+test_expect_success 'left alignment formatting' '
 	git log --pretty="tformat:%<(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	message two                            Z
@@ -202,7 +207,7 @@ test_expect_success ICONV 'left alignment formatting. i18n.logOutputEncoding' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting at the nth column' '
+test_expect_success 'left alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %<|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
@@ -213,7 +218,7 @@ test_expect_success ICONV 'left alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting at the nth column' '
+test_expect_success 'left alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %<|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1 message two                    Z
@@ -235,7 +240,7 @@ test_expect_success ICONV 'left alignment formatting at the nth column. i18n.log
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting with no padding' '
+test_expect_success 'left alignment formatting with no padding' '
 	git log --pretty="tformat:%<(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two
@@ -246,7 +251,7 @@ test_expect_success ICONV 'left alignment formatting with no padding' '
 	test_cmp expected actual
 '
 
-test_expect_success 'left alignment formatting with no padding. i18n.logOutputEncoding' '
+test_expect_success ICONV 'left alignment formatting with no padding. i18n.logOutputEncoding' '
 	git -c i18n.logOutputEncoding=$test_encoding log --pretty="tformat:%<(1)%s" >actual &&
 	cat <<-EOF | iconv -f utf-8 -t $test_encoding >expected &&
 	message two
@@ -257,7 +262,7 @@ test_expect_success 'left alignment formatting with no padding. i18n.logOutputEn
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting with trunc' '
+test_expect_success 'left alignment formatting with trunc' '
 	git log --pretty="tformat:%<(10,trunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF >expected &&
 	message ..
@@ -279,7 +284,7 @@ test_expect_success ICONV 'left alignment formatting with trunc. i18n.logOutputE
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting with ltrunc' '
+test_expect_success 'left alignment formatting with ltrunc' '
 	git log --pretty="tformat:%<(10,ltrunc)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	..sage two
@@ -301,7 +306,7 @@ test_expect_success ICONV 'left alignment formatting with ltrunc. i18n.logOutput
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'left alignment formatting with mtrunc' '
+test_expect_success 'left alignment formatting with mtrunc' '
 	git log --pretty="tformat:%<(10,mtrunc)%s" >actual &&
 	qz_to_tab_space <<-\EOF >expected &&
 	mess.. two
@@ -323,7 +328,7 @@ test_expect_success ICONV 'left alignment formatting with mtrunc. i18n.logOutput
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'right alignment formatting' '
+test_expect_success 'right alignment formatting' '
 	git log --pretty="tformat:%>(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	Z                            message two
@@ -345,7 +350,7 @@ test_expect_success ICONV 'right alignment formatting. i18n.logOutputEncoding' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'right alignment formatting at the nth column' '
+test_expect_success 'right alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %>|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
@@ -356,7 +361,7 @@ test_expect_success ICONV 'right alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'right alignment formatting at the nth column' '
+test_expect_success 'right alignment formatting at the nth column' '
 	COLUMNS=50 git log --pretty="tformat:%h %>|(-10)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1                      message two
@@ -391,7 +396,7 @@ test_expect_success ICONV 'right alignment formatting at the nth column with --g
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'right alignment formatting with no padding' '
+test_expect_success 'right alignment formatting with no padding' '
 	git log --pretty="tformat:%>(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two
@@ -402,7 +407,7 @@ test_expect_success ICONV 'right alignment formatting with no padding' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'right alignment formatting with no padding and with --graph' '
+test_expect_success 'right alignment formatting with no padding and with --graph' '
 	git log --graph --pretty="tformat:%>(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	* message two
@@ -424,7 +429,7 @@ test_expect_success ICONV 'right alignment formatting with no padding. i18n.logO
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'center alignment formatting' '
+test_expect_success 'center alignment formatting' '
 	git log --pretty="tformat:%><(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	Z             message two              Z
@@ -445,7 +450,8 @@ test_expect_success ICONV 'center alignment formatting. i18n.logOutputEncoding'
 	EOF
 	test_cmp expected actual
 '
-test_expect_success ICONV 'center alignment formatting at the nth column' '
+
+test_expect_success 'center alignment formatting at the nth column' '
 	git log --pretty="tformat:%h %><|(40)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
@@ -456,7 +462,7 @@ test_expect_success ICONV 'center alignment formatting at the nth column' '
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'center alignment formatting at the nth column' '
+test_expect_success 'center alignment formatting at the nth column' '
 	COLUMNS=70 git log --pretty="tformat:%h %><|(-30)%s" >actual &&
 	qz_to_tab_space <<-EOF >expected &&
 	$head1           message two          Z
@@ -478,7 +484,7 @@ test_expect_success ICONV 'center alignment formatting at the nth column. i18n.l
 	test_cmp expected actual
 '
 
-test_expect_success ICONV 'center alignment formatting with no padding' '
+test_expect_success 'center alignment formatting with no padding' '
 	git log --pretty="tformat:%><(1)%s" >actual &&
 	cat <<-EOF >expected &&
 	message two

-- 
2.53.0.295.g64333814d3.dirty

