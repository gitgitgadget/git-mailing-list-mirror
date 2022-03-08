Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC11C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242850AbiCHAP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiCHAPy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:15:54 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472DE36B60
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:14:59 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 184-20020a6215c1000000b004f6dc47ec08so4932511pfv.21
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=h856fAmmKR2FPcD3X/9dqmufQ6lG4FJy+VlTpNLRd52lzKtPJXjYTGFUy9E9edgwRU
         mOC/FM1OjUyYoHJmbGKGPuBpfybud56hypnrFnZsng+EB1Lvihmwl9XyM0dMHS2b+S6l
         Y9flbNDqd8HI8KZXLGdlFTIGVy4a4kf/cQz1zHNE3xOB2r8L9xH4cIpD/1pCEyK4njoC
         zFqZ0nLnrUru0k4hOAKDVs04GJhA87ZDUCHxpln8qwZDycOqdWcq4bBLXm2n92vI3qtT
         qLQIGhdlbCUJbXL52l6AndEQpRcMxixWPvxjeattghBIjVQe1XwyxkZeZbasbx7TErX1
         VXYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=jMKFFMj25zrRdrj/VKq4uwdhmkhAO9UMRLTmQPqt2tU=;
        b=MhQ7xzoV1zWWHe9YWJW8Yyni0D+jlPPMzLrRZm9FmCf9ySNX0mw9fjxxXKE+eRC4O+
         ZNRK7PM1PkjW+l/7V08UgG5OhKT2bBNLzdB1z4Px+2/lt5CrbmCmvhS2K0SML1gqRrbu
         00Ry4ITJ88ild+St/qL/S5v1fIykDcX7lYcHMZIKgr5ja3e/fWi2cRfXDlsVaWDrTh/1
         KbBmNB1ZJ7HrDw/DBkaFxwUv0D74nzBGqeTlmxvEcPabIy5NYvMmvkb4P70ToeQR4TTX
         BZrV3Xf4RN6DuMeQBNoEqYBeGgo6ve7GCZwEuBwEVt1ikUygX4/HzN1GR2mClZcPZQld
         d7zQ==
X-Gm-Message-State: AOAM533rSn1qACVNq2WjnPUD4EFChOOhdCcDid5li38HRSO3Wz2he3Ua
        UhLK6hWah82FFxh8o1B0iGpJsNod3WC1aD0Eg24zVZPWglFbFQoJMb7v/WWhZwogTbzai3ITLCY
        7G+r5AzxzyW6ilF9494txiKh1AqHVWxIYTU+jwR2I2K3ds+41LnLFFq3YnpvTw5Y=
X-Google-Smtp-Source: ABdhPJxqh6U/Hr5UsjDhZW7ltVOJ7baNR7N8IBnPD49xN4+X4X5k3MGbs7IaCDqBFMtSnt+65mrAgy6NyqP7oQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f605:b0:14f:5d75:4fb0 with SMTP
 id n5-20020a170902f60500b0014f5d754fb0mr14561727plg.101.1646698498586; Mon,
 07 Mar 2022 16:14:58 -0800 (PST)
Date:   Mon,  7 Mar 2022 16:14:27 -0800
In-Reply-To: <20220308001433.94995-1-chooglen@google.com>
Message-Id: <20220308001433.94995-5-chooglen@google.com>
Mime-Version: 1.0
References: <20220304005757.70107-1-chooglen@google.com> <20220308001433.94995-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v5 04/10] submodule: make static functions read submodules
 from commits
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

A future commit will teach "fetch --recurse-submodules" to fetch
unpopulated submodules. To prepare for this, teach the necessary static
functions how to read submodules from superproject commits using a
"treeish_name" argument (instead of always reading from the index and
filesystem) but do not actually change where submodules are read from.
Submodules will be read from commits when we fetch unpopulated
submodules.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 submodule.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/submodule.c b/submodule.c
index 5ace18a7d9..4f3300f2cb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -932,6 +932,7 @@ struct has_commit_data {
 	struct repository *repo;
 	int result;
 	const char *path;
+	const struct object_id *super_oid;
 };
 
 static int check_has_commit(const struct object_id *oid, void *data)
@@ -940,7 +941,7 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	struct repository subrepo;
 	enum object_type type;
 
-	if (repo_submodule_init(&subrepo, cb->repo, cb->path, null_oid())) {
+	if (repo_submodule_init(&subrepo, cb->repo, cb->path, cb->super_oid)) {
 		cb->result = 0;
 		goto cleanup;
 	}
@@ -968,9 +969,15 @@ static int check_has_commit(const struct object_id *oid, void *data)
 
 static int submodule_has_commits(struct repository *r,
 				 const char *path,
+				 const struct object_id *super_oid,
 				 struct oid_array *commits)
 {
-	struct has_commit_data has_commit = { r, 1, path };
+	struct has_commit_data has_commit = {
+		.repo = r,
+		.result = 1,
+		.path = path,
+		.super_oid = super_oid
+	};
 
 	/*
 	 * Perform a cheap, but incorrect check for the existence of 'commits'.
@@ -1017,7 +1024,7 @@ static int submodule_needs_pushing(struct repository *r,
 				   const char *path,
 				   struct oid_array *commits)
 {
-	if (!submodule_has_commits(r, path, commits))
+	if (!submodule_has_commits(r, path, null_oid(), commits))
 		/*
 		 * NOTE: We do consider it safe to return "no" here. The
 		 * correct answer would be "We do not know" instead of
@@ -1277,7 +1284,7 @@ static void calculate_changed_submodule_paths(struct repository *r,
 		if (!path)
 			continue;
 
-		if (submodule_has_commits(r, path, commits)) {
+		if (submodule_has_commits(r, path, null_oid(), commits)) {
 			oid_array_clear(commits);
 			*name->string = '\0';
 		}
@@ -1402,12 +1409,13 @@ static const struct submodule *get_non_gitmodules_submodule(const char *path)
 }
 
 static struct fetch_task *fetch_task_create(struct repository *r,
-					    const char *path)
+					    const char *path,
+					    const struct object_id *treeish_name)
 {
 	struct fetch_task *task = xmalloc(sizeof(*task));
 	memset(task, 0, sizeof(*task));
 
-	task->sub = submodule_from_path(r, null_oid(), path);
+	task->sub = submodule_from_path(r, treeish_name, path);
 	if (!task->sub) {
 		/*
 		 * No entry in .gitmodules? Technically not a submodule,
@@ -1439,11 +1447,12 @@ static void fetch_task_release(struct fetch_task *p)
 }
 
 static struct repository *get_submodule_repo_for(struct repository *r,
-						 const char *path)
+						 const char *path,
+						 const struct object_id *treeish_name)
 {
 	struct repository *ret = xmalloc(sizeof(*ret));
 
-	if (repo_submodule_init(ret, r, path, null_oid())) {
+	if (repo_submodule_init(ret, r, path, treeish_name)) {
 		free(ret);
 		return NULL;
 	}
@@ -1464,7 +1473,7 @@ static int get_next_submodule(struct child_process *cp,
 		if (!S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		task = fetch_task_create(spf->r, ce->name);
+		task = fetch_task_create(spf->r, ce->name, null_oid());
 		if (!task)
 			continue;
 
@@ -1487,7 +1496,7 @@ static int get_next_submodule(struct child_process *cp,
 			continue;
 		}
 
-		task->repo = get_submodule_repo_for(spf->r, task->sub->path);
+		task->repo = get_submodule_repo_for(spf->r, task->sub->path, null_oid());
 		if (task->repo) {
 			struct strbuf submodule_prefix = STRBUF_INIT;
 			child_process_init(cp);
-- 
2.33.GIT

