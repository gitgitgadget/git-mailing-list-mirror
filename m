Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFC1FDE31
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106028; cv=none; b=WvdvU+W+t7YXSZdMOySAW1rwYu8ICh/mPS+MH7sgTw2p3QYuBFxDNjE2C5Cep+rJaP9zrnvdlbwrlPG15uB/XLDx6AuGCelRUZPwiQD9qEEnHZ6HMIr7TRiPEaud1ORJdekYmH9Mfc/2LxG3ldkzTwGWi9hAO7PLNZiOXUZkZxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106028; c=relaxed/simple;
	bh=rIiRJuFpagmemQD0wRW7nWZp8pr8L3STotZk8t5Cbi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EItaBINRiPQzo+8wlgoOrJxRQxpeJSEucmrturypr1xYTMKkXFRgfK7nRfWP0vqzuiyyRY14pCcxCssudhqEjVOUvZTNbeh+9j6fDZ2mh7UXX+mq1U+Tgr9o9QOhlQpSDdu02REmmoYA0O7L7zeOEOGGNYPIqHSsqbN+uI+EgVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tknwra5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFw79GgX; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tknwra5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFw79GgX"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A18D125400EB;
	Thu,  5 Jun 2025 02:47:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 05 Jun 2025 02:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106025;
	 x=1749192425; bh=4KVeQgmN7xcaJrmcaqcUe2/ZattPeF66Z3cIRquWLQU=; b=
	Tknwra5NWq8bKYW5AOrLoFYmbeUOyqCFvd6K1vnzAO17mgiaRYf70Y8795paZ0OO
	UpxcHlGVH07/vsyxOpsDpbhsABMacJhdJVVp6qHbKQE+vkRMbTkkWHLWrdlfKqw3
	7oOOxgeUd9Ejze452v91wOiha05d9rgybqdwDfKlBpLWLbQHpWqMHNAZ9ZiqQ5by
	3YkkoC//sgUIC3OZFQfzbOgHsSzJ58evUakPgzVha1ZKwv9y76O5xBX3UGlP+ajZ
	WfX1TYbOTLpK8rTn7VTATH+y61y/BxlgpsQUeUlMmrdqDXfvJo5tkRCvCVn3JpHz
	YJREUlFItHtgWk34+Gz+Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106025; x=
	1749192425; bh=4KVeQgmN7xcaJrmcaqcUe2/ZattPeF66Z3cIRquWLQU=; b=C
	Fw79GgXUw6lZf8OyXJt3GTgqkXyn+9M9ci2gRDB/RoO+lj9ZinXxC1O+3b3M52Ff
	ILisGk53C8xFfzSQna1UyC3yyvBeqJ+can5Di8kI9AvbGn04q9DIFy0g5HOnHECD
	+zTf3mWp9Kus4UUCV6qNVw8Q35W0q4Wtt9/HJKgwflUq1VxgBXyo7Rj5GV9gf1d3
	OXXQZ2FWfUMq9CGeVI0I+EohMgewgLCHwf9Smki80V91+UQfIrAKQIi+HsUzi0on
	oQizpJMKdlhV+0MQkabIhDEuBqsYyePJURRNEOehEys/wPYKvaL2cwJvv14U8K20
	czt9TjwVhCVofBDTtTkMw==
X-ME-Sender: <xms:aT1BaMZmnFQmWCmHIQoJQnb2yngUBWO6C4EWXP7zwn6-lHOQv8tMpw>
    <xme:aT1BaHbCa0WY9KIb30rMTSXJ8dMDZUIe1rv6bvrMr7oWWUEirceyQLHGcAKrEaefe
    A5A1WkcvMcW3TZdMA>
X-ME-Received: <xmr:aT1BaG8owO-C6GsUNv6j7F-PYVXlINOuZ9fvXymKcYnimGtpkQhCjeHbh6-um99SVf5HTYt7h7MTiyqIJCUSxFq35So44hm0Xg_6yvpZeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:aT1BaGpdXIZzB3QhVkeAl4pauoazUZViJq0iAtuCGmpsmSVkIMD5lA>
    <xmx:aT1BaHrGPHfzd1ol44RTdzpdJFTdu5FAhYUgAvUXq7hYwuHvi-wo0w>
    <xmx:aT1BaES6kKTu_8g4Ok8P_zN1vEqDxvQr-3puDBLcuvAaoWjL6Fqh7g>
    <xmx:aT1BaHr4RTrEMYGJWVlazA85DZPPHYzmuW2bxoasXxZSXsYs8Cz-2A>
    <xmx:aT1BaFRC02e1Z5GhQ8sM9dagpYLz7jxJtVGM5963zMIs7bq9wIEAL04i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 806216f4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:46:57 +0200
Subject: [PATCH v5 07/17] odb: get rid of `the_repository` in
 `odb_mkstemp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-7-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `odb_mkstemp()` by
passing in the object database as a parameter and adjusting all callers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  2 +-
 bundle-uri.c          |  3 ++-
 odb.c                 |  9 +++++----
 odb.h                 |  7 ++++---
 pack-bitmap-write.c   |  3 ++-
 pack-write.c          | 10 ++++++----
 7 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 52c792488e1..413304db9b5 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -763,7 +763,8 @@ static void start_packfile(void)
 	struct packed_git *p;
 	int pack_fd;
 
-	pack_fd = odb_mkstemp(&tmp_file, "pack/tmp_pack_XXXXXX");
+	pack_fd = odb_mkstemp(the_repository->objects, &tmp_file,
+			      "pack/tmp_pack_XXXXXX");
 	FLEX_ALLOC_STR(p, pack_name, tmp_file.buf);
 	strbuf_release(&tmp_file);
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1aabe6b8ee2..4d4d989eb1a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -362,7 +362,7 @@ static const char *open_pack_file(const char *pack_name)
 		input_fd = 0;
 		if (!pack_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			output_fd = odb_mkstemp(&tmp_file,
+			output_fd = odb_mkstemp(the_repository->objects, &tmp_file,
 						"pack/tmp_pack_XXXXXX");
 			pack_name = strbuf_detach(&tmp_file, NULL);
 		} else {
diff --git a/bundle-uri.c b/bundle-uri.c
index 2e623f8627a..f94e780e967 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -278,7 +278,8 @@ static char *find_temp_filename(void)
 	 * Find a temporary filename that is available. This is briefly
 	 * racy, but unlikely to collide.
 	 */
-	fd = odb_mkstemp(&name, "bundles/tmp_uri_XXXXXX");
+	fd = odb_mkstemp(the_repository->objects, &name,
+			 "bundles/tmp_uri_XXXXXX");
 	if (fd < 0) {
 		warning(_("failed to create temporary file"));
 		return NULL;
diff --git a/odb.c b/odb.c
index 3a3ceed5508..73410920a88 100644
--- a/odb.c
+++ b/odb.c
@@ -63,7 +63,8 @@ static const struct cached_object *find_cached_object(struct object_database *ob
 	return NULL;
 }
 
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
+int odb_mkstemp(struct object_database *odb,
+		struct strbuf *temp_filename, const char *pattern)
 {
 	int fd;
 	/*
@@ -71,15 +72,15 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	 * restrictive except to remove write permission.
 	 */
 	int mode = 0444;
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
+	repo_git_path_replace(odb->repo, temp_filename, "objects/%s", pattern);
 	fd = git_mkstemp_mode(temp_filename->buf, mode);
 	if (0 <= fd)
 		return fd;
 
 	/* slow path */
 	/* some mkstemp implementations erase temp_filename on failure */
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
-	safe_create_leading_directories(the_repository, temp_filename->buf);
+	repo_git_path_replace(odb->repo, temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(odb->repo, temp_filename->buf);
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
diff --git a/odb.h b/odb.h
index 13f5da45f54..5de952608f3 100644
--- a/odb.h
+++ b/odb.h
@@ -201,12 +201,13 @@ void odb_clear(struct object_database *o);
 struct odb_source *odb_find_source(struct object_database *odb, const char *obj_dir);
 
 /*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
+ * Create a temporary file rooted in the primary alternate's directory, or die
+ * on failure. The filename is taken from "pattern", which should have the
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+int odb_mkstemp(struct object_database *odb,
+		struct strbuf *temp_filename, const char *pattern);
 
 void *repo_read_object_file(struct repository *r,
 			    const struct object_id *oid,
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 37648b57125..c847369eaaa 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -1052,7 +1052,8 @@ void bitmap_writer_finish(struct bitmap_writer *writer,
 
 	struct bitmap_disk_header header;
 
-	int fd = odb_mkstemp(&tmp_file, "pack/tmp_bitmap_XXXXXX");
+	int fd = odb_mkstemp(writer->repo->objects, &tmp_file,
+			     "pack/tmp_bitmap_XXXXXX");
 
 	if (writer->pseudo_merges_nr)
 		options |= BITMAP_OPT_PSEUDO_MERGES;
diff --git a/pack-write.c b/pack-write.c
index 6b06315f80a..eccdc798e36 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -84,7 +84,8 @@ const char *write_idx_file(struct repository *repo,
 	} else {
 		if (!index_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			fd = odb_mkstemp(&tmp_file, "pack/tmp_idx_XXXXXX");
+			fd = odb_mkstemp(repo->objects, &tmp_file,
+					 "pack/tmp_idx_XXXXXX");
 			index_name = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(index_name);
@@ -259,7 +260,8 @@ char *write_rev_file_order(struct repository *repo,
 	if (flags & WRITE_REV) {
 		if (!rev_name) {
 			struct strbuf tmp_file = STRBUF_INIT;
-			fd = odb_mkstemp(&tmp_file, "pack/tmp_rev_XXXXXX");
+			fd = odb_mkstemp(repo->objects, &tmp_file,
+					 "pack/tmp_rev_XXXXXX");
 			path = strbuf_detach(&tmp_file, NULL);
 		} else {
 			unlink(rev_name);
@@ -342,7 +344,7 @@ static char *write_mtimes_file(struct repository *repo,
 	if (!to_pack)
 		BUG("cannot call write_mtimes_file with NULL packing_data");
 
-	fd = odb_mkstemp(&tmp_file, "pack/tmp_mtimes_XXXXXX");
+	fd = odb_mkstemp(repo->objects, &tmp_file, "pack/tmp_mtimes_XXXXXX");
 	mtimes_name = strbuf_detach(&tmp_file, NULL);
 	f = hashfd(repo->hash_algo, fd, mtimes_name);
 
@@ -531,7 +533,7 @@ struct hashfile *create_tmp_packfile(struct repository *repo,
 	struct strbuf tmpname = STRBUF_INIT;
 	int fd;
 
-	fd = odb_mkstemp(&tmpname, "pack/tmp_pack_XXXXXX");
+	fd = odb_mkstemp(repo->objects, &tmpname, "pack/tmp_pack_XXXXXX");
 	*pack_tmp_name = strbuf_detach(&tmpname, NULL);
 	return hashfd(repo->hash_algo, fd, *pack_tmp_name);
 }

-- 
2.50.0.rc1.591.g9c95f17f64.dirty

