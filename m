Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD733AD86
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710928; cv=none; b=uTWVTu9t0eLWVo0Rp0a6RChIbylkwZ2ZYnXTqk2xCkKyJNqzpCf6D25EirVMkcaWeS38q3/anrIA1JhP2+vmKk2fyGIyDCROAiDBdzKZRLVVLm+hDTTl7gVV4YDXAy0KGUSioNGbmANtkp1wlCLdaqHPjYW/tyUuFZKiQg3ifCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710928; c=relaxed/simple;
	bh=Sx7rvmnzvv4+G9HcI6yl2KESCg40srdGjZJvIrFr76I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d3yc1J4pUAb01+IiPk2yPa8IAzy+n/bmxqB3ovK2U1BKx6D0ssKrXrI8KO9qwiFDOYRa2kDf0L/XkA26ZlSOlAJv5+Ml9M/UD2jdOxPwWNUKxByEeO2JuSv96N1NCuNQDBVmvh+poxQuTdZcuhspuI/4fGZ4U3RqsGegan6Yi4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a/tVRHAz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hssCEOzp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a/tVRHAz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hssCEOzp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB9A77A01AB;
	Fri, 21 Nov 2025 02:42:05 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Nov 2025 02:42:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710925;
	 x=1763797325; bh=HYy7yPvT7WGvdNM2RYawyi84O66APKEbw1eg3QJPx4o=; b=
	a/tVRHAz57u+FAZIy+x1XSVvIUaPD7/dD6ETvmDg3HU7ZfmqkgZlVdwQEfRK7Wnv
	qHhA+VBNivnsZwv6ZtWnzS+Ep+gdHpMsa8n1oknAdSGgsqjo9pGeLVsmk0kMlrGe
	LhFzb0uocuhVN5WC8Hk9GpvLXw11KhtcQePd6DwEqawoG/YmMusLRulNCmhiL9+x
	JJjbLCo+0PPoyRZOBBMwwyEALnaTCxU6c3e7k+sL21DoR8YP3/Y5HqGyDGGDc+IC
	WVEQBFgKvqoixeTLVT2QzUwJEviA2CngEC0AqlX8pS7SZi/zAd1M2A6tKsge8gxv
	s6GcPVxBbZgPa6lvlM8ccA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710925; x=
	1763797325; bh=HYy7yPvT7WGvdNM2RYawyi84O66APKEbw1eg3QJPx4o=; b=h
	ssCEOzpN7Wf35cEqi50YrRFUZ18JQ47tugzZaAA8TX9t+Tsox5goQhj0BEMRmljG
	RMNF3eM2j1eOMAhF30IgE1lXDEImQbmnNsh36R0crtOuPq7WXTZW0gSe9gosJExd
	MJSsSZL5+qMzwJ5jD45HKvHBHGAqiT15qQ41oZQfHwnfJeNm77BEkp8bk/11Tcrq
	+oWcK6rmomEd8hJY6rHJrfhnYfR6xnGX2IOd6BUYizKd4k6+16ugD/WVDMi1nmOX
	hAGIcAgkEK0eXhaoESZMc/LLumvqcYyrPynzAFNxJkKc2qOF9LQSoNJDTZU6ewtn
	cqxbVJaFFsjFh6wmWz9RQ==
X-ME-Sender: <xms:zRcgaeSNnWDF1Kp21wuk_R-etJ7TwV2nb0V0qqEIgotF0FCN02FOUA>
    <xme:zRcgabM5kujUTAiBzb9YU73BdstK2Rm7FoSnvFw-hFVqs_0ACEtxfw4xkWbhxHGTU
    qnz1oRQfVu_F1uGqDOZfGux0FDYErBiQfIMfDaIL4wTAwII2kQlAg>
X-ME-Received: <xmr:zRcgaZNrmwWcJ9TG9G2-JBCQJJ7RiusGfcYel51tg6Go02pNdv3PA9v094YSXTCKnOlUrX_WJTRH4HRr4jamDvlt0xQb7M_yzGd9r-rfPakz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:zRcgaTtjIZTnxBqv2w3Q0Q0Dcc1xlkLid8y8qhlmi4yg6JyiEGoIxA>
    <xmx:zRcgabW9IyC8vLbpWggN_UAw9CifcSxmXXhaz0cv16qy3SPIvbxwDg>
    <xmx:zRcgaTvlFa-N9PrsIMopWnwpVaKGq5DusXGWWnfo5oT2XnsERq7hXw>
    <xmx:zRcgafWlfCIbTfbsMjh-7S5H1vooiOFoQf8gd2MqypfhmqoYHcdg7w>
    <xmx:zRcgaSo1swOxjWQCQj-y1dz08xReuCbSx5oH7j5-Xt4UxCDQM1046GWQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:42:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 466587f3 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:42:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:41:02 +0100
Subject: [PATCH v2 17/19] streaming: refactor interface to be
 object-database-centric
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-17-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

Refactor the streaming interface to be centered around object databases
instead of centered around the repository. Rename the functions
accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c          |  6 +++---
 archive-zip.c          | 12 ++++++------
 builtin/index-pack.c   |  8 ++++----
 builtin/pack-objects.c | 14 +++++++-------
 object-file.c          |  8 ++++----
 streaming.c            | 44 ++++++++++++++++++++++----------------------
 streaming.h            | 30 +++++++++++++++++++++++++-----
 7 files changed, 71 insertions(+), 51 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index dc1eda09e0..4133e09ca1 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -135,16 +135,16 @@ static int stream_blocked(struct repository *r, const struct object_id *oid)
 	char buf[BLOCKSIZE];
 	ssize_t readlen;
 
-	st = open_istream(r, oid, &type, &sz, NULL);
+	st = odb_read_object_stream(r->objects, oid, &type, &sz, NULL);
 	if (!st)
 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
 	for (;;) {
-		readlen = read_istream(st, buf, sizeof(buf));
+		readlen = odb_read_stream_read(st, buf, sizeof(buf));
 		if (readlen <= 0)
 			break;
 		do_write_blocked(buf, readlen);
 	}
-	close_istream(st);
+	odb_read_stream_close(st);
 	if (!readlen)
 		finish_record();
 	return readlen;
diff --git a/archive-zip.c b/archive-zip.c
index 40a9c93ff9..ff57f4f884 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -348,8 +348,8 @@ static int write_zip_entry(struct archiver_args *args,
 
 		if (!buffer) {
 			enum object_type type;
-			stream = open_istream(args->repo, oid, &type, &size,
-					      NULL);
+			stream = odb_read_object_stream(args->repo->objects, oid,
+							&type, &size, NULL);
 			if (!stream)
 				return error(_("cannot stream blob %s"),
 					     oid_to_hex(oid));
@@ -429,7 +429,7 @@ static int write_zip_entry(struct archiver_args *args,
 		ssize_t readlen;
 
 		for (;;) {
-			readlen = read_istream(stream, buf, sizeof(buf));
+			readlen = odb_read_stream_read(stream, buf, sizeof(buf));
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
@@ -439,7 +439,7 @@ static int write_zip_entry(struct archiver_args *args,
 							    buf, readlen);
 			write_or_die(1, buf, readlen);
 		}
-		close_istream(stream);
+		odb_read_stream_close(stream);
 		if (readlen)
 			return readlen;
 
@@ -462,7 +462,7 @@ static int write_zip_entry(struct archiver_args *args,
 		zstream.avail_out = sizeof(compressed);
 
 		for (;;) {
-			readlen = read_istream(stream, buf, sizeof(buf));
+			readlen = odb_read_stream_read(stream, buf, sizeof(buf));
 			if (readlen <= 0)
 				break;
 			crc = crc32(crc, buf, readlen);
@@ -486,7 +486,7 @@ static int write_zip_entry(struct archiver_args *args,
 			}
 
 		}
-		close_istream(stream);
+		odb_read_stream_close(stream);
 		if (readlen)
 			return readlen;
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 5f90f12f92..67221dbe6a 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -779,7 +779,7 @@ static int compare_objects(const unsigned char *buf, unsigned long size,
 	}
 
 	while (size) {
-		ssize_t len = read_istream(data->st, data->buf, size);
+		ssize_t len = odb_read_stream_read(data->st, data->buf, size);
 		if (len == 0)
 			die(_("SHA1 COLLISION FOUND WITH %s !"),
 			    oid_to_hex(&data->entry->idx.oid));
@@ -807,15 +807,15 @@ static int check_collison(struct object_entry *entry)
 
 	memset(&data, 0, sizeof(data));
 	data.entry = entry;
-	data.st = open_istream(the_repository, &entry->idx.oid, &type, &size,
-			       NULL);
+	data.st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
+					 &type, &size, NULL);
 	if (!data.st)
 		return -1;
 	if (size != entry->size || type != entry->type)
 		die(_("SHA1 COLLISION FOUND WITH %s !"),
 		    oid_to_hex(&entry->idx.oid));
 	unpack_data(entry, compare_objects, &data);
-	close_istream(data.st);
+	odb_read_stream_close(data.st);
 	free(data.buf);
 	return 0;
 }
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c693d948e1..adf267c59d 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -417,7 +417,7 @@ static unsigned long write_large_blob_data(struct odb_read_stream *st, struct ha
 	for (;;) {
 		ssize_t readlen;
 		int zret = Z_OK;
-		readlen = read_istream(st, ibuf, sizeof(ibuf));
+		readlen = odb_read_stream_read(st, ibuf, sizeof(ibuf));
 		if (readlen == -1)
 			die(_("unable to read %s"), oid_to_hex(oid));
 
@@ -520,8 +520,8 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		if (oe_type(entry) == OBJ_BLOB &&
 		    oe_size_greater_than(&to_pack, entry,
 					 repo_settings_get_big_file_threshold(the_repository)) &&
-		    (st = open_istream(the_repository, &entry->idx.oid, &type,
-				       &size, NULL)) != NULL)
+		    (st = odb_read_object_stream(the_repository->objects, &entry->idx.oid,
+						 &type, &size, NULL)) != NULL)
 			buf = NULL;
 		else {
 			buf = odb_read_object(the_repository->objects,
@@ -577,7 +577,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 			dheader[--pos] = 128 | (--ofs & 127);
 		if (limit && hdrlen + sizeof(dheader) - pos + datalen + hashsz >= limit) {
 			if (st)
-				close_istream(st);
+				odb_read_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -591,7 +591,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 		 */
 		if (limit && hdrlen + hashsz + datalen + hashsz >= limit) {
 			if (st)
-				close_istream(st);
+				odb_read_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -601,7 +601,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	} else {
 		if (limit && hdrlen + datalen + hashsz >= limit) {
 			if (st)
-				close_istream(st);
+				odb_read_stream_close(st);
 			free(buf);
 			return 0;
 		}
@@ -609,7 +609,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	}
 	if (st) {
 		datalen = write_large_blob_data(st, f, &entry->idx.oid);
-		close_istream(st);
+		odb_read_stream_close(st);
 	} else {
 		hashwrite(f, buf, datalen);
 		free(buf);
diff --git a/object-file.c b/object-file.c
index 8c67847fea..c6d2f2d953 100644
--- a/object-file.c
+++ b/object-file.c
@@ -139,7 +139,7 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
 
-	st = open_istream(r, oid, &obj_type, &size, NULL);
+	st = odb_read_object_stream(r->objects, oid, &obj_type, &size, NULL);
 	if (!st)
 		return -1;
 
@@ -151,10 +151,10 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	git_hash_update(&c, hdr, hdrlen);
 	for (;;) {
 		char buf[1024 * 16];
-		ssize_t readlen = read_istream(st, buf, sizeof(buf));
+		ssize_t readlen = odb_read_stream_read(st, buf, sizeof(buf));
 
 		if (readlen < 0) {
-			close_istream(st);
+			odb_read_stream_close(st);
 			return -1;
 		}
 		if (!readlen)
@@ -162,7 +162,7 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 		git_hash_update(&c, buf, readlen);
 	}
 	git_hash_final_oid(&real_oid, &c);
-	close_istream(st);
+	odb_read_stream_close(st);
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
diff --git a/streaming.c b/streaming.c
index 3d80ddd757..3ac1a0c40f 100644
--- a/streaming.c
+++ b/streaming.c
@@ -35,7 +35,7 @@ static int close_istream_filtered(struct odb_read_stream *_fs)
 {
 	struct odb_filtered_read_stream *fs = (struct odb_filtered_read_stream *)_fs;
 	free_stream_filter(fs->filter);
-	return close_istream(fs->upstream);
+	return odb_read_stream_close(fs->upstream);
 }
 
 static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
@@ -87,7 +87,7 @@ static ssize_t read_istream_filtered(struct odb_read_stream *_fs, char *buf,
 
 		/* refill the input from the upstream */
 		if (!fs->input_finished) {
-			fs->i_end = read_istream(fs->upstream, fs->ibuf, FILTER_BUFFER);
+			fs->i_end = odb_read_stream_read(fs->upstream, fs->ibuf, FILTER_BUFFER);
 			if (fs->i_end < 0)
 				return -1;
 			if (fs->i_end)
@@ -149,7 +149,7 @@ static ssize_t read_istream_incore(struct odb_read_stream *_st, char *buf, size_
 }
 
 static int open_istream_incore(struct odb_read_stream **out,
-			       struct repository *r,
+			       struct object_database *odb,
 			       const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -163,7 +163,7 @@ static int open_istream_incore(struct odb_read_stream **out,
 	oi.typep = &stream.base.type;
 	oi.sizep = &stream.base.size;
 	oi.contentp = (void **)&stream.buf;
-	ret = odb_read_object_info_extended(r->objects, oid, &oi,
+	ret = odb_read_object_info_extended(odb, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
@@ -180,49 +180,49 @@ static int open_istream_incore(struct odb_read_stream **out,
  *****************************************************************************/
 
 static int istream_source(struct odb_read_stream **out,
-			  struct repository *r,
+			  struct object_database *odb,
 			  const struct object_id *oid)
 {
 	struct odb_source *source;
 
-	if (!packfile_store_read_object_stream(out, r->objects->packfiles, oid))
+	if (!packfile_store_read_object_stream(out, odb->packfiles, oid))
 		return 0;
 
-	odb_prepare_alternates(r->objects);
-	for (source = r->objects->sources; source; source = source->next)
+	odb_prepare_alternates(odb);
+	for (source = odb->sources; source; source = source->next)
 		if (!odb_source_loose_read_object_stream(out, source, oid))
 			return 0;
 
-	return open_istream_incore(out, r, oid);
+	return open_istream_incore(out, odb, oid);
 }
 
 /****************************************************************
  * Users of streaming interface
  ****************************************************************/
 
-int close_istream(struct odb_read_stream *st)
+int odb_read_stream_close(struct odb_read_stream *st)
 {
 	int r = st->close(st);
 	free(st);
 	return r;
 }
 
-ssize_t read_istream(struct odb_read_stream *st, void *buf, size_t sz)
+ssize_t odb_read_stream_read(struct odb_read_stream *st, void *buf, size_t sz)
 {
 	return st->read(st, buf, sz);
 }
 
-struct odb_read_stream *open_istream(struct repository *r,
-				     const struct object_id *oid,
-				     enum object_type *type,
-				     unsigned long *size,
-				     struct stream_filter *filter)
+struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
+					       const struct object_id *oid,
+					       enum object_type *type,
+					       unsigned long *size,
+					       struct stream_filter *filter)
 {
 	struct odb_read_stream *st;
-	const struct object_id *real = lookup_replace_object(r, oid);
+	const struct object_id *real = lookup_replace_object(odb->repo, oid);
 	int ret;
 
-	ret = istream_source(&st, r, real);
+	ret = istream_source(&st, odb, real);
 	if (ret)
 		return NULL;
 
@@ -230,7 +230,7 @@ struct odb_read_stream *open_istream(struct repository *r,
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
 		struct odb_read_stream *nst = attach_stream_filter(st, filter);
 		if (!nst) {
-			close_istream(st);
+			odb_read_stream_close(st);
 			return NULL;
 		}
 		st = nst;
@@ -253,7 +253,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	ssize_t kept = 0;
 	int result = -1;
 
-	st = open_istream(odb->repo, oid, &type, &sz, filter);
+	st = odb_read_object_stream(odb, oid, &type, &sz, filter);
 	if (!st) {
 		if (filter)
 			free_stream_filter(filter);
@@ -264,7 +264,7 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	for (;;) {
 		char buf[1024 * 16];
 		ssize_t wrote, holeto;
-		ssize_t readlen = read_istream(st, buf, sizeof(buf));
+		ssize_t readlen = odb_read_stream_read(st, buf, sizeof(buf));
 
 		if (readlen < 0)
 			goto close_and_exit;
@@ -295,6 +295,6 @@ int odb_stream_blob_to_fd(struct object_database *odb,
 	result = 0;
 
  close_and_exit:
-	close_istream(st);
+	odb_read_stream_close(st);
 	return result;
 }
diff --git a/streaming.h b/streaming.h
index acfdef1598..2dce2e359f 100644
--- a/streaming.h
+++ b/streaming.h
@@ -24,11 +24,31 @@ struct odb_read_stream {
 	unsigned long size; /* inflated size of full object */
 };
 
-struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
-				     enum object_type *, unsigned long *,
-				     struct stream_filter *);
-int close_istream(struct odb_read_stream *);
-ssize_t read_istream(struct odb_read_stream *, void *, size_t);
+/*
+ * Create a new object stream for the given object database. Populates the type
+ * and size pointers with the object's info. An optional filter can be used to
+ * transform the object's content.
+ *
+ * Returns the stream on success, a `NULL` pointer otherwise.
+ */
+struct odb_read_stream *odb_read_object_stream(struct object_database *odb,
+					       const struct object_id *oid,
+					       enum object_type *type,
+					       unsigned long *size,
+					       struct stream_filter *filter);
+
+/*
+ * Close the given read stream and release all resources associated with it.
+ * Returns 0 on success, a negative error code otherwise.
+ */
+int odb_read_stream_close(struct odb_read_stream *stream);
+
+/*
+ * Read data from the stream into the buffer. Returns 0 on EOF and the number
+ * of bytes read on success. Returns a negative error code in case reading from
+ * the stream fails.
+ */
+ssize_t odb_read_stream_read(struct odb_read_stream *stream, void *buf, size_t len);
 
 /*
  * Look up the object by its ID and write the full contents to the file

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

