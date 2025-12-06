Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14852C0293
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765053112; cv=none; b=TPTvu1f2AdgV0q9SazUgaGlhCnEdr9HBuSmoTdEc+BEgzGXEibsUkh/0vrtq9sLbJC/ZsbmR4bY7iPUZEsNVMIth1pfJxCAnqGy9Y+xb0GQ27bPopq75aL7rIZcyB4lpimQRC6RoPWcyQ5iRtjRg2zK5tzwGKsBgfiO1ie2NSg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765053112; c=relaxed/simple;
	bh=sdM/jmdOao3Mpv4kK8KnKCrVqAfnrahMfXXp8locjqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pspjFdYYSoPHi4sl9RrBauXINKUncho0lB30cOctoH5P/QFGA/BccuoGzQ41+NCprabz+tGdKsb8KC/LnyFUCG6lX335SJLPvRinh/LTMS+IN4mtC1XKcDyCNay0gdTyjEZjTVSsZGKpPgxazgo+4jWgJfeCOAw1KQwDcdMZPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ePalWC7y; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ePalWC7y"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-63f996d4e1aso3622993d50.0
        for <git@vger.kernel.org>; Sat, 06 Dec 2025 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765053108; x=1765657908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tKD6Xrj951sn3AmL2C5amuryzHzJ3DcbLEa8raywGck=;
        b=ePalWC7y3A2X0F6g337tImCUrW4sT7wPDeL94MORMW1yQIIjjm9fkdWQX56s1yrly+
         4HF4mRsbB75wyySQHRtHcjAYDpzR96HFzd2m8DN60CXnTPSueq352aphSFzLmOg9Fkez
         tJmdEfj7f0litdvaZP1JAsETn9G7umFPGnYicf0gM7jtfNaPA+5tG8w6GlvFMBDaRqX3
         WcxLGhKvt4JhpqaZB94Og47tanCAfzdZfxHSuHn5AhOwEHnaE7DOj4ZTdRNcVfKoKtI5
         lfbg/vJMwMuqwQfOAXEMH/TgRfbHkicWTYy2H9k37T6cPbxfxobHwFJDICPskaBmjSDr
         qgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765053108; x=1765657908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tKD6Xrj951sn3AmL2C5amuryzHzJ3DcbLEa8raywGck=;
        b=szhe+y1Erp7T2Trj7a3+ril6WbYNDWhtPnZC1Jf1wsk96bWmgqABN0ejCMhqZ5/HqO
         rgrN6Jes2y0apuuZ2RWMy1hnOah5/vPIvIxtVRQHgijHZq5syzfy7Ps6iJIWG/Vp/5zi
         NIi1+sTHYuovkDnjMv+xJKbN1tEh5WwAF2ZBX1sGZOwye7mdKWG9A8KLlJYNILmiulGB
         iVMuJsXKhQLi8Vq/hEOv2/2SyPNCW0XvvORcK+/L87Mvmogl5wrR3xiU0az6FVjzic83
         6WOra2eVCb8mPpsZq1NhrbSQFcEGGeXoFyxTEX9S41bia49iOOHircW0zD0oyYNMFYUg
         3j/Q==
X-Gm-Message-State: AOJu0Yy2YZuFpOBaVo4ELfAwcuryJrT4GX5zQ4iN0S43VYQyMMOEceOW
	69rO/ekI99IT2yP7sWlgG4OaklBL/myeZ2DJSFG8KcMD+9yWL9fMEaJxVAnUiqHwVF8GBfEdm1B
	CMCdCw28=
X-Gm-Gg: ASbGncvGHqdQJoatb0AbhfdvXFNa7sEbFu7joxpF2N8IXCat7OwIalJIPc4S5aMuGI9
	dA7LJArVGzyCPBfsKLP2Rgf/9kJabkI7dw0RuHHz0hLYGwTavf0HtlIwEbYCanjAZKOJtQVPGjn
	W3VKt9qUVVsMtmImEd7vXEUY2Up8knhiNJVxXWeKwlpxry8iG6oVZUymdHnEdaZ4YcGXVGGa14/
	nci8wwWdcYrrzGBFR9wp75HIcXTRVEFzCNVCahTGbWOaFRpPNRnGHue+R7LeQalJPZIP8A2KqmO
	jETkKyte2p2IL/kYce21MB4HfeLoVj2IKCZMTK3RZEpQTe7eaSXIRKQBw1/vyBB3i3MDBpZ8J7g
	jQwDu+d2HOP3PYEG6hSFTXVS0nJA4EPdqlLFgxu7YWw8i66WP2Pf1ODOwtoUfz03ZmzLZIT5TSz
	pHsS0UBJubWy8reEHcuWrcarwQfJ9i1KGX29RAo4JbMyF6jYm2VarAKFE1FtyQmz7+dlxtG51a+
	bPX6WFSmLHofgM8eg==
X-Google-Smtp-Source: AGHT+IHzswpcGMbCWDqmE46BWrvPkndf2IkhcKnhYJ4EGmrWPpEhsIBdkMj4G5mBFEAGRjbMNABpog==
X-Received: by 2002:a05:690e:bc1:b0:641:f5bc:68de with SMTP id 956f58d0204a3-6444e7fae4bmr2782236d50.75.1765053108358;
        Sat, 06 Dec 2025 12:31:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6443f2c404asm3355113d50.11.2025.12.06.12.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Dec 2025 12:31:48 -0800 (PST)
Date: Sat, 6 Dec 2025 15:31:47 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 16/17] midx: implement MIDX compaction
Message-ID: <c136b2e179d02321de7e7b3f1b6c748cb434d68d.1765053054.git.me@ttaylorr.com>
References: <cover.1765053054.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1765053054.git.me@ttaylorr.com>

When managing a MIDX chain with many layers, it is convenient to combine
a sequence of adjacent layers into a single layer to prevent the chain
from growing too long.

While it is conceptually possible to "compact" a sequence of MIDX layers
together by running "git multi-pack-index write --stdin-packs", there
are a few drawbacks that make this less than desirable:

 - Preserving the MIDX chain is impossible, since there is no way to
   write a MIDX layer that contains objects or packs found in an earlier
   MIDX layer already part of the chain. So callers would have to write
   an entirely new (non-incremental) MIDX containing only the compacted
   layers, discarding all other objects/packs from the MIDX.

 - There is (currently) no way to write a MIDX layer outside of the MIDX
   chain to work around the above, such that the MIDX chain could be
   reassembled substituting the compacted layers with the MIDX that was
   written.

 - The `--stdin-packs` command-line option does not allow us to specify
   the order of packs as they appear in the MIDX. Therefore, even if
   there were workarounds for the previous two challenges, any bitmaps
   belonging to layers which come after the compacted layer(s) would no
   longer be valid.

This commit introduces a way to compact a sequence of adjacent MIDX
layers into a single layer while preserving the MIDX chain, as well as
any bitmap(s) in layers which are newer than the compacted ones.

Implementing MIDX compaction does not require a significant number of
changes to how MIDX layers are written. The main changes are as follows:

 - Instead of calling `fill_packs_from_midx()`, we call a new function
   `fill_packs_from_midx_range()`, which walks backwards along the
   portion of the MIDX chain which we are compacting, and adds packs one
   layer a time.

   In order to preserve the pseudo-pack order, the concatenated pack
   order is preserved, with the exception of preferred packs which are
   always added first.

 - After adding entries from the set of packs in the compaction range,
   `compute_sorted_entries()` must adjust the `pack_int_id`'s for all
   objects added in each fanout layer to match their original
   `pack_int_id`'s (as opposed to the index at which each pack appears
   in `ctx.info`).

 - When writing out the new 'multi-pack-index-chain' file, discard any
   layers in the compaction range, replacing them with the newly written
   layer, instead of keeping them and placing the new layer at the end
   of the chain.

This ends up being sufficient to implement MIDX compaction in such a way
that preserves bitmaps corresponding to more recent layers in the MIDX
chain.

The tests for MIDX compaction are so far fairly spartan, since the main
interesting behavior here is ensuring that the right packs/objects are
selected from each layer, and that the pack order is preserved despite
whether or not they are sorted in lexicographic order in the original
MIDX chain.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.adoc |  13 ++
 builtin/multi-pack-index.c              |  67 +++++++
 midx-write.c                            | 242 ++++++++++++++++++++++--
 midx.h                                  |   5 +
 t/meson.build                           |   1 +
 t/t5335-compact-multi-pack-index.sh     | 102 ++++++++++
 6 files changed, 411 insertions(+), 19 deletions(-)
 create mode 100755 t/t5335-compact-multi-pack-index.sh

diff --git a/Documentation/git-multi-pack-index.adoc b/Documentation/git-multi-pack-index.adoc
index 164cf1f2291..a9664e77411 100644
--- a/Documentation/git-multi-pack-index.adoc
+++ b/Documentation/git-multi-pack-index.adoc
@@ -12,6 +12,8 @@ SYNOPSIS
 'git multi-pack-index' [<options>] write [--preferred-pack=<pack>]
 		         [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]
 		         [--refs-snapshot=<path>]
+'git multi-pack-index' [<options>] compact [--[no-]incremental]
+		         <from> <to>
 'git multi-pack-index' [<options>] verify
 'git multi-pack-index' [<options>] expire
 'git multi-pack-index' [<options>] repack [--batch-size=<size>]
@@ -83,6 +85,17 @@ marker).
 		necessary.
 --
 
+compact::
+	Write a new MIDX layer containing only objects and packs present
+	in the range `<from>` to `<to>`, where both arguments are
+	checksums of existing layers in the MIDX chain.
++
+--
+	--incremental::
+		Write the result to a MIDX chain instead of writing a
+		stand-alone MIDX. Incompatible with `--bitmap`.
+--
+
 verify::
 	Verify the contents of the MIDX file.
 
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index c0c6c1760c0..9b0c2082cb3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -17,6 +17,10 @@
 	   "  [--[no-]bitmap] [--[no-]incremental] [--[no-]stdin-packs]\n" \
 	   "  [--refs-snapshot=<path>]")
 
+#define BUILTIN_MIDX_COMPACT_USAGE \
+	N_("git multi-pack-index [<options>] compact [--[no-]incremental]\n" \
+	   "  <from> <to>")
+
 #define BUILTIN_MIDX_VERIFY_USAGE \
 	N_("git multi-pack-index [<options>] verify")
 
@@ -30,6 +34,10 @@ static char const * const builtin_multi_pack_index_write_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
 	NULL
 };
+static char const * const builtin_multi_pack_index_compact_usage[] = {
+	BUILTIN_MIDX_COMPACT_USAGE,
+	NULL
+};
 static char const * const builtin_multi_pack_index_verify_usage[] = {
 	BUILTIN_MIDX_VERIFY_USAGE,
 	NULL
@@ -44,6 +52,7 @@ static char const * const builtin_multi_pack_index_repack_usage[] = {
 };
 static char const * const builtin_multi_pack_index_usage[] = {
 	BUILTIN_MIDX_WRITE_USAGE,
+	BUILTIN_MIDX_COMPACT_USAGE,
 	BUILTIN_MIDX_VERIFY_USAGE,
 	BUILTIN_MIDX_EXPIRE_USAGE,
 	BUILTIN_MIDX_REPACK_USAGE,
@@ -195,6 +204,63 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 	return ret;
 }
 
+static int cmd_multi_pack_index_compact(int argc, const char **argv,
+					const char *prefix,
+					struct repository *repo)
+{
+	struct multi_pack_index *m, *cur;
+	struct multi_pack_index *from_midx = NULL;
+	struct multi_pack_index *to_midx = NULL;
+	struct odb_source *source;
+	int ret;
+
+	struct option *options;
+	static struct option builtin_multi_pack_index_compact_options[] = {
+		OPT_BIT(0, "incremental", &opts.flags,
+			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
+		OPT_END(),
+	};
+
+	repo_config(repo, git_multi_pack_index_write_config, NULL);
+
+	options = add_common_options(builtin_multi_pack_index_compact_options);
+
+	trace2_cmd_mode(argv[0]);
+
+	if (isatty(2))
+		opts.flags |= MIDX_PROGRESS;
+	argc = parse_options(argc, argv, prefix,
+			     options, builtin_multi_pack_index_compact_usage,
+			     0);
+
+	if (argc != 2)
+		usage_with_options(builtin_multi_pack_index_compact_usage,
+				   options);
+	source = handle_object_dir_option(the_repository);
+
+	FREE_AND_NULL(options);
+
+	m = get_multi_pack_index(source);
+
+	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
+		const char *midx_csum = get_midx_checksum(cur);
+
+		if (!from_midx && !strcmp(midx_csum, argv[0]))
+			from_midx = cur;
+		if (!to_midx && !strcmp(midx_csum, argv[1]))
+			to_midx = cur;
+	}
+
+	if (!from_midx)
+		die(_("could not find MIDX 'from': %s"), argv[0]);
+	if (!to_midx)
+		die(_("could not find MIDX 'to': %s"), argv[1]);
+
+	ret = write_midx_file_compact(source, from_midx, to_midx, opts.flags);
+
+	return ret;
+}
+
 static int cmd_multi_pack_index_verify(int argc, const char **argv,
 				       const char *prefix,
 				       struct repository *repo UNUSED)
@@ -295,6 +361,7 @@ int cmd_multi_pack_index(int argc,
 	struct option builtin_multi_pack_index_options[] = {
 		OPT_SUBCOMMAND("repack", &fn, cmd_multi_pack_index_repack),
 		OPT_SUBCOMMAND("write", &fn, cmd_multi_pack_index_write),
+		OPT_SUBCOMMAND("compact", &fn, cmd_multi_pack_index_compact),
 		OPT_SUBCOMMAND("verify", &fn, cmd_multi_pack_index_verify),
 		OPT_SUBCOMMAND("expire", &fn, cmd_multi_pack_index_expire),
 		OPT_END(),
diff --git a/midx-write.c b/midx-write.c
index 7854561359d..fcbfedcd913 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -108,6 +108,10 @@ struct write_midx_context {
 	int incremental;
 	uint32_t num_multi_pack_indexes_before;
 
+	struct multi_pack_index *compact_from;
+	struct multi_pack_index *compact_to;
+	int compact;
+
 	struct string_list *to_include;
 
 	struct repository *repo;
@@ -117,6 +121,8 @@ struct write_midx_context {
 static uint32_t midx_pack_perm(struct write_midx_context *ctx,
 			       uint32_t orig_pack_int_id)
 {
+	if (ctx->compact)
+		orig_pack_int_id -= ctx->compact_from->num_packs_in_base;
 	return ctx->pack_perm[orig_pack_int_id];
 }
 
@@ -347,6 +353,21 @@ static void midx_fanout_add(struct midx_fanout *fanout,
 					    cur_fanout);
 }
 
+static void midx_fanout_add_compact(struct midx_fanout *fanout,
+				    struct write_midx_context *ctx,
+				    uint32_t cur_fanout)
+{
+	struct multi_pack_index *m = ctx->compact_to;
+
+	ASSERT(ctx->compact);
+
+	while (m && m != ctx->compact_from->base_midx) {
+		midx_fanout_add_midx_fanout(fanout, m, cur_fanout,
+					    NO_PREFERRED_PACK);
+		m = m->base_midx;
+	}
+}
+
 /*
  * It is possible to artificially get into a state where there are many
  * duplicate copies of objects. That can create high memory pressure if
@@ -365,6 +386,9 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	size_t alloc_objects, total_objects = 0;
 	struct midx_fanout fanout = { 0 };
 
+	if (ctx->compact)
+		ASSERT(!start_pack);
+
 	for (cur_pack = start_pack; cur_pack < ctx->nr; cur_pack++)
 		total_objects = st_add(total_objects,
 				       ctx->info[cur_pack].p->num_objects);
@@ -383,7 +407,10 @@ static void compute_sorted_entries(struct write_midx_context *ctx,
 	for (cur_fanout = 0; cur_fanout < 256; cur_fanout++) {
 		fanout.nr = 0;
 
-		midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
+		if (ctx->compact)
+			midx_fanout_add_compact(&fanout, ctx, cur_fanout);
+		else
+			midx_fanout_add(&fanout, ctx, start_pack, cur_fanout);
 		midx_fanout_sort(&fanout);
 
 		/*
@@ -953,6 +980,72 @@ static int fill_packs_from_midx(struct write_midx_context *ctx)
 	return 0;
 }
 
+static uint32_t compactible_packs_between(const struct multi_pack_index *from,
+					  const struct multi_pack_index *to)
+{
+	uint32_t nr;
+
+	ASSERT(from && to);
+
+	nr = u32_add(to->num_packs, to->num_packs_in_base);
+	if (nr < from->num_packs_in_base)
+		BUG("unexpected number of packs in base during compaction: "
+		    "%"PRIu32" < %"PRIu32, nr, from->num_packs_in_base);
+
+	return nr - from->num_packs_in_base;
+}
+
+static int fill_packs_from_midx_range(struct write_midx_context *ctx,
+				      int bitmap_order)
+{
+	struct multi_pack_index *m = ctx->compact_to;
+	uint32_t packs_nr;
+
+	ASSERT(ctx->compact && !ctx->nr);
+	ASSERT(ctx->compact_from);
+	ASSERT(ctx->compact_to);
+
+	packs_nr = compactible_packs_between(ctx->compact_from,
+					     ctx->compact_to);
+
+	ALLOC_GROW(ctx->info, packs_nr, ctx->alloc);
+
+	while (m != ctx->compact_from->base_midx) {
+		uint32_t pack_int_id, preferred_pack_id;
+		uint32_t i;
+
+		if (bitmap_order) {
+			if (midx_preferred_pack(m, &preferred_pack_id) < 0)
+				die(_("could not determine preferred pack"));
+		} else {
+			preferred_pack_id = m->num_packs_in_base;
+		}
+
+		pack_int_id = m->num_packs_in_base - ctx->compact_from->num_packs_in_base;
+
+		if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
+					preferred_pack_id) < 0)
+			return -1;
+
+		for (i = m->num_packs_in_base;
+		     i < m->num_packs_in_base + m->num_packs; i++) {
+			if (preferred_pack_id == i)
+				continue;
+
+			if (fill_pack_from_midx(&ctx->info[pack_int_id++], m,
+						i) < 0)
+				return -1;
+		}
+
+		ctx->nr += m->num_packs;
+		m = m->base_midx;
+	}
+
+	ASSERT(ctx->nr == packs_nr);
+
+	return 0;
+}
+
 static struct {
 	const char *non_split;
 	const char *split;
@@ -1038,12 +1131,22 @@ static void clear_midx_files(struct odb_source *source,
 	strbuf_release(&buf);
 }
 
+static int midx_hashcmp(const struct multi_pack_index *a,
+			const struct multi_pack_index *b,
+			const struct git_hash_algo *algop)
+{
+	return hashcmp(get_midx_hash(a), get_midx_hash(b), algop);
+}
+
 struct write_midx_opts {
 	struct odb_source *source;
 
 	struct string_list *packs_to_include;
 	struct string_list *packs_to_drop;
 
+	struct multi_pack_index *compact_from;
+	struct multi_pack_index *compact_to;
+
 	const char *preferred_pack_name;
 	const char *refs_snapshot;
 	unsigned flags;
@@ -1066,6 +1169,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	int dropped_packs = 0;
 	int result = -1;
 	const char **keep_hashes = NULL;
+	size_t keep_hashes_nr = 0;
 	struct chunkfile *cf;
 
 	trace2_region_enter("midx", "write_midx_internal", r);
@@ -1074,6 +1178,17 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	ctx.source = opts->source;
 
 	ctx.incremental = !!(opts->flags & MIDX_WRITE_INCREMENTAL);
+	ctx.compact = !!(opts->flags & MIDX_WRITE_COMPACT);
+
+	if (ctx.compact) {
+		if (!opts->compact_from)
+			BUG("expected non-NULL 'from' MIDX during compaction");
+		if (!opts->compact_to)
+			BUG("expected non-NULL 'to' MIDX during compaction");
+
+		ctx.compact_from = opts->compact_from;
+		ctx.compact_to = opts->compact_to;
+	}
 
 	if (ctx.incremental)
 		strbuf_addf(&midx_name,
@@ -1101,11 +1216,18 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			 */
 			if (ctx.incremental)
 				ctx.base_midx = m;
-			else if (!opts->packs_to_include)
+			if (!opts->packs_to_include)
 				ctx.m = m;
 		}
 	}
 
+	/*
+	 * If compacting MIDX layer(s) in the range [from, to], then the
+	 * compacted MIDX will share the same base MIDX as 'from'.
+	 */
+	if (ctx.compact)
+		ctx.base_midx = ctx.compact_from->base_midx;
+
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs + ctx.m->num_packs_in_base : 16;
 	ctx.info = NULL;
@@ -1122,7 +1244,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			ctx.num_multi_pack_indexes_before++;
 			m = m->base_midx;
 		}
-	} else if (ctx.m && fill_packs_from_midx(&ctx)) {
+	} else if (ctx.m && !ctx.compact && fill_packs_from_midx(&ctx)) {
 		goto cleanup;
 	}
 
@@ -1135,13 +1257,23 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	else
 		ctx.progress = NULL;
 
-	ctx.to_include = opts->packs_to_include;
+	if (ctx.compact) {
+		int bitmap_order = 0;
+		if (opts->preferred_pack_name)
+			bitmap_order |= 1;
+		else if (opts->flags & (MIDX_WRITE_REV_INDEX | MIDX_WRITE_BITMAP))
+			bitmap_order |= 1;
 
-	for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+		fill_packs_from_midx_range(&ctx, bitmap_order);
+	} else {
+		ctx.to_include = opts->packs_to_include;
+		for_each_file_in_pack_dir(opts->source->path, add_pack_to_midx, &ctx);
+	}
 	stop_progress(&ctx.progress);
 
 	if ((ctx.m && ctx.nr == ctx.m->num_packs + ctx.m->num_packs_in_base) &&
 	    !ctx.incremental &&
+	    !ctx.compact &&
 	    !(opts->packs_to_include || opts->packs_to_drop)) {
 		struct bitmap_index *bitmap_git;
 		int bitmap_exists;
@@ -1255,12 +1387,15 @@ static int write_midx_internal(struct write_midx_opts *opts)
 			ctx.large_offsets_needed = 1;
 	}
 
-	QSORT(ctx.info, ctx.nr, pack_info_compare);
+	if (!ctx.compact)
+		QSORT(ctx.info, ctx.nr, pack_info_compare);
 
 	if (opts->packs_to_drop && opts->packs_to_drop->nr) {
 		size_t drop_index = 0;
 		int missing_drops = 0;
 
+		ASSERT(!ctx.compact);
+
 		for (size_t i = 0;
 		     i < ctx.nr && drop_index < opts->packs_to_drop->nr; i++) {
 			int cmp = strcmp(ctx.info[i].pack_name,
@@ -1292,12 +1427,20 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	 */
 	ALLOC_ARRAY(ctx.pack_perm, ctx.nr);
 	for (size_t i = 0; i < ctx.nr; i++) {
+		uint32_t from = ctx.info[i].orig_pack_int_id;
+		uint32_t to;
+
 		if (ctx.info[i].expired) {
+			to = PACK_EXPIRED;
 			dropped_packs++;
-			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = PACK_EXPIRED;
 		} else {
-			ctx.pack_perm[ctx.info[i].orig_pack_int_id] = i - dropped_packs;
+			to = i - dropped_packs;
 		}
+
+		if (ctx.compact)
+			from -= ctx.compact_from->num_packs_in_base;
+
+		ctx.pack_perm[from] = to;
 	}
 
 	for (size_t i = 0; i < ctx.nr; i++) {
@@ -1445,7 +1588,24 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (ctx.num_multi_pack_indexes_before == UINT32_MAX)
 		die(_("too many multi-pack-indexes"));
 
-	CALLOC_ARRAY(keep_hashes, ctx.num_multi_pack_indexes_before + 1);
+	if (ctx.compact) {
+		struct multi_pack_index *m;
+
+		/*
+		 * Keep all MIDX layers excluding those in the range [from, to].
+		 */
+		for (m = ctx.base_midx; m; m = m->base_midx)
+			keep_hashes_nr++;
+		for (m = ctx.m;
+		     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
+		     m = m->base_midx)
+			keep_hashes_nr++;
+
+		keep_hashes_nr++; /* include the compacted layer */
+	} else {
+		keep_hashes_nr = ctx.num_multi_pack_indexes_before + 1;
+	}
+	CALLOC_ARRAY(keep_hashes, keep_hashes_nr);
 
 	if (ctx.incremental) {
 		FILE *chainf = fdopen_lock_file(&lk, "w");
@@ -1470,17 +1630,47 @@ static int write_midx_internal(struct write_midx_opts *opts)
 
 		strbuf_release(&final_midx_name);
 
-		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
+		if (ctx.compact) {
+			struct multi_pack_index *m;
+			uint32_t num_layers_before_from = 0;
+			uint32_t i;
 
-		for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
-			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
+			for (m = ctx.base_midx; m; m = m->base_midx)
+				num_layers_before_from++;
 
-			keep_hashes[j] = xstrdup(get_midx_checksum(m));
-			m = m->base_midx;
+			m = ctx.base_midx;
+			for (i = 0; i < num_layers_before_from; i++) {
+				uint32_t j = num_layers_before_from - i - 1;
+
+				keep_hashes[j] = xstrdup(get_midx_checksum(m));
+				m = m->base_midx;
+			}
+
+			keep_hashes[i] = xstrdup(hash_to_hex_algop(midx_hash,
+								   r->hash_algo));
+
+			i = 0;
+			for (m = ctx.m;
+			     m && midx_hashcmp(m, ctx.compact_to, r->hash_algo);
+			     m = m->base_midx) {
+				keep_hashes[keep_hashes_nr - i - 1] =
+					xstrdup(get_midx_checksum(m));
+				i++;
+			}
+		} else {
+			keep_hashes[ctx.num_multi_pack_indexes_before] =
+				xstrdup(hash_to_hex_algop(midx_hash,
+							  r->hash_algo));
+
+			for (uint32_t i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
+				uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
+
+				keep_hashes[j] = xstrdup(get_midx_checksum(m));
+				m = m->base_midx;
+			}
 		}
 
-		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
+		for (uint32_t i = 0; i < keep_hashes_nr; i++)
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
@@ -1493,8 +1683,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	if (commit_lock_file(&lk) < 0)
 		die_errno(_("could not write multi-pack-index"));
 
-	clear_midx_files(opts->source, keep_hashes,
-			 ctx.num_multi_pack_indexes_before + 1,
+	clear_midx_files(opts->source, keep_hashes, keep_hashes_nr,
 			 ctx.incremental);
 	result = 0;
 
@@ -1512,7 +1701,7 @@ static int write_midx_internal(struct write_midx_opts *opts)
 	free(ctx.pack_perm);
 	free(ctx.pack_order);
 	if (keep_hashes) {
-		for (uint32_t i = 0; i <= ctx.num_multi_pack_indexes_before; i++)
+		for (uint32_t i = 0; i < keep_hashes_nr; i++)
 			free((char *)keep_hashes[i]);
 		free(keep_hashes);
 	}
@@ -1553,6 +1742,21 @@ int write_midx_file_only(struct odb_source *source,
 	return write_midx_internal(&opts);
 }
 
+int write_midx_file_compact(struct odb_source *source,
+			    struct multi_pack_index *from,
+			    struct multi_pack_index *to,
+			    unsigned flags)
+{
+	struct write_midx_opts opts = {
+		.source = source,
+		.compact_from = from,
+		.compact_to = to,
+		.flags = flags | MIDX_WRITE_COMPACT,
+	};
+
+	return write_midx_internal(&opts);
+}
+
 int expire_midx_packs(struct odb_source *source, unsigned flags)
 {
 	uint32_t i, *count, result = 0;
diff --git a/midx.h b/midx.h
index 39bf04b18e5..61f9809b8c9 100644
--- a/midx.h
+++ b/midx.h
@@ -81,6 +81,7 @@ struct multi_pack_index {
 #define MIDX_WRITE_BITMAP_HASH_CACHE (1 << 3)
 #define MIDX_WRITE_BITMAP_LOOKUP_TABLE (1 << 4)
 #define MIDX_WRITE_INCREMENTAL (1 << 5)
+#define MIDX_WRITE_COMPACT (1 << 6)
 
 #define MIDX_EXT_REV "rev"
 #define MIDX_EXT_BITMAP "bitmap"
@@ -130,6 +131,10 @@ int write_midx_file_only(struct odb_source *source,
 			 struct string_list *packs_to_include,
 			 const char *preferred_pack_name,
 			 const char *refs_snapshot, unsigned flags);
+int write_midx_file_compact(struct odb_source *source,
+			    struct multi_pack_index *from,
+			    struct multi_pack_index *to,
+			    unsigned flags);
 void clear_midx_file(struct repository *r);
 int verify_midx_file(struct odb_source *source, unsigned flags);
 int expire_midx_packs(struct odb_source *source, unsigned flags);
diff --git a/t/meson.build b/t/meson.build
index 7c994d4643e..2d1926faaf2 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -613,6 +613,7 @@ integration_tests = [
   't5332-multi-pack-reuse.sh',
   't5333-pseudo-merge-bitmaps.sh',
   't5334-incremental-multi-pack-index.sh',
+  't5335-compact-multi-pack-index.sh',
   't5351-unpack-large-objects.sh',
   't5400-send-pack.sh',
   't5401-update-hooks.sh',
diff --git a/t/t5335-compact-multi-pack-index.sh b/t/t5335-compact-multi-pack-index.sh
new file mode 100755
index 00000000000..f889af7fb1d
--- /dev/null
+++ b/t/t5335-compact-multi-pack-index.sh
@@ -0,0 +1,102 @@
+#!/bin/sh
+
+test_description='multi-pack-index compaction'
+
+. ./test-lib.sh
+
+GIT_TEST_MULTI_PACK_INDEX=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
+GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
+
+objdir=.git/objects
+packdir=$objdir/pack
+midxdir=$packdir/multi-pack-index.d
+midx_chain=$midxdir/multi-pack-index-chain
+
+nth_line() {
+	local n="$1"
+	shift
+	awk "NR==$n" "$@"
+}
+
+write_packs () {
+	for c in "$@"
+	do
+		test_commit "$c" &&
+
+		git pack-objects --all --unpacked $packdir/pack-$c &&
+		git prune-packed &&
+
+		git multi-pack-index write --incremental --bitmap || return 1
+	done
+}
+
+test_midx_layer_packs () {
+	local checksum="$1" &&
+	shift &&
+
+	test-tool read-midx $objdir "$checksum" >out &&
+
+	printf "%s\n" "$@" >expect &&
+	# NOTE: do *not* pipe through sort here, we want to ensure the
+	# order of packs is preserved during compaction.
+	grep "^pack-" out | cut -d"-" -f2 >actual &&
+
+	test_cmp expect actual
+}
+
+test_midx_layer_object_uniqueness () {
+	: >objs.all
+	while read layer
+	do
+		test-tool read-midx --show-objects $objdir "$layer" >out &&
+		grep "\.pack$" out | cut -d" " -f1 | sort >objs.layer &&
+		test_stdout_line_count = 0 comm -12 objs.all objs.layer &&
+		cat objs.all objs.layer | sort >objs.tmp &&
+		mv objs.tmp objs.all || return 1
+	done <$midx_chain
+}
+
+test_expect_success 'MIDX compaction with lex-ordered pack names' '
+	git init midx-compact-lex-order &&
+	(
+		cd midx-compact-lex-order &&
+
+		write_packs A B C D E &&
+		test_line_count = 5 $midx_chain &&
+
+		git multi-pack-index compact --incremental \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 3 $midx_chain &&
+
+		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" A &&
+		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" B C D &&
+		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
+
+		test_midx_layer_object_uniqueness
+	)
+'
+
+test_expect_success 'MIDX compaction with non-lex-ordered pack names' '
+	git init midx-compact-non-lex-order &&
+	(
+		cd midx-compact-non-lex-order &&
+
+		write_packs D C A B E &&
+		test_line_count = 5 $midx_chain &&
+
+		git multi-pack-index compact --incremental \
+			"$(nth_line 2 "$midx_chain")" \
+			"$(nth_line 4 "$midx_chain")" &&
+		test_line_count = 3 $midx_chain &&
+
+		test_midx_layer_packs "$(nth_line 1 "$midx_chain")" D &&
+		test_midx_layer_packs "$(nth_line 2 "$midx_chain")" C A B &&
+		test_midx_layer_packs "$(nth_line 3 "$midx_chain")" E &&
+
+		test_midx_layer_object_uniqueness
+	)
+'
+
+test_done
-- 
2.52.0.171.gd6a4e6b6955

