Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9D022541F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463354; cv=none; b=n18svbRA4ul67as5FBflrOLeK/8cmmIfdRWdunSNb9qcYazjiDupHMHvb9v++ykRWWhfmwDdTborHYwzk876L9F/lL7pTZDZ/I3BMMZnDFhLd6pxHGTPrF4nWlJ8fy+eBwL4ov8EC7y7d0H2wnWC5uIuRFHqLGjWJYpPcYktxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463354; c=relaxed/simple;
	bh=0vDLZtJoO0JWlSJGdB1334hkWHi1ZII88VJ3KTVuw4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I10L7TuJ4R9K77wWGz3oW/NYJ5Wc8Cu+7wpTLwhtSSzMf71GEPxV6PuGqm3SNPZtjZPHArF5JxS56w8Tlr6B619YfzWZxA9/bJXiTAFiAAvNoyk9qCpgQFobkW4cUepyP+tz+Rrpm5C36W2N/dEd5h0CwIxEvF6YiF5VkHek4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PuxxUQ68; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6szfIjF3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PuxxUQ68";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6szfIjF3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F5672540099;
	Thu, 20 Mar 2025 05:35:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 20 Mar 2025 05:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463351;
	 x=1742549751; bh=8mNJ6Dr3p2I6SWEWYBP3GmUzLBsShSYpobEZZTH9ZWE=; b=
	PuxxUQ68KIXd6S8N7g3h0x40ql/B4ei9AWBVHG2ebKloooN4noALT3gG0479q9Zj
	G9sQY+k7a0nMPtORAVCFvGolm3rUHll66vgnRV5RGDJ1LH8cuTqS1UZelaNHVteK
	z8rvFHttAkkPnbb6S/Bkd1hulWvbcVGP+U0La1BQk3gQFXuj9P0369nTU1SFU1Ea
	Pp2JcIq8BMl6yqaaVDwNgUe0C8Ttc/kflG6ltu9IL9vxS7s7i7HgO1KQyC/XAjyW
	d/9NPedK8LV37awlDOr/qp3XG4Mwl/mDIh2cNdZO7B1IatSW2CFUBqEOyKY5TsV7
	Z2JxMJzTWEFaPA7mSBhIuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463351; x=
	1742549751; bh=8mNJ6Dr3p2I6SWEWYBP3GmUzLBsShSYpobEZZTH9ZWE=; b=6
	szfIjF37lPATkZ7ALJ9SztkFbT7wRIZ6Du/KcZN81biNqUji6InOF1++B5gatQfL
	Na0g4CYYOziTEnPjxlLrl8XMLFQ4+asKknl+RknNKp9QH7ALKTpZtVxAhfpPMySr
	1Ku0rs6e4GfQLuUMx8BsSM7A7ao0u4YOXZ66d7INu5ZmOxJuApLjzY0lnCoVOl0p
	l2e/Kfr73kaSq40FaHgP0miCL8DY/tDJke3NofT2wYwPnzBZL4Oknnjn6dEIEU6r
	wudqArLS8UrWyxhqT7f4t2RQTMRD68Udqz5UlJm+SXeg2me8i4RQPOxqMYzUXBO9
	Z+Q6MrzoL6rPQVyBDtvZA==
X-ME-Sender: <xms:d-HbZ3sOx852xjjABkiwm2yNAd_aV3l9gggpkxfSiUVS39cIhRT53Q>
    <xme:d-HbZ4fIHS3rE_ud3T_xDAm33YDvK1pz2-Z-sUtugG3P88lk1hFY56fOmMMCj5cE0
    qTgl-wdTyVDs_DIfg>
X-ME-Received: <xmr:d-HbZ6wDrN1qgj4OLqx6IDMpRy9AwntpcR4xbexqjd2giufZ5L3CoP37sK6iJnh5fqMcXPad6Gy84LGkyzpj_3mWwTyOLO2F_TYKfZcxJp92JPE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:d-HbZ2OE_bxRfsOHzoSLwXkrdAUlBQDJOcfY8dr9x4N-8CqbEW7Ihg>
    <xmx:d-HbZ38Ual6fjfJIVyQ3ujbxI_93uA_mC64625w7AJ1XMwT2_-63kQ>
    <xmx:d-HbZ2VwjwmUlw8HpCFOlEoyve6VAgQBwAlw_AZyhrW_Bqkf9wUyyg>
    <xmx:d-HbZ4cqx5bhWXLacT_fTBL2Z1MzUM5Q2Fww_1Epkb-8SHQNbyeMXA>
    <xmx:d-HbZ5KSjaJTR_-WLJSvrnG80yGa3FEybl8e-O3HU3fJuxguzADtpmng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 402e6d98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:47 +0100
Subject: [PATCH 20/20] t5703: refactor test to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-20-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index ac7266126a0..1ab3191d72d 100755
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

