Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0323A3E9C
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351789; cv=none; b=jxt7RmGyf+Qq/zH/YFRsuitto+qTxDu1D68Au4CddKP7v4nWe/oipKt08KQkYZsfdMDDiPt2fI7oekst4Q5jb+DNRXrflurYUZ4aSWQb4KBbcdEkM0f3lGwuKJw5BJKbail5Jkwx6mrnOmGMEZNLlLn8bM87q8XrEGJaHuthXWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351789; c=relaxed/simple;
	bh=46WCSRzj8gFO0CciVqOltkypQ8vOUiT7WtdGFIaft0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJrTFEaIUJEWjtzwfvjUZxOF2ZJpyRkcQHjvdrgRXoqTgdp+W1I7ga2Bn24XqhiBH+AmdofsGbQsfCxvmxlD2B6AwlyEOqjTg9fYX6THM6T/tBGkRRn2y6KxtrwR/5hVZix5LJezxOxkMaSsOtA9GmIMLWUXQrFG3eI8js6uqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mj9qH1T2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gKEIcuun; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mj9qH1T2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gKEIcuun"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D922EC0067
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:23:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 04:23:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351787;
	 x=1779438187; bh=9xyHItLc4FMz3WraDsxPD7uaDI6fEn0VKuexvn2DbM4=; b=
	Mj9qH1T2+XHNMSNMq4ahe4oN0SqvH+4O2UYjg6zL/Hmh5vYWEQuvuZ8cxDqWNJU8
	Ng8PtN7p0n2LJrcrQz7kLp5BI62Ezz5UBvNmT9Yo+a7ZNbpkKZI3PAAIpIYN+1x7
	3b01dmWCN8d1vS/xjcrAqKdLDkbfItLqokUjUl1ctIL/6epG/794QfjFgF2y1fBW
	d54M8Nmy9x9jn7wqhiFXNqzTrsnHAVcqjLvEwOg/k3+2o/VbIEp1KDeo2mu6qawy
	dh85nrm4IMdSGAPwdRkzOAIHnijkxzQp0qQQZQwDINOHWjyNUj1n7KoWUDUPLlne
	FzUZt9ALoT/Fiz1dbq65GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351787; x=
	1779438187; bh=9xyHItLc4FMz3WraDsxPD7uaDI6fEn0VKuexvn2DbM4=; b=g
	KEIcuunK6tu4ZnDCJIKpQSb1/UtSZ91o1zvckUrAnAfPH3nwuvoZ9+55voGaQwhl
	A0Q58IV0yH+YPLJHSJK0lZjkcoP7TgQgp0u5Y9fdbmfQbsK/pED2bsBv46cRBf/L
	T7xaUV6xkF/j2aR87x9OZ1Z39jPdcPsZS4duU6X7LrtXGVsondtHBT0pz0RVk3OI
	xq5N6WBSon4sSLrNgtRv0R0DzQD6qhI68jspaTIheWaS3fWPvCJyU7LcHz5k+GhD
	B0HiqNrkn/sRMwNuBM1PWoL9FPYu3K4Nseg4lMkqKcmBBcrLew1VTX2ZrDHUMHWb
	fZC5UWCmK0ik0NJyT4NWg==
X-ME-Sender: <xms:68AOal21GNzo9n4GQUxhvdlUO0XGaMU0aqJOiV2sBqxtM6u99B1JRw>
    <xme:68AOajDb0mdn6HTa6jy1g6aGcOQbiV4vXA-ChtX4jklqV4OSSw2LQuFofp9gziSxD
    44qe8uV0IgUu0kh6Zz131Vm1FHo330OUtbl-5jl3Q0z_LENgBhw8w>
X-ME-Received: <xmr:68AOarjeFtLX5RdVH2O6YB25kwmb_tYO-6S5FoQaxrHqtFkJNbVn2cNng4Z1WHezkpP_qdIG_sZ4L4F252z7FMA5aLw8u97skvFtOaaszeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:68AOan-l60k01-kQBCD-_50gRXv7vy-_82Oc5P6ytUQRYpqxvS6CvA>
    <xmx:68AOan-GPoTvKAlruaXqt_uLAkQWrX6JZE_tgTjkQYzsAG8r8KazmA>
    <xmx:68AOagBLNFyDLo_bm6u0l-HKLDNONndS9EroCa_3qL8hjWUQy9gZjw>
    <xmx:68AOanz4pHB9R8KVU_zSA5A_vvTxMd09jL9T0vVs5bllGoX7_FSEbQ>
    <xmx:68AOarFSoJv8c-vA4I3pP64teaujEx9zHw5o6oE7cHabbTWL9gxRbh2U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:23:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0777232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:23:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:34 +0200
Subject: [PATCH 14/18] odb/source-loose: wire up `write_object()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-14-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Move `odb_source_loose_write_object()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `write_object()` callback of
the loose source.

As in preceding commits, this requires us to expose a couple of generic
functions from "object-file.c" as they are used in both subsystems now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 58 ++++++++----------------------------------------------
 object-file.h      | 14 +++++++------
 odb/source-files.c |  5 +++--
 odb/source-loose.c | 44 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 63 insertions(+), 58 deletions(-)

diff --git a/object-file.c b/object-file.c
index fe24f00d1b..7bb5b31bca 100644
--- a/object-file.c
+++ b/object-file.c
@@ -326,10 +326,10 @@ static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_c
 	git_hash_final_oid(oid, c);
 }
 
-static void write_object_file_prepare(const struct git_hash_algo *algo,
-				      const void *buf, unsigned long len,
-				      enum object_type type, struct object_id *oid,
-				      char *hdr, int *hdrlen)
+void write_object_file_prepare(const struct git_hash_algo *algo,
+			       const void *buf, unsigned long len,
+			       enum object_type type, struct object_id *oid,
+			       char *hdr, int *hdrlen)
 {
 	struct git_hash_ctx c;
 
@@ -746,10 +746,10 @@ static int end_loose_object_common(struct odb_source *source,
 	return Z_OK;
 }
 
-static int write_loose_object(struct odb_source *source,
-			      const struct object_id *oid, char *hdr,
-			      int hdrlen, const void *buf, unsigned long len,
-			      time_t mtime, unsigned flags)
+int write_loose_object(struct odb_source *source,
+		       const struct object_id *oid, char *hdr,
+		       int hdrlen, const void *buf, unsigned long len,
+		       time_t mtime, unsigned flags)
 {
 	int fd, ret;
 	unsigned char compressed[4096];
@@ -926,48 +926,6 @@ int odb_source_loose_write_stream(struct odb_source *source,
 	return err;
 }
 
-int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
-				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in,
-				  enum odb_write_object_flags flags)
-{
-	struct odb_source_files *files = odb_source_files_downcast(source);
-	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
-	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
-	struct object_id compat_oid;
-	char hdr[MAX_HEADER_LEN];
-	int hdrlen = sizeof(hdr);
-
-	/* Generate compat_oid */
-	if (compat) {
-		if (compat_oid_in)
-			oidcpy(&compat_oid, compat_oid_in);
-		else if (type == OBJ_BLOB)
-			hash_object_file(compat, buf, len, type, &compat_oid);
-		else {
-			struct strbuf converted = STRBUF_INIT;
-			convert_object_file(source->odb->repo, &converted, algo, compat,
-					    buf, len, type, 0);
-			hash_object_file(compat, converted.buf, converted.len,
-					 type, &compat_oid);
-			strbuf_release(&converted);
-		}
-	}
-
-	/* Normally if we have it in the pack then we do not bother writing
-	 * it out into .git/objects/??/?{38} file.
-	 */
-	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
-	if (odb_freshen_object(source->odb, oid))
-		return 0;
-	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
-		return -1;
-	if (compat)
-		return repo_add_loose_object_map(files->loose, oid, &compat_oid);
-	return 0;
-}
-
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime)
 {
diff --git a/object-file.h b/object-file.h
index 1d90df9d98..2b32592de1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,12 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_write_object(struct odb_source *source,
-				  const void *buf, unsigned long len,
-				  enum object_type type, struct object_id *oid,
-				  struct object_id *compat_oid_in,
-				  enum odb_write_object_flags flags);
-
 int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
@@ -129,6 +123,14 @@ int finalize_object_file_flags(struct repository *repo,
 void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      unsigned long len, enum object_type type,
 		      struct object_id *oid);
+void write_object_file_prepare(const struct git_hash_algo *algo,
+			       const void *buf, unsigned long len,
+			       enum object_type type, struct object_id *oid,
+			       char *hdr, int *hdrlen);
+int write_loose_object(struct odb_source *source,
+		       const struct object_id *oid, char *hdr,
+		       int hdrlen, const void *buf, unsigned long len,
+		       time_t mtime, unsigned flags);
 
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
diff --git a/odb/source-files.c b/odb/source-files.c
index ef548e6fe6..52ba04237a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -164,8 +164,9 @@ static int odb_source_files_write_object(struct odb_source *source,
 					 struct object_id *compat_oid,
 					 enum odb_write_object_flags flags)
 {
-	return odb_source_loose_write_object(source, buf, len, type,
-					     oid, compat_oid, flags);
+	struct odb_source_files *files = odb_source_files_downcast(source);
+	return odb_source_write_object(&files->loose->base, buf, len, type,
+				       oid, compat_oid, flags);
 }
 
 static int odb_source_files_write_object_stream(struct odb_source *source,
diff --git a/odb/source-loose.c b/odb/source-loose.c
index e519365d23..c91018109e 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -5,6 +5,7 @@
 #include "hex.h"
 #include "loose.h"
 #include "object-file.h"
+#include "object-file-convert.h"
 #include "odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
@@ -588,6 +589,48 @@ static int odb_source_loose_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_file(path.buf, 1);
 }
 
+static int odb_source_loose_write_object(struct odb_source *source,
+					 const void *buf, unsigned long len,
+					 enum object_type type, struct object_id *oid,
+					 struct object_id *compat_oid_in,
+					 enum odb_write_object_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	const struct git_hash_algo *algo = source->odb->repo->hash_algo;
+	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
+	struct object_id compat_oid;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen = sizeof(hdr);
+
+	/* Generate compat_oid */
+	if (compat) {
+		if (compat_oid_in)
+			oidcpy(&compat_oid, compat_oid_in);
+		else if (type == OBJ_BLOB)
+			hash_object_file(compat, buf, len, type, &compat_oid);
+		else {
+			struct strbuf converted = STRBUF_INIT;
+			convert_object_file(source->odb->repo, &converted, algo, compat,
+					    buf, len, type, 0);
+			hash_object_file(compat, converted.buf, converted.len,
+					 type, &compat_oid);
+			strbuf_release(&converted);
+		}
+	}
+
+	/* Normally if we have it in the pack then we do not bother writing
+	 * it out into .git/objects/??/?{38} file.
+	 */
+	write_object_file_prepare(algo, buf, len, type, oid, hdr, &hdrlen);
+	if (odb_freshen_object(source->odb, oid))
+		return 0;
+	if (write_loose_object(source, oid, hdr, hdrlen, buf, len, 0, flags))
+		return -1;
+	if (compat)
+		return repo_add_loose_object_map(loose, oid, &compat_oid);
+	return 0;
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -647,6 +690,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
 	loose->base.count_objects = odb_source_loose_count_objects;
 	loose->base.freshen_object = odb_source_loose_freshen_object;
+	loose->base.write_object = odb_source_loose_write_object;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

