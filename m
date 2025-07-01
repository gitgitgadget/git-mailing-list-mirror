Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091F274FD0
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 12:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751372567; cv=none; b=UoCIgN5mG2KFEf7Uxoh97TFcaU09QR5c9sx3TihnyUelFN54SVnajkZ4TVWZbmcIqS659VX9V9CifEFS/sWvZOhKw1ABCxXDvGi493xdgs87kjoTOTu4KJvELbJvrmq7u+0lKYP5rJownaYFuxFRZsNvz53T62NgK1UhI4rN4Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751372567; c=relaxed/simple;
	bh=xp4gtbTZmwQmXIa/V7MsaS9YY+gUoYhWFfzAFIM7uWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YmyiQJgBZA9bkk0f6xU7kwXe4XiNCkzA3IAw0IUi1TzxwU9PiUvRrxri3lxzHMCf+aQfr6VcWfWICv2cUttSQvzb5PociQbyiGaECR4RbanMk5RIRU+ldSiZz1wgtPLrX1u0A22/PaR8l54xrCMsGbYclCuAukdr40GfG8k9acQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Rbj8NBo8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cIZlNg1E; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Rbj8NBo8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cIZlNg1E"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 314A6EC04E8;
	Tue,  1 Jul 2025 08:22:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 08:22:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751372565;
	 x=1751458965; bh=W8qwQDhhNFB2hmQDjbNKaJ61CFfj2ynrQDZNziEk/nM=; b=
	Rbj8NBo8yVHKFBe4bk+6MBm1tbfn6VxGT7WcWx/w16ItLID6uhpT69UYI45zHbgg
	zQYd5J8OYQzOmNp4TLJSUprkx49bF32hRgZ/BuItuUq8ti631mpqtD72URwjPrU8
	Rvj9vVMJls33dLwn/OwmEtJINWr9FvWxzw7YdYj481TIvYXz2OYRhXRjht+rHpuM
	SjRjW1pfl/78vd3zN3fzIRzYI/RNhqZBWFUdawAI1Qz8ca/KbAiuqtUQpp6vX6MQ
	OVoatZCU3OKmjQqQLYhGqeKikjhAyphY2wyYg/1NXiQWLAcMUWFuuO1ElZsC0VW2
	7rd4AKsaQinzhaGjjwz2Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751372565; x=
	1751458965; bh=W8qwQDhhNFB2hmQDjbNKaJ61CFfj2ynrQDZNziEk/nM=; b=c
	IZlNg1EIbVcyVBjQXRIpL79fzqZVlw+Kfd55cSIqdzxLIyYZf6n501pyG64K0HXt
	eiOg94obV7ff2E9i2M2gsTyDplEqKRwEgn5bfS513YRoXtU8R2n5PIAQObURnVL+
	r+YrRu3YArmAbLS/HNA9TixwBOl5s2k7sYk8vkSMNQ6agp7OkT25GJGfQcY4cJuV
	trwRWmX5NdP5YNnVk15v2rFRjcPP0td9hLH4uRpybECaHisfF2wtnKpd0sGy8DeQ
	8uu3orro9I3gzlYEQt7v+O9DFAHzdoXaXa5OcUIipVZpUiJsH4pI6uVqUBPkQ0DR
	9z+CmwPbO9Gjk0EnNqbjw==
X-ME-Sender: <xms:FdNjaKx1EZ8spfJHtrlhg4pbTc7eU1DNIteh-ckZjp8S-bvMzlTuLg>
    <xme:FdNjaGS-rVQdf2qTECVcBdknXnBijA_q-WiIcb-B3mce8j3QEr7Mah-Qo_yl3tNZf
    ICgQ-gHTsRgYEp_7g>
X-ME-Received: <xmr:FdNjaMVAmFpZmDyIPGUxxy6YIvQbGFaX-VNtoCDTBvIJxKmAu6nv34uFGiUKCNYnFscVUbdYmMRRFvHU_sdoxqi5jG1ALGQDOZf-h7gdWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtoh
    hlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FdNjaAj-gy1rjI_6rvcOe5ztsRwaThzK9HkbwvI0EZZC4tuISjBk9A>
    <xmx:FdNjaMAdElPsWgY3hN5naInNQuO-luI4ESIdEWAQL4u6YpxrlWWe1A>
    <xmx:FdNjaBLHVxP99TGXnYhnUSuAAKWxd3mfkabeN94aUQlPCmbvWKDYpw>
    <xmx:FdNjaDCAb6wjbHzP2TCVaQOSYu0sbOncKUZ2pI8kS4ze1B0LFSfW1g>
    <xmx:FdNjaBJa-EuzEBGkX5HQ3dAc9fDb3G7kA_0rZYK94MBlP2vU5edM-IrM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 08:22:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9f2047f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 12:22:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 01 Jul 2025 14:22:19 +0200
Subject: [PATCH v6 07/17] odb: get rid of `the_repository` in
 `odb_mkstemp()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250701-pks-object-store-wo-the-repository-v6-7-dbf3894ab4e2@pks.im>
References: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
In-Reply-To: <20250701-pks-object-store-wo-the-repository-v6-0-dbf3894ab4e2@pks.im>
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
index d0ca2990774..8967e9fd548 100644
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
2.50.0.195.g74e6fc65d0.dirty

