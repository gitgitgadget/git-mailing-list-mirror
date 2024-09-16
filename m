Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6618E152517
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489705; cv=none; b=SqLxOfZEQ7xnsD+uhhHLYiWRIgu2CCgbOg5bi2fvyH6l7Maw2W4wZ/nTLaheT2WmWAZW/+qZ+7Req63LjE1Vz6KecmPgsCwWrHFRnAQDDV+pVIzIwAmGpBSXNf8p5gcBe/cus6YFkOFebiORpUamoiL26iRDNHsqPa7kqFU5dzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489705; c=relaxed/simple;
	bh=BNYeULamOjMjVaNeUf8eIfRGJaC/f+XJXuV+jF56tVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8+DZk66FBstIci/2zV+vEB2S7GRfQnqW2bOLWa/8AxXN+I1CqiyH86hhTS4bSAS+0sLkwBkXROg9911LR2U5n5NzTtzbtjFHQIRG93rQHyaZrD4oKPCJcyHxUu1c8UCX94DNOdI2CGSyXlkjOk7BZ93x/tqLu5GuHfN2cXbfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ddvoUevW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dKz6dtZC; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ddvoUevW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dKz6dtZC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8280013801E0;
	Mon, 16 Sep 2024 08:28:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Sep 2024 08:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489702; x=1726576102; bh=ISlQJ5eYBr
	Z0YIvKGLKOwRLd8kul4jZ1oElPD3Bekt0=; b=ddvoUevWR4NwtolothcuexMIEK
	aiwSPK4D4mCZapbZQ4LD/Yy9aqOyB3YAxBtc/cLRoB2dxaEZ61dADuT3zCfhJSZM
	Q9TU60hyQK5JYGdpUMNxwOpoeqfMa/w8qd0vfDqMceLeZ9t3f7CSAP0UnGppLo/g
	jqqJIWYKY9LbGfTH6EmJvL3bWR2ltbr1l3NxWCMYRuDmX1F3K/BwOi0zL3jX0aqy
	vxgP534fpffo9M1lUSxQEIRtXhhXf8DX0lQ11wz8BvvAipTHiWSmYgRh4C11HGpa
	NN/06uasBhDITmAXPbrpSJAXIYVW/D/tY5df32UDRuLoVmuArEIQZKTMlG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489702; x=1726576102; bh=ISlQJ5eYBrZ0YIvKGLKOwRLd8kul
	4jZ1oElPD3Bekt0=; b=dKz6dtZCVi+VDtm8HnjDg6mmKFzR+O0CHAaBh8Yqs6v6
	gZpPbHH+tt5zzUe+Mdg8EaxE98MLWk2SV6bfCJ3h8Sv7+zRzypcR/DL0h+iNsChb
	YmFcpIWMNyUNVj9P0BBR6T017Ej6LOA5YCymYZK/DrrVwgo4oDTPBi5kiQla0WXu
	ADop+RAJZASqmz9SR+q0CG1XMGzAkNTTMYSWaoFIg5F2iJWFgSC92xSopZ/L5/Ih
	JTeibjce+Q9fzUBqjXNRj9o3f7nFFsrtLhZ2MIKQGFZoOzFqeoIxWyLQsGatxttj
	bUM4xK1Etrq+tIrJyrE4gQCW7iMHGYvtIX3O4IgCcg==
X-ME-Sender: <xms:ZiToZvyLFw1LMKEPvlOA4T64QmdjskxouwtsXE--ZiC6BFJLkf2COw>
    <xme:ZiToZnQeEZe7bF153zFTMT_VufqIvc74fst94Ja2Lmtuyha69icGmYG-rsqxCjPV1
    5__QCNras3xOijkBQ>
X-ME-Received: <xmr:ZiToZpWH9lWDYCApsGUtEkYSHc0nu9ahK0-5I1FU_XwsWGC3dazO-LS5gvQPkR5gW2rSF8spZfRQlVg0kJuDooOR0tEkXRYCSWN8rSWky0NFQyno>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:ZiToZpgEB5CGk_aV9PQSpAMJznUhaWJUuG_jQ7fW64K1WlLzfIbpKg>
    <xmx:ZiToZhBJgenusEQb58wod1P0es7VFb6rHISwsDM1-H3l9LdylFUheQ>
    <xmx:ZiToZiIYV0_JvZFWe5h8shY7sqhflQYAZQcn5G-EgmTivnkoUN1_ZQ>
    <xmx:ZiToZgBkuTWsNMmlz1n0RBfJTngpwwjmwpGm5L_b8fgBe_07Z7bsKw>
    <xmx:ZiToZkNoJqI1GmGv0QXwk3yENg2gaQUWPBoEH3ADS8Ojv_2JRfQSt4d4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 450de9c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:04 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 02/22] reftable/basics: merge "publicbasics" into "basics"
Message-ID: <4dcdf1d48ecf9a05cfa643d5a6165240898811a7.1726489647.git.ps@pks.im>
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
index e3abf0ba831..39b10923d49 100644
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
index 0058619ca67..cf072935c88 100644
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
index c8fec68d4e8..4e2e76014aa 100644
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
index 44b84a125e4..00000000000
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
index 00000000000..6e8e636b716
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
index 5f2185f1f34..00000000000
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
2.46.0.551.gc5ee8f2d1c.dirty

