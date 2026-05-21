Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E883546F8
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351787; cv=none; b=H7MuA7eUiqqpPsp57sE6fMX1LK9SfBYc9LVif9zbUEhTWJmp6cIkCBPhtCPw6IwvAq5fmcS5ZRjT3duf/1lWQnqLrbF1qrbnftBO6ofWLGgr7i/f8ePvTmyy1zJw+r+Sd+O1SD2XQnZrJ5anFOpuPD1HVuJDzulONkv/XwAy4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351787; c=relaxed/simple;
	bh=ixw+/8mvHjiAZ0VHUzItrJzZ9N2OZBaytqBe8NUDz68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XkKdcaAnOfkSlzLKypfr/bOUTqIKWfRkfOYvOouwuziYtCcLbTHjHj2rsk5T+3YKNjOqhnSsoCyuXs88j0ME1OeFJqGtpZgSlQ2C4g7zABZ0vCbz47Vj+LyFR0f4ciUI05fERzBYBLxqOGF0ja4G2RXRkycFne8koCIm+kgrgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lxmn/5QC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nBNxj2xP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lxmn/5QC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nBNxj2xP"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B21E7EC0087
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 04:23:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351784;
	 x=1779438184; bh=ndUZ+0J75HOXcfQBZPNMShZPIBUTph5ZgtHRfxvJZW0=; b=
	lxmn/5QCs59eYaEH3mIde34VIBB/2AseQnAJw24H5p8OjvVvxH3N6nbAcV/QsAlb
	wHvU426VBzQmRiDnLRovYs1fQsJU2HPiAsmSki57dZCVz2grm1VAEOsjdD/6inXM
	fgeGOoHCIEjJ/ZiZrkqXgjQOQPDrXHxcXB+z1jDeLUMZokPVOF1EH/oqN32K75aG
	KjZaGqJeigWxy5yWPFs3HCJeZ8UAVnitPIk7YvPzhQRe13DdfVkXU7WuMqtIDuCX
	P+X4H+f29sxySuWcNAJ/8fiUGfhBUhfCEOF4z+y1Tj89KkYem92gVMt0QlsU5vwQ
	zSqsdXz78zXeIHjeJoHB4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351784; x=
	1779438184; bh=ndUZ+0J75HOXcfQBZPNMShZPIBUTph5ZgtHRfxvJZW0=; b=n
	BNxj2xPtWIqyNXpgKUcpdQG6ODVN9HUdIOx8xFbXP1bGP2WDsV2kNuHZqm2JiSMB
	Y7KxLgd3PdjdX+bQc/sVSH3kcxVJzKBGklQMB7QDrHvTeC/kFaBinBoIQYF/cIms
	NHPrwKQsg3wERfS0wbjw2xXaYp9bg/kGB/E9VeMLcHa/nTa06YztK6x1rCxjfyMw
	JSN0Pek/jNkSBpH5gi7VpU0mAhS4/cDGQNYhs1J638CArn29ik9rrp7QwgcIvcL4
	oknFnUoHlEIu3YxH63Fzkb9atfH1LkAcNzr07c4J3GiSBStuv5p4f0051SoD984Z
	2s/PTVXSX30e0JhXjZB/Q==
X-ME-Sender: <xms:6MAOaih519HXotWL9QPtb4woqjB7Ne36HL-OD5AoKsVSX4pNaoc_Mw>
    <xme:6MAOap-aGPeWKNht3U4pYixeQumIXt59I_5OIGcBc9S0Q6qgLR8giNdAQladqOGA_
    TpHqh_PvpONJY7WcXkMEwSfU7v6XxsHcrW1OOxHDGFuQBjFIals6g>
X-ME-Received: <xmr:6MAOavsaGzmYwlD7dCCW35Ha97eh_8CbRDyyf8_B2XKtuxXZmoMbD1dFHUVtoKNpvEXb6niW0nbG_Nk4CFjxYym5XohBU34yIiLESLscgKk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:6MAOagaAoZyPvHgbgvxJJxVLRzcOr3hD-5DD_LDpQnWe4OB5Ro8a3A>
    <xmx:6MAOavrbdaQPDHWkDHupt0_9E17qy0RSGZi9nywprtmKdzEgxy7KHQ>
    <xmx:6MAOal8y9EE0JnVjfTlxfwBPOaycoZ3I4m83QtFN4Jd_8Bt85QP4rg>
    <xmx:6MAOau_VzVp9OUA9lIc4A6kJub_MoYXGExsdgtRUAUifGVTb3JHqPw>
    <xmx:6MAOavjcraw4b3Sn1kGfpysOfqhg-cNsG7zNWPL7XmLxjakbQtIoK6tp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6cb5f531 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:33 +0200
Subject: [PATCH 13/18] loose: refactor object map to operate on `struct
 odb_source_loose`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-13-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

While the loose object map functions in "loose.c" accept a generic
`struct odb_source *`, they always expect this to be the "files"
backend. Furthermore, the subsystem doesn't even care about the "files"
backend, but only uses it as a stepping stone to get to the "loose"
backend.

This assumption is implicit and thus not immediately obvious. Refactor
the interfaces to instead operate on a `struct odb_source_loose`
instead, which eliminates the implicit dependency and unnecessary detour
via the "files" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c       | 45 ++++++++++++++++++++++-----------------------
 loose.h       |  4 ++--
 object-file.c |  9 ++++++---
 3 files changed, 30 insertions(+), 28 deletions(-)

diff --git a/loose.c b/loose.c
index f7a3dd1a72..0b626c1b85 100644
--- a/loose.c
+++ b/loose.c
@@ -46,38 +46,36 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
 	return 1;
 }
 
-static int insert_loose_map(struct odb_source *source,
+static int insert_loose_map(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	struct loose_object_map *map = files->loose->map;
+	struct loose_object_map *map = loose->map;
 	int inserted = 0;
 
 	inserted |= insert_oid_pair(map->to_compat, oid, compat_oid);
 	inserted |= insert_oid_pair(map->to_storage, compat_oid, oid);
 	if (inserted)
-		oidtree_insert(files->loose->cache, compat_oid, NULL);
+		oidtree_insert(loose->cache, compat_oid, NULL);
 
 	return inserted;
 }
 
-static int load_one_loose_object_map(struct repository *repo, struct odb_source *source)
+static int load_one_loose_object_map(struct repository *repo, struct odb_source_loose *loose)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 	FILE *fp;
 
-	if (!files->loose->map)
-		loose_object_map_init(&files->loose->map);
-	if (!files->loose->cache) {
-		ALLOC_ARRAY(files->loose->cache, 1);
-		oidtree_init(files->loose->cache);
+	if (!loose->map)
+		loose_object_map_init(&loose->map);
+	if (!loose->cache) {
+		ALLOC_ARRAY(loose->cache, 1);
+		oidtree_init(loose->cache);
 	}
 
-	insert_loose_map(source, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
-	insert_loose_map(source, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
-	insert_loose_map(source, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
+	insert_loose_map(loose, repo->hash_algo->empty_tree, repo->compat_hash_algo->empty_tree);
+	insert_loose_map(loose, repo->hash_algo->empty_blob, repo->compat_hash_algo->empty_blob);
+	insert_loose_map(loose, repo->hash_algo->null_oid, repo->compat_hash_algo->null_oid);
 
 	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
 	fp = fopen(path.buf, "rb");
@@ -97,7 +95,7 @@ static int load_one_loose_object_map(struct repository *repo, struct odb_source
 		    parse_oid_hex_algop(p, &compat_oid, &p, repo->compat_hash_algo) ||
 		    p != buf.buf + buf.len)
 			goto err;
-		insert_loose_map(source, &oid, &compat_oid);
+		insert_loose_map(loose, &oid, &compat_oid);
 	}
 
 	strbuf_release(&buf);
@@ -119,7 +117,8 @@ int repo_read_loose_object_map(struct repository *repo)
 	odb_prepare_alternates(repo->objects);
 
 	for (source = repo->objects->sources; source; source = source->next) {
-		if (load_one_loose_object_map(repo, source) < 0) {
+		struct odb_source_files *files = odb_source_files_downcast(source);
+		if (load_one_loose_object_map(repo, files->loose) < 0) {
 			return -1;
 		}
 	}
@@ -171,7 +170,7 @@ int repo_write_loose_object_map(struct repository *repo)
 	return -1;
 }
 
-static int write_one_object(struct odb_source *source,
+static int write_one_object(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
 {
@@ -180,7 +179,7 @@ static int write_one_object(struct odb_source *source,
 	struct stat st;
 	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
 
-	strbuf_addf(&path, "%s/loose-object-idx", source->path);
+	strbuf_addf(&path, "%s/loose-object-idx", loose->base.path);
 	hold_lock_file_for_update_timeout(&lock, path.buf, LOCK_DIE_ON_ERROR, -1);
 
 	fd = open(path.buf, O_WRONLY | O_CREAT | O_APPEND, 0666);
@@ -196,7 +195,7 @@ static int write_one_object(struct odb_source *source,
 		goto errout;
 	if (close(fd))
 		goto errout;
-	adjust_shared_perm(source->odb->repo, path.buf);
+	adjust_shared_perm(loose->base.odb->repo, path.buf);
 	rollback_lock_file(&lock);
 	strbuf_release(&buf);
 	strbuf_release(&path);
@@ -210,18 +209,18 @@ static int write_one_object(struct odb_source *source,
 	return -1;
 }
 
-int repo_add_loose_object_map(struct odb_source *source,
+int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid)
 {
 	int inserted = 0;
 
-	if (!should_use_loose_object_map(source->odb->repo))
+	if (!should_use_loose_object_map(loose->base.odb->repo))
 		return 0;
 
-	inserted = insert_loose_map(source, oid, compat_oid);
+	inserted = insert_loose_map(loose, oid, compat_oid);
 	if (inserted)
-		return write_one_object(source, oid, compat_oid);
+		return write_one_object(loose, oid, compat_oid);
 	return 0;
 }
 
diff --git a/loose.h b/loose.h
index 6af1702973..6c9b3f4571 100644
--- a/loose.h
+++ b/loose.h
@@ -4,7 +4,7 @@
 #include "khash.h"
 
 struct repository;
-struct odb_source;
+struct odb_source_loose;
 
 struct loose_object_map {
 	kh_oid_map_t *to_compat;
@@ -17,7 +17,7 @@ int repo_loose_object_map_oid(struct repository *repo,
 			      const struct object_id *src,
 			      const struct git_hash_algo *dest_algo,
 			      struct object_id *dest);
-int repo_add_loose_object_map(struct odb_source *source,
+int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
diff --git a/object-file.c b/object-file.c
index 0689a4e67b..fe24f00d1b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -810,6 +810,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *in_stream, size_t len,
 				  struct object_id *oid)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
 	int fd, ret, err = 0, flush = 0;
@@ -918,7 +919,7 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	err = finalize_object_file_flags(source->odb->repo, tmp_file.buf, filename.buf,
 					 FOF_SKIP_COLLISION_CHECK);
 	if (!err && compat)
-		err = repo_add_loose_object_map(source, oid, &compat_oid);
+		err = repo_add_loose_object_map(files->loose, oid, &compat_oid);
 cleanup:
 	strbuf_release(&tmp_file);
 	strbuf_release(&filename);
@@ -931,6 +932,7 @@ int odb_source_loose_write_object(struct odb_source *source,
 				  struct object_id *compat_oid_in,
 				  enum odb_write_object_flags flags)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
@@ -962,13 +964,14 @@ int odb_source_loose_write_object(struct odb_source *source,
 	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
 		return -1;
 	if (compat)
-		return repo_add_loose_object_map(source, oid, &compat_oid);
+		return repo_add_loose_object_map(files->loose, oid, &compat_oid);
 	return 0;
 }
 
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	void *buf;
 	unsigned long len;
@@ -998,7 +1001,7 @@ int force_object_loose(struct odb_source *source,
 	hdrlen = format_object_header(hdr, sizeof(hdr), type, len);
 	ret = write_loose_object(source, oid, hdr, hdrlen, buf, len, mtime, 0);
 	if (!ret && compat)
-		ret = repo_add_loose_object_map(source, oid, &compat_oid);
+		ret = repo_add_loose_object_map(files->loose, oid, &compat_oid);
 	free(buf);
 
 	return ret;

-- 
2.54.0.926.g75ba10bac6.dirty

