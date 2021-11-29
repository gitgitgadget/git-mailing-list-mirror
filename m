Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8783C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352388AbhK2TjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 14:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbhK2Tg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 14:36:57 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2371BC061A27
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:49 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 137so15073957wma.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 07:52:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RoWCfn6JRRfStiyXqXlPgVJh3RC3yln4UjwHY17j5yg=;
        b=ZmwGISjoMGZ/P2JnZg2u6NxGGXfY/C11mS2HxTxmrDahQ2fWp28G2wKyKrwZYiZmyQ
         DjR4/q45q7729VxfLZShvZbGAa5l61BW6rzYRZlGjqYiejBY//geEYvcBszR9nC8GnVd
         DUQPQNOoxtsJYC6vbZ+ATl8ZuJRzcP/Ap17ntrxE4VMKXZ1/HqPIiJ1Z/FAtq0Y6bkkj
         oRvKlvTLS/oQezm2QqFb6bNyvV7lty5Ws660+7kSihSZD9jYhlOlHxxctTnQa/qYjQxt
         owPTm7F7mokG0VS06thfB54OK375gcjRp5+xealzU0smP7akm28ONeU2ITXBHxh6aNi2
         n0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RoWCfn6JRRfStiyXqXlPgVJh3RC3yln4UjwHY17j5yg=;
        b=prDOzyUsu8W1/HWqVnmIPLSjoqmXLJmaRaoQwHyOmEl4ZUUgrxgvEihcmjfTahwIIM
         rEsbUF312qQ7vPvMzUFWqTfiydXjPOSbe81MtYR899Mn6iI/i7RD42CJeO4mIgVbUGnS
         +u9iTRZ5UzwkXtJKrssRskmGBQUscXLcObHi38NSvAzEBS1Jm5p2/RKOYb57y19OZ4t5
         idQwNCmzwXgMDYIE42H6d+Ze+AgLHU/O2nkOWEgHFIfZ5wdWMUx7GaOm0YFjadjPsc/C
         uF+cCGouUScaPMM1/pSoTC8WqwXhuKpFM5XLr2rz591b0PEOAHY/vIhgnQb4J62bmZcG
         A3vA==
X-Gm-Message-State: AOAM531aCDenWVyKQyySp+PvtUiSGUtIz3yHafm8Aml7urKQD1maVj5V
        rPaxVan5ckjQojAVQXtXOZXh1ngRPXc=
X-Google-Smtp-Source: ABdhPJymAyS3M/EAVfZpd4e6xKbxkDsr5NohDbpaebnRo9UCmCohvQW40i4qD6n6W2oq+/EJ48xing==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr37739364wmg.67.1638201167609;
        Mon, 29 Nov 2021 07:52:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d9sm13940578wre.52.2021.11.29.07.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 07:52:47 -0800 (PST)
Message-Id: <741a2c9ffaa8f3ea5e7fc7d3d44cf0ed3654cff2.1638201164.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
        <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 15:52:39 +0000
Subject: [PATCH v6 4/8] reset: expand test coverage for sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
pathspecs. New performance test cases exercise various execution paths for
`reset`.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  3 +
 t/t1092-sparse-checkout-compatibility.sh | 98 ++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 597626276fb..bfd332120c8 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -110,5 +110,8 @@ test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
 test_perf_on_all git checkout -f -
+test_perf_on_all git reset
+test_perf_on_all git reset --hard
+test_perf_on_all git reset -- does-not-exist
 
 test_done
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index cab6340a9d0..4125525ab86 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -475,6 +475,104 @@ test_expect_success 'checkout and reset (mixed)' '
 	run_on_sparse test_path_is_missing folder1
 '
 
+test_expect_success 'checkout and reset (merge)' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents a &&
+	test_all_match git reset --merge deepest &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_all ../edit-contents deep/a &&
+	test_all_match test_must_fail git reset --merge deepest
+'
+
+test_expect_success 'checkout and reset (keep)' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents a &&
+	test_all_match git reset --keep deepest &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_all ../edit-contents deep/a &&
+	test_all_match test_must_fail git reset --keep deepest
+'
+
+test_expect_success 'reset with pathspecs inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	test_all_match git checkout -b reset-test update-deep &&
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git reset base -- deep/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset base -- nonexistent-file &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset deepest -- deep &&
+	test_all_match git status --porcelain=v2
+'
+
+# Although the working tree differs between full and sparse checkouts after
+# reset, the state of the index is the same.
+test_expect_success 'reset with pathspecs outside sparse definition' '
+	init_repos &&
+	test_all_match git checkout -b reset-test base &&
+
+	test_sparse_match git reset update-folder1 -- folder1 &&
+	git -C full-checkout reset update-folder1 -- folder1 &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder1 &&
+
+	test_sparse_match git reset update-folder2 -- folder2/a &&
+	git -C full-checkout reset update-folder2 -- folder2/a &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder2/a
+'
+
+test_expect_success 'reset with wildcard pathspec' '
+	init_repos &&
+
+	test_all_match git reset update-deep -- deep\* &&
+	test_all_match git ls-files -s -- deep &&
+
+	test_all_match git reset deepest -- deep\*\*\* &&
+	test_all_match git ls-files -s -- deep &&
+
+	# The following `git reset`s result in updating the index on files with
+	# `skip-worktree` enabled. To avoid failing due to discrepencies in reported
+	# "modified" files, `test_sparse_match` reset is performed separately from
+	# "full-checkout" reset, then the index contents of all repos are verified.
+
+	test_sparse_match git reset update-folder1 -- \*/a &&
+	git -C full-checkout reset update-folder1 -- \*/a &&
+	test_all_match git ls-files -s -- deep/a folder1/a &&
+
+	test_sparse_match git reset update-folder2 -- folder\* &&
+	git -C full-checkout reset update-folder2 -- folder\* &&
+	test_all_match git ls-files -s -- folder10 folder1 folder2 &&
+
+	test_sparse_match git reset base -- folder1/\* &&
+	git -C full-checkout reset base -- folder1/\* &&
+	test_all_match git ls-files -s -- folder1
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

