Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6673C3358CD
	for <git@vger.kernel.org>; Fri, 20 Feb 2026 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575976; cv=none; b=AmTpXXkt0RLE4ABUiWZdhF+yBGv9HPj1jExfDvILwGmPJlrD/5twMUtg1qxO/TE8HA5MHGcI4QUx90vDxpgI7Y+vjq2r4bziwlcvpa4tc9Da5pJiZcA776ae1r4Z7WDral0C/uu0OyHu6eeePavzQ9qkVV82q2SrQmGYcGDMMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575976; c=relaxed/simple;
	bh=+KgTM2i7CMaEZsqaNyoyZxvfvtujm2n1o6/39VP1nTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=heyexAsm5KZ9GqLJGSQA4e5JZurORZJYdcwl14exQ0Am4QarR5bZ95IsYBbYqdQHB8bFFAlVaTsEYGstswvXYxRbBug52wVSlJVXmJTNv9mFGxdFYuVwdKMMA1+vTGb4TA2Kcn/pUboa3u6mMhHJutXS9cvFRsk+UZxIjvpRB9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qQk9PkXi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wHYXHxlj; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qQk9PkXi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wHYXHxlj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 626387A01D3;
	Fri, 20 Feb 2026 03:26:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 20 Feb 2026 03:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771575974;
	 x=1771662374; bh=jHDUMxn0vgoO8Wy89VKU3aP0zeUb0kIHzPttlH6ieUo=; b=
	qQk9PkXi+ebRdRc2cS4oXYGALV/9jfA+0EXSWW/ZYNiMiFmmqP3DFalrmku8nxLe
	dv/1X6bE/ZfG1iISZS4p0TkYZL6JXSXV9w4Wl9YyfOMIPl3y2IjTDliTaR9ip+Ss
	qyAeSVPuXDufnc/7yhas0wn0YAyJ1sbB4FPEFp+skFclHOi+aQqxR+3Raw3VKVja
	XRQU1L/LlRJK4E1yEN7lBkag1JHdhKQnGosK8diOBAAg0WvH7t1YJa3dATDEN5oN
	rmPfX2CBr/eckW6mVfF/j9hNGH2/O/+ntBOiXTX3svdIrkhCMF3o0HW9RK3m3T0p
	5cDMeEiljrvulQ+ztlxqkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771575974; x=
	1771662374; bh=jHDUMxn0vgoO8Wy89VKU3aP0zeUb0kIHzPttlH6ieUo=; b=w
	HYXHxlj2W3HUuycwNuHJaBKdpIpNVEn4PlHpdQ+NmuFpo3X65/p1PJ/CHDx6PF3q
	NNG0gegvtx7QPxow52CbcNXnFBohas3qNOUjoZjwUjBOoefkiMPFv3yYcW0lJ2pk
	dyQx7Yj6lJBMVnuR7qrRGRlu5f26xcMHX7KqmbjXdOL+QD48BGNAZN5U6xSiLolE
	wwLbf4C717pucsj8KlPuS05BSpwajuJomnifGbpUpCWNB4AP/KEWLSTro1GFCcW1
	cn619CRtL+odx1BOO+5EDT/c9LzLzsVhtVwO/ngWGs98cyEmhO3aJ+cEbP+xJiNE
	xiGmnbgkcqYMT6WPBG0Zg==
X-ME-Sender: <xms:phqYaUieP11nWOCmM-d8kR2895pextSdeH0rPm5ykZ18sNx4wfNYNA>
    <xme:phqYaUDV2ZkmB0ZMgTjfyvUIhpSQ2B1hABHtA1fB1wYYWaKy88gBb2wrJvx2rW8m-
    YwgvYEtx_cpQGol1dbSZKlLNVSC_PKHdekwWahPvwY12uFBh5E5yA>
X-ME-Received: <xmr:phqYaRFaQbyq2bzTExncY-6ZZyTH9fSCTOq0BQ0KcD846A8k0uhRyaFgH3WCuXFp5AoO6mlk6uifl2ABXFOhInqypXxG15wjAJFtEe4NZQiM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghhrhhish
    gtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehsuhhnshhhihhnvges
    shhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:phqYaUKtin3w4stYDAavqsfw-h4jvuvmNg79qkQgB8PELz9TDhHkmg>
    <xmx:phqYadlGzq1gQmdM4XeMOoDWEmCylPzkyVNdrYrqH6o8CBBl8pbU8Q>
    <xmx:phqYaURuHSHm8pUmPYzX3rL_tEGhGWBkGsF8KXqDADIO__9373oRvQ>
    <xmx:phqYaXIeNLF_gCBjNtg65y9-JhO1XVh3MuZfJs1mc3R_d89xLxp4Jw>
    <xmx:phqYaV1xRJEWThNgAluKidGjRyXW-p-keNy_FRtaM7dW66SP1zKVqcNe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Feb 2026 03:26:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8133ebb0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Feb 2026 08:26:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Feb 2026 09:26:01 +0100
Subject: [PATCH v4 3/5] t4205: improve handling of ICONV prerequisite
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-3-e0e6bbcaeb5b@pks.im>
References: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
In-Reply-To: <20260220-b4-pks-ci-msvc-iconv-fixes-v4-0-e0e6bbcaeb5b@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
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

