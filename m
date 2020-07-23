Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB2C43445
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8BB020888
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yaPVVp2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgGWBKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:10:15 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40490 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387499AbgGWBKI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Jul 2020 21:10:08 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1E5FA61016
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1595466606;
        bh=zD+J+qC1vFfe+R7++k49opxxt0yeicK8qcr0J08iAeA=;
        h=From:To:Subject:Date:In-Reply-To:References:From:Reply-To:Subject:
         Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:
         References:Content-Type:Content-Disposition;
        b=yaPVVp2/NnVF1Qsnrf0SGnRDw0REe0q42bKjO8Dt7UJ51F05duKFBY+lCI+xZu8Tj
         eEyB4tddO15QoTnvOoTBPHcsL4hGvBFrpRezApzyEjo5RvVcdpoR3bJsDqLL6zdpet
         +NWHu+slsp7zf5ZWHOrGKxm+oJJw5vyNrrAVCVfFlV75O8Z4Vshvwz1niFVbQu5R/y
         +BVu/JP/vMedN3O1I2T1meQaQYmrZlIqfLHc1KRE0e4dv2KqjR1RykOFVLoc/4rUnx
         fS4tbA8xAGe5HyT/TpOkwNdFDBUy07YBdLdam04NqbLXF7/Z/p0Wn5RCBtuzDKSNTI
         N6q9YSAsiJ+oRUdv5S7ZU3T0p1vIVvlAWTZZnBB6R8+LalZi2+hk+cB2aYNhzdGdxf
         fLMU+QqbFx5sq6ePGM5hWcxCtkg0H2e5JGDV3WFx+WPqR3x1EqzB4JR8/lmu3z1OMV
         YzE5BV3v2UAB1xQRsdJBckjJmfpvQgTnlWbk06HcnFGLnEvs3/p
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH v3 39/39] t: remove test_oid_init in tests
Date:   Thu, 23 Jul 2020 01:09:43 +0000
Message-Id: <20200723010943.2329634-40-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.28.0.rc1.129.ge9626dbbb9f
In-Reply-To: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
References: <20200723010943.2329634-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that we call test_oid_init in the setup for all test scripts,
there's no point in calling it individually.  Remove all of the places
where we've done so to help keep tests tidy.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 t/lib-pack.sh                          | 3 ---
 t/lib-submodule-update.sh              | 1 -
 t/t0000-basic.sh                       | 4 ----
 t/t1006-cat-file.sh                    | 2 --
 t/t1050-large.sh                       | 1 -
 t/t1410-reflog.sh                      | 1 -
 t/t1450-fsck.sh                        | 1 -
 t/t1500-rev-parse.sh                   | 1 -
 t/t3305-notes-fanout.sh                | 1 -
 t/t3308-notes-merge.sh                 | 1 -
 t/t3404-rebase-interactive.sh          | 1 -
 t/t3600-rm.sh                          | 1 -
 t/t3800-mktag.sh                       | 1 -
 t/t4002-diff-basic.sh                  | 2 --
 t/t4027-diff-submodule.sh              | 1 -
 t/t4134-apply-submodule.sh             | 1 -
 t/t4200-rerere.sh                      | 1 -
 t/t4211-line-log.sh                    | 1 -
 t/t5300-pack-object.sh                 | 3 +--
 t/t5302-pack-index.sh                  | 1 -
 t/t5313-pack-bounds-checks.sh          | 1 -
 t/t5318-commit-graph.sh                | 3 +--
 t/t5319-multi-pack-index.sh            | 1 -
 t/t5324-split-commit-graph.sh          | 1 -
 t/t5504-fetch-receive-strict.sh        | 1 -
 t/t5530-upload-pack-error.sh           | 1 -
 t/t5562-http-backend-content-length.sh | 1 -
 t/t5702-protocol-v2.sh                 | 1 -
 t/t5703-upload-pack-ref-in-want.sh     | 1 -
 t/t6006-rev-list-format.sh             | 1 -
 t/t6301-for-each-ref-errors.sh         | 1 -
 t/t6501-freshen-objects.sh             | 4 ----
 t/t7003-filter-branch.sh               | 1 -
 t/t8002-blame.sh                       | 4 ----
 t/t8003-blame-corner-cases.sh          | 2 --
 t/t9301-fast-import-notes.sh           | 1 -
 t/t9350-fast-export.sh                 | 2 --
 37 files changed, 2 insertions(+), 54 deletions(-)

diff --git a/t/lib-pack.sh b/t/lib-pack.sh
index 0c799d53c6..bb8938ccbe 100644
--- a/t/lib-pack.sh
+++ b/t/lib-pack.sh
@@ -35,8 +35,6 @@ pack_header () {
 # have hardcoded some well-known objects. See the case statements below for the
 # complete list.
 pack_obj () {
-	test_oid_init
-
 	case "$1" in
 	# empty blob
 	$EMPTY_BLOB)
@@ -121,7 +119,6 @@ pack_obj () {
 
 # Compute and append pack trailer to "$1"
 pack_trailer () {
-	test_oid_init &&
 	test-tool $(test_oid algo) -b <"$1" >trailer.tmp &&
 	cat trailer.tmp >>"$1" &&
 	rm -f trailer.tmp
diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 07c822c8ff..87a759149f 100644
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -196,7 +196,6 @@ test_git_directory_exists () {
 # the submodule repo if it doesn't exist and configures the most problematic
 # settings for diff.ignoreSubmodules.
 prolog () {
-	test_oid_init &&
 	(test -d submodule_update_repo || create_lib_submodule_repo) &&
 	test_config_global diff.ignoreSubmodules all &&
 	test_config diff.ignoreSubmodules all
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 47d6b502c2..34c64c59f3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -891,10 +891,6 @@ test_expect_success 'test_atexit is run' "
 	test_path_is_missing also-clean-atexit
 "
 
-test_expect_success 'test_oid setup' '
-	test_oid_init
-'
-
 test_expect_success 'test_oid provides sane info by default' '
 	test_oid zero >actual &&
 	grep "^00*\$" actual &&
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 43c4be1e5e..2f501d2dc9 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -140,8 +140,6 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
 	test_cmp expect actual
 '
 
-test_oid_init
-
 tree_sha1=$(git write-tree)
 tree_size=$(($(test_oid rawsz) + 13))
 tree_pretty_content="100644 blob $hello_sha1	hello"
diff --git a/t/t1050-large.sh b/t/t1050-large.sh
index 6a56d1ca24..61e89a8071 100755
--- a/t/t1050-large.sh
+++ b/t/t1050-large.sh
@@ -12,7 +12,6 @@ file_size () {
 }
 
 test_expect_success setup '
-	test_oid_init &&
 	# clone does not allow us to pass core.bigfilethreshold to
 	# new repos, so set core.bigfilethreshold globally
 	git config --global core.bigfilethreshold 200k &&
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 76d9b744a6..730a43d9dd 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -54,7 +54,6 @@ check_dont_have () {
 }
 
 test_expect_success setup '
-	test_oid_init &&
 	mkdir -p A/B &&
 	echo rat >C &&
 	echo ox >A/D &&
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 344a2aad82..e81f1cbf0e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -9,7 +9,6 @@ test_description='git fsck random collection of tests
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_oid_init &&
 	git config gc.auto 0 &&
 	git config i18n.commitencoding ISO-8859-1 &&
 	test_commit A fileA one &&
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 603019b541..408b97d5af 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -59,7 +59,6 @@ test_rev_parse () {
 ROOT=$(pwd)
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	mkdir -p sub/dir work &&
 	cp -R .git repo.git
 '
diff --git a/t/t3305-notes-fanout.sh b/t/t3305-notes-fanout.sh
index d5a94b7174..94c1b02251 100755
--- a/t/t3305-notes-fanout.sh
+++ b/t/t3305-notes-fanout.sh
@@ -31,7 +31,6 @@ all_notes_have_fanout() {
 }
 
 test_expect_success 'tweak test environment' '
-	test_oid_init &&
 	git checkout -b nondeterminism &&
 	test_commit A &&
 	git checkout --orphan with_notes;
diff --git a/t/t3308-notes-merge.sh b/t/t3308-notes-merge.sh
index 790e292966..d69c84c640 100755
--- a/t/t3308-notes-merge.sh
+++ b/t/t3308-notes-merge.sh
@@ -22,7 +22,6 @@ test_expect_success setup '
 	# Copy notes to remote-notes
 	git fetch . refs/notes/*:refs/remote-notes/origin/* &&
 
-	test_oid_init &&
 	test_oid_cache <<-EOF
 	hash4a sha1:5e93d24084d32e1cb61f7070505b9d2530cca987
 	hash3a sha1:8366731eeee53787d2bdf8fc1eff7d94757e8da0
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 2fb2c581cb..9744e88760 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -30,7 +30,6 @@ Initial setup:
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	test_commit A file1 &&
 	test_commit B file1 &&
 	test_commit C file2 &&
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index f2c0168941..efec8d13b6 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -241,7 +241,6 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
-	test_oid_init &&
 	git reset -q --hard &&
 	test_when_finished "rm -f .git/index.lock && git reset -q --hard" &&
 	i=0 &&
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 64dcc5ec28..d696aa4e52 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -23,7 +23,6 @@ check_verify_failure () {
 # first create a commit, so we have a valid object/type
 # for the tag.
 test_expect_success 'setup' '
-	test_oid_init &&
 	echo Hello >A &&
 	git update-index --add A &&
 	git commit -m "Initial commit" &&
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index cbcdd10464..6a9f010197 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -10,8 +10,6 @@ test_description='Test diff raw-output.
 
 . "$TEST_DIRECTORY"/lib-read-tree-m-3way.sh
 
-test_oid_init
-
 test_oid_cache <<\EOF
 aa_1 sha1:ccba72ad3888a3520b39efcf780b9ee64167535d
 aa_1 sha256:9febfbf18197819b2735c45291f138525d2476d59470f98239647544586ba403
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index e29deaf4a5..d7145ccca4 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -6,7 +6,6 @@ test_description='difference in submodules'
 . "$TEST_DIRECTORY"/diff-lib.sh
 
 test_expect_success setup '
-	test_oid_init &&
 	test_tick &&
 	test_create_repo sub &&
 	(
diff --git a/t/t4134-apply-submodule.sh b/t/t4134-apply-submodule.sh
index 99ed4cc546..d1c16ba33c 100755
--- a/t/t4134-apply-submodule.sh
+++ b/t/t4134-apply-submodule.sh
@@ -8,7 +8,6 @@ test_description='git apply submodule tests'
 . ./test-lib.sh
 
 test_expect_success setup '
-	test_oid_init &&
 	cat > create-sm.patch <<EOF &&
 diff --git a/dir/sm b/dir/sm
 new file mode 160000
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 831d424c47..d94d25e4f0 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -25,7 +25,6 @@ test_description='git rerere
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	cat >a1 <<-\EOF &&
 	Some title
 	==========
diff --git a/t/t4211-line-log.sh b/t/t4211-line-log.sh
index e186c83250..2d1d7b5d19 100755
--- a/t/t4211-line-log.sh
+++ b/t/t4211-line-log.sh
@@ -4,7 +4,6 @@ test_description='test log -L'
 . ./test-lib.sh
 
 test_expect_success 'setup (import history)' '
-	test_oid_init &&
 	git fast-import < "$TEST_DIRECTORY"/t4211/history.export &&
 	git reset --hard
 '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 746cdb626e..cf9f91c941 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -12,8 +12,7 @@ TRASH=$(pwd)
 
 test_expect_success \
     'setup' \
-    'test_oid_init &&
-     rm -f .git/index* &&
+    'rm -f .git/index* &&
      perl -e "print \"a\" x 4096;" > a &&
      perl -e "print \"b\" x 4096;" > b &&
      perl -e "print \"c\" x 4096;" > c &&
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 8981c9b90e..119494bd64 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -7,7 +7,6 @@ test_description='pack index with 64-bit offsets and object CRC'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	rawsz=$(test_oid rawsz) &&
 	rm -rf .git &&
 	git init &&
diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index 2a4557efc2..535313e4dc 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -45,7 +45,6 @@ extended_table () {
 }
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	test_oid_cache <<-EOF
 	oid000 sha1:1485
 	oid000 sha256:4222
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 26f332d6a3..67f2663c7c 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -10,8 +10,7 @@ test_expect_success 'setup full repo' '
 	cd "$TRASH_DIRECTORY/full" &&
 	git init &&
 	git config core.commitGraph true &&
-	objdir=".git/objects" &&
-	test_oid_init
+	objdir=".git/objects"
 '
 
 test_expect_success POSIXPERM 'tweak umask for modebit tests' '
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 7214cab36c..7dfff0f8f4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -29,7 +29,6 @@ midx_read_expect () {
 }
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	test_oid_cache <<-EOF
 	idxoff sha1:2999
 	idxoff sha256:3739
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 269d0964a3..3a63639fbc 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -12,7 +12,6 @@ test_expect_success 'setup repo' '
 	git config gc.writeCommitGraph false &&
 	infodir=".git/objects/info" &&
 	graphdir="$infodir/commit-graphs" &&
-	test_oid_init &&
 	test_oid_cache <<-EOM
 	shallow sha1:1760
 	shallow sha256:2064
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index a32efe2b6c..1a16ac4c0d 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -4,7 +4,6 @@ test_description='fetch/receive strict mode'
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
-	test_oid_init &&
 	echo hello >greetings &&
 	git add greetings &&
 	git commit -m greetings &&
diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 4ce9a9f704..205a2631e7 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -14,7 +14,6 @@ corrupt_repo () {
 }
 
 test_expect_success 'setup and corrupt repository' '
-	test_oid_init &&
 	echo file >file &&
 	git add file &&
 	git rev-parse :file &&
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index c6ec625497..e5d3d15ba8 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -46,7 +46,6 @@ ssize_b100dots() {
 }
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	HTTP_CONTENT_ENCODING="identity" &&
 	export HTTP_CONTENT_ENCODING &&
 	git config http.receivepack true &&
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 7fc22171e7..5a60fbe3ed 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -13,7 +13,6 @@ start_git_daemon --export-all --enable=receive-pack
 daemon_parent=$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent
 
 test_expect_success 'create repo to be served by git-daemon' '
-	test_oid_init &&
 	git init "$daemon_parent" &&
 	test_commit -C "$daemon_parent" one
 '
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 748282f058..d9ecf0f4a9 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -43,7 +43,6 @@ write_command () {
 #             \ | /
 #               a
 test_expect_success 'setup repository' '
-	test_oid_init &&
 	test_commit a &&
 	git checkout -b o/foo &&
 	test_commit b &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 7e82e43a63..bc95da8a5f 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -32,7 +32,6 @@ changed_iso88591=$(echo "$changed" | iconv -f utf-8 -t $test_encoding)
 truncate_count=20
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	: >foo &&
 	git add foo &&
 	git config i18n.commitEncoding $test_encoding &&
diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
index d545a725a5..809854fc0c 100755
--- a/t/t6301-for-each-ref-errors.sh
+++ b/t/t6301-for-each-ref-errors.sh
@@ -7,7 +7,6 @@ test_description='for-each-ref errors for broken refs'
 ZEROS=$ZERO_OID
 
 test_expect_success setup '
-	test_oid_init &&
 	MISSING=$(test_oid deadbeef) &&
 	git commit --allow-empty -m "Initial" &&
 	git tag testtag &&
diff --git a/t/t6501-freshen-objects.sh b/t/t6501-freshen-objects.sh
index 7416ed5ffe..8a3bb4105b 100755
--- a/t/t6501-freshen-objects.sh
+++ b/t/t6501-freshen-objects.sh
@@ -45,10 +45,6 @@ maybe_repack () {
 	fi
 }
 
-test_expect_success 'setup' '
-	test_oid_init
-'
-
 for repack in '' true; do
 	title=${repack:+repack}
 	title=${title:-loose}
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index beeb2b855a..36477cb1f4 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -5,7 +5,6 @@ test_description='git filter-branch'
 . "$TEST_DIRECTORY/lib-gpg.sh"
 
 test_expect_success 'setup' '
-	test_oid_init &&
 	test_commit A &&
 	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
 	test_commit --notick B &&
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index 557c886559..aed4a923a3 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -6,10 +6,6 @@ test_description='git blame'
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
-test_expect_success 'setup' '
-	test_oid_init
-'
-
 test_expect_success 'blame untracked file in empty repo' '
 	>untracked &&
 	test_must_fail git blame untracked
diff --git a/t/t8003-blame-corner-cases.sh b/t/t8003-blame-corner-cases.sh
index ebe79aa4ea..b871dd4f86 100755
--- a/t/t8003-blame-corner-cases.sh
+++ b/t/t8003-blame-corner-cases.sh
@@ -6,8 +6,6 @@ test_description='git blame corner cases'
 pick_fc='s/^[0-9a-f^]* *\([^ ]*\) *(\([^ ]*\) .*/\1-\2/'
 
 test_expect_success setup '
-	test_oid_init &&
-
 	echo A A A A A >one &&
 	echo B B B B B >two &&
 	echo C C C C C >tres &&
diff --git a/t/t9301-fast-import-notes.sh b/t/t9301-fast-import-notes.sh
index 9d1aaac980..ff3338abc0 100755
--- a/t/t9301-fast-import-notes.sh
+++ b/t/t9301-fast-import-notes.sh
@@ -71,7 +71,6 @@ EOF
 INPUT_END
 
 test_expect_success 'set up master branch' '
-	test_oid_init &&
 	git fast-import <input &&
 	git whatchanged master
 '
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index ba79db6a17..210b9bc4b6 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -7,8 +7,6 @@ test_description='git fast-export'
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	test_oid_init &&
-
 	echo break it > file0 &&
 	git add file0 &&
 	test_tick &&
