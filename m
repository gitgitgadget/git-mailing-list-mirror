Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660BA3EA959
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206276; cv=none; b=BsTq5vEP4ppQmn9rkMkRyzhRnlUjKcSu0EX0WQ4jagrWAZNfUrHxMsezb5N5JzlBvY4Qe04q3hacxsadYRZpR+B+UF2HovrTEyyR6hdBgpizUta06cBuTfR8OzeO2OJCSu/s2i6tj7H34c7IfKCglRXN1qvnDio1j6dsr96C6/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206276; c=relaxed/simple;
	bh=4l5V+OxMxX49EVU9n/KkErtzsafP6899pwwAve+hUBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1z9xE6EBdzTKikONlViWVyE+i0kYqAjl/zfer2VF8gyb35+LcnympH0JCbGsnsUv2mEdV/gXN61FkOfBRt8bEO6bDvIKWLVwPVKQ6XavKmzUwTfVAUkd8+6swaOruIw+ErRvuvy9V+0z6N+xSrbkxqDwns367uCRe3KuLFATYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=fuB+fvOB; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="fuB+fvOB"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-65c2cd216c9so3219259d50.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206273; x=1779811073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KOnD2Hd2d/e/cSc7zoVvj7wNTCfjTbVqVSIwwAfardU=;
        b=fuB+fvOBviBlWqwMCUjaoWtS6FzQZzaae0dciB6arSmL6Vt3X4v9o/Jvf8e7P2q5Jm
         DyLzIo3tCN+TRtBDwyZJ4G5VFL6fu3pHJwn3+j+g2Nw2Cf5bNhNyxou4vnzF3Z4OxOx4
         puPSXCuK6wN8ZV0T4duDAN4lUDWNK6w132sk1o+zT4nkD5bYh8d2jyY1+uTqqJHoy3Nn
         JoEtwe9bn97SuFVA8V+DMeVGaDsIP21eCzu929MEXt7W83fH+pN3+2U609HUZz8rJ8OY
         X3AsLYYSKTn8U7QyfVRiStNJUl+ahcwrtUGO9iPUvwn2coqa4vUGf2C5Ojwsd/ophcSq
         B4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206273; x=1779811073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOnD2Hd2d/e/cSc7zoVvj7wNTCfjTbVqVSIwwAfardU=;
        b=orzxa++3FmiB1ipPe5/o+UosaZg+LBunMbkNPxCGf+43lhmqaKiwj9EELtGX0PsOer
         EFhndOToGomnqjzAg+U/cavW/iqQai0n5nz7Pf2NQKzXVjz16bMqo0nFVyBW6LHeVVOs
         /jWP6MKI+LhsRPboMqzcm7GBznBG7XlmxX1x9jkDm7og2zGkg6OF2RazyKpSJOA5o8hv
         njZgTMOxdE+NPrQAV9hSzpB5V9MT8D6Y51vqdln9ciVZm/072Zm/KLT09busWDnrhCQh
         9IddQVmczOQhTFm8AHlVW8Cr8sJIcWZJyBByvu08uXeeQysymfzxyqCsc1hodsBXmtQk
         gmUg==
X-Gm-Message-State: AOJu0YyFIDlE0tL142hvh34rYkqLmvWKHpxbxGGog29BIgMgdNu7aBRo
	KkyklYPcWKQQqSYivD0cNPu1sMmSo3oxGqeFRArkug2LpFardxwX+q0xaBjtgEcjkH2N1kYZztO
	A2oyhmw6uN1T/
X-Gm-Gg: Acq92OEuDQWoMLqy3tIMzUbeh4DPMbNXbg04qhNAaeXi1AHE1v1kGG0378faJnqSbyk
	M8YwbZIMwJ0YMdqIO6U9/c9STdkbnxbbbupbiBquvGiC/SJbhXA7XNXdvPajYa2dQNf6nWGOFIK
	elbj/uhg49DuEYymToo0fNxd7ZaJYf92b8IwoNn5/neLs8ewIpTLECGP0JUftCIVanlGT6wsQkP
	hbMepQsVFaXwd3V1rSxJ/jKfSCUiEeid5gNlGivI/ckwMCLCocfhhVrULIUt8/tQ1N05qkw4fFS
	iDNYgSsQ02fQ/6x+z/gqVGBVaypUwUSWRvZqjhiS4EDCXUAc7CYGMFblBTH3KRCMqLg33B0iek+
	/o0FaxfntCPDiHNbfVwUXkCH3/a82yA3BUcRXe6xerOrhbJR19cX0zDMnH5E8oVIE+4h/p244x2
	gRFF1wyB5AtFhz/0/FOnvkey+/n8/p1LuKe6zlrF/P6AZVhPbDug2qKZlR5nhR0XblPv3QiIo6H
	uNZluGy4GItO4MPLDA5rEZU8GW2e5aTCmVWBVNXRUA5uau2webfxd8GwBPkOMtRjD+eL0h9+MJx
	rwpcY60LcQ3IeG8+
X-Received: by 2002:a05:690e:4082:b0:65e:412e:681b with SMTP id 956f58d0204a3-65e412e68a9mr13264291d50.55.1779206272942;
        Tue, 19 May 2026 08:57:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e85bf1c57sm513975d50.12.2026.05.19.08.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:57:52 -0700 (PDT)
Date: Tue, 19 May 2026 11:57:51 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 05/16] midx: introduce `--no-write-chain-file` for
 incremental MIDX writes
Message-ID: <cac3fd54bf0c5fe23ca40eb9e13f850ae0a1996f.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

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
2.54.0.175.g8bd0ec98dc3

