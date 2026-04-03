Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C5F36E498
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 06:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775196150; cv=none; b=h15oJKxfakYbiW+NVhc/7wSwG7cWfUEM4eaUdGw0Ec6EkZuSwHibov0Ojto879SrNsxBuWTD9Y29aAX/tITR1hmccSZmQhMCWMWc1CDOTGhiyf2ykL2eeGsyM0sqr4vQnI4WSOkU/dSPAD8zIkHOe06hOpI5nuhImoAcqgo2evI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775196150; c=relaxed/simple;
	bh=p5YfUyKI4jUsd4PoK+pl9/ZwOQrXoErkXXccdPS/0DI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgObUbAmRDc9cImuf+3O3hhEYekf3Qy4lMg1I0IePhJQl9ynij0lZIpuyor4WDDpiOn6Bl7BsgeUmQw6AkI89KXl+LkpQoK/NHceQfPwlqLfQYZjlETVAy0a0QUJnhxsD7Yaoh9cnRnaOAgXuksrt7NnDrwDaHx7um8YLkWuVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vR8EIMFN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bXTFW1aW; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vR8EIMFN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bXTFW1aW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D59971D000F9
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 02:02:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 03 Apr 2026 02:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775196139;
	 x=1775282539; bh=V5rlqPHKox+V8AE084f50h2CCEKBonIzESfQsHlhldk=; b=
	vR8EIMFNQ5T8xqbmyI0hL6v4eaPz+axSix2g4qFdCZg2Sp2vIrYq8s4Mb8gBoZr5
	D1+s7nGWaPiWfma3uXq19ReT+3yFKOBqwdaYUqCNgtdvmmhr5HIN/K7wSfPJ+g6W
	jtomKe6D4nhO9CrxFxv84bTKs7Pz/JZ10C0BhtreNzDR0X3QsGsYHTTlIGLNWhZv
	u4c7OzOFrujZyEVpYEoSFefJYiVm7AYVOf7BcAiPIZOqZadVYteM+bYU9DxPxNNb
	SaWYBTbC0v+gi7vmYId6C/gDWV9FdP9v5pBw0ZYusmDK1Gekj8BaX2Bwq3HvE4W9
	qGQ9khXTaGOQA4FMoxwunA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775196139; x=
	1775282539; bh=V5rlqPHKox+V8AE084f50h2CCEKBonIzESfQsHlhldk=; b=b
	XTFW1aWYBDdsKWucX4ag6ddHxZTi48zbGvjOod7/Eql9pFD99NaKz1FqOqbstlhi
	ngr1JREXDS/SdNbPGHws5YqX++CjgwKeQhgsBT6Fc4ia82N7qWx8+tntYl4WdYvI
	tRNXhLIzKVjsCZ4W6Vjl7GM6uk11RHIX9fvDkzr7wUeotlFOc2G8qrd7kIhPYqhj
	wklx9zr1uscE4yuRt6QJKd1Cb3bZk6AnYDhD6PdLe9CbZBU4UbL8inOihApKXuBJ
	q3UwZQXBIIYz+aEDsf8clXXT0QIlp4ozp1/rauRBwqvVOsvjdTQilvR7Lsfhye7I
	CZG73K9QKkLQsXRdv13Ag==
X-ME-Sender: <xms:61fPaSJuvEzwPbrQW6cAFePQosMmsgDMljj1CbiWPfTAeHc8L_D2lw>
    <xme:61fPaRGFJaHccYAX2LUIzoPXXgnwujTJ3FjUIYawoBXuEZeygI4PQWN6l9_WcDUFX
    G1IdYS-0C-xJvrWAWYoubWbOyG9QV8kts7BXRldE5ScrW3TItmqwg>
X-ME-Received: <xmr:61fPaYVZVThSNfKKXir1rzBjGDqraMigRZfWGJGLvAbKhVgQEZWrh6NNrXgRrbJWfg-TIkYVYKtozpXXiycejis76YUDSxNXDFTIHfKQOgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:61fPacgc1u9WEZ4sFD6Z6dxLyli3zA-8nHcqLDbZxeI6PNREulW1cw>
    <xmx:61fPaZTmihVj73UhTjUHVlE_0SPURQ6EO_NzMH8rJD8Ov_7J9J-_Lg>
    <xmx:61fPafERaKGZa-OZM48TCFR-xhyAwY2E-G92hzhnHLRPxM9y-duDTQ>
    <xmx:61fPaRkzmdD9UfWZ9aAdiIBJYiOJvQV4ge5gimNoCXSWvfZsLemRNQ>
    <xmx:61fPaTouK_5UgXiP02-vsbvfO2g7ipXQjlnxi0Td1EF1XsYQ-ZwVFqMi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Apr 2026 02:02:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3731823b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Apr 2026 06:02:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Apr 2026 08:01:49 +0200
Subject: [PATCH 02/16] odb/source-inmemory: implement `free()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260403-b4-pks-odb-source-inmemory-v1-2-8b8d1abaa25e@pks.im>
References: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
In-Reply-To: <20260403-b4-pks-odb-source-inmemory-v1-0-8b8d1abaa25e@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.1

Implement the `free()` callback function for the "inmemory" source.

Note that this requires us to define `struct cached_object_entry` in
"odb/source-inmemory.h", as it is accessed in both "odb.c" and
"odb/source-inmemory.c" now. This will be fixed in subsequent commits
though.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c                 | 25 ++++---------------------
 odb/source-inmemory.c | 12 ++++++++++++
 odb/source-inmemory.h |  9 ++++++++-
 3 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/odb.c b/odb.c
index 95b21e2cfd..d321242353 100644
--- a/odb.c
+++ b/odb.c
@@ -32,21 +32,6 @@
 KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
 	struct odb_source *, 1, fspathhash, fspatheq)
 
-/*
- * This is meant to hold a *small* number of objects that you would
- * want odb_read_object() to be able to return, but yet you do not want
- * to write them into the object store (e.g. a browse-only
- * application).
- */
-struct cached_object_entry {
-	struct object_id oid;
-	struct cached_object {
-		enum object_type type;
-		const void *buf;
-		unsigned long size;
-	} value;
-};
-
 static const struct cached_object *find_cached_object(struct object_database *object_store,
 						      const struct object_id *oid)
 {
@@ -1109,6 +1094,10 @@ static void odb_free_sources(struct object_database *o)
 		odb_source_free(o->sources);
 		o->sources = next;
 	}
+
+	odb_source_free(&o->inmemory_objects->base);
+	o->inmemory_objects = NULL;
+
 	kh_destroy_odb_path_map(o->source_by_path);
 	o->source_by_path = NULL;
 }
@@ -1126,12 +1115,6 @@ void odb_free(struct object_database *o)
 	odb_close(o);
 	odb_free_sources(o);
 
-	for (size_t i = 0; i < o->inmemory_objects->objects_nr; i++)
-		free((char *) o->inmemory_objects->objects[i].value.buf);
-	free(o->inmemory_objects->objects);
-	free(o->inmemory_objects->base.path);
-	free(o->inmemory_objects);
-
 	string_list_clear(&o->submodule_source_paths, 0);
 
 	free(o);
diff --git a/odb/source-inmemory.c b/odb/source-inmemory.c
index c7ac5c24f0..ccbb622eae 100644
--- a/odb/source-inmemory.c
+++ b/odb/source-inmemory.c
@@ -1,6 +1,16 @@
 #include "git-compat-util.h"
 #include "odb/source-inmemory.h"
 
+static void odb_source_inmemory_free(struct odb_source *source)
+{
+	struct odb_source_inmemory *inmemory = odb_source_inmemory_downcast(source);
+	for (size_t i = 0; i < inmemory->objects_nr; i++)
+		free((char *) inmemory->objects[i].value.buf);
+	free(inmemory->objects);
+	free(inmemory->base.path);
+	free(inmemory);
+}
+
 struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 {
 	struct odb_source_inmemory *source;
@@ -8,5 +18,7 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 	CALLOC_ARRAY(source, 1);
 	odb_source_init(&source->base, odb, ODB_SOURCE_INMEMORY, "source", false);
 
+	source->base.free = odb_source_inmemory_free;
+
 	return source;
 }
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
index 95477bf36d..14dc06f7c3 100644
--- a/odb/source-inmemory.h
+++ b/odb/source-inmemory.h
@@ -3,7 +3,14 @@
 
 #include "odb/source.h"
 
-struct cached_object_entry;
+struct cached_object_entry {
+	struct object_id oid;
+	struct cached_object {
+		enum object_type type;
+		const void *buf;
+		unsigned long size;
+	} value;
+};
 
 /*
  * An inmemory source that you can write objects to that shall be made

-- 
2.53.0.1323.g189a785ab5.dirty

