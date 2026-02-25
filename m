Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70381381AF
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 00:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771978916; cv=none; b=faOJZn08SIJXaTCbaSXrFthxLu0+fwhOZKyMo0lAJetoJ6kTk6YagRNm+WrBzH/s+GKzA0YbLrGeqeRwwLzj4SaHs+j+ogOlxc9Tep6LV4O/KzZ7Y1zqtkF3qrP2s/q47rSjSGRH14W4Fd83v3KJaIR1I0gLov35vmKPF+SnPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771978916; c=relaxed/simple;
	bh=xb7ag53QzBVpORh232RwP2XzJFQ+1XWY2dlGp1VJUFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRDV++rtpyGunrN2NL0bcbr9+2bgq0nuE8/MOctvo8ZI/oHpWreKgdUmosJ97aBJ/VIX7LLvZge7ORKQdhojz9J9ow0CqrogCe5px4LjhEUdr1OthVDhQnZ28pTmeQmc6aqqWmmwF5KVXmypgl+1qyU0AEmiLFchQfPLgbphyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=CU0G+hM4; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="CU0G+hM4"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb3825b0fbso596097185a.0
        for <git@vger.kernel.org>; Tue, 24 Feb 2026 16:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1771978914; x=1772583714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk3xCLZ5CIsojxs+2Smfw9+t3LZJm+4SUwBcbLaYJTs=;
        b=CU0G+hM4SmyDxnGaftBmHUBncc050FXnuELFLkVUcncgH34gF5rjT7GERIwwQ9vhAO
         dVvcsgqXSmoa55+uzO+S8lqfwI03hI0uyFSt6U2juCsIs8k03o5SwuCEzhZRrE0jrAgb
         pVFRg5gv3DyUK4ze20iEntCfKy3oRkKKrfELh9ihHG5NYL+4DQbGIczesw9i9VtR/l4h
         JOHRsrEZNIoiYOBKbrvw7VdbD+l0MnJhp1/a+Trlw7dQjfFzvV/GNRHbpsuBfhCnuZuH
         /9L12mayVEzwRiMDqirX7l6yND9bBEJk9gcoX2UDwZWL6QSeoy/BBBTn2keaVsZZ9Ji5
         gQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771978914; x=1772583714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nk3xCLZ5CIsojxs+2Smfw9+t3LZJm+4SUwBcbLaYJTs=;
        b=bwURJI0P1OpnqVsSedwnkhnyTD6BNjjimfslTnReciKUQ9IXXb2o4dn0i8syBeOZrl
         VjtUVeuUfTCIploiveOaXf4q9sY+JpcWKkwUmhHN+TVejlIpPtrC+oQ5GcZNeLN+qaO9
         h2Ea3wJKxRtHl2WGa2gEZj8aFuEjpVOoHZtOwgvWDWAR/yw/WmPuq/AWon1FqGcqdCgL
         zf/yR5ms6DfDJ5mYv/oluTYipXv9DCcZ397VRdmcBCDd3db3aJtj+8hNBgwHWlyPts3d
         vCXvLyu+IiMauc8eZFyvK7omyvFBbrQ4RnlWCaftSWU9p/x9nghxB/2YYM7GzBuiQ8N6
         DdJw==
X-Gm-Message-State: AOJu0YxDAA3JdzkpbsS0DDE4RuK5/mhPj66KSm86UauG4YQpFSbqitvV
	dbTarQcAoqKJ2m+q6w6o6YyWose67SSQENeIBSoCD80bEKhPXp77S/FBL3NfIGJyXmBYxwIMhvA
	7lB+PAMhzZA==
X-Gm-Gg: ATEYQzz++aU7cTjlYqzcLnuc+3Fn8pCADXjp4yFea6dfwkTv3wufXcP/pktxt14RrXj
	9UfBsbBtw86C2SN+9K/7vdC6S1N0clcv1WiFl4Dhv5Iti5TJYd2RDBHvcgCWjqRI19Tu1n0jjDB
	lEnIz0P4887Q9ZEcPFbwyGwf4tBYNgfc/2apNSeRFur3hhetFWuVfRC6LhTqqP7oQcYMlN7H4yu
	pdaCihgkvJ04QUbtXOJrBEXlvssv73u7n6zhHKbyERJ8v86TpKNZZt23f/24I6cTdSe34BDO21z
	L3Mrzqz5Ef7WeGob3/TiLPj+3ZfZ7OzCNn1X0UnhrKV1HhWRH0SYcpptkaLNDJkLU+fIHVzL5W3
	FMk+nT2V9XS2xuPQ/zSvf3hL85lui0y9f6WmEV9CuyL9AQg62QNlHqnRTDHZpN5rXx/TIvmnGl0
	cYCz1oDPKKtu9cDoE8CMj6YVFZo/2lWn+Lp+ITNDBlibHg3vvovIJeQDo+gCnlA14BKXWh8j8B5
	rctHQEx6GHi5bYll/BhgE2JWzdIgw==
X-Received: by 2002:a05:620a:2845:b0:89f:5f63:68eb with SMTP id af79cd13be357-8cb8c9e6891mr1832539485a.13.1771978914221;
        Tue, 24 Feb 2026 16:21:54 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb8d064007sm1314284785a.19.2026.02.24.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 16:21:53 -0800 (PST)
Date: Tue, 24 Feb 2026 19:21:51 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH 11/14] builtin/repack.c: convert `--write-midx` to an
 `OPT_CALLBACK`
Message-ID: <a234852eba45cbd988f44c676e0d9e63b27de7e5.1771978829.git.me@ttaylorr.com>
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
index 44a95b56f23..3a5042491d6 100644
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
@@ -504,7 +530,7 @@ int cmd_repack(int argc,
 	if (delete_redundant && pack_everything & ALL_INTO_ONE)
 		existing_packs_mark_for_deletion(&existing, &names);
 
-	if (write_midx) {
+	if (write_midx != REPACK_WRITE_MIDX_NONE) {
 		struct repack_write_midx_opts opts = {
 			.existing = &existing,
 			.geometry = &geometry,
@@ -513,11 +539,11 @@ int cmd_repack(int argc,
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
index bc5059927f7..6c28d9acef6 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -323,7 +323,7 @@ static int repack_fill_midx_stdin_packs(struct child_process *cmd,
 	return finish_command(cmd);
 }
 
-int write_midx_included_packs(struct repack_write_midx_opts *opts)
+static int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list include = STRING_LIST_INIT_DUP;
@@ -386,3 +386,15 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 
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
2.53.0.185.g29bc4dff628

