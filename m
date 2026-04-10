Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE703BE155
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823195; cv=none; b=jqgID3ONU+s+AsarGerQQuHW5DfOYNg8x+l37zzY09SCRCPM8raP9VFPWgpN2XApUZ5JvRm1n6DC3u5ZeWzn2PLB6rl6QX+5rEZIRJ3vNIsYvLk2UKZYMbhshk3s5DCRSvt91Ck9MC/6jcsXy9z7W6C5prS6GWVVyAMKo1XoFf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823195; c=relaxed/simple;
	bh=YUbtHQCyXHukym1+61bkrNegebB3senu/f1n1+Zv8VA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaf2Dfk8GigAehwc18U5s1Fa4Xs4RiggXIPYE8SdaRomdkGESSLopNLnSBLr4RdZMOhXXlcqZBQRTOwvf3/9KlWm/gcHx6Lr8CHIIKDns0Eu2idizUmJBF9P3B+Befn7Uv2G8z1cDSENngbVZb71OEYuCaoHs/tZXrm+kagJjto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jIbJKV8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eljg0UHa; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jIbJKV8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eljg0UHa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E8EC21D00178;
	Fri, 10 Apr 2026 08:13:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Apr 2026 08:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823193;
	 x=1775909593; bh=KrVOvL9T0SPXQzy8T7/4TE18+fx0r0kspEKdh4vUYOA=; b=
	jIbJKV8HXeA4a6Xh/1ivWFgiPaYczwtFkqQOXFOyVYX+c2O+Mp3OWts2OGkHCFRC
	5d1ZhMADUaGheFngxTTLn1WX9TOW05ss8PnKcPI1bGu6hBAgBJxZe5HKxININsD7
	cnUuJ5CWl3f8YxYnOhjWmqQetjt5ON0O31XLXS+eaji6IFksZOpkoJEhVBaIhybu
	aHgOkXhsRm+VHZnpUAXk4BLKw0Gum6ozTavWcKGenaU/VxklTp/B69xHoBGm7Tk/
	2aGE5laqWbbZOQ8owqGiX/rFnguMuOrxn26XmU6KVDt6phgeTAFh+C9N7okSX99K
	2fQC/ASA7h3EUf47c4xJwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823193; x=
	1775909593; bh=KrVOvL9T0SPXQzy8T7/4TE18+fx0r0kspEKdh4vUYOA=; b=e
	ljg0UHa6RksB+WvrqCQm2P+wOnubryqf8WDR3h2Opt2S37F4NU6ul7dcmwLAxbXZ
	Dpm0QzY8zN7ztT5f5rwNKc0pqcuphZCtBcguCajSJFOt7obB5wo1DKiYuCuqdVnI
	fLFnTJ990s8ZzjYY0QqcPaAytODuH/6TCKFbUFvFZnxCHiXs3ksd89Ozn9IKaExZ
	xGI9RNCX3ujdFqFMazxbKZmhLzrWswd+NrWzEXPKcRq+ycedHQutJ4LWhXWjD2Oo
	a9KZuMonBxNiFJMJxK5UQS8znOPG5b+spTZ9u7SQ0aALjBz7VucLXmMDCTqb5foz
	GkvyP4GwUgScQdLXKLYdw==
X-ME-Sender: <xms:WenYaSybYSA0WPlXOjl8tRlIxw8i95lu7Bnnvd9r1J3rGRnUBjxSXQ>
    <xme:WenYaVuRWmGk7hYK7yw47DQ9O05RdOzaSH1WJL8Z4K8UlM8Ms3b2wJaPlAXYJQVeM
    r_lElJiUlk6mWUNIwF7Y169tGVCMDxm3ofym6brJOT5d8BAuER0>
X-ME-Received: <xmr:WenYaRuuifDxwX925K0UajhIW2qM_xcvppv59nH5_PdrAXaKj_QXdwoMeFh5xdc_9gvZaS1c_EWoZ3P8I3SHNfGcq4AS854FIpDhhDm4iziqGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:WenYaSPnufDrJXTBkKIpbKzDvBBqnSqxZBekCL2zHHQqWwP-ttnKvw>
    <xmx:WenYaX1Xdl3bYOvjP-b8O4JDkmOP1qik8HVrC10ushSi5F5m1ysTwQ>
    <xmx:WenYaWMPyzUPymMz30Jo3zfenpdRyqyd7-9Ri1SdRYP19f9Br-NWqQ>
    <xmx:WenYaf2IX86er2Qmrz0yknsrtGnBsP2IYsEVs20XC8ZDg4YUAV_CvQ>
    <xmx:WenYaVtbrjd9F-Ser2bb79DfU_y3a_swGLGG9_PdnRq4vbUjfZkezZ6m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:13:12 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cde4d92e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:13:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:40 +0200
Subject: [PATCH v3 10/17] odb/source-inmemory: convert to use oidtree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-10-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
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
index d05a13df45..3b51cc7fef 100644
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
@@ -88,7 +97,7 @@ static int odb_source_inmemory_read_object_stream(struct odb_read_stream **out,
 {
 	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
 	struct odb_read_stream_inmemory *stream;
-	const struct cached_object *object;
+	const struct inmemory_object *object;
 
 	object = find_cached_object(inmemory, oid);
 	if (!object)
@@ -113,17 +122,23 @@ static int odb_source_inmemory_write_object(struct odb_source *source,
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
@@ -167,12 +182,29 @@ static int odb_source_inmemory_write_object_stream(struct odb_source *source,
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
index d1b05a3996..a88fc2e320 100644
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
  * An in-memory source that you can write objects to that shall be made
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
2.54.0.rc0.707.g0fbf48f4d6.dirty

