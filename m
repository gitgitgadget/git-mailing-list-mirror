Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7E4282F1E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719506; cv=none; b=iIBkOo35GsMdnxodd2vxnYS/mJdOgND+a14XAYTb0Ttw7tr19TiZXVazXkHSfR0vDjs/+wS4QmCH+Fyihz7998XWDIIp2ST6hJ0K76xuVUOpSbJOp/KkZEv9z584njypQm3W05Qky/14fthi2YvFaqx4bS6bOnjJ7McnYjh6Ajo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719506; c=relaxed/simple;
	bh=h/sVyCY2KfKsHB+yqBuddMbUyNXZuBwcrXftM6/LPBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZfCd7l5YPotDeRjrdSdhoJ6ek1NOnTwCmqv6rIEq+FQomBy2WO1BKAKh6hSWDnx1BJb/8Y7aCYG10Bd+3WB3/ja61d8M3+ERycCwH8s4+6WNnzqe51C6fGNTbQv24pvXIh3Q4+zfYYdvWxOqkWXyDYgYbqf5EuX3SYBDKXjhOts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JZ632RLz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PX9fPkWw; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JZ632RLz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PX9fPkWw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8CF81400272;
	Thu,  9 Apr 2026 03:25:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 03:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719503;
	 x=1775805903; bh=vsAzpIxwYH46aF+Bc2RcbWBEdixZ/q8PQ7cjKF41Xgs=; b=
	JZ632RLzS6jsrshj/mkiBRO+rq+c2L0v0rnfbm4d6SiGkZcf4xvwvgStbgGKwOeD
	TYsJvbl8PKCl3NZL/7uisEITNNyMRM/f3+ej1xMhtOsk4MxBW8RIN12qzbKf+UnB
	erz5qOaFpEyUjsfj4Me9lKxTPR2uQ2h0/WOJADcxFde0D09DGYDsARPueIPIkVOs
	BGPkOOB3BYodw9weHcHjSxpm7bP/5YvnAF6JevBzlNsRBgLtCX29PiwwHI4nYMO/
	LE/SIH8vAYvypma/UqpFWE6+clp4itKtL2VAWfkiD4Qpp4oLeZWjNQ9IoCg18zIZ
	MaZXA7l0ShSE86x6iQEjPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719503; x=
	1775805903; bh=vsAzpIxwYH46aF+Bc2RcbWBEdixZ/q8PQ7cjKF41Xgs=; b=P
	X9fPkWwhuoCKWW2uQPhkxzSdz7GIIpCU2r/EkeDBkFgrgr2rhh8sufttfahuEZZr
	uDNJz5+6rw0fZlUArHz09R2Glq/D4y2qaopIjA8vB+C8Rs7jHwjAn6gC7OrfX6tu
	9QLBFa72gv2QLDdjxGFl4ILiytKJk0Kg4UDFMEon3X5lFhtVSq/fZ9nX4aDEXz1J
	d7JefwYRHedWPwQFMAx4BlINdbLF/Mdn5kR4NcaOD8m/G3mdstPAXa04XGFFMpqy
	1VpOt3MKo8BWvB1eo7lNpGKXYyPLY+kJIC4QWWmSbPvgh3D7VLLxbrJTW5GJVzGf
	VAT2YhxfyOPyKiXyg6XVw==
X-ME-Sender: <xms:T1TXae_IOdxVk14aszx-6_gDxAy_H5Vo8wETfaJaigBJxlYsbLSMMg>
    <xme:T1TXaWI_R9_52FVTJO2tf22do54hq16R1_E08xbRkyptyXPAIyf2vIiYCu1auqSL_
    ZxDU6Gdidxic_UVoP8t0LXXdPq8fqJmnu0u00EEPTbkfn7g6xGR>
X-ME-Received: <xmr:T1TXaRYRHrPnPYpcCXfGgbxPslvyy2_6PIIA5mp_HEft8i7fQmQlbnIaokvr387ClFf2GTha4FDUSj5XXg-a6_Ivs5aMbkaKrJauuZf3u9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgt
    ohhm
X-ME-Proxy: <xmx:T1TXaQKOOQRDuB5eA68-7Q2QrXzhLkx7EQ_eTkNq9o3fSBPUUjUR-A>
    <xmx:T1TXaXC-UJKslRzVrONR9qFRgy2ntugdgILpw1uH7VwtV5vPT_btrw>
    <xmx:T1TXado2S5Ex9n23QJBmccVILTJYwdOfrXvFGmmD0yzKYVkIZvmZoQ>
    <xmx:T1TXaahAGXvI21wMNguT4UFHePaepOSPW1ZDn4wjd8jtO6bHNFEr_w>
    <xmx:T1TXaSI4l3q5mcW1tFr6_CpDeQ_pZ5OA5jdvmqCBaPssZboIDN1BiFDG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7d59d27c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:25:01 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:33 +0200
Subject: [PATCH v2 12/17] odb/source-inmemory: implement
 `for_each_object()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-12-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `for_each_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 86 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 0420b98d00..d1674836cc 100644
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
 
@@ -112,6 +119,52 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
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
@@ -217,6 +270,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.for_each_object = odb_source_inmemory_for_each_object;
 	source->base.write_object = odb_source_inmemory_write_object;
 	source->base.write_object_stream = odb_source_inmemory_write_object_stream;
 

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

