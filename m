Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B6719C540
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759097393; cv=none; b=pzmh8e2ZmDBgVBs/itdEJ3qdSg3QdwvK9uttHR54nL7vMiZrc8TPPt+q2VfGNd0QlK1B81YvulDhQtwAbivymoThAL68xQSvPMw2SJ0SvCvpo302pY6yW24q3MrzsdONe0zXQuJwHqw5qpWqkv1FvXP3McYMgyruq0zKVO/OcVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759097393; c=relaxed/simple;
	bh=hkH5Jq/5dqxafT5ytYwKmKX3zkxpZy7gV3bA8u3EQvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jT+nsW9AwKjoRUSmh9UzqxhV0R5XkoTR9JF04znGj4Fq1kag5m0V8axEK4IiPe+R1r2VnKL25NllRV30YfSqzdkCPlSz3gfVWGynH3aKc8hAec8O1XDrAVbuZ+NUgYX9O1B+auz1utm3e+2xg450LlMddhl4rTBh1GeNJ3p7qLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Rk4odq8f; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Rk4odq8f"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-73b4e3d0756so49656087b3.3
        for <git@vger.kernel.org>; Sun, 28 Sep 2025 15:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759097390; x=1759702190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VyJyOlAiVWagiL9LigZAFEl+k6ZYDHgHdArSbTyqqts=;
        b=Rk4odq8fAFVVvRJkkJQIM4XfcQaFTzYbWm9+LQOZEmljZx4vy8LXMipdzXZXFMW03A
         +X+5y+kpPCctCYXOYIqDiYhvtJ3w9UZeKLcZpXhRCctL0l6/0n8fB8n4Bzj57BWcBJ3e
         kx59RKDS/KE8/jgfbBnVbETXwdUDijgdSziiLQ6SYB8jsG0HyZ9MZcFPknCTBOiI0wJJ
         p3whsc55XAG18nxlb+Bn2RfCcTOe731h5Vy8fkkEXgKMrsq8Qg8b4oyo7KBT7/p3jyUh
         TFanV6cen6uuP5mc6ekuD4xzR11kUiqxQFA0+gJ1Mg0DawxQdIB8w5CakvAbnOxogMu4
         h2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759097390; x=1759702190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyJyOlAiVWagiL9LigZAFEl+k6ZYDHgHdArSbTyqqts=;
        b=DnyyJRvOywtu1UHlkVqvkjqfRsaKtrcA/gkYUAM/HbzUD0bm8CrUBF3yzNeJ2wKYz8
         WA+E1v9hvDpRi54Ik3G+tmL42M9gfbulyym59qmhw9tou72vsGwgCZTDaUJfW4lFJxfe
         +earDAYuxj9M0bRyx9GSYL378F/3ZGnDtoPnqsiPo2donvvm0LFJeWTYTzcBYYE0Rw3t
         kuhOdTvYGeeMeWJoMgkMRWQC92TgJMaE5uWh+qefx7H5gXSLtAFHZk1XegVM46uE0Jd2
         YAzCnwbaw+gXQqKdMASzoN8BmKFsgbQfX1hnoPZVXKPKnfkW4qigtI9DfPi6FBfjFutk
         LZCw==
X-Gm-Message-State: AOJu0YwlvOj3jXiOdtyZ5NdRGa1ovEmDFYAEMWXlI6lKuwQBLBImFGFp
	gwGXgizZ1oRlTrPWOUI8GHmvu4RcF3LBT6ITG1z610soQH0K1/Ug25ze9OtpC3kRd/ofjh/8wId
	qbUX6ClytptLd
X-Gm-Gg: ASbGncs97EdQtpG3SZmf7fWKyGeI+Z7xsWnXuKB5rAU3gZiRyffIQYh94gfcIENMXWV
	zK/fjsqB1+6z7okvohWZsXJJede9hG3mStEOhW5VFcMhgO7I7wfTphAFXf/G9WEVtILv2VeEY5t
	yPifBPJPqnA1l3M7/hNfpoqGlzS3ntN5uRfcNuZHJMYd3VtZomw2l2wjwf8rNC21IZ9I5KYYWQ4
	JUhT2u6m1xxNKAuaO8rWF6Uneneco71R3ApfhZteQfo5Hlt4589vEfMvfu4tU3Wl+0ISkIn2/gF
	7k7hfl5kk9iGVC/USVIhQUcXHvRYq/2/W5unXjrnwm4GHbpCJBPOprwjyiWysGt+k6esESkNSDB
	8yOBRvYH0fvGCdK76MRCh9l9FrUto4asFcTH4czeo6LLk/NJwL/Fg7RDWl56CS26DaBJwLy//7n
	iYSCwg33DORLsSiqeVDqxI04DsHQ==
X-Google-Smtp-Source: AGHT+IH4yCQ2HmfTX0dJ1BzK6EBx+CTtmK2VcvBMYrnt1o2wcqv3zmMOrhanORpfTcfGveBGlKCBoA==
X-Received: by 2002:a05:690c:12:b0:71e:257d:11ff with SMTP id 00721157ae682-763fe753f61mr158080707b3.23.1759097389520;
        Sun, 28 Sep 2025 15:09:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-775cca6c31csm7889507b3.20.2025.09.28.15.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 15:09:49 -0700 (PDT)
Date: Sun, 28 Sep 2025 18:09:46 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 39/49] repack: 'write_midx_included_packs' API from the
 builtin
Message-ID: <c28891443bba0b2b84c44d8968cd1ca1710c99ab.1759097191.git.me@ttaylorr.com>
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

Now that we have sufficiently cleaned up the write_midx_included_packs()
function, we can move it (along with the struct repack_write_midx_opts)
out of the builtin, and into the repack.h header.

Since this function (and the static ones that it depends on) are
MIDX-specific details of the repacking process, move them to the
repack-midx.c compilation unit instead of the general repack.c one.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 305 -----------------------------------------------
 repack-midx.c    | 295 +++++++++++++++++++++++++++++++++++++++++++++
 repack.h         |  12 ++
 3 files changed, 307 insertions(+), 305 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index e2acba6312..5fed79e826 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -107,311 +107,6 @@ static int repack_config(const char *var, const char *value,
 	return git_default_config(var, value, ctx, cb);
 }
 
-struct repack_write_midx_opts {
-	struct existing_packs *existing;
-	struct pack_geometry *geometry;
-	struct string_list *names;
-	const char *refs_snapshot;
-	const char *packdir;
-	int show_progress;
-	int write_bitmaps;
-	int midx_must_contain_cruft;
-};
-
-static int midx_has_unknown_packs(struct string_list *include,
-				  struct pack_geometry *geometry,
-				  struct existing_packs *existing)
-{
-	struct string_list_item *item;
-
-	string_list_sort(include);
-
-	for_each_string_list_item(item, &existing->midx_packs) {
-		const char *pack_name = item->string;
-
-		/*
-		 * Determine whether or not each MIDX'd pack from the existing
-		 * MIDX (if any) is represented in the new MIDX. For each pack
-		 * in the MIDX, it must either be:
-		 *
-		 *  - In the "include" list of packs to be included in the new
-		 *    MIDX. Note this function is called before the include
-		 *    list is populated with any cruft pack(s).
-		 *
-		 *  - Below the geometric split line (if using pack geometry),
-		 *    indicating that the pack won't be included in the new
-		 *    MIDX, but its contents were rolled up as part of the
-		 *    geometric repack.
-		 *
-		 *  - In the existing non-kept packs list (if not using pack
-		 *    geometry), and marked as non-deleted.
-		 */
-		if (string_list_has_string(include, pack_name)) {
-			continue;
-		} else if (geometry) {
-			struct strbuf buf = STRBUF_INIT;
-			uint32_t j;
-
-			for (j = 0; j < geometry->split; j++) {
-				strbuf_reset(&buf);
-				strbuf_addstr(&buf, pack_basename(geometry->pack[j]));
-				strbuf_strip_suffix(&buf, ".pack");
-				strbuf_addstr(&buf, ".idx");
-
-				if (!strcmp(pack_name, buf.buf)) {
-					strbuf_release(&buf);
-					break;
-				}
-			}
-
-			strbuf_release(&buf);
-
-			if (j < geometry->split)
-				continue;
-		} else {
-			struct string_list_item *item;
-
-			item = string_list_lookup(&existing->non_kept_packs,
-						  pack_name);
-			if (item && !existing_pack_is_marked_for_deletion(item))
-				continue;
-		}
-
-		/*
-		 * If we got to this point, the MIDX includes some pack that we
-		 * don't know about.
-		 */
-		return 1;
-	}
-
-	return 0;
-}
-
-static void midx_included_packs(struct string_list *include,
-				struct repack_write_midx_opts *opts)
-{
-	struct existing_packs *existing = opts->existing;
-	struct pack_geometry *geometry = opts->geometry;
-	struct string_list *names = opts->names;
-	struct string_list_item *item;
-	struct strbuf buf = STRBUF_INIT;
-
-	for_each_string_list_item(item, &existing->kept_packs) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "%s.idx", item->string);
-		string_list_insert(include, buf.buf);
-	}
-
-	for_each_string_list_item(item, names) {
-		strbuf_reset(&buf);
-		strbuf_addf(&buf, "pack-%s.idx", item->string);
-		string_list_insert(include, buf.buf);
-	}
-
-	if (geometry->split_factor) {
-		uint32_t i;
-
-		for (i = geometry->split; i < geometry->pack_nr; i++) {
-			struct packed_git *p = geometry->pack[i];
-
-			/*
-			 * The multi-pack index never refers to packfiles part
-			 * of an alternate object database, so we skip these.
-			 * While git-multi-pack-index(1) would silently ignore
-			 * them anyway, this allows us to skip executing the
-			 * command completely when we have only non-local
-			 * packfiles.
-			 */
-			if (!p->pack_local)
-				continue;
-
-			strbuf_reset(&buf);
-			strbuf_addstr(&buf, pack_basename(p));
-			strbuf_strip_suffix(&buf, ".pack");
-			strbuf_addstr(&buf, ".idx");
-
-			string_list_insert(include, buf.buf);
-		}
-	} else {
-		for_each_string_list_item(item, &existing->non_kept_packs) {
-			if (existing_pack_is_marked_for_deletion(item))
-				continue;
-
-			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s.idx", item->string);
-			string_list_insert(include, buf.buf);
-		}
-	}
-
-	if (opts->midx_must_contain_cruft ||
-	    midx_has_unknown_packs(include, geometry, existing)) {
-		/*
-		 * If there are one or more unknown pack(s) present (see
-		 * midx_has_unknown_packs() for what makes a pack
-		 * "unknown") in the MIDX before the repack, keep them
-		 * as they may be required to form a reachability
-		 * closure if the MIDX is bitmapped.
-		 *
-		 * For example, a cruft pack can be required to form a
-		 * reachability closure if the MIDX is bitmapped and one
-		 * or more of the bitmap's selected commits reaches a
-		 * once-cruft object that was later made reachable.
-		 */
-		for_each_string_list_item(item, &existing->cruft_packs) {
-			/*
-			 * When doing a --geometric repack, there is no
-			 * need to check for deleted packs, since we're
-			 * by definition not doing an ALL_INTO_ONE
-			 * repack (hence no packs will be deleted).
-			 * Otherwise we must check for and exclude any
-			 * packs which are enqueued for deletion.
-			 *
-			 * So we could omit the conditional below in the
-			 * --geometric case, but doing so is unnecessary
-			 *  since no packs are marked as pending
-			 *  deletion (since we only call
-			 *  `existing_packs_mark_for_deletion()` when
-			 *  doing an all-into-one repack).
-			 */
-			if (existing_pack_is_marked_for_deletion(item))
-				continue;
-
-			strbuf_reset(&buf);
-			strbuf_addf(&buf, "%s.idx", item->string);
-			string_list_insert(include, buf.buf);
-		}
-	} else {
-		/*
-		 * Modern versions of Git (with the appropriate
-		 * configuration setting) will write new copies of
-		 * once-cruft objects when doing a --geometric repack.
-		 *
-		 * If the MIDX has no cruft pack, new packs written
-		 * during a --geometric repack will not rely on the
-		 * cruft pack to form a reachability closure, so we can
-		 * avoid including them in the MIDX in that case.
-		 */
-		;
-	}
-
-	strbuf_release(&buf);
-}
-
-static void remove_redundant_bitmaps(struct string_list *include,
-				     const char *packdir)
-{
-	struct strbuf path = STRBUF_INIT;
-	struct string_list_item *item;
-	size_t packdir_len;
-
-	strbuf_addstr(&path, packdir);
-	strbuf_addch(&path, '/');
-	packdir_len = path.len;
-
-	/*
-	 * Remove any pack bitmaps corresponding to packs which are now
-	 * included in the MIDX.
-	 */
-	for_each_string_list_item(item, include) {
-		strbuf_addstr(&path, item->string);
-		strbuf_strip_suffix(&path, ".idx");
-		strbuf_addstr(&path, ".bitmap");
-
-		if (unlink(path.buf) && errno != ENOENT)
-			warning_errno(_("could not remove stale bitmap: %s"),
-				      path.buf);
-
-		strbuf_setlen(&path, packdir_len);
-	}
-	strbuf_release(&path);
-}
-
-static int write_midx_included_packs(struct repack_write_midx_opts *opts)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct string_list include = STRING_LIST_INIT_DUP;
-	struct string_list_item *item;
-	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
-	FILE *in;
-	int ret = 0;
-
-	midx_included_packs(&include, opts);
-	if (!include.nr)
-		goto done;
-
-	cmd.in = -1;
-	cmd.git_cmd = 1;
-
-	strvec_push(&cmd.args, "multi-pack-index");
-	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
-
-	if (opts->show_progress)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "--no-progress");
-
-	if (opts->write_bitmaps)
-		strvec_push(&cmd.args, "--bitmap");
-
-	if (preferred)
-		strvec_pushf(&cmd.args, "--preferred-pack=%s",
-			     pack_basename(preferred));
-	else if (opts->names->nr) {
-		/* The largest pack was repacked, meaning that either
-		 * one or two packs exist depending on whether the
-		 * repository has a cruft pack or not.
-		 *
-		 * Select the non-cruft one as preferred to encourage
-		 * pack-reuse among packs containing reachable objects
-		 * over unreachable ones.
-		 *
-		 * (Note we could write multiple packs here if
-		 * `--max-pack-size` was given, but any one of them
-		 * will suffice, so pick the first one.)
-		 */
-		for_each_string_list_item(item, opts->names) {
-			struct generated_pack *pack = item->util;
-			if (generated_pack_has_ext(pack, ".mtimes"))
-				continue;
-
-			strvec_pushf(&cmd.args, "--preferred-pack=pack-%s.pack",
-				     item->string);
-			break;
-		}
-	} else {
-		/*
-		 * No packs were kept, and no packs were written. The
-		 * only thing remaining are .keep packs (unless
-		 * --pack-kept-objects was given).
-		 *
-		 * Set the `--preferred-pack` arbitrarily here.
-		 */
-		;
-	}
-
-	if (opts->refs_snapshot)
-		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
-			     opts->refs_snapshot);
-
-	ret = start_command(&cmd);
-	if (ret)
-		goto done;
-
-	in = xfdopen(cmd.in, "w");
-	for_each_string_list_item(item, &include)
-		fprintf(in, "%s\n", item->string);
-	fclose(in);
-
-	ret = finish_command(&cmd);
-done:
-	if (!ret && opts->write_bitmaps)
-		remove_redundant_bitmaps(&include, opts->packdir);
-
-	string_list_clear(&include, 0);
-
-	return ret;
-}
-
 static int finish_pack_objects_cmd(const struct git_hash_algo *algop,
 				   struct child_process *cmd,
 				   struct string_list *names,
diff --git a/repack-midx.c b/repack-midx.c
index 354df729a5..6f6202c5bc 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -6,6 +6,7 @@
 #include "oidset.h"
 #include "pack-bitmap.h"
 #include "refs.h"
+#include "run-command.h"
 #include "tempfile.h"
 
 struct midx_snapshot_ref_data {
@@ -75,3 +76,297 @@ void midx_snapshot_refs(struct repository *repo, struct tempfile *f)
 
 	oidset_clear(&data.seen);
 }
+
+static int midx_has_unknown_packs(struct string_list *include,
+				  struct pack_geometry *geometry,
+				  struct existing_packs *existing)
+{
+	struct string_list_item *item;
+
+	string_list_sort(include);
+
+	for_each_string_list_item(item, &existing->midx_packs) {
+		const char *pack_name = item->string;
+
+		/*
+		 * Determine whether or not each MIDX'd pack from the existing
+		 * MIDX (if any) is represented in the new MIDX. For each pack
+		 * in the MIDX, it must either be:
+		 *
+		 *  - In the "include" list of packs to be included in the new
+		 *    MIDX. Note this function is called before the include
+		 *    list is populated with any cruft pack(s).
+		 *
+		 *  - Below the geometric split line (if using pack geometry),
+		 *    indicating that the pack won't be included in the new
+		 *    MIDX, but its contents were rolled up as part of the
+		 *    geometric repack.
+		 *
+		 *  - In the existing non-kept packs list (if not using pack
+		 *    geometry), and marked as non-deleted.
+		 */
+		if (string_list_has_string(include, pack_name)) {
+			continue;
+		} else if (geometry) {
+			struct strbuf buf = STRBUF_INIT;
+			uint32_t j;
+
+			for (j = 0; j < geometry->split; j++) {
+				strbuf_reset(&buf);
+				strbuf_addstr(&buf, pack_basename(geometry->pack[j]));
+				strbuf_strip_suffix(&buf, ".pack");
+				strbuf_addstr(&buf, ".idx");
+
+				if (!strcmp(pack_name, buf.buf)) {
+					strbuf_release(&buf);
+					break;
+				}
+			}
+
+			strbuf_release(&buf);
+
+			if (j < geometry->split)
+				continue;
+		} else {
+			struct string_list_item *item;
+
+			item = string_list_lookup(&existing->non_kept_packs,
+						  pack_name);
+			if (item && !existing_pack_is_marked_for_deletion(item))
+				continue;
+		}
+
+		/*
+		 * If we got to this point, the MIDX includes some pack that we
+		 * don't know about.
+		 */
+		return 1;
+	}
+
+	return 0;
+}
+
+static void midx_included_packs(struct string_list *include,
+				struct repack_write_midx_opts *opts)
+{
+	struct existing_packs *existing = opts->existing;
+	struct pack_geometry *geometry = opts->geometry;
+	struct string_list *names = opts->names;
+	struct string_list_item *item;
+	struct strbuf buf = STRBUF_INIT;
+
+	for_each_string_list_item(item, &existing->kept_packs) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
+
+	for_each_string_list_item(item, names) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "pack-%s.idx", item->string);
+		string_list_insert(include, buf.buf);
+	}
+
+	if (geometry->split_factor) {
+		uint32_t i;
+
+		for (i = geometry->split; i < geometry->pack_nr; i++) {
+			struct packed_git *p = geometry->pack[i];
+
+			/*
+			 * The multi-pack index never refers to packfiles part
+			 * of an alternate object database, so we skip these.
+			 * While git-multi-pack-index(1) would silently ignore
+			 * them anyway, this allows us to skip executing the
+			 * command completely when we have only non-local
+			 * packfiles.
+			 */
+			if (!p->pack_local)
+				continue;
+
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, pack_basename(p));
+			strbuf_strip_suffix(&buf, ".pack");
+			strbuf_addstr(&buf, ".idx");
+
+			string_list_insert(include, buf.buf);
+		}
+	} else {
+		for_each_string_list_item(item, &existing->non_kept_packs) {
+			if (existing_pack_is_marked_for_deletion(item))
+				continue;
+
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
+		}
+	}
+
+	if (opts->midx_must_contain_cruft ||
+	    midx_has_unknown_packs(include, geometry, existing)) {
+		/*
+		 * If there are one or more unknown pack(s) present (see
+		 * midx_has_unknown_packs() for what makes a pack
+		 * "unknown") in the MIDX before the repack, keep them
+		 * as they may be required to form a reachability
+		 * closure if the MIDX is bitmapped.
+		 *
+		 * For example, a cruft pack can be required to form a
+		 * reachability closure if the MIDX is bitmapped and one
+		 * or more of the bitmap's selected commits reaches a
+		 * once-cruft object that was later made reachable.
+		 */
+		for_each_string_list_item(item, &existing->cruft_packs) {
+			/*
+			 * When doing a --geometric repack, there is no
+			 * need to check for deleted packs, since we're
+			 * by definition not doing an ALL_INTO_ONE
+			 * repack (hence no packs will be deleted).
+			 * Otherwise we must check for and exclude any
+			 * packs which are enqueued for deletion.
+			 *
+			 * So we could omit the conditional below in the
+			 * --geometric case, but doing so is unnecessary
+			 *  since no packs are marked as pending
+			 *  deletion (since we only call
+			 *  `existing_packs_mark_for_deletion()` when
+			 *  doing an all-into-one repack).
+			 */
+			if (existing_pack_is_marked_for_deletion(item))
+				continue;
+
+			strbuf_reset(&buf);
+			strbuf_addf(&buf, "%s.idx", item->string);
+			string_list_insert(include, buf.buf);
+		}
+	} else {
+		/*
+		 * Modern versions of Git (with the appropriate
+		 * configuration setting) will write new copies of
+		 * once-cruft objects when doing a --geometric repack.
+		 *
+		 * If the MIDX has no cruft pack, new packs written
+		 * during a --geometric repack will not rely on the
+		 * cruft pack to form a reachability closure, so we can
+		 * avoid including them in the MIDX in that case.
+		 */
+		;
+	}
+
+	strbuf_release(&buf);
+}
+
+static void remove_redundant_bitmaps(struct string_list *include,
+				     const char *packdir)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct string_list_item *item;
+	size_t packdir_len;
+
+	strbuf_addstr(&path, packdir);
+	strbuf_addch(&path, '/');
+	packdir_len = path.len;
+
+	/*
+	 * Remove any pack bitmaps corresponding to packs which are now
+	 * included in the MIDX.
+	 */
+	for_each_string_list_item(item, include) {
+		strbuf_addstr(&path, item->string);
+		strbuf_strip_suffix(&path, ".idx");
+		strbuf_addstr(&path, ".bitmap");
+
+		if (unlink(path.buf) && errno != ENOENT)
+			warning_errno(_("could not remove stale bitmap: %s"),
+				      path.buf);
+
+		strbuf_setlen(&path, packdir_len);
+	}
+	strbuf_release(&path);
+}
+
+int write_midx_included_packs(struct repack_write_midx_opts *opts)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct string_list include = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
+	struct packed_git *preferred = pack_geometry_preferred_pack(opts->geometry);
+	FILE *in;
+	int ret = 0;
+
+	midx_included_packs(&include, opts);
+	if (!include.nr)
+		goto done;
+
+	cmd.in = -1;
+	cmd.git_cmd = 1;
+
+	strvec_push(&cmd.args, "multi-pack-index");
+	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
+
+	if (opts->show_progress)
+		strvec_push(&cmd.args, "--progress");
+	else
+		strvec_push(&cmd.args, "--no-progress");
+
+	if (opts->write_bitmaps)
+		strvec_push(&cmd.args, "--bitmap");
+
+	if (preferred)
+		strvec_pushf(&cmd.args, "--preferred-pack=%s",
+			     pack_basename(preferred));
+	else if (opts->names->nr) {
+		/* The largest pack was repacked, meaning that either
+		 * one or two packs exist depending on whether the
+		 * repository has a cruft pack or not.
+		 *
+		 * Select the non-cruft one as preferred to encourage
+		 * pack-reuse among packs containing reachable objects
+		 * over unreachable ones.
+		 *
+		 * (Note we could write multiple packs here if
+		 * `--max-pack-size` was given, but any one of them
+		 * will suffice, so pick the first one.)
+		 */
+		for_each_string_list_item(item, opts->names) {
+			struct generated_pack *pack = item->util;
+			if (generated_pack_has_ext(pack, ".mtimes"))
+				continue;
+
+			strvec_pushf(&cmd.args, "--preferred-pack=pack-%s.pack",
+				     item->string);
+			break;
+		}
+	} else {
+		/*
+		 * No packs were kept, and no packs were written. The
+		 * only thing remaining are .keep packs (unless
+		 * --pack-kept-objects was given).
+		 *
+		 * Set the `--preferred-pack` arbitrarily here.
+		 */
+		;
+	}
+
+	if (opts->refs_snapshot)
+		strvec_pushf(&cmd.args, "--refs-snapshot=%s",
+			     opts->refs_snapshot);
+
+	ret = start_command(&cmd);
+	if (ret)
+		goto done;
+
+	in = xfdopen(cmd.in, "w");
+	for_each_string_list_item(item, &include)
+		fprintf(in, "%s\n", item->string);
+	fclose(in);
+
+	ret = finish_command(&cmd);
+done:
+	if (!ret && opts->write_bitmaps)
+		remove_redundant_bitmaps(&include, opts->packdir);
+
+	string_list_clear(&include, 0);
+
+	return ret;
+}
diff --git a/repack.h b/repack.h
index 6aa5b4e0f0..25a31ac0a0 100644
--- a/repack.h
+++ b/repack.h
@@ -101,6 +101,18 @@ void pack_geometry_release(struct pack_geometry *geometry);
 
 struct tempfile;
 
+struct repack_write_midx_opts {
+	struct existing_packs *existing;
+	struct pack_geometry *geometry;
+	struct string_list *names;
+	const char *refs_snapshot;
+	const char *packdir;
+	int show_progress;
+	int write_bitmaps;
+	int midx_must_contain_cruft;
+};
+
 void midx_snapshot_refs(struct repository *repo, struct tempfile *f);
+int write_midx_included_packs(struct repack_write_midx_opts *opts);
 
 #endif /* REPACK_H */
-- 
2.51.0.243.g16eca91f2c0

