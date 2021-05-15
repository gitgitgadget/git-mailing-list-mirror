Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4B8C43460
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE82613CE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbhEOPaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 11:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbhEOPaD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 11:30:03 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF60C061756
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id f6-20020a1c1f060000b0290175ca89f698so363484wmf.5
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vMG5CNA8YIyFhcuQQxL390sVVqrk+jyktA5t48mBxkY=;
        b=cO7OzeKJ3dKFzlL5JXq9+4QKh3IAuQyamOYzYqifptD2aXijiYllwHQlm9sIFxYW40
         bQQMEOyJzvX6CCc19gy+nIiK73ggFL2jYajmXEeWEQsuUNHjmuev6JNdbjpEvuemIiRt
         tTNRnOBg5jYPmAy1RsJSRTNNVJIb6sHDBV9/Nz8uq5Dak8cC6VzVmT1j1twfHj0VqxXP
         7sNPEzZ83hVOQscEvvUCogq/lzeseVgtQOUC3QydBx88lM+i9d/iA8omf6ouzOUwHrhq
         mF8Ge98V5bhasRkrG/prFKMV6EX2aeXDvBsNFVbfV0C22kP+0K2xPZsSK/k3Te/dr8s0
         fJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vMG5CNA8YIyFhcuQQxL390sVVqrk+jyktA5t48mBxkY=;
        b=nl1FEMHnfEE7WVH4nDN1hv/Ntvz7L5meDRWwHc/uzTSdAZmrm+XCNOaKMbgocM7I7E
         iat9rdaQAViNZPqmxFqLaM4okgvfCo1vTG8jlRVfTmDz79bg0dWWSdQ7Rk7tMB0gcfWZ
         STV0zyDNGqwZxlUpTgR1DpSiA8nxgkoUd0EV7ktm/8NRET/yrF3Wdp/v0kwBNqqnYgKQ
         ycmI5dxjaupLDSj30k4SehFoYLER0BTeRrgKS4/Yw2CsTL0ANZakyM2aAlR7D7s4mJft
         fEUiUGvArLKzlhKYqoqGkAvb8ABdKeT9rd+rTqyYA8jFNDIJj++wQhrnWz/dHhIzPlN8
         j/hQ==
X-Gm-Message-State: AOAM532c1avtY0WEhPffwYzRD1LVQkzz3B2ETqFrqfdYZcXusJpS+qLE
        uLRiQozyTulV3Gr2KQPm/tM=
X-Google-Smtp-Source: ABdhPJwqfQzaboyZK97kI5cBvarLhZeQ1wXjudbQff8s/ysvWwav+lmHdWGqK4J4SJSszZFbWlP27w==
X-Received: by 2002:a1c:f303:: with SMTP id q3mr14944085wmq.9.1621092528314;
        Sat, 15 May 2021 08:28:48 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001504451e90ab6b33.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1504:451e:90ab:6b33])
        by smtp.gmail.com with ESMTPSA id v18sm11617271wro.18.2021.05.15.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:28:47 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/2] t: use test_config whenever possible
Date:   Sat, 15 May 2021 17:27:21 +0200
Message-Id: <20210515152721.885728-3-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
In-Reply-To: <20210515152721.885728-1-firminmartin24@gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210515152721.885728-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace patterns of the form
1.
        git config <config-option> <value> &&
        ...
        git config --unset <config-option> &&
2.
        test_when_finished "git config --unset <config-option>" &&
        git config <config-option> <value> &&
        ...

to the concise

        test_config <config-option> <value>

In t5526, two tests have been further simplified as the output file is
written before "git config --global --unset".

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 t/t3200-branch.sh                |  9 +++------
 t/t3900-i18n-commit.sh           |  3 +--
 t/t4027-diff-submodule.sh        |  3 +--
 t/t4041-diff-submodule-option.sh |  3 +--
 t/t4205-log-pretty-formats.sh    |  8 +++-----
 t/t5505-remote.sh                |  3 +--
 t/t5526-fetch-submodules.sh      | 16 ++++------------
 t/t6006-rev-list-format.sh       |  5 ++---
 t/t7401-submodule-summary.sh     |  3 +--
 t/t7610-mergetool.sh             |  2 +-
 t/t7900-maintenance.sh           |  9 +++------
 11 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cc4b10236e..0b0119bbe2 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -365,11 +365,9 @@ EOF
 '
 
 test_expect_success 'git branch with column.*' '
-	git config column.ui column &&
-	git config column.branch "dense" &&
+	test_config column.ui column &&
+	test_config column.branch "dense" &&
 	COLUMNS=80 git branch >actual &&
-	git config --unset column.branch &&
-	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c   bam   foo   l   * main   n     o/p   r
   abc     bar   j/k   m/m   mb     o/o   q     topic
@@ -382,9 +380,8 @@ test_expect_success 'git branch --column -v should fail' '
 '
 
 test_expect_success 'git branch -v with column.ui ignored' '
-	git config column.ui column &&
+	test_config column.ui column &&
 	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
-	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
   abc
diff --git a/t/t3900-i18n-commit.sh b/t/t3900-i18n-commit.sh
index bfab245eb3..c16c0f7fba 100755
--- a/t/t3900-i18n-commit.sh
+++ b/t/t3900-i18n-commit.sh
@@ -179,7 +179,7 @@ test_commit_autosquash_flags () {
 	H=$1
 	flag=$2
 	test_expect_success "commit --$flag with $H encoding" '
-		git config i18n.commitencoding $H &&
+		test_config i18n.commitencoding $H &&
 		git checkout -b $H-$flag C0 &&
 		echo $H >>F &&
 		git commit -a -F "$TEST_DIRECTORY"/t3900/$H.txt &&
@@ -193,7 +193,6 @@ test_commit_autosquash_flags () {
 		E=$(git cat-file commit '$H-$flag' |
 			sed -ne "s/^encoding //p") &&
 		test "z$E" = "z$H" &&
-		git config --unset-all i18n.commitencoding &&
 		git rebase --autosquash -i HEAD^^^ &&
 		git log --oneline >actual &&
 		test_line_count = 3 actual
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index 94ef77e1df..a6eb2416ed 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -123,7 +123,7 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)'
 '
 
 test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match) [.gitmodules]' '
-	git config diff.ignoreSubmodules dirty &&
+	test_config diff.ignoreSubmodules dirty &&
 	git diff HEAD >actual &&
 	test_must_be_empty actual &&
 	git config --add -f .gitmodules submodule.subname.ignore none &&
@@ -152,7 +152,6 @@ test_expect_success 'git diff HEAD with dirty submodule (work tree, refs match)
 	test_cmp expect.body actual.body &&
 	git config --remove-section submodule.subname &&
 	git config --remove-section -f .gitmodules submodule.subname &&
-	git config --unset diff.ignoreSubmodules &&
 	rm .gitmodules
 '
 
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index 0c1502d4b0..782424c2d0 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -58,13 +58,12 @@ test_expect_success 'added submodule' '
 '
 
 test_expect_success 'added submodule, set diff.submodule' '
-	git config diff.submodule log &&
+	test_config diff.submodule log &&
 	git add sm1 &&
 	git diff --cached >actual &&
 	cat >expected <<-EOF &&
 	Submodule sm1 0000000...$head1 (new submodule)
 	EOF
-	git config --unset diff.submodule &&
 	test_cmp expected actual
 '
 
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 8272d94ce6..fbe8ae5378 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -30,12 +30,11 @@ test_expect_success 'set up basic repos' '
 	>bar &&
 	git add foo &&
 	test_tick &&
-	git config i18n.commitEncoding $test_encoding &&
+	test_config i18n.commitEncoding $test_encoding &&
 	commit_msg $test_encoding | git commit -F - &&
 	git add bar &&
 	test_tick &&
-	git commit -m "add bar" &&
-	git config --unset i18n.commitEncoding
+	git commit -m "add bar"
 '
 
 test_expect_success 'alias builtin format' '
@@ -60,10 +59,9 @@ test_expect_success 'alias user-defined format' '
 '
 
 test_expect_success 'alias user-defined tformat with %s (ISO8859-1 encoding)' '
-	git config i18n.logOutputEncoding $test_encoding &&
+	test_config i18n.logOutputEncoding $test_encoding &&
 	git log --oneline >expected-s &&
 	git log --pretty="tformat:%h %s" >actual-s &&
-	git config --unset i18n.logOutputEncoding &&
 	test_cmp expected-s actual-s
 '
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c7b392794b..bed8e6633a 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -836,8 +836,7 @@ test_expect_success 'rename a remote with name prefix of other remote' '
 
 test_expect_success 'rename succeeds with existing remote.<target>.prune' '
 	git clone one four.four &&
-	test_when_finished git config --global --unset remote.upstream.prune &&
-	git config --global remote.upstream.prune true &&
+	test_config_global remote.upstream.prune true &&
 	git -C four.four remote rename origin upstream
 '
 
diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index ed11569d8d..ff18263171 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -418,7 +418,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	git config --global fetch.recurseSubmodules false &&
+	test_config_global fetch.recurseSubmodules false &&
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -429,11 +429,7 @@ test_expect_success "'fetch.recurseSubmodules=on-demand' overrides global config
 	(
 		cd downstream &&
 		git config fetch.recurseSubmodules on-demand &&
-		git fetch >../actual.out 2>../actual.err
-	) &&
-	git config --global --unset fetch.recurseSubmodules &&
-	(
-		cd downstream &&
+		git fetch >../actual.out 2>../actual.err &&
 		git config --unset fetch.recurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
@@ -446,7 +442,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 		git fetch --recurse-submodules
 	) &&
 	add_upstream_commit &&
-	git config fetch.recurseSubmodules false &&
+	test_config fetch.recurseSubmodules false &&
 	head1=$(git rev-parse --short HEAD) &&
 	git add submodule &&
 	git commit -m "new submodule" &&
@@ -457,11 +453,7 @@ test_expect_success "'submodule.<sub>.fetchRecurseSubmodules=on-demand' override
 	(
 		cd downstream &&
 		git config submodule.submodule.fetchRecurseSubmodules on-demand &&
-		git fetch >../actual.out 2>../actual.err
-	) &&
-	git config --unset fetch.recurseSubmodules &&
-	(
-		cd downstream &&
+		git fetch >../actual.out 2>../actual.err &&
 		git config --unset submodule.submodule.fetchRecurseSubmodules
 	) &&
 	test_must_be_empty actual.out &&
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 35a2f62392..9ba06ec5ae 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -37,7 +37,7 @@ truncate_count=20
 test_expect_success 'setup' '
 	: >foo &&
 	git add foo &&
-	git config i18n.commitEncoding $test_encoding &&
+	test_config i18n.commitEncoding $test_encoding &&
 	echo "$added_iso88591" | git commit -F - &&
 	head1=$(git rev-parse --verify HEAD) &&
 	head1_short=$(git rev-parse --verify --short $head1) &&
@@ -48,8 +48,7 @@ test_expect_success 'setup' '
 	head2=$(git rev-parse --verify HEAD) &&
 	head2_short=$(git rev-parse --verify --short $head2) &&
 	tree2=$(git rev-parse --verify HEAD:) &&
-	tree2_short=$(git rev-parse --verify --short $tree2) &&
-	git config --unset i18n.commitEncoding
+	tree2_short=$(git rev-parse --verify --short $tree2)
 '
 
 # usage: test_format name format_string [failure] <expected_output
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9c3cc4cf40..4963f3290d 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -116,7 +116,7 @@ test_expect_success 'no ignore=all setting has any effect' "
 	git config -f .gitmodules submodule.sm1.path sm1 &&
 	git config -f .gitmodules submodule.sm1.ignore all &&
 	git config submodule.sm1.ignore all &&
-	git config diff.ignoreSubmodules all &&
+	test_config diff.ignoreSubmodules all &&
 	git submodule summary >actual &&
 	cat >expected <<-EOF &&
 	* sm1 $head1...$head2 (1):
@@ -124,7 +124,6 @@ test_expect_success 'no ignore=all setting has any effect' "
 
 	EOF
 	test_cmp expected actual &&
-	git config --unset diff.ignoreSubmodules &&
 	git config --remove-section submodule.sm1 &&
 	git config -f .gitmodules --remove-section submodule.sm1
 "
diff --git a/t/t7610-mergetool.sh b/t/t7610-mergetool.sh
index 8cc64729ad..2ff00f6c46 100755
--- a/t/t7610-mergetool.sh
+++ b/t/t7610-mergetool.sh
@@ -803,7 +803,7 @@ test_expect_success 'diff.orderFile configuration is honored' '
 test_expect_success 'mergetool -Oorder-file is honored' '
 	test_when_finished "git reset --hard" &&
 	git checkout -b test$test_count order-file-side2 &&
-	test_config diff.orderFile order-file &&
+	git config diff.orderFile order-file &&
 	test_config mergetool.myecho.cmd "echo \"\$LOCAL\"" &&
 	test_config mergetool.myecho.trustExitCode true &&
 	echo b >order-file &&
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index b93ae014ee..7f12619feb 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -155,8 +155,7 @@ test_expect_success 'prefetch multiple remotes' '
 	git log --oneline --decorate --all >log &&
 	! grep "prefetch" log &&
 
-	test_when_finished git config --unset remote.remote1.skipFetchAll &&
-	git config remote.remote1.skipFetchAll true &&
+	test_config remote.remote1.skipFetchAll true &&
 	GIT_TRACE2_EVENT="$(pwd)/skip-remote1.txt" git maintenance run --task=prefetch 2>/dev/null &&
 	test_subcommand ! git fetch remote1 $fetchargs <skip-remote1.txt &&
 	test_subcommand git fetch remote2 $fetchargs <skip-remote1.txt
@@ -407,8 +406,7 @@ test_expect_success 'maintenance.strategy inheritance' '
 		git config --unset maintenance.$task.schedule || return 1
 	done &&
 
-	test_when_finished git config --unset maintenance.strategy &&
-	git config maintenance.strategy incremental &&
+	test_config maintenance.strategy incremental &&
 
 	GIT_TRACE2_EVENT="$(pwd)/incremental-hourly.txt" \
 		git maintenance run --schedule=hourly --quiet &&
@@ -465,8 +463,7 @@ test_expect_success 'maintenance.strategy inheritance' '
 '
 
 test_expect_success 'register and unregister' '
-	test_when_finished git config --global --unset-all maintenance.repo &&
-	git config --global --add maintenance.repo /existing1 &&
+	test_config_global maintenance.repo /existing1 &&
 	git config --global --add maintenance.repo /existing2 &&
 	git config --global --get-all maintenance.repo >before &&
 
-- 
2.31.1.443.g67a420f573

