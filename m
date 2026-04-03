Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C3B374E55
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196172; cv=none; b=LGo14cwNKldgzcsqgTiM4c5MdiQks9RYD2FO5p+l0k3apqYBxlVcezvJvfuHm8ivjdbcWMeLLiw9sQPY4yY9Lf19ALXA6vonR5Vbay02+fuJvSkZkm9j+BmspT5iRwmRMKrrh+7PC/boSZPs96MbU9s7QPLI/EWjFDWrXj82hJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196172; c=relaxed/simple;
	bh=qmLdHj4jnIYQ/dr7QanPVJz6hCpfOmQJjnPME2hpD2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIqgjmG6PrNhoAqLu9PKVS84EeWq0UwqoXDD36Ib3BC8wBhrTa9oWFK0DwWu0dNNQdQ6PkpFIOvM52QWIxj7P6z7JpkpsrZAsQFIZ39xrFdcu1dsrGZ2fJLa+urn75j8KP9wUWgh7liAdMZnuxMoyI5Fsklk8XLctn3qSWzUxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qJ/mmxET; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PoLFAGL8; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qJ/mmxET";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PoLFAGL8"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 756BA1D000F9
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Apr 2026 02:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196163;
	 x=1775282563; bh=+mujMXqaSYYOyQGbfMSvbGGn21TFvWxfHnz3bo0KQUc=; b=
	qJ/mmxETfCP9Um6lMXV6vixtJ0iF8orUbppu7wf72JVXLOwQyF9IRWGuUztfck8K
	7ylTFMbgKjSBIEai66t96OrIb0ajaojkY6Xlg4px/9zw757Kkl2afjeWM2xj0RIq
	RwkoTK2V7KCiE6YaTcfgMJEHLYRI24qZD3hbwgGDSWa9PMY/0aSM/uquYd4vsbnb
	JRqftcmi3aZe9DWHeQnx37OW5PiwAi0IadVowk1h8zyX8Ob5eWZtIib+RRDY5Pa8
	7EuRJBTlK0M52hXe76Z+vCMx/WkvKimenQyStlVCrTFxZGaXP++xO0VcnPEVRhr2
	+xlW1Cx8YW4VzIrv2jKdFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196163; x=
	1775282563; bh=+mujMXqaSYYOyQGbfMSvbGGn21TFvWxfHnz3bo0KQUc=; b=P
	oLFAGL8TXKnk9zPWHQZKTOqokxIxpHsranXwoYaoWiW91zXg+le6lPfGv2GJQd4c
	4DwOWc+J/f8CARTKBcW3MLHhlCyNOBj+mAxMtsBHUC62QryB5BL3lgLosdnCoXS/
	XyQWhwqCeGbIOfYrE+19dKC+kV1Mm8u/jFhPBrEvbZuNnWs2KSqDBUfx26Ge3n4z
	v5rMmbw1UEKhtj2gSmvjolezzC4iNioODzxKlLTk1/hTlR5+TcvTQsm4HARRogWH
	ZO+RtdtCQ8s8an5hmeDi9l/83Ster8qMFdAZJkjvQz8whKue4ZZNMNCfcqdCVeYq
	y/Q3HK78nTuYQ+6ZOrz8w==
X-ME-Sender: <xms:A1jPaQJikfMmTFSmFO8UKGHrClMoM7lfPDwTBUtNO3SHoTnD4O8hrw>
    <xme:A1jPaXGbbA-6CRvGSZyQUDSYhADE1ujZNEfQyZzqpf7neIuRKAQvC5g0bDOwAO589
    vu2fWL5REtbqteR2V70gl1AIcwfS_7-ZUpc5UFAqj4gn7cqHKAdnA>
X-ME-Received: <xmr:A1jPaWUgNOs_3TunU-NPFc5GSkd0SMWfCwtk1zUHpJrb6r1vxQo6SJZhggb3VAFAWmLRx1Q8rFT5X5Jy3Omwa6G1QhXkvclc-gZmPIISRxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:A1jPaSgK3tVYPKPMiJixMkX0Z7fDSYuX4s05VD2VmZXCo6JrABhiMA>
    <xmx:A1jPaXQ4rzo6EU4B76iofrpn0KwhEzUiH9AcdbKB387Y70uwjxF4Hg>
    <xmx:A1jPaVEu7s3DN1RjNWdori-ptrt06UYYfbLMJ7fuhaZZ9xMXfnwMxg>
    <xmx:A1jPafmHsau9zpB6Y4Y0w8SMnMioHZScoKPerWrCfAg2gGx4rcN8qw>
    <xmx:A1jPaZoziQW7HM8WuUi5Jlf19l6EEgtoVN1Cfyx8-UHkAny5cxOWnxby>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6eb7f33b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:57 +0200
Subject: [PATCH 10/16] odb/source-inmemory: convert to use oidtree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-10-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

The inmemory source stores its objects in a simple array that we grow as
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
index 890e2a8c7c..22bae6927e 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -2,20 +2,29 @@
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
@@ -29,7 +38,7 @@ static int odb_source_inmemory_read_object_info(struct odb_source *source,
 						enum object_info_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
-	const struct cached_object *object;
+	const struct inmemory_object *object;
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
@@ -85,7 +94,7 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	struct odb_read_stream_inmemory *stream;
-	const struct cached_object *object;
+	const struct inmemory_object *object;
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
@@ -110,15 +119,21 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
 					    enum odb_write_object_flags flags UNUSED)
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
-	struct cached_object_entry *object;
+	struct inmemory_object *object;
 
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
@@ -162,12 +177,29 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
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
2.53.0.1323.g189a785ab5.dirty

