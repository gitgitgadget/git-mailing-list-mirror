Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A5638737C
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115092; cv=none; b=U1pyAHYdArFvJqJmd9Tpex2Q7mLlOJgbtrjDIsvxOlXzc2J7irESNGzsU8cBAXVDuvYAL08E6h0t6fTrQYAmYk0fDeZTcTWdG0KfqU5tWh11/UUilB3m/Q7zAUnGyniFomzrG5I1c2Xceyu27Ifj0uyVZVPTgHv5tBViPQRR7nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115092; c=relaxed/simple;
	bh=f8f+I5kFjLD4mSxJjQeLjqgWB7O+47nLt7vY5qKeS68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vc8qF+F/hgfJlQVkZV1B7fUK+RgPCxuM+8r54l4V7BKkwvfJptx74cYMd8fzMflqitblCIHqlNPdIvAD3HI/rNrWW+/IjULsfBlqxcuBOTrwcUC2Yac9PTx16apW0MQFrh4nCIDPAds4vBvVDr7Z8JuMJIpvJ2DRyoaIYqdlL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mD/baZ1W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JgP2J5NF; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mD/baZ1W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JgP2J5NF"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id DCA4D1D0033F;
	Thu,  2 Apr 2026 03:31:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 02 Apr 2026 03:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115090;
	 x=1775201490; bh=DM9Gs2/77Haa1c/jfSwWTDHEqJF02pSpKUHLpJg1614=; b=
	mD/baZ1W9i/v+eyd+cK+SnmlwYXKWtHdxojwLEQxPpSojj/szfkqx1DBFRw3rEdb
	JAOYV8Orzw9dzZsm/0fjxkpkzgKJZDqN4hb2xTYi6HVap0OAEwb54RFKJklKGkp4
	h2XXFRl8kGyJWvUGGwd+1aQADvM1qZk5MIA3HPaH3RXMkrj4rDyxBQd2RxXgTWI6
	/dVssomi7qiyX0MzkYpe2GfVg7jn8771YKcYFP5TXMLvq79JBBNt8GVYAMKjmv9Y
	IFjz6olFmuZlmx+zZtr/iacxy71guCzOfcCzgJ3gw2v4pwej3BgkoZNJKmlCk6yU
	1T/rh9kuaV7UTnKD006Y0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115090; x=
	1775201490; bh=DM9Gs2/77Haa1c/jfSwWTDHEqJF02pSpKUHLpJg1614=; b=J
	gP2J5NFsHAlfOO9AHXA3Pp6d7gq/lf+/7E9wb2XuAuujDJna4vvr84rgCI10gofm
	3u+T9WxO5Mi1A3w23KNgHHd7VSzfEOsMXhmL0xu9OuQAha0lmMpxVLZuTKTrpQP8
	mMtAtY83J5FvONamWEAh0VdeyUVzGW6RyGMqtnDbnfZ3fouBgtJwfVmqWyWLhSe0
	3UaQPF8rAc79m2uzxC0S0+xIVYHu2Wn/oupq75hq1Wv0ABxvJfe1J/KeL15cJbBY
	Zyo+yJ3xQ95pOHkHXVxzHxMd2dntHRLY1GyNcfmK2QtF6t6tjQY0rS0Ly7gCo13t
	yNzLJ14DknEK0jp17CvJQ==
X-ME-Sender: <xms:UhvOaazBXkKbuYucmpJgLq3vVUoYTIIx22IXtzbxdFc4f87MhNldCw>
    <xme:UhvOadS-F3r_NBupS-vXOPU1RrZcJW-HR4LWiW_CNzr0eWQxor9X2irxbc6X18b7s
    wlclxws5l8xYpEK0-kjftfzqhsrYzFeHNm4ezgvHMuOYhVnv4kS>
X-ME-Received: <xmr:UhvOaRXG6IK8Vhl02DDjUYdCBa2DYjRl0ls2JI6xKs4s3aT1SV63E1sYuVIHtJOWG9PZXJJCH11JorrIM9sSfzoRkhLeCs7ipO6wOuBBSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthho
    ohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:UhvOafZCj4k2iZ2UipQN_FFhg4ZVrN6Ap0SN_qRomhPD8QtJaQSWVQ>
    <xmx:UhvOaX28MQTkfiCi89StDzu1CP7WNi4X_vcxXAIYdKPPwERU4VUFAA>
    <xmx:UhvOaRjdV_BwISxiXxQ8Pm5Wh93rLfGciJRYV9ITjBipxQuDdZqAcg>
    <xmx:UhvOabbGF3BBxQML3Ca2quTgIfEdAFlmp4J1woME7luKCbXm0cckmQ>
    <xmx:UhvOaQG6rDQAKW3pLXmiBAt4tP_ZK_gmY83guVbIYN0Q-yu1LV0AnbNh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 996ea0bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 09:31:14 +0200
Subject: [PATCH v2 1/5] reftable: introduce "reftable-system.h" header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-pks-reftable-portability-fixes-v2-1-bc110cee0ae0@pks.im>
References: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
In-Reply-To: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

We're including a couple of standard headers like <stdint.h> in a bunch
of locations, which makes it hard for a project to plug in their own
logic for making required functionality available. For us this is for
example via "compat/posix.h", which already includes all of the system
headers relevant to us.

Introduce a new "reftable-system.h" header that allows projects to
provide their own headers. This new header is supposed to contain all
the project-specific bits to provide the POSIX-like environment, and some
additional supporting code. With this change, we thus have the following
split in our system-specific code:

  - "reftable/reftable-system.h" is the project-specific header that
    provides a POSIX-like environment. Every project is expected to
    provide their own implementation.

  - "reftable/system.h" contains the project-independent definition of
    the interfaces that a project needs to implement. This file should
    not be touched by a project.

  - "reftable/system.c" contains the project-specific implementation of
    the interfaces defined in "system.h". Again, every project is
    expected to provide their own implementation.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-basics.h      |  2 +-
 reftable/reftable-block.h       |  3 +--
 reftable/reftable-blocksource.h |  2 +-
 reftable/reftable-error.h       |  2 ++
 reftable/reftable-fsck.h        |  1 +
 reftable/reftable-iterator.h    |  1 +
 reftable/reftable-merged.h      |  1 +
 reftable/reftable-record.h      |  2 +-
 reftable/reftable-stack.h       |  1 +
 reftable/reftable-system.h      | 15 +++++++++++++++
 reftable/reftable-table.h       |  1 +
 reftable/reftable-writer.h      |  4 +---
 reftable/system.h               | 11 +++++++----
 13 files changed, 34 insertions(+), 12 deletions(-)

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
index 0000000000..4a18a6a790
--- /dev/null
+++ b/reftable/reftable-system.h
@@ -0,0 +1,15 @@
+#ifndef REFTABLE_SYSTEM_H
+#define REFTABLE_SYSTEM_H
+
+/*
+ * This header defines the platform-specific bits required to compile the
+ * reftable library. It should provide an environment that bridges over the
+ * gaps between POSIX and your system, as well as the zlib interfaces. This
+ * header is expected to be changed by the individual project.
+ */
+
+#define MINGW_DONT_HANDLE_IN_USE_ERROR
+#include "compat/posix.h"
+#include "compat/zlib-compat.h"
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
index c54ed4cad6..a7eb6acd4a 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -9,11 +9,14 @@
 #ifndef SYSTEM_H
 #define SYSTEM_H
 
-/* This header glues the reftable library to the rest of Git */
+/*
+ * This header defines the platform-agnostic interface that is to be
+ * implemented by the project to make it work on their respective supported
+ * systems, and to integrate it into the project itself. This header is not
+ * expected to be changed by the individual project.
+ */
 
-#define MINGW_DONT_HANDLE_IN_USE_ERROR
-#include "compat/posix.h"
-#include "compat/zlib-compat.h"
+#include "reftable-system.h"
 
 /*
  * Return a random 32 bit integer. This function is expected to return

-- 
2.53.0.1323.g189a785ab5.dirty

