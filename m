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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EBEC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03CD6109D
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhHMVGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhHMVGD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:06:03 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24BE1C0617AD
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:36 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id r13-20020ac85c8d0000b029028efef0404cso7198316qta.14
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ttuIlaGEsGA2WOKX51NmgYQlRPI1mt9FbO5PiFF9ERg=;
        b=GbxlMgGawSuczhOsfW7GFDLs5JrI8pG9I1wlqoJ75oXzXsqLaGEwcKP/dqFs7WMgTP
         2VgBHCaXSsj0Qf3GXCeT++Yn/2134HhPVdDDy0+h56DtFyTWjZJW9Pw5eTNnzdnwOtbd
         n7B082wnKzA8b292gmWG46r1i/9mHtLS+2d9mQk8j6NrX4+zuAFscf50kBdTzG8LA/Ru
         fm4pYdPWdyaiIK+ZIy7+bT6DyJsmORY3BlUFYkW7FipUXdSj8H+6TYzImVf0tqb5R0XW
         LmxpKceCD0r4iERUwYMskkDefBYnHLvF0VIPP/35B4HQV6Ps3eBiUurOxYfE5nah7nxP
         dMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ttuIlaGEsGA2WOKX51NmgYQlRPI1mt9FbO5PiFF9ERg=;
        b=C3W82pADbEqfX7qTvcLdk4BOc8xtzk4tOt3SIndnkUVqpvSeB8ez2cKZ2+aSjePoLu
         FdfBLM+Zxjv5PlPSFDFx29sjiq71RvwfCXn/mFbVAn7f2HS6T1hKrL/ISSGsGicZvxYn
         9X+emVWBKupCv76HRLmP14ykKpqYHV7dZm4GJwhYIqrs4efdbBWP6vswZnoxf1MW0YGS
         3ieuVoDAj/0kOpVIPh/B2ovupRYnKUFl+LeyaqdB8Zll647saXnYz1stBYMZUYPD5HQK
         BIjHh23t/9q2g7G5kOjb8JJxYVqCajkjCzWkuPYIjvRmQTVOTx87TiSQoJmpa6O9DdGh
         OiXw==
X-Gm-Message-State: AOAM531Pnj8qjk5iLRPmLJ4nDC3BrPY+6TwKDQihCcI+ryvGW1j4deH9
        pVdYq08Py2leVBY0x3SD8SPwmPD47ue3N/VG66m3mYSEf4Zz9C+2CMOM6WwSJj6eIBmZH88gIV9
        Jt3jg2D/UvF5nKcvJKJm1nuWdOfS3rzCk6xMYy1ZOsBQXQqkYA26f0BIiBh34aJsBQohc6y7Sx6
        6g
X-Google-Smtp-Source: ABdhPJzars2NCvxQLuEy6k6dubQXGUTKxH3eHE5Ksh8O+DNUAa0Ggp3zmMFm4sNw0jiQikUA6y8ZHEwVFgfsAsp0V9RP
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:51c7:: with SMTP id
 p7mr4549099qvq.15.1628888735333; Fri, 13 Aug 2021 14:05:35 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:20 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <3f2481522404bcf66d83d02bd63b6bf682cee0ef.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 5/8] grep: allocate subrepos on heap
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
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
index 9e61c7c993..69d8ea0808 100644
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
+	free(repos_to_free);
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

