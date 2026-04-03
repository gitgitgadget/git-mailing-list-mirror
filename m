Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C735E952
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196175; cv=none; b=r7a1kkShi2Hf6WdNqL/LY+TQ1OQfsQVdI9VdwGPoExsQdUJGE/0p3ay/X0Qd29ZrhERULVgAER5BPF4OBa8qTjqmTKeuBaPq3VjQ4eZ8bdLHJEG97VW6XOutq15adJlDdvousxLC6IPBNU4cCm952GM40dcNCIv8wQl9exfPvOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196175; c=relaxed/simple;
	bh=QkA8p1SidygftaQ827xqJHaXTNp4CzJDzcsouftvMtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DX03ii9b2tv/kIVg4jD2PrindO5r8TKT34lZ69k7pJLtHh4gKPByI2gkFbW1TAMksVvAmvujYnYBAPRzCDsX4WRvnnwbipDpX9yJxz/Fgxt3PtV/JbN6fmarB4aFWVQN+O6MHFG9IaG8rJkqgGjnCZ4LiIzr7yBj1iEJwlS+bW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ICe984Cr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wli4QQ+g; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ICe984Cr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wli4QQ+g"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F65D7A0105
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 03 Apr 2026 02:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196166;
	 x=1775282566; bh=nB8d0jYwSYIJdbtHpvsPBjnDrcbM009niIzG27rijNk=; b=
	ICe984Cr49KMVKT+T5irfTmjvKZrCMWCNtqsSPf1eEnp+jG6A+wUoGO9qlNth4kx
	gLhNwRGzdjhcKypJmUGcCB5LOydwOFdo63oG9aExV31Nf0gGX8D7FijQHoYIQBTe
	z0LuG7MuzI5Os0W8ciPdLHgRAoa/u16bQwkli4vNrZixGMKyzoa8C6pG2cCPhYEP
	wYLPNDguEAaHn+wt1Vv+ZAQS4yRBhjJpEf7Rwer0tI9sIbRm5XhM3gVTYvLAfu7z
	uRJfleE0tcOSPktMpqKUTC6i7esW42+GvIpNmAc9ILiDb+zfqVctB68cCA8wInzk
	P0ySXRBIOHI+r6UktSsqpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196166; x=
	1775282566; bh=nB8d0jYwSYIJdbtHpvsPBjnDrcbM009niIzG27rijNk=; b=W
	li4QQ+gvT1t7xeSOopd05RZVfVt9UVoLgcXHdBBnNCNhlpDl42qCNsQo4k0q+c3M
	+nQuaJbnswY16aaE5iGOz8r6F2keAIRCOGMZSLnAxhPFwoKhrmKeQHdzuXu794mY
	Y6T2FuqnjZWC6UCRLl/J00RiM1bRjVinvpes1wQW5S8n5PtFA2II5kT7eW/fbXvX
	+nQ2+5vMtCsDeC2jlI6XNe9Rs7q24+7r5eaj1WKv/IqCQL8fM11F5ii1wfwi5zQ2
	RsoKbwgLQ97ED+lJ+hUeAjjUJzKZcyHvYWAnpXIekcfJEzY+vhJUeR4xM0Nnhgh1
	E2MhOv2PiiHy3udGVGV9Q==
X-ME-Sender: <xms:BljPac3H0faZJNYSWYPFBJmdBOnVnlvjHwMP8trHwvjJqLM2LPJxsw>
    <xme:BljPaeBUcC6Xpm61ZW-JaZgadORoqgfsZRujQZ7c_uBGNtj97nOve7eXlWWYRHLV7
    eHuUaX-hZgqP60qvHRL3tWjU2som5f-bgkh3lRTLt1KjFAncPWxkQ>
X-ME-Received: <xmr:BljPaajOt6x9DFdPMVri_b2cfQrYHRQokn-lxmAO6nudJvhB4PXf1Aq1c9kLhJpDljRL-UgbFbVv6V4Px9YFi0qxFEHeWMKIUINiQ1-_fSc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:BljPaa9uQ0k3Dj5f1k9AMU1llDg0HZ-nvspYoxYr6e2zkyxnIMbseg>
    <xmx:BljPae9PoDNNfGLgnI7t3l8Q9yH_kmBmLIfCmoepHbRVmmcDXNv0kQ>
    <xmx:BljPabCvEbf2YfKoCK5HKXit2gaoTYQYp0aprgig9JZuUMk7keeVXQ>
    <xmx:BljPaWz3nnv2CNNG-n0CLYKJSIbm8Ar_C_H4yHkPWSGW-whiciyvww>
    <xmx:BljPaeHHPErl9klHwIwlJulS6aCm4Ig-nJBIvqoPQngYhPlyCM38s6pF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6292de2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:58 +0200
Subject: [PATCH 11/16] odb/source-inmemory: implement `for_each_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-11-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `for_each_object()` callback function for the inmemory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 86 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 22bae6927e..0ac20df323 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -32,6 +32,28 @@ static const struct inmemory_object *find_cached_object(struct odb_source_inmemo
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
@@ -44,22 +66,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
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
 
@@ -111,6 +118,52 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
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
+
+	return oidtree_each(inmemory->objects,
+			    opts->prefix ? opts->prefix : &null_oid, opts->prefix_hex_len,
+			    odb_source_inmemory_for_each_object_cb, &payload);
+}
+
 static int odb_source_inmemory_write_object(struct odb_source *source,
 					    const void *buf, unsigned long len,
 					    enum object_type type,
@@ -214,6 +267,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.53.0.1323.g189a785ab5.dirty

