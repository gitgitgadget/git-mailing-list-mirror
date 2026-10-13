Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C0038886B
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 07:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791877017; cv=none; b=QvSCoU/EgQg3840KOQ3bedkznfg8PfipmwxY9DdeA3bRf7W1e+BlMYBtvhUtDcsF4nmYH70wAvhGjqlygvLB90xqPj+l7ljTcysISIQGYtNlwRcs2UB/O1oE/mn7Jc9zS4Wj/Oey3JveruNZkW5SIfl4vIjcCSTgUHaBOJDwA7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791877017; c=relaxed/simple;
	bh=3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gM+3mK4C7A80fyT3kfUVgGm9lH8GIQxf7NkLMeEP86XmGX05f4Nhe5wNjWR2GYwmxP+t5yKSfDGPv5olDfLVh8OozwPuI9i7k6Iwuae0z7Z/5Cq4Idb6y+Eqa2/0z7gX0GPe/NA29S+KaW0WxVELau3n8XNh2wOn6kf3FT3ZMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cYXmWoUy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SUH9bq64; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cYXmWoUy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SUH9bq64"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E12B41400152
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 03:36:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 13 Oct 2026 03:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791877014;
	 x=1791963414; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=
	cYXmWoUybbxWkF+tZ7xdOd7RWaWAf7tYYySsyFI+f474cL8Ju4emkrc6J5xARNNT
	/CKM9bWsdupRPlaKoAR328OkMH4f5aYla5bLKgleu8IBA/rU3/aRUFeLu09I6OTi
	7JTnF0w1LZXIbLh0gA0lxzSKJcEobbRoAsvwa225wvruJAxZdp3CXbVrkGBYPicX
	KI1/cp2Ut+3aFSrh9YjPE42DQ1lVmDxlzSz7LQxJ9SSn+A/9frnwmiO/ZaCb4JbE
	lwONYVOzmTfEHxcerTlPj3AzgXa9vmsR46VGYHvHw7XK2ORskem0SNp4tgZucgj9
	tkFUEYRpL4SQRqDZ9CyU5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791877014; x=
	1791963414; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=S
	UH9bq64Z1PgM5Edz+2TSoCMJEPkX3hSmtnnb9Joe0dISq6AWZGXi64A0h4BvJxR+
	EmPvCSCsgYHRLxFZmNSDcysgjkIMiWci891QkoJnIPbSuN3P4J+n4NTcj66qh6hY
	6pZ445Gk/zs8OFKojCkbY+mHCGFsrVNtoNYZLHgERCntX0WVyAdPHXn/3YP7f+am
	GlMFN6OZogZ0nRJtUKhBZO0tAeTX2O6Yn2PaKP3YIw0DeX/YYT+MWy8X78dP6feK
	HNnT+0KipeRvqd4h2f8U1mCOgn5T5v9dnb+1HD1ii9mh4fH6Fv8kjuIYX/t6+xI6
	5eFH9KgOfREsfs4+WtxUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791877014; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pNCI0f1XTJpDs3oRuuJekoQ45ja6v507Lcxp7fSIqXzmxxz
	zJjtO9AYXBRl6n3+tvw3whKaCrqNopXwmWQNQzfckIueJEkyPVCyAx2CEgA79ykd
	cn+G7wifbFZuuEdKisR5ucxGW7/8gcaqUZiySHnl+Lyq242PqzQEFAsIyGZxzNKA
	B95IP7DitqFgUpnQ6TxWyLu1P+Qt3Titpj8RXcFdoo6FltGF8qK5B51KL8vfyfFE
	iBFzfTxK2T/hEWcgeYQlYciX7pRrejQaXWdJPat/8XlFkchSoitY+3XfTpDQeGzc
	YnOpwbzzTgDkR23YCy5KglK/fI1I9FIMOVPJ+ZQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sW8mw1ZDLnQ5hROCLcKzDjos7Ej3HeXK74NSi2r+Jl0=:3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
X-ME-Sender: <xms:lt_NapVC-1gLi-ynNIWO9tXiLxS5BbPVi4Ft5cp1z3HweoixNljNLQ>
    <xme:lt_NahAv--k3bVFiRAhYOyj8MBaEPGudIw7-kMGZX6YFctRYW5CNTqiyYi0cbPhT_
    m2X45jr3tkv7DdpPhy4iZGPKTymHATJCj1UNcwMvYnb58HGA34dHXU>
X-ME-Received: <xmr:lt_NaixyecPepyD_gIxDLMryMj4_kInitt8UefH7-vkSgMYjUZYJgQ>
X-ME-Proxy-Cause: dmFkZTEFUVtx0m1gVgvNwfak4FvGqNwTOGPAovQRfkApREj2T7mxel/rrbDAojqhTaTULx
    av4CfVjP0KE1DOqoFDpaKjw8rpFImExzn183toIDOGLzFoICAzeDh7WoadDfFSos4NwGeq
    AVQGNMhic9Efyki9sto/FeW5OnRJESUaCCtb1BKIpS32JxZfRcJtch0K1zvGmmVaBbq56U
    gb1tLWfysaH/3Y2AgzcjOtJtBO+J/y8R3GpcKKeecMWvbAEV1gp3TL0CNpZgq2MlEs0/6Q
    r0IEitoKCMe9DwPsTW1OjN7IR/VgLutSFNc2wIrT7oWnh5s6MahxoSojtzP4nQ46RZLIaB
    x59I1Yce/MdWV2oNbLcEYFr8TGjhYc88rUoSDsaU4o5Ma3LJeYLFRMuZeYm3YNgsYfApZb
    P/c3CiZRHEXBghHcnUUpzpyQjc6XoL1H+ZcQd4eUJC9b//+j1gqH1ih07qrbSYpK6DLDfa
    bGNiCHVDTv68leyEE/EbKfmwXDzfXnIxI5uoYpR/Gunz7OvpqjpBSS6kTamIsqiPZigHYs
    jraj0JtiBak1/saGyDfWwD5jR2TVBK3DcPIz2dOzitCqyz7ac8NGspg77j+nEdnrsAKsnT
    mAFUntvG+juWhp2iGTyM9qNjM5f9a7gm96EDjWdEyurOq1nRGY8nxWIncl6g
X-ME-Proxy: <xmx:lt_NamCoo6g-4QdSAuBnUi65OYwTLUl3e_lmmKxe8ujxEIXLHKRwrA>
    <xmx:lt_NanZs1rn7quA-B-tuaf6BnEhd9Akl_7UDLXhg3Hb7WbxcqUTcCQ>
    <xmx:lt_NamizFyFEWk4GnNnsnhIperbXJfYhFLlQO9TNGzzP4riI7zQi2Q>
    <xmx:lt_Nah7d-WM78WtBL04MyN5PQoURQSrO9ABmOLCG82CUSx1hbZPCxg>
    <xmx:lt_NaqToSDJW5hZ5Urowwtjfp9Rte7ZLvRyPl1u2QfH0p9CmLWksk7vT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Oct 2026 03:36:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 29e2b92e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Oct 2026 07:36:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Oct 2026 09:36:29 +0200
Subject: [PATCH 5/5] odb/source: drop `local` flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-pks-odb-files-alternates-cleanups-v1-5-b7030ff2b26f@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
In-Reply-To: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>
X-Mailer: b4 0.15.2

The `local` flag indicates whether a given `struct odb_source` is a
local source or not, where "local" is defined as being the object
directory that is directly attached to the current repository. But now
that alternates are handled in the "files" backend, this property is not
something that even makes sense anymore to have on the generic source.

In fact, we already have a partial replacement for this field in `struct
odb_files_dir`. The only other site that requires it is the packed
object database source, because it propagates the bit into the packfiles
it is opening.

Drop the flag from `struct odb_source` and instead move it into the
packed source.

Note that we stop considering the `local` bit when iterating through all
loose objects with the `ODB_FOR_EACH_OBJECT_LOCAL_ONLY` flag. This is
fine though, as we already handle the flag in the "files" backend
itself, where we skip over any object directory that is not marked as
local.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 midx.c                |  2 +-
 odb/source-files.c    |  4 ++--
 odb/source-inmemory.c | 10 +++++++---
 odb/source-loose.c    |  7 ++-----
 odb/source-loose.h    |  3 +--
 odb/source-packed.c   |  5 +++--
 odb/source-packed.h   |  7 +++++++
 odb/source.c          |  4 +---
 odb/source.h          | 13 +------------
 repack.c              |  2 +-
 10 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/midx.c b/midx.c
index dc0c728401..2d4feeeade 100644
--- a/midx.c
+++ b/midx.c
@@ -470,7 +470,7 @@ int prepare_midx_pack(struct multi_pack_index *m,
 	strbuf_addf(&pack_name, "%s/pack/%s", packed->base.path,
 		    m->pack_names[pack_int_id]);
 	p = packfile_store_load_pack(packed,
-				     pack_name.buf, packed->base.local);
+				     pack_name.buf, packed->local);
 	strbuf_release(&pack_name);
 
 	if (!p) {
diff --git a/odb/source-files.c b/odb/source-files.c
index 9788a5adf4..5b4277fbfd 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -33,7 +33,7 @@ struct odb_files_dir *odb_files_dir_new(struct object_database *odb,
 	CALLOC_ARRAY(dir, 1);
 	dir->abspath = absolute_pathdup(path);
 	dir->local = local;
-	dir->loose = odb_source_loose_new(odb, path, local);
+	dir->loose = odb_source_loose_new(odb, path);
 	dir->packed = odb_source_packed_new(odb, path, local);
 
 	return dir;
@@ -1265,7 +1265,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 		object_dir = xstrfmt("%s/objects", odb->repo->commondir);
 
 	CALLOC_ARRAY(files, 1);
-	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir, true);
+	odb_source_init(&files->base, odb, ODB_SOURCE_FILES, object_dir);
 
 	hashmap_init(&files->dirs_by_path, odb_files_dir_by_path_cmp, files, 0);
 	files->dirs_paths_icase = -1;
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 868e723c81..75cf29fa9d 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -161,8 +161,12 @@ static int odb_source_inmemory_for_each_object(struct odb_source *source,
 	};
 	struct object_id null_oid = { 0 };
 
-	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
-	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
+	/*
+	 * In-memory objects are neither promisor objects nor do they live in
+	 * the local object directory, so there is nothing to iterate over.
+	 */
+	if (opts->flags & (ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
+			   ODB_FOR_EACH_OBJECT_LOCAL_ONLY))
 		return 0;
 	if (!inmemory->objects)
 		return 0;
@@ -369,7 +373,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	struct odb_source_inmemory *source;
 
 	CALLOC_ARRAY(source, 1);
-	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
+	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source");
 
 	source->base.free = odb_source_inmemory_free;
 	source->base.close = odb_source_inmemory_close;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 180ce7403f..50cb388c35 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -464,8 +464,6 @@ static int odb_source_loose_for_each_object(struct odb_source *source,
 	/* There are no loose promisor objects, so we can return immediately. */
 	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
 		return 0;
-	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
-		return 0;
 
 	if (opts->prefix)
 		return oidtree_each(odb_source_loose_cache(loose, opts->prefix),
@@ -1108,13 +1106,12 @@ static int odb_source_loose_fsck(struct odb_source *source,
 }
 
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
-					      const char *path,
-					      bool local)
+					      const char *path)
 {
 	struct odb_source_loose *loose;
 
 	CALLOC_ARRAY(loose, 1);
-	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path, local);
+	odb_source_init(&loose->base, odb, ODB_SOURCE_LOOSE, path);
 
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 7c7e845fe3..a6ae808662 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -34,8 +34,7 @@ struct odb_source_loose {
 };
 
 struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
-					      const char *path,
-					      bool local);
+					      const char *path);
 
 /*
  * Cast the given object database source to the loose backend. This will cause
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 48fe00c2bc..7fcbbb4fe9 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -740,7 +740,7 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 	      midx_contains_pack(data->source->midx, file_name))) {
 		char *trimmed_path = xstrndup(full_name, full_name_len);
 		packfile_store_load_pack(data->source,
-					 trimmed_path, data->source->base.local);
+					 trimmed_path, data->source->local);
 		free(trimmed_path);
 	}
 
@@ -988,8 +988,9 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 	struct odb_source_packed *packed;
 
 	CALLOC_ARRAY(packed, 1);
-	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path, local);
+	odb_source_init(&packed->base, odb, ODB_SOURCE_PACKED, path);
 	strmap_init(&packed->packs_by_path);
+	packed->local = local;
 
 	packed->base.free = odb_source_packed_free;
 	packed->base.close = odb_source_packed_close;
diff --git a/odb/source-packed.h b/odb/source-packed.h
index a0f6b5096d..e8a7b08fbb 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -41,6 +41,13 @@ struct odb_source_packed {
 	 */
 	struct strmap packs_by_path;
 
+	/*
+	 * Whether this store is part of the local object directory of the
+	 * owning repository. Packfiles loaded via this store inherit this
+	 * flag via `pack_local`. Stores for alternates are not local.
+	 */
+	bool local;
+
 	/*
 	 * Whether packfiles have already been populated with this store's
 	 * packs.
diff --git a/odb/source.c b/odb/source.c
index b25ef14df8..4155fc22da 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -32,12 +32,10 @@ struct odb_source *odb_source_new(struct object_database *odb,
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
 		     enum odb_source_type type,
-		     const char *path,
-		     bool local)
+		     const char *path)
 {
 	source->odb = odb;
 	source->type = type;
-	source->local = local;
 	source->path = xstrdup(path);
 }
 
diff --git a/odb/source.h b/odb/source.h
index 0cfe762376..8b839caa39 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -58,14 +58,6 @@ struct odb_source {
 	/* The type used by this source. */
 	enum odb_source_type type;
 
-	/*
-	 * Figure out whether this is the local source of the owning
-	 * repository, which would typically be its ".git/objects" directory.
-	 * This local object directory is usually where objects would be
-	 * written to.
-	 */
-	bool local;
-
 	/*
 	 * Path to the source. If this is a relative path, it is relative to
 	 * the current working directory.
@@ -304,8 +296,6 @@ struct odb_source *odb_source_new(struct object_database *odb,
 
 /*
  * Initialize the source for the given object database located at `path`.
- * `local` indicates whether or not the source is the local and thus primary
- * object source of the object database.
  *
  * This function is only supposed to be called by specific object source
  * implementations.
@@ -313,8 +303,7 @@ struct odb_source *odb_source_new(struct object_database *odb,
 void odb_source_init(struct odb_source *source,
 		     struct object_database *odb,
 		     enum odb_source_type type,
-		     const char *path,
-		     bool local);
+		     const char *path);
 
 /*
  * Free the object database source, releasing all associated resources and
diff --git a/repack.c b/repack.c
index 53c34197f3..4c6d1f507d 100644
--- a/repack.c
+++ b/repack.c
@@ -62,7 +62,7 @@ void repack_remove_redundant_pack(struct repository *repo, const char *dir_name,
 	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
 	struct multi_pack_index *m = get_multi_pack_index(files->dirs->packed);
 	strbuf_addf(&buf, "%s.pack", base_name);
-	if (m && files->base.local && midx_contains_pack(m, buf.buf)) {
+	if (m && files->dirs->local && midx_contains_pack(m, buf.buf)) {
 		clear_midx_file(repo);
 		if (!wrote_incremental_midx)
 			clear_incremental_midx_files(repo, NULL);

-- 
2.56.0.212.g129ede20d9.dirty

