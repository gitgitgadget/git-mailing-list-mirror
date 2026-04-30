Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8190413D8B1
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777508004; cv=none; b=lqDxvaytARSOyLhNvPhuYBkvJ4PGOSfs8exR9J4Rr9I++qVFBW6OE4kI6B7eso+gzbdUs1BgnkWOM3EdnI2A2BZ1Y+13Q/MLK1fWqMVwwa8L6Ml2kIoalNuUGfMsBMVRCqSJwb7GYWQG0V4xbn3/R4W3cdn33lyRXNwaoT24NTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777508004; c=relaxed/simple;
	bh=K9K44bnZvDAZMFwDOy9uZQ6U9yOfQo0WFbIiN3vgMds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WAqrVZAnWQ59Mt1r7RPSwc3SDYIizmYSvDFh60FkG4JEw1eN7niClwoyMSrpyGzRIs0lqsieSiw6NGVuuPtIQDCwnCS/dVq5EwFm7X3XnIJ5NT9t32QqZQiZlGfM9FS0yUM5qlOrgkYgUN7ZKJbkqzLBGkBod5aO2Dfb1xjN09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DktFOoTv; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DktFOoTv"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-64e87a81639so320300d50.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777508001; x=1778112801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dnptqpgrfdXYScu9/UA/SdKjJkcWK38Z707sdQFUb9Y=;
        b=DktFOoTvndvrt+kuoibpVplRfJpFq2evXhgq2yUhmJQtMc8tB68Oq8GK8am3hRArjF
         514ihp6Yx6lyUg9nDYVKq5vF4FG202ynsSzNbq9fvxIpO8X3I5TynMqDUk7lUjuxAwPU
         gkJLwJEkfYHbmPhZfXoIzra8o84XvxEnbdtlUwj1luIRing6jTNNgRTE48GqmKNFMTy4
         3P4gwpAgAPH+g4RHw7EJx6SFirIvBKxjzUbE+Aso3bNDI0ghP+cDyv06eMz3XSsaSMxc
         3tIOgwpJhMGw0fxBsMwlIGERlx3sUw6CBaNqBgUxR84LAZH/7UZpruJvm7Q05rnz/CzY
         XptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777508001; x=1778112801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnptqpgrfdXYScu9/UA/SdKjJkcWK38Z707sdQFUb9Y=;
        b=aRt0GtgNmLXvhPcnZ0EPE6dJwZNgulCF58NuadmHMGugFvNUXeICSxd3zoRclYnKmC
         IomWx/qOxpCu/pK4XZ6cYEAb0L+ZyQ8TXQvNsmJsXz3b+ulIxMrjBGaXj0GDRjYNPhlT
         4JgPkQQxbsElHRONYT+ua1M2Sy64aihpKgDcetkku8QVEFv8wAp2QmlgYXiaOeFDTt6X
         PrjmbwNIbSqmgAu5yPSZnFT6xqRC52s8VGTlPJgGQAWAsUGC98Kzi9dRk/bbLTDApOi+
         Y0FCUbIAErfViz77vtjtuJL/QXDCPj40CnA33vqdH56sgx+DITJuWdBEHINuqjYpnlV8
         NCug==
X-Gm-Message-State: AOJu0YxTDjSy9XViFeQe1HejdsGQyrBgQiv1Cc+KjKVCEf+xciAp6NGR
	0FT+rs9oCFiiCnJfRYz7GozqEOfvV9PVQal+0az1EPK6YmrdoAplNhSlMdzxE+oSczYZgQ8PNCr
	AJ1kEcNTp7HOd
X-Gm-Gg: AeBDiesw+RZs1l8UEYq+ctozeIb1XifhpNfxOCQ3R7HUuxx0bMaLxqD9kLOUEQ12B7h
	npBihujx4z8ZhcKQSGzdB/DSu2RBSKPjLM6+tcMCSbOLtGdqVaDK6udYmk4t1vR3myd8A4m8p3O
	lIcs0aR9xVvEMw6eAfE2mlfZLjEbH6dieDkDP9sl/uESRB0ZXKtzZ0eexjVgolUrHC4SjenKev1
	jGdNKWZCvfWxygZV2mWmQEdbV5z30kVCsPRfqnwPqs+yJevK1du2u1IygXFpJfX8dVt/NYwmbz6
	jeaZEDX6IRnp1NT9Z5pm53vvPBz6PZXLf7XsSDFPteuaTSiD2fBIV4Q6h5pyjrGw8CZLS6Ep+/6
	0CUiFkr674eluPr+AfdaAzsrWhXBUPd1y5XFLfVOnDAht6b0XDvUGiFOINQ/m8vPBdAfCCUDgay
	Hl6VP5jkepEWFV14kvZWJU4SDDZ9mQOMbfYhywi+NJWTpUP6lWJhVoRVEZ8Z2iTByj1Detpy1dR
	0iszyyN/7K7bM6ro0gdenS8w7AkN/uN/wyKK7qXoEqOpszYBKhO2e7pnQdDLKoYph/pE7Rj+zGm
	l+RP2Q2W2/CHcWxuFXGL+FXrL/Q=
X-Received: by 2002:a05:690e:d09:b0:652:738f:4461 with SMTP id 956f58d0204a3-65c18fcd14emr435033d50.58.1777508001293;
        Wed, 29 Apr 2026 17:13:21 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4c2a40sm1978695d50.2.2026.04.29.17.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:20 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 05/16] midx: introduce `--no-write-chain-file` for
 incremental MIDX writes
Message-ID: <2c80aa34fac76a7755d3cdcd0d9bdc659b5d3795.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

When writing an incremental MIDX layer, the MIDX machinery writes the
new layer into the multi-pack-index.d directory and then updates the
multi-pack-index-chain file to include the freshly written layer.

Future callers however may not wish to immediately update the MIDX chain
itself, preferring instead to write out new layer(s) themselves before
atomically updating the chain. Concretely, the new incremental
MIDX-based repacking strategy will want to do exactly this (that is,
assemble the new MIDX chain itself before writing a new chain file and
atomically linking it into place).

Introduce a `--no-write-chain-file` flag that:

 * writes the new MIDX layer into the multi-pack-index.d directory

 * prints its checksum

 * does not update the multi-pack-index-chain file.

The MIDX chain file (and thus, the lock protecting it) remain untouched,
allowing callers to assemble the chain themselves. This flag requires
`--incremental`, since the notion of a separate layer only makes sense
for incremental MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 17 ++++++++--
 builtin/multi-pack-index.c              | 28 +++++++++++++++--
 midx-write.c                            | 42 ++++++++++++++++---------
 midx.h                                  |  1 +
 t/t5334-incremental-multi-pack-index.sh | 17 ++++++++++
 t/t5335-compact-multi-pack-index.sh     | 36 +++++++++++++++++++++
 6 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 3a5aa227784..c26196815e2 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
-		         [--refs-snapshot=<path>]
+		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] <from> <to>
+		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +83,13 @@ marker).
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
 		necessary.
+
+	--[no-]write-chain-file::
+		When used with `--incremental`, write a new MIDX layer
+		but do not update the multi-pack-index-chain file.
+		The checksum of the new layer is printed to standard
+		output, allowing the caller to assemble and write the
+		chain itself. Requires `--incremental`.
 --
 
 compact::
@@ -97,6 +104,12 @@ compact::
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
+
+	--[no-]write-chain-file::
+		When used with `--incremental`, write a new compacted
+		MIDX layer but do not update the multi-pack-index-chain
+		file. The checksum of the new layer is printed to
+		standard output. Requires `--incremental`.
 --
 +
 Note that the compact command requires writing a version-2 midx that
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 0f72d96c02d..f861b4b8394 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,11 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>]")
+	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] <from> <to>")
+	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -153,6 +153,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
+			N_("write the multi-pack-index chain file"),
+			MIDX_WRITE_NO_CHAIN),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
@@ -178,6 +181,15 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--no-write-chain-file", "--incremental");
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -221,6 +233,9 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
+			N_("write the multi-pack-index chain file"),
+			MIDX_WRITE_NO_CHAIN),
 		OPT_END(),
 	};
 
@@ -239,6 +254,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	if (argc != 2)
 		usage_with_options(builtin_multi_pack_index_compact_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_NO_CHAIN &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--no-write-chain-file", "--incremental");
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
diff --git a/midx-write.c b/midx-write.c
index 5d9409a9741..38c898e5ff5 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1257,7 +1257,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	unsigned char midx_hash[GIT_MAX_RAWSZ];
 	uint32_t start_pack;
 	struct hashfile *f = NULL;
-	struct lock_file lk;
+	struct lock_file lk = LOCK_INIT;
 	struct tempfile *incr;
 	struct write_midx_context ctx = {
 		.preferred_pack_idx = NO_PREFERRED_PACK,
@@ -1601,11 +1601,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (ctx.incremental) {
-		struct strbuf lock_name = STRBUF_INIT;
+		if (!(opts->flags & MIDX_WRITE_NO_CHAIN)) {
+			struct strbuf lock_name = STRBUF_INIT;
 
-		get_midx_chain_filename(opts->source, &lock_name);
-		hold_lock_file_for_update(&lk, lock_name.buf, LOCK_DIE_ON_ERROR);
-		strbuf_release(&lock_name);
+			get_midx_chain_filename(opts->source, &lock_name);
+			hold_lock_file_for_update(&lk, lock_name.buf,
+						  LOCK_DIE_ON_ERROR);
+			strbuf_release(&lock_name);
+		}
 
 		incr = mks_tempfile_m(midx_name.buf, 0444);
 		if (!incr) {
@@ -1707,16 +1710,23 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
+	if (!is_lock_file_locked(&lk))
+		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
+	else if (opts->flags & MIDX_WRITE_NO_CHAIN)
+		BUG("lockfile held with MIDX_WRITE_NO_CHAIN set?");
+
 	if (ctx.incremental) {
-		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 		struct multi_pack_index **layers = NULL;
 		size_t layers_nr = 0, layers_alloc = 0;
 
-		if (!chainf) {
-			error_errno(_("unable to open multi-pack-index chain file"));
-			goto cleanup;
+		if (is_lock_file_locked(&lk)){
+			FILE *chainf = fdopen_lock_file(&lk, "w");
+			if (!chainf) {
+				error_errno(_("unable to open multi-pack-index chain file"));
+				goto cleanup;
+			}
 		}
 
 		if (link_midx_to_chain(ctx.base_midx) < 0)
@@ -1773,8 +1783,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 		free(layers);
 
-		for (size_t i = 0; i < keep_hashes.nr; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
+		if (is_lock_file_locked(&lk))
+			for (size_t i = 0; i < keep_hashes.nr; i++)
+				fprintf(get_lock_file_fp(&lk), "%s\n",
+					keep_hashes.v[i]);
 	} else {
 		strvec_push(&keep_hashes,
 			    hash_to_hex_algop(midx_hash, r->hash_algo));
@@ -1783,10 +1795,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.m || ctx.base_midx)
 		odb_close(ctx.repo->objects);
 
-	if (commit_lock_file(&lk) < 0)
-		die_errno(_("could not write multi-pack-index"));
+	if (is_lock_file_locked(&lk)) {
+		if (commit_lock_file(&lk) < 0)
+			die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+		clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+	}
 	result = 0;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 08f3728e520..5b193882dcf 100644
--- a/midx.h
+++ b/midx.h
@@ -83,6 +83,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
 #define MIDX_WRITE_COMPACT (1 << 6)
+#define MIDX_WRITE_NO_CHAIN (1 << 7)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index c9f5b4e87aa..66d6894761b 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -96,6 +96,23 @@ test_expect_success 'show object from second pack' '
 	git cat-file -p 2.2
 '
 
+test_expect_success 'write MIDX layer with --no-write-chain-file' '
+	test_commit no-write-chain-file &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file' '
+	test_must_fail git multi-pack-index write --bitmap --no-write-chain-file 2>err &&
+	test_grep "cannot use --no-write-chain-file without --incremental" err
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282f..1a65d48b62b 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -290,4 +290,40 @@ test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --no-write-chain-file' '
+	git init midx-compact-with--no-write-chain-file &&
+	(
+		cd midx-compact-with--no-write-chain-file &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		layer="$(git multi-pack-index compact --incremental \
+			--no-write-chain-file \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")")" &&
+
+		test_cmp "$midx_chain.bak" "$midx_chain" &&
+
+		# After writing the new layer, insert it into the chain
+		# manually. This is done in order to make $layer visible
+		# to the read-midx test helper below, and matches what
+		# the MIDX command would do without --no-write-chain-file.
+		{
+			nth_line 1 "$midx_chain.bak" &&
+			echo $layer &&
+			nth_line 4 "$midx_chain.bak"
+		} >$midx_chain &&
+
+		test-tool read-midx $objdir $layer >midx.data &&
+		grep "^pack-B-.*\.idx" midx.data &&
+		grep "^pack-C-.*\.idx" midx.data
+
+	)
+'
+
 test_done
-- 
2.54.0.16.g1c05dfce579

