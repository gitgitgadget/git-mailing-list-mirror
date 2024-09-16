Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB515624D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489718; cv=none; b=ZNFCb/v3BikXlumz456QmIuOb8/rhC3MvFx4aUnAqqR6opSe0xzDA8BXGCXTiyd8fTh6G1xqlO1QN76qWsHGt70RnIaZffcHtT49DH2L72BKhsGFxEO9rNV2HSyFjuJROdSY5FcmDm+HJJZqCcH5qCN1p3MRowptNDw5WuaHNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489718; c=relaxed/simple;
	bh=UXe/jneljxmmgsi8+vRJhgKs6mn4z4+x0S5xFQB6sBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SszcGjXfcTHhypt0+h1KFuxeHbRWnAFLNuxGBBbvYI52ZNJoP3CBnb6Pi8g4MhH17w1BFfbMptGI8/vkBM7iW1v3gYEih655x9+NyXOt218tyXzPXC7WZBZJTEBJn/wWEt+dn5zMEMVVfLzG4UhvOlMx9+amrUYdYzUEcodQe2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L5nvxJEe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nQDHamPD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L5nvxJEe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nQDHamPD"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 939B4114023D;
	Mon, 16 Sep 2024 08:28:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 08:28:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489715; x=1726576115; bh=orYIaVjKvY
	rdaHpRk626AtD0G2Qqvo4E/RErPNcSwcQ=; b=L5nvxJEe7k8glVe9eDxe7HGL3A
	4CYt3CS/hDO8YAbaz6xznrPJ8hrUKbfwqhitsBadLoAYXaGme5n1dCSR8Elr2TFy
	eUV3WNUnND0ybb1rKXD6ZdxcMlblxK1UhGbGxigNB9QxjvWimtRY+mP8wX+q1vgQ
	+HoJCFE71nKNXUo5zZQjkUZ/aSWNcSM+rJ0vlVQKiMUyCwpap1vB7HvOUoOSGHhG
	Jg3Sbni22F66eEjAhOTiXilYRqt0SmvlJ1e+dgPeHKgDZ2nAdNfvS9gh81lPIk1n
	UH+aetkP4G3X3XJeDThKeUckszrOjqfP8iqgo0EsRUhuV6272WNnZgpIkZaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489715; x=1726576115; bh=orYIaVjKvYrdaHpRk626AtD0G2Qq
	vo4E/RErPNcSwcQ=; b=nQDHamPDgAVd49PZoFOUsVQ1wN76IJ8kTS6rF69IuagE
	wIeuZ/6DS2JlVrovnaEgXizljBnKVtntpkCs8RQxxr0FlJSdFCSuMYOghVwOaw9A
	MqXXi/lIZRFseJgRygJkcUbFGnna/RN2KOClx+adfNI2bcrPmdxjSMdyM2dSc6Bi
	NM3hBaLewPsLRqac8LHnzWBXr3IsZYgVvVWrhxpOuw9+x+j3jlQNiaBXjnEE94hE
	Yg2APA7qrZo1HggJBU0Q4MpSkti1SrHm9HGosIAtucjjrR1GAXGdjgW5EeTPw7Kg
	KxurvtFXNBIk7lZqN0jEnPC8e+3SLhawoZKI+v5TLg==
X-ME-Sender: <xms:cyToZkgE4RdTfM4DaMlA0m-4KTmN3bd8kJfW7fYkepPDywDPYUsC4w>
    <xme:cyToZtCe_f5dBTWWut6c9C_grzipHVmkYgM3GkRf_AR-9WTa1-OX4u8okmG-l8LI1
    G_MBwG92zHS5qPhng>
X-ME-Received: <xmr:cyToZsHWyy1pqFZVT3SCzrIqDPPfVF3Zu0Txp9BO4KKsQXFFbL_26uwObFx5xUb-qkfHwvDOdWRvgOKTzfqZKvVMlye120sclF2Si7yluGJUH3Ri>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdehvdegledtvdekkedtieekjeduteekuddvhffgleff
    gfdtieekgefgffeihfdtnecuffhomhgrihhnpehvrghlvddrthgrrhhgvghtpdhuphgurg
    htvgdrvghmrghilhdpuhhpuggrthgvrdhnrghmvgdpuhhpuggrthgvrdhnvgifnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    vghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cyToZlRCiz9MkqJyYWHG45A0xWC06FZoyx27w6jprO10_xp03JPHqA>
    <xmx:cyToZhx6lmWm0lSt27-C1FFUbiQsWPztxqb4Lxn86NnVq_0DOS8IaA>
    <xmx:cyToZj7Cfc2_NJg9dwTGylzGYPTIRgtJFQXfQLWhvaG9bULml7Ac7Q>
    <xmx:cyToZuz51MJAunO8_thKgFjmsJGGrGtWACxfXeY4OWpI69GVv6JFsA>
    <xmx:cyToZs8uFFW3bhlcXQMMmImGIet0ghmlhHn4YcQeRI8AVjNTSTuzqWDx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b6c6e809 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:18 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 06/22] reftable/record: handle allocation failures on copy
Message-ID: <fa32be01e508c1f90096e25fe14708587b649013.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures when copying records. While at it, convert
from `xstrdup()` to `reftable_strdup()`. Adapt callsites to check for
error codes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 84 +++++++++++++++++++++++++++++++++--------------
 reftable/record.h |  6 ++--
 2 files changed, 63 insertions(+), 27 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index 6b5a075b921..60fd33c9c94 100644
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
index 5003bacdb0c..0f53ba54434 100644
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
2.46.0.551.gc5ee8f2d1c.dirty

