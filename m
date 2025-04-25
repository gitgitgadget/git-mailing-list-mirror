Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A932343AF
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564943; cv=none; b=MH1LEEBIDC6jvpn3vNqr8EdcSewwO6zUd8UfeCnsswCstEHKIezk+3Un/XmWNBxD2UM/eQ71KrtZ/rzz8tVbvWEsYGEp0aJxPf5xUm8nIXNbbSxa7Oc0FLDkkhNukVH1+nBvsrOQz1xtxLWTZSYgBaXlOA5P05D+veszobGFuN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564943; c=relaxed/simple;
	bh=IhV1Grui/mHz6B1D8U4zKKMicyNE3hvL7DguvuNBakM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m1+OMUskB0F1Fufxnu0PL0+4n+Uyh7ONYSJmDg0VigeLeHzVS8o5g4tVS0KGNLbi9vwJqfPZFWcbKNF/kCTJvX53gTWZwM8Hol6n6c5MYY8e+64dvJJHsGdZ6UOD2guJDwydmS7AeJc8V0kYSG0V/QZkTClDWDpEF9A62rQWAoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sy7WOVrF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DvjLJ/iI; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sy7WOVrF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DvjLJ/iI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E039138020A;
	Fri, 25 Apr 2025 03:09:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 25 Apr 2025 03:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745564940;
	 x=1745651340; bh=PD9xfezrOKBeAVrGxucP7iGa5vU784CSKaroCsT4RLw=; b=
	Sy7WOVrFmdIPY53I+bQdkoGjDyaz4guLvR1QRGihZE3AXPPXrsupm1iNI4pUV9dJ
	VhU7uuHRBMveinSotCTH60TYERavmnw8imV3N7qRYLOiZnNX5mgRT2Ap5tbvz0o+
	yoWnnZyO6o9mjP5c52rNacj8Bry/vUAFLJGKGfO0EJ+lTuxdzkcz1uJRgaZlKbSR
	iuClqKR0Ms3kkFzHmaNto95Vcnv3ZGaTFma61dv+iHzb7hnrgHRe8q8CbQjLwrKs
	W5iQMq0SRYPuqMRk7pqbG+zV74j3WxwXSsiqmVqhEk87nMV/GuRQR0rMIEi1hwIH
	pmSc6zmE3drDajw78Co9sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745564940; x=
	1745651340; bh=PD9xfezrOKBeAVrGxucP7iGa5vU784CSKaroCsT4RLw=; b=D
	vjLJ/iINOrfxR5Y1ywxbQZDCpVmztcqSOAiRIcRO1jVOUk6uSUe7znR78CznRCWn
	cSUt8SGIqzMqZk4ylhzBIGHVZG0kQO08F2KVidIN3+tqyON0LRc8mL1rB1QSzMiK
	szbaFst5yW0sab5ygBBNcdQQz7ilbPZjYsxCTZlFToIz37WjRUi+QBTTIIIuubXX
	sD0sY2Z4qZ+z5g+xbaUjDJhLT5iVRuZRVUFRBvZQ6oL/CGEfcDgdJgtt4ebc7R6g
	nQ5ix/sPYANfUfbQniWxOgIh9kPZcEz31Rc47QMsIpjcIuEJis4b7xTXIqTv3USE
	8PPi/5gp8N3vpkW7R4rrQ==
X-ME-Sender: <xms:CzULaMcGzo0wKu5AfMmqjMv7TEv6sZ8fydNQJYt642FXaCc0DT3s3w>
    <xme:CzULaOPIOZReBfITuQHaEs8nHpoGqBfWB000mESJDoe3QeKDxocyBQPOYQAy0Y7nF
    0cMevoEHzUPso7V3g>
X-ME-Received: <xmr:CzULaNjSugmgjLzLJw1QUo5EmuLusk5TyYegP0vqHPaTDonLPBfCqXrPFpr1C-QeYKYZ_S675qZURNd6DHQz-wjwbwp1nntYTN3KUX70>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:DDULaB9C_fFCECGO838HP-hVSRs7Omyujle1a3VjEEamc99T4B8LiA>
    <xmx:DDULaIvFFKXdvd20PI0rieHVIeBg9G1hP2d3j92KnHONxWJl9MGXAA>
    <xmx:DDULaIGaXRqcfbmFYz-eWsvJOACKvqOdUzgsImP9m3nr3aeQ50be9A>
    <xmx:DDULaHNANBLZ63OOeOlMSyVi3sdUfGQS7Av2BeLcqS-q7aMacDfzkg>
    <xmx:DDULaAKx3NWbJbe39exqGFnRhwueRdMcTX8i2MfErJZKEQGEAkr6SuAb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Apr 2025 03:08:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e93ed69c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 25 Apr 2025 07:08:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:08:53 +0200
Subject: [PATCH v2 02/13] object-store: drop `loose_object_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-object-store-cleanups-v2-2-63f1695b7700@pks.im>
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
In-Reply-To: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The function `loose_object_path()` is a trivial wrapper around
`odb_loose_path()`, with the only exception that it always uses the
primary object database of the given repository. This doesn't really add
a ton of value though, so let's drop the function and inline it at every
callsite.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-walker.c  | 3 ++-
 http.c         | 4 ++--
 object-file.c  | 4 ++--
 object-file.h  | 4 ++++
 object-store.c | 6 ------
 object-store.h | 7 -------
 6 files changed, 10 insertions(+), 18 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 882cae19c24..95458e2f638 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -9,6 +9,7 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store.h"
 
 struct alt_base {
@@ -540,7 +541,7 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 		ret = error("File %s has bad hash", hex);
 	} else if (req->rename < 0) {
 		struct strbuf buf = STRBUF_INIT;
-		loose_object_path(the_repository, &buf, &req->oid);
+		odb_loose_path(the_repository->objects->odb, &buf, &req->oid);
 		ret = error("unable to write sha1 filename %s", buf.buf);
 		strbuf_release(&buf);
 	}
diff --git a/http.c b/http.c
index 0c411380425..3c029cf8947 100644
--- a/http.c
+++ b/http.c
@@ -2662,7 +2662,7 @@ struct http_object_request *new_http_object_request(const char *base_url,
 	oidcpy(&freq->oid, oid);
 	freq->localfile = -1;
 
-	loose_object_path(the_repository, &filename, oid);
+	odb_loose_path(the_repository->objects->odb, &filename, oid);
 	strbuf_addf(&freq->tmpfile, "%s.temp", filename.buf);
 
 	strbuf_addf(&prevfile, "%s.prev", filename.buf);
@@ -2814,7 +2814,7 @@ int finish_http_object_request(struct http_object_request *freq)
 		unlink_or_warn(freq->tmpfile.buf);
 		return -1;
 	}
-	loose_object_path(the_repository, &filename, &freq->oid);
+	odb_loose_path(the_repository->objects->odb, &filename, &freq->oid);
 	freq->rename = finalize_object_file(freq->tmpfile.buf, filename.buf);
 	strbuf_release(&filename);
 
diff --git a/object-file.c b/object-file.c
index 9cc3a24a40d..dc56a4766df 100644
--- a/object-file.c
+++ b/object-file.c
@@ -932,7 +932,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	if (batch_fsync_enabled(FSYNC_COMPONENT_LOOSE_OBJECT))
 		prepare_loose_object_bulk_checkin();
 
-	loose_object_path(the_repository, &filename, oid);
+	odb_loose_path(the_repository->objects->odb, &filename, oid);
 
 	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
 				       &stream, compressed, sizeof(compressed),
@@ -1079,7 +1079,7 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 		goto cleanup;
 	}
 
-	loose_object_path(the_repository, &filename, oid);
+	odb_loose_path(the_repository->objects->odb, &filename, oid);
 
 	/* We finally know the object path, and create the missing dir. */
 	dirlen = directory_size(filename.buf);
diff --git a/object-file.h b/object-file.h
index c002fbe2345..0a7b6b9f9d9 100644
--- a/object-file.h
+++ b/object-file.h
@@ -25,6 +25,10 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 
 struct object_directory;
 
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified oid.
+ */
 const char *odb_loose_path(struct object_directory *odb,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
diff --git a/object-store.c b/object-store.c
index 6ab50d25d3e..e5cfb8c0079 100644
--- a/object-store.c
+++ b/object-store.c
@@ -96,12 +96,6 @@ int odb_pack_keep(const char *name)
 	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
 }
 
-const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const struct object_id *oid)
-{
-	return odb_loose_path(r->objects->odb, buf, oid);
-}
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
diff --git a/object-store.h b/object-store.h
index e04469a85fb..5668de62d01 100644
--- a/object-store.h
+++ b/object-store.h
@@ -196,13 +196,6 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
  */
 int odb_pack_keep(const char *name);
 
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified oid.
- */
-const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const struct object_id *oid);
-
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 

-- 
2.49.0.901.g37484f566f.dirty

