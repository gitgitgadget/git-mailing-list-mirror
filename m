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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9070DC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA666109E
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbhHMVGL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbhHMVGG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:06:06 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5BBC0612A3
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id kk20-20020a0562145094b029034e3ec4ffb4so8048490qvb.11
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3XoMnzdanjKGxVFJj5l5BZKbaCFlLhzXuokPGmMB2xM=;
        b=pniNXyQNu53m9VkERjgR3r4oldo/GSfwBG5D4Qafi0qdGObeGJTJPa9cot51g3+AP2
         fWoR+u7j0LdhHLiVfU10B4ZOX9F+nQU64ftnJ2wDUSLHIFpmwoqr37LilzVHm/Uuzf2Q
         NomzFzIoZx+XKHgsly5Ij+TBbeyoSsz1vbjGgGLyOO7AlZRuQHcauLM/PxqG+E/1tb5v
         NcBP9+3IGCQuMhTLb5CK2Pmjk/JhEk1B1smLOQfJbuK29mQI0V9i5H6KnG6uBiEGTWRc
         O/5RWaoXgwKE+XGbBy3kFQuYgJ+YdYWi0isYojb4ZIWa+FifMtK5q5WZkbTsof905YvJ
         bYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3XoMnzdanjKGxVFJj5l5BZKbaCFlLhzXuokPGmMB2xM=;
        b=EV2pa8N1w9EX5E3DnOiZ2GqoRO4sDe78/nUZvC+qtRyqObLyEoqSVZsICbfUL5BIaO
         +FY8LhRQautqZuSoFp66jcHyXSkX7yMgeaTmLk+60Uj0opCDzDdhS9OBJWCSPwq28Rv7
         esTLFmiKuqX3r7W5euqSRtNKg6/ETenLBJ3IQZLAvqDJJ/f2WoOkSHgAzznO930vs74U
         LNN/1R88Xgfxq2QSL6fW+51HpMplIXyykOz9RuFG8OB17B3mrzHrt5iY36IfP46eL0bd
         jx4MgZVPlUu3BUS/Quy8zqit60V0OQkI3dsK9e3U6+EUCoeBGO14ROAgOzc35M43SHuz
         joQw==
X-Gm-Message-State: AOAM530A0OFS36WTPuIix/5ZwJMb9KebVxtQ5znfk7RBJ1ODO+76l9iy
        3iZwS+XjT3VNwnjgsl7OLJd7/wlyZ9E2Pa/YpE3ntnNZi3VAjAR1F8frDTWPaTeMHLL6EQWiKRr
        hWqd9PgF1dIfWXVHvx+Z9nkwm1/YLl6h/1akbK84FypeESvCU5pPO7w4Qn1AJRZxCWYSxv1kqjc
        rs
X-Google-Smtp-Source: ABdhPJzIKvbEqLx9TJji3ROxKZTBfbqEGso9bDbw8Jcjor42nfwhjm8me1crWJ6jkVn6aii8XYwO8qnr2jaVHMuJfPI1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:76d:: with SMTP id
 f13mr4637069qvz.53.1628888736763; Fri, 13 Aug 2021 14:05:36 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:21 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <50c69a988b2afca68f06e36949e4a8cc3a93940a.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 6/8] grep: add repository to OID grep sources
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
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
 grep.h         | 13 ++++++++++++-
 3 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 69d8ea0808..d27e95e092 100644
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
index 480b3f5bba..24c6b64cea 100644
--- a/grep.h
+++ b/grep.h
@@ -120,7 +120,16 @@ struct grep_opt {
 	struct grep_pat *header_list;
 	struct grep_pat **header_tail;
 	struct grep_expr *pattern_expression;
+
+	/*
+	 * NEEDSWORK: See if we can remove this field, because the repository
+	 * should probably be per-source, not per-repo. This is potentially the
+	 * cause of at least one bug - "git grep" ignoring the textconv
+	 * attributes from submodules. See [1] for more information.
+	 * [1] https://lore.kernel.org/git/CAHd-oW5iEQarYVxEXoTG-ua2zdoybTrSjCBKtO0YT292fm0NQQ@mail.gmail.com/
+	 */
 	struct repository *repo;
+
 	const char *prefix;
 	int prefix_length;
 	regex_t regexp;
@@ -187,6 +196,7 @@ struct grep_source {
 		GREP_SOURCE_BUF,
 	} type;
 	void *identifier;
+	struct repository *repo; /* if GREP_SOURCE_OID */
 
 	char *buf;
 	unsigned long size;
@@ -198,7 +208,8 @@ struct grep_source {
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

