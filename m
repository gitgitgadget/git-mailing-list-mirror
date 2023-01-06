Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3444AC3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 16:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjAFQcN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjAFQcE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 11:32:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70376EF7
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 08:32:03 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so1730124wrz.12
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 08:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pvFKRnd3AndEohyyEC5z7YMXT7+2Ddy+ydsdu69Dec=;
        b=hlD2ihVtsFYnE6sLz5d9MaaQQJG88bmkHPIN0QNv+6ugsuKr2s0gBlt78cpp6h/cWi
         6gHwQSYIIjbbIG5lJOkHeilPK0+n8l/RivkWZOlJGBT0syrGeekIlY5NLw7zyPnTSqCR
         s0vdgFuEKq58sPggrfrQfOy756rFi8W63Or01JdBOKXaGObSpS/tS3LMKCHblMQSCHgh
         f50TZI7MseWlgqW0YXF3stvwjIg7diL5iFw7sg6SPFanaRg2PlTDAqJG5d5VdL7o/1F2
         ItJ8vDu+7QjA6W8UJ3lf6DrTStiYg48RrUEyAAHOOs26ouTAeTQMRm+C06FYSgXvTDXF
         84HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pvFKRnd3AndEohyyEC5z7YMXT7+2Ddy+ydsdu69Dec=;
        b=SR6P1gFzviw7RKWe67NkIT7vpdx3MvUAz8GggNxqTBC+Yes4JJVztE/jHrnrnTUamz
         sS/PutCQrYBXv2QbCRxMlRET5ms9/UD64ruE+vAejhIRyvetoUDmckYoeZeY1Vv/6nZW
         XhEwZ2+OZdD/fFv+jrVExl0tH2eQcWnDMJO6Z2JGbFZ1AKDsK6arY5Iaj5mOxYNusIJk
         HyeiJx6tFf7Aq4cDhbc4hB3AjlH6gQncT2ZtexOI3TideExP3roBgq89FI3/pERZOYoq
         2WWtzNh2vHTa73EbGhdJD6ddm0ntXLLMxHYPRsujwNegrz0qJdhyLkPbhxT8L8cGYPuD
         t6Gg==
X-Gm-Message-State: AFqh2krqmAB4f5qs138X42zNXXWPIBZEo2DT0XgwNNFuafF5quBEUya+
        EJzn8aL5qPLZ+J1sj7G/D7b693VQHl8=
X-Google-Smtp-Source: AMrXdXt3L8ytzXV9TzOvtsYevyCPcQi8SB/pq5MFO4406T/rW7ez0n2tL8JvKrQTJ/oPhtSS/jDseA==
X-Received: by 2002:a05:6000:69c:b0:281:67a6:5138 with SMTP id bo28-20020a056000069c00b0028167a65138mr27712345wrb.15.1673022721724;
        Fri, 06 Jan 2023 08:32:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bx11-20020a5d5b0b000000b002366f9bd717sm1956837wrb.45.2023.01.06.08.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:32:01 -0800 (PST)
Message-Id: <1beedcb5ba112b05f6ef9cd306378b140ca73f8c.1673022717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 16:31:56 +0000
Subject: [PATCH v5 4/4] features: feature.manyFiles implies fast index writes
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
 t/t1600-index.sh                 | 11 +++++++++++
 6 files changed, 22 insertions(+), 1 deletion(-)

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
index d73a81e41ae..feefa0f68ba 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2927,7 +2927,8 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 
 	f = hashfd(tempfile->fd, tempfile->filename.buf);
 
-	repo_config_get_bool(r, "index.skiphash", &f->skip_hash);
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
index 2f792bb8ffa..0ebbae13058 100755
--- a/t/t1600-index.sh
+++ b/t/t1600-index.sh
@@ -73,6 +73,17 @@ test_expect_success 'index.skipHash config option' '
 	test_cmp expect hash &&
 	git fsck &&
 
+	rm -f .git/index &&
+	git -c feature.manyFiles=true add a &&
+	test_trailing_hash .git/index >hash &&
+	cmp expect hash &&
+
+	rm -f .git/index &&
+	git -c feature.manyFiles=true \
+	    -c index.skipHash=false add a &&
+	test_trailing_hash .git/index >hash &&
+	! cmp expect hash &&
+
 	test_commit start &&
 	git -c protocol.file.allow=always submodule add ./ sub &&
 	git config index.skipHash false &&
-- 
gitgitgadget
