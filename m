Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD2336B055
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336720; cv=none; b=YTEz19NmhrUzR+hpg8+ut9hxOYdgN0cqw636C23RgMVIdjiOIBhzIWLb9on8VrX8hIpdtpW+EfgRHGGJMXvpOS2/etYbYheAFALJO/BGvmAE2fiGqN/0tMIruDhLPmwv99mLn0eC5XU8mpvIjcDwQOq7xtNuKed7ydCeBgVdsNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336720; c=relaxed/simple;
	bh=AsZJvyQYgZsezlsOpChWxvJJsbpBq003nPwAjjjwWt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OOwWRJJEZExwgN7OXigvhfJIBpQVg6NDrp2GEczAPpdUuYap25mWssepv6GKe9T/yLikUr+kjzmDX2kMQjLvpGZKXFp8xDUqv+xxE5kxmpqrm0SCheWuBIOvO1LNkB+F7AXJDVyMk8g1jMSnjCZmgcW2CBohrwpfi5TvTXdxzDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FY8tKchT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=abowpghd; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FY8tKchT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="abowpghd"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id BD883EC05A3;
	Tue, 17 Feb 2026 08:58:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 08:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771336718;
	 x=1771423118; bh=grI4eyQAjqzKi2F/esDrEs38IrBBolYB4/8PrhKt5x8=; b=
	FY8tKchT0cudMElGKmk2QmmuC2+9E3PwEI7t+rd86J7qxCc7xMDR5vkUOcG/nv+4
	IvIsXqRTj6m7o1+b6bvEltvWVTCE0shh30xM/GZZthXM04CA1nHbuZfGEgQrI9D8
	kRYGJAwfjf4iPFV/Y9K4caFE7VqJqQkg3S4rkqvSfVa6AhAuf92CHS2JCiz7enCM
	rV/wWyugJRBWE9h9Iekv0QVL1felmTv6NGzWsVPAht12mNafa+fxiugMBkyAi6eU
	Lm9FpJdglHeYdgxrEON+TsunAR/c5falH1TcWTx/wEJXObyeul+fhuWBrU69Xouo
	bHHmVw4P001NK2JmhPjVCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771336718; x=
	1771423118; bh=grI4eyQAjqzKi2F/esDrEs38IrBBolYB4/8PrhKt5x8=; b=a
	bowpghdo/zYqH94QjqBz4hDLBQxgocFfZBTI3JFzA/kk8fl4GrYlG/TBrDNwx6r2
	LjlkIs31ChrQtE1RxSdsabpg3tZKtWbANR0SJBBpZ/hzGXWFMZCOPhrUHXeGmYBu
	3EipPuxNP8zpfesUH8U5tPbPrXZbkqKvX8CxqtTWy9pKVCGTYZQxPhw3o6ZGgazW
	tshhq0tXmJbE6u0frLriC6lIjl7TJ+74z1WZHByCJ1frBaVa3PAurok1Hb35r7hz
	VdT/imZMASAjltec9ZfCR+iZWq12digBt0s5b9npQtx5Pc7Hsr5DHZOIVhsPqbx9
	GzlcursWjRlz45p8jivUA==
X-ME-Sender: <xms:DnSUaaW1J3C-QDTQaliC5WUKDeU9nsXPRHWz0El2a1Wron6beKQsrA>
    <xme:DnSUack0ytDsIAmncIYeX9yOuMq8cdkw_yRTyGl52vqlnJbPUG_c5Udc9YePOMwcg
    HqGl6EPXNcDO955RZ7JqfGhc-4rVOsd78Zl7--GL2_kqQBpMtTekXE>
X-ME-Received: <xmr:DnSUacAFGr0g1x0vKbzvHm0l-7UH6vdiRAtBGfxCCucQC7DFJE7BStERmqwu24LZYqdRstNmk5omoW5jIF5nozgtTvXJnJMrq3s8pch8pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghm
    ihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DnSUacc7GdqhizWaAbEeHgvi23p2DR2cDz4nwKxfppFQfiYBUW1mcQ>
    <xmx:DnSUaXK7rR_n22swxtv1CPbRMMkIP_PcYJKQkU-id_CRQRINNP5zNA>
    <xmx:DnSUafcmEdqfGzRFAnHFO8LaHOuEFjyxaVhf9WBUgjVuhf9LyRKcew>
    <xmx:DnSUae0zmDvNfH041QA7DyjsiySMevVznpGRg_UvXcsXRPkDQ_vrAA>
    <xmx:DnSUaVt6SaD-emMmPCqGQVycNTFPt9Fndc22C0LBP0QuMEimpMa6QIOS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Feb 2026 08:58:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d2496fd3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Feb 2026 13:58:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 17 Feb 2026 14:58:28 +0100
Subject: [PATCH v2 2/4] t4205: improve handling of ICONV prerequisite
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-2-25491bc8dbf8@pks.im>
References: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
In-Reply-To: <20260217-b4-pks-ci-msvc-iconv-fixes-v2-0-25491bc8dbf8@pks.im>
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
2.53.0.352.gd1286b26eb.dirty

