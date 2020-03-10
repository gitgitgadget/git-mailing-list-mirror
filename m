Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF72C18E5B
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD2720873
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 13:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCLJA74K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgCJNLd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38620 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgCJNLc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n2so1287164wmc.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 06:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0Mjzsh71QKQicvKes1AlKy0nsmsEetH3MrEAXj28LcI=;
        b=jCLJA74KoYL1vs7i+RTOUlAGSjHwy7m6zoPPikuGTozjl4m/xBc+HOWcrIiwpXJZf/
         r32ThKa5+jd3c5oqnPnaoteVtUXW1inoUi2P8QpY/0Pd/vCYKdYHRCSZmIkAa1RaAaYs
         7ccOC0cQo1K49xGPjDVTwH39aSJ7hT3qVwUkv++PJ1bnJh4Fm+aYzTK8H4XKq8d8FDWh
         4U8CyPkV4oABwViKZUFxkVkSlj4xW382xzbHnn2CEkin7Gmfy3MTTI8uur41oucAnWKC
         xddnwYVSQJ9QvwbFfKuJ5aq0ekBvn71EwR5tXNaRirgzS9GeJiRFh6HAp4XgTecb4V02
         iPQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0Mjzsh71QKQicvKes1AlKy0nsmsEetH3MrEAXj28LcI=;
        b=TDefMJ9Kd/bE4lqqiruCzzAHGH6EmOEKNFlkr0JhJslqn7H+l84pfsWsice2CEWeqV
         izHVx6YBQdH6WrY78NGeX3HViXvxM0mZ19+dDOrx4KcqLYiC3U2VeJ5t1v7w2s3i0l6H
         +hCInbkr0TqOn7mrb+L8nF6hRl/m3r640B1NvUlMcbfbf+2U2TDX3B4X+T6tAq2WMiD2
         5lgqZkSrhQNuOP33WTfbBC7bIxYpbz7erPd+2+/0JUNsRGVwMYzHtG3wNq+/B6/OXcw1
         k1wWLcZpO0AhTzZwWSF51/9LLV7Y/CunKyGK930fjQf0SfkaZXxbj941YaQMoeEWxXKx
         z18w==
X-Gm-Message-State: ANhLgQ1uxNizeZK5Fu48ShJqoAkwV8fumhhPefbUOhywMgvI+xXNeuWG
        J/s9N/bO4V/kMYbGQrwf3MklR27k
X-Google-Smtp-Source: ADFU+vtn5KOTCkwdzhPmYNUsGxyTtz4khbiRPvq5nAWQYVzWJmm4Gwt4negI1/ZEu3242josRdXI2A==
X-Received: by 2002:a1c:23ca:: with SMTP id j193mr2175767wmj.111.1583845890231;
        Tue, 10 Mar 2020 06:11:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c72sm3944697wme.35.2020.03.10.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:11:29 -0700 (PDT)
Message-Id: <a49176386710de97bfe92defd92b7861ef7242fb.1583845884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
References: <pull.575.git.1583521396.gitgitgadget@gmail.com>
        <pull.575.v2.git.1583845884.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Mar 2020 13:11:23 +0000
Subject: [PATCH v2 3/4] real_path_if_valid(): remove unsafe API
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

This commit continues the work started with previous commit.

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 abspath.c   | 10 ----------
 cache.h     |  1 -
 setup.c     |  2 +-
 sha1-file.c | 13 ++++---------
 submodule.c |  7 ++++---
 worktree.c  |  7 +++++--
 6 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/abspath.c b/abspath.c
index d34026bfeb8..6f15a418bb6 100644
--- a/abspath.c
+++ b/abspath.c
@@ -202,16 +202,6 @@ char *strbuf_realpath(struct strbuf *resolved, const char *path,
 	return retval;
 }
 
-/*
- * Resolve `path` into an absolute, cleaned-up path. The return value
- * comes from a shared buffer.
- */
-const char *real_path_if_valid(const char *path)
-{
-	static struct strbuf realpath = STRBUF_INIT;
-	return strbuf_realpath(&realpath, path, 0);
-}
-
 char *real_pathdup(const char *path, int die_on_error)
 {
 	struct strbuf realpath = STRBUF_INIT;
diff --git a/cache.h b/cache.h
index f6937793ec2..aa3f5ce718a 100644
--- a/cache.h
+++ b/cache.h
@@ -1314,7 +1314,6 @@ static inline int is_absolute_path(const char *path)
 int is_directory(const char *);
 char *strbuf_realpath(struct strbuf *resolved, const char *path,
 		      int die_on_error);
-const char *real_path_if_valid(const char *path);
 char *real_pathdup(const char *path, int die_on_error);
 const char *absolute_path(const char *path);
 char *absolute_pathdup(const char *path);
diff --git a/setup.c b/setup.c
index 1ae3f203016..9e8fa46bc78 100644
--- a/setup.c
+++ b/setup.c
@@ -886,7 +886,7 @@ static dev_t get_device_or_die(const char *path, const char *prefix, int prefix_
 
 /*
  * A "string_list_each_func_t" function that canonicalizes an entry
- * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
+ * from GIT_CEILING_DIRECTORIES using real_pathdup(), or
  * discards it if unusable.  The presence of an empty entry in
  * GIT_CEILING_DIRECTORIES turns off canonicalization for all
  * subsequent entries.
diff --git a/sha1-file.c b/sha1-file.c
index 616886799e5..f2b24654895 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -676,20 +676,15 @@ void add_to_alternates_memory(const char *reference)
 char *compute_alternate_path(const char *path, struct strbuf *err)
 {
 	char *ref_git = NULL;
-	const char *repo, *ref_git_s;
+	const char *repo;
 	int seen_error = 0;
 
-	ref_git_s = real_path_if_valid(path);
-	if (!ref_git_s) {
+	ref_git = real_pathdup(path, 0);
+	if (!ref_git) {
 		seen_error = 1;
 		strbuf_addf(err, _("path '%s' does not exist"), path);
 		goto out;
-	} else
-		/*
-		 * Beware: read_gitfile(), real_path() and mkpath()
-		 * return static buffer
-		 */
-		ref_git = xstrdup(ref_git_s);
+	}
 
 	repo = read_gitfile(ref_git);
 	if (!repo)
diff --git a/submodule.c b/submodule.c
index bad7a788c06..215c62580fc 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2173,7 +2173,7 @@ const char *get_superproject_working_tree(void)
 	static struct strbuf realpath = STRBUF_INIT;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf sb = STRBUF_INIT;
-	const char *one_up = real_path_if_valid("../");
+	struct strbuf one_up = STRBUF_INIT;
 	const char *cwd = xgetcwd();
 	const char *ret = NULL;
 	const char *subpath;
@@ -2188,10 +2188,11 @@ const char *get_superproject_working_tree(void)
 		 */
 		return NULL;
 
-	if (!one_up)
+	if (!strbuf_realpath(&one_up, "../", 0))
 		return NULL;
 
-	subpath = relative_path(cwd, one_up, &sb);
+	subpath = relative_path(cwd, one_up.buf, &sb);
+	strbuf_release(&one_up);
 
 	prepare_submodule_repo_env(&cp.env_array);
 	argv_array_pop(&cp.env_array);
diff --git a/worktree.c b/worktree.c
index e7bbf716f6b..543472f0c7b 100644
--- a/worktree.c
+++ b/worktree.c
@@ -226,17 +226,20 @@ struct worktree *find_worktree(struct worktree **list,
 
 struct worktree *find_worktree_by_path(struct worktree **list, const char *p)
 {
+	struct strbuf wt_path = STRBUF_INIT;
 	char *path = real_pathdup(p, 0);
 
 	if (!path)
 		return NULL;
 	for (; *list; list++) {
-		const char *wt_path = real_path_if_valid((*list)->path);
+		if (!strbuf_realpath(&wt_path, (*list)->path, 0))
+			continue;
 
-		if (wt_path && !fspathcmp(path, wt_path))
+		if (!fspathcmp(path, wt_path.buf))
 			break;
 	}
 	free(path);
+	strbuf_release(&wt_path);
 	return *list;
 }
 
-- 
gitgitgadget

