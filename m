Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9C19F421
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656771; cv=none; b=V1h9LOjrnlgaqF3pJpizTWkaaMlkZAgLOdxyRlvjmaG8c6yt2h7WwURfCd6ewPFM4GwC6Ws+zVjp7ww2Q2APGzYSGW4o6cI3i6s/dC5hb2/BN/dEFvLc0t+GlTkaF/v4698ULbG72P8FgJAKvIFbn/XL4kyKYUtHn4i5WABDbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656771; c=relaxed/simple;
	bh=+1U+08GrhZmFmsaa9if2NgRqZUHvdApa01IyhYYJrQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GSHeM0YBS1Ewvi5nzTMFMHn9QpPWhDWN8BQdex/ZTER+txACywLVDgPEM48Gg3lvMcWIrMoHokWpFS05jH/0w3Uk0DB/R7gSP8WyE6iySugRizig9j78u38sAluWS7Ir/S4ayaAR6EF27gWod2FdV1BlsZWcBRPBL8Yga/B289k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aL6ZzDIM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KDA4fxsw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aL6ZzDIM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KDA4fxsw"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A18EB254020D;
	Thu,  3 Apr 2025 01:06:08 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 01:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656768;
	 x=1743743168; bh=8xxJx8KGd/piQ+I5mcStUiSn3WZ8iTKJWLLcsZLrwKk=; b=
	aL6ZzDIM3PCp/LUenff79JmtcHY2wueRo9BvTMHxQdNfB8uOVL3e2ZOuLYTplK5R
	B09NgduiZKHRru+t2Y4FekSquymDCL4l2/0t+jJYwHDEunQjaPoljx5rnSFcgXug
	X4odiZ4NYu6XWJwUYmh3UcICo49QasuUOBl0xvmGZreMeC6hi367jiBcXuymEjZP
	snGKIoX7vrULYNEnsWf4WibkKugw/3YL5u4kobNt9EP6/e/lgwy0NKGlTFgpw4WA
	p/ZOa6pZy16MRuCu1ragM16YWSTC70M8yyPvVIXhXnsK6GdOpmAp4x6Rg+eMIEXB
	809p26YtFuzzhyhYYkpWwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656768; x=
	1743743168; bh=8xxJx8KGd/piQ+I5mcStUiSn3WZ8iTKJWLLcsZLrwKk=; b=K
	DA4fxswdXFB4aIFl66p01tjLLpSEyS7WaE/cuPovz4aTKyhZ2bsRxVVNEJZgbmI/
	SbGjEXWDIYAfnj/MCpeQOyqP5UvAB+tZNsmNkm8LxbQQIOyVS0jb5EEW/TyPZFxF
	TiQ0SQAOjGvicqlUi2gwBlFVXiNjetv7FUL+HwlHJ6nkt4GlwufHTvXvY6CB7K61
	pBfVy2V6OKUqGOYeUHwy5vQwLpKjEziOrPTEJw7UIberENqIYc6utxr8OzNWtKzq
	ltHvSROpvgyk38zjcsl/u8IY7hqTLFErTy4W8tHIXUo6Q4uMG2v395Lu7EREISmm
	9uWLWlvV2gkVxzmndz9vw==
X-ME-Sender: <xms:QBfuZ8Y5hNWZm-2DTO3jujl9-4ohGs9y357vBN3TvvUuGx8TvpdJpg>
    <xme:QBfuZ3aZsvO96pj7EyRfZAVmmb7RtN6l85pkfFmLMq2umtRfs5UBd2V0qY0q-FK4d
    5qeYGlEWFw53hI1Lw>
X-ME-Received: <xmr:QBfuZ2-zE_3t3BYmJ0mR-vvXKNGY0AwiJsldRs1Glhgq7qA9AtqR60-7i8QJuGCb0OiNpZIIQBuvXqpNqcqC93XNtOKSKWQoP5UxhADy9-tPvAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QBfuZ2qM0GUUx3kZJ4mIJS3m4u-N9Vk4UyLvWMhWwl5Bv3E0-qOCNA>
    <xmx:QBfuZ3rJ7lEKf14V7kx37jT1RH1BFXh3Sdq0VQLxAQlcJGHVm1Rkdw>
    <xmx:QBfuZ0QBDnXOg838BgbYoV_WXDq3JYx7F-1OW_FSqMa8rw3HmraXPA>
    <xmx:QBfuZ3ozZwGSH7rXVR-qVcRG8Ati-Pz2rtUhvFtk_vrvEMAb5vor6w>
    <xmx:QBfuZyM6nIebjTgDZTD1XYtlxzOWVqOZLj9GXUUZ_IN9W6BlYW35wEYS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ebbf995a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:58 +0200
Subject: [PATCH v4 07/20] t: adapt existing PERL prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-7-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

