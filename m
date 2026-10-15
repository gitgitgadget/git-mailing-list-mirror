Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400D3BBFD0
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792042098; cv=none; b=JoJsBBU+EnoM5gDSdeQx1M4Z9nRePFhlcSgRtAHttlel7DivfV1k6UVqUYHPeZeeRM5qzWV7tislMorEsrNhauUJud8ohSSWnvnGgqbA6yg3kQjf4tYy7Klbjemp2FCEY/DNJpnyA7XlpQ450EZ6g8psR/Xq08bLNH4R1mi34Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792042098; c=relaxed/simple;
	bh=3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sFaBi+y9TgsK1T0YI7Lz+h/QDlX+J/j2b0RbkpnQrhu/V4k56jik7l+r4P/xtDarz14znN3hjT4VTa6FEPv6CIUkwBoSto++rhouYZvsxQngdrQ26szTdjqz9PrvlSJtoOM62CaUAN/OQANijRwcmUyDtUYJRiD9CSB7RdtCKkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ToHciSAE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FD3++lsq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ToHciSAE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FD3++lsq"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE0FB7A0191
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 01:28:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Oct 2026 01:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792042095;
	 x=1792128495; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=
	ToHciSAEXFttvpAZrL+XobUkjCfrp+n8eg3TR7Tqo1LO1/BZvKISfeq1UzgjVZDI
	OmLgYhm1ZEi1A1lL+SUJWHj+MNGrhLAzvEMQFRsripdH5dG56yxvIHtZlijWjzbC
	sCy4DAnqyhf1b427o7XDCbgzQEL+Xig5sq2uIVGHJzP/eo1TAFSYSqM8bIrgkIz5
	whw3hY8CaZW588pH3aZR+0a+Dk0YyvugYb1WIn25zMTE7U0P9bRc+kKWB8sW+hyz
	4TEQnkFHvHsMiCS6hduYyvwOvMxtNOhAtsQjoQet+AByqJIrzIj0jhlWWRvZLztw
	He14zKqKtFE1IugItuia9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792042095; x=
	1792128495; bh=Z6hhPluAu1mGRczNUApRehrC8rwRG2nx8ainiW8rTps=; b=F
	D3++lsq9QwSN4O/lzfyIv2NFtszgiUOWPkfjRVw3+5+2r4JqBN0yr4L1pCvDvREI
	Zs6UrZRY0rAaVo6cPNaAEcqLbcleh5lCRrRLzQ2ZfH+zaXLD7DdmVuCi953NX4nj
	qAzNi6yVs0fuRjSyxY/E0VaNqyiCz+tFnmw396sJqrtj8IjwX/hLaegVMlfPnpu+
	XDop80uRDUMhfrDX6oddiLyabK64xdF1FTFxcU24K6svHJhNwh0DKIJVwAgbPErO
	QaWLgRm3HKHSUGA8+gN1oJhJzCC+aKMYbipnaUhLjX3Fo3u+RW7vH9zLkFPpCmPT
	kDUqLeCGjXUZqxn7XvWJA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792042095; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QN84vk/zV5VCa22ryYtq3H7l7V9p2L+3zILnkYcwlyz2jnP
	CFaB5yWT5jNEVpac8HCskemdbpqIb+c+JyWesh+TlVmxzOja/j7YX+0/aQnLr+Cu
	FMpB7AipGEr8u8ldKXda7E+56prAvB5nEPNmNkCPRk/WUeiI4VLGSSzX61twZmfl
	FzoC/Uc9pZUxfbTgf5XeLwjB6Gxnk94yv4F+rxPuSgfR1mLQppQdM8z4541Ol/6D
	osHiErb7aCnzZqSdnUHR1vJFtl9SbuInQmymHE82+LCkj4ITgnzaQR2J2rCjIe2o
	dr7EgNB1MRuYrzAAuobS1I9v4yvMLbUof2JrniA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:0NFYKrdD6jj2zDmpkW+3TAbgHDKTz59ojX1Zgz0mMeo=:3mHYiI4FRjFlTxQu/6IkRNrglq26offvs3kTTwCOOrc=;
X-ME-Sender: <xms:b2TQaqpDz5nU2mgSYXQXfFGGVHVv1ihCs5-iYHp1I8TEj5YKtVZUMA>
    <xme:b2TQavhx75uK0vaOrkfuzp6IG2YT1ZnRnfwW_YvXniIUnPKPXO5cmoVb_Bi1YqusD
    W3p2cOAU5FCfuD2iKxYiUOqiVLIDiU5PtCDz77CNBf0cGVx3eOHHw>
X-ME-Received: <xmr:b2TQanjpCklYsvG6XocRjkQjm1jnmArLjjYlaVx9ctuJvn8HpZjjrXZ9QyNlTOd5c2XH2aY>
X-ME-Proxy-Cause: dmFkZTFlm4xBwnnUrq0iXE9WdfR1pU34OlAmKCKASgwyj8Sm/x+s8aMAc2Xuf+9EQW2hFH
    hrDx+1BhCYEpYhpy1Vv5FW5eK+Aa071VRZOsZB+0xHK6vEnH0QGqRITWRSTZ4DIS2q0hGr
    wU2OLM+4+2+QNPcOkBppZH8JSEu+iudyEJmIa46pFIygoEFJUM4drEyfJhNltgHvq5N+uD
    USlnpYcEuJvpjsV/mnQlNRmVC5pSN3FszjK+vz/d/rBLGEMMpX1ipe/16OOHTNCxtcpepk
    Tdp7IDVhtrO8P/F9deNsGMPzpWmOC3rMcfAEfBRIUJQKbd8UmDjR9hj167GMfCIBJuqHZY
    yuZ+/mNf3h9BzKuWMYiKGaLVl88J3s5x5awWvK7+l+hcYnAtYus73wf6HTRmXLJVsbW1ku
    D5+Olk82YbsJfGmA5XMLrq1YC30Ivhsvaae4KwCIvRpmnu3OXXdCpE5nMXXFBv3DKPLu+7
    ZKfnv2qTanU7COy05jNV5fZ88NCYHvMZCt5exRHfzIdbMcO20T8lDcDMTbidYtjyyGJm2G
    R/A9bMdKNxxdwJ0D+xwCigZwsUkvJJcTIXwA9xgNmc90V+dQa+Wp7v9mgfv+yO0VOkLgJr
    032Pz7mGyzFy2UhjqRTy3V71MGnrHnHyeYoANr2hIgUUrdT4yXktGfsi57hw
X-ME-Proxy: <xmx:b2TQalhiqLesWB84Lwm17jNhScfGks_SsH37hz2GGxJB1bYmmJdolA>
    <xmx:b2TQanKsQqkgYOBWFYcHI02L4DB1nF6AHyQzpI-FcqM3OOcWlpIbaQ>
    <xmx:b2TQakEyZtGVSrgdpBCgiXgkR7x0rjVjASesaDE38RPU_NmG6znZSA>
    <xmx:b2TQarQTzwEcOG_YMV_8r58BTPbnjEUVaL0aQiUtt-QL_PmTP1bnOw>
    <xmx:b2TQao9QEmkEyGc725GZ5s4IHuswpjNBPX0gLvmu4h_yLePNGC_JJ0pw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 01:28:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac6ff25f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 05:28:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 07:28:00 +0200
Subject: [PATCH v3 6/6] odb/source: drop `local` flag
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-odb-files-alternates-cleanups-v3-6-bfc62fd780eb@pks.im>
References: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
In-Reply-To: <20261015-pks-odb-files-alternates-cleanups-v3-0-bfc62fd780eb@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Wolfgang Kritzinger <wkritzinger@atlassian.com>, 
 Justin Tobler <jltobler@gmail.com>, Tyrie Vella <tyrielv@gmail.com>
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

