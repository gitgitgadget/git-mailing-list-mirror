Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A1BC4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJQCXx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiJQCXd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E5444B4
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id az22-20020a05600c601600b003c6b72797fdso8995415wmb.5
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzkqgSkNQdq8N4dpFhyWqulPwP1qvPc/RRAdLMJF8cY=;
        b=n4okneeSG0cs6jJk0/7pA5McYudRFr+ZLPlUmPoueOnT55R7bo04xU08UJJ+lX/iGY
         RnVhNjZBK9lCYzGYYu0Sb5uTVmH60uWAXgLDi0WfJOaqxCwbs1Ub7GbpD+E2h+rdh6bF
         SqHdC6UcxVY2XE+KfBlaT71Mqf5oGnBR7gSc3LAFsu3VTZylCrebCHjjk1kbaec2x2qa
         6vEgml21zHFGZtwAC7HYBonDUmI+p4M9YOidsxEtpFO/YYGSAJn2WQWrJ5yryhPGBgvw
         w9n+e1IsFHcJm7//Ug62wjP8vR3Q+L+EYjiAXiTlEDVE56wTmYtE2Dj4uUcfL+fzWNBh
         lZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzkqgSkNQdq8N4dpFhyWqulPwP1qvPc/RRAdLMJF8cY=;
        b=I7g4xcC0PjdqDnr20nBOnQG5NOesATJkQPrab/Tb/5Yr2Q++hlCC0c6G3GtUh4TRDt
         EUYcx5PjLX07R1qxm2v8T1xMpPa+aIokhkaaK28UXas6RRRgzhkbPjK+FrmVCVTBI2Un
         MXSVg8Lh8hmoD35vX7yB42Hwq617uK9i+6jwMFcfjw0B3QFD8sB6zqpRgC21Yf8Quq9l
         U00Zh7wY23ipUCzpmxIxFWLikj48ZGJVO2xrVNdNJlhpXjtnnwUA/J1bCImL+5alWQFj
         Yg0WHa2EXukTb4pUp/KJqjRt2GjgYmGcbhRvuiKmOdot8oL0+1uB2WHJIExm90aFnCnl
         dL5g==
X-Gm-Message-State: ACrzQf07IDNHeo6YjaLuKcmKNtd+Pn28LXaMuvnXd/4FP6KfaKc5iIGj
        m60g5FARXlfs8STnVDiNHr3CE6Ms9E8=
X-Google-Smtp-Source: AMsMyM7TJS7R8lxZJPTCYpggYiRLB6VWLhK86kInjVlZ4AQW/u7FUIM+Vo277lQASNCwmUiyuN9efQ==
X-Received: by 2002:a05:600c:654f:b0:3c4:271b:6b35 with SMTP id dn15-20020a05600c654f00b003c4271b6b35mr5434987wmb.182.1665973409917;
        Sun, 16 Oct 2022 19:23:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d54c6000000b0022e2c38f8basm7155822wrv.14.2022.10.16.19.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:29 -0700 (PDT)
Message-Id: <2443c9b1b6efce4340f01930c179d2fafbc5bbb3.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:19 +0000
Subject: [PATCH v3 7/9] archive: remove global repository from archive_args
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>,
        Heather Lapointe <alpha@alphaservcomputing.solutions>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heather Lapointe <alpha@alphaservcomputing.solutions>

Remove archive_args.repo to ensure all functions are using local
repository instances.
Since all functions now have access to repo, this access isn't
needed anymore.

The main issue is that submodules do not use the same repo
as the subproject repo that is being passed around contextually.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 archive.c | 51 +++++++++++++++++++++++++++++----------------------
 archive.h |  1 -
 2 files changed, 29 insertions(+), 23 deletions(-)

diff --git a/archive.c b/archive.c
index 2cca7bc5c8a..34549d849f1 100644
--- a/archive.c
+++ b/archive.c
@@ -36,7 +36,9 @@ void init_archivers(void)
 	init_zip_archiver();
 }
 
-static void format_subst(const struct commit *commit,
+static void format_subst(
+			 struct repository *repo,
+			 const struct commit *commit,
 			 const char *src, size_t len,
 			 struct strbuf *buf, struct pretty_print_context *ctx)
 {
@@ -59,7 +61,7 @@ static void format_subst(const struct commit *commit,
 		strbuf_add(&fmt, b + 8, c - b - 8);
 
 		strbuf_add(buf, src, b - src);
-		format_commit_message(commit, fmt.buf, buf, ctx);
+		repo_format_commit_message(repo, commit, fmt.buf, buf, ctx);
 		len -= c + 1 - src;
 		src  = c + 1;
 	}
@@ -68,7 +70,9 @@ static void format_subst(const struct commit *commit,
 	free(to_free);
 }
 
-static void *object_file_to_archive(const struct archiver_args *args,
+static void *object_file_to_archive(
+				    struct repository *repo,
+				    const struct archiver_args *args,
 				    const char *path,
 				    const struct object_id *oid,
 				    unsigned int mode,
@@ -84,15 +88,15 @@ static void *object_file_to_archive(const struct archiver_args *args,
 			       (args->tree ? &args->tree->object.oid : NULL), oid);
 
 	path += args->baselen;
-	buffer = read_object_file(oid, type, sizep);
+	buffer = repo_read_object_file(repo, oid, type, sizep);
 	if (buffer && S_ISREG(mode)) {
 		struct strbuf buf = STRBUF_INIT;
 		size_t size = 0;
 
 		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
-		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &buf, &meta);
+		convert_to_working_tree(repo->index, path, buf.buf, buf.len, &buf, &meta);
 		if (commit)
-			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
+			format_subst(repo, commit, buf.buf, buf.len, &buf, args->pretty_ctx);
 		buffer = strbuf_detach(&buf, &size);
 		*sizep = size;
 	}
@@ -186,7 +190,7 @@ static int write_archive_entry(
 	    size > big_file_threshold)
 		return write_entry(repo, args, oid, path.buf, path.len, mode, NULL, size);
 
-	buffer = object_file_to_archive(args, path.buf, oid, mode, &type, &size);
+	buffer = object_file_to_archive(repo, args, path.buf, oid, mode, &type, &size);
 	if (!buffer)
 		return error(_("cannot read '%s'"), oid_to_hex(oid));
 	err = write_entry(repo, args, oid, path.buf, path.len, mode, buffer, size);
@@ -313,8 +317,8 @@ int write_archive_entries(
 		memset(&opts, 0, sizeof(opts));
 		opts.index_only = 1;
 		opts.head_idx = -1;
-		opts.src_index = args->repo->index;
-		opts.dst_index = args->repo->index;
+		opts.src_index = repo->index;
+		opts.dst_index = repo->index;
 		opts.fn = oneway_merge;
 		init_tree_desc(&t, args->tree->buffer, args->tree->size);
 		if (unpack_trees(1, &t, &opts))
@@ -322,7 +326,7 @@ int write_archive_entries(
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree(args->repo, args->tree,
+	err = read_tree(repo, args->tree,
 			&args->pathspec,
 			queue_or_write_archive_entry,
 			&context);
@@ -412,7 +416,7 @@ static int reject_entry(
 	return ret;
 }
 
-static int path_exists(struct archiver_args *args, const char *path)
+static int path_exists(struct repository *repo, struct archiver_args *args, const char *path)
 {
 	const char *paths[] = { path, NULL };
 	struct path_exists_context ctx;
@@ -421,14 +425,16 @@ static int path_exists(struct archiver_args *args, const char *path)
 	ctx.args = args;
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
-	ret = read_tree(args->repo, args->tree,
+	ret = read_tree(repo, args->tree,
 			&ctx.pathspec,
 			reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
 }
 
-static void parse_pathspec_arg(const char **pathspec,
+static void parse_pathspec_arg(
+		struct repository *repo,
+		const char **pathspec,
 		struct archiver_args *ar_args)
 {
 	/*
@@ -442,14 +448,16 @@ static void parse_pathspec_arg(const char **pathspec,
 	ar_args->pathspec.recursive = 1;
 	if (pathspec) {
 		while (*pathspec) {
-			if (**pathspec && !path_exists(ar_args, *pathspec))
+			if (**pathspec && !path_exists(repo, ar_args, *pathspec))
 				die(_("pathspec '%s' did not match any files"), *pathspec);
 			pathspec++;
 		}
 	}
 }
 
-static void parse_treeish_arg(const char **argv,
+static void parse_treeish_arg(
+		struct repository *repo,
+		const char **argv,
 		struct archiver_args *ar_args, const char *prefix,
 		int remote)
 {
@@ -475,7 +483,7 @@ static void parse_treeish_arg(const char **argv,
 	if (get_oid(name, &oid))
 		die(_("not a valid object name: %s"), name);
 
-	commit = lookup_commit_reference_gently(ar_args->repo, &oid, 1);
+	commit = lookup_commit_reference_gently(repo, &oid, 1);
 	if (commit) {
 		commit_oid = &commit->object.oid;
 		archive_time = commit->date;
@@ -484,7 +492,7 @@ static void parse_treeish_arg(const char **argv,
 		archive_time = time(NULL);
 	}
 
-	tree = parse_tree_indirect(&oid);
+	tree = repo_parse_tree_indirect(repo, &oid);
 	if (!tree)
 		die(_("not a tree object: %s"), oid_to_hex(&oid));
 
@@ -493,14 +501,14 @@ static void parse_treeish_arg(const char **argv,
 		unsigned short mode;
 		int err;
 
-		err = get_tree_entry(ar_args->repo,
+		err = get_tree_entry(repo,
 				     &tree->object.oid,
 				     prefix, &tree_oid,
 				     &mode);
 		if (err || !S_ISDIR(mode))
 			die(_("current working directory is untracked"));
 
-		tree = parse_tree_indirect(&tree_oid);
+		tree = repo_parse_tree_indirect(repo, &tree_oid);
 	}
 	ar_args->refname = ref;
 	ar_args->tree = tree;
@@ -701,7 +709,6 @@ int write_archive(int argc, const char **argv, const char *prefix,
 	ctx.abbrev = DEFAULT_ABBREV;
 	ctx.describe_status = &describe_status;
 	args.pretty_ctx = &ctx;
-	args.repo = repo;
 	args.prefix = prefix;
 	string_list_init_dup(&args.extra_files);
 	argc = parse_archive_args(argc, argv, &ar, &args, name_hint, remote);
@@ -714,8 +721,8 @@ int write_archive(int argc, const char **argv, const char *prefix,
 		setup_git_directory();
 	}
 
-	parse_treeish_arg(argv, &args, prefix, remote);
-	parse_pathspec_arg(argv + 1, &args);
+	parse_treeish_arg(repo, argv, &args, prefix, remote);
+	parse_pathspec_arg(repo, argv + 1, &args);
 
 	rc = ar->write_archive(ar, repo, &args);
 
diff --git a/archive.h b/archive.h
index bfbbd3274bd..540a3b12130 100644
--- a/archive.h
+++ b/archive.h
@@ -8,7 +8,6 @@ struct repository;
 struct pretty_print_context;
 
 struct archiver_args {
-	struct repository *repo;
 	char *refname;
 	const char *prefix;
 	const char *base;
-- 
gitgitgadget

