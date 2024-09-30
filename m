Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD944175D4C
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683713; cv=none; b=raEpUSC6qlSNgNA85KOtza5nkYHOKc+XtUQlwUVj0fcNzACDH55L6C8cu7uJoXf9DylgmXiJwCcBijgLSXoPDnfmLAbZsgZn2kjWTvmRLIk/F+vMyqc2iC4BwigWjt+U1GLR9cQrYY33WPKvf5iyaFsJTELysPcOP4MlT2pFOoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683713; c=relaxed/simple;
	bh=pzlUGWXRBnj9K2LItjlbb6SVrr54XoYLIBye6yyGV3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9GbdBF0zAaPNPCB3k12bAI4ttXce3xFXBpe19fZhWiNQ8p5s6HVsTq2KhDr5V/R3Z+x8mplaJwpruDhkunfp9O9aWQEtnII8sOivhYZi4/Udvg+gyQ6wygbZtB/OTgpMcnTpCuDrYW+e5NZU/5BhpU2AGNvka6N7seGEkwrkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RbfEhcu6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JVt1JAGB; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RbfEhcu6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JVt1JAGB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 2A26D1380446;
	Mon, 30 Sep 2024 04:08:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Sep 2024 04:08:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683711; x=1727770111; bh=VEgBxnzLLI
	wccok7L50eCkc24UTwhrvqf+uFPzglnY8=; b=RbfEhcu6hOznfw3ZUvJwniryjL
	zjGwPYVTsUVVaCAbES9o6FZxuXqePbZd4sKB9xHieoWCXEmNtgJPvRl5IREzBycy
	RVxg/z2cWhc5iqB6TPQZRoTJBt59XC6tWAKhnmW8QHJkgFRSNlgOpJH/Y6mXcBiu
	v60ws61Dl95Pfw3pCrk1QP63L57sJSx+gkhDla8GLvo7dLVjL9eLBDAfBSAGJDDV
	PbsFtYgxr37qLrTmsocw2445T7mPWBcgylhCYgNA69mBMDGKZCUFMlwgDA+aom9/
	B9Zn4gy3a72XMItzVZSMD/AZZgjCEBYGe5OgbN2UoJCyfSKlNtpurJXhFy/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683711; x=1727770111; bh=VEgBxnzLLIwccok7L50eCkc24UTw
	hrvqf+uFPzglnY8=; b=JVt1JAGBUNGGf1pGnUVYXBEx4Hc13CLLgOimEKTcm9OM
	S61aI2xCRHDsid96/NWV8YPChzMf/7gfjVDh3CRcxzyZLrkaPHZI+LclMTGk03lZ
	nKzAbVtMce0L4d3NWP25GcyHEF0bHcTl8qbdbvSVGzCohv0GfvAtYWJXY7hByw4g
	HxE/jHJt7jnK2/LSi0AjUymN+Ot1qo5rrMKf73EL9Lcr9sAjGsQBuWe0qAlU8Ouz
	NLRkUiqc+uppqpoPwWrZIcYIpEAOFVJLJncdo5xjQsZzH/Cw3u6NyfqI0QwRj40+
	Jgu36zw+OoAaHBngWsO4v8muArIs29lxgj1KxuBlww==
X-ME-Sender: <xms:flz6ZiedVKHu86xKS6EW1z8PbgaAQJS-JlnpoaJfysqvAg1N6iJWjQ>
    <xme:flz6ZsMPIrBewRxy79PV30N5DWVD7hNp8SeETBVsB_5sVZoJKvgWhS2htjPn47xxR
    tK04Whjvi7w2bx4uA>
X-ME-Received: <xmr:flz6ZjhAzjEy3D9G-KFBAvkbSzNwrjtnTHPXu4EfS8suvOQdYILBcgMyuG0xCRXFQ98Re2ocrvQHW9c8sXIpNd0C7SQmoAQdcOf7RRrmqFgn6d4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvhedvgeeltddvkeektdeikeejudetkeduvdfhgfel
    fffgtdeikeeggfffiefhtdenucffohhmrghinhepvhgrlhdvrdhtrghrghgvthdpuhhpug
    grthgvrdgvmhgrihhlpdhuphgurghtvgdrnhgrmhgvpdhuphgurghtvgdrnhgvfienucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdrrhesfigvsg
    druggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:flz6Zv8TB4sPLPQTP8nKwpYb-8ezuMWtjH3jtTELcVVqkeff6bsABA>
    <xmx:flz6ZuthUlsvQiidwtqNxiralYkBtMgb2wFVb7oel7GL0u0qt2vr8A>
    <xmx:flz6ZmFvl3W00f7poHblOfJruuVmDjFfe4MzZRIADxERq665V_DAJg>
    <xmx:flz6ZtMjlV16EYtgQ_8aNaZRHu2ZTbFDOwQVDBXnzX0x3ayxW4JHhQ>
    <xmx:f1z6ZgI66kBeS-dINQejRf1UzgOfNR134jfGcHYVAERb60hRjzDdJxp0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 16e636c3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:43 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 06/22] reftable/record: handle allocation failures on copy
Message-ID: <d4676e8a6a952ff43761b305fd77915e26b692f9.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures when copying records. While at it, convert
from `xstrdup()` to `reftable_strdup()`. Adapt callsites to check for
error codes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 84 +++++++++++++++++++++++++++++++++--------------
 reftable/record.h |  6 ++--
 2 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6b5a075b92..60fd33c9c9 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -215,13 +215,14 @@ static void reftable_ref_record_key(const void *r, struct strbuf *dest)
 	strbuf_addstr(dest, rec->refname);
 }
 
-static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size)
+static int reftable_ref_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size)
 {
 	struct reftable_ref_record *ref = rec;
 	const struct reftable_ref_record *src = src_rec;
 	char *refname = NULL;
 	size_t refname_cap = 0;
+	int err;
 
 	assert(hash_size > 0);
 
@@ -236,6 +237,11 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
 
 		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
 				    ref->refname_cap);
+		if (!ref->refname) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
+
 		memcpy(ref->refname, src->refname, refname_len);
 		ref->refname[refname_len] = 0;
 	}
@@ -254,9 +260,17 @@ static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
 		       src->value.val2.target_value, hash_size);
 		break;
 	case REFTABLE_REF_SYMREF:
-		ref->value.symref = xstrdup(src->value.symref);
+		ref->value.symref = reftable_strdup(src->value.symref);
+		if (!ref->value.symref) {
+			err = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 		break;
 	}
+
+	err = 0;
+out:
+	return err;
 }
 
 static void reftable_ref_record_release_void(void *rec)
@@ -457,23 +471,28 @@ static void reftable_obj_record_release(void *rec)
 	memset(obj, 0, sizeof(struct reftable_obj_record));
 }
 
-static void reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size UNUSED)
+static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
-	const struct reftable_obj_record *src =
-		(const struct reftable_obj_record *)src_rec;
+	const struct reftable_obj_record *src = src_rec;
 
 	reftable_obj_record_release(obj);
 
 	REFTABLE_ALLOC_ARRAY(obj->hash_prefix, src->hash_prefix_len);
+	if (!obj->hash_prefix)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->hash_prefix_len = src->hash_prefix_len;
 	if (src->hash_prefix_len)
 		memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
 
 	REFTABLE_ALLOC_ARRAY(obj->offsets, src->offset_len);
+	if (!obj->offsets)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	obj->offset_len = src->offset_len;
 	COPY_ARRAY(obj->offsets, src->offsets, src->offset_len);
+
+	return 0;
 }
 
 static uint8_t reftable_obj_record_val_type(const void *rec)
@@ -646,33 +665,44 @@ static void reftable_log_record_key(const void *r, struct strbuf *dest)
 	strbuf_add(dest, i64, sizeof(i64));
 }
 
-static void reftable_log_record_copy_from(void *rec, const void *src_rec,
-					  int hash_size)
+static int reftable_log_record_copy_from(void *rec, const void *src_rec,
+					 int hash_size)
 {
 	struct reftable_log_record *dst = rec;
 	const struct reftable_log_record *src =
 		(const struct reftable_log_record *)src_rec;
+	int ret;
 
 	reftable_log_record_release(dst);
 	*dst = *src;
+
 	if (dst->refname) {
-		dst->refname = xstrdup(dst->refname);
+		dst->refname = reftable_strdup(dst->refname);
+		if (!dst->refname) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
+		}
 	}
+
 	switch (dst->value_type) {
 	case REFTABLE_LOG_DELETION:
 		break;
 	case REFTABLE_LOG_UPDATE:
-		if (dst->value.update.email) {
+		if (dst->value.update.email)
 			dst->value.update.email =
-				xstrdup(dst->value.update.email);
-		}
-		if (dst->value.update.name) {
+				reftable_strdup(dst->value.update.email);
+		if (dst->value.update.name)
 			dst->value.update.name =
-				xstrdup(dst->value.update.name);
-		}
-		if (dst->value.update.message) {
+				reftable_strdup(dst->value.update.name);
+		if (dst->value.update.message)
 			dst->value.update.message =
-				xstrdup(dst->value.update.message);
+				reftable_strdup(dst->value.update.message);
+
+		if (!dst->value.update.email ||
+		    !dst->value.update.name ||
+		    !dst->value.update.message) {
+			ret = REFTABLE_OUT_OF_MEMORY_ERROR;
+			goto out;
 		}
 
 		memcpy(dst->value.update.new_hash,
@@ -681,6 +711,10 @@ static void reftable_log_record_copy_from(void *rec, const void *src_rec,
 		       src->value.update.old_hash, hash_size);
 		break;
 	}
+
+	ret = 0;
+out:
+	return ret;
 }
 
 static void reftable_log_record_release_void(void *rec)
@@ -954,8 +988,8 @@ static void reftable_index_record_key(const void *r, struct strbuf *dest)
 	strbuf_addbuf(dest, &rec->last_key);
 }
 
-static void reftable_index_record_copy_from(void *rec, const void *src_rec,
-					    int hash_size UNUSED)
+static int reftable_index_record_copy_from(void *rec, const void *src_rec,
+					   int hash_size UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -963,6 +997,8 @@ static void reftable_index_record_copy_from(void *rec, const void *src_rec,
 	strbuf_reset(&dst->last_key);
 	strbuf_addbuf(&dst->last_key, &src->last_key);
 	dst->offset = src->offset;
+
+	return 0;
 }
 
 static void reftable_index_record_release(void *rec)
@@ -1054,14 +1090,14 @@ int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 						   dest, hash_size);
 }
 
-void reftable_record_copy_from(struct reftable_record *rec,
+int reftable_record_copy_from(struct reftable_record *rec,
 			       struct reftable_record *src, int hash_size)
 {
 	assert(src->type == rec->type);
 
-	reftable_record_vtable(rec)->copy_from(reftable_record_data(rec),
-					       reftable_record_data(src),
-					       hash_size);
+	return reftable_record_vtable(rec)->copy_from(reftable_record_data(rec),
+						      reftable_record_data(src),
+						      hash_size);
 }
 
 uint8_t reftable_record_val_type(struct reftable_record *rec)
diff --git a/reftable/record.h b/reftable/record.h
index 5003bacdb0..0f53ba5443 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -44,7 +44,7 @@ struct reftable_record_vtable {
 	/* The record type of ('r' for ref). */
 	uint8_t type;
 
-	void (*copy_from)(void *dest, const void *src, int hash_size);
+	int (*copy_from)(void *dest, const void *src, int hash_size);
 
 	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
 	 * vs ref deletion) */
@@ -137,8 +137,8 @@ void reftable_record_init(struct reftable_record *rec, uint8_t typ);
 int reftable_record_cmp(struct reftable_record *a, struct reftable_record *b);
 int reftable_record_equal(struct reftable_record *a, struct reftable_record *b, int hash_size);
 void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
-void reftable_record_copy_from(struct reftable_record *rec,
-			       struct reftable_record *src, int hash_size);
+int reftable_record_copy_from(struct reftable_record *rec,
+			      struct reftable_record *src, int hash_size);
 uint8_t reftable_record_val_type(struct reftable_record *rec);
 int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
 			   int hash_size);
-- 
2.46.2.852.g229c0bf0e5.dirty

