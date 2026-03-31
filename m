Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AA33D4114
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956418; cv=none; b=NpXVPbFMVAg3/y/8wzHz87xHyII0XEIPzILCnIqxKUUIogRv+FFqaytDvGzpQlqwZJ8g3tpYE0ziXBAgMVsvQ+i5vAG9DRKo5dWH5H+pLAzlV8LtMaQK3CtqjIBJIuKwagwT5044a7FbJriwxZytdwwV0Cm299OLz3+qIdCJduk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956418; c=relaxed/simple;
	bh=uooemrPifiFlFi48t2NPMxj2QLeDpdxkv4SPTdw/Ojk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ejF+/xkdKnlyYaVrgvMM59rQBrkurcZsOeQE6f6zLbU/a+9a+DSG/gwiAP7NGG08KwRAa8kgZWjluH1Qg8DkJ3XA8A5dA0KE6Galip97PyZq7H3HsOWH0RM9CalNd3ibKaQq1/Gf6uVlzwLmcUGntjVPBXEgVP+IRi9Kc/Bk534=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UiOfzlip; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOzSveiR; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UiOfzlip";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOzSveiR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C771EC00C5
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 07:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956416;
	 x=1775042816; bh=U5wU2lZvDF1leQH95cnI6SeK/GnrlxaPUMsmteUq71A=; b=
	UiOfzlipzL85KVyCDAY4BLQsmGRFBoLh+zLxIGb3xuObEQeAOOkyRbqMdGfCq1/3
	uC5ASimVDFGdNycMFt94AndzFw8voeYAVuo5xalE+CQxs8y72KzJXqgmclpxpJKm
	j99fTfXr8llpyYBkYE2e66bX3KCDZlFL51bNNmDB4JL8fS7e1ebnMnEmzheVsbV3
	EIkDz45OPYg8L0KKtOJoeGuV+LXL4+v+aG+5tftAGkpda2AOcCpYCkgOVtQekiPt
	iEIKhj0mxEQtKFdWH1byh8uCEpo6zlAaw6FpxCm1a8ytyfZDP/sCdLb/uSww03lB
	iebCgWNVa9K8+axUEyH6WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956416; x=
	1775042816; bh=U5wU2lZvDF1leQH95cnI6SeK/GnrlxaPUMsmteUq71A=; b=l
	OzSveiRAoNFsU2mZGVJIxxeRWBzsokEZUG/tmzmHzhtfIpIZRwcRg0YDuYKgWKy5
	wwRLysSEdrI8F9YfbHbEpPZno91RXJGkUWL+JqjLCoQJnUJbxzWzx/WFsDzZiPER
	nTBI4jE1CX2k5fNvKIDo1Y6oMVOg+bmecs1GtmFgLBvYl6Ka8/Ecbo0UyhvtoL0f
	fQu9F0sMqAVCOXXHxJgYCPuEr3f3WZ1MknNRQ562tah1mipTFZknRK1LFW6xpXMK
	GCaVUjvUYCIhGLcTY35Kbjuzf1DNNHUP1c8QlVtl6bQvocetc4Xbu0L2en3os9or
	sUVlepO4M3iygF8fccJyw==
X-ME-Sender: <xms:gK_LaT03fkHR6ptvXgiRs4x812gbCVfr8yuIOlvEd4ayp3B3n3kMFA>
    <xme:gK_LaZBnOsH8qGiGEk6vn04qKHJa_5xuP8xuN8DRe02cOHxjZbPD7TT2nN2G9FxCv
    xSnOfMnjhvgD1Fx9yyy6kcTMaF2fTr_RDMhI7Su8-jsftmyUF4T>
X-ME-Received: <xmr:gK_LaZjjy5NFz3TAVkaSrJuQDWqayWLZoKM1mdFSoyaCkjRqpxzKF80pyj9xcG654D0_NcUKOgvdfjUeKHUY0LIlg4-puU7i9-bGSeiQLes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:gK_Lad_43yRLad202HqPEudrMFLUV_r0byzUkBYeafCkYOxFwq4nZw>
    <xmx:gK_LaV9Grl1UwnO3TNxOvYZ0OzVu1fe-hdeWAiTGD87bFaHTVr2aHA>
    <xmx:gK_LaWA9rHm_ScIwWLQxnEMQlY8WWOtuPlHZ0fHEt42kJEKLX1lMQw>
    <xmx:gK_LaVxr-XDZypN0PC3guoWZrZQ1XOLNrpapIPEYgue9BUVYzYt3GQ>
    <xmx:gK_LaRE-0OO1gZzRJo0L3gJ_U3NovHIKW4y-k1icf2QB5k6LvYaI-3dD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:26:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bbb3d4a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:26:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:47 +0200
Subject: [PATCH 1/6] reftable/system: provide `REFTABLE_INLINE()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-1-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Not every compiler knows about the `inline` annotation for functions.
Consequently, Git knows to define `inline` as an empty macro in case
it's not available.

In the reftable library though we cannot assume the macro to be
available as it is usable as a standalone library. Fix this by
introducing a `REFTABLE_INLINE()` macro via "reftable/system.h" that
allows the project to use their own definition.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h | 20 ++++++++++----------
 reftable/pq.h     |  4 ++--
 reftable/record.h |  4 ++--
 reftable/system.h |  2 ++
 4 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index e4b83b2b03..ebbcec2ac3 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -75,14 +75,14 @@ char *reftable_buf_detach(struct reftable_buf *buf);
 
 /* Bigendian en/decoding of integers */
 
-static inline void reftable_put_be16(void *out, uint16_t i)
+REFTABLE_INLINE(void) reftable_put_be16(void *out, uint16_t i)
 {
 	unsigned char *p = out;
 	p[0] = (uint8_t)((i >> 8) & 0xff);
 	p[1] = (uint8_t)((i >> 0) & 0xff);
 }
 
-static inline void reftable_put_be24(void *out, uint32_t i)
+REFTABLE_INLINE(void) reftable_put_be24(void *out, uint32_t i)
 {
 	unsigned char *p = out;
 	p[0] = (uint8_t)((i >> 16) & 0xff);
@@ -90,7 +90,7 @@ static inline void reftable_put_be24(void *out, uint32_t i)
 	p[2] = (uint8_t)((i >>  0) & 0xff);
 }
 
-static inline void reftable_put_be32(void *out, uint32_t i)
+REFTABLE_INLINE(void) reftable_put_be32(void *out, uint32_t i)
 {
 	unsigned char *p = out;
 	p[0] = (uint8_t)((i >> 24) & 0xff);
@@ -99,7 +99,7 @@ static inline void reftable_put_be32(void *out, uint32_t i)
 	p[3] = (uint8_t)((i >>  0) & 0xff);
 }
 
-static inline void reftable_put_be64(void *out, uint64_t i)
+REFTABLE_INLINE(void) reftable_put_be64(void *out, uint64_t i)
 {
 	unsigned char *p = out;
 	p[0] = (uint8_t)((i >> 56) & 0xff);
@@ -112,14 +112,14 @@ static inline void reftable_put_be64(void *out, uint64_t i)
 	p[7] = (uint8_t)((i >>  0) & 0xff);
 }
 
-static inline uint16_t reftable_get_be16(const void *in)
+REFTABLE_INLINE(uint16_t) reftable_get_be16(const void *in)
 {
 	const unsigned char *p = in;
 	return (uint16_t)(p[0]) << 8 |
 	       (uint16_t)(p[1]) << 0;
 }
 
-static inline uint32_t reftable_get_be24(const void *in)
+REFTABLE_INLINE(uint32_t) reftable_get_be24(const void *in)
 {
 	const unsigned char *p = in;
 	return (uint32_t)(p[0]) << 16 |
@@ -127,7 +127,7 @@ static inline uint32_t reftable_get_be24(const void *in)
 	       (uint32_t)(p[2]) << 0;
 }
 
-static inline uint32_t reftable_get_be32(const void *in)
+REFTABLE_INLINE(uint32_t) reftable_get_be32(const void *in)
 {
 	const unsigned char *p = in;
 	return (uint32_t)(p[0]) << 24 |
@@ -136,7 +136,7 @@ static inline uint32_t reftable_get_be32(const void *in)
 	       (uint32_t)(p[3]) <<  0;
 }
 
-static inline uint64_t reftable_get_be64(const void *in)
+REFTABLE_INLINE(uint64_t) reftable_get_be64(const void *in)
 {
 	const unsigned char *p = in;
 	return (uint64_t)(p[0]) << 56 |
@@ -187,7 +187,7 @@ void reftable_free(void *p);
 void *reftable_calloc(size_t nelem, size_t elsize);
 char *reftable_strdup(const char *str);
 
-static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
+REFTABLE_INLINE(int) reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
 {
 	if (nelem && elsize > SIZE_MAX / nelem)
 		return -1;
@@ -215,7 +215,7 @@ static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
 		} \
 	} while (0)
 
-static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
+REFTABLE_INLINE(void) *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 					size_t *allocp)
 {
 	void *new_p;
diff --git a/reftable/pq.h b/reftable/pq.h
index 42310670b0..9210ede273 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -27,12 +27,12 @@ int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
 
-static inline struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
+REFTABLE_INLINE(struct) pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
 {
 	return pq.heap[0];
 }
 
-static inline int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
+REFTABLE_INLINE(int) merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
 {
 	return pq.len == 0;
 }
diff --git a/reftable/record.h b/reftable/record.h
index 7953f352a3..20c9091371 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -26,7 +26,7 @@ struct string_view {
 };
 
 /* Advance `s.buf` by `n`, and decrease length. */
-static inline void string_view_consume(struct string_view *s, int n)
+REFTABLE_INLINE(void) string_view_consume(struct string_view *s, int n)
 {
 	s->buf += n;
 	s->len -= n;
@@ -147,7 +147,7 @@ int reftable_record_decode(struct reftable_record *rec, struct reftable_buf key,
 			   uint32_t hash_size, struct reftable_buf *scratch);
 int reftable_record_is_deletion(struct reftable_record *rec);
 
-static inline uint8_t reftable_record_type(struct reftable_record *rec)
+REFTABLE_INLINE(uint8_t) reftable_record_type(struct reftable_record *rec)
 {
 	return rec->type;
 }
diff --git a/reftable/system.h b/reftable/system.h
index c54ed4cad6..b15768dbdb 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -15,6 +15,8 @@
 #include "compat/posix.h"
 #include "compat/zlib-compat.h"
 
+#define REFTABLE_INLINE(type) static inline type
+
 /*
  * Return a random 32 bit integer. This function is expected to return
  * pre-seeded data.

-- 
2.53.0.1185.g05d4b7b318.dirty

