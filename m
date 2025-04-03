Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F6A19C558
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656774; cv=none; b=oCB9gJOZ8mXFLXMscueLkQrOfQAyqP2Aq5yLVH3IVX44RGgkO7cknZCOEDRpIIkwaZTqxVRhbgdzm3xE9AiwRrceaOb2l7OZAnm5he3i+tKVycgj3SwTZ8RrPWbQdSfwqh8wb+ZMpt/Nm4nfcmhMI2Eh/1pGjfDOA6Kf05vZQM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656774; c=relaxed/simple;
	bh=+ZonEw5t+vccV4lSmVUxeXVrr9n83wU4t2HjiVrnbPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vz4AvO45STDw0JJMPIsFaxMzLY86lVEp0gFcih5kZgKLALJAEyla5GBEksD+fQDYyMeQuek/8pzvdpovQH27Lxb+urlakkyOlfkZwJRuSFy6k9Lj1zqPrKha85h4M5eUREortizH45Vd3YcArv0ogDD+4ZlfyGY8euWGtH9xlHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ab29CLic; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZJYT5M7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ab29CLic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZJYT5M7"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 2E0DB1140197;
	Thu,  3 Apr 2025 01:06:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 03 Apr 2025 01:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656772;
	 x=1743743172; bh=cHqbgUzl800aHvHA8EkALWgymSz4YWr9p5Dt9E773QY=; b=
	ab29CLicrfET8wWOwoWSDvHAg0faSmlC+FOHIpjTBGzqN15xRQRaBpiysdrKByjl
	XGrPYtuD9w2aE4T+IlunPp42zL6yh/38y4uXSLPcwMGc8ZF5VdAw7G/Vldd+71xx
	xzRcyJ2S/zHSFpkwfKzHHdo3V+Mt7/zDpW9P9Uqgv11DtBUmOqxM15O0W0OJHLsy
	Oyb4/pJnop4JrKqu0lPRsS/+ZB4rQKkBxpUBqP83tx79tmyJ8IFYGeoHwNyyvLIe
	HPhgTWG+zLmFMZMETm94NB/OaeEDBBX1klg9xieD+61i26TEnL6fZKZ9RQ+8n7MS
	xdA7l50B+2FPfeuLHf7j6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656772; x=
	1743743172; bh=cHqbgUzl800aHvHA8EkALWgymSz4YWr9p5Dt9E773QY=; b=T
	ZJYT5M7+nOWE3Xbfy7yt1DuBo2qzW5/pj+BcPhYQV9mShVZUZbotclv+gSGWpSis
	R9B7Rgc434cfiSCLKw/haZgMFt+lG+QVzjWXU2uu9wQ7Ko3HD/pZJFUrHLLqMMiT
	/ENTGunekZ+YzQVP8OFMaECH//plfkhETKVbFxCItOC5Z+dtNS0nFektudw+74d1
	H3/u+Sw1q/yx9JdNH1MzH2/4GmYuE4gWDwRCMGYwa9ejpK84bzvLpayYK01OTKlM
	g0L43Y6EK9OJAI+pG8Z7qC44U96l3m8QE0FB6RnKymyznoqSalOgqKcrqtP6shDA
	A1zWeAhDVarJAqMCRJohA==
X-ME-Sender: <xms:QxfuZx-NRiTHOZJlWymMMqKhm78Vvo_pIY1e077txFszXxFKBkuF1A>
    <xme:QxfuZ1sMXhc51jn8Xr46TdHHAeLxXi5nVBOLV84gx5FXCCcm9XQwFVYJItqLgv3Ti
    gzVeDW7qMcouc8tQQ>
X-ME-Received: <xmr:QxfuZ_BcabfKEcMlV7CjdhIg9dPykOvXWpIHkFTiGLZiNXr2SWofO4kGVeQW-vtaqDim0WTuwJXlgyon-erdoAaOQrex0MxRYRptOL4x2orAjIE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QxfuZ1eef9PCP_CEUidaI8X2_JUn5tYYq8bvTWSgE_3_yzKr8o4zFw>
    <xmx:QxfuZ2NZEFwpvUbA6p3SuFcARHRkWcvYQHNor8g-_wh177uprckbHA>
    <xmx:QxfuZ3mdb6UFzuToMOUTQuM5bST89-Lg6kKsdPFTeOZl9F7LXbzPaQ>
    <xmx:QxfuZwtUKkQgs47XC6nbVPwQUl5U53DY6TVFQg5rvkm_XavPU9LlEA>
    <xmx:RBfuZ5B74ubiQ1MRGGQeka01lP74lpKjJygKwAoA5hvyuBk5uNTxzmRF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6bf8ffe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:05 +0200
Subject: [PATCH v4 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not
 depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-14-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `sanitize_pgp()` test helper uses Perl to strip PGP signatures from
stdin. Refactor it to instead use sed(1) so that we drop the
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
2.49.0.604.gff1f9ca942.dirty

