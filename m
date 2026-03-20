Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31616359A6A
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773990474; cv=none; b=nmR3tWZRFsjxl4EXFDJWhq1qi+JuwcAXtrpd1HME86g74EG69uMee6ee0aYXDZ2jbWVHN5CQ0XalXhOZJ5JBnb8ShV6tpt5WIT362TAvxWypFzkCr2LbJrJRvGgGboEEitKmd/mTYnHn47SsvOVBsYyO37AVxSXRlSLwjjABU+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773990474; c=relaxed/simple;
	bh=OOybGYbMgS6KwXElfbKvFcraFZR5rpO1r9iGdtM6+js=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HBD8irwfpxyBUVT63s4/y7Hkjqo4O56GQvAdtY3LbW3t4zB+ZaHxo41xH/6GbryJsoe/IOCDoIiVLmloUZiCj97BaDz2r0ygg+RF/5dmfZENlSQ47Z8F36jWHGPkVxhvR3tJlZpaLwQnNc+VxQWnvgbkcmwFwqBnYNXoXsniibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L2kvlTyU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sSPMeP7N; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L2kvlTyU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sSPMeP7N"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7467BEC01AA;
	Fri, 20 Mar 2026 03:07:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 20 Mar 2026 03:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773990472;
	 x=1774076872; bh=2d73GLAVAWk9VK5LPi2x2nTLmjNz/iJGjeSGr26xW14=; b=
	L2kvlTyUbKrPpmOqvUb28Vb1qJ+M05vyIOO3Krl/L8DXSlIJot83/RwjuO9nABn5
	t+Vqwal3tXJ1GNsE9+3FYNpwUhdS/JMozBea6V/KeUp3dDu7YoeSHA1jM0uj4fkA
	r+JBUeMm0D+hAcrFslQRBHJxl8iEUbHJELCB3EgpA3VOa6YCst9zTqC+nh30T+0c
	/0ill1sHrVUEHdG7i1ZdVqD/8vWJL2W1ehF4B15uKyCj1Ri/PFqUSUbgMR3gLS3Y
	+Olt6tX9VLxazyFl4BgsNrQw/S77JbutRFC/PlrWoqtG7woU1bbQrvP6a14v6lIP
	MXYWEjbeNSDO6mZCPuf0gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773990472; x=
	1774076872; bh=2d73GLAVAWk9VK5LPi2x2nTLmjNz/iJGjeSGr26xW14=; b=s
	SPMeP7NRugWNIGJESQ6on1RU5U7LJxXnfdWzRbm+3Q1Tw2JNc5s+yu+cBIpqvHuk
	oR55F4I/uW03krNS49aA56CnvE9z00c4a+78UM2CbtaMRDajrRbbyAUdaGMHEMmJ
	NAfo7nyo8ouuhC1W/n1E1JGJR47uEtlg8sub3aMjxBu2m4LdrIrxKKzHNNEVusvj
	rw/RHG7w07n2KxgVXfbE6ZTZdTKyHkBrHbmd1daFPLL32Rs+T/SA8CpXNGI31FvQ
	kkHMBbBBfCuwiS41+idNWdvM3CrG3QODwuwXNOYvfBDjeuz1NWYgdmhCpo+jYIJl
	lt5xqMK4hJffcZr/QK+aw==
X-ME-Sender: <xms:SPK8aS6-TO-dyzhL93QkRHeSiOTw_99CR8yxzMVtoGWH071KTGXSbw>
    <xme:SPK8aTVFxL6uJ1JLNH471WRIf992gOMJQtdRa2GndvGjRPmaoZWAiysK4OfAwiz3e
    bfuelVuvApLzqjusAGQj6LilD_U4zrNOLCjCmmKSA7yy4i0V7la>
X-ME-Received: <xmr:SPK8ae0dGYdyy2L9glShohKp0-fVIIwA0tLpFs_VSuNpxbBikgulGIURVugNeaml57DaXKS05Caoag8d0a882nk1rsEili7w8Ay53F-cdX1->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdelvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:SPK8aY0v2xvoFbNDc1u0hzOpOkEr-y7SB6M4GatnbPgI8wiC-ZesRg>
    <xmx:SPK8aZ9oaU9caO58uy4iqMXg2n7Z5HMR8sM-bzVYDnxwZGBnHfLa5Q>
    <xmx:SPK8ad3mBePH7qZ0aAfqL1VYlrDu5teFz31Km4weO9-WCKxzLHM8Qg>
    <xmx:SPK8ae_jfN56ryR-tv-rocoWav6NPbeN1JF448iiVFK2ckNvb2cjPQ>
    <xmx:SPK8abWjs0bheriFeLcVacO1-i9XcFF6xo7t-FyEh6o34ZXoVW0zQJdl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 03:07:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d7ec241 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 07:07:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 20 Mar 2026 08:07:30 +0100
Subject: [PATCH v2 04/14] object-name: move logic to iterate through loose
 prefixed objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-b4-pks-odb-source-abbrev-v2-4-fe65dcd8c735@pks.im>
References: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
In-Reply-To: <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The logic to iterate through loose objects that have a certain prefix is
currently hosted in "object-name.c". This logic reaches into specifics
of the loose object source, so it breaks once a different backend is
used for the object storage.

Move the logic to iterate through loose objects with a prefix into
"object-file.c". This is done by extending the for-each-object options
to support an optional prefix that is then honored by the loose source.
Naturally, we'll also have this support in the packfile store. This is
done in the next commit.

Furthermore, there are no users of the loose cache outside of
"object-file.c" anymore. As such, convert `odb_source_loose_cache()` to
have file scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 29 +++++++++++++++++++++++++++--
 object-file.h |  7 -------
 object-name.c | 10 ++++++----
 odb.h         |  7 +++++++
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 56cbb27ab9..13732f324f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -33,6 +33,9 @@
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
+static struct oidtree *odb_source_loose_cache(struct odb_source *source,
+					      const struct object_id *oid);
+
 static int get_conv_flags(unsigned flags)
 {
 	if (flags & INDEX_RENORMALIZE)
@@ -1845,6 +1848,23 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	}
 }
 
+static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
+					       void *cb_data)
+{
+	struct for_each_object_wrapper_data *data = cb_data;
+	if (data->request) {
+		struct object_info oi = *data->request;
+
+		if (odb_source_loose_read_object_info(data->source,
+						      oid, &oi, 0) < 0)
+			return -1;
+
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
 int odb_source_loose_for_each_object(struct odb_source *source,
 				     const struct object_info *request,
 				     odb_for_each_object_cb cb,
@@ -1864,6 +1884,11 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 	if ((opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY) && !source->local)
 		return 0;
 
+	if (opts->prefix)
+		return oidtree_each(odb_source_loose_cache(source, opts->prefix),
+				    opts->prefix, opts->prefix_hex_len,
+				    for_each_prefixed_object_wrapper_cb, &data);
+
 	return for_each_loose_file_in_source(source, for_each_object_wrapper_cb,
 					     NULL, NULL, &data);
 }
@@ -1935,8 +1960,8 @@ static int append_loose_object(const struct object_id *oid,
 	return 0;
 }
 
-struct oidtree *odb_source_loose_cache(struct odb_source *source,
-				       const struct object_id *oid)
+static struct oidtree *odb_source_loose_cache(struct odb_source *source,
+					      const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	int subdir_nr = oid->hash[0];
diff --git a/object-file.h b/object-file.h
index 46dfa7b632..f11ad58f6c 100644
--- a/object-file.h
+++ b/object-file.h
@@ -74,13 +74,6 @@ int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *stream, size_t len,
 				  struct object_id *oid);
 
-/*
- * Populate and return the loose object cache array corresponding to the
- * given object ID.
- */
-struct oidtree *odb_source_loose_cache(struct odb_source *source,
-				       const struct object_id *oid);
-
 /*
  * Put in `buf` the name of the file in the local object database that
  * would be used to store a loose object with the specified oid.
diff --git a/object-name.c b/object-name.c
index a24a1b48e1..929a68dbd0 100644
--- a/object-name.c
+++ b/object-name.c
@@ -16,7 +16,6 @@
 #include "remote.h"
 #include "dir.h"
 #include "oid-array.h"
-#include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
 #include "object-file.h"
@@ -103,7 +102,7 @@ static void update_candidates(struct disambiguate_state *ds, const struct object
 
 static int match_hash(unsigned, const unsigned char *, const unsigned char *);
 
-static int match_prefix(const struct object_id *oid, void *arg)
+static int match_prefix(const struct object_id *oid, struct object_info *oi UNUSED, void *arg)
 {
 	struct disambiguate_state *ds = arg;
 	/* no need to call match_hash, oidtree_each did prefix match */
@@ -113,11 +112,14 @@ static int match_prefix(const struct object_id *oid, void *arg)
 
 static void find_short_object_filename(struct disambiguate_state *ds)
 {
+	struct odb_for_each_object_options opts = {
+		.prefix = &ds->bin_pfx,
+		.prefix_hex_len = ds->len,
+	};
 	struct odb_source *source;
 
 	for (source = ds->repo->objects->sources; source && !ds->ambiguous; source = source->next)
-		oidtree_each(odb_source_loose_cache(source, &ds->bin_pfx),
-				&ds->bin_pfx, ds->len, match_prefix, ds);
+		odb_source_loose_for_each_object(source, NULL, match_prefix, ds, &opts);
 }
 
 static int match_hash(unsigned len, const unsigned char *a, const unsigned char *b)
diff --git a/odb.h b/odb.h
index a19a8bb50d..e80fd8f7ab 100644
--- a/odb.h
+++ b/odb.h
@@ -488,6 +488,13 @@ typedef int (*odb_for_each_object_cb)(const struct object_id *oid,
 struct odb_for_each_object_options {
 	/* A bitfield of `odb_for_each_object_flags`. */
 	enum odb_for_each_object_flags flags;
+
+	/*
+	 * If set, only iterate through objects whose first `prefix_hex_len`
+	 * hex characters matches the given prefix.
+	 */
+	const struct object_id *prefix;
+	size_t prefix_hex_len;
 };
 
 /*

-- 
2.53.0.1055.ga2ffed1127.dirty

