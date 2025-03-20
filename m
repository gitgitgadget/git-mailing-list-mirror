Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C711224AFB
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463348; cv=none; b=cuJxsHUJGM3fMe5pPAk1qKzKEosPd4khU3TsDIrPMgKuXWyUKy1a1nCm0DKdKtiXlO2lDOwh7EeFvUO/ewBF3K5r9I7QG+9pGPawwDbFVep+YYk7zBDtgsSnfsQ416kDHOj85rKz9SY+TOykIZLW1TNPYuJ17D4rXZq3Q4OnKWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463348; c=relaxed/simple;
	bh=OzPEXYJJSkCRVgvE9r/ZR014p4QQC/SiVAp5FNaVjm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxoXsvK0SL7e6rbhTUzBTlnSHVkgXwG9nRl55nODqT/uz61ZA0LGugsMFH9VMMBKv6Xoz2R2aGblnmungEi6sebC5LonDn14kGOZHhz3Z7hwuBEjVmupDLXEp+4qAgf8X4RFhOCs5uq5fYvYKyjOSP5x4CKB0wf+f/2A+EzKPUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zg54pa2O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UPKVI5Lh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zg54pa2O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UPKVI5Lh"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1983D2540170;
	Thu, 20 Mar 2025 05:35:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Mar 2025 05:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463345;
	 x=1742549745; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=
	Zg54pa2OSUO+tdegnMztpCfLmqRhpkGs2fjzI/nnR0R2RXz1OaJSo2DLxOQ8Bva7
	Xsn57TorvBoNOVEIzR9jPwBFPdLvEuV7RArIXBc/P/7F68zteOk5sw6/Teu6Lpan
	xWnt95GqZ9EQ4Fj4mAi5tdg09beJjuxVz4EyM/LJE7x0M/WN33295SQTT8dmOxW2
	cVTSl6/sj2Qy6uCEkuzsMX9hMLb2RSUTOoKzOfX9YllWJDwIFhXFKYxfrjYbM8qG
	Dg47zaH8o7lvKC1VM414iZytrs5q45Vb5yZg2xRysUcpWQZNbD2o84/GybVyODLm
	yE1+LVBl8t5qNJy1dpZyZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463345; x=
	1742549745; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=U
	PKVI5LhqZYzna+L/y93Rmgn6L+VOCcqxec7o79C0q1LlBTXs3qSofrMp2XNf7It+
	AYXg1vRtBLGAp3GImPdexN936AryHhogFZcpyNIVcYHOrCeWvv2c8WageEKSE3wp
	73TaMcKuzTHQBeAyN5a/LAfXS96bLZaniVzH3SSWqJrfy4W4AwW3it9Zc/y+mfOI
	l0WQ87hn3j4PR06xQ5C6QSOe7RCpJr/RQCMRKqsAjr0wNvKdOTuZAGf9XwYFzcW6
	j3RTLUZc01EbsESPFVXmsevPjYwrPCg3hfMA2MvMzx+lQi+iB7duE8lUWSI2/FnU
	xlReo2w5xRUWbtC+eDlEw==
X-ME-Sender: <xms:ceHbZ5yL2BYLv4O-d4gIAUWMYJD6m4pnpjw_-D2GQ_kzyIH-nxKvpg>
    <xme:ceHbZ5S1Z4uSILfX40pST2D9v8IRuHP_nGlDGa3iuEQTh4r4KQWYcHRmj2ni6lBJ6
    yb-7lawcSx3Qr9ERA>
X-ME-Received: <xmr:ceHbZzWgGzycxz1Kny0Q5JSMC_Cts0VEXc_zCvLCjWuusq7zlNYJcehAIFv9uDSHH6yLlB6cLoM53dCHkWU02fV1_SyCJHKNPx8fkFUmaZ_ud-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ceHbZ7hAclWblQGcGW9ocIuWnT7LPiOXukLmRrgxOmunIU6HHATcKQ>
    <xmx:ceHbZ7Cirn3mHPfGqnrx996DbSbe0XvokshsIwK1FtaLfrUzCrdozQ>
    <xmx:ceHbZ0IBrITd09jzSW7wCq3xwKOwez5vycwdZsnPdV4HIMuFvGG-IA>
    <xmx:ceHbZ6Bm092i9vjPTp3tJ7UUOsGvd3TwRVu6L5P05TaBDFOIihRUZg>
    <xmx:ceHbZ-NVyTr4ctux1iML2PBFAk48UjkqrZku5Jo-XZrgyaVoEmzBo9TY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 56c97458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:41 +0100
Subject: [PATCH 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not depend
 on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-14-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The `sanitize_pgp()` test helper uses Perl to strip PGP signatures from
stdin. Refactor it to instead use awk(1) so that we drop the
PERL_TEST_HELPERS prerequisite in users of this library.

Note that we have to add PERL_TEST_HELPERS to a subset of tests in t6300
now that the test suite doesn't bail out early anymore in case the
prerequisite isn't set.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-gpg.sh            |  6 +-----
 t/t6300-for-each-ref.sh | 21 ++++++++++-----------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 3845b6ac449..937b876bd05 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -192,9 +192,5 @@ test_lazy_prereq GPGSSH_VERIFYTIME '
 '
 
 sanitize_pgp() {
-	perl -ne '
-		/^-----END PGP/ and $in_pgp = 0;
-		print unless $in_pgp;
-		/^-----BEGIN PGP/ and $in_pgp = 1;
-	'
+	sed "/^-----BEGIN PGP/,/^-----END PGP/{/^-/p;d;}"
 }
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 732a4d3171e..5db7038c417 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -10,12 +10,6 @@ GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping for-each-ref tests; Perl not available'
-	test_done
-fi
-
 # Mon Jul 3 23:18:43 2006 +0000
 datestamp=1151968723
 setdate_and_increment () {
@@ -1215,7 +1209,7 @@ test_expect_success '%(raw) with --tcl must fail' '
 	test_must_fail git for-each-ref --format="%(raw)" --tcl
 '
 
-test_expect_success '%(raw) with --perl' '
+test_expect_success PERL_TEST_HELPERS '%(raw) with --perl' '
 	git for-each-ref --format="\$name= %(raw);
 print \"\$name\"" refs/myblobs/blob1 --perl | perl >actual &&
 	cmp blob1 actual &&
@@ -1442,9 +1436,14 @@ test_expect_success 'set up trailers for next test' '
 '
 
 test_trailer_option () {
+	if test "$#" -eq 3
+	then
+		prereq="$1"
+		shift
+	fi &&
 	title=$1 option=$2
 	cat >expect
-	test_expect_success "$title" '
+	test_expect_success $prereq "$title" '
 		git for-each-ref --format="%($option)" refs/heads/main >actual &&
 		test_cmp expect actual &&
 		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
@@ -1452,7 +1451,7 @@ test_trailer_option () {
 	'
 }
 
-test_trailer_option '%(trailers:unfold) unfolds trailers' \
+test_trailer_option PERL_TEST_HELPERS '%(trailers:unfold) unfolds trailers' \
 	'trailers:unfold' <<-EOF
 	$(unfold <trailers)
 
@@ -1482,13 +1481,13 @@ test_trailer_option '%(trailers:only=no) shows all trailers' \
 
 	EOF
 
-test_trailer_option '%(trailers:only) and %(trailers:unfold) work together' \
+test_trailer_option PERL_TEST_HELPERS '%(trailers:only) and %(trailers:unfold) work together' \
 	'trailers:only,unfold' <<-EOF
 	$(grep -v patch.description <trailers | unfold)
 
 	EOF
 
-test_trailer_option '%(trailers:unfold) and %(trailers:only) work together' \
+test_trailer_option PERL_TEST_HELPERS '%(trailers:unfold) and %(trailers:only) work together' \
 	'trailers:unfold,only' <<-EOF
 	$(grep -v patch.description <trailers | unfold)
 

-- 
2.49.0.472.ge94155a9ec.dirty

