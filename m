Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF73C00145
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiLLQbd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLQbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56147FCF3
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5659459wma.1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fESBRnWCynHwK44228IT91mKpA82MaCngsfDT7ZqGik=;
        b=N2YniAR2nO6LsksvkfACYIzA3p/VOybuOTIwzhWDmlxSnrKYYqYhXmNU5msVXVL6uf
         cEge4vNK5c7Zsl/mQfaEltC7XW+qlTbm5YOKQw+61fm5lVGPE2M4Na3kIRe6S82S2Jva
         NneEDgQ/lTpQ5xV1DTMzrx723A67iQT0sV7qb+tZxfelXwpDbMthts1LYgintMeukMqc
         tC+u1Kw5PluqI+3auFsdc8PIHZKQAVb2HaLapDgt1cQ4cFdPDHWHJC0iQPvc7ojGURdg
         6X3B1Ne1jlcNWY3I/mkISs+rO92gHTZ2lIEY72jpLjE/zP7okcW2umf0/Dya9CrBwYVf
         ZeoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fESBRnWCynHwK44228IT91mKpA82MaCngsfDT7ZqGik=;
        b=UVkJseKFZj+ZW2FyG5y+Z228M9QTTCwIXVWj47UZ/XNTURjednXKdUIS+2g0hqk2Qf
         0GtvY13y5U5Km7biX0qYpTv8SS4+AgK9Hqwadu7wTFFjQ3ZEVTzHCQ/2uEwgo8kbuReV
         PwAT0gZxkOsM2zq1KB7zbBU1hQB6jv1wRCmuIEbgYbybHQ3qZsF4NhfZRz+MsXmH2yT7
         x8l9BceqKLPEiNC95julM/ElVN+FH3l/u9F6g0nBD3LBt/vK7MM1cBuk+g4y2Eorr/BX
         sfNw+iFJ4sGSgS+GU0igZfenVJ8lhiyc4XewVpFAJE0tHBtryTL46K2jjSIbwZkfZ/oE
         +z8w==
X-Gm-Message-State: ANoB5pmusjLNabjKfpqscblI3dgeafcW3c5GTtyEGcHaytIxK+vNgLyH
        bSgYrXFMZujnle+mRRpKDpufxvK/obY=
X-Google-Smtp-Source: AA0mqf5J4e/hoKyzAXzTIQ82GkRd860DjAknzDEQdOXDncwwdpm+f78TDUFFQzPzHT6uOXkunU3GVA==
X-Received: by 2002:a05:600c:a56:b0:3d1:d396:1adc with SMTP id c22-20020a05600c0a5600b003d1d3961adcmr16235665wmq.14.1670862681736;
        Mon, 12 Dec 2022 08:31:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bu4-20020a056000078400b00236576c8eddsm9350031wrb.12.2022.12.12.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:31:21 -0800 (PST)
Message-Id: <e640dff53dd3f0aa48bd40fcf0e261292bbded66.1670862677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 16:31:17 +0000
Subject: [PATCH v2 4/4] features: feature.manyFiles implies fast index writes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
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
