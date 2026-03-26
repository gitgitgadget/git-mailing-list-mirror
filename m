Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF9401A09
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538103; cv=none; b=VAdxW9TLLZ2/ktYQHTjUS0LtuJSAZr/8pHG7eFRgS7WGDWoEM722DkFWiXG/V7sVvnnCMJx7kse+vva01fAw+wt/2eMr0f4tVGlRUmcIG6GllGvgk5xd+34KIfKiCtKlBNAJBdwcZiWZLE7W5UwGfeRehXssEqO/avi7MNHtum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538103; c=relaxed/simple;
	bh=Dc+gSb9kAZZCw2CM059JiNTiGboFvHrLIw8NEEfNafM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=I3Gv8faHCKJ1+xZgDdawEiYGSjX2VtCHr0a43Q1qr7fp7SFJjoasfjlNVU72wg28/vUxT6bp4gSY4feCPuLSgyXcyDx3MNRQPA4Dr3SdpWou+dLfPu3JIHdPeW8w3GRLjaxF09KbYW9kOANAn3d4yUr0TqXbOnK9f6ajtILfT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GiKY6dZR; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GiKY6dZR"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c70b5594f4so122578185a.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538099; x=1775142899; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r9WG22LNe/KuiLeUWF24h8T+ww3D4g9W8Uv/qreSLGc=;
        b=GiKY6dZRUgr9akzlvYBZ3QUgjTwSR1wvlouG/c47GHbRVlzAYh6CHjv84dEw3DkTg4
         ANs2ZL0u9FmQ0zp89r8D3VTAsR8WL7HeZVdQtfyUyPgnxjFUipC4griKXWGOkQ8Bi0aB
         JYUY6TUAP1LZpD4XbIofo/gznDyJMtImbjdqRqPqlNq7T2tm+QI2VjdL1pey67HfWAc/
         +p6CVpxi6aMUazcP4W+vcaJUxDpyDPvEe4kIEgDXsO5UMfZi1P7XGRXWhESoEIQ6R3TQ
         /wFsv0jXtQZK96/NcV3neCm3oTtIJ2o9TLrLRPyJfei8NA9hYALH/qGJHzPfXn5MQVV8
         rg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538099; x=1775142899;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r9WG22LNe/KuiLeUWF24h8T+ww3D4g9W8Uv/qreSLGc=;
        b=NZA92VIsEtPiv5toKULQ9k45WuCV7N8IlcV/cmst4BhHDC22Di61rjRaIU7hALo8cm
         cWuhGUAm0c6LywKRXysxy/blTqPyJn+ZLEb2bJkXJt468XVwKk1+xueMFlCxQ6bSGDeL
         B/5t+JTFskKslW84c5EYf5YdFkchrThreqp+FcTgtxKHQ9+KayeipSE45D9DvkmJNUgI
         jcaYJMSImLIY2/uCDICHwQ73LnaE2LKaHaf2Vf6264V047OnxnZghBN8D6OaOChF2ZKw
         FyO+8yrJg73VVANspILppZYr4Ra5UaZ9viESkdnaAXj+tyykUZbpGOdaaaCC4DiR9me8
         awTQ==
X-Gm-Message-State: AOJu0YxhoBCi84D0h8eYLJvgPEAcI7SQPmCqtGjfaE1dVhdxWhnyTBKH
	KERb1R8kdtgjq7wj8mcqaiBkjzNtBYBlg1Bxj3t2C/gq3r9vyGLwTCkJytIvQw==
X-Gm-Gg: ATEYQzxq6X6qYe6J9Jj3V/hySw5ymGW7Ac0TOPoLozsV09deO2tMhRWZu7NqxX/okhx
	0QZA+68nU5Q/NU1a3VfIpgMekRBdqAZ/YIVfrZrS9HHCab6FJTXR177nyep9zUIIc49q6Fd1z32
	KUQcoSewFZGd3h6gyFg4ymgK+GzQvu8RV6qs0Zodl2CW+I9lN1gNMMYg8rqZd5tF6Bq/vtfultV
	+0u7B2b4K4umIhrztqkLNdLk590ti/LbEfa1gMIgbXPA9EZOZLe01t9dmL7i9DKMbkj4XI3mWTE
	oJcHOJNYNYhAwEHt3NMDc+dK6kG1KRRY7tknawgrMFXqtFQU3dMJ3fiqve/rIknN6n1QxAQxg8k
	xsYbvZQfgYviPYGkxv4yc7CrZZBoEhWmoTx6kf+S7/5DEzPonQwFNqPncxCRMr0h+YLUrcPzuhR
	quxmHHQhK3XLemKm0Kh2jIXcBe6g==
X-Received: by 2002:a05:620a:7104:b0:8cf:dd93:aca5 with SMTP id af79cd13be357-8d0140e1cebmr217522085a.34.1774538099407;
        Thu, 26 Mar 2026 08:14:59 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3d656fsm264311685a.17.2026.03.26.08.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:14:58 -0700 (PDT)
Message-Id: <610a162973a7ad59eba4ef4d5a9288f1fea1d2e8.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:51 +0000
Subject: [PATCH v3 3/6] backfill: accept revision arguments
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The existing implementation of 'git backfill' only includes downloading
missing blobs reachable from HEAD. Advanced uses may desire more general
commit limiting options, such as '--all' for all references, specifying a
commit range via negative references, or specifying a recency of use such as
with '--since=<date>'.

All of these options are available if we use setup_revisions() to parse the
unknown arguments with the revision machinery. This opens up a large number
of possibilities, only a small set of which are tested here.

For documentation, we avoid duplicating the option documentation and instead
link to the documentation of 'git rev-list'.

Note that these arguments currently allow specifying a pathspec, which
modifies the commit history checks but does not limit the paths used in the
backfill logic. This will be updated in a future change.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.adoc |   5 +-
 builtin/backfill.c              |  19 ++--
 t/t5620-backfill.sh             | 156 ++++++++++++++++++++++++++++++++
 3 files changed, 173 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index b8394dcf22..246ab417c2 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -63,9 +63,12 @@ OPTIONS
 	current sparse-checkout. If the sparse-checkout feature is enabled,
 	then `--sparse` is assumed and can be disabled with `--no-sparse`.
 
+You may also specify the commit limiting options from linkgit:git-rev-list[1].
+
 SEE ALSO
 --------
-linkgit:git-clone[1].
+linkgit:git-clone[1],
+linkgit:git-rev-list[1]
 
 GIT
 ---
diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..90c9d84793 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -35,6 +35,7 @@ struct backfill_context {
 	struct oid_array current_batch;
 	size_t min_batch_size;
 	int sparse;
+	struct rev_info revs;
 };
 
 static void backfill_context_clear(struct backfill_context *ctx)
@@ -80,7 +81,6 @@ static int fill_missing_blobs(const char *path UNUSED,
 
 static int do_backfill(struct backfill_context *ctx)
 {
-	struct rev_info revs;
 	struct path_walk_info info = PATH_WALK_INFO_INIT;
 	int ret;
 
@@ -92,13 +92,14 @@ static int do_backfill(struct backfill_context *ctx)
 		}
 	}
 
-	repo_init_revisions(ctx->repo, &revs, "");
-	handle_revision_arg("HEAD", &revs, 0, 0);
+	/* Walk from HEAD if otherwise unspecified. */
+	if (!ctx->revs.pending.nr)
+		add_head_to_pending(&ctx->revs);
 
 	info.blobs = 1;
 	info.tags = info.commits = info.trees = 0;
 
-	info.revs = &revs;
+	info.revs = &ctx->revs;
 	info.path_fn = fill_missing_blobs;
 	info.path_fn_data = ctx;
 
@@ -109,7 +110,6 @@ static int do_backfill(struct backfill_context *ctx)
 		download_batch(ctx);
 
 	path_walk_info_clear(&info);
-	release_revisions(&revs);
 	return ret;
 }
 
@@ -121,6 +121,7 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.current_batch = OID_ARRAY_INIT,
 		.min_batch_size = 50000,
 		.sparse = 0,
+		.revs = REV_INFO_INIT,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
@@ -134,7 +135,12 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 					 builtin_backfill_usage, options);
 
 	argc = parse_options(argc, argv, prefix, options, builtin_backfill_usage,
-			     0);
+			     PARSE_OPT_KEEP_UNKNOWN_OPT |
+			     PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	repo_init_revisions(repo, &ctx.revs, prefix);
+	argc = setup_revisions(argc, argv, &ctx.revs, NULL);
 
 	repo_config(repo, git_default_config, NULL);
 
@@ -143,5 +149,6 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 
 	result = do_backfill(&ctx);
 	backfill_context_clear(&ctx);
+	release_revisions(&ctx.revs);
 	return result;
 }
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 1331949be4..db66d8b614 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -224,6 +224,162 @@ test_expect_success 'backfill --sparse without cone mode (negative)' '
 	test_line_count = 12 missing
 '
 
+test_expect_success 'backfill with revision range' '
+	test_when_finished rm -rf backfill-revs &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-revs &&
+
+	# No blobs yet
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	git -C backfill-revs backfill HEAD~2..HEAD &&
+
+	# 30 objects downloaded.
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 18 missing
+'
+
+test_expect_success 'backfill with revisions over stdin' '
+	test_when_finished rm -rf backfill-revs &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-revs &&
+
+	# No blobs yet
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	cat >in <<-EOF &&
+	HEAD
+	^HEAD~2
+	EOF
+
+	git -C backfill-revs backfill --stdin <in &&
+
+	# 30 objects downloaded.
+	git -C backfill-revs rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 18 missing
+'
+
+test_expect_success 'backfill with prefix pathspec' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The pathspec should limit the downloaded blobs to
+	# only those matching the prefix "d/f", but currently all
+	# blobs are downloaded.
+	git -C backfill-path backfill HEAD -- d/f &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with multiple pathspecs' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The pathspecs should limit the downloaded blobs to
+	# only those matching "d/f" or "a", but currently all blobs
+	# are downloaded.
+	git -C backfill-path backfill HEAD -- d/f a &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with wildcard pathspec' '
+	test_when_finished rm -rf backfill-path &&
+	git clone --bare --filter=blob:none		        \
+		--single-branch --branch=main   		\
+		"file://$(pwd)/srv.bare" backfill-path &&
+
+	# No blobs yet
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 48 missing &&
+
+	# TODO: The wildcard pathspec should limit downloaded blobs,
+	# but currently all blobs are downloaded.
+	git -C backfill-path backfill HEAD -- "d/file.*.txt" &&
+
+	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with --all' '
+	test_when_finished rm -rf backfill-all &&
+	git clone --no-checkout --filter=blob:none		\
+		"file://$(pwd)/srv-revs.bare" backfill-all &&
+
+	# All blobs from all refs are missing
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 54 missing &&
+
+	# Backfill from HEAD gets main blobs only
+	git -C backfill-all backfill HEAD &&
+
+	# Other branch blobs still missing
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 2 missing &&
+
+	# Backfill with --all gets everything
+	git -C backfill-all backfill --all &&
+
+	git -C backfill-all rev-list --quiet --objects --all --missing=print >missing &&
+	test_line_count = 0 missing
+'
+
+test_expect_success 'backfill with --first-parent' '
+	test_when_finished rm -rf backfill-fp &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main			\
+		"file://$(pwd)/srv-revs.bare" backfill-fp &&
+
+	git -C backfill-fp rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 52 missing &&
+
+	# --first-parent skips the side branch commits, so
+	# s/file.{1,2}.txt v1 blobs (only in side commit 1) are missed.
+	git -C backfill-fp backfill --first-parent HEAD &&
+
+	git -C backfill-fp rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 2 missing
+'
+
+test_expect_success 'backfill with --since' '
+	test_when_finished rm -rf backfill-since &&
+	git clone --no-checkout --filter=blob:none		\
+		--single-branch --branch=main			\
+		"file://$(pwd)/srv-revs.bare" backfill-since &&
+
+	git -C backfill-since rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 52 missing &&
+
+	# Use a cutoff between commits 4 and 5 (between v1 and v2
+	# iterations). Commits 5-8 still carry v1 of files 2-4 in
+	# their trees, but v1 of file.1.txt is only in commits 1-4.
+	SINCE=$(git -C backfill-since log --first-parent --reverse \
+		--format=%ct HEAD~1 | sed -n 5p) &&
+	git -C backfill-since backfill --since="@$((SINCE - 1))" HEAD &&
+
+	# 6 missing: v1 of file.1.txt in all 6 directories
+	git -C backfill-since rev-list --quiet --objects --missing=print HEAD >missing &&
+	test_line_count = 6 missing
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

