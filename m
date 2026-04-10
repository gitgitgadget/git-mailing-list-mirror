Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B13F3BD25D
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 12:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823175; cv=none; b=n8TGiTZSYaLJO/FAmk5YqvgxqfHj1AhNhFb7xCHhLEPKpYNFejbuCIi7PEfWJD8+ot7zMouhuNOQAE+kebZHh8eUGcAQDWZlwVa+GFAnBD2ISgQzMpjrnGWOYHFPWPKYlxqLTI/HpOVl9vQyGPO/qDO4Gg+/V4HcI6qmADDcWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823175; c=relaxed/simple;
	bh=oK1j1/jhe6dkkdIuprFZfmNI7E2E+ssLE21Wn+CNfpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sTElmSfSGzq9KLv0d2+6gg8vpWnHsMA1Fq1NzaW39CAF9nZS2Qi4Rnub+cfiRpSt5pEGWMHlaN3hiMldWtsRBjpx7UderUKZVUT2xrCcVOONTB2m0CcshEHkotFtnSeclE+qGiG7gim2EjAp8UAsfU9h9aXE0IE9zq2SC4R5dFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F/4ExHdt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lm3YLuyq; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F/4ExHdt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lm3YLuyq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C2F77A00E8;
	Fri, 10 Apr 2026 08:12:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 10 Apr 2026 08:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775823173;
	 x=1775909573; bh=LQeoehAZzEFhMmYOpEJ6FQL6318EO9SXDUr/9/nI8Ww=; b=
	F/4ExHdtTenUza3R3AY/la+CeFTl64vueQ9YRDomCS0aIBXln0PIEE13Vjl48kou
	lJbZgurkFHZXOtGhmrcP7ivGmLUHAWLIe6bLZOrb4R/KeiFdRjMMWy+V0OwvpUeY
	8ypD2BDq1t0nzDeXgweLRDtSmQFmdwlXTVbtjY7ZOI3K+ic+Jn3rTHnqAUjg0SS3
	CU6kRni8y2ljrKU1DypobKU5klrt5iyY0gNnXxuZqjeZcrlk57MvRFVx8Em2otyf
	9WxX3H1JYDcdDO2nRDsx7jd86kI2b+gqm2ycG7L2bhdulZ8VoXnvnLeYyFjnacok
	sepj0GfLkZX7U+MhTtRBrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775823173; x=
	1775909573; bh=LQeoehAZzEFhMmYOpEJ6FQL6318EO9SXDUr/9/nI8Ww=; b=l
	m3YLuyq3WBtbXnYJu4hCejE2JV4a8N//aEwkxD/eZHLkuwTHC6PVpzvqFuTzPiJH
	BK6UatOKw3HBXXo/Aq6ZgVGCYKKRsao8CRLIwn+bHNXG54PJuhVMcgD/HEvGNDDU
	dyX63XVGZnQme8x9jleZEyYiFQ/UgBy4N9r8enNdt0w4auygAmcYAQLFeDyX7krF
	ykkdAmUABsBqsbiETEA6f7iilqXHNWN0Jq7QuXyxgnKt3TmecCVNPL5JvR9LCpm1
	xlZ2PoNBJAaBAIQjZL1sgwNfLOIOXuYfTtSsQdiYxMA6F3pmdY3zML1QWDYEEqh/
	JXqYlyQ3jTWLuCESomOcg==
X-ME-Sender: <xms:RenYabfWy8opUyfOFyIPgYO9l29NkcjcOpAdzSbO-N2srDS_KM6ZJw>
    <xme:RenYaYrNONApW7PquQP4Al-rilCszOOZEepJWexAUC5gj3cBAXepX5f1LptIN4CYI
    yrPhxXXAuYUcSkQnhj6CwYwNmutZDP83C2URy-bTA72IJNjP42HeKs>
X-ME-Received: <xmr:RenYaR6Ijwxmj8i5XDDcx5nC0P4nOykhjjrBzFUIlBqyMyQffNYrd0a2FwN4ogyiTDMNJ7lgDExv1RIUo5MmQM5a65oW6H2Wc6csHkEKuLUzjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvleefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslh
    gvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:RenYaWps2rULVnMFo6AjgbG7rsIPatqEnHFXdVgT9nys7MESz-_luA>
    <xmx:RenYabjggPPzcsLE0tKd9BKRZE7r5CKVurAYacXLmQ2gIszxjri-6Q>
    <xmx:RenYaYJ_9ju3D7ZTulcINomNM_4n-2Yi-fEpuhEpqO-0Bj37zgWA0Q>
    <xmx:RenYaTAgLrTzR0H245Xpfs5waGbzIgFWLg9_NCc0SLgWLEeJLNnV0A>
    <xmx:RenYaUoIkbxzKma3YEfUrtQMDbiNScsUEBbyZqhAvCh99kfR-zHAI11x>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 08:12:52 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 85a6869c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Apr 2026 12:12:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Apr 2026 14:12:32 +0200
Subject: [PATCH v3 02/17] odb/source-inmemory: implement `free()` callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-b4-pks-odb-source-inmemory-v3-2-22fd0fad58fe@pks.im>
References: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
In-Reply-To: <20260410-b4-pks-odb-source-inmemory-v3-0-22fd0fad58fe@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.1

Implement the `free()` callback function for the "in-memory" source.

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
index 60e1eead25..1d65825ed3 100644
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
index 15db068ef7..d1b05a3996 100644
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
  * An in-memory source that you can write objects to that shall be made

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

