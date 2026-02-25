Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com [209.85.222.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F43A2745C
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978881; cv=none; b=PldbRrULJpgkXSbFY/hWCheUz/24DSIs1rkaebBC2u5dbLK73n8rPExuOb6OrkeFGNZw0Csv4K72mEqdFYC6t07ZtLAIMAdLTV+sK5KajgEpSAZT3DusrTlWcy0Nz2Jcz4wjzXlApEmo+ZpNY4cEuRrX2lvNUXnsLgTWpgOEnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978881; c=relaxed/simple;
	bh=Iul7wgsvZi8M+du2q08hEwxpWONjMaamlBD01gN0s14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZI1NSI/I+vhsrrkNugDYLnkPrlDLZ+KLtItn6COOVpnjR3KJqyec4ehkqYPZn9amXj29SKlbERrQki6upOq01E1wttfOB+hobcuyDYzMYxK7wK/KjSJ0JTv4EQ/mL3H8FPdrenwokWlNcFiIqCuOzmbs3v+Wx8qoD5vYp4DBgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nncr56oT; arc=none smtp.client-ip=209.85.222.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nncr56oT"
Received: by mail-qk1-f195.google.com with SMTP id af79cd13be357-8cb20bcff5aso629096785a.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978879; x=1772583679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NgiVSdQq7F6PzjswvTLmr2R8cdTb0P2oi/qw0ksOVxc=;
        b=nncr56oTgLs4DZZ/tKcMcxCPDgeKv1+Y5DppnN4JP77PBOe2bJmlOMW30Pw7tL7afe
         AMb9qdA7Sw1EMFUv0DTv5GHgrtSbt5MoPymRsj2bk8+hoarl3mmhnZFRD+VqUFZld6WN
         Roaa0xH3Jj5qBF5w/XxgnVcBrJEf8/Af5N/dCHuw/kRYzzy7f3Q9NkGyX44urMbwx7HZ
         CBGfeVtaobmllWkliDjYR0dMw2Ey+gGw5WLaACYqMc2fXi7RCxBDTdxgntbdsW2q7B5h
         55+LDwRNiU0C8i/j+DZyp8pcCD/rxSrEJsZtjlNsMuPEfW9kH7QdxQIb8MefYa3VJ4gY
         gk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978879; x=1772583679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgiVSdQq7F6PzjswvTLmr2R8cdTb0P2oi/qw0ksOVxc=;
        b=YcMeGc2vsnnMLb6qtSwMXUMhz3loQathKrH724cTnN5CCYyI6aOVEI3B2LRRW+Ki7v
         IFqwMtbef32VbNUrB9J8GP+S2lbwS5cUnbE6qaurfTVTdGYlmnj8UYUwEwKPz6V+fBy3
         LO0BYknCanBWqajayqsO8dSaZTCo2YqHQhzlfcXCOwYlv4P8PatLe8PI8SXm77GjyL46
         GhABjgqnxgtUZ1tcCB3H4X54YcyqgfZmJKSqcchPPcBMlsSmmS0mh0JzCx2m7l9BYkRb
         dDBI2MBON3cADO3SLax4thmDD5P2NPpL2+ACCsQNw8jqdc1R0VMntKN/VqgE1YExtaLx
         wQKQ==
X-Gm-Message-State: AOJu0Yzi0JHM3acKyNZeArK1d0ismteU0AXfP0jrSeV98mNXAcOxjT3p
	VWmIyE16PH/5RDmXYDGDoz6dk92vWTkxjF3Gthvj/BMEg/pl7dPyInayd7/48kqPqC2yRSwLAD1
	iIYlx4fGUaMm1
X-Gm-Gg: ATEYQzy0tWmZtpZDLsIS8glsIoFXeBN9UPJkdg3pjyJbx5ZqCWjupPIUjNGyShS6cOG
	u13KcYI1JlRcIDLSA5NkzyiU4/fRHqF8w+EosXKQv4dlzPyZxrCQS8HcsygeohGOvaZ3tZU6UHZ
	ryzTxB1gZdyRl2HWyj4NZZ4MG9PlW+cBJsPcQOoybO5EQ7rgNo0Ip/T1P7LncwpgC88K+rFgwZd
	GBzM4srLSyuCt/qoaIxD/CkDF5A4gNeCcQHzIYMTQ+xj0fbsdCfATM11RFx1IEXkCYyRk0puX+G
	RZhlWd+iH8kO2+epJXYCtxUyZ5neIHZqBAPK6P/DnmB0EKRkPwaROQ6g2l1S5FdiaHHIDefOdKI
	lrG+up2Ec+6TZE8DWMj118VekZS6m9io8U/zrjcit5V4JCDk4wuORa969exwElII5Io9R6i0mDh
	/TpXwAu/GLfCz0pTvNk9XRE1lj4KeSoZI04rdcIH7SLlCejbY/PtpKebjAR7ViE3Q6VbKkWdQIZ
	QAYqtVPrjS7h1Tqv4vzzUfvOLdNZA==
X-Received: by 2002:a05:620a:45ab:b0:8b2:598d:6e66 with SMTP id af79cd13be357-8cb8c9f9a9fmr1741537985a.22.1771978878995;
        Tue, 24 Feb 2026 16:21:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899b894a227sm3263456d6.8.2026.02.24.16.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:18 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:16 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 05/14] midx: support custom `--base` for incremental MIDX
 writes
Message-ID: <9ab735bafe37c2bf3b5e9064d83415e7c4e555c6.1771978829.git.me@ttaylorr.com>
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

For the `write` subcommand, `--base` requires `--checksum-only`. A plain
`write --incremental` appends a new layer to the live chain tip with no
mechanism to atomically replace it; overriding the base would produce a
layer that does not extend the tip, breaking chain invariants. With
`--checksum-only` the chain is left unmodified and the caller is
responsible for assembling a valid chain.

For `compact`, no such restriction applies. The compaction operation
atomically replaces the compacted range in the chain file, so writing
the result on top of any valid ancestor preserves chain invariants.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc | 17 +++++-
 builtin/multi-pack-index.c              | 24 +++++++--
 midx-write.c                            | 34 ++++++++++--
 midx.h                                  |  5 +-
 t/t5334-incremental-multi-pack-index.sh | 30 +++++++++++
 t/t5335-compact-multi-pack-index.sh     | 71 +++++++++++++++++++++++++
 6 files changed, 172 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 657e0639f6a..635105ad801 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,8 +12,10 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>] [--[no-]checksum-only]
+			 [--base=<checksum>]
 'git multi-pack-index' [<options>] compact [--[no-]incremental]
-		         [--[no-]bitmap] [--[no-]checksum-only] <from> <to>
+		         [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]
+			 <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +85,13 @@ marker).
 		and packs not present in an existing MIDX layer.
 		Migrates non-incremental MIDXs to incremental ones when
 		necessary.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base when writing a new incremental layer.
+		The special value `none` indicates that the new layer
+		should have no base (i.e., it becomes a root layer).
+		Requires `--checksum-only`.
 --
 
 compact::
@@ -97,6 +106,12 @@ compact::
 
 	--[no-]bitmap::
 		Control whether or not a multi-pack bitmap is written.
+
+	--base=<checksum>::
+		Specify the checksum of an existing MIDX layer to use
+		as the base for the compacted result, instead of using
+		the immediate parent of `<from>`. The special value
+		`none` indicates that the result should have no base.
 --
 
 verify::
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index ee1ddf1386f..4fc53a5971c 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -15,11 +15,13 @@
 #define BUILTIN_MIDX_WRITE_USAGE \
 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
-	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]")
+	   "  [--refs-snapshot=<path>] [--[no-]checksum-only]\n" \
+	   "  [--base=<checksum>]")
 
 #define BUILTIN_MIDX_COMPACT_USAGE \
 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
-	   "  [--[no-]bitmap] [--[no-]checksum-only] <from> <to>")
+	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]checksum-only]\n" \
+	   "  <from> <to>")
 
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
@@ -62,6 +64,7 @@ static char const * const builtin_multi_pack_index_usage[] = {
 static struct opts_multi_pack_index {
 	char *object_dir;
 	const char *preferred_pack;
+	const char *incremental_base;
 	char *refs_snapshot;
 	unsigned long batch_size;
 	unsigned flags;
@@ -150,6 +153,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 			   N_("pack for reuse when computing a multi-pack bitmap")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "incremental", &opts.flags,
 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
 		OPT_BIT(0, "checksum-only", &opts.flags,
@@ -189,6 +194,13 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 				   options);
 	}
 
+	if (opts.incremental_base &&
+	    !(opts.flags & MIDX_WRITE_CHECKSUM_ONLY)) {
+		error(_("cannot use --base without --checksum-only"));
+		usage_with_options(builtin_multi_pack_index_write_usage,
+				   options);
+	}
+
 	source = handle_object_dir_option(repo);
 
 	FREE_AND_NULL(options);
@@ -200,7 +212,8 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		ret = write_midx_file_only(source, &packs,
 					   opts.preferred_pack,
-					   opts.refs_snapshot, opts.flags);
+					   opts.refs_snapshot,
+					   opts.incremental_base, opts.flags);
 
 		string_list_clear(&packs, 0);
 		free(opts.refs_snapshot);
@@ -228,6 +241,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	struct option *options;
 	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
+			   N_("base MIDX for incremental writes")),
 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
 		OPT_BIT(0, "incremental", &opts.flags,
@@ -289,7 +304,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
+	ret = write_midx_file_compact(source, from_midx, to_midx,
+				      opts.incremental_base, opts.flags);
 
 	return ret;
 }
diff --git a/midx-write.c b/midx-write.c
index 9cf085ca333..c3e70d76d7c 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1245,6 +1245,7 @@ struct write_midx_opts {
 
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
+	const char *incremental_base;
 	unsigned flags;
 };
 
@@ -1327,11 +1328,32 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
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
@@ -1844,7 +1866,8 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 int write_midx_file(struct odb_source *source,
 		    const char *preferred_pack_name,
-		    const char *refs_snapshot, unsigned flags)
+		    const char *refs_snapshot,
+		    unsigned flags)
 {
 	struct write_midx_opts opts = {
 		.source = source,
@@ -1859,13 +1882,16 @@ int write_midx_file(struct odb_source *source,
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
 
@@ -1875,12 +1901,14 @@ int write_midx_file_only(struct odb_source *source,
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
index 9f1acd7ace4..e4a75ff2bef 100644
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
index 96449178c07..77fb40ade01 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -112,6 +112,36 @@ test_expect_success 'write non-incremental MIDX layer with --checksum-only' '
 	test_grep "cannot use --checksum-only without --incremental" err
 '
 
+test_expect_success 'write MIDX layer with --base without --checksum-only' '
+	test_must_fail git multi-pack-index write --bitmap --incremental \
+		--base=none 2>err &&
+	test_grep "cannot use --base without --checksum-only" err
+'
+
+test_expect_success 'write MIDX layer with --base=none and --checksum-only' '
+	test_commit base-none &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only --base=none)" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
+test_expect_success 'write MIDX layer with --base=<hash> and --checksum-only' '
+	test_commit base-hash &&
+	git repack -d &&
+
+	cp "$midx_chain" "$midx_chain.bak" &&
+	layer="$(git multi-pack-index write --bitmap --incremental \
+		--checksum-only --base="$(nth_line 1 "$midx_chain")")" &&
+
+	test_cmp "$midx_chain.bak" "$midx_chain" &&
+	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
+'
+
 for reuse in false single multi
 do
 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
index 55b9773568b..f0d1d68d26c 100755
--- a/t/t5335-compact-multi-pack-index.sh
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -302,6 +302,7 @@ test_expect_success 'MIDX compaction with --checksum-only' '
 
 		layer="$(git multi-pack-index compact --incremental \
 			--checksum-only \
+			--base="$(nth_line 1 "$midx_chain")" \
 			"$(nth_line 2 "$midx_chain")" \
 			"$(nth_line 3 "$midx_chain")")" &&
 
@@ -324,4 +325,74 @@ test_expect_success 'MIDX compaction with --checksum-only' '
 	)
 '
 
+test_expect_success 'MIDX compaction with --base' '
+	git init midx-compact-with--base &&
+	(
+		cd midx-compact-with--base &&
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
2.53.0.185.g29bc4dff628

