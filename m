Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F297C433F5
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1622661503
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbhJENWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbhJENWw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:52 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE9C061764
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:01 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p21so6636555wmq.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MMsbOv/bbgTRd4gzYHz/ThjOh6qlXknsOXHwR0Dnvbk=;
        b=bT2BwGhwMXaIZbBqw08LpTOEbEFVWnpPS/Lfm8Yje2ejR4zTI//eL3RhFRM6d5WHcZ
         SqZtZ2l6copUZHX28uPblfbgzrmiyTuvaPVcv/gpi3MZRVCapBoUkDt+u5E6hHFLKBvf
         wea6twoYZVPQvCsAVjeZ0gForwrGX/FeaB0w5xyUVvyNE4gq0SeNHapiKx0qiyaptBZf
         BL3JMSMAB36ymhosw3/rzx8x/efz/uDZg8LW8jKEFK0fq7wd5i73oBzSHejrnL7AANg4
         w2EYW40FuJtfoRkGNukWcjU6N52iYN1RrIP4qONgz7dyh+0DqB9hGZY2ju8PnLRpXTQE
         HiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MMsbOv/bbgTRd4gzYHz/ThjOh6qlXknsOXHwR0Dnvbk=;
        b=LzxrwVlwuOYfu8nuNGsnmAu+Vi4dOnfcHVTwYr/MxF1+/m/aAz+n+ahI4Jsgp2t2cc
         a1zzCy2DcNPvclfwA6DVWXCDdoAg6tj6AOvtWfcAKm1EZvXGkaVc3tvAmv3oAcmvHw43
         DRrxraDCmHBw5YTne4ogIpUrWQ9V3N2jCXcMkNcx9eI7MelxslJdsq3Szi+eGcL/2fUC
         /ZFlbyTkunM9XxDBmK4tkFWa9lNtiD4RFZKla9WxAVByA86LK/cePbruKF+Nm1sCsoLb
         3PcR2/1NIawct61y5D3MpJqvJheeVZwj/QdnTb0BbA6AR4iv43i3C/iUkaowcrOuarRP
         xkBA==
X-Gm-Message-State: AOAM530paWq00nhIdtab2mG/I4bEApuXoBkI7vfN6AlUpJWhbab5D4fW
        RuBTh72hqWh16PBDIDpp2rA4Z6A9uVI=
X-Google-Smtp-Source: ABdhPJxMG7uD288wEPcpdv5kLKmHrgbbpdH8xMTOaNE0LBIq9VxC3qX8DPDhD67R3NIV8spr94t0/Q==
X-Received: by 2002:a05:600c:21d6:: with SMTP id x22mr3491660wmj.121.1633440060025;
        Tue, 05 Oct 2021 06:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm6447815wrt.96.2021.10.05.06.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:20:59 -0700 (PDT)
Message-Id: <c7e9d9f4e03fe0dbd8a112460f0ac0864f087c8f.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:53 +0000
Subject: [PATCH v2 3/7] reset: expand test coverage for sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add new tests for `--merge` and `--keep` modes, as well as mixed reset with
pathspecs both inside and outside of the sparse checkout definition. New
performance test cases exercise various execution paths for `reset`.

Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |   3 +
 t/t1092-sparse-checkout-compatibility.sh | 107 +++++++++++++++++++++++
 2 files changed, 110 insertions(+)

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
index b3c0d3b98ee..f0723a6ac97 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -479,6 +479,113 @@ test_expect_success 'checkout and reset (mixed) [sparse]' '
 	test_sparse_match git reset update-folder2
 '
 
+# NEEDSWORK: with mixed reset, files with differences between HEAD and <commit>
+# will be added to the work tree even if outside the sparse checkout
+# definition, and even if the file is modified to a state of having no local
+# changes. The file is "re-ignored" if a hard reset is executed. We may want to
+# change this behavior in the future and enforce that files are not written
+# outside of the sparse checkout definition.
+test_expect_success 'checkout and mixed reset file tracking [sparse]' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset update-folder1 &&
+	test_all_match git reset update-deep &&
+
+	# At this point, there are no changes in the working tree. However,
+	# folder1/a now exists locally (even though it is outside of the sparse
+	# paths).
+	run_on_sparse test_path_exists folder1 &&
+
+	run_on_all rm folder1/a &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard update-deep &&
+	run_on_sparse test_path_is_missing folder1 &&
+	test_path_exists full-checkout/folder1
+'
+
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
+test_expect_success 'reset with sparse directory pathspec outside definition' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- folder1 &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'reset with pathspec match in sparse directory' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- folder1/a &&
+	test_all_match git status --porcelain=v2
+'
+
+test_expect_success 'reset with wildcard pathspec' '
+	init_repos &&
+
+	test_all_match git checkout -b reset-test update-deep &&
+	test_all_match git reset --hard update-folder1 &&
+	test_all_match git reset base -- \*/a &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

