Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A023D7EB
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924448; cv=none; b=pJYv7SlOSTPeUnWeEEt7oWDX8Iz1eJd6lDhiZuDiK6Bak4QyxKbdXoGiiX7eG24ueAFxGnnyUlKWI4is6UD6CinKMk66OZtqXmGlwATfai93bwWL+Fc6mp4yEtHpRFRjZBCrUixbqSycazrP2M9Ncuss9ZmUa5PV8uGeAhoPEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924448; c=relaxed/simple;
	bh=StQ2gcJizs7vwsf0H97j0+7a9CJJIAEpT0Kb8nPrp9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C6Akb8S9crn9lkuzcglCi4frz4NqPEUJt/PyFhVTHpfhPrdCA6Dvj4HBOa77+qST6dMUuR8jcO1TYUfh76Egtw/w6OfkyB0LDR5kWNgoC8PABnMeYgKnKNot0PzaeKtvct/Fc6y97ivpt2cpFidKh8/WLg1C7DwX3ty5ndYKeeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h1blqNa0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bBCbGYp2; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h1blqNa0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bBCbGYp2"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 996B57A00FE;
	Sun, 23 Nov 2025 14:00:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sun, 23 Nov 2025 14:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924445;
	 x=1764010845; bh=BVa3+fBfOBPr5UNalmYRe1vuLzL6eGFBj84jz2I69go=; b=
	h1blqNa0Bh4tURnhSk7zqvqP2wDl2jKTybHdNN1jBnYdIbyyx7jIQ9oJnOK1NnDy
	aHCuoRIDyfQvMfTJoEo3b+LPpy9X7RPwjOOdOTN1hA37uVB5D9edHdGnqO/7k+M0
	FeZ2c4UxTdX8wGXRVEAa7dBezIJw+cTjxDGrotXs+o+TC0KAmS2nS++2V1DH4pMc
	p+zaGjvD6PVc/NZL2uGLHGECzmCdLis2vqKfKhFb754JTD28WOliVPxAAutbxg3i
	kifHh0iHjs7+SM137GNetqypYy4+SlK7F+bxLgijggrQn3+kEc6TxBuADyue4EyV
	X+6lpTQOb7fzVpdfU6WtTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924445; x=
	1764010845; bh=BVa3+fBfOBPr5UNalmYRe1vuLzL6eGFBj84jz2I69go=; b=b
	BCbGYp2Bjp4e/H6arDnzlCZEkHAKf1FZJVi9JVcyeZ8solGpxlTdhM5aBpRm569K
	buMss5lPG5VzGp98cZoApaecW3KFVGxh3mE7EVxUlFlpff4VOsLQIFCpwFIRK860
	HS5NzJvtc1B/atmtH78TvVbrbxU+NOAmLibqwUNJ6fv7U88u6AJaq/ziWQ2W8mED
	S+ZnLWWtdwslFRXNxn7escE4/I1t38I5Lv7j8YmKcNlOWXwKkQ2pprzGigy4OsaC
	6510vFZrbzMS3Kgdv8898EGOkUagfc4a8w4hpYspoAnIGmztpo6fDQDWe65hNVdW
	Y6o6TFsWkPIYx1RK0Ox5A==
X-ME-Sender: <xms:3VkjaZz-XecI36KDxL8WW7Vv1eJF4KvCl4sB1XoTB9mqDTm-DQFQBQ>
    <xme:3VkjaQRRxFjwUbOfzQAOGLsGIqTUBf5O0sZ41Gbtf7-c9DPDDhZxOEJNcV_vkeZav
    T5fnUBJAHLhrLVoltUNpiSaHGTSg-vvwjvR254njUzrWKIWB-bqRA>
X-ME-Received: <xmr:3VkjaYUk-sGKB-xnWAu292vQSE79Tuz6vHvGiFM2PK34TLphOesUKmdb-HfD4vSx809G0LGJQokS760tjrvWOogOIL4z-Q2fTP4W-NY3zMKoTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3VkjaaYYDS7CBc5dQZwDrPbrR50nHBub4jxcKBpe9x4sPqhR0_2Mjw>
    <xmx:3VkjaW3YAbr994T6tdVDEC5Szr3hoITUVLOAUmSflj1BGbxbZLNhaA>
    <xmx:3VkjaUhiTTTIW2Msw255UUPMKzluY2sU7EABM0hhTWubEG9B1QA25A>
    <xmx:3VkjaSacil3xX8nTAGx3a-RK-wyD2pVAmraGduQNRJHa6bxFmol86Q>
    <xmx:3Vkjaf1CYate7RqXv-cOL7zj5IvVtP3YZd9_IGzdv_7KR9bjzove-3yb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 14:00:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc7d9637 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 19:00:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:43 +0100
Subject: [PATCH v3 18/19] streaming: move into object database subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-18-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index 4d87b28504..494b9f0667 100644
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
index c44684aebc..a0bdc2fe3b 100644
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
index fb76ef0f4c..581023495f 100644
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
index 1353c2384c..f109e26786 100644
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
index 9ba40a848c..9601fdb12d 100644
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
index 06993a751c..7ef58adaa2 100644
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

