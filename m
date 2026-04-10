Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04623BD624
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823181; cv=none; b=Crsq55EOfN/fImhVDPENLciTkM8jVkn/apw4KxHdDjbJr+4JQ3UQjZaqrT1vsPmBbOL2Qrwx95UkxksbzP0hGcm1Qt1/jbbERQR0lGuh5R9TaxR8T7hmVk7wtd6G7rvnn/bIb0nV9fSLAZMgYYEJQ7liAUjEEPkxKTQ+P1KnBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823181; c=relaxed/simple;
	bh=2dMOk/wOB+z3K4Gjbg1u7n6jDsuqBa/KCjowryYuvAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M09UyLEheTarwQNfVtbG8CH1KTdX0qXVaevj4BauyqBvGlRCReLmR/0Z1FhyGZVG8EaZi74sN/F5SPJX94916Azww2muFkMBC/UvHkmgV6s6x7Fi/4RziNAwJ7OIx4inQIrps/cqOLH3lsHl93WDoQE8kpo6qSxn4dP/Ivt+bTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pWwKbO7i; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPRn4gnQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pWwKbO7i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPRn4gnQ"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 16C967A00EB;
	Fri, 10 Apr 2026 08:12:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 10 Apr 2026 08:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823178;
	 x=1775909578; bh=0lTIiMrrTZLwpL+apoSajlb+/zWLCNf7rwWCMHuXz2E=; b=
	pWwKbO7iCaeLj6OW5rX1j0LNlrSCRlfPmWFLzRwMZ6X0113JyA4kH1XCmuhJpquS
	fu6AkKtjp1LRJ2eKk4RvpUjphLMcjZRexpCqtQESjm8ek0ak7Ot3BKvXEWsLUjAa
	a2aiVlnHhQFqp2l7xMH2cJCJshAqHRwEvPRIVvDFqlKDBbdcxtasAfHGxLlqU8qQ
	9KPQdXgDvDDh3HCvKjVIIuwlMqSpfxQjdXoAqs24coJRHCRo7GxnhXYwzZwn1bh7
	79E5G+mWCUMALIz/qCgW0CP60HjBc7rrLqBWgq/PdVR3V8apbFHvF+jMqFeyXmSG
	twDw6DvHdM1apxCJ8G/hrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823178; x=
	1775909578; bh=0lTIiMrrTZLwpL+apoSajlb+/zWLCNf7rwWCMHuXz2E=; b=M
	PRn4gnQ4DdpsQdUuRaAewClJFCj4olOm2URx3aoLnvZmQx6JJn41vTs8CRcF1QQq
	HDUhKyQcVhoEizzyGUJEHSZ9g+g4hgzwGFVN5AEKQgymGslQe9U6lXjgYcIhTfll
	YvGZexOZcvVb32Et2Mq9GdksQ4CN0X96GRtKMrw48M4eGdE9T9kCw3Lnv4IdwauO
	bHRRaUZc8bteAL0CMxFy0a3fuREUKoGYG41MbqptzlxzXGv0tj/ONgAkBFZV6MZX
	KLpmP7jDkV13JuUHCT9/p1HwhH4xzw/137zOWiuY8S1laOGNmS8VfmQlfg1A1jjC
	6y2YyZjmdf2W4CNaasHZw==
X-ME-Sender: <xms:SunYaUnUZ7qXoVEouHQ-6Wvx1l2bOaE3YgHcjB9kn-dyV5J0JLh8dg>
    <xme:SunYabTwDFo8gtyNWLz2KVVOF0O1-lHqLP2bkW9ZItyRrQHnlQNbDtQ5AMQVZLicp
    dc3uZS6NbB--F9telvXxg6Lt5sHL7Bu8PDyXEcCYafRlzZvFClvRQ>
X-ME-Received: <xmr:SunYaQA9Miogk65TCJ3S4_t_rlMlRyzdZTxHHE2tbYIuD7LICnRszpX8mjp2ZPZ86eCJ2cTgTJ9CTQLdS_rI7uTvgEO8rfvk_671-iH3h7huJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:SunYaaR8_D6U4XKJly7GyhmYNXTlHBhxj6KZ6mlYQ-hlQhxnTNdj-w>
    <xmx:SunYaWrlDTNMFOY0_KYOzIY_C4XeUBFuSNaCnnjU5bm7yaz_osGumg>
    <xmx:SunYaUxrUa2EI3hDlGXc-YhoOEVlw8lUKj_YKAjUIfeTxpzwtNUojg>
    <xmx:SunYaTIB9DGHQ8D_cXhQbcTFOjBRJ8IJjRlanMfrJmVxiIpHkSzJTA>
    <xmx:SunYafQDVxp-nfG1Li6cwvrmRrM47LI3npSFMB_nH9FjoBYhxNMwS9Gr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:12:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c064cc65 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:34 +0200
Subject: [PATCH v3 04/17] odb/source-inmemory: implement
 `read_object_info()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-4-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
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
2.54.0.rc0.707.g0fbf48f4d6.dirty

