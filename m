Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD3EC83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C6402053B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 08:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="olGHGFgZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgD1Igp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726377AbgD1Igo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 04:36:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE168C03C1A9
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 01:36:43 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id fb4so9988359qvb.7
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 01:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UC0WInV9S7+vWNvgyP9lf/ekTIZMEbRkJERE3mn81vU=;
        b=olGHGFgZxOqJiwtAzaEwARffJCPwXsdkI4EDn1fTlOZGdtGMR/H/vYmmZklUr0heKv
         FyZ7bFuDYPUxF7lgUVaTLFMxicioQxFV0Bq6CQkHGKuz9T4+FRYXhQugxJp0pOv9A9TC
         9nKc3Nz1I8sdUq6vs4MUckMiV9FZFuiHCsgmDX3UU1X/+2uKHEU9sObWJKy5GeROCQ8S
         DshfAPA828VJK45Y2e0UdOllOLfCI/R0qtilnTYXm2IAi2vCRPy4yD1RafzX/clngnwd
         UP0oogAd+8lqrxkQmSBc1zg751RXUwVpE/Id9BqGqcSvYAQXAoT9L0e2Hk/aW9VGzHq4
         6shw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UC0WInV9S7+vWNvgyP9lf/ekTIZMEbRkJERE3mn81vU=;
        b=gaThUSnutLXuQqYl49KHN4E6iziFFdaYpXtDOLAVcY4ZE9EWENTZywnPi09h6m8jZY
         vPdTJgFKuCM+4zU/UK5aCBQWXJOqgC58Av186i4tKJkcukoghzDRGPmOuT76Vk+OHu1Y
         cCbqpOls1lqd+siXj713V93WlLOX6cT81FDBwM++DRwIcmR0HI2oIdUNzMBSYJw1d3Wj
         BA8tPJu9G9n9AfOtYllIaAbV3Kepo9Qi7GM2DWbLa3uZsjd+TE5UZsqUzayS1NXIEQh1
         XNE7O52jI+wjDkpYj/hIOhG24Mig978MqCNl/kth4mAqP+WW+YUOsunfU/piXy7Gptg+
         KwMw==
X-Gm-Message-State: AGi0PuZI1uuiKq6lXv0IeKckqNX+28AZAjrSjJRvBTUHCP/l5SWIOUv4
        S3fhXL+jpeVMpVL+x2zKJqFwouyH
X-Google-Smtp-Source: APiQypJ3nc4bJ6YPX3O8BFL2YF3aUZeW6IQTfmcSGxp7iBdVjQI78YZ2i4Ef3VesPT7aA5wGPLLcbA==
X-Received: by 2002:a0c:9a4f:: with SMTP id q15mr23822926qvd.132.1588063000375;
        Tue, 28 Apr 2020 01:36:40 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id j25sm12755669qtn.21.2020.04.28.01.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 01:36:38 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Andrew White <andrew.white@audinate.com>
Subject: [PATCH] Use OPT_CALLBACK and OPT_CALLBACK_F
Date:   Tue, 28 Apr 2020 04:36:28 -0400
Message-Id: <d6d35a21a5bb1077eea4dd49f5716bece9e015de.1588062647.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <xmqq7dy092tq.fsf@gitster.c.googlers.com>
References: <xmqq7dy092tq.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the codebase, there are many options which use OPTION_CALLBACK in a
plain ol' struct definition. However, we have the OPT_CALLBACK and
OPT_CALLBACK_F macros which are meant to abstract these plain struct
definitions away. These macros are useful as they semantically signal to
developers that these are just normal callback option with nothing fancy
happening.

Replace plain struct definitions of OPTION_CALLBACK with OPT_CALLBACK or
OPT_CALLBACK_F where applicable. The heavy lifting was done using the
following (disgusting) shell script:

	#!/bin/sh

	do_replacement () {
		tr '\n' '\r' |
			sed -e 's/{\s*OPTION_CALLBACK,\s*\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\s*0,\(\s*[^[:space:]}]*\)\s*}/OPT_CALLBACK(\1,\2,\3,\4,\5,\6)/g' |
			sed -e 's/{\s*OPTION_CALLBACK,\s*\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\(\s*[^[:space:]}]*\)\s*}/OPT_CALLBACK_F(\1,\2,\3,\4,\5,\6,\7)/g' |
			tr '\r' '\n'
	}

	for f in $(git ls-files \*.c)
	do
		do_replacement <"$f" >"$f.tmp"
		mv "$f.tmp" "$f"
	done

The result was manually inspected and then reformatted to match the
style of the surrounding code. Finally, using
`git grep OPTION_CALLBACK \*.c`, leftover results which were not handled
by the script were manually transformed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
I didn't really like the idea of just changing this one case while
leaving the many other cases behind so I spent a bit of time coming up
with a more general solution that should hopefully fix this problem in
all the cases where this is happening.

I contemplated breaking this down into file-sized patches but I don't
think it really makes sense in this case since it's the same change
which is being made in each file and, imo, it wouldn't really ease
reviewer burden since the same number of changes are being reviewed.

 apply.c                       | 28 +++++++++---------
 builtin/add.c                 |  4 +--
 builtin/blame.c               |  4 +--
 builtin/branch.c              |  6 ++--
 builtin/cat-file.c            |  8 +++---
 builtin/checkout-index.c      |  4 +--
 builtin/checkout.c            |  4 +--
 builtin/clean.c               |  4 +--
 builtin/commit-tree.c         | 12 ++++----
 builtin/commit.c              |  8 +++---
 builtin/fetch.c               | 12 ++++----
 builtin/grep.c                | 26 ++++++++---------
 builtin/interpret-trailers.c  |  4 +--
 builtin/log.c                 | 54 +++++++++++++++++------------------
 builtin/ls-files.c            | 12 ++++----
 builtin/merge.c               |  4 +--
 builtin/notes.c               | 32 ++++++++++-----------
 builtin/pack-objects.c        | 12 ++++----
 builtin/pull.c                |  8 +++---
 builtin/push.c                | 17 +++++------
 builtin/read-tree.c           | 12 ++++----
 builtin/rebase.c              | 20 ++++++-------
 builtin/remote.c              |  4 +--
 builtin/reset.c               |  4 +--
 builtin/send-pack.c           | 10 +++----
 builtin/shortlog.c            |  4 +--
 builtin/show-branch.c         |  4 +--
 builtin/show-ref.c            | 12 ++++----
 builtin/tag.c                 |  4 +--
 builtin/update-index.c        | 16 +++++------
 list-objects-filter-options.h |  6 ++--
 31 files changed, 175 insertions(+), 184 deletions(-)

diff --git a/apply.c b/apply.c
index 144c19aaca..8bff604dbe 100644
--- a/apply.c
+++ b/apply.c
@@ -4964,15 +4964,15 @@ int apply_parse_options(int argc, const char **argv,
 			const char * const *apply_usage)
 {
 	struct option builtin_apply_options[] = {
-		{ OPTION_CALLBACK, 0, "exclude", state, N_("path"),
+		OPT_CALLBACK_F(0, "exclude", state, N_("path"),
 			N_("don't apply changes matching the given path"),
-			PARSE_OPT_NONEG, apply_option_parse_exclude },
-		{ OPTION_CALLBACK, 0, "include", state, N_("path"),
+			PARSE_OPT_NONEG, apply_option_parse_exclude),
+		OPT_CALLBACK_F(0, "include", state, N_("path"),
 			N_("apply changes matching the given path"),
-			PARSE_OPT_NONEG, apply_option_parse_include },
-		{ OPTION_CALLBACK, 'p', NULL, state, N_("num"),
+			PARSE_OPT_NONEG, apply_option_parse_include),
+		OPT_CALLBACK('p', NULL, state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
-			0, apply_option_parse_p },
+			apply_option_parse_p),
 		OPT_BOOL(0, "no-add", &state->no_add,
 			N_("ignore additions made by the patch")),
 		OPT_BOOL(0, "stat", &state->diffstat,
@@ -5005,15 +5005,15 @@ int apply_parse_options(int argc, const char **argv,
 			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &state->p_context,
 				N_("ensure at least <n> lines of context match")),
-		{ OPTION_CALLBACK, 0, "whitespace", state, N_("action"),
+		OPT_CALLBACK(0, "whitespace", state, N_("action"),
 			N_("detect new or modified lines that have whitespace errors"),
-			0, apply_option_parse_whitespace },
-		{ OPTION_CALLBACK, 0, "ignore-space-change", state, NULL,
+			apply_option_parse_whitespace),
+		OPT_CALLBACK_F(0, "ignore-space-change", state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, apply_option_parse_space_change },
-		{ OPTION_CALLBACK, 0, "ignore-whitespace", state, NULL,
+			PARSE_OPT_NOARG, apply_option_parse_space_change),
+		OPT_CALLBACK_F(0, "ignore-whitespace", state, NULL,
 			N_("ignore changes in whitespace when finding context"),
-			PARSE_OPT_NOARG, apply_option_parse_space_change },
+			PARSE_OPT_NOARG, apply_option_parse_space_change),
 		OPT_BOOL('R', "reverse", &state->apply_in_reverse,
 			N_("apply the patch in reverse")),
 		OPT_BOOL(0, "unidiff-zero", &state->unidiff_zero,
@@ -5029,9 +5029,9 @@ int apply_parse_options(int argc, const char **argv,
 		OPT_BIT(0, "recount", options,
 			N_("do not trust the line counts in the hunk headers"),
 			APPLY_OPT_RECOUNT),
-		{ OPTION_CALLBACK, 0, "directory", state, N_("root"),
+		OPT_CALLBACK(0, "directory", state, N_("root"),
 			N_("prepend <root> to all filenames"),
-			0, apply_option_parse_directory },
+			apply_option_parse_directory),
 		OPT_END()
 	};
 
diff --git a/builtin/add.c b/builtin/add.c
index 18a0881ecf..298e0114f9 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -330,10 +330,10 @@ static struct option builtin_add_options[] = {
 	OPT_BOOL(0, "renormalize", &add_renormalize, N_("renormalize EOL of tracked files (implies -u)")),
 	OPT_BOOL('N', "intent-to-add", &intent_to_add, N_("record only the fact that the path will be added later")),
 	OPT_BOOL('A', "all", &addremove_explicit, N_("add changes from all tracked and untracked files")),
-	{ OPTION_CALLBACK, 0, "ignore-removal", &addremove_explicit,
+	OPT_CALLBACK_F(0, "ignore-removal", &addremove_explicit,
 	  NULL /* takes no arguments */,
 	  N_("ignore paths removed in the working tree (same as --no-all)"),
-	  PARSE_OPT_NOARG, ignore_removal_cb },
+	  PARSE_OPT_NOARG, ignore_removal_cb),
 	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
 	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
 	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
diff --git a/builtin/blame.c b/builtin/blame.c
index bf1cecdf3f..6d86831f2d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -864,8 +864,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "minimal", &xdl_opts, N_("Spend extra cycles to find better match"), XDF_NEED_MINIMAL),
 		OPT_STRING('S', NULL, &revs_file, N_("file"), N_("Use revisions from <file> instead of calling git-rev-list")),
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
-		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
-		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
+		OPT_CALLBACK_F('C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback),
+		OPT_CALLBACK_F('M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback),
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
diff --git a/builtin/branch.c b/builtin/branch.c
index d8297f80ff..176e524a94 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -653,10 +653,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_NO_MERGED(&filter, N_("print only branches that are not merged")),
 		OPT_COLUMN(0, "column", &colopts, N_("list branches in columns")),
 		OPT_REF_SORT(sorting_tail),
-		{
-			OPTION_CALLBACK, 0, "points-at", &filter.points_at, N_("object"),
-			N_("print only branches of the object"), 0, parse_opt_object_name
-		},
+		OPT_CALLBACK(0, "points-at", &filter.points_at, N_("object"),
+			N_("print only branches of the object"), parse_opt_object_name),
 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
 		OPT_END(),
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0d03fdac6e..ae18e20a7c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -650,14 +650,14 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "allow-unknown-type", &unknown_type,
 			  N_("allow -s and -t to work with broken/corrupt objects")),
 		OPT_BOOL(0, "buffer", &batch.buffer_output, N_("buffer --batch output")),
-		{ OPTION_CALLBACK, 0, "batch", &batch, "format",
+		OPT_CALLBACK_F(0, "batch", &batch, "format",
 			N_("show info and content of objects fed from the standard input"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
-			batch_option_callback },
-		{ OPTION_CALLBACK, 0, "batch-check", &batch, "format",
+			batch_option_callback),
+		OPT_CALLBACK_F(0, "batch-check", &batch, "format",
 			N_("show info about objects fed from the standard input"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
-			batch_option_callback },
+			batch_option_callback),
 		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
 			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
 		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 1ac1cc290e..a854fd16e7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -177,9 +177,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			N_("write the content to temporary files")),
 		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
 			N_("when creating files, prepend <string>")),
-		{ OPTION_CALLBACK, 0, "stage", NULL, "(1|2|3|all)",
+		OPT_CALLBACK_F(0, "stage", NULL, "(1|2|3|all)",
 			N_("copy out the files from named stage"),
-			PARSE_OPT_NONEG, option_parse_stage },
+			PARSE_OPT_NONEG, option_parse_stage),
 		OPT_END()
 	};
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 8bc94d392b..0b18591ffa 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1486,9 +1486,9 @@ static struct option *add_common_options(struct checkout_opts *opts,
 {
 	struct option options[] = {
 		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
 		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
diff --git a/builtin/clean.c b/builtin/clean.c
index c8c011d2dd..46664c1c85 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -906,8 +906,8 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
 		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
-		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
-		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
+		OPT_CALLBACK_F('e', "exclude", &exclude_list, N_("pattern"),
+		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb),
 		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
 		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index b866d83951..1031b9a491 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -108,15 +108,15 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 	struct object_id commit_oid;
 
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'p', NULL, &parents, N_("parent"),
+		OPT_CALLBACK_F('p', NULL, &parents, N_("parent"),
 			N_("id of a parent commit object"), PARSE_OPT_NONEG,
-			parse_parent_arg_callback },
-		{ OPTION_CALLBACK, 'm', NULL, &buffer, N_("message"),
+			parse_parent_arg_callback),
+		OPT_CALLBACK_F('m', NULL, &buffer, N_("message"),
 			N_("commit message"), PARSE_OPT_NONEG,
-			parse_message_arg_callback },
-		{ OPTION_CALLBACK, 'F', NULL, &buffer, N_("file"),
+			parse_message_arg_callback),
+		OPT_CALLBACK_F('F', NULL, &buffer, N_("file"),
 			N_("read commit log message from file"), PARSE_OPT_NONEG,
-			parse_file_arg_callback },
+			parse_file_arg_callback),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 			N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END()
diff --git a/builtin/commit.c b/builtin/commit.c
index d3e7781e65..8c8620a18c 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1372,9 +1372,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			 N_("show stash information")),
 		OPT_BOOL(0, "ahead-behind", &s.ahead_behind_flags,
 			 N_("compute full ahead/behind values")),
-		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
+		OPT_CALLBACK_F(0, "porcelain", &status_format,
 		  N_("version"), N_("machine-readable output"),
-		  PARSE_OPT_OPTARG, opt_parse_porcelain },
+		  PARSE_OPT_OPTARG, opt_parse_porcelain),
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
@@ -1393,9 +1393,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		OPT_COLUMN(0, "column", &s.colopts, N_("list untracked files in columns")),
 		OPT_BOOL(0, "no-renames", &no_renames, N_("do not detect renames")),
-		{ OPTION_CALLBACK, 'M', "find-renames", &rename_score_arg,
+		OPT_CALLBACK_F('M', "find-renames", &rename_score_arg,
 		  N_("n"), N_("detect renames, optionally set similarity index"),
-		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, opt_parse_rename_score },
+		  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, opt_parse_rename_score),
 		OPT_END(),
 	};
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1097e1e512..3ae52c015d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -156,9 +156,9 @@ static struct option builtin_fetch_options[] = {
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
 		 N_("prune local tags no longer on remote and clobber changed tags")),
-	{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
+	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
-		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
+		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
@@ -178,15 +178,15 @@ static struct option builtin_fetch_options[] = {
 		      1, PARSE_OPT_NONEG),
 	{ OPTION_STRING, 0, "submodule-prefix", &submodule_prefix, N_("dir"),
 		   N_("prepend this to submodule path output"), PARSE_OPT_HIDDEN },
-	{ OPTION_CALLBACK, 0, "recurse-submodules-default",
+	OPT_CALLBACK_F(0, "recurse-submodules-default",
 		   &recurse_submodules_default, N_("on-demand"),
 		   N_("default for recursive fetching of submodules "
 		      "(lower priority than config files)"),
-		   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules },
+		   PARSE_OPT_HIDDEN, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
-	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
-	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
+	OPT_CALLBACK_F(0, "refmap", NULL, N_("refmap"),
+		       N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg),
 	OPT_STRING_LIST('o', "server-option", &server_options, N_("server-specific"), N_("option to transmit")),
 	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
 			TRANSPORT_FAMILY_IPV4),
diff --git a/builtin/grep.c b/builtin/grep.c
index 99e2685090..6216e43a02 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -886,20 +886,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, N_("file"),
 			N_("read patterns from file"), file_callback),
-		{ OPTION_CALLBACK, 'e', NULL, &opt, N_("pattern"),
-			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback },
-		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
-		  N_("combine patterns specified with -e"),
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
+		OPT_CALLBACK_F('e', NULL, &opt, N_("pattern"),
+			N_("match <pattern>"), PARSE_OPT_NONEG, pattern_callback),
+		OPT_CALLBACK_F(0, "and", &opt, NULL,
+			N_("combine patterns specified with -e"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback),
 		OPT_BOOL(0, "or", &dummy, ""),
-		{ OPTION_CALLBACK, 0, "not", &opt, NULL, "",
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback },
-		{ OPTION_CALLBACK, '(', NULL, &opt, NULL, "",
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
-		  open_callback },
-		{ OPTION_CALLBACK, ')', NULL, &opt, NULL, "",
-		  PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
-		  close_callback },
+		OPT_CALLBACK_F(0, "not", &opt, NULL, "",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback),
+		OPT_CALLBACK_F('(', NULL, &opt, NULL, "",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+			open_callback),
+		OPT_CALLBACK_F(')', NULL, &opt, NULL, "",
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG | PARSE_OPT_NODASH,
+			close_callback),
 		OPT__QUIET(&opt.status_only,
 			   N_("indicate hit with exit status without output")),
 		OPT_BOOL(0, "all-match", &opt.all_match,
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index f101d092b8..84748eafc0 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -105,8 +105,8 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
 		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
-		{ OPTION_CALLBACK, 0, "parse", &opts, NULL, N_("set parsing options"),
-			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse },
+		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("set parsing options"),
+			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
 		OPT_BOOL(0, "no-divider", &opts.no_divider, N_("do not treat --- specially")),
 		OPT_CALLBACK(0, "trailer", &trailers, N_("trailer"),
 				N_("trailer(s) to add"), option_parse_trailer),
diff --git a/builtin/log.c b/builtin/log.c
index a5c3ace9a0..911d68c2dc 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -179,8 +179,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
 				N_("pattern"), N_("do not decorate refs that match <pattern>")),
-		{ OPTION_CALLBACK, 0, "decorate", NULL, NULL, N_("decorate options"),
-		  PARSE_OPT_OPTARG, decorate_callback},
+		OPT_CALLBACK_F(0, "decorate", NULL, NULL, N_("decorate options"),
+			       PARSE_OPT_OPTARG, decorate_callback),
 		OPT_CALLBACK('L', NULL, &line_cb, "n,m:file",
 			     N_("Process line range n,m in file, counting from 1"),
 			     log_line_range_callback),
@@ -1631,12 +1631,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int creation_factor = -1;
 
 	const struct option builtin_format_patch_options[] = {
-		{ OPTION_CALLBACK, 'n', "numbered", &numbered, NULL,
+		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
-			    PARSE_OPT_NOARG, numbered_callback },
-		{ OPTION_CALLBACK, 'N', "no-numbered", &numbered, NULL,
+			    PARSE_OPT_NOARG, numbered_callback),
+		OPT_CALLBACK_F('N', "no-numbered", &numbered, NULL,
 			    N_("use [PATCH] even with multiple patches"),
-			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback },
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, no_numbered_callback),
 		OPT_BOOL('s', "signoff", &do_signoff, N_("add Signed-off-by:")),
 		OPT_BOOL(0, "stdout", &use_stdout,
 			    N_("print patches to standard out")),
@@ -1650,21 +1650,21 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_INTEGER('v', "reroll-count", &reroll_count,
 			    N_("mark the series as Nth re-roll")),
-		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
+		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
 			    N_("Use [RFC PATCH] instead of [PATCH]"),
-			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
-		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
+		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
-			    PARSE_OPT_NONEG, subject_prefix_callback },
-		{ OPTION_CALLBACK, 'o', "output-directory", &output_directory,
+			    PARSE_OPT_NONEG, subject_prefix_callback),
+		OPT_CALLBACK_F('o', "output-directory", &output_directory,
 			    N_("dir"), N_("store resulting files in <dir>"),
-			    PARSE_OPT_NONEG, output_directory_callback },
-		{ OPTION_CALLBACK, 'k', "keep-subject", &rev, NULL,
+			    PARSE_OPT_NONEG, output_directory_callback),
+		OPT_CALLBACK_F('k', "keep-subject", &rev, NULL,
 			    N_("don't strip/add [PATCH]"),
-			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback),
 		OPT_BOOL(0, "no-binary", &no_binary_diff,
 			 N_("don't output binary diffs")),
 		OPT_BOOL(0, "zero-commit", &zero_commit,
@@ -1675,27 +1675,25 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			      N_("show patch format instead of default (patch + stat)"),
 			      1, PARSE_OPT_NONEG),
 		OPT_GROUP(N_("Messaging")),
-		{ OPTION_CALLBACK, 0, "add-header", NULL, N_("header"),
-			    N_("add email header"), 0, header_callback },
-		{ OPTION_CALLBACK, 0, "to", NULL, N_("email"), N_("add To: header"),
-			    0, to_callback },
-		{ OPTION_CALLBACK, 0, "cc", NULL, N_("email"), N_("add Cc: header"),
-			    0, cc_callback },
-		{ OPTION_CALLBACK, 0, "from", &from, N_("ident"),
+		OPT_CALLBACK(0, "add-header", NULL, N_("header"),
+			    N_("add email header"), header_callback),
+		OPT_CALLBACK(0, "to", NULL, N_("email"), N_("add To: header"), to_callback),
+		OPT_CALLBACK(0, "cc", NULL, N_("email"), N_("add Cc: header"), cc_callback),
+		OPT_CALLBACK_F(0, "from", &from, N_("ident"),
 			    N_("set From address to <ident> (or committer ident if absent)"),
-			    PARSE_OPT_OPTARG, from_callback },
+			    PARSE_OPT_OPTARG, from_callback),
 		OPT_STRING(0, "in-reply-to", &in_reply_to, N_("message-id"),
 			    N_("make first mail a reply to <message-id>")),
-		{ OPTION_CALLBACK, 0, "attach", &rev, N_("boundary"),
+		OPT_CALLBACK_F(0, "attach", &rev, N_("boundary"),
 			    N_("attach the patch"), PARSE_OPT_OPTARG,
-			    attach_callback },
-		{ OPTION_CALLBACK, 0, "inline", &rev, N_("boundary"),
+			    attach_callback),
+		OPT_CALLBACK_F(0, "inline", &rev, N_("boundary"),
 			    N_("inline the patch"),
 			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
-			    inline_callback },
-		{ OPTION_CALLBACK, 0, "thread", &thread, N_("style"),
+			    inline_callback),
+		OPT_CALLBACK_F(0, "thread", &thread, N_("style"),
 			    N_("enable message threading, styles: shallow, deep"),
-			    PARSE_OPT_OPTARG, thread_callback },
+			    PARSE_OPT_OPTARG, thread_callback),
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
 		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f069a028ce..9ab9db7c59 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -554,18 +554,18 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			N_("show unmerged files in the output")),
 		OPT_BOOL(0, "resolve-undo", &show_resolve_undo,
 			    N_("show resolve-undo information")),
-		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
+		OPT_CALLBACK_F('x', "exclude", &exclude_list, N_("pattern"),
 			N_("skip files matching pattern"),
-			PARSE_OPT_NONEG, option_parse_exclude },
-		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, N_("file"),
+			PARSE_OPT_NONEG, option_parse_exclude),
+		OPT_CALLBACK_F('X', "exclude-from", &dir, N_("file"),
 			N_("exclude patterns are read from <file>"),
-			PARSE_OPT_NONEG, option_parse_exclude_from },
+			PARSE_OPT_NONEG, option_parse_exclude_from),
 		OPT_STRING(0, "exclude-per-directory", &dir.exclude_per_dir, N_("file"),
 			N_("read additional per-directory exclude patterns in <file>")),
-		{ OPTION_CALLBACK, 0, "exclude-standard", &dir, NULL,
+		OPT_CALLBACK_F(0, "exclude-standard", &dir, NULL,
 			N_("add the standard git exclusions"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			option_parse_exclude_standard },
+			option_parse_exclude_standard),
 		OPT_SET_INT_F(0, "full-name", &prefix_len,
 			      N_("make the output relative to the project top directory"),
 			      0, PARSE_OPT_NONEG),
diff --git a/builtin/merge.c b/builtin/merge.c
index df83ba2a80..35707003b6 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -241,9 +241,9 @@ static int option_parse_n(const struct option *opt,
 }
 
 static struct option builtin_merge_options[] = {
-	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
+	OPT_CALLBACK_F('n', NULL, NULL, NULL,
 		N_("do not show a diffstat at the end of the merge"),
-		PARSE_OPT_NOARG, option_parse_n },
+		PARSE_OPT_NOARG, option_parse_n),
 	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
 	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
diff --git a/builtin/notes.c b/builtin/notes.c
index 35e468ea2d..2987c08a2e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -406,18 +406,18 @@ static int add(int argc, const char **argv, const char *prefix)
 	const struct object_id *note;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
+		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &d, N_("file"),
+			parse_msg_arg),
+		OPT_CALLBACK_F('F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
-			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &d, N_("object"),
+			parse_file_arg),
+		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
-			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
+			parse_reedit_arg),
+		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
-			parse_reuse_arg},
+			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT__FORCE(&force, N_("replace existing notes"), PARSE_OPT_NOCOMPLETE),
@@ -572,18 +572,18 @@ static int append_edit(int argc, const char **argv, const char *prefix)
 	const char * const *usage;
 	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
 	struct option options[] = {
-		{ OPTION_CALLBACK, 'm', "message", &d, N_("message"),
+		OPT_CALLBACK_F('m', "message", &d, N_("message"),
 			N_("note contents as a string"), PARSE_OPT_NONEG,
-			parse_msg_arg},
-		{ OPTION_CALLBACK, 'F', "file", &d, N_("file"),
+			parse_msg_arg),
+		OPT_CALLBACK_F('F', "file", &d, N_("file"),
 			N_("note contents in a file"), PARSE_OPT_NONEG,
-			parse_file_arg},
-		{ OPTION_CALLBACK, 'c', "reedit-message", &d, N_("object"),
+			parse_file_arg),
+		OPT_CALLBACK_F('c', "reedit-message", &d, N_("object"),
 			N_("reuse and edit specified note object"), PARSE_OPT_NONEG,
-			parse_reedit_arg},
-		{ OPTION_CALLBACK, 'C', "reuse-message", &d, N_("object"),
+			parse_reedit_arg),
+		OPT_CALLBACK_F('C', "reuse-message", &d, N_("object"),
 			N_("reuse specified note object"), PARSE_OPT_NONEG,
-			parse_reuse_arg},
+			parse_reuse_arg),
 		OPT_BOOL(0, "allow-empty", &allow_empty,
 			N_("allow storing empty note")),
 		OPT_END()
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fdd18c7ccb..03b85f5166 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3380,9 +3380,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "all-progress-implied",
 			 &all_progress_implied,
 			 N_("similar to --all-progress when progress meter is shown")),
-		{ OPTION_CALLBACK, 0, "index-version", NULL, N_("<version>[,<offset>]"),
+		OPT_CALLBACK_F(0, "index-version", NULL, N_("<version>[,<offset>]"),
 		  N_("write the pack index file in the specified idx format version"),
-		  PARSE_OPT_NONEG, option_parse_index_version },
+		  PARSE_OPT_NONEG, option_parse_index_version),
 		OPT_MAGNITUDE(0, "max-pack-size", &pack_size_limit,
 			      N_("maximum size of each output pack file")),
 		OPT_BOOL(0, "local", &local,
@@ -3427,9 +3427,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			 N_("keep unreachable objects")),
 		OPT_BOOL(0, "pack-loose-unreachable", &pack_loose_unreachable,
 			 N_("pack loose unreachable objects")),
-		{ OPTION_CALLBACK, 0, "unpack-unreachable", NULL, N_("time"),
+		OPT_CALLBACK_F(0, "unpack-unreachable", NULL, N_("time"),
 		  N_("unpack unreachable objects newer than <time>"),
-		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable },
+		  PARSE_OPT_OPTARG, option_parse_unpack_unreachable),
 		OPT_BOOL(0, "sparse", &sparse,
 			 N_("use the sparse reachability algorithm")),
 		OPT_BOOL(0, "thin", &thin,
@@ -3454,9 +3454,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			      N_("write a bitmap index if possible"),
 			      WRITE_BITMAP_QUIET, PARSE_OPT_HIDDEN),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
-		{ OPTION_CALLBACK, 0, "missing", NULL, N_("action"),
+		OPT_CALLBACK_F(0, "missing", NULL, N_("action"),
 		  N_("handling for missing objects"), PARSE_OPT_NONEG,
-		  option_parse_missing_action },
+		  option_parse_missing_action),
 		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
 			 N_("do not pack objects in promisor packfiles")),
 		OPT_BOOL(0, "delta-islands", &use_delta_islands,
diff --git a/builtin/pull.c b/builtin/pull.c
index b5d51ea74f..119b28a6e7 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -118,17 +118,17 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "progress", &opt_progress, NULL,
 		N_("force progress reporting"),
 		PARSE_OPT_NOARG),
-	{ OPTION_CALLBACK, 0, "recurse-submodules",
+	OPT_CALLBACK_F(0, "recurse-submodules",
 		   &recurse_submodules, N_("on-demand"),
 		   N_("control for recursive fetching of submodules"),
-		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules },
+		   PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
-	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
+	OPT_CALLBACK_F('r', "rebase", &opt_rebase,
 	  "(false|true|merges|preserve|interactive)",
 	  N_("incorporate changes by rebasing rather than merging"),
-	  PARSE_OPT_OPTARG, parse_opt_rebase },
+	  PARSE_OPT_OPTARG, parse_opt_rebase),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
diff --git a/builtin/push.c b/builtin/push.c
index 90f071fcf2..e061eb03fd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -546,13 +546,11 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
-		{ OPTION_CALLBACK,
-		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
-		  N_("require old value of ref to be at this value"),
-		  PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option },
-		{ OPTION_CALLBACK, 0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
-			N_("control recursive pushing of submodules"),
-			0, option_parse_recurse_submodules },
+		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
+				N_("require old value of ref to be at this value"),
+				PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP, parseopt_push_cas_option),
+		OPT_CALLBACK(0, "recurse-submodules", &recurse_submodules, "(check|on-demand|no)",
+				N_("control recursive pushing of submodules"), option_parse_recurse_submodules),
 		OPT_BOOL_F( 0 , "thin", &thin, N_("use thin pack"), PARSE_OPT_NOCOMPLETE),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
@@ -564,9 +562,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
-		{ OPTION_CALLBACK,
-		  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
-		  PARSE_OPT_OPTARG, option_parse_push_signed },
+		OPT_CALLBACK_F(0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
+				PARSE_OPT_OPTARG, option_parse_push_signed),
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
 		OPT_STRING_LIST('o', "push-option", &push_options_cmdline, N_("server-specific"), N_("option to transmit")),
 		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
diff --git a/builtin/read-tree.c b/builtin/read-tree.c
index af7424b94c..485e7b0479 100644
--- a/builtin/read-tree.c
+++ b/builtin/read-tree.c
@@ -120,9 +120,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 	int prefix_set = 0;
 	struct lock_file lock_file = LOCK_INIT;
 	const struct option read_tree_options[] = {
-		{ OPTION_CALLBACK, 0, "index-output", NULL, N_("file"),
+		OPT_CALLBACK_F(0, "index-output", NULL, N_("file"),
 		  N_("write resulting index to <file>"),
-		  PARSE_OPT_NONEG, index_output_cb },
+		  PARSE_OPT_NONEG, index_output_cb),
 		OPT_BOOL(0, "empty", &read_empty,
 			    N_("only empty the index")),
 		OPT__VERBOSE(&opts.verbose_update, N_("be verbose")),
@@ -140,10 +140,10 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 		  PARSE_OPT_NONEG },
 		OPT_BOOL('u', NULL, &opts.update,
 			 N_("update working tree with merge result")),
-		{ OPTION_CALLBACK, 0, "exclude-per-directory", &opts,
+		OPT_CALLBACK_F(0, "exclude-per-directory", &opts,
 		  N_("gitignore"),
 		  N_("allow explicitly ignored files to be overwritten"),
-		  PARSE_OPT_NONEG, exclude_per_directory_cb },
+		  PARSE_OPT_NONEG, exclude_per_directory_cb),
 		OPT_BOOL('i', NULL, &opts.index_only,
 			 N_("don't check the working tree after merging")),
 		OPT__DRY_RUN(&opts.dry_run, N_("don't update the index or the work tree")),
@@ -151,9 +151,9 @@ int cmd_read_tree(int argc, const char **argv, const char *cmd_prefix)
 			 N_("skip applying sparse checkout filter")),
 		OPT_BOOL(0, "debug-unpack", &opts.debug_unpack,
 			 N_("debug unpack-trees")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT__QUIET(&opts.quiet, N_("suppress feedback messages")),
 		OPT_END()
 	};
diff --git a/builtin/rebase.c b/builtin/rebase.c
index c466923869..8f6fc829ae 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -474,10 +474,10 @@ int cmd_rebase__interactive(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_NEGBIT(0, "ff", &opts.flags, N_("allow fast-forward"),
 			   REBASE_FORCE),
-		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
+		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
 			N_("keep commits which start empty"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			parse_opt_keep_empty },
+			parse_opt_keep_empty),
 		OPT_BOOL_F(0, "allow-empty-message", &opts.allow_empty_message,
 			   N_("allow commits with empty messages"),
 			   PARSE_OPT_HIDDEN),
@@ -1532,18 +1532,18 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "show-current-patch", &action,
 			    N_("show the patch file being applied or merged"),
 			    ACTION_SHOW_CURRENT_PATCH),
-		{ OPTION_CALLBACK, 0, "apply", &options, NULL,
+		OPT_CALLBACK_F(0, "apply", &options, NULL,
 			N_("use apply strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			parse_opt_am },
-		{ OPTION_CALLBACK, 'm', "merge", &options, NULL,
+			parse_opt_am),
+		OPT_CALLBACK_F('m', "merge", &options, NULL,
 			N_("use merging strategies to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			parse_opt_merge },
-		{ OPTION_CALLBACK, 'i', "interactive", &options, NULL,
+			parse_opt_merge),
+		OPT_CALLBACK_F('i', "interactive", &options, NULL,
 			N_("let the user edit the list of commits to rebase"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			parse_opt_interactive },
+			parse_opt_interactive),
 		OPT_SET_INT_F('p', "preserve-merges", &options.type,
 			      N_("(DEPRECATED) try to recreate merges instead of "
 				 "ignoring them"),
@@ -1552,10 +1552,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
-		{ OPTION_CALLBACK, 'k', "keep-empty", &options, NULL,
+		OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
 			N_("keep commits which start empty"),
 			PARSE_OPT_NOARG | PARSE_OPT_HIDDEN,
-			parse_opt_keep_empty },
+			parse_opt_keep_empty),
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
diff --git a/builtin/remote.c b/builtin/remote.c
index 555d4c896c..e8377994e5 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -170,9 +170,9 @@ static int add(int argc, const char **argv)
 		OPT_STRING_LIST('t', "track", &track, N_("branch"),
 				N_("branch(es) to track")),
 		OPT_STRING('m', "master", &master, N_("branch"), N_("master branch")),
-		{ OPTION_CALLBACK, 0, "mirror", &mirror, "(push|fetch)",
+		OPT_CALLBACK_F(0, "mirror", &mirror, "(push|fetch)",
 			N_("set up remote as a mirror to push to or fetch from"),
-			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt },
+			PARSE_OPT_OPTARG | PARSE_OPT_COMP_ARG, parse_mirror_opt),
 		OPT_END()
 	};
 
diff --git a/builtin/reset.c b/builtin/reset.c
index 4c634111bd..8ae69d6f2b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -302,9 +302,9 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+		OPT_CALLBACK_F(0, "recurse-submodules", NULL,
 			    "reset", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index f2c5a34402..2b9610f121 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -165,9 +165,8 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('n' , "dry-run", &dry_run, N_("dry run")),
 		OPT_BOOL(0, "mirror", &send_mirror, N_("mirror all refs")),
 		OPT_BOOL('f', "force", &force_update, N_("force updates")),
-		{ OPTION_CALLBACK,
-		  0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
-		  PARSE_OPT_OPTARG, option_parse_push_signed },
+		OPT_CALLBACK_F(0, "signed", &push_cert, "(yes|no|if-asked)", N_("GPG sign the push"),
+		  PARSE_OPT_OPTARG, option_parse_push_signed),
 		OPT_STRING_LIST(0, "push-option", &push_options,
 				N_("server-specific"),
 				N_("option to transmit")),
@@ -177,10 +176,9 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "stateless-rpc", &stateless_rpc, N_("use stateless RPC protocol")),
 		OPT_BOOL(0, "stdin", &from_stdin, N_("read refs from stdin")),
 		OPT_BOOL(0, "helper-status", &helper_status, N_("print status from remote helper")),
-		{ OPTION_CALLBACK,
-		  0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
+		OPT_CALLBACK_F(0, CAS_OPT_NAME, &cas, N_("<refname>:<expect>"),
 		  N_("require old value of ref to be at this value"),
-		  PARSE_OPT_OPTARG, parseopt_push_cas_option },
+		  PARSE_OPT_OPTARG, parseopt_push_cas_option),
 		OPT_END()
 	};
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 65cd41392c..c856c58bb5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -268,9 +268,9 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			 N_("Suppress commit descriptions, only provides commit count")),
 		OPT_BOOL('e', "email", &log.email,
 			 N_("Show the email address of each author")),
-		{ OPTION_CALLBACK, 'w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
+		OPT_CALLBACK_F('w', NULL, &log, N_("<w>[,<i1>[,<i2>]]"),
 			N_("Linewrap output"), PARSE_OPT_OPTARG,
-			&parse_wrap_args },
+			&parse_wrap_args),
 		OPT_END(),
 	};
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 8c90cbb18f..7e52ee9126 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -671,11 +671,11 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			    N_("topologically sort, maintaining date order "
 			       "where possible"),
 			    REV_SORT_BY_COMMIT_DATE),
-		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
+		OPT_CALLBACK_F('g', "reflog", &reflog_base, N_("<n>[,<base>]"),
 			    N_("show <n> most recent ref-log entries starting at "
 			       "base"),
 			    PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
-			    parse_reflog_param },
+			    parse_reflog_param),
 		OPT_END()
 	};
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 6456da70cc..ae60b4acf2 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -169,15 +169,15 @@ static const struct option show_ref_options[] = {
 	  N_("show the HEAD reference, even if it would be filtered out")),
 	OPT_BOOL('d', "dereference", &deref_tags,
 		    N_("dereference tags into object IDs")),
-	{ OPTION_CALLBACK, 's', "hash", &abbrev, N_("n"),
-	  N_("only show SHA1 hash using <n> digits"),
-	  PARSE_OPT_OPTARG, &hash_callback },
+	OPT_CALLBACK_F('s', "hash", &abbrev, N_("n"),
+		       N_("only show SHA1 hash using <n> digits"),
+		       PARSE_OPT_OPTARG, &hash_callback),
 	OPT__ABBREV(&abbrev),
 	OPT__QUIET(&quiet,
 		   N_("do not print results to stdout (useful with --verify)")),
-	{ OPTION_CALLBACK, 0, "exclude-existing", &exclude_existing_arg,
-	  N_("pattern"), N_("show refs from stdin that aren't in local repository"),
-	  PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback },
+	OPT_CALLBACK_F(0, "exclude-existing", &exclude_existing_arg,
+		       N_("pattern"), N_("show refs from stdin that aren't in local repository"),
+		       PARSE_OPT_OPTARG | PARSE_OPT_NONEG, exclude_existing_callback),
 	OPT_END()
 };
 
diff --git a/builtin/tag.c b/builtin/tag.c
index dd160b49c7..b93b7365f4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -410,8 +410,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_GROUP(N_("Tag creation options")),
 		OPT_BOOL('a', "annotate", &annotate,
 					N_("annotated tag, needs a message")),
-		{ OPTION_CALLBACK, 'm', "message", &msg, N_("message"),
-		  N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg },
+		OPT_CALLBACK_F('m', "message", &msg, N_("message"),
+			       N_("tag message"), PARSE_OPT_NONEG, parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of tag message")),
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
diff --git a/builtin/update-index.c b/builtin/update-index.c
index d527b8f106..79087bccea 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -985,14 +985,14 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "unmerged", &refresh_args.flags,
 			N_("refresh even if index contains unmerged entries"),
 			REFRESH_UNMERGED),
-		{OPTION_CALLBACK, 0, "refresh", &refresh_args, NULL,
+		OPT_CALLBACK_F(0, "refresh", &refresh_args, NULL,
 			N_("refresh stat information"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			refresh_callback},
-		{OPTION_CALLBACK, 0, "really-refresh", &refresh_args, NULL,
+			refresh_callback),
+		OPT_CALLBACK_F(0, "really-refresh", &refresh_args, NULL,
 			N_("like --refresh, but ignore assume-unchanged setting"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			really_refresh_callback},
+			really_refresh_callback),
 		{OPTION_LOWLEVEL_CALLBACK, 0, "cacheinfo", NULL,
 			N_("<mode>,<object>,<path>"),
 			N_("add the specified entry to the index"),
@@ -1000,10 +1000,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 			NULL, 0,
 			cacheinfo_callback},
-		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
+		OPT_CALLBACK_F(0, "chmod", &set_executable_bit, "(+|-)x",
 			N_("override the executable bit of the listed files"),
 			PARSE_OPT_NONEG,
-			chmod_callback},
+			chmod_callback),
 		{OPTION_SET_INT, 0, "assume-unchanged", &mark_valid_only, NULL,
 			N_("mark files as \"not changing\""),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, MARK_FLAG},
@@ -1045,10 +1045,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			REFRESH_IGNORE_MISSING),
 		OPT_SET_INT(0, "verbose", &verbose,
 			N_("report actions to standard output"), 1),
-		{OPTION_CALLBACK, 0, "clear-resolve-undo", NULL, NULL,
+		OPT_CALLBACK_F(0, "clear-resolve-undo", NULL, NULL,
 			N_("(for porcelains) forget saved unresolved conflicts"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
-			resolve_undo_clear_callback},
+			resolve_undo_clear_callback),
 		OPT_INTEGER(0, "index-version", &preferred_index_format,
 			N_("write index in this format")),
 		OPT_BOOL(0, "split-index", &split_index,
diff --git a/list-objects-filter-options.h b/list-objects-filter-options.h
index 2ffb39222c..73fffa4ad7 100644
--- a/list-objects-filter-options.h
+++ b/list-objects-filter-options.h
@@ -82,9 +82,9 @@ int opt_parse_list_objects_filter(const struct option *opt,
 				  const char *arg, int unset);
 
 #define OPT_PARSE_LIST_OBJECTS_FILTER(fo) \
-	{ OPTION_CALLBACK, 0, CL_ARG__FILTER, fo, N_("args"), \
-	  N_("object filtering"), 0, \
-	  opt_parse_list_objects_filter }
+	OPT_CALLBACK(0, CL_ARG__FILTER, fo, N_("args"), \
+	  N_("object filtering"), \
+	  opt_parse_list_objects_filter)
 
 /*
  * Translates abbreviated numbers in the filter's filter_spec into their
-- 
2.26.0.159.g23e2136ad0

