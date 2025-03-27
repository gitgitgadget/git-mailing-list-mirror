Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322021147D
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071841; cv=none; b=nAdoQ3V8lCfvY1C0FHaRToWib+6+NGFFdDFELDxML/618k4inHiTIi9AddK1h+Ix7iYvooWUWea+DzuLyyJMiFp4rR88F3r9oWBx9BVfzYPHFDK270k+lBqIYf63gsJORFMDWYWfrIs2qjx+e8ztd+TwnvNperBsQlpnLkj/REs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071841; c=relaxed/simple;
	bh=gUke79LnyfZSRD0/MotwlvWqHdKVVyeB6FV+PZda8SU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cEINfDfFZUkui2OS8uR/WKt5muZBwrRLp+OWDPUkgEnps2gDTQpWAGGOcTlzjcKsSh8Q6SY4ESk2TbRxDhPK17WMO8c2X8MQvYmEkh3t7UbPkmgZoIxwUCeGEWe2RrQnZKD3rnYODTQ7m4HFc/fmtfj6o50UV8utFh1HYdJWcNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gesxe4BJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3QwSuUb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gesxe4BJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3QwSuUb"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 56623138390D;
	Thu, 27 Mar 2025 06:37:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 06:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071838;
	 x=1743158238; bh=93qlzESQW0KFRaOECxJolM6SZLQPFwZWiDuq8ZVQYGo=; b=
	Gesxe4BJswXQoxI7jgZKy9c5XLPJ/eQZbL/LBe5GGlg/EpkSR/5go43xAPXYEke5
	iQVzXFd8D+ZjCtRjkVcXII8/p2Wph6BiWmou8f0rhirKrg6Bcz4syMssM4XkV14U
	cn67wmtQUkDhRyu06lk8Ql2honneD2OiDN3OpU0/J0xLxGDEyOiAS8yU6lpMdaNN
	5Kj0VlxAREz1MPASvjC4a822wMea4QP2mMFKMEEK1PkaApi6WZ4PTxSND5aRzYeV
	0hsnJr4M6kxNkeTWrOMAsKuYtqiuhJVOfXoL8opP9hLz2o19EbcxDFrbshPWr0Fo
	RWsxTqaYaIdY2RizcxXm7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071838; x=
	1743158238; bh=93qlzESQW0KFRaOECxJolM6SZLQPFwZWiDuq8ZVQYGo=; b=b
	3QwSuUbCnGa52NiVpe7kZXZGI0DhoUUGzRfATfx4wQ7eRXUpbI2UgceHI9fh6wqt
	UB4A6W3U7/a+BObjUHMRwHAQLCKYC1CPDSCBpRH56ZnGS9CM6hqlbbSLxnCmivEg
	hCpzaPD5kGb+UXb6mt7iSeMoPEG+ZjRLZnIxtfs2LaqXj1Ndxlb8vt/JCnsYfXQn
	pfA5xzBPyyHQhC3xh5+8ph2kBWpH5KMiC7pfZb9Z5gt27dD2Qz8PmisvyLlSJdgm
	tcjYPdgLyi9D4V7WObu2+H1uza95ruMAcQXXDr4z0wWq2tYS/lqe6fGlonFWYhDX
	9xxPals519bBd1hIIWA8Q==
X-ME-Sender: <xms:XirlZyrMlohuSsbYXvStJx_QwMSPkkJTQ9-gnU3PUY0pqE6WRqsq9A>
    <xme:XirlZwrGUI7-vYW0VEqGg7Rclgw_5zeW9GWaHBvQMxoAkBwqWUBocLjOiI4ovASb7
    v2T1TF9S0N2SNbyDQ>
X-ME-Received: <xmr:XirlZ3Om6V6_QKm4wSzg48U6foRBIbpeI8ftNNplbQgBct547kMXlbL3jVSuvtyvaw7QLFXSgUpNIuTrqGJ7njKWvAuuWOJthhVg7KtybS4b_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:XirlZx6d7sWMiM9BxVFCjFvMOnCIPXhimBTyTb0_qhDAyaJfmWWjKg>
    <xmx:XirlZx6erb9WQZ_FTNV4MnfeQUyZud5wuv1at03_gP8FPj2RbTzaSw>
    <xmx:XirlZxjjieGYdAqXtZfYc-o0K2rfMzfu2HvAsD3sjG1iDW4phULcYA>
    <xmx:XirlZ77Seoa6_NAnRyCVcydHM55EEc_r4DWrsayDzZMkF1x3lpXtxQ>
    <xmx:XirlZ_Tje6q7hBcxzaEqwMS0VavJVGY-c434YGQ2ggaMIRoibWC7X6-e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a10770b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:09 +0100
Subject: [PATCH v3 11/20] t: refactor tests depending on Perl substitution
 operator
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-11-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

We have a bunch of tests that use Perl to perform substitution via the
"s/" operator. These usecases can be trivially replaced with sed(1).

Refactor the tests accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh                        | 10 ++--------
 t/t4029-diff-trailing-space.sh            |  5 +++--
 t/t4200-rerere.sh                         | 12 +++---------
 t/t5303-pack-corruption-resilience.sh     | 10 ++++++----
 t/t5310-pack-bitmaps.sh                   |  4 ++--
 t/t5534-push-signed.sh                    |  4 ++--
 t/t6011-rev-list-with-bad-commit.sh       | 20 +++++++++-----------
 t/t7416-submodule-dash-url.sh             |  9 ++-------
 t/t7508-status.sh                         |  4 ++--
 t/t8006-blame-textconv.sh                 |  8 +-------
 t/t9137-git-svn-dcommit-clobber-series.sh | 14 ++++++++------
 11 files changed, 40 insertions(+), 60 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 1aaa6bf5ae8..273d71411fe 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -5,12 +5,6 @@ test_description=check-ignore
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping ignores tests; Perl not available'
-	test_done
-fi
-
 init_vars () {
 	global_excludes="global-excludes"
 }
@@ -45,11 +39,11 @@ test_stderr () {
 }
 
 broken_c_unquote () {
-	"$PERL_PATH" -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
+	sed -e 's/^"//' -e 's/\\//' -e 's/"$//' "$1" | tr '\n' '\0'
 }
 
 broken_c_unquote_verbose () {
-	"$PERL_PATH" -pe 's/	"/	/; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
+	sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' "$1" | tr ':\t\n' '\000'
 }
 
 stderr_contains () {
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index a92a42990b1..90cdde88d8b 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -18,7 +18,7 @@ index 5f6a263..8cb8bae 100644
 EOF
 exit 1
 
-test_expect_success PERL_TEST_HELPERS "$test_description" '
+test_expect_success "$test_description" '
 	printf "\nx\n" > f &&
 	before=$(git hash-object f) &&
 	before=$(git rev-parse --short $before) &&
@@ -31,7 +31,8 @@ test_expect_success PERL_TEST_HELPERS "$test_description" '
 	git config --bool diff.suppressBlankEmpty true &&
 	git diff f > actual &&
 	test_cmp exp actual &&
-	perl -i.bak -p -e "s/^\$/ /" exp &&
+	sed "s/^\$/ /" exp >exp.munged &&
+	mv exp.munged exp &&
 	git config --bool diff.suppressBlankEmpty false &&
 	git diff f > actual &&
 	test_cmp exp actual &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 7fcca9ddad5..204325f4d53 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -27,12 +27,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping rerere tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	cat >a1 <<-\EOF &&
 	Some title
@@ -87,7 +81,7 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	test_might_fail git config --unset rerere.enabled &&
 	test_must_fail git merge first &&
 
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
 	! test -f $rr/postimage &&
@@ -100,7 +94,7 @@ test_expect_success 'rerere.enabled works, too' '
 	git reset --hard &&
 	test_must_fail git merge first &&
 
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep ^=======$ $rr/preimage
 '
@@ -110,7 +104,7 @@ test_expect_success 'set up rr-cache' '
 	git config rerere.enabled true &&
 	git reset --hard &&
 	test_must_fail git merge first &&
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1
 '
 
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index ac5e370e1e4..ab99c8b6850 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -99,11 +99,12 @@ test_expect_success '... and loose copy of first delta allows for partial recove
 	git cat-file blob $blob_3 > /dev/null
 '
 
-test_expect_success PERL_TEST_HELPERS 'create corruption in data of first object' '
+test_expect_success 'create corruption in data of first object' '
 	create_new_pack &&
 	git prune-packed &&
 	chmod +w ${pack}.pack &&
-	perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
+	sed "s/ base /abcdef/" ${pack}.pack >${pack}.pack.munged &&
+	mv ${pack}.pack.munged ${pack}.pack &&
 	test_must_fail git cat-file blob $blob_1 > /dev/null &&
 	test_must_fail git cat-file blob $blob_2 > /dev/null &&
 	test_must_fail git cat-file blob $blob_3 > /dev/null
@@ -156,11 +157,12 @@ test_expect_success '... and then a repack "clears" the corruption' '
 	git cat-file blob $blob_3 > /dev/null
 '
 
-test_expect_success PERL_TEST_HELPERS 'create corruption in data of first delta' '
+test_expect_success 'create corruption in data of first delta' '
 	create_new_pack &&
 	git prune-packed &&
 	chmod +w ${pack}.pack &&
-	perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+	sed "s/ delta1 /abcdefgh/" ${pack}.pack >${pack}.pack.munged &&
+	mv ${pack}.pack.munged ${pack}.pack &&
 	git cat-file blob $blob_1 > /dev/null &&
 	test_must_fail git cat-file blob $blob_2 > /dev/null &&
 	test_must_fail git cat-file blob $blob_3 > /dev/null
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 81987296235..a62b463eaf0 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -395,7 +395,7 @@ test_bitmap_cases () {
 		)
 	'
 
-	test_expect_success PERL_TEST_HELPERS 'pack.preferBitmapTips' '
+	test_expect_success 'pack.preferBitmapTips' '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
 		(
@@ -421,7 +421,7 @@ test_bitmap_cases () {
 
 			# mark the commits which did not receive bitmaps as preferred,
 			# and generate the bitmap again
-			perl -pe "s{^}{create refs/tags/include/$. }" <before |
+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
 				git update-ref --stdin &&
 			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 342d0423c92..2a782214ee1 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -177,7 +177,7 @@ test_expect_success GPGSSH 'ssh signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
-test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in signed push not allowed' '
+test_expect_success GPG 'inconsistent push options in signed push not allowed' '
 	# First, invoke receive-pack with dummy input to obtain its preamble.
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
@@ -205,7 +205,7 @@ test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in signed p
 	# Tweak the push output to make the push option outside the cert
 	# different, then replay it on a fresh dst, checking that ff is not
 	# deleted.
-	perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
+	sed "s/\([^ ]\)bar/\1baz/" push >push.tweak &&
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
 	git -C dst config receive.advertisepushoptions 1 &&
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index 6131c361094..b6f3344dbfb 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -4,12 +4,6 @@ test_description='git rev-list should notice bad commits'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping rev-list with bad commit tests; Perl not available'
-	test_done
-fi
-
 # Note:
 # - compression level is set to zero to make "corruptions" easier to perform
 # - reflog is disabled to avoid extra references which would twart the test
@@ -41,11 +35,15 @@ test_expect_success 'verify number of revisions' \
    first_commit=$(git rev-parse HEAD~3)
    '
 
-test_expect_success 'corrupt second commit object' \
-   '
-   perl -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
-   test_must_fail git fsck --full
-   '
+test_expect_success 'corrupt second commit object' '
+	for p in .git/objects/pack/*.pack
+	do
+		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
+		mv "$p.munged" "$p" ||
+		return 1
+	done &&
+	test_must_fail git fsck --full
+'
 
 test_expect_success 'rev-list should fail' '
 	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false rev-list --all > /dev/null
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 14069600a2f..3d944a00e0d 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -4,12 +4,6 @@ test_description='check handling of disallowed .gitmodule urls'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping submodule dash URL tests; Perl not available'
-	test_done
-fi
-
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
 '
@@ -39,7 +33,8 @@ test_expect_success 'fsck accepts protected dash' '
 '
 
 test_expect_success 'remove ./ protection from .gitmodules url' '
-	perl -i -pe "s{\./}{}" .gitmodules &&
+	sed "s|\./||" .gitmodules >.gitmodules.munged &&
+	mv .gitmodules.munged .gitmodules &&
 	git commit -am "drop protection"
 '
 
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 14c41b2cb7c..cdc1d6fcc78 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1064,9 +1064,9 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
 	test_cmp expect output
 '
 
-test_expect_success PERL_TEST_HELPERS 'status -z implies porcelain' '
+test_expect_success 'status -z implies porcelain' '
 	git status --porcelain |
-	perl -pe "s/\012/\000/g" >expect &&
+	tr "\012" "\000" >expect &&
 	git status -z >output &&
 	test_cmp expect output
 '
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 5cb16872081..db1e2afb2ca 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -4,12 +4,6 @@ test_description='git blame textconv support'
 
 . ./test-lib.sh
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping blame textconv tests; Perl not available'
-	test_done
-fi
-
 find_blame() {
 	sed -e 's/^[^(]*//'
 }
@@ -17,7 +11,7 @@ find_blame() {
 cat >helper <<'EOF'
 #!/bin/sh
 grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
-"$PERL_PATH" -p -e 's/^bin: /converted: /' "$1"
+sed 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
 
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index a9d38be997c..b57a362bb98 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -15,13 +15,13 @@ test_expect_success 'initialize repo' '
 	test -e file
 	'
 
-test_expect_success PERL_TEST_HELPERS '(supposedly) non-conflicting change from SVN' '
+test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"$(sed -n -e 58p < file)" = x58 &&
 	test x"$(sed -n -e 61p < file)" = x61 &&
 	svn_cmd co "$svnrepo" tmp &&
 	(cd tmp &&
-		perl -i.bak -p -e "s/^58$/5588/" file &&
-		perl -i.bak -p -e "s/^61$/6611/" file &&
+		sed -e "s/^58$/5588/" -e "s/^61$/6611/" file >file.munged &&
+		mv file.munged file &&
 		poke file &&
 		test x"$(sed -n -e 58p < file)" = x5588 &&
 		test x"$(sed -n -e 61p < file)" = x6611 &&
@@ -37,11 +37,13 @@ test_expect_success 'some unrelated changes to git' "
 	git commit -m bye-life life
 	"
 
-test_expect_success PERL_TEST_HELPERS 'change file but in unrelated area' "
+test_expect_success 'change file but in unrelated area' "
 	test x\"\$(sed -n -e 4p < file)\" = x4 &&
 	test x\"\$(sed -n -e 7p < file)\" = x7 &&
-	perl -i.bak -p -e 's/^4\$/4444/' file &&
-	perl -i.bak -p -e 's/^7\$/7777/' file &&
+	sed -e 's/^4\$/4444/' \
+	    -e 's/^7\$/7777/' \
+		file >file.munged &&
+	mv file.munged file &&
 	test x\"\$(sed -n -e 4p < file)\" = x4444 &&
 	test x\"\$(sed -n -e 7p < file)\" = x7777 &&
 	git commit -m '4 => 4444, 7 => 7777' file &&

-- 
2.49.0.472.ge94155a9ec.dirty

