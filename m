Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84EA40855
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719491; cv=none; b=eKY5u9NlagNCQPxDxq7LR4Ti1jLbjvkHEjFsaXrovbU3mmbrrLQnlZAS0JlIISnP6NntWYlKJXTAqGjA+HlpYzW3a/uvT04pxjrFoBRKlQIlWd+CHe+8P0i5xmUDusAK7u0oEgp9VNNsIJs/48wIPTMIVKvF2zUA7jcWz9fPaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719491; c=relaxed/simple;
	bh=9vV9pVoDYnLF/D3RzBTQuTyKzpq8PK8hGPC6NKMyuKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JqbSXlT6biwFX5rPaJnZu9a6DqWyjHbKVhyqVIFwJ/0FkiJSuIGejMvBXZQ1xY3QWnaRBmLFeaN4Ru5NYM+M9tyN8AdTEHqiRxNM6TsSJzUm1UOgCcMS11+fG6xgvVXi16RUsBps+C+MJIh8YSWmLFJdgq9WzNG8AO2toSD+GWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=teIS+9KC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qo8EI5V7; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="teIS+9KC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qo8EI5V7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 192A6EC046D;
	Thu,  9 Apr 2026 03:24:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 03:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719489;
	 x=1775805889; bh=dbhqntRCvOfX/RWX6g/3m9j6jJHJNvFhRUAvkZhxUZQ=; b=
	teIS+9KCMTov/IMmtmS0Nw/ZGvs5RWVQIiDbdQUxF+FDwBIcVDwalYpq7xN3+XP3
	XWvrLRWVtCVflmV3lTgZo3X08xcw3gh6Oyg12ccenS/jEyCioudSqLWfFPwuEzOV
	OU0osOmcOEu0uoR30jwUf7Otb8BPOH5kbUGo1LxuCJOQGBarufL64CN9dngXWVI1
	K6Wlxr9mfdKfMi1i7Dc7AMWQ1xV+5chJRigsMx/ShygU0RGByaNJP73lyOHkXwIA
	EVDlIfkXX1MbaEsHdn0rGIoHFamCqyaBXxVE9vVUv5b8iYlZ2xwiqHafeOlRUaeX
	Hzz5x6o1HeRcwXuOJ6y4BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719489; x=
	1775805889; bh=dbhqntRCvOfX/RWX6g/3m9j6jJHJNvFhRUAvkZhxUZQ=; b=Q
	o8EI5V7QH/O1UDsfcGGlxmPjKEuAeMdoXPpy/9AbkAAFCrrYGWYRASclwi2YDea7
	YLi79qMKz8eHi/dZsPbnfmlrb1Ft749KJUnDJXqIC3hpwy8ZhKG0HWIgWPtiUc68
	/52HaN8nxpGa2Ry38kjDcVP7nH0l8ADgNVlFo6+HlDOC6PJrkLADQly1v8Gh1/xH
	nO0vPGgn9CxVICOJFeEXF0TKSsaAUS7+Z5UkHXwuFnaoXEqCUcGTsp7GPAgV+IDa
	NKizXhW7yi990foU5w+DLW/EDaJWkrVMJ3CJNHUInuJHPGzfg6pmPQNY5oNZVDQh
	HCHjgeiZ3rp0xRATQtekQ==
X-ME-Sender: <xms:QFTXaaDASqfsoLxV_CTH17j9dZEkOAfVcB2N_j9G7G1dvp0aasiUXQ>
    <xme:QFTXab-7NWm8V_FqL5m3Xl5piHjN3_nA1r08vyO9rmAdShSkgv6huGkeQdIzcwgOL
    piTbYL5-OwLNxMrTD5CuEYx9rB24uFofHbpHhd14AL3qrheIuAiNg>
X-ME-Received: <xmr:QFTXaa-SIP1AjygyUW26gj5kmVDiWs5vydTljnkgDW_R8sFWOG18SIGjDVtONjuzEV4YvfSenQh-Gvw-mDpbK2lwzorgoUqYvhhNvLKj3DI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:QFTXaScyxu5Ev8CF87XHu16dlBurtqlKpdG2YGQBSKTfKccZQHNjEQ>
    <xmx:QFTXaTHgxzMQ0tGSPrS1gOtz2km-rmds4m-l4s-NRcM1M-D5AdLuvA>
    <xmx:QFTXaQf8Q9W-R35sBlQpnexiRQAbSCb2G42XBNwt4_WVQhbkL2wi2g>
    <xmx:QFTXadGip7gDpPcjUGhzv-gn0zO65Uj3fgaxNeIXVNlTulHLCA-CXw>
    <xmx:QVTXac3yRTdC9qjeULcJapOJXmD-Rs3yN1eeSxPnaepj4pxMBQhXZAxw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:24:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bf443da2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:27 +0200
Subject: [PATCH v2 06/17] odb/source-inmemory: implement `write_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-6-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `write_object()` callback function for the in-memory
source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 16 ++--------------
 odb/source-inmemory.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 14 deletions(-)

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
index 4a68169430..d2fc4c4054 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -102,6 +102,27 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
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
@@ -122,6 +143,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	source->base.free = odb_source_inmemory_free;
 	source->base.read_object_info = odb_source_inmemory_read_object_info;
 	source->base.read_object_stream = odb_source_inmemory_read_object_stream;
+	source->base.write_object = odb_source_inmemory_write_object;
 
 	return source;
 }

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

