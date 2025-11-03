Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4402C15BC
	for <git@vger.kernel.org>; Mon,  3 Nov 2025 07:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155763; cv=none; b=KyhNt1Bjrh8YVujJwzBv1Xgtioum8KGeOGZWC3mVqgWrws9sJgUOZwyV9u5gW/cu9uD7TQwXU0Lrjrxvv1JChPggZafDewIfKqpEb55Ep7vJyj+164h2qu82z/CYIek4Erm3z0dBfU2aOvqZEnkUmtJcd/LBf6OIzofvHEOQkKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155763; c=relaxed/simple;
	bh=83kDE8doZXTfd3aftDi4mstUp/XvCYHm1qs9X2rb3fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DdVyS1Gutyc99Na+T6z1epfwJM2vMbJ45c2Ba1+NGtnbprMUzkBDAkZ57wXSfcOVJwrSlK9I9JP7Hyr2nk098vAOsMpg7W0Wr7eWK/guWWLDz5u+2KrTzXzf3addPU/mqmXlaC5t73uGCZyuTJHMPiH7muh328WhPDugyyMHFVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iE9jg5Ol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x2URfoaI; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iE9jg5Ol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x2URfoaI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4E78E1D0013B;
	Mon,  3 Nov 2025 02:42:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 02:42:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1762155761;
	 x=1762242161; bh=dsgsE9/9N9+bbs9kfsQtWkQ76lYTEW4IBy7lT+z9KJE=; b=
	iE9jg5OlZ6puC2tsB5x5CSCc4b+3osi65HBSIq5Sv5YGseld6eh9CB8tZiNbTcms
	DuIYn4kVlp4YhgqPQd7ipThw5VjDBXmFQM5kpkDwBdzszwxnK7hLjddTP8wYMID8
	RnW8qFUcpmFMd5EeiZ2pNBhR1GT4nfd4qdgPVVsFU5oEY32Q2u5Mn59/gp3B6/pa
	h/ZJzCoonQqnzAUoMPIWX47Pn7esdcnIMnc7Qrd/mGmNQK/+1HTPlzeHFjAUybSY
	B30fY4bUln4rCTZnMeJf+kFdcx/yKs1+eV63CSs35TFgHThfRVxE0Dz0vxG/+6N+
	56950rB7Sm6byHcWwf4BXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762155761; x=
	1762242161; bh=dsgsE9/9N9+bbs9kfsQtWkQ76lYTEW4IBy7lT+z9KJE=; b=x
	2URfoaIm+2tornV/K684vpA3h4p74jH/wsoJtVRzohfOaGNYouxjwCsxw4J8YBPO
	DWmU6QCdwVt2PHeVKe65RyFNH8kELxrL1cpKSdBZxUMQpLoyHtYNuaEkhCq0xgoC
	T9RlArMXu6Jf/j3f2qMylAjFIGFmVFQPkZcai+zZbZynOlCKIYSEERIb8MHkj7IG
	y16mWprvjreNU6rjZZi7X7y3FsU6+F45xbQbxP44OWYvmUPNNke6J+8yMORR97sV
	YCkypG7UcpWHIebfn0ttB2BdlS0/OHkEibc2EFyAkj7izE4JlHfelmaiA5PCiMJg
	pPod3bLrhpj3IgT3u6U3g==
X-ME-Sender: <xms:8VwIafAZOt7lugsED7VCRVq_QAoVJ3_tCvLZ3NCrDPINe2PEzhjCuQ>
    <xme:8VwIac-iHI193DZrZf4x1yMKz5FJTJ8PiBM6ckLPHdAP9MacidtBmSaPXPdrhe5Lz
    tyTTCbja-ZiXQTQu5kKKioeArgFOxDnPlN7uOllgPByTeayhPTdBg>
X-ME-Received: <xmr:8VwIaX9UyZx1pvRotEwdGUi6oUereh4Y313peTC3V6gO1s8Zn0vfEmrBvF6hwDBs1jatRvQNJxBGaNlWHycnhDBfk5XnFZ_7zv_cyZ39BcT->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:8VwIabeXgZOVDfp0QlkNiphPQD5f0tPKMB-jx80QRGuixpIUHoitFw>
    <xmx:8VwIaYF-kTXq_CsevrS-3we-8eB3uQcpAw9hU8UhGKpuqugpvmYoQw>
    <xmx:8VwIaRdEGA71O_4iz_e3RTS1oK-EEznXwplYN2N9ir6luXYNpux04w>
    <xmx:8VwIaaGxiPJy4lYAnhHdLStFjeM0pq9EqSaouW129xLAx09JJgAlIA>
    <xmx:8VwIac9FNYL85w0YprdJVpy_sWw8w4-MkudeNT_dMM-iPrwckXOodFDf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 02:42:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1e025579 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 3 Nov 2025 07:42:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Nov 2025 08:42:05 +0100
Subject: [PATCH v3 10/13] object-file: rename `has_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-b4-pks-odb-loose-backend-v3-10-6a61ea977393@pks.im>
References: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
In-Reply-To: <20251103-b4-pks-odb-loose-backend-v3-0-6a61ea977393@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Rename `has_loose_object()` to `odb_source_loose_has_object()` so that
it becomes clear that this is tied to a specific loose object source.
This matches our modern naming schema for functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c |  4 ++--
 object-file.c          |  6 +++---
 object-file.h          | 16 ++++++++--------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5bdc44fb2de..2a448ab3585 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1716,7 +1716,7 @@ static int want_object_in_pack_mtime(const struct object_id *oid,
 		 */
 		struct odb_source *source = the_repository->objects->sources->next;
 		for (; source; source = source->next)
-			if (has_loose_object(source, oid))
+			if (odb_source_loose_has_object(source, oid))
 				return 0;
 	}
 
@@ -3980,7 +3980,7 @@ static void add_cruft_object_entry(const struct object_id *oid, enum object_type
 			int found = 0;
 
 			for (; !found && source; source = source->next)
-				if (has_loose_object(source, oid))
+				if (odb_source_loose_has_object(source, oid))
 					found = 1;
 
 			/*
diff --git a/object-file.c b/object-file.c
index 6d6e9a5a2ad..79e7ab8d2e3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -99,8 +99,8 @@ static int check_and_freshen_source(struct odb_source *source,
 	return check_and_freshen_file(path.buf, freshen);
 }
 
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid)
+int odb_source_loose_has_object(struct odb_source *source,
+				const struct object_id *oid)
 {
 	return check_and_freshen_source(source, oid, 0);
 }
@@ -1161,7 +1161,7 @@ int force_object_loose(struct odb_source *source,
 	int ret;
 
 	for (struct odb_source *s = source->odb->sources; s; s = s->next)
-		if (has_loose_object(s, oid))
+		if (odb_source_loose_has_object(s, oid))
 			return 0;
 
 	oi.typep = &type;
diff --git a/object-file.h b/object-file.h
index ca13d3d64e7..065a44bb8a0 100644
--- a/object-file.h
+++ b/object-file.h
@@ -51,6 +51,14 @@ void *odb_source_loose_map_object(struct odb_source *source,
 				  const struct object_id *oid,
 				  unsigned long *size);
 
+/*
+ * Return true iff an object database source has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+int odb_source_loose_has_object(struct odb_source *source,
+				const struct object_id *oid);
+
 /*
  * Populate and return the loose object cache array corresponding to the
  * given object ID.
@@ -66,14 +74,6 @@ const char *odb_loose_path(struct odb_source *source,
 			   struct strbuf *buf,
 			   const struct object_id *oid);
 
-/*
- * Return true iff an object database source has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int has_loose_object(struct odb_source *source,
-		     const struct object_id *oid);
-
 /*
  * Iterate over the files in the loose-object parts of the object
  * directory "path", triggering the following callbacks:

-- 
2.51.2.1041.gc1ab5b90ca.dirty

