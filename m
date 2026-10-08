Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDAF3E832B
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 08:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448578; cv=none; b=i8YHITMyiQ/lNFE+l358upBkMfJWMUmzFod2t0j76WKI6p+GcHnjXekXi46MzBiM7CQby3jalX0HPlgKlhRIlIzTIkA9y/vKyoHef8pIXqMfGVaBZpdgAlmD+4riPIthlDUhbP2LUAiJKbL2Wlge/pYYhzt99XhwbEge6YizKuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448578; c=relaxed/simple;
	bh=bcwLossni3pK/t4fM2sJD5xhv8KmXAwbSd5XPabG4/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q8Fh+8ex9iXCvaSp/fscaRiASEpYlocc9got5er8sa61ncYvnYk+XxTwnI0s3e3/uGttOJ4gsJT7lJpVHnD1+GtO9sLsbfxEtC8shIKX7qBqLNnBLmkvIu78u7lEg/JQ5kmh8M7ZaqorrM5f5XSF3yhZ/ia93JtI2CMj0Q2N3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KKfdfh/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdllXvXr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KKfdfh/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdllXvXr"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19B041400153
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 04:36:15 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 08 Oct 2026 04:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791448575;
	 x=1791534975; bh=uF9xkFsc4t5lzdi0JG9TknMVmC90hWpGoc5i2kLb0tg=; b=
	KKfdfh/AKDffopj2tpTW0DJytloT6fV9ml8MCAkgvrdpSakeZmpUUguUftziB44G
	UJEkV39Bhk+BYYQcT/Zc/wWc35Oh/QyXacAHPVCmvXV7VP8KAtwkEffxj34USpvf
	ksCMRW40DsQONpMQHP4F5oF0kwfB5p5DawBRObHmXtnMtR+oz2BhSACANbBUgm9n
	bv34WY9bTZyG2yF+RDss+Urzx5jLTtWN+fay2u2YkQAhxnLEqHxIYwh42/4+BKtB
	JvkaYiAyYS020tER3ZE5K94VgeTpBIsrAYewmGlVhLMxdi1movKpLnnYrOInQ6qV
	dHl+lgx89YoZWl8j6IKpeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791448575; x=
	1791534975; bh=uF9xkFsc4t5lzdi0JG9TknMVmC90hWpGoc5i2kLb0tg=; b=Z
	dllXvXrMkO1Tfvu9ouUzSWe1uyNIOswRu1h/LA63yFFusyy7TCsirWLvh+dvGjID
	nunaX4mW7u8g5aUMkwFuxrtPDedtEi+DsgaLYFEFLsEehGurcLLTUEhUS48dfPaC
	3wFDKK9Mg0fh9O2THnoSSDVrGFokuvmLqSCfrVLb5QJ5cWckeBh0tCNZkcqcWwo/
	rHyTHn7tps0MlExDvLB5G2Ltui2qUo5G+CpAGR8Ufspl97+MSJaZXmIwmT/FCVZf
	KawmdEjnDEE5R3zodn8AHgoIzY/ZQEgcGRjDQZ6MPsOFMDOTUq8pSnQK448v4olC
	xxePTtQ3hEkgwKfxaITFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791448575; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HKEuVUAscX4FgsLRBdqSuRN3JTOL80bUfd7y0ptBPzxiNnT
	b0S4BkMEliUxlRLd3c1lB+3z7Hzn285HnSAOD7wuL1JRUQHMOrhLp3HMoYyyge0d
	clNDTsrL6YvtVJBTDxVd9lNZfozQKJqyVB5Ovqa43PcyVua0+vxmlr9N62FFBUby
	4mDOK9cqT/ee+RfrOQ/yBgpWCi8oN1ZRe1IrDiR4x+ZPke3n2N+aMYp1d3WHEpL5
	mGv9rHpv3FMGMvlJY0536bI1N17lqDz+rBHUcgl+RrU11JOIaBQ3Tm2pp8z+tIjV
	kJgaYg9mejcA7hMEpMvGY/nsWQh4AKwnzqUBvLQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1pTba6a9rt6QvOnusos1KRupnjCFZcrhFgKu+XxD7mw=:bcwLossni3pK/t4fM2sJD5xhv8KmXAwbSd5XPabG4/Y=;
X-ME-Sender: <xms:_lXHanjZ31oezpr5rSYIxd5EOS9eeZ-w3XFz0yZ8W8BY2-52v-T7sQ>
    <xme:_lXHaqAH5TFDadklXwnB2YA1tJl2-8VQlgehhxL7QhDxt9eP4FLcqySX5uxrbfHmi
    HZJ79Ii35mEmEzBA5WcPKM5D_mGh67ITdA3fBbT4JFInS7XyozbqlA>
X-ME-Received: <xmr:_lXHakv1Jv_4pT-yKqnxb3uvOhoRYoejBwBqStK2oA62zhczkgF8fg>
X-ME-Proxy-Cause: dmFkZTEJ12PrM6lPkulG2HrVHQhK7W+nzWtv82fCmVg5Srp1vYOBsOZXk+3zbaSKR1o9q9
    zgaDeQtd8exjkN8iOx8gK+wWQ1lxo0Q9l5NbSN30f6p85fJAxnBnfB37gvWssqHY0VvvFk
    PiSqXLopWAifncYeDTw784/UzhaCYudHQhaoZVmElltXFrtbNxE9yoMHYjh+fC+7+cmO4F
    trDv6wR/hEYFDz8+qQNhsJOcx0mrPE3FW04oN9df+1q7n0ABLdhTxdS8UQHC0rVd1KtZxV
    7/37M0p9gjidiOzO6b0dZkeD/ejphFx+/vQQFlrVrQqcWyOiFkr2KBwIfyyln8WZPtNoCs
    dQDfSuQdxzLOUn0Qk71PqXmNrTWJWHHMvHxodfB+4c4IbNprFNLISFI7XYElOtplLehura
    u9tY/n3sQT5jO71n44iIC1IOwsUB51nIesh9Co5iM/OVbufAe+kw4+XbutL8lVNo9bg4mi
    S5tWsR5YyaayrMqjS5bcI6il8Bx8jcCxB/dY7+R8b4DdRtY5Sb55EkMDdqcJ3Oncuf+M42
    gbhqxl4toA9LWa8trI1bmG76DPtnYgnojPcqSZ0wgaHstzlHG8qBDPh8RVfX9WomqNvjSK
    VQuJ7KcHzIlbek08V0c1orfJkraYULZCXeaRhd3Z3+K7dNH6AhJqIFqDp44Q
X-ME-Proxy: <xmx:_lXHavYb9vZ_ygknUd186U9NvaX3zrsutJxpqI6FtcNDWtK0-ERWew>
    <xmx:_1XHanVpd0i1BDnTcFr1FA5_ZqE5nziVGcW6WxlXSdTB978C2kgiwg>
    <xmx:_1XHaj7wCm8iRBREIlss8jDoIRqOAO7cAZvQ888D5Bbw33nXsSLL5Q>
    <xmx:_1XHaiixPDSOj1b4NN6PxUYCIw41SshhL9a6oT-oBp6bkLYx-X7Sdg>
    <xmx:_1XHavSrdY6JMfZ-jD8bZS85OhFpzc85g9VeCgpz5fE-45WJiFfYI0qb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 04:36:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64ab45c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Oct 2026 08:36:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 08 Oct 2026 10:35:53 +0200
Subject: [PATCH v2 03/13] odb/source-files: introduce `struct
 odb_files_dir`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-pks-odb-move-alternates-v2-3-b47e8189baa5@pks.im>
References: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
In-Reply-To: <20261008-pks-odb-move-alternates-v2-0-b47e8189baa5@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The "files" object database source consists of two separate backends for
storing loose and packed objects. These are managed as somewhat separate
entities even though they derive from the same object directory, whether
it's the primary object directory or that one from an alternate.

In a subsequent commit we'll move the handling of alternates into the
"files" backend completely so that it becomes another implementation
detail thereof. As part of this, we'll want to keep track of both of
these sub-sources as a single entity derived from their respective
object directory.

Prepare for this change by introducing a new `struct odb_files_dir` that
encapsulates them. For now, every "files" source has exactly one such
directory. In a subsequent commit though, we'll make it a linked list of
directories so that we can manage multiple such directories in a single
"files" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c      |  6 ++--
 builtin/index-pack.c       |  2 +-
 builtin/multi-pack-index.c | 14 ++++-----
 builtin/pack-objects.c     | 18 +++++------
 builtin/repack.c           |  4 +--
 commit-graph.c             |  2 +-
 http-walker.c              |  2 +-
 http.c                     |  6 ++--
 loose.c                    |  6 ++--
 midx.c                     | 26 ++++++++--------
 odb/source-files.c         | 77 ++++++++++++++++++++++++++++++----------------
 odb/source-files.h         | 27 ++++++++++++++--
 pack-bitmap.c              |  2 +-
 packfile.c                 |  8 ++---
 packfile.h                 |  4 +--
 repack-geometry.c          |  2 +-
 repack-midx.c              |  6 ++--
 repack.c                   |  2 +-
 t/helper/test-read-midx.c  |  2 +-
 19 files changed, 131 insertions(+), 85 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index fbd919982c..0bf76b028b 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -921,7 +921,7 @@ static void end_packfile(void)
 		idx_name = keep_pack(create_index());
 
 		/* Register the packfile with core git's machinery. */
-		new_p = packfile_store_load_pack(files->packed, idx_name, 1);
+		new_p = packfile_store_load_pack(files->dirs->packed, idx_name, 1);
 		if (!new_p)
 			die(_("core Git rejected index %s"), idx_name);
 		all_packs[pack_id] = new_p;
@@ -1005,7 +1005,7 @@ static int store_object(
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
-		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
+		if (!packfile_list_find_oid(packfile_store_get_packs(files->dirs->packed), &oid))
 			continue;
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
@@ -1215,7 +1215,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
-		if (!packfile_list_find_oid(packfile_store_get_packs(files->packed), &oid))
+		if (!packfile_list_find_oid(packfile_store_get_packs(files->dirs->packed), &oid))
 			continue;
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 6b2a87e2d3..70860b8f27 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1641,7 +1641,7 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 	if (do_fsck_object && startup_info->have_repository) {
 		struct odb_source_files *files =
 			odb_source_files_downcast(the_repository->objects->sources);
-		packfile_store_load_pack(files->packed, final_index_name, 0);
+		packfile_store_load_pack(files->dirs->packed, final_index_name, 0);
 	}
 
 	if (!from_stdin) {
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 753bd53a70..a170ec80b9 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -213,7 +213,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 		read_packs_from_stdin(&packs);
 
-		ret = write_midx_file_only(source->packed, &packs,
+		ret = write_midx_file_only(source->dirs->packed, &packs,
 					   opts.preferred_pack,
 					   opts.refs_snapshot,
 					   opts.incremental_base, opts.flags);
@@ -225,7 +225,7 @@ static int cmd_multi_pack_index_write(int argc, const char **argv,
 
 	}
 
-	ret = write_midx_file(source->packed, opts.preferred_pack,
+	ret = write_midx_file(source->dirs->packed, opts.preferred_pack,
 			      opts.refs_snapshot, opts.flags);
 
 	free(opts.refs_snapshot);
@@ -284,7 +284,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	m = get_multi_pack_index(source->packed);
+	m = get_multi_pack_index(source->dirs->packed);
 
 	for (cur = m; cur && !(from_midx && to_midx); cur = cur->base_midx) {
 		const char *midx_csum = midx_get_checksum_hex(cur);
@@ -307,7 +307,7 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
 			die(_("MIDX %s must be an ancestor of %s"), argv[0], argv[1]);
 	}
 
-	ret = write_midx_file_compact(source->packed, from_midx, to_midx,
+	ret = write_midx_file_compact(source->dirs->packed, from_midx, to_midx,
 				      opts.incremental_base, opts.flags);
 
 	return ret;
@@ -339,7 +339,7 @@ static int cmd_multi_pack_index_verify(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return verify_midx_file(source->packed, opts.flags);
+	return verify_midx_file(source->dirs->packed, opts.flags);
 }
 
 static int cmd_multi_pack_index_expire(int argc, const char **argv,
@@ -368,7 +368,7 @@ static int cmd_multi_pack_index_expire(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return expire_midx_packs(source->packed, opts.flags);
+	return expire_midx_packs(source->dirs->packed, opts.flags);
 }
 
 static int cmd_multi_pack_index_repack(int argc, const char **argv,
@@ -400,7 +400,7 @@ static int cmd_multi_pack_index_repack(int argc, const char **argv,
 
 	FREE_AND_NULL(options);
 
-	return midx_repack(source->packed, (size_t)opts.batch_size, opts.flags);
+	return midx_repack(source->dirs->packed, (size_t)opts.batch_size, opts.flags);
 }
 
 int cmd_multi_pack_index(int argc,
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index af9390a46b..070659b6ed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1570,7 +1570,7 @@ static int want_cruft_object_mtime(struct repository *r,
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packed_git **cache = packfile_store_get_kept_pack_cache(files->packed, flags);
+		struct packed_git **cache = packfile_store_get_kept_pack_cache(files->dirs->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
@@ -1765,7 +1765,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
-			if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
+			if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
 				return 0;
 		}
 	}
@@ -1787,7 +1787,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct multi_pack_index *m = get_multi_pack_index(files->packed);
+		struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
 		struct pack_entry e;
 
 		if (m && midx_fill_entry(m, oid, &e, NULL) == MIDX_FILL_HIT) {
@@ -1800,11 +1800,11 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
-		for (e = files->packed->packs.head; e; e = e->next) {
+		for (e = files->dirs->packed->packs.head; e; e = e->next) {
 			struct packed_git *p = e->pack;
 			want = want_object_in_pack_one(p, oid, exclude, found_pack, found_offset, found_mtime);
 			if (!exclude && want > 0)
-				packfile_list_prepend(&files->packed->packs, p);
+				packfile_list_prepend(&files->dirs->packed->packs, p);
 			if (want != -1)
 				return want;
 		}
@@ -4175,7 +4175,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 
 			for (; !found && source; source = source->next) {
 				struct odb_source_files *files = odb_source_files_downcast(source);
-				if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
+				if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
 					found = 1;
 			}
 
@@ -4532,7 +4532,7 @@ static void add_objects_in_unpacked_packs(void)
 		if (!source->local)
 			continue;
 
-		if (odb_source_for_each_object(&files->packed->base, &oi,
+		if (odb_source_for_each_object(&files->dirs->packed->base, &oi,
 					       add_object_in_unpacked_pack, NULL, &opts))
 			die(_("cannot open pack index"));
 	}
@@ -4642,7 +4642,7 @@ static int force_object_loose(struct odb_source *source,
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next) {
 		struct odb_source_files *files = odb_source_files_downcast(s);
-		if (!odb_source_read_object_info(&files->loose->base, oid, NULL, 0, NULL))
+		if (!odb_source_read_object_info(&files->dirs->loose->base, oid, NULL, 0, NULL))
 			return 0;
 	}
 
@@ -4664,7 +4664,7 @@ static int force_object_loose(struct odb_source *source,
 		compat_oid_p = &compat_oid;
 	}
 
-	ret = odb_source_write_object(&files->loose->base, buf, len, type, oid,
+	ret = odb_source_write_object(&files->dirs->loose->base, buf, len, type, oid,
 				      compat_oid_p, mtime, 0);
 
 out:
diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..5d06872d77 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -617,7 +617,7 @@ int cmd_repack(int argc,
 		 * midx_has_unknown_packs() will make the decision for
 		 * us.
 		 */
-		if (!get_multi_pack_index(files->packed))
+		if (!get_multi_pack_index(files->dirs->packed))
 			midx_must_contain_cruft = 1;
 	}
 
@@ -775,7 +775,7 @@ int cmd_repack(int argc,
 
 		if (git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL, 0))
 			flags |= MIDX_WRITE_INCREMENTAL;
-		write_midx_file(files->packed, NULL, NULL, flags);
+		write_midx_file(files->dirs->packed, NULL, NULL, flags);
 	}
 
 cleanup:
diff --git a/commit-graph.c b/commit-graph.c
index 80ebc6a542..7cc486d140 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2020,7 +2020,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 
 	for (source = ctx->r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		odb_source_for_each_object(&files->packed->base, &oi, add_packed_commits_oi,
+		odb_source_for_each_object(&files->dirs->packed->base, &oi, add_packed_commits_oi,
 					   ctx, &opts);
 	}
 
diff --git a/http-walker.c b/http-walker.c
index abafca84d6..0a6c99f471 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -542,7 +542,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	} else if (req->rename < 0) {
 		struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 		struct strbuf buf = STRBUF_INIT;
-		odb_loose_path(files->loose, &buf, &req->oid);
+		odb_loose_path(files->dirs->loose, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index c8fcfd7693..fe6ec88a21 100644
--- a/http.c
+++ b/http.c
@@ -2720,7 +2720,7 @@ void http_install_packfile(struct packed_git *p,
 {
 	struct odb_source_files *files = odb_source_files_downcast(the_repository->objects->sources);
 	packfile_list_remove(list_to_remove_from, p);
-	packfile_store_add_pack(files->packed, p);
+	packfile_store_add_pack(files->dirs->packed, p);
 }
 
 struct http_pack_request *new_http_pack_request(
@@ -2861,7 +2861,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	odb_loose_path(files->loose, &filename, oid);
+	odb_loose_path(files->dirs->loose, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -3014,7 +3014,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	odb_loose_path(files->loose, &filename, &freq->oid);
+	odb_loose_path(files->dirs->loose, &filename, &freq->oid);
 	freq->rename = finalize_object_file(the_repository, freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/loose.c b/loose.c
index c159d29d2d..957bf83e6b 100644
--- a/loose.c
+++ b/loose.c
@@ -117,7 +117,7 @@ int repo_read_loose_object_map(struct repository *repo)
 
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (loose_object_map_load(files->loose) < 0)
+		if (loose_object_map_load(files->dirs->loose) < 0)
 			return -1;
 	}
 
@@ -127,7 +127,7 @@ int repo_read_loose_object_map(struct repository *repo)
 int repo_write_loose_object_map(struct repository *repo)
 {
 	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
-	kh_oid_map_t *map = files->loose->map->to_compat;
+	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
 	struct lock_file lock;
 	int fd;
 	khiter_t iter;
@@ -237,7 +237,7 @@ int repo_loose_object_map_oid(struct repository *repo,
 
 	for (source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct loose_object_map *loose_map = files->loose->map;
+		struct loose_object_map *loose_map = files->dirs->loose->map;
 		if (!loose_map)
 			continue;
 		map = (to == repo->compat_hash_algo) ?
diff --git a/midx.c b/midx.c
index 6d1c548e3d..c0f82c4163 100644
--- a/midx.c
+++ b/midx.c
@@ -837,20 +837,20 @@ void clear_midx_file(struct repository *r)
 
 		for (source = r->objects->sources; source; source = source->next) {
 			files = odb_source_files_downcast(source);
-			if (files->packed->midx)
-				close_midx(files->packed->midx);
-			files->packed->midx = NULL;
+			if (files->dirs->packed->midx)
+				close_midx(files->dirs->packed->midx);
+			files->dirs->packed->midx = NULL;
 		}
 	}
 
 	files = odb_source_files_downcast(r->objects->sources);
-	get_midx_filename(files->packed, &midx);
+	get_midx_filename(files->dirs->packed, &midx);
 
 	if (remove_path(midx.buf))
 		die(_("failed to clear multi-pack-index at %s"), midx.buf);
 
-	clear_midx_files_ext(files->packed, MIDX_EXT_BITMAP, NULL);
-	clear_midx_files_ext(files->packed, MIDX_EXT_REV, NULL);
+	clear_midx_files_ext(files->dirs->packed, MIDX_EXT_BITMAP, NULL);
+	clear_midx_files_ext(files->dirs->packed, MIDX_EXT_REV, NULL);
 
 	strbuf_release(&midx);
 }
@@ -864,21 +864,21 @@ void clear_incremental_midx_files(struct repository *r,
 
 	for (source = r->objects->sources; source; source = source->next) {
 		files = odb_source_files_downcast(source);
-		if (files->packed->midx)
-			close_midx(files->packed->midx);
-		files->packed->midx = NULL;
+		if (files->dirs->packed->midx)
+			close_midx(files->dirs->packed->midx);
+		files->dirs->packed->midx = NULL;
 	}
 
 	files = odb_source_files_downcast(r->objects->sources);
-	get_midx_chain_filename(files->packed, &chain);
+	get_midx_chain_filename(files->dirs->packed, &chain);
 
 	if (!keep_hashes && remove_path(chain.buf))
 		die(_("failed to clear multi-pack-index chain at %s"),
 		    chain.buf);
 
-	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_BITMAP, keep_hashes);
-	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_REV, keep_hashes);
-	clear_incremental_midx_files_ext(files->packed, MIDX_EXT_MIDX, keep_hashes);
+	clear_incremental_midx_files_ext(files->dirs->packed, MIDX_EXT_BITMAP, keep_hashes);
+	clear_incremental_midx_files_ext(files->dirs->packed, MIDX_EXT_REV, keep_hashes);
+	clear_incremental_midx_files_ext(files->dirs->packed, MIDX_EXT_MIDX, keep_hashes);
 
 	strbuf_release(&chain);
 }
diff --git a/odb/source-files.c b/odb/source-files.c
index f2fc4cd9ab..1f4cedaffa 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -24,6 +24,30 @@
 #include "tree.h"
 #include "write-or-die.h"
 
+struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
+					const char *path, bool local)
+{
+	struct odb_files_dir *dir;
+
+	CALLOC_ARRAY(dir, 1);
+	dir->abspath = absolute_pathdup(path);
+	dir->local = local;
+	dir->loose = odb_source_loose_new(odb, path, local);
+	dir->packed = odb_source_packed_new(odb, path, local);
+
+	return dir;
+}
+
+void odb_files_dir_free(struct odb_files_dir *dir)
+{
+	if (!dir)
+		return;
+	odb_source_free(&dir->loose->base);
+	odb_source_free(&dir->packed->base);
+	free(dir->abspath);
+	free(dir);
+}
+
 static void odb_source_files_reparent(const char *old_cwd,
 				      const char *new_cwd,
 				      void *cb_data)
@@ -31,6 +55,7 @@ static void odb_source_files_reparent(const char *old_cwd,
 	struct odb_source_files *files = cb_data;
 	char *path = reparent_relative_path(old_cwd, new_cwd,
 					    files->base.path);
+
 	free(files->base.path);
 	files->base.path = path;
 }
@@ -39,8 +64,7 @@ static void odb_source_files_free(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(odb_source_files_reparent, files);
-	odb_source_free(&files->loose->base);
-	odb_source_free(&files->packed->base);
+	odb_files_dir_free(files->dirs);
 	odb_source_release(&files->base);
 	free(files);
 }
@@ -48,8 +72,8 @@ static void odb_source_files_free(struct odb_source *source)
 static void odb_source_files_close(struct odb_source *source)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_close(&files->loose->base);
-	odb_source_close(&files->packed->base);
+	odb_source_close(&files->dirs->loose->base);
+	odb_source_close(&files->dirs->packed->base);
 }
 
 static int odb_source_files_create_on_disk(struct odb_source *source,
@@ -144,8 +168,8 @@ static void odb_source_files_prepare(struct odb_source *source,
 				     enum odb_prepare_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	odb_source_prepare(&files->loose->base, flags);
-	odb_source_prepare(&files->packed->base, flags);
+	odb_source_prepare(&files->dirs->loose->base, flags);
+	odb_source_prepare(&files->dirs->packed->base, flags);
 }
 
 static enum odb_read_status odb_source_files_read_object_info(struct odb_source *source,
@@ -157,12 +181,12 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	enum odb_read_status ret_packed, ret_loose;
 
-	ret_packed = odb_source_read_object_info(&files->packed->base, oid, oi,
+	ret_packed = odb_source_read_object_info(&files->dirs->packed->base, oid, oi,
 						 flags, errmsg);
 	if (!ret_packed)
 		return 0;
 
-	ret_loose = odb_source_read_object_info(&files->loose->base, oid, oi, flags,
+	ret_loose = odb_source_read_object_info(&files->dirs->loose->base, oid, oi, flags,
 						ret_packed == ODB_READ_NOT_FOUND ? errmsg : NULL);
 	if (!ret_loose)
 		return 0;
@@ -184,8 +208,8 @@ static int odb_source_files_read_object_stream(struct odb_stream **out,
 					       const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (!odb_source_read_object_stream(out, &files->packed->base, oid) ||
-	    !odb_source_read_object_stream(out, &files->loose->base, oid))
+	if (!odb_source_read_object_stream(out, &files->dirs->packed->base, oid) ||
+	    !odb_source_read_object_stream(out, &files->dirs->loose->base, oid))
 		return 0;
 	return -1;
 }
@@ -200,12 +224,12 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 	int ret;
 
 	if (!(opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-		ret = odb_source_for_each_object(&files->loose->base, request, cb, cb_data, opts);
+		ret = odb_source_for_each_object(&files->dirs->loose->base, request, cb, cb_data, opts);
 		if (ret)
 			return ret;
 	}
 
-	ret = odb_source_for_each_object(&files->packed->base, request, cb, cb_data, opts);
+	ret = odb_source_for_each_object(&files->dirs->packed->base, request, cb, cb_data, opts);
 	if (ret)
 		return ret;
 
@@ -220,14 +244,14 @@ static int odb_source_files_count_objects(struct odb_source *source,
 	unsigned long count;
 	int ret;
 
-	ret = odb_source_count_objects(&files->packed->base, flags, &count);
+	ret = odb_source_count_objects(&files->dirs->packed->base, flags, &count);
 	if (ret < 0)
 		goto out;
 
 	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
 		unsigned long loose_count;
 
-		ret = odb_source_count_objects(&files->loose->base, flags, &loose_count);
+		ret = odb_source_count_objects(&files->dirs->loose->base, flags, &loose_count);
 		if (ret < 0)
 			goto out;
 
@@ -250,11 +274,11 @@ static int odb_source_files_find_abbrev_len(struct odb_source *source,
 	unsigned len = min_len;
 	int ret;
 
-	ret = odb_source_find_abbrev_len(&files->packed->base, oid, len, &len);
+	ret = odb_source_find_abbrev_len(&files->dirs->packed->base, oid, len, &len);
 	if (ret < 0)
 		goto out;
 
-	ret = odb_source_find_abbrev_len(&files->loose->base, oid, len, &len);
+	ret = odb_source_find_abbrev_len(&files->dirs->loose->base, oid, len, &len);
 	if (ret < 0)
 		goto out;
 
@@ -270,8 +294,8 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 					   const time_t *mtime)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (odb_source_freshen_object(&files->packed->base, oid, mtime) ||
-	    odb_source_freshen_object(&files->loose->base, oid, mtime))
+	if (odb_source_freshen_object(&files->dirs->packed->base, oid, mtime) ||
+	    odb_source_freshen_object(&files->dirs->loose->base, oid, mtime))
 		return 1;
 	return 0;
 }
@@ -285,7 +309,7 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 enum odb_write_object_flags flags)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return odb_source_write_object(&files->loose->base, buf, len, type,
+	return odb_source_write_object(&files->dirs->loose->base, buf, len, type,
 				       oid, compat_oid, mtime, flags);
 }
 
@@ -294,7 +318,7 @@ static int odb_source_files_write_object_stream(struct odb_source *source,
 						struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	return odb_source_write_object_stream(&files->loose->base, stream, oid);
+	return odb_source_write_object_stream(&files->dirs->loose->base, stream, oid);
 }
 
 static int odb_source_files_begin_transaction(struct odb_source *source,
@@ -330,7 +354,7 @@ static int too_many_loose_objects(struct odb_source_files *files, int limit)
 	if (limit <= 0)
 		return 0;
 
-	if (odb_source_count_objects(&files->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
+	if (odb_source_count_objects(&files->dirs->loose->base, ODB_COUNT_OBJECTS_APPROXIMATE,
 				     &loose_count) < 0)
 		return 0;
 
@@ -349,7 +373,7 @@ static struct packed_git *find_base_packs(struct odb_source_files *files,
 	struct packfile_list_entry *e;
 	struct packed_git *base = NULL;
 
-	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+	for (e = packfile_store_get_packs(files->dirs->packed); e; e = e->next) {
 		if (e->pack->is_cruft)
 			continue;
 		if (limit) {
@@ -374,7 +398,7 @@ static int too_many_packs(struct odb_source_files *files, int gc_auto_pack_limit
 	if (gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (e = packfile_store_get_packs(files->packed); e; e = e->next) {
+	for (e = packfile_store_get_packs(files->dirs->packed); e; e = e->next) {
 		if (e->pack->pack_keep)
 			continue;
 		/*
@@ -937,8 +961,8 @@ static int odb_source_files_fsck(struct odb_source *source,
 	if (!(opts->flags & ODB_FSCK_FULL) && !source->local)
 		return 0;
 
-	ret |= odb_source_fsck(&files->loose->base, opts);
-	ret |= odb_source_fsck(&files->packed->base, opts);
+	ret |= odb_source_fsck(&files->dirs->loose->base, opts);
+	ret |= odb_source_fsck(&files->dirs->packed->base, opts);
 
 	return ret;
 }
@@ -951,8 +975,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 
 	CALLOC_ARRAY(files, 1);
 	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, path, local);
-	files->loose = odb_source_loose_new(odb, path, local);
-	files->packed = odb_source_packed_new(odb, path, local);
+	files->dirs = odb_files_dir_new(odb, path, local);
 
 	files->base.free = odb_source_files_free;
 	files->base.close = odb_source_files_close;
diff --git a/odb/source-files.h b/odb/source-files.h
index 9630b5f962..7f465853b1 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -6,14 +6,37 @@
 struct odb_source_loose;
 struct odb_source_packed;
 
+/*
+ * A single object directory that encapsulates access to both the loose and
+ * packed backend. This can either be the primary or an alternate object
+ * directory.
+ */
+struct odb_files_dir {
+	/* Absolute path to the object directory. */
+	char *abspath;
+
+	/* The two sources derived from this object directory. */
+	struct odb_source_loose *loose;
+	struct odb_source_packed *packed;
+
+	/*
+	 * Whether this is the local object directory of the owning
+	 * repository. Directories added via alternates are not local.
+	 */
+	bool local;
+};
+
+struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
+					const char *path, bool local);
+void odb_files_dir_free(struct odb_files_dir *dir);
+
 /*
  * The files object database source uses a combination of loose objects and
  * packfiles. It is the default backend used by Git to store objects.
  */
 struct odb_source_files {
 	struct odb_source base;
-	struct odb_source_loose *loose;
-	struct odb_source_packed *packed;
+	struct odb_files_dir *dirs;
 };
 
 /* Allocate and initialize a new object source. */
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 3de8e9590c..52556b4543 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -720,7 +720,7 @@ static int open_bitmap(struct repository *r,
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 
-		if (!open_bitmap_for_source(files->packed, bitmap_git))
+		if (!open_bitmap_for_source(files->dirs->packed, bitmap_git))
 			found = true;
 
 		/*
diff --git a/packfile.c b/packfile.c
index 4fa5fd67c8..93b69d7f50 100644
--- a/packfile.c
+++ b/packfile.c
@@ -280,7 +280,7 @@ static int unuse_one_window(struct object_database *odb)
 
 	for (source = odb->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		for (e = files->packed->packs.head; e; e = e->next)
+		for (e = files->dirs->packed->packs.head; e; e = e->next)
 			scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
 	}
 
@@ -458,7 +458,7 @@ static int close_one_pack(struct repository *r)
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		for (e = files->packed->packs.head; e; e = e->next) {
+		for (e = files->dirs->packed->packs.head; e; e = e->next) {
 			if (e->pack->pack_fd == -1)
 				continue;
 			find_lru_pack(e->pack, &lru_p, &mru_w, &accept_windows_inuse);
@@ -1925,7 +1925,7 @@ int has_object_pack(struct repository *r, const struct object_id *oid)
 
 	for (source = r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		if (!odb_source_read_object_info(&files->packed->base, oid, NULL, 0, NULL))
+		if (!odb_source_read_object_info(&files->dirs->packed->base, oid, NULL, 0, NULL))
 			return 1;
 	}
 
@@ -1942,7 +1942,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		struct packed_git **cache;
 
-		cache = packfile_store_get_kept_pack_cache(files->packed, flags);
+		cache = packfile_store_get_kept_pack_cache(files->dirs->packed, flags);
 
 		for (; *cache; cache++) {
 			struct packed_git *p = *cache;
diff --git a/packfile.h b/packfile.h
index 6d30d15a00..fd1cf0ad6c 100644
--- a/packfile.h
+++ b/packfile.h
@@ -79,7 +79,7 @@ static inline struct repo_for_each_pack_data repo_for_eack_pack_data_init(struct
 
 	for (struct odb_source *source = repo->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
+		struct packfile_list_entry *entry = packfile_store_get_packs(files->dirs->packed);
 		if (!entry)
 			continue;
 		data.source = source;
@@ -100,7 +100,7 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 
 	for (source = data->source->next; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		struct packfile_list_entry *entry = packfile_store_get_packs(files->packed);
+		struct packfile_list_entry *entry = packfile_store_get_packs(files->dirs->packed);
 		if (!entry)
 			continue;
 		data->source = source;
diff --git a/repack-geometry.c b/repack-geometry.c
index 15b3412950..b541c34af5 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -33,7 +33,7 @@ void pack_geometry_init(struct pack_geometry *geometry,
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 	struct odb_source_files *files = odb_source_files_downcast(existing->source);
-	struct multi_pack_index *m = get_multi_pack_index(files->packed);
+	struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
 
 	repo_for_each_pack(existing->repo, p) {
 		if (geometry->midx_layer_threshold_set && m &&
diff --git a/repack-midx.c b/repack-midx.c
index 64c7f8d0f4..25140569bd 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -564,7 +564,7 @@ static void repack_make_midx_append_plan(struct repack_write_midx_opts *opts,
 	size_t steps_nr = 0, steps_alloc = 0;
 
 	odb_reprepare(opts->existing->repo->objects);
-	m = get_multi_pack_index(files->packed);
+	m = get_multi_pack_index(files->dirs->packed);
 
 	if (opts->names->nr) {
 		struct strbuf buf = STRBUF_INIT;
@@ -620,7 +620,7 @@ static int repack_make_midx_compaction_plan(struct repack_write_midx_opts *opts,
 			    opts->existing->repo);
 
 	odb_reprepare(opts->existing->repo->objects);
-	m = get_multi_pack_index(files->packed);
+	m = get_multi_pack_index(files->dirs->packed);
 
 	for (i = 0; m && i < m->num_packs + m->num_packs_in_base; i++) {
 		if (prepare_midx_pack(m, i)) {
@@ -949,7 +949,7 @@ static int write_midx_incremental(struct repack_write_midx_opts *opts)
 	size_t i;
 	int ret = 0;
 
-	get_midx_chain_filename(files->packed, &lock_name);
+	get_midx_chain_filename(files->dirs->packed, &lock_name);
 	if (safe_create_leading_directories(opts->existing->repo,
 					    lock_name.buf))
 		die_errno(_("unable to create leading directories of %s"),
diff --git a/repack.c b/repack.c
index d2aa58e134..e20431690c 100644
--- a/repack.c
+++ b/repack.c
@@ -60,7 +60,7 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct odb_source_files *files = odb_source_files_downcast(repo->objects->sources);
-	struct multi_pack_index *m = get_multi_pack_index(files->packed);
+	struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
 	strbuf_addf(&buf, "%s.pack", base_name);
 	if (m && files->base.local && midx_contains_pack(m, buf.buf)) {
 		clear_midx_file(repo);
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 83b07c6236..3f4bafff61 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -22,7 +22,7 @@ static struct multi_pack_index *setup_midx(const char *object_dir,
 
 	source = odb_find_source(the_repository->objects, object_dir);
 	if (source) {
-		packed = odb_source_files_downcast(source)->packed;
+		packed = odb_source_files_downcast(source)->dirs->packed;
 	} else {
 		packed = odb_source_packed_new(the_repository->objects,
 					       object_dir, false);

-- 
2.56.0.406.ga2d225a756.dirty

