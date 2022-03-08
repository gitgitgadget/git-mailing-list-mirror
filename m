Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DBA3C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbiCHAQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245592AbiCHAQC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:16:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF137BFA
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:15:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b9-20020a17090aa58900b001b8b14b4aabso391540pjq.9
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0+DUoUS5ilqFWzyXgb3pLwZXXCHYiCAPtFOWIKm3PTw=;
        b=mUAqLeSxYNWRrljB5bJ7b0B7AJcoy5++Hej4dvxXivTx77bvohmsKxZMaad9ZaRW4m
         OxSsfOAeyjL02u+mv9Pz9uohLQf/aZR98aZpK2MC6RuV3uPpnFzfBxTIsfqjEpPKSm/e
         9ZW01OvK1DveuG5bEIR1v9/yxAPFCJ475IGDxgcAyx1uUZb3vfLI7WQELYT3g4sQ69Md
         AX7FIDcV4Wc7WA0ZxLG40rIQlMqxG2A0t9V78/eg2O/mxPQ4PfpzVPcMeTFySj64qS6D
         4YBCkCEGSo9EtkRVQGxNn1cSoCuZxDxKvegyAAR/QmlpHMmeTKx47YHqXtTEZdKXbykZ
         6ojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0+DUoUS5ilqFWzyXgb3pLwZXXCHYiCAPtFOWIKm3PTw=;
        b=USEWsKXXDCqx6ADqGQzVpn5H5GSJy5Cp8iYHEq0RNw6BCV5cL2T3/Q5DT6HDYmvcwR
         6LIpEh14eOw+41psSPntX8SQ51Jm/aeGnBwkdzCE7imPz2HTK90VCKUDHJUhxVMFJYTx
         OaW2qsDk+4YS1ga508ezquMTfjSbk5L18RxKZsvf8gi9Z9TCQwgi4YJER6QBCOVaaAF0
         aNjIl6y8fu/MY6Pqcw2cwCJvNcO/LbdhRPx5DhUeY1QXO00Yfg3iHLJ5Vc4iJHBE0PfH
         L2qGq91Ou4UEY3GwhFU/8rAvXgGHd6mZbf4edI9bafAwh+VeYiU5npgJFxy0pYs4/ri0
         Gmcg==
X-Gm-Message-State: AOAM532nVnsdn9eoG8nHkx++VQ4Wx8VseJLlgSQnRI2CRuTwD3YPzueW
        tXK+ze/C6kMwV2BorUOG8SoQ4hH6Sf3gAnugIySlFmdsOdGW06MuXFjznTIcbBcJver8a3M85q8
        u3ZcTi2H5j8O1Uep64SlMzgRQv3t7KBH4M/oUiwtNu/+nVNd5oiVwwNvbZSZvxAA=
X-Google-Smtp-Source: ABdhPJwHp+dO2r7P/GHtzzb8eJBezpRV5OKLmGoXdPjxhut8DEq3KvZ3I8XD8mTk6EZCVsAYbuy/Mrpey45uKw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:17d1:b0:1bf:1e3:ded3 with SMTP id
 me17-20020a17090b17d100b001bf01e3ded3mr1722168pjb.144.1646698505709; Mon, 07
 Mar 2022 16:15:05 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:30 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 07/10] submodule: extract get_fetch_task()
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

get_next_submodule() configures the parallel submodule fetch by
performing two functions:

* iterate the index to find submodules
* configure the child processes to fetch the submodules found in the
  previous step

Extract the index iterating code into an iterator function,
get_fetch_task(), so that get_next_submodule() is agnostic of how
to find submodules. This prepares for a subsequent commit will teach the
fetch machinery to also iterate through the list of changed
submodules (in addition to the index).

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 61 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 25 deletions(-)

diff --git a/submodule.c b/submodule.c
index 0b9c25f9d3..7a5316b6f7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1389,6 +1389,7 @@ struct fetch_task {
 	struct repository *repo;
 	const struct submodule *sub;
 	unsigned free_sub : 1; /* Do we need to free the submodule? */
+	const char *default_argv; /* The default fetch mode. */
 
 	struct oid_array *commits; /* Ensure these commits are fetched */
 };
@@ -1466,14 +1467,11 @@ static struct repository *get_submodule_repo_for(struct repository *r,
 	return ret;
 }
 
-static int get_next_submodule(struct child_process *cp,
-			      struct strbuf *err, void *data, void **task_cb)
+static struct fetch_task *
+get_fetch_task(struct submodule_parallel_fetch *spf, struct strbuf *err)
 {
-	struct submodule_parallel_fetch *spf = data;
-
 	for (; spf->count < spf->r->index->cache_nr; spf->count++) {
 		const struct cache_entry *ce = spf->r->index->cache[spf->count];
-		const char *default_argv;
 		struct fetch_task *task;
 
 		if (!S_ISGITLINK(ce->ce_mode))
@@ -1493,10 +1491,10 @@ static int get_next_submodule(struct child_process *cp,
 					&spf->changed_submodule_names,
 					task->sub->name))
 				continue;
-			default_argv = "on-demand";
+			task->default_argv = "on-demand";
 			break;
 		case RECURSE_SUBMODULES_ON:
-			default_argv = "yes";
+			task->default_argv = "yes";
 			break;
 		case RECURSE_SUBMODULES_OFF:
 			continue;
@@ -1504,29 +1502,12 @@ static int get_next_submodule(struct child_process *cp,
 
 		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
-			struct strbuf submodule_prefix = STRBUF_INIT;
-			child_process_init(cp);
-			cp->dir = task->repo->gitdir;
-			prepare_submodule_repo_env_in_gitdir(&cp->env_array);
-			cp->git_cmd = 1;
 			if (!spf->quiet)
 				strbuf_addf(err, _("Fetching submodule %s%s\n"),
 					    spf->prefix, ce->name);
-			strvec_init(&cp->args);
-			strvec_pushv(&cp->args, spf->args.v);
-			strvec_push(&cp->args, default_argv);
-			strvec_push(&cp->args, "--submodule-prefix");
-
-			strbuf_addf(&submodule_prefix, "%s%s/",
-						       spf->prefix,
-						       task->sub->path);
-			strvec_push(&cp->args, submodule_prefix.buf);
 
 			spf->count++;
-			*task_cb = task;
-
-			strbuf_release(&submodule_prefix);
-			return 1;
+			return task;
 		} else {
 			struct strbuf empty_submodule_path = STRBUF_INIT;
 
@@ -1550,6 +1531,36 @@ static int get_next_submodule(struct child_process *cp,
 			strbuf_release(&empty_submodule_path);
 		}
 	}
+	return NULL;
+}
+
+static int get_next_submodule(struct child_process *cp, struct strbuf *err,
+			      void *data, void **task_cb)
+{
+	struct submodule_parallel_fetch *spf = data;
+	struct fetch_task *task = get_fetch_task(spf, err);
+
+	if (task) {
+		struct strbuf submodule_prefix = STRBUF_INIT;
+
+		child_process_init(cp);
+		cp->dir = task->repo->gitdir;
+		prepare_submodule_repo_env_in_gitdir(&cp->env_array);
+		cp->git_cmd = 1;
+		strvec_init(&cp->args);
+		strvec_pushv(&cp->args, spf->args.v);
+		strvec_push(&cp->args, task->default_argv);
+		strvec_push(&cp->args, "--submodule-prefix");
+
+		strbuf_addf(&submodule_prefix, "%s%s/",
+						spf->prefix,
+						task->sub->path);
+		strvec_push(&cp->args, submodule_prefix.buf);
+		*task_cb = task;
+
+		strbuf_release(&submodule_prefix);
+		return 1;
+	}
 
 	if (spf->oid_fetch_tasks_nr) {
 		struct fetch_task *task =
-- 
2.33.GIT

