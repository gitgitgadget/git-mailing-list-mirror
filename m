Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A11358361
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 06:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773903195; cv=none; b=cdFNVaVOCIfLC1z0tZcXiNN+ojU2eQPI+IhkUA+Fvwu7O9cWGSoCydt3EmbYMMBWKve429tzKZ72IfYHS+3Ahx1pHHAKlkg5/qRAQ91bPVN/uA/bZsSDVC7tmHee8DKVTMc5NdS/+JoB23NbYYvM7yUHyYP4S8IOCoz3u9V7tZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773903195; c=relaxed/simple;
	bh=dGdbUvk8uDHVJ7gCcxF0V9qBr5dsNNK9saRPJ2HiCns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ksAB0U2a/UbtR6b7D+1mZjU/m59ai15sLpKWKiHdlxH8PIvJ0XtgUKHNyZPeZvDiDNJXXefQ+rcqkIkDefVq82F+CGZTRzdHM+Y1KSI3yI8Khge3v3/wdS2tX9jA+Umdekf3TWhH3DX1xbfyRmX0wEpiMKvw0KAoG2HT1NjnwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=esrOr60w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WTfSBmYm; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="esrOr60w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WTfSBmYm"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4B7DEEC0279
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 02:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773903192;
	 x=1773989592; bh=/GEug5zV7KSban4QqNWhb/jYTu8XoEkrrZkDJatb2d4=; b=
	esrOr60wfGGV3T8elU3S949Tv56TZFDPqgfUAw6Dun5IcvOUhri9rV0SmGvjTvJN
	/c3CfF4r0fMUA2tzc/hSdsDxYgW4eTNIBDh46bLXI8vMJdMGe3uvsiSyen0VdHGo
	PVhzuYXgi1Fw/IwZMlnLETHPqmQ2L0Yyr2zeOBNyfKiGQozRgQOX0KVuzeos1CNf
	f5dCuXrrR/n2JUQqsvAcl0elRd7WFJCMX3annRHOJLX8RXIjy/IDFWlGJRGVPYE7
	Cd2CuhBR/V6IQ7prueKLiftuy3uINK2bVlhOnFb+rb4RgwrlPRZFE/UEktSjGyaR
	1VxMfQlrjBPLVoguBhfYWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773903192; x=
	1773989592; bh=/GEug5zV7KSban4QqNWhb/jYTu8XoEkrrZkDJatb2d4=; b=W
	TfSBmYm4roVoOaq69kU3sK2WMzQwN7h1QtGb3RTw9s8tfkDgLPiDRt/AwpsNg4HB
	oT/k/7ngY5tyAkZMB8fhvQSbuxfXiwa0KXJG8olthFhqzUbnQLvkAysz9eOSaah4
	cqtszkV6oguPqwQwytcPBS6G3pZZij2x0+79SsZ5O5dIxiOW3/wZ49fWWVP80UnG
	XDDaYe6ESSheYcRQrHCAzvpc8vN12XGC85B70unvVOeT+FWvnMJUGG3CoYSaXgKO
	raaXCXsSIwlwriBSRrcno0m42+sWdrX2wpzvsqiZf/C3+349JeyWaH/n5CVCOfEz
	oHpXxECauivcWFZ9qahvA==
X-ME-Sender: <xms:WJ27aW4OL59B8Fxvrqm5FagJHGiuSy5w94LMXDlxP5tghgpjk9Ne4Q>
    <xme:WJ27aW0NCGb_60R7tUJgcw4GTNBNDSPE9yIhG5xn4d0duygdzkaIVRqjj5u9HOQRA
    IB4agmaTAdWxkocIGHjsDnBHULHQ1a5Zfj2WlCJ5TkXM_upou2dSQ>
X-ME-Received: <xmr:WJ27abEQHBDrakcD7HwW4FTZXx9botycgG3KBqIYzDtCuU5hK-uHq0UkOJ09ihLK4PZFiYzFwGOGeXd3l5LGhcnxHI-RVSlH2ZFQ6TZn3V0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:WJ27aYSik1wrtLgDfprSjXKQ6LI_4seOUha707ZbGKKUz-hOcqKrEA>
    <xmx:WJ27aaC_s_lc10iZa_5ZdXCp1SGlOxPwd6ZHRn9_-8Xmcpjsln-cGg>
    <xmx:WJ27aQ1E3fiTlkPwW23cxW0xU7tJVCko-aTRaXY22e0FrPSPerjC4w>
    <xmx:WJ27aQWxVNJT1OzemfEjQ2hbkZD0O-NgPfk-HeRfrtqfiAp9LQwlhA>
    <xmx:WJ27afaahS7CrpGr5A23E8NtdqsTAfZhzOSzxav9wZPMhx1pW6Esnh0G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 19 Mar 2026 02:53:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b64dbbe1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 19 Mar 2026 06:53:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Mar 2026 07:53:01 +0100
Subject: [PATCH 03/14] odb: introduce `struct odb_for_each_object_options`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-b4-pks-odb-source-abbrev-v1-3-5ddebad292b0@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
In-Reply-To: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `odb_for_each_object()` function only accepts a bitset of flags. In
a subsequent commit we'll want to change object iteration to also
support iterating over only those objects that have a specific prefix.
While we could of course add the prefix to the function signature, or
alternative introduce a new function, both of these options don't really
seem to be that sensible.

Instead, introduce a new `struct odb_for_each_object_options` that can
be passed to a new `odb_for_each_object_ext()` function. Splice through
the options structure into the respective object database sources.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  7 +++++--
 builtin/pack-objects.c | 12 +++++++-----
 commit-graph.c         |  5 ++++-
 object-file.c          |  6 +++---
 object-file.h          |  2 +-
 odb.c                  | 26 +++++++++++++++++++-------
 odb.h                  | 16 ++++++++++++++++
 odb/source-files.c     |  8 ++++----
 odb/source.h           |  6 +++---
 packfile.c             | 12 ++++++------
 packfile.h             |  2 +-
 11 files changed, 69 insertions(+), 33 deletions(-)

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
index f0b029ff0b..ddcc8e81b4 100644
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

