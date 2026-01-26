Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DB0313543
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 09:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769421089; cv=none; b=QyBZ8IvqyEL73m6G544DmA3l7a/RMg9TfzCc14FUmBk9FrDyOOKBEkSJkyVdBzGue5r8RmO3lsfHA0U9ZWHm0vX0t8QXTCEcZuuf/S63eo5Q9gdFMz0G0Sg7VmJ9BKqfTIPBdyvd3LVj7Mu+241ZNQvBOIbQ1/CXvbzknnX12iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769421089; c=relaxed/simple;
	bh=pwc0spM5E1WW/zx6KBHb+nRhLlHSMAUZ0zrwQzNW2Is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hrrZQwSGXYq5k6yKxAeb7va6p+0gOHUm/6jIGJkqrYgl2oe9Ss3aOakhQ/APaXteECpR1WC0O4BQApXcbgWcYeoK7FBjpmxUjFCxRBti7fvsNh5ARiisf3c7t8lvZPW6RaCR5IF4DXBhNkphh5M5cD/Uu0Q+ANau0XmT5Jb5e7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f4CVbvhs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUrRduLH; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f4CVbvhs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUrRduLH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4C77B1D00067;
	Mon, 26 Jan 2026 04:51:26 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 26 Jan 2026 04:51:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1769421086;
	 x=1769507486; bh=BjIoxomd3R1UnZa0q7WI4B27W5d7xQ33CNG9ZArdPjo=; b=
	f4CVbvhsqSdfuLOmG0K2oi0E7sWOCzKCYxK3TeGoIoob4K/dHFhy311F4OrJxkOk
	3vlO2xL4JRZspObzWSRE9MVgfuSdYls8utwPTJ1nbCGSlgeKSt++G5+xQOdFH7hr
	xP4QCIbXHfLzTruYGBTIMdCUxWjVhoKcfJmV1nZOYjGOiOgZOSRhQxQyaolz7oRI
	Kfb7VkDOb7Fb3iu/Cjaasikz7Qx7r4jBTc2OKQEGA4d/R0015kmOh9Dteqle1NtC
	6rSlJw51XfjpvXqTWsgExtKZ5x280TI1UlJIhJT2lXTYwFiIkSmv9Ypi/BiOIWKs
	Xg03kS/gqtNi4ZeSe3CK5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769421086; x=
	1769507486; bh=BjIoxomd3R1UnZa0q7WI4B27W5d7xQ33CNG9ZArdPjo=; b=C
	UrRduLHmeCx1W1dRYCB+8I+6HeWMNTNs49JsBJQjfXUbXC003DeUmD8SmZUiSq8j
	OA0vLbvLuCPboWqf5k8jG2Gy2pcohZKjr5hOk2XIfTfnG4lcfXxLOIEzjJFmjDKk
	RAdY0La4Tfvv89KSsiHo5IHZjlj6yj+s3vP6YTh+xtRwy7TRff6Bi/1E1nbkuZ/N
	YzXoJhfhqpbJcQm0xu4c+poVS7gfZY/jwP/1SztA6+3a0kOU0HpNxZQtMHNfu4Gx
	7F5b6nfuZauGpA6TpDSlpl1T9oNcJaYmtYEcQPz1JZaUf9jkSgOTRn4eYGWAPVtD
	PP9n/tnyErFwHq7PUmc2A==
X-ME-Sender: <xms:Hjl3aXarjjEoxyGqFoifY7PsJHtPGmoXoi82ejus7QWTLiC8v66rQg>
    <xme:Hjl3adbFwQ-VxCRfV4j-mLJDTtBuzYkX4eJDrl5Ert6zVKVvY-uovRrXVGC8MnSWa
    4i9Pp3Bt8sF8BFc-FdesxYjflOgV_ksJNfT3lCECR6ijUJMeIhg7w>
X-ME-Received: <xmr:Hjl3ae-NcTDTQeTJ8IhbeqtO8YMx8YBh7Ukvk76IIks7gNct-Ix6PmHUzh9CXNwfDfTFcNA7YhD6C1EOqzsmF4tO-_oIowZZ9mHmsrgR7K5nXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheejfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosg
    hlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Hjl3acg2UpniK3We-rCP4MYhyUoWSoebDzWdsMMcBl1SLD20zyd4EA>
    <xmx:Hjl3aec42sIBr3lK1Z63QfZV_zdzMOPiKKhfbMSMfxuLkj05RTTWoQ>
    <xmx:Hjl3aToSlBs5GtIuSD9sxiv3LtJchYtJ3QRE6pGS6nob0-6zqEastw>
    <xmx:Hjl3aTDyzmf1IID-7-Iqkk0ujjn2wYM29YahrRWUzJTL3AC01tM-iQ>
    <xmx:Hjl3aefUCDIpotLjH9PLS8prgSD5WBNH-0iWjvPWR5KLQFhO2VKMVp7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 04:51:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6a791b3d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Jan 2026 09:51:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 26 Jan 2026 10:51:17 +0100
Subject: [PATCH v4 01/14] odb: rename `FOR_EACH_OBJECT_*` flags
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-pks-odb-for-each-object-v4-1-5a64a038c791@pks.im>
References: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
In-Reply-To: <20260126-pks-odb-for-each-object-v4-0-5a64a038c791@pks.im>
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
2.53.0.rc1.267.g6e3a78c723.dirty

