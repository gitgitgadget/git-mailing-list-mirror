Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2062B2C11F0
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155772; cv=none; b=KCsVcZKZVnxzg6egMySj5MMh1bIyaaQ3Qv4TwkTJIGA2NMOGNGK5I2nPD545yx7U7LhYhD5NOSWKptsocHEDx5Qy4AoBCd6K0k9Uf9e+B8ldC/cybkBMzHRv9hniWe1M2ryXN9czDM+LZAvrDYkMWkRy+jZaocSCg1R9weyWfWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155772; c=relaxed/simple;
	bh=UXALBHrYIE+nD8RBHijhmaJjnKB4zWu2tOFcDY6m2as=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AriZ23xo270f94JpKeBraLP2HCYoINwKyxrfAFI9IjIB1ity45To5QPNDp2p9pARUWCWNa6YTSSHy7IkmtPGlYkTHyznuf+8fh6rmbvDUMvJP20k/1zUTxAnYCSGCPSqy5rk4RQ+88d15sZ0+ghLkwUt0kqCesIGzQ5Xxq427NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZvIgBZsm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDT+RgSd; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZvIgBZsm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDT+RgSd"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EBFF1D00133;
	Mon,  3 Nov 2025 02:42:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155770;
	 x=1762242170; bh=vZtWeJN3xxgJCp01NIlUbn6QY9szlAY2xFRSTGH3jic=; b=
	ZvIgBZsmWWeL8e6uxUUvwDSQSMIvyf/y8TYkgR+v0H3x5issM0FRZ7z+GuaXb6pW
	SkrYZFMIUoaKRv7MqyR/TglkBsEFeITkt+GSvnf6aG7OpDtZ9MRl3lpfp4C1sed/
	B7XvSKOG5/GqbpP0HfBLiAOmjfTl+Nfd1ALpjXBMOWtiF8H5+Ame9ScLAFcaaQ9m
	f//5PMwSHxunc4S8mglAk9JQvxz3xiShQaRmRELMalHuKTzTKMnjtAwBpbz8Uy1l
	gOKRB1dkePY89E9yrjob4X/MJzUOZFCF15g5/GsmjRqLFqhBlDc3+831I8LL6d9V
	ijtjKW2O69dRG1HNcR7yxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155770; x=
	1762242170; bh=vZtWeJN3xxgJCp01NIlUbn6QY9szlAY2xFRSTGH3jic=; b=X
	DT+RgSd/d1MyKjiJs/pRRTlQZwzI4WphxUqpYoxvjFEhm2lVERdHEqeo8qUyDEuM
	E4W8VfIjzwLrVusZ9oU1whzyOGi8F3duMtJMGZv6sxaNZFY/xBs0th1kGgRYKnxI
	z98vkcPC0iit8kxxSlK1BC9fUrHEgT6UKLFPSUNSsw4ssX62Z5LD8dYLG7PqG25a
	BVnv1jKOz7YbRbngBnBpF09Hna/GWGdnAF0Bb7pW8U2R4RGVLxMKljQi9UFBr8En
	aGPF4H2iJBSlKjq3LqTYEKaW608d9sMb22yFsNQmH9avX/iO72FwJrIGIKBQiMvY
	GUeQqyJukDBy204xU8Sug==
X-ME-Sender: <xms:-VwIacRYcRM-GRxhrDxOcOsJQvqLbtMNGN3j9FTtjPoPM4kLgNtGwg>
    <xme:-VwIaRPbhJsYpFChioacjRkGr4t1wNhvD9v5WEFId32gkfAeJN--ERgIRQFaw_PW6
    jM2W3T7AB6LmB9CJZgicTzhQytKWBQ8rLqNHBVlSirmWkfwp-Ax>
X-ME-Received: <xmr:-VwIaXNhZjgrIM2nk_aUGfVC65k53Y45Rh-3Ucep34kvSlhVBCx2T-MuILeJXc6_wTBWyaK0WFYf9Zsfb5Q7vSDMECBdh2BM7x8kyFzbC3HV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:-lwIaZtT83d0rjGVEf74QdlL0zNTM_mcX3R074it2jgBgpxVYid70w>
    <xmx:-lwIaZVW_ZZ-wC6kWgnL3eV3sn52cyYmWPj_j7bUWrtaM0nHJKFZwg>
    <xmx:-lwIaZs8lfdxwLddKmSIvfkL9YfRfaEVoLl03tV-V9v6B9O5gKrd2Q>
    <xmx:-lwIadUZtTVYCJcvTlmVqvkHEJSDl_wXpPVunNbJy5f2t0sTm3Y4ww>
    <xmx:-lwIaRP7OCWjulMPHcRffPP9Mv0ux6nirRFL5VpnZ7DDGhoopqEUuTG6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 542c5472 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:08 +0100
Subject: [PATCH v3 13/13] object-file: refactor writing objects via a
 stream
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-13-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
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

Rename `stream_loose_object()` to `odb_source_loose_write_stream()` to
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
index fdc644a4275..811c569ed36 100644
--- a/object-file.c
+++ b/object-file.c
@@ -974,9 +974,9 @@ int odb_source_loose_freshen_object(struct odb_source *source,
 	return !!check_and_freshen_source(source, oid, 1);
 }
 
-int stream_loose_object(struct odb_source *source,
-			struct input_stream *in_stream, size_t len,
-			struct object_id *oid)
+int odb_source_loose_write_stream(struct odb_source *source,
+				  struct odb_write_stream *in_stream, size_t len,
+				  struct object_id *oid)
 {
 	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
 	struct object_id compat_oid;
diff --git a/object-file.h b/object-file.h
index 36a60e15c40..eeffa67bbda 100644
--- a/object-file.h
+++ b/object-file.h
@@ -67,6 +67,10 @@ int odb_source_loose_write_object(struct odb_source *source,
 				  enum object_type type, struct object_id *oid,
 				  struct object_id *compat_oid_in, unsigned flags);
 
+int odb_source_loose_write_stream(struct odb_source *source,
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
index da44f1d63b4..3ec21ef24e1 100644
--- a/odb.c
+++ b/odb.c
@@ -1025,6 +1025,13 @@ int odb_write_object_ext(struct object_database *odb,
 					     oid, compat_oid, flags);
 }
 
+int odb_write_object_stream(struct object_database *odb,
+			    struct odb_write_stream *stream, size_t len,
+			    struct object_id *oid)
+{
+	return odb_source_loose_write_stream(odb->sources, stream, len, oid);
+}
+
 struct object_database *odb_new(struct repository *repo)
 {
 	struct object_database *o = xmalloc(sizeof(*o));
diff --git a/odb.h b/odb.h
index 2653247e0cc..9bb28008b1d 100644
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

