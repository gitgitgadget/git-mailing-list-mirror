Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EB30FF31
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 22:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567358; cv=none; b=adGU7DRvkgIo3J+mzGpodKcbLxKJARz7GsiRQIzOjznffi3ztkc/E3NO0VCtjKcPuVXCAiCL0cGRyFZjEuKXJsbA4jyaHbqecRM2APs3VwpCkp0tKXyAohH7PJ8kOR/G8QH9uYy33BoFm2gA4kyVjb3C5lXEkLAMxRLLfoTZiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567358; c=relaxed/simple;
	bh=VwsM2gsjrX3dBJ7w5GBk2fqyueFs0X0XGlB/ht9dPf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6wfI887cWYNCZ4Z8Aeie7cNFLvFpTAUaFcgr+ajxb5AVsL8khu2KgYPogM0Ok50N6y9VbR2N74dQVtKyoVkY1iZZ1HZGnTWRAQYQ+xCpekfMSzs/HOpweAGwCQWwCaPeKrWr91u65FqBINEuuPTAstE0m7zQx+d9Qmj9ZWheTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=j2jsEWEa; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="j2jsEWEa"
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-71d5fb5e34cso933017b3.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 15:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760567355; x=1761172155; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=awkHzBdkXIjhepAq00ac7DZOuikz4etOT06LA9Nkq/c=;
        b=j2jsEWEa2rFoo8rqv+n+k1QhuaimFNllB44C+BaWgpnxw6fzefn1xcGKB+jWcim5sM
         boMQJmHC9Kz+BXs/x5EzaNvTsixHNDgh/NJfV09S+0jmd4p1GtDk+6a15CTufjJA+UEy
         EzS8k8Czfxs3OxoBDMMyWY7+DYA3hcQgKnH7gMk/Rkcd2AB/tF0ijRJRG4M5950L8P8L
         gg0r1mhutiiuuo3ipg/nx4Xrs7vnXvsM2eNO+X686EsMTpy10Bv/4waxVCfa09oHYuzZ
         VVC1Elskthvvj0QvnvyhMmYd3SnlFMVQA6+QdFgVpOhOvtjmD7cS1hOosMAly36Z+UIf
         YVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567355; x=1761172155;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awkHzBdkXIjhepAq00ac7DZOuikz4etOT06LA9Nkq/c=;
        b=etEe399P3xQbAiwWPv7pBX+ysexFhC2j6jFlbpJEYEVD8ke/ZvF5PvSnRc/4LoSq7w
         ftmxUnlYHjiEU3Y6Dv4iqwhBeed5Ym7qwKmfM+kqb9hwMUi1kVC/JBM7cyaFOS4BsnzU
         834cLgqjDwsWkRry1TJFvaNvtbfErGwjxoE+0I835giydkXaFW09VWlBR5kBHEb34uuI
         XaVN0SSj4F1aDon6F2zRgFEAPLrR/bg6+tVPdU2RgGvjxQiTy9AaFZz4KxbY2Qv7uVcV
         +tYx7ocmSbD20dl4RK5R3ltpmk3ILUeCv9qDBoWYCNLNz6No4O14GXNWvivzSGGKyAlu
         Aa8Q==
X-Gm-Message-State: AOJu0Yx+RjYS8SYCb+hQTeXqL/vDHMzmFirdJaOpFwM/wr7+hSCBwAFy
	ZKpdSA86V+g9bcWHz8JnC2KUlDwfTNo6+OqxwH1j16dFVjrwNnsewVRjtKFpxon+xXiKAatPZJe
	IXj738vN/b8t+
X-Gm-Gg: ASbGncsKFFqSKe0rnl+DVdA13zAILjfn+pQTWX44ePNid2r6/al+4s2fFpNsJMS5jXh
	LQzAD8A46lM0Ys8K4DF3nQsdBs7vsh0rY9g3j/sry/5+4kzgudo4DS3ILZd12mkoALr1f5tdLa8
	wwUeFrwD0dOKOnxo0djZMbZuquYcVuk57p6XB7O3eYIEzQ0iPQQufu2qNBkAI56t/t/f82qIklg
	vMk7Zt7HHbKGXjiNe2ymj2TxJ5PtIoR+FBitUn19407xAf89amm68xY6no3OkBWAzWws+ccgY1Z
	nIlAzAwwZ9SjxTnuwk2GeSHbSfmbLu2WacDKrr8QFQKQem1CAXJMu2jZ1TLfNawqpjUiAT7ooQN
	QAumb3ZbnEDuF3TYO01swGYaglgyO3p0bs+S1UgzqY/sjjZQI6jRV9QpfJE4Uzf3TjxzlcoTT1l
	aEx92Hw1974gO0rVOA/NO3erbHDOSxM/08lpOidyq+NfZI0PD4aHgGyuH++xz9DNViJl85sUk4g
	/24nHgwon9FNd77RQ==
X-Google-Smtp-Source: AGHT+IFIODttSW4KAu+pffMK6eC5ROJDloHoGwY9zyd9RTwsERiWbcFIZ4b66/ULgFiVQQcLj4Zk7w==
X-Received: by 2002:a0d:d304:0:b0:780:c50d:c61 with SMTP id 00721157ae682-7826a01d617mr14380367b3.18.1760567355030;
        Wed, 15 Oct 2025 15:29:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63cf52f27b9sm4261662d50.0.2025.10.15.15.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:29:14 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:29:13 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 39/49] repack: 'write_midx_included_packs' API from the
 builtin
Message-ID: <794122266d64ec8fbd21532b0ab080cdf8fc6fa7.1760567210.git.me@ttaylorr.com>
References: <cover.1759097191.git.me@ttaylorr.com>
 <cover.1760567210.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1760567210.git.me@ttaylorr.com>

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
index fad10be42a..2f49a18283 100644
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
2.51.0.540.ga7423965ad8

