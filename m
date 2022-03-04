Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19AEC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241724AbiCDSdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241732AbiCDSdj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:39 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1A35F66
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:34 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t11so13931554wrm.5
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3E3QcWzdHFRs9rdSlHOOuV6A/S6L2GoKPxiHS0KaoFM=;
        b=ZsB4pTsX1yXsSatLZUt48fXZLFJh8Bju2u/mz5fAItWRKRTHdmPnl0TC5oTBZBaG62
         jwboXzf3T13k+AiJNO6BgscLVIJWjJoetk3vJwGnJosnXW/vi2sPNLdEvMJvtlg9PJbQ
         ybiwat0SkMGvmlyRu+lLr3FUXph0xJaymKKFcBjLDLC/S8Z7BSGn6wU2E6bIF3zZmgD2
         MOJqeUOvRc/YIF5u7XRVmUGNLKCv8G+/lpM8idgeXWqnXgIeVdpy+9TsRD/fBYHEaX0b
         elaEPMQ3YI0z+qCDGhrJaZrltArZICGfnUtJudQaUff6k+6ugA7/0lMdEqg/QUBB8kko
         5dRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3E3QcWzdHFRs9rdSlHOOuV6A/S6L2GoKPxiHS0KaoFM=;
        b=fLgkgeyGBAa9IWyy5o0DNnykyueb8eAOpY1m2abJrY55eWVM+tV+Fh6F34qmfIJE1w
         Z04aZZlHh7YnTrjQB+cjh5+JOucUD09pRGRhNbf8nUhqLaltAJc2l76Z5R5D3M6vPmg7
         r8oNsBP/eTLKTx3Ij/Ths5Qd6gTRds/x+5pA9IS+sA0tEaAjX5cW3/5eyZBlghhq/U2D
         cBlMSBUg5slnFttVk6+YMcrQVo5jXzU37NHmX4hVzu72Tey2diyXTRCjz1EqNuzjn7VW
         6C3lOoUiyusyfG1LCezbr31mzJMD4K5lQNxhIWYI6UzrnMo1AhEtppHVWoFzvocyBk+I
         OxPA==
X-Gm-Message-State: AOAM533h/kRmcnHiHaHq4eJYm6wd2nuTt5OojatB5lg8qROp5tuXitjk
        a23UiMlpV+f1xXP/bv4bepX8egH1al7EVw==
X-Google-Smtp-Source: ABdhPJwwrMdhfZVAZckhL499B3RbESFz0b30ZRyd/CJyNbU6072sR098GMdqO+W2j1J7Yf53jBOI4w==
X-Received: by 2002:a05:6000:143:b0:1f0:25a1:874c with SMTP id r3-20020a056000014300b001f025a1874cmr19401wrx.191.1646418752659;
        Fri, 04 Mar 2022 10:32:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/14] lockfile API users: simplify and don't leak "path"
Date:   Fri,  4 Mar 2022 19:32:14 +0100
Message-Id: <patch-v2-11.14-217754edc62-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in 6c622f9f0bb (commit-graph: write
commit-graph chains, 2019-06-18). We needed to free the "lock_name" if
we encounter errors, and the "graph_name" after we'd run unlink() on
it.

For the case of write_commit_graph_file() refactoring the code to free
the "lock_name" after we were done using the "struct lock_file lk"
would have made the control flow more complex. Luckily we can free the
"lock_file" right after the hold_lock_file_for_update() call, if it
makes use of "path" at all it'll have copied its contents to a "struct
strbuf" of its own.

While I'm at it let's fix code added in fb10ca5b543 (sparse-checkout:
write using lockfile, 2019-11-21) in write_patterns_and_update() to
avoid the same complexity that I thought I needed when I wrote the
initial fix for write_commit_graph_file(). We can free the
"sparse_filename" right after calling hold_lock_file_for_update(), we
don't need to wait until we're exiting the function to do so.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/sparse-checkout.c | 3 +--
 commit-graph.c            | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 9c338d33ea2..270ad49c2b8 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -328,11 +328,11 @@ static int write_patterns_and_update(struct pattern_list *pl)
 
 	fd = hold_lock_file_for_update(&lk, sparse_filename,
 				      LOCK_DIE_ON_ERROR);
+	free(sparse_filename);
 
 	result = update_working_directory(pl);
 	if (result) {
 		rollback_lock_file(&lk);
-		free(sparse_filename);
 		clear_pattern_list(pl);
 		update_working_directory(NULL);
 		return result;
@@ -348,7 +348,6 @@ static int write_patterns_and_update(struct pattern_list *pl)
 	fflush(fp);
 	commit_lock_file(&lk);
 
-	free(sparse_filename);
 	clear_pattern_list(pl);
 
 	return 0;
diff --git a/commit-graph.c b/commit-graph.c
index aab0b292774..b8cde7ea27d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1854,6 +1854,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 
 		hold_lock_file_for_update_mode(&lk, lock_name,
 					       LOCK_DIE_ON_ERROR, 0444);
+		free(lock_name);
 
 		fd = git_mkstemp_mode(ctx->graph_name, 0444);
 		if (fd < 0) {
@@ -1978,6 +1979,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		} else {
 			char *graph_name = get_commit_graph_filename(ctx->odb);
 			unlink(graph_name);
+			free(graph_name);
 		}
 
 		ctx->commit_graph_hash_after[ctx->num_commit_graphs_after - 1] = xstrdup(hash_to_hex(file_hash));
-- 
2.35.1.1248.gb68c9165ad8

