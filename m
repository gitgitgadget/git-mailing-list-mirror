Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8631282F1E
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775719503; cv=none; b=VA1S8zNCX9/IWrkObJLFqqfJ+j751vsvoMi0AkwFyyNY/hd2nNUiQxwSK2I50nJe39OALpmxpAYVbZl89NkBuVuIFE6x8PbVy3OY9KNm5IId1MYvLP3MzhRFf6EEuV9RO/i6I7CnQN/1cfN9MK+FyI4hLxZovE1U00Nmib6SHlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775719503; c=relaxed/simple;
	bh=1rDna/6kidH2LYMT1kp3P4LlbD0X1S5kI7SVPXkSC1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePlzY7jswSbMBfsIqnT3cxUUmHOnLjyRHvRBfHuvxUOib95xMOied/nTUyirJ9cvtpuPdHDJfLnUi3mjaIkR0YqG3gXhuu/0eafWHUhQIfI1ZWdyAxABlTN07LWntWG5BrB7wtxqusMyMuhyxwOy3/N1sLPdOukzab5FgGqtSO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rgf1L38m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ap4VJTe+; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rgf1L38m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ap4VJTe+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 05FC61400273;
	Thu,  9 Apr 2026 03:25:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 09 Apr 2026 03:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775719501;
	 x=1775805901; bh=gzXKWM8gF11BQZprJxJgEBQ4xpPlrlhNJbQdOwBqsfE=; b=
	rgf1L38mhr+HebIsaFEOe2kc4NM/VAaHpZD/4HMgVZy7DyuBuT8wPaWapTDUH4We
	OtJcPxnIYSD3OSYyinhBcPNpXluu18xlEtEpN+/CLMEtm2nrUjOYFShCa9u4HrVd
	w9Ll0umOHrC9eCKXuguR6R8ryOOeKtrrCZBMsYY+NRAPBr9/5GJ5aCxyG0z7zxJf
	WFO9cx9BsIQrTPYPJyygeoYYg5nYm/F9i862AqZsaLXJTrpKubJfIi5y9FWncJYi
	5+Hv3BKY9dQ014QPL0ODxIwDA//9SsoZMTzwk3WUq1qS9uxOTVOXMGbNqaFFCPvu
	Dhdz5TlICwCRpwdBH8I68g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775719501; x=
	1775805901; bh=gzXKWM8gF11BQZprJxJgEBQ4xpPlrlhNJbQdOwBqsfE=; b=A
	p4VJTe+GuKKniaGqjA7pash1Z7ZhD4O+9eRkDMN3qexT8hfRNEa7PluACXrqf4R/
	8ooA22NI+sHkKjZP9L7xUKuvtdPdaSm37Qx3dVaGA80A/ACkFeyNeHokRY0aDxos
	4XuQ/odw+0+BmryyoeZwELm3FOb7OmSweh77FwojvZ1xmA7DFnsKk3o6a6bncth+
	gNc0C4Vl3G6jYfdX4PT90vmBUTLpkrGZm0E0OUf4swPWyidJ4R6Eq7uYypHvn/o8
	r3v6e+E+CXQ0i65d6TttH2HPsoVsaaHIEeJUNwS+tZN1VeMnMAydSvP4ZILT3SbA
	lWbBnDG4rRQFwoeouQT9A==
X-ME-Sender: <xms:TFTXaRcD4aDRbg94iYSHNezsf2Ck9tJ_29x2z4zGzAqX9nyQXKeY2A>
    <xme:TFTXaWrymiVIOx_T3aa-wfuM0524vGRQGHZZTFvAy1mxSIxCdBagV4x0PmnmXlHyu
    F1SFIxs5EBGiO6zxeUipFFTB_yXHrCELidfSrMKpZynnv0c8WTqdQ>
X-ME-Received: <xmr:TFTXaX57-tL8zmuWXpZdxeqfD_jLyowA97Vhfp4ViLwIJiogZSoyYzMmZvfBvgFAoICiXX0XUsxB_en1-Jre-EKqcPMD5bxhgyg5G2gZEkE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:TFTXaUpMjOSOaIFpIDfo2JRocayhQjH9eF48iZpeyAdOWlf4oATpEw>
    <xmx:TFTXaRhz4EblKNC9OZo1nUyISWkjny88ufMabnVG2H6Q33kVIZPKMg>
    <xmx:TFTXaWISqslHpE0gNtRQR2qprN-BNadkKq3g4j1m-75rhHNl_1nvPA>
    <xmx:TFTXaZDpGAbm5R4bZ61wzFHfk81gXLlf3FJuWLATehuNQllEG1DUuA>
    <xmx:TVTXaSoFXuPBEROpEwmcvyZ7Jb0veBmCY2XIAxJpqa_5ym_JTvMONZqa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 03:25:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e409cf35 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 07:24:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 09:24:32 +0200
Subject: [PATCH v2 11/17] odb/source-inmemory: convert to use oidtree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-odb-source-inmemory-v2-11-f02b4f1c0f13@pks.im>
References: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
In-Reply-To: <20260409-b4-pks-odb-source-inmemory-v2-0-f02b4f1c0f13@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

The in-memory source stores its objects in a simple array that we grow as
needed. This has a couple of downsides:

  - The object lookup is O(n). This doesn't matter in practice because
    we only store a small number of objects.

  - We don't have an easy way to iterate over all objects in
    lexicographic order.

  - We don't have an easy way to compute unique object ID prefixes.

Refactor the code to use an oidtree instead. This is the same data
structure used by our loose object source, and thus it means we get a
bunch of functionality for free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-inmemory.c | 72 +++++++++++++++++++++++++++++++++++++--------------
 odb/source-inmemory.h | 13 ++--------
 2 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index 578ceea550..0420b98d00 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -3,20 +3,29 @@
 #include "odb.h"
 #include "odb/source-inmemory.h"
 #include "odb/streaming.h"
+#include "oidtree.h"
 #include "repository.h"
 
-static const struct cached_object *find_cached_object(struct odb_source_inmemory *source,
-						      const struct object_id *oid)
+struct inmemory_object {
+	enum object_type type;
+	const void *buf;
+	unsigned long size;
+};
+
+static const struct inmemory_object *find_cached_object(struct odb_source_inmemory *source,
+							const struct object_id *oid)
 {
-	static const struct cached_object empty_tree = {
+	static const struct inmemory_object empty_tree = {
 		.type = OBJ_TREE,
 		.buf = "",
 	};
-	const struct cached_object_entry *co = source->objects;
+	const struct inmemory_object *object;
 
-	for (size_t i = 0; i < source->objects_nr; i++, co++)
-		if (oideq(&co->oid, oid))
-			return &co->value;
+	if (source->objects) {
+		object = oidtree_get(source->objects, oid);
+		if (object)
+			return object;
+	}
 
 	if (oid->algo && oideq(oid, hash_algos[oid->algo].empty_tree))
 		return &empty_tree;
@@ -30,7 +39,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 						enum object_info_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
-	const struct cached_object *object;
+	const struct inmemory_object *object;
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
@@ -86,7 +95,7 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	struct odb_read_stream_inmemory *stream;
-	const struct cached_object *object;
+	const struct inmemory_object *object;
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
@@ -111,17 +120,23 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 					    enum odb_write_object_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
-	struct cached_object_entry *object;
+	struct inmemory_object *object;
 
 	hash_object_file(source->odb->repo->hash_algo, buf, len, type, oid);
 
-	ALLOC_GROW(inmemory->objects, inmemory->objects_nr + 1,
-		   inmemory->objects_alloc);
-	object = &inmemory->objects[inmemory->objects_nr++];
-	object->value.size = len;
-	object->value.type = type;
-	object->value.buf = xmemdupz(buf, len);
-	oidcpy(&object->oid, oid);
+	if (!inmemory->objects) {
+		CALLOC_ARRAY(inmemory->objects, 1);
+		oidtree_init(inmemory->objects);
+	} else if (oidtree_contains(inmemory->objects, oid)) {
+		return 0;
+	}
+
+	CALLOC_ARRAY(object, 1);
+	object->size = len;
+	object->type = type;
+	object->buf = xmemdupz(buf, len);
+
+	oidtree_insert(inmemory->objects, oid, object);
 
 	return 0;
 }
@@ -165,12 +180,29 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
 	return ret;
 }
 
+static int inmemory_object_free(const struct object_id *oid UNUSED,
+				void *node_data,
+				void *cb_data UNUSED)
+{
+	struct inmemory_object *object = node_data;
+	free((void *) object->buf);
+	free(object);
+	return 0;
+}
+
 static void odb_source_inmemory_free(struct odb_source *source)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
-	for (size_t i = 0; i < inmemory->objects_nr; i++)
-		free((char *) inmemory->objects[i].value.buf);
-	free(inmemory->objects);
+
+	if (inmemory->objects) {
+		struct object_id null_oid = { 0 };
+
+		oidtree_each(inmemory->objects, &null_oid, 0,
+			     inmemory_object_free, NULL);
+		oidtree_clear(inmemory->objects);
+		free(inmemory->objects);
+	}
+
 	free(inmemory->base.path);
 	free(inmemory);
 }
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
index 14dc06f7c3..02cf586b63 100644
--- a/odb/source-inmemory.h
+++ b/odb/source-inmemory.h
@@ -3,14 +3,7 @@
 
 #include "odb/source.h"
 
-struct cached_object_entry {
-	struct object_id oid;
-	struct cached_object {
-		enum object_type type;
-		const void *buf;
-		unsigned long size;
-	} value;
-};
+struct oidtree;
 
 /*
  * An inmemory source that you can write objects to that shall be made
@@ -20,9 +13,7 @@ struct cached_object_entry {
  */
 struct odb_source_inmemory {
 	struct odb_source base;
-
-	struct cached_object_entry *objects;
-	size_t objects_nr, objects_alloc;
+	struct oidtree *objects;
 };
 
 /* Create a new in-memory object database source. */

-- 
2.54.0.rc0.680.geaeac8ef83.dirty

