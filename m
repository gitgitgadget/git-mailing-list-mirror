Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D4447798E
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922775; cv=none; b=IfkGJiERgIjaWFRay+IPjNzqc0VOyARgzXAvAhDWyM0pJMwiWFpzEmWznyeiaiiGP45XxjbeyicATBoRA+JnORonfZMo6d5X9XaWpXIkbe+naQl52ehlA+v4spK1r1c+saa9/mlbOcwQzZDa5+ILOZjcpQD22cZJ4j5EWWYPieI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922775; c=relaxed/simple;
	bh=JBF6GG2cgU+T3YYiqFCGdgH1GOts8AMI0uxORe5c1Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FxOVA6jkbuRw9tYci8YcbvAtU5pxS1TjeP/frD9wfMTveSV30LyETalLdA3uyO+Cvh4EKdkevXtkOJHuFaTYFDXSdNN0TGsvXe8TzqeLSC4tU0N3JPW5r3vTnOgDvRojs8kGYZRQneHQB9R6uZroVmP5xNvoUaS6HQXVPYKgfpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NtkGvPCV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OpjxYdPH; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NtkGvPCV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OpjxYdPH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07ACA7A00E2;
	Tue, 20 Jan 2026 10:26:12 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 20 Jan 2026 10:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768922771;
	 x=1769009171; bh=qoauWNQ7hw9UeyeUfqv8yGkMErp7iVYasdr8tXQ+ViM=; b=
	NtkGvPCVwlL7VXmXLaTKFZGCWno7s62bC7KPKOxGYJRwWGCrcjjINodnBbxkE3x4
	6dJRCOyr+xs2fdu0k4JgZhEmb8QAqPR+fxav7FzEGbcMsEYwbxrv+qoo9qXdP6h6
	UfVVynESzX0zT7HgxpXwJsnQnyIjCcrEEVI8JpyZmGA0QPPfzK6WrCncuXvFQqLH
	7cTLW+jQazszhHMJ3jje8YhjMCcfscdXDADZRWaxVSkCTTH3z4/H/esHur49kaqq
	7Z4egIMYuhFL7xD+7rU+rKy3dFfVKL1y0+tqlGnzhDuHXrGid5UlUEGJHiBBeIEI
	K2/0REvhmB333RYeQWCAZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768922771; x=
	1769009171; bh=qoauWNQ7hw9UeyeUfqv8yGkMErp7iVYasdr8tXQ+ViM=; b=O
	pjxYdPHGdTRqHy+JnzwUPGR1zORmh1WAG70kaN8h3V+tEpeiaTNWC2mmQcsj4JLt
	cjSJimxujLTBTBg4UHIfzS4nTkNBrZ7lV77e5C8S7WP6ZKdOzZpjcOr8y3cU2km3
	nYMdqKJ4fgmMipla3WUOI+fKhk9bLbvMKhHkCw1FlQOY2hdIazD1/zpcPT2Z3Fct
	tH+6sSEKuyMjKxSlpMTLkeVpDft81vHwUEC2GzeX7370LGPZn6FMIa7N520jNs/a
	uwqC2HCbNYMacFYywffLRlOOJ/cto9I3Dy+iKEa1pLE/KDHVAKu72X4CdRfB1Vn8
	i4FFrjYm8tfcXAcI/qAkg==
X-ME-Sender: <xms:k55vaUy_zPmzmfHexxUvBqpQDVjEvnY4IbSyl-PZ4XaUcskZ-fc6Zw>
    <xme:k55vafR7SvWpcOdFdZi9UYt3K9w5Wbu28P8JFhhqXZncpE__a7U9s4aXGdeCnSCrr
    aQBQEe_GKgdgs8Qag2rS6kOeI7S9Ud8-EGiZNgShDBVZsUCqEA9gg>
X-ME-Received: <xmr:k55vabUM7qalwEjFHivREqTOVmgAiuSiOVRLk5vCwRm-GIspwBDNewshYktrjmpev_bmYKJAG8nPH74uguGH8UrvhrpZfmzqe5-MUjvo8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedtjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:k55vaRYVwngd6qOje6NUPY5YEhio9Zygm_s2UPsrYW_LzqeFeUDp2w>
    <xmx:k55vaR30HftpLQJ0xw2aKcrqlYKI78Yn2gvDswHmC9ZjMoq_Nrdy5A>
    <xmx:k55vaThMZVRcfkGylCWyVII91PoBs380uEW9EIOfaZECH5MUc-nqEA>
    <xmx:k55vaVbXJk2QtXRSrpR7qNA8ZgRVVU8pgeAmlfqzH5MhTF3wGI_CNw>
    <xmx:k55vaS1HB2uHKdQXK55PMBCQC6Bam8R7xKs5mdLpL93IBeKNQoZ9Mm5s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Jan 2026 10:26:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1f16ad12 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Jan 2026 15:26:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 20 Jan 2026 16:25:57 +0100
Subject: [PATCH v2 01/14] odb: rename `FOR_EACH_OBJECT_*` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-pks-odb-for-each-object-v2-1-d05cbfd3d6f8@pks.im>
References: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
In-Reply-To: <20260120-pks-odb-for-each-object-v2-0-d05cbfd3d6f8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Rename the `FOR_EACH_OBJECT_*` flags to have an `ODB_` prefix. This
prepares us for a new upcoming `odb_for_each_object()` function and
ensures that both the function and its flags have the same prefix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c     |  2 +-
 builtin/pack-objects.c | 10 +++++-----
 commit-graph.c         |  4 ++--
 object-file.c          |  4 ++--
 object-file.h          |  2 +-
 odb.h                  | 13 +++++++------
 packfile.c             | 20 ++++++++++----------
 packfile.h             |  4 ++--
 reachable.c            |  8 ++++----
 repack-promisor.c      |  2 +-
 revision.c             |  2 +-
 11 files changed, 36 insertions(+), 35 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 2ad712e9f8..6964a5a52c 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -922,7 +922,7 @@ static int batch_objects(struct batch_options *opt)
 			cb.seen = &seen;
 
 			batch_each_object(opt, batch_unordered_object,
-					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
+					  ODB_FOR_EACH_OBJECT_PACK_ORDER, &cb);
 
 			oidset_clear(&seen);
 		} else {
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6ee31d48c9..74317051fd 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3912,7 +3912,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 		for_each_object_in_pack(p,
 					add_object_entry_from_pack,
 					revs,
-					FOR_EACH_OBJECT_PACK_ORDER);
+					ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	}
 
 	strbuf_release(&buf);
@@ -4344,10 +4344,10 @@ static void add_objects_in_unpacked_packs(void)
 	if (for_each_packed_object(to_pack.repo,
 				   add_object_in_unpacked_pack,
 				   NULL,
-				   FOR_EACH_OBJECT_PACK_ORDER |
-				   FOR_EACH_OBJECT_LOCAL_ONLY |
-				   FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
-				   FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
+				   ODB_FOR_EACH_OBJECT_PACK_ORDER |
+				   ODB_FOR_EACH_OBJECT_LOCAL_ONLY |
+				   ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS |
+				   ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS))
 		die(_("cannot open pack index"));
 }
 
diff --git a/commit-graph.c b/commit-graph.c
index 6b1f02e179..7f1145a082 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1927,7 +1927,7 @@ static int fill_oids_from_packs(struct write_commit_graph_context *ctx,
 			goto cleanup;
 		}
 		for_each_object_in_pack(p, add_packed_commits, ctx,
-					FOR_EACH_OBJECT_PACK_ORDER);
+					ODB_FOR_EACH_OBJECT_PACK_ORDER);
 		close_pack(p);
 		free(p);
 	}
@@ -1965,7 +1965,7 @@ static void fill_oids_from_all_packs(struct write_commit_graph_context *ctx)
 			_("Finding commits for commit graph among packed objects"),
 			ctx->approx_nr_objects);
 	for_each_packed_object(ctx->r, add_packed_commits, ctx,
-			       FOR_EACH_OBJECT_PACK_ORDER);
+			       ODB_FOR_EACH_OBJECT_PACK_ORDER);
 	if (ctx->progress_done < ctx->approx_nr_objects)
 		display_progress(ctx->progress, ctx->approx_nr_objects);
 	stop_progress(&ctx->progress);
diff --git a/object-file.c b/object-file.c
index e7e4c3348f..64e9e239dc 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1789,7 +1789,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 
 int for_each_loose_object(struct object_database *odb,
 			  each_loose_object_fn cb, void *data,
-			  enum for_each_object_flags flags)
+			  enum odb_for_each_object_flags flags)
 {
 	struct odb_source *source;
 
@@ -1800,7 +1800,7 @@ int for_each_loose_object(struct object_database *odb,
 		if (r)
 			return r;
 
-		if (flags & FOR_EACH_OBJECT_LOCAL_ONLY)
+		if (flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY)
 			break;
 	}
 
diff --git a/object-file.h b/object-file.h
index 1229d5f675..42bb50e10c 100644
--- a/object-file.h
+++ b/object-file.h
@@ -134,7 +134,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
  */
 int for_each_loose_object(struct object_database *odb,
 			  each_loose_object_fn, void *,
-			  enum for_each_object_flags flags);
+			  enum odb_for_each_object_flags flags);
 
 
 /**
diff --git a/odb.h b/odb.h
index bab07755f4..74503addf1 100644
--- a/odb.h
+++ b/odb.h
@@ -442,24 +442,25 @@ static inline void obj_read_unlock(void)
 	if(obj_read_use_lock)
 		pthread_mutex_unlock(&obj_read_mutex);
 }
+
 /* Flags for for_each_*_object(). */
-enum for_each_object_flags {
+enum odb_for_each_object_flags {
 	/* Iterate only over local objects, not alternates. */
-	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
+	ODB_FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
 
 	/* Only iterate over packs obtained from the promisor remote. */
-	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+	ODB_FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
 
 	/*
 	 * Visit objects within a pack in packfile order rather than .idx order
 	 */
-	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
+	ODB_FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
 
 	/* Only iterate over packs that are not marked as kept in-core. */
-	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
+	ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
 
 	/* Only iterate over packs that do not have .keep files. */
-	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
+	ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
 };
 
 enum {
diff --git a/packfile.c b/packfile.c
index 402c3b5dc7..b65f0b43f1 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2259,12 +2259,12 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    enum for_each_object_flags flags)
+			    enum odb_for_each_object_flags flags)
 {
 	uint32_t i;
 	int r = 0;
 
-	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
+	if (flags & ODB_FOR_EACH_OBJECT_PACK_ORDER) {
 		if (load_pack_revindex(p->repo, p))
 			return -1;
 	}
@@ -2285,7 +2285,7 @@ int for_each_object_in_pack(struct packed_git *p,
 		 *   - in pack-order, it is pack position, which we must
 		 *     convert to an index position in order to get the oid.
 		 */
-		if (flags & FOR_EACH_OBJECT_PACK_ORDER)
+		if (flags & ODB_FOR_EACH_OBJECT_PACK_ORDER)
 			index_pos = pack_pos_to_index(p, i);
 		else
 			index_pos = i;
@@ -2302,7 +2302,7 @@ int for_each_object_in_pack(struct packed_git *p,
 }
 
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum for_each_object_flags flags)
+			   void *data, enum odb_for_each_object_flags flags)
 {
 	struct odb_source *source;
 	int r = 0;
@@ -2318,15 +2318,15 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 		for (e = packfile_store_get_packs(source->packfiles); e; e = e->next) {
 			struct packed_git *p = e->pack;
 
-			if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
+			if ((flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 				continue;
-			if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
+			if ((flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) &&
 			    !p->pack_promisor)
 				continue;
-			if ((flags & FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
+			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS) &&
 			    p->pack_keep_in_core)
 				continue;
-			if ((flags & FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
+			if ((flags & ODB_FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS) &&
 			    p->pack_keep)
 				continue;
 			if (open_pack_index(p)) {
@@ -2413,8 +2413,8 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 		if (repo_has_promisor_remote(r)) {
 			for_each_packed_object(r, add_promisor_object,
 					       &promisor_objects,
-					       FOR_EACH_OBJECT_PROMISOR_ONLY |
-					       FOR_EACH_OBJECT_PACK_ORDER);
+					       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY |
+					       ODB_FOR_EACH_OBJECT_PACK_ORDER);
 		}
 		promisor_objects_prepared = 1;
 	}
diff --git a/packfile.h b/packfile.h
index acc5c55ad5..15551258bd 100644
--- a/packfile.h
+++ b/packfile.h
@@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    enum for_each_object_flags flags);
+			    enum odb_for_each_object_flags flags);
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum for_each_object_flags flags);
+			   void *data, enum odb_for_each_object_flags flags);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1
diff --git a/reachable.c b/reachable.c
index 4b532039d5..82676b2668 100644
--- a/reachable.c
+++ b/reachable.c
@@ -307,7 +307,7 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 					   int ignore_in_core_kept_packs)
 {
 	struct recent_data data;
-	enum for_each_object_flags flags;
+	enum odb_for_each_object_flags flags;
 	int r;
 
 	data.revs = revs;
@@ -319,13 +319,13 @@ int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 	data.extra_recent_oids_loaded = 0;
 
 	r = for_each_loose_object(the_repository->objects, add_recent_loose, &data,
-				  FOR_EACH_OBJECT_LOCAL_ONLY);
+				  ODB_FOR_EACH_OBJECT_LOCAL_ONLY);
 	if (r)
 		goto done;
 
-	flags = FOR_EACH_OBJECT_LOCAL_ONLY | FOR_EACH_OBJECT_PACK_ORDER;
+	flags = ODB_FOR_EACH_OBJECT_LOCAL_ONLY | ODB_FOR_EACH_OBJECT_PACK_ORDER;
 	if (ignore_in_core_kept_packs)
-		flags |= FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
+		flags |= ODB_FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS;
 
 	r = for_each_packed_object(revs->repo, add_recent_packed, &data, flags);
 
diff --git a/repack-promisor.c b/repack-promisor.c
index ee6e0669f6..45c330b9a5 100644
--- a/repack-promisor.c
+++ b/repack-promisor.c
@@ -56,7 +56,7 @@ void repack_promisor_objects(struct repository *repo,
 	ctx.cmd = &cmd;
 	ctx.algop = repo->hash_algo;
 	for_each_packed_object(repo, write_oid, &ctx,
-			       FOR_EACH_OBJECT_PROMISOR_ONLY);
+			       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 
 	if (cmd.in == -1) {
 		/* No packed objects; cmd was never started */
diff --git a/revision.c b/revision.c
index b65a763770..5aadf46dac 100644
--- a/revision.c
+++ b/revision.c
@@ -3938,7 +3938,7 @@ int prepare_revision_walk(struct rev_info *revs)
 
 	if (revs->exclude_promisor_objects) {
 		for_each_packed_object(revs->repo, mark_uninteresting, revs,
-				       FOR_EACH_OBJECT_PROMISOR_ONLY);
+				       ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
 	}
 
 	if (!revs->reflog_info)

-- 
2.53.0.rc0.250.g0ac79233d6.dirty

