Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880473444
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 22:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717712370; cv=none; b=MGtarzYDZPZiDw5YBH0bW1+MHbcG8STjh7Uvu7ZK27aqIZ05okI0rfgtRALmHA33scNYYQlkoB3tjRlrMcGmhw6WF+tPPqPctd6zF/czUQaXBkwa6H+uxjHDVSFYHPPr/FvngkDXxuzF2PcnW87KNjKIcACqC0Xz6HJk8LGBg+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717712370; c=relaxed/simple;
	bh=JOAkrmUgXhuNd+/svUtRn0M3GA/394hWuIltutc4Fio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM9TMVnZIVZtfWiipPipSxtjvpHGluX4ryO7x7pyNvpnFhG9GgcGa3C6piaDVj2hsisCu/QQ5bpQuM7EHy++3S6oPj1jiR2DvTxx+Np3hhvhNQNFE3pGn8r2+BdtgtklxV3ZX63anevEkD9sbgUjTP9nmK1HuQ4fDslXLazz3Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=PLat2oNd; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PLat2oNd"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d2062325fbso917117b6e.0
        for <git@vger.kernel.org>; Thu, 06 Jun 2024 15:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1717712367; x=1718317167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wtre4JRs2W0SS0GSCyMPvBQPAD+pzKsUaqxsmxaVFlk=;
        b=PLat2oNdtcSJSxx56UA27Uf4LaVTPQTjH5XUn3KF5CrcRRaj1KoaHUDSNutTwITY6F
         nJ73kWxPEjwGRYHjDKE7TtrZQAtq8tO5Gie2dEfhFBrS9ZHDvLledfu8rfEaYipC2P1O
         Jd1QS8jv3jsnqaahIEW5m8xfGAu0Q8e/JQbXhoPzkuBk3b6hno7jlEFrGHTLXSi+GWMn
         RysE2khllp3kHN9qoUfbMvwj9Y5s/jTZr7QDRvXeKCCU9kqpbfGaaD0iR0Q41Fd1V3ff
         BGWxw3egDeJKe/XZzukZiz0txznykMwC4gptOASJxQkRQA4bvAnj5DIW1MV6HY8N9ARX
         jmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717712367; x=1718317167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wtre4JRs2W0SS0GSCyMPvBQPAD+pzKsUaqxsmxaVFlk=;
        b=ac8G3H5uIKzAwhLGP6rpQplAxUHdMk4u0A0tb0s35Eins5KwlFaiPWRBWaRyl97bHy
         uz0P9v6cpkd5aYPGpZY8qdES7zHRbCuVGDLmGZLB3q1lhaz19QT7wAVCv0ksFsnorBqV
         MYsQhe03CF94Qnltx5cYJ+cteuTUwmqlvN2J4O/rMer+Sau0eUXn9a/zjNdLhEIIeHc+
         WA6z54BR2RTIEmOCODpqkpmQT8JdoNM4hNVkLKyzENJ+aUcgrm3ntjOIQUzQ3A4qx//x
         gmR6LJTpL+NcWGBd/hpSuJZzhmjyPF584tBlhu3A0xmuvsnJLQnNax75Y/nx6G89k78t
         OV9A==
X-Gm-Message-State: AOJu0YwfzJB03PubE0Hgqs2BDixbYcHlQn5wk45b3RWzeQhyYBzcoR8E
	I7kxglVJBxjRr26uHllXV7wVg/ZxrGn0242jYB156V2BlyUIezF7VGfv8T9aaZEEh+56zicCU5u
	G/fc=
X-Google-Smtp-Source: AGHT+IGZmwi7UK/MNI9xOlhBNz/PAI2oeVUAF+rMmxCQRdfUjvoRfriLIPmHv62DyEOgSETVtFv75g==
X-Received: by 2002:a05:6808:249:b0:3d1:fdf5:a88e with SMTP id 5614622812f47-3d210d71220mr729825b6e.21.1717712367504;
        Thu, 06 Jun 2024 15:19:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b04fa39b1esm10112826d6.143.2024.06.06.15.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 15:19:27 -0700 (PDT)
Date: Thu, 6 Jun 2024 18:19:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] commit-graph.c: remove temporary graph layers on exit
Message-ID: <25324fea5b7c7f748d7f4e1e40299c0af04006e8.1717712358.git.me@ttaylorr.com>
References: <cover.1717712358.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1717712358.git.me@ttaylorr.com>

Since the introduction of split commit graph layers in 92b1ea66b9a
(Merge branch 'ds/commit-graph-incremental', 2019-07-19), the function
write_commit_graph_file() has done the following when writing an
incremental commit-graph layer:

  - used a lock_file to control access to the commit-graph-chain file

  - used an auxiliary file (whose descriptor was stored in 'fd') to
    write the new commit-graph layer itself

Using a lock_file to control access to the commit-graph-chain is
sensible, since only one writer may modify it at a time. Likewise, when
the commit-graph machinery is writing out a single layer, the lock_file
structure is used to modify the commit-graph itself. This is also
sensible, since the non-incremental commit-graph may also have at most
one writer.

However, using an auxiliary temporary file without using the tempfile.h
API means that writes that fail after the temporary graph layer has been
created will leave around a file in

    $GIT_DIR/objects/info/commit-graphs/tmp_graph_XXXXXX

The commit-graph-chain file and non-incremental commit-graph do not
suffer from this problem as the lockfile.h API uses the tempfile.h API
transparently, so processes that died before moving those finals into
their final location cleaned up after themselves.

Ensure that the temporary file used to write incremental commit-graphs
is also managed with the tempfile.h API, to ensure that we do not ever
leave tmp_graph_XXXXXX files laying around.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c                | 19 ++++++++-----------
 t/t5324-split-commit-graph.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index e5dd3553dfe..92c71637142 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2002,8 +2002,8 @@ static int write_graph_chunk_base(struct hashfile *f,
 static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 {
 	uint32_t i;
-	int fd;
 	struct hashfile *f;
+	struct tempfile *graph_layer; /* when ctx->split is non-zero */
 	struct lock_file lk = LOCK_INIT;
 	const unsigned hashsz = the_hash_algo->rawsz;
 	struct strbuf progress_title = STRBUF_INIT;
@@ -2035,24 +2035,23 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 					       LOCK_DIE_ON_ERROR, 0444);
 		free(lock_name);
 
-		fd = git_mkstemp_mode(ctx->graph_name, 0444);
-		if (fd < 0) {
+		graph_layer = mks_tempfile_m(ctx->graph_name, 0444);
+		if (!graph_layer) {
 			error(_("unable to create temporary graph layer"));
 			return -1;
 		}
 
-		if (adjust_shared_perm(ctx->graph_name)) {
+		if (adjust_shared_perm(get_tempfile_path(graph_layer))) {
 			error(_("unable to adjust shared permissions for '%s'"),
-			      ctx->graph_name);
+			      get_tempfile_path(graph_layer));
 			return -1;
 		}
 
-		f = hashfd(fd, ctx->graph_name);
+		f = hashfd(get_tempfile_fd(graph_layer), get_tempfile_path(graph_layer));
 	} else {
 		hold_lock_file_for_update_mode(&lk, ctx->graph_name,
 					       LOCK_DIE_ON_ERROR, 0444);
-		fd = get_lock_file_fd(&lk);
-		f = hashfd(fd, get_lock_file_path(&lk));
+		f = hashfd(get_lock_file_fd(&lk), get_lock_file_path(&lk));
 	}
 
 	cf = init_chunkfile(f);
@@ -2133,8 +2132,6 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		char *final_graph_name;
 		int result;
 
-		close(fd);
-
 		if (!chainf) {
 			error(_("unable to open commit-graph chain file"));
 			return -1;
@@ -2169,7 +2166,7 @@ static int write_commit_graph_file(struct write_commit_graph_context *ctx)
 		free(ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1]);
 		ctx->commit_graph_filenames_after[ctx->num_commit_graphs_after - 1] = final_graph_name;
 
-		result = rename(ctx->graph_name, final_graph_name);
+		result = rename_tempfile(&graph_layer, final_graph_name);
 
 		for (i = 0; i < ctx->num_commit_graphs_after; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", ctx->commit_graph_hash_after[i]);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 281266f7883..77e91547ea3 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -13,7 +13,8 @@ test_expect_success 'setup repo' '
 	git init &&
 	git config core.commitGraph true &&
 	git config gc.writeCommitGraph false &&
-	infodir=".git/objects/info" &&
+	objdir=".git/objects" &&
+	infodir="$objdir/info" &&
 	graphdir="$infodir/commit-graphs" &&
 	test_oid_cache <<-EOM
 	shallow sha1:2132
@@ -718,4 +719,27 @@ test_expect_success 'write generation data chunk when commit-graph chain is repl
 	)
 '
 
+test_expect_success 'temporary graph layer is discarded upon failure' '
+	git init layer-discard &&
+	(
+		cd layer-discard &&
+
+		test_commit A &&
+		test_commit B &&
+
+		# Intentionally remove commit "A" from the object store
+		# so that the commit-graph machinery fails to parse the
+		# parents of "B".
+		#
+		# This takes place after the commit-graph machinery has
+		# initialized a new temporary file to store the contents
+		# of the new graph layer, so will allow us to ensure
+		# that the temporary file is discarded upon failure.
+		rm $objdir/$(test_oid_to_path $(git rev-parse HEAD^)) &&
+
+		test_must_fail git commit-graph write --reachable --split &&
+		test_dir_is_empty $graphdir
+	)
+'
+
 test_done
-- 
2.45.2.411.g2d5a0536af1

