Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B1C2EBB99
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771389536; cv=none; b=XeuRpnxZf2fEKWW2ji2xLzdinudgfreKhheIMMZ7TG9e0MnigPMc+SzqsqNSIb50pu9J48QZP5ULkKqdLgKfmyl2TbviD/5ZPhIZTbZarNClx+cIl5a+5UT3v2xMIcWuvYmMnk91XpmS9xpGw/7u1cRM9z/4rwjyktXRTz93RuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771389536; c=relaxed/simple;
	bh=+KgTM2i7CMaEZsqaNyoyZxvfvtujm2n1o6/39VP1nTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c7D2V/x6totlfTKRnC7ILPrNMFXDnDcXPuu6W8VpeA1zyO3F5pr2FOK7DEmmLxfmK7GNI4gcj1tkgjT5FUP1EafQxKUsAkVKoRWIeWloC9UvhiZoN+1l7ohi5bERDiWHIGX+g6nMzQQ2XK+LZ89vmgUuBnc2dWixt51+RYoz/Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JgcFbE2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UFpOOrmz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JgcFbE2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UFpOOrmz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2EA751400179;
	Tue, 17 Feb 2026 23:38:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 17 Feb 2026 23:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771389534;
	 x=1771475934; bh=jHDUMxn0vgoO8Wy89VKU3aP0zeUb0kIHzPttlH6ieUo=; b=
	JgcFbE2X0n6XGo18XbI+y16+O5lkcExKRY8jifOyJMrdNtKqGbEQENzmk0sLfcdN
	4oq+wceT3n8ogx9tw9MaFh6Fepf5dPn8P/1ahLBvXc9D2HEF7U1zE7m54ecye8yw
	LC1vyAYbiiUr12QoIhmfAGM9mpmS1QRa4RhlvsHcPUdrXeLFFBPEXMxEkEvkVAg6
	0kMFyxy9g0Qiu29L/rCThkvOYq2C093Em630uFjhcSlFiB71XpjZLSrc/YqZ7r5J
	Hp6uTAu47jElPX9k5og563SYb/HD3zakQGCkOxjRz8JnFLN2SY4WJiGxmGmGXB+R
	yBc9eqdBM6IuDtx0nsO/Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771389534; x=
	1771475934; bh=jHDUMxn0vgoO8Wy89VKU3aP0zeUb0kIHzPttlH6ieUo=; b=U
	FpOOrmzMgROCkrMGbYyCOUOMOwQcMl6AH3hbgZ/Z01uewZ7miVQ/sHaQegCM0qtP
	FFAvRWb2qDsBWA8aCfJYyDlgos56DXpQOAUJy8ELyp3ax55/mFgHMlx+NvII0xX0
	fXTUgLFxTAk7+ROCz1olnvofyNMC6s3cRrr0fkeBQ9iQcKszFYmxsm/Wpf3BA0bp
	T++su/WoKfZIApFtEULa47w7hpPYcqOnDD4PUGteFq91MMha06k7eMfYQE+XiFUv
	K4ei4RYTO28ePRVQNbBOLHiMIS7XbV6Tnb3Fx4Ga+H/UgzRxGnZcRm8v8LYasOLJ
	m7wudhVjAg+4ud88WPrSg==
X-ME-Sender: <xms:XkKVaUkatKLfyfeXUGJox6447syhFLetHyZvjqgxGzC2NdSAnd6RvQ>
    <xme:XkKVaZ1mLHikL6Y1VBXgEziy-Ytv9zwXS77s_FSauDt8-gqvcuYBKr9tJ8pZ4puIY
    Lr92t3LMQaTd2nuN6rKc-vTG-WGlTpW-7ZbolTy65gUstmj2HAOmg>
X-ME-Received: <xmr:XkKVaQS1HQKpb27JB0VBtPaTuUgF4W3ip-6AQmLsrDJA6B2tFXq1sp-iO_Na84dWww1ZKaQbLi5ulY2msOSDWOPN4OWyPJh-oqBZEsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvddujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:XkKVabvz0RaPp0tCICCrc3_0DfQ4iqdCWrtlTe1ZEpRlBaQWC37EuA>
    <xmx:XkKVaVZGiRyKXcyUKHst3or4xYXOYiBdai7WBWRGNolYvySZIl8d7g>
    <xmx:XkKVaQsihIQ5GprcYAVbTJ_mobULxrcGp8VLEkdQo5E5uUs5GOOp3Q>
    <xmx:XkKVaXETkeoVh00gmyjUsOHYj8-H6Vvoa6AMQLCznqE-uvXG3E6WWw>
    <xmx:XkKVaf8AuaTL0e0CapPm2e72C52316UHXUA9oO1CnhMiZr5gt7Zf8_-6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 23:38:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67d4cc68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Feb 2026 04:38:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 18 Feb 2026 05:38:40 +0100
Subject: [PATCH v3 3/5] t4205: improve handling of ICONV prerequisite
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-3-08c1ff3ffc9a@pks.im>
References: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
In-Reply-To: <20260218-b4-pks-ci-msvc-iconv-fixes-v3-0-08c1ff3ffc9a@pks.im>
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
2.53.0.414.gf7e9f6c205.dirty

