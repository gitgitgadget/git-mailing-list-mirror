Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2231C433FE
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244460AbiCHAQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243351AbiCHAQF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:16:05 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB81F36E14
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:15:08 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id cl16-20020a17090af69000b001beea61ada4so7033859pjb.5
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m3OQr6dzy8LMsoOOQyCKMsA/7E5JvXbC+Yn9WukhCU4=;
        b=N4QxvEPz0/hn8FayMDmzzKRcufCQ1A+mwrxBSnAv7cQ839SfDCGyWocY5HeNiPhoSx
         eQsoAA6XmEhQn78mQ7d5jxcNAeNsSADlVuMQA71o+IrrzeeoJedUb1Uf/n/ldJSOo5o2
         5X0Efp8uzHIjqGD0UHh0wI9oYywumJoWP13FEES+1Q10z9cYyPw17j9aysGdjD+MIlpS
         6ZI9NVENKWGJtXZob0ZA5ZDKKi/+l7kF3MJp9+QKOWYSCX2VVHeAqRvy9T2IGGwxjwIQ
         tmx5vGbYg/llbfVrEPzb9wGqOQFNS5myjV29fs/Jc5cs04fjVR409k+01nB/hpTeC8nx
         k58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m3OQr6dzy8LMsoOOQyCKMsA/7E5JvXbC+Yn9WukhCU4=;
        b=hSOuJaliz7Zz9imNpLRwgrcv865T6Vp9zNBMXa45TnauM9ud4KkhK2GkxXbRYsRd1K
         fcVEZ14xYQ5zwozJWhGjL8fJ0WDaCJEkwdeN65gt+Rd/MLEa05WnDXiYUI+EDf+I9eiX
         sHEsOVZmW8L7epW2Nkz3eW313GAq0wIdGt+33kloanlxYIVP6sAyHrus7vlN+6w62clN
         sZ4hZRD+W+aZ6KR+Tem1OttZx0Rvzcbx+WizYS8gzS3s3/hhUgkTmWHDi5K9HWNODQ5h
         cEqIsYZREKnrZRDOh8TmGKUZlatfTwJ80TcHQqBcWCZhFTi674tfuE9EvUToX/7NxdKN
         YR3Q==
X-Gm-Message-State: AOAM533IlKsfsMg2egjnzpHU/q7KgccBmC8ek7wiNe7QOXiBIqTDEJLW
        CPRMp8xTtf66fvnLVRMrIfqxNbZqLmE1HhoYUWqxr1CK+TWiOsZJL6NlX19U/6vzt/mKR/D1//K
        t0S/8XUYdHlUvr10XqtBBC4UCb1eKZc9SLM9RrcIkgKjxVpI8aQEqExCe2UZ/yTg=
X-Google-Smtp-Source: ABdhPJz2u2Q1A1INeY+7Ax3iCzH1B4lqJRZrWDlzR5NcXAJZscquGT0uG3AtKX3HlQHpzmHrhMn8hyyY5EYHaQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:e7cf:b0:1bf:4f60:b191 with SMTP
 id kb15-20020a17090ae7cf00b001bf4f60b191mr270557pjb.0.1646698507756; Mon, 07
 Mar 2022 16:15:07 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:31 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 08/10] submodule: move logic into fetch_task_create()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

get_fetch_task() gets a fetch task by iterating the index; a future
commit will introduce a similar function, get_fetch_task_from_changed(),
that gets a fetch task from the list of changed submodules. Both
functions are similar in that they need to:

* create a fetch task
* initialize the submodule repo for the fetch task
* determine the default recursion mode

Move all of this logic into fetch_task_create() so that it is no longer
split between fetch_task_create() and get_fetch_task(). This will make
it easier to share code with get_fetch_task_from_changed().

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 99 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 52 insertions(+), 47 deletions(-)

diff --git a/submodule.c b/submodule.c
index 7a5316b6f7..b36ef26752 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1415,32 +1415,6 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
 	return (const struct submodule *) ret;
 }
 
-static struct fetch_task *fetch_task_create(struct repository *r,
-					    const char *path,
-					    const struct object_id *treeish_name)
-{
-	struct fetch_task *task = xmalloc(sizeof(*task));
-	memset(task, 0, sizeof(*task));
-
-	task->sub = submodule_from_path(r, treeish_name, path);
-	if (!task->sub) {
-		/*
-		 * No entry in .gitmodules? Technically not a submodule,
-		 * but historically we supported repositories that happen to be
-		 * in-place where a gitlink is. Keep supporting them.
-		 */
-		task->sub = get_non_gitmodules_submodule(path);
-		if (!task->sub) {
-			free(task);
-			return NULL;
-		}
-
-		task->free_sub = 1;
-	}
-
-	return task;
-}
-
 static void fetch_task_release(struct fetch_task *p)
 {
 	if (p->free_sub)
@@ -1467,6 +1441,57 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	return ret;
 }
 
+static struct fetch_task *fetch_task_create(struct submodule_parallel_fetch *spf,
+					    const char *path,
+					    const struct object_id *treeish_name)
+{
+	struct fetch_task *task = xmalloc(sizeof(*task));
+	memset(task, 0, sizeof(*task));
+
+	task->sub = submodule_from_path(spf->r, treeish_name, path);
+
+	if (!task->sub) {
+		/*
+		 * No entry in .gitmodules? Technically not a submodule,
+		 * but historically we supported repositories that happen to be
+		 * in-place where a gitlink is. Keep supporting them.
+		 */
+		task->sub = get_non_gitmodules_submodule(path);
+		if (!task->sub)
+			goto cleanup;
+
+		task->free_sub = 1;
+	}
+
+	switch (get_fetch_recurse_config(task->sub, spf))
+	{
+	default:
+	case RECURSE_SUBMODULES_DEFAULT:
+	case RECURSE_SUBMODULES_ON_DEMAND:
+		if (!task->sub ||
+			!string_list_lookup(
+				&spf->changed_submodule_names,
+				task->sub->name))
+			goto cleanup;
+		task->default_argv = "on-demand";
+		break;
+	case RECURSE_SUBMODULES_ON:
+		task->default_argv = "yes";
+		break;
+	case RECURSE_SUBMODULES_OFF:
+		goto cleanup;
+	}
+
+	task->repo = get_submodule_repo_for(spf->r, path, treeish_name);
+
+	return task;
+
+ cleanup:
+	fetch_task_release(task);
+	free(task);
+	return NULL;
+}
+
 static struct fetch_task *
 get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 {
@@ -1477,30 +1502,10 @@ get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name, null_oid());
+		task = fetch_task_create(spf, ce->name, null_oid());
 		if (!task)
 			continue;
 
-		switch (get_fetch_recurse_config(task->sub, spf))
-		{
-		default:
-		case RECURSE_SUBMODULES_DEFAULT:
-		case RECURSE_SUBMODULES_ON_DEMAND:
-			if (!task->sub ||
-			    !string_list_lookup(
-					&spf->changed_submodule_names,
-					task->sub->name))
-				continue;
-			task->default_argv = "on-demand";
-			break;
-		case RECURSE_SUBMODULES_ON:
-			task->default_argv = "yes";
-			break;
-		case RECURSE_SUBMODULES_OFF:
-			continue;
-		}
-
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
-- 
2.33.GIT

