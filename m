Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C4A20FAA9
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071837; cv=none; b=SXuN2wGLNht0HdREqx2mOW+tFhm6Se0dbQamjCox2FKxMNvryHyaVtOd4femNNsArOFGr2TpWws7Ft0c1ooHlttFR5o4jg8Wn/OC7cR/HOHgKXgW8JK6/FzkFZ92Okj/qr7Lab+RG0Ct43vnA9tCcEPBMYNPC+Xc5EQML0gb3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071837; c=relaxed/simple;
	bh=W5vQfqGcP+FcynwRxGfXxDOW1LmfnQPXMZ7KkfpvjYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XumoGRo8vz6kLQNZ8zK918mx4RUka75IcRO8oYFuS88CvBdCgyn9aW1PDloytG7kYghKjENXUYEXjyOw3Ao7ZHXtwY89+4ZEwnPYKiDvoVhW32hFhCYvcITCfK/k/o8dEd3tbK55sZSkaBOaHVVF8BpHwohNmm6IyeINyKzypAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XAWZqbXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e8AWLp4b; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XAWZqbXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e8AWLp4b"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id B898D138390D;
	Thu, 27 Mar 2025 06:37:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 06:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071834;
	 x=1743158234; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=
	XAWZqbXsSd7VhEnyLU9+CzTROhLNvzUSgDqsMasB3rKV98YkfZorKstLaCM2nG6d
	j9qH2TOdDFpk8/Bsjtz59R7SS29jLOYJHw3u4MLNVRLOcjGY5lemP0iJKObZSFlO
	iQz5pOcAuyfaLFBpnLEHLaHYGseuq1deGwEfseivm5b9XJdivn41zbcG8nM6GFU9
	DhZVDiq9BpCJvvPCfLNsojAgUGrbOZxtJWbhwaNiE2I1i27vWJvpmQfPpp6fjE6+
	/uMBSMD5iJLEqJYDpMdyRe1RMrI/yyu0H/5cHlbmT2y6aVm+YYb0hHBqyq4aZQLX
	Ey8aBcMeeBx+pKIsAl/evQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071834; x=
	1743158234; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=e
	8AWLp4bf5us9kVAOb9cKIfB/4CcdUx4Kn6A4BBfpJC4lBDqsJeBs0Eea2jl/U9by
	mb3A0Fx4L+ztCiTEtKUUJx7FlII+FqXyXDxD0UX1/1d811dDzFqomJ3f6YcU/G7s
	lwep3eNW3nsaaoh6ICwjNSfXLf3HBT9b7sh+angp1tUYQQk9KdGDvbCAIf+8lnoJ
	N01hT+QGmW11+c05RUSZCpqe58ep6oEFoDrXtBInl9/RYO2tuQgP+4aRITMU8Pkz
	H7e1ZLv3jpsJAjLcXIeivQB6oSMd17TxcUBpANRebCl5ucMTz54nd+hnx00dOJtS
	/g+3cP9aKkYwg7LR5Sfrw==
X-ME-Sender: <xms:WirlZ1TnDkWz1FkN7u7mUbkB_QJtzzvZbZelaX7H8hARLjL32v8B9g>
    <xme:WirlZ-wSlCxv_sXR23KX7N85nIsMJfpA47_Ziz4SxckrHVUD4P73o0H7qQj1p9AUz
    d_a0VeN9_-hl4EFIg>
X-ME-Received: <xmr:WirlZ61u_BR9XKcWP59U389BCP44g2xbF1uzFIH9-cKrcKcB5Eclw7Wab3I8K3l1XmNKT2DsH2i7d2GkSbjLRjCWj80DN3Jjmu9GJS1vc5yNyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    shhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:WirlZ9D5SQ3cxpOJU_fXqjeDAIWMLTo_ZXaZU9kGUXRrZxMAAnmfUg>
    <xmx:WirlZ-gB9Ab2wXIHkdZhbp0lMs7sXdyOAYg0_hImDW9-_0fVKv8fRQ>
    <xmx:WirlZxrcYaJ1TsU3nsJnQgYD0IGRkbemhUiLtOJ6MIQDSXyO93gmAA>
    <xmx:WirlZ5ik__Xa-sOBgmEK6SnqfFr8Y1gwkx4vTVlbRY8vrllOx90wUA>
    <xmx:WirlZwZCOcWPnlGgyFyZnC3t579ISLDodBqnVw6KZU8nHmVSshCg6gM->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee9014e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:05 +0100
Subject: [PATCH v3 07/20] t: adapt existing PERL prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-7-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
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

