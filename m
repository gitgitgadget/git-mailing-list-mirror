Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DAECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiHaQD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiHaQCv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:51 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4CCB6016
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:47 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e13so17977781wrm.1
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=xqcQOfyiDgT7nCN+ojM9zvzSM76LM5R6p1VuKM/vYIE=;
        b=Tl/FebpDsaNNbctb7fJE4TaG8KXPABE8U00WR9RAoM9XitlBzWIN/TfIhq7pLPEJ9s
         nZnpwyNPPkJ1/nRI/fEegd8OvHlsGEg24KbErchvsOMa2QE6gaePVah4DxFhkPSAV+UE
         BNj5mVJjZLDb+rg/Ys+FKwkiSQA/L78ocuhTjons12O17z6CDjvdDvs96ZgydobTha+b
         9gDdrmkhHw+Cqm5oSqpdRiZluOR6UTuSmo0PJ8mAH4ULXiAx1P0s05pj5DnD+iRHPR4Z
         4t524+xKT4AE1uHalHQdWhVY7file/0ALTtGJbvaxQv8qqddyELdb0y6ARnjqRTQzuON
         6dXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=xqcQOfyiDgT7nCN+ojM9zvzSM76LM5R6p1VuKM/vYIE=;
        b=bMrdLXtIBeW6C+AC5VBfFwEaOBBzJky1yk/cpjEq9d/YtGX1+b8aQQJmhCiWzhbDU9
         SO434hOvI5HYYlQjiL8FiEc44IQy/xQeiKSjJVgUK/IBCub5hg5fIKJxyBcuqDubiRAX
         Sf5rvrKRBXtPnRgPGZMRdTIXjbGYEOVAlx4z40X9EWDOOo+zyPj5mkGikcM2ThsR44Jv
         zgem7tLelXMPNYkDnmMLoF0CKm1udC9ognuAAjc452il5kZddjAdP+32bu3LIXaun0vS
         MBWEdYu3uGC0q8CjDmZLKu+uqN8JKQgeDfqkN9cT/3qOWEiGN2m4yYQoXg2GvOiuer5g
         ih3A==
X-Gm-Message-State: ACgBeo3P5bPE0wfl9RFH/xnSNrSeapT8Ra9PBPETsXI3fyWbWndF49Ww
        bqtE5QFf+UisvITQZ66tct91pMKxryw=
X-Google-Smtp-Source: AA6agR7e2H5/36aqHLSnivOUPlXykNYUkImIJ0v0RBg7xaRak2v3B+uW8cu5czNENSDJqOw0uhb9fA==
X-Received: by 2002:adf:dd0d:0:b0:225:8759:a35a with SMTP id a13-20020adfdd0d000000b002258759a35amr13097626wrm.615.1661961765914;
        Wed, 31 Aug 2022 09:02:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003a317ee3036sm2571988wmk.2.2022.08.31.09.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:45 -0700 (PDT)
Message-Id: <a3b7cb0a3bd1f56172db8420b9e80a26be1fda5d.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:22 +0000
Subject: [PATCH 5/8] scalar-clone: add test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a new test file ('t9211-scalar-clone.sh') to exercise the options and
behavior of the 'scalar clone' command.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t9211-scalar-clone.sh | 135 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100755 t/t9211-scalar-clone.sh

diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
new file mode 100755
index 00000000000..9fbbc4de2c0
--- /dev/null
+++ b/t/t9211-scalar-clone.sh
@@ -0,0 +1,135 @@
+#!/bin/sh
+
+test_description='test the `scalar clone` subcommand'
+
+. ./test-lib.sh
+
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
+export GIT_TEST_MAINT_SCHEDULER
+
+test_expect_success 'set up repository to clone' '
+	rm -rf .git &&
+	git init to-clone &&
+	(
+		cd to-clone &&
+		git branch -m base &&
+
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git switch -c parallel first &&
+		mkdir -p 1/2 &&
+		test_commit 1/2/3 &&
+
+		git switch base &&
+
+		# By default, permit
+		git config uploadpack.allowfilter true &&
+		git config uploadpack.allowanysha1inwant true
+	)
+'
+
+cleanup_clone () {
+	rm -rf "$1"
+}
+
+test_expect_success 'creates content in enlistment root' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone "file://$(pwd)/to-clone" cloned &&
+	ls -A cloned >enlistment-root &&
+	test_line_count = 1 enlistment-root &&
+	test_path_is_dir cloned/src &&
+	test_path_is_dir cloned/src/.git
+'
+
+test_expect_success 'with spaces' '
+	test_when_finished cleanup_clone "cloned with space" &&
+
+	scalar clone "file://$(pwd)/to-clone" "cloned with space" &&
+	test_path_is_dir "cloned with space" &&
+	test_path_is_dir "cloned with space/src" &&
+	test_path_is_dir "cloned with space/src/.git"
+'
+
+test_expect_success 'partial clone if supported by server' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone "file://$(pwd)/to-clone" cloned &&
+
+	(
+		cd cloned/src &&
+
+		# Two promisor packs: one for refs, the other for blobs
+		ls .git/objects/pack/pack-*.promisor >promisorlist &&
+		test_line_count = 2 promisorlist
+	)
+'
+
+test_expect_success 'fall back on full clone if partial unsupported' '
+	test_when_finished cleanup_clone cloned &&
+
+	test_config -C to-clone uploadpack.allowfilter false &&
+	test_config -C to-clone uploadpack.allowanysha1inwant false &&
+
+	scalar clone "file://$(pwd)/to-clone" cloned 2>err &&
+	grep "filtering not recognized by server, ignoring" err &&
+
+	(
+		cd cloned/src &&
+
+		# Still get a refs promisor file, but none for blobs
+		ls .git/objects/pack/pack-*.promisor >promisorlist &&
+		test_line_count = 1 promisorlist
+	)
+'
+
+test_expect_success 'initializes sparse-checkout by default' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone "file://$(pwd)/to-clone" cloned &&
+	(
+		cd cloned/src &&
+		test_cmp_config true core.sparseCheckout &&
+		test_cmp_config true core.sparseCheckoutCone
+	)
+'
+
+test_expect_success '--full-clone does not create sparse-checkout' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone --full-clone "file://$(pwd)/to-clone" cloned &&
+	(
+		cd cloned/src &&
+		test_cmp_config "" --default "" core.sparseCheckout &&
+		test_cmp_config "" --default "" core.sparseCheckoutCone
+	)
+'
+
+test_expect_success '--single-branch clones HEAD only' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone --single-branch "file://$(pwd)/to-clone" cloned &&
+	(
+		cd cloned/src &&
+		git for-each-ref refs/remotes/origin >out &&
+		test_line_count = 1 out &&
+		grep "refs/remotes/origin/base" out
+	)
+'
+
+test_expect_success '--no-single-branch clones all branches' '
+	test_when_finished cleanup_clone cloned &&
+
+	scalar clone --no-single-branch "file://$(pwd)/to-clone" cloned &&
+	(
+		cd cloned/src &&
+		git for-each-ref refs/remotes/origin >out &&
+		test_line_count = 2 out &&
+		grep "refs/remotes/origin/base" out &&
+		grep "refs/remotes/origin/parallel" out
+	)
+'
+
+test_done
-- 
gitgitgadget

