Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1EE176ADB
	for <git@vger.kernel.org>; Fri, 30 May 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611916; cv=none; b=n31+y4CAYLnOrlxN0nFIkXprsaZtiQ1a3hn7Cg/Kme3KARTiv3nHWHxparI2plaGxEFwr1oso3iJQYMgOEfvnhRH1vwpYM/rhrm4hIyPCjXEYOIirl9nkZrr1WyR7eERt++rAdi8IgR48cRLsBm+Q8nuGuRnGd5OLV2Mh2LvniE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611916; c=relaxed/simple;
	bh=npMnNFgFDlU/SRrZoin920eqmixxw+/YbedgxpiVsaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=on9w8iSnYy/O/i5t0e0+QoAOqenpoZ9vKL6mgpYeBVQjO0/0JDWekJ2ys8u/SE7q/yUoD3KgiaEGVIMGi+Nbl/qLtrpdKqFyv504eiQqb04hAYWyqucAbLrZP+xD2dTGG4Onrv1IjTE0v1mrmt2RpK2g7w/vm/epOjadlXat2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IXu5Pvt5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gQYXsEEY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IXu5Pvt5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gQYXsEEY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CB5E21140141;
	Fri, 30 May 2025 09:31:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 May 2025 09:31:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748611913;
	 x=1748698313; bh=5sXua1yt+d0Z7ch93naG6pJ3cS5FGT/PwTZpPhEzPPI=; b=
	IXu5Pvt5ldkyqlrAeBVPy3v988zmjl/vluFINmSuzhZD0fwwMoC6Kw0Ak9qgX9Ut
	yU9xBAYfF3nI2B9t7gOeQsQq8vaeHo/4+gYrWGz9Bukxbhg1UEDJAHoGa5oJr32n
	JkWzN8bJbFWy8Z6nWHX32AQww/b2imz+EqmUIXFlnXH1sborkAUqxZuuYqgi5lEV
	NnArtstX07vexpgP5pPPBBn+wg9eObIOYUDPO+roVZLbU5QaIddRhvo3FtlRTe3l
	QTKTe5EckTSZtAFaZsdBxKaP1nJLMKsVYM40fIJCgN2+82vtqcD8LFkEhncKX5NO
	Z4M5RrmNwzWt/obh4Qf5Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748611913; x=
	1748698313; bh=5sXua1yt+d0Z7ch93naG6pJ3cS5FGT/PwTZpPhEzPPI=; b=g
	QYXsEEYAS+VD1KAuTXGNIuDnVmOY+9CcOaCzYmKVjsXzYpMmIZlasRvb9ovuKytF
	kvU2DT1qSg3WVdFX/FA6wSvDdON4MF1eiv29QI0M43hwL2HSsSNzE4bZvgbv1ahQ
	5WZV9gg2OOjHWS6VQpQimxS7R3TEjax1xxBw8lffs+vsEwXgNa/Id3ZL3QR12o5f
	lNPtHiSF8XslydkiE58TcXOsnYDBKmsM9DzcosMisuN8U3szwZBfmX8ON0z833GA
	HMjHZqoo8zzMWulQMcAbAulWM+E9cf5zcMyTSKV4VM0EOXJAVRVHsKKXlDKA2tIb
	16lnR+j4ULTbN7w+XSwRA==
X-ME-Sender: <xms:SbM5aFN52dEsC8ydV5Gc6eQV58j1hejiCm62YTR6YlwXoHBOWBuDIg>
    <xme:SbM5aH9WE9chHDTDdmx64tZqpH_m3JNId4T9OtpsXOdOY7QmfB0CzkixGRN-IHpvF
    lLB9cstWkLeXTmL5g>
X-ME-Received: <xmr:SbM5aERGZskUTosE01U73uxXin4S4Tq47Xe8CxQ9uCF03xMeuhdPdBJWdHAi3hPya3k9SU-xfBtpZS2XhgN3dL_VX7dQl8-hjCOuqDH9Hw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvledufeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegvshgthhifrghr
    thiisehgvghnthhoohdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:SbM5aBtvQKeAvSjDeySkIbSua0aGVa_rx_WPEt9yh3cBlgs5TQlLEA>
    <xmx:SbM5aNdUaS32m1Wr9QzlN-ZHOSqph5dwrEcjC_rwGKD-6MBl0f4hkA>
    <xmx:SbM5aN3lLCE8L0gPCSBSj0S1NDk-Nn7C1UAS5SZX0LikmJXTdW8_VA>
    <xmx:SbM5aJ_--3Y-WiiUfxw6PTgJYz4gQYEFffYhTiYqJUiaXUQEC_jdwg>
    <xmx:SbM5aGzsUhWKX85fAmDdw32ny95Gr9UKyzILXuJbuVpNMlRItoERB7zt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 09:31:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 909827a8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 13:31:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 15:31:43 +0200
Subject: [PATCH v3 05/10] t/test-lib: don't print shell traces to stdout
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-pks-meson-tap-v3-5-676f5e41f2e4@pks.im>
References: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
In-Reply-To: <20250530-pks-meson-tap-v3-0-676f5e41f2e4@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Todd Zullinger <tmz@pobox.com>, 
 Eric Sunshine <sunshine@sunshineco.com>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

