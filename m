Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64515FA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbiJXVzs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiJXVzV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:55:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6DDD0393
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so7294499wrq.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVeQ/mWty2Tpibi+Iyhp7FnN8iq0Jx9ktGkbazpbcxU=;
        b=RDCC/YwrJwLnhOGO+5zdm1DPHOSYgst04TMGc/zt0RuWRh2pzxurB9J/vlMWDUCpkp
         ynPq0XCITcFkxa5yqVLGVnxFHISxFFqD3ey521ph5Q1hH9csQBB/d3x8dJR3ImPVRb8E
         lHA6mObFEK5UHNYp+CLO4H3RdD7b5Zknh7Umo4pI50r8RjQvS045nR2pfF4MZ7YQCqnJ
         rfg1rqpqWRyKzj2llT9vKQZQUKcAv2y0c0xRkMfloN7cnm7iq7TBv/C1DwHq7TsT+1/C
         MfUqgweMGdIzwfGFcQmT2kbwBI2RbBmHK8JAJDg+p8BxBMb/KZY21jMeEFDi1vO/jKCo
         avyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IVeQ/mWty2Tpibi+Iyhp7FnN8iq0Jx9ktGkbazpbcxU=;
        b=YEGZZOIhA19dQTozZ6JzLO7oy3LsN2EQVuQajomMDuwikYu9cl4ydpyuwFPt+SmGq+
         TqWfvknZ+tVs4EwotlwLGit4OlKnnbSxH6vamz/N7Nj+ZQjHEBush6JuqBBGJCDbSt5Q
         0bjbTw1Ev+SxMdHaikwUWloHkN/ojmBhK79AelPpF5iHrufMEzpbtpE8Dg7v9qAwAcFA
         94/MecvDSHX3VwjC+Y6WduwqpQgNw36UpW6LIu5So1MLvT4cZNUS8CQhhMPgtoytmOnE
         gZ8+FGbUz7E1gr2Sm7//iM2G/J4kcTEW91qReU32Gtu1gZtZx80sx8TdZgV5SOH57SBY
         WNNA==
X-Gm-Message-State: ACrzQf1eice7BzqvSqS04ITmKZqszuuW0lKRRaYgbg9Buk9dy4OsdcDp
        soizxITQSorME09BUgRER8I2exAxaO4=
X-Google-Smtp-Source: AMsMyM7hq6JKUlUNHj0ulZ1A2Q92j32cY455lacVDd/etUCtuYLhqD5mcbCgeEWeG0eP/0kNFT+qoQ==
X-Received: by 2002:a5d:6c63:0:b0:230:8257:be9e with SMTP id r3-20020a5d6c63000000b002308257be9emr21662006wrz.606.1666642069247;
        Mon, 24 Oct 2022 13:07:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c0b5500b003cdf141f363sm698056wmr.11.2022.10.24.13.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:48 -0700 (PDT)
Message-Id: <ec4a2422d5b65efcbe8722f7f25f4b6ef6911302.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:40 +0000
Subject: [PATCH v5 2/6] patch-id: use stable patch-id for rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

Git doesn't persist patch-ids during the rebase process, so there is
no need to specifically invoke the unstable variant. Use the stable
logic for all internal patch-id calculations to minimize the number of
code paths and improve test coverage.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 builtin/log.c |  2 +-
 diff.c        | 12 ++++--------
 diff.h        |  2 +-
 patch-ids.c   | 10 +++++-----
 patch-ids.h   |  2 +-
 5 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index ee19dc5d450..e72869afb36 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1763,7 +1763,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		struct object_id *patch_id;
 		if (*commit_base_at(&commit_base, commit))
 			continue;
-		if (commit_patch_id(commit, &diffopt, &oid, 0, 1))
+		if (commit_patch_id(commit, &diffopt, &oid, 0))
 			die(_("cannot get patch id"));
 		ALLOC_GROW(bases->patch_id, bases->nr_patch_id + 1, bases->alloc_patch_id);
 		patch_id = bases->patch_id + bases->nr_patch_id;
diff --git a/diff.c b/diff.c
index c15169e4b06..199b63dbcc3 100644
--- a/diff.c
+++ b/diff.c
@@ -6206,7 +6206,7 @@ static void patch_id_add_mode(git_hash_ctx *ctx, unsigned mode)
 }
 
 /* returns 0 upon success, and writes result into oid */
-static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
+static int diff_get_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
@@ -6293,21 +6293,17 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 				return error("unable to generate patch-id diff for %s",
 					     p->one->path);
 		}
-		if (stable)
-			flush_one_hunk(oid, &ctx);
+		flush_one_hunk(oid, &ctx);
 	}
 
-	if (!stable)
-		the_hash_algo->final_oid_fn(oid, &ctx);
-
 	return 0;
 }
 
-int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only, int stable)
+int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
 	int i;
-	int result = diff_get_patch_id(options, oid, diff_header_only, stable);
+	int result = diff_get_patch_id(options, oid, diff_header_only);
 
 	for (i = 0; i < q->nr; i++)
 		diff_free_filepair(q->queue[i]);
diff --git a/diff.h b/diff.h
index 8ae18e5ab1e..fd33caeb25d 100644
--- a/diff.h
+++ b/diff.h
@@ -634,7 +634,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option);
 int run_diff_index(struct rev_info *revs, unsigned int option);
 
 int do_diff_cache(const struct object_id *, struct diff_options *);
-int diff_flush_patch_id(struct diff_options *, struct object_id *, int, int);
+int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 void flush_one_hunk(struct object_id *result, git_hash_ctx *ctx);
 
 int diff_result_code(struct diff_options *, int);
diff --git a/patch-ids.c b/patch-ids.c
index 46c6a8f3eab..31534466266 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -11,7 +11,7 @@ static int patch_id_defined(struct commit *commit)
 }
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int diff_header_only, int stable)
+		    struct object_id *oid, int diff_header_only)
 {
 	if (!patch_id_defined(commit))
 		return -1;
@@ -22,7 +22,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
 	else
 		diff_root_tree_oid(&commit->object.oid, "", options);
 	diffcore_std(options);
-	return diff_flush_patch_id(options, oid, diff_header_only, stable);
+	return diff_flush_patch_id(options, oid, diff_header_only);
 }
 
 /*
@@ -48,11 +48,11 @@ static int patch_id_neq(const void *cmpfn_data,
 	b = container_of(entry_or_key, struct patch_id, ent);
 
 	if (is_null_oid(&a->patch_id) &&
-	    commit_patch_id(a->commit, opt, &a->patch_id, 0, 0))
+	    commit_patch_id(a->commit, opt, &a->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&a->commit->object.oid));
 	if (is_null_oid(&b->patch_id) &&
-	    commit_patch_id(b->commit, opt, &b->patch_id, 0, 0))
+	    commit_patch_id(b->commit, opt, &b->patch_id, 0))
 		return error("Could not get patch ID for %s",
 			oid_to_hex(&b->commit->object.oid));
 	return !oideq(&a->patch_id, &b->patch_id);
@@ -82,7 +82,7 @@ static int init_patch_id_entry(struct patch_id *patch,
 	struct object_id header_only_patch_id;
 
 	patch->commit = commit;
-	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1, 0))
+	if (commit_patch_id(commit, &ids->diffopts, &header_only_patch_id, 1))
 		return -1;
 
 	hashmap_entry_init(&patch->ent, oidhash(&header_only_patch_id));
diff --git a/patch-ids.h b/patch-ids.h
index ab6c6a68047..490d7393716 100644
--- a/patch-ids.h
+++ b/patch-ids.h
@@ -20,7 +20,7 @@ struct patch_ids {
 };
 
 int commit_patch_id(struct commit *commit, struct diff_options *options,
-		    struct object_id *oid, int, int);
+		    struct object_id *oid, int);
 int init_patch_ids(struct repository *, struct patch_ids *);
 int free_patch_ids(struct patch_ids *);
 
-- 
gitgitgadget

