Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1923AE79
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870531; cv=none; b=M+t3G1jRZe6ZBmu3Tkv6vcroZURHIN/z8Uyj69y+CzToeweO8LsWdDYVxvZ1iExsvQ85zFpTBcOc4cKxhVAiCjLo6K0XaMh1l5kxaLRMLHtlI4RT/Nk4E14owOEDBY7tIF19KSPk8VSxC0+tuTIRPhRLUPjAASQ7RW4aYQiTlIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870531; c=relaxed/simple;
	bh=ecpwxH1pmg1Z/UKS5i8kqGx5neyB2HMD4sQNtwuxXsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVGWQGw4ksTa4ycNok0z79a8bKP7+pSUeJN8lm6XYeSIlh4kh7e5pC4vwtbgPLquXVYFIY+ZROvJr6Wsbh8uWAeI2swupLTWbZdcy147UsA+WJ4IMuEyOf/3VswW/7nyS6u7a5oKAo7arhdOVleKWrKR+5dh6CpmGHGTnzyixxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CE09Ao+A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hRHJbVWE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CE09Ao+A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hRHJbVWE"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EA921140267;
	Tue, 18 Feb 2025 04:22:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 04:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870528;
	 x=1739956928; bh=i+WtZami/fBgkJNDJiOZho+AnV8lfKNIvDxD/ST5Zyw=; b=
	CE09Ao+AmAR9D7fa+zXvCAbJwtzGQ2MC+kO/o4HMItNlxv13E03kuBZx6zoakufi
	fcc3CdleOScrBdJ4jxG55ktcQjyOifwSy/QZC8FQSHZDEq9IGoE5CRW2ZuQ2KYA5
	UQsE/8YtBWg89aTvjOG154Vx0/4D20EBooamqBquez+evvsGC3I8svlZ/4LuFEYZ
	O3zO5vuHR5Ilman842S+mQtkHtrxcZihqN3OROm+rKscVfZE+4hIWEytOpe/vfk3
	QGYP/cq840ZBivSDC5NtFDdLS4NK76XRzmQ6eX6QrLYQ5sWt9h9rDK8Hg6VeBmpR
	ixBHgOBH/diN3Y/qn0gNiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870528; x=
	1739956928; bh=i+WtZami/fBgkJNDJiOZho+AnV8lfKNIvDxD/ST5Zyw=; b=h
	RHJbVWE/aJKFIM6E7xr80yLPSn0EN+JSO/lA9vnt+K/6QtzRkm7BcQYetB/pSzB7
	CWk1tPoqqGIG7HWid7sEryYbADLMJGRXb66It9ig984c/422v6UhJBOuYnfC3rXD
	ODEQaa5Fpoqr78YTMAzKco6OpQZ9EKc/aJ1g8edR/GbNkWDJiMfeNjTbxjZhNf3K
	EbveuxeTjKv1wZGtCrPuIIXsi4lqMvrQMgsTBBBhCTpMjPFbRpRbDZ02LQnR+s/P
	S5AIxht0UCztTUgpMIuvpmea14u+Tn+WNAdWzONcGu3PEMPeqWCTWSunpnMJ2w62
	/QKqOre2Jaak+ZKe6cgeA==
X-ME-Sender: <xms:P1G0Zz6OQHXSIEsaLSvkshxJe_2i-iCO8_ceP00lMfAt8IRACUGjkA>
    <xme:P1G0Z45gZhk_p8aLBlMV-Tv-tivvv3Uty-kc52dnHp42qi0r4afXOWv14lsg_V3SX
    7UJaXwfcysdA5jZeA>
X-ME-Received: <xmr:P1G0Z6cIn-klLMXZq8J431ebh8yHWdi5PhtHEwzyXas5UOoBAoOyvR3TKlYcBTklwVyUS6ssQxQaGQZDBTbtIfLvMJTvScVT9425s5QSVVt1hNw2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhho
    mhhsohhnrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpth
    htohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:P1G0Z0IlVGvoaHaRdgdkDCVqqrcNEZKMEQKGXs5IuJxrznrEzd1rxw>
    <xmx:P1G0Z3LtaB1JhIzrwMwJSIzphMRGrlClDamPc1cf0ljg4GcmgVeuyQ>
    <xmx:P1G0Z9whAA1l7cGl1pmkskOzomcCj5K1rv5nbHantLuEejU59Li9hQ>
    <xmx:P1G0ZzKk5xgG2s61cI9ele01T48dlE_zzDkQeHieW9vcn42Raidgzw>
    <xmx:QFG0Z0oqgTJ9b-RxXcB77GyR9QHoK9EwpuA8GPGUUadZ6P6yCeRTBQ9L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:22:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f9fd9ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:22:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:50 +0100
Subject: [PATCH v6 14/18] reftable/basics: introduce `REFTABLE_UNUSED`
 annotation
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-14-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Introduce the `REFTABLE_UNUSED` annotation and replace all existing
users of `UNUSED` in the reftable library to use the new macro instead.

Note that we unconditionally define `MAYBE_UNUSED` in the exact same
way, so doing so unconditionally for `REFTABLE_UNUSED` should be fine,
too.

Suggested-by: Toon Claes <toon@iotcl.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h      |  2 ++
 reftable/blocksource.c |  6 +++---
 reftable/iter.c        | 10 +++++-----
 reftable/record.c      | 26 +++++++++++++-------------
 reftable/writer.c      |  2 +-
 5 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 59000798f0b..fd59cbb7720 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -16,6 +16,8 @@ license that can be found in the LICENSE file or at
 #include "system.h"
 #include "reftable-basics.h"
 
+#define REFTABLE_UNUSED __attribute__((__unused__))
+
 struct reftable_buf {
 	size_t alloc;
 	size_t len;
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 02972c46f4b..78c1be23373 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -13,14 +13,14 @@ license that can be found in the LICENSE file or at
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 
-static void reftable_buf_return_block(void *b UNUSED, struct reftable_block *dest)
+static void reftable_buf_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest)
 {
 	if (dest->len)
 		memset(dest->data, 0xff, dest->len);
 	reftable_free(dest->data);
 }
 
-static void reftable_buf_close(void *b UNUSED)
+static void reftable_buf_close(void *b REFTABLE_UNUSED)
 {
 }
 
@@ -67,7 +67,7 @@ static uint64_t file_size(void *b)
 	return ((struct file_block_source *)b)->size;
 }
 
-static void file_return_block(void *b UNUSED, struct reftable_block *dest UNUSED)
+static void file_return_block(void *b REFTABLE_UNUSED, struct reftable_block *dest REFTABLE_UNUSED)
 {
 }
 
diff --git a/reftable/iter.c b/reftable/iter.c
index b2ffb09c16b..f520382e700 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -25,17 +25,17 @@ int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
 	return it->ops->next(it->iter_arg, rec);
 }
 
-static int empty_iterator_seek(void *arg UNUSED, struct reftable_record *want UNUSED)
+static int empty_iterator_seek(void *arg REFTABLE_UNUSED, struct reftable_record *want REFTABLE_UNUSED)
 {
 	return 0;
 }
 
-static int empty_iterator_next(void *arg UNUSED, struct reftable_record *rec UNUSED)
+static int empty_iterator_next(void *arg REFTABLE_UNUSED, struct reftable_record *rec REFTABLE_UNUSED)
 {
 	return 1;
 }
 
-static void empty_iterator_close(void *arg UNUSED)
+static void empty_iterator_close(void *arg REFTABLE_UNUSED)
 {
 }
 
@@ -143,8 +143,8 @@ static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
 	return 0;
 }
 
-static int indexed_table_ref_iter_seek(void *p UNUSED,
-				       struct reftable_record *want UNUSED)
+static int indexed_table_ref_iter_seek(void *p REFTABLE_UNUSED,
+				       struct reftable_record *want REFTABLE_UNUSED)
 {
 	return REFTABLE_API_ERROR;
 }
diff --git a/reftable/record.c b/reftable/record.c
index 9a1edf39a02..142853d5070 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -490,7 +490,7 @@ static void reftable_obj_record_release(void *rec)
 }
 
 static int reftable_obj_record_copy_from(void *rec, const void *src_rec,
-					 uint32_t hash_size UNUSED)
+					 uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_obj_record *obj = rec;
 	const struct reftable_obj_record *src = src_rec;
@@ -528,7 +528,7 @@ static uint8_t reftable_obj_record_val_type(const void *rec)
 }
 
 static int reftable_obj_record_encode(const void *rec, struct string_view s,
-				      uint32_t hash_size UNUSED)
+				      uint32_t hash_size REFTABLE_UNUSED)
 {
 	const struct reftable_obj_record *r = rec;
 	struct string_view start = s;
@@ -563,8 +563,8 @@ static int reftable_obj_record_encode(const void *rec, struct string_view s,
 
 static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 				      uint8_t val_type, struct string_view in,
-				      uint32_t hash_size UNUSED,
-				      struct reftable_buf *scratch UNUSED)
+				      uint32_t hash_size REFTABLE_UNUSED,
+				      struct reftable_buf *scratch REFTABLE_UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_obj_record *r = rec;
@@ -618,13 +618,13 @@ static int reftable_obj_record_decode(void *rec, struct reftable_buf key,
 	return start.len - in.len;
 }
 
-static int not_a_deletion(const void *p UNUSED)
+static int not_a_deletion(const void *p REFTABLE_UNUSED)
 {
 	return 0;
 }
 
 static int reftable_obj_record_equal_void(const void *a, const void *b,
-					  uint32_t hash_size UNUSED)
+					  uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_obj_record *ra = (struct reftable_obj_record *) a;
 	struct reftable_obj_record *rb = (struct reftable_obj_record *) b;
@@ -1054,7 +1054,7 @@ static int reftable_index_record_key(const void *r, struct reftable_buf *dest)
 }
 
 static int reftable_index_record_copy_from(void *rec, const void *src_rec,
-					   uint32_t hash_size UNUSED)
+					   uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_index_record *dst = rec;
 	const struct reftable_index_record *src = src_rec;
@@ -1075,13 +1075,13 @@ static void reftable_index_record_release(void *rec)
 	reftable_buf_release(&idx->last_key);
 }
 
-static uint8_t reftable_index_record_val_type(const void *rec UNUSED)
+static uint8_t reftable_index_record_val_type(const void *rec REFTABLE_UNUSED)
 {
 	return 0;
 }
 
 static int reftable_index_record_encode(const void *rec, struct string_view out,
-					uint32_t hash_size UNUSED)
+					uint32_t hash_size REFTABLE_UNUSED)
 {
 	const struct reftable_index_record *r =
 		(const struct reftable_index_record *)rec;
@@ -1097,10 +1097,10 @@ static int reftable_index_record_encode(const void *rec, struct string_view out,
 }
 
 static int reftable_index_record_decode(void *rec, struct reftable_buf key,
-					uint8_t val_type UNUSED,
+					uint8_t val_type REFTABLE_UNUSED,
 					struct string_view in,
-					uint32_t hash_size UNUSED,
-					struct reftable_buf *scratch UNUSED)
+					uint32_t hash_size REFTABLE_UNUSED,
+					struct reftable_buf *scratch REFTABLE_UNUSED)
 {
 	struct string_view start = in;
 	struct reftable_index_record *r = rec;
@@ -1120,7 +1120,7 @@ static int reftable_index_record_decode(void *rec, struct reftable_buf key,
 }
 
 static int reftable_index_record_equal(const void *a, const void *b,
-				       uint32_t hash_size UNUSED)
+				       uint32_t hash_size REFTABLE_UNUSED)
 {
 	struct reftable_index_record *ia = (struct reftable_index_record *) a;
 	struct reftable_index_record *ib = (struct reftable_index_record *) b;
diff --git a/reftable/writer.c b/reftable/writer.c
index 913b971b591..ce55a1deb06 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -649,7 +649,7 @@ static void write_object_record(void *void_arg, void *key)
 done:;
 }
 
-static void object_record_free(void *void_arg UNUSED, void *key)
+static void object_record_free(void *void_arg REFTABLE_UNUSED, void *key)
 {
 	struct obj_index_tree_node *entry = key;
 

-- 
2.48.1.666.gff9fcf71b7.dirty

