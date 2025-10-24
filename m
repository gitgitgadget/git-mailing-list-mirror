Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6F830FC11
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299795; cv=none; b=F5ksnkl9zs3vsnxhrIlGu4Mb3s5fHH9v10QE96ZQGb9yHCD96XNAGv4I98aZYUmiFdStN2Qoff2FmZ7uDi/WxWHa5AHAmO4ayP/d0e38vW3rnIV+sf+XB7FUbB3vPIGX1bOWLF77VNJgLaiYxXkBJBPituBKpSFPW+VFS1TNcpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299795; c=relaxed/simple;
	bh=PLfH16LjSpWWiAnKLuhtFZbNSHJzkGYQw5gS6MzXSb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d+y/Vl7TXqVOpvJAgmyoVAmhHBeDZNO0Zg59zjI6VRl0ul+gEcnk6BvLhjhCxpTkc4l1BXbl8tE4nQpaKtscv4ydiRQaSkAzu2+TwAUL6/mwJJEMRdioM1+WatE1Z4PAZzEtGXdFEc2aKsjhwtdhJCUCpXT0q2mqwQpWzGCOc8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i2sdCkzY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bk7heFNL; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i2sdCkzY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bk7heFNL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50C1AEC0292
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 24 Oct 2025 05:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299793;
	 x=1761386193; bh=J4O4UfyE40C8xw8YKOXcVO6SNqtQjCMMRGWo3QKEl2A=; b=
	i2sdCkzYpS+AugeJY35Ud9m+pC2HeMJVn72eZGvF1wIwu4TlEjasBePPthrD5zdo
	Mq3XBNkWRPpYXhEIUUwGd0EoVSVyJ96b6YmCd7WBWazWzJ01H5ZReOWtYwnx8kId
	svsmxaRTxDD4OXUv5A/FJrRHE6FNmhYDQwCbSUmVmeW1lYXqND3Q3IH9gEwsJKrB
	pqdliShJ10U6kbyGKGz2vCQrq3VvJ8SQZ1jxizxSFKaoa+vsenPsEzoK5Y3Tqr5z
	X3pDtzRNcE9Qrk16KBNXUBvNkvxC1CrWuWhT0jCAZ5JOcwWYOu1bTuKwteTFzKwX
	zl6h/f1NgJvbZUkHA/jJSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299793; x=
	1761386193; bh=J4O4UfyE40C8xw8YKOXcVO6SNqtQjCMMRGWo3QKEl2A=; b=B
	k7heFNLq0DC59JrRL1M9K5m4JMtjAQLlek1I3jbZ9pqXLBOrbdXE6KQAzB4Tm097
	zwLnWr8J8FIVeT6RJyFpIGPgMFA1hmclBB45DQeZNUD+TdzSswnUwbjFQePPoqtl
	LDsLToMWYEQSuS3Qe9AcH+uPtbLZIXEfSwbvA/sGvIKg2+juVkxuNsmjuH7GEm0j
	In63ckCYMqv4qE5G6qzD+0iPX5eRxo4aDrvRrsBHiRtKSJScWwk8CeFMfgZqC3Nb
	LaPXV61Kh88IteRZhTpSx2McgyGM3lJ864wzmGj1RZdd3/pCY5XD8GV+twUsax3x
	f95CAXKzTHaSVprJQL3uQ==
X-ME-Sender: <xms:UU37aBY03VTf9iNeEDmr62uxJstmYLuppTPBxu3czxOUI8D55skf7Q>
    <xme:UU37aPUF4537z3i5suzTQL9bnbSvam1XU3n70TGAJ31ifefud3O-4J9Mrpt9tbyDy
    10Nwf83vbg9ljm8ZNMpGbCHNeiBwVlWMQFFi2EJgzOZHhPkyb3S>
X-ME-Received: <xmr:UU37aJkSAqE0JBSkpINi8dbofu74ZDK0fXlUC1u3iO2hTL4Me81ijcR_ylEqoWAFjU-BuAr265uJYjHLDpLaqzCXN_QQTLbsBLs683jF6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:UU37aEziGKYGA_xKEc-SpYx6XdKd7dWWKaojS4Jw7o6yf4eUUDWyPw>
    <xmx:UU37aMiXHTsowlE2EBb20C7q1o84FqYS5u09kVS9gZa0CR6QTBePrg>
    <xmx:UU37aBU9AuC11D9Jrbo1x5vzKgXcYIMhT_wZaGBJtItlszpNABfAPQ>
    <xmx:UU37aG3pL_h9b1q1AAXiH-_bk_Jy7euhHrI0TxTjFosGu4lj4UVLsA>
    <xmx:UU37aL5cesq1zmf30Yg2ihDHsV17_Muw7K4a_pGcyKN2E9QaK4WUqSwO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 24 Oct 2025 05:56:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c2df9c7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Oct 2025 09:56:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Oct 2025 11:56:08 +0200
Subject: [PATCH 09/13] object-file: read objects via the loose object
 source
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-b4-pks-odb-loose-backend-v1-9-1a4202273c38@pks.im>
References: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
In-Reply-To: <20251024-b4-pks-odb-loose-backend-v1-0-1a4202273c38@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

When reading an object via `loose_object_info()` or `map_loose_object()`
we hand in the whole repository. We then iterate through each of the
object sources to figure out whether that source has the object in
question.

This logic is reversing responsibility though: a specific backend should
only care about one specific source, where the object sources themselves
are then managed by the object database.

Refactor the code accordingly by passing an object source to both of
these functions instead. The different sources are then handled by
either `do_oid_object_info_extended()`, which sits on the object
database level, and by `open_istream_loose()`. The latter function
arguably is still at the wrong level, but this will be cleaned up at a
later point in time.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 68 ++++++++++++++++++++++-------------------------------------
 object-file.h | 15 +++++++------
 odb.c         |  9 ++++++--
 streaming.c   | 11 +++++++++-
 4 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/object-file.c b/object-file.c
index 14daa2bdd90..d9724e3105f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -167,25 +167,22 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 }
 
 /*
- * Find "oid" as a loose object in the local repository or in an alternate.
+ * Find "oid" as a loose object in given source.
  * Returns 0 on success, negative on failure.
  *
  * The "path" out-parameter will give the path of the object we found (if any).
  * Note that it may point to static storage and is only valid until another
  * call to stat_loose_object().
  */
-static int stat_loose_object(struct repository *r, const struct object_id *oid,
+static int stat_loose_object(struct odb_loose_source *source,
+			     const struct object_id *oid,
 			     struct stat *st, const char **path)
 {
-	struct odb_source *source;
 	static struct strbuf buf = STRBUF_INIT;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		*path = odb_loose_path(source, &buf, oid);
-		if (!lstat(*path, st))
-			return 0;
-	}
+	*path = odb_loose_path(source->source, &buf, oid);
+	if (!lstat(*path, st))
+		return 0;
 
 	return -1;
 }
@@ -194,39 +191,24 @@ static int stat_loose_object(struct repository *r, const struct object_id *oid,
  * Like stat_loose_object(), but actually open the object and return the
  * descriptor. See the caveats on the "path" parameter above.
  */
-static int open_loose_object(struct repository *r,
+static int open_loose_object(struct odb_loose_source *source,
 			     const struct object_id *oid, const char **path)
 {
-	int fd;
-	struct odb_source *source;
-	int most_interesting_errno = ENOENT;
 	static struct strbuf buf = STRBUF_INIT;
+	int fd;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		*path = odb_loose_path(source, &buf, oid);
-		fd = git_open(*path);
-		if (fd >= 0)
-			return fd;
+	*path = odb_loose_path(source->source, &buf, oid);
+	fd = git_open(*path);
+	if (fd >= 0)
+		return fd;
 
-		if (most_interesting_errno == ENOENT)
-			most_interesting_errno = errno;
-	}
-	errno = most_interesting_errno;
 	return -1;
 }
 
-static int quick_has_loose(struct repository *r,
+static int quick_has_loose(struct odb_loose_source *source,
 			   const struct object_id *oid)
 {
-	struct odb_source *source;
-
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next) {
-		if (oidtree_contains(odb_loose_source_cache(source, oid), oid))
-			return 1;
-	}
-	return 0;
+	return !!oidtree_contains(odb_loose_source_cache(source->source, oid), oid);
 }
 
 /*
@@ -252,12 +234,12 @@ static void *map_fd(int fd, const char *path, unsigned long *size)
 	return map;
 }
 
-void *map_loose_object(struct repository *r,
-		       const struct object_id *oid,
-		       unsigned long *size)
+void *odb_loose_source_map_object(struct odb_source *source,
+				  const struct object_id *oid,
+				  unsigned long *size)
 {
 	const char *p;
-	int fd = open_loose_object(r, oid, &p);
+	int fd = open_loose_object(source->loose, oid, &p);
 
 	if (fd < 0)
 		return NULL;
@@ -407,9 +389,9 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-int loose_object_info(struct repository *r,
-		      const struct object_id *oid,
-		      struct object_info *oi, int flags)
+int odb_loose_source_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi, int flags)
 {
 	int status = 0;
 	int fd;
@@ -422,7 +404,7 @@ int loose_object_info(struct repository *r,
 	enum object_type type_scratch;
 
 	if (oi->delta_base_oid)
-		oidclr(oi->delta_base_oid, r->hash_algo);
+		oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
 
 	/*
 	 * If we don't care about type or size, then we don't
@@ -435,15 +417,15 @@ int loose_object_info(struct repository *r,
 	if (!oi->typep && !oi->sizep && !oi->contentp) {
 		struct stat st;
 		if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK))
-			return quick_has_loose(r, oid) ? 0 : -1;
-		if (stat_loose_object(r, oid, &st, &path) < 0)
+			return quick_has_loose(source->loose, oid) ? 0 : -1;
+		if (stat_loose_object(source->loose, oid, &st, &path) < 0)
 			return -1;
 		if (oi->disk_sizep)
 			*oi->disk_sizep = st.st_size;
 		return 0;
 	}
 
-	fd = open_loose_object(r, oid, &path);
+	fd = open_loose_object(source->loose, oid, &path);
 	if (fd < 0) {
 		if (errno != ENOENT)
 			error_errno(_("unable to open loose object %s"), oid_to_hex(oid));
diff --git a/object-file.h b/object-file.h
index 706f1e1872d..cc723c9baec 100644
--- a/object-file.h
+++ b/object-file.h
@@ -43,6 +43,14 @@ void odb_loose_source_free(struct odb_loose_source *source);
 /* Reprepare the loose source by emptying the loose object cache. */
 void odb_loose_source_reprepare(struct odb_source *source);
 
+int odb_loose_source_read_object_info(struct odb_source *source,
+				      const struct object_id *oid,
+				      struct object_info *oi, int flags);
+
+void *odb_loose_source_map_object(struct odb_source *source,
+				  const struct object_id *oid,
+				  unsigned long *size);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -66,9 +74,6 @@ const char *odb_loose_path(struct odb_source *source,
 int has_loose_object(struct odb_source *source,
 		     const struct object_id *oid);
 
-void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:
@@ -196,10 +201,6 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  */
 int stream_object_signature(struct repository *r, const struct object_id *oid);
 
-int loose_object_info(struct repository *r,
-		      const struct object_id *oid,
-		      struct object_info *oi, int flags);
-
 enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
 };
diff --git a/odb.c b/odb.c
index 96059456f20..5dc1e2c7eb0 100644
--- a/odb.c
+++ b/odb.c
@@ -697,13 +697,18 @@ static int do_oid_object_info_extended(struct object_database *odb,
 		return 0;
 	}
 
+	odb_prepare_alternates(odb);
+
 	while (1) {
+		struct odb_source *source;
+
 		if (find_pack_entry(odb->repo, real, &e))
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!loose_object_info(odb->repo, real, oi, flags))
-			return 0;
+		for (source = odb->sources; source; source = source->next)
+			if (!odb_loose_source_read_object_info(source, real, oi, flags))
+				return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
 		if (!(flags & OBJECT_INFO_QUICK)) {
diff --git a/streaming.c b/streaming.c
index 4b13827668e..8e554abd084 100644
--- a/streaming.c
+++ b/streaming.c
@@ -230,12 +230,21 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
 			      enum object_type *type)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
+	struct odb_source *source;
+
 	oi.sizep = &st->size;
 	oi.typep = type;
 
-	st->u.loose.mapped = map_loose_object(r, oid, &st->u.loose.mapsize);
+	odb_prepare_alternates(r->objects);
+	for (source = r->objects->sources; source; source = source->next) {
+		st->u.loose.mapped = odb_loose_source_map_object(source, oid,
+								 &st->u.loose.mapsize);
+		if (st->u.loose.mapped)
+			break;
+	}
 	if (!st->u.loose.mapped)
 		return -1;
+
 	switch (unpack_loose_header(&st->z, st->u.loose.mapped,
 				    st->u.loose.mapsize, st->u.loose.hdr,
 				    sizeof(st->u.loose.hdr))) {

-- 
2.51.1.930.gacf6e81ea2.dirty

