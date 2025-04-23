Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265D542A92
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394510; cv=none; b=RXuMNAAVORifn/vfcYADR7ggsGZdedi44nuTtdvA+v/XntGDBz6tirxvivbFJvY/fed91HGBa51SGRl10fPOJi71TfQrgw/vWSLYevKmQUnJ9iYu2kujKiAyKOzlMTLRfedh3K/SH26PYiLs7AU5M/NLAdSlLGcvGd/xNDrBt2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394510; c=relaxed/simple;
	bh=IhV1Grui/mHz6B1D8U4zKKMicyNE3hvL7DguvuNBakM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sBnoN0OJCh/g/4R2uJwEmIeC3QTOP56M9Nt40MHVWLK4ZLk03Z/Tjde1Tf7FYopQvKGeqiXAtPlu8HCZaPYa9jrcFw5A6Dz5XjZ1aGwnDlb/99kWckZqo7bbtYTKnfsybd4FnOWWq5MTWgEwSg8vw33NRPCilkU8IxDQcTpzmfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X9FyTxdT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/p1VXvD; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X9FyTxdT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/p1VXvD"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 418B211400D7
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 23 Apr 2025 03:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394507;
	 x=1745480907; bh=PD9xfezrOKBeAVrGxucP7iGa5vU784CSKaroCsT4RLw=; b=
	X9FyTxdT2riC1yGAN5pJcb8yw4iaImiHimObu/5w6ActOZa9my2riJa9MKCE8Iu4
	dx6NMkqxrXLbPS6jYs9uNN90QKzPpw10kCJbcZY5uFZ5RHVsRtH4hSYhtjwm8xa0
	JDZNpU2t1vDNpwnrxeefo1qQ7Utd1Ufo2NwCliyXJ2rT7suxR84wFFrhF/GUKRlf
	K4sTtqSlUwiZvxK6luUvrHiwclbzYdefnZtwEyBCzPmU8VkaoK82ILUzQZ/qZzi8
	a9u/xx4+us9e/oS8vY6065pIlfdZhyoCS+Ait/asEcV4pkHGV14q/nkOXqAYfxYd
	9MmCJJyGMlJzhtz/mktQpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394507; x=
	1745480907; bh=PD9xfezrOKBeAVrGxucP7iGa5vU784CSKaroCsT4RLw=; b=B
	/p1VXvDdFl6FrxdCpE4NFsf1VvQx5DfOADK19Bi2q1lMFAgO1p2QPJpCV8kwba+T
	AI4QykQJqxeW+vzjLmdPXSf9BXGsWLyjjAaKY/8Vr/XkQTQexEgAyi5NRTMl44nF
	dz+9J7jb8SUclHeg6E/LWlPKU/z8AQIezun8QnokYsnJ/j2QoAycCbhDMxiXWoWv
	w6I6Lzjs7SbDyz6xqiZpk0G3pw8I4t2jGw6vYPVLB5U3y94GHzHZURW4LMeudV3/
	V28T9yPUHjaN+VPfIZkhZDVAdB6H8VAgerLvmXZ4CnCWPfIBQp+YJRrwV0PY8Bgx
	4S8LBDYqCKnSvqWuEwLUg==
X-ME-Sender: <xms:S5sIaNOws8pjUYxmXFKUucK0Y50TKKRYhGeD_SKpxmfXFhVXyveJ9Q>
    <xme:S5sIaP_32QN3X-Llf18VM_lhH_9F4b3NowwRZDGOe6noYwhUYtU8w_4K7ueCJ37P-
    bPdyukK__rwDDCKZg>
X-ME-Received: <xmr:S5sIaMQJEjFrdSMe7gjURUHAy7-EUvc4YXH_nbDhxVpzcIBB1TOlcOE-KUM__NAwwD4yk8CRuVeikiXqtcv3JCifwMoLtX60X02Y8y2_HQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S5sIaJusB1ejB2kjWhPBZIY9H5ippQESyrxAqGhFT3CftvEkM9EADQ>
    <xmx:S5sIaFeEf7jChZG-BRybjbBrxwvBilRfXkpyrFohRh06e5LSVDFqhQ>
    <xmx:S5sIaF0fTBIUjSIEG3cbAjv0URWhLNcWM4zglj7cRitYKS8eXW843w>
    <xmx:S5sIaB968DBGMidevFmoPH5RYBFnrOjVozVWXV1jItKlZ3ih3Wz0zA>
    <xmx:S5sIaB4qnZtnjiBLwp-KAqmci2ys5TY9pwcQi-66YZIAz1vO9_iHFiUv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 92f42b6d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:12 +0200
Subject: [PATCH 02/13] object-store: drop `loose_object_path()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-2-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
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

