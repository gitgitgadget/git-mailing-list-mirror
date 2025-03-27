Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F94E210F6A
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071842; cv=none; b=sOhgJIb7ImEBdX2q9fmaAXFIpkHfExerhrVRnRCA7mfxmlcUlD7FXiZWawoZPlXatP94dMjViZlNvogG8iSyKSBkr5Pvvsf4EsPDX56bC7ouPWhbUm2R4+RS9d2+1e5x3YUaLWjNaiqLNfmxUDEmIjS3n4aCO+S+HoecvQZ7dB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071842; c=relaxed/simple;
	bh=nKBTUDW3m5HVPJrkSl0OA+SRnqOc5+0pmJORynvddlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FNrlf1aipMDrsbh6KxKm+ihrdcEPL0WYJXYfApjInNfWGfDQY1PgaQs8Si5rMfyhggPCbS3KWZzfgplqsprMe1b2tJtPNgPitvfrmfi3/7gUEKeaXfRJ0e77/Z/BEgyfjEjBmDrlxZBCD6XPaTGo/vEhFa9QlxdxSf0XRyuuyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OouXSOfl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M8TPyx18; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OouXSOfl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M8TPyx18"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 860FB114011B;
	Thu, 27 Mar 2025 06:37:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071839;
	 x=1743158239; bh=nJLgrkszrMLx9Na/l0R1GvMiWQHEWW0d1vI0kA83XQM=; b=
	OouXSOflJnEj5iyB1tZ3oGWOyHL50H8NqCnc9dghe2qm8u3UyPGp/1hbkmxCGSOo
	wTCHCy4HodCh97KqKbD8mzUG90eQP7Rt9CGecuY6r/AfbhCxEaCHRwVRoCappbLZ
	+drqgPjR7JopbU1jKh16WwEg1E/pBoFKeDJbce0P73d+BqXlrs2O/8F499lPlqmu
	T7Ahu14Ildv1EAoe056NpvWUue/SxmnAnVLMXabn7ewj+iIaPwAHW0X2O3cP0l0x
	yXQFzLKyP3WZW1BBZIbwWODupWeePGrLOhb8uersjfmwHpwjRsapzoeSBtazIlN2
	hb9UH8mzl0CjVtr1Amc0Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071839; x=
	1743158239; bh=nJLgrkszrMLx9Na/l0R1GvMiWQHEWW0d1vI0kA83XQM=; b=M
	8TPyx18T5BRWAMTmc/e8VHC2EwSFwh2tWh8FedG0iB6LFgPFZAhaUfAsA8b1z6t0
	raT+lja0PCQwlhnUL9rVDXZU3HvzDOAiH9w+TTmE7AvrHrWFhrBR10OpuL3Q7QIN
	6VcLPCy3oSa/z0T+tGMiaau718EooVrjSTgclF4MPQRnNuB1yhnqz8hlTxEJTbwL
	rwRDK/ql63EG51aZaL5muh2VIp4XG2RNiRrxeqS/Kkj1q0+i77jvoCrenzKnNrUR
	dx9yaG0cDkmqeCoAEGyL8dmLgSZmcytUiKjp0uADd4sT1vWwPe6jz5D8+tSsLgOp
	tGWHKzu2Nh/ySoqi+mnag==
X-ME-Sender: <xms:XyrlZ8CT7E_XgD-gsEwIknkdXhS2SiWzooZSLWUy4jqGsQoErM9Gkw>
    <xme:XyrlZ-iEb5Ft0CC398MDI46OmUvNzBhAXsh-zeCcP8kIbMaCg1BY9qAQqdU3zdXcg
    EfkQ8-OLN9bfcZBlw>
X-ME-Received: <xmr:XyrlZ_leJMtEe0cyUpGm4nZmT0zE_Nvy5DgYQUAXCB2bTXdsoqXzG4ZFN6xlBgmUuPA_LDvZ0RJOazvI5E9rC_v3Z7bo7SwcxPuh-5Vy9cfAZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XyrlZyySP-zGzcVjQi2lmEBaN7Jp8JZCZCkvACTuAKj8tkyi4-ENPg>
    <xmx:XyrlZxSJONlMYjXDxs8YkkJay8Q4TkNkwCl2y_zyVA7WR8C9CqF1AA>
    <xmx:XyrlZ9bxkH8uqdbaG4obP5ThmX5-QAGr2EMdHOh7wVoFbx575lt7Zw>
    <xmx:XyrlZ6TN4oH4kwigY4OPg6QF334lpMAKdoiUHNlBKxUQsMrDEQINPA>
    <xmx:XyrlZ6IrJnJu5XmMqJY014EAHOzmgrwgr_cgqGuCLBk5AYzJjdIFbkAe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e068931b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:10 +0100
Subject: [PATCH v3 12/20] t: refactor tests depending on Perl to print data
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-12-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

A bunch of tests rely on Perl to print data in various different ways.
These usages fall into the following categories:

  - Print data conditionally by matching patterns. These usecases can be
    converted to use awk(1) rather easily.

  - Print data repeatedly. These usecases can typically be converted to
    use a combination of `test-tool genzeros` and sed(1).

  - Print data in reverse. These usecases can be converted to use
    awk(1).

Refactor the tests accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh          |  7 +++----
 t/t0613-reftable-write-options.sh   |  4 ++--
 t/t1010-mktree.sh                   |  8 ++++----
 t/t4150-am.sh                       | 10 +++++-----
 t/t5300-pack-object.sh              | 16 +++++-----------
 t/t5326-multi-pack-bitmaps.sh       |  6 +++---
 t/t5333-pseudo-merge-bitmaps.sh     | 18 +++++-------------
 t/t5410-receive-pack-alternates.sh  |  6 +++---
 t/t5701-git-serve.sh                |  7 +++++--
 t/t6013-rev-list-reverse-parents.sh | 14 ++++++++------
 t/t6115-rev-list-du.sh              |  8 +-------
 t/t7006-pager.sh                    |  8 ++++----
 t/t8002-blame.sh                    |  2 +-
 t/t9850-shell.sh                    |  4 ++--
 14 files changed, 51 insertions(+), 67 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 5e0a1fa176d..77ed11e7172 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -643,12 +643,11 @@ test_expect_success 'basic: commit and list refs' '
 	test_cmp actual expect
 '
 
-test_expect_success PERL_TEST_HELPERS 'basic: can write large commit message' '
+test_expect_success 'basic: can write large commit message' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-	perl -e "
-		print \"this is a long commit message\" x 50000
-	" >commit-msg &&
+
+	awk "BEGIN { for (i = 0; i < 50000; i++) printf \"%s\", \"this is a long commit message\" }" >commit-msg &&
 	git -C repo commit --allow-empty --file=../commit-msg
 '
 
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index fa1e2f9eef8..42aa1592f87 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -139,13 +139,13 @@ test_expect_success 'small block size leads to multiple ref blocks' '
 	)
 '
 
-test_expect_success PERL_TEST_HELPERS 'small block size fails with large reflog message' '
+test_expect_success 'small block size fails with large reflog message' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
 		cd repo &&
 		test_commit A &&
-		perl -e "print \"a\" x 500" >logmsg &&
+		test-tool genzeros 500 | tr "\000" "a" >logmsg &&
 		cat >expect <<-EOF &&
 		fatal: update_ref failed for ref ${SQ}refs/heads/logme${SQ}: reftable: transaction failure: entry too large
 		EOF
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index 4977998e205..e9973f74949 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -41,14 +41,14 @@ test_expect_success 'ls-tree piped to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'ls-tree output in wrong order given to mktree (1)' '
-	perl -e "print reverse <>" <top |
+test_expect_success 'ls-tree output in wrong order given to mktree (1)' '
+	sort -r <top |
 	git mktree >actual &&
 	test_cmp tree actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'ls-tree output in wrong order given to mktree (2)' '
-	perl -e "print reverse <>" <top.withsub |
+test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
+	sort -r <top.withsub |
 	git mktree >actual &&
 	test_cmp tree.withsub actual
 '
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 4794510d70d..2ae93d3c967 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1073,7 +1073,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	test_cmp msg out
 '
 
-test_expect_success PERL_TEST_HELPERS 'am works with multi-line in-body headers' '
+test_expect_success 'am works with multi-line in-body headers' '
 	FORTY="String that has a length of more than forty characters" &&
 	LONG="$FORTY $FORTY" &&
 	rm -fr .git/rebase-apply &&
@@ -1084,13 +1084,13 @@ test_expect_success PERL_TEST_HELPERS 'am works with multi-line in-body headers'
     Body test" --author="$LONG <long@example.com>" &&
 	git format-patch --stdout -1 >patch &&
 	# bump from, date, and subject down to in-body header
-	perl -lpe "
-		if (/^From:/) {
+	awk "
+		/^From:/{
 			print \"From: x <x\@example.com>\";
 			print \"Date: Sat, 1 Jan 2000 00:00:00 +0000\";
 			print \"Subject: x\n\";
-		}
-	" patch >msg &&
+		}; 1
+	" <patch >msg &&
 	git checkout HEAD^ &&
 	git am msg &&
 	# Ensure that the author and full message are present
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 143856c29f1..a5932b6a8be 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -7,17 +7,11 @@ test_description='git pack-object'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping pack-object tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	rm -f .git/index* &&
-	perl -e "print \"a\" x 4096;" >a &&
-	perl -e "print \"b\" x 4096;" >b &&
-	perl -e "print \"c\" x 4096;" >c &&
+	test-tool genzeros 4096 | tr "\000" "a" >a &&
+	test-tool genzeros 4096 | tr "\000" "b" >b &&
+	test-tool genzeros 4096 | tr "\000" "c" >c &&
 	test-tool genrandom "seed a" 2097152 >a_big &&
 	test-tool genrandom "seed b" 2097152 >b_big &&
 	git update-index --add a a_big b b_big c &&
@@ -146,7 +140,7 @@ test_expect_success 'pack-object <stdin parsing: --stdin-packs handles garbage'
 # usage: check_deltas <stderr_from_pack_objects> <cmp_op> <nr_deltas>
 # e.g.: check_deltas stderr -gt 0
 check_deltas() {
-	deltas=$(perl -lne '/delta (\d+)/ and print $1' "$1") &&
+	deltas=$(sed -n 's/Total [0-9][0-9]* (delta \([0-9][0-9]*\)).*/\1/p' "$1") &&
 	shift &&
 	if ! test "$deltas" "$@"
 	then
@@ -221,7 +215,7 @@ test_expect_success 'unpack with OFS_DELTA (core.fsyncmethod=batch)' '
 	check_unpack test-3-${packname_3} obj-list "$BATCH_CONFIGURATION"
 '
 
-test_expect_success 'compare delta flavors' '
+test_expect_success PERL_TEST_HELPERS 'compare delta flavors' '
 	perl -e '\''
 		defined($_ = -s $_) or die for @ARGV;
 		exit 1 if $ARGV[0] <= $ARGV[1];
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 627f8b4efdc..892aeb09e4b 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -153,7 +153,7 @@ test_midx_bitmap_cases () {
 		)
 	'
 
-	test_expect_success PERL_TEST_HELPERS 'pack.preferBitmapTips' '
+	test_expect_success 'pack.preferBitmapTips' '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
 		(
@@ -176,8 +176,8 @@ test_midx_bitmap_cases () {
 			comm -13 bitmaps commits >before &&
 			test_line_count = 1 before &&
 
-			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
-				<before | git update-ref --stdin &&
+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
+			git update-ref --stdin &&
 
 			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
 			rm -fr $midx &&
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 1059ff45fe4..56674db562f 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -6,12 +6,6 @@ GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping pseudo-merge bitmap tests; Perl not available'
-	test_done
-fi
-
 test_pseudo_merges () {
 	test-tool bitmap dump-pseudo-merges
 }
@@ -34,9 +28,8 @@ test_pseudo_merges_reused () {
 
 tag_everything () {
 	git rev-list --all --no-object-names >in &&
-	perl -lne '
-		print "create refs/tags/" . $. . " " . $1 if /([0-9a-f]+)/
-	' <in | git update-ref --stdin
+	sed 's|\(.*\)|create refs/tags/\1 \1|' in |
+	git update-ref --stdin
 }
 
 test_expect_success 'setup' '
@@ -108,7 +101,7 @@ test_expect_success 'stale bitmap traversal with pseudo-merges' '
 	test_cmp expect actual
 '
 
-test_expect_success 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
+test_expect_success PERL_TEST_HELPERS 'bitmapPseudoMerge.sampleRate adjusts commit selection rate' '
 	test_config bitmapPseudoMerge.test.pattern "refs/tags/" &&
 	test_config bitmapPseudoMerge.test.maxMerges 1 &&
 	test_config bitmapPseudoMerge.test.stableThreshold never &&
@@ -241,8 +234,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
 			test_commit_bulk 16 &&
 
 			git rev-list HEAD~16.. >in &&
-
-			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
+			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
 			git update-ref --stdin || return 1
 		done &&
 
@@ -258,7 +250,7 @@ test_expect_success 'pseudo-merge pattern with capture groups' '
 		do
 			test_pseudo_merge_commits $m >oids &&
 			grep -f oids refs |
-			perl -lne "print \$1 if /refs\/remotes\/([0-9]+)/" |
+			sed -n "s|refs/remotes/\([0-9][0-9]*\)/|\1|p" &&
 			sort -u || return 1
 		done >remotes &&
 
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 6a009fdcd71..4e82fd102e3 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -17,10 +17,10 @@ test_expect_success 'setup' '
 '
 
 extract_haves () {
-	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
+	depacketize | sed -n 's/^\([^ ][^ ]*\) \.have/\1/p'
 }
 
-test_expect_success PERL_TEST_HELPERS 'with core.alternateRefsCommand' '
+test_expect_success 'with core.alternateRefsCommand' '
 	write_script fork/alternate-refs <<-\EOF &&
 		git --git-dir="$1" for-each-ref \
 			--format="%(objectname)" \
@@ -33,7 +33,7 @@ test_expect_success PERL_TEST_HELPERS 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
-test_expect_success PERL_TEST_HELPERS 'with core.alternateRefsPrefixes' '
+test_expect_success 'with core.alternateRefsPrefixes' '
 	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
 	git rev-parse private/branch >expect &&
 	printf "0000" | git receive-pack fork >actual &&
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 200bf06ecb3..d4c28bae39e 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -220,7 +220,7 @@ test_expect_success 'refs/heads prefix' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'ignore very large set of prefixes' '
+test_expect_success 'ignore very large set of prefixes' '
 	# generate a large number of ref-prefixes that we expect
 	# to match nothing; the value here exceeds TOO_MANY_PREFIXES
 	# from ls-refs.c.
@@ -228,7 +228,10 @@ test_expect_success PERL_TEST_HELPERS 'ignore very large set of prefixes' '
 		echo command=ls-refs &&
 		echo object-format=$(test_oid algo) &&
 		echo 0001 &&
-		perl -le "print \"ref-prefix refs/heads/\$_\" for (1..65536)" &&
+		awk "{
+			for (i = 1; i <= 65536; i++)
+				print \"ref-prefix refs/heads/\", \$i
+		}" &&
 		echo 0000
 	} |
 	test-tool pkt-line pack >in &&
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 8074185742c..273196f52b5 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -26,17 +26,19 @@ test_expect_success 'set up --reverse example' '
 	commit five
 	'
 
-test_expect_success PERL_TEST_HELPERS '--reverse --parents --full-history combines correctly' '
-	git rev-list --parents --full-history main -- foo |
-		perl -e "print reverse <>" > expected &&
+reverse () {
+	awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
+}
+
+test_expect_success '--reverse --parents --full-history combines correctly' '
+	git rev-list --parents --full-history main -- foo | reverse >expected &&
 	git rev-list --reverse --parents --full-history main -- foo \
 		> actual &&
 	test_cmp expected actual
 	'
 
-test_expect_success PERL_TEST_HELPERS '--boundary does too' '
-	git rev-list --boundary --parents --full-history main ^root -- foo |
-		perl -e "print reverse <>" > expected &&
+test_expect_success '--boundary does too' '
+	git rev-list --boundary --parents --full-history main ^root -- foo | reverse >expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		main ^root -- foo > actual &&
 	test_cmp expected actual
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index 6a74be576a2..04c577dad69 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -4,12 +4,6 @@ test_description='basic tests of rev-list --disk-usage'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping rev-list disk usage tests; Perl not available'
-	test_done
-fi
-
 # we want a mix of reachable and unreachable, as well as
 # objects in the bitmapped pack and some outside of it
 test_expect_success 'set up repository' '
@@ -28,7 +22,7 @@ test_expect_success 'set up repository' '
 disk_usage_slow () {
 	git rev-list --no-object-names "$@" |
 	git cat-file --batch-check="%(objectsize:disk)" |
-	perl -lne '$total += $_; END { print $total}'
+	awk '{ i += $1 } END { print i }'
 }
 
 # check behavior with given rev-list options; note that
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 49aae183829..9717e825f0d 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -661,10 +661,10 @@ test_expect_success 'setup trace2' '
 	export GIT_TRACE2_BRIEF
 '
 
-test_expect_success PERL_TEST_HELPERS 'setup large log output' '
-	perl -e "
-		print \"this is a long commit message\" x 50000
-	" >commit-msg &&
+test_expect_success 'setup large log output' '
+	test-tool genzeros 50000 |
+	tr "\000" "a" |
+	sed "s/a/this is a long commit message/g" >commit-msg &&
 	git commit --allow-empty -F commit-msg
 '
 
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index b40199df231..7822947f028 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -107,7 +107,7 @@ test_expect_success 'set up abbrev tests' '
 		expect=$1 && shift &&
 		echo $sha1 | cut -c 1-$expect >expect &&
 		git blame "$@" abbrev.t >actual &&
-		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
+		sed -n "s/^[\^]\{0,1\}\([0-9a-f][0-9a-f]*\).*/\1/p" actual >actual.sha &&
 		test_cmp expect actual.sha
 	}
 '
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index f619b60f226..21c3af48bd0 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -29,8 +29,8 @@ test_expect_success 'shell allows interactive command' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'shell complains of overlong commands' '
-	perl -e "print \"a\" x 2**12 for (0..2**19)" |
+test_expect_success 'shell complains of overlong commands' '
+	test-tool genzeros | tr "\000" "a" |
 	test_must_fail git shell 2>err &&
 	grep "too long" err
 '

-- 
2.49.0.472.ge94155a9ec.dirty

