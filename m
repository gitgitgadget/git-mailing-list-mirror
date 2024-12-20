Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B1219E93
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712202; cv=none; b=Bxl68Fwnv/9bc1GD6Y1WEpTAhVTLX830FDr3jC5X23aNyVi0vHe9wvXtNfmoBzwyqY0Mft2tAqMBWjLo6uD1h+4M/oGqGAWFoNRkJYWbhC6yvNQj0hIYUD1rtF/U3VM92LHdkydFe+4qKiH75Aozm8csNGNYL9DkqIkjl6RRE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712202; c=relaxed/simple;
	bh=TZoCoFrF/t/CIwFC9xzlxTCQoRyTOhtb5XUXNnOOOv0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jAMWONE2V1twlr+BeFyU8M9bk+c2EOKOxIjUcdtLU0kD88g3DKeaiPeSRuuz40l/pGfjimd/v/NCGeGtYjMoMI77sk1uYqmAz63CbOn2LycO2Cd4bf9VVCBwdLUvp9duLZl6ZLU91GjcbEoDhEv+oV0hF5VcoWDINRJSk0MsPqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PR+v1Y+p; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR+v1Y+p"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361a50e337so14886335e9.0
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734712197; x=1735316997; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R46F2SvtDdcV3I/HyD8wyLC+bxL0tz5N2DNmYNh631g=;
        b=PR+v1Y+p22gvcxdyeHMkhUFSYTstp0lzkKE1lO3wXb11k4qo4aojokOxsG8tJysOVG
         hZ75VVZEO8JYYMBi8AXwufavj+mgNJx4KJlVn57IxklQ39l5nsq6uxGEWOjvVlc1cApS
         hbykYaAKyzZ7Wvb5iK3Q+CAlwe/k+IB7C5X1ZPBnurLEpYP8zfbGXqexLxyX114UHAmz
         PERVTOK/YTGZrrwt2R+4bZIqZfjNV4W4X8DbHE9JUVbayYsSbPtQCRrMPu7o4pE8CLQv
         XwQC5Mn2p0ZOIiCJG8POt428gP9LLVO567it5QCYSD494+7VSl55yGrYik//TLnFsNnR
         oVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712197; x=1735316997;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R46F2SvtDdcV3I/HyD8wyLC+bxL0tz5N2DNmYNh631g=;
        b=SwVJSj8vFruNX4Vbbs2GS9jahVAWXNu03/J2TIZ5lECjAH7Q+OD7OF9zBdMucvkeJZ
         ++PwF+lEgp7NP1YCEKJM0MFcr9R6/FisPeTApxLSe3DyL4NMTNTDJarpu+LtRXrWqMOo
         LFjA4ub5yl9b8qKdAUSD9XmVDUyPGa4+bY0eW/o8nLlhvlkDhm0w7fiokUa26SFos10P
         JHync6Q2OaqUanJ48SuaRg4djMECRJfxwT7JKFTfHQsOHqnatVd4NMUDHJ+MKZcJvzRO
         3hrrzWKSjjVEi3K/vA+5s2pZl0qia87n8SXNDPuDdssXRPkv5DzXxqdiV54dTlneAXw6
         KJ2w==
X-Gm-Message-State: AOJu0YxXb0kS+OoUmrPeaDIka/rhAwFj+7BPOr6NA0tvuWkgOKotB6ol
	nNS8y39UyJwlwKWpKBID4kMfTZwTMNx9IW3kG2vlBpgWjQT6Gat1TIQkHg==
X-Gm-Gg: ASbGncs+vUBnP3xJpyknnEKlcHbo5sfr9O+k3fWiXeDY1Oq1+3qKxkoJ7h2Qun/FOMp
	GMygj+Ob23oN5TpTxSFm0gYda+LeE/on7fVWwF91tidbM2n89yp5Xujl5AlUcf5JbiLSdEGdqVi
	ZjIdOUINaaVPzXun3cqlF5NRmt1Pr4IzCJ2J3EmW5F3oxZdyX5HPx+6kVX/5Lf3JzrkR+xLJ+pv
	ysbpOUwlS7HQPjYlImgDZ0q05KF8rjnjGw3PMFkbG9CzbzUhp3PDYUVmw==
X-Google-Smtp-Source: AGHT+IGVV0uTu+czqf6UJ8DKYoUSJOW9qWLqMt+EpP8DKX2+c2xAxXpEX5ECkMzO1D4oHEF4ThMLMQ==
X-Received: by 2002:a05:600c:1c0b:b0:435:9ed3:5688 with SMTP id 5b1f17b1804b1-43668646750mr34257425e9.18.1734712197064;
        Fri, 20 Dec 2024 08:29:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b3b1f6sm85130475e9.31.2024.12.20.08.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:29:56 -0800 (PST)
Message-Id: <e4e88794cae7edc568dd054b1376caac7fd30076.1734712193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:29:50 +0000
Subject: [PATCH v2 2/5] backfill: basic functionality and tests
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

The default behavior of 'git backfill' is to fetch all missing blobs that
are reachable from HEAD. Document and test this behavior.

The implementation is a very simple use of the path-walk API, initializing
the revision walk at HEAD to start the path-walk from all commits reachable
from HEAD. Ignore the object arrays that correspond to tree entries,
assuming that they are all present already.

The path-walk API provides lists of objects in batches according to a
common path, but that list could be very small. We want to balance the
number of requests to the server with the ability to have the process
interrupted with minimal repeated work to catch up in the next run.
Based on some experiments (detailed in the next change) a minimum batch
size of 50,000 is selected for the default.

This batch size is a _minimum_. As the path-walk API emits lists of blob
IDs, they are collected into a list of objects for a request to the
server. When that list is at least the minimum batch size, then the
request is sent to the server for the new objects. However, the list of
blob IDs from the path-walk API could be much longer than the batch
size. At this moment, it is unclear if there is a benefit to split the
list when there are too many objects at the same path.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt            |  31 +++++++
 Documentation/technical/api-path-walk.txt |   3 +-
 builtin/backfill.c                        | 106 +++++++++++++++++++++-
 t/t5620-backfill.sh                       |  94 +++++++++++++++++++
 4 files changed, 230 insertions(+), 4 deletions(-)
 create mode 100755 t/t5620-backfill.sh

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 640144187d3..ece887831f6 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -14,6 +14,37 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
+Blobless partial clones are created using `git clone --filter=blob:none`
+and then configure the local repository such that the Git client avoids
+downloading blob objects unless they are required for a local operation.
+This initially means that the clone and later fetches download reachable
+commits and trees but no blobs. Later operations that change the `HEAD`
+pointer, such as `git checkout` or `git merge`, may need to download
+missing blobs in order to complete their operation.
+
+In the worst cases, commands that compute blob diffs, such as `git blame`,
+become very slow as they download the missing blobs in single-blob
+requests to satisfy the missing object as the Git command needs it. This
+leads to multiple download requests and no ability for the Git server to
+provide delta compression across those objects.
+
+The `git backfill` command provides a way for the user to request that
+Git downloads the missing blobs (with optional filters) such that the
+missing blobs representing historical versions of files can be downloaded
+in batches. The `backfill` command attempts to optimize the request by
+grouping blobs that appear at the same path, hopefully leading to good
+delta compression in the packfile sent by the server.
+
+In this way, `git backfill` provides a mechanism to break a large clone
+into smaller chunks. Starting with a blobless partial clone with `git
+clone --filter=blob:none` and then running `git backfill` in the local
+repository provides a way to download all reachable objects in several
+smaller network calls than downloading the entire repository at clone
+time.
+
+By default, `git backfill` downloads all blobs reachable from the `HEAD`
+commit. This set can be restricted or expanded using various options.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/Documentation/technical/api-path-walk.txt b/Documentation/technical/api-path-walk.txt
index 7075d0d5ab5..1fba0ce04cb 100644
--- a/Documentation/technical/api-path-walk.txt
+++ b/Documentation/technical/api-path-walk.txt
@@ -60,4 +60,5 @@ Examples
 --------
 
 See example usages in:
-	`t/helper/test-path-walk.c`
+	`t/helper/test-path-walk.c`,
+	`builtin/backfill.c`
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 38e6aaeaa03..177fd4286c7 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,16 +1,118 @@
 #include "builtin.h"
+#include "git-compat-util.h"
 #include "config.h"
 #include "parse-options.h"
 #include "repository.h"
+#include "commit.h"
+#include "hex.h"
+#include "tree.h"
+#include "tree-walk.h"
 #include "object.h"
+#include "object-store-ll.h"
+#include "oid-array.h"
+#include "oidset.h"
+#include "promisor-remote.h"
+#include "strmap.h"
+#include "string-list.h"
+#include "revision.h"
+#include "trace2.h"
+#include "progress.h"
+#include "packfile.h"
+#include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
 	N_("git backfill [<options>]"),
 	NULL
 };
 
+struct backfill_context {
+	struct repository *repo;
+	struct oid_array current_batch;
+	size_t batch_size;
+};
+
+static void backfill_context_clear(struct backfill_context *ctx)
+{
+	oid_array_clear(&ctx->current_batch);
+}
+
+static void download_batch(struct backfill_context *ctx)
+{
+	promisor_remote_get_direct(ctx->repo,
+				   ctx->current_batch.oid,
+				   ctx->current_batch.nr);
+	oid_array_clear(&ctx->current_batch);
+
+	/*
+	 * We likely have a new packfile. Add it to the packed list to
+	 * avoid possible duplicate downloads of the same objects.
+	 */
+	reprepare_packed_git(ctx->repo);
+}
+
+static int fill_missing_blobs(const char *path UNUSED,
+			      struct oid_array *list,
+			      enum object_type type,
+			      void *data)
+{
+	struct backfill_context *ctx = data;
+
+	if (type != OBJ_BLOB)
+		return 0;
+
+	for (size_t i = 0; i < list->nr; i++) {
+		off_t size = 0;
+		struct object_info info = OBJECT_INFO_INIT;
+		info.disk_sizep = &size;
+		if (oid_object_info_extended(ctx->repo,
+					     &list->oid[i],
+					     &info,
+					     OBJECT_INFO_FOR_PREFETCH) ||
+		    !size)
+			oid_array_append(&ctx->current_batch, &list->oid[i]);
+	}
+
+	if (ctx->current_batch.nr >= ctx->batch_size)
+		download_batch(ctx);
+
+	return 0;
+}
+
+static int do_backfill(struct backfill_context *ctx)
+{
+	struct rev_info revs;
+	struct path_walk_info info = PATH_WALK_INFO_INIT;
+	int ret;
+
+	repo_init_revisions(ctx->repo, &revs, "");
+	handle_revision_arg("HEAD", &revs, 0, 0);
+
+	info.blobs = 1;
+	info.tags = info.commits = info.trees = 0;
+
+	info.revs = &revs;
+	info.path_fn = fill_missing_blobs;
+	info.path_fn_data = ctx;
+
+	ret = walk_objects_by_path(&info);
+
+	/* Download the objects that did not fill a batch. */
+	if (!ret)
+		download_batch(ctx);
+
+	backfill_context_clear(ctx);
+	path_walk_info_clear(&info);
+	release_revisions(&revs);
+	return ret;
+}
+
 int cmd_backfill(int argc, const char **argv, const char *prefix, struct repository *repo)
 {
+	struct backfill_context ctx = {
+		.repo = repo,
+		.current_batch = OID_ARRAY_INIT,
+		.batch_size = 50000,
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
@@ -23,7 +125,5 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	repo_config(repo, git_default_config, NULL);
 
-	die(_("not implemented"));
-
-	return 0;
+	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
new file mode 100755
index 00000000000..64326362d80
--- /dev/null
+++ b/t/t5620-backfill.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+
+test_description='git backfill on partial clones'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# We create objects in the 'src' repo.
+test_expect_success 'setup repo for object creation' '
+	echo "{print \$1}" >print_1.awk &&
+	echo "{print \$2}" >print_2.awk &&
+
+	git init src &&
+
+	mkdir -p src/a/b/c &&
+	mkdir -p src/d/e &&
+
+	for i in 1 2
+	do
+		for n in 1 2 3 4
+		do
+			echo "Version $i of file $n" > src/file.$n.txt &&
+			echo "Version $i of file a/$n" > src/a/file.$n.txt &&
+			echo "Version $i of file a/b/$n" > src/a/b/file.$n.txt &&
+			echo "Version $i of file a/b/c/$n" > src/a/b/c/file.$n.txt &&
+			echo "Version $i of file d/$n" > src/d/file.$n.txt &&
+			echo "Version $i of file d/e/$n" > src/d/e/file.$n.txt &&
+			git -C src add . &&
+			git -C src commit -m "Iteration $n" || return 1
+		done
+	done
+'
+
+# Clone 'src' into 'srv.bare' so we have a bare repo to be our origin
+# server for the partial clone.
+test_expect_success 'setup bare clone for server' '
+	git clone --bare "file://$(pwd)/src" srv.bare &&
+	git -C srv.bare config --local uploadpack.allowfilter 1 &&
+	git -C srv.bare config --local uploadpack.allowanysha1inwant 1
+'
+
+# do basic partial clone from "srv.bare"
+test_expect_success 'do partial clone 1, backfill gets all objects' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill1 &&
+
+	# Backfill with no options gets everything reachable from HEAD.
+	GIT_TRACE2_EVENT="$(pwd)/backfill-file-trace" git \
+		-C backfill1 backfill &&
+
+	# We should have engaged the partial clone machinery
+	test_trace2_data promisor fetch_count 48 <backfill-file-trace &&
+
+	# No more missing objects!
+	git -C backfill1 rev-list --quiet --objects --missing=print HEAD >revs2 &&
+	test_line_count = 0 revs2
+'
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+test_expect_success 'create a partial clone over HTTP' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	git clone --bare "file://$(pwd)/src" "$SERVER" &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	git clone --no-checkout --filter=blob:none \
+		"$HTTPD_URL/smart/server" backfill-http
+'
+
+test_expect_success 'backfilling over HTTP succeeds' '
+	GIT_TRACE2_EVENT="$(pwd)/backfill-http-trace" git \
+		-C backfill-http backfill &&
+
+	# We should have engaged the partial clone machinery
+	test_trace2_data promisor fetch_count 48 <backfill-http-trace &&
+
+	# Confirm all objects are present, none missing.
+	git -C backfill-http rev-list --objects --all >rev-list-out &&
+	awk "{print \$1;}" <rev-list-out >oids &&
+	GIT_TRACE2_EVENT="$(pwd)/walk-trace" git -C backfill-http \
+		cat-file --batch-check <oids >batch-out &&
+	! grep missing batch-out
+'
+
+# DO NOT add non-httpd-specific tests here, because the last part of this
+# test script is only executed when httpd is available and enabled.
+
+test_done
-- 
gitgitgadget

