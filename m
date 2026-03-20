Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6A359A79
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990471; cv=none; b=EHXnjU60gqHZDaOvoW1P6JAkGl7a01NGeQ00Ij3Tq+d8F4v68lm+5Eui6e7dJI7RGlaEz9jV/FeOC2nDOYj+p7V/hIYDX+npJWLhnlheNDgSvXp7kLdxZT+5yjpzwcuMR5P6tgo84/dgAE5OqS5NI45n7KoiNJ1YPSN+bYDPVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990471; c=relaxed/simple;
	bh=AzAsVjC0BwTbj3ge1BmJVsFi8+9kagi1iRHROYqTEOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SkPVHEw0D+SYS1SE7qoRwkTx3jh1JLwDFKoRMAfeszzJ0af5rAv9Pb2TQELTgTxJ5zRV+DvXReOfpqLxQFUszylPBUyaqbe2mI/uDOqVKdmcp5EhyL2LhzTGduoiT9wRcLtuepJqKF9fU55hU5W2GMB1fzGp7deAkanQEMmoRms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yj7GchVM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1Fupuc6; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yj7GchVM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1Fupuc6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7995BEC01AA;
	Fri, 20 Mar 2026 03:07:49 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 20 Mar 2026 03:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990469;
	 x=1774076869; bh=llZCfpglYKmLyN4aNsG79Obf+Nr7oj2/pEwpHPjUvE0=; b=
	Yj7GchVMNYYdxDGANrhzMoOlvUjSfmsC0Zd040bEtaaMV8IHfTfowbct2KxNR+4p
	MgyRimjjuxXnWuqbXe51oEoFxmBxwzeTcCyprV+c0VtyXvcQ4FLqgxWioY0svWO8
	jzx7dbTbatHQl7TWNXDw/2qvSAnIjkIkukkLq12VbD8+YpZ+YT5I9UZSp5UVvkiW
	2YgdZJDdRljndd0k63gCPVtceXWIpDgqr69D8GFBJWUX9LgAo2/uEyP3r0Xq1jpD
	PDVxkmMPK7RkZDQBX23tMfESD60Vw+3V0cA7Rz0XAtZqs7htpEsVRn/AB5mLHjMB
	exiCNmtj3EWt5Z0RwGU3QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990469; x=
	1774076869; bh=llZCfpglYKmLyN4aNsG79Obf+Nr7oj2/pEwpHPjUvE0=; b=D
	1Fupuc6rAUn45u+LNvdU8F7qQFVMVbtQTBmWoAzi9ssD8VY0GuAlt+04SOVAdk3g
	i/lXb7sS+V1NqbhBBH3ozh3x3Hzd3fqSkW3sddm0/DVQ8nOfwpBLrzoHv0Pk1odJ
	jCeE9jZsXatJk+aeuGKY5LiauULNyyAnuEnf5cn+/dRsRPH1m6e0kiUZsi2k9k0M
	7HqbFgvJFdddzMCqMTQu+EzRkGMlHj+tECcZkIg35szImflCuJuRPxWCEZEjLemL
	OaAXnwHHXYaGgb1dwp4R6ysfysrH0uD+Tzxj63hh62+t8RjO0ynQBN5Rql6x0h4H
	5doVFypcdx5zA/7XFgbag==
X-ME-Sender: <xms:RfK8aZ_dtgS-EZW0WWfK4uVQ3Mw7hMkAd47PQgk8Ruw58VEaVjtnOQ>
    <xme:RfK8aVIuXy9NoLlOzTTsNSs07VjAanE9slndSbrVBtnwOwEgAxGRUIrbTh1yNHCdn
    titMV8s0_LC4duA_KbguSb0Rbd1xRCBMv6NqMHnHs6WwVa8n_-WLQ>
X-ME-Received: <xmr:RfK8aUZtOrOcoy2EQpjq_HeWqwGUQyxe48mId4Amb0cWI7WxrLuI2_p9TVSPKSHc1tjXlsgzbNjaUjczVOW8HuXjjWW_-IyLOmJWy0-t7_ZJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:RfK8aXLuXyeUIePBC2jDMW1w1McSKU65rufnrPu_dOwjBJ-QNVuySw>
    <xmx:RfK8aSBujAsDrHrEGKHO5hmD95OPljWme6g0qggrx9vOxbkV1p2qFA>
    <xmx:RfK8acokzWVQxZiXfaDOu0fj5mXdVoguXwCJoNXRGM6rw3pRNjLwdw>
    <xmx:RfK8adgvcSsuD9EryO8jGjkutz8U0QSkNA1jeHZ84bzWF-qvkHza-Q>
    <xmx:RfK8aRIzZbmU5TiefrTMa-MSvXUMZDRzHTnMxBYQqxwc7oj_kBEnYQNt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9384d232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:29 +0100
Subject: [PATCH v2 03/14] odb: introduce `struct
 odb_for_each_object_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-3-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The `odb_for_each_object()` function only accepts a bitset of flags. In
a subsequent commit we'll want to change object iteration to also
support iterating over only those objects that have a specific prefix.
While we could of course add the prefix to the function signature, or
alternatively introduce a new function, both of these options don't
really seem to be that sensible.

Instead, introduce a new `struct odb_for_each_object_options` that can
be passed to a new `odb_for_each_object_ext()` function. Splice through
the options structure into the respective object database sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  7 +++++--
 builtin/pack-objects.c | 12 +++++++-----
 commit-graph.c         |  5 ++++-
 object-file.c          |  9 +++++----
 object-file.h          |  2 +-
 odb.c                  | 26 +++++++++++++++++++-------
 odb.h                  | 16 ++++++++++++++++
 odb/source-files.c     |  8 ++++----
 odb/source.h           |  6 +++---
 packfile.c             | 12 ++++++------
 packfile.h             |  2 +-
 11 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b6f12f41d6..cd13a3a89f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -848,6 +848,9 @@ static void batch_each_object(struct batch_options *opt,
 		.callback = callback,
 		.payload = _payload,
 	};
+	struct odb_for_each_object_options opts = {
+		.flags = flags,
+	};
 	struct bitmap_index *bitmap = NULL;
 	struct odb_source *source;
 
@@ -860,7 +863,7 @@ static void batch_each_object(struct batch_options *opt,
 	odb_prepare_alternates(the_repository->objects);
 	for (source = the_repository->objects->sources; source; source = source->next) {
 		int ret = odb_source_loose_for_each_object(source, NULL, batch_one_object_oi,
-							   &payload, flags);
+							   &payload, &opts);
 		if (ret)
 			break;
 	}
@@ -884,7 +887,7 @@ static void batch_each_object(struct batch_options *opt,
 		for (source = the_repository->objects->sources; source; source = source->next) {
 			struct odb_source_files *files = odb_source_files_downcast(source);
 			int ret = packfile_store_for_each_object(files->packed, &oi,
-								 batch_one_object_oi, &payload, flags);
+								 batch_one_object_oi, &payload, &opts);
 			if (ret)
 				break;
 		}
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index cd013c0b68..3bb57ff183 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4344,6 +4344,12 @@ static void add_objects_in_unpacked_packs(void)
 {
 	struct odb_source *source;
 	time_t mtime;
+	struct odb_for_each_object_options opts = {
+		.flags = ODB_FOR_EACH_OBJECT_PACK_ORDER |
+			 ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
+			 ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+			 ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS,
+	};
 	struct object_info oi = {
 		.mtimep = &mtime,
 	};
@@ -4356,11 +4362,7 @@ static void add_objects_in_unpacked_packs(void)
 			continue;
 
 		if (packfile_store_for_each_object(files->packed, &oi,
-						   add_object_in_unpacked_pack, NULL,
-						   ODB_FOR_EACH_OBJECT_PACK_ORDER |
-						   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
-						   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
-						   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+						   add_object_in_unpacked_pack, NULL, &opts))
 			die(_("cannot open pack index"));
 	}
 }
diff --git a/commit-graph.c b/commit-graph.c
index c030003330..df4b4a125e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1969,6 +1969,9 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 {
 	struct odb_source *source;
 	enum object_type type;
+	struct odb_for_each_object_options opts = {
+		.flags = ODB_FOR_EACH_OBJECT_PACK_ORDER,
+	};
 	struct object_info oi = {
 		.typep = &type,
 	};
@@ -1983,7 +1986,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 	for (source = ctx->r->objects->sources; source; source = source->next) {
 		struct odb_source_files *files = odb_source_files_downcast(source);
 		packfile_store_for_each_object(files->packed, &oi, add_packed_commits_oi,
-					       ctx, ODB_FOR_EACH_OBJECT_PACK_ORDER);
+					       ctx, &opts);
 	}
 
 	if (ctx->progress_done < ctx->approx_nr_objects)
diff --git a/object-file.c b/object-file.c
index f0b029ff0b..56cbb27ab9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1849,7 +1849,7 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
 				     void *cb_data,
-				     unsigned flags)
+				     const struct odb_for_each_object_options *opts)
 {
 	struct for_each_object_wrapper_data data = {
 		.source = source,
@@ -1859,9 +1859,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 	};
 
 	/* There are no loose promisor objects, so we can return immediately. */
-	if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
+	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY))
 		return 0;
-	if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
+	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
 		return 0;
 
 	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
@@ -1914,9 +1914,10 @@ int odb_source_loose_count_objects(struct odb_source *source,
 		*out = count * 256;
 		ret = 0;
 	} else {
+		struct odb_for_each_object_options opts = { 0 };
 		*out = 0;
 		ret = odb_source_loose_for_each_object(source, NULL, count_loose_object,
-						       out, 0);
+						       out, &opts);
 	}
 
 out:
diff --git a/object-file.h b/object-file.h
index f8d8805a18..46dfa7b632 100644
--- a/object-file.h
+++ b/object-file.h
@@ -137,7 +137,7 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
 				     void *cb_data,
-				     unsigned flags);
+				     const struct odb_for_each_object_options *opts);
 
 /*
  * Count the number of loose objects in this source.
diff --git a/odb.c b/odb.c
index 350e23f3c0..3019957b87 100644
--- a/odb.c
+++ b/odb.c
@@ -896,20 +896,20 @@ int odb_freshen_object(struct object_database *odb,
 	return 0;
 }
 
-int odb_for_each_object(struct object_database *odb,
-			const struct object_info *request,
-			odb_for_each_object_cb cb,
-			void *cb_data,
-			unsigned flags)
+int odb_for_each_object_ext(struct object_database *odb,
+			    const struct object_info *request,
+			    odb_for_each_object_cb cb,
+			    void *cb_data,
+			    const struct odb_for_each_object_options *opts)
 {
 	int ret;
 
 	odb_prepare_alternates(odb);
 	for (struct odb_source *source = odb->sources; source; source = source->next) {
-		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
+		if (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local)
 			continue;
 
-		ret = odb_source_for_each_object(source, request, cb, cb_data, flags);
+		ret = odb_source_for_each_object(source, request, cb, cb_data, opts);
 		if (ret)
 			return ret;
 	}
@@ -917,6 +917,18 @@ int odb_for_each_object(struct object_database *odb,
 	return 0;
 }
 
+int odb_for_each_object(struct object_database *odb,
+			const struct object_info *request,
+			odb_for_each_object_cb cb,
+			void *cb_data,
+			unsigned flags)
+{
+	struct odb_for_each_object_options opts = {
+		.flags = flags,
+	};
+	return odb_for_each_object_ext(odb, request, cb, cb_data, &opts);
+}
+
 int odb_count_objects(struct object_database *odb,
 		      enum odb_count_objects_flags flags,
 		      unsigned long *out)
diff --git a/odb.h b/odb.h
index 9aee260105..a19a8bb50d 100644
--- a/odb.h
+++ b/odb.h
@@ -481,6 +481,15 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 				      struct object_info *oi,
 				      void *cb_data);
 
+/*
+ * Options that can be passed to `odb_for_each_object()` and its
+ * backend-specific implementations.
+ */
+struct odb_for_each_object_options {
+	/* A bitfield of `odb_for_each_object_flags`. */
+	enum odb_for_each_object_flags flags;
+};
+
 /*
  * Iterate through all objects contained in the object database. Note that
  * objects may be iterated over multiple times in case they are either stored
@@ -495,6 +504,13 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
  * Returns 0 on success, a negative error code in case a failure occurred, or
  * an arbitrary non-zero error code returned by the callback itself.
  */
+int odb_for_each_object_ext(struct object_database *odb,
+			    const struct object_info *request,
+			    odb_for_each_object_cb cb,
+			    void *cb_data,
+			    const struct odb_for_each_object_options *opts);
+
+/* Same as `odb_for_each_object_ext()` with `opts.flags` set to the given flags. */
 int odb_for_each_object(struct object_database *odb,
 			const struct object_info *request,
 			odb_for_each_object_cb cb,
diff --git a/odb/source-files.c b/odb/source-files.c
index c08d8993e3..e90bb689bb 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -75,18 +75,18 @@ static int odb_source_files_for_each_object(struct odb_source *source,
 					    const struct object_info *request,
 					    odb_for_each_object_cb cb,
 					    void *cb_data,
-					    unsigned flags)
+					    const struct odb_for_each_object_options *opts)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret;
 
-	if (!(flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
-		ret = odb_source_loose_for_each_object(source, request, cb, cb_data, flags);
+	if (!(opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY)) {
+		ret = odb_source_loose_for_each_object(source, request, cb, cb_data, opts);
 		if (ret)
 			return ret;
 	}
 
-	ret = packfile_store_for_each_object(files->packed, request, cb, cb_data, flags);
+	ret = packfile_store_for_each_object(files->packed, request, cb, cb_data, opts);
 	if (ret)
 		return ret;
 
diff --git a/odb/source.h b/odb/source.h
index 96c906e7a1..ee5d6ed530 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -140,7 +140,7 @@ struct odb_source {
 			       const struct object_info *request,
 			       odb_for_each_object_cb cb,
 			       void *cb_data,
-			       unsigned flags);
+			       const struct odb_for_each_object_options *opts);
 
 	/*
 	 * This callback is expected to count objects in the given object
@@ -343,9 +343,9 @@ static inline int odb_source_for_each_object(struct odb_source *source,
 					     const struct object_info *request,
 					     odb_for_each_object_cb cb,
 					     void *cb_data,
-					     unsigned flags)
+					     const struct odb_for_each_object_options *opts)
 {
-	return source->for_each_object(source, request, cb, cb_data, flags);
+	return source->for_each_object(source, request, cb, cb_data, opts);
 }
 
 /*
diff --git a/packfile.c b/packfile.c
index d4de9f3ffe..a6f3d2035d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2375,7 +2375,7 @@ int packfile_store_for_each_object(struct packfile_store *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
-				   unsigned flags)
+				   const struct odb_for_each_object_options *opts)
 {
 	struct packfile_store_for_each_object_wrapper_data data = {
 		.store = store,
@@ -2391,15 +2391,15 @@ int packfile_store_for_each_object(struct packfile_store *store,
 	for (e = packfile_store_get_packs(store); e; e = e->next) {
 		struct packed_git *p = e->pack;
 
-		if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
 		    !p->pack_promisor)
 			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
 		    p->pack_keep_in_core)
 			continue;
-		if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+		if ((opts->flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
 		    p->pack_keep)
 			continue;
 		if (open_pack_index(p)) {
@@ -2408,7 +2408,7 @@ int packfile_store_for_each_object(struct packfile_store *store,
 		}
 
 		ret = for_each_object_in_pack(p, packfile_store_for_each_object_wrapper,
-					      &data, flags);
+					      &data, opts->flags);
 		if (ret)
 			goto out;
 	}
diff --git a/packfile.h b/packfile.h
index a16ec3950d..fa41dfda38 100644
--- a/packfile.h
+++ b/packfile.h
@@ -367,7 +367,7 @@ int packfile_store_for_each_object(struct packfile_store *store,
 				   const struct object_info *request,
 				   odb_for_each_object_cb cb,
 				   void *cb_data,
-				   unsigned flags);
+				   const struct odb_for_each_object_options *opts);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1

-- 
2.53.0.1055.ga2ffed1127.dirty

