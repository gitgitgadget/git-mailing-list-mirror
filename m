Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80912745C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978875; cv=none; b=K2UMZhBiPi67A74XhmQ1jBOGbD9lMK2LJ2843qy41WIUX5janHjJr9ZHcdD2ZCNbZs3GNbXXIMFdSm3nTuLupg/Cr9laBHsG6uYSa26CojcjfbumLItS+XTZEQWtgn1Xy6me6b8zMpJZ32pKZUC4fvxxRWxoYoLFSbwbi7bSi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978875; c=relaxed/simple;
	bh=ylswdcGLnkBxpqBcR3D3yRf+0x3KuADALJEo1U9A4Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CjgX1Wsq7+UBfqd1D5vqsVX6WJO8P+uTeKKPm/MAM3XgznKBP/ECGBQHvNe4pjw8Qa1TGrAuXVnlPEW+kdnQ4UA3Ipe/jUvZWDZ5W/ql4n1tkl3RHZtF121lGe2cJ9Q47tiShdqQxydfMKFAIED8Y5JHzgQKVCZQ8oMSLOJwFMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=AoAdm9y/; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="AoAdm9y/"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-899b676b5d2so3918826d6.1
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978873; x=1772583673; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3xbqxHta8NuiEoLJ1Bq47eIGFO5aMrKMVwWujAoM7Xc=;
        b=AoAdm9y/kG9OpV1rNh3TMbSpbbXI8hG4u77gs6zH7GVRpb+lKy8cO9jm4cYo0XKy8o
         CXs59TQ2t6i6ehMojnQvtkfYdDmtw1LKxlNGHDS9Y+r+sdSMS4Kd2e3BbYNpI65TX20l
         UwQUyQRJVVPiUa2IQ9WACEGpj7yUcyPeTHiqnV5EUhXODyc4rBhEqxfIFy8/DavwiomS
         2aoa1WJOR6dgJH1qtjh6BFX4SPYsFd49M76Z/AfWF3Qh8Dl+tTxfpc98mjTG+EgiP+Sv
         ZPacxtz/RIhqCFUSZ3RQH8tQzgVawHa3cenm0DxZJm12fm//Uc5aX3jX1ZA7Lub4c3NO
         +MFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978873; x=1772583673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xbqxHta8NuiEoLJ1Bq47eIGFO5aMrKMVwWujAoM7Xc=;
        b=U3ICaEpUZR6KdNsijBwuQpAp7x7tApVfzdfCyW4yQ1ThnoBVfGkOSl118YmaRKyb77
         RSmOeaYfmnFmmhR4SDEzNmqquqFM02iUBtEGyDpuptgEGIGqx8Y0Be9V5uD1l0qE90vP
         bFZ48AUJsIoFFsppc9Zvn2AMqFyQXPWhtnpptF2mVwuNPcSTqh5cU/cbCRCub2OdS4w+
         0e6gdkWTMxUbFNrFsnO32r9sIodFohJPU3KLj8m3Zb2Z6aU685psYICMthZAigEHNUbJ
         eWhgGq5nBeqmSoAa3QNsUam6edRsOPqt2daHt/MnnC9z0EfNcoMO6ogz0g7dubukTTuf
         MCng==
X-Gm-Message-State: AOJu0Yyj9bnsTiJ0E/IdzRWL1DgaZG4NU7GHv8KUH2E/V23OSSm0B2xO
	FF3z0h8KHeByfGBtkBPIliEFp8dv9plrJ2KJjwScPJdcPW/16gYoK/9MO5Y77X/SxNnRwG+XtWA
	JKiqDoeUaGw==
X-Gm-Gg: ATEYQzwcR35i21A81zlJmFlz1I6+mu/1/gVFh7ygMDhYTXwFiuP2khGJO6wmiCY+7Tp
	r2gQvlRsfeioOLRtmtUu1KWe3MezV8SRPvmADl0JamHTYVD/5Yh2rVHTPYt4AnSiPA9wCV/ML+x
	mZq/1PeN+NCY1DKtdHrYTSVGlyQYI5xVpjv8/Y91tLTmZYXNVnLmuUxNPxuyqJYFcupNNQEqlOa
	zLBbwZU1flTyCKu9cnBBSVDo2pwbMim2iIXcRfRrI/tfYluQluniv611+h5xwuck7C80IgRoWvl
	eWjNMWPqx/YY3Z+p0+BnhD+XDD0a9YCUlLzPoSQfUbQh95AVr1M4Rmd2ZnKnqZJSKCpzRoYmJJg
	1K1/oVa0HgBBaeweMFhWLWPJ2wYC2p5x5is4wfYhkUu3pepv40PZN7MZGas4VzHflHN914HJG3y
	2s8seH3wCjUnDv4znH0lxkIbJRdS/VvMlqWXOrdOiDrXMKiLAjR8YwGEYxaHU/HUAhsZ27+XmP3
	tcRNPrPxaDGj7DVYQ+jjkLVz1+QBA==
X-Received: by 2002:a05:620a:448b:b0:8b9:dc23:89b9 with SMTP id af79cd13be357-8cbb58aea38mr72512085a.58.1771978872662;
        Tue, 24 Feb 2026 16:21:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d0eba54sm1241822085a.30.2026.02.24.16.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:12 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:10 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 04/14] midx: introduce `--checksum-only` for incremental
 MIDX writes
Message-ID: <2d31ea3907ff1965302acb089a594746c8dfb149.1771978829.git.me@ttaylorr.com>
References: <cover.1771978829.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1771978829.git.me@ttaylorr.com>

When writing an incremental MIDX layer, the MIDX machinery writes the
new layer into the multi-pack-index.d directory and then updates the
multi-pack-index-chain file to include the freshly written layer.

Future callers however may not wish to immediately update the MIDX chain
itself, preferring instead to write out new layer(s) itself before
atomically updating the chain. Concretely, the new incremental
MIDX-based repacking strategy will want to do exactly this (that is,
assemble the new MIDX chain itself before writing a new chain file and
atomically linking it into place).

Introduce a `--checksum-only` flag that:

 * writes the new MIDX layer into the multi-pack-index.d directory

 * prints its checksum

 * does not update the multi-pack-index-chain file.

The MIDX chain file (and thus, the lock protecting it) remain untouched,
allowing callers to assemble the chain themselves. This flag requires
`--incremental`, since the notion of a separate layer only makes sense
for incremental MIDXs.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  4 +--
 builtin/multi-pack-index.c              | 28 ++++++++++++++++--
 midx-write.c                            | 38 ++++++++++++++++---------
 midx.h                                  |  1 +
 t/t5334-incremental-multi-pack-index.sh | 17 +++++++++++
 t/t5335-compact-multi-pack-index.sh     | 34 ++++++++++++++++++++++
 6 files changed, 105 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 61256830141..657e0639f6a 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -11,9 +11,9 @@ SYNOPSIS
 [verse]
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
-		         [--refs-snapshot=<path>]
+		         [--refs-snapshot=<path>] [--[no-]checksum-only]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] <from> <to>
+		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2f24c113c8f..ee1ddf1386f 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -15,11 +15,11 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>]")
+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] <from> <to>")
+	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -152,6 +152,9 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_BIT(0, "checksum-only", &opts.flags,
+			N_("write a MIDX layer without updating the MIDX chain"),
+			MIDX_WRITE_CHECKSUM_ONLY),
 		OPT_BOOL(0, "stdin-packs", &opts.stdin_packs,
 			 N_("write multi-pack index containing only given indexes")),
 		OPT_FILENAME(0, "refs-snapshot", &opts.refs_snapshot,
@@ -177,6 +180,15 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	if (argc)
 		usage_with_options(builtin_multi_pack_index_write_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--checksum-only", "--incremental");
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -220,6 +232,9 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_BIT(0, "checksum-only", &opts.flags,
+			N_("write a MIDX layer without updating the MIDX chain"),
+			MIDX_WRITE_CHECKSUM_ONLY),
 		OPT_END(),
 	};
 
@@ -238,6 +253,15 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 	if (argc != 2)
 		usage_with_options(builtin_multi_pack_index_compact_usage,
 				   options);
+
+	if (opts.flags & MIDX_WRITE_CHECKSUM_ONLY &&
+	    !(opts.flags & MIDX_WRITE_INCREMENTAL)) {
+		error(_("cannot use %s without %s"),
+		      "--checksum-only", "--incremental");
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(the_repository);
 
 	FREE_AND_NULL(options);
diff --git a/midx-write.c b/midx-write.c
index 7fdc4d31243..9cf085ca333 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1598,11 +1598,14 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 
 	if (ctx.incremental) {
-		struct strbuf lock_name = STRBUF_INIT;
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
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
@@ -1723,14 +1726,19 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	}
 	strvec_init_alloc(&keep_hashes, keep_hashes_nr);
 
+	if (opts->flags & MIDX_WRITE_CHECKSUM_ONLY)
+		printf("%s\n", hash_to_hex_algop(midx_hash, r->hash_algo));
+
 	if (ctx.incremental) {
-		FILE *chainf = fdopen_lock_file(&lk, "w");
 		struct strbuf final_midx_name = STRBUF_INIT;
 		struct multi_pack_index *m = ctx.base_midx;
 
-		if (!chainf) {
-			error_errno(_("unable to open multi-pack-index chain file"));
-			goto cleanup;
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+			FILE *chainf = fdopen_lock_file(&lk, "w");
+			if (!chainf) {
+				error_errno(_("unable to open multi-pack-index chain file"));
+				goto cleanup;
+			}
 		}
 
 		if (link_midx_to_chain(ctx.base_midx) < 0)
@@ -1791,8 +1799,10 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			}
 		}
 
-		for (uint32_t i = 0; i < keep_hashes_nr; i++)
-			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes.v[i]);
+		if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY))
+			for (uint32_t i = 0; i < keep_hashes_nr; i++)
+				fprintf(get_lock_file_fp(&lk), "%s\n",
+					keep_hashes.v[i]);
 	} else {
 		keep_hashes.v[ctx.num_multi_pack_indexes_before] =
 			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
@@ -1802,10 +1812,12 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.m || ctx.base_midx)
 		odb_close(ctx.repo->objects);
 
-	if (commit_lock_file(&lk) < 0)
-		die_errno(_("could not write multi-pack-index"));
+	if (!(opts->flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+		if (commit_lock_file(&lk) < 0)
+			die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+		clear_midx_files(opts->source, &keep_hashes, ctx.incremental);
+	}
 	result = 0;
 
 cleanup:
diff --git a/midx.h b/midx.h
index 08f3728e520..9f1acd7ace4 100644
--- a/midx.h
+++ b/midx.h
@@ -83,6 +83,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
 #define MIDX_WRITE_COMPACT (1 << 6)
+#define MIDX_WRITE_CHECKSUM_ONLY (1 << 7)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index d30d7253d6f..96449178c07 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -95,6 +95,23 @@ test_expect_success 'show object from second pack' '
 	git cat-file -p 2.2
 '
 
+test_expect_success 'write MIDX layer with --checksum-only' '
+	test_commit checksum-only &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
+	test_must_fail git multi-pack-index write --bitmap --checksum-only 2>err &&
+	test_grep "cannot use --checksum-only without --incremental" err
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 40f3844282f..55b9773568b 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -290,4 +290,38 @@ test_expect_success 'MIDX compaction with bitmaps (non-trivial)' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --checksum-only' '
+	git init midx-compact-with--checksum-only &&
+	(
+		cd midx-compact-with--checksum-only &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		layer="$(git multi-pack-index compact --incremental \
+			--checksum-only \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")")" &&
+
+		test_cmp "$midx_chain.bak" "$midx_chain" &&
+
+		# After writing the new layer, insert it into the chain
+		# manually. This is done in order to make $layer visible
+		# to the read-midx test helper below, and matches what
+		# the MIDX command would do without --checksum-only.
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
2.53.0.185.g29bc4dff628

