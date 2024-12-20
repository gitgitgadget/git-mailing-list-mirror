Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65A219A9B
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734712202; cv=none; b=t3XXmx/locIDmHwjjj3//tAcA0tncKg8StzQ+FKq8Qk3GnKj6MWxUA1kh1y6I3Eevn6R+JIISYogPshNYUnMqgB7wMPS6DjyfIqIBo6wpk0vtLfOfnjAnEsTdjWKxzkSmo+0m6ikn+eldAMFRAC6u/lIFjhQbMxxdgYGajikYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734712202; c=relaxed/simple;
	bh=ME1YLd5a96/jrECsyHIbbUX8ykWy3yDkabIopGfkeXk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iMf/esa9IvJwmp3oIebeUJKHZzmy2tp9dZzKPCEbWcRvZpwKbgfx87dKoAllVptQaP4NmY3KV0MzuPMRzEjZCGq0dAykaDQuBUF4iXuMic9csti/Se6VqdgiiIB4WRC3zf9xqtmmlwhKrvLalzbNTQsQj1SI5rqezTlGW/5xnJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9maQm4b; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9maQm4b"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43623f0c574so14708885e9.2
        for <git@vger.kernel.org>; Fri, 20 Dec 2024 08:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734712198; x=1735316998; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iavcp7DQaRcLwqLmdmEgrLlPN3yQyImzLWHZt8CJ+8s=;
        b=P9maQm4bdBqtN7heL+vQTPznfSNuXNlAj7e+kA5mIRsFWV3iofGi3bcsNQrGIJzxat
         Vawgqy+lnIGGiaVINds9A4fJbQrUvGq2P1KFN/t2nzX6YwvD+O+mcatrZoQLDvTIPU/1
         a4HTtGRLwLOoZeT+t342LEAkpOoQ4I5sDhsw47L+wgbkxSV5K/hhsqRr2fMrg9HsanHV
         pfVqgMq87nwJq2eKg6J+QL0Zxu31QXZG1pijFsknfAYHGGEi8ZEG3bcnJpdSciTi+GDN
         mePI1df+M9gG9U8VbBgsIuN+W6HThJWjWMFuo35SV0wUyrP8LPrgUZxByAFy30s5HiLJ
         Q1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734712198; x=1735316998;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iavcp7DQaRcLwqLmdmEgrLlPN3yQyImzLWHZt8CJ+8s=;
        b=JadJf15Zi9aK3D9U8cuPm5sfii5EPoHBoQPWZYu1htA0jp8eVuQ0miR4IijAWfjBIc
         Ik5BjeNcXpoR83JmCItDZVy6W+9KQRHkA1le+G7vwx2BRJPINum5ekgqRQnnOzgUs5Xx
         y5By7QU96GpM/haikUGTNbEqFq01ngHf3ClS3kftQ+oY/vpNEbTUug8GUwK0CxR8b8rR
         Fo+UiYL+PkQNJf407yu2GRZFX8zf8ejHx8gcDcVCjWpSOZf1fJ6St44FsjdnwoHi9tpj
         EjSPzyv/Sg5DQz8GL9aLIroKfwRqFmEvna1/q++h5oyXMApv/aimIFBZQcWEW2e7xE+t
         eoCQ==
X-Gm-Message-State: AOJu0Yz5WJAG1bopC5Gk9IVvanR47vb1YGHQ2kdHuLifaZtgqAWU7NCz
	H+yAMcsMoyJaISwVSVQZIYQn03+HKFNF6yjKUN3BdU2aoJaLOFdV2FaHRQ==
X-Gm-Gg: ASbGnct+Y5LYc6k4qpMDr1lm9qIrvZtSomKwYNhrS1uYm8wE0uNJj/1QSAiqDpu1S0Q
	Gxwos0X0dQdC+Fp6PnBHtysyQNHrRQpcunYlRF2TU2N3sNE+D1Qp4a6VQYHCn+BKRVgsao9IXcO
	zEo5+TLR8swgp22BbsgxPI5onxrUtwbKqz0ZPptP7XnaR7M9WxvQtmtc+jugK5L0aWf4fCJbSpj
	5nxdG658L8/RTxu0iTK4LmeHokhrBthtC/9uX6nYzCy07CclJUKO18tdQ==
X-Google-Smtp-Source: AGHT+IE7qKBkslBionUz6pNV2079pi2wuRfSAfC3/QR1P2ZnoFiX057IJhk9yGFZoAquax2Kz6KoOg==
X-Received: by 2002:a05:600c:1c1a:b0:434:f0df:a14 with SMTP id 5b1f17b1804b1-43668548500mr29899185e9.2.1734712197989;
        Fri, 20 Dec 2024 08:29:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366127c515sm50134715e9.30.2024.12.20.08.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 08:29:57 -0800 (PST)
Message-Id: <3fa32822dabb64266a0625c50530ae2ae0797de6.1734712193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
References: <pull.1820.git.1733515638.gitgitgadget@gmail.com>
	<pull.1820.v2.git.1734712193.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Dec 2024 16:29:51 +0000
Subject: [PATCH v2 3/5] backfill: add --min-batch-size=<n> option
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

Users may want to specify a minimum batch size for their needs. This is only
a minimum: the path-walk API provides a list of OIDs that correspond to the
same path, and thus it is optimal to allow delta compression across those
objects in a single server request.

We could consider limiting the request to have a maximum batch size in the
future. For now, we let the path-walk API batches determine the
boundaries.

To get a feeling for the value of specifying the --batch-size parameter,
I tested a number of open source repositories available on GitHub. The
procedure was generally:

 1. git clone --filter=blob:none <url>
 2. git backfill

Checking the number of packfiles and the size of the .git/objects/pack
directory helps to identify the effects of different batch sizes.

For the Git repository, we get these results:

| Batch Size      | Pack Count | Pack Size | Time  |
|-----------------|------------|-----------|-------|
| (Initial clone) | 2          | 119 MB    |       |
| 25K             | 8          | 290 MB    | 24s   |
| 50K             | 5          | 290 MB    | 24s   |
| 100K            | 4          | 290 MB    | 29s   |

Other than the packfile counts decreasing as we need fewer batches, the
size and time required is not changing much for this small example.

For the nodejs/node repository, we see these results:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 330 MB    |        |
| 25K             | 19         | 1,222 MB  | 1m 22s |
| 50K             | 11         | 1,221 MB  | 1m 24s |
| 100K            | 7          | 1,223 MB  | 1m 40s |
| 250K            | 4          | 1,224 MB  | 2m 23s |
| 500K            | 3          | 1,216 MB  | 4m 38s |

Here, we don't have much difference in the size of the repo, though the
500K batch size results in a few MB gained. That comes at a cost of a
much longer time. This extra time is due to server-side delta
compression happening as the on-disk deltas don't appear to be reusable
all the time. But for smaller batch sizes, the server is able to find
reasonable deltas partly because we are asking for objects that appear
in the same region of the directory tree and include all versions of a
file at a specific path.

To contrast this example, I tested the microsoft/fluentui repo, which
has been known to have inefficient packing due to name hash collisions.
These results are found before GitHub had the opportunity to repack the
server with more advanced name hash versions:

| Batch Size      | Pack Count | Pack Size | Time   |
|-----------------|------------|-----------|--------|
| (Initial clone) | 2          | 105 MB    |        |
| 5K              | 53         | 348 MB    | 2m 26s |
| 10K             | 28         | 365 MB    | 2m 22s |
| 15K             | 19         | 407 MB    | 2m 21s |
| 20K             | 15         | 393 MB    | 2m 28s |
| 25K             | 13         | 417 MB    | 2m 06s |
| 50K             | 8          | 509 MB    | 1m 34s |
| 100K            | 5          | 535 MB    | 1m 56s |
| 250K            | 4          | 698 MB    | 1m 33s |
| 500K            | 3          | 696 MB    | 1m 42s |

Here, a larger variety of batch sizes were chosen because of the great
variation in results. By asking the server to download small batches
corresponding to fewer paths at a time, the server is able to provide
better compression for these batches than it would for a regular clone.
A typical full clone for this repository would require 738 MB.

This example justifies the choice to batch requests by path name,
leading to improved communication with a server that is not optimally
packed.

Finally, the same experiment for the Linux repository had these results:

| Batch Size      | Pack Count | Pack Size | Time    |
|-----------------|------------|-----------|---------|
| (Initial clone) | 2          | 2,153 MB  |         |
| 25K             | 63         | 6,380 MB  | 14m 08s |
| 50K             | 58         | 6,126 MB  | 15m 11s |
| 100K            | 30         | 6,135 MB  | 18m 11s |
| 250K            | 14         | 6,146 MB  | 18m 22s |
| 500K            | 8          | 6,143 MB  | 33m 29s |

Even in this example, where the default name hash algorithm leads to
decent compression of the Linux kernel repository, there is value for
selecting a smaller batch size, to a limit. The 25K batch size has the
fastest time, but uses 250 MB more than the 50K batch size. The 500K
batch size took much more time due to server compression time and thus
we should avoid large batch sizes like this.

Based on these experiments, a batch size of 50,000 was chosen as the
default value.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-backfill.txt | 11 ++++++++++-
 builtin/backfill.c             | 10 ++++++----
 t/t5620-backfill.sh            | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-backfill.txt b/Documentation/git-backfill.txt
index ece887831f6..e392517869c 100644
--- a/Documentation/git-backfill.txt
+++ b/Documentation/git-backfill.txt
@@ -9,7 +9,7 @@ git-backfill - Download missing objects in a partial clone
 SYNOPSIS
 --------
 [verse]
-'git backfill' [<options>]
+'git backfill' [--batch-size=<n>]
 
 DESCRIPTION
 -----------
@@ -45,6 +45,15 @@ time.
 By default, `git backfill` downloads all blobs reachable from the `HEAD`
 commit. This set can be restricted or expanded using various options.
 
+OPTIONS
+-------
+
+--min-batch-size=<n>::
+	Specify a minimum size for a batch of missing objects to request
+	from the server. This size may be exceeded by the last set of
+	blobs seen at a given path. The default minimum batch size is
+	50,000.
+
 SEE ALSO
 --------
 linkgit:git-clone[1].
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 177fd4286c7..ddccececc36 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -21,14 +21,14 @@
 #include "path-walk.h"
 
 static const char * const builtin_backfill_usage[] = {
-	N_("git backfill [<options>]"),
+	N_("git backfill [--batch-size=<n>]"),
 	NULL
 };
 
 struct backfill_context {
 	struct repository *repo;
 	struct oid_array current_batch;
-	size_t batch_size;
+	size_t min_batch_size;
 };
 
 static void backfill_context_clear(struct backfill_context *ctx)
@@ -72,7 +72,7 @@ static int fill_missing_blobs(const char *path UNUSED,
 			oid_array_append(&ctx->current_batch, &list->oid[i]);
 	}
 
-	if (ctx->current_batch.nr >= ctx->batch_size)
+	if (ctx->current_batch.nr >= ctx->min_batch_size)
 		download_batch(ctx);
 
 	return 0;
@@ -111,9 +111,11 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 	struct backfill_context ctx = {
 		.repo = repo,
 		.current_batch = OID_ARRAY_INIT,
-		.batch_size = 50000,
+		.min_batch_size = 50000,
 	};
 	struct option options[] = {
+		OPT_INTEGER(0, "min-batch-size", &ctx.min_batch_size,
+			    N_("Minimum number of objects to request at a time")),
 		OPT_END(),
 	};
 
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 64326362d80..36107a51c54 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -59,6 +59,24 @@ test_expect_success 'do partial clone 1, backfill gets all objects' '
 	test_line_count = 0 revs2
 '
 
+test_expect_success 'do partial clone 2, backfill min batch size' '
+	git clone --no-checkout --filter=blob:none	\
+		--single-branch --branch=main 		\
+		"file://$(pwd)/srv.bare" backfill2 &&
+
+	GIT_TRACE2_EVENT="$(pwd)/batch-trace" git \
+		-C backfill2 backfill --min-batch-size=20 &&
+
+	# Batches were used
+	test_trace2_data promisor fetch_count 20 <batch-trace >matches &&
+	test_line_count = 2 matches &&
+	test_trace2_data promisor fetch_count 8 <batch-trace &&
+
+	# No more missing objects!
+	git -C backfill2 rev-list --quiet --objects --missing=print HEAD >revs2 &&
+	test_line_count = 0 revs2
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
gitgitgadget

