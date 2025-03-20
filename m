Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA02224AED
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463347; cv=none; b=CG+VcjCXEjXRjt20GaKwunRSXQlhuxIEXwULgU6UeYY5FYK3nziCegHyoRSOdg5oJ5p8w7yDh5rmOB34GLPT69UhtTMk2VpHDYl5Q1P5zEQVOd9zE7kaUd3Do7XcozCmb8dvKVaOa5MVjWxxC2PPmdhr/xqwooBrB6W3KziZBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463347; c=relaxed/simple;
	bh=Nah5GjtzhBqGaOoSgcgls7dXKelICaPBRlqDFEUT+Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4nY1Q9N23GF5TUP/u8Qyib4jSmV2AF+RFlbWO7dQSQFdrE2yusus1+smTBKE8q7R7ldusALwnYl9nplFmQfoDimQm0qC7Vr7I+yyV4G/JPaQ41IhTbuj4hQ4prQqf3x6zNNlR9bbfqZjgz0q36ZVdSQVp50dlrpaa3wYLVcNAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o/1V+IzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6gZVV/Fa; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o/1V+IzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6gZVV/Fa"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 0155B1140187;
	Thu, 20 Mar 2025 05:35:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463344;
	 x=1742549744; bh=ojjYbpoWhyxrpo9ge2subbPzxws80MZNcbLh57DVWe4=; b=
	o/1V+IzYs5x2YZ+b5V/v/v2ijXCmbd0higY29lvhEZitB6lHSpB3saeoX/54W8o4
	MLVfp15fXVbhwkHjzeM4YZqDvj2WCzvT+Fv0TRoGW3tRk08I8A5HvyzsY8bo+f8h
	orA636Hzgu2EeaAYxXEL2C9CLgPmhXhBPqUcqLQLCxiqA7gBWVaiKgGWJkrWhNus
	8VWjpQHfYwfvGhKsR1CHkV1V3Z9e9I3tnuhODZPE4r/f4v84kxAaGOJnrGNskZ6o
	LcXln1qmB46qK1c4GGsJNPqaM5bKuWxsFkwQhSRRrD435Q9qGuxoJfKixpP5+6kH
	ld8o21sjZAl42nbZInm1YA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463344; x=
	1742549744; bh=ojjYbpoWhyxrpo9ge2subbPzxws80MZNcbLh57DVWe4=; b=6
	gZVV/Fa2VXIBC4TVjKGkk/gHLZxijUlhYJ+wmp+tQH+y2KV658XmNRff8AJ36Mwe
	aflLsIZN+Jd93ZYRRXi6vZO/gqqqFqFpliU/ftxo1VdNHTq4/FkARiKxp+asd6Zo
	v468o8DtvvPlWoZhf9qMEn06OLm7rnI6eUxn96eIycJTCdXC0JAaFW7KPVNUcYbH
	N8xQxR4em3Ud6OovKYqY+HZuyXY9wvAkngTH095a5vDEz5BwHCrQovqTV6xqwzBP
	yYr9u85OEIT7NVDtgvsrSILK3InGqZXkjXV8LW8jTsZtIXHi6w+hmKkhE/dk/Uy8
	dhMNImxwnQ7Jq8Iw+r4wg==
X-ME-Sender: <xms:cOHbZ9EQw-GbLtgAbVKSk0h7kC4TaVZS_rdxz1v-LCqUm9_1bfnNgQ>
    <xme:cOHbZyULzGcbwMb9-jMlKiJIqmQEgFIhKkSG8H1lBQ7sTCjAAqPxI-67zbAuvF0XO
    nL88e04eHDqqN_2OA>
X-ME-Received: <xmr:cOHbZ_JUYNcIPyJ2ueMLlRA5mKE75BXm7WeFh71PuXzsJX_EDmvYVbT5dI5w25n-OXZRV7qxVIj2efsG6yr7fSFXVR2U661IhCoMDqjusdQnQhg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:cOHbZzEDUbAZ-fO3wSVnkrZvVBjBKdUlFOVWYq9F9P5083rc0aRWPQ>
    <xmx:cOHbZzUmzIZMMSCUR6UhcC07-8nyaLof6hSam2Lwv2b1tnuXlYWCSA>
    <xmx:cOHbZ-N-An9xKwTZO03p-JfruYorsOthYXd28yYkHvqK8sxqJM83CA>
    <xmx:cOHbZy2K8Zd5i0bxGWZgq-OvK25LlY_29MRuSnm2zrlZuh3Mfz5maQ>
    <xmx:cOHbZwjlf1mcAvshous9Yvo8_ADjge12lTkhLK4-WgynRbZ5gKLsuWbe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 527f93db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:40 +0100
Subject: [PATCH 13/20] t: refactor tests depending on Perl for textconv
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We have a couple of tests that depend on Perl for textconv scripts.
Refactor these tests to instead be implemented via shell utilities so
that we can drop a couple of PERL_TEST_HELPERS prerequisites.

Note that not all of the conversions are a one-to-one equivalent to the
previous textconv scripts. But that's not really needed in the first
place: we only care that the textconv script does something, and that
can be verified trivially without having a full-blown invocation of
hexdump. So at times, the implementation of the textconv scripts is
reduced to their bare minimum.

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

