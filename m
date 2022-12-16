Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4D1C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLPPbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPPb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:31:27 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDC213D60
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:26 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso4350870wme.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujToYgSUqwtjlMniUxu19gWSADfeOByLekCmkP6dz/4=;
        b=Gog+zVYyhpgAq0j6BnPRsuP1VjB+NoN6Qwr2ltRwxgvSMSMb3xVYKsDAyyd19PV91u
         BTdmfadcJAGj6C1sdPzvfhbHx1sFzTwHc0X8BqjQeAglC44vy9Q81ly7JOpZwdtarpfQ
         GTqHZRZApaaTuf4aQawNQvhHa4B/4x7rx3ugzdBlbJ7UyXiuiauSgu3BudPcaxU4z0LZ
         nE8SKHwCWSNyxF5m7kXORC+ytRrreSuonL9hGJBeOFaaok162xg+UAFMt/latJPTE15F
         C2z6Pd+UPyiRTzfrS9Jfp/vKATRL7lScutPXZYevnVjnverr3mYI1wz/wTt3cugct692
         BkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujToYgSUqwtjlMniUxu19gWSADfeOByLekCmkP6dz/4=;
        b=l0kvNIkK4XhiBROdVSl5w0/lZH+kpLGrGukjzkYbkfD55ql+WQQH5j6MYiGLgbhr2n
         05b5LljWf+4L75weII4wJicmu5+CA9qv5DZnGGcDfK691Y1iP9zvOhJWoaHno0TfAGFc
         iav/wUZmuAAOhckw/8/2V4YgHQz4YLPwvTHKp8eBekmAmfLvLELL4ui09VvffTDgFPz7
         ff0ZxijqdEjb7v51pcmxXAI0r9OGvhmDMhyykToAxRvz6TfO8vNdY2ZCuvk06SSNDOdS
         M2Kfs2N9UOq93vs24vmRaANZpeDGRuEiMeW/yh4pJfFmXUamSveqM15lDk0OaWSxxJGR
         meng==
X-Gm-Message-State: ANoB5pnBMYQiYB1+TZEiypzwelwSILbizTHFQz8KKDFh+IrsOD1MGvYQ
        ozn7gxnHbaUp36uleLKeNhWjM3j/cbE=
X-Google-Smtp-Source: AA0mqf6Ol+/C05BBpmjQD+2zpnUONeNOOODBJQ3wZ62FjRxQgi/t1BkzeCJt5CExpCuZHr8gWbEUIw==
X-Received: by 2002:a05:600c:4fc8:b0:3cf:614e:b587 with SMTP id o8-20020a05600c4fc800b003cf614eb587mr25921328wmq.26.1671204684400;
        Fri, 16 Dec 2022 07:31:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003d09150b339sm12263672wmb.20.2022.12.16.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:31:23 -0800 (PST)
Message-Id: <075921514f23163ce95839ec981d7ad5e070facd.1671204678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 15:31:18 +0000
Subject: [PATCH v4 4/4] features: feature.manyFiles implies fast index writes
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
 read-cache.c                     |  3 ++-
 repo-settings.c                  |  2 ++
 repository.h                     |  1 +
 scalar.c                         |  1 +
 t/t1600-index.sh                 | 13 ++++++++++++-
 6 files changed, 23 insertions(+), 2 deletions(-)

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
index fde0697873c..feefa0f68ba 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2927,7 +2927,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
-	repo_config_get_maybe_bool(r, "index.skiphash", &f->skip_hash);
+	prepare_repo_settings(r);
+	f->skip_hash = r->settings.index_skip_hash;
 
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
