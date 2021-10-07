Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF76DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9783E61058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbhJGVRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhJGVRi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C21C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i12so10489890wrb.7
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sv612smGvd4dq4LynrPLQSKIFJ3a45Vznz69O66lrI4=;
        b=lhAk9RFblt4jFDWg0yO+Vf6mltnx1yxGpKAqlY3+TwmtLQTXWzQBQyTIjnOZAsFFqO
         mIuAy1jExOcsCZ8m5UOkW0mMGRA1OlJyVtL9NlmB4pm67y6ulIu1/dViXOT1nhw7BZBn
         reG1et/C1+pwDGTTZ/cE8zA7Q36izmNJvASCXs8lIOnRfHj2NXwtXTxw8n+OmGP9ZM0p
         hmluJgfeNZRRlm+yeFiO7dWaK57pGlbRxdVmOY222s4yOr271xL7a/5IY0t1/wk4zqbY
         VSS+loNFqUd9oXFr6ppfuxKsMdB2NqbBbdRaJCX1EeRpKUhEqSRTO+Z1a/qWRRjuaahV
         6OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sv612smGvd4dq4LynrPLQSKIFJ3a45Vznz69O66lrI4=;
        b=DmiPdU2kzQG9UpS90IqRgJD1fbtW2HNoWcq41aHkE67V0833qPX4/CEb88YsI3vFS5
         rH9LCSOROC+M9NultHDTmsE3pjd9Jf1DgjpexyuJ1uMmdgN3a9XGYxTZyjj1LX3uD/jd
         KTf7aWNG6U6yv6cKTrhRZVbvZ1ZK7k1rRaoMr+69AXma6oeV6s2/5EqjRBC+K2ve19Y8
         fkbeiepXgPEA5TiYHuA6OWS7sOw7jH5wonklaybJCw9Hh7B8LsabeqywFPa/tCnpCFPR
         M673n8bcIvkUeIgzex1mk5XkjSiLTuW7V4NN+MrtG+IXb3mpK0MHPPtQwU5jHqKuzTtA
         GAbg==
X-Gm-Message-State: AOAM530WupVqw/mZgCJkjfs/wkW2MJByLm4qBbrTJNZenq9x2B+N+OEp
        NTd5XaDRSrg595jnjTLV/hk8qHTX5EA=
X-Google-Smtp-Source: ABdhPJwBzIVrApOuBP4qF4IKJ0P/74m8t0VhysIZdJtqftsXgQA/Cqii1JYinbgAVateyMYUj9MH8A==
X-Received: by 2002:adf:a347:: with SMTP id d7mr8465986wrb.139.1633641343341;
        Thu, 07 Oct 2021 14:15:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i92sm436305wri.28.2021.10.07.14.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:43 -0700 (PDT)
Message-Id: <7f21cf53e9d71de8c6351ae0f21ed531b7d13c42.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:34 +0000
Subject: [PATCH v3 4/8] reset: expand test coverage for sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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
 t/t1092-sparse-checkout-compatibility.sh | 84 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

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
index 4aa4fef7b4f..875cdcb0495 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -472,6 +472,90 @@ test_expect_success 'checkout and reset (mixed)' '
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
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset base -- \*/a &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder1/a &&
+
+	test_all_match git reset base -- folder\* &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git rev-parse HEAD:folder2
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

