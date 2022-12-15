Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53081C4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiLOPHe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiLOPHL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B052303C5
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso2070136wmp.3
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fESBRnWCynHwK44228IT91mKpA82MaCngsfDT7ZqGik=;
        b=N7TFfRPB5up1RvW6r1xdUjEz8O8W536eIIhu1+sWrGo99fmaAgLICHe4ROv9Xv26ao
         i/OWZ6tynWlTS7HzMSa2ztvxYolls3rwjFw30MDkh1ixHjXc3yESg0ss1BXTpm3Mwh2P
         4s2W/j2pCKZImRDb9/DccU9NQ9ytG+ZX7LBBI9YUAZ3iDw59ZPTWtWg8a8Yrf1S8F3yY
         Q8QSxYtaPw+BPTFIgliJYff32euGK5+lU2vjLv6nbqrcuEtAjLMKxe87amT7NBTFSRnj
         r6ApJmORyuvSDgD5WR/Ef4YTyPJs9S1PRXBVk6QnH6Fe0GQg910TXLAvmjiVwEb51SAq
         VGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fESBRnWCynHwK44228IT91mKpA82MaCngsfDT7ZqGik=;
        b=AzENg005mryAC3jcd8ok0HSTPqP8yY91A+1r5WGoBtBo1KQO9N5ds78oFR0h5tgITe
         6OtnwkhY4TUxjCTel/lWw568IkjeE26Y7ilbdkUXJsnxIKLLLRxLqtUcDlEtqXzlNBwh
         bJYmLR9LOWXfU0lUuEtstxknMSpwkrv/kmLgE11m4ajoRHvmYqtx1h7G5L0UNO1vJkuQ
         tvcDvSiPEtgJfJldWu5Skke7IlGT8ki+ITqyIVsstVNoQZDo1NlF38axcVcACd95jvpp
         XymZvVypy3N41mWYVHShVdlaSe9+paYJ9Z/V+fF+G6zDvfe4baPET+jCzoafQvE130f9
         SO9A==
X-Gm-Message-State: ANoB5pmrQ3EO6AhO4PZcRYCIFLia9azBL6403nyD6aKItmOV8qgpTzqj
        28Fk2STH0M1zMQv4DOK5lH797xz4A8M=
X-Google-Smtp-Source: AA0mqf6Yzp3InwbXVZyI9HZ8+1JhXB/3eYQHq0D2gn9H5RveeQSBSw9x9UTb19VN1D3gJiWdemp96w==
X-Received: by 2002:a05:600c:3c8d:b0:3d0:6d39:c62e with SMTP id bg13-20020a05600c3c8d00b003d06d39c62emr23098112wmb.12.1671116826895;
        Thu, 15 Dec 2022 07:07:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n7-20020a05600c4f8700b003d1e90717ccsm8353420wmq.30.2022.12.15.07.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:07:06 -0800 (PST)
Message-Id: <6490bd445ebea41223eec38784426ad17a0711b6.1671116820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
        <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 15:07:00 +0000
Subject: [PATCH v3 4/4] features: feature.manyFiles implies fast index writes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The recent addition of the index.skipHash config option allows index
writes to speed up by skipping the hash computation for the trailing
checksum. This is particularly critical for repositories with many files
at HEAD, so add this config option to two cases where users in that
scenario may opt-in to such behavior:

 1. The feature.manyFiles config option enables some options that are
    helpful for repositories with many files at HEAD.

 2. 'scalar register' and 'scalar reconfigure' set config options that
    optimize for large repositories.

In both of these cases, set index.skipHash=true to gain this
speedup. Add tests that demonstrate the proper way that
index.skipHash=true can override feature.manyFiles=true.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/feature.txt |  5 +++++
 read-cache.c                     |  5 ++++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 13 ++++++++++++-
 6 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/feature.txt b/Documentation/config/feature.txt
index 95975e50912..e52bc6b8584 100644
--- a/Documentation/config/feature.txt
+++ b/Documentation/config/feature.txt
@@ -23,6 +23,11 @@ feature.manyFiles::
 	working directory. With many files, commands such as `git status` and
 	`git checkout` may be slow and these new defaults improve performance:
 +
+* `index.skipHash=true` speeds up index writes by not computing a trailing
+  checksum. Note that this will cause Git versions earlier than 2.13.0 to
+  refuse to parse the index and Git versions earlier than 2.40.0 will report
+  a corrupted index during `git fsck`.
++
 * `index.version=4` enables path-prefix compression in the index.
 +
 * `core.untrackedCache=true` enables the untracked cache. This setting assumes
diff --git a/read-cache.c b/read-cache.c
index 3f7de8b2e20..1844953fba7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2926,7 +2926,10 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
-	git_config_get_maybe_bool("index.skiphash", (int *)&f->skip_hash);
+	if (istate->repo) {
+		prepare_repo_settings(istate->repo);
+		f->skip_hash = istate->repo->settings.index_skip_hash;
+	}
 
 	for (i = removed = extended = 0; i < entries; i++) {
 		if (cache[i]->ce_flags & CE_REMOVE)
diff --git a/repo-settings.c b/repo-settings.c
index 3021921c53d..3dbd3f0e2ec 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -47,6 +47,7 @@ void prepare_repo_settings(struct repository *r)
 	}
 	if (manyfiles) {
 		r->settings.index_version = 4;
+		r->settings.index_skip_hash = 1;
 		r->settings.core_untracked_cache = UNTRACKED_CACHE_WRITE;
 	}
 
@@ -61,6 +62,7 @@ void prepare_repo_settings(struct repository *r)
 	repo_cfg_bool(r, "pack.usesparse", &r->settings.pack_use_sparse, 1);
 	repo_cfg_bool(r, "core.multipackindex", &r->settings.core_multi_pack_index, 1);
 	repo_cfg_bool(r, "index.sparse", &r->settings.sparse_index, 0);
+	repo_cfg_bool(r, "index.skiphash", &r->settings.index_skip_hash, r->settings.index_skip_hash);
 
 	/*
 	 * The GIT_TEST_MULTI_PACK_INDEX variable is special in that
diff --git a/repository.h b/repository.h
index 6c461c5b9de..e8c67ffe165 100644
--- a/repository.h
+++ b/repository.h
@@ -42,6 +42,7 @@ struct repo_settings {
 	struct fsmonitor_settings *fsmonitor; /* lazily loaded */
 
 	int index_version;
+	int index_skip_hash;
 	enum untracked_cache_setting core_untracked_cache;
 
 	int pack_use_sparse;
diff --git a/scalar.c b/scalar.c
index 6c52243cdf1..b49bb8c24ec 100644
--- a/scalar.c
+++ b/scalar.c
@@ -143,6 +143,7 @@ static int set_recommended_config(int reconfigure)
 		{ "credential.validate", "false", 1 }, /* GCM4W-only */
 		{ "gc.auto", "0", 1 },
 		{ "gui.GCWarning", "false", 1 },
+		{ "index.skipHash", "false", 1 },
 		{ "index.threads", "true", 1 },
 		{ "index.version", "4", 1 },
 		{ "merge.stat", "false", 1 },
diff --git a/t/t1600-index.sh b/t/t1600-index.sh
index 55914bc3506..103743a1c7d 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -71,7 +71,18 @@ test_expect_success 'index.skipHash config option' '
 	test_trailing_hash .git/index >hash &&
 	echo $(test_oid zero) >expect &&
 	test_cmp expect hash &&
-	git fsck
+	git fsck &&
+
+	rm -f .git/index &&
+	git -c feature.manyFiles=true add a &&
+	test_trailing_hash .git/index >hash &&
+	test_cmp expect hash &&
+
+	rm -f .git/index &&
+	git -c feature.manyFiles=true \
+		-c index.skipHash=false add a &&
+	test_trailing_hash .git/index >hash &&
+	! cmp expect hash
 '
 
 test_index_version () {
-- 
gitgitgadget
