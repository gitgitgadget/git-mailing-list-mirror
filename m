Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABDB267F71
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908474; cv=none; b=nwgMc2tD6T9MhY47Ict8U5uYqzqrlHHCYl5vlxUOrGSW4Xue/osH7vCnWVut69EmvGju9UR8XIKdCU1s/H2cKIwVxTJsY/N6OD9ps8nykVIfSpFu+2P8srOuCpWodmH9eQ3JEKqO0BTw+oxf9od7DLhJ+TnhqduHpUMOW7rx0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908474; c=relaxed/simple;
	bh=W5vQfqGcP+FcynwRxGfXxDOW1LmfnQPXMZ7KkfpvjYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJpsftYMgUGc+5/jEHv4HigiU7SD7c5mhuV7Tb00Z40LHqB4BG0gI/zb4/MkDdAz/FKA5nCUOVBKSMNEXIETTHfKORMqXm6tzdP/vdsU/QnG6ZRDMWJVRN61XBTEOS3np6QPrtp5GCqVp33scNerXJOpRC1+II66PWFvYJH5xPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mm7lqMhC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwJ6pe9K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mm7lqMhC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwJ6pe9K"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DF401383156;
	Tue, 25 Mar 2025 09:14:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908470;
	 x=1742994870; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=
	mm7lqMhClxh06vVXS34GgwgrOTlhShjeLO6FZpl/ksxJzJfpAB4G62Zx5w2dAGHW
	Xz4pE5vJkBXXKmgSXMCel3Zlog0eDiH/HQ3cV5ELDfWJBZrmDSP4lCYqbNdh4+7V
	TTskPF4xClWimUK8dpvXtwMidP740c4BlssZcJkbgsV+GU/ztX+D87nWmCyW+VVb
	5NQi5mU70EqbcSh17ZcBk9UZOhh0flcR4q5yZwSlMHQD17YGQd7/SQTBXVT+b9CW
	jVE9nJYKVuBrQBrjPW8amk+a94NWeeY2TiHFzo+AtafJUWe1a4qhSm5qx+Jwgq8Z
	MrUNzWN6I6BotmfRFxhwvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908470; x=
	1742994870; bh=+gu+FJNpyDG04XVbftmayiPJ01w5q1S8ohw5XjWfwLc=; b=J
	wJ6pe9KDz4rBciWdK22WIA7tZLt13WPdPcu5J81evCwGhSrorV3VM+JeSBKzGWZm
	Tx43XkKFw/Of8aAIpEnk4i+mAH/1zV/M1oZaETCu5tJe/sKC7gDavrvlkBXU4ixM
	cGqSzc98m9MSAXBg1WCsr62FSYnIwwhtE6Au6Y2PE9GNPQhHaZqm4CKgM4D1PokS
	U9+hTW6g3LXIj4FrMK9k2q+NUNSFkydwo+0cY1QMWNx9vWW1ELfvRPI7uSR0DbHr
	nNAhloltgOsMJM1bfrFUcR9QL8VH4c4HytX8vOoAeUGSDnLYO58NLI3Zk+cZaPhE
	GLxuIh1nFDbqurrSIRtcg==
X-ME-Sender: <xms:NqziZ2yidcMy6L5cK17ayq7jsqBtq3U42KTBgckiWDqhAE8SJz-33g>
    <xme:NqziZyRMiZSbDYxcs_yLLqUHwvoF8KVaduaeBoyBniYiPkz_qYS6QWSSX8fYlufq9
    PG-clfS8RdllI2iuw>
X-ME-Received: <xmr:NqziZ4UbbvncPZsR-dzfdXjP0V2yhRZgBuLvICmnzJossrCk7vP5tX_HhgUFo-yTlWNfD7qP8_PFuZYGu0vUdqLKMT7MZJs7K41kRCv0Ski9LQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
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
    htohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjohhh
    rghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:NqziZ8ihGhrRRM-sQaVcq4RYojX-YPI3KlkuCITndrURkTc_QCaIJg>
    <xmx:NqziZ4BWVNuLGMhvc8yncROmjK7159EOwfteZfKeX5gZQ_DNIinX9Q>
    <xmx:NqziZ9JwhmesBjbzJbc_4HtGfxbbQKoKlfyEMFGYqes1o5ghXH52Bg>
    <xmx:NqziZ_BG0G15xmIRYjVS465Z6cV9R3etkRL8_2esWJhQfC83PBdoqA>
    <xmx:NqziZ37o4r-X8M2lG0vxPeVOvvZ1-Is-h4aS60ESyq9y6SbE99PUi1HO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id af55590a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:25 +0100
Subject: [PATCH v2 07/20] t: adapt existing PERL prerequisites
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-7-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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

