Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363B6C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbiKJTIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 14:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiKJTHf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1798E59FC6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l14so3643175wrw.2
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 11:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=aWyYZdD5ZyzbHQcMVtHGR9CO2bfznnwb3GuR+1yCQMi2ahRa4KtON3IH0VmackLWsK
         6K3FjXDsrzAdAlOi3MiezQuzQSlYuTC/5Gdaec8sJq1l0l1s5oiB0EbehELXnyWd+Hn/
         OIMq2gHD9LZINCwZ/otTa6UNEF9RhrQqkzsDSxRZG+iqphR5UltHarc4r4yPFsD/ZvQP
         2PHlKrUg3QvtKy2M1EF1yUFeGfFZGlTPldaMRnfZzivTWsRUKFHSTlzFhgxINIbXJ/UA
         IIg11U9sP7BM9dhB1OI6DR1sPMewDFNV+i1+D8L9hKxQ1DcEvtNcZ2v/vFNL/5h6dDAb
         8ZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9D6pDzcfKa+C9JuV33FlqQspXTfBgY5IZLMOQAlznk=;
        b=WgdA4D83pjBh3cEPskY5WS6wywMCZ/yFnHJQO44948IwUHBzoIO0q5TuHzs4T53miG
         udXIwr/24dCEgoZgahg8jFbLQOSuzPfPgNTpkG28bnVyyu5bjyM1Ygz5v995brINVTS/
         Ru7/cWrnfijPXx584ssmN8QDDRlKFVawBQIsZi5NjcJBZggJTzJ4RUEdS1q3UJICDMrX
         UaLe4kZMuKopLy4QatBdwMMCQpQRWMqpdp+nv05wR2oxN2aCLV7RPUydAf5hFUmK0wKu
         Ar5ULvI45ltdFBCXk3CWsSi9tOpUFIL9+w4/72fWkrCGI7zdKQa3LvrRkGsHRciKna/S
         b7cA==
X-Gm-Message-State: ACrzQf2P2vkgPWDJpDo77itDQqR90FZZMrM2+Cx4HGOIioPsf8XUBKtL
        GnEt6mKDA3A6jxDs8lzXsf4Q6fthfn8=
X-Google-Smtp-Source: AMsMyM55c9ErbhPb3sIX1YWWfRMkc4hiQ6N2senGHZioV03JGZpl5kCLSlfP+L9HAQZNFmDlqmJ3DA==
X-Received: by 2002:adf:fa8d:0:b0:236:bb9c:45e4 with SMTP id h13-20020adffa8d000000b00236bb9c45e4mr40171080wrr.216.1668107173172;
        Thu, 10 Nov 2022 11:06:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020adfdc82000000b0022ae401e9e0sm16912516wrj.78.2022.11.10.11.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:06:12 -0800 (PST)
Message-Id: <ea5c82ce992192681bc1ea230d1d57d0a1011ed6.1668107165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
References: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
        <pull.1411.v3.git.1668107165.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 19:06:04 +0000
Subject: [PATCH v3 4/5] read-tree: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        szeder.dev@gmail.com, Taylor Blau <me@ttaylorr.com>,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When running 'read-tree' with a single tree and no prefix,
'prime_cache_tree()' is called after the tree is unpacked. In that
situation, skip a redundant call to 'cache_tree_update()' in
'unpack_trees()' by enabling the 'skip_cache_tree_update' unpack option.

Removing the redundant cache tree update provides a substantial performance
improvement to 'git read-tree <tree-ish>', as shown by a test added to
'p0006-read-tree-checkout.sh':

Test                          before            after
----------------------------------------------------------------------
read-tree br_ballast_plus_1   3.94(1.80+1.57)   3.00(1.14+1.28) -23.9%

Note that the 'read-tree' in 't1022-read-tree-partial-clone.sh' is updated
to read two trees, rather than one. The test was first introduced in
d3da223f221 (cache-tree: prefetch in partial clone read-tree, 2021-07-23) to
exercise the 'cache_tree_update()' code path, as used in 'git merge'. Since
this patch drops the call to 'cache_tree_update()' in single-tree 'git
read-tree', change the test to use the two-tree variant so that
'cache_tree_update()' is called as intended.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/read-tree.c                | 4 ++++
 t/perf/p0006-read-tree-checkout.sh | 8 ++++++++
 t/t1022-read-tree-partial-clone.sh | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index f4cbe460b97..45c6652444b 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -249,6 +249,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	if (opts.debug_unpack)
 		opts.fn = debug_merge;
 
+	/* If we're going to prime_cache_tree later, skip cache tree update */
+	if (nr_trees == 1 && !opts.prefix)
+		opts.skip_cache_tree_update = 1;
+
 	cache_tree_free(&active_cache_tree);
 	for (i = 0; i < nr_trees; i++) {
 		struct tree *tree = trees[i];
diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
index c481c012d2f..325566e18eb 100755
--- a/t/perf/p0006-read-tree-checkout.sh
+++ b/t/perf/p0006-read-tree-checkout.sh
@@ -49,6 +49,14 @@ test_perf "read-tree br_base br_ballast ($nr_files)" '
 	git read-tree -n -m br_base br_ballast
 '
 
+test_perf "read-tree br_ballast_plus_1 ($nr_files)" '
+	# Run read-tree 100 times for clearer performance results & comparisons
+	for i in  $(test_seq 100)
+	do
+		git read-tree -n -m br_ballast_plus_1 || return 1
+	done
+'
+
 test_perf "switch between br_base br_ballast ($nr_files)" '
 	git checkout -q br_base &&
 	git checkout -q br_ballast
diff --git a/t/t1022-read-tree-partial-clone.sh b/t/t1022-read-tree-partial-clone.sh
index a9953b6a71c..da539716359 100755
--- a/t/t1022-read-tree-partial-clone.sh
+++ b/t/t1022-read-tree-partial-clone.sh
@@ -19,7 +19,7 @@ test_expect_success 'read-tree in partial clone prefetches in one batch' '
 	git -C server config uploadpack.allowfilter 1 &&
 	git -C server config uploadpack.allowanysha1inwant 1 &&
 	git clone --bare --filter=blob:none "file://$(pwd)/server" client &&
-	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git -C client read-tree $TREE $TREE &&
 
 	# "done" marks the end of negotiation (once per fetch). Expect that
 	# only one fetch occurs.
-- 
gitgitgadget

