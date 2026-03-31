Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDFF3D5659
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956433; cv=none; b=nAzAkceMRzJPyd6eh855knCpg/3/Vxh1biCSDXzL3rV44iCOFXXY18aciSwQDxqxHnoHNbl2fvd557hUmTrJBZtd5kcklr2uuGpvY5IJBehzCHFARAQofpRt8I/GMQLxoFdSc/P2XEsXCoHIo+jS8n4ezIK8JctF5QATRmyfqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956433; c=relaxed/simple;
	bh=y577JHaybvDYdpL6LOsg060Ds+x5wkvPakJUpA+ez40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OPzAgCwuwzAZMImnaB3PMqQZcF4/X7az8A+29Hc1A8XwGsCBLxKsnlHLMfTmVVrjHZ6JU2HiM8hnydwpMr9o58vDx/FrNwwOEzVyo6DoY6TW40rKd4HsnaWR5+izIgZJjJ06OntWCQTbm/hJDiDIpUd2MPQr2F6cbQJptybGL2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nfKXARr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eqBNp8ac; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nfKXARr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eqBNp8ac"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3708C14001A3
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:11 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 31 Mar 2026 07:27:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956431;
	 x=1775042831; bh=J+PH+7VMGYgRMn4JnH3fJAiLHZG5GnllQ5pY/7Sr5mo=; b=
	nfKXARr/1VxfFJU0iogPrPoTAnQdfoMSxnkE7Sj1p+TYcfLHFPbSWX/8VS0+hBQO
	l782adAIJ+DB+oaJmkneRfe/9ftuM4tZ7f6l/HTkKiLgqN6KmLdtRovxVCtMZzEt
	NwIPAhmx5rX+BGA4KVTp2LtCfeFTBjDvQNmmEEyiH8gX3x2XG7X8fiYN49OJ9PRq
	UPfRjtmKAicLq5K4/D2d0CW6zO/o3RHagbNm55AzduMbqCWHkbjA2bM91Psj+HnH
	UzdXctZLa5k0uEr7QQcqheb0ayq4OEBMzISbz8wnGDiorYXZMdJsCev668Vq0hch
	x2thc5DWdtMnUzKkxemigw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956431; x=
	1775042831; bh=J+PH+7VMGYgRMn4JnH3fJAiLHZG5GnllQ5pY/7Sr5mo=; b=e
	qBNp8acIt3zVWoZ3H3JdfOB5qwBGRn7ClmNeegft5yk7WXoDmj+ZPzAmQLOr2NOI
	+Jvapcr7T5SpSmRA7+LOqcTwUdcHuRww1J/Q2M3XQAXCV5TLZGbJojlabuqsm3P7
	J/7zr87CUD84acvHuvllQorXvfUmRk+1rncQQIPZ5jeddK16zyzvr0/MfoDKg3WL
	MmYo4DYrYwBMzm8Sv53IoKncZeYaUNDOpaMLxOlEO+n+0reAhoOB4sy3BpLx03xQ
	KpueSfyOlWMBq3IymMvgdR7yRPfMiEpp35y/NmRItO06tsqc45N1RkGgUFwRweM1
	bzbJRLsc9SKO6Nl5t7Odg==
X-ME-Sender: <xms:j6_LaQsoOeRY_hb8JuK3KTT2SyCxqhqADZuf_jDQJ9qHzWb6-GDPUQ>
    <xme:j6_LaUYDFKE0B4tuinLFJcFa-OGZrexmo9seo-Wh7yrcPUwwsaohsunGIe8yOeWXR
    YrQEaIABRrjouVq1afgp_PguTnNCqg1-uJAAPdvn6EoORzUYiU>
X-ME-Received: <xmr:j6_LaRa0IMWi7QqYjDcRMUPnxjmcqhlhAuWDTpd9tdIbYg9Pisq8aU3LXjvj0BchWjD11KXCNO8YPlQM2iZsFBOeTaQSRN10ekv2f42C-A0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j6_LaYXyddGznqCym9AckPoAKGGLcI8NDdclBqD_e5wKQEYI4Spgog>
    <xmx:j6_LaQ223LA4mtR3q9gYtnhuvgZh7Zg0JWk2EDcjQU21Cyo3ueuXww>
    <xmx:j6_LaXYeMHUoyP3WJ5jQ-ns-Go7dM65QNMukD05PkEw2tXgMwoen4A>
    <xmx:j6_LaboFopjTJy8wBohPU1PPiShU-0dgAG4JaHcQNWDgme3AOYRLnA>
    <xmx:j6_LaTftD0Ei-OS3w9fLDgscrKIqRxGs2AGn_scUMN6i0q7hisJSJ011>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e927c219 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:27:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:52 +0200
Subject: [PATCH 6/6] reftable: introduce "reftable-system.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-6-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

We're including a couple of standard headers like <stdint.h> in a bunch
of locations, which makes it hard for a project to plug in their own
logic for making required functionality available. For us this is for
example via "compat/posix.h", which already includes all of the system
headers relevant to us.

Introduce a new "reftable-system.h" header that allows projects to
provide their own headers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-basics.h      | 2 +-
 reftable/reftable-block.h       | 3 +--
 reftable/reftable-blocksource.h | 2 +-
 reftable/reftable-error.h       | 2 ++
 reftable/reftable-fsck.h        | 1 +
 reftable/reftable-iterator.h    | 1 +
 reftable/reftable-merged.h      | 1 +
 reftable/reftable-record.h      | 2 +-
 reftable/reftable-stack.h       | 1 +
 reftable/reftable-system.h      | 7 +++++++
 reftable/reftable-table.h       | 1 +
 reftable/reftable-writer.h      | 4 +---
 reftable/system.h               | 3 +--
 13 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
index 6d73f19c85..dc8622682d 100644
--- a/reftable/reftable-basics.h
+++ b/reftable/reftable-basics.h
@@ -9,7 +9,7 @@
 #ifndef REFTABLE_BASICS_H
 #define REFTABLE_BASICS_H
 
-#include <stddef.h>
+#include "reftable-system.h"
 
 /* A buffer that contains arbitrary byte slices. */
 struct reftable_buf {
diff --git a/reftable/reftable-block.h b/reftable/reftable-block.h
index 0b05a8f7e3..94c79b5c58 100644
--- a/reftable/reftable-block.h
+++ b/reftable/reftable-block.h
@@ -9,8 +9,7 @@
 #ifndef REFTABLE_BLOCK_H
 #define REFTABLE_BLOCK_H
 
-#include <stdint.h>
-
+#include "reftable-system.h"
 #include "reftable-basics.h"
 #include "reftable-blocksource.h"
 #include "reftable-iterator.h"
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index f5ba867bd6..40c1e94646 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -9,7 +9,7 @@
 #ifndef REFTABLE_BLOCKSOURCE_H
 #define REFTABLE_BLOCKSOURCE_H
 
-#include <stdint.h>
+#include "reftable-system.h"
 
 /*
  * Generic wrapper for a seekable readable file.
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index d100e0df92..0535e1478b 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -9,6 +9,8 @@
 #ifndef REFTABLE_ERROR_H
 #define REFTABLE_ERROR_H
 
+#include "reftable-system.h"
+
 /*
  * Errors in reftable calls are signaled with negative integer return values. 0
  * means success.
diff --git a/reftable/reftable-fsck.h b/reftable/reftable-fsck.h
index 007a392cf9..340fc7762e 100644
--- a/reftable/reftable-fsck.h
+++ b/reftable/reftable-fsck.h
@@ -1,6 +1,7 @@
 #ifndef REFTABLE_FSCK_H
 #define REFTABLE_FSCK_H
 
+#include "reftable-system.h"
 #include "reftable-stack.h"
 
 enum reftable_fsck_error {
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
index af582028c2..a050cc153b 100644
--- a/reftable/reftable-iterator.h
+++ b/reftable/reftable-iterator.h
@@ -9,6 +9,7 @@
 #ifndef REFTABLE_ITERATOR_H
 #define REFTABLE_ITERATOR_H
 
+#include "reftable-system.h"
 #include "reftable-record.h"
 
 struct reftable_iterator_vtable;
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index e5af846b32..02a9966835 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -9,6 +9,7 @@
 #ifndef REFTABLE_MERGED_H
 #define REFTABLE_MERGED_H
 
+#include "reftable-system.h"
 #include "reftable-iterator.h"
 
 /*
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 385a74cc86..e18c538238 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -9,8 +9,8 @@
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
 
+#include "reftable-system.h"
 #include "reftable-basics.h"
-#include <stdint.h>
 
 /*
  * Basic data types
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index c2415cbc6e..5f7be573fa 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -9,6 +9,7 @@
 #ifndef REFTABLE_STACK_H
 #define REFTABLE_STACK_H
 
+#include "reftable-system.h"
 #include "reftable-writer.h"
 
 /*
diff --git a/reftable/reftable-system.h b/reftable/reftable-system.h
new file mode 100644
index 0000000000..f90c415182
--- /dev/null
+++ b/reftable/reftable-system.h
@@ -0,0 +1,7 @@
+#ifndef REFTABLE_SYSTEM_H
+#define REFTABLE_SYSTEM_H
+
+#define MINGW_DONT_HANDLE_IN_USE_ERROR
+#include "compat/posix.h"
+
+#endif
diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
index 5f935d02e3..d7666b53a1 100644
--- a/reftable/reftable-table.h
+++ b/reftable/reftable-table.h
@@ -9,6 +9,7 @@
 #ifndef REFTABLE_TABLE_H
 #define REFTABLE_TABLE_H
 
+#include "reftable-system.h"
 #include "reftable-iterator.h"
 #include "reftable-block.h"
 #include "reftable-blocksource.h"
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 1e7003cd69..065dd93dc6 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -9,11 +9,9 @@
 #ifndef REFTABLE_WRITER_H
 #define REFTABLE_WRITER_H
 
+#include "reftable-system.h"
 #include "reftable-record.h"
 
-#include <stdint.h>
-#include <unistd.h> /* ssize_t */
-
 /* Writing single reftables */
 
 /* reftable_write_options sets options for writing a single reftable. */
diff --git a/reftable/system.h b/reftable/system.h
index dffc717bd4..52f964c04b 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -11,8 +11,7 @@
 
 /* This header glues the reftable library to the rest of Git */
 
-#define MINGW_DONT_HANDLE_IN_USE_ERROR
-#include "compat/posix.h"
+#include "reftable-system.h"
 #include "compat/zlib-compat.h"
 
 #define REFTABLE_INLINE(type) static inline type

-- 
2.53.0.1185.g05d4b7b318.dirty

