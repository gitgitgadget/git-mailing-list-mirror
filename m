Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6009819CD0E
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910954; cv=none; b=iXxjcOGqKRHzv8ZCwakEF7NnlbB7Aq7H7opU98EupXkz4kF/tTXwB6L+wN7L132uykoDA/O96JwiseKF5orsFa3vCkmOnsLgffsqJVIv3WVY8C9H82n4Jd2JCaNn6fImTiO9yOyTDIp9GdZWj5YbK/3jjkPOEtMnL7SRka5ZH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910954; c=relaxed/simple;
	bh=kPkCQk+fawCU0UZwSQVpvghBi8x4awlhmCSIL9NMqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NegTG27TbIaBn0WHTwBeS3KEYc8HijwpwteRC1/iIPAcn5cU7+UOHs/bhTU+kt+AqSttJDDXVZNnHKlzOOOTQZhxRaWTmxSrHhGx8cbotEtgee/d52bZd1imm2VWkObGwq6j8h11pLJls2TJVyerZbnsNaVx5bmHYhvCa4yboBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VnhFstz7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGFyR0kq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VnhFstz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGFyR0kq"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 66676138039F;
	Mon, 14 Oct 2024 09:02:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 14 Oct 2024 09:02:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728910951; x=1728997351; bh=t+/0ZzPjHW
	xKXszze5i43kTrICWafoFY/ZCuQOGx4E0=; b=VnhFstz71wMfVXVFaB4nH930/m
	kNGazUfoiIWlGoo76CzFX773g6SHc0SZhP6p6k7TQ8OKgoddZq9b0+qqfj9RNJaU
	NfI6JLl8GimCFy1ZlRT0lEn7VAqhnIsR1mtX+2lGpDTaVBbhPIpM0x1vFv3ZFa31
	jfZw37lwTxYtBgF8glshNtLpt3aSRS01oQXIR5uJmeLf2ePCBvkWX7EAoA99U3b8
	P5FUh54KisI2Tk8gP/ZHfnqvoteIaM6XGDFvuMdnTqP49+aop3jLybZC/dFxzX6W
	cwucLMqlWtToC6wRwvKrxltvjhERgegEo/mFjjRmMRSnzupVx4ItmocVn/DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728910951; x=1728997351; bh=t+/0ZzPjHWxKXszze5i43kTrICWa
	foFY/ZCuQOGx4E0=; b=PGFyR0kqEVX/AsASRkBiyLZ6vMIiurnyd4zlLr+N6fBx
	fl0yz6n5I2DxGqfQOV45ygWdv1t1SO1nIVYOJ4kzw7GiAWu9boSDkIfJPcNk7GGS
	/D3O3pshkzcge3BdbPwUq8x/JgTk1vx8e2zIU19wPqzlHyRbBruDAsf06FAYtm+s
	g4lCfiZHVQ76AwJVeVP/XgoF2MudL1fo2H7VNRaWbAe+YvfOFC1dYz4rO2mrL8vj
	T/ce1N6fubjc9R/UDr1JgRWkoz8fjmvA+lUTagKx/f51foa4bGmJpSy4eeyoIexI
	eZE4ZpxCxYEGin7+85+vcknqE9m7nkQpugYRZrc6dQ==
X-ME-Sender: <xms:ZxYNZ0qDYQOezzvQOA1hrsWy00-vOQJRGb6-J5fA-otVMZtOSGE-Og>
    <xme:ZxYNZ6p-p4gf9DmANckPSVQurEmsRMkD4OgrMCNsaQ_N8JyXTabp1jdxOyt5NpSHZ
    N0lIGnv_eTbAApe3Q>
X-ME-Received: <xmr:ZxYNZ5MCNtNmc0FyhY_oYbn_jKD9SpaEkv6r10UXbVsFnUEQj-vAkBcunuRfP_h35SrhWYm8sWlr54lUBAUyasE7DH4L778C4OnNMUq2G5TUvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeghedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZxYNZ76WtpIPImY7biDXUMiRNlG76o6_sojnjJC4QlRFbckRLQEUPQ>
    <xmx:ZxYNZz6nmHqt7riQKYWcfZMGdxrOnFXjUKfj-SmLXtV-aqwV6_HCog>
    <xmx:ZxYNZ7iFT8tp8ut9YCqJ0wbuqKdTaMF5ZMNnX2jFS1wEya2ruVbI8w>
    <xmx:ZxYNZ97QPEskBDwAXNsQbfH4geQyfYb1yE_jXFT8fKCzojvb0qb0HA>
    <xmx:ZxYNZ1nqjRoLfS20WAOl9vwc97LIRgDynk6ZKYciL6P_OzR5Ize_A3dj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Oct 2024 09:02:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 702d17a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 14 Oct 2024 13:01:13 +0000 (UTC)
Date: Mon, 14 Oct 2024 15:02:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728910726.git.ps@pks.im>

Implement a new `reftable_buf` interface that will replace Git's own
`strbuf` interface. This is done due to three reasons:

  - The `strbuf` interfaces do not handle memory allocation failures and
    instead causes us to die. This is okay in the context of Git, but is
    not in the context of the reftable library, which is supposed to be
    usable by third-party applications.

  - The `strbuf` interface is quite deeply tied into Git, which makes it
    hard to use the reftable library as a standalone library. Any
    dependent would have to carefully extract the relevant parts of it
    to make things work, which is not all that sensible.

  - The `strbuf` interface does not use the pluggable allocators that
    can be set up via `refatble_set_alloc()`.

So we have good reasons to use our own type, and the implementation is
rather trivial. Implement our own type. Conversion of the reftable
library will be handled in subsequent commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++
 reftable/basics.h | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/reftable/basics.c b/reftable/basics.c
index 9a949e5cf80..65ad761da0b 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -9,6 +9,7 @@ license that can be found in the LICENSE file or at
 #define REFTABLE_ALLOW_BANNED_ALLOCATORS
 #include "basics.h"
 #include "reftable-basics.h"
+#include "reftable-error.h"
 
 static void *(*reftable_malloc_ptr)(size_t sz);
 static void *(*reftable_realloc_ptr)(void *, size_t);
@@ -69,6 +70,79 @@ void reftable_set_alloc(void *(*malloc)(size_t),
 	reftable_free_ptr = free;
 }
 
+void reftable_buf_init(struct reftable_buf *buf)
+{
+	struct reftable_buf empty = REFTABLE_BUF_INIT;
+	*buf = empty;
+}
+
+void reftable_buf_release(struct reftable_buf *buf)
+{
+	reftable_free(buf->buf);
+	reftable_buf_init(buf);
+}
+
+void reftable_buf_reset(struct reftable_buf *buf)
+{
+	if (buf->alloc) {
+		buf->len = 0;
+		buf->buf[0] = '\0';
+	}
+}
+
+int reftable_buf_setlen(struct reftable_buf *buf, size_t len)
+{
+	if (len > buf->len)
+		return -1;
+	if (len == buf->len)
+		return 0;
+	buf->buf[len] = '\0';
+	buf->len = len;
+	return 0;
+}
+
+int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b)
+{
+	size_t len = a->len < b->len ? a->len : b->len;
+	if (len) {
+		int cmp = memcmp(a->buf, b->buf, len);
+		if (cmp)
+			return cmp;
+	}
+	return a->len < b->len ? -1 : a->len != b->len;
+}
+
+int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len)
+{
+	size_t newlen = buf->len + len;
+
+	if (newlen + 1 > buf->alloc) {
+		char *reallocated = buf->buf;
+		REFTABLE_ALLOC_GROW(reallocated, newlen + 1, buf->alloc);
+		if (!reallocated)
+			return REFTABLE_OUT_OF_MEMORY_ERROR;
+		buf->buf = reallocated;
+	}
+
+	memcpy(buf->buf + buf->len, data, len);
+	buf->buf[newlen] = '\0';
+	buf->len = newlen;
+
+	return 0;
+}
+
+int reftable_buf_addstr(struct reftable_buf *buf, const char *s)
+{
+	return reftable_buf_add(buf, s, strlen(s));
+}
+
+char *reftable_buf_detach(struct reftable_buf *buf)
+{
+	char *result = buf->buf;
+	reftable_buf_init(buf);
+	return result;
+}
+
 void put_be24(uint8_t *out, uint32_t i)
 {
 	out[0] = (uint8_t)((i >> 16) & 0xff);
diff --git a/reftable/basics.h b/reftable/basics.h
index 4c9ef0fe6c5..bd33c34deae 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,6 +16,62 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-basics.h"
 
+struct reftable_buf {
+	size_t alloc;
+	size_t len;
+	char *buf;
+};
+#define REFTABLE_BUF_INIT { 0 }
+
+/*
+ * Initialize the buffer such that it is ready for use. This is equivalent to
+ * using REFTABLE_BUF_INIT for stack-allocated variables.
+ */
+void reftable_buf_init(struct reftable_buf *buf);
+
+/*
+ * Release memory associated with the buffer. The buffer is reinitialized such
+ * that it can be reused for subsequent operations.
+ */
+void reftable_buf_release(struct reftable_buf *buf);
+
+/*
+ * Reset the buffer such that it is effectively empty, without releasing the
+ * memory that this structure holds on to. This is equivalent to calling
+ * `reftable_buf_setlen(buf, 0)`.
+ */
+void reftable_buf_reset(struct reftable_buf *buf);
+
+/*
+ * Trim the buffer to a shorter length by updating the `len` member and writing
+ * a NUL byte to `buf[len]`. Returns 0 on success, -1 when `len` points outside
+ * of the array.
+ */
+int reftable_buf_setlen(struct reftable_buf *buf, size_t len);
+
+/*
+ * Lexicographically compare the two buffers. Returns 0 when both buffers have
+ * the same contents, -1 when `a` is lexicographically smaller than `b`, and 1
+ * otherwise.
+ */
+int reftable_buf_cmp(const struct reftable_buf *a, const struct reftable_buf *b);
+
+/*
+ * Add the given bytes to the buffer. Returns 0 on success,
+ * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
+ */
+int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
+
+/* Equivalent to `reftable_buf_add(buf, s, strlen(s))`. */
+int reftable_buf_addstr(struct reftable_buf *buf, const char *s);
+
+/*
+ * Detach the buffer from the structure such that the underlying memory is now
+ * owned by the caller. The buffer is reinitialized such that it can be reused
+ * for subsequent operations.
+ */
+char *reftable_buf_detach(struct reftable_buf *buf);
+
 /* Bigendian en/decoding of integers */
 
 void put_be24(uint8_t *out, uint32_t i);
-- 
2.47.0.dirty

