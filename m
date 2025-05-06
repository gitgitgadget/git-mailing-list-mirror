Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597EC275113
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529768; cv=none; b=NYe51R487CH8LCNaJ3C7qTWVlYqi19KGSRe9in333UIzlt+kqlB5HBaqSIfZZFxxh9XBcn8Sc/c8c3jICKKSZhdLe0LlSolcYhDi9U0Ti7EtOXKGIRKLgUvmIKoDmocIIPj9Ts/OAgrmOw4FL8tCk62NUMcp7PXUn9uPP3T2Z8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529768; c=relaxed/simple;
	bh=2EKVC4ce6rY0nQrBgnGw6KYMNh/aStI22XtvVbvIaec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ilj1zApgQKE5KojMZdrN+YnzCDlCsKFeKdd4oYfLHX2vy2tuEvK6NbG10il0yQBZ/QgiR9kUSsxTMn6yxBRWODXq68Zh2Y0m411UyCMkK5z7oA6iDg+X4FZdTiyMJSPG+5Rx2QVToOfKEIuDjbaViwn83hrF8tnCWl6/EhDsMfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t11raipd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W4bkyHg1; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t11raipd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4bkyHg1"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A798138148E
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 06 May 2025 07:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529765;
	 x=1746616165; bh=rAS/8xzsuarGHk46X8ru1lzeG8/gXA//p5QlMt2ZVvs=; b=
	t11raipdF059cAZGgZryG5z0M80wtEihnlbxStYenGDobKtfVBc27w8pN7slCpXo
	XENAnt2+2PooEcyPCx1/40QkIgOJq3U05quM0CZFNc/Are6/SmKrYAv6VNDRNsJe
	T4qVUUTDZavtBlszD3cauc9xlONzVI/iy/9dRj+HS/0I7B+/MDWK4jutsNTr4cVZ
	2kMcwqQbhkPF72yDj4WjvmPBxxHCrDHWsEfhmkt0fXn0IFni1XFJwK9ud2ms8LAA
	gopNStMfFxuKNpV93he9RnugzMVhtVUauEx1gZ5Z0MEvupLtu+PbrXzvCzOJSDfM
	NQzxtwp/panc9SghhCeblQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529765; x=
	1746616165; bh=rAS/8xzsuarGHk46X8ru1lzeG8/gXA//p5QlMt2ZVvs=; b=W
	4bkyHg1kwZj9g9Ri/yDY26hgszTc1fI/WZNOJx+gSIRVXCaVbFYtXDwAmjyX5jtJ
	E8IzPtIanQKZ1wByDPEBKFTMMUXhYlLQW2qH35s0irRdd3RqJfA09gsOyNjhh2sF
	SSwlx7Mf1yEXQIRcXqEnd8Uq4GZ9jrgeikClaB7SP6RYpdK5V8iqXFUzaQZXxMrl
	vXEvRzsT4jtpfeYeeByz4zdwN5rKuZWAV8SR7waki+CP6cb/3n3JE33lBdeAlqOr
	B+sY2ywAr9FGTEPo1dCk1plDjQLeBZdx45wYha6k8y7cgreygXsBc2693nsBMcH2
	WpvnprHQZlaDJrZ2sVxBg==
X-ME-Sender: <xms:5e0ZaCBJMMpkbk-ES7F8uwHAGIaKAsupoVcjtBdBkavXuJ6MyIX1Tg>
    <xme:5e0ZaMj-t-lAw5qfuw57EBrKx0ncmxFlPpqYqRe7XP8Ujc9p74RFTnA-X1mn0gr4s
    GrV6R55kaO9O3nSiA>
X-ME-Received: <xmr:5e0ZaFmD_xm8sgCFl1vYHnxxD8hz4c18ZsEQTCT15cwJY8T0I4I2kP8PEsxuuvJwQFgIcStV-4Pk1h9ItIRjRug7ST9r2kv69-SSP5-f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:5e0ZaAxPvCrpCmLP0X89gUxIyGGhRmq3tzxdyiO0aNraFDKUHo0_sg>
    <xmx:5e0ZaHQ0huS1Ew_TuhXnRfl6BxuC6H6VFiwssn5HvueQJHfH_gFz6A>
    <xmx:5e0ZaLYpG1RAj1julb3ihPpcj57imsOBStdRtjT9bIG2Glu5A8HNCg>
    <xmx:5e0ZaATYb_FU3g53xD3PaY1S3kYgbteKU4jlJSrFJStU7b0s9gb6Xg>
    <xmx:5e0ZaM9K88BOGR8CyTCpUh1SplGXleDMSOe2jxPcHEjlyfdx16I2DvhY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bae84ac3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:20 +0200
Subject: [PATCH 07/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-7-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Get rid of our dependency on `the_repository` in `assert_oid_type()` by
passing in the object database as a parameter and adjusting all callers.

Rename the function to `odb_assert_oid_type()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  2 +-
 bundle-uri.c          |  3 ++-
 odb.c                 |  9 +++++----
 odb.h                 | 11 ++++++-----
 pack-bitmap-write.c   |  3 ++-
 pack-write.c          | 10 ++++++----
 7 files changed, 24 insertions(+), 17 deletions(-)

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
index 8ce446064e8..8e5acefde40 100644
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
index 993ac62c271..87a5ba50945 100644
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
index b4265da2993..9bd87204737 100644
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
index 7e634db16f2..62967da6cf6 100644
--- a/odb.h
+++ b/odb.h
@@ -189,12 +189,13 @@ void odb_clear(struct object_database *o);
 struct odb_backend *odb_find_backend(struct object_database *odb, const char *obj_dir);
 
 /*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
- * usual "XXXXXX" trailer, and the resulting filename is written into the
- * "template" buffer. Returns the open descriptor.
+ * Create a temporary file rooted in the primary object database backend's
+ * directory, or die on failure. The filename is taken from "pattern", which
+ * should have the usual "XXXXXX" trailer, and the resulting filename is
+ * written into the "template" buffer. Returns the open descriptor.
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
2.49.0.1045.g170613ef41.dirty

