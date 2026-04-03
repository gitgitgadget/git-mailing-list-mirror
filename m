Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A489A36AB56
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196154; cv=none; b=VoSAX8FkqQoo4OW/yYPBkb2Y+3gzQmCsRPIsJDK5L+dNqYEK0eXaVnO0lfqHdyBmF2RTZVqj6BHO/7DIO1s6+TmzXiAVtepAt2mzuFOraBGOQ3t5GVluNqQHkKFv0If0viZQ7UIvo1xh5WPGzLYhJwkndvOcf5fPlU+VoXyJAJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196154; c=relaxed/simple;
	bh=OLc7AH8pPs8XQFiSgD81ylPBH8aTkg5EboFRO3VQ2S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kx8ygPON2ho4CB6Ci90QlpXJT+m+IWFt1FQzffIRJwXxBvrZ7wgh45muBOkEhpJrwcSy7Z56mGk2CllDFuL4eVLJfc7+YK0BnHMY5p4vqlFfPG7mFqrjVoMQuEjUlHTVjl3VaBNesfYUIKxT4MQUH1psr8UA1qmvAt6QSPzrJ4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yqMYw8UL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+3oQnv7; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yqMYw8UL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+3oQnv7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D26277A00FC
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 03 Apr 2026 02:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196145;
	 x=1775282545; bh=YNKo26MZTjBtvBY8kBLj3Me3ImhLI2nhe2Kpqn3wMCI=; b=
	yqMYw8ULJbIcUUJtQB8vXo+TBcaZo0erFUcdrrEE2pjk+w0zzIIlqNi4xIy7O+5s
	b4/J+bcXYVm+ynqGFDbtnKFVy0jX6t7a1g66BMrlSU1AYnj42h8i1m5j8AuDmv0+
	Sx+A+4O1xIjwMKlkonPoKkEenXMShoAj8UEtdkJYx8CUZCGMv4fNxFgKCpLQzN5V
	fw3RKg7zKWeRYTntFmcRkbFR+lrZBF09cigAlW5xnkimAGUsopAuGHBm9/U2AfgI
	1ldYv7KPGSgZn4XGYFppYIpx1o/8FFzH7pe3vrgmcUeUZI+DmU1lm4zbalm35uuZ
	COzvK7bgh2pneY71gzNh0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196145; x=
	1775282545; bh=YNKo26MZTjBtvBY8kBLj3Me3ImhLI2nhe2Kpqn3wMCI=; b=P
	+3oQnv7aSsQ5ckFVxx33T3XGh3WEZPH8WInz4KBYDaujLyiA9Ua5aPlyxi5QGDFF
	35iYnwt2l8NkAfD6shO9NyK7xT1zyYkw91hQgTSH2Ha9FH/hvwBOl5o/qmdEHchy
	32AeCTTlNKTARu7j7h6sMFEy0SHP3SIqvFO2kI1KXlC4/CXYbMvOcXE+MgmnWo6E
	UDDCEK5YsWXKoivZCPqJhNwK8HB4d4BG1S3P2b92A+hAy2aHwSud+BKykKfDZ6h2
	pdXs9Gppk6EIyB9Ujb3P/8HDjtNL9plzkKHcqIeLtpCAUaFvwNQWEj3RCSbTFe+Y
	mC+oDSYFJhaxiCPdabauA==
X-ME-Sender: <xms:8VfPaR5_fFp98GRVVMEfxNulE8qagtHGER5y-WJ7VTucMnBDaUrMUg>
    <xme:8VfPaV0ofzsbH8GIi7mCgL-zJqfuY-6DR5pjaaaK6gD0WOr2V0yUxgVd6qzr7p6kH
    0_iys687O80zP3PlwkUXZF2zjxKXMqdF0Q0WVoBLswTu-gFXc-Svg>
X-ME-Received: <xmr:8VfPaeEoRusANMuMWfo1kzvKHFSO6UT2uyrqGaIqJ1uGTflv_UAbmAvGXhlaA7AhcgeEC_OsEZHmYCJv-KMHZqtEcdO0dbn5Do-uBWrf8jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:8VfPafQOe2tHYl2h6-NUEz9vTSqsJ2c6n9o9YM78NoG3n8YeeqDynQ>
    <xmx:8VfPaVCL6VT9aq-5RvNP1gen0U64ZEeiAmL43BJECe70o557CoRZHQ>
    <xmx:8VfPaf0dBYp9q0JTsFibJl_dXwsxwXJfqIicmgtuoTVq5Cbt2Kq4ZQ>
    <xmx:8VfPaTUcWndd8J_YQkI8C9k30xUiy6GhqtGrM41IXwdZ3JcnvtFoDA>
    <xmx:8VfPaWYD4ehNmiXtj1RD1pVINxtqKT9yOYbOQqTeRSaioWLKekJtSmXn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0470819c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:51 +0200
Subject: [PATCH 04/16] odb/source-inmemory: implement `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-4-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `read_object_info()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 39 +------------------------------------
 odb/source-inmemory.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/odb.c b/odb.c
index 21cdedc31c..b8e7356951 100644
--- a/odb.c
+++ b/odb.c
@@ -32,25 +32,6 @@
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct odb_source *, 1, fspathhash, fspatheq)
 
-static const struct cached_object *find_cached_object(struct object_database *object_store,
-						      const struct object_id *oid)
-{
-	static const struct cached_object empty_tree = {
-		.type = OBJ_TREE,
-		.buf = "",
-	};
-	const struct cached_object_entry *co = object_store->inmemory_objects->objects;
-
-	for (size_t i = 0; i < object_store->inmemory_objects->objects_nr; i++, co++)
-		if (oideq(&co->oid, oid))
-			return &co->value;
-
-	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
-		return &empty_tree;
-
-	return NULL;
-}
-
 int odb_mkstemp(struct object_database *odb,
 		struct strbuf *temp_filename, const char *pattern)
 {
@@ -570,7 +551,6 @@ static int do_oid_object_info_extended(struct object_database *odb,
 				       const struct object_id *oid,
 				       struct object_info *oi, unsigned flags)
 {
-	const struct cached_object *co;
 	const struct object_id *real = oid;
 	int already_retried = 0;
 
@@ -580,25 +560,8 @@ static int do_oid_object_info_extended(struct object_database *odb,
 	if (is_null_oid(real))
 		return -1;
 
-	co = find_cached_object(odb, real);
-	if (co) {
-		if (oi) {
-			if (oi->typep)
-				*(oi->typep) = co->type;
-			if (oi->sizep)
-				*(oi->sizep) = co->size;
-			if (oi->disk_sizep)
-				*(oi->disk_sizep) = 0;
-			if (oi->delta_base_oid)
-				oidclr(oi->delta_base_oid, odb->repo->hash_algo);
-			if (oi->contentp)
-				*oi->contentp = xmemdupz(co->buf, co->size);
-			if (oi->mtimep)
-				*oi->mtimep = 0;
-			oi->whence = OI_CACHED;
-		}
+	if (!odb_source_read_object_info(&odb->inmemory_objects->base, oid, oi, flags))
 		return 0;
-	}
 
 	odb_prepare_alternates(odb);
 
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index ccbb622eae..12c80f9b34 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,5 +1,57 @@
 #include "git-compat-util.h"
+#include "odb.h"
 #include "odb/source-inmemory.h"
+#include "repository.h"
+
+static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
+						      const struct object_id *oid)
+{
+	static const struct cached_object empty_tree = {
+		.type = OBJ_TREE,
+		.buf = "",
+	};
+	const struct cached_object_entry *co = source->objects;
+
+	for (size_t i = 0; i < source->objects_nr; i++, co++)
+		if (oideq(&co->oid, oid))
+			return &co->value;
+
+	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
+		return &empty_tree;
+
+	return NULL;
+}
+
+static int odb_source_inmemory_read_object_info(struct odb_source *source,
+						const struct object_id *oid,
+						struct object_info *oi,
+						enum object_info_flags flags UNUSED)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	const struct cached_object *object;
+
+	object = find_cached_object(inmemory, oid);
+	if (!object)
+		return -1;
+
+	if (oi) {
+		if (oi->typep)
+			*(oi->typep) = object->type;
+		if (oi->sizep)
+			*(oi->sizep) = object->size;
+		if (oi->disk_sizep)
+			*(oi->disk_sizep) = 0;
+		if (oi->delta_base_oid)
+			oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
+		if (oi->contentp)
+			*oi->contentp = xmemdupz(object->buf, object->size);
+		if (oi->mtimep)
+			*oi->mtimep = 0;
+		oi->whence = OI_CACHED;
+	}
+
+	return 0;
+}
 
 static void odb_source_inmemory_free(struct odb_source *source)
 {
@@ -19,6 +71,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
 	source->base.free = odb_source_inmemory_free;
+	source->base.read_object_info = odb_source_inmemory_read_object_info;
 
 	return source;
 }

-- 
2.53.0.1323.g189a785ab5.dirty

