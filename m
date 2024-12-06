Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D4320629E
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 20:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733515650; cv=none; b=g03cRJENLfdvNZEa23TebrWwvvD+i6IdnjVR5s93T2FbEOvyoO1Mp+FA+gd1QSYbFL+UPFJ28dNWJKxKnqnDOwgSXBQo2E2CkO+JNTYyhA6R/em/HfW40MY314gDVSx4sQqIjxFsJqXgeeg3+bdHUYuRPHarN68zJyzNZRPAmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733515650; c=relaxed/simple;
	bh=nrkTOapO4ebLiz03hOIiJPjRvbSKd9DRwEFq3P6FWqQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D/eEQfJ6z7lWgBI3JDcUEC1v1adTgwW0r4ztESa9gmQYf10S+yRb/GGzd9V+wOtmLK8poH/nafhasiiChTjwVSLj3dI+VqR3dZjPGN6LmJ86JwQJuJ84nGTQcf705/bJP41Fs37zYeAYT7Daxs8SGMCQzYm7usU5bGBTQqpiYOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7CQlxZh; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7CQlxZh"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-434a14d6bf4so24317865e9.1
        for <git@vger.kernel.org>; Fri, 06 Dec 2024 12:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733515644; x=1734120444; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNiFdsEHOCFE1bnq12cGIjw7bPD7xaFPBT1NS2MynjE=;
        b=j7CQlxZhSfURKtwOr3fHSlQHllQYl+ihzYHI0CelPrZK/Jc9cvfQuhLDwyGGZr8LuB
         62ZUMIAVRAlLBBPsOLxFVCts7CckfffpVFbqGalJ4QZxz/PFuyDYvqk+/hnWTgFqfDnt
         9I4MDrqya/dq26oAa7f69JMNsRWtizOY/rSqoFsnLo+zY1LEDQJvDVgo8NwbliXXA24F
         GWVVVxTafhQwEWecuya2+Yd0ijFyn5Yy60+T0odanf7Q6KB/JztYKeqxgZ9aQFrxeNh2
         j45mDzIHIW3Hr1kwNPNQgoM/bwcGCOfk+X7eSHT3hA3LNXVoP4xAWAYdBgoVm/ZUYhfu
         uxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733515644; x=1734120444;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cNiFdsEHOCFE1bnq12cGIjw7bPD7xaFPBT1NS2MynjE=;
        b=gFwvw0G1+6TVq5vVdC+35tb0+yIFmZpl+GhvHvXCH/bTNUhyctWm+Knu0tqISUs0Gk
         xeGFE9andxUgBClqezjF+9meeE5+9PkHIyZdA5fb9Jc09wy0tv0p9FMFcAGPZp6p13UR
         7vMP/ksKZwSgMKL2VLdbo7330EVdBbA+GDrod7Cu2DogpFvzDL1aWZI9hUOw7xICCJ+N
         P3IoFNbElXbMgr6vs10uPcjp86QDj+286V7L0OnCC0/5lFWizjiUvJcrtLqZWzBx7oFZ
         LRGebDDwPzt5t3cNUN+j8u89DBiAb6QTL4wRTBDT4EfW9raqx+krVRMoUWDAxwGMHI2v
         b82A==
X-Gm-Message-State: AOJu0YxsIh7FusXAx4AveOmHX5+hHPWWb4jZufTJTmGNXtMcYjbauR4Z
	aKuJpTLBUpTscXOh8Hr70aQKB795n0ml4tmKWUxREfcsDnN+z4Ik4aeFsQ==
X-Gm-Gg: ASbGncv7ZAJf5UOe1Fwd9SRm/jop3ERtXjq40rI4H37dVzmiBuwY9+mUlmQNb9dKHB3
	jDowXf73odwj21LBD2tHeSfezRfR6TULvxJzF/Ujrf6ZXvM7IbuYR9iJzxAYcHUJ+79gCFMs76+
	CqnZT8q2YN9Nd9/lesE3/MCBsQ3ja8N4YJs4ZMGJWnEeYV1pHGZbhRCREMg8SmyJB9gZdrr/NQx
	gEisdNSHuQ733vuLI1Ju//nWBe04xllaNrzqaN9t8zbGTnGRqg=
X-Google-Smtp-Source: AGHT+IEmF8i6GJzUoM7oMG1Gwbj2+j1jkseqPV0N8jxUIK9Wdur8JdyI0EhEw+GJLwETkBZ6IO4xdA==
X-Received: by 2002:a05:600c:4684:b0:42c:bb10:7292 with SMTP id 5b1f17b1804b1-434ddea3597mr33590655e9.1.1733515644111;
        Fri, 06 Dec 2024 12:07:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da1134b9sm64684445e9.33.2024.12.06.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:07:23 -0800 (PST)
Message-Id: <19a8efebbad7f414e3ef3fdca612dc1fcb835f25.1733515638.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Dec 2024 20:07:17 +0000
Subject: [PATCH 4/5] backfill: add --sparse option
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    christian.couder@gmail.com,
    kristofferhaugsbakk@fastmail.com,
    jonathantanmy@google.com,
    karthik.188@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <derrickstolee@github.com>

From: Derrick Stolee <derrickstolee@github.com>

One way to significantly reduce the cost of a Git clone and later fetches is
to use a blobless partial clone and combine that with a sparse-checkout that
reduces the paths that need to be populated in the working directory. Not
only does this reduce the cost of clones and fetches, the sparse-checkout
reduces the number of objects needed to download from a promisor remote.

However, history investigations can be expensie as computing blob diffs will
trigger promisor remote requests for one object at a time. This can be
avoided by downloading the blobs needed for the given sparse-checkout using
'git backfill' and its new '--sparse' mode, at a time that the user is
willing to pay that extra cost.

Note that this is distinctly different from the '--filter=sparse:<oid>'
option, as this assumes that the partial clone has all reachable trees and
we are using client-side logic to avoid downloading blobs outside of the
sparse-checkout cone. This avoids the server-side cost of walking trees
while also achieving a similar goal. It also downloads in batches based on
similar path names, presenting a resumable download if things are
interrupted.

This augments the path-walk API to have a possibly-NULL 'pl' member that may
point to a 'struct pattern_list'. This could be more general than the
sparse-checkout definition at HEAD, but 'git backfill --sparse' is currently
the only consumer.

Be sure to test this in both cone mode and not cone mode. Cone mode has the
benefit that the path-walk can skip certain paths once they would expand
beyond the sparse-checkout.

To test this, we can create a blobless sparse clone, expand the
sparse-checkout slightly, and then run 'git backfill --sparse' to see
how much data is downloaded. The general steps are

 1. git clone --filter=blob:none --sparse <url>
 2. git sparse-checkout set <dir1> ... <dirN>
 3. git backfill --sparse

For the Git repository with the 'builtin' directory in the
sparse-checkout, we get these results for various batch sizes:

| Batch Size      | Pack Count | Pack Size | Time  |
|-----------------|------------|-----------|-------|
| (Initial clone) | 3          | 110 MB    |       |
| 10K             | 12         | 192 MB    | 17.2s |
| 15K             | 9          | 192 MB    | 15.5s |
| 20K             | 8          | 192 MB    | 15.5s |
| 25K             | 7          | 192 MB    | 14.7s |

This case matters less because a full clone of the Git repository from
GitHub is currently at 277 MB.

Using a copy of the Linux repository with the 'kernel/' directory in the
sparse-checkout, we get these results:

| Batch Size      | Pack Count | Pack Size | Time |
|-----------------|------------|-----------|------|
| (Initial clone) | 2          | 1,876 MB  |      |
| 10K             | 11         | 2,187 MB  | 46s  |
| 25K             | 7          | 2,188 MB  | 43s  |
| 50K             | 5          | 2,194 MB  | 44s  |
| 100K            | 4          | 2,194 MB  | 48s  |

This case is more meaningful because a full clone of the Linux
repository is currently over 6 GB, so this is a valuable way to download
a fraction of the repository and no longer need network access for all
reachable objects within the sparse-checkout.

Choosing a batch size will depend on a lot of factors, including the
user's network speed or reliability, the repository's file structure,
and how many versions there are of the file within the sparse-checkout
scope. There will not be a one-size-fits-all solution.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt            |  6 ++-
 Documentation/technical/api-path-walk.txt |  8 ++++
 builtin/backfill.c                        | 13 +++++-
 dir.c                                     | 10 ++---
 dir.h                                     |  3 ++
 path-walk.c                               | 18 ++++++++
 path-walk.h                               | 11 +++++
 t/helper/test-path-walk.c                 | 22 ++++++++-
 t/t5620-backfill.sh                       | 55 +++++++++++++++++++++++
 t/t6601-path-walk.sh                      | 32 +++++++++++++
 10 files changed, 168 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 9b0bae04e9d..ecf2ac428ce 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [verse]
-'git backfill' [--batch-size=<n>]
+'git backfill' [--batch-size=<n>] [--[no-]sparse]
 
 DESCRIPTION
 -----------
@@ -46,6 +46,10 @@ OPTIONS
 	from the server. This size may be exceeded by the last set of
 	blobs seen at a given path. Default batch size is 16,000.
 
+--[no-]sparse::
+	Only download objects if they appear at a path that matches the
+	current sparse-checkout.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 1fba0ce04cb..3e089211fb4 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -56,6 +56,14 @@ better off using the revision walk API instead.
 	the revision walk so that the walk emits commits marked with the
 	`UNINTERESTING` flag.
 
+`pl`::
+	This pattern list pointer allows focusing the path-walk search to
+	a set of patterns, only emitting paths that match the given
+	patterns. See linkgit:gitignore[5] or
+	linkgit:git-sparse-checkout[1] for details about pattern lists.
+	When the pattern list uses cone-mode patterns, then the path-walk
+	API can prune the set of paths it walks to improve performance.
+
 Examples
 --------
 
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 127333daef8..cdee87e38af 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -4,6 +4,7 @@
 #include "parse-options.h"
 #include "repository.h"
 #include "commit.h"
+#include "dir.h"
 #include "hex.h"
 #include "tree.h"
 #include "tree-walk.h"
@@ -21,7 +22,7 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [--batch-size=<n>]"),
+	N_("git backfill [--batch-size=<n>] [--[no-]sparse]"),
 	NULL
 };
 
@@ -29,6 +30,7 @@ struct backfill_context {
 	struct repository *repo;
 	struct oid_array current_batch;
 	size_t batch_size;
+	int sparse;
 };
 
 static void clear_backfill_context(struct backfill_context *ctx)
@@ -84,6 +86,12 @@ static int do_backfill(struct backfill_context *ctx)
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	int ret;
 
+	if (ctx->sparse) {
+		CALLOC_ARRAY(info.pl, 1);
+		if (get_sparse_checkout_patterns(info.pl))
+			return error(_("problem loading sparse-checkout"));
+	}
+
 	repo_init_revisions(ctx->repo, &revs, "");
 	handle_revision_arg("HEAD", &revs, 0, 0);
 
@@ -110,10 +118,13 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.repo = repo,
 		.current_batch = OID_ARRAY_INIT,
 		.batch_size = 50000,
+		.sparse = 0,
 	};
 	struct option options[] = {
 		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
 			    N_("Minimun number of objects to request at a time")),
+		OPT_BOOL(0, "sparse", &ctx.sparse,
+			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_END(),
 	};
 
diff --git a/dir.c b/dir.c
index c43b5e30813..32af7ee294d 100644
--- a/dir.c
+++ b/dir.c
@@ -1088,10 +1088,6 @@ static void invalidate_directory(struct untracked_cache *uc,
 		dir->dirs[i]->recurse = 0;
 }
 
-static int add_patterns_from_buffer(char *buf, size_t size,
-				    const char *base, int baselen,
-				    struct pattern_list *pl);
-
 /* Flags for add_patterns() */
 #define PATTERN_NOFOLLOW (1<<0)
 
@@ -1181,9 +1177,9 @@ static int add_patterns(const char *fname, const char *base, int baselen,
 	return 0;
 }
 
-static int add_patterns_from_buffer(char *buf, size_t size,
-				    const char *base, int baselen,
-				    struct pattern_list *pl)
+int add_patterns_from_buffer(char *buf, size_t size,
+			     const char *base, int baselen,
+			     struct pattern_list *pl)
 {
 	char *orig = buf;
 	int i, lineno = 1;
diff --git a/dir.h b/dir.h
index a3a2f00f5d9..6cfef5df660 100644
--- a/dir.h
+++ b/dir.h
@@ -467,6 +467,9 @@ void add_patterns_from_file(struct dir_struct *, const char *fname);
 int add_patterns_from_blob_to_list(struct object_id *oid,
 				   const char *base, int baselen,
 				   struct pattern_list *pl);
+int add_patterns_from_buffer(char *buf, size_t size,
+			     const char *base, int baselen,
+			     struct pattern_list *pl);
 void parse_path_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 void add_pattern(const char *string, const char *base,
 		 int baselen, struct pattern_list *pl, int srcpos);
diff --git a/path-walk.c b/path-walk.c
index b31924df52e..47809f8c315 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -12,6 +12,7 @@
 #include "object.h"
 #include "oid-array.h"
 #include "prio-queue.h"
+#include "repository.h"
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
@@ -166,6 +167,23 @@ static int add_children(struct path_walk_context *ctx,
 		if (type == OBJ_TREE)
 			strbuf_addch(&path, '/');
 
+		if (ctx->info->pl) {
+			int dtype;
+			enum pattern_match_result match;
+			match = path_matches_pattern_list(path.buf, path.len,
+							  path.buf + base_len, &dtype,
+							  ctx->info->pl,
+							  ctx->repo->index);
+
+			if (ctx->info->pl->use_cone_patterns &&
+			    match == NOT_MATCHED)
+				continue;
+			else if (!ctx->info->pl->use_cone_patterns &&
+				 type == OBJ_BLOB &&
+				 match != MATCHED)
+				continue;
+		}
+
 		if (!(list = strmap_get(&ctx->paths_to_lists, path.buf))) {
 			CALLOC_ARRAY(list, 1);
 			list->type = type;
diff --git a/path-walk.h b/path-walk.h
index de0db007dc9..0961f67bc9d 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -6,6 +6,7 @@
 
 struct rev_info;
 struct oid_array;
+struct pattern_list;
 
 /**
  * The type of a function pointer for the method that is called on a list of
@@ -47,6 +48,16 @@ struct path_walk_info {
 	 * walk the children of such trees.
 	 */
 	int prune_all_uninteresting;
+
+	/**
+	 * Specify a sparse-checkout definition to match our paths to. Do not
+	 * walk outside of this sparse definition. If the patterns are in
+	 * cone mode, then the search may prune directories that are outside
+	 * of the cone. If not in cone mode, then all tree paths will be
+	 * explored but the path_fn will only be called when the path matches
+	 * the sparse-checkout patterns.
+	 */
+	struct pattern_list *pl;
 };
 
 #define PATH_WALK_INFO_INIT {   \
diff --git a/t/helper/test-path-walk.c b/t/helper/test-path-walk.c
index 7f2d409c5bc..61e845e5ec2 100644
--- a/t/helper/test-path-walk.c
+++ b/t/helper/test-path-walk.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "test-tool.h"
+#include "dir.h"
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
@@ -9,6 +10,7 @@
 #include "revision.h"
 #include "setup.h"
 #include "parse-options.h"
+#include "strbuf.h"
 #include "path-walk.h"
 #include "oid-array.h"
 
@@ -65,7 +67,7 @@ static int emit_block(const char *path, struct oid_array *oids,
 
 int cmd__path_walk(int argc, const char **argv)
 {
-	int res;
+	int res, stdin_pl = 0;
 	struct rev_info revs = REV_INFO_INIT;
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	struct path_walk_test_data data = { 0 };
@@ -80,6 +82,8 @@ int cmd__path_walk(int argc, const char **argv)
 			 N_("toggle inclusion of tree objects")),
 		OPT_BOOL(0, "prune", &info.prune_all_uninteresting,
 			 N_("toggle pruning of uninteresting paths")),
+		OPT_BOOL(0, "stdin-pl", &stdin_pl,
+			 N_("read a pattern list over stdin")),
 		OPT_END(),
 	};
 
@@ -99,6 +103,17 @@ int cmd__path_walk(int argc, const char **argv)
 	info.path_fn = emit_block;
 	info.path_fn_data = &data;
 
+	if (stdin_pl) {
+		struct strbuf in = STRBUF_INIT;
+		CALLOC_ARRAY(info.pl, 1);
+
+		info.pl->use_cone_patterns = 1;
+
+		strbuf_fread(&in, 2048, stdin);
+		add_patterns_from_buffer(in.buf, in.len, "", 0, info.pl);
+		strbuf_release(&in);
+	}
+
 	res = walk_objects_by_path(&info);
 
 	printf("commits:%" PRIuMAX "\n"
@@ -107,6 +122,11 @@ int cmd__path_walk(int argc, const char **argv)
 	       "tags:%" PRIuMAX "\n",
 	       data.commit_nr, data.tree_nr, data.blob_nr, data.tag_nr);
 
+	if (info.pl) {
+		clear_pattern_list(info.pl);
+		free(info.pl);
+	}
+
 	release_revisions(&revs);
 	return res;
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 32e2bb1c132..c2acd1339bd 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -77,6 +77,61 @@ test_expect_success 'do partial clone 2, backfill batch size' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'backfill --sparse' '
+	git clone --sparse --filter=blob:none		\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill3 &&
+
+	# Initial checkout includes four files at root.
+	git -C backfill3 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 44 missing &&
+
+	# Initial sparse-checkout is just the files at root, so we get the
+	# older versions of the four files at tip.
+	GIT_TRACE2_EVENT="$(pwd)/sparse-trace1" git \
+		-C backfill3 backfill --sparse &&
+	test_trace2_data promisor fetch_count 4 <sparse-trace1 &&
+	test_trace2_data path-walk paths 5 <sparse-trace1 &&
+	git -C backfill3 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 40 missing &&
+
+	# Expand the sparse-checkout to include 'd' recursively. This
+	# engages the algorithm to skip the trees for 'a'. Note that
+	# the "sparse-checkout set" command downloads the objects at tip
+	# to satisfy the current checkout.
+	git -C backfill3 sparse-checkout set d &&
+	GIT_TRACE2_EVENT="$(pwd)/sparse-trace2" git \
+		-C backfill3 backfill --sparse &&
+	test_trace2_data promisor fetch_count 8 <sparse-trace2 &&
+	test_trace2_data path-walk paths 15 <sparse-trace2 &&
+	git -C backfill3 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 24 missing
+'
+
+test_expect_success 'backfill --sparse without cone mode' '
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill4 &&
+
+	# No blobs yet
+	git -C backfill4 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# Define sparse-checkout by filename regardless of parent directory.
+	# This downloads 6 blobs to satisfy the checkout.
+	git -C backfill4 sparse-checkout set --no-cone "**/file.1.txt" &&
+	git -C backfill4 checkout main &&
+
+	GIT_TRACE2_EVENT="$(pwd)/no-cone-trace1" git \
+		-C backfill4 backfill --sparse &&
+	test_trace2_data promisor fetch_count 6 <no-cone-trace1 &&
+
+	# This walk needed to visit all directories to search for these paths.
+	test_trace2_data path-walk paths 12 <no-cone-trace1 &&
+	git -C backfill4 rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 36 missing
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
diff --git a/t/t6601-path-walk.sh b/t/t6601-path-walk.sh
index 7d765ffe907..538e2ed297f 100755
--- a/t/t6601-path-walk.sh
+++ b/t/t6601-path-walk.sh
@@ -176,6 +176,38 @@ test_expect_success 'branches and indexed objects mix well' '
 	test_cmp_sorted expect out
 '
 
+test_expect_success 'base & topic, sparse' '
+	cat >patterns <<-EOF &&
+	/*
+	!/*/
+	/left/
+	EOF
+
+	test-tool path-walk --stdin-pl -- base topic <patterns >out &&
+
+	cat >expect <<-EOF &&
+	0:commit::$(git rev-parse topic)
+	0:commit::$(git rev-parse base)
+	0:commit::$(git rev-parse base~1)
+	0:commit::$(git rev-parse base~2)
+	1:tree::$(git rev-parse topic^{tree})
+	1:tree::$(git rev-parse base^{tree})
+	1:tree::$(git rev-parse base~1^{tree})
+	1:tree::$(git rev-parse base~2^{tree})
+	2:blob:a:$(git rev-parse base~2:a)
+	3:tree:left/:$(git rev-parse base:left)
+	3:tree:left/:$(git rev-parse base~2:left)
+	4:blob:left/b:$(git rev-parse base~2:left/b)
+	4:blob:left/b:$(git rev-parse base:left/b)
+	blobs:3
+	commits:4
+	tags:0
+	trees:6
+	EOF
+
+	test_cmp_sorted expect out
+'
+
 test_expect_success 'topic only' '
 	test-tool path-walk -- topic >out &&
 
-- 
gitgitgadget

