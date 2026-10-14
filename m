Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8069C4CDDF8
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968054; cv=none; b=aE88M7NnRO888F7nIWASfKEt8pc1bGMwIlAcYN1f1tGOFD/3yirBE6rm70A8p33BU2x5TNgA+8F1ONnokw+mjUlk4wHMattBHi/oGouR2Rhx/oD7yNTNfbPvD6ZejZ7nST+VvB+n8A9PbljmBxF5F9vGCdoJ7nE6gW+wdj2pcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968054; c=relaxed/simple;
	bh=3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QKdAnRFBVJhmkSa+F+wEkQJg8TmU5hndBw3udfY5eFOfFoeHBbcW1BDKvjkekp8OCk77dJVD7EwFQivOaNuTNJ1ik5c3v5PpHfCSkV9kb/JcbX7kGzOVkefB878OzhaqxyCA+HB93ue/HuBKSZ99t14NS1RlTjMlIdC7n7e7lm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fpIr/UvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tEBmWV9j; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fpIr/UvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tEBmWV9j"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 9586AEC0252
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 04:54:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 Oct 2026 04:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1791968051;
	 x=1792054451; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=
	fpIr/UvOxx/cm1WbVIjEWZvEaOZVdeNuXqfNspK97hNXhip9ufu+T48kO+FPmTPH
	oM1wD/hax0zJpb+8uNgLrmh0jYa0XCyl0YOMLpA59ag7v9+FvlNqU5L1aJdf6k4x
	FlPgdwRyDYSXsTfLzH50PTrkz4rvJIf65lJCiG4va6VAQE5C4m08GdWnVDizyENb
	VTWtKAxkMuUjIJUE38BsNVENBOaxybhIwhFbjQWNTpgVqqw3NHIvj5hTLj5gzYzr
	RYLUVd6J0XLMvVID6IHuoe32HZu00hgd4q1tgfoO1VxwJGAyAYOU+Adt7cuduV1b
	H5dwUztY7YiJHsuucul8aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791968051; x=
	1792054451; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=t
	EBmWV9jw0jT3LySe2gVQ+Uobb40xUDq/mqUm4VMcu7p9SOs2SfimdInX0QdpUoe+
	Fo2q52RjdZT1hIevHgbD6AU2S7lrDU9rgTS6VAVv0cZfQtvtLZ54aQr2d3uZiCX/
	Utsmo579prRaA3QpADjKocHHBNgU/BGyS4vVUUdoLqdwv2EGavuUIbM6g78wnqSF
	IRHHhaO4UUTAWMmZZAEb6QDB+AClX2WVCciR8gJtkB+QedfZabQ43We9kSnPEnxZ
	yjf3RfcIJa6ujSs9k3761slkvBFvVhJxkKmSEqN84HpPc+verNDG3TmGk7rMx0UO
	/ihh5T33rS9Bv0YtteCyw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791968051; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:hs9khJL03/49+TBSMnTvQsR94m/o0KuoRxjE5lZZsN1gcDZ
	MxKckA8f6PuSmMCYvsaKHCAPxl3TEUIA4OqIv6QQur/bTnCiwN4RdLUsHvGR/OZK
	Rj4xnujY5fadR7jMSBxH3C0nA3C4NR9Nkpk3Rb5h24Hoy4JPz0FQ5NNRrM5Gr62O
	ZG4llC5ty45ypueM8KIXuKp2z0ijvB2j6A4IyGFQE0EGpqBMC2Ci/IPLgO3JXFLm
	oj/Ism3RiwyutB5kis04mtOg8RgaiCRkx9Y2ll/ykhCOW8yYc20S/ZHEyW6FbiB6
	L2nIklq632Fynl+tHOFhgwre+YeBSUywacuJLHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XRqsIlyerLcx7s5lejelN4EU+/crzPLObbuRfcvfNoQ=:3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
X-ME-Sender: <xms:M0PPaoziqiltdC2ueSEeQPTcG9l7Bf_lzwgoPQH3Ml2patFhihjEkQ>
    <xme:M0PPajT-iun6MMoOFHuECmHXPXcllzTv2Cs4ASXAcBZw2bhEAC3dPemcRLhg8g3kl
    0gh5sTyknZeEoeac02msFGgCe1764wRkeM2drV83DaKJVezanOX>
X-ME-Received: <xmr:M0PPavUBay7q6ByPfALcfKvCiRBM2qX103JelAf1sO9Q0tRQ5j0TBg>
X-ME-Proxy-Cause: dmFkZTEmhPxbaWbmdmiM5YEoMDthvvqhAUT+PKR/t9E8V5ghj/QIC7S7c2AowCcJWUx2Ty
    IszGpMH0nxcrIYvdd/LiEJoDG3jBQeBKGnlQkVIjtcy5ewOb1klrSiTckMthzKvmfXlCiT
    xEVmh4GzpWDY6QhEsKIwwQvKr36ua8q3OVqGGGm6UjfL+5v1GNfFQ1xw/jSxWAwx6TsbAd
    zuvjcrmPGyY2xkKKSCqEw+4getqwIObIDFrJsS/rUYL3LL4a0RPMzuZ9rKYQlumWKWmSzs
    +zvNzZI8bjzyj6OTlrQZJgsfV7snNGycVu11AD4DBUT2jF0sQSI+xvCQozJ9gU7ON8O0IB
    K6dDo91yFedy5lGMkUjNK+aWKWCv52P5wRHMD/p4oM4Glv2Bw18ZO9deIMwfbUTQ94894f
    2W/DwQiavZODsxk+/1GtNXjkhG+6zWiHWALQpRiRRwFJuIdqO7JPpAMkgoVSqH7jwa5yR3
    tk/CMB6yt+ij3aY3XLJpID7NdZsqwiE4dy7pnC7w6BepGaHyGoraUzF9psB7KCmUaZGfaH
    IiABoZUpSfErTXXIO+GIgCGH7VLqK0w8nXbeAuFmMc5FNolvMon9Zl6dPO5ua4XRUhN4ws
    QDNStNhQ294JAgdmfY6mmzCmy6F+sdfSqijs6eVs47bzXuiy7xQ43vRALscg
X-ME-Proxy: <xmx:M0PPalYBTgSYX4vB_j6dcll1bwTfLwK1V0PPfN3EgMw1S5EM27oIPg>
    <xmx:M0PPal0L82Y4THeRlo5xfUAWUUkUzhZxM2zRcqPgk9t4O5xlYKzJEg>
    <xmx:M0PPaniyA6CRsY7jeajMWwvxH9oJ7cx-Azb-pXO2uN-nj3GHJmylcA>
    <xmx:M0PPapbgdZJ83r5eKm6DRRFeIQYbAREVmRAuXeiY5uEWUYF2l91aCQ>
    <xmx:M0PPapOlMLENmMNcIQDtA9gxmcib22EQa0sba9zOR6Q8LPo3uTD6DoZS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 04:54:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57293ec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 08:54:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 Oct 2026 10:53:50 +0200
Subject: [PATCH v2 6/6] odb/source: drop `local` flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-pks-odb-files-alternates-cleanups-v2-6-fed9b2caa3be@pks.im>
References: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
In-Reply-To: <20261014-pks-odb-files-alternates-cleanups-v2-0-fed9b2caa3be@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>
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

