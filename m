Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EB29A310
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097430; cv=none; b=TXNzzRK8YaJEL7CxNL3WHwMfH3DR5rnEFGpVJ6+zn7Fk+Wgw2P3HTrxzfEKPQkT8J2MnAxVkbEp2B1vgyBhSXXsS2XuWTsyfYXyzNYpcnRZR1XD+9Gaeda8Qlmen6RHOagOr13XMBCSi2Yh/LjwdR4LaivK5g1sR32BHFYbb8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097430; c=relaxed/simple;
	bh=C0ReIbXdjb9+sntgqTjw0d+CBH/X3w8TLyh70GW2Qys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzixqbHKpgE3NM8ZKB8vOptGwF9qlZ7rtTybdkYtMoPlf/teOqTosnd/dGrsDFI4HPhyCaLUJkh4fvwpFVo94JlIo3WDAKVPfSYf+5hBYjNWV2KaHXIcfCkwvd/YOKlPZ0n0GVClNennjQClYwWwy0VcDDyJWbw2JFCRaTDOD/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=g8sof3n/; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="g8sof3n/"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-73f20120601so40199607b3.2
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097428; x=1759702228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cFg92q+hZfhnR3CnbpBvo7fRrVVpCs3ZmqtM6WFlz8Y=;
        b=g8sof3n/cvHFxOFhpeG0S3JUjaboKrdPgQHNGTaIv2+9g13yN4Cj6oiVEjk1BdvpYj
         f6YD4yFR+OEeRjEMnD00UQi0NGnuU/bQs7DgOGhERWgFEnQTmXw6qxm/MIiWwwuddEhE
         hs8Bjck+11YPXE9qCfC/VS/3r/8B1OG/YkBrGBuONJ0Wm8VBfjGNLuXOZJextfDW/eFp
         Ss0sjcjKGFUAk3/JZIR0fd62DlqD9cue64bbAPumY1zNy/ZXPLGgZfFGk2fKkKY4uotZ
         D2YEwW3qaf0i/4bZyTaseN9QP3nH2GZzM9saXdFxsmhTQq3ZMTFid0lrgW/2PLJDuHZz
         H/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097428; x=1759702228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFg92q+hZfhnR3CnbpBvo7fRrVVpCs3ZmqtM6WFlz8Y=;
        b=u+NpMo8328eW822Vj3iEV4wN5kzZQwCWQkqrJpMcS0eo3hBmEyrT3gQlWe4lBiA3L5
         wXXvUHeajs/Bnud4khwEcSP4LUjgARNaQM/YaIkF8YWvq5S8pfmYtj8NtdjHZZ/NPwGJ
         jQkqzvPMGvwt3rrHWRuP/4+hA3Eo9yVVFv98TE2IQhs3iPKSnOjgbSs0AqCkUkKA7V1S
         hALi+vIVLjOtTdFHl32y6LiHqPoWt5az/UFNdDCSPxtXy9cgclayLzwwMA7sUyqxTimn
         d0fFqzIPizPQrZFrr2GmkhjuutckSOvDqv+toewZjRgyVGcU4FnOF4GV5xw2wj6n62vq
         Hn5w==
X-Gm-Message-State: AOJu0YzVq/YgtxtfJ4V0HN7IXPRUY9iMMR+L6TMYoQ91UE9pm21W9Wic
	WL3UY/fLieHKe94tnSAFCTvgRhHYKrz6Y8i+zCV5WHTQtpmFv230jdqPCdIOSKxa+iSexJFIPVX
	HVM4hZCY=
X-Gm-Gg: ASbGncvYuNgSCViwEmLpxuIs5cxTZRZdJE/BAwCTc9AZJs4ITx3K4yMt8BUGmBUaW+3
	gpKrtKE5d5JvrkPvhTN8YEQ8QiMTPedPKrg6x32dqeLgfk7pNAregYhh5fZPsD0jOSVWY9bBQba
	RoxoQQSoWJgYT0RjkUQA2hae1549MrpNYC9Nnl4BG7OYB4jN4OOwQgQwHgy8l0NRtU5C4uSV6vg
	NyPEoLHzlN5fzZB5/0C/E2DeUZucy/Wohpl2IGNCqCHNBc2d1STLUt4pu4zHJYRbfGAJFPZxSW2
	cPpu2L17m05OzOu/mutUBwOZzhXs8DduMq4cU/f93HAa5AsOkWjLgyLdkx2tWImUWEpf+waDJy3
	N7GBiiHG9SzDnTUa1ZdSadXuFXNHz7RWC7RFwvUubbVsmoW0DaffzXJwJw7F2d4Omv/e1pVkpf8
	DApFMTxCp4den0ux2aIL//F3ozaA==
X-Google-Smtp-Source: AGHT+IGsWrVH1GO11//jtG/m6NTQUT+t1l8aBJmqkydyAT6/KfPL6LzwQUEv1uqMJJYw/KN34JEPMw==
X-Received: by 2002:a05:690c:6087:b0:721:10a3:6584 with SMTP id 00721157ae682-763f7ce0a9cmr179630227b3.11.1759097427882;
        Sun, 28 Sep 2025 15:10:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-765be66afddsm22688917b3.30.2025.09.28.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:10:27 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:10:25 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 46/49] repack: move `pack_kept_objects` to `struct
 pack_objects_args`
Message-ID: <2d9a879bb027ef8dbd7b4ff7eccd2d038bbfb84c.1759097191.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1759097191.git.me@ttaylorr.com>

The "pack_kept_objects" variable is defined as static to the repack
builtin, but is inherently related to the pack-objects arguments that
the builtin uses when generating new packs.

Move that field into the "struct pack_objects_args", and shuffle around
where we append the corresponding command-line option when preparing a
pack-objects process. Specifically:

 - `write_cruft_pack()` always wants to pass "--honor-pack-keep", so
   explicitly set the `pack_kept_objects` field to "0" when initializing
   the `write_pack_opts` struct before calling `write_cruft_pack()`.

 - `write_filtered_pack()` no longer needs to handle writing the
   command-line option "--honor-pack-keep" when preparing a pack-objects
   process, since its call to `prepare_pack_objects()` will have already
   taken care of that.

   `write_filtered_pack()` also reads the `pack_kept_objects` field to
   determine whether to write the existing kept packs with a leading "^"
   character, so update that to read through the `po_args` pointer
   instead.

 - `cmd_repack()` also no longer has to write the "--honor-pack-keep"
   flag explicitly, since this is also handled via its call to
   `prepare_pack_objects()`.

Since there is a default value for "pack_kept_objects" that relies on
whether or not we are writing a bitmap (and not writing a MIDX), extract
a default initializer for `struct pack_objects_args` that keeps this
conditional default behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c  | 20 +++++++-------------
 repack-geometry.c |  5 ++---
 repack.c          |  2 ++
 repack.h          |  9 ++++++---
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 836a006607..9d89217b77 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -33,7 +33,6 @@
 #define RETAIN_PACK 2
 
 static int pack_everything;
-static int pack_kept_objects = -1;
 static int write_bitmaps = -1;
 static int use_delta_islands;
 static int run_update_server_info = 1;
@@ -68,7 +67,7 @@ static int repack_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "repack.packkeptobjects")) {
-		pack_kept_objects = git_config_bool(var, value);
+		po_args->pack_kept_objects = git_config_bool(var, value);
 		return 0;
 	}
 	if (!strcmp(var, "repack.writebitmaps") ||
@@ -122,8 +121,6 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 
 	strvec_push(&cmd.args, "--stdin-packs");
 
-	if (!pack_kept_objects)
-		strvec_push(&cmd.args, "--honor-pack-keep");
 	for_each_string_list_item(item, &existing->kept_packs)
 		strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
 
@@ -146,7 +143,7 @@ static int write_filtered_pack(struct write_pack_opts *opts,
 		fprintf(in, "%s.pack\n", item->string);
 	for_each_string_list_item(item, &existing->cruft_packs)
 		fprintf(in, "%s.pack\n", item->string);
-	caret = pack_kept_objects ? "" : "^";
+	caret = opts->po_args->pack_kept_objects ? "" : "^";
 	for_each_string_list_item(item, &existing->kept_packs)
 		fprintf(in, "%s%s.pack\n", caret, item->string);
 	fclose(in);
@@ -208,7 +205,6 @@ static int write_cruft_pack(struct write_pack_opts *opts,
 		strvec_pushf(&cmd.args, "--cruft-expiration=%s",
 			     cruft_expiration);
 
-	strvec_push(&cmd.args, "--honor-pack-keep");
 	strvec_push(&cmd.args, "--non-empty");
 
 	cmd.in = -1;
@@ -333,7 +329,7 @@ int cmd_repack(int argc,
 		OPT_UNSIGNED(0, "max-pack-size", &po_args.max_pack_size,
 			     N_("maximum size of each packfile")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&po_args.filter_options),
-		OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
+		OPT_BOOL(0, "pack-kept-objects", &po_args.pack_kept_objects,
 				N_("repack objects in packs marked with .keep")),
 		OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
 				N_("do not repack this pack")),
@@ -379,8 +375,8 @@ int cmd_repack(int argc,
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
 	}
-	if (pack_kept_objects < 0)
-		pack_kept_objects = write_bitmaps > 0 && !write_midx;
+	if (po_args.pack_kept_objects < 0)
+		po_args.pack_kept_objects = write_bitmaps > 0 && !write_midx;
 
 	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
 		die(_(incremental_bitmap_conflict_error));
@@ -421,8 +417,7 @@ int cmd_repack(int argc,
 	if (geometry.split_factor) {
 		if (pack_everything)
 			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
-		pack_geometry_init(&geometry, &existing, &po_args,
-				   pack_kept_objects);
+		pack_geometry_init(&geometry, &existing, &po_args);
 		pack_geometry_split(&geometry);
 	}
 
@@ -431,8 +426,6 @@ int cmd_repack(int argc,
 	show_progress = !po_args.quiet && isatty(2);
 
 	strvec_push(&cmd.args, "--keep-true-parents");
-	if (!pack_kept_objects)
-		strvec_push(&cmd.args, "--honor-pack-keep");
 	for (i = 0; i < keep_pack_list.nr; i++)
 		strvec_pushf(&cmd.args, "--keep-pack=%s",
 			     keep_pack_list.items[i].string);
@@ -577,6 +570,7 @@ int cmd_repack(int argc,
 		cruft_po_args.local = po_args.local;
 		cruft_po_args.quiet = po_args.quiet;
 		cruft_po_args.delta_base_offset = po_args.delta_base_offset;
+		cruft_po_args.pack_kept_objects = 0;
 
 		ret = write_cruft_pack(&opts, cruft_expiration,
 				       combine_cruft_below_size, &names,
diff --git a/repack-geometry.c b/repack-geometry.c
index a879f2fe49..fd4a89a115 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -26,8 +26,7 @@ static int pack_geometry_cmp(const void *va, const void *vb)
 
 void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
-			const struct pack_objects_args *args,
-			int pack_kept_objects)
+			const struct pack_objects_args *args)
 {
 	struct packfile_store *packs = existing->repo->objects->packfiles;
 	struct packed_git *p;
@@ -42,7 +41,7 @@ void pack_geometry_init(struct pack_geometry *geometry,
 			 */
 			continue;
 
-		if (!pack_kept_objects) {
+		if (!args->pack_kept_objects) {
 			/*
 			 * Any pack that has its pack_keep bit set will
 			 * appear in existing->kept_packs below, but
diff --git a/repack.c b/repack.c
index 8a0e4789fa..1982a48165 100644
--- a/repack.c
+++ b/repack.c
@@ -38,6 +38,8 @@ void prepare_pack_objects(struct child_process *cmd,
 		strvec_push(&cmd->args,  "--quiet");
 	if (args->delta_base_offset)
 		strvec_push(&cmd->args,  "--delta-base-offset");
+	if (!args->pack_kept_objects)
+		strvec_push(&cmd->args,  "--honor-pack-keep");
 	strvec_push(&cmd->args, out);
 	cmd->git_cmd = 1;
 	cmd->out = -1;
diff --git a/repack.h b/repack.h
index 9351293233..4a1c4eb606 100644
--- a/repack.h
+++ b/repack.h
@@ -17,10 +17,14 @@ struct pack_objects_args {
 	int name_hash_version;
 	int path_walk;
 	int delta_base_offset;
+	int pack_kept_objects;
 	struct list_objects_filter_options filter_options;
 };
 
-#define PACK_OBJECTS_ARGS_INIT { .delta_base_offset = 1 }
+#define PACK_OBJECTS_ARGS_INIT { \
+	.delta_base_offset = 1, \
+	.pack_kept_objects = -1, \
+}
 
 struct child_process;
 
@@ -104,8 +108,7 @@ struct pack_geometry {
 
 void pack_geometry_init(struct pack_geometry *geometry,
 			struct existing_packs *existing,
-			const struct pack_objects_args *args,
-			int pack_kept_objects);
+			const struct pack_objects_args *args);
 void pack_geometry_split(struct pack_geometry *geometry);
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry);
 void pack_geometry_remove_redundant(struct pack_geometry *geometry,
-- 
2.51.0.243.g16eca91f2c0

