Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3C6328B70
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538512; cv=none; b=Da3Ry94BSL3Gp1dv/EJaJvlmTdZHGz+aNF4GI2iTSfgTx8dN23w4rgIpOetREz7D29k0F28uN/BNjqPh5Uptv7gBxNfR9wwGjJEnQo6jlYIIdpkjwd2w48W2U0B6Lfx/nBeaOAf0lOqL9j71WO0VkxBOzonTEhIuZF7sjF3NtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538512; c=relaxed/simple;
	bh=AO0fVkTzchsRO9FQ+d8AfjMluJmpC/s/UN4fgRvlxf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ctQxw3zLyJfLqFlFVRS3i0fpL5d4EjU31i+GkMNLBG+wWwJsAK3uSvk6zyke0Ar8Fl4k4poZ3SougGd7U4tc4Hy4+VHuKJx1i4X21GcuYcbwFbV7KBr/OgctPGDFWdHlNWQoGuh03yfeZSIuy0oz1PSDmA3rg7cYUiMpyc4e1JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nzkYMfps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GU48Tr3X; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nzkYMfps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GU48Tr3X"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 32FCD1400200
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:30 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538510;
	 x=1763624910; bh=KNsNMA34ojXXtTQW/+pW3S8Xeqmy0x731MDiOx/Jlt8=; b=
	nzkYMfpsEw7JVjZlTszD4qFAHWsQzTiLUBCgPlUUV1xNEc4+KNs1eJ6npZWbLPKH
	gpCapr8FI8uGmV00tiZrwiCEjeH36FUGfz3LKiij5LOI6fJfllAEmzSdg5PrPRDD
	hv6Q5Ol/uyldvBqvFNZqBqMpY7iN9cH2B7+S5lBy7u5w2PXSTH6TkB6eRRDu+YmR
	2X+OAuZ7uwkKZcMQnGfj+/HyaTfE/ELdW9bxYCmS2THUOfGaoYCpQh6E45fQyvgx
	n/Yfr8d36AfyF7rWfq5vlTnybjEx+ml444OhcAGchfO2KeEv1H1J24OGJ7HhB5iJ
	iDSY51JamvqF9S9Ftzek1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538510; x=
	1763624910; bh=KNsNMA34ojXXtTQW/+pW3S8Xeqmy0x731MDiOx/Jlt8=; b=G
	U48Tr3X6BQCUHOSargBRfi4bnqsDArXWTELowersDSDxRNF368SF+kYZ3uAMsiyl
	cXE5npNrM6wle3uVj7PMg2cXSvAdVwuoNpdy6H64lkQc2xhiUVYH5ujOA+ZKo+sC
	xKy5z1PHC5N2etThkMHI1cEDENskvJFFocd0Q3xBPh17SPxj4s/7o9t/Qz0Mq1OE
	F7OJ7NBpaIgu6FD4DWpYOEzOCidvj/bfhZrPGodxuY4WtZ6gM0pBvUx9VNxWZf/r
	lx/1KfXHWsg4/DYUXZyY51Urka1+TVB6dG0c94u6eLWLgvBrx8zUajEcEbdBMqTs
	7Mi55uvbKNZ5koGKMYjdg==
X-ME-Sender: <xms:TnYdaaCZucu9SveBR-lue3P_TNPDwbeB7fQs8C3ZDLO0KI_wSIR8FQ>
    <xme:TnYdabc9LITLB0Y0hI06Iw0zolzl7IfeAF7k_2ZbGt2VOCcVIIrl98q8k_FPmgpfm
    jOMMcfmM2-Omhvu3EaFoEXLjV1a0UKf3YZFwen68hCISsYZobmg>
X-ME-Received: <xmr:TnYdaTMcHxkV-sMSiosbBcThdXG2AeP5K3BO8YlW5Esm_nETGK3cAipG9f5tadzkeYCBv9F3oEjNMeGE5x-THrgEeDgvswMeHlqqfrxlTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:TnYdad5UDkcbTyY4ZDGVPQytczSMvFt0ReEHIqYerSPtGz88RNTElA>
    <xmx:TnYdafKLJoOLebCDseqJxgaOsRTc4aGsZrZS6ditibSNHAsejWgytA>
    <xmx:TnYdaffu5xlmCWbi_UcGiQl7A3RfqohaXv8hcy_6WEb98hXwNU8E1A>
    <xmx:TnYdaaeyJfVO6fT38gXrGO_1Amwvu5XF4V2ACZ_jcC9vh3U9Suqy0A>
    <xmx:TnYdadCX2T1uweO3xZ515d-1p_zVSD1oh_UHQwb10qmeDVJOiJxHh1CI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6c5bdb16 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:48:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:18 +0100
Subject: [PATCH 18/18] streaming: move into object database subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-18-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 5e0ff171bf..34c9582bcc 100644
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

