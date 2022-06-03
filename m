Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CA4C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 10:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243674AbiFCKXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243669AbiFCKX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 06:23:27 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74443B3E1
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 03:23:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t13so9801592wrg.9
        for <git@vger.kernel.org>; Fri, 03 Jun 2022 03:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=THEr+e4S14ymmfWHoely5LfPrPiC5p+LGvc/M8laIhU=;
        b=UKmteARD2Tb4t2p9kirkZqqAvkX/3zdvgi34iDSH9O5e7VXJ43NbrB9YtRz6zYxPoC
         7n8pABOb8E9R4mjiYwgAMKCZP4tm/TpDJusJ+Nk7Y+HlVRYvEDwB4n9FAQcFsG61kxBx
         jnRaI97ZN2seAVuXYY8tkIYhjzJMt30SXpTRUiDPfmvCgi3nkUcgiFw4+yaJAbWUCrzd
         /BCH//20vyTERfGrfXQnW0MSJCuiDMoCBPm+vJTrA2dk63rfp3TwW1JQ43kuwoNNNSjL
         r+XfmMKnHAnx/EuVTasUEGRnnCMiPecCyPo0LIl/hzCu3AeQESzEuvpp7Ys5hH/FYky8
         aCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=THEr+e4S14ymmfWHoely5LfPrPiC5p+LGvc/M8laIhU=;
        b=iJ7czNZe3z3PvzeicEMOXBi2pt8sYivXIbgQLV9T9/rW9tZV/Gg24+Nm9ylKCyvq0j
         FHmFjzv9pFXZZTwGCZCewKctHrf7/fSKI57lQvbXgmbBGGQnjMt1MCMIW0AkZa338edO
         3sPycpAQWxtyzAN/PEtL1N37+Ou4EnkB9oDFYShdUawVQaix5OGytmB5MUjgqNxT+Js7
         cuY1IHLMHDXflS878Bsc2W2FJ/DRF5Xq0QNqKzY4fSlATB2Zi9qTuacKIkyMrcy/JVAY
         CPc4+sah+IuYsYs8Di79JtD00AX93L7r2LqTgqb/1+onJiz94P8lsRl/2NGtV+NldFA5
         VoSQ==
X-Gm-Message-State: AOAM530ublUzc8vtRfYgr6kZ8BaaYYtZsd3pbzePCOcGA9xP7Y84wK+B
        QCkb6HZ5TWd6JcA7fUeAxF0Ht9iHFiTc4A==
X-Google-Smtp-Source: ABdhPJxPfDfJE4PL1++ng94QSMaSEreKfFl5GP90x6xMDFbQ1sC5l9TPe4mRdnfJej6WiR+gB3oEWA==
X-Received: by 2002:a5d:6085:0:b0:213:b9b5:d985 with SMTP id w5-20020a5d6085000000b00213b9b5d985mr3356482wrt.113.1654251796005;
        Fri, 03 Jun 2022 03:23:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003958af7d0c8sm7985082wmq.45.2022.06.03.03.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 03:23:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v2] ls-tree: test for the regression in 9c4d58ff2c3
Date:   Fri,  3 Jun 2022 12:23:10 +0200
Message-Id: <patch-v2-1.1-f2beb02dd29-20220603T102148Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1119.g5a713b43bd4
In-Reply-To: <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
References: <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the regression introduced in my 9c4d58ff2c3 (ls-tree:
split up "fast path" callbacks, 2022-03-23) and fixed in
350296cc789 (ls-tree: `-l` should not imply recursive listing,
2022-04-04), and test for the test of ls-tree option/mode combinations
to make sure we don't have other blind spots.

The setup for these tests can be shared with those added in the
1041d58b4d9 (Merge branch 'tl/ls-tree-oid-only', 2022-04-04) topic, so
let's create a new t/lib-t3100.sh to help them share data.

The existing tests in "t3104-ls-tree-format.sh" didn't deal with a
submodule, which they'll now encounter with as the
setup_basic_ls_tree_data() sets one up.

This extensive testing should give us confidence that there were no
further regressions in this area. The lack of testing was noted back
in [1], but unfortunately we didn't cover that blind-spot before
9c4d58ff2c3.

1. https://lore.kernel.org/git/211115.86o86lqe3c.gmgdl@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Fix a quoting issue in v1 that made CI fail, now passes:
https://github.com/avar/git/tree/avar/ls-tree-rewrite-regression-test-2

I usually check the CI before submitting, but I don't know how that
slipped through in this case, sorry, and thanks for the quick
review/diagnosis.

Range-diff against v1:
1:  0fdfec624eb ! 1:  f2beb02dd29 ls-tree: test for the regression in 9c4d58ff2c3
    @@ t/t3105-ls-tree-output.sh (new)
     +'
     +
     +test_ls_tree_format_mode_output () {
    -+	local opts=$1 &&
    ++	local opts="$1" &&
     +	shift &&
     +	cat >expect &&
     +

 t/lib-t3100.sh            |  10 ++
 t/t3104-ls-tree-format.sh |   5 +-
 t/t3105-ls-tree-output.sh | 192 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+), 3 deletions(-)
 create mode 100644 t/lib-t3100.sh
 create mode 100755 t/t3105-ls-tree-output.sh

diff --git a/t/lib-t3100.sh b/t/lib-t3100.sh
new file mode 100644
index 00000000000..eabb5fd8034
--- /dev/null
+++ b/t/lib-t3100.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+setup_basic_ls_tree_data () {
+	mkdir dir &&
+	test_commit dir/sub-file &&
+	test_commit top-file &&
+	git clone . submodule &&
+	git submodule add ./submodule &&
+	git commit -m"add submodule"
+}
diff --git a/t/t3104-ls-tree-format.sh b/t/t3104-ls-tree-format.sh
index 0769a933d69..383896667b6 100755
--- a/t/t3104-ls-tree-format.sh
+++ b/t/t3104-ls-tree-format.sh
@@ -4,6 +4,7 @@ test_description='ls-tree --format'
 
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
 
 test_expect_success 'ls-tree --format usage' '
 	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
@@ -12,9 +13,7 @@ test_expect_success 'ls-tree --format usage' '
 '
 
 test_expect_success 'setup' '
-	mkdir dir &&
-	test_commit dir/sub-file &&
-	test_commit top-file
+	setup_basic_ls_tree_data
 '
 
 test_ls_tree_format () {
diff --git a/t/t3105-ls-tree-output.sh b/t/t3105-ls-tree-output.sh
new file mode 100755
index 00000000000..ce2391e28be
--- /dev/null
+++ b/t/t3105-ls-tree-output.sh
@@ -0,0 +1,192 @@
+#!/bin/sh
+
+test_description='ls-tree output'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-t3100.sh
+
+test_expect_success 'ls-tree --format usage' '
+	test_expect_code 129 git ls-tree --format=fmt -l HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-only HEAD &&
+	test_expect_code 129 git ls-tree --format=fmt --name-status HEAD
+'
+
+test_expect_success 'setup' '
+	setup_basic_ls_tree_data
+'
+
+test_ls_tree_format_mode_output () {
+	local opts="$1" &&
+	shift &&
+	cat >expect &&
+
+	while test $# -gt 0
+	do
+		local mode="$1" &&
+		shift &&
+
+		test_expect_success "'ls-tree $opts${mode:+ $mode}' output" '
+			git ls-tree ${mode:+$mode }$opts HEAD >actual &&
+			test_cmp expect actual
+		'
+
+		case "$opts" in
+		--full-tree)
+			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir, fails)" '
+				test_must_fail git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../
+			'
+			;;
+		*)
+			test_expect_success "'ls-tree $opts${mode:+ $mode}' output (via subdir)" '
+				git -C dir ls-tree --full-name ${mode:+$mode }$opts HEAD -- ../ >actual &&
+				test_cmp expect actual
+			'
+			;;
+		esac
+	done
+}
+
+# test exact output of option (none, --long, ...) and mode (none and
+# -d, -r -t) and combinations
+test_expect_success 'setup: HEAD_* variables' '
+	HEAD_gitmodules=$(git rev-parse HEAD:.gitmodules) &&
+	HEAD_dir=$(git rev-parse HEAD:dir) &&
+	HEAD_top_file=$(git rev-parse HEAD:top-file.t) &&
+	HEAD_submodule=$(git rev-parse HEAD:submodule) &&
+	HEAD_dir_sub_file=$(git rev-parse HEAD:dir/sub-file.t)
+'
+## opt =
+test_ls_tree_format_mode_output "" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+## opt = --long
+test_ls_tree_format_mode_output "--long" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules      61	.gitmodules
+	040000 tree $HEAD_dir       -	dir
+	160000 commit $HEAD_submodule       -	submodule
+	100644 blob $HEAD_top_file       9	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--long" "-d" <<-EOF
+	040000 tree $HEAD_dir       -	dir
+	160000 commit $HEAD_submodule       -	submodule
+	EOF
+test_ls_tree_format_mode_output "--long" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules      61	.gitmodules
+	100644 blob $HEAD_dir_sub_file      13	dir/sub-file.t
+	160000 commit $HEAD_submodule       -	submodule
+	100644 blob $HEAD_top_file       9	top-file.t
+	EOF
+## opt = --name-only
+test_ls_tree_format_mode_output "--name-only" "" "-t" <<-EOF
+	.gitmodules
+	dir
+	submodule
+	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--name-only" "-d" <<-EOF
+	dir
+	submodule
+	EOF
+test_ls_tree_format_mode_output "--name-only" "-r" <<-EOF
+	.gitmodules
+	dir/sub-file.t
+	submodule
+	top-file.t
+	EOF
+## opt = --object-only
+test_ls_tree_format_mode_output "--object-only" "" "-t" <<-EOF
+	$HEAD_gitmodules
+	$HEAD_dir
+	$HEAD_submodule
+	$HEAD_top_file
+	EOF
+test_ls_tree_format_mode_output "--object-only" "-d" <<-EOF
+	$HEAD_dir
+	$HEAD_submodule
+	EOF
+test_ls_tree_format_mode_output "--object-only" "-r" <<-EOF
+	$HEAD_gitmodules
+	$HEAD_dir_sub_file
+	$HEAD_submodule
+	$HEAD_top_file
+	EOF
+## opt = --object-only --abbrev
+test_expect_success 'setup: HEAD_short_* variables' '
+	HEAD_short_gitmodules=$(git rev-parse --short HEAD:.gitmodules) &&
+	HEAD_short_dir=$(git rev-parse --short HEAD:dir) &&
+	HEAD_short_top_file=$(git rev-parse --short HEAD:top-file.t) &&
+	HEAD_short_submodule=$(git rev-parse --short HEAD:submodule) &&
+	HEAD_short_dir_sub_file=$(git rev-parse --short HEAD:dir/sub-file.t)
+'
+test_ls_tree_format_mode_output "--object-only --abbrev" "" "-t" <<-EOF
+	$HEAD_short_gitmodules
+	$HEAD_short_dir
+	$HEAD_short_submodule
+	$HEAD_short_top_file
+	EOF
+test_ls_tree_format_mode_output "--object-only --abbrev" "-d" <<-EOF
+	$HEAD_short_dir
+	$HEAD_short_submodule
+	EOF
+test_ls_tree_format_mode_output "--object-only --abbrev" "-r" <<-EOF
+	$HEAD_short_gitmodules
+	$HEAD_short_dir_sub_file
+	$HEAD_short_submodule
+	$HEAD_short_top_file
+	EOF
+## opt = --full-name
+test_ls_tree_format_mode_output "--full-name" "" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-name" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+## opt = --full-tree
+test_ls_tree_format_mode_output "--full-tree" "" "-t" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+test_ls_tree_format_mode_output "--full-tree" "-d" <<-EOF
+	040000 tree $HEAD_dir	dir
+	160000 commit $HEAD_submodule	submodule
+	EOF
+test_ls_tree_format_mode_output "--full-tree" "-r" <<-EOF
+	100644 blob $HEAD_gitmodules	.gitmodules
+	100644 blob $HEAD_dir_sub_file	dir/sub-file.t
+	160000 commit $HEAD_submodule	submodule
+	100644 blob $HEAD_top_file	top-file.t
+	EOF
+
+test_done
-- 
2.36.1.1119.g5a713b43bd4

