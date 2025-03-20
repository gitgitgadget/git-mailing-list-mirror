Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5587D2253F8
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463352; cv=none; b=ZhldZfDBI88oxaBCOc4F843sfNcYeZ/dsFshhIYY5BeIx8tQqsVbgww+Z9o9ZAqVQ+Nn2Ht2krnKEMlcDYOHIyuYA2w/6kRNmIO/72+OK6Vgw01goWaHI7KBYF5lm4ttYJizYoAH/sw3KOo9Bg0PDQKDVshFN4TN/05nbpFfD0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463352; c=relaxed/simple;
	bh=hMHoOV37e0krItUaU8O9JexiNN8vAaEVAdxYIOii9PY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SZSRqoSdMI0L3WhrUtuxLHAH/zEn6DdGF8BRi192QLhQmQ5V6sIOHFyGCF0tha2mD5RVQL71Ki5X2DJ33LpDXtECTJpwwJNSXEVbWQzq6251btpd6DM6MJqGFPxOyk75CeoTXkUB/UKnlt5J0R8T+pbR49N2mmkrWLI8P/QLBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ffV2vJ8S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgNTrvP9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ffV2vJ8S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgNTrvP9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B4D3A254017A;
	Thu, 20 Mar 2025 05:35:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463349;
	 x=1742549749; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=
	ffV2vJ8SIE+RI8B2gxEiZHTG3fDHU5q3iCLxmlzU8O16Dk73iZwgf1j1j4R4q3J/
	1RXag6iU3wVWdh8gpWZOkuK+3ia9nz3OlFpUAOpM72aGkgE22XisE5ImgcJ2Ip79
	AgXzdPh7+bEW9BLJU8KEtI5nQGx5FWmY/i23kqdLC6DsKB+5e8H6cJan6vm/cQPj
	3agbQxh530iTNVQuF6feHeyVn3J1+VxXoZc4HXBt5FmlkwhjUvlDluk1jPgvM6TJ
	Y16UbqurHjdssP9E0XDMiN1tv7Qsc9/3JtVNsvD3iW74KDGDMNFBnyf+8k7QBFR5
	1y7Z1MSy0QxOjnZvWsDCXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463349; x=
	1742549749; bh=1Sfq4J/FE5u5N3Dkim9UAQS2zWTDPrPjW8DuJVNQQt8=; b=X
	gNTrvP97EV9NXY/zfn8fgNSJ0mjYuS7ABL+xQtP3ZnbkfeguKjmhMYiLwkvpfFUB
	tgn4/J/cPJdT3Zjt/LRvslqiTTYhCW8Cy+8quDXKT9RbHW+SjZ+ADZEFH5Aw3q4L
	5TNYZBuoE/Xw8rOjlvUTi0ou8WwlPm+MjYp410AnmuNcW9tYijeQ9/WFDjFaguXY
	fxVo8+VV+JxF6II5dR7GzWYIyz3n1bkDVB/xjepFVeSznutAi6swl8jtFdhW/xD7
	tux35M1KvD0umleJyZ5TnhSXlXElKkjWJ2Z5pS9pDLfJVIi0WXe7TAAk32/UIes4
	PsCdnwfHAO0eyNxZV87cA==
X-ME-Sender: <xms:deHbZ4rFghmD9OwTJZgLPSLIJfungBN8ftzwKZoUIPmm5imie2o7Sw>
    <xme:deHbZ-ozVmlcJa0mcYDTilqWtVxZetOygq2UO3gvSNc06aamWVOnaL0K150-1ljeZ
    t60E6unfiApsRmVXg>
X-ME-Received: <xmr:deHbZ9OucAvdnINAsyUfnIgFFOY7M9wP1JZhBzKtTLqjvb5FWABrFJSqSl5p_IR_YVwBP8o_8VkBlPGVFOgJhY4-OzClVdQWtFogaBjfz1ZrPAE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:deHbZ_5tc4UlCTzkdpp1KCYL4tGVgF0vX-sBifQTtgNbaCZv3PBICQ>
    <xmx:deHbZ37NY23d0NnXntKubkS9F_xu-0Uhcj-5lC1-kE46m7KhfaeXvg>
    <xmx:deHbZ_hOLHPH5fBzcxohDZP5oROeCYSojoaWkU-X8Y-3v6viiIjJxA>
    <xmx:deHbZx4BDigyxkeGi7TCjLUkrHxqFrI2wyuY2PfKtNRQ_TQ_avve_Q>
    <xmx:deHbZ3HMf8jimnX4SJK357Lg8q1Nj_EehwLjFr_sELGuT6nFPsL85oHf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c44bab7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:45 +0100
Subject: [PATCH 18/20] t0210: refactor trace2 scrubbing to not use Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-18-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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

