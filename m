Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB29E1E767D
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866533; cv=none; b=JSLbDiHyipdCWV5OOBeJkjJzSWku4K6golp+qCJE7Co8JwxrpXlyuzSFZfyozkBiOmyH+qcRs4wN5MWPXuSg64VdzqmbdqHfxh1k76vapPzcqF5E3+0nNhf0ca+QNIVXVYGkA7T3KwEoK+rP0Sgj9HzAl6QkZrxjtwvJUSEMSPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866533; c=relaxed/simple;
	bh=FLTImrbvvvFgAkSveQ7xVh//0HjBGYKPh1lsSNOHEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6yqAgjPoDOqV5TMR58/l+FFzp0n7K6DkUVRidweGZXWibrDiS2qtGZ7NX2iuT1YC8tB/HfArlqK3ABHgvTptaank8N9vUVotL3wJfoXlnLLNi8xcvOSFHGXRquqSe7UMndN29O/DLWDHpd+rBHDY1tAdU/euDiOpzlC/ipmO28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VcILhMk2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CFae8vwp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VcILhMk2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CFae8vwp"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BC191140223;
	Wed,  2 Oct 2024 06:55:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Oct 2024 06:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866531; x=1727952931; bh=dV4fHV40tW
	wTaQ2ycbPOM+RJxkvB0dTi+16vDpN+s1c=; b=VcILhMk2jBNPE0S9nliFVH9WUy
	xj8XOHyHJdUdS85cGdHdSQh62E5UltRv7kE4LUCGBqH/3Q+ora9hTGmmp4W6Oi++
	QZ9urnDiGB8dOJwaJ1An8fzYpvb66mW3jPGlEr75OH1HQoJMEpv/Z+g/SOXF1r/6
	XQwb7JqimyubTCq+9W0CwYIk13JHp7UcidqFQZe7f4Pa9LUI25sp4C9REwAxQcB4
	AkLCFTsPdNgop2PNhNziPaL1SIaUna21yTilhn2naVodcHiQTro2JN9NOGxyvUoO
	lwGissHjdt74wc8FU42jFAOZIzqfvsKJYzC+Rb0KnROAySxu8pWgjXqhGPSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866531; x=1727952931; bh=dV4fHV40tWwTaQ2ycbPOM+RJxkvB
	0dTi+16vDpN+s1c=; b=CFae8vwpoPF/OXBB0NMA1FQwCbOISezor15ewN5RJ6fB
	FenT/u0w3vm2ap+DOtTTg4b5KTfoy2RkZ62EidcLcvthmbMxBG5Muik1pz1e89Uy
	xENddBom5fiErDIM84jCCkbmikt3IpsSKnfUX0U6gFLORHYMX8wSWq+NBTAqc89Q
	fCkm3JOuL+F+Y0wAMt+A7QAKdNgyas9qy9KoczcWdF+6C5mQIZedzmB/p4QTLvKU
	2WU3pbH2/XOZODDR4yloVlpZEZtrd7fc8L9cFq1aNb/4CFtQm42j16ZuGmCOXZw9
	MpKMErq5poIReVHEnHFlXsjSrVWSSQY4yGCazjr6qg==
X-ME-Sender: <xms:oib9Zsx2XF_gAs_3XLMQyCh_-IhPa7rcZl8fTbcA7kC1cren92tbpQ>
    <xme:oib9ZgT5H2EmrJWMR8QfcV7zKK443h6TCVKkpdwWj6lN8BiljHpojreMhhYdtTLvZ
    i3C0P3VJd9L5iEwhw>
X-ME-Received: <xmr:oib9ZuX2ZhOaOy2-uPVYXYHLaDQ7XGt-DxNn-k5S36ZCrh4StXHivekdsGqGuwEHQP5ISwpT5YwO6tLrdWwFwLCygyOQ87Cz81nttE7nQTP1D8lx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvth
    hhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdrrhesfigvsgdrug
    gvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:oib9ZqhJqDqbIg9yXkBbvWHEkOyf5jN_ADHmQnHSorgFWG1vUvdANQ>
    <xmx:oib9ZuAQ-P4HWIAyLcdJEKQVJc6_NBGcdM7oTX6GQwgDVTjmRgP_2w>
    <xmx:oib9ZrILL755iWnhewY0s9AhYRgdlSGPMUFJvxqsEETTUxzLsL0M8Q>
    <xmx:oib9ZlB4P9VbEzTeyOC63m050mATBdbG37tsYg76T8IPV1MOfGWESw>
    <xmx:oyb9Zh_BaVEdYGXhrXMMNGQXFalDTCojf0qzUXzxfF6L6slwHMs-Kg6t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5a57499 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:54:40 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 02/25] reftable/basics: merge "publicbasics" into "basics"
Message-ID: <fe55051cb79015960729d7a06f21f43138585177.1727866394.git.ps@pks.im>
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

The split between "basics" and "publicbasics" is somewhat arbitrary and
not in line with how we typically structure code in the reftable
library. While we do indeed split up headers into a public and internal
part, we don't do that for the compilation unit itself. Furthermore, the
declarations for "publicbasics.c" are in "reftable-malloc.h", which
isn't in line with our naming schema, either.

Fix these inconsistencies by:

  - Merging "publicbasics.c" into "basics.c".

  - Renaming "reftable-malloc.h" to "reftable-basics.h" as the public
    header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                   |  1 -
 reftable/basics.c          | 55 +++++++++++++++++++++++++++++++
 reftable/basics.h          |  3 ++
 reftable/publicbasics.c    | 66 --------------------------------------
 reftable/reftable-basics.h | 18 +++++++++++
 reftable/reftable-malloc.h | 18 -----------
 6 files changed, 76 insertions(+), 85 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

diff --git a/Makefile b/Makefile
index e3abf0ba83..39b10923d4 100644
--- a/Makefile
+++ b/Makefile
@@ -2683,7 +2683,6 @@ REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
-REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
diff --git a/reftable/basics.c b/reftable/basics.c
index 0058619ca6..cf072935c8 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -7,6 +7,49 @@ license that can be found in the LICENSE file or at
 */
 
 #include "basics.h"
+#include "reftable-basics.h"
+
+static void *(*reftable_malloc_ptr)(size_t sz);
+static void *(*reftable_realloc_ptr)(void *, size_t);
+static void (*reftable_free_ptr)(void *);
+
+void *reftable_malloc(size_t sz)
+{
+	if (reftable_malloc_ptr)
+		return (*reftable_malloc_ptr)(sz);
+	return malloc(sz);
+}
+
+void *reftable_realloc(void *p, size_t sz)
+{
+	if (reftable_realloc_ptr)
+		return (*reftable_realloc_ptr)(p, sz);
+	return realloc(p, sz);
+}
+
+void reftable_free(void *p)
+{
+	if (reftable_free_ptr)
+		reftable_free_ptr(p);
+	else
+		free(p);
+}
+
+void *reftable_calloc(size_t nelem, size_t elsize)
+{
+	size_t sz = st_mult(nelem, elsize);
+	void *p = reftable_malloc(sz);
+	memset(p, 0, sz);
+	return p;
+}
+
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *))
+{
+	reftable_malloc_ptr = malloc;
+	reftable_realloc_ptr = realloc;
+	reftable_free_ptr = free;
+}
 
 void put_be24(uint8_t *out, uint32_t i)
 {
@@ -121,3 +164,15 @@ int common_prefix_size(struct strbuf *a, struct strbuf *b)
 
 	return p;
 }
+
+int hash_size(uint32_t id)
+{
+	switch (id) {
+	case 0:
+	case GIT_SHA1_FORMAT_ID:
+		return GIT_SHA1_RAWSZ;
+	case GIT_SHA256_FORMAT_ID:
+		return GIT_SHA256_RAWSZ;
+	}
+	abort();
+}
diff --git a/reftable/basics.h b/reftable/basics.h
index c8fec68d4e..4e2e76014a 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -14,6 +14,7 @@ license that can be found in the LICENSE file or at
  */
 
 #include "system.h"
+#include "reftable-basics.h"
 
 /* Bigendian en/decoding of integers */
 
@@ -71,4 +72,6 @@ void *reftable_calloc(size_t nelem, size_t elsize);
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
 
+int hash_size(uint32_t id);
+
 #endif
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
deleted file mode 100644
index 44b84a125e..0000000000
--- a/reftable/publicbasics.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "reftable-malloc.h"
-
-#include "basics.h"
-
-static void *(*reftable_malloc_ptr)(size_t sz);
-static void *(*reftable_realloc_ptr)(void *, size_t);
-static void (*reftable_free_ptr)(void *);
-
-void *reftable_malloc(size_t sz)
-{
-	if (reftable_malloc_ptr)
-		return (*reftable_malloc_ptr)(sz);
-	return malloc(sz);
-}
-
-void *reftable_realloc(void *p, size_t sz)
-{
-	if (reftable_realloc_ptr)
-		return (*reftable_realloc_ptr)(p, sz);
-	return realloc(p, sz);
-}
-
-void reftable_free(void *p)
-{
-	if (reftable_free_ptr)
-		reftable_free_ptr(p);
-	else
-		free(p);
-}
-
-void *reftable_calloc(size_t nelem, size_t elsize)
-{
-	size_t sz = st_mult(nelem, elsize);
-	void *p = reftable_malloc(sz);
-	memset(p, 0, sz);
-	return p;
-}
-
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *))
-{
-	reftable_malloc_ptr = malloc;
-	reftable_realloc_ptr = realloc;
-	reftable_free_ptr = free;
-}
-
-int hash_size(uint32_t id)
-{
-	switch (id) {
-	case 0:
-	case GIT_SHA1_FORMAT_ID:
-		return GIT_SHA1_RAWSZ;
-	case GIT_SHA256_FORMAT_ID:
-		return GIT_SHA256_RAWSZ;
-	}
-	abort();
-}
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
new file mode 100644
index 0000000000..6e8e636b71
--- /dev/null
+++ b/reftable/reftable-basics.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_BASICS_H
+#define REFTABLE_BASICS_H
+
+#include <stddef.h>
+
+/* Overrides the functions to use for memory management. */
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *));
+
+#endif
diff --git a/reftable/reftable-malloc.h b/reftable/reftable-malloc.h
deleted file mode 100644
index 5f2185f1f3..0000000000
--- a/reftable/reftable-malloc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef REFTABLE_H
-#define REFTABLE_H
-
-#include <stddef.h>
-
-/* Overrides the functions to use for memory management. */
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *));
-
-#endif
-- 
2.47.0.rc0.dirty

