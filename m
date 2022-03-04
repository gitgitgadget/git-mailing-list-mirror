Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9C8C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237501AbiCDA7W (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbiCDA7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:11 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6F91405F4
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:22 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id w13-20020a1709027b8d00b0014fb4f012d3so3773560pll.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=m3OQr6dzy8LMsoOOQyCKMsA/7E5JvXbC+Yn9WukhCU4=;
        b=eXyY8X/EfB1Z4PLwLOTJgyG8Z3fxuzkXQTSS8VCsWi+HbRBjz50Pd2bqSeC44v01Ca
         ktWu3jLO50NZpONTyeKoN0oxFQDaMhxQvTW5FJCF8sYLh3KmTuHHPvBeqF1BBZgUVW89
         Sg7uR2yiALxkUjNFTMmd8qN+bNUD7BRJs5mjw0UTpna6ZLzwmBCCYHzjBbzrKsxUbLpf
         Fcjv3qEmQK3KysMOFwoQVDF0pEg5Rm1C4q0aAhxlxk3KqWimy/lM+p5WzR+pDtgvXzAb
         U3nOxVHwwodnCkSquqMgc3Lfx1iygDkfyousGDlWJGCHRCC1127YTnj9+NEMXpxActqz
         77mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m3OQr6dzy8LMsoOOQyCKMsA/7E5JvXbC+Yn9WukhCU4=;
        b=2h8Q+nDEjkSumjTaheygjKq6emdyZtyueBIvIQDxzHcPx/iijo/FJ+MNO/TYSb7yu6
         UIBk/OQnaivcBHV8mm/x8V3wsXKD1mLvIcSZmzP2JqAD1uNWV092UedNZnl0lSJ2MW09
         2YVheDGEYXJ/Q73KJQjrV1SGLu6vGu8KfCahvKfBvv5FmgILVQsrTYJQ04wBdzWxBHbq
         aJ6BUOT7bdeamHxJy1nRsT4s74X/yahE56LE9yXMhJsZPNFztOEYumCeFVDntAy5MuBG
         FZeBMmUOESUv7y3I86ZiYnMemUVmz2po+lAYW7+vfK39bKW3qoNEFC7vhT3ZWR6sv0iF
         ZIsw==
X-Gm-Message-State: AOAM530HAX+np6IdwqpCIaQ2lLFUjyMoKjQpMx04aEAlWzGWkdfNI3Sz
        LrLx8BqUVebOmdVHtL0A/JFLeefPGM5bXrf+e3BhlxkrkWUnyPfSQLbbACDrUaNr32D9wuGple/
        V48qR9uewjgdTi7KQSUWORTU/jTDJtXinzi8vDa20sCbXxONLHu7Rvt0hcShS7JQ=
X-Google-Smtp-Source: ABdhPJzDw3Xe2VxFCZhOJlnyHiAwxNv/Lg48UAtuc4Vu2HHqCXafHbBwNgAO5ggQEKZ+ZVrh54Q1cZm/wHN/cg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:ad0:b0:4e1:2d96:2ab0 with SMTP
 id c16-20020a056a000ad000b004e12d962ab0mr40750802pfl.3.1646355501741; Thu, 03
 Mar 2022 16:58:21 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:55 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-9-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 08/10] submodule: move logic into fetch_task_create()
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

