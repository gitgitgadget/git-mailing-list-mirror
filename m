Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0E279780
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913149; cv=none; b=jsyrrgCifoN9DpyRyFZYsUWKeuSJQOR1pnWfgx+I518RkzWGt2wl/JYcO96hSXXAoi62JnxlZSZ3UbNWqG9OAXLgojYkTmu/dC2KStGh5Y3ZKgOp3+CtOqsivyv8fEb7QR+a16TsqWPUHbbhfHNjyvL/AEpTBw48ft0Q+iu7imQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913149; c=relaxed/simple;
	bh=XuERQFHzkcT3pzBvmRvKlZAT8xfGXFSwvq2wLh2uyys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SM7Yr63l/YnQnS6O7Aen9d7YYIot0/duwAwYZKusBZqeugUPtgoWt3QHrpGuliBafwPmtN0Y7BKcsHQGLFEmTESc7gzGVws75et5pyiXrd00plLT0iKfZsvHbz/P/OdlPSVj8rsQ19sXImOP4m7Wc//FCet8pYfEyOUOY0zLMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WyBzd6tp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oD2tDG3M; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WyBzd6tp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oD2tDG3M"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 138731140274;
	Tue, 29 Apr 2025 03:52:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 03:52:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913146;
	 x=1745999546; bh=YUOa+WHarGrwSvFXtBuSrOLBVD6rAlKDCnrV6/x1cWw=; b=
	WyBzd6tptDNfXgcugj9kmmb8gR8BNEqqS6Wdov78Yk0NkAcBPLguladhlknQpyde
	SW+IRpDGGK9JKydbXp937eKIqUPEUxi9gS+ZesyiBeuAzVhcf8sSgvFPNXkPO8XP
	uQOOedNUPrFpsqlkx9Mu1dwg8ufm3rAjnsXplrIt/6qTGUuITZonsjz1CeXAwrjN
	xrTsSyxp1JqUI7qzhXdHsyW1HGg0q/JDI4Hs+7D/PyVlstkdho/d/eqKszKOdjZu
	gqP+QVxY6DXF27AO6p0JhBskEZ9mIorCAQ9saX0g73M4NZRHYHwpY2wqLfRpiUIa
	Tl+iEnW+0ciHWaKoBRAsVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913146; x=
	1745999546; bh=YUOa+WHarGrwSvFXtBuSrOLBVD6rAlKDCnrV6/x1cWw=; b=o
	D2tDG3MkWhj8Q3il+tbt32XR2NUEzq8Agt2/oLR+qLgF5lJMCA5M9bfgAAZUQwwd
	UOZhk4xIFZ7+S/Sg49XozjX5KyQZ4gQY2GcMAl0qlN8LO6li7H2TEgGbmvTs2oU8
	2gS+7TaTnehpt3Hx++3zX/g6eK8fzCjf/F9Ahx1xJA60gs+qp4YEMzQmgr0BeQcZ
	sYCmKeN+xGRK55hWUp9VwpmDJfpTTjjFQtS1Rf+pWeTHsHSxAEYBSMVXqJqhHBip
	lWpd3zn8ab8Mz9NabEb1Ts95y4SpH+VI9ggXHE/NPuP/dpiNdNrBPLpUokUCoRO1
	JjYsZUqQ9ov2TsOXatu0w==
X-ME-Sender: <xms:OYUQaMyG5CH75nyiqinBzxxuWPZf8Gb3dsuNlSEGBb7I0yYyFIh39A>
    <xme:OYUQaATJbjPYT8nlv6F7iGcRapK1rrkL4-zP2o9pobEOwArf1ad1-9N0ivMa7OlfK
    xAXidp0vZLfByEkgA>
X-ME-Received: <xmr:OYUQaOWG1S1JWBhlPpWyU5rIlhfIMiRkrf9X2_OUGKPnVnGSnPkAU3VmOiyGqclxQFrXDvwwD3TWsLm_3hqXVEsVHCsxymARdBZRTULnUuo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:OYUQaKiZG5EQpB5Dkdl9DaF2eaz87PUR0FxjfSFAYn-KZ8I0ZSEKZw>
    <xmx:OYUQaOAg8SfxuobFa8QarM1UJ_vqzUoAbiZUgsnDSSt9m_iAjUjriA>
    <xmx:OYUQaLLbmrSx9yG--82ocbeTOVZWyJkHadTd91zlH0PD5IMcKqWmeQ>
    <xmx:OYUQaFAIB15IrBiQDCwIJqDtaaiKASzt1T4BkRDltXFwlbnLw6AXgg>
    <xmx:OoUQaL8hqtB3h2FsTojRjeBrFaBhN8zFIuY9xpWYAUVRW0khwIvfyE28>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7abe29c4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:16 +0200
Subject: [PATCH v3 2/7] object-store: drop `loose_object_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-2-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
2.49.0.967.g6a0df3ecc3.dirty

