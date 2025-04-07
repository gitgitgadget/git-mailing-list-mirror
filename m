Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1172C253B77
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031788; cv=none; b=q6NF3feQzhtdEvl2dDTD20JwHBuXtfb/v0pKyibW1sWScPuJsZCyijWoo0sgqn9V4RUGCpxTUhmgrdgz8ZlWnP48E5x1H7hnZo/Nbklt/kc34hK5HOk8waw3Xhzb7W3buzzg4E6fzb1s03PTtBX4Gpn47rJDIAIK9833Y2/LQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031788; c=relaxed/simple;
	bh=GLyRQ4e+dTHSNrhNHOIVlTILH9u3BSUx03TMNOsITcg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gP2/8X70fm0Sv5iIRaPJ6f33fdbFW4CrhzQlUIMPARmnHkOwBqC6C03KpQWTmGoZe2+dO0qFHK5VyC4KGEtPAElFCr7iIvIuFEkAb5gRDZmCy6rZhqlfoZYGe47BMrsPLX1kV2XSryiBDbG95iXrEVeJVDI0O1nz2LY5qi+z5/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nE2K5QUS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pJrw1Deh; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nE2K5QUS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pJrw1Deh"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0DACA1380228;
	Mon,  7 Apr 2025 09:16:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 07 Apr 2025 09:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031785;
	 x=1744118185; bh=mNfctF1n7F9ALuXmHRaEGIW+LNfS6gGc78rc2CAT3S4=; b=
	nE2K5QUSbGWoC6eF7l5mrNoCPWtTBuDK8b1Ff2Ipb+3GD7Sq0+Y/tQ619a/xwojz
	C3c8P7MQ7K2fc6cLveauBK+iTzIx1fF6teZ2NAlLvMSarP1e1p9QMwvPYzacs62i
	tXgXwWyo4NRhMCRJt96F01X/uWyQ82dDi+fwvX/vK7rhP/fcnPNccBJgQuJBFowP
	nbcYONm5e21Zi/MapMNbb0orOQEjkLVO9h9xyy5AwS523pCQRTyigzbfQafakrdD
	EVwhWthbqbqfwFDX5X9eu04m0eW33aXX+CooosJE80sf0Ps/x7hwlIqZ2vUdKH9q
	JFAT2Fbk/7kwG0jz1Qxhyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031785; x=
	1744118185; bh=mNfctF1n7F9ALuXmHRaEGIW+LNfS6gGc78rc2CAT3S4=; b=p
	Jrw1DehwbjWz3otCnumybCO/hWTPlD185/6vEnNzKk7zjfkyXZdUm9smV5t2PIAS
	ibBb3zTH/GDO65Y1FApD6vvqEMPRTyhzFJmBonB3KSgEyLBdPgXyMnqPuIVIqtbw
	ey64h40I4WcQkXRGbiZAe05SmfaDKIH2TiLkpdmF0ChDCJRcKnsuRMzz6GdXPJJS
	nPFdNiJLE/WX4lza3QBINEa5IjfZp9dSq5fKhTRspWC8KkJy/EgO5BPN6ZBgxCHR
	HWRLCwP5d0ZR/cO/EGDWc5ZOIRce07STuowvceFlzEAeLTEX21oGZetjojwjHHyZ
	r40rQ7cekRR8ea5KSBf4Q==
X-ME-Sender: <xms:KNDzZ0Q3bDqeTaDUb2qLGR2ikzyBawiNYRtTGDcKwxPNT9V4HgCOig>
    <xme:KNDzZxy8YEzFKmbRYxnrh6fbUHC8H3T6MUzPbBTwX2AX5oOMSXYVGUB06F5hkMFWL
    i6IM9INaszzwRtXwg>
X-ME-Received: <xmr:KNDzZx2YYRfPy5SjIlIXQHdIc3y2GqMXD_zoMlAW25xjWAAbH827yTiqf4XpiaGFs-NVk-FUw8e_-pOEUhCXVaBxiWFJGaXSmVIi4KsFzArtOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedthfegfeejuefgieffvefhvedvfedtffdtgffh
    heevgfdtjedukefgkefgfeevtdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KNDzZ4A-10iZsuiL5MRFZS2vvHsaCOEc_lkus-fs206poAhGmrbscQ>
    <xmx:KNDzZ9hgEEAGsg1Q260zlrMeyGjD-gjdnKXs31i9_htvTvOJeb3LfQ>
    <xmx:KNDzZ0roARYEttx9HUNAtCC8MfaVWDqIlqPZaMVi3RoprWQSbwmCwQ>
    <xmx:KNDzZwj1V9jw4DbBj-Ht39u6lXT8GNppfSoYDiVHAsG5eArxciH0RA>
    <xmx:KdDzZxtf5Fy3k0QDYr8HXzIl-0ZDHWH1OQNW6GxDNfO1JiX1p8wpjl1D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:23 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 35e24e36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:13 +0200
Subject: [PATCH v2 01/16] reftable: fix formatting of the license header
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-1-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The license headers used across the reftable library doesn't follow our
typical coding style for multi-line comments. Fix it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.c               | 12 ++++++------
 reftable/basics.h               | 12 ++++++------
 reftable/block.c                | 12 ++++++------
 reftable/block.h                | 12 ++++++------
 reftable/blocksource.c          | 12 ++++++------
 reftable/blocksource.h          | 12 ++++++------
 reftable/constants.h            | 12 ++++++------
 reftable/error.c                | 12 ++++++------
 reftable/iter.c                 | 12 ++++++------
 reftable/iter.h                 | 12 ++++++------
 reftable/merged.c               | 12 ++++++------
 reftable/merged.h               | 12 ++++++------
 reftable/pq.c                   | 12 ++++++------
 reftable/pq.h                   | 12 ++++++------
 reftable/reader.c               | 12 ++++++------
 reftable/reader.h               | 12 ++++++------
 reftable/record.c               | 12 ++++++------
 reftable/record.h               | 12 ++++++------
 reftable/reftable-basics.h      |  2 +-
 reftable/reftable-blocksource.h | 12 ++++++------
 reftable/reftable-error.h       | 12 ++++++------
 reftable/reftable-iterator.h    | 12 ++++++------
 reftable/reftable-merged.h      | 12 ++++++------
 reftable/reftable-reader.h      | 12 ++++++------
 reftable/reftable-record.h      | 12 ++++++------
 reftable/reftable-stack.h       | 12 ++++++------
 reftable/reftable-writer.h      | 12 ++++++------
 reftable/stack.c                | 12 ++++++------
 reftable/stack.h                | 12 ++++++------
 reftable/system.h               | 12 ++++++------
 reftable/tree.c                 | 12 ++++++------
 reftable/tree.h                 | 12 ++++++------
 reftable/writer.c               | 12 ++++++------
 reftable/writer.h               | 12 ++++++------
 34 files changed, 199 insertions(+), 199 deletions(-)

diff --git a/reftable/basics.c b/reftable/basics.c
index 8c4a4433e41..9988ebd635e 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #define REFTABLE_ALLOW_BANNED_ALLOCATORS
 #include "basics.h"
diff --git a/reftable/basics.h b/reftable/basics.h
index fd59cbb7720..96a2f0d3829 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef BASICS_H
 #define BASICS_H
diff --git a/reftable/block.c b/reftable/block.c
index 53b5e044690..a5734d44415 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "block.h"
 
diff --git a/reftable/block.h b/reftable/block.h
index bef2b8a4c5c..eaeffdffc90 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef BLOCK_H
 #define BLOCK_H
diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 78c1be23373..1397cbe7800 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "system.h"
 
diff --git a/reftable/blocksource.h b/reftable/blocksource.h
index a84a3ccd891..7b67898ae22 100644
--- a/reftable/blocksource.h
+++ b/reftable/blocksource.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef BLOCKSOURCE_H
 #define BLOCKSOURCE_H
diff --git a/reftable/constants.h b/reftable/constants.h
index f6beb843ebf..091728cf033 100644
--- a/reftable/constants.h
+++ b/reftable/constants.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef CONSTANTS_H
 #define CONSTANTS_H
diff --git a/reftable/error.c b/reftable/error.c
index 660d0296170..c7cab2dbc42 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "system.h"
 #include "reftable-error.h"
diff --git a/reftable/iter.c b/reftable/iter.c
index f520382e700..44a155e756e 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "iter.h"
 
diff --git a/reftable/iter.h b/reftable/iter.h
index 40f98893b85..bd217405f55 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef ITER_H
 #define ITER_H
diff --git a/reftable/merged.c b/reftable/merged.c
index 4ff1553772a..1829a081756 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "merged.h"
 
diff --git a/reftable/merged.h b/reftable/merged.h
index 0b7d939e92b..ae92409d342 100644
--- a/reftable/merged.h
+++ b/reftable/merged.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef MERGED_H
 #define MERGED_H
diff --git a/reftable/pq.c b/reftable/pq.c
index 82394a972db..9a79f5c5eec 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "pq.h"
 
diff --git a/reftable/pq.h b/reftable/pq.h
index ff39016445b..42310670b09 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef PQ_H
 #define PQ_H
diff --git a/reftable/reader.c b/reftable/reader.c
index 172aff2c10b..155a26c30ff 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "reader.h"
 
diff --git a/reftable/reader.h b/reftable/reader.h
index bb72108a6f1..c9dccbd6c97 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef READER_H
 #define READER_H
diff --git a/reftable/record.c b/reftable/record.c
index 142853d5070..26cd834d405 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 /* record.c - methods for different types of records. */
 
diff --git a/reftable/record.h b/reftable/record.h
index 867810a9328..7953f352a3c 100644
--- a/reftable/record.h
+++ b/reftable/record.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef RECORD_H
 #define RECORD_H
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
index e0397ed5836..ed7c7c9ac2c 100644
--- a/reftable/reftable-basics.h
+++ b/reftable/reftable-basics.h
@@ -4,7 +4,7 @@
  * Use of this source code is governed by a BSD-style
  * license that can be found in the LICENSE file or at
  * https://developers.google.com/open-source/licenses/bsd
-*/
+ */
 
 #ifndef REFTABLE_BASICS_H
 #define REFTABLE_BASICS_H
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 6b326aa5ea5..8692cd017e9 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_BLOCKSOURCE_H
 #define REFTABLE_BLOCKSOURCE_H
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index a7e33d964d0..d100e0df927 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_ERROR_H
 #define REFTABLE_ERROR_H
diff --git a/reftable/reftable-iterator.h b/reftable/reftable-iterator.h
index e3bf688d53d..af582028c27 100644
--- a/reftable/reftable-iterator.h
+++ b/reftable/reftable-iterator.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_ITERATOR_H
 #define REFTABLE_ITERATOR_H
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index f2d01c3ef82..445756e475a 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_MERGED_H
 #define REFTABLE_MERGED_H
diff --git a/reftable/reftable-reader.h b/reftable/reftable-reader.h
index 0085fbb9032..9b6a8ac0716 100644
--- a/reftable/reftable-reader.h
+++ b/reftable/reftable-reader.h
@@ -1,10 +1,10 @@
 /*
-  Copyright 2020 Google LLC
-
-  Use of this source code is governed by a BSD-style
-  license that can be found in the LICENSE file or at
-  https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_READER_H
 #define REFTABLE_READER_H
diff --git a/reftable/reftable-record.h b/reftable/reftable-record.h
index 931e5947441..385a74cc864 100644
--- a/reftable/reftable-record.h
+++ b/reftable/reftable-record.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_RECORD_H
 #define REFTABLE_RECORD_H
diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index ae14270ea74..910ec6ef3a2 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_STACK_H
 #define REFTABLE_STACK_H
diff --git a/reftable/reftable-writer.h b/reftable/reftable-writer.h
index 1befe3b07cf..0fbeff17f46 100644
--- a/reftable/reftable-writer.h
+++ b/reftable/reftable-writer.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef REFTABLE_WRITER_H
 #define REFTABLE_WRITER_H
diff --git a/reftable/stack.c b/reftable/stack.c
index 6dac015b473..bc3cfa91170 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "stack.h"
 
diff --git a/reftable/stack.h b/reftable/stack.h
index 5b45cff4f75..d91f5ce6072 100644
--- a/reftable/stack.h
+++ b/reftable/stack.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef STACK_H
 #define STACK_H
diff --git a/reftable/system.h b/reftable/system.h
index 10055fbff2d..cf207aa0c53 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef SYSTEM_H
 #define SYSTEM_H
diff --git a/reftable/tree.c b/reftable/tree.c
index f4dbe720901..a52f7c0c7d4 100644
--- a/reftable/tree.c
+++ b/reftable/tree.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "system.h"
 #include "tree.h"
diff --git a/reftable/tree.h b/reftable/tree.h
index 9604453b6d5..2c9c4652994 100644
--- a/reftable/tree.h
+++ b/reftable/tree.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef TREE_H
 #define TREE_H
diff --git a/reftable/writer.c b/reftable/writer.c
index ce55a1deb06..f0accfd0c32 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #include "writer.h"
 
diff --git a/reftable/writer.h b/reftable/writer.h
index 1f4788a430c..9f53610b27a 100644
--- a/reftable/writer.h
+++ b/reftable/writer.h
@@ -1,10 +1,10 @@
 /*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
 
 #ifndef WRITER_H
 #define WRITER_H

-- 
2.49.0.604.gff1f9ca942.dirty

