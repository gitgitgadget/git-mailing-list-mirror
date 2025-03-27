Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33EA212D7A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071849; cv=none; b=gKBe0ccasGW9/maSNJUG6XtezLcnacSu6QRugzlmV5OpDqduOo31PfexhXkRU/kG6tzxCDl7Gca3dWqpibU2F1N+yvDzo+n6Xu5puE1IyzHj/KLbbkEC/tYh9m8LQ0IZYQ5MLOEEf8815urFph9Z0Ef/YXrMmeKkH1acB0Va9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071849; c=relaxed/simple;
	bh=hMHoOV37e0krItUaU8O9JexiNN8vAaEVAdxYIOii9PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kmVyKFoe7WScjSy8+HNcsP5KvErB6VjPXGonlYRG3lkCANMUOryZSd3xbFLeAv/fxorWQNgdzBK8GbigUus5xbmignEGp5lyh1/CUYhPI3zWw7MDkCxBxDRgr+xdt48JAKv9PKV65K/qBXiLmsMxeLHJw+ZiaxZKo6UnLu64tWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Srm9689K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hgF8i7wv; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Srm9689K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgF8i7wv"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A268114018A;
	Thu, 27 Mar 2025 06:37:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 27 Mar 2025 06:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071847;
	 x=1743158247; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=
	Srm9689KNKZzf1TtdIT7/3j80vFvvs59mmZJCefUuP271h+VtUNOpRj1z2Pqad50
	niAI0Zjx1hav9Ybw2UHdUpJC9Fpv0hgs2BlCUmgO4uiTLFKFRxhm1I2dUVVgOwjf
	jIsYuh60nMq2O6AxpY0p+46lisS5rUE3VGKA14oS7bfj3yzuvfNghdxTHJ8IWNrA
	MoZWB4fTxWAo6r8/eRWA/1nGh5HcG2iOuSwtvEoYWqOgD6HoMsvfc+5wJaW/CPNv
	KTsFt1fBWMACi5xLKdm51NWky3Md2JpTrUJiGOIOATu8nWvlesCkXjQ58fkvOCJt
	8Vv+cFr2hRrU09KFwg9h+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071847; x=
	1743158247; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=h
	gF8i7wvSOjyxW0LmfLuWij1t8ppvtyqjyDRtEIzuh7OFTLIPqSGWIKVuWDqzPUgi
	PhlcQCEirU/vhy9Ax0WCzBE9UsEwtAY7xn3uiWHauzRmHB7cgsPvXwUeFHJ5n4fJ
	IcLRLkBP4g0lgMkgiB/vUrd5UD8pCDcq2BCFI5l54QcmCsqldIR9gmHpn6Mv7H/T
	lFYuDCTsIra5h+yqQRJ9rsdhWNg6q+4PfhniHMlBqItvupQnyf16M4Q6QuHFvdCX
	5AzStrd6rka4S4fuzqwXh/4e8+L898uh3xRCI2dRvw+ANwuqy5NGTkUGzwhbTp1f
	281lXqM8wEg/N2cQBOMkg==
X-ME-Sender: <xms:ZyrlZxipu4kXrUQ6gmvgOG5nz_LhLjI2DueNR4VLPDv2ecKXtXZhwQ>
    <xme:ZyrlZ2Cr6DhroKEUr4C73fqkMq1tQfCgoj_GL5vAdT552CxlhYsqaQ9Ahhed7oHY1
    SeHNc60pGyr19ksFQ>
X-ME-Received: <xmr:ZyrlZxGQ6XgcaGNybf50TX156S2VEXpuupSahMpvpk-ZoDQc0BpI1UMrHNQsW1S_HnSzMsHYNYBI71569phz76pDkOOOZhUL396uyaXjOMVlZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:ZyrlZ2QJcSXO7I-6rPCTbarjTlSEycFRTgFcQHPQxIWyzkU_-CnoQw>
    <xmx:ZyrlZ-ybBByfaQraimpVJxGYZdm2_30Ch6xR-rVqqvd5BZVwlwT82w>
    <xmx:ZyrlZ84Hg_h4ZpPUmsPYN27jAWB9ActBw9poIEuyYgVHYKiHFBQyTQ>
    <xmx:ZyrlZzz4UtGVkoPWEUuFLbwkpY0g0hAxbYNjXv7EebYTaHda6uuvCg>
    <xmx:ZyrlZ1p9u-mBO9TmBuUJz2GnVZQo8GtfMBNut-FbUBI3nKa1tiZCBCsm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4c7fb904 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:16 +0100
Subject: [PATCH v3 18/20] t0210: refactor trace2 scrubbing to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-18-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The output generated by our trace2 mechanism contains several fields
that are dependent on the environment they're being run in, which makes
it somewhat harder to test it. As a countermeasure we scrub the output
and strip out any fields that contain such information.

The logic to do so is implemented in Perl, but it can be trivially
ported to instead use sed(1). Refactor the code accordingly so that we
can drop the PERL_TEST_HELPERS prerequisite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0210-trace2-normal.sh  | 61 +++++++++++++++++++++++++++++++++--------------
 t/t0210/scrub_normal.perl | 54 -----------------------------------------
 2 files changed, 43 insertions(+), 72 deletions(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index ba4c0442b85..96c68f65df2 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -4,12 +4,6 @@ test_description='test trace2 facility (normal target)'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping trace2 tests; Perl not available'
-	test_done
-fi
-
 # Turn off any inherited trace2 settings for this test.
 sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
 sane_unset GIT_TRACE2_BRIEF
@@ -59,10 +53,41 @@ GIT_TRACE2_BRIEF=1 && export GIT_TRACE2_BRIEF
 #
 # Implicit return from cmd_<verb> function propagates <code>.
 
+scrub_normal () {
+	# Scrub the variable fields from the normal trace2 output to make
+	# testing easier:
+	#
+	#   1. Various messages include an elapsed time in the middle of the
+	#      message. Replace the time with a placeholder to simplify our
+	#      HEREDOC in the test script.
+	#
+	#   2. We expect:
+	#
+	#        start <argv0> [<argv1> [<argv2> [...]]]
+	#
+	#      where argv0 might be a relative or absolute path, with or
+	#      without quotes, and platform dependent. Replace argv0 with a
+	#      token for HEREDOC matching in the test script.
+	#
+	#   3. Likewise, the 'cmd_path' message breaks out argv[0].
+	#
+	#      This line is only emitted when RUNTIME_PREFIX is defined,
+	#      so just omit it for testing purposes.
+	#
+	#   4. 'cmd_ancestry' is not implemented everywhere, so for portability's
+	#      sake, skip it when parsing normal.
+	sed \
+		-e 's/elapsed:[0-9]*\.[0-9][0-9]*\([eE][-+]\{0,1\}[0-9][0-9]*\)\{0,1\}/elapsed:_TIME_/g' \
+		-e "s/^start '[^']*' \(.*\)/start _EXE_ \1/" \
+		-e 's/^start [^ ][^ ]* \(.*\)/start _EXE_ \1/' \
+		-e '/^cmd_path/d' \
+		-e '/^cmd_ancestry/d'
+}
+
 test_expect_success 'normal stream, return code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -76,7 +101,7 @@ test_expect_success 'normal stream, return code 0' '
 test_expect_success 'normal stream, return code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 001return 1 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 1
@@ -91,7 +116,7 @@ test_expect_success 'automatic filename' '
 	test_when_finished "rm -r traces actual expect" &&
 	mkdir traces &&
 	GIT_TRACE2="$(pwd)/traces" test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <"$(ls traces/*)" >actual &&
+	scrub_normal <"$(ls traces/*)" >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -109,7 +134,7 @@ test_expect_success 'automatic filename' '
 test_expect_success 'normal stream, exit code 0' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 002exit 0
@@ -123,7 +148,7 @@ test_expect_success 'normal stream, exit code 0' '
 test_expect_success 'normal stream, exit code 1' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 002exit 1 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 002exit 1
@@ -141,7 +166,7 @@ test_expect_success 'normal stream, exit code 1' '
 test_expect_success 'normal stream, error event' '
 	test_when_finished "rm trace.normal actual expect" &&
 	GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 003error "hello world" "this is a test" &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 003error '\''hello world'\'' '\''this is a test'\''
@@ -161,7 +186,7 @@ test_expect_success 'normal stream, error event' '
 test_expect_success 'BUG messages are written to trace2' '
 	test_when_finished "rm trace.normal actual expect" &&
 	test_must_fail env GIT_TRACE2="$(pwd)/trace.normal" test-tool trace2 007bug &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 007bug
@@ -185,7 +210,7 @@ test_expect_success 'bug messages with BUG_if_bug() are written to trace2' '
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 008bug
@@ -211,7 +236,7 @@ test_expect_success 'bug messages without explicit BUG_if_bug() are written to t
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 009bug_BUG
@@ -236,7 +261,7 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
 	sed "s/^.*: //" <err >actual &&
 	test_cmp expect actual &&
 
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 010bug_BUG
@@ -268,7 +293,7 @@ test_expect_success 'using global config, normal stream, return code 0' '
 	test_config_global trace2.normalBrief 1 &&
 	test_config_global trace2.normalTarget "$(pwd)/trace.normal" &&
 	test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
@@ -286,7 +311,7 @@ test_expect_success 'using global config with include' '
 	mv "$(pwd)/.gitconfig" "$(pwd)/real.gitconfig" &&
 	test_config_global include.path "$(pwd)/real.gitconfig" &&
 	test-tool trace2 001return 0 &&
-	perl "$TEST_DIRECTORY/t0210/scrub_normal.perl" <trace.normal >actual &&
+	scrub_normal <trace.normal >actual &&
 	cat >expect <<-EOF &&
 		version $V
 		start _EXE_ trace2 001return 0
diff --git a/t/t0210/scrub_normal.perl b/t/t0210/scrub_normal.perl
deleted file mode 100644
index 7cc4de392a0..00000000000
--- a/t/t0210/scrub_normal.perl
+++ /dev/null
@@ -1,54 +0,0 @@
-#!/usr/bin/perl
-#
-# Scrub the variable fields from the normal trace2 output to
-# make testing easier.
-
-use strict;
-use warnings;
-
-my $float = '[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?';
-
-# This code assumes that the trace2 data was written with bare
-# turned on (which omits the "<clock> <file>:<line>" prefix.
-
-while (<>) {
-    # Various messages include an elapsed time in the middle
-    # of the message.  Replace the time with a placeholder to
-    # simplify our HEREDOC in the test script.
-    s/elapsed:$float/elapsed:_TIME_/g;
-
-    my $line = $_;
-
-    # we expect:
-    #    start <argv0> [<argv1> [<argv2> [...]]]
-    #
-    # where argv0 might be a relative or absolute path, with
-    # or without quotes, and platform dependent.  Replace argv0
-    # with a token for HEREDOC matching in the test script.
-
-    if ($line =~ m/^start/) {
-	$line =~ /^start\s+(.*)/;
-	my $argv = $1;
-	$argv =~ m/(\'[^\']*\'|[^ ]+)\s+(.*)/;
-	my $argv_0 = $1;
-	my $argv_rest = $2;
-
-	print "start _EXE_ $argv_rest\n";
-    }
-    elsif ($line =~ m/^cmd_path/) {
-	# Likewise, the 'cmd_path' message breaks out argv[0].
-	#
-	# This line is only emitted when RUNTIME_PREFIX is defined,
-	# so just omit it for testing purposes.
-	# print "cmd_path _EXE_\n";
-    }
-    elsif ($line =~ m/^cmd_ancestry/) {
-	# 'cmd_ancestry' is not implemented everywhere, so for portability's
-	# sake, skip it when parsing normal.
-	#
-	# print "$line";
-    }
-    else {
-	print "$line";
-    }
-}

-- 
2.49.0.472.ge94155a9ec.dirty

