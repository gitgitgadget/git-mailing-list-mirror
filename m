Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78914D710
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 02:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725935345; cv=none; b=uqAWnV4WtjJXfjItlCd8JVUQrCnU292ZIS2eDNHhe0S94X0YT53BMAwiW7pwkKwIv/CTNRTjlEpdeXKrOUK4GmkEVlUQcZnkmZNOLwjK0yT+9GA106OqAHX2fMuFaENMoQgQ8CDugOiqTzLXZRX0bXHiR8XehOe39fMvNJ5OdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725935345; c=relaxed/simple;
	bh=8ozNh6DaupTCj0gOuq5l65B4rl9Pe7gL3E8KUR122Gc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mAywELv7SSKpGaHcevqqh2vJBQqWqXeVJ3wB0WDE4vpRxLX1MSSrL0RVScUYoK8a8niIsqXIT3IQCr7YaFaVbXIEtFt1eex9wJZJbdTvF25LCAEpbCmXaml2LhhajwreXzYKCHJzeToEM/huifjC0/fpZN6OH7rJGnDlpRylkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjb3dnH9; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjb3dnH9"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365d3f9d34so3373314e87.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 19:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725935341; x=1726540141; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHQ+dG+TUAngLKzXqrm9rZ+af9iT+T6fPXhRv1EJnDM=;
        b=Rjb3dnH9FS4Tt1O0L1diOX12AxWzflskDFzfu6DRnPIZyJCSDWiqX6Cx8UStdSCVJ4
         UWi8M5CJq2Y/VrAB8dWeX5+mYojoJykgOFljietf9UmPatd6svl4CRWe0HBsMEzm/YWh
         09qWmsx9tqnGu1hiC3kK00vI/Mgga0NM3YG339LXXfaWBG+0giL4hvKzLYEO62Q/HEfx
         94BfrAZ1VQry4DRazqyPeJdv2d+xOoYMh9urT+9zWKWcl2Dn707Qsh9Hw6rWpkNx0wMc
         PUIKHFHID4B3XeVaYPQF+BrXZQs2xuj6bDJv/r3fjVdQb0PSfOcodXg+LUt+GRy3gCBK
         x6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725935341; x=1726540141;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHQ+dG+TUAngLKzXqrm9rZ+af9iT+T6fPXhRv1EJnDM=;
        b=ku5ff/cus+OXhGmlUx0N1DrQw1kIYel1Bzx4HqT0qDPay1bamHsk+iwxrBUHgzr7jd
         glP2xVTNsxJc0Yipt5nVLOwuuO4cqDUm28AQZbiGGc4knX51EC6xxgvXWK4jBjZ7/wcq
         WX6SkOsHwOgeQgMHpcjusDfn0p/DPQr8mkP6PhFuAY1zcovEltrtMJ0NvM3TEu3j49Pv
         C1fiG7Rrc8vBn3NXRDMw5/tZ5QETMACyVeo17zF+fVXhcPjCvPjCMwZk3le6UAR2Q2St
         T7J4T6HohMth8a2vrza+cWn3Lty4PGh3L7Lgb0akNQRERpuNaVUhPfWMFWirXCUhJeK8
         HfEw==
X-Gm-Message-State: AOJu0YxlNbiY6dqAuX4RIX5tMUzJS6yPt3egWJ/ui1RZQBL8LWqJwM46
	1m5uM4Ft9nf5GHp2qINSHVo6pqO4frYaHmCN6PiZ6M36gCrwBVXn980FJA==
X-Google-Smtp-Source: AGHT+IHzYELrtVtfoZXodOD7ZB1r5n/+pUhEuqrVzP1oyOwAhwRGpSoKA9w0vTqhSTS/Ex0pOGr/TA==
X-Received: by 2002:a05:6512:3989:b0:536:54d6:e6e3 with SMTP id 2adb3069b0e04-53658819213mr7941394e87.61.1725935340088;
        Mon, 09 Sep 2024 19:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd467f5sm3655943a12.36.2024.09.09.19.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 19:28:58 -0700 (PDT)
Message-Id: <be21c8370eb5143c3f6e91d354d48465d221692a.1725935335.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Sep 2024 02:28:28 +0000
Subject: [PATCH 03/30] backfill: basic functionality and tests
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

The default behavior of 'git backfill' is to fetch all missing blobs that
are reachable from HEAD. Document and test this behavior.

The implementation is a very simple use of the path-walk API, initializing
the revision walk at HEAD to start the path-walk from all commits reachable
from HEAD. Ignore the object arrays that correspond to tree entries,
assuming that they are all present already.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt |  24 ++++++++
 builtin/backfill.c             | 101 ++++++++++++++++++++++++++++++++-
 t/t5620-backfill.sh            |  97 +++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+), 3 deletions(-)
 create mode 100755 t/t5620-backfill.sh

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index 640144187d3..0e10f066fef 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -14,6 +14,30 @@ SYNOPSIS
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
+By default, `git backfill` downloads all blobs reachable from the `HEAD`
+commit. This set can be restricted or expanded using various options.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 77b05a2f838..23d40fc02a2 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -1,16 +1,113 @@
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
+static void clear_backfill_context(struct backfill_context *ctx)
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
+static int fill_missing_blobs(const char *path,
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
+		if (oid_object_info_extended(the_repository,
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
+	clear_backfill_context(ctx);
+	return ret;
+}
+
 int cmd_backfill(int argc, const char **argv, const char *prefix)
 {
+	struct backfill_context ctx = {
+		.repo = the_repository,
+		.current_batch = OID_ARRAY_INIT,
+		.batch_size = 16000,
+	};
 	struct option options[] = {
 		OPT_END(),
 	};
@@ -23,7 +120,5 @@ int cmd_backfill(int argc, const char **argv, const char *prefix)
 
 	git_config(git_default_config, NULL);
 
-	die(_("not implemented"));
-
-	return 0;
+	return do_backfill(&ctx);
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
new file mode 100755
index 00000000000..43868a4a75f
--- /dev/null
+++ b/t/t5620-backfill.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+
+test_description='git backfill on partial clones'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+TEST_PASSES_SANITIZE_LEAK=0
+export TEST_PASSES_SANITIZE_LEAK
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

