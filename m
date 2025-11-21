Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254D3385A1
	for <git@vger.kernel.org>; Fri, 21 Nov 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710932; cv=none; b=Otz6XADfmmHJCrdPmU8tUIsWAqY79ufsKXi9eVDT+2fXrwAgwZqZiKzT7BOTrsj4xHrk3mbmRIFHVldfZbGPqM9iXIMztWue6FiNsaG52RTqqjdudhUiPjsFMhrvT1IEVRFib3E+gBo7mgJ1SkWyweHEpBCoIg2c8/bNp+MHEN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710932; c=relaxed/simple;
	bh=QyNkXTFd/bnjPYZeXEE1PCaCrLapkS6//+68aRI5Wu8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X51LWX+QMOX58b51AUM7OLoryfI18RfpnbxJJE2l4gBlFUZInCB311pMiooGaQJg9aSiGXULFbTcao2jcaOlixGo6UHGb172c8eAzuLjrBBrhR4kipzw9fjAYKPdvzMe0P8p2B/3o7jj58wMdtSIDP5+y3Ycz3pAYESDupLo/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QDhHwx5N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMWkNzA2; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QDhHwx5N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMWkNzA2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 16B9F1D0015F;
	Fri, 21 Nov 2025 02:42:10 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 21 Nov 2025 02:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763710929;
	 x=1763797329; bh=du6O8TEv0LgC+xS5lY38LMaHYryb9KE6zr65DpekCWA=; b=
	QDhHwx5NVVe7/lMenT2S2VoqI2z9Q4hIDTjfsqabyW+mDJagBqu1iCwcA/u0faJQ
	RBarsKzZ5MCZWHO3PqSHN+iTOJfs0D+kkegEotIeYCfKPS9EfZ35pOo/+xNnTT3P
	ocWt1ZLE5C8Mq1QZbFzCzr5YdhEwcnAVksyosowjCEtH5g2KiPpCdANU/CsKn4Jm
	BZlowcyK38Dfryj5djIc8zxlVBlL9F4jYIaDRZJAhynicGDe/V28Jq4mUVzuX2vU
	Ews4oxJfD/PIvcB2IloNVfszXztTkAOIFc7z+3xDLn72ZhXsI/hwxt8Vf6johL4w
	JpE3D01Sl41yYnnJIc+WiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763710929; x=
	1763797329; bh=du6O8TEv0LgC+xS5lY38LMaHYryb9KE6zr65DpekCWA=; b=i
	MWkNzA26xuoPU+08oCUIYkfoPYWo1vhAgfpLbiNP7Q8JterjdXMKFpZD8+LdcL0d
	tvjshrTw8RNdNn8Kux9fe+5ONxBRbhM1+j0EFKJBrdw1mYTLsuRiFRdPe3FCU3cq
	RbJcwEltwy5djiHfgKi0mAPo0MIcACatg3D3uYMr9Ul1XZo7WvWyQAyf9neMNbAt
	wPUFmcitTeeqY9LWGJ8s5dUYwCYHPsqABH3mQFSpE7IJcCDCkmvObs8h7K8LfP4j
	sopivG7vxE7BgCWr0b1ni+qKfX+mhFv9EFjcEvCsdY0xEiqMn57R/rNWxG/ub1GI
	VMPBcM8+9k8GVPwzaTbOg==
X-ME-Sender: <xms:0RcgaXja2f-ftaVdtvUptdQRGOcJKmUDBpNw7hail199tblCVORYzw>
    <xme:0RcgabfMe9LQszQE_6hq4s8yN-g5UxXiz93OX0d8UoS_W6Fl-PdCyVP4KGscDJ1wY
    WtL3hAW1tAKk8h4RQX3nCjwssJ2AlupV4kxGnDYEYbBr9ahL0ap>
X-ME-Received: <xmr:0RcgaUec1HfMGdURzBdhgnOyQ3bYAgB2B_Jxw7GA_oCeq0jPI7ZKOoZLZm44nzIfX8AI5F2hK8epa59zEQtada9Veq3kzUKV2uP5Ux_n0bFS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdelfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:0Rcgad_XLJY_JKF2RVDTN3UF8vZ5PZxpjfXQY1PtoLwPh7JPXC-eVg>
    <xmx:0RcgaYm__wie-RaBrCFjCu47Mfm3qmkkm78JLmZlVHtmHX1ShMrPpQ>
    <xmx:0RcgaX8k1wVHWNmNEAFfu8Yse4o_KcQixDfPug2ah73RYbsO-98skQ>
    <xmx:0RcgaemtS_xIqx7NrmVRSAuaRtLYbHPHDOL-klo1cxvGIFG0Jbje6g>
    <xmx:0RcgaW5Y3_ALhjwBCYogCt1q7FAcU336YiHEU1xjXppbFnB7sHtQ_dge>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 02:42:09 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 699416a7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 21 Nov 2025 07:42:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Nov 2025 08:41:03 +0100
Subject: [PATCH v2 18/19] streaming: move into object database subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-b4-pks-odb-read-stream-v2-18-ca8534963150@pks.im>
References: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
In-Reply-To: <20251121-b4-pks-odb-read-stream-v2-0-ca8534963150@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The "streaming" terminology is somewhat generic, so it may not be
immediately obvious that "streaming.{c,h}" is specific to the object
database. Rectify this by moving it into the "odb/" directory so that it
can be immediately attributed to the object subsystem.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                       | 2 +-
 archive-tar.c                  | 2 +-
 archive-zip.c                  | 2 +-
 builtin/cat-file.c             | 2 +-
 builtin/fsck.c                 | 2 +-
 builtin/index-pack.c           | 2 +-
 builtin/log.c                  | 2 +-
 builtin/pack-objects.c         | 2 +-
 entry.c                        | 2 +-
 meson.build                    | 2 +-
 object-file.c                  | 2 +-
 streaming.c => odb/streaming.c | 2 +-
 streaming.h => odb/streaming.h | 0
 packfile.c                     | 2 +-
 parallel-checkout.c            | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Makefile b/Makefile
index 7e0f77e298..6d8dcc4622 100644
--- a/Makefile
+++ b/Makefile
@@ -1201,6 +1201,7 @@ LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
 LIB_OBJS += object.o
 LIB_OBJS += odb.o
+LIB_OBJS += odb/streaming.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
@@ -1294,7 +1295,6 @@ LIB_OBJS += split-index.o
 LIB_OBJS += stable-qsort.o
 LIB_OBJS += statinfo.o
 LIB_OBJS += strbuf.o
-LIB_OBJS += streaming.o
 LIB_OBJS += string-list.o
 LIB_OBJS += strmap.o
 LIB_OBJS += strvec.o
diff --git a/archive-tar.c b/archive-tar.c
index 4133e09ca1..74499c311f 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -12,8 +12,8 @@
 #include "tar.h"
 #include "archive.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "strbuf.h"
-#include "streaming.h"
 #include "run-command.h"
 #include "write-or-die.h"
 
diff --git a/archive-zip.c b/archive-zip.c
index ff57f4f884..2b645f28ef 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -10,9 +10,9 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
-#include "streaming.h"
 #include "utf8.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "strbuf.h"
 #include "userdiff.h"
 #include "write-or-die.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 120d626d66..505ddaa12f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -18,13 +18,13 @@
 #include "list-objects-filter-options.h"
 #include "parse-options.h"
 #include "userdiff.h"
-#include "streaming.h"
 #include "oid-array.h"
 #include "packfile.h"
 #include "pack-bitmap.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1a348d43c2..c7d2eea287 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -13,11 +13,11 @@
 #include "fsck.h"
 #include "parse-options.h"
 #include "progress.h"
-#include "streaming.h"
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 67221dbe6a..6403edd3a6 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -16,12 +16,12 @@
 #include "progress.h"
 #include "fsck.h"
 #include "strbuf.h"
-#include "streaming.h"
 #include "thread-utils.h"
 #include "packfile.h"
 #include "pack-revindex.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "oid-array.h"
 #include "oidset.h"
 #include "path.h"
diff --git a/builtin/log.c b/builtin/log.c
index e7b83a6e00..d4cf9c59c8 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -16,6 +16,7 @@
 #include "refs.h"
 #include "object-name.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "pager.h"
 #include "color.h"
 #include "commit.h"
@@ -35,7 +36,6 @@
 #include "parse-options.h"
 #include "line-log.h"
 #include "branch.h"
-#include "streaming.h"
 #include "version.h"
 #include "mailmap.h"
 #include "progress.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index adf267c59d..f6c01bc4e0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -22,7 +22,6 @@
 #include "pack-objects.h"
 #include "progress.h"
 #include "refs.h"
-#include "streaming.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
 #include "delta-islands.h"
@@ -33,6 +32,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
diff --git a/entry.c b/entry.c
index 38dfe670f7..7817aee362 100644
--- a/entry.c
+++ b/entry.c
@@ -2,13 +2,13 @@
 
 #include "git-compat-util.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "name-hash.h"
 #include "sparse-index.h"
-#include "streaming.h"
 #include "submodule.h"
 #include "symlinks.h"
 #include "progress.h"
diff --git a/meson.build b/meson.build
index 1f95a06edb..fc82929b37 100644
--- a/meson.build
+++ b/meson.build
@@ -397,6 +397,7 @@ libgit_sources = [
   'object-name.c',
   'object.c',
   'odb.c',
+  'odb/streaming.c',
   'oid-array.c',
   'oidmap.c',
   'oidset.c',
@@ -490,7 +491,6 @@ libgit_sources = [
   'stable-qsort.c',
   'statinfo.c',
   'strbuf.c',
-  'streaming.c',
   'string-list.c',
   'strmap.c',
   'strvec.c',
diff --git a/object-file.c b/object-file.c
index c6d2f2d953..4b46cf5b71 100644
--- a/object-file.c
+++ b/object-file.c
@@ -20,13 +20,13 @@
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "oidtree.h"
 #include "pack.h"
 #include "packfile.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "setup.h"
-#include "streaming.h"
 #include "tempfile.h"
 #include "tmp-objdir.h"
 
diff --git a/streaming.c b/odb/streaming.c
similarity index 99%
rename from streaming.c
rename to odb/streaming.c
index 3ac1a0c40f..a7ee50dc34 100644
--- a/streaming.c
+++ b/odb/streaming.c
@@ -5,10 +5,10 @@
 #include "git-compat-util.h"
 #include "convert.h"
 #include "environment.h"
-#include "streaming.h"
 #include "repository.h"
 #include "object-file.h"
 #include "odb.h"
+#include "odb/streaming.h"
 #include "replace-object.h"
 #include "packfile.h"
 
diff --git a/streaming.h b/odb/streaming.h
similarity index 100%
rename from streaming.h
rename to odb/streaming.h
diff --git a/packfile.c b/packfile.c
index ad56ce0b90..7a16aaa90d 100644
--- a/packfile.c
+++ b/packfile.c
@@ -20,7 +20,7 @@
 #include "tree.h"
 #include "object-file.h"
 #include "odb.h"
-#include "streaming.h"
+#include "odb/streaming.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "pack-revindex.h"
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 1cb6701b92..0bf4bd6d4a 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -13,7 +13,7 @@
 #include "read-cache-ll.h"
 #include "run-command.h"
 #include "sigchain.h"
-#include "streaming.h"
+#include "odb/streaming.h"
 #include "symlinks.h"
 #include "thread-utils.h"
 #include "trace2.h"

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

