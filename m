Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5F3B71CF
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678426; cv=none; b=u+vev4hBXsKKuaVsrCX4utAjnNC0xRDOjHeoe/tqfiyFZTyvPb6SYmB9kc/27bb7g9pvxz92JbfhpG2rNLGrbanns3N7+h09Jn3AjaO+R2SpjiAjNvoPdaR/er0nHzk3fIzNC56cTG/hyySTRle6UGmd7gao0hWD3uQLT2UGZlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678426; c=relaxed/simple;
	bh=gKAc19e56EEhhr63O/5wPVgtyrlhXzfYJfoKp9YE4Vs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fiOKz+utQXwOTw7myug7rlsxUf7EHYiMsO4xF6znWheJsiw4FsIEnR7/WZkPA/60Zbie0TrBzwk1jeALA5ZfijEbYHpi+P9Io3U5OBocheqMKPZe9brqMx0IKMYWNwPHkOzBpAcvSQN5P690ZwQrC5krj4nVqqcy2I3fS/Z4+UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cLVHppys; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q6qcBDno; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cLVHppys";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q6qcBDno"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EF771D00126;
	Wed, 17 Jun 2026 02:40:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 17 Jun 2026 02:40:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678424;
	 x=1781764824; bh=ruQ9sFwKAk0zuIsI8RbvLYIb1xa2xTSumIeXiZnZjCQ=; b=
	cLVHppysr5S6cK0mCYgtRjtytgnzxub1RLvvpzhlcrRkaoSkH535DYk2XQ98IdSo
	Td9q2QFPPCthbHn4rT5qxkDqwM9afHNThdSRDXyZNFDTRwWmXf56QnsaxtX3q/R8
	c3WHsj7Q1wLIsqBDjBvK0JmlKUp1LNX3yzjKyMBzQnbXLYjmmS6i31CXP5h7NOaI
	l057PcJjtFNNCs03ugeCrmo2JAD5IVcagQAzZWNW7V/bADbQyELS9wOIF0ZniHbv
	4H+max9j3ZhraaHG51Ka7wbJbd2YBk2XtzXgj82YEdRJGpYHFKiAdfBqf2cCrBZF
	OYfbUsGju5Fo4PZJSerbnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678424; x=
	1781764824; bh=ruQ9sFwKAk0zuIsI8RbvLYIb1xa2xTSumIeXiZnZjCQ=; b=Q
	6qcBDnoAJ3/lql28yB18YiGr66gjVBu0Z5YxeLFdBOpPFqkNfPG95sPOupM4+Twv
	RdC04e3SK0S3InXL1f8bFA58j4S2qAzh1Fd0IhoKnoX2UmNlMM5Xop7dqFIErXXR
	t+VgjohUJjkPFMyosEL9QcIud8iFjekv11A5kPdn+NeXAOnxDiUw414TDZEn/RaA
	2WSGkKB1/o+qVFhvnmjMvHJPITHYQPKh7KjW8lrBWZrzhxabQR0oLw/WAKHNXM+e
	z0K/sc8W8Xgmm53sZc0Czd1lAtQqaFlclNA/4jYf1m3eZBeOUOfbFfemXPF5hv0E
	ryN6bNdYlnsANH+3iTrmQ==
X-ME-Sender: <xms:WEEyamvJsYNMQ8HGWt8meMuQsVx3L6vsKGYTKyXvVvzjyWNhOeOt3w>
    <xme:WEEyai7cHvg-Ptqee5zWXiQWy4xsOzhroDDYWL1WVxZKAemc5JDabxkpbz075fUYS
    2_ldtsx9P_m8l0NylPkFmba9baeK_i-_bExjBXMZET0zbStX2xW>
X-ME-Received: <xmr:WEEyavIb23GkCPBnkhuBes99vIZcG9ca1KPM2CHbFoBDDhhuvBGmacH4PCsaWtaWU6wkGBUlMpAUMcp7J80_tsqVP7V_QIOf68-vvwM>
X-ME-Proxy-Cause: dmFkZTGO0C78ZwW/frQbOi0yCZr+3GuzTeYQYFlkQNPcjd5Ibxn88F8mcCuwiw5R0LaC49
    KJhHoT6pt2ouQ0TmaZBZoQ9x2gUJJMC5mgMVUTSZTuscfNdkDIdfcUFMHqPDDQBiSMwl3m
    SMGQxVBuHTRS6Hbv2nQ3ME3ZxXdCTBTMth8OKmyedtasQzciKMeXHwxr5RW1FUkUbI8hyQ
    GzyRa8IG+8urqY6o+u+qtni9Xi2SATUTXBXbFWF9zWnEZyUNdPww5/ZB+rK41HoG9mJKAJ
    QmZjJFQ1sfIWQY7Q3Go3Tc+nVcDPT7mlhtlA8E5SqwHw+ZmexVHwsBWw88RiR25rM/gUR/
    owSHPd0YIO0XGpUvj+xEgmVn3P6nfPbCPmoPcuemmEmu+ySKTnqe8Az7wEyOcX9u4aLK/D
    Uo29HXBjeAWBBsAAkJ52SrOciMGScY5oEcGGnxUE7+NzeKze2KTq0wmiRnLrVntnT/n1wf
    GWPixFLTgSWgFy/gQvnpHSB0761q64Qb4iHHLoHdpUt4EOez5+gjoi9MG0MDra4PnMc9FJ
    rZXMZsEOWcJ21Bat+WoQ5NwyudDbvCxFLuj7fyr6lse1EQaWZzhCi1n9hrlept3+IRgfk5
    99OOeQpAclQjquybaEXA2yYr3WsOHhHXp8nHHP671hzeuNynFL3tBfGTTLTw
X-ME-Proxy: <xmx:WEEyaq7VSN19NTjORJs46iD_uJSqWgXGCocvvKiGuGJikISmsbhpgA>
    <xmx:WEEyaqzKxvIFgw-sloEFXc2reywhIXElpTRAwSHN-LFSgiU0sq1iZA>
    <xmx:WEEyamZU3AE5ZjQo9sMHHDnMxjIH746NxrDtRVpOCIAS1gq5JwGwHQ>
    <xmx:WEEyakSdfm6kl-OhY5CGpJ6L1VlaFhHtAEQfl7HUDOsxLnKgiuTZYQ>
    <xmx:WEEyalVHPPW-jLn14ksmsIS4pbjv5_y935t06jbNV2U2B1qwYwlquUOi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d0b6e87e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:54 +0200
Subject: [PATCH v3 11/17] odb/source-packed: wire up `for_each_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-11-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Move `packfile_store_for_each_object()` and its associated helpers from
"packfile.c" into "odb/source-packed.c" and wire it up as the
`for_each_object()` callback of the "packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |   4 +-
 builtin/pack-objects.c |   4 +-
 commit-graph.c         |   4 +-
 odb/source-files.c     |   2 +-
 odb/source-packed.c    | 258 ++++++++++++++++++++++++++++++++++++++++++++++++
 packfile.c             | 260 +------------------------------------------------
 packfile.h             |  17 +---
 7 files changed, 269 insertions(+), 280 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 04b64006a5..d997011531 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -916,8 +916,8 @@ static void batch_each_object(struct batch_options *opt,
 
 		for (source = the_repository->objects->sources; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
-			int ret = packfile_store_for_each_object(files->packed, &oi,
-								 batch_one_object_oi, &payload, &opts);
+			int ret = odb_source_for_each_object(&files->packed->base, &oi,
+							     batch_one_object_oi, &payload, &opts);
 			if (ret)
 				break;
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 50675481e1..5e94805478 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4503,8 +4503,8 @@ static void add_objects_in_unpacked_packs(void)
 		if (!source->local)
 			continue;
 
-		if (packfile_store_for_each_object(files->packed, &oi,
-						   add_object_in_unpacked_pack, NULL, &opts))
+		if (odb_source_for_each_object(&files->packed->base, &oi,
+					       add_object_in_unpacked_pack, NULL, &opts))
 			die(_("cannot open pack index"));
 	}
 }
diff --git a/commit-graph.c b/commit-graph.c
index 9abe62bd5a..1e4038baf3 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2016,8 +2016,8 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	odb_prepare_alternates(ctx->r->objects);
 	for (source = ctx->r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
-		packfile_store_for_each_object(files->packed, &oi, add_packed_commits_oi,
-					       ctx, &opts);
+		odb_source_for_each_object(&files->packed->base, &oi, add_packed_commits_oi,
+					   ctx, &opts);
 	}
 
 	if (ctx->progress_done < ctx->approx_nr_objects)
diff --git a/odb/source-files.c b/odb/source-files.c
index dff69d0e4e..c73a7e5f90 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -88,7 +88,7 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 			return ret;
 	}
 
-	ret = packfile_store_for_each_object(files->packed, request, cb, cb_data, opts);
+	ret = odb_source_for_each_object(&files->packed->base, request, cb, cb_data, opts);
 	if (ret)
 		return ret;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 23d7149fe3..a61c809c8c 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -81,6 +81,263 @@ static int odb_source_packed_read_object_stream(struct odb_read_stream **out,
 	return packfile_read_object_stream(out, oid, e.p, e.offset);
 }
 
+struct odb_source_packed_for_each_object_wrapper_data {
+	struct odb_source_packed *store;
+	const struct object_info *request;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int odb_source_packed_for_each_object_wrapper(const struct object_id *oid,
+						     struct packed_git *pack,
+						     uint32_t index_pos,
+						     void *cb_data)
+{
+	struct odb_source_packed_for_each_object_wrapper_data *data = cb_data;
+
+	if (data->request) {
+		off_t offset = nth_packed_object_offset(pack, index_pos);
+		struct object_info oi = *data->request;
+
+		if (packed_object_info_with_index_pos(pack, offset,
+						      &index_pos, &oi) < 0) {
+			mark_bad_packed_object(pack, oid);
+			return -1;
+		}
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
+{
+	do {
+		if (*a != *b)
+			return 0;
+		a++;
+		b++;
+		len -= 2;
+	} while (len > 1);
+	if (len)
+		if ((*a ^ *b) & 0xf0)
+			return 0;
+	return 1;
+}
+
+static int for_each_prefixed_object_in_midx(
+	struct odb_source_packed *store,
+	struct multi_pack_index *m,
+	const struct odb_for_each_object_options *opts,
+	struct odb_source_packed_for_each_object_wrapper_data *data)
+{
+	int ret;
+
+	for (; m; m = m->base_midx) {
+		uint32_t num, i, first = 0;
+		int len = opts->prefix_hex_len > m->source->odb->repo->hash_algo->hexsz ?
+			m->source->odb->repo->hash_algo->hexsz : opts->prefix_hex_len;
+
+		if (!m->num_objects)
+			continue;
+
+		num = m->num_objects + m->num_objects_in_base;
+
+		bsearch_one_midx(opts->prefix, m, &first);
+
+		/*
+		 * At this point, "first" is the location of the lowest
+		 * object with an object name that could match "opts->prefix".
+		 * See if we have 0, 1 or more objects that actually match(es).
+		 */
+		for (i = first; i < num; i++) {
+			const struct object_id *current = NULL;
+			struct object_id oid;
+
+			current = nth_midxed_object_oid(&oid, m, i);
+
+			if (!match_hash(len, opts->prefix->hash, current->hash))
+				break;
+
+			if (data->request) {
+				struct object_info oi = *data->request;
+
+				ret = odb_source_read_object_info(&store->base, current,
+								  &oi, 0);
+				if (ret)
+					goto out;
+
+				ret = data->cb(&oid, &oi, data->cb_data);
+				if (ret)
+					goto out;
+			} else {
+				ret = data->cb(&oid, NULL, data->cb_data);
+				if (ret)
+					goto out;
+			}
+		}
+	}
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
+static int for_each_prefixed_object_in_pack(
+	struct odb_source_packed *store,
+	struct packed_git *p,
+	const struct odb_for_each_object_options *opts,
+	struct odb_source_packed_for_each_object_wrapper_data *data)
+{
+	uint32_t num, i, first = 0;
+	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
+		p->repo->hash_algo->hexsz : opts->prefix_hex_len;
+	int ret;
+
+	num = p->num_objects;
+	bsearch_pack(opts->prefix, p, &first);
+
+	/*
+	 * At this point, "first" is the location of the lowest object
+	 * with an object name that could match "bin_pfx".  See if we have
+	 * 0, 1 or more objects that actually match(es).
+	 */
+	for (i = first; i < num; i++) {
+		struct object_id oid;
+
+		nth_packed_object_id(&oid, p, i);
+		if (!match_hash(len, opts->prefix->hash, oid.hash))
+			break;
+
+		if (data->request) {
+			struct object_info oi = *data->request;
+
+			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
+			if (ret)
+				goto out;
+
+			ret = data->cb(&oid, &oi, data->cb_data);
+			if (ret)
+				goto out;
+		} else {
+			ret = data->cb(&oid, NULL, data->cb_data);
+			if (ret)
+				goto out;
+		}
+	}
+
+	ret = 0;
+
+out:
+	return ret;
+}
+
+static int odb_source_packed_for_each_prefixed_object(
+	struct odb_source_packed *store,
+	const struct odb_for_each_object_options *opts,
+	struct odb_source_packed_for_each_object_wrapper_data *data)
+{
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	bool pack_errors = false;
+	int ret;
+
+	if (opts->flags)
+		BUG("flags unsupported");
+
+	store->skip_mru_updates = true;
+
+	m = get_multi_pack_index(&store->files->base);
+	if (m) {
+		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
+		if (ret)
+			goto out;
+	}
+
+	for (e = packfile_store_get_packs(store); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+
+		if (open_pack_index(e->pack)) {
+			pack_errors = true;
+			continue;
+		}
+
+		if (!e->pack->num_objects)
+			continue;
+
+		ret = for_each_prefixed_object_in_pack(store, e->pack, opts, data);
+		if (ret)
+			goto out;
+	}
+
+	ret = 0;
+
+out:
+	store->skip_mru_updates = false;
+	if (!ret && pack_errors)
+		ret = -1;
+	return ret;
+}
+
+static int odb_source_packed_for_each_object(struct odb_source *source,
+					     const struct object_info *request,
+					     odb_for_each_object_cb cb,
+					     void *cb_data,
+					     const struct odb_for_each_object_options *opts)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct odb_source_packed_for_each_object_wrapper_data data = {
+		.store = packed,
+		.request = request,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+	struct packfile_list_entry *e;
+	int pack_errors = 0, ret;
+
+	if (opts->prefix)
+		return odb_source_packed_for_each_prefixed_object(packed, opts, &data);
+
+	packed->skip_mru_updates = true;
+
+	for (e = packfile_store_get_packs(packed); e; e = e->next) {
+		struct packed_git *p = e->pack;
+
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			continue;
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		    !p->pack_promisor)
+			continue;
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		    p->pack_keep_in_core)
+			continue;
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		    p->pack_keep)
+			continue;
+		if (open_pack_index(p)) {
+			pack_errors = 1;
+			continue;
+		}
+
+		ret = for_each_object_in_pack(p, odb_source_packed_for_each_object_wrapper,
+					      &data, opts->flags);
+		if (ret)
+			goto out;
+	}
+
+	ret = 0;
+
+out:
+	packed->skip_mru_updates = false;
+
+	if (!ret && pack_errors)
+		ret = -1;
+	return ret;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -291,6 +548,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.reprepare = odb_source_packed_reprepare;
 	packed->base.read_object_info = odb_source_packed_read_object_info;
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
+	packed->base.for_each_object = odb_source_packed_for_each_object;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index 42c84397eb..b8d6054c16 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1362,8 +1362,8 @@ static void add_delta_base_cache(struct packed_git *p, off_t base_offset,
 	hashmap_add(&delta_base_cache, &ent->ent);
 }
 
-static int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
-					     uint32_t *maybe_index_pos, struct object_info *oi)
+int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+				      uint32_t *maybe_index_pos, struct object_info *oi)
 {
 	struct pack_window *w_curs = NULL;
 	size_t size;
@@ -2068,262 +2068,6 @@ int for_each_object_in_pack(struct packed_git *p,
 	return r;
 }
 
-struct odb_source_packed_for_each_object_wrapper_data {
-	struct odb_source_packed *store;
-	const struct object_info *request;
-	odb_for_each_object_cb cb;
-	void *cb_data;
-};
-
-static int packfile_store_for_each_object_wrapper(const struct object_id *oid,
-						  struct packed_git *pack,
-						  uint32_t index_pos,
-						  void *cb_data)
-{
-	struct odb_source_packed_for_each_object_wrapper_data *data = cb_data;
-
-	if (data->request) {
-		off_t offset = nth_packed_object_offset(pack, index_pos);
-		struct object_info oi = *data->request;
-
-		if (packed_object_info_with_index_pos(pack, offset,
-						      &index_pos, &oi) < 0) {
-			mark_bad_packed_object(pack, oid);
-			return -1;
-		}
-
-		return data->cb(oid, &oi, data->cb_data);
-	} else {
-		return data->cb(oid, NULL, data->cb_data);
-	}
-}
-
-static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
-{
-	do {
-		if (*a != *b)
-			return 0;
-		a++;
-		b++;
-		len -= 2;
-	} while (len > 1);
-	if (len)
-		if ((*a ^ *b) & 0xf0)
-			return 0;
-	return 1;
-}
-
-static int for_each_prefixed_object_in_midx(
-	struct odb_source_packed *store,
-	struct multi_pack_index *m,
-	const struct odb_for_each_object_options *opts,
-	struct odb_source_packed_for_each_object_wrapper_data *data)
-{
-	int ret;
-
-	for (; m; m = m->base_midx) {
-		uint32_t num, i, first = 0;
-		int len = opts->prefix_hex_len > m->source->odb->repo->hash_algo->hexsz ?
-			m->source->odb->repo->hash_algo->hexsz : opts->prefix_hex_len;
-
-		if (!m->num_objects)
-			continue;
-
-		num = m->num_objects + m->num_objects_in_base;
-
-		bsearch_one_midx(opts->prefix, m, &first);
-
-		/*
-		 * At this point, "first" is the location of the lowest
-		 * object with an object name that could match "opts->prefix".
-		 * See if we have 0, 1 or more objects that actually match(es).
-		 */
-		for (i = first; i < num; i++) {
-			const struct object_id *current = NULL;
-			struct object_id oid;
-
-			current = nth_midxed_object_oid(&oid, m, i);
-
-			if (!match_hash(len, opts->prefix->hash, current->hash))
-				break;
-
-			if (data->request) {
-				struct object_info oi = *data->request;
-
-				ret = odb_source_read_object_info(&store->base, current,
-								  &oi, 0);
-				if (ret)
-					goto out;
-
-				ret = data->cb(&oid, &oi, data->cb_data);
-				if (ret)
-					goto out;
-			} else {
-				ret = data->cb(&oid, NULL, data->cb_data);
-				if (ret)
-					goto out;
-			}
-		}
-	}
-
-	ret = 0;
-
-out:
-	return ret;
-}
-
-static int for_each_prefixed_object_in_pack(
-	struct odb_source_packed *store,
-	struct packed_git *p,
-	const struct odb_for_each_object_options *opts,
-	struct odb_source_packed_for_each_object_wrapper_data *data)
-{
-	uint32_t num, i, first = 0;
-	int len = opts->prefix_hex_len > p->repo->hash_algo->hexsz ?
-		p->repo->hash_algo->hexsz : opts->prefix_hex_len;
-	int ret;
-
-	num = p->num_objects;
-	bsearch_pack(opts->prefix, p, &first);
-
-	/*
-	 * At this point, "first" is the location of the lowest object
-	 * with an object name that could match "bin_pfx".  See if we have
-	 * 0, 1 or more objects that actually match(es).
-	 */
-	for (i = first; i < num; i++) {
-		struct object_id oid;
-
-		nth_packed_object_id(&oid, p, i);
-		if (!match_hash(len, opts->prefix->hash, oid.hash))
-			break;
-
-		if (data->request) {
-			struct object_info oi = *data->request;
-
-			ret = odb_source_read_object_info(&store->base, &oid, &oi, 0);
-			if (ret)
-				goto out;
-
-			ret = data->cb(&oid, &oi, data->cb_data);
-			if (ret)
-				goto out;
-		} else {
-			ret = data->cb(&oid, NULL, data->cb_data);
-			if (ret)
-				goto out;
-		}
-	}
-
-	ret = 0;
-
-out:
-	return ret;
-}
-
-static int packfile_store_for_each_prefixed_object(
-	struct odb_source_packed *store,
-	const struct odb_for_each_object_options *opts,
-	struct odb_source_packed_for_each_object_wrapper_data *data)
-{
-	struct packfile_list_entry *e;
-	struct multi_pack_index *m;
-	bool pack_errors = false;
-	int ret;
-
-	if (opts->flags)
-		BUG("flags unsupported");
-
-	store->skip_mru_updates = true;
-
-	m = get_multi_pack_index(&store->files->base);
-	if (m) {
-		ret = for_each_prefixed_object_in_midx(store, m, opts, data);
-		if (ret)
-			goto out;
-	}
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		if (e->pack->multi_pack_index)
-			continue;
-
-		if (open_pack_index(e->pack)) {
-			pack_errors = true;
-			continue;
-		}
-
-		if (!e->pack->num_objects)
-			continue;
-
-		ret = for_each_prefixed_object_in_pack(store, e->pack, opts, data);
-		if (ret)
-			goto out;
-	}
-
-	ret = 0;
-
-out:
-	store->skip_mru_updates = false;
-	if (!ret && pack_errors)
-		ret = -1;
-	return ret;
-}
-
-int packfile_store_for_each_object(struct odb_source_packed *store,
-				   const struct object_info *request,
-				   odb_for_each_object_cb cb,
-				   void *cb_data,
-				   const struct odb_for_each_object_options *opts)
-{
-	struct odb_source_packed_for_each_object_wrapper_data data = {
-		.store = store,
-		.request = request,
-		.cb = cb,
-		.cb_data = cb_data,
-	};
-	struct packfile_list_entry *e;
-	int pack_errors = 0, ret;
-
-	if (opts->prefix)
-		return packfile_store_for_each_prefixed_object(store, opts, &data);
-
-	store->skip_mru_updates = true;
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		struct packed_git *p = e->pack;
-
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
-		    !p->pack_promisor)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
-		    p->pack_keep_in_core)
-			continue;
-		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
-		    p->pack_keep)
-			continue;
-		if (open_pack_index(p)) {
-			pack_errors = 1;
-			continue;
-		}
-
-		ret = for_each_object_in_pack(p, packfile_store_for_each_object_wrapper,
-					      &data, opts->flags);
-		if (ret)
-			goto out;
-	}
-
-	ret = 0;
-
-out:
-	store->skip_mru_updates = false;
-
-	if (!ret && pack_errors)
-		ret = -1;
-	return ret;
-}
-
 static int extend_abbrev_len(const struct object_id *a,
 			     const struct object_id *b,
 			     unsigned *out)
diff --git a/packfile.h b/packfile.h
index dd97684e70..0097de0b27 100644
--- a/packfile.h
+++ b/packfile.h
@@ -227,21 +227,6 @@ int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
 			    enum odb_for_each_object_flags flags);
 
-/*
- * Iterate through all packed objects in the given packfile store and invoke
- * the callback function for each of them. If an object info request is given,
- * then the object info will be read for every individual object and passed to
- * the callback as if `packfile_store_read_object_info()` was called for the
- * object.
- *
- * The flags parameter is a combination of `odb_for_each_object_flags`.
- */
-int packfile_store_for_each_object(struct odb_source_packed *store,
-				   const struct object_info *request,
-				   odb_for_each_object_cb cb,
-				   void *cb_data,
-				   const struct odb_for_each_object_options *opts);
-
 int packfile_store_find_abbrev_len(struct odb_source_packed *store,
 				   const struct object_id *oid,
 				   unsigned min_len,
@@ -354,6 +339,8 @@ extern int do_check_packed_object_crc;
  */
 int packed_object_info(struct packed_git *pack,
 		       off_t offset, struct object_info *);
+int packed_object_info_with_index_pos(struct packed_git *p, off_t obj_offset,
+				      uint32_t *maybe_index_pos, struct object_info *oi);
 
 void mark_bad_packed_object(struct packed_git *, const struct object_id *);
 const struct packed_git *has_packed_and_bad(struct repository *, const struct object_id *);

-- 
2.55.0.rc0.786.g65d90a0328.dirty

