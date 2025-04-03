Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C01C84B2
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656778; cv=none; b=KfFnolGMkapnk+LtdU1Elitir+j85TP6MqqADSFDN6b0b2mNoSvInpRxOcHwVKDwJauufnRB1xwChkHaEctfJ7u9x920vlfoCkV2wWk5eZWTnFL8zVzY69OvizPQQ+bZnK8QfXcfu19kTCpDOmafQEscJKFkZ8/FrVBjn58Cc3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656778; c=relaxed/simple;
	bh=Z2y+bIJ+/X1xpmaodcJ05Qgf7bKZVgWfXCAMY2zXOKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiUTI5eQExeEu0S8JZwOxg+Yj6CQbQV0JRWmfl0vF0bycUx2lTF8Ul+J807v/XRNnmdBoar9gfqHVFxlRRGy9+yh4L8poI28T2O1IB9I8gyP8z021AUHcR0OGmoGIY4Hu1ld9EOsZG0tLTttHEk2uGfX7MH1fgz9PzIROu4s0A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nVDl4huj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hcJRQkVH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nVDl4huj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hcJRQkVH"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F7A625401DA;
	Thu,  3 Apr 2025 01:06:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 03 Apr 2025 01:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656775;
	 x=1743743175; bh=cVj9uoJ46LL6DCCoOZS8qarCVZDsS8EKJ7JhWFHgbsg=; b=
	nVDl4huj05LMn/dHH5cSTJzc905dVarm9snrE4UsgdHWCRmcmx1z0nJAhVXNXyoo
	BN3fxGlizz6sc7znar5a/tZsmcVyB3Hnnc9IzwJN+j7x5Lfb2FKRL0CzmZXt1ONJ
	8Guqf5ox5ADIPu5leifxslMgFnRVuqonUMT/CKcl8Jukh3OZ/sUUdyMd0bLy8fOI
	3Qg9CV4twq4i4d3utOLA6OBHJ5RslxGj4fWfS5bN3HV0n5ngmDk4thHhRrIvUlxp
	mqaU1h3OvhYZJHplWCqYKmzRAdEN+TyOI7sc73e3h9hlDbz0AhLm+lGmLP8oOGtn
	T7Dv9cXQbgTlqv7UWoyxfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656775; x=
	1743743175; bh=cVj9uoJ46LL6DCCoOZS8qarCVZDsS8EKJ7JhWFHgbsg=; b=h
	cJRQkVHSTPeKmaCOhHqloxXE2WX60StEBXa1c1j6EebvuEqBBgNLTInEMJD5TXL7
	kJrl71QA7AOLHOSNEKBJ0I7wwfD6NsgQFAuAymD4Yr+BA6V73MW0U2gZXIHNzvaO
	hSeTDlv2ovL3bSEN07nOVkFkESDE7kCH6Nw+iqOjd1MPKVuu82ascmuKOuPP8zq+
	Lz8PE878n8fmAHvqlCAI/QWDyqFD5+g3MW1fRKmOGMgHN5IHjXehZRkvqn13mm2J
	jBNJKAUwxZAiSZ/UuvbGy934QEJcU6c9uLLJ0ZyPQknUpiqfjRo84554irOmE1UZ
	Iey4gM1LxjJRBnJvunftw==
X-ME-Sender: <xms:RxfuZ-xyRdAGk6JlUWZqCMUP3glkXL7iZR6x3MNskXp0n7mSoDoReQ>
    <xme:RxfuZ6QSWPRLMq7-G2VssczBEhLi2MTEsDdQHoysUD6KSsHWqYPsfo17bw1U17F_L
    JDztCeIwiSEyClS1w>
X-ME-Received: <xmr:RxfuZwWgz4jmFmWBJj5GvEbDWVHRYJ53h37JKNnxHjS6WH6HGJi6XMknOOFF9p0JNHKHJVnkQDaf2shMEY1JWugHsTXYelqD6zz1PwBco1h1o0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:RxfuZ0gMq-lyVtAyiUvgG1g42RIM7o1kIZ-_K6YNOikj1aPoTPy9hQ>
    <xmx:RxfuZwCvgClgIc9Fy8vK6pYvdoexW0FT2ovzYyYh52mOROyZDBQKBg>
    <xmx:RxfuZ1If6x193WcW_nEg08N-ghRVHYH7EaihOxlh7Tr0zVOG_rla7w>
    <xmx:RxfuZ3CTdWmfrFVK0ysMJufzcUHZxebNsBFBHa4beHF2DY-faCdnrQ>
    <xmx:RxfuZwEPD5dYFVtN15bCtw9EPQqCKeJGiKsHiUrgtbQsdlmH8Eqyi_ww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 616069b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:11 +0200
Subject: [PATCH v4 20/20] t5703: refactor test to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-20-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

