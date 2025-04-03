Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CA61A23A2
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656774; cv=none; b=spOxZBQJJtg9D+mxRG2ADM2R4k8tw8kq9M2gfjtkogqzceAXWPYlBC9VBRB102/SfYYu5d70Jgi+V4pXKNy2dWtrMfsVPtAgg1hbWT80NUVCpyYqBCWT/vYQ0roCjKIYFXbkJjsM4LxJmgmL5hv54xMihUIQ0Q4tTiPGssjh9uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656774; c=relaxed/simple;
	bh=X8oXUVNN7u5b2smJY0uvxWeWWAjPeNkWl/x9vdxTu6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bmum48Fl/fEQmk92TaKSo4gtXc9kGi7JK/fZrtKzLOkBp85gkgm9BlClA8hDYahsFL28aDlBybnq/40rs8vl2yWWQGsa997YnIc/Jxq34+owL8zRA5vpJz1PnBLAVJelhqwfqmELpj24mTSITJFSVz3jtEBIKMzBmots45WLB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FRSBzLDJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jE2YPyVk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FRSBzLDJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jE2YPyVk"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D14952540214;
	Thu,  3 Apr 2025 01:06:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 03 Apr 2025 01:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656771;
	 x=1743743171; bh=XXOzDHbk77bCd1Cj0reHlbowXlZP2E92co4uPP3OAbw=; b=
	FRSBzLDJqDdc3MvZSxvHIjzpdCHZ9zJwnb2KMmg7YTK7DaB5V4IVIhldRqj9F/KQ
	2SXhuBgN16DvA7zbazUnim21b+YrY0NXD3of8pZuGIdc37LUtnbk/LWMwq/3xaX0
	/yLY0HcWvtdBN1ySv0Xja0sFC+RPDFRcsqixW8tnTK2GqAWhooqsf7iVK8Cpius4
	hBNbWV1UUnuXX2bJeLh8DWKUacETJOWEmw2fiZMY4E7RNl0De6EkI9T1fJRdPBzy
	rUW0WKmJbeZcaY1/Dg9TAt6BGiQpr+XtNOdjer/NO/yDed4ZC4M3Tvr0DV1XrPif
	qlY5G14WcXbj1jA+JZ3YfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656771; x=
	1743743171; bh=XXOzDHbk77bCd1Cj0reHlbowXlZP2E92co4uPP3OAbw=; b=j
	E2YPyVkVhuPsYCPuSwoEZFarAonJA4ZlrNQy1EfIhxfWJzV7ryFBFLAWQu7F+U4Z
	x+xN0rAq/tzDK4zhAclMheSU9jbf8Ak2GHFuQb61Uf+XqLIJ4DIpQGJYltwr2Aag
	nnIJT8PpBou0sgTMDYICnO+SjWUiZ83hHjbVq8itXELRlXrWTggt48dven/XoeXj
	whMEeexAM5YG9mb6E0NBJIlUa1EUCDx6+OS9ZgBMTZAZoOCVacKbAUvYZV9KMP8s
	8W+FX1tRFFPrfjv0g13F8cCgDp6cozLLkDI0pwhO04r5PmyoJJ56zd0Taax/6WFh
	V/HelzJMfMa/AuBcsKMjw==
X-ME-Sender: <xms:QxfuZxAbBlGKJTUkarmpg7cSaxKgTyOkzHYmfFi1JQVxR90cBhWNxw>
    <xme:QxfuZ_gBoBbcPeEhGXu4pFMortB13trY2XS6bE2Nb6bS-RHDeVIqHuTQ0IfAUuy6z
    tR2XIDzDmQlVqX4Jg>
X-ME-Received: <xmr:QxfuZ8n-5Tv-vOqbZVVRPVoX6SDJGYA-lzU3-bACXPNmo8BVlEd_eLQmmW0t1HawKUeAYGKAMKXjb6ZrTLK4qh02em3gj6QpGtZKt5ZjkJBhKIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:QxfuZ7x9BZifqzFACniJjiqNNwP8MokUZl13nowKUkQTN1I0KG4S-w>
    <xmx:QxfuZ2Q14dYkSGrkntWFn9bV402D6uxKFdBscUps3K5IoEupF15-6w>
    <xmx:QxfuZ-Yv8kQsqu4FUPmui9Cb4zD9KoXA2KpkyADlVTNSgS86t51amg>
    <xmx:QxfuZ3SazACQyaLh7JIDuSJR-Hnv_LUk00sGcu91ex-_AKJVtRvs0g>
    <xmx:QxfuZ3XeXdOudRELMVS4hmtl5QRRdzrRrTa6ajDglvTQyvCNWJ95eVNe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9231a3f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:04 +0200
Subject: [PATCH v4 13/20] t: refactor tests depending on Perl for textconv
 scripts
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250403-b4-pks-t-perlless-v4-13-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We have a couple of tests that depend on Perl for textconv scripts.
Refactor these tests to instead be implemented via shell utilities so
that we can drop a couple of PERL_TEST_HELPERS prerequisites.

Note that the conversion in t4030 is not a one-to-one equivalent to the
previous textconv script. Before this change we used to essentially do a
hexdump via Perl. The obvious conversion here would be to use `test-tool
hexdump` like we do for the other tests. But this would lead to a ripple
effect where we would have to adapt a bunch of other tests with a bunch
of seemingly unrelated changes, which would be somewhat awkward.

Instead, we're going with the minimum viable change: the test files we
write contain "\001" and "\000", and the test's expectation is that
those get translated into proper ASCII characters. So instead of doing a
full hexdump, we simply use tr(1) to translate these specific bytes.

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
2.49.0.604.gff1f9ca942.dirty

