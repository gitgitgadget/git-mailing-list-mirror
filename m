Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA903BED16
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823185; cv=none; b=FOHvjxHqreHnbqUaDY37bRbBVh0uKdidOyyGONlGC+c/TBb8ZFW4rUumliLntdtbwrTKdhvpIlgbs3vtXMMMS+rRXkuE/jGE1WL0lxmYySCxFd9GwxrFIZGrNhlThll2IZCjfKLekWHoCbpUh4A5iCtx7fbn/U1kZQI52pgqz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823185; c=relaxed/simple;
	bh=oK6RJIpefuChylTfz1va0Vb8uJq3aEyYjmwiCyMRd7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4LtKCY2234Tnvmx5AOnI7fMZ2ngdyYjZlcJHTxNKCtqTU/GIjJBiMWgn8ZOnhvs6mNOdDUUxW4rQo6wFcr5ysj+dwdLSZx1n6qJraO501lKCl+QeYhs2HameQE1Ee2aym+RJ7ZR3CtfknGVzFUISjVGRpFw5MYC1+UhjZKxskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rDTAa9O1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ekvPh0y4; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rDTAa9O1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ekvPh0y4"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9AC787A01EC;
	Fri, 10 Apr 2026 08:13:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Apr 2026 08:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823183;
	 x=1775909583; bh=MfjYB5mOJ97MOkAFbK+EaWK4IJdg9VHom76aQrdNXbA=; b=
	rDTAa9O1VYVNJutpDTw+/ebCBX20xUW7kWBRXXgPbno97QigBiNE9aB9oJHzbvKU
	hCV09V/E7KYgaahNFg5FhX+i/Ob9StQjkAL8UOofA+JtTR610POXlDIlpr1mBIs3
	BocPTWMpzt96tGyW/CtiWo39r0Sdh9+AsORa1Ww4V8ez7ZCHrBPSbYSbrkbpVNwj
	bJaVeKKq67evH4AFb7yisWKO6hRA8+MB0G9IvOKNBnpYwNfEN8Ur8c1r14pueghM
	miY6NP7AgxBw3AOcYTseEqODKtYOd0NVYIhnO8MpW/u8iUkdgxAKhMELlRD+TgAh
	dRJ9cC9JR9w2DuDllOuVXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823183; x=
	1775909583; bh=MfjYB5mOJ97MOkAFbK+EaWK4IJdg9VHom76aQrdNXbA=; b=e
	kvPh0y4pDB73xLalqaEZutHJZNGJQkWppADVkjDBVCyRY36DZvTw/ipv3LVYX9z1
	laxVlwJCDsP4emsCxKEV5WD0sPpojWevDK9qbewJn2ttM+p8pfR1JFv85O+bIIl4
	bRkN2+DdCPXek6m30FO+r5OhbOgcFpY3bLb43cGzGvzsTGHCf6Q7YaIxzCC3lKGy
	lUB9LnZKC+iT3kZWxSsIe8q3pSAkmRFIer9RnEQfc9e0xUaLkZGuwakIpvigTaws
	VNoe3fkFBFKchXwGnC4HjooVTm+LEsaDrogYG+9vcY/7X9SbcWq4GFyryjrfdr5z
	FhfqCdx9va+6uHAvkHczg==
X-ME-Sender: <xms:T-nYadHcG9-f47oatiVsCay5LlwP23F62vcgZggzz2Ah2ROIj2o1IQ>
    <xme:T-nYaZzCvod0X4Un1leC5ZOV-MkavSDNk6o7oP0KOGvJQIGDsQH79Wta6Lc4RHQAD
    qcU4NdMpeB5mb9zOleTwQ1XidZoQiVTLy7EkYbqFiZJBBgYTX2AlDQ>
X-ME-Received: <xmr:T-nYacgMXxPtxyNoQ_CEmpbqmAg618g1LqgTCpx0Em6UeCJgwoa51nO8hUEKA6kojNH0c4zn_PBWkZ-5_BnQmlpPLU6ue08f0iGdfCuZZ0E1KA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:T-nYacykHsYlJgKodJgTrG7Vi9jbuY8Y41QOMjHllm_OfguO1wLu0Q>
    <xmx:T-nYaXLujCGsPWXiG1VsLqbwtuVs3fGnwA8i7gFjhyLsCl4aXyZolQ>
    <xmx:T-nYabRz5Z4jGGQPGDMzsYvUjrO1NdDMXk9CW0ACfzsKCH4k3s_5Xg>
    <xmx:T-nYaXoFaf1CpnF4YlJ_IVGfBzAdMYdcbLXd-vkoETSlEpbOe4c6rw>
    <xmx:T-nYadxH49Y3YsUkawYja6qpxUMN4j-9zhl3SmPACOzmu7-vy-3q8ULP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 75a13bb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:36 +0200
Subject: [PATCH v3 06/17] odb/source-inmemory: implement `write_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-6-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `write_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 16 ++--------------
 odb/source-inmemory.c | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index 6a3912adac..24e929f03c 100644
--- a/odb.c
+++ b/odb.c
@@ -733,24 +733,12 @@ int odb_pretend_object(struct object_database *odb,
 		       void *buf, unsigned long len, enum object_type type,
 		       struct object_id *oid)
 {
-	struct cached_object_entry *co;
-	char *co_buf;
-
 	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
 	if (odb_has_object(odb, oid, 0))
 		return 0;
 
-	ALLOC_GROW(odb->inmemory_objects->objects,
-		   odb->inmemory_objects->objects_nr + 1,
-		   odb->inmemory_objects->objects_alloc);
-	co = &odb->inmemory_objects->objects[odb->inmemory_objects->objects_nr++];
-	co->value.size = len;
-	co->value.type = type;
-	co_buf = xmalloc(len);
-	memcpy(co_buf, buf, len);
-	co->value.buf = co_buf;
-	oidcpy(&co->oid, oid);
-	return 0;
+	return odb_source_write_object(&odb->inmemory_objects->base,
+				       buf, len, type, oid, NULL, 0);
 }
 
 void *odb_read_object(struct object_database *odb,
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 39f0e799c7..4848011df5 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "object-file.h"
 #include "odb.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
@@ -104,6 +105,29 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 	return 0;
 }
 
+static int odb_source_inmemory_write_object(struct odb_source *source,
+					    const void *buf, unsigned long len,
+					    enum object_type type,
+					    struct object_id *oid,
+					    struct object_id *compat_oid UNUSED,
+					    enum odb_write_object_flags flags UNUSED)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	struct cached_object_entry *object;
+
+	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
+
+	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
+		   inmemory->objects_alloc);
+	object = &inmemory->objects[inmemory->objects_nr++];
+	object->value.size = len;
+	object->value.type = type;
+	object->value.buf = xmemdupz(buf, len);
+	oidcpy(&object->oid, oid);
+
+	return 0;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
@@ -124,6 +148,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.write_object = odb_source_inmemory_write_object;
 
 	return source;
 }

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

