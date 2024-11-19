Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872261CF7C7
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732031133; cv=none; b=Tz6N3FfCFpV+c6cKL2vGB5e4lYn3nGB6e/p7FDEz3rBgukl9hWGfLJvAUkHbAXBO54I7PZMpsaijxuyLC4wEAub14McLzpKD2J/UoUZZMfPDcZwuJuujfKW+QCQlqqbOriDtSVFE25+T+q8HhC1d5pri75jWoB/y/3RljcuZ1fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732031133; c=relaxed/simple;
	bh=B12hGd6i9QWug35sLpT941ZcQmmggVfeXbG1Owv1U74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uuaCXJWFu+GiKNrKMSu8UIBDYcjLa82vQ8Ao+wFRl7hwnvxGczsnsAJ9AISYJfECX4C+x645vmTU7M5C+IUyj4XbxUR8g8EYIVcGsz7BtjW73x8pHDGii0H1BCcrfT6kIWaEKzP1VX0XF2s1jPYyp6rI7atEUR1o/Jl50Qgf0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuneiaUI; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuneiaUI"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ff3232ee75so12813691fa.0
        for <git@vger.kernel.org>; Tue, 19 Nov 2024 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732031126; x=1732635926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7qFaL325BLK6UsmoH5bv64smidErvBPS90PwORCttv4=;
        b=YuneiaUIDpsPrNhtXr/ZP8VJOICjdXZbLMPLB0184YxXpRo2PoheZourrEVM58sP2p
         Wl7GeSc8X5mc1GiBnap9MOkJIiKrTZo84YA+L3pf2AZ3Oi87+G6Bux/o5epnP1YflaqS
         b/w062ArG0H+aPHijgoAPhahx0jYtFm+Tg2HX3R6GzBrEf+FnuDwI3FiQ4BX2DMJarLb
         k3ktnuqPQSvHxxcndW0utxO7T1rCf0WeKDbIYKKvWfDlELl6qcw3K9BiKGBLO4LdeASf
         i/OJDZsb2VxeDVTMZJyz+/bQ+kavwm8CnRJ2XJ0S8Hti9uCOTD7iKEe01pVM4Ib08I9w
         npdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732031126; x=1732635926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qFaL325BLK6UsmoH5bv64smidErvBPS90PwORCttv4=;
        b=AbCOeJWcHsgql4LP3dRDJRFMXX3G+JaAvLcheRluqB9QSukLFeyFTz8kZa2CVJKkqn
         5pYEpC4tAAlyWE+b+B5fKJsEql/2QIM6Fj1c8+4gLR/j9K8m8QX7F+djvQpKCbKhPvOD
         KxMwTld1ELMXTTRSceV/wBLrvmhK5l3pJiYlX6kxkBffjrC7NHOT88plXxvqwXsOGaVM
         4l/ZWschajHvfVGRgjeSy2Lot0PdP2J1FxVDwRsTU5VfRSzupbCFzANAXNHkBrk0naaX
         lYJz/NT8vwbjhtI230k/GfiwrwQiSC8pYUpRLF8TLw0ncG4HvVtK13z19s9ox/GLTJmT
         VoHQ==
X-Gm-Message-State: AOJu0Yx616Ak2TT9zgNWPvWvI+N02TExKR5owRKj41INNNFolm5P81Iq
	mZT2nF0tWbswhljwDch61ktO/xtu6RJIaLSrqVFPrcdLQXqBg6+S8XgeUdAT
X-Google-Smtp-Source: AGHT+IHIv172quwxQExX9gJyIk9FgeCovqlmREDlBAHBWf5A6S3nQjKzwNECITBEbVig5VREINVg+Q==
X-Received: by 2002:a17:906:d108:b0:aa4:844d:e5ee with SMTP id a640c23a62f3a-aa4844dfe9fmr1304335466b.56.1732030620431;
        Tue, 19 Nov 2024 07:37:00 -0800 (PST)
Received: from [192.168.178.20] ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df4e7bfsm661900566b.42.2024.11.19.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 07:37:00 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 19 Nov 2024 16:36:41 +0100
Subject: [PATCH v2 02/10] midx-write: pass down repository to static
 functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-2-e2f607174efc@gmail.com>
References: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
In-Reply-To: <20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, shejialuo@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8735; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=B12hGd6i9QWug35sLpT941ZcQmmggVfeXbG1Owv1U74=;
 b=owEB7QES/pANAwAIAT7VnySORox/AcsmYgBnPLCX21YoElqs5mQ00JtJ9v1pECp1/L+FmH+jl
 NQP2wfQfQuJAbMEAAEIAB0WIQRXzkx/Y3VxD8tlxgY+1Z8kjkaMfwUCZzywlwAKCRA+1Z8kjkaM
 f44kC/9sI0RWdfa0Z2oyRklnv3Ijlz2qyYJB5Pv3xk8Xy3kqXtw26uI7RyhFCZhJispSQZwOJHp
 gRokO30LcF5MJs14xvG87TjK97wYhH95fFCK5wrlIBWxQlKlI15jcvCWqDYoRhT22aF42XvepxO
 mPXmdEx9NDSsjwVTNg1p4IHquWhwHcWMC3fPV7cp+RESupyAIKhnV7ReEjsgtxBPaq17ToTngev
 DIauhX3uHPMoVSFPIsGIbM2VzcNS76aXJ5QrKsXrHnDaEbgxl55RS3HSQLPLFIJcp4SG5JCxkGR
 auKZIR8NAyJJcUN1XfpPYyaG+nQ/TUuJda7D1emy0H67ofKwLPYSfhz5hguv/O8glgrxxajS54q
 FVDB2xKG5LST/FKQUNhIhbfMvGTI0BvLt1JNotzuZfEWgGmosrfzq741YndLNT/iaRriQ5Z3BGr
 F/LeysAqlIqDvQ+ID/dgm58JdioHkBWBCjfrVbbJup7CLjUdJiACiK8124Bpwf61m4NV4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

In 'midx-write.c' there are a lot of static functions which use global
variables `the_repository` or `the_hash_algo`. In a follow up commit,
the repository variable will be added to `write_midx_context`, which
some of the functions can use. But for functions which do not have
access to this struct, pass down the required information from
non-static functions `write_midx_file` and `write_midx_file_only`.

This ensures that the usage of global variables is limited to these
non-static functions, which will be cleaned up in a follow up commits.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 midx-write.c | 57 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index c57726ef9475df693890d61627ce91409c1def7c..22b5233f51ec6c6d99b8f9613818f1581dca5982 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -35,13 +35,13 @@ extern void clear_incremental_midx_files_ext(const char *object_dir,
 extern int cmp_idx_or_pack_name(const char *idx_or_pack_name,
 				const char *idx_name);
 
-static size_t write_midx_header(struct hashfile *f,
-				unsigned char num_chunks,
+static size_t write_midx_header(const struct git_hash_algo *hash_algo,
+				struct hashfile *f, unsigned char num_chunks,
 				uint32_t num_packs)
 {
 	hashwrite_be32(f, MIDX_SIGNATURE);
 	hashwrite_u8(f, MIDX_VERSION);
-	hashwrite_u8(f, oid_version(the_hash_algo));
+	hashwrite_u8(f, oid_version(hash_algo));
 	hashwrite_u8(f, num_chunks);
 	hashwrite_u8(f, 0); /* unused */
 	hashwrite_be32(f, num_packs);
@@ -702,7 +702,7 @@ static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
 		return 0;
 	}
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
+	if (!peel_iterated_oid(revs->repo, oid, &peeled))
 		oid = &peeled;
 
 	object = parse_object_or_die(oid, refname);
@@ -827,7 +827,7 @@ static struct commit **find_commits_for_midx_bitmap(uint32_t *indexed_commits_nr
 	return cb.commits;
 }
 
-static int write_midx_bitmap(const char *midx_name,
+static int write_midx_bitmap(struct repository *r, const char *midx_name,
 			     const unsigned char *midx_hash,
 			     struct packing_data *pdata,
 			     struct commit **commits,
@@ -840,9 +840,9 @@ static int write_midx_bitmap(const char *midx_name,
 	struct bitmap_writer writer;
 	struct pack_idx_entry **index;
 	char *bitmap_name = xstrfmt("%s-%s.bitmap", midx_name,
-					hash_to_hex(midx_hash));
+				    hash_to_hex_algop(midx_hash, r->hash_algo));
 
-	trace2_region_enter("midx", "write_midx_bitmap", the_repository);
+	trace2_region_enter("midx", "write_midx_bitmap", r);
 
 	if (flags & MIDX_WRITE_BITMAP_HASH_CACHE)
 		options |= BITMAP_OPT_HASH_CACHE;
@@ -859,7 +859,7 @@ static int write_midx_bitmap(const char *midx_name,
 	for (i = 0; i < pdata->nr_objects; i++)
 		index[i] = &pdata->objects[i].idx;
 
-	bitmap_writer_init(&writer, the_repository, pdata);
+	bitmap_writer_init(&writer, r, pdata);
 	bitmap_writer_show_progress(&writer, flags & MIDX_PROGRESS);
 	bitmap_writer_build_type_index(&writer, index);
 
@@ -892,7 +892,7 @@ static int write_midx_bitmap(const char *midx_name,
 	free(bitmap_name);
 	bitmap_writer_free(&writer);
 
-	trace2_region_leave("midx", "write_midx_bitmap", the_repository);
+	trace2_region_leave("midx", "write_midx_bitmap", r);
 
 	return ret;
 }
@@ -1049,7 +1049,7 @@ static void clear_midx_files(const char *object_dir,
 	strbuf_release(&buf);
 }
 
-static int write_midx_internal(const char *object_dir,
+static int write_midx_internal(struct repository *r, const char *object_dir,
 			       struct string_list *packs_to_include,
 			       struct string_list *packs_to_drop,
 			       const char *preferred_pack_name,
@@ -1070,7 +1070,8 @@ static int write_midx_internal(const char *object_dir,
 	const char **keep_hashes = NULL;
 	struct chunkfile *cf;
 
-	trace2_region_enter("midx", "write_midx_internal", the_repository);
+	trace2_region_enter("midx", "write_midx_internal", r);
+
 
 	ctx.incremental = !!(flags & MIDX_WRITE_INCREMENTAL);
 	if (ctx.incremental && (flags & MIDX_WRITE_BITMAP))
@@ -1087,8 +1088,7 @@ static int write_midx_internal(const char *object_dir,
 			  midx_name.buf);
 
 	if (!packs_to_include || ctx.incremental) {
-		struct multi_pack_index *m = lookup_multi_pack_index(the_repository,
-								     object_dir);
+		struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 		if (m && !midx_checksum_valid(m)) {
 			warning(_("ignoring existing multi-pack-index; checksum mismatch"));
 			m = NULL;
@@ -1351,7 +1351,7 @@ static int write_midx_internal(const char *object_dir,
 	add_chunk(cf, MIDX_CHUNKID_OIDFANOUT, MIDX_CHUNK_FANOUT_SIZE,
 		  write_midx_oid_fanout);
 	add_chunk(cf, MIDX_CHUNKID_OIDLOOKUP,
-		  st_mult(ctx.entries_nr, the_hash_algo->rawsz),
+		  st_mult(ctx.entries_nr, r->hash_algo->rawsz),
 		  write_midx_oid_lookup);
 	add_chunk(cf, MIDX_CHUNKID_OBJECTOFFSETS,
 		  st_mult(ctx.entries_nr, MIDX_CHUNK_OFFSET_WIDTH),
@@ -1373,7 +1373,8 @@ static int write_midx_internal(const char *object_dir,
 			  write_midx_bitmapped_packs);
 	}
 
-	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
+	write_midx_header(r->hash_algo, f, get_num_chunks(cf),
+			  ctx.nr - dropped_packs);
 	write_chunkfile(cf, &ctx);
 
 	finalize_hashfile(f, midx_hash, FSYNC_COMPONENT_PACK_METADATA,
@@ -1405,7 +1406,7 @@ static int write_midx_internal(const char *object_dir,
 		FREE_AND_NULL(ctx.entries);
 		ctx.entries_nr = 0;
 
-		if (write_midx_bitmap(midx_name.buf, midx_hash, &pdata,
+		if (write_midx_bitmap(r, midx_name.buf, midx_hash, &pdata,
 				      commits, commits_nr, ctx.pack_order,
 				      flags) < 0) {
 			error(_("could not write multi-pack bitmap"));
@@ -1449,12 +1450,13 @@ static int write_midx_internal(const char *object_dir,
 		strbuf_release(&final_midx_name);
 
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 
 		for (i = 0; i < ctx.num_multi_pack_indexes_before; i++) {
 			uint32_t j = ctx.num_multi_pack_indexes_before - i - 1;
 
-			keep_hashes[j] = xstrdup(hash_to_hex(get_midx_checksum(m)));
+			keep_hashes[j] = xstrdup(hash_to_hex_algop(get_midx_checksum(m),
+								   r->hash_algo));
 			m = m->base_midx;
 		}
 
@@ -1462,7 +1464,7 @@ static int write_midx_internal(const char *object_dir,
 			fprintf(get_lock_file_fp(&lk), "%s\n", keep_hashes[i]);
 	} else {
 		keep_hashes[ctx.num_multi_pack_indexes_before] =
-			xstrdup(hash_to_hex(midx_hash));
+			xstrdup(hash_to_hex_algop(midx_hash, r->hash_algo));
 	}
 
 	if (ctx.m || ctx.base_midx)
@@ -1495,7 +1497,7 @@ static int write_midx_internal(const char *object_dir,
 	}
 	strbuf_release(&midx_name);
 
-	trace2_region_leave("midx", "write_midx_internal", the_repository);
+	trace2_region_leave("midx", "write_midx_internal", r);
 
 	return result;
 }
@@ -1505,8 +1507,8 @@ int write_midx_file(const char *object_dir,
 		    const char *refs_snapshot,
 		    unsigned flags)
 {
-	return write_midx_internal(object_dir, NULL, NULL, preferred_pack_name,
-				   refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, NULL, NULL,
+				   preferred_pack_name, refs_snapshot, flags);
 }
 
 int write_midx_file_only(const char *object_dir,
@@ -1515,8 +1517,9 @@ int write_midx_file_only(const char *object_dir,
 			 const char *refs_snapshot,
 			 unsigned flags)
 {
-	return write_midx_internal(object_dir, packs_to_include, NULL,
-				   preferred_pack_name, refs_snapshot, flags);
+	return write_midx_internal(the_repository, object_dir, packs_to_include,
+				   NULL, preferred_pack_name, refs_snapshot,
+				   flags);
 }
 
 int expire_midx_packs(struct repository *r, const char *object_dir, unsigned flags)
@@ -1572,7 +1575,8 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 	free(count);
 
 	if (packs_to_drop.nr)
-		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
+		result = write_midx_internal(r, object_dir, NULL,
+					     &packs_to_drop, NULL, NULL, flags);
 
 	string_list_clear(&packs_to_drop, 0);
 
@@ -1769,7 +1773,8 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 		goto cleanup;
 	}
 
-	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
+	result = write_midx_internal(r, object_dir, NULL, NULL, NULL, NULL,
+				     flags);
 
 cleanup:
 	free(include_pack);

-- 
2.47.0

