Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1347211A19
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071843; cv=none; b=APhN5BYcylhHCCqDeIyEh1qgBRc2VixvFISL0Mc5Y07KlfT1jOdoJGoY/OM0uXMiIsQH7kmOdx8NxQy11Colf7jpT050UnjC8MYVxh2KzDujAP3zNkcMUlRgnjs26BhjYYuiAt37k0Wov+SYM6f5J5jbHxE4D4fiRFR+qxrCytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071843; c=relaxed/simple;
	bh=pWr3UcaWANc8naJen7QnchaDNFox7PBbI03NK6qmi2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JDYs90LaugmDO4kJAJUf6DyuzBYkLxYHbFmBCgZOVsPNA/ptF4RNp/gKfVILTrnlX/yT0qNwA4DvRNuUfttJcvyza+vhmHouHMp3JWeCxLzcVyaHVeDzuOrgG3dDoXPy/NJ+gNk/KcXihZZiCFWF3LvspcAOC1gEN1u15xExvIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SxuRQ00T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RVX+G0T+; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SxuRQ00T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RVX+G0T+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id CB9FF1383845;
	Thu, 27 Mar 2025 06:37:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 06:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071840;
	 x=1743158240; bh=wAM+E/mH1X/v6GuqkS1/CQ4VcAw05+8QixkS7TW35Cw=; b=
	SxuRQ00TVmls8Y/uV9lIcvPU2A/CKAGLfY31y321FWiFwLwAPMYznFDDyMcF0zMZ
	8BZmM3vIBWQ1ZZ7kyhA47Zrf8afQU4ffz1gMJW1oPnW8zU47AsfnKOEngspFf8e3
	K6AY2Ka2kR+RAqj/nwuxrkqqPwXLHSfak7pZBW/zRyyZRP+TG6vnFS0ql0cHS2gc
	2OnodrDRRHG6kw3pkt5NARlyJmDz2ic+5weFjhVvLWHMJ3SzC8J/gdnt4psKZz2c
	Pfuhpn2pjQMKK9QN3EaXh8zO/UToG7Mtj5+gJriE4S0hk3chBvew04TGYvsUtB0m
	J3LX6we04AacwkAcqCShmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071840; x=
	1743158240; bh=wAM+E/mH1X/v6GuqkS1/CQ4VcAw05+8QixkS7TW35Cw=; b=R
	VX+G0T+tV8DjbK5vUpgHeqQtYIVNkEzcTjt6fPzHw4FMteHUhFc8QMaf8lgh7aHu
	3pwsbZcn/2BQGMPReUUJ+OjE4iJOD+I0nConFniGRC2TAGBffiV6N5v6c5UhsPy7
	M14UAEaU0jVL0urN6cBKnHjr0LhZ2MzCE9gY8lb3QobxhEUyg6+BQRpExHBfKdOx
	FJpuvwFlw8l2XPu3//B6BGurFgW+/uu6xyDQ0PkM/Zq4zkqF+70DFNFkzP505y48
	HA9I6XEUk1/DmVO+8AIChHOqcilOXSrHzybosoeX6/t16/1oqp9+l9ssF3M+5oEj
	DLgRItFdh6g1uqYxiLNzQ==
X-ME-Sender: <xms:YCrlZ8-8eOYtbaFYSuXbI035HZfqBQfbgksD7_CvT9O33Dt8lVp0ZA>
    <xme:YCrlZ0t61HMmZC1TNnIEWzkmH-IjS0e7DlgB70Mu9K9Z_XTRMzhv__11PHbYilJ1e
    6-x5mjAiUaGs100Jw>
X-ME-Received: <xmr:YCrlZyDM2_W-iC8hW4rwjnPDTJ7SZuA4QRt6Jx8RVI7B3F-k5wZpBHj1VMabsZ1U4yMIOU_0x_nb50RoZbX1eTRCR-VDx9CsBRX8JyEL1ItYdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhes
    ghhmgidruggvpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:YCrlZ8cVXlosE9Ck7BDacQu66suCpUAzLVyhC0x292dXZE-f6LTRng>
    <xmx:YCrlZxPUV-MytkJPYA0PyR37QeB2kvUu-8WAa-x7pttVqfKnSziS6A>
    <xmx:YCrlZ2n6WDHoQinnatyFM3BrsFSxUQWnHMyznaxi9ZZZj5yJdE-MfA>
    <xmx:YCrlZzuGRk2IhWYXtlDkgEaDtO_RcD-4DYmCrcM9WDZ3uBk6ml2doA>
    <xmx:YCrlZ01M0wLaojga4hYGJbwcEK7f1IKQew8ORi0nIb4OlutlTG4C5dX6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a1c43c0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:11 +0100
Subject: [PATCH v3 13/20] t: refactor tests depending on Perl for textconv
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-b4-pks-t-perlless-v3-13-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We have a couple of tests that depend on Perl for textconv scripts.
Refactor these tests to instead be implemented via shell utilities so
that we can drop a couple of PERL_TEST_HELPERS prerequisites.

Note that not all of the conversions are a one-to-one equivalent to the
previous textconv scripts. But that's not really needed in the first
place: we only care that the textconv script does something, and that
can be verified trivially without having a full-blown invocation of
hexdump. So at times, the implementation of the textconv scripts is
reduced to their bare minimum and the expectations of those tests are
adapted accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t4030-diff-textconv.sh       | 15 +++------------
 t/t4031-diff-rewrite-binary.sh | 19 +++++++------------
 t/t7815-grep-binary.sh         | 15 +++------------
 3 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index c7d8eb12453..f904fc19f69 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -4,12 +4,6 @@ test_description='diff.*.textconv tests'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping diff textconv tests; Perl not available'
-	test_done
-fi
-
 find_diff() {
 	sed '1,/^index /d' | sed '/^-- $/,$d'
 }
@@ -26,13 +20,10 @@ cat >expect.text <<'EOF'
 +1
 EOF
 
-cat >hexdump <<'EOF'
-#!/bin/sh
-"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
-EOF
-chmod +x hexdump
-
 test_expect_success 'setup binary file with history' '
+	write_script hexdump <<-\EOF &&
+	tr "\000\001" "01" <"$1"
+	EOF
 	test_commit --printf one file "\\0\\n" &&
 	test_commit --printf --append two file "\\01\\n"
 '
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index cbe50b15772..15e012ccc7c 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -57,24 +57,19 @@ test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 	grep " rewrite file" diff
 '
 
-{
-	echo "#!$SHELL_PATH"
-	cat <<'EOF'
-"$PERL_PATH" -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
-EOF
-} >dump
-chmod +x dump
-
 test_expect_success 'setup textconv' '
+	write_script dump <<-\EOF &&
+	test-tool hexdump <"$1"
+	EOF
 	echo file diff=foo >.gitattributes &&
 	git config diff.foo.textconv "\"$(pwd)\""/dump
 '
 
-test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
+test_expect_success 'rewrite diff respects textconv' '
 	git diff -B >diff &&
-	grep "dissimilarity index" diff &&
-	grep "^-61" diff &&
-	grep "^-0" diff
+	test_grep "dissimilarity index" diff &&
+	test_grep "^-3d 0a 00" diff &&
+	test_grep "^+3d 0a 01" diff
 '
 
 test_done
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index b2730d200c8..3bd91da9707 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -4,12 +4,6 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping grep binary tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' "
 	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
@@ -120,13 +114,10 @@ test_expect_success 'grep respects not-binary diff attribute' '
 	test_cmp expect actual
 '
 
-cat >nul_to_q_textconv <<'EOF'
-#!/bin/sh
-"$PERL_PATH" -pe 'y/\000/Q/' < "$1"
-EOF
-chmod +x nul_to_q_textconv
-
 test_expect_success 'setup textconv filters' '
+	write_script nul_to_q_textconv <<-\EOF &&
+	tr "\000" "Q" <"$1"
+	EOF
 	echo a diff=foo >.gitattributes &&
 	git config diff.foo.textconv "\"$(pwd)\""/nul_to_q_textconv
 '

-- 
2.49.0.472.ge94155a9ec.dirty

