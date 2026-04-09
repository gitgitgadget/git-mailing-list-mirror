Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBB221257F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719485; cv=none; b=YySo9CKreTDkct2biqmNeOOJXIyESZjPnbnw0PvZ96A2MQpYpi5mRfhr3oWYG1SjSfQWp7eFv9dA8M4w5rf9MwU/0c3myuo8oKGpePirZtgpZT7oe7SPkc1GlkrDdNMVLaQUrLv/oH3AcDHscffUuKa8vcBfvYyft3aVwQE9c0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719485; c=relaxed/simple;
	bh=TpbMuwmkaAjDIg4nsaVAs62zgnJqSkg30YO99Khgceo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SJ2G82AiBch2zGuG7zFlkj/DzfnONCmFGpOKGrJKLkZWtI0LXeme4gk/bpK7K0zsAvXohPHUXS/BVlin9yWVoyW89n5s79fBi/bVpI/PEvtND1vG1kdI2NrWV05ivYjNYlV6DQNelHRaX4KsCx5mFj6Cc971MkmXGXe3Bj+F7MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ClQtHvMQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fJ1aKZg4; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ClQtHvMQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fJ1aKZg4"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 224001400272;
	Thu,  9 Apr 2026 03:24:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 03:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719483;
	 x=1775805883; bh=TxW2wRgGjrXs40zitGLQqr9HQT6x2hvqcNXCtZKqHKU=; b=
	ClQtHvMQofIE5HGTIRHGhAJdHs0MP0KPaKZmrKAMLGJ4D0LmRBFrq4HoEgZ1CPlr
	hzp91+upDBVJKgoSa0kqgs+Il05Ktkx/eQmjieSb8+fAVU8AKwSDU97zWP1BZtN/
	7v0mlSP7QmQqlHIfbehGAkZS3UyTeqKX75+x7/AFPbSSZ1BxWWf6HpfqHgtHeasm
	7K3wQX2j58iQkNfV79skl20XJfP8FxmRxtu0AsmRdnABcuZsqfHzuAhjDvPlRfwV
	0Iog4VIeO+1FyBk2aHJg7xECV+sEfzEKlLQP4qU+pD4M0vpo6k1DPloaiPUyXxeQ
	5YX/GEsOpnGv393Z7X7i5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719483; x=
	1775805883; bh=TxW2wRgGjrXs40zitGLQqr9HQT6x2hvqcNXCtZKqHKU=; b=f
	J1aKZg4PuJkZh/dg3/7sPzMLBJevJ9iL0TgsFgM8g3+MhkOKgQd8AJ1nzycb6doc
	DEwhUGEUlwQtpLmwsYd4+Q+r1xyKxksxw1yhJHP4l8s3M1k2HLsXChzQEallI8Os
	ue7OA0TAY1k+JW+QruPEOZ4dfh7TnSqW847lOrnW4x9DhGlxeKyJ8f2b26Zdmhcb
	G+FdgwTya2OPsewTffMj6n9boQKAGjw7yAUrriQrM6MGx/2k5OEsOz4qPDi1UIaN
	1wHSbhfhJOYyYG8zu2d0nFa2kezs35M0s1JjJQBJXdt5HD6UCSgzXvefpZy9Pydt
	ij1fIzDdKWUw/fI3eKAGg==
X-ME-Sender: <xms:O1TXabuB71GU7upd4LKe2syyqpFXk-W-pHKjRd0vwt36oGJWb2PZuw>
    <xme:O1TXaT42voU5MeFlQRHmyy-tb_sdZYZNMw1pIb_rr0L1Zrb3JBFaErDpdzDC_ixjN
    _grzLQKR34WYDtjF3VP2bzOZDTZuPE0HT_OaavCqg62uxlPUV-qRQ>
X-ME-Received: <xmr:O1TXacLUXtD8Wb9sRR1PpvzXA_tO9XXR_3yTB-wQaIYJFgt2bYQ9yjLg_cfziK2CYurNyX9o_e5MkmHnMy_eFj0aGyCk94kGdcp1zZ4Bhl0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:O1TXaT5mKTMOQ3y5I8mz0ga13us2dyjZ-t8dSPwpmEiiJHTnyy4Mhg>
    <xmx:O1TXafy3BWrJyBpZ8VfamXhn7EozSv0usdUH4tcAKZFZ-TMGS1Hnmg>
    <xmx:O1TXaXY_nXa3pcMqOPA5ON9H2RDYEXegWADD4VkYgwX0TY5MVTE45A>
    <xmx:O1TXaRQTkwp6smVTU_ciFQxugz-Mg-Nq9RmlK4KN9c6JWv0wxmFI2w>
    <xmx:O1TXaf7ZeMbNKPXn47S-89W_-p2JxrVuaOYLXcTq88sFLeHbEbP6YHRy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7415600e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:25 +0200
Subject: [PATCH v2 04/17] odb/source-inmemory: implement
 `read_object_info()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-4-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `read_object_info()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 39 +------------------------------------
 odb/source-inmemory.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/odb.c b/odb.c
index ea3fcf5e11..6a3912adac 100644
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
2.54.0.rc0.680.geaeac8ef83.dirty

