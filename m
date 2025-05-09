Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56551296FAA
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799954; cv=none; b=fTn1rL3HkTyJgRCVl6O3b0SLu4GaO0P9Qy4gX9Fp4yhZ4cokeAdQ2H+F6PvmpGuIdUEPoxxUs22fjeUrD8mFj+bYodpAXg2xNiqm5uqDlKc/Zc6gHA/u8wVbgcVc11PNnffUA10BkNK3mvCiqcigko8LtGH8xCArZn5fi/aPPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799954; c=relaxed/simple;
	bh=4myBycOk6ubuolsqY6XaY2N4l+Rdp2c40t3O13NL2L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sg/lret2yjS6CY+ZBfNYI8wVU1XGs5Gd4+SMJ4VD9DwCYx0TK6wGznMpuwvM+theLJ06SRfQ/L5BpuE72bWihyB2BmllzEfyu/x3uvxET4vhARm5v8Q5kbVknIEms2perOIQj6QRrSYLW1PCT8dw/OxFXaFeIdDeUcOBdfqgmFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GRpjo4U5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIdxha+R; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GRpjo4U5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIdxha+R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F1B925400CB;
	Fri,  9 May 2025 10:12:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799951;
	 x=1746886351; bh=CuOEz7hO1fLwqxx7HieG7mIPBCClFsODLrzf63M49Ik=; b=
	GRpjo4U5WP9ugOypCdwHxIUhJ4Ecy3GVpQaKCGstCsLY5obZcIj7pgO6w8GnAcyB
	NqZ9ywMK27PuPCFT7GonxrD3p6WTZj+Umnzg6/OfUWHW6RSJq6PxgYMakFV2mi+Z
	7DhFmHCMnA24tb3H1npYmE7W48IdVwq2SFNUUw3HGDbLQ8Im90ZGYeNMpV1UJtf9
	039o7M245z6uJ3Bczc6EngrJGLvkXIJoQWJ0FkOek19L2SIC2BivicmjOlOFXDT0
	NmRS0HbHOJ2U+L0bQd0fqE9x39Z/z8FHQ/qWNSEn2f5N6mFot5+oybCifyYNQnr3
	VwcyMZA3tgPGAF0yEOCpFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799951; x=
	1746886351; bh=CuOEz7hO1fLwqxx7HieG7mIPBCClFsODLrzf63M49Ik=; b=A
	Idxha+RQBhcd2XxXjIL+5gvjjTr/9qZyJNicNX3IKarf4vuEfUSUVOCGw+SKGjM3
	mK9v16hroBVubJILiOMHx0Xu8d0wGlobygitOabBixsMZx9tOQM28SFvjg6smuUQ
	cEBHSDsbeSRUseBlJA8wvNzzFEf7kjZ5ApY8NyMzb+hJ+Krhvex6ewONvEZ/3iZt
	MRTactYN4JTjinLrF4sHQHVCNt4f+CbbBw3zzC8ubVUF2knwIkHklWL+ykRHyUCF
	+O/Jp/MTVx0BRtkN0RmcMnGh03STzEIhrI8NhXSL7r6B9AI8ZoLl1lMqFtjroZ+n
	sngIgrEcSSAZbH9L3uQKQ==
X-ME-Sender: <xms:Tw0eaDIpNmd0xGr7YXW6YofPv723GsRURIumWs54SpuDDuruirnpdg>
    <xme:Tw0eaHKSIDlhMqWZxFI0p6pSVdoLqv_hIyaDJKfpXo8HVqCxLr2iR_yYS04lmOXCk
    6Z0bwGN8jFivcKLCA>
X-ME-Received: <xmr:Tw0eaLse6Wr0pM-OceHBKLD_-rnYabsFhSClZito-biKjbE1v-mwPEiQUFPF4r2T76ZpjurU_3-B2nK7KqBxO5pJg4T_EMS3mV-M97BGDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Tw0eaMaDJbr--u6YAciiw8G3XIJ7gZYCAfG9sbHdFS3vx1D-KMcAyw>
    <xmx:Tw0eaKbDKGEw_SGW5hiEFbP480GTmLDbva3hrbTvmlJ0Qzh0_HjOsQ>
    <xmx:Tw0eaAAOEdCToiIpcGv8YHPVODP8EyklBaMOSJf1ipgFCA6LKoB74w>
    <xmx:Tw0eaIaHdETK-VhcenafzebBxgIY0HCMWZQ_FJQbXs5e34vO7rPb2w>
    <xmx:Tw0eaK3AvnA5TNHHvTRekZPKoCpC5R08lR54hi8LijhiUYwZ59rmie49>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b893dc8f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:16 +0200
Subject: [PATCH v2 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-16-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 3d38f1ebe60..911448f4d42 100644
--- a/odb.h
+++ b/odb.h
@@ -271,9 +271,9 @@ void *odb_read_object(struct object_database *odb,
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
2.49.0.1077.gc0e912fd4c.dirty

