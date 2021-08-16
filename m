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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF3FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510D860F46
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhHPVKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233399AbhHPVKo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:10:44 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB8AC061796
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w11-20020ac857cb0000b029024e7e455d67so9902793qta.16
        for <git@vger.kernel.org>; Mon, 16 Aug 2021 14:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=E+tyuU0CUs3tZiYizbS+yAu5+FVDa72Pm9LN8Rblx3Y=;
        b=mtrWJhGErnnzZcq+Kw19HJKQHXbUUkgxA0x36sME0q947Scf89meETaMbqw5rHwYQO
         UWClZCMbketgqZ6KPKjEaueNVjuZAM9bys2U73ZLoCMrhtkMKs7DYQ+YbzTYcczcThPz
         y7fv00w/5K/8GpLU2cmr/tsc41lS6cstLwBpED/hbBoA9fLsY0IdDEwIArCYH/R8WFwj
         eZMmo1/JTeBZE4ug7NhE2iFdcXuHqwykMaXgMec7yUMhAkkMZkrpAUzHHBvvO9eXytWV
         Axo6vLh27Y9miMjFtjEeEb8Adz7h8k6Wv52AE42oAOUkMTJP4ZlsU/DFr8+iSgOZv9ls
         IUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=E+tyuU0CUs3tZiYizbS+yAu5+FVDa72Pm9LN8Rblx3Y=;
        b=HcpOyUPZeokGDK0zw7VrLX/Qqe4HHPi0LW7veO7/c6bWga8uZoDCYWw+YeUpN1fzlE
         OOnKCyU5yTwfMyea23i0f2bVk1qM+LSfkgV6RFKkZbjiCplg/Fk/kG5cEKMqJ+s5BkAd
         GhpB3RBM3fYk1fMMzUNRHomd6pmvb/9hVDcxJifvaxPAbEazGPNoGXzYOnUY0m/yGEMQ
         BYmjFYvwxab7y7f/SL+RIfB5UqAvXTcvRC4wSE+lg05XJ+5jCMvakfoPM8foXIlgeSSw
         eb/UJEj9fUVqriqNxwnqEdPzt2vIG0u6bEKaSylZnG12P/CwJpZhBEMwGnQZ3NruZehm
         ncIQ==
X-Gm-Message-State: AOAM531tOgoO3AAuX9YTjjEf6nI6Qtq4teidcdEwJJrbbFQ4dJapQA8O
        9Q4h6puk4xi7DVsJ1kJ7jcmryCAcW74pVPEno8l0Pz/+bITtQNeCxAH7m/+lPf3myKRqXaZp//H
        B8l7FRjZI4RPZhR3DPVvUQeDTO7NtHuHa2thqKEKtrGaLqlYC8wCVbkoK1PEosjAhcIzRIdCHda
        y0
X-Google-Smtp-Source: ABdhPJxuFAyh2dHYjC1UYFfxMffqZsjgrqDK+0QGT3F1hiFxy3BfjGqxRITkQW0iEj4KtxSWM/Xq6as6L5V3n+edb6bZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:194b:: with SMTP id
 q11mr34212qvk.33.1629148211129; Mon, 16 Aug 2021 14:10:11 -0700 (PDT)
Date:   Mon, 16 Aug 2021 14:09:56 -0700
In-Reply-To: <cover.1629148153.git.jonathantanmy@google.com>
Message-Id: <f362fc278cc2d0291c24097a75f8cfdfe88c27d6.1629148153.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1629148153.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 6/8] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Record the repository whenever an OID grep source is created, and teach
the worker threads to explicitly provide the repository when accessing
objects.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 15 ++++++---------
 grep.c         |  7 +++++--
 grep.h         | 17 ++++++++++++++++-
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index fa7fd08150..51278b01fa 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -349,7 +349,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct grep_source gs;
 
 	grep_source_name(opt, filename, tree_name_len, &pathbuf);
-	grep_source_init_oid(&gs, pathbuf.buf, path, oid);
+	grep_source_init_oid(&gs, pathbuf.buf, path, oid, opt->repo);
 	strbuf_release(&pathbuf);
 
 	if (num_threads > 1) {
@@ -462,14 +462,11 @@ static int grep_submodule(struct grep_opt *opt,
 	repo_read_gitmodules(subrepo, 0);
 
 	/*
-	 * NEEDSWORK: This adds the submodule's object directory to the list of
-	 * alternates for the single in-memory object store.  This has some bad
-	 * consequences for memory (processed objects will never be freed) and
-	 * performance (this increases the number of pack files git has to pay
-	 * attention to, to the sum of the number of pack files in all the
-	 * repositories processed so far).  This can be removed once the object
-	 * store is no longer global and instead is a member of the repository
-	 * object.
+	 * All code paths tested by test code no longer need submodule ODBs to
+	 * be added as alternates, but add it to the list just in case.
+	 * Submodule ODBs added through add_submodule_odb_by_path() will be
+	 * lazily registered as alternates when needed (and except in an
+	 * unexpected code interaction, it won't be needed).
 	 */
 	add_submodule_odb_by_path(subrepo->objects->odb->path);
 	obj_read_unlock();
diff --git a/grep.c b/grep.c
index 8a8105c2eb..79598f245f 100644
--- a/grep.c
+++ b/grep.c
@@ -1863,7 +1863,8 @@ void grep_source_init_file(struct grep_source *gs, const char *name,
 }
 
 void grep_source_init_oid(struct grep_source *gs, const char *name,
-			  const char *path, const struct object_id *oid)
+			  const char *path, const struct object_id *oid,
+			  struct repository *repo)
 {
 	gs->type = GREP_SOURCE_OID;
 	gs->name = xstrdup_or_null(name);
@@ -1872,6 +1873,7 @@ void grep_source_init_oid(struct grep_source *gs, const char *name,
 	gs->size = 0;
 	gs->driver = NULL;
 	gs->identifier = oiddup(oid);
+	gs->repo = repo;
 }
 
 void grep_source_clear(struct grep_source *gs)
@@ -1900,7 +1902,8 @@ static int grep_source_load_oid(struct grep_source *gs)
 {
 	enum object_type type;
 
-	gs->buf = read_object_file(gs->identifier, &type, &gs->size);
+	gs->buf = repo_read_object_file(gs->repo, gs->identifier, &type,
+					&gs->size);
 	if (!gs->buf)
 		return error(_("'%s': unable to read %s"),
 			     gs->name,
diff --git a/grep.h b/grep.h
index 480b3f5bba..128007db65 100644
--- a/grep.h
+++ b/grep.h
@@ -120,7 +120,20 @@ struct grep_opt {
 	struct grep_pat *header_list;
 	struct grep_pat **header_tail;
 	struct grep_expr *pattern_expression;
+
+	/*
+	 * NEEDSWORK: See if we can remove this field, because the repository
+	 * should probably be per-source. That is, grep.c functions using this
+	 * field should probably start using "repo" in "struct grep_source"
+	 * instead.
+	 *
+	 * This is potentially the cause of at least one bug - "git grep"
+	 * ignoring the textconv attributes from submodules. See [1] for more
+	 * information.
+	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
+	 */
 	struct repository *repo;
+
 	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
@@ -187,6 +200,7 @@ struct grep_source {
 		GREP_SOURCE_BUF,
 	} type;
 	void *identifier;
+	struct repository *repo; /* if GREP_SOURCE_OID */
 
 	char *buf;
 	unsigned long size;
@@ -198,7 +212,8 @@ struct grep_source {
 void grep_source_init_file(struct grep_source *gs, const char *name,
 			   const char *path);
 void grep_source_init_oid(struct grep_source *gs, const char *name,
-			  const char *path, const struct object_id *oid);
+			  const char *path, const struct object_id *oid,
+			  struct repository *repo);
 void grep_source_clear_data(struct grep_source *gs);
 void grep_source_clear(struct grep_source *gs);
 void grep_source_load_driver(struct grep_source *gs,
-- 
2.33.0.rc1.237.g0d66db33f3-goog

