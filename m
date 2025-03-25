Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4AD25F978
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908479; cv=none; b=mH0UcwvogwPivzdRA30chZN7rhgrYb5dN1FRDRSSlgySNgk4zG/5PAA595NlDA08MBqXceb9NoyVF08wiFm/WRuhsZl9UZXtVE3mAOQQKqjEdgzShqjAwQnmW21xErVmTxXSLTZduo/FwO8R+M9N++0NTy/AfugG2UzmCpFAXAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908479; c=relaxed/simple;
	bh=OzPEXYJJSkCRVgvE9r/ZR014p4QQC/SiVAp5FNaVjm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IE6tKBvUkjs9cKVW9azyvOtl+fFswrbJC9B86v89Ak87merBSYVCKnqfUMNT1P72McC9MZwJxr9l4Uss0jN+8cx+Qs+x7qQh5NLO9GLErCCg5xlGMbqUYu6LUCyEA0Qy+3NXVRQIqMSGbNexIlSgMxZeIbuCOWCr2NQwvljAVGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WFd8CYGx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pkpSHwoE; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WFd8CYGx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pkpSHwoE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D68FB1140275;
	Tue, 25 Mar 2025 09:14:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908476;
	 x=1742994876; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=
	WFd8CYGxhH6++5uAQuEG9SNaAUfwg1bAUNhOubzcTdv1e096RcJzy/zhKmC2I1am
	sSPW5pDrdHR0WnnziM041V2TSBrqQOFBP/IVRoZfyh2pQJq8GcTv7ZIX1YDj0fxo
	ZVcBf9iv+RcZnR+ds5SUVzK/TABwv/8owTojFWEjCPlkPRAKORGMQFt7flXHZMyw
	xcC+TpDYAr9aKu09TbZrLgIQ4tB4bcUOudK3XCQ9teKlnyxVT7k0v8KE7x6TA89K
	yIuZDHAqkICS9t3mn6NH+W21Dz/IbOZPO6ZRqR1GtiyBFZosfFlezwF6dLMpNCHm
	2dla+FkONyhsquU1vrW+bQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908476; x=
	1742994876; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=p
	kpSHwoE9bTPWTDR7FFuX+jzqxsIivTo4v7U5lF/nj/DaqOIgVZz7drhLsgi8/2j9
	4MX1QvXs5GhXGU/0gBDUE99gK0DpQvU4DUvrkM5KsWphIuTyDsdgvpo6a1QWZofg
	YM2oVMvrW1wd+ufkTcCAqbn3QSgKcP/xQUANwFnO34oPgHxWeJy/kXKxComZZpp4
	K3AlW/QfrC0JQrtl1uVG7Y95uY/M3bApDtNOg62wPaLWNdtXx7gl0ENU/dbEmzTo
	0WSLRR4RZdC3OwS2zmVbgJZILUT6TJP1137pKTgvcTjlM8tLqo3vLyZj2OuJR3r/
	QXkCZzufFFVpmRGIyJAvw==
X-ME-Sender: <xms:PKziZ-5i8cY7bfVA3Jnp3HhMCzvaPDRzKKLLRDo1oKKPH2LxAsAPBA>
    <xme:PKziZ34PB3PUxxRb-EWMDqCf7L9icGVY2Jy3ZFzgiMn9NjznnL3u-jVZ2Se-UMxSM
    D_KnWhntSuQ5XV4tA>
X-ME-Received: <xmr:PKziZ9ckddVjdg7XB599sOCh9qt-Znd2ANgcNaJK3-7zozIWx_td9MNodkf-I8kk9CqGr-SZfTObQqwD2l1e799Id_1NOcbFOnccUua-XOclQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PKziZ7JFEc_Sl--8wlZeeFuXnpttg2odmkt3X70fPz0sQhVnNCBSvA>
    <xmx:PKziZyJdVIdIEJqU6plx9kqiyIZ8rg-KTPartMMXRYIbguUNJWamcQ>
    <xmx:PKziZ8zP1kKLXQZeqAMgufGldxm0txWcTBrIwo_ec-injneDsqqOhA>
    <xmx:PKziZ2JT1V5_QHkMMNqxknh4qdLIMTQPmL6Avm3_xlPUqiqqzcyH6A>
    <xmx:PKziZ0hodtM3X1KQ9OTlQZzVTv4c1ReRG3Odi19-F095oSvk3t1s0-0f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2600f114 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:32 +0100
Subject: [PATCH v2 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not
 depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-14-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
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

