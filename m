Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027C3BED16
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823197; cv=none; b=io9jlQ9rdDvKKQ4f3udoFdvKItlgSwP9C7caKf+g3lAU4WUDr7tklYyAskTHsI5w38PYd7RHFhxYzQoz3oWT7bmfackQY6YgrjkOUy1k1bn6aqLqa9cH9+dAu2pibKCu3GKmjHw/bHooYHlaRU+gD52I2lSjC1hmwz9DGQwdDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823197; c=relaxed/simple;
	bh=j/ZMUN5Z+5Zh54Rh8R0/qnjksl6D+XDqmTcMUMOuco8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AfKDghH/M8UgAMOhzRiaZaNwAyYLm1K0lEgdDz3RbP5VAogC+kztT8h0r6q7gcIlF5Hn0vjgMvXTrolJTPzG2smXVUXDYHiGNV60rVu853rxCE0YuBr8D/vY8VA/ZNdMdID1x+iNeabpc4qOGEBBLy5fLziDzE36/PK/MQFbG04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bZsfBw3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pw1zrLoV; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bZsfBw3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pw1zrLoV"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 35D441D00178;
	Fri, 10 Apr 2026 08:13:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 08:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823196;
	 x=1775909596; bh=2vTVgezruUTYBTgbuQFIhCOcj1NqH/q6hAxBi/DEWFI=; b=
	bZsfBw3rPTBPLwMHJrehLAxxJ5XeLKh/eOefRgzptGyjYeeuavqRiT5c7FkSYPMH
	w+pRk8Bj5KeIMtAgBbbdElaz/3GdcnTWGIYZmZw/g3Y/ZN9FmvF9gJgTvnolers5
	EmEnkcpb0jC2995GueNBcneDU9wTdR72PeWTtUzCih9RZcGlODjKnPNq8EPtSQyC
	dCXqjp0RRRjyfIBZ/QM8BwC3KTMew9X/+yh/U7XEiXMhAI+RgVwQ7HuzVntpWcjM
	Si08qHTbvARGBZ+0tEVtU0YKJcY/lNnbX9gY5rHqn8IuPfhgDNc6QZnBFYPvCSxB
	p3XHG2zOMeV+HPA/UlgaMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823196; x=
	1775909596; bh=2vTVgezruUTYBTgbuQFIhCOcj1NqH/q6hAxBi/DEWFI=; b=p
	w1zrLoV/bY9qn+odSiwm3SZpOZPFlP1eTI5y73djfhyVA2FNIvPri3/k3bvO0hm1
	2nKj9P+0X6UKN3fx0Bdm4ZMmKxxCkQYeQHEQ78w8nmoU+oLLn8ORihN6nRx0vWwX
	HbuifxftVzGGUzT5/A4nsH7BXgB73CyUwRvfmD6ZcJKFzMmiTkQUe2Gb3lousJP9
	za2tn6AOExdrzel+E8ijPXa0s5E2iN/1s6HUVhIL//ppPOWxmd1z82qETu8typX7
	xEt9PJ9oOVPAb8LRrMiUMy8b9qtTFUiMvAdG7uS2pMMolJKgR/Oh6JGeXjPoa2JI
	fEx38RUdQBWja4R4Tcs8A==
X-ME-Sender: <xms:W-nYabcKRd0SjJYY8GdqzWCLjghqZiQrwU1GXoFMbYwHjRVAESKXRg>
    <xme:W-nYaYrxi4IuO_q4h8x7Amc7aMs4tldb9frPiJto8WSSZcGAd-CVYayHA7vlZReSz
    xBL2PUDw7kkjf0nxBQ3wdeCgk7DY9jVirB7qTg-wH7_5ZxYYaGB>
X-ME-Received: <xmr:W-nYaR7cTdxo-m61KH3M6sOEf8AHkqMt7eIRHMa_tC_UjOUzFCf18CDks4fy6_Em2kyX4JBDbD6yGEYv8RT-b7m4DJgb4aLy3zTAADOi5RF6Sg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:XOnYaWowXJkQSoYJcK0GLjc1TU27WbxFtgPZZ12-DWEspGZJsDbpyw>
    <xmx:XOnYabhU2ReX60tJoMQlrG5-ZzdAqVOxk1rPp7S5cSRH7XVHM4LsAQ>
    <xmx:XOnYaYLj1x0EMbHYx-uBjRWBaUdR1Y4b8UJ5t_jkWWDniLLediqTRA>
    <xmx:XOnYaTC0_ZD7o1yNFigbZM1YFJ6RNzTZfOQ9PejlXrI1RNxCRmJdNg>
    <xmx:XOnYaUosucQej6qFIL__pYhG3pUv9A-QboASah3zxdhZouOdrV56aarW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1bc5396e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:41 +0200
Subject: [PATCH v3 11/17] odb/source-inmemory: implement
 `for_each_object()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-11-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `for_each_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 88 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 16 deletions(-)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 3b51cc7fef..f60eecbdbb 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -33,6 +33,28 @@ static const struct inmemory_object *find_cached_object(struct odb_source_inmemo
 	return NULL;
 }
 
+static void populate_object_info(struct odb_source_inmemory *source,
+				 struct object_info *oi,
+				 const struct inmemory_object *object)
+{
+	if (!oi)
+		return;
+
+	if (oi->typep)
+		*(oi->typep) = object->type;
+	if (oi->sizep)
+		*(oi->sizep) = object->size;
+	if (oi->disk_sizep)
+		*(oi->disk_sizep) = 0;
+	if (oi->delta_base_oid)
+		oidclr(oi->delta_base_oid, source->base.odb->repo->hash_algo);
+	if (oi->contentp)
+		*oi->contentp = xmemdupz(object->buf, object->size);
+	if (oi->mtimep)
+		*oi->mtimep = 0;
+	oi->whence = OI_CACHED;
+}
+
 static int odb_source_inmemory_read_object_info(struct odb_source *source,
 						const struct object_id *oid,
 						struct object_info *oi,
@@ -45,22 +67,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 	if (!object)
 		return -1;
 
-	if (oi) {
-		if (oi->typep)
-			*(oi->typep) = object->type;
-		if (oi->sizep)
-			*(oi->sizep) = object->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(object->buf, object->size);
-		if (oi->mtimep)
-			*oi->mtimep = 0;
-		oi->whence = OI_CACHED;
-	}
-
+	populate_object_info(inmemory, oi, object);
 	return 0;
 }
 
@@ -114,6 +121,54 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 	return 0;
 }
 
+struct odb_source_inmemory_for_each_object_data {
+	struct odb_source_inmemory *inmemory;
+	const struct object_info *request;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int odb_source_inmemory_for_each_object_cb(const struct object_id *oid,
+						  void *node_data, void *cb_data)
+{
+	struct odb_source_inmemory_for_each_object_data *data = cb_data;
+	struct inmemory_object *object = node_data;
+
+	if (data->request) {
+		struct object_info oi = *data->request;
+		populate_object_info(data->inmemory, &oi, object);
+		return data->cb(oid, &oi, data->cb_data);
+	} else {
+		return data->cb(oid, NULL, data->cb_data);
+	}
+}
+
+static int odb_source_inmemory_for_each_object(struct odb_source *source,
+					       const struct object_info *request,
+					       odb_for_each_object_cb cb,
+					       void *cb_data,
+					       const struct odb_for_each_object_options *opts)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	struct odb_source_inmemory_for_each_object_data payload = {
+		.inmemory = inmemory,
+		.request = request,
+		.cb = cb,
+		.cb_data = cb_data,
+	};
+	struct object_id null_oid = { 0 };
+
+	if ((opts->flags & ODB_FOR_EACH_OBJECT_PROMISOR_ONLY) ||
+	    (opts->flags & ODB_FOR_EACH_OBJECT_LOCAL_ONLY && !source->local))
+		return 0;
+	if (!inmemory->objects)
+		return 0;
+
+	return oidtree_each(inmemory->objects,
+			    opts->prefix ? opts->prefix : &null_oid, opts->prefix_hex_len,
+			    odb_source_inmemory_for_each_object_cb, &payload);
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -219,6 +274,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

