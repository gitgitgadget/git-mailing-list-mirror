Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5C51514E4
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935347; cv=none; b=U6I62ZwLwPgZpV1h/aIkLU+j7TybWvgymjr82qxFssH/Ukb/vFhDD37NGc5uhnVmmefbhBS2Bk0DvnAfM65NuN0DohRpf+jelJ/SJGGbpejMyUJQG114HGytc0YKRjjqtbcCh5wQ0ML8UrsNAixm5pVUMI907vjBkfq89GnXDKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935347; c=relaxed/simple;
	bh=ndtY29naIc8nZq8JNhBDL5UNuWm+2MTjMgy3IS7TlEc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BCY1HX7b+XO3KN8RMb5clw3ftyfTiY/9zcFJe8U3Vy7isFi6qO31QBSQlBK/YXJLeUYluMLkmkaffiTCsnANONXv55/wL/oJyrsRrfAWxPHbddMtOCKATyLeHOyEV97cuRSl/H+Pobi+4fXnt2i2ULOU5Zxpq0lWcSXf1vZSp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hx49Pedp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hx49Pedp"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c3cdbe4728so4968813a12.2
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935342; x=1726540142; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJe0VJtiw3wmxFS8RJdy7DTd2s4o6MGfHdt9vLbNyTI=;
        b=Hx49PedpqSA3ZR+icf82CIS5Bf/KRbngw25jEPThuU3Rq62OmpbwfT+q5h7RcT0I5e
         Dw4VL8QatzfzLwL2ZNZOUUH3J80FQ7rna4EABQYB0KKqIoL68WIieHUDa4V1A1/m28MQ
         MbOQwJVpbkrjILARo4qJpv5pqg1qLxYKPhwQJ6VG9wzaWpGvm2Yc8PA/fts+PGgqavJ+
         TIeeh9fI4wDMlc4gyixL2JSiYCw5Toup9NKaMSgR6yJJiUGbKSyboCeGOHFlvzFewsfv
         h5SOTdcSvOGUM6MvxVuI3FY8+nxUyM6w9ueTzIehT8K9eDFRlaokCzwvzTCL8fZYIozx
         HQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935342; x=1726540142;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJe0VJtiw3wmxFS8RJdy7DTd2s4o6MGfHdt9vLbNyTI=;
        b=QbBGNQszlgPPUGHeCXlJv13kqMhOLpn9GkJAL6vjEKeTza3V6LDYZjEn/nCpachPYO
         Sbd9CZi/yP1AZSZPd59Q/Ihqh3OmyPIcrfyQ1zWHvHq5a8UfZV3Td7LdRqnx8XWCS4tJ
         dfP95m7hqF8dOSF3N0CIeMvejav81s0ybgWhNf5u1C/t122W/ijxdwoR0/KYE4ksOitD
         dWzGUnc2lCnEl8KIB1pUlh1UMf/d9rvf0dMHr3kU3LP2iIB540F4r5BsugkY/Hk6KF5b
         QNbgYs6/Jni0TOmtp4XpJBv1oQ+m2TwTZRXtnuiwC5VbJCpsEXI8WAh50njbxeMMg/JN
         wb2g==
X-Gm-Message-State: AOJu0Yx7rnTuUZD73iMCPKx2sEHy7Ow9h70Yb0AmL8E7M2C8tKDozhsj
	IcNHRFjVq4xbdc6qeKt6S3raM+t1//CTC+56C5F0Lm3mgPXV9phb4BWoDQ==
X-Google-Smtp-Source: AGHT+IFkqQDrqH+16cwjm0/f+0xbmA8xMwYyYkRnDZOLdzTBx5Spy2tpAOYrqGDJAIIzoTVdrt0gHQ==
X-Received: by 2002:a17:907:d2c5:b0:a86:95ff:f3a0 with SMTP id a640c23a62f3a-a8d245139admr650974966b.3.1725935341653;
        Mon, 09 Sep 2024 19:29:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c80a24sm415963366b.137.2024.09.09.19.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:29:01 -0700 (PDT)
Message-Id: <cd33c62f9cc7a9b05b0441b956f2b303cd302270.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:30 +0000
Subject: [PATCH 05/30] backfill: add --sparse option
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

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt |  6 +++-
 builtin/backfill.c             | 13 +++++++-
 path-walk.c                    | 18 +++++++++++
 path-walk.h                    | 11 +++++++
 t/t5620-backfill.sh            | 55 ++++++++++++++++++++++++++++++++++
 5 files changed, 101 insertions(+), 2 deletions(-)

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
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 50006f15740..de75471cf44 100644
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
 
@@ -107,10 +115,13 @@ int cmd_backfill(int argc, const char **argv, const char *prefix)
 		.repo = the_repository,
 		.current_batch = OID_ARRAY_INIT,
 		.batch_size = 16000,
+		.sparse = 0,
 	};
 	struct option options[] = {
 		OPT_INTEGER(0, "batch-size", &ctx.batch_size,
 			    N_("Minimun number of objects to request at a time")),
+		OPT_BOOL(0, "sparse", &ctx.sparse,
+			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_END(),
 	};
 
diff --git a/path-walk.c b/path-walk.c
index 2edfa0572e4..dc2390dd9ea 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -10,6 +10,7 @@
 #include "hex.h"
 #include "object.h"
 #include "oid-array.h"
+#include "repository.h"
 #include "revision.h"
 #include "string-list.h"
 #include "strmap.h"
@@ -111,6 +112,23 @@ static int add_children(struct path_walk_context *ctx,
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
index c9e94a98bc8..bc1ebba5081 100644
--- a/path-walk.h
+++ b/path-walk.h
@@ -6,6 +6,7 @@
 
 struct rev_info;
 struct oid_array;
+struct pattern_list;
 
 /**
  * The type of a function pointer for the method that is called on a list of
@@ -30,6 +31,16 @@ struct path_walk_info {
 	 */
 	path_fn path_fn;
 	void *path_fn_data;
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
 
 #define PATH_WALK_INFO_INIT { 0 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 2d81559d8e9..c7bb27b72c1 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -80,6 +80,61 @@ test_expect_success 'do partial clone 2, backfill batch size' '
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
 
-- 
gitgitgadget

