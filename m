Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055C12C484
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140840; cv=none; b=ANXbGyR8jT4shPDYzhhjOVkB1UWlu0f6TeJQVjKFk1ZI0wXw5ZlcBxosRb52k8pTRuwtGiITgofc0Ej/Bp2ytyLCxdA45s3kU7+AXuS/xX0Zg0gJqH2rgLekaULFarrP1GtXndEbudVkCBmEvFzMeld4WKX/4b72q9WNsrWVmkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140840; c=relaxed/simple;
	bh=IElx/x3adFu5BW9BrLpHnkkgAHHI4bSVRrBcG2rNnX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEJkKroOgqqpIV/kgzg13qMKMlIIbt98Fyfco75cWi0FSIr4yFGDbyvQXbeblRiOY49/q1XXTFGmemjYhn5XP00WPBR3jJ8HomXVZnGFW/g86DjWCOITbB5Na9Cr8WPSi0Oz3jIV8htCJv/UkHb2BVw3KueMO29is6fHiHocq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GoyoXQQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d3Q0A3s2; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GoyoXQQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d3Q0A3s2"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E760913801F0;
	Thu, 17 Oct 2024 00:53:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 17 Oct 2024 00:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729140835; x=1729227235; bh=LrNP231hlT
	Pe6NzZQeOy2yl9kSjLih7ANHMpRFnefZQ=; b=GoyoXQQatSdh8Ayv7WTC2pnpa/
	P0pUf4xrbWI/zg4N3tF50ontol3G/gJUb4SzvalJROznz5uHNOcBIvbN46fCJZ6w
	XCnyrGn0MqLM7GZoIDZ7yQ34GX+EWWjDS3Lc/Md66Sxo7D7pQ7jFsuz1+VGtx+YY
	jF86C1KgRCqisGpVFgnZXwZxIJh/Ri1/2YI0x1kfWofUi9qtEB9ezZQiKEF5Z+5H
	K4Sw0dGu6uO/6XkoZkNFWhg28id4OwOAeXBtaY5fTcmNMiMKgI96K3/S4GoSinaA
	HUm2nr7GiEowv3o+7AKZZ78O1YLhbOvqRnHEJXpvsDeoM+hCIt5DU/t0UCHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729140835; x=1729227235; bh=LrNP231hlTPe6NzZQeOy2yl9kSjL
	ih7ANHMpRFnefZQ=; b=d3Q0A3s23mTJXgHibcIq5ohib7fePQsjSDVbFUSPnwZk
	1fD3cW1XYPxuFVVbB2a+ro1q6gQsGk+hqbh/w1hthNv8HMnJNUpGlICuOE0soGOU
	mFsSRjuYWLCTKAPzwuDEVnpl2dg4ky098N9v7mBlo900hmcJDMgKctRBYLHkYnPu
	dpVwKYgkyQMVaCUzGRDfGV8sChUUydjj/Nd2siqM7hAD7fEywLZF1v9141SP9vGV
	OdLfNPAGjgQKn0jbQ1rHE0S5EiofBVKOsbHAleh8f2Xg3BFeGsgoIf78qnzD5O54
	hWK7KkUorEWxkqWY6+UwSH386xQ31rg5CSPhfQ7Wbw==
X-ME-Sender: <xms:Y5gQZ-CnwMPMnIlufNPRl3xTc_FOj9vLhDB28w5lOy6d-YqypNPZcw>
    <xme:Y5gQZ4jWULrWICpRPqYBhKspTEzRfy8sogapxDIqm1jf52WoUtZx6v26FMQxAtDPU
    bKRW2v0S9P30qtE0A>
X-ME-Received: <xmr:Y5gQZxng6aE43lN018SCFU8O762zpcEG0FZrk2SD50VVVox-oFk2h76W9qY2NoldsG04Rst24kBCt1CHMCHFnUfKSKlyp1zPXNIx0zv8rS5NFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    hhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhho
    rhhrrdgtohhm
X-ME-Proxy: <xmx:Y5gQZ8xM2pnMtWtJ7hNufBicpaqmchP91jxlK9Ft1VPd7SGt-Nt6Iw>
    <xmx:Y5gQZzS_RZM-gJRHw5dbL5vYYb4xks701qBjdxx11IglVSD_LRB8uw>
    <xmx:Y5gQZ3a9UTuqMynVro8iTINn6bbzO_C_8bIxCGkBHEMiUEGlDG_j9w>
    <xmx:Y5gQZ8RAayH3j_z9Mur0C_y0XRsTqqQ8jQDYoeUejRf3lfsi-KGr5w>
    <xmx:Y5gQZ0LkZTclTojsjwDfnM0zG6RuDDtatQmyJeDTBbT9JBlEDWzRxqfc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:53:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4d8c2a18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:52:36 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:53:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>,
	Taylor Blau <me@ttaylorr.com>, shejialuo <shejialuo@gmail.com>
Subject: [PATCH v3 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <53c5f667f28c89ebcf023055423af24920e8c0ca.1729140565.git.ps@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1729140565.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729140565.git.ps@pks.im>

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
    can be set up via `reftable_set_alloc()`.

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
2.47.0.72.gef8ce8f3d4.dirty

