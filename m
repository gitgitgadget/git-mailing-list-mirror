Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDC200114
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866546; cv=none; b=a10+/KD6sJ27nDq/y88Uzki37zjjORpfgEA1eKI6kKZn6Ou/G6lhtA0E04GtGA8kR0aTIuNQbF9gY+YqJFX1oNArzIHhG9OJIbdVnnvACi5LrS0VAysozr0uRCG1JkprbSGdGemFFAIxCOlA2y5ZDB9RMe+xs9Uw4cvD3pxAloQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866546; c=relaxed/simple;
	bh=qxU0Xmm3CMMGs5WTlWr/DpDEk6fwVujl5k+Xkzvwp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlqRxEw/hYyUfxdx+feiUmjzKoW73eTf2mYw9nINgyD8snzzSHiKrEcRL3orBPSm+1/S5sqDAzgy6JrMHxlk1B/OmqeURQdN+OfJdIvKfqH5jR3/r7g4sf1KuRqBqmG1m/gzm78HmenR3Ru6Gjluxs7FtYHkTOpnAdeX74iS8bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SUOvMA2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D5/GzZhz; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SUOvMA2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D5/GzZhz"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3F2961380253;
	Wed,  2 Oct 2024 06:55:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 06:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866544; x=1727952944; bh=ntLRfyLoj/
	jtFPMVcZ5YzVO9pb1iRg2Bwsm5QmFS4gw=; b=SUOvMA2Ft5TUzl6MYYY85F5Q1R
	GL/zKHBrdwHCI/CGdbDyfVWr7Xxo7YbMJVDLwyLGTdAYzrrIo7OarM3VbzPA9uvl
	sqaZTt5sEcX/T0zoQGlq9whLfITqXBsz58WiyXIr690CHL9E6AlNM9cEPxgZBZ5E
	tOlXdA93AixOUxoxhisjHlrSa3tp71ypSd5O1WQM0MBNKaJKtH9hnkNlqrz6Uv6p
	T1dZgFdTw5WTIEP6yU4PpXI1NOf9Gp7IouEsOodXdvQWoGdax6XP9k82sFizDvyl
	xwWGCnXk1Yx7m5sIKSGDPuCEic/yWcvmjl5hZRrJshhG7ZZ4F6cP54FQgm/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866544; x=1727952944; bh=ntLRfyLoj/jtFPMVcZ5YzVO9pb1i
	Rg2Bwsm5QmFS4gw=; b=D5/GzZhzB8uuRPlTo/aWrykvuHK4UGhTZXsGKS4nk72Z
	iETb4bvZyLnRsQe0hMBVquTpAXZGeG6PSlgAPmlhabwBR18bwZosJTks2bHXrgrb
	7gHTKppBYapZAyMHcn3nDX51cFq7T/UCekdpdMJGbMjm1g6tfuD0Fytfo9CL8Jok
	K5cne7bXX0bTLqdX4WdYUHe7qtGPnrrRGK/Q4xmmmh2+dYuYfvJjrK0UodwmuKCx
	H7ujtzbKrYPNEKAMDaOYnrAr6i3FzD4hJYte6tPARZ8I0Zajo4uNFDb90gz76T3Y
	zKtDWVWnNKt3x/As0YPqHKZN5MTcYJ6lOslPYQlAWw==
X-ME-Sender: <xms:sCb9Zsvgsc8LxCcf1rGzWwpIc9cXL_vG_EBimSHVs967t3MMVu-erA>
    <xme:sCb9Zpc0zcuL7q9hfjJF9w_Rdq65SNBk6MY6qqr3inVXPRwLbwWmTdiwiv6UNirdi
    _RC2gBpdZavtsU1tQ>
X-ME-Received: <xmr:sCb9ZnxmM4jpz2NgpfDHAQUmhrOcQWojh9H6ZGXNIHG24LBIYeUOXUvCtHeZZAV_prshHsvX6f08EtwjmtJRIOkLtldht1WS2op4t8u8JKlDmPfM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdehvdegledtvdekkedtieekjeduteekuddvhffgleff
    gfdtieekgefgffeihfdtnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurg
    htvgdrvghmrghilhdpuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdhnvgifnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonh
    esvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:sCb9ZvN2KXODmzbCiR8I9SPXLzijtaHbgBtVFbikVAMI8tMLFRnikg>
    <xmx:sCb9Zs-7zedd3UME2dedvSgY7fg69S2y6cotKqQboH4hmKwo1T922A>
    <xmx:sCb9ZnWND69kdT-9dVvr5tYhcxsDfdnmRC7si3j7gnIIYskY_em8wQ>
    <xmx:sCb9ZlfqL9NXAjNvg-ezlijZ1XFiSOLTlITdECoCKXepqD4TAzwSmw>
    <xmx:sCb9ZgbNPTiQMTPlyW9rWbUx3R8gDWmUiXoC03gFiFK1IOCKYnLKA4c6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c6093879 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:53 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 06/25] reftable/record: handle allocation failures on copy
Message-ID: <756a32c28558bfaa360304712110443d643fc303.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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
2.47.0.rc0.dirty

