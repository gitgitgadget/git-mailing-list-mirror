Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53B4C433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbiCDA7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiCDA7L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:59:11 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936E13AA3B
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:58:20 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id d10-20020a17090a564a00b001beeadd3da1so3866988pji.3
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 16:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0+DUoUS5ilqFWzyXgb3pLwZXXCHYiCAPtFOWIKm3PTw=;
        b=R/RRVCgABltLqeOAYLRfg7PXNUpgNoIxO2JrkuX2Cz+Nn4vUjyZZPkE4mHJ0FkURsP
         /G4kViVHLViWOUjcmNJRhF7qxfsL4cQ3Czc3Ws6QR6a2Bsl2ghg7miYcZzUS65j4ywmP
         UlaI1AkMSQ09/ghfcBDe8OaziYDhvAWfPk7uTkdsv7ap+0ZyBVEBHvVYQORycyi7gjKl
         vp8fczEOFAz+NSnjTJ+N4nEnez+zQnDGFSuJ11oels7xPvwsmIJZScHqsESFoMDaqfd9
         Xj+dIgm3f79DUe7Wv2s3EKaVfoT1bBmJ6IE4P1FkFLwqA/zkdVat0HqcHTXQSd1yi/22
         S+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0+DUoUS5ilqFWzyXgb3pLwZXXCHYiCAPtFOWIKm3PTw=;
        b=5dTMgBt/q/GPBSWOryXVF0nwjyXfNw/tukFL6Bi6Mi2L9SbdYhJnBCrlkkPpPxNfxZ
         IAP2ufcmVW+TWBVfeJFOnRzUzQ7032JiVSa1zds9JQ0+whjvIRiN0XrNZLFR/JpF3LLt
         14UPLugVXJZtf6g9zpqbZ+jgJIO2rFk3a9kXCuyIIxaQ+ioUyhsAQ5+M9iNCvBZgyFro
         e+325BfBIri55Ru6jJl5c4Q9BGPct8Ya18g01YphSpWszZEzUCLf2BIkvLFdpLGFEmDW
         4zIp+pSZtjPdHnpeHvwF4RocKhKvhkM6Zr2Oya9J+MQ8ny06WwMIalEPc8jlUcfYWu14
         pNpw==
X-Gm-Message-State: AOAM532oe3tgLp3x7j5jpvstW4N/CQdGLozxX7jFk1hEce7Vx6F3hsaK
        5w0csYfokC++TnSU5/ZVpabzCuSzPRTOHA0vb06gH06CFkECN+fLqO+yd5qhkKjn8PTRmovodCc
        Wuzdy/RTC/Afh/y/CTQbJxD/glED7WGvzf0yK+uMynNl3bmURYzFjTyvhCT/0YZI=
X-Google-Smtp-Source: ABdhPJyfeKt0oX9yW9RB7cChasdJ8jm6UAwDC6YHC8s9jNppGRYMwXdZdllejYL4H0I7uxvEXdSWgLWBkbwgoA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:c61:0:b0:370:592b:3ad1 with SMTP id
 33-20020a630c61000000b00370592b3ad1mr32233478pgm.240.1646355499653; Thu, 03
 Mar 2022 16:58:19 -0800 (PST)
Date:   Thu,  3 Mar 2022 16:57:54 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com>
Message-Id: <20220304005757.70107-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220224100842.95827-1-chooglen@google.com> <20220304005757.70107-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 07/10] submodule: extract get_fetch_task()
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

