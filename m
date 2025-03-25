Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2510268C79
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908484; cv=none; b=E88+mZEJkQ5V5hGwpE3rA8RNowPqlT7CS5PpYMU2STiIpaDuZfDJHb7MKkjLqR5PpLENtBJ3yiR3830Nd6ngSgZVMp22dHkh1QHOVzaE3CA5WgRIsmw1f5d8Pf8A5wF6j1ZsA8kxYNwAnPbnmkcvBCBw+V4xxbNG4rxytOPxaWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908484; c=relaxed/simple;
	bh=hMHoOV37e0krItUaU8O9JexiNN8vAaEVAdxYIOii9PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QG0/7ywNp/kbWvGNc0h1/fKpy4dSTBrEN0L/5RSF4u0yCJIeFDuTbxvJl4FyOsX1QKEdq+LR+ZS1jLfUEbk3Q34uSNfWTR0Db4C2GqM03JU9EvobzHd5U1PUPcCCkvp8A7tTztr+witL5OsGtSwUDfX7gDlDXPcyvRrXtrCfVxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DGNj3d9v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HBFUJESR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DGNj3d9v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HBFUJESR"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B24B1140272;
	Tue, 25 Mar 2025 09:14:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 25 Mar 2025 09:14:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908482;
	 x=1742994882; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=
	DGNj3d9vz3Ox6NlJ9aRLB8CDWYQE6E1i0o2dBiweLH6EW/raEOX8MRAF9bY3/JiP
	unqHJXVltFfgHMIOTn0O9OEGdtkqbFzf9XLLRjIHLtA8J4vSPVSQ6VpSRuLKeN0M
	VGoSyT3FLUWA9oyntRDbtaphEtS3wPSm4CNvZCZgkD/4zvqt+2xmUY50bN8D0So7
	qJycWaxzX6g3DXWKZq9WLkrjGIMsZCSPkxg/+0FH+W+HoE3BIIcLdzQBlSN2I+hp
	mTpcj8qraqaV9lBvOe+yMs/KqRm0R4hkFMn/JdaCQfelNs17DvurEzhTDf2ReLty
	u4u+d9ntaCQyseomY38G/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908482; x=
	1742994882; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=H
	BFUJESRJV7PAShRe67JUnS0cEZxR+5eBw9QTEj8l5PP2zfEPPs3HRRgBoWbtJRNC
	sCDBbtFKmVtdmgt9JjFiNCXXsIgdeFofpFZ04DpLOCFkPIgK0Bcc9LtvA7pnZxnr
	Wcq06WY+rtYFE+CRCUXw4Bl5hiLxEOc/87ZveETsFR4Bb3j1WHR3yCVAYgZ/cWGV
	7EKQcTY10l5ep6pfnGeN8S9h8q5LfxvGYsfT21n6nOpOnYLsaRPtfd1+M6kxUr72
	YJxZgKxDliOhdGMT7X0l24qX9ASqWL3S10+B2e/zn05rVwEjW3P7z9MybDT4hfRj
	Wk+SZRcwOe1Q5MLY4RBYg==
X-ME-Sender: <xms:QaziZ2n4_IlEUCzH2Qx4tImb62__GuZzwSbpP2GQHOQ9_SqO5y_3ow>
    <xme:QaziZ902pl6zfw-TzuM4FA8Sr7sLjPKuXUBNEi8uwvmTyInhFrqrk7BwTjclh7N7O
    NfToRgm7iBiAnYIHg>
X-ME-Received: <xmr:QaziZ0pCLNMRwFsjpjDtjOvXUkd5qFWUcEhFgY1zZzbH5q61F_HYI_kMJMptOkQcC2wdGgS9rfAi1AK69kpaNa3TevTduF9O0QP_7krnTPVD2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QaziZ6khgjp8J700nP8ab8zlZQF7zVHxHwJm_lQGBCJcWqRP-aWTtQ>
    <xmx:QaziZ03vtaW2VlH0m2IKc3Oram-JwGG2pCU8bf9TEpg6T_kw9kbRKQ>
    <xmx:QaziZxuuWOWqpe9nfXoPf-nmiz5avGSWh3dLHfbtMEMVyoPdh0A1eA>
    <xmx:QaziZwX1r7CPfdqe4wFPwNcMJPCujknEVhm8ohAOzJ5HIFoPfLvfvw>
    <xmx:QqziZ48y0Twxy-LH4PGpZqnPELDw0hks1nmyST7ZDltjJU4c1xda22CR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 68f76844 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:36 +0100
Subject: [PATCH v2 18/20] t0210: refactor trace2 scrubbing to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-18-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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

