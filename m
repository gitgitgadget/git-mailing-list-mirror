Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7C114A8B
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507990; cv=none; b=JP0RZ2FDcXZ1vOoE/pdbLetxdTWR8vL/v2zQwlkaVU29eltAu75meunVPsc8wt1eaqXH7p2+0OFD/Ll4It+dG2dhewbekNd7rOvUM8KfWffXYttVN+t/xuPBbP5eLvHgpx4TaJbIoCDZK+QV7FH2WarbTPenyiCYwC+EOhGHBPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507990; c=relaxed/simple;
	bh=ooWX+XSeTcfzUwpz5zFbPPV3fG1qDPEXTyrDJupTHMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHzRJb4badqWKJQAjUw7BTeycrisYX2YdQ2Nl308LtbcJMkieWYA+wMRICiJNB6Vl5cwpbgfs2OK+cGuPxO7kXvhw9zfXqyx54JJigebBhNnwVZ44QHIqFgePpmB+EncEf3eJDC4LOnctU+rgnSWbIrkOQa+UUlO+y4iSQA8txE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HkPKDcus; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HkPKDcus"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-79ab3e26cceso3436247b3.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777507986; x=1778112786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EZVHik1IH77QELwuy/XDEMqC72rw74YHH4h1RZoHlH4=;
        b=HkPKDcusH/eDxrOhBYJXmOUwbqwSIrUFRijnHVjEzhN2Ykxe7uks/tvDYcBg0qRc7D
         KdO/4cxDndx8DSrjtq+ELKk5jUDMgbuTb0DULBGYU+CEsaBhPSZs4SXr944ScHe8CcsW
         yg/XRCSBt08n3G/MYSXmFliteJOTFxAHTzHzB7GAiljNAARkHqlb8IU5Fgfp0K3AWjp/
         c79AEGD7Szf9ru0rbFn5TrcSFR4sZBBMd/zQ38qhPV3vjRwXXaxx1M5UWzpnQfcfxirh
         7tW9ZjIi9MPWRGVE+gOjXHFc5OXfYE84Inio8jrZyS5g21wiaVUu5H/bfSmmljEv+bGM
         qG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507986; x=1778112786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZVHik1IH77QELwuy/XDEMqC72rw74YHH4h1RZoHlH4=;
        b=HOYKJpclwW9/pdEz0myjFHULFYHc4wnp8BqkSPjcI6yW3rsCPg5sYqKNL6YVJWHc0B
         VqfM/gVi2RerMKExKBuOD3iYVkACXWp0u4zQ+Gz8+PVg6cNPbI9kZC+E0s1pHHYHiPHy
         pXPwVd/Bqj5tT7rEJKjftCiTSKGBOe6zW7ufxw7FYf/VrS+60tt5Wkd1lBAZqJ0/F1/i
         H6CjrZ2cBkeuISDmT1aACFO7RYo6byyKoQRULaYJLlNTUx6oNuG6SWD4xlyeEcK84OXc
         NiG3npHMdkmM9YkAiK91BSoRNZdRH5NmGz/Vqrc3e+1gE35WDZkXH5NvFvJ16F95DAcb
         SGmQ==
X-Gm-Message-State: AOJu0YzqnfZRT8HZs2sYdGaMinQauDDHS8erf19fER2Z37PhnVU6+5eJ
	dEs62kd8aE0sUJaT7vmFMByqM0wvb+KTX8h2jjEx9z/oqfoFujKlgGfHDr4rWAGJC2I8W7m7ytd
	vIWWNmYzdmqqO
X-Gm-Gg: AeBDietCfBUQ4H7vTVvM440FW1EtEmPCyKcq4GUJKH9nGZMhJNqx6dHEWgm0d/369Lf
	g8Y5nBbJyRsvfbTbnxfJCoGHP2XaExJXVnsmXuaCnHuhJ8e0NPEJ5NAgflydv5UoR4AoUfu3Hw3
	alMB9ItdZ+OJ9stjN1SM2mwWb0gVCz/MEUqFjGGY2TMTNjH1EVCYxFtzdjgzYCkDsKKcJhNrb/r
	8RfBwGtdk4TQZ+sOA8KnIb3Q+jZhlC2CKOaY8yoSnIY4QFJSidi99CCLZ8m2Zqq98nglzr2HH5K
	tB9WpamM6J84nZQOtuvXR+j7lSvZA39ZRSxBUzl6d0SpZBIMRsp/2k6WsWG5JsrEgtMguywMy50
	mhUzrXvdOAZDSRQhXErhbiDGUvUuh+A0ridXIl+e/GBjNNIGAlFKWMptEH7Cqi3i7SAEDEoNWt+
	Y14kdw31dja/KBh3CD1+pYbxTcooUqTSfnorZ/R8uLIbHurjVommUIirk7kW9S/EnAi7q6OuwHg
	VaMbNk3kibWus9UbjoU5+ByKdkzKAfxyZiRWsE3yYU96vPA9js+xj7BF9zyxSHAy1Ge9THULyDD
	2E2a0r6lXV/8+ZtP2efh3g09x08=
X-Received: by 2002:a05:690c:d82:b0:7ba:f0ed:c5a6 with SMTP id 00721157ae682-7bd5286fe5cmr10340397b3.15.1777507986175;
        Wed, 29 Apr 2026 17:13:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd54b2f1d9sm1772467b3.15.2026.04.29.17.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:05 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:04 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/16] repack: incremental MIDX/bitmap-based repacking
Message-ID: <cover.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1774820449.git.me@ttaylorr.com>

This a small reroll of my series to implement the last remaining
component of the incremental MIDX/bitmap-based repacking strategy that I
have been working on.

I expect that this should be the final reroll absent any late-breaking
feedback. The only changes since last time are the following:

 - Various stale references to "--checksum-only" have been eradicated
   from commit message(s).

 - `repack_prepare_midx_command()` now uses `pipe_command()` to
   eliminate the possibility of a deadlock.

 - `write_midx_included_packs()` now cleans up after itself properly
   when receiving multiple lines of output.

 - The errant test in t7705 was moved to the final commit (where it
   belongs) instead of the penultimate one.

As usual, a range-diff is included below as well for convenience. Thanks
in advance for reviewing!

Taylor Blau (16):
  midx-write: handle noop writes when converting incremental chains
  midx: use `strset` for retained MIDX files
  midx: build `keep_hashes` array in order
  midx: use `strvec` for `keep_hashes`
  midx: introduce `--no-write-chain-file` for incremental MIDX writes
  midx: support custom `--base` for incremental MIDX writes
  repack: track the ODB source via existing_packs
  midx: expose `midx_layer_contains_pack()`
  repack-midx: factor out `repack_prepare_midx_command()`
  repack-midx: extract `repack_fill_midx_stdin_packs()`
  repack-geometry: prepare for incremental MIDX repacking
  builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
  packfile: ensure `close_pack_revindex()` frees in-memory revindex
  repack: implement incremental MIDX repacking
  repack: introduce `--write-midx=incremental`
  repack: allow `--write-midx=incremental` without `--geometric`

 Documentation/config/repack.adoc        |  18 +
 Documentation/git-multi-pack-index.adoc |  32 +-
 Documentation/git-repack.adoc           |  44 +-
 builtin/multi-pack-index.c              |  48 +-
 builtin/repack.c                        | 102 +++-
 midx-write.c                            | 206 ++++---
 midx.c                                  | 104 ++--
 midx.h                                  |  11 +-
 packfile.c                              |   2 +
 repack-geometry.c                       |  48 +-
 repack-midx.c                           | 710 +++++++++++++++++++++++-
 repack.c                                |  58 +-
 repack.h                                |  26 +-
 t/meson.build                           |   1 +
 t/t5334-incremental-multi-pack-index.sh |  63 +++
 t/t5335-compact-multi-pack-index.sh     | 113 ++++
 t/t7705-repack-incremental-midx.sh      | 525 ++++++++++++++++++
 17 files changed, 1911 insertions(+), 200 deletions(-)
 create mode 100755 t/t7705-repack-incremental-midx.sh

Range-diff against v2:
 -:  ----------- >  1:  d6c27317c25 midx-write: handle noop writes when converting incremental chains
 -:  ----------- >  2:  629c8d23116 midx: use `strset` for retained MIDX files
 -:  ----------- >  3:  e303bf6a4ac midx: build `keep_hashes` array in order
 -:  ----------- >  4:  42d76c70060 midx: use `strvec` for `keep_hashes`
 -:  ----------- >  5:  2c80aa34fac midx: introduce `--no-write-chain-file` for incremental MIDX writes
 7:  d9acef1334a !  6:  2a05f4b86f3 repack: allow `--write-midx=incremental` without `--geometric`
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>
     
      ## Commit message ##
    -    repack: allow `--write-midx=incremental` without `--geometric`
    +    midx: support custom `--base` for incremental MIDX writes
     
    -    Previously, `--write-midx=incremental` required `--geometric` and would
    -    die() without it. Relax this restriction so that incremental MIDX
    -    repacking can be used independently.
    +    Both `compact` and `write --incremental` fix the base of the resulting
    +    MIDX layer: `compact` always places the compacted result on top of
    +    "from's" immediate parent in the chain, and `write --incremental` always
    +    appends a new layer to the existing tip. In both cases the base is not
    +    configurable.
     
    -    Without `--geometric`, the behavior is append-only: a single new MIDX
    -    layer is created containing whatever packs were written by the repack
    -    and appended to the existing chain (or a new chain is started). Existing
    -    layers are preserved as-is with no compaction or merging.
    +    Future callers need additional flexibility. For instance, the incremental
    +    MIDX-based repacking code may wish to write a layer based on some
    +    intermediate ancestor rather than the current tip, or produce a root
    +    layer when replacing the bottommost entries in the chain.
     
    -    Implement this via a new repack_make_midx_append_plan() that builds a
    -    plan consisting of a WRITE step for the freshly written packs followed
    -    by COPY steps for every existing MIDX layer. The existing compaction
    -    plan (repack_make_midx_compaction_plan) is used only when `--geometric`
    -    is active.
    +    Introduce a new `--base` option for both subcommands to specify the
    +    checksum of the MIDX layer to use as the base. The given checksum must
    +    refer to a valid layer in the MIDX chain that is an ancestor of the
    +    topmost layer being written or compacted.
     
    -    Update the documentation to describe the behavior with and without
    -    `--geometric`, and replace the test that enforced the old restriction
    -    with one exercising append-only incremental MIDX repacking.
    +    The special value "none" is accepted to produce a root layer with no
    +    parent. This will be needed when the incremental repacking machinery
    +    determines that the bottommost layers of the chain should be replaced.
    +
    +    If no `--base` is given, behavior is unchanged: `compact` uses "from's"
    +    immediate parent in the chain, and `write` appends to the existing tip.
    +
    +    For the `write` subcommand, `--base` requires `--no-write-chain-file`. A plain
    +    `write --incremental` appends a new layer to the live chain tip with no
    +    mechanism to atomically replace it; overriding the base would produce a
    +    layer that does not extend the tip, breaking chain invariants. With
    +    `--no-write-chain-file` the chain is left unmodified and the caller is
    +    responsible for assembling a valid chain.
    +
    +    For `compact`, no such restriction applies. The compaction operation
    +    atomically replaces the compacted range in the chain file, so writing
    +    the result on top of any valid ancestor preserves chain invariants.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    - ## Documentation/git-repack.adoc ##
    -@@ Documentation/git-repack.adoc: linkgit:git-multi-pack-index[1]).
    + ## Documentation/git-multi-pack-index.adoc ##
    +@@ Documentation/git-multi-pack-index.adoc: SYNOPSIS
    + 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
    + 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
    + 		         [--refs-snapshot=<path>] [--[no-]write-chain-file]
    ++			 [--base=<checksum>]
    + 'git multi-pack-index' [<options>] compact [--[no-]incremental]
    +-		         [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>
    ++		         [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]
    ++			 <from> <to>
    + 'git multi-pack-index' [<options>] verify
    + 'git multi-pack-index' [<options>] expire
    + 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
    +@@ Documentation/git-multi-pack-index.adoc: marker).
    + 		The checksum of the new layer is printed to standard
    + 		output, allowing the caller to assemble and write the
    + 		chain itself. Requires `--incremental`.
    ++
    ++	--base=<checksum>::
    ++		Specify the checksum of an existing MIDX layer to use
    ++		as the base when writing a new incremental layer.
    ++		The special value `none` indicates that the new layer
    ++		should have no base (i.e., it becomes a root layer).
    ++		Requires `--no-write-chain-file`.
    + --
      
    - 	`incremental`;;
    - 		Write an incremental MIDX chain instead of a single
    --		flat MIDX. This mode requires `--geometric`.
    -+		flat MIDX.
    - +
    --The incremental mode maintains a chain of MIDX layers that is compacted
    --over time using a geometric merging strategy. Each repack creates a new
    --tip layer containing the newly written pack(s). Adjacent layers are then
    --merged whenever the newer layer's object count exceeds
    --`1/repack.midxSplitFactor` of the next deeper layer's count. Layers
    --that do not meet this condition are retained as-is.
    -+Without `--geometric`, a new MIDX layer is appended to the existing
    -+chain (or a new chain is started) containing whatever packs were written
    -+by the repack. Existing layers are preserved as-is.
    -++
    -+When combined with `--geometric`, the incremental mode maintains a chain
    -+of MIDX layers that is compacted over time using a geometric merging
    -+strategy. Each repack creates a new tip layer containing the newly
    -+written pack(s). Adjacent layers are then merged whenever the newer
    -+layer's object count exceeds `1/repack.midxSplitFactor` of the next
    -+deeper layer's count. Layers that do not meet this condition are
    -+retained as-is.
    + compact::
    +@@ Documentation/git-multi-pack-index.adoc: compact::
    + 		MIDX layer but do not update the multi-pack-index-chain
    + 		file. The checksum of the new layer is printed to
    + 		standard output. Requires `--incremental`.
    ++
    ++	--base=<checksum>::
    ++		Specify the checksum of an existing MIDX layer to use
    ++		as the base for the compacted result, instead of using
    ++		the immediate parent of `<from>`. The special value
    ++		`none` indicates that the result should have no base.
    + --
      +
    - The result is that newer (tip) layers tend to contain many small packs
    - with relatively few objects, while older (deeper) layers contain fewer,
    + Note that the compact command requires writing a version-2 midx that
     
    - ## builtin/repack.c ##
    -@@ builtin/repack.c: int cmd_repack(int argc,
    - 	if (pack_everything & PACK_CRUFT)
    - 		pack_everything |= ALL_INTO_ONE;
    - 
    --	if (write_midx == REPACK_WRITE_MIDX_INCREMENTAL && !geometry.split_factor)
    --		die(_("--write-midx=incremental requires --geometric"));
    --
    - 	if (write_bitmaps < 0) {
    - 		if (write_midx == REPACK_WRITE_MIDX_NONE &&
    - 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
    -
    - ## repack-midx.c ##
    -@@ repack-midx.c: static void midx_compaction_step_release(struct midx_compaction_step *step)
    - 	free(step->csum);
    - }
    + ## builtin/multi-pack-index.c ##
    +@@
    + #define BUILTIN_MIDX_WRITE_USAGE \
    + 	N_("git multi-pack-index [<options>] write [--preferred-pack=<pack>]\n" \
    + 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
    +-	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]")
    ++	   "  [--refs-snapshot=<path>] [--[no-]write-chain-file]\n" \
    ++	   "  [--base=<checksum>]")
      
    -+/*
    -+ * Build an append-only MIDX plan: a single WRITE step for the freshly
    -+ * written packs, plus COPY steps for every existing layer.  No
    -+ * compaction or merging is performed.
    -+ */
    -+static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
    -+					 struct midx_compaction_step **steps_p,
    -+					 size_t *steps_nr_p)
    -+{
    -+	struct multi_pack_index *m;
    -+	struct midx_compaction_step *steps = NULL;
    -+	struct midx_compaction_step *step;
    -+	size_t steps_nr = 0, steps_alloc = 0;
    -+
    -+	odb_reprepare(opts->existing->repo->objects);
    -+	m = get_multi_pack_index(opts->existing->source);
    + #define BUILTIN_MIDX_COMPACT_USAGE \
    + 	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
    +-	   "  [--[no-]bitmap] [--[no-]write-chain-file] <from> <to>")
    ++	   "  [--[no-]bitmap] [--base=<checksum>] [--[no-]write-chain-file]\n" \
    ++	   "  <from> <to>")
    + 
    + #define BUILTIN_MIDX_VERIFY_USAGE \
    + 	N_("git multi-pack-index [<options>] verify")
    +@@ builtin/multi-pack-index.c: static char const * const builtin_multi_pack_index_usage[] = {
    + static struct opts_multi_pack_index {
    + 	char *object_dir;
    + 	const char *preferred_pack;
    ++	const char *incremental_base;
    + 	char *refs_snapshot;
    + 	unsigned long batch_size;
    + 	unsigned flags;
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv,
    + 			   N_("pack for reuse when computing a multi-pack bitmap")),
    + 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
    + 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
    ++		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
    ++			   N_("base MIDX for incremental writes")),
    + 		OPT_BIT(0, "incremental", &opts.flags,
    + 			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
    + 		OPT_NEGBIT(0, "write-chain-file", &opts.flags,
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv,
    + 				   options);
    + 	}
    + 
    ++	if (opts.incremental_base &&
    ++	    !(opts.flags & MIDX_WRITE_NO_CHAIN)) {
    ++		error(_("cannot use --base without --no-write-chain-file"));
    ++		usage_with_options(builtin_multi_pack_index_write_usage,
    ++				   options);
    ++	}
     +
    -+	if (opts->names->nr) {
    -+		struct strbuf buf = STRBUF_INIT;
    -+		uint32_t i;
    + 	source = handle_object_dir_option(repo);
    + 
    + 	FREE_AND_NULL(options);
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_write(int argc, const char **argv,
    + 
    + 		ret = write_midx_file_only(source, &packs,
    + 					   opts.preferred_pack,
    +-					   opts.refs_snapshot, opts.flags);
    ++					   opts.refs_snapshot,
    ++					   opts.incremental_base, opts.flags);
    + 
    + 		string_list_clear(&packs, 0);
    + 		free(opts.refs_snapshot);
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, const char **argv,
    + 
    + 	struct option *options;
    + 	static struct option builtin_multi_pack_index_compact_options[] = {
    ++		OPT_STRING(0, "base", &opts.incremental_base, N_("checksum"),
    ++			   N_("base MIDX for incremental writes")),
    + 		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
    + 			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
    + 		OPT_BIT(0, "incremental", &opts.flags,
    +@@ builtin/multi-pack-index.c: static int cmd_multi_pack_index_compact(int argc, const char **argv,
    + 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
    + 	}
    + 
    +-	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
    ++	ret = write_midx_file_compact(source, from_midx, to_midx,
    ++				      opts.incremental_base, opts.flags);
    + 
    + 	return ret;
    + }
    +
    + ## midx-write.c ##
    +@@ midx-write.c: struct write_midx_opts {
    + 
    + 	const char *preferred_pack_name;
    + 	const char *refs_snapshot;
    ++	const char *incremental_base;
    + 	unsigned flags;
    + };
    + 
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 
    + 	/*
    + 	 * If compacting MIDX layer(s) in the range [from, to], then the
    +-	 * compacted MIDX will share the same base MIDX as 'from'.
    ++	 * compacted MIDX will share the same base MIDX as 'from',
    ++	 * unless a custom --base is specified (see below).
    + 	 */
    + 	if (ctx.compact)
    + 		ctx.base_midx = ctx.compact_from->base_midx;
    + 
    ++	if (opts->incremental_base) {
    ++		if (!strcmp(opts->incremental_base, "none")) {
    ++			ctx.base_midx = NULL;
    ++		} else {
    ++			while (ctx.base_midx) {
    ++				const char *cmp = midx_get_checksum_hex(ctx.base_midx);
    ++				if (!strcmp(opts->incremental_base, cmp))
    ++					break;
     +
    -+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
    ++				ctx.base_midx = ctx.base_midx->base_midx;
    ++			}
     +
    -+		step = &steps[steps_nr++];
    -+		memset(step, 0, sizeof(*step));
    ++			if (!ctx.base_midx) {
    ++				error(_("could not find base MIDX '%s'"),
    ++				      opts->incremental_base);
    ++				goto cleanup;
    ++			}
    ++		}
    ++	}
     +
    -+		step->type = MIDX_COMPACTION_STEP_WRITE;
    -+		string_list_init_dup(&step->u.write);
    + 	ctx.nr = 0;
    + 	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
    + 	ctx.info = NULL;
    +@@ midx-write.c: static int write_midx_internal(struct write_midx_opts *opts)
    + 
    + int write_midx_file(struct odb_source *source,
    + 		    const char *preferred_pack_name,
    +-		    const char *refs_snapshot, unsigned flags)
    ++		    const char *refs_snapshot,
    ++		    unsigned flags)
    + {
    + 	struct write_midx_opts opts = {
    + 		.source = source,
    +@@ midx-write.c: int write_midx_file(struct odb_source *source,
    + int write_midx_file_only(struct odb_source *source,
    + 			 struct string_list *packs_to_include,
    + 			 const char *preferred_pack_name,
    +-			 const char *refs_snapshot, unsigned flags)
    ++			 const char *refs_snapshot,
    ++			 const char *incremental_base,
    ++			 unsigned flags)
    + {
    + 	struct write_midx_opts opts = {
    + 		.source = source,
    + 		.packs_to_include = packs_to_include,
    + 		.preferred_pack_name = preferred_pack_name,
    + 		.refs_snapshot = refs_snapshot,
    ++		.incremental_base = incremental_base,
    + 		.flags = flags,
    + 	};
    + 
    +@@ midx-write.c: int write_midx_file_only(struct odb_source *source,
    + int write_midx_file_compact(struct odb_source *source,
    + 			    struct multi_pack_index *from,
    + 			    struct multi_pack_index *to,
    ++			    const char *incremental_base,
    + 			    unsigned flags)
    + {
    + 	struct write_midx_opts opts = {
    + 		.source = source,
    + 		.compact_from = from,
    + 		.compact_to = to,
    ++		.incremental_base = incremental_base,
    + 		.flags = flags | MIDX_WRITE_COMPACT,
    + 	};
    + 
    +
    + ## midx.h ##
    +@@ midx.h: int write_midx_file(struct odb_source *source,
    + int write_midx_file_only(struct odb_source *source,
    + 			 struct string_list *packs_to_include,
    + 			 const char *preferred_pack_name,
    +-			 const char *refs_snapshot, unsigned flags);
    ++			 const char *refs_snapshot,
    ++			 const char *incremental_base,
    ++			 unsigned flags);
    + int write_midx_file_compact(struct odb_source *source,
    + 			    struct multi_pack_index *from,
    + 			    struct multi_pack_index *to,
    ++			    const char *incremental_base,
    + 			    unsigned flags);
    + void clear_midx_file(struct repository *r);
    + int verify_midx_file(struct odb_source *source, unsigned flags);
    +
    + ## t/t5334-incremental-multi-pack-index.sh ##
    +@@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'write non-incremental MIDX layer with --no-write-chain-file
    + 	test_grep "cannot use --no-write-chain-file without --incremental" err
    + '
    + 
    ++test_expect_success 'write MIDX layer with --base without --no-write-chain-file' '
    ++	test_must_fail git multi-pack-index write --bitmap --incremental \
    ++		--base=none 2>err &&
    ++	test_grep "cannot use --base without --no-write-chain-file" err
    ++'
     +
    -+		for (i = 0; i < opts->names->nr; i++) {
    -+			strbuf_reset(&buf);
    -+			strbuf_addf(&buf, "pack-%s.idx",
    -+				    opts->names->items[i].string);
    -+			string_list_append(&step->u.write, buf.buf);
    -+		}
    ++test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
    ++	test_commit base-none &&
    ++	git repack -d &&
     +
    -+		strbuf_release(&buf);
    -+	}
    ++	cp "$midx_chain" "$midx_chain.bak" &&
    ++	layer="$(git multi-pack-index write --bitmap --incremental \
    ++		--no-write-chain-file --base=none)" &&
     +
    -+	for (; m; m = m->base_midx) {
    -+		ALLOC_GROW(steps, st_add(steps_nr, 1), steps_alloc);
    ++	test_cmp "$midx_chain.bak" "$midx_chain" &&
    ++	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
    ++'
     +
    -+		step = &steps[steps_nr++];
    -+		memset(step, 0, sizeof(*step));
    ++test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
    ++	test_commit base-hash &&
    ++	git repack -d &&
     +
    -+		step->type = MIDX_COMPACTION_STEP_COPY;
    -+		step->u.copy = m;
    -+		step->objects_nr = m->num_objects;
    -+	}
    ++	cp "$midx_chain" "$midx_chain.bak" &&
    ++	layer="$(git multi-pack-index write --bitmap --incremental \
    ++		--no-write-chain-file --base="$(nth_line 1 "$midx_chain")")" &&
     +
    -+	*steps_p = steps;
    -+	*steps_nr_p = steps_nr;
    -+}
    ++	test_cmp "$midx_chain.bak" "$midx_chain" &&
    ++	test_path_is_file "$midxdir/multi-pack-index-$layer.midx"
    ++'
     +
    - static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
    - 					    struct midx_compaction_step **steps_p,
    - 					    size_t *steps_nr_p)
    -@@ repack-midx.c: static int write_midx_incremental(struct repack_write_midx_opts *opts)
    - 		goto done;
    - 	}
    + for reuse in false single multi
    + do
    + 	test_expect_success "full clone (pack.allowPackReuse=$reuse)" '
    +
    + ## t/t5335-compact-multi-pack-index.sh ##
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '
      
    --	if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
    --		ret = error(_("unable to generate compaction plan"));
    --		goto done;
    -+	if (opts->geometry->split_factor) {
    -+		if (repack_make_midx_compaction_plan(opts, &steps, &steps_nr) < 0) {
    -+			ret = error(_("unable to generate compaction plan"));
    -+			goto done;
    -+		}
    -+	} else {
    -+		repack_make_midx_append_plan(opts, &steps, &steps_nr);
    - 	}
    + 		layer="$(git multi-pack-index compact --incremental \
    + 			--no-write-chain-file \
    ++			--base="$(nth_line 1 "$midx_chain")" \
    + 			"$(nth_line 2 "$midx_chain")" \
    + 			"$(nth_line 3 "$midx_chain")")" &&
      
    - 	for (i = 0; i < steps_nr; i++) {
    -
    - ## t/t7705-repack-incremental-midx.sh ##
    -@@ t/t7705-repack-incremental-midx.sh: create_layers () {
    - 	done
    - }
    +@@ t/t5335-compact-multi-pack-index.sh: test_expect_success 'MIDX compaction with --no-write-chain-file' '
    + 	)
    + '
      
    --test_expect_success '--write-midx=incremental requires --geometric' '
    --	test_must_fail git repack --write-midx=incremental 2>err &&
    -+test_expect_success '--write-midx=incremental without --geometric' '
    -+	git init incremental-without-geometric &&
    ++test_expect_success 'MIDX compaction with --base' '
    ++	git init midx-compact-with--base &&
     +	(
    -+		cd incremental-without-geometric &&
    - 
    --	test_grep -- "--write-midx=incremental requires --geometric" err
    ++		cd midx-compact-with--base &&
    ++
     +		git config maintenance.auto false &&
     +
    -+		test_commit first &&
    -+		git repack -d &&
    ++		write_packs A B C D &&
     +
    -+		test_commit second &&
    -+		git repack --write-midx=incremental &&
    ++		test_line_count = 4 "$midx_chain" &&
     +
    -+		git multi-pack-index verify &&
    -+		test_line_count = 1 $midx_chain &&
    -+		cp $midx_chain $midx_chain.before &&
    ++		cp "$midx_chain" "$midx_chain.bak" &&
     +
    -+		# A second repack appends a new layer without
    -+		# disturbing the existing one.
    -+		test_commit third &&
    -+		git repack --write-midx=incremental &&
    -+
    -+		git multi-pack-index verify &&
    ++		git multi-pack-index compact --incremental \
    ++			--base="$(nth_line 1 "$midx_chain")" \
    ++			"$(nth_line 3 "$midx_chain")" \
    ++			"$(nth_line 4 "$midx_chain")" &&
     +		test_line_count = 2 $midx_chain &&
    -+		head -n 1 $midx_chain.before >expect &&
    -+		head -n 1 $midx_chain >actual &&
    -+		test_cmp expect actual &&
     +
    -+		git fsck
    ++		nth_line 1 "$midx_chain.bak" >expect &&
    ++		nth_line 1 "$midx_chain" >actual &&
    ++
    ++		test_cmp expect actual
     +	)
    - '
    - 
    - test_expect_success 'below layer threshold, tip packs excluded' '
    -@@ t/t7705-repack-incremental-midx.sh: test_expect_success 'kept packs are excluded from repack' '
    - 		# entirely, so no rollup occurs as there is only one
    - 		# non-kept pack. A new MIDX layer is written containing
    - 		# that pack.
    --		git repack --geometric=2 -d --write-midx=incremental \
    --			--write-bitmap-index &&
    -+		git repack --geometric=2 -d --write-midx=incremental &&
    - 
    - 		test-tool read-midx $objdir >actual &&
    - 		grep "^pack-.*\.idx$" actual >actual.packs &&
    ++'
    ++
    ++test_expect_success 'MIDX compaction with --base=none' '
    ++	git init midx-compact-base-none &&
    ++	(
    ++		cd midx-compact-base-none &&
    ++
    ++		git config maintenance.auto false &&
    ++
    ++		write_packs A B C D &&
    ++
    ++		test_line_count = 4 $midx_chain &&
    ++
    ++		cp "$midx_chain" "$midx_chain".bak &&
    ++
    ++		# Compact the two bottommost layers (A and B) into a new
    ++		# root layer with no parent.
    ++		git multi-pack-index compact --incremental \
    ++			--base=none \
    ++			"$(nth_line 1 "$midx_chain")" \
    ++			"$(nth_line 2 "$midx_chain")" &&
    ++
    ++		test_line_count = 3 $midx_chain &&
    ++
    ++		# The upper layers (C and D) should be preserved
    ++		# unchanged.
    ++		nth_line 3 "$midx_chain.bak" >expect &&
    ++		nth_line 4 "$midx_chain.bak" >>expect &&
    ++		nth_line 2 "$midx_chain" >actual &&
    ++		nth_line 3 "$midx_chain" >>actual &&
    ++
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    ++test_expect_success 'MIDX compaction with bogus --base checksum' '
    ++	git init midx-compact-bogus-base &&
    ++	(
    ++		cd midx-compact-bogus-base &&
    ++
    ++		git config maintenance.auto false &&
    ++
    ++		write_packs A B C &&
    ++
    ++		test_must_fail git multi-pack-index compact --incremental \
    ++			--base=deadbeef \
    ++			"$(nth_line 2 "$midx_chain")" \
    ++			"$(nth_line 3 "$midx_chain")" 2>err &&
    ++		test_grep "could not find base MIDX" err
    ++	)
    ++'
    ++
    + test_done
 -:  ----------- >  7:  92aba3d366f repack: track the ODB source via existing_packs
 -:  ----------- >  8:  d3ac65c1f11 midx: expose `midx_layer_contains_pack()`
 -:  ----------- >  9:  1bd2f194c6f repack-midx: factor out `repack_prepare_midx_command()`
 1:  44f522ea04d ! 10:  2a87a1e4561 repack-midx: extract `repack_fill_midx_stdin_packs()`
    @@ Commit message
         This simplifies `write_midx_included_packs()` and prepares for a
         subsequent commit where the same helper is called with `cmd->out = -1`
         to capture the MIDX's checksum from the command's standard output,
    -    which is needed when writing MIDX layers with `--checksum-only`.
    +    which is needed when writing MIDX layers with `--no-write-chain-file`.
     
         No functional changes are included in this patch.
     
 2:  f5642a46bbd = 11:  3d32b9c88da repack-geometry: prepare for incremental MIDX repacking
 3:  9fdcb253a96 = 12:  1f7a5479bb8 builtin/repack.c: convert `--write-midx` to an `OPT_CALLBACK`
 4:  1e1b957bf12 = 13:  b155f25d53c packfile: ensure `close_pack_revindex()` frees in-memory revindex
 5:  93e152fb6aa ! 14:  ef012314930 repack: implement incremental MIDX repacking
    @@ Commit message
         Unlike the default mode which writes a single flat MIDX, the incremental
         mode constructs a compaction plan that determines which MIDX layers to
         write, compact, or copy, and then executes each step using `git
    -    multi-pack-index` subcommands with the --checksum-only flag.
    +    multi-pack-index` subcommands with the --no-write-chain-file flag.
     
         The repacking strategy works as follows:
     
    @@ Commit message
     
         After writing the new layer, the strategy is evaluated among the
         existing MIDX layers in order from oldest to newest. Each step that
    -    writes a new MIDX layer uses "--checksum-only" to avoid updating the
    -    multi-pack-index-chain file. After all steps are complete, the new chain
    -    file is written and then atomically moved into place.
    +    writes a new MIDX layer uses "--no-write-chain-file" to avoid updating
    +    the multi-pack-index-chain file. After all steps are complete, the new
    +    chain file is written and then atomically moved into place.
     
         At present, this functionality is exposed behind a new enum value,
         `REPACK_WRITE_MIDX_INCREMENTAL`, but has no external callers. A
    @@ repack-midx.c: static void repack_prepare_midx_command(struct child_process *cmd
     +					struct string_list *include,
     +					struct string_list *out)
      {
    ++	struct strbuf in_buf = STRBUF_INIT;
    ++	struct strbuf out_buf = STRBUF_INIT;
      	struct string_list_item *item;
    - 	FILE *in;
    +-	FILE *in;
      	int ret;
      
    - 	cmd->in = -1;
    -+	if (out)
    -+		cmd->out = -1;
    - 
    +-	cmd->in = -1;
    +-
      	strvec_push(&cmd->args, "--stdin-packs");
      
    -@@ repack-midx.c: static int repack_fill_midx_stdin_packs(struct child_process *cmd,
    - 		fprintf(in, "%s\n", item->string);
    - 	fclose(in);
    +-	ret = start_command(cmd);
    +-	if (ret)
    +-		return ret;
    +-
    +-	in = xfdopen(cmd->in, "w");
    + 	for_each_string_list_item(item, include)
    +-		fprintf(in, "%s\n", item->string);
    +-	fclose(in);
    ++		strbuf_addf(&in_buf, "%s\n", item->string);
      
    -+	if (out) {
    -+		struct strbuf buf = STRBUF_INIT;
    -+		FILE *outf = xfdopen(cmd->out, "r");
    +-	return finish_command(cmd);
    ++	ret = pipe_command(cmd, in_buf.buf, in_buf.len,
    ++			   out ? &out_buf : NULL, 0, NULL, 0);
     +
    -+		while (strbuf_getline(&buf, outf) != EOF)
    -+			string_list_append(out, buf.buf);
    -+		strbuf_release(&buf);
    ++	if (out)
    ++		string_list_split_f(out, out_buf.buf, "\n", -1,
    ++				    STRING_LIST_SPLIT_NONEMPTY);
     +
    -+		fclose(outf);
    -+	}
    ++	strbuf_release(&in_buf);
    ++	strbuf_release(&out_buf);
     +
    - 	return finish_command(cmd);
    ++	return ret;
      }
      
    + static int write_midx_included_packs(struct repack_write_midx_opts *opts)
     @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opts *opts)
      		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
      			     opts->refs_snapshot);
    @@ repack-midx.c: static int write_midx_included_packs(struct repack_write_midx_opt
     +	while (strbuf_getline_lf(&buf, out) != EOF) {
     +		if (step->csum) {
     +			ret = error(_("unexpected MIDX output: '%s'"), buf.buf);
    ++			fclose(out);
    ++			out = NULL;
    ++			finish_command(&cmd);
     +			goto out;
     +		}
     +		step->csum = strbuf_detach(&buf, NULL);
 6:  6119f15d3e8 ! 15:  04cfecd5136 repack: introduce `--write-midx=incremental`
    @@ t/t7705-repack-incremental-midx.sh (new)
     +	)
     +'
     +
    -+test_expect_success 'repack -ad --write-midx=incremental is safe' '
    -+	git init ad-incremental-midx &&
    -+	(
    -+		cd ad-incremental-midx &&
    -+
    -+		git config maintenance.auto false &&
    -+
    -+		# Build a MIDX chain with multiple layers referencing
    -+		# distinct packs.
    -+		test_commit first &&
    -+		git repack -d &&
    -+
    -+		test_commit second &&
    -+		git repack -d --write-midx=incremental &&
    -+
    -+		git multi-pack-index verify &&
    -+		test_line_count = 1 $midx_chain &&
    -+
    -+		# Now do a full -ad repack. The new pack contains all
    -+		# objects, but any retained MIDX layers still reference
    -+		# the now-deleted packs.
    -+		test_commit third &&
    -+		git repack -ad --write-midx=incremental &&
    -+
    -+		git multi-pack-index verify &&
    -+		git fsck &&
    -+		git rev-list --all --objects >/dev/null
    -+	)
    -+'
    -+
     +test_expect_success 'repack rejects invalid midxSplitFactor' '
     +	test_when_finished "rm -fr bad-split-factor" &&
     +	git init bad-split-factor &&
 -:  ----------- > 16:  1c05dfce579 repack: allow `--write-midx=incremental` without `--geometric`

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
2.54.0.16.g1c05dfce579
