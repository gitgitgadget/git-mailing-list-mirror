Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEE82F1FFA
	for <git@vger.kernel.org>; Fri, 31 Oct 2025 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891210; cv=none; b=O5G3p8ZHk/gXL7/TeDyqj6bbhFDCMC6wOtSncKSO0X0zd+Q4gZGA6j8PPh2FTw09pfsPfJM4QB8sqNwCred8wvXUt9BWvaOJJXfAmiFitUfx7rEBdATAU3zhIsMG2VuD8Y0JF65MsphRqKihOhZC0gYkwxww+VHzyHcN7UM9GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891210; c=relaxed/simple;
	bh=6Q4njyaaWhrQmyvuqSDFXiRIOVeMXLexArocERms+Dk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ptNhTMJ8UJL3K6HmxI/Os9xlWHIB6ir2EY4RZYI1BzC+Ce8CpTxa4+f8QNJmkNk6gYnQYjLrJAiylYKtkoqNlfPP9QSdajcOaGhXriyXqibbawL7VzyOwJ0VizwJidYTlJGvZMqhSYEFUqqAcWjY6YIcT5cny9wKgy1hiZcXm4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VCAbLi9K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sJJuSLG/; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VCAbLi9K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sJJuSLG/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F684140012D;
	Fri, 31 Oct 2025 02:13:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 31 Oct 2025 02:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761891208;
	 x=1761977608; bh=5+qAgV0KzPW/KtvXn1vUApiEX3hBsA4Tx31X4wd4+PA=; b=
	VCAbLi9KjYyUwNOii6i+zH6s/DfkBM438dR1ZnPgezFyHIpNUqZLktV+0cTwvEO/
	RQVpDIlQ1y7cGSKgX1bt1hviaei7OIPw483B1DiuHFCevKNRZl4IxEH+DZ4IzT9K
	PDflIfmFUMPaQfYDVwcu+kLEpNRxnKanbSRUZyA4UmZ4+OyCDDBQSty/M4PzZhBy
	AnxaYabU8B4xlM/JGXzStl0MoCgiZbE2Jfz+tZJBM8ASORHxOJ3+Hu2YQ6jthQNs
	5KsBwOS85ZrB9QI9+Xfb/PvgC/NSfbRrJZ+gdsowoFGJ70QHtJA8WnHPoN5C/qw7
	lHgDf/0UPR+ZmBuVc2DWtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761891208; x=
	1761977608; bh=5+qAgV0KzPW/KtvXn1vUApiEX3hBsA4Tx31X4wd4+PA=; b=s
	JJuSLG/Bi7SgCq56/GGluTTebp5OcLO52zzohD7H3YMB170QAMFEMSHbE+pT25wb
	xVjHQ6HXRJDCONfTDRynk9P3k0ooKKdpJnuaPPaNDncPXKkdnIe6PIF1YHll4Tmm
	U70fN6UineazK+ZcDl/3aKSoGE+5+X1JL0g7s0uYCybV2EOshfKd3l8TEuXoL5vA
	VeOVchaCD392RlGQIpP5mVrcfN1jSP0rieBkeTUOB8qS/NQhO7lNS0RsI/qe5JXD
	SUDRy+Z5r5Hes1oFRbSGg+BEJlvXcmkuknK81qaO3qSnVyvlaKaUyhTW3i7dfvME
	cAU5tittefZP1wZbQwZuA==
X-ME-Sender: <xms:h1MEadDQUV5TeFZOAU6xD0bTjNv5QZTzkxdrWAa8_mA4LfOKO7lYeA>
    <xme:h1MEaS_AAjzolOi5vcO6hpgvJy3wPddyw0bk2Yj4ul6EBEiIn2YkmjdiltxfDe_TO
    IZ08u_VeriEEGKx6oaLXA7LeNWptjSohOS-31JcgcrcDpQCr5oDDw>
X-ME-Received: <xmr:h1MEaV8WqCeXGkyCXAcMPwOD0oQsIcj18eroLFRH8-U7Nm84HUTHLEFrvs0VpcHuTQTQ5AeESJ4H5Na7Yeus0EWb2MPWBvcl_mxgF5vBxQa4tQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieekjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeelnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:h1MEaRdkCdFKv7zOoUx1Ra7jFXBONTs_o5AAAE2ZbViP5Rz90os5Qw>
    <xmx:h1MEaWHDgRJer1vjB49LkkNsBoyDEgchm536n6lHQf6c3Nuyx8Y9XA>
    <xmx:h1MEaXfXxrync0UskBRzEK__JFd2__j4w_bYbmOPXmr6CUiNLQY0wQ>
    <xmx:h1MEaYGxxUcTUKhrAyPx0MY1dnFjqgqepoB2WCYJ74u17Cjls9hNnQ>
    <xmx:iFMEaS_bgUmhXbtSxAv_6Jcw2OiAVp3FNPp2Plz_1yEV-1o3F_OR4g0C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Oct 2025 02:13:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8ecbce63 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 31 Oct 2025 06:13:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 31 Oct 2025 07:12:49 +0100
Subject: [PATCH v2 13/13] object-file: refactor writing objects via a
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-pks-odb-loose-backend-v2-13-920f721aef71@pks.im>
References: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
In-Reply-To: <20251031-b4-pks-odb-loose-backend-v2-0-920f721aef71@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

We have two different ways to write an object into the database:

  - We either provide the full buffer and write the object all at once.

  - Or we provide an input stream that has a `read()` function so that
    we can chunk the object.

The latter is especially used for large objects, where it may be too
expensive to hold the complete object in memory all at once.

While we already have `odb_write_object()` at the ODB-layer, we don't
have an equivalent for streaming an object. Introduce a new function
`odb_write_object_stream()` to address this gap so that callers don't
have to be aware of the inner workings of how to stream an object to
disk with a specific object source.

Rename `stream_loose_object()` to `odb_loose_source_write_stream()` to
clarify its scope. This matches our modern best practices around how to
name functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/unpack-objects.c |  7 +++----
 object-file.c            |  6 +++---
 object-file.h            | 14 ++++----------
 odb.c                    |  7 +++++++
 odb.h                    | 10 ++++++++++
 5 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index ef79e43715d..6fc64e9e4b8 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -363,7 +363,7 @@ struct input_zstream_data {
 	int status;
 };
 
-static const void *feed_input_zstream(struct input_stream *in_stream,
+static const void *feed_input_zstream(struct odb_write_stream *in_stream,
 				      unsigned long *readlen)
 {
 	struct input_zstream_data *data = in_stream->data;
@@ -393,7 +393,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 {
 	git_zstream zstream = { 0 };
 	struct input_zstream_data data = { 0 };
-	struct input_stream in_stream = {
+	struct odb_write_stream in_stream = {
 		.read = feed_input_zstream,
 		.data = &data,
 	};
@@ -402,8 +402,7 @@ static void stream_blob(unsigned long size, unsigned nr)
 	data.zstream = &zstream;
 	git_inflate_init(&zstream);
 
-	if (stream_loose_object(the_repository->objects->sources,
-				&in_stream, size, &info->oid))
+	if (odb_write_object_stream(the_repository->objects, &in_stream, size, &info->oid))
 		die(_("failed to write object in stream"));
 
 	if (data.status != Z_STREAM_END)
diff --git a/object-file.c b/object-file.c
index d3e29e23c13..b02239f4e2d 100644
--- a/object-file.c
+++ b/object-file.c
@@ -974,9 +974,9 @@ int odb_loose_source_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_source(source, oid, 1);
 }
 
-int stream_loose_object(struct odb_source *source,
-			struct input_stream *in_stream, size_t len,
-			struct object_id *oid)
+int odb_loose_source_write_stream(struct odb_source *source,
+				  struct odb_write_stream *in_stream, size_t len,
+				  struct object_id *oid)
 {
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
diff --git a/object-file.h b/object-file.h
index 428731970af..c933be01fb8 100644
--- a/object-file.h
+++ b/object-file.h
@@ -67,6 +67,10 @@ int odb_loose_source_write_object(struct odb_source *source,
 				  enum object_type type, struct object_id *oid,
 				  struct object_id *compat_oid_in, unsigned flags);
 
+int odb_loose_source_write_stream(struct odb_source *source,
+				  struct odb_write_stream *stream, size_t len,
+				  struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -173,16 +177,6 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
-struct input_stream {
-	const void *(*read)(struct input_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
-
-int stream_loose_object(struct odb_source *source,
-			struct input_stream *in_stream, size_t len,
-			struct object_id *oid);
-
 int force_object_loose(struct odb_source *source,
 		       const struct object_id *oid, time_t mtime);
 
diff --git a/odb.c b/odb.c
index 432011b4dac..62d65f71a6d 100644
--- a/odb.c
+++ b/odb.c
@@ -1025,6 +1025,13 @@ int odb_write_object_ext(struct object_database *odb,
 					     oid, compat_oid, flags);
 }
 
+int odb_write_object_stream(struct object_database *odb,
+			    struct odb_write_stream *stream, size_t len,
+			    struct object_id *oid)
+{
+	return odb_loose_source_write_stream(odb->sources, stream, len, oid);
+}
+
 struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
diff --git a/odb.h b/odb.h
index 8681b7782b4..92df20417b9 100644
--- a/odb.h
+++ b/odb.h
@@ -492,4 +492,14 @@ static inline int odb_write_object(struct object_database *odb,
 	return odb_write_object_ext(odb, buf, len, type, oid, NULL, 0);
 }
 
+struct odb_write_stream {
+	const void *(*read)(struct odb_write_stream *, unsigned long *len);
+	void *data;
+	int is_finished;
+};
+
+int odb_write_object_stream(struct object_database *odb,
+			    struct odb_write_stream *stream, size_t len,
+			    struct object_id *oid);
+
 #endif /* ODB_H */

-- 
2.51.2.1041.gc1ab5b90ca.dirty

