Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C27C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:25:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243864AbiBWS0J (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:26:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243846AbiBWSZu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:25:50 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99CE64A3C2
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o4so4278707wrf.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Gl8Ky/hGrIT7Vpt1VCymg9PVQ9UsiYvNL+d+J0ivp5I=;
        b=i+HOWxKyL9dFV6yXVJkLJNZ6gbkXX25IkIW7iJZwM8d0TFRUGltDpC1P5dB9OWbJ4t
         Npp7g5cEclxi6myyMqC0n7C74asex9auKoI5ZITsfGFsCe9UFkPl1SXh1pa+RRGYIgP+
         tU7rZD8Cx8l1IHAdjVXkz5iREdmbfzRwkFNH1CU4arHmhaBNdakX0BAX0Io33AHjBOD1
         GqUNWGektIOrQ5cwrjbilClY5Kdu5ZKvu14v7BsSpcFvYq4/8dA7Cwizem7oWGLW1MRT
         gPsK3rGw+LdXdJoBTCupSzOiVCpGqh7qV3dlpfyKjsH4LlUJ+FmVG3A4iM0D32WEynfl
         V8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Gl8Ky/hGrIT7Vpt1VCymg9PVQ9UsiYvNL+d+J0ivp5I=;
        b=AtXs1ByKXdSuLvzsEC6IBLHoOCPZwgiBLLukuw2ZzyziNUcWQK+7w4A+WSGqvuAq5w
         aXJiDQmigIV2mUX3/ObyRJPPkDqFKEuN0bma/JJlgY6FMaRtTeWLdWQJVotRzZP8vHAO
         fIfBWqgIB92o/q35lb3BCep6mnMzBZ0fR8oTW8BQgANrzg12XvEhR+YEQ+AdXSlTrLJA
         dpIPgPlV7YUHjvd3fTks05jilmX/hycNKKF4pRnr8pZ1703LjQjxKX+eChuDvPQ8/8l/
         7rhTaxppRxzRQZja2JplCymTbVGe4ZWweEAWSFxQPtx2Nq3k0NryV45/yxrR9dTBN/JH
         9V7Q==
X-Gm-Message-State: AOAM533LVhGTNqoOmRpJBNQfA0nQpRpVP1X00yNqh648O6QMHHcXkF3L
        YR3kceYYVlIMX0jBfQ68hquIOML2OWc=
X-Google-Smtp-Source: ABdhPJxO40pi18FlRna2WsF8aZZQF13+aU63ciUEgWpgcCn7LTENXkmeCuZu/r//iWLYmfaIsbp2Vw==
X-Received: by 2002:a05:6000:50a:b0:1e3:5af:153e with SMTP id a10-20020a056000050a00b001e305af153emr653833wrf.385.1645640721011;
        Wed, 23 Feb 2022 10:25:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a05600c4ec600b0037bf934bca3sm651854wmq.17.2022.02.23.10.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:25:20 -0800 (PST)
Message-Id: <ac42ae21d4a1134b866b4be650f28b319b75d7ba.1645640717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:25:12 +0000
Subject: [PATCH 3/7] read-tree: expand sparse checkout test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "mailto:stolee@gmail.com" <[stolee@gmail.com]@vger.kernel.org>,
        "mailto:newren@gmail.com" <[newren@gmail.com]@vger.kernel.org>,
        "mailto:gitster@pobox.com" <[gitster@pobox.com]@vger.kernel.org>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests focused on how 'git read-tree' behaves in sparse checkouts. Extra
emphasis is placed on interactions with files outside the sparse cone, e.g.
merges with out-of-cone conflicts.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  1 +
 t/t1092-sparse-checkout-compatibility.sh | 85 ++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 2a7106b9495..382716cfca9 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -117,6 +117,7 @@ test_perf_on_all git diff
 test_perf_on_all git diff --cached
 test_perf_on_all git blame $SPARSE_CONE/a
 test_perf_on_all git blame $SPARSE_CONE/f3/a
+test_perf_on_all git read-tree -mu HEAD
 test_perf_on_all git checkout-index -f --all
 test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b1dcaa0e642..9d58da4e925 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -819,6 +819,91 @@ test_expect_success 'update-index --cacheinfo' '
 	test_cmp expect sparse-checkout-out
 '
 
+test_expect_success 'read-tree --merge with files outside sparse definition' '
+	init_repos &&
+
+	test_all_match git checkout -b test-branch update-folder1 &&
+	for MERGE_TREES in "base HEAD update-folder2" \
+			   "update-folder1 update-folder2" \
+			   "update-folder2"
+	do
+		# Clean up and remove on-disk files
+		test_all_match git reset --hard HEAD &&
+		test_sparse_match git sparse-checkout reapply &&
+
+		# Although the index matches, without --no-sparse-checkout, outside-of-
+		# definition files will not exist on disk for sparse checkouts
+		test_all_match git read-tree -mu $MERGE_TREES &&
+		test_all_match git status --porcelain=v2 &&
+		test_path_is_missing sparse-checkout/folder2 &&
+		test_path_is_missing sparse-index/folder2 &&
+
+		test_all_match git read-tree --reset -u HEAD &&
+		test_all_match git status --porcelain=v2 &&
+
+		test_all_match git read-tree -mu --no-sparse-checkout $MERGE_TREES &&
+		test_all_match git status --porcelain=v2 &&
+		test_cmp sparse-checkout/folder2/a sparse-index/folder2/a &&
+		test_cmp sparse-checkout/folder2/a full-checkout/folder2/a || return 1
+	done
+'
+
+test_expect_success 'read-tree --merge with edit/edit conflicts in sparse directories' '
+	init_repos &&
+
+	# Merge of multiple changes to same directory (but not same files) should
+	# succeed
+	test_all_match git read-tree -mu base rename-base update-folder1 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+
+	test_all_match git read-tree -mu rename-base update-folder2 &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git reset --hard &&
+
+	test_all_match test_must_fail git read-tree -mu base update-folder1 rename-out-to-in &&
+	test_all_match test_must_fail git read-tree -mu rename-out-to-in update-folder1
+'
+
+test_expect_success 'read-tree --prefix outside sparse definition' '
+	init_repos &&
+
+	# Cannot read-tree --prefix with a single argument when files exist within
+	# prefix
+	test_all_match test_must_fail git read-tree --prefix=folder1/ -u update-folder1 &&
+
+	test_all_match git read-tree --prefix=folder2/0 -u rename-base &&
+	test_path_is_missing sparse-checkout/folder2 &&
+	test_path_is_missing sparse-index/folder2 &&
+
+	test_all_match git read-tree --reset -u HEAD &&
+	test_all_match git read-tree --prefix=folder2/0 -u --no-sparse-checkout rename-base &&
+	test_cmp sparse-checkout/folder2/0/a sparse-index/folder2/0/a &&
+	test_cmp sparse-checkout/folder2/0/a full-checkout/folder2/0/a
+'
+
+test_expect_success 'read-tree --merge with directory-file conflicts' '
+	init_repos &&
+
+	test_all_match git checkout -b test-branch rename-base &&
+
+	# Although the index matches, without --no-sparse-checkout, outside-of-
+	# definition files will not exist on disk for sparse checkouts
+	test_sparse_match git read-tree -mu rename-out-to-out &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_path_is_missing sparse-checkout/folder2 &&
+	test_path_is_missing sparse-index/folder2 &&
+
+	test_sparse_match git read-tree --reset -u HEAD &&
+	test_sparse_match git status --porcelain=v2 &&
+
+	test_sparse_match git read-tree -mu --no-sparse-checkout rename-out-to-out &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_cmp sparse-checkout/folder2/0/1 sparse-index/folder2/0/1
+'
+
 test_expect_success 'merge, cherry-pick, and rebase' '
 	init_repos &&
 
-- 
gitgitgadget

