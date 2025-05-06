Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0D27990C
	for <git@vger.kernel.org>; Tue,  6 May 2025 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746529776; cv=none; b=NBXk6yJaLxWwtgnFQYfNqnUfCDn/JJFUk6yhcc8PjGLELUH7UZ/dVYMBydOjWjFJVcapjNbV49IkF+xm+AW4s1Q7SIdtLohbAXHzrnTReHWHj7vYm1+HaWa4V0IKqgIcLg62xCd3gYCqy9bNy53+rqaUECMY8ZFBSBd+JipRyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746529776; c=relaxed/simple;
	bh=i/OeBqlNCxAsGFrL4+wJYI2Bi1QOLUkFmMuLvvHh4lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ic14WCYykHABjKiKw7HlmLP78qwpGIvL7qWITKOThZfETSEOu25Ar8IukTnL+KV+fsgrKmP7OCoNimaiUTGWaA0V1S9gI0Xw0DirRozagBeiLhlf/KtJ4SGH5L20LvpZSC46kKWOgbkfxXyMBS/4D6hmX4Ct0A4mUZB5SPQZfK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YVHug1Wm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DTB/nbDT; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YVHug1Wm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DTB/nbDT"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B3361381491
	for <git@vger.kernel.org>; Tue,  6 May 2025 07:09:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 06 May 2025 07:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746529773;
	 x=1746616173; bh=JYuOe51Ag5usUPPWhd/ZsMU7LDBlL6s+u9VBv3xeEBQ=; b=
	YVHug1WmyNCY7Wzb67SQGyNKxokrmp5xNr1TJXXJQj6OrpikkPJkOeD6ND3SgpWx
	uFlDuFkRvdorj7y0QEpEi98NSad1sN1yuzOWMs7kqFv08N4ymT2+pzdrGKwzFT2A
	XUwf2oC71k37wWj3X3/cpGrZZcFa3fOB7jygzAp+K9BPWoYbfejDXY5UVgbBEBjD
	hnI8cUVA0uTVO1sPlQKQEijAObcvMks+27tytntP6Ah62vb5Vo/nXZWekArh5Y3l
	xUsOKIjRRwZArjZKck957To0vsMOBI6ZHxKr54mZEDzqa+wviSBILlO1FOBfpnOZ
	3Ro37YIIymPHLuPOA/3Gxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746529773; x=
	1746616173; bh=JYuOe51Ag5usUPPWhd/ZsMU7LDBlL6s+u9VBv3xeEBQ=; b=D
	TB/nbDTi6/RWC5oS5ARszsIb8ZlOs7VUgl0KS9G/eBpvW6wxIsjhBZomo7FAmvbn
	jYQ9/Q0x/210Ju5+UCLcF+WzDMXpMF/0bgLiaSs+ry5ouZd63+TlX+Yy03ot2zoW
	YQ5OZhIXTWvlgn6yoPi2TLHDdk9QfFFI8wREHYOEg3Kqy3T1KBP4ll1O3iDXMIMu
	wgnGiXDeDZWmC5yLVlvjfg60QbJU5fi6ANHYuTgeSbcQqs0lqRfkPfU15Iww6Dlt
	7JsyGCsY617fipnMXIKcDoMlpIZakFMCNyN0zJKkhZGLcnxNuhir60nOxXZj5CJy
	GbFc8Fm4M8SjquVZ2YGiw==
X-ME-Sender: <xms:7O0ZaH3n5sFhXa0RpfKJAbYtqB17n4eZddandHOd37iDNFrARq7n3w>
    <xme:7O0ZaGH6fBii2W8CgeOMiziwTri_kAnRhaXXkFYDsmskLr8VFLGcR_82KnaquShqc
    y4goqsKrA8MEm5row>
X-ME-Received: <xmr:7O0ZaH4Z9pwDgREO6tAaG3nyjItM86aBew6Torlot1nXOPs-yMtnS1eLt1nZxOPeCMl221rGQGhqKXInDI9CQkBgafDSmWYQ2iWuiwpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:7e0ZaM16u_jhqd8cn7y0FA0PpJRaK6MFqAS_Jm9QYRO032QcMO0-0g>
    <xmx:7e0ZaKE7Z4_FSvDaYtRjgw2H-LOVy60vC43AGXuQzdOdXlZxY74b8A>
    <xmx:7e0ZaN-l2eXzm-kWGEaL-5w0B2PPsP-2MaEk8y8sPVDXhx5MryxFPQ>
    <xmx:7e0ZaHmL4ybidRXjcsEPouhq5n9VJokiNKeM3cF3kejdQn6ehtTtCA>
    <xmx:7e0ZaNDoiEAOfDr9gutnDq6ydhc2-jh_XVDSxGBYi_fliLO7YC_fBXWx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 6 May 2025 07:09:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2416a8b2 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 6 May 2025 11:09:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 06 May 2025 13:09:29 +0200
Subject: [PATCH 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250506-pks-object-store-wo-the-repository-v1-16-c05b82e7b126@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
To: git@vger.kernel.org
Cc: 
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
index e7c83d96361..3931020fa80 100644
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
index fd4f1c55b6d..b9aefca639c 100644
--- a/odb.h
+++ b/odb.h
@@ -269,9 +269,9 @@ void *odb_read_object(struct object_database *odb,
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
2.49.0.1045.g170613ef41.dirty

