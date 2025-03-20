Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB2C22422B
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463343; cv=none; b=HoI0v5G4Mc/l3ezpPewd7zSR/WEOMZR9WdxPEBhcSCkkDdEBM1P15cHuEJMgYGuxfUnqjyiaV4uEmvzv/uhIOEa2NM/atmXRnhpbdzMFPl7875ZX9JcQusIsI8NOGKCvIzHwzTJLnxj1uLInatKP2FnuzSSsv9xOCFUu7dPHvvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463343; c=relaxed/simple;
	bh=W5vQfqGcP+FcynwRxGfXxDOW1LmfnQPXMZ7KkfpvjYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHdwD1wjp822+CVqd2ToX5sFf1iMOJJRVKN4BcNmdLl1cTkqUGY/7ZD8lLE/FQVggqS8fxsrIXlARy7Wx3Mn1Pc6eFicr/dRCfmPi9IEocas1F8GfRWC8N9aMiwFVFeY+HmEwo823KjCY30MPO2b9ap0QgSkGUidfo4m1Lbt/dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SHzBGMpB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jsYiL7wz; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SHzBGMpB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jsYiL7wz"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id 5265111401B3;
	Thu, 20 Mar 2025 05:35:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 20 Mar 2025 05:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463340;
	 x=1742549740; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=
	SHzBGMpB03G5pCWKhJY7NtZ/qPEQ56pnx5U1Yos6nNcebGo1KTPDe5DMcdgCUZp8
	o4jsWEh+u075AW2bMHKilMYzUaUUlq9nQkQ5bun+vcsERhXcbLR2v9aevT36sQfV
	/e+f/iiLlLZ4HAKZqx2JfvAGvA/HqS8rI1irJXSHHB2vpza8XdSroDGleJNO3tj0
	BlFpj64sP57wfdP977BX7olq0H+MtmRn+X1eOQ2WWodUlGpHuUdlqhpfnlxIf9PX
	IJEGV3X8efZrF/c9sgOPCUZNdKv7YygnfboYWNfxlEhnQGU/0O/Gbiy4aaRipwxw
	rQ4JLXJN7RgkqeJ7hKOhQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463340; x=
	1742549740; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=j
	sYiL7wzEtK+QhdYwHaQ5n8e9TLN6gCC4uQvztDS8AC5/l6pBhDPPbPJhw8Q6+0M8
	Jc6h2xJ5anZqoteh9DTtVmBv9TwdraHblvgIKxJYms7swxQg/uiMN+I6/AfgcTRD
	i0bNed8vEuSKhLdqRiO0i6kiL6RYBUx/OE3bwJWiCEZGYC89Hau0A78osnMYM0j3
	9bqIJkqE56EiCNIm0ucjbTOQTxPcit8Qg2dkYhJxKvJxrovR7o157gMSWeqDzDmy
	pkKrV1JlExPXwqs58v/EUhmxMffH8nkRyAql5fg/Lo4QAv5n+GbWIckGCiS31W+w
	FdL3aLfPWiuBS52N8LueA==
X-ME-Sender: <xms:bOHbZwBhVe273v6941ozvIBaYU_N4H1ZL4kFmJsRfpk_NMkBuMjm8w>
    <xme:bOHbZyhpdnaJ-8QLcMdvIzShGas23E7mPJgI-a1zfUh6M87WVDC7SejC44r4kXxEv
    kCbkGRpvgfAmeildw>
X-ME-Received: <xmr:bOHbZzkOJWs1qM32_XN9oMFmH0tlo43uTSEY7ryAnC8ozcuX5ojN48gzQB1TFAEYkh4TLD398d37BY4VHUvWwRjIlfOabnuyh0v9oMLy9PcfX3s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:bOHbZ2yw_bhGxFUL7uf0yauzXB3J1eJl-SpVWw5ofkeTmpiSyM-_TQ>
    <xmx:bOHbZ1TqWDjEq7b3UdUy4YOosfdpekFfaDm-iabswf5XKk8UcCngcA>
    <xmx:bOHbZxbauT6WNa31h4LbHCewQ3br7XywoqFsKgTuc8zNyYz_dUhUfw>
    <xmx:bOHbZ-Qw90Ennuf1-Du1yXi-nFwT9aEMyMDY2YqIzhmhSz0uRT0-kw>
    <xmx:bOHbZwdu70MgrRctOQD5HQ0kVlz3yWng-8h0fWNtP1oT6_siRN7bY58E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 904235bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:34 +0100
Subject: [PATCH 07/20] t: adapt existing PERL prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-7-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

A couple of our tests depend on the PERL prerequisite even though it
isn't needed. These tests fall into one of the following classes:

  - The underlying logic used to be implemented in Perl but isn't
    anymore. Here we can simply drop the dependency altogether.

  - The test logic used to depend on Perl but doesn't anymore. Again, we
    can simply drop the dependency.

  - The test logic still relies on a Perl interpreter. These tests
    should use the newly introduced PERL_TEST_HELPERS prerequisite.

Adapt test cases accordingly.

Note that in t1006 we have to introduce another new prerequisite
depending on whether or not the IPC::Open2 module is available. Funny
enough, when starting to use `test_lazy_prereq` to do so we also get a
conflict of variables with the "script" variable that contains the Perl
logic because `test_run_lazy_prereq_` also sets that variable. We thus
rename the variable in t1006 to "perl_script".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0021-conversion.sh                 | 10 +++++-----
 t/t0090-cache-tree.sh                 |  4 ++--
 t/t1006-cat-file.sh                   | 14 +++++++++-----
 t/t7501-commit-basic-functionality.sh |  6 +++---
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 9c3738ebb3f..4a892a91780 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -841,7 +841,7 @@ test_expect_success 'process filter abort stops processing of all further files'
 	)
 '
 
-test_expect_success PERL 'invalid process filter must fail (and not hang!)' '
+test_expect_success 'invalid process filter must fail (and not hang!)' '
 	test_config_global filter.protocol.process cat &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
@@ -1111,19 +1111,19 @@ do
 	branch) opt='-f HEAD' ;;
 	esac
 
-	test_expect_success PERL,TTY "delayed checkout shows progress by default on tty ($mode checkout)" '
+	test_expect_success TTY "delayed checkout shows progress by default on tty ($mode checkout)" '
 		test_delayed_checkout_progress test_terminal git checkout $opt
 	'
 
-	test_expect_success PERL "delayed checkout omits progress on non-tty ($mode checkout)" '
+	test_expect_success "delayed checkout omits progress on non-tty ($mode checkout)" '
 		test_delayed_checkout_progress ! git checkout $opt
 	'
 
-	test_expect_success PERL,TTY "delayed checkout omits progress with --quiet ($mode checkout)" '
+	test_expect_success TTY "delayed checkout omits progress with --quiet ($mode checkout)" '
 		test_delayed_checkout_progress ! test_terminal git checkout --quiet $opt
 	'
 
-	test_expect_success PERL,TTY "delayed checkout honors --[no]-progress ($mode checkout)" '
+	test_expect_success TTY "delayed checkout honors --[no]-progress ($mode checkout)" '
 		test_delayed_checkout_progress ! test_terminal git checkout --no-progress $opt &&
 		test_delayed_checkout_progress test_terminal git checkout --quiet --progress $opt
 	'
diff --git a/t/t0090-cache-tree.sh b/t/t0090-cache-tree.sh
index ab80c9ef135..d9015882946 100755
--- a/t/t0090-cache-tree.sh
+++ b/t/t0090-cache-tree.sh
@@ -128,7 +128,7 @@ test_expect_success 'second commit has cache-tree' '
 	test_cache_tree
 '
 
-test_expect_success PERL 'commit --interactive gives cache-tree on partial commit' '
+test_expect_success 'commit --interactive gives cache-tree on partial commit' '
 	test_when_finished "git reset --hard" &&
 	cat <<-\EOT >foo.c &&
 	int foo()
@@ -162,7 +162,7 @@ test_expect_success PERL 'commit --interactive gives cache-tree on partial commi
 	test_cache_tree expected.status
 '
 
-test_expect_success PERL 'commit -p with shrinking cache-tree' '
+test_expect_success 'commit -p with shrinking cache-tree' '
 	mkdir -p deep/very-long-subdir &&
 	echo content >deep/very-long-subdir/file &&
 	git add deep &&
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index a574da3df53..0a22b0a7b8e 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1323,7 +1323,7 @@ test_expect_success 'batch-command flush without --buffer' '
 	grep "^fatal:.*flush is only for --buffer mode.*" err
 '
 
-script='
+perl_script='
 use warnings;
 use strict;
 use IPC::Open2;
@@ -1345,12 +1345,16 @@ $? == 0 or die "\$?=$?";
 
 expect="$hello_oid blob $hello_size"
 
-test_expect_success PERL '--batch-check is unbuffered by default' '
-	perl -e "$script" -- --batch-check $hello_oid "$expect"
+test_lazy_prereq PERL_IPC_OPEN2 '
+	perl -MIPC::Open2 -e "exit 0"
 '
 
-test_expect_success PERL '--batch-command info is unbuffered by default' '
-	perl -e "$script" -- --batch-command $hello_oid "$expect" "info "
+test_expect_success PERL_IPC_OPEN2 '--batch-check is unbuffered by default' '
+	perl -e "$perl_script" -- --batch-check $hello_oid "$expect"
+'
+
+test_expect_success PERL_IPC_OPEN2 '--batch-command info is unbuffered by default' '
+	perl -e "$perl_script" -- --batch-command $hello_oid "$expect" "info "
 '
 
 test_done
diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index cc12f99f115..a37509f0043 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -46,7 +46,7 @@ test_expect_success 'paths and -a do not mix' '
 	test_must_fail git commit -m foo -a file
 '
 
-test_expect_success PERL 'can use paths with --interactive' '
+test_expect_success 'can use paths with --interactive' '
 	echo bong-o-bong >file &&
 	# 2: update, 1:st path, that is all, 7: quit
 	test_write_lines 2 1 "" 7 |
@@ -345,12 +345,12 @@ test_expect_success 'overriding author from command line' '
 	grep Rubber.Duck output
 '
 
-test_expect_success PERL 'interactive add' '
+test_expect_success 'interactive add' '
 	echo 7 | test_must_fail git commit --interactive >out &&
 	grep "What now" out
 '
 
-test_expect_success PERL "commit --interactive doesn't change index if editor aborts" '
+test_expect_success "commit --interactive doesn't change index if editor aborts" '
 	echo zoo >file &&
 	test_must_fail git diff --exit-code >diff1 &&
 	test_write_lines u "*" q |

-- 
2.49.0.472.ge94155a9ec.dirty

