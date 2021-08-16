Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37871C432BE
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C99E60F11
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhHPVKn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbhHPVKm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9D8C061764
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f8-20020a2585480000b02905937897e3daso17999252ybn.2
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=U7yZxbJqMHc1pHxmMU8fL8bNbaBykjpuYGi3VG2SyVM=;
        b=tUjV6uJu1T05SSz2NF12Dn5gxaSSk5SZgT1Reca77R1ECQZqcfUN6Cu8rjtKrPIMLG
         PzJs/Vs8WTfRdrVBFbG/ODLNJ8FZbhFJgm2a9AFP/HF9dk1Hgtc5ewARL/of2QVpyzZh
         zOPFhfxHaMghteY7vEVyYMkq7oSI4RGNxUdRAsVXqRkt51lG+NIgy6ywNWPdbuABUzcj
         Ur/bsXaMrC3BMKm0COTOugBBoX1aSRk77XMWOZBjiRtmgBYvBjO1xf6AMxu0LX46DMJV
         MVkOH6tzLtXVqmGhgxKki4LPCasHY592/LITNpGGUj3C/KYJbVow1zW641ij/6La2M4r
         TDZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U7yZxbJqMHc1pHxmMU8fL8bNbaBykjpuYGi3VG2SyVM=;
        b=XATVt4JS7tbKZXdXkQceuaegHIGte6G/iHYDUpff+gov31feLWAVXoRbbqQ9fR3jR+
         t/GC+aTSIhnSWbhsKci8aXmzLgJMV7TKROcRGqE+JUusCewVnQrsIi7O+i9Zcjl5GChH
         lYhJBkNR0rryWDeu+4evnI1nzaJGSKgUYGUMPZouH+5WImo/hMAzYStjWZOPllPMo9ZH
         Ven4+1Qxf8ZEAaI11WUeOeewqGQezIranx1pMZLwX6VDfy0196WPFp9jm+wjOAiNuQM8
         gm8fYLYxSSFdqf+AQ8026DIDIte5W2RrJ/P+6qsf0BDYS8hrq5gptMpOvqEpwbolL3An
         9/bw==
X-Gm-Message-State: AOAM530JYZSskmozxj4vQ8hIENmFYZKNwo6UyZN1l2kmmE4kXetUe1sX
        7kgkQiajypKJwKhyJWNb7JHa1//0YXz6Ae1CysIaYjIHE4MjodYhxIhycOGINo/PDlDQhpPJFgY
        qIZESkUVcQ2cVv2zt0iTyOWU20HKm+sEQXiPiPIdnghY11v8lfzeYZbkoFaAg8IzfmQGbmrsJOb
        39
X-Google-Smtp-Source: ABdhPJwJVeSDh3TcpAQGENh/Fz4CZ/e3Bi3Ea4zA5ZCwoOmzye4O/shQqkcJ8+B/2Ocevoc60D7D4ctsLRA6gsQ+5dqU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:2c82:: with SMTP id
 s124mr409ybs.17.1629148209433; Mon, 16 Aug 2021 14:10:09 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:55 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <7d1eeac4b50abd46c99f61eaddcc72f8bb1de043.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 5/8] grep: allocate subrepos on heap
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, struct repository objects corresponding to submodules are
allocated on the stack in grep_submodule(). This currently works because
they will not be used once grep_submodule() exits, but a subsequent
patch will require these structs to be accessible for longer (perhaps
even in another thread). Allocate them on the heap and clear them only
at the very end.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e61c7c993..fa7fd08150 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -65,6 +65,9 @@ static int todo_done;
 /* Has all work items been added? */
 static int all_work_added;
 
+static struct repository **repos_to_free;
+static size_t repos_to_free_nr, repos_to_free_alloc;
+
 /* This lock protects all the variables above. */
 static pthread_mutex_t grep_mutex;
 
@@ -168,6 +171,19 @@ static void work_done(struct work_item *w)
 	grep_unlock();
 }
 
+static void free_repos(void)
+{
+	int i;
+
+	for (i = 0; i < repos_to_free_nr; i++) {
+		repo_clear(repos_to_free[i]);
+		free(repos_to_free[i]);
+	}
+	FREE_AND_NULL(repos_to_free);
+	repos_to_free_nr = 0;
+	repos_to_free_alloc = 0;
+}
+
 static void *run(void *arg)
 {
 	int hit = 0;
@@ -415,19 +431,24 @@ static int grep_submodule(struct grep_opt *opt,
 			  const struct object_id *oid,
 			  const char *filename, const char *path, int cached)
 {
-	struct repository subrepo;
+	struct repository *subrepo;
 	struct repository *superproject = opt->repo;
 	const struct submodule *sub;
 	struct grep_opt subopt;
-	int hit;
+	int hit = 0;
 
 	sub = submodule_from_path(superproject, null_oid(), path);
 
 	if (!is_submodule_active(superproject, path))
 		return 0;
 
-	if (repo_submodule_init(&subrepo, superproject, sub))
+	subrepo = xmalloc(sizeof(*subrepo));
+	if (repo_submodule_init(subrepo, superproject, sub)) {
+		free(subrepo);
 		return 0;
+	}
+	ALLOC_GROW(repos_to_free, repos_to_free_nr + 1, repos_to_free_alloc);
+	repos_to_free[repos_to_free_nr++] = subrepo;
 
 	/*
 	 * NEEDSWORK: repo_read_gitmodules() might call
@@ -438,7 +459,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * subrepo's odbs to the in-memory alternates list.
 	 */
 	obj_read_lock();
-	repo_read_gitmodules(&subrepo, 0);
+	repo_read_gitmodules(subrepo, 0);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
@@ -450,11 +471,11 @@ static int grep_submodule(struct grep_opt *opt,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	add_submodule_odb_by_path(subrepo.objects->odb->path);
+	add_submodule_odb_by_path(subrepo->objects->odb->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
-	subopt.repo = &subrepo;
+	subopt.repo = subrepo;
 
 	if (oid) {
 		enum object_type object_type;
@@ -464,9 +485,9 @@ static int grep_submodule(struct grep_opt *opt,
 		struct strbuf base = STRBUF_INIT;
 
 		obj_read_lock();
-		object_type = oid_object_info(&subrepo, oid, NULL);
+		object_type = oid_object_info(subrepo, oid, NULL);
 		obj_read_unlock();
-		data = read_object_with_reference(&subrepo,
+		data = read_object_with_reference(subrepo,
 						  oid, tree_type,
 						  &size, NULL);
 		if (!data)
@@ -484,7 +505,6 @@ static int grep_submodule(struct grep_opt *opt,
 		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
-	repo_clear(&subrepo);
 	return hit;
 }
 
@@ -1182,5 +1202,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	free_repos();
 	return !hit;
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

