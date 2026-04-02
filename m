Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A4388E79
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115103; cv=none; b=KCFgWRke1H/+3V8xhCNZ1yLrmyDlTE9Bqyf1ooqCrzXGZEgChLsoSNxrQp5IwScHpqzZ6I5DURIVjZJJj9sGZ7cGI9ajiKIXnKQN/Vfuf+xn5VUpUjhOUIhJ2h8CWc/wj3jQzq4UtaHUXuaOISIJmTISkfl4shlTxTQGpRzNx6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115103; c=relaxed/simple;
	bh=2tV7wKYy1tznRZEXew9uvId3R4zr8q4xNUp88hGz+Hs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgMsGxB5uBoKBQb3ZQXnFkeGy7CsPu55X9DSIw29ms8Fwmzw6KjwEBqKcG6OKlT7/tnMAuqhu6ce/2k+72TIoqEjWduuMiknEQBQVoOYBv46Wi5LepOWWNFDRBrAYUIVlTYV8Aop9+0/7m9pr+jaOWxiLk8i1ieldfpRQgKVukQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EQ5QuR3G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SGihPTt6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EQ5QuR3G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SGihPTt6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 4ABAC1D000F0;
	Thu,  2 Apr 2026 03:31:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 03:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115101;
	 x=1775201501; bh=wo/ajetGsnJt3O/Tyb9ue6PeskU3G5mLX/nemrJRDNc=; b=
	EQ5QuR3GF9PRn8lG5Mb5IhnyYiTFC0baS7mlKfw94tNqoI9lwP6vkl6wBuIHiTHL
	dE3fhbQ12ztgCecKNdBNw6h3NpPktL9eBRDGmLv8hlCl6HfIt+TgeclVzacAsqxO
	RGMRQjGZT/rYs/cRA8mMBmuE7IcNhHeQIaHXmrl4+uOcOM88IUQ5Nrd75cQ27UvB
	iFRdYyE9Cb/QRABYoYjOqsNYpep7Ug4l3EEm9iA1BU66i4VcjARsyJJujkS65rs2
	PZ/6Wp9mhJ2m6Lv0S5kLTrn2kcQgS1uHto1UXrFxcqgM4OvL8+L8Ju1E7cQ4BtiE
	om2GzjZmwt2JezwGW1ARwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115101; x=
	1775201501; bh=wo/ajetGsnJt3O/Tyb9ue6PeskU3G5mLX/nemrJRDNc=; b=S
	GihPTt6MM5zHgLVtY0m9eU96ZTagPpRF+5SdDtICckAmY2tBhFrw5fNPs6UKyVtD
	JM4nKH3AGFtc+pW3VZLZf6QoOyg/a4KuRL55DmldA70b+uH6ZWIv6I/eXzpf5Ao9
	X8itMHtoPX0YAMjB/6EX9arSnrO7xD/7Tqw88OZkvgITnUVh9DAIXl5bEFrJBRT2
	6VG23+WzKsJFIeyGWOcRFGh6M3huqB9ewtxWkcIktsBBkfjlZ663eOhjbVEXExMy
	m0s1Q0tluC9KUIkTIfscsSqvhsbVfI+i57EHczypL4c4nRrDa8Frr9qvWo36xsHt
	SrDtzTw+MIU3TEhcr1QBA==
X-ME-Sender: <xms:XRvOaa2-_1bUv-mLiSKxQYeZWxPyaKg5Uc0qhuC4ZwCdQifeWbDC-A>
    <xme:XRvOaUFe3gACwIJAOSqGKAiJHPVAIO9CrLcthBkAQWIC_kc4xvV7E6c4CKzIKM6KE
    jfpglHP7QEWf3M--Zx1IWGju9wPrHdZpgrFITGMyz1XiLanCH_5>
X-ME-Received: <xmr:XRvOaX6VMtcWrIJDj7TPKzDFnGo83wqXQcqqOSE-UhmUkQuo6Uxcg8tutwpMuaAkFyisY0gDvsYktgXhqRHW8VbycVCX_0xzy8LxQIoAVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:XRvOaavoIAAvDmaS3tUhQxHdnKlJ190xzZ44tWxxv8tkV-O5oAKjVg>
    <xmx:XRvOaY7o8RMytPq_mPJafsMpNSrfhJqHurS6UOOelrwA_SAtQC_k9g>
    <xmx:XRvOaVXmbao8eaegAs7A4vUJH9rxihFsOcc7Bf0pdJwWzSesEaZjMg>
    <xmx:XRvOaa-DAuLuyEqcnXq2wtS5MDBeAgD93s3sTYUil4hwTrpJZ6s9pA>
    <xmx:XRvOadKImOlj_YP48fhTgdy7SSRYTOT_NSIXG1Ok16b9C25hcsg1jCOu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:40 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0063c9ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 09:31:18 +0200
Subject: [PATCH v2 5/5] reftable/system: add abstraction to mmap files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-reftable-portability-fixes-v2-5-bc110cee0ae0@pks.im>
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

In our codebase we have a couple of wrappers around mmap(3p) that allow
us to reimplement the syscall on platforms that don't have it natively,
like for example Windows. Other projects that embed the reftable library
may have a different infra though to hook up mmap wrappers, but these
are currently hard to integrate.

Provide the infrastructure to let projects easily define the mmap
interface with a custom struct and custom functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 19 +++++++------------
 reftable/system.c      | 20 ++++++++++++++++++++
 reftable/system.h      | 18 ++++++++++++++++++
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 573c81287f..7f7441f751 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -93,13 +93,12 @@ void block_source_from_buf(struct reftable_block_source *bs,
 }
 
 struct file_block_source {
-	uint64_t size;
-	unsigned char *data;
+	struct reftable_mmap mmap;
 };
 
 static uint64_t file_size(void *b)
 {
-	return ((struct file_block_source *)b)->size;
+	return ((struct file_block_source *)b)->mmap.size;
 }
 
 static void file_release_data(void *b REFTABLE_UNUSED, struct reftable_block_data *dest REFTABLE_UNUSED)
@@ -109,7 +108,7 @@ static void file_release_data(void *b REFTABLE_UNUSED, struct reftable_block_dat
 static void file_close(void *v)
 {
 	struct file_block_source *b = v;
-	munmap(b->data, b->size);
+	reftable_munmap(&b->mmap);
 	reftable_free(b);
 }
 
@@ -117,8 +116,8 @@ static ssize_t file_read_data(void *v, struct reftable_block_data *dest, uint64_
 			      uint32_t size)
 {
 	struct file_block_source *b = v;
-	assert(off + size <= b->size);
-	dest->data = b->data + off;
+	assert(off + size <= b->mmap.size);
+	dest->data = (unsigned char *) b->mmap.data + off;
 	dest->len = size;
 	return size;
 }
@@ -156,13 +155,9 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 		goto out;
 	}
 
-	p->size = st.st_size;
-	p->data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (p->data == MAP_FAILED) {
-		err = REFTABLE_IO_ERROR;
-		p->data = NULL;
+	err = reftable_mmap(&p->mmap, fd, st.st_size);
+	if (err < 0)
 		goto out;
-	}
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
diff --git a/reftable/system.c b/reftable/system.c
index cd76e56be8..9063641f30 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -143,3 +143,23 @@ uint64_t reftable_time_ms(void)
 {
 	return getnanotime() / 1000000;
 }
+
+int reftable_mmap(struct reftable_mmap *out, int fd, size_t len)
+{
+	void *data = xmmap_gently(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (data == MAP_FAILED)
+		return REFTABLE_IO_ERROR;
+
+	out->data = data;
+	out->size = len;
+
+	return 0;
+}
+
+int reftable_munmap(struct reftable_mmap *mmap)
+{
+	if (munmap(mmap->data, mmap->size) < 0)
+		return REFTABLE_IO_ERROR;
+	memset(mmap, 0, sizeof(*mmap));
+	return 0;
+}
diff --git a/reftable/system.h b/reftable/system.h
index 071bfa3d58..c0e2cbe0ff 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -114,4 +114,22 @@ int flock_commit(struct reftable_flock *l);
 /* Report the time in milliseconds. */
 uint64_t reftable_time_ms(void);
 
+struct reftable_mmap {
+       void *data;
+       size_t size;
+       void *priv;
+};
+
+/*
+ * Map the file into memory. Returns 0 on success, a reftable error code on
+ * error.
+ */
+int reftable_mmap(struct reftable_mmap *out, int fd, size_t len);
+
+/*
+ * Unmap the file from memory. Returns 0 on success, a reftable error code on
+ * error.
+ */
+int reftable_munmap(struct reftable_mmap *mmap);
+
 #endif

-- 
2.53.0.1323.g189a785ab5.dirty

