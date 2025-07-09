Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B37292B5B
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059849; cv=none; b=GkXzIMmlbSCmaU9iqoTSwxRKNrcbsAYz4kzO4zvHu3SVgUXHOVr9KHO5Be8sXPkiwLvZ9J7olj6PgD/qCq3kxVRucyv8lP7hQV0ySnpchPVCPWB4PUS806Gk0j74DDXTq5r+hYvOE7J15rHzqTrcgeQ/0868dYHUWxO3mYMd2uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059849; c=relaxed/simple;
	bh=s3nfdC78fI33foNPomhyMi7/AwZOc7HuwEVp111218o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8woN9OVrcuL7E6OVkVIAgpCaXgo8LgHqgsraap52TUmEcChJck2oGbi5MtMU9MeBiEID6+NWs8TgPI5xPJm7AaD4+7KH6D/ZnKV/YkBnBGYufZdtQCbAQlAQJeZB+fDlqbYRSmPH/Wpl6rUggSBpCPACAPYgchxEB/BVrcZgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B0deYCKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boRFI/IY; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B0deYCKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boRFI/IY"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E00B140035E
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 07:17:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059846;
	 x=1752146246; bh=nmPIBIpWmtG+2A1K8M80Rd9v00UXzDwFbvoMWlh7Wbs=; b=
	B0deYCKbfEmWJrpdY60qP9PmYyvT1ZQ6xViUhxqLo7qt3ZPTqeUvyF/butpFItBS
	MllwlWYbsgNYG8VLkPLz4gcoFrcYPn0r1mCC0py2KbcLVa0YgFfzziZbQeHDMY+b
	As6hCHpRFNSWEu3UslEC8krAdGjtHB4rV1oMLt2DI3+O81xDX8HiZ0coUis5+yVq
	2vXQQ4dbQu/rZ1eeISUL4If4jP0n3q9FR8z/DO2a1fiWVO0Y3qIMNIUUPFa/Uhos
	6MxPLXS+0zW6dK+9MdMdV290bNqM9zp+XVzBZTa2uv/krMSogySuJ5QokRyk4zHq
	/9wbrBBURoksPixZPoT8/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059846; x=
	1752146246; bh=nmPIBIpWmtG+2A1K8M80Rd9v00UXzDwFbvoMWlh7Wbs=; b=b
	oRFI/IYn6g73HUQ4tKUQTIEb9Iul+r8YuU4g/CBqmvjadSzn+KaaKpcggMaJx/dV
	8wsQE/xLUXZv6p/DJssl58f2h0MU/fL4auo0QsEduiKCjgIyvsbwSLsRTNbnY5P7
	lZgFIeVhjtfba7ztnyPlL4OpVDhz1bRF51Bw5ud9dSK5J7iNcOzwbPbCgfs2cGau
	aMlpnghkGRLU991CCQxfzhuUOKKIX3jGO2GNgQISCGvOvVWp9H0EnJa0eFAPg+Ym
	7gezQSZ2hOGNQ38eyIOJp70hfZJ3aLuZx7ihtOwGjUcf8hujCjZnFNqdX5CDz6IZ
	L8AsIXH0k9Q9e468BOnog==
X-ME-Sender: <xms:xk9uaE3SckNQMs8_eVvHChJQfVlWVt-ObIFhbPUL_vQI4VbzlJm6GA>
    <xme:xk9uaBEk8wH3inuuo6mtUdf-DHeEUlkeE91HADMSe8DIwTsdiLbIpD5VCQPvlJ1Fk
    QowILsvngusREUX4g>
X-ME-Received: <xmr:xk9uaGQiD63f59n-kGV2HvnKb2PBV72xWzg4xNXltcjhLNfdrV-E70AMbzD0Fgngbss34QIMn5utlK-dHFMcYjuzJieo5VbLc8TZY1k1QxaWtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:xk9uaAByrFWd2FdUeUtP9sCuPlNhHrbzfC9pRVoGjmLROa1WChpSfg>
    <xmx:xk9uaO12g0IGAnRpj5i2lIp0Sdw2GPJuBTBjrqfRlTdk88EophItCA>
    <xmx:xk9uaGWaTaZ-HyjtaKgiyelXFrOgdfidK03hG88qYSEUhgo74tdvOQ>
    <xmx:xk9uaIkacUvYqu7z5oarWgl32BuJ28qSTV4tPNc0l4n5tvODf10RuQ>
    <xmx:xk9uaO8W2JPlUx8tzGIi0AcUCC9Ft43Rtxq4PUcp3lomi2UAm5yEt3am>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eef1473e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:12 +0200
Subject: [PATCH 02/19] object-file: stop using `the_hash_algo`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-2-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are a couple of users of the `the_hash_algo` macro, which
implicitly depends on `the_repository`. Adapt these callers to not do so
anymore, either by deriving it from already-available context or by
using `the_repository->hash_algo`. The latter variant doesn't yet help
to remove the global dependency, but such users will be adapted in the
following commits to not use `the_repository` anymore, either.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 40 ++++++++++++++++++++++++----------------
 object-file.h |  1 +
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/object-file.c b/object-file.c
index 987cf289420..bc395febc9d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -25,6 +25,7 @@
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
+#include "read-cache-ll.h"
 #include "setup.h"
 #include "streaming.h"
 
@@ -41,9 +42,11 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
+static void fill_loose_path(struct strbuf *buf,
+			    const struct object_id *oid,
+			    const struct git_hash_algo *algop)
 {
-	for (size_t i = 0; i < the_hash_algo->rawsz; i++) {
+	for (size_t i = 0; i < algop->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = oid->hash[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -60,7 +63,7 @@ const char *odb_loose_path(struct odb_source *source,
 	strbuf_reset(buf);
 	strbuf_addstr(buf, source->path);
 	strbuf_addch(buf, '/');
-	fill_loose_path(buf, oid);
+	fill_loose_path(buf, oid, source->odb->repo->hash_algo);
 	return buf->buf;
 }
 
@@ -1165,7 +1168,7 @@ static int index_mem(struct index_state *istate,
 
 		opts.strict = 1;
 		opts.error_func = hash_format_check_report;
-		if (fsck_buffer(null_oid(the_hash_algo), type, buf, size, &opts))
+		if (fsck_buffer(null_oid(istate->repo->hash_algo), type, buf, size, &opts))
 			die(_("refusing to create malformed object"));
 		fsck_finish(&opts);
 	}
@@ -1173,7 +1176,7 @@ static int index_mem(struct index_state *istate,
 	if (write_object)
 		ret = write_object_file(buf, size, type, oid);
 	else
-		hash_object_file(the_hash_algo, buf, size, type, oid);
+		hash_object_file(istate->repo->hash_algo, buf, size, type, oid);
 
 	strbuf_release(&nbuf);
 	return ret;
@@ -1199,7 +1202,7 @@ static int index_stream_convert_blob(struct index_state *istate,
 		ret = write_object_file(sbuf.buf, sbuf.len, OBJ_BLOB,
 					oid);
 	else
-		hash_object_file(the_hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
+		hash_object_file(istate->repo->hash_algo, sbuf.buf, sbuf.len, OBJ_BLOB,
 				 oid);
 	strbuf_release(&sbuf);
 	return ret;
@@ -1297,7 +1300,7 @@ int index_path(struct index_state *istate, struct object_id *oid,
 		if (strbuf_readlink(&sb, path, st->st_size))
 			return error_errno("readlink(\"%s\")", path);
 		if (!(flags & INDEX_WRITE_OBJECT))
-			hash_object_file(the_hash_algo, sb.buf, sb.len,
+			hash_object_file(istate->repo->hash_algo, sb.buf, sb.len,
 					 OBJ_BLOB, oid);
 		else if (write_object_file(sb.buf, sb.len, OBJ_BLOB, oid))
 			rc = error(_("%s: failed to insert into database"), path);
@@ -1328,6 +1331,7 @@ int read_pack_header(int fd, struct pack_header *header)
 
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
+				const struct git_hash_algo *algop,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
 				each_loose_subdir_fn subdir_cb,
@@ -1364,12 +1368,12 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		namelen = strlen(de->d_name);
 		strbuf_setlen(path, baselen);
 		strbuf_add(path, de->d_name, namelen);
-		if (namelen == the_hash_algo->hexsz - 2 &&
+		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  the_hash_algo->rawsz - 1)) {
-			oid_set_algo(&oid, the_hash_algo);
-			memset(oid.hash + the_hash_algo->rawsz, 0,
-			       GIT_MAX_RAWSZ - the_hash_algo->rawsz);
+				  algop->rawsz - 1)) {
+			oid_set_algo(&oid, algop);
+			memset(oid.hash + algop->rawsz, 0,
+			       GIT_MAX_RAWSZ - algop->rawsz);
 			if (obj_cb) {
 				r = obj_cb(&oid, path->buf, data);
 				if (r)
@@ -1405,7 +1409,8 @@ int for_each_loose_file_in_objdir_buf(struct strbuf *path,
 	int i;
 
 	for (i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, path, obj_cb, cruft_cb,
+		r = for_each_file_in_obj_subdir(i, path, the_repository->hash_algo,
+						obj_cb, cruft_cb,
 						subdir_cb, data);
 		if (r)
 			break;
@@ -1481,6 +1486,7 @@ struct oidtree *odb_loose_cache(struct odb_source *source,
 	}
 	strbuf_addstr(&buf, source->path);
 	for_each_file_in_obj_subdir(subdir_nr, &buf,
+				    source->odb->repo->hash_algo,
 				    append_loose_object,
 				    NULL, NULL,
 				    source->loose_objects_cache);
@@ -1501,7 +1507,8 @@ static int check_stream_oid(git_zstream *stream,
 			    const char *hdr,
 			    unsigned long size,
 			    const char *path,
-			    const struct object_id *expected_oid)
+			    const struct object_id *expected_oid,
+			    const struct git_hash_algo *algop)
 {
 	struct git_hash_ctx c;
 	struct object_id real_oid;
@@ -1509,7 +1516,7 @@ static int check_stream_oid(git_zstream *stream,
 	unsigned long total_read;
 	int status = Z_OK;
 
-	the_hash_algo->init_fn(&c);
+	algop->init_fn(&c);
 	git_hash_update(&c, hdr, stream->total_out);
 
 	/*
@@ -1594,7 +1601,8 @@ int read_loose_object(const char *path,
 
 	if (*oi->typep == OBJ_BLOB &&
 	    *size > repo_settings_get_big_file_threshold(the_repository)) {
-		if (check_stream_oid(&stream, hdr, *size, path, expected_oid) < 0)
+		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
+				     the_repository->hash_algo) < 0)
 			goto out_inflate;
 	} else {
 		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
diff --git a/object-file.h b/object-file.h
index 67b4ffc4808..222ff2871a1 100644
--- a/object-file.h
+++ b/object-file.h
@@ -89,6 +89,7 @@ typedef int each_loose_subdir_fn(unsigned int nr,
 				 void *data);
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
+				const struct git_hash_algo *algo,
 				each_loose_object_fn obj_cb,
 				each_loose_cruft_fn cruft_cb,
 				each_loose_subdir_fn subdir_cb,

-- 
2.50.1.327.g047016eb4a.dirty

