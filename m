Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9B21147D
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071844; cv=none; b=CaAFan5boyX5MJ0g2IUGc1gXvoh1FV5+WFJT3rYP7DEPmk2z+CpbMrw8JMyWRrgz17rw91+7GPtPvxxIVEr7WoKS/dnzqDsOmflNi4ThKaFGBVgL7/83gzgieGkjYmlvU/jXYnvWFaDjQ4nYClfn/jRoAlApbF8Hqs5zfw7+IOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071844; c=relaxed/simple;
	bh=OzPEXYJJSkCRVgvE9r/ZR014p4QQC/SiVAp5FNaVjm0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s5BFkJRutIrbyRs0gBBcnOafvH40t9RIC7P0KmD+b6lrfvuEiKUCdEHvfAKIe6mP+GcCSbfRzxJDU9ikOSDFRpX84ekka0RGgiTlEIh0sxS4qaf26Tij1gCLEgcrld3ZLnEC0YTDrtW800WVycprCZRq/j2c4rIAFT8zA7lL+fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWac+aqf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BA4tI4Bx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWac+aqf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BA4tI4Bx"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 120DC11400FE;
	Thu, 27 Mar 2025 06:37:22 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071842;
	 x=1743158242; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=
	JWac+aqfreBiHqWhm1+Nt45PB8JBw7f9u02wYKR+4ZbOIzMZN7KUwmtqdWVyCY0B
	MrYQlmHS+EphXOuetuLr6QDYcMzNm/mANDcLcDGlNzEqSk1vqGzzslULOupBlXYi
	CVpK5phmG/Xe/l8c7llBXX99JmGk/2dXj/8CILv8xof62eF0aM4dbIB+p7vUNLbB
	Kj10ZERoCb+JoMFk/2QMz6LK7QQ8om/6HjccHxP789dvlKF38jyKxZpgv1ko2ORn
	tUFAEVlgoT1TKOdeXwFb0udfuvjX/mgGfkTpRndAJoCeDDdkznj3KW4Bc+Yiigjd
	Qe8VF+N3GiqXcu8boWB4bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071842; x=
	1743158242; bh=SK72nLGE48Io01PVlKAlFOEhxfBN6derLq8NspJR/K0=; b=B
	A4tI4BxIrJdyqh5B8mj2zdbYqRUED7lokFJxUKwpgid3xP+aeAtuKnFr+jIQKEAo
	iIN5xGSzpWU73yNF7AGJ2cQmEc4+hOC0Zk3+Kx3XH3oBEkoUjzsx2QlvNXWpbtG7
	bkh2OTNgwPp5801vy4PyRwzJYQ4ObsY5wMhg9KcAI5mMwr+kd5bGggjB6vDng29O
	3P9Rdu/u+KqVTAAVfhdbVP9BmB4hhI6WkS9iKku5/vTZELCwkoGmZzPjMof+G7DM
	bLkjRuaSKuc3iz0229+HoSq3eVX7uXijc4BG7lVcJdvQoMKafPmm3RKH/Xkgn7CI
	52Ys7JeBg8LiDN7rC2J3g==
X-ME-Sender: <xms:YSrlZw9Xp5oHLUdDrSOURJSZV5A--gAcYxVzEnHUkGmnbrhf9CFFZw>
    <xme:YSrlZ4unQb3Sng40MkzwUxftGoxihWerZLEFLErt0NT0xCsgT73qf0YtHR5jmfBnw
    dN4Cb3FwK-ebzUQog>
X-ME-Received: <xmr:YSrlZ2CQ_4aivyNnQjL3wpNq0J2PARp9kWhPf0JCzyJs6q15_t28GbqAH6-duH8dE0n4b8HVHFldLGzDEU1N0PAhk49NjGjsJ3PGvoZYG2qggg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YSrlZwcl6rM6C4llDXHtX4zZpkuzjW884fbostxDPNoHNyyht0UyNw>
    <xmx:YSrlZ1PSrWg9MH-LdWH7YmfWQ49ssfDM_O7AQWfXJGE9cY3ohaxKdw>
    <xmx:YSrlZ6m7YxyBNWgh---7W6Dyg-LhCwHgMZqnryput4l-D0k-eU7-3A>
    <xmx:YSrlZ3tOerFiCUkUca3o4l1uqahYX9lt4psfCIFuGbjQ61D50rorgg>
    <xmx:YirlZ403BklX2LHrH4tbB8zwGEj33l_CbjT1qkUD6daXwzn3wdtcNLKz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:20 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 05e5942f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:12 +0100
Subject: [PATCH v3 14/20] t/lib-gpg: refactor `sanitize_pgp()` to not
 depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-14-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
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

