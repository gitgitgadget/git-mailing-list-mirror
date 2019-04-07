Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FD6320248
	for <e@80x24.org>; Sun,  7 Apr 2019 07:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfDGHhg (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Apr 2019 03:37:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39245 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfDGHhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Apr 2019 03:37:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id i17so2633039pfo.6
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 00:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43Pu5g5da6V0kIXznEpAdYfuS5eeh/Qp1yOFvY6GsdU=;
        b=tytJGdC8wwSl7vhVE9o2W4E/GxIsICPj4cePcn86LwkjU8fv7jAa9NTjsK/vtN59yP
         XZIBBLWxzj1CiRZDE6lmgiwSDXZSqQ8DEYWQmkznCzQYSsfC1xoEv60PmSVlGD8Xvpya
         blsHftarCUgYcA/tn3Uw2a3+mFjuMslwX+wIg0DBWI7byGHgNv1f3IUpRwl1IrjuGH3i
         uC9m3xPDkSDQofqGNMxFh8h9Y8GP1PPHgdAZ0up5ILZXEC6iB5q9YkVxztrtt3ZqaZM5
         3YxEBJJWIsoG+7loi5JZUiVo0+3UsT2eO2ZCRmrJspxnT2w9rg1jAadt8WZygP1o9VGA
         sMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=43Pu5g5da6V0kIXznEpAdYfuS5eeh/Qp1yOFvY6GsdU=;
        b=uRp53PI8n7asOx/zjeckl4qPFZnpi6nP2ID4boSKjWV25DM9nJtskTeS2ViH7Lsi0n
         TVUbGoBdpcybsAKY42M5Dd3j+V9Sj2Ng4Dq77h1W7IwMG3BnJC/N9ABNY1EBszkp8Ueo
         HW75inwqqXR+JgqL+/Sc6+Uu3bEWfom8xt1iOK01nCZJSUJxh4eZf6bJCdyGumd7Lhaf
         CRPQ2lewNyrTYJOyPW+XRlvtyZjdsZ/RdEsMIfh9MT79teW5esMnDcHKiP6cc7TP1X0T
         7FHsjWErviTya6CUobTSqM80wLNKTeT/jlXTq98WcTZTrMRCllXvhexPV+j4aW5iZv5T
         YGow==
X-Gm-Message-State: APjAAAWMMIVsBAjWRd3Ad1CZzvYogBtvOfY03cZInOwm2aUg8R+7VljA
        mxJ4CcZpr1lSvo6dWAQ4zX5IQbGtdGo=
X-Google-Smtp-Source: APXvYqyCyojjjTigACYYB0Elg4t9Z5+Ika/2U9InT1h5CjRpF+8mo0Q+eKE2AgGMQPr+vab1jT5wZQ==
X-Received: by 2002:a62:e50a:: with SMTP id n10mr22748617pff.55.1554622655082;
        Sun, 07 Apr 2019 00:37:35 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:1583:f1fe:c62f:ecb9:e878:d537])
        by smtp.gmail.com with ESMTPSA id n26sm73573792pfi.165.2019.04.07.00.37.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 00:37:34 -0700 (PDT)
From:   Kapil Jain <jkapil.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        t.gummerer@gmail.com, Kapil Jain <jkapil.cs@gmail.com>
Subject: [PATCH][RFC] read-cache: read_index_from() accepts repo as arg
Date:   Sun,  7 Apr 2019 13:07:12 +0530
Message-Id: <20190407073712.1642-1-jkapil.cs@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
---

In read-cache, the read_index_from() function had a TODO task,
this patch completes that. There are some other functions in the same file
where this exact TODO needs to be done, will proceed to do them once this patch is accepted.

running test gave 256 not okays, each had a label as `# TODO known breakage`, which i think
are not concerned to this patch.

 apply.c            | 2 +-
 builtin/worktree.c | 2 +-
 cache-tree.c       | 2 +-
 cache.h            | 4 ++--
 read-cache.c       | 4 ++--
 repository.c       | 2 +-
 revision.c         | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index f15afa9f6a..3b4d128149 100644
--- a/apply.c
+++ b/apply.c
@@ -4021,7 +4021,7 @@ static int read_apply_cache(struct apply_state *state)
 {
 	if (state->index_file)
 		return read_index_from(state->repo->index, state->index_file,
-				       get_git_dir());
+				       get_git_dir(), state->repo);
 	else
 		return repo_read_index(state->repo);
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 6cc094a453..874adebd2c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -737,7 +737,7 @@ static void validate_no_submodules(const struct worktree *wt)
 		 */
 		found_submodules = 1;
 	} else if (read_index_from(&istate, worktree_git_path(wt, "index"),
-				   get_worktree_git_dir(wt)) > 0) {
+				   get_worktree_git_dir(wt), the_repository) > 0) {
 		for (i = 0; i < istate.cache_nr; i++) {
 			struct cache_entry *ce = istate.cache[i];
 			int err;
diff --git a/cache-tree.c b/cache-tree.c
index b13bfaf71e..84f19b224e 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -616,7 +616,7 @@ int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
 
 	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
 
-	entries = read_index_from(index_state, index_path, get_git_dir());
+	entries = read_index_from(index_state, index_path, get_git_dir(), the_repository);
 	if (entries < 0) {
 		ret = WRITE_TREE_UNREADABLE_INDEX;
 		goto out;
diff --git a/cache.h b/cache.h
index ac92421f3a..3850c82fc9 100644
--- a/cache.h
+++ b/cache.h
@@ -420,7 +420,7 @@ extern struct index_state the_index;
 #define active_cache_tree (the_index.cache_tree)
 
 #define read_cache() repo_read_index(the_repository)
-#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()))
+#define read_cache_from(path) read_index_from(&the_index, (path), (get_git_dir()), the_repository)
 #define read_cache_preload(pathspec) repo_read_index_preload(the_repository, (pathspec), 0)
 #define is_cache_unborn() is_index_unborn(&the_index)
 #define read_cache_unmerged() repo_read_index_unmerged(the_repository)
@@ -678,7 +678,7 @@ extern void preload_index(struct index_state *index,
 extern int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
 extern int read_index_from(struct index_state *, const char *path,
-			   const char *gitdir);
+			   const char *gitdir, const struct repository *repo);
 extern int is_index_unborn(struct index_state *);
 
 /* For use with `write_locked_index()`. */
diff --git a/read-cache.c b/read-cache.c
index 4dc6de1b55..0444703284 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2256,7 +2256,7 @@ static void freshen_shared_index(const char *shared_index, int warn)
 }
 
 int read_index_from(struct index_state *istate, const char *path,
-		    const char *gitdir)
+		    const char *gitdir, const struct repository *repo)
 {
 	struct split_index *split_index;
 	int ret;
@@ -2292,7 +2292,7 @@ int read_index_from(struct index_state *istate, const char *path,
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 
 	base_oid_hex = oid_to_hex(&split_index->base_oid);
-	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
+	base_path = xstrfmt("%s/sharedindex.%s", repo->gitdir, base_oid_hex);
 	trace2_region_enter_printf("index", "shared/do_read_index",
 				   the_repository, "%s", base_path);
 	ret = do_read_index(split_index->base, base_path, 1);
diff --git a/repository.c b/repository.c
index 682c239fe3..8ac2b65f61 100644
--- a/repository.c
+++ b/repository.c
@@ -264,7 +264,7 @@ int repo_read_index(struct repository *repo)
 	if (!repo->index)
 		repo->index = xcalloc(1, sizeof(*repo->index));
 
-	return read_index_from(repo->index, repo->index_file, repo->gitdir);
+	return read_index_from(repo->index, repo->index_file, repo->gitdir, repo);
 }
 
 int repo_hold_locked_index(struct repository *repo,
diff --git a/revision.c b/revision.c
index eb8e51bc63..247a4d5704 100644
--- a/revision.c
+++ b/revision.c
@@ -1556,7 +1556,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 
 		if (read_index_from(&istate,
 				    worktree_git_path(wt, "index"),
-				    get_worktree_git_dir(wt)) > 0)
+				    get_worktree_git_dir(wt), the_repository) > 0)
 			do_add_index_objects_to_pending(revs, &istate, flags);
 		discard_index(&istate);
 	}
-- 
2.20.1

