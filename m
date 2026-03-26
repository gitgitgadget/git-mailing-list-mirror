Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E2D31F9B1
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538105; cv=none; b=DB8r61JhT2k2HU5gGM9kzoRnWaClswgblK6l++1fVx0UBDj9tbOcBxUeYDY12UzEi0N765N2myO9evVNNUidzWleeJpoRhtnJQMCE61plcpySFBlF/KihHrGKfKjbOmwPnwjh1Fa1x6rVhzhxyUba0rEeL/01mjUueIgS0FWdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538105; c=relaxed/simple;
	bh=od4mC3QrLQXlAuu+apkMM0NiDG16Ee+/tzEXXXEAsQY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZHJ7IVos4MmXHbW3I/ayaAZVbKWG4UylGV0/wEThoJ7oMahtIVAZRwPX6YMsoM3MA0rErMDVlBOCVxIERuRIFHLX2IbTmlvLcfIE2GQvFT8UQL//culEF/2EqD8brTDTj+e3Nf2ZNzjXHzu7OzUjE5yyTjhEIu0FmqoJhWG95mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9AD+8IB; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9AD+8IB"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cfc5941028so198917285a.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538102; x=1775142902; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BIVAmiHRyDQxNulONZ4yvpNLCj2zrJvjmbmGZyBZrs=;
        b=Z9AD+8IB8uTxjheh3eAfNyjw94n/J6PwUp6UgsriBlxAEYExfsqDmZi0yRV1gaLj2t
         o1TX6yX/ojHB0Aya3EYITznoU7N/XZoEz7vrfOqUv5+thMfsC6Gx79Y3/A+KnCGzoEFH
         fDs9KFVCF9+lt27lG4/xhg8/GN5A8h2UHwTKpBMT3HMBo9cghSXUgR1HniJiRWJp208K
         3TZzqd/A5O4whft/Rl6hJOZlfUqTECx5iwgxkzdtGNfssPVfWgFTsB9Bs/3Qc3J/nvVH
         CZlxHSHAHQd/w9PnuxgNmWiIukZgcnmMeVIUNpdgOTX5xaxMbzB+uFvrxA+1rCzd3rMb
         HsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538102; x=1775142902;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5BIVAmiHRyDQxNulONZ4yvpNLCj2zrJvjmbmGZyBZrs=;
        b=iPIjlQd8vgA6tHgvDH0APb7mV7QF7hMT40QppG6zhaH6DdiMJCnM9pAzi1fQR2z12l
         EdfXKnJAiftTWdFo8QVUAtauuU5/EnWx8xaWFNe4R+xVr9uw+vf/xrN/8C9mjiNqy6n+
         hIpNlqtu7ltmrskVafkPP0DCyOoTORlgMIG1rxI7mt4o4b2AdTWhzyd5meAF7+Y/yMIC
         dkubV/QK0lhFESEwvX0xTgCKgAy7uvoZ7n5NIJT+zXWwQhtUHRMr9k7/4mrLpEEjK8EF
         MMkbrM1XEAf4ndFFPUkbrqv1+9WNywGnQ5gTPmhXjbkNOgba1HOwpXMdpbUmxB0ysrTN
         rc2g==
X-Gm-Message-State: AOJu0YzftGI0KX6hp1gA42B216EqqtxQaHJ6M+wVgbuAIzjDhz2GPOts
	0j/N5+vcmuYxQk9j+/yP3qn1kufWuDvnkhi55cJSWChYMsEfRefTNoVf4w1jRg==
X-Gm-Gg: ATEYQzy7+nl8w0lK7fvETwnKyE2xfKxDtWj4ZA/Sp7tC6zfzhR5S2CqX/A1QbpX6m+7
	AwyBHOqpmxI5INJCPfrEbzWJuHqexn0oiPgNDuY/MdywKvYHgnNA23I4D/g/rkRxJFTpR1pJW55
	5R1oZmdgqY1uNIc5ZXdK888+I6GpYWKKypcIpD89HAtKOW0armUBGYEtqq0i0KDATpBmUomWslb
	MqFW+Reot13HNjBtN5dyaxMXkKdJ4P4Mt6z//T9Hp4B7Gn7Mic2n8EWq2qovrX3ewX7SZGJ0fqp
	/eblHt3eawj1moXASsAEUbkCwxAjNebE5vi1vem+OEAXzadEpmiWZ/m1YSetqA4zdLmQ7WSpniw
	AJt8qdSn+XjcYIZegSxkyUA5uQDqvDqecYgzuOvcrUPTDcxNh/XYyB/Fumu1QzO0pVzcB+gIE4Z
	HPRMXtJ5eLzgHdLavblsZJ3Omd9A==
X-Received: by 2002:ac8:5e06:0:b0:509:2d50:9788 with SMTP id d75a77b69052e-50b80d6f81amr112341971cf.32.1774538101999;
        Thu, 26 Mar 2026 08:15:01 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50b9234e3c0sm27507571cf.15.2026.03.26.08.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:15:01 -0700 (PDT)
Message-Id: <1ea278bd10bdd0b7980750c9d0c450b044aec196.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:53 +0000
Subject: [PATCH v3 5/6] path-walk: support wildcard pathspecs for blob
 filtering
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

Previously, walk_objects_by_path() silently ignored pathspecs containing
wildcards or magic by clearing them. This caused all blobs to be
downloaded regardless of the given pathspec. Wildcard pathspecs like
"d/file.*.txt" are useful for narrowing which blobs to process (e.g.,
during 'git backfill').

Support wildcard pathspecs by making two changes:

 1. Add an 'exact_pathspecs' flag to path_walk_context. When the
    pathspec has no wildcards or magic, set this flag and use the
    existing fast-path prefix matching in add_tree_entries(). When
    wildcards are present, skip that block since prefix matching
    cannot handle glob patterns.

 2. Add a match_pathspec() check in walk_path() to filter out blobs
    whose full path does not match the pathspec. This provides the
    actual blob-level filtering for wildcard pathspecs.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c         | 22 +++++++++++++---------
 t/t5620-backfill.sh |  7 +++----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 3750552978..2aa3e7d8a4 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -63,6 +63,8 @@ struct path_walk_context {
 	 */
 	struct prio_queue path_stack;
 	struct strset path_stack_pushed;
+
+	unsigned exact_pathspecs:1;
 };
 
 static int compare_by_type(const void *one, const void *two, void *cb_data)
@@ -207,7 +209,7 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
-		if (ctx->revs->prune_data.nr) {
+		if (ctx->revs->prune_data.nr && ctx->exact_pathspecs) {
 			struct pathspec *pd = &ctx->revs->prune_data;
 			bool found = false;
 			int did_strip_suffix = strbuf_strip_suffix(&path, "/");
@@ -302,6 +304,13 @@ static int walk_path(struct path_walk_context *ctx,
 			return 0;
 	}
 
+	if (list->type == OBJ_BLOB &&
+	    ctx->revs->prune_data.nr &&
+	    !match_pathspec(ctx->repo->index, &ctx->revs->prune_data,
+			   path, strlen(path), 0,
+			   NULL, 0))
+		return 0;
+
 	/* Evaluate function pointer on this data, if requested. */
 	if ((list->type == OBJ_TREE && ctx->info->trees) ||
 	    (list->type == OBJ_BLOB && ctx->info->blobs) ||
@@ -510,14 +519,9 @@ int walk_objects_by_path(struct path_walk_info *info)
 		info->revs->tag_objects = 1;
 
 	if (ctx.revs->prune_data.nr) {
-		/*
-		 * Only exact prefix pathspecs are currently supported.
-		 * Clear any wildcard or magic pathspecs to avoid
-		 * incorrect prefix matching.
-		 */
-		if (ctx.revs->prune_data.has_wildcard ||
-		    ctx.revs->prune_data.magic)
-			clear_pathspec(&ctx.revs->prune_data);
+		if (!ctx.revs->prune_data.has_wildcard &&
+		    !ctx.revs->prune_data.magic)
+			ctx.exact_pathspecs = 1;
 	}
 
 	/* Insert a single list for the root tree into the paths. */
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index 52f6484ca1..c6f54ee91c 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -307,12 +307,11 @@ test_expect_success 'backfill with wildcard pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The wildcard pathspec should limit downloaded blobs,
-	# but currently all blobs are downloaded.
-	git -C backfill-path backfill HEAD -- "d/file.*.txt" &&
+	git -C backfill-path backfill HEAD -- "d/file.*.txt" 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 40 missing
 '
 
 test_expect_success 'backfill with --all' '
-- 
gitgitgadget

