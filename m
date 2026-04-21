Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FA3DDDC3
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776803855; cv=none; b=nbQVLu3WlaMYTedvq6OhnsBFYczZHnPCB2v4cT9XZyGdQ3at22pFanspI9yQzZOPpePmC0dLIc0LahLxzJ9zksvexRR4vgV25K0wjTOt2hIBlIqm1nyoiZ+f47laYZQOuc2+PP0FgODj/ttwyUZ2B9ZBnfrGs8dhTfLjtMdGQPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776803855; c=relaxed/simple;
	bh=LAoocV09PnJbJtJGhX5gaAVRVqnj582GdHaJVblrZqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIzP88NGKPzXvznLOQU5Coo5YHF+ydqSij58NXqaZA2n8/DBbgTb6FekNCUG6l6f1KX/kuKN/cQTLeRnui5QmDFL0bmVSQaFaVMtWaRlB30OPEXi8CtWrpxnlTqicNC3t2l4Iy4iJR1OUm7v/GntyEORzY9JMGyRVqMeGWU1YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VCTePLKS; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VCTePLKS"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7dbec19732eso4174620a34.3
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 13:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1776803852; x=1777408652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JXq4qUsx7FY/l3F3TAsE+wvFkgsXLSBhwOExU4Jb/Y=;
        b=VCTePLKSAjg3f9d6TOcKPBrmka0fMgIIUsBlcfbIs8TlCblOIwavWN1N9+TGP2dh9R
         NtIBjc2dvTRsTnaPYDyH4TjgZeDra595QgQVP9sgOcW3V9fNpVjbtFmgRtZvlBmlkba2
         XWcWRRl3HwrNpKx/KexeWDUs7b6cqlepI8uRyH23WqZRJYG0NClIhLY0D1Zeh0rOUA1C
         w2N4QikuQnl5Kc+kBm3BTvy0ptRD3NRSp2dGWfwxKEc3xLBgFBJoKJL2YaZ5JJY23+Ih
         T0XvsVupIT/vf9UlfabyvIgg4HHrG0wpr4PP38WlAmnFQDBlRvj0YczlrHNgXNlVFBw3
         PIYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776803852; x=1777408652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JXq4qUsx7FY/l3F3TAsE+wvFkgsXLSBhwOExU4Jb/Y=;
        b=TLRKcufRbUfSNoXkjEo8pbRWOJy1EUTRSSh9Khajpnvl42Bj1S3rI8pxAKzusYs4vT
         rpa2L0Cxs11POa5IBSFd8wU5PTs9sz0A31gz14Tnk1k90u7BMpcaLvGx59sICl3+OBiz
         CvU3lKekBAh5H8oyTlXg9vixiOloMRJ2kz+Hu0L0gFikW8U2k8rsUdh0n3MXFY6WjIq+
         0OaeGokoYc0V8VLKNXpfXmNU+q5c9YGKyxYuQx4wkrRv3bT3h7DFKAyr4oLEWH5/zdAv
         a2GO1sPfejpJRHUUNVKn3xaP4dMlczE8116JB1q5K3LbnB0MB8cStAJQeouwRbGb7xOH
         ZXaA==
X-Gm-Message-State: AOJu0Yz41RtFHfBp9P9iheRoyDAjx45Ac2VFu9pxQTrZGlQ5EbD0aUBK
	bjqwqOx2yQBju4DqTUQUMVGXmmOT6x8VK62KidAdSRHs52eTbGLCIyHDUFnp45wpaRf43fofo0Q
	NWxaUSy0=
X-Gm-Gg: AeBDiesBiXOIF5IGMRpjZzK20wiL1j3Ngjuqux2BJ5umgNzBu5zT0eXqS/E1cDpNAs5
	6tNCp5ojzPSziTUJNpQ0xPFV+2h2lSZYOxNrfoJNZR4xBEp8dF0M2pNyLGPqKhMyOQ2CxkOra4Y
	HBroJEyXS+Z4jP9vneobm7LNiDSmc9mtJHDkESNH5yOAxWAK5SiZjruh7+lMyZnY7bEY0dHmXiX
	XlKXy6nazETZoq2GhFpBZCxSDggh1JbASbSR0+vzP+IHqkebo1lSc4qnn9qzvi9s9qF1iqqARhA
	3qnl+5kv4noV/1fefK1GTJWDqj5atcK5dqav6JlHR0/tLWwomGNfqurTZA9588wVgko6Rji0my5
	m+6umYCZ0UMDjmDdquxnwdfy94X1tFtxkbtGDERRmC1lLUSzbBEbVGMmCvw9IA4dGGcxn/dVQQK
	LfWjhgmP/5fwDUrGCVfT/WHmYWfA5kBWFIoWPV2RhfhB2me8qLioxtMst45k2MXT3SYGdVvY+he
	1Jqlj2wF72V4WUYQofM8lMyMOR/9CLflr7X1r8ehDvl47hpMzgOoNi/XjBQuZXrkmDl/PEALE0Z
	GcRc11A+jGLe3WYV5dVUWYYB4IQ=
X-Received: by 2002:a05:6820:620:b0:694:a362:4b86 with SMTP id 006d021491bc7-694a3624ce5mr310012eaf.22.1776803852092;
        Tue, 21 Apr 2026 13:37:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b9ac564d2sm13176361fac.14.2026.04.21.13.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 13:37:31 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:37:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 06/16] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <2a05f4b86f30ccd1f54e65c5da2d9234d405cbec.1776803827.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1776803827.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1776803827.git.me@ttaylorr.com>

Both `compact` and `write --incremental` fix the base of the resulting
MIDX layer: `compact` always places the compacted result on top of
"from's" immediate parent in the chain, and `write --incremental` always
appends a new layer to the existing tip. In both cases the base is not
configurable.

Future callers need additional flexibility. For instance, the incremental
MIDX-based repacking code may wish to write a layer based on some
intermediate ancestor rather than the current tip, or produce a root
layer when replacing the bottommost entries in the chain.

Introduce a new `--base` option for both subcommands to specify the
checksum of the MIDX layer to use as the base. The given checksum must
refer to a valid layer in the MIDX chain that is an ancestor of the
topmost layer being written or compacted.

The special value "none" is accepted to produce a root layer with no
parent. This will be needed when the incremental repacking machinery
determines that the bottommost layers of the chain should be replaced.

If no `--base` is given, behavior is unchanged: `compact` uses "from's"
immediate parent in the chain, and `write` appends to the existing tip.

For the `write` subcommand, `--base` requires `--no-write-chain-file`. A plain
`write --incremental` appends a new layer to the live chain tip with no
mechanism to atomically replace it; overriding the base would produce a
layer that does not extend the tip, breaking chain invariants. With
`--no-write-chain-file` the chain is left unmodified and the caller is
responsible for assembling a valid chain.

For `compact`, no such restriction applies. The compaction operation
atomically replaces the compacted range in the chain file, so writing
the result on top of any valid ancestor preserves chain invariants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 17 +++++-
 builtin/multi-pack-index.c              | 24 ++++++--
 midx-write.c                            | 34 ++++++++++-
 midx.h                                  |  5 +-
 t/t5334-incremental-multi-pack-index.sh | 30 ++++++++++
 t/t5335-compact-multi-pack-index.sh     | 77 +++++++++++++++++++++++++
 6 files changed, 178 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index c26196815e2..c6d23aeeb9a 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,8 +12,10 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
+			 [--base=<checksum>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]
+			 <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -90,6 +92,13 @@ marker).
 		The checksum of the new layer is printed to standard
 		output, allowing the caller to assemble and write the
 		chain itself. Requires `--incremental`.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base when writing a new incremental layer.
+		The special value `none` indicates that the new layer
+		should have no base (i.e., it becomes a root layer).
+		Requires `--no-write-chain-file`.
 --
 
 compact::
@@ -110,6 +119,12 @@ compact::
 		MIDX layer but do not update the multi-pack-index-chain
 		file. The checksum of the new layer is printed to
 		standard output. Requires `--incremental`.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base for the compacted result, instead of using
+		the immediate parent of `<from>`. The special value
+		`none` indicates that the result should have no base.
 --
 +
 Note that the compact command requires writing a version-2 midx that
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index f861b4b8394..00ffb36394d 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -16,11 +16,13 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
+	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]\n" \
+	   "  [--base=<checksum>]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]\n" \
+	   "  <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -63,6 +65,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	char *object_dir;
 	const char *preferred_pack;
+	const char *incremental_base;
 	char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
@@ -151,6 +154,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
@@ -190,6 +195,13 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 				   options);
 	}
 
+	if (opts.incremental_base &&
+	    !(opts.flags & MIDX_WRITE_NO_CHAIN)) {
+		error(_("cannot use --base without --no-write-chain-file"));
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -201,7 +213,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		ret = write_midx_file_only(source, &packs,
 					   opts.preferred_pack,
-					   opts.refs_snapshot, opts.flags);
+					   opts.refs_snapshot,
+					   opts.incremental_base, opts.flags);
 
 		string_list_clear(&packs, 0);
 		free(opts.refs_snapshot);
@@ -229,6 +242,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	struct option *options;
 	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
@@ -290,7 +305,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
+	ret = write_midx_file_compact(source, from_midx, to_midx,
+				      opts.incremental_base, opts.flags);
 
 	return ret;
 }
diff --git a/midx-write.c b/midx-write.c
index 38c898e5ff5..561e9eedc0e 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1247,6 +1247,7 @@ struct write_midx_opts {
 
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
+	const char *incremental_base;
 	unsigned flags;
 };
 
@@ -1330,11 +1331,32 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 	/*
 	 * If compacting MIDX layer(s) in the range [from, to], then the
-	 * compacted MIDX will share the same base MIDX as 'from'.
+	 * compacted MIDX will share the same base MIDX as 'from',
+	 * unless a custom --base is specified (see below).
 	 */
 	if (ctx.compact)
 		ctx.base_midx = ctx.compact_from->base_midx;
 
+	if (opts->incremental_base) {
+		if (!strcmp(opts->incremental_base, "none")) {
+			ctx.base_midx = NULL;
+		} else {
+			while (ctx.base_midx) {
+				const char *cmp = midx_get_checksum_hex(ctx.base_midx);
+				if (!strcmp(opts->incremental_base, cmp))
+					break;
+
+				ctx.base_midx = ctx.base_midx->base_midx;
+			}
+
+			if (!ctx.base_midx) {
+				error(_("could not find base MIDX '%s'"),
+				      opts->incremental_base);
+				goto cleanup;
+			}
+		}
+	}
+
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
@@ -1827,7 +1849,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot, unsigned flags)
+		    const char *refs_snapshot,
+		    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
@@ -1842,13 +1865,16 @@ int write_midx_file(struct odb_source *source,
 int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags)
+			 const char *refs_snapshot,
+			 const char *incremental_base,
+			 unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
 		.packs_to_include = packs_to_include,
 		.preferred_pack_name = preferred_pack_name,
 		.refs_snapshot = refs_snapshot,
+		.incremental_base = incremental_base,
 		.flags = flags,
 	};
 
@@ -1858,12 +1884,14 @@ int write_midx_file_only(struct odb_source *source,
 int write_midx_file_compact(struct odb_source *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
+			    const char *incremental_base,
 			    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
 		.compact_from = from,
 		.compact_to = to,
+		.incremental_base = incremental_base,
 		.flags = flags | MIDX_WRITE_COMPACT,
 	};
 
diff --git a/midx.h b/midx.h
index 5b193882dcf..77dd66de02b 100644
--- a/midx.h
+++ b/midx.h
@@ -132,10 +132,13 @@ int write_midx_file(struct odb_source *source,
 int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
-			 const char *refs_snapshot, unsigned flags);
+			 const char *refs_snapshot,
+			 const char *incremental_base,
+			 unsigned flags);
 int write_midx_file_compact(struct odb_source *source,
 			    struct multi_pack_index *from,
 			    struct multi_pack_index *to,
+			    const char *incremental_base,
 			    unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct odb_source *source, unsigned flags);
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 66d6894761b..68a103d13d2 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -113,6 +113,36 @@ test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
 	test_grep "cannot use --no-write-chain-file without --incremental" err
 '
 
+test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
+	test_must_fail git multi-pack-index write --bitmap --incremental \
+		--base=none 2>err &&
+	test_grep "cannot use --base without --no-write-chain-file" err
+'
+
+test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
+	test_commit base-none &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file --base=none)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
+	test_commit base-hash &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 1a65d48b62b..ec1dafe89fc 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -304,6 +304,7 @@ test_expect_success 'MIDX compaction with --no-write-chain-file' '
 
 		layer="$(git multi-pack-index compact --incremental \
 			--no-write-chain-file \
+			--base="$(nth_line 1 "$midx_chain")" \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 3 "$midx_chain")")" &&
 
@@ -326,4 +327,80 @@ test_expect_success 'MIDX compaction with --no-write-chain-file' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --base' '
+	git init midx-compact-with--base &&
+	(
+		cd midx-compact-with--base &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 "$midx_chain" &&
+
+		cp "$midx_chain" "$midx_chain.bak" &&
+
+		git multi-pack-index compact --incremental \
+			--base="$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 2 $midx_chain &&
+
+		nth_line 1 "$midx_chain.bak" >expect &&
+		nth_line 1 "$midx_chain" >actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'MIDX compaction with --base=none' '
+	git init midx-compact-base-none &&
+	(
+		cd midx-compact-base-none &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C D &&
+
+		test_line_count = 4 $midx_chain &&
+
+		cp "$midx_chain" "$midx_chain".bak &&
+
+		# Compact the two bottommost layers (A and B) into a new
+		# root layer with no parent.
+		git multi-pack-index compact --incremental \
+			--base=none \
+			"$(nth_line 1 "$midx_chain")" \
+			"$(nth_line 2 "$midx_chain")" &&
+
+		test_line_count = 3 $midx_chain &&
+
+		# The upper layers (C and D) should be preserved
+		# unchanged.
+		nth_line 3 "$midx_chain.bak" >expect &&
+		nth_line 4 "$midx_chain.bak" >>expect &&
+		nth_line 2 "$midx_chain" >actual &&
+		nth_line 3 "$midx_chain" >>actual &&
+
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'MIDX compaction with bogus --base checksum' '
+	git init midx-compact-bogus-base &&
+	(
+		cd midx-compact-bogus-base &&
+
+		git config maintenance.auto false &&
+
+		write_packs A B C &&
+
+		test_must_fail git multi-pack-index compact --incremental \
+			--base=deadbeef \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 3 "$midx_chain")" 2>err &&
+		test_grep "could not find base MIDX" err
+	)
+'
+
 test_done
-- 
2.54.0.9.gb905fd5d0ae

