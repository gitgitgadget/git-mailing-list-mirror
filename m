Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DCE3090CD
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 00:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727725; cv=none; b=nR2x7pbY5pgfFICX/1Tb8B84Cy85kBUHdq2MycKmDpFWe0dE6kpt5xlQ97FHc7ZiZxIDicprr3zfkeAfHM1e7hNEVveeAtaFUM0l8HJVeL8i1/og43Wn0bUmY6Td5y+OuPdcGXJh2qkNxip9TV5jBCco1+28wKk9HsRqZKzVj5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727725; c=relaxed/simple;
	bh=PNOUTy11GPx3aWSj6Ij0QPBHu4/Ou0vWahouf2Cw7ig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XzsZS8G/TPGEhI0Ny9lwGzTNmPXVzCDbGzncQLQYU5aYxE7xwJpJviG7S8TPGTvTRGFZWXQ5R1ngmObbjLQHwJYTIDTPEUneR+uwVTQ0Yt5AUNb/rbj6ogOmRIQcoRz6Nbw+un9wWvduwP37flhcj9yayO6pZQbr2sObMhb6mCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKdooZvi; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKdooZvi"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffa15f67fso21645715e9.2
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 17:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790727720; x=1791332520; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zu1cWTlAGP+APTGfeDYTlNoaREve/1tEASbNefnhFMs=;
        b=SKdooZviYu/VdtQNfzyH0YznybwybAjOGrg/5hAo4L0nkaY/+HYgF7ete3RRAAMK+3
         WipsqsP5eEADN/P1Lg/NePlp8afIUFH4+/mSxfKJdVqlQHJRd3jrg/4Ys+tKWcTbi/VO
         kqGpqRh2bLh49HLbDUvKTqj5FyKdHO06rMRXyr8q9YCamRj1fieua/83u6beR325w58m
         ugUb4zWqKNwbQqcCG3WQJIhw9Pgns3lHS1U+NEeWtKrx+xo2K4ymBOgKPxEy1f2urhw7
         XVYEhKUcmzrjkwLWljb4b+LVp/gXenzuHgD2qgKj5BIFcNr0TlMu1zoJ2MWzEz5PAoyj
         fmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790727720; x=1791332520;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zu1cWTlAGP+APTGfeDYTlNoaREve/1tEASbNefnhFMs=;
        b=pUT8NW47CbQrV6qKqpLjTV2c5I6h0gIa4ozddP/JEaXOjSsmQcyfisbHX6PPTFJoQK
         FfW8FDiXA7LE9u0j4GSsrGzRCaDonNwUZGomi8awe/Ed+AusOmvpIuFWeYMVOh+gwyTY
         CckkK2MdAooIkLeWJ2LeczqFCVE/00VCiEMlyPDK24mJZFabZ2DUuFBCGZXV9DPVr4Cb
         zYNW29eizt2RUY6bNbY+wej0Tt85Y7q+tJcDp6Zl1zKRJiKb2ZYH9oTmcZFPue0iFNjy
         auNEeabuga6/aI5kicmnYnqUCXLdEkM6z7mIVZzvZQ+IaFG8ozwAxkQdLdCJI3F/745p
         v36w==
X-Gm-Message-State: AFuF++l/OztBFt7cDw6MnSio8GXEOjcD6AzVJzMJ0/IOG2yWqkLZeWd6
	3VpSZ4MJOyUCdb8uCm7TZkCzCbenbJIx4zc7if1hQTD0DpqgEMBR0k2ANVNzgZlWVYM=
X-Gm-Gg: AYBFou217Cbm6W8g6ILpSkIis+vc5wzw3Yoapq1VZmetODGuI+wJMnwUNnnF7cADTP1
	X/z/g8eBcW1B/XfhvlskXgBo0zSwH3xIwdb5AgKEKyMY3PP/K/i80IqQiVN8LJS172HjsrKkx4r
	UCjs+cIslUJsbYXTo9HDXM/FiXzd9zUCZ52VQkTmeE5BscrSvJZFg4H53MH7IIicLMqI0N4dvKx
	sCf5B0vTevX2qolj3dV8Yz9QJ8ArRYlOnye9LCRFsjLU88lOyWmWhKqtnwuFDuLNjYn8ICPTmgI
	YSuPQecaGYQqEf0k2kaXZMISQMz2aK5Rk5Qe9iHDQ2sP8grmMevoiAahdVfGPokHlzlxfoXKFma
	TswKTbWfR3tNAj5xpIm3bBmKK7vR+LGniCab18cO7efPR7eTLlrT16rXPifWoXsvAUwO4yDF2E5
	LWjJHXDcXZyKtm9NF3rmx8ezh9FRqPjEokhZpueOIbX/MTV5Q3W3DJ/uGYpRdq0XMRAx1OHpqH/
	ZcsmO0lGHSsruobNM0rzLXn6cZV1l8ZlkdLGXBZecFC0WBWFEancB4+Ik67TY3sM1x5LlZAwri9
	HSKdBH7JZCyuGGtNfLauPsJPctUXV2D/O6HYz9Uaoj/IsbxPz5YfjwlcsDGkC4AY+Iu1v4dKWrJ
	8+umWxzXU7YRijz1HmUhn
X-Received: by 2002:a05:600c:8b21:b0:4a0:c01:1902 with SMTP id 5b1f17b1804b1-4a014fd4fcamr11098385e9.2.1790727720370;
        Tue, 29 Sep 2026 17:22:00 -0700 (PDT)
Received: from mac.lan ([2001:818:c665:a700:4e1:afcc:bdec:a44d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a015cde27asm5135615e9.3.2026.09.29.17.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 17:21:59 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
Date: Wed, 30 Sep 2026 01:21:50 +0100
Subject: [PATCH RFC 5/5] backfill: report total size of missing blobs in
 --dry-run
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-backfill-dryrun-v1-5-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, 
 Pablo Sabater <pabloosabaterr@gmail.com>
X-Mailer: b4 0.15.2

The number of missing blobs says little about how much data a backfill
will transfer.  In --dry-run mode, if the server has the object-info
capability enabled, fetch the size of the objects to be fetched and show
the total size, if the server doesn't have the capability enabled, fall
back to printing only the count.

The reported size is the sum of the uncompressed object sizes, so it
is an upper bound: once fetched, the blobs are stored compressed and
possibly deltified in a packfile, and usually take less space on disk.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 Documentation/git-backfill.adoc |  6 +++-
 builtin/backfill.c              | 70 ++++++++++++++++++++++++++++++++++++++---
 t/t5620-backfill.sh             | 22 +++++++++++++
 3 files changed, 92 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-backfill.adoc b/Documentation/git-backfill.adoc
index 08f19fea17..660e1c17c0 100644
--- a/Documentation/git-backfill.adoc
+++ b/Documentation/git-backfill.adoc
@@ -72,7 +72,11 @@ OPTIONS
 
 `--dry-run`::
 	Do not download any objects. Instead, print the number of
-	missing blobs that would be downloaded.
+	missing blobs that would be downloaded and, if the promisor
+	remote supports the `object-info` capability, their total
+	size. This is the sum of the uncompressed sizes of the blobs,
+	so the space used on disk after a real backfill is usually
+	smaller.
 
 `<revision-range>`::
 	Backfill only blobs reachable from commits in the specified
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 6019112966..caf1a64e95 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -24,6 +24,9 @@
 #include "progress.h"
 #include "packfile.h"
 #include "path-walk.h"
+#include "transport.h"
+#include "remote.h"
+#include "fetch-object-info.h"
 
 static const char * const builtin_backfill_usage[] = {
 	N_("git backfill [--min-batch-size=<n>] [--[no-]sparse] [--[no-]include-edges] [--dry-run] [<revision-range>]"),
@@ -37,7 +40,11 @@ struct backfill_context {
 	int sparse;
 	int include_edges;
 	int dry_run;
+	int object_info_enabled;
+	size_t total_batch_size;
 	size_t total_batch_nr;
+	struct transport *object_info_transport;
+	struct fetch_object_info_results object_info_results;
 	struct rev_info revs;
 };
 
@@ -62,10 +69,47 @@ static void download_batch(struct backfill_context *ctx)
 
 static void dry_run_batch(struct backfill_context *ctx)
 {
+	struct fetch_object_info_results *results = &ctx->object_info_results;
+	enum fetch_object_info_status status;
+
 	if (!ctx->current_batch.nr)
 		return;
 
 	ctx->total_batch_nr += ctx->current_batch.nr;
+
+	if (!ctx->object_info_enabled)
+		goto cleanup;
+
+	if (!ctx->object_info_transport) {
+		struct promisor_remote *promise =
+			repo_promisor_remote_find(ctx->repo, NULL);
+		struct remote *remote = NULL;
+
+		if (!promise || !(remote = remote_get(promise->name)))
+			die(_("--dry-run requires a promisor remote"));
+
+		ctx->object_info_transport = transport_get(remote, NULL);
+
+		if (!ctx->object_info_transport->smart_options)
+			die(_("failed to get object info: smart options required"));
+	}
+
+	results->wants_size = 1;
+	status = transport_fetch_object_info(ctx->object_info_transport,
+					     &ctx->current_batch,
+					     results);
+
+	if (status == FETCH_OBJECT_INFO_NOT_ENABLED ||
+	    !results->sizes) {
+		ctx->object_info_enabled = 0;
+		goto cleanup;
+	}
+
+	for (size_t i = 0; i < results->nr; i++)
+		ctx->total_batch_size += results->sizes[i];
+
+cleanup:
+	free_fetch_object_info_results(&ctx->object_info_results);
 	oid_array_clear(&ctx->current_batch);
 }
 
@@ -157,12 +201,25 @@ static int do_backfill(struct backfill_context *ctx)
 
 	dry_run_batch(ctx);
 
-	printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
-		  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
-		  (unsigned long)ctx->total_batch_nr),
-	       (uintmax_t)ctx->total_batch_nr);
+	if (ctx->object_info_enabled && ctx->total_batch_nr) {
+		struct strbuf size = STRBUF_INIT;
+
+		strbuf_humanise_bytes(&size, ctx->total_batch_size);
+		printf(Q_("After backfill, %" PRIuMAX " blob would be fetched (%s).\n",
+			  "After backfill, %" PRIuMAX " blobs would be fetched (%s).\n",
+			  (unsigned long)ctx->total_batch_nr),
+		       (uintmax_t)ctx->total_batch_nr, size.buf);
+		strbuf_release(&size);
+	} else {
+		printf(Q_("After backfill, %" PRIuMAX " blob would be fetched.\n",
+			  "After backfill, %" PRIuMAX " blobs would be fetched.\n",
+			  (unsigned long)ctx->total_batch_nr),
+		       (uintmax_t)ctx->total_batch_nr);
+	}
 
 end:
+	if (ctx->object_info_transport)
+		transport_disconnect(ctx->object_info_transport);
 	path_walk_info_clear(&info);
 	return ret;
 }
@@ -177,6 +234,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 		.sparse = -1,
 		.revs = REV_INFO_INIT,
 		.include_edges = 1,
+		.object_info_results = FETCH_OBJECT_INFO_RESULTS_INIT,
+		.object_info_enabled = 1,
 	};
 	struct option options[] = {
 		OPT_UNSIGNED(0, "min-batch-size", &ctx.min_batch_size,
@@ -185,7 +244,8 @@ int cmd_backfill(int argc, const char **argv, const char *prefix, struct reposit
 			 N_("Restrict the missing objects to the current sparse-checkout")),
 		OPT_BOOL(0, "include-edges", &ctx.include_edges,
 			 N_("Include blobs from boundary commits in the backfill")),
-		OPT__DRY_RUN(&ctx.dry_run, N_("Preview the number of blobs to be fetched")),
+		OPT__DRY_RUN(&ctx.dry_run, N_("Preview the number of blobs and their total "
+					      "size to be fetched")),
 		OPT_END(),
 	};
 	struct repo_config_values *cfg = repo_config_values(the_repository);
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index e76fa6081b..b21feb625c 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -167,6 +167,28 @@ test_expect_success '--dry-run with no missing blobs' '
 	test_grep "0 blobs would be fetched" out
 '
 
+test_expect_success '--dry-run reports total size with object-info' '
+	test_config -C srv.bare transfer.advertiseobjectinfo true &&
+	test_when_finished rm -rf backfill-dry-run &&
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-dry-run &&
+
+	git -C backfill-dry-run backfill --dry-run >out &&
+	test_grep "48 blobs would be fetched (.*)" out
+'
+
+test_expect_success '--dry-run reports only the count without object-info' '
+	test_config -C srv.bare transfer.advertiseobjectinfo false &&
+	test_when_finished rm -rf backfill-dry-run &&
+	git clone --no-checkout --filter=blob:none \
+		--single-branch --branch=main \
+		"file://$(pwd)/srv.bare" backfill-dry-run &&
+
+	git -C backfill-dry-run backfill --dry-run >out &&
+	test_grep "48 blobs would be fetched\.$" out
+'
+
 test_expect_success 'backfill --sparse without sparse-checkout fails' '
 	git init not-sparse &&
 	test_must_fail git -C not-sparse backfill --sparse 2>err &&

-- 
2.54.0

