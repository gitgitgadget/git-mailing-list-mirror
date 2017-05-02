Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA8C207E3
	for <e@80x24.org>; Tue,  2 May 2017 22:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdEBWXh (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 18:23:37 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33227 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751383AbdEBWXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 18:23:33 -0400
Received: by mail-pf0-f177.google.com with SMTP id q20so3539210pfg.0
        for <git@vger.kernel.org>; Tue, 02 May 2017 15:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjZ5mpVdFoL7DGo85L3UYGi0GfpweAHLz46J1Y9LNIc=;
        b=vvphDpTvBlmtSzD+gmfrvAm0udIs29DiaRqyHZhBa99WyFxzCIt6Jd7TmM5Io3v0HC
         MFUiOL4NevQeZK+dH9r6NFwOW0L6q1bu6pIjeQz+PhuAzdLEd1zVGo43f8PbpBsPwwf2
         1riJEIESZXYRRvc533lf4MSWArPL1VrEP8FBNqNwgKd/K/uifuN05vKYCF1J/OP8tZM+
         6UXyD8Z2Yp64V8bM5oZvOQjxBRFO+GSimd6elfvM8IrWrI0IiXZ/g0JYfCFfA995ONNs
         trfQEjnUAjogk2a7Z7qLzfIH3+93ntGpi4dm6UEdYYEBK/sGhakzb87MtJEBNGXWJBKX
         tVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bjZ5mpVdFoL7DGo85L3UYGi0GfpweAHLz46J1Y9LNIc=;
        b=o6KHPRHzfk8EH+aId1lpbslrA/qGxK5C8zt52rv2eZ5+IncHuMD2DgfH5ou9U8rpw1
         JcY08u6FLAouzr+qaFqt5JuZ2lBhJZXs68NCfjo1xZL+vrBSvqwJPfBJL+d+c6yKIR08
         8jOi56ft8y2WeBX1yNWOD4n1mo/kWkMXAWq3WL02pM0iCeMJDTVvLNOdz/LXU4SQ+DhJ
         Vz/9l4xfmmhpoqT7nf92ZkTeqTwpcrLadySeuzGKeVmYOrn7eaQ+LSPEVBWhVOsFXTf2
         skByiURO4EMUnwf0Fm0vlvftU7wx8nEmMXrwNnqUwRGo2BGohjwNyRrV+kcP/XGeLnd3
         YOhA==
X-Gm-Message-State: AN3rC/5SJcy79QpppYV2Sam1VOVhoej5Jp5F4nJP/Zp35zdVCQUoA4HI
        b3tSmPgJx9Lmdphc
X-Received: by 10.84.138.193 with SMTP id 59mr44934049plp.184.1493763812630;
        Tue, 02 May 2017 15:23:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c805:cf1:74c5:2e74])
        by smtp.gmail.com with ESMTPSA id k196sm30737079pgc.0.2017.05.02.15.23.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 May 2017 15:23:32 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@jeffhostetler.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 03/24] cache.h: drop read_cache_from
Date:   Tue,  2 May 2017 15:23:01 -0700
Message-Id: <20170502222322.21055-4-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.39.ga6db8bfa24
In-Reply-To: <20170502222322.21055-1-sbeller@google.com>
References: <20170502222322.21055-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

coccinelle patch:
@@ expression E; @@
-read_cache_from(E)
+read_index_from(&the_index, E)

additionally drop the define from cache.h manually

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 apply.c          | 2 +-
 builtin/am.c     | 4 ++--
 builtin/commit.c | 6 +++---
 cache.h          | 1 -
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/apply.c b/apply.c
index ae1b659b68..159e039a18 100644
--- a/apply.c
+++ b/apply.c
@@ -3985,7 +3985,7 @@ static int check_patch_list(struct apply_state *state, struct patch *patch)
 static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
-		return read_cache_from(state->index_file);
+		return read_index_from(&the_index, state->index_file);
 	else
 		return read_index(&the_index);
 }
diff --git a/builtin/am.c b/builtin/am.c
index c6a679d8e1..cb3e4dff63 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1557,7 +1557,7 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	if (index_file) {
 		/* Reload index as apply_all_patches() will have modified it. */
 		discard_cache();
-		read_cache_from(index_file);
+		read_index_from(&the_index, index_file);
 	}
 
 	return 0;
@@ -1600,7 +1600,7 @@ static int fall_back_threeway(const struct am_state *state, const char *index_pa
 		return error("could not build fake ancestor");
 
 	discard_cache();
-	read_cache_from(index_path);
+	read_index_from(&the_index, index_path);
 
 	if (write_index_as_tree(orig_tree.hash, &the_index, index_path, 0, NULL))
 		return error(_("Repository lacks necessary blobs to fall back on 3-way merge."));
diff --git a/builtin/commit.c b/builtin/commit.c
index 01d298c836..65a04ac199 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -370,7 +370,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 			unsetenv(INDEX_ENVIRONMENT);
 
 		discard_cache();
-		read_cache_from(get_lock_file_path(&index_lock));
+		read_index_from(&the_index, get_lock_file_path(&index_lock));
 		if (update_main_cache_tree(WRITE_TREE_SILENT) == 0) {
 			if (reopen_lock_file(&index_lock) < 0)
 				die(_("unable to write index file"));
@@ -489,7 +489,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 
 	discard_cache();
 	ret = get_lock_file_path(&false_lock);
-	read_cache_from(ret);
+	read_index_from(&the_index, ret);
 	return ret;
 }
 
@@ -949,7 +949,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	 * the editor and after we invoke run_status above.
 	 */
 	discard_cache();
-	read_cache_from(index_file);
+	read_index_from(&the_index, index_file);
 	if (update_main_cache_tree(0)) {
 		error(_("Error building trees"));
 		return 0;
diff --git a/cache.h b/cache.h
index 4e913d1346..6abf48dcc3 100644
--- a/cache.h
+++ b/cache.h
@@ -354,7 +354,6 @@ extern void free_name_hash(struct index_state *istate);
 
 
 #ifndef NO_THE_INDEX_COMPATIBILITY_MACROS
-#define read_cache_from(path) read_index_from(&the_index, (path))
 #define read_cache_preload(pathspec) read_index_preload(&the_index, (pathspec))
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() read_index_unmerged(&the_index)
-- 
2.13.0.rc1.39.ga6db8bfa24

