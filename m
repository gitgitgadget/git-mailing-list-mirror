Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C0C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 02:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJQCX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 22:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiJQCXe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 22:23:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8385C2C66A
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so16407819wrb.9
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 19:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbHU69GkfyEQzRT4xm0Puy2ehVoFdYZ5dmmHFRr40ro=;
        b=SBEZu7SiyuEh3KXZ6PE7lcduLhASeb1w/J1rm1gCTMqk9FshoCvaYL8kSb668+bg9u
         xbQPSj/MpokF8TKajzE9I/exHHLyFiWsNnlgmsutmaa8i4vGcqcliaXDz5pF/SkAUN8t
         7zCN7rsp8ppvk6Yf9O7v6DSN/2vZDXu5+rF5JBSbM0Tme+zYNMRzCd8753H5hetWd/r1
         /HO6ei/0aajeenktk51ufzuLdOHfTx1Y0Bojmvs4CcScr864kpI5J8F90aS6zq6SKQ10
         Pvaqr30M4cHYyzWQ5jFDFHeRfXp7+CgzuWFN1crnmzyYs3aE5RDhPgtHIXzt7rAtT0BW
         BG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbHU69GkfyEQzRT4xm0Puy2ehVoFdYZ5dmmHFRr40ro=;
        b=LUj159CKI8FCTwiqOFInM97OicvmOiLEaqjxPM4Hpr3nBFSaCfdIbS9nEr0S3PXDTl
         oQOkGZTRZdPYbfuBQQQG8lWEn0Iga53drKq01t0po54LEsaGd4IiGsqVfHcFf1XZeDfs
         A35OvmgA++O9zE6OUCTZ65gFGmT1EDokIQrh16CwOxXbEwa68+0Kr7vXNuJswlo8q+av
         rvMq10K6L0VO+3CFndvCrKKg3FrFgcny9bwErqaoBPJNVEbNwq7DQPA6San8pVZYbrWY
         t4uVRD4/TaIanS9aPvU5IBIFO7gqWBWCa1NDJHq6QkoFGp9/kC/irwoncA8+Qde1yTbB
         7tPg==
X-Gm-Message-State: ACrzQf0UL/PdVMSRywtj8QBr4X/xEM1PCS3W6mrk1RSDeBushOB8CZGa
        qMrHmdA6kyA9FsUjjN3NO51bXU27Jq4=
X-Google-Smtp-Source: AMsMyM7Q9Ws1pwrj/5qw4phkHYLOjPyQN9CAUbnxXezMCMI3GrmxOvkTuafPVjiyMlSTbReUtdndhg==
X-Received: by 2002:a05:6000:2c9:b0:22f:e7b5:bc26 with SMTP id o9-20020a05600002c900b0022fe7b5bc26mr4578668wry.149.1665973410833;
        Sun, 16 Oct 2022 19:23:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d6e5c000000b0022cd27bc8c1sm8991852wrz.9.2022.10.16.19.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 19:23:30 -0700 (PDT)
Message-Id: <4672e3d958625cd76eb8056ab434e9a37f52661e.1665973401.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
References: <pull.1359.v2.git.git.1665660960.gitgitgadget@gmail.com>
        <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>
From:   "Heather Lapointe via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Oct 2022 02:23:20 +0000
Subject: [PATCH v3 8/9] archive: add --recurse-submodules to git-archive
 command
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

This makes it possible to include submodule contents in an archive command.

The default behavior remains the same, do not write submodule contents
to the resulting archive.

Signed-off-by: Heather Lapointe <alpha@alphaservcomputing.solutions>
---
 Documentation/git-archive.txt |  6 +++++-
 archive.c                     | 36 +++++++++++++++++++++++++++++++++--
 archive.h                     |  1 +
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 60c040988bb..22f54428b98 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git archive' [--format=<fmt>] [--list] [--prefix=<prefix>/] [<extra>]
-	      [-o <file> | --output=<file>] [--worktree-attributes]
+	      [-o <file> | --output=<file>]
+	      [--recurse-submodules] [--worktree-attributes]
 	      [--remote=<repo> [--exec=<git-upload-archive>]] <tree-ish>
 	      [<path>...]
 
@@ -82,6 +83,9 @@ The file mode is limited to a regular file, and the option may be
 subject to platform-dependent command-line limits. For non-trivial
 cases, write an untracked file and use `--add-file` instead.
 
+--recurse-submodules
+	Include submodules recursively in archive.
+
 --worktree-attributes::
 	Look for attributes in .gitattributes files in the working tree
 	as well (see <<ATTRIBUTES>>).
diff --git a/archive.c b/archive.c
index 34549d849f1..f81ef741487 100644
--- a/archive.c
+++ b/archive.c
@@ -10,6 +10,7 @@
 #include "unpack-trees.h"
 #include "dir.h"
 #include "quote.h"
+#include "submodule.h"
 
 static char const * const archive_usage[] = {
 	N_("git archive [<options>] <tree-ish> [<path>...]"),
@@ -213,6 +214,25 @@ static void queue_directory(const struct object_id *oid,
 	oidcpy(&d->oid, oid);
 }
 
+static void queue_submodule(
+		struct repository *superproject,
+		const struct object_id *oid,
+		struct strbuf *base, const char *filename,
+		unsigned mode, struct archiver_context *c)
+{
+	struct repository subrepo;
+
+	if (repo_submodule_init(&subrepo, superproject, filename, null_oid()))
+		return;
+
+	if (repo_read_index(&subrepo) < 0)
+		die("index file corrupt");
+
+    queue_directory(oid, base, filename, mode, c);
+
+	repo_clear(&subrepo);
+}
+
 static int write_directory(
 		struct repository *repo,
 		struct archiver_context *c)
@@ -228,9 +248,11 @@ static int write_directory(
 		write_directory(repo, c) ||
 		write_archive_entry(repo, &d->oid, d->path, d->baselen,
 				    d->path + d->baselen, d->mode,
-				    c) != READ_TREE_RECURSIVE;
+				    c);
 	free(d);
-	return ret ? -1 : 0;
+	if (ret == READ_TREE_RECURSIVE)
+		return 0;
+	return ret;
 }
 
 static int queue_or_write_archive_entry(
@@ -263,6 +285,11 @@ static int queue_or_write_archive_entry(
 			return 0;
 		queue_directory(oid, base, filename, mode, c);
 		return READ_TREE_RECURSIVE;
+	} else if (c->args->recurse_submodules && S_ISGITLINK(mode)) {
+		if (is_submodule_active(r, filename)) {
+			queue_submodule(r, oid, base, filename, mode, c);
+			return READ_TREE_RECURSIVE;
+		}
 	}
 
 	if (write_directory(r, c))
@@ -446,6 +473,7 @@ static void parse_pathspec_arg(
 		       PATHSPEC_PREFER_FULL,
 		       "", pathspec);
 	ar_args->pathspec.recursive = 1;
+	ar_args->pathspec.recurse_submodules = ar_args->recurse_submodules;
 	if (pathspec) {
 		while (*pathspec) {
 			if (**pathspec && !path_exists(repo, ar_args, *pathspec))
@@ -609,6 +637,7 @@ static int parse_archive_args(int argc, const char **argv,
 	int verbose = 0;
 	int i;
 	int list = 0;
+	int recurse_submodules = 0;
 	int worktree_attributes = 0;
 	struct option opts[] = {
 		OPT_GROUP(""),
@@ -623,6 +652,8 @@ static int parse_archive_args(int argc, const char **argv,
 		  add_file_cb, (intptr_t)&base },
 		OPT_STRING('o', "output", &output, N_("file"),
 			N_("write the archive to this file")),
+		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
+			N_("include submodules in archive")),
 		OPT_BOOL(0, "worktree-attributes", &worktree_attributes,
 			N_("read .gitattributes in working directory")),
 		OPT__VERBOSE(&verbose, N_("report archived files on stderr")),
@@ -686,6 +717,7 @@ static int parse_archive_args(int argc, const char **argv,
 	args->verbose = verbose;
 	args->base = base;
 	args->baselen = strlen(base);
+	args->recurse_submodules = recurse_submodules;
 	args->worktree_attributes = worktree_attributes;
 
 	return argc;
diff --git a/archive.h b/archive.h
index 540a3b12130..1b21484dda6 100644
--- a/archive.h
+++ b/archive.h
@@ -18,6 +18,7 @@ struct archiver_args {
 	timestamp_t time;
 	struct pathspec pathspec;
 	unsigned int verbose : 1;
+	unsigned int recurse_submodules : 1;
 	unsigned int worktree_attributes : 1;
 	unsigned int convert : 1;
 	int compression_level;
-- 
gitgitgadget

