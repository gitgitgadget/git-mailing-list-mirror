Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5B62641F3
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529202; cv=none; b=i8W8nGKgjxVQVwk9hX0E5ku97FY00ZhuJSHKlvhAqXZWEHAC7UEmp0waXi1NUefLDWha3KdDAXOIzn3iXvxzw5iv6wkLO3BYxDCyA3gkfz5LygnidzSJUR8MoZzbivM0mCcn+aF9bXHRcPZm+1EpeEnBv13hkBsMAKwfinGdnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529202; c=relaxed/simple;
	bh=ghc7dMuLwnX2DkjCv3JtSH8CVOMiuoVvuEExz/gyH7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khaunN1EE2aS9Eh975x/+1ee28vdp3TpzhSU7Fm/FWMhKbBBBCunbLCsqeFgh5JKNqKahPR1xSZ7YyGBW2+W/rIMdVfm0pYHKFQ8R0WyDq/a9FW2w4cEJYoIbq4Fz4N7o1XMjHvoEPSHXI8+4tp3NS3mtl8aaNcBQ5e6Y0l/1q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pTK+uYpZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JljY6iJX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pTK+uYpZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JljY6iJX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8021114026C
	for <git@vger.kernel.org>; Tue,  6 May 2025 06:59:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 06 May 2025 06:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529199;
	 x=1746615599; bh=k7vpZC+jVYmjpgwQ7jPx4moPtmTK9wRsx/L+fkA3LZs=; b=
	pTK+uYpZf8JS71bptEcCVT1IDq4CwZMoGcxUuEs3WSk4qm55J7Wj+59ihytfeSp1
	oOlIH1SdcLw8K6gqpzpoxoBxfukYBrppK6OI6a38AgbZpWzjAAT9I92sCaIDFjZ5
	CVjAX8+CeDJx/AVeoxe/CpvNPSiBGgk+NgU6lXyHZX+9YNx0F2d8WqqaJtNQOvpV
	vZlJgtC+zS0ciJDp2wtQaGDShpV4RUME40s/T9k8rEU6md1nNkiXPoj8k6SZsnoT
	vhN/3ersRYSrCLjUI7DBO4Uqj0wAZX9rO+LP9CdDji8gE0RdLUwdssjwp5RWLuoK
	vjZPt7BNGk25Nlh5FFCHqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529199; x=
	1746615599; bh=k7vpZC+jVYmjpgwQ7jPx4moPtmTK9wRsx/L+fkA3LZs=; b=J
	ljY6iJXZm8oYGSxonokijXK3AyG8IVmd6/kIzbSk1OM3cyQalUxZw7zsQf7j8kP8
	icduRlzi44CeWHXxgso/3LLW6Lc08KtxN6pXiavOL8f+0feijYLL8Ur6p6WMfcSg
	muNwOU3OQXmljIXoOv++trCrDx14KDVrPycW+z1IORkZ9+9KSyp8B4wBIOMb4zCz
	jLu0sG9G9s3eLvc8Cr4aizuB5exc2piFqWQajlvkWu0LYAIx2jolti6HnJZQeOgs
	Aph2/NnwzraRR244peLfgkuCHZDbahRGb7ecbfyBCTOLjyffL3tau8lTSWy9EFWv
	8JoLVFpBBGUREkZ1oiAWw==
X-ME-Sender: <xms:r-sZaHcX2jbCVjyf06Mgd7neSgiWxtMZsIZwGlkKTZWqYlfoO8AJAg>
    <xme:r-sZaNMDm2cTB8T_nVMI6p54UlOASHzPw1cB1WjfMzPQ7RC3gKodensDBCFIm1dfC
    Pam24kfdeWfLTHnow>
X-ME-Received: <xmr:r-sZaAiLVNqcQHrB_8aWUUMHdBNEUVaN5_vKv_j9sWemXzmPEvcZArtGhKvFlO-bxg9PpFy2m-BjfOK5kMx6pkzlQKjwNhpvb3keKOT1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:r-sZaI_OK0s67mnOfKD9njxkVDZEmcd-N5cY192zdkGRQppQWGb91w>
    <xmx:r-sZaDsxUwfsmIZcs-HHaIOYpMUIPzixoKmQnxdjBFGY2zW7Qy95-g>
    <xmx:r-sZaHGU8emdp6VnxlQxP3SMlSTXDqHcRmBA56JRSp4G4YvrzwIGeg>
    <xmx:r-sZaKNLA_D2RUu_cEstyIPkiDadQjhSJ9Ok-m16-bXhsBryGxdpFw>
    <xmx:r-sZaBKxncM4kru1VkgI9uKpE2QIUt1InZRbidNyFYilygzpoTZbb_zG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 06:59:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fefd7ad8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 10:59:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 12:59:51 +0200
Subject: [PATCH 2/4] t/test-lib: don't print shell traces to stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-meson-tap-v1-2-5aaab2942a4c@pks.im>
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
In-Reply-To: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

We have several flags like "--verbose", "--verbose-only" or "-x" that
cause us to generate shell traces. The generated tracing output is split
up in these cases so that the test's stdout is printed to file
descriptor 3 whereas its stderr is printed to file descriptor 4.
Depending on which options have been given, we then end up either:

  - Redirecting both file descriptors to a file.

  - Redirecting them to stdout and stderr, respectively.

  - Closing them in case we're running in none-verbose mode.

The second case causes problems though when passing output to a TAP
parser. We print the test's stdout to the console's stdout, and that
results in broken TAP output.

Fix the issue by instead redirecting the test's stdout to the shell's
stderr. This makes it impossible to discern stdout from stderr, but
going by my own experience I never came across a usecase where I would
have needed this distinction.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0000-basic.sh | 35 +++++++++++++++++++----------------
 t/test-lib.sh    |  4 ++--
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 35c5c2b4f9b..16b785f3b91 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -219,41 +219,44 @@ test_expect_success 'subtest: --verbose option' '
 	test_expect_success "failing test" false
 	test_done
 	EOF
-	mv t1234-verbose/out t1234-verbose/out+ &&
-	grep -v "^Initialized empty" t1234-verbose/out+ >t1234-verbose/out &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
-	> expecting success of 1234.1 '\''passing test'\'': true
+	mv t1234-verbose/err t1234-verbose/err+ &&
+	grep -v "^Initialized empty" t1234-verbose/err+ >t1234-verbose/err &&
+	check_sub_test_lib_test_err t1234-verbose \
+		<<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
+	> ok 2 - test with output
+	> not ok 3 - failing test
+	> #	false
+	> # failed 1 among 3 test(s)
+	> 1..3
+	EOF_OUT
+	> expecting success of 1234.1 '\''passing test'\'': true
 	> Z
 	> expecting success of 1234.2 '\''test with output'\'': echo foo
 	> foo
-	> ok 2 - test with output
 	> Z
 	> expecting success of 1234.3 '\''failing test'\'': false
-	> not ok 3 - failing test
-	> #	false
 	> Z
-	> # failed 1 among 3 test(s)
-	> 1..3
-	EOF
+	EOF_ERR
 '
 
 test_expect_success 'subtest: --verbose-only option' '
 	run_sub_test_lib_test_err \
 		t1234-verbose \
 		--verbose-only=2 &&
-	check_sub_test_lib_test t1234-verbose <<-\EOF
+	check_sub_test_lib_test_err t1234-verbose <<-\EOF_OUT 3<<-\EOF_ERR
 	> ok 1 - passing test
-	> Z
-	> expecting success of 1234.2 '\''test with output'\'': echo foo
-	> foo
 	> ok 2 - test with output
-	> Z
 	> not ok 3 - failing test
 	> #	false
 	> # failed 1 among 3 test(s)
 	> 1..3
-	EOF
+	EOF_OUT
+	> Z
+	> expecting success of 1234.2 '\''test with output'\'': echo foo
+	> foo
+	> Z
+	EOF_ERR
 '
 
 test_expect_success 'subtest: skip one with GIT_SKIP_TESTS' '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index af722d383d9..6ce8570226c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -707,7 +707,7 @@ then
 	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3
 elif test "$verbose" = "t"
 then
-	exec 4>&2 3>&1
+	exec 4>&2 3>&2
 else
 	exec 4>/dev/null 3>/dev/null
 fi
@@ -949,7 +949,7 @@ maybe_setup_verbose () {
 	test -z "$verbose_only" && return
 	if match_pattern_list $test_count "$verbose_only"
 	then
-		exec 4>&2 3>&1
+		exec 4>&2 3>&2
 		# Emit a delimiting blank line when going from
 		# non-verbose to verbose.  Within verbose mode the
 		# delimiter is printed by test_expect_*.  The choice

-- 
2.49.0.1045.g170613ef41.dirty

