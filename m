Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E361F4285
	for <git@vger.kernel.org>; Wed, 14 May 2025 05:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747199569; cv=none; b=lpkgCUE0URTNaDzr+GdQ76KiuXkPaYHgBQ4Gl+8+0fHzlNqnSyo06R+rA/8GNwjqcOU1y+2kDnqhHQNRviUCVuDWs6s00zUs1qY2sH8gujnBEFMRelJUAXorFhyF7Da7/jN7A0Arq5nNXE5Rt7ytKJZoztuOCEfUctXL8GofZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747199569; c=relaxed/simple;
	bh=7dUsjPc71wIAZs/2ipeW3ZnvK7Iuh2xTjpEgrQ1wu4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AM+mmYjiTpG/5RpMJ1TYoKtg9PKzx/RyBkOTDt8C6kpJuwUgVGOvJcpPTeaXTL64vPaVXOkBXH+pJ9wwXHnbVN3HEdmaYiIYOVlSJQCqUgBBWq7nDY4K3iXnwO4qhLkDQ1HP3+YvqxzkJtBTTbaEPblEuhLIKJFLvWBVbIauijo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tj7GBVdf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IQ/DKc1o; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tj7GBVdf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IQ/DKc1o"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 903821380216;
	Wed, 14 May 2025 01:12:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 May 2025 01:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1747199566;
	 x=1747285966; bh=xinu9J9WNeU54jXv59m+cZbTmwn6VW2HGz60HAVcAII=; b=
	Tj7GBVdfFVHw16Wlmz9q63v3PaYo5Pmn7T3NGKrPSGJlJd1IQtnktnEyeg7uXFJY
	L0Pt1xuESQ3m+axEljwhLuseOMT8HYSz+R3fOMISKvS3Fn32mugDiY2H7eTUU6Je
	zoLqSvn9wquwRT9MBY/QaCkj/Yb8Wr/OTDlA4Ak550oCxQOm7fpmkQDKj8A3OFTt
	wWpaNuLch30kyQM7C9csN9swLvYfhBjntHcNsSCkiR0EOJ+svWj15d5p2OIMwolc
	ojWyrCRAa50e5oedY0LPKqfmW5IQOK0qXdHXBGrxBLNBaqQUNuDvshjPs6ttIyGh
	3207Yo0pdvn8r0rzAxfhyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1747199566; x=
	1747285966; bh=xinu9J9WNeU54jXv59m+cZbTmwn6VW2HGz60HAVcAII=; b=I
	Q/DKc1oYDDI2T4uUkW/dUbcEIOALuP4wuvRFYmf3gZ7Q2knDKFztj/aRHFjB0wzo
	DyKyEVli9OG0VODILB/i48xXlWPlj3OLFxB83SDu0eDWmD+U9WBUtRc4tCwa/PLt
	SakzqDElz9MEMtcyutHMnvxtILSLMjOx0jIQuUIJWBOJIUDMSg/YRSHGQEGhK65d
	jWdD9hwCS40PxgXyKsnU6JAc+rR8ZGlOSoMzAjtCm0vD9ozIFEaRg6K43QfgsLM0
	OSwt9Ha8LvlBH4WIbzL976LFzX79U2BHtry0TtvJXiRQSmqEM9g9cVw1xx40HkW6
	CjARi9ZmvYrTcVguzp8tQ==
X-ME-Sender: <xms:TiYkaJixOHTb28Z4h4WAtyDqha5zynwqFDHwHw6NcldE74a057agwg>
    <xme:TiYkaOBJyDs2O-39mlL8qcCxsr1iw3rf4iXuFSU00FW8XgLmFTt0cx6SOVM_k1X8X
    txHHRMYe3CuHIlWkQ>
X-ME-Received: <xmr:TiYkaJEMh7jVmFxIutP1-sRJP02L6Sv0omjhPtCQPfGWl0gRiA98fRl2PLG_79AlxrYosVOac8HpPGaBjCLRb0IxLXcTc8X8tPA5VVpATF0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeiudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:TiYkaOQLWn-8EBdf81I6Pew_wJt5hwUAHIYiQiZBv4jV9UVy2ABu8g>
    <xmx:TiYkaGyseQo-4HlReEm5HQNfcGelOMnZalT6JyjKFoJCSuej3m_ZDQ>
    <xmx:TiYkaE4OLuM6YzJOHVNgnJf0H9O1nCYNG0s5DXrCd62ZwouAAqa4Mw>
    <xmx:TiYkaLy8-2HKj_lKd0ynqnbDb8unBK8IrquZ-2pluj9-L-IUnZPihg>
    <xmx:TiYkaM0TwPsZ9PdFj1ns_l4p2r_xAEU5ESUFGFqkC_9a4N1sxIMKMp2M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 May 2025 01:12:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22d8608e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 14 May 2025 05:12:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 14 May 2025 07:12:39 +0200
Subject: [PATCH v3 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-pks-object-store-wo-the-repository-v3-16-47df1d4ead22@pks.im>
References: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
In-Reply-To: <20250514-pks-object-store-wo-the-repository-v3-0-47df1d4ead22@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Rename `pretend_object_file()` to `odb_pretend_object()` to match other
functions related to the object database and our modern coding
guidelines.

No compatibility wrapper is introduces as the function is not used a lot
throughout our codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c |  3 ++-
 odb.c   | 18 +++++++++---------
 odb.h   |  6 +++---
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/blame.c b/blame.c
index 858d2d74df9..dce5c8d855c 100644
--- a/blame.c
+++ b/blame.c
@@ -277,7 +277,8 @@ static struct commit *fake_working_tree_commit(struct repository *r,
 	convert_to_git(r->index, path, buf.buf, buf.len, &buf, 0);
 	origin->file.ptr = buf.buf;
 	origin->file.size = buf.len;
-	pretend_object_file(the_repository, buf.buf, buf.len, OBJ_BLOB, &origin->blob_oid);
+	odb_pretend_object(the_repository->objects, buf.buf, buf.len,
+			   OBJ_BLOB, &origin->blob_oid);
 
 	/*
 	 * Read the current index, replace the path entry with
diff --git a/odb.c b/odb.c
index 787611c8f60..dfebeb4c8c0 100644
--- a/odb.c
+++ b/odb.c
@@ -872,21 +872,21 @@ int odb_read_object_info(struct object_database *odb,
 	return type;
 }
 
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid)
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid)
 {
 	struct cached_object_entry *co;
 	char *co_buf;
 
-	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (odb_has_object(repo->objects, oid, 0) ||
-	    find_cached_object(repo->objects, oid))
+	hash_object_file(odb->repo->hash_algo, buf, len, type, oid);
+	if (odb_has_object(odb, oid, 0) ||
+	    find_cached_object(odb, oid))
 		return 0;
 
-	ALLOC_GROW(repo->objects->cached_objects,
-		   repo->objects->cached_object_nr + 1, repo->objects->cached_object_alloc);
-	co = &repo->objects->cached_objects[repo->objects->cached_object_nr++];
+	ALLOC_GROW(odb->cached_objects,
+		   odb->cached_object_nr + 1, odb->cached_object_alloc);
+	co = &odb->cached_objects[odb->cached_object_nr++];
 	co->value.size = len;
 	co->value.type = type;
 	co_buf = xmalloc(len);
diff --git a/odb.h b/odb.h
index 3a96de56bd6..18de1f3f57c 100644
--- a/odb.h
+++ b/odb.h
@@ -274,9 +274,9 @@ void *odb_read_object(struct object_database *odb,
  * object in persistent storage before writing any other new objects
  * that reference it.
  */
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid);
+int odb_pretend_object(struct object_database *odb,
+		       void *buf, unsigned long len, enum object_type type,
+		       struct object_id *oid);
 
 struct object_info {
 	/* Request */

-- 
2.49.0.1141.g47af616452.dirty

