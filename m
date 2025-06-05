Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54B920E031
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 06:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749106037; cv=none; b=LPFbxtw3G4Wr8Iu3pglErlz7fp5wqbNjjTjHXoFng95DP43nSbIY/ESC4Jgd7mEGtSjL2/69YqvpyKxNGLvuXjFTSv8Gnm9PRnZ/x7fozaLifNlmfYs2KEPEcE/67QhsZ3nEMA5e+7UZgF4bk60aPHPNE59/A6Y/TFSh8Wp8dow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749106037; c=relaxed/simple;
	bh=b1BiOQ6iSROGEcbFETYhfPbSoNMZJ4YZkAQ9zXNqcPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNmADDihp+HkhXDHQBLKhlGc3Yut7fSBnJU0kz5bFXqcMdJ6bMZfotcFGu/8jyGoW4ECVF8i2sUhUDzQ2lQ36Nq6gu13SC2E39QIYpq72BEOXMa7NWbxp0BiAqKxge0CuiXC4gIA3m1tpSA3zanL+6RD5TStcVnfCo3q9G8RNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iEuHf8Wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nhSYt4Bl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iEuHf8Wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhSYt4Bl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB40D25400E8;
	Thu,  5 Jun 2025 02:47:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 05 Jun 2025 02:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1749106034;
	 x=1749192434; bh=aVNT9Jl6vgqwmhYR22Tx8x0Wz1HBdldXqobe1uZJHl8=; b=
	iEuHf8Wfwho16XfL0800ck/eRqNWy4of9d54rtZj+YWKfecv69gJ2ClvdYRLaiBZ
	LRRYokaC54zXODP5HBn0944Wjd0UUCPAHXkP+fglE8KtGxFlPMiCd17A7Bh7n+oZ
	tpGxn2Ba6xdptvwXAiDwAdeS7H1wcvQSnzS+FNmsjS2fRElau3co/wOcAJsP0dgI
	GpegWvjRu50heWDlK8G8H+uFr9fzgIjV/pjzcRlWV37bvgSL6i3SXLMLdeYOS2xK
	RYLtTkcDVaTaZogmKlmervshaqhWnu/zbtXJgqe42n53/M3HpvdIT/odTul6dc1l
	LZ6bQX0Nw7efLD8C+Vjcug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749106034; x=
	1749192434; bh=aVNT9Jl6vgqwmhYR22Tx8x0Wz1HBdldXqobe1uZJHl8=; b=n
	hSYt4Bl48anT1kI9arx8G8b91ehKDy81EhK+2ZFH3o/8A2OrF/k+6/24Sb7U9OeC
	j2HKk6LBMzkDv85R5KETF+1EKXW4JtPHOHKzzZ/fhpBgntC+Nl6WQA7o7nPqVPDO
	bf+qRdu1o/L5DmZGoyPzmMdVOQ/uZ3SE854W2LSzWX3O3ToY9Uc+c8f1qIlIFpdN
	jpOcXmGqxQYV+25ht7GmNfcYWr9u+6nd2biRNkV7kv1EOor8k/n1zSojHwVpcRja
	kchGYhNMirJL/Ej+CnvKNsFoy8DOqHUTH4ve36kmlMydMGyNI8Bqldo8QW/bay39
	CnbFTfDH9QPl32Y+tEVVQ==
X-ME-Sender: <xms:cj1BaO7S4xFp5t6PiKBXg2InzmfJR7RichGcCQIGBtyViIO8gkQTiw>
    <xme:cj1BaH6_4GxBONlra4HmTXxfE0Lj3-L95fCfa-J9X2jebSOrwDTokVhrI0VnSr1w7
    ag3FCVLgsDMhjy5WA>
X-ME-Received: <xmr:cj1BaNcURQu3GmMQdvVQOITcK_tYOwERqr9PXQq_FHJH-z1Hy6cVrsP3YM7Nde5YJZfysGqa6yIPSzvI-X-X4sicGOHT47BMm8_CtJwuxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdefvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthho
    lhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
    dprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cj1BaLJ1OsrMBk0Op2pIMCfaQOpXR3vKrChzIk4x5okuGjyzjVhpqw>
    <xmx:cj1BaCLN_bjdJir0hJoB6qsmM0ubtgKTVH4ut9eF16GaUnMFDI9ZqA>
    <xmx:cj1BaMx_m-KRwbu3dE1vOVMGMqTlIdEJgeuUEYwJwN87chPseq0W9g>
    <xmx:cj1BaGJDtFutvW_VIN8GU5ncCdF_bMMpFlSFj1GM0NdLVSHfq-maVQ>
    <xmx:cj1BaBxyxsdE91VJ-5YPacNGtjBku7te011qX0C-MgDkZOWtp3ggd4bc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Jun 2025 02:47:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9bcd966 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 5 Jun 2025 06:47:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Jun 2025 08:47:06 +0200
Subject: [PATCH v5 16/17] odb: rename `pretend_object_file()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-pks-object-store-wo-the-repository-v5-16-779d1c28774b@pks.im>
References: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
In-Reply-To: <20250605-pks-object-store-wo-the-repository-v5-0-779d1c28774b@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Toon Claes <toon@iotcl.com>, Justin Tobler <jltobler@gmail.com>
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
index 4dccb9215d8..f6231a0556d 100644
--- a/odb.c
+++ b/odb.c
@@ -863,21 +863,21 @@ int odb_read_object_info(struct object_database *odb,
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
index 2532c490461..e4c51f8c38e 100644
--- a/odb.h
+++ b/odb.h
@@ -282,9 +282,9 @@ void *odb_read_object(struct object_database *odb,
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
2.50.0.rc1.591.g9c95f17f64.dirty

