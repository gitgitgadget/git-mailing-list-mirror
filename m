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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9752C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44D36056C
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhHJS3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhHJS3W (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:22 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847A7C0613C1
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:00 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 16-20020a17090a1990b0290178031dca45so19275049pji.9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2F4GV+ndVkmWQuV1Jy8YrI9Flbyz/QGrsQZclyyddNg=;
        b=g5XL+7hukWfHvKbW0fnVim7Fe+E5hjqldwIecMJMhKXbbaLsZVZeDCP4ColJwPUimK
         Q04skRL0CnCdfH+tQcQ9WHvpM30wFnzgyTkRq6cwes/yd8e3gxQZdC6VaoTu3A3tqo3k
         J4CuLb2nLeZPEvTFlHPMzLAomzLPWou1Sygvrsgp/IHPrkf+rY5bKsC3xuNkouM1fKkt
         6GQ8wQbHwb4ikCnAvfooD5aUF91+BBkxv74vMFTdYuS4usFIbia3/+g/IjEseyVMPXfU
         YMPzmkoSe5LXt8dcK1TzxsXxvI568jHfrtx/vUjmMih/Q2oyAg3qRaKtopXzJWNq8Qfu
         E5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2F4GV+ndVkmWQuV1Jy8YrI9Flbyz/QGrsQZclyyddNg=;
        b=O7u3tFSNmjt8/TbfAVk6PMuZHv+VtYqWbLJrJ5sqITsFiJwp5LOtYe3h4uf31YTsKG
         8dbsTBivmQKWXjHO8M6vFwuIk0NnLggaGG6jdmtTHGfojQ05i5mbLZxTgZeCRgE24EBr
         pva8Pdx53pluigHL9A07Tq6nvAq6mkqFjJIZ/sfu50JxfuSnsjsGIjIXXYcxgrYkr0W0
         RwNt+nBgY17ngagdfJIZu+ZQflhyjIlFcaA9bUdCp23xqR22SeisASHXmiP+PsNWRkUo
         tsk61ueLP3xOjlmkwOJfQxxZsztHvVLwRsHapdwgrAqouCHqQNxIR/SeekoeTTPp+ggq
         wKiw==
X-Gm-Message-State: AOAM530STGGHC9p49DjZ6T1uDurfBAB0rvHuvsniIbjYqWpBAp+H6nLT
        6ckV2XsZwcyTlwafTb8rGNco1Mc8wXH/XPNtiXpnEk3RX4ImRog4Jk3V27wbKinyjT28fC3uQLC
        91bLGadXLM7T68GSnF5UnsU6U5nxm4TY0siK+wOGkxj99bG0U6RMEnV+0GCIgrMAt2Ok9HxK0wL
        E0
X-Google-Smtp-Source: ABdhPJy3mrmwQzOgvgwIrULs4waDQEZ0A/k/RRQJZT8+bE5xSTj9rBNlnE23x9gtkTYdYtg6N49IlgGasxRkjfWraY+m
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:8642:b029:12c:dda2:30c3 with
 SMTP id y2-20020a1709028642b029012cdda230c3mr838711plt.84.1628620139937; Tue,
 10 Aug 2021 11:28:59 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:43 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <f62608e88f125096c1f236a47e3ee670104c7b78.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 5/7] grep: allocate subrepos on heap
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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
 builtin/grep.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 9e61c7c993..5a40e18e47 100644
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
 
@@ -168,6 +171,17 @@ static void work_done(struct work_item *w)
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
+	free(repos_to_free);
+}
+
 static void *run(void *arg)
 {
 	int hit = 0;
@@ -415,19 +429,24 @@ static int grep_submodule(struct grep_opt *opt,
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
@@ -438,7 +457,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * subrepo's odbs to the in-memory alternates list.
 	 */
 	obj_read_lock();
-	repo_read_gitmodules(&subrepo, 0);
+	repo_read_gitmodules(subrepo, 0);
 
 	/*
 	 * NEEDSWORK: This adds the submodule's object directory to the list of
@@ -450,11 +469,11 @@ static int grep_submodule(struct grep_opt *opt,
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
@@ -464,9 +483,9 @@ static int grep_submodule(struct grep_opt *opt,
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
@@ -484,7 +503,6 @@ static int grep_submodule(struct grep_opt *opt,
 		hit = grep_cache(&subopt, pathspec, cached);
 	}
 
-	repo_clear(&subrepo);
 	return hit;
 }
 
@@ -1182,5 +1200,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		run_pager(&opt, prefix);
 	clear_pathspec(&pathspec);
 	free_grep_patterns(&opt);
+	free_repos();
 	return !hit;
 }
-- 
2.33.0.rc1.237.g0d66db33f3-goog

