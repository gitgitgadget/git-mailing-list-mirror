Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915A63C276E
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206300; cv=none; b=t4u93cDBfYlr+2P0sXzE2Kk4lGkw//2o2q/cEAMT4L6NmvrNR67TDK8jcg4coOO3UK348fAxOYG5a2wE5i3k3ZIeYrUjUt71eGqusHtb1HFlSJ5EkBDbAeNdJgT4f+97LgD7D8273T493CXVU7q1UrpVFI7yw34yPOEqYLnAjAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206300; c=relaxed/simple;
	bh=W++YRnjHG7L3v1KLFm3plnj3+QNKlD2HNYsYrYmfMlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9uRbpr7JkW0amgMhojW4oUStQHX8SAGlcou595VVmSa3UY84iCMroL50mV/G6uTuuYxkSzU5N5GHvikn2VzIvEjWtWiS2R0NaGximE78CvYyKppgQ6WUc6DeAGn1ivIOc/Ney95qaYYn7f/CBO2gYm/jqmq0vtnejHoNWFTK8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=S1I6SuVA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="S1I6SuVA"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7c04749d739so23818527b3.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206295; x=1779811095; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P+8omHkgpx2ctquayj5J8hcLQD8nUUBjgOc0uAeRu0=;
        b=S1I6SuVAM6/q889vvwDmHy5sm2f4WzPCWpOKaWubCpN/GiRXJGrd2h5zW8wf4VNTjO
         FtWXKHIKQNc7QjFZXdSQjl5ZZzu7ynQtfOMptiNOOGgS3B0sOMNicAVON2GRqG1/O7wm
         uhR3SVqaAfXsRApeCu+88mXW7lY7rrkcqkcKhnJuSSYXOex4K2C22VCPBdgU6B9cDNGV
         1mFEfQK/i0vMFXAAu5RVoM+OSryEItQk6NZshInCeZPFekSZLAU0OYIzIVRhPWn3JhNX
         s4fxfdM9Oebs9I+tQSvlBgtFyPv+zqwTQg4wu1/lvB4EuZFOIYf2MMGBGjFM1lzM6oft
         qTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206295; x=1779811095;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1P+8omHkgpx2ctquayj5J8hcLQD8nUUBjgOc0uAeRu0=;
        b=C+lElefFMDDKvVZT7HO2oBvwuVFdVZ8rh6L95lPLWFNVciKeSag35aFPjdf3C03COI
         skj0QkZnn4V7jLsFG/I/uEtO0+jyVQQ0RzxZG2BY4mCtjB55WyFIkCj0rqqULNyoy9rt
         O2f1Dv08Q6YfVN+DjLabXEPkC+N/dAvrxydmKV024nCEu+1UJj5APoaR8qkXH3+j2GYH
         h4iXBxE1MD0UityIylP6hnLQ9g8/guMoP/d6M6TLSeckdRmFjCSGD3g6R5S2LuJaOH31
         osgsFOeWHZFsEiIXKR1/vKl6UJ/5fsoiIxyzBwvWgpriQWtgdMWDUi8oowNJBC6McHwA
         Jbzw==
X-Gm-Message-State: AOJu0YzoCLRjfZKPa38h6lU/IakRlWml6VYLDGWQiFqtiyZbnYz9TW0x
	/aKVtx85UIz0UMWPDaGHk+l6s0s1cY5822eBl+1rN8hK1EF1cY8f7vron8SIxiwa5EQdE5DOFRL
	Jaur68jt4wg==
X-Gm-Gg: Acq92OGxk7zHuE0zu5dO2lTsNPdEXWXerbtqAwWBKunlcgtD39UIdrFS56MbL47I++w
	cKxCSLrcZSloCfiSVa7OVbYTvPtftqcyEHshbFt2Aj9EBIPFncSwOmn1xNrF5yYTkzaWkAewCJi
	Po4H94dskVwl7sq739D78Mi/kpSKROK9QKfpoeXOTzKPZVBh0plh9tKoj44ONkqVVQSdc24GHtJ
	FCCSi6o9ZbcyxXLCY8V6gipyJGywMAfu7ICMmOO9PsWDxv0HI5c0czX/yThyzoPYHhXnrzYAhiG
	irDe31W3NdqDELbNhcsRyOpNgE+MqVdcETZXPkfmIzW3mFJWYFuBtLJYlasklju9x5tzcWTdavD
	7Hus7GXzYlaWP2n4FTmXDRffmp8jN7+0Jb1nMVdO5119g2Bv4tAG8ljwy750wu4vfFA+Lzvoz1L
	/jPWBHKQTaqnut8dSr16l/eOFAtB70bQ68H0GR1sSwv74Kb2WoEb1a+g7DBcZ/iLPZ8ImS08lyQ
	PFVatPuBhIQfMV34Oy5Z7fQWmmkeX5mcZ4aiqUF4YhC/H2mBKyTKreDnBt4F9oa7aFEOVFRJeee
	i1HjhqQ4lHUa6zK0
X-Received: by 2002:a05:690c:6012:b0:7d0:1b14:2ccc with SMTP id 00721157ae682-7d01b143d44mr14359427b3.47.1779206294885;
        Tue, 19 May 2026 08:58:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9bc0ccf7sm39438937b3.25.2026.05.19.08.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:14 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 12/16] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <e0db62b9f10946eed38bb4925194821c699449fa.1779206240.git.me@ttaylorr.com>
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

Change the --write-midx (-m) flag from an OPT_BOOL to an OPT_CALLBACK
that accepts an optional mode argument. Introduce an enum with
REPACK_WRITE_MIDX_NONE and REPACK_WRITE_MIDX_DEFAULT to distinguish
between the two states, and update all existing boolean checks
accordingly.

For now, passing no argument (or just `-m`) selects the default mode,
preserving existing behavior. A subsequent commit will add a new mode
for writing incremental MIDXs.

Extract repack_write_midx() as a dispatcher that selects the
appropriate MIDX-writing implementation based on the mode.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 50 ++++++++++++++++++++++++++++++++++++------------
 repack-midx.c    | 14 +++++++++++++-
 repack.h         |  8 +++++++-
 3 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 24be147d39a..5d366340c34 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -97,6 +97,24 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
+static int option_parse_write_midx(const struct option *opt, const char *arg,
+				   int unset)
+{
+	enum repack_write_midx_mode *cfg = opt->value;
+
+	if (unset) {
+		*cfg = REPACK_WRITE_MIDX_NONE;
+		return 0;
+	}
+
+	if (!arg || !*arg)
+		*cfg = REPACK_WRITE_MIDX_DEFAULT;
+	else
+		return error(_("unknown value for %s: %s"), opt->long_name, arg);
+
+	return 0;
+}
+
 int cmd_repack(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -119,7 +137,7 @@ int cmd_repack(int argc,
 	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
 	struct pack_objects_args po_args = PACK_OBJECTS_ARGS_INIT;
 	struct pack_objects_args cruft_po_args = PACK_OBJECTS_ARGS_INIT;
-	int write_midx = 0;
+	enum repack_write_midx_mode write_midx = REPACK_WRITE_MIDX_NONE;
 	const char *cruft_expiration = NULL;
 	const char *expire_to = NULL;
 	const char *filter_to = NULL;
@@ -185,8 +203,14 @@ int cmd_repack(int argc,
 				N_("do not repack this pack")),
 		OPT_INTEGER('g', "geometric", &geometry.split_factor,
 			    N_("find a geometric progression with factor <N>")),
-		OPT_BOOL('m', "write-midx", &write_midx,
-			   N_("write a multi-pack index of the resulting packs")),
+		OPT_CALLBACK_F(0, "write-midx", &write_midx,
+			   N_("mode"),
+			   N_("write a multi-pack index of the resulting packs"),
+			   PARSE_OPT_OPTARG, option_parse_write_midx),
+		OPT_SET_INT_F('m', NULL, &write_midx,
+			   N_("write a multi-pack index of the resulting packs"),
+			   REPACK_WRITE_MIDX_DEFAULT,
+			   PARSE_OPT_HIDDEN),
 		OPT_STRING(0, "expire-to", &expire_to, N_("dir"),
 			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_STRING(0, "filter-to", &filter_to, N_("dir"),
@@ -221,14 +245,16 @@ int cmd_repack(int argc,
 		pack_everything |= ALL_INTO_ONE;
 
 	if (write_bitmaps < 0) {
-		if (!write_midx &&
+		if (write_midx == REPACK_WRITE_MIDX_NONE &&
 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
 			write_bitmaps = 0;
 	}
 	if (po_args.pack_kept_objects < 0)
-		po_args.pack_kept_objects = write_bitmaps > 0 && !write_midx;
+		po_args.pack_kept_objects = write_bitmaps > 0 &&
+			write_midx == REPACK_WRITE_MIDX_NONE;
 
-	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) && !write_midx)
+	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE) &&
+	    write_midx == REPACK_WRITE_MIDX_NONE)
 		die(_(incremental_bitmap_conflict_error));
 
 	if (write_bitmaps && po_args.local &&
@@ -244,7 +270,7 @@ int cmd_repack(int argc,
 		write_bitmaps = 0;
 	}
 
-	if (write_midx && write_bitmaps) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE && write_bitmaps) {
 		struct strbuf path = STRBUF_INIT;
 
 		strbuf_addf(&path, "%s/%s_XXXXXX",
@@ -297,7 +323,7 @@ int cmd_repack(int argc,
 	}
 	if (repo_has_promisor_remote(repo))
 		strvec_push(&cmd.args, "--exclude-promisor-objects");
-	if (!write_midx) {
+	if (write_midx == REPACK_WRITE_MIDX_NONE) {
 		if (write_bitmaps > 0)
 			strvec_push(&cmd.args, "--write-bitmap-index");
 		else if (write_bitmaps < 0)
@@ -519,7 +545,7 @@ int cmd_repack(int argc,
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
 		existing_packs_mark_for_deletion(&existing, &names);
 
-	if (write_midx) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE) {
 		struct repack_write_midx_opts opts = {
 			.existing = &existing,
 			.geometry = &geometry,
@@ -528,11 +554,11 @@ int cmd_repack(int argc,
 			.packdir = packdir,
 			.show_progress = show_progress,
 			.write_bitmaps = write_bitmaps > 0,
-			.midx_must_contain_cruft = midx_must_contain_cruft
+			.midx_must_contain_cruft = midx_must_contain_cruft,
+			.mode = write_midx,
 		};
 
-		ret = write_midx_included_packs(&opts);
-
+		ret = repack_write_midx(&opts);
 		if (ret)
 			goto cleanup;
 	}
diff --git a/repack-midx.c b/repack-midx.c
index 3fe83715da4..b1ca3797080 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -315,7 +315,7 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
-int write_midx_included_packs(struct repack_write_midx_opts *opts)
+static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
@@ -378,3 +378,15 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 
 	return ret;
 }
+
+int repack_write_midx(struct repack_write_midx_opts *opts)
+{
+	switch (opts->mode) {
+	case REPACK_WRITE_MIDX_NONE:
+		BUG("write_midx mode is NONE?");
+	case REPACK_WRITE_MIDX_DEFAULT:
+		return write_midx_included_packs(opts);
+	default:
+		BUG("unhandled write_midx mode: %d", opts->mode);
+	}
+}
diff --git a/repack.h b/repack.h
index 77d24ee45fb..81907fcce7f 100644
--- a/repack.h
+++ b/repack.h
@@ -134,6 +134,11 @@ void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
 
+enum repack_write_midx_mode {
+	REPACK_WRITE_MIDX_NONE,
+	REPACK_WRITE_MIDX_DEFAULT,
+};
+
 struct repack_write_midx_opts {
 	struct existing_packs *existing;
 	struct pack_geometry *geometry;
@@ -143,10 +148,11 @@ struct repack_write_midx_opts {
 	int show_progress;
 	int write_bitmaps;
 	int midx_must_contain_cruft;
+	enum repack_write_midx_mode mode;
 };
 
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
-int write_midx_included_packs(struct repack_write_midx_opts *opts);
+int repack_write_midx(struct repack_write_midx_opts *opts);
 
 int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
-- 
2.54.0.175.g8bd0ec98dc3

