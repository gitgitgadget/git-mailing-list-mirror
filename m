Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0D19D899
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775714; cv=none; b=UK7550I2HDmAaFhq2nTdWu+3IAx/SMNqz750MJtYn1E1kgIf5CSOvduCucWOhNaTixW2mzMvaByV16e4updDXPK+So+CW8r9ZeqIbybOUZTKcWYi7EF5u7zWa+hjvIYaLsr1C3kQ8qX1ogK9cSYqldaoRgcuoyZEVkYtTRpXWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775714; c=relaxed/simple;
	bh=FLTImrbvvvFgAkSveQ7xVh//0HjBGYKPh1lsSNOHEow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBsh2ebjHa8sbTH2sAv2FwvCtxcexKWkVR9RfWxmHVel0m+sxsW3hztMXzcZw9jNNFRu49wDGVbjvbeo9XXWD59ONXQCHn+jiux1WhM2F4SX5+yWk2S5ipHTuuIrXy7oHZC21uOr2C12W5r/EnRRvU1OhKeGD8JvX00ii7G5wrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SyZ01/HO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wmh+ii+M; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SyZ01/HO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wmh+ii+M"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5A01F114099F;
	Tue,  1 Oct 2024 05:41:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 01 Oct 2024 05:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775711; x=1727862111; bh=dV4fHV40tW
	wTaQ2ycbPOM+RJxkvB0dTi+16vDpN+s1c=; b=SyZ01/HOFt8oyV++7Lq7qwtkI1
	E2cg1JKLl1RbTphS0O7sbL97dIQquhoXX0S5V1vg87BVxy44xsxWOf1Z/KWWcnv0
	lbAdViaPbDloxEBhodPeqKbS976QABifBONJTTnAt5KwmxPp5nXlXxqCQcswI3z1
	PCymXW8u50mLYnh6Cmr7OijoTqzuvZSrXPS/ztSMo0uiUcA0fgHkw134+AsSryay
	tkWtzQzQGZ1y1wrNP/gac3gDiF+i/s/C8ob//MEG3qDCJ7BE2i0HRV2C+WPVTq1d
	pkNZoQk6/446m3rJsDQGMWTz8I8bhsdMKGivO/yhBJtALtb40BlZ4+wIpojg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775711; x=1727862111; bh=dV4fHV40tWwTaQ2ycbPOM+RJxkvB
	0dTi+16vDpN+s1c=; b=Wmh+ii+MsMQO9C94OR9Z5rig7f0Vym0EKGYhhfDsry2R
	/d0hWDR/gnU3xgT5iU206UW0sgIJFyht+8TXspOkbdhdu0AkwYs1njzbvD5XHqLJ
	V2cIgKuOREh6OxwmNRnOR38Ua0uzvNZmPc+EEULEavwet8cP8FlQa8FsnGztIvui
	lIXuGLv6qWqpm7/DjLQBUCb+7cjb4HLN1yr3MGBa3jk+CYnOFX6dmqG/yHvuz8ao
	smzGqqOB7u2Ovr4CTScMtVLZBH8kLzNQr3zS9vysUguryKt29TZDFXa7dUOa46uO
	wVy46HiW0gGNyHySVzJ89hbpPE46AXWDxsgPLNouNw==
X-ME-Sender: <xms:38P7ZiWG82xpp2Vqln_FvrMxc7QVsFbHMlCdyLf2QB4oLDUHCcVDvQ>
    <xme:38P7Zul3RzYvjcr4ntVAzBZcZIGK7rSDcgzcuNh-hLydX11-ctuI1_VBLyoPwGOdX
    iY_30mKtzFAxBIFzg>
X-ME-Received: <xmr:38P7Zma8VeKygjLeJ3eyFTeN0yIePJzdERiIC2sN4LzqlE3SStaaEJhoRBvgTScZojFcDsB7h4tBQQASNT1wZaH1ECV02YmAJ4_Kb51wJ-b5dg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueeiueduhfevhfekiefgkefggeeljedtffetheehtefh
    hfdvledukeekfffhffdvnecuffhomhgrihhnpehgohhoghhlvgdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
X-ME-Proxy: <xmx:38P7ZpVHsMwTPPS1QGljhXY8EfK76LAz92aYD5wsmaudzwyFo86d1A>
    <xmx:38P7Zskc_vbknnUCArRkd8G6jIhwnKMNiIDZ0ekGBTQVTS0C9js8_w>
    <xmx:38P7ZudzQdCgUm38VyC3fb1jMk_lfWH5lXqGtPHlbG9AmxC7wkZ_Uw>
    <xmx:38P7ZuF0kReEecgPlTH67jb6M6abyD-YU5E81srOh40JOSWlgR0t-w>
    <xmx:38P7ZtBezlkBYIu8cmZpOQ1yEMs-1lcW-g1YgkyOowu0tYzVwnQO0iSV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:41:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54725d2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:02 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:41:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 02/25] reftable/basics: merge "publicbasics" into "basics"
Message-ID: <fe55051cb79015960729d7a06f21f43138585177.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

