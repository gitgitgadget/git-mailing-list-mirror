Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F390212FA6
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071852; cv=none; b=vD8o+IFHEVQuIfEJanpMU2L2Kc60T7r8FPS29iXtHGoSnyYhRz1uxwAcoo3yZEZuNUXY+ayoZMyr/FtfcWwxYouO2ULSS94u9Wvly7XAR7HevLrCTU3ftXcQr974S/MgMtr2RoOBKJ0dRz0bdBBJbHxsCxcN1440Z6dm8Snkr2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071852; c=relaxed/simple;
	bh=S0793xqNnZtEOK+SMpisZGDO6NlmigsE8gk9i3ZjQTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WeIltAJ3ANE760pRxcsYCt40zUDGWGIPL0epE10S6TXnUkvTf1fdMV/VgxQxZwscNJtgVsCBMxXG/h5gqUh0698o0CRsXJgcC8+cuMcBVMrOXejxrV2jI0MX+yQXCc3BqnzYVDeSqad1gpp6xNnXBG20JugMrtASpseEdS+hO2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IgwjxnKD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WMluImJs; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IgwjxnKD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WMluImJs"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id E1DAA138390D;
	Thu, 27 Mar 2025 06:37:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 06:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071849;
	 x=1743158249; bh=eCj9Ek2/c1TfxacmjqQ7rCgPJWlYGz0nqgBP5yUAAvg=; b=
	IgwjxnKD57o0DPDo1f+s1+5bw3B3QxYvyg+1hpGAlB2TlLE8h3SBentKvqx7OSlO
	9fOo5dB1l2gxy+tnfhc9zIbvAHTQZItjNZvisgZvBLZO14Am3bu43iJGlITExANQ
	jM5WlP0KgaJFA6ZBLBil8LAeTOlREiI1t3Rlb60jZ05nFZK2tgkVgdS/c982Ddd8
	6E24+qq14Yj5JkbzZ4LJg+ZwOXRKtV0/n7ECHMdddVTUnnVb6r/ODP7fcpgqAjIz
	DbRsljh8qVXZr5VI6fWEQyqVohNFeFgG0k5LeYcO8Ru3UksqtZWmgmNjYQTbUvcA
	FJRWAOdMbxID0sEslweefw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071849; x=
	1743158249; bh=eCj9Ek2/c1TfxacmjqQ7rCgPJWlYGz0nqgBP5yUAAvg=; b=W
	MluImJsI8Xqo+f9I9QxqbJzt0/+XCgkmZYoy1yJ9zMvdc9BOd5qcuZt4XOuW0LYO
	345/SbVQERY+Xdv3FkI741/++7YXssBdl/8s5sMif9gxh7t/zLMdhQCGFnb6DTC4
	Q0x+JFY15DYPJ+uiIq373sJEiWNCjhu/MquRFSeOchy0PT4m/56J6G2mKHqd1/US
	Lyz7PeurjarFDlvrLaNdksmYb/tQ3gsuvtwOPFIIeBufCVMMOyp9LPHKgpO77BAu
	QZXh3Vvnzbx0124wvvQPzJGyL7VAETAThEoFSg7eVyKQnXUR/n1PxEFt4DS4TcRT
	ssM1a1w6vkewuNWHV/bUg==
X-ME-Sender: <xms:aSrlZ0wuwWzLXqaLrAoXbl-6X-xULgmD7XBKIwXcZbe_LNUMXd4lpA>
    <xme:aSrlZ4Qa37u-THQsSCiw719VbOHyV4u8ufqxenyWTAkw0kaY9_765xXLfBr58NNWM
    QY_0MWZXCOLcOujPg>
X-ME-Received: <xmr:aSrlZ2U64VB8yrJYOMs-ZTRF15mHp6TV2k-j-v_rt2ZK7YmAwdxxvd--kqVFS9XBSD9UBEOxDclfImG9gH7IcRAEznknkjDlZ20BjeeA8eq0TA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:aSrlZygHXHq0-hSWL8_FznKGw0VHGKg7ESmZA0QcwE1nR10kJe6Txw>
    <xmx:aSrlZ2DAwExTtAOreF0rq9Eeu0YKF0cSDrlNFlKf1_1h43iaY8aUEw>
    <xmx:aSrlZzLFTvTvM82XxY9_V4Sp1RzCTajn3Ed8oIIJT54g4m7p9p5Zww>
    <xmx:aSrlZ9BzamM3Ne3K2SNjh9EwX6FgM-dN1QT9Hm-HIP8QnflEvO_SLQ>
    <xmx:aSrlZ95PxXuINsBBoD8dBsF7K0YK-Ee4vDgwBGFD8tPAZsiPghzJQk3O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d373f1ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:18 +0100
Subject: [PATCH v3 20/20] t5703: refactor test to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-20-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We use Perl due to two different reasons in t5703:

  - To filter advertised capabilities.

  - To set up a CGI script with HTTPD.

Refactor the first category to use `test_grep` instead. Refactoring the
second category would be a bit more involved, so instead we add the
PERL_TEST_HELPERS prerequisite to those individual tests now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5703-upload-pack-ref-in-want.sh | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index fc915e7b823..249137b4673 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -4,12 +4,6 @@ test_description='upload-pack ref-in-want'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping upload-pack ref-in-want tests; Perl not available'
-	test_done
-fi
-
 get_actual_refs () {
 	sed -n -e '/wanted-refs/,/0001/{
 		/wanted-refs/d
@@ -89,18 +83,15 @@ test_expect_success 'setup repository' '
 
 test_expect_success 'config controls ref-in-want advertisement' '
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_must_be_empty out.filter &&
+	test_grep ! "ref-in-want" out &&
 
 	git config uploadpack.allowRefInWant false &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_must_be_empty out.filter &&
+	test_grep ! "ref-in-want" out &&
 
 	git config uploadpack.allowRefInWant true &&
 	test-tool serve-v2 --advertise-capabilities >out &&
-	perl -ne "/ref-in-want/ and print" out >out.filter &&
-	test_file_not_empty out.filter
+	test_grep "ref-in-want" out
 '
 
 test_expect_success 'invalid want-ref line' '
@@ -486,7 +477,7 @@ inconsistency () {
 	EOF
 }
 
-test_expect_success 'server is initially ahead - no ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially ahead - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -495,7 +486,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	test_grep "fatal: remote error: upload-pack: not our ref" err
 '
 
-test_expect_success 'server is initially ahead - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -507,7 +498,7 @@ test_expect_success 'server is initially ahead - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server is initially behind - no ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially behind - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -519,7 +510,7 @@ test_expect_success 'server is initially behind - no ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server is initially behind - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -531,7 +522,7 @@ test_expect_success 'server is initially behind - ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_success 'server loses a ref - ref in want' '
+test_expect_success PERL_TEST_HELPERS 'server loses a ref - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&

-- 
2.49.0.472.ge94155a9ec.dirty

