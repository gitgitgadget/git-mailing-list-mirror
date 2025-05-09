Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4E32957B5
	for <git@vger.kernel.org>; Fri,  9 May 2025 14:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799941; cv=none; b=UONVhDAYevlpqsnasCLyxtcUpAbuxlFCoTCDwFXxJnGIFmQHIdCS3dNnidFWzt1jf/E3+1xPkqIXaz4jtSf+zve90/d+2DzbkVK9YzFXTSMgPy45kIlbmmLOW+5O51dvhLzzKqK2ez2Kv7RurXP8Yzh2c6yOmawely5X81KJYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799941; c=relaxed/simple;
	bh=8e65Sqp5ChXJyOQLQFCjg2edlkg24Nul2PCUgesssQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMfW96fWYT/ys4brIbpKLG/aBWXrf0ke6iKH2PdQr5UTZLj/KCKb2JsoEHSOFKhEn0CRadw5SWhim6PAKNxtQrBikX64ACpsHIVq8g48LUayRvKpnuTCfmFVo/sYqUN006Jw3i4pHPxVtMwxG6qLrZUHp6y5QabPpBea+d1k/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CYCdvuzc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Le8w9eKz; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CYCdvuzc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Le8w9eKz"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id EC8211140134;
	Fri,  9 May 2025 10:12:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 09 May 2025 10:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746799936;
	 x=1746886336; bh=x7ZAaXoZHLoAstRti3+c65NX9uOgKIWskP3iXe8or50=; b=
	CYCdvuzcWIEHFs6utwpXgGNIY+xUmOGYjGr2/ZqxZzcZWQah6S3WiRnmZimvZX0W
	rxXmCF8yB4BIXr35cVdpbo3h0m249x9MzH8NXdBkxiV8T8Ip6FV2UoiT7tVo64gv
	0o0ETcp/lJHrRXStVD49WkyQrjKVifRaBU4R9KU9snLeXgDbzQ+XDDLFjxxGKxXA
	R1zpsrjjMKgI0oI4Z5Jmq60MKFJKu6zpPUUDx3NOcFBbtgZGeeYe1dM3cufMmVwW
	AMaQGz+wGAVmd//z/hXEK7YxQt/Mi02WI/gR3uqo+1lijCyfDDbC7JQX1r8aEhZZ
	uNPwFCXS5b+xLD8Jh9Ptvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746799936; x=
	1746886336; bh=x7ZAaXoZHLoAstRti3+c65NX9uOgKIWskP3iXe8or50=; b=L
	e8w9eKzYnP47odkmS9Um2FPaAvyGVNt4V2fiYWKKk9vO4fRGRflF+F/GTxCNFjnj
	GwhJJJxQ3eGbdBQAvKv0X532zvQTfEwC7mgOoJoOSX6+TnvCZzaGm7jPQDcqFSux
	2TnwoXr+0mLT3y7U0J2SNQZnCY6l3x6G37X5YmFbiw9vGN7L89b5VAKDahsuzsN4
	CNioj/CKD9ZOMn1OXzmygx/HuNLrDR02V4w4J3cYaC9AQa3ZLKItKQMLzTj1sbOh
	91zMbZGIZki2d6iYkq2eUl15xGimxYdZtLdeuULDUyjrgty57ZZIkaHYkaJEGXZU
	D3IBMWuF+81BqTJJiuM+A==
X-ME-Sender: <xms:QA0eaBunH6V1GolrLh1QneYkbyecJOrzyMBIf2A_Z6v6t-E7VtRDUQ>
    <xme:QA0eaKeEdn172FRTPyEwENHQtjaN5MXIWwrmhdSoqiMpvnRn7vgLlQGWFL_IOGSiZ
    xZMQvSgf1428c4qOQ>
X-ME-Received: <xmr:QA0eaEzd-Pk2bxoTz745CaHYdFlBk6PU_uEez_UoxH0es9dV_8FRiGgLPyWF92ATyRSNh8skP7Tj5UxGnGF1Zqn_3-6YETBDqBC1sJndpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehs
    thholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QA0eaIPtuzQIuI95xdAtcPVFeX59InnPUsrmFw0iG8fRU0vqhGemeg>
    <xmx:QA0eaB-XbxZoEfpKABgiGLj9aTRhiP4BvhTLgndqydym5fd1G-AR1A>
    <xmx:QA0eaIXOw4LVc5IGMknW_8PaWi_0Y0UhaAPYqC3MTEZ3uwkEQsJ1Ww>
    <xmx:QA0eaCf-I8TzamKl36fbJjLZkh8W2FXFpb5upl_4eYPbTUKnt--V0w>
    <xmx:QA0eaApVxSop4Y3RUWiCDTVu3Sd5ugd4crZ8l5SoV_FmkhkIa_PxD5ot>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 10:12:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8a3b36b (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 14:12:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 May 2025 16:12:03 +0200
Subject: [PATCH v2 03/17] object-store: rename files to "odb.{c,h}"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-pks-object-store-wo-the-repository-v2-3-103f59bf8e28@pks.im>
References: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In the preceding commits we have renamed the structures contained in
"object-store.h" to `struct object_database` and `struct odb_backend`.
As such, the code files "object-store.{c,h}" are confusingly named now.
Rename them to "odb.{c,h}" accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                                | 2 +-
 apply.c                                 | 2 +-
 archive-tar.c                           | 2 +-
 archive-zip.c                           | 2 +-
 archive.c                               | 2 +-
 attr.c                                  | 2 +-
 bisect.c                                | 2 +-
 blame.c                                 | 2 +-
 builtin/backfill.c                      | 2 +-
 builtin/blame.c                         | 2 +-
 builtin/cat-file.c                      | 2 +-
 builtin/checkout.c                      | 2 +-
 builtin/clone.c                         | 2 +-
 builtin/commit-graph.c                  | 2 +-
 builtin/commit-tree.c                   | 2 +-
 builtin/describe.c                      | 2 +-
 builtin/difftool.c                      | 2 +-
 builtin/fast-export.c                   | 2 +-
 builtin/fast-import.c                   | 2 +-
 builtin/fetch.c                         | 2 +-
 builtin/fsck.c                          | 2 +-
 builtin/grep.c                          | 2 +-
 builtin/hash-object.c                   | 2 +-
 builtin/index-pack.c                    | 2 +-
 builtin/log.c                           | 2 +-
 builtin/ls-files.c                      | 2 +-
 builtin/ls-tree.c                       | 2 +-
 builtin/merge-file.c                    | 2 +-
 builtin/merge-tree.c                    | 2 +-
 builtin/mktag.c                         | 2 +-
 builtin/mktree.c                        | 2 +-
 builtin/multi-pack-index.c              | 2 +-
 builtin/notes.c                         | 2 +-
 builtin/pack-objects.c                  | 2 +-
 builtin/pack-redundant.c                | 2 +-
 builtin/prune.c                         | 2 +-
 builtin/receive-pack.c                  | 2 +-
 builtin/remote.c                        | 2 +-
 builtin/repack.c                        | 2 +-
 builtin/replace.c                       | 2 +-
 builtin/rev-list.c                      | 2 +-
 builtin/show-ref.c                      | 2 +-
 builtin/submodule--helper.c             | 2 +-
 builtin/tag.c                           | 2 +-
 builtin/unpack-file.c                   | 2 +-
 builtin/unpack-objects.c                | 2 +-
 bulk-checkin.c                          | 2 +-
 bundle-uri.c                            | 2 +-
 bundle.c                                | 2 +-
 cache-tree.c                            | 2 +-
 combine-diff.c                          | 2 +-
 commit-graph.c                          | 2 +-
 commit-graph.h                          | 2 +-
 commit.c                                | 2 +-
 config.c                                | 2 +-
 connected.c                             | 2 +-
 contrib/coccinelle/the_repository.cocci | 2 +-
 diagnose.c                              | 2 +-
 diff.c                                  | 2 +-
 entry.c                                 | 2 +-
 fetch-pack.c                            | 2 +-
 fmt-merge-msg.c                         | 2 +-
 fsck.c                                  | 2 +-
 grep.c                                  | 2 +-
 http-backend.c                          | 2 +-
 http-push.c                             | 2 +-
 http-walker.c                           | 2 +-
 http.c                                  | 2 +-
 list-objects-filter.c                   | 2 +-
 list-objects.c                          | 2 +-
 loose.c                                 | 2 +-
 mailmap.c                               | 2 +-
 match-trees.c                           | 2 +-
 merge-blobs.c                           | 2 +-
 merge-ort.c                             | 2 +-
 meson.build                             | 2 +-
 notes-cache.c                           | 2 +-
 notes-merge.c                           | 2 +-
 notes.c                                 | 2 +-
 object-file.c                           | 2 +-
 object-file.h                           | 2 +-
 object-store.c => odb.c                 | 2 +-
 object-store.h => odb.h                 | 6 +++---
 oss-fuzz/fuzz-pack-idx.c                | 2 +-
 pack-bitmap-write.c                     | 2 +-
 pack-bitmap.c                           | 2 +-
 pack-check.c                            | 2 +-
 pack-mtimes.c                           | 2 +-
 pack-objects.h                          | 2 +-
 pack-revindex.c                         | 2 +-
 packfile.c                              | 2 +-
 packfile.h                              | 4 ++--
 path.c                                  | 2 +-
 promisor-remote.c                       | 2 +-
 protocol-caps.c                         | 2 +-
 read-cache.c                            | 2 +-
 ref-filter.c                            | 2 +-
 reflog.c                                | 2 +-
 refs.c                                  | 2 +-
 remote.c                                | 2 +-
 replace-object.c                        | 2 +-
 replace-object.h                        | 2 +-
 repository.c                            | 2 +-
 rerere.c                                | 2 +-
 revision.c                              | 2 +-
 send-pack.c                             | 2 +-
 sequencer.c                             | 2 +-
 server-info.c                           | 2 +-
 shallow.c                               | 2 +-
 streaming.c                             | 2 +-
 submodule-config.c                      | 2 +-
 submodule.c                             | 2 +-
 t/helper/test-find-pack.c               | 2 +-
 t/helper/test-pack-mtimes.c             | 2 +-
 t/helper/test-partial-clone.c           | 2 +-
 t/helper/test-read-graph.c              | 2 +-
 t/helper/test-read-midx.c               | 2 +-
 t/helper/test-ref-store.c               | 2 +-
 tag.c                                   | 2 +-
 tmp-objdir.c                            | 2 +-
 tree-walk.c                             | 2 +-
 tree.c                                  | 2 +-
 unpack-trees.c                          | 2 +-
 upload-pack.c                           | 2 +-
 walker.c                                | 2 +-
 xdiff-interface.c                       | 2 +-
 126 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/Makefile b/Makefile
index 8a7f1c76543..d2d65f30907 100644
--- a/Makefile
+++ b/Makefile
@@ -1083,8 +1083,8 @@ LIB_OBJS += notes.o
 LIB_OBJS += object-file-convert.o
 LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
-LIB_OBJS += object-store.o
 LIB_OBJS += object.o
+LIB_OBJS += odb.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
 LIB_OBJS += oidset.o
diff --git a/apply.c b/apply.c
index 381d2e3652f..879f04df31e 100644
--- a/apply.c
+++ b/apply.c
@@ -14,7 +14,7 @@
 #include "abspath.h"
 #include "base85.h"
 #include "config.h"
-#include "object-store.h"
+#include "odb.h"
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
diff --git a/archive-tar.c b/archive-tar.c
index 282b48196f9..249164ea77d 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strbuf.h"
 #include "streaming.h"
 #include "run-command.h"
diff --git a/archive-zip.c b/archive-zip.c
index 405da6f3d83..df8866d5bae 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -12,7 +12,7 @@
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strbuf.h"
 #include "userdiff.h"
 #include "write-or-die.h"
diff --git a/archive.c b/archive.c
index 8309ea213e6..7fa2cc2596a 100644
--- a/archive.c
+++ b/archive.c
@@ -14,7 +14,7 @@
 #include "pretty.h"
 #include "setup.h"
 #include "refs.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/attr.c b/attr.c
index 86b6109fc4e..e5680db7f65 100644
--- a/attr.c
+++ b/attr.c
@@ -22,7 +22,7 @@
 #include "read-cache-ll.h"
 #include "refs.h"
 #include "revision.h"
-#include "object-store.h"
+#include "odb.h"
 #include "setup.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/bisect.c b/bisect.c
index a327468c75b..a7939216d00 100644
--- a/bisect.c
+++ b/bisect.c
@@ -20,7 +20,7 @@
 #include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "dir.h"
 
diff --git a/blame.c b/blame.c
index 57daa45e899..0ceea080a80 100644
--- a/blame.c
+++ b/blame.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "refs.h"
-#include "object-store.h"
+#include "odb.h"
 #include "cache-tree.h"
 #include "mergesort.h"
 #include "commit.h"
diff --git a/builtin/backfill.c b/builtin/backfill.c
index fa82ad2f6ff..0b49baa39fa 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -13,7 +13,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "object.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "oidset.h"
 #include "promisor-remote.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index 944952e30eb..15eda60af90 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,7 +28,7 @@
 #include "line-log.h"
 #include "progress.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pager.h"
 #include "blame.h"
 #include "refs.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 3914a2a3f61..2fa5e3f43bd 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -24,7 +24,7 @@
 #include "pack-bitmap.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index d185982f3a6..e7dd66173dd 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,7 +20,7 @@
 #include "merge-ort-wrappers.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 91b9cd0d164..1eafeefb48d 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,7 +25,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 628d3a1e92e..ae8ac52a975 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "commit-graph.h"
-#include "object-store.h"
+#include "odb.h"
 #include "progress.h"
 #include "replace-object.h"
 #include "strbuf.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index ad6b2c93209..546069f8682 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 
 #include "commit.h"
 #include "parse-options.h"
diff --git a/builtin/describe.c b/builtin/describe.c
index 2d50883b729..96cb68e5e5d 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -19,7 +19,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "object-store.h"
+#include "odb.h"
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "wildmatch.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index a3b64ce6942..fac613e3bc3 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -30,7 +30,7 @@
 #include "strbuf.h"
 #include "lockfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 37c01d6c6fe..0505f289a94 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index b2839c5f439..52c792488e1 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -24,7 +24,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
 #include "khash.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4de6d3206d4..82e9603ccab 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oidset.h"
 #include "oid-array.h"
 #include "commit.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9c54286540c..6a5181393a2 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -17,7 +17,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 3c51a39c10d..3858df2a82e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,7 +26,7 @@
 #include "submodule-config.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "pager.h"
 #include "path.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index cd53fa3bde8..9ce0b87c30b 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -11,7 +11,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 147e9b8b479..8ce446064e8 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -21,7 +21,7 @@
 #include "packfile.h"
 #include "pack-revindex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "oidset.h"
 #include "path.h"
diff --git a/builtin/log.c b/builtin/log.c
index b450cd3bde8..fe9cc5ebecb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -15,7 +15,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pager.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index be74f0a03b2..821339b07d4 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -25,7 +25,7 @@
 #include "setup.h"
 #include "sparse-index.h"
 #include "submodule.h"
-#include "object-store.h"
+#include "odb.h"
 #include "hex.h"
 
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8aafc30ca48..62b6fd58c16 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,7 +10,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "tree.h"
 #include "path.h"
 #include "quote.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 2b16b10d2ca..9464f275629 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -7,7 +7,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "config.h"
 #include "gettext.h"
 #include "setup.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4aafa73c615..709ae3966a6 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -10,7 +10,7 @@
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "parse-options.h"
 #include "blob.h"
 #include "merge-blobs.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 7ac11c46d53..1809b38f937 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -6,7 +6,7 @@
 #include "strbuf.h"
 #include "replace-object.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "fsck.h"
 #include "config.h"
 
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 4b478034675..016b0e5b224 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,7 +12,7 @@
 #include "tree.h"
 #include "parse-options.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index a77ae465d48..01c4c8e62e3 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -7,7 +7,7 @@
 #include "midx.h"
 #include "strbuf.h"
 #include "trace2.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "repository.h"
 
diff --git a/builtin/notes.c b/builtin/notes.c
index a3f433ca4c0..783d4932ca6 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -16,7 +16,7 @@
 #include "notes.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 
 #include "pretty.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8b33edc2ff5..99b63cb0980 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,7 +32,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 5d1fc781761..3134cb8c689 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -13,7 +13,7 @@
 #include "hex.h"
 
 #include "packfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strbuf.h"
 
 #define BLKSIZE 512
diff --git a/builtin/prune.c b/builtin/prune.c
index e930caa0c0a..7bbfb14c2be 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,7 +17,7 @@
 #include "replace-object.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "shallow.h"
 
 static const char * const prune_usage[] = {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c92e57ba188..cb5fd55a8e4 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -33,7 +33,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "protocol.h"
 #include "commit-reach.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 0d6755bcb71..ac5b8d2a1a6 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index 59214dbdfdf..16782320058 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,7 +17,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
-#include "object-store.h"
+#include "odb.h"
 #include "promisor-remote.h"
 #include "shallow.h"
 #include "pack.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index 48c7c6a2d56..11c7e2d4c0c 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -19,7 +19,7 @@
 #include "run-command.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "tag.h"
 #include "wildmatch.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c4cd4ed5c81..ee25d61c802 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -14,7 +14,7 @@
 #include "object.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pack-bitmap.h"
 #include "parse-options.h"
 #include "log-tree.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 623a52a45f8..90ec1de78f9 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -5,7 +5,7 @@
 #include "hex.h"
 #include "refs/refs-internal.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "object.h"
 #include "string-list.h"
 #include "parse-options.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index cd7db11d825..a6c936fb2bd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -28,7 +28,7 @@
 #include "diff.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 4742b27d16e..cf2ea4b4993 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,7 +19,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "tag.h"
 #include "parse-options.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index e33acfc4ee4..b92fd4710a9 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index e905d5f4e19..7bf395eec84 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,7 +9,7 @@
 #include "git-zlib.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 678e2ecc2c2..55406a539e7 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -17,7 +17,7 @@
 #include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 
 static int odb_transaction_nesting;
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 96d2ba726d9..993ac62c271 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -14,7 +14,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "trace2.h"
-#include "object-store.h"
+#include "odb.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
diff --git a/bundle.c b/bundle.c
index 0c7cd15bb12..c67f85126da 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "repository.h"
 #include "object.h"
 #include "commit.h"
diff --git a/cache-tree.c b/cache-tree.c
index fa3858e2829..9786b32b3a1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -10,7 +10,7 @@
 #include "cache-tree.h"
 #include "bulk-checkin.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "repository.h"
diff --git a/combine-diff.c b/combine-diff.c
index dfae9f7995d..cf23a753407 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "convert.h"
 #include "diff.h"
diff --git a/commit-graph.c b/commit-graph.c
index 58d1eeedb1a..4848198d7bf 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,7 +13,7 @@
 #include "refs.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "path.h"
 #include "alloc.h"
diff --git a/commit-graph.h b/commit-graph.h
index 19d95ade6ea..0be594e2638 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "object-store.h"
+#include "odb.h"
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
diff --git a/commit.c b/commit.c
index e915b2b9a12..1d30f8ce15a 100644
--- a/commit.c
+++ b/commit.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "repository.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/config.c b/config.c
index b18b5617fcd..883dd066827 100644
--- a/config.c
+++ b/config.c
@@ -31,7 +31,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pager.h"
 #include "path.h"
 #include "utf8.h"
diff --git a/connected.c b/connected.c
index 4415388beba..18c13245d8e 100644
--- a/connected.c
+++ b/connected.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 765ad689678..ea7fe1c8db7 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -77,7 +77,7 @@
 |
 - diff_setup
 + repo_diff_setup
-// object-store.h
+// odb.h
 |
 - read_object_file
 + repo_read_object_file
diff --git a/diagnose.c b/diagnose.c
index 50129cf4be3..d407c98d094 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/diff.c b/diff.c
index 63e9ecb30c6..193da8bee68 100644
--- a/diff.c
+++ b/diff.c
@@ -23,7 +23,7 @@
 #include "color.h"
 #include "run-command.h"
 #include "utf8.h"
-#include "object-store.h"
+#include "odb.h"
 #include "userdiff.h"
 #include "submodule.h"
 #include "hashmap.h"
diff --git a/entry.c b/entry.c
index f36ec5ad242..75d55038d7c 100644
--- a/entry.c
+++ b/entry.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "object-store.h"
+#include "odb.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index fa4231fee74..cf157f5d7e5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -24,7 +24,7 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 501b5acdd44..1a8c972adf3 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -6,7 +6,7 @@
 #include "environment.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "hex.h"
diff --git a/fsck.c b/fsck.c
index 8dc8472ceb3..e69baab3af7 100644
--- a/fsck.c
+++ b/fsck.c
@@ -4,7 +4,7 @@
 #include "date.h"
 #include "dir.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "repository.h"
 #include "object.h"
diff --git a/grep.c b/grep.c
index f8d535182c3..dc77e6c4631 100644
--- a/grep.c
+++ b/grep.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "grep.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/http-backend.c b/http-backend.c
index 0c575aa88aa..ad8c4037493 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -18,7 +18,7 @@
 #include "url.h"
 #include "strvec.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "protocol.h"
 #include "date.h"
 #include "write-or-die.h"
diff --git a/http-push.c b/http-push.c
index f9e67cabd4b..d1b1bb23711 100644
--- a/http-push.c
+++ b/http-push.c
@@ -20,7 +20,7 @@
 #include "url.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit-reach.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
diff --git a/http-walker.c b/http-walker.c
index 9e7bc37f02e..4b1cdd25a80 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -10,7 +10,7 @@
 #include "transport.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index 8ce2ec73947..e639d9fafef 100644
--- a/http.c
+++ b/http.c
@@ -19,7 +19,7 @@
 #include "packfile.h"
 #include "string-list.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "tempfile.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
diff --git a/list-objects-filter.c b/list-objects-filter.c
index 7765761b3c6..cb9c16734b1 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -12,7 +12,7 @@
 #include "oidmap.h"
 #include "oidset.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/list-objects.c b/list-objects.c
index 597114281f6..c50b9578584 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -14,7 +14,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "trace.h"
 #include "environment.h"
 
diff --git a/loose.c b/loose.c
index bce4e1c3ee7..9febd1f3e9a 100644
--- a/loose.c
+++ b/loose.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "hash.h"
 #include "path.h"
-#include "object-store.h"
+#include "odb.h"
 #include "hex.h"
 #include "repository.h"
 #include "wrapper.h"
diff --git a/mailmap.c b/mailmap.c
index 9e2642a043b..b18e74c2110 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "setup.h"
 
 char *git_mailmap_file;
diff --git a/match-trees.c b/match-trees.c
index 72922d5d64e..4704f95c340 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -7,7 +7,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "repository.h"
 
 static int score_missing(unsigned mode)
diff --git a/merge-blobs.c b/merge-blobs.c
index 53f36dbc175..ba8a3fdfd82 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -4,7 +4,7 @@
 #include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
-#include "object-store.h"
+#include "odb.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-ort.c b/merge-ort.c
index 77310a4a52c..f86c84635f0 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -39,7 +39,7 @@
 #include "mem-pool.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "path.h"
 #include "promisor-remote.h"
diff --git a/meson.build b/meson.build
index 270ce933d0f..a3c917b1345 100644
--- a/meson.build
+++ b/meson.build
@@ -394,8 +394,8 @@ libgit_sources = [
   'object-file-convert.c',
   'object-file.c',
   'object-name.c',
-  'object-store.c',
   'object.c',
+  'odb.c',
   'oid-array.c',
   'oidmap.c',
   'oidset.c',
diff --git a/notes-cache.c b/notes-cache.c
index 150241b15e0..344f67762b8 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "notes-cache.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pretty.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/notes-merge.c b/notes-merge.c
index dae8e6a281a..de6a52e2e7f 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -8,7 +8,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "repository.h"
 #include "diff.h"
diff --git a/notes.c b/notes.c
index 0a128f1de98..fc000e501d2 100644
--- a/notes.c
+++ b/notes.c
@@ -8,7 +8,7 @@
 #include "notes.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
diff --git a/object-file.c b/object-file.c
index e48d968c0e0..dabc238447a 100644
--- a/object-file.c
+++ b/object-file.c
@@ -21,7 +21,7 @@
 #include "loose.h"
 #include "object-file-convert.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oidtree.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/object-file.h b/object-file.h
index f1601200938..e4810eee449 100644
--- a/object-file.h
+++ b/object-file.h
@@ -3,7 +3,7 @@
 
 #include "git-zlib.h"
 #include "object.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct index_state;
 
diff --git a/object-store.c b/odb.c
similarity index 99%
rename from object-store.c
rename to odb.c
index 673a9c6006b..81281db7e0a 100644
--- a/object-store.c
+++ b/odb.c
@@ -13,7 +13,7 @@
 #include "loose.h"
 #include "object-file-convert.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "path.h"
 #include "promisor-remote.h"
diff --git a/object-store.h b/odb.h
similarity index 99%
rename from object-store.h
rename to odb.h
index 2dda6e85388..465820a3d5c 100644
--- a/object-store.h
+++ b/odb.h
@@ -1,5 +1,5 @@
-#ifndef OBJECT_STORE_H
-#define OBJECT_STORE_H
+#ifndef ODB_H
+#define ODB_H
 
 #include "hashmap.h"
 #include "object.h"
@@ -345,4 +345,4 @@ void *read_object_with_reference(struct repository *r,
 				 unsigned long *size,
 				 struct object_id *oid_ret);
 
-#endif /* OBJECT_STORE_H */
+#endif /* ODB_H */
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index 609a343ee3e..d2a92f34d98 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 7f400ee0121..37648b57125 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -4,7 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d866046..467a3e91035 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -17,7 +17,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
-#include "object-store.h"
+#include "odb.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
diff --git a/pack-check.c b/pack-check.c
index 874897d6cba..67cb2cf72f2 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -8,7 +8,7 @@
 #include "progress.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct idx_entry {
 	off_t                offset;
diff --git a/pack-mtimes.c b/pack-mtimes.c
index 20900ca88d3..8e1f2dec0ef 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "strbuf.h"
 
diff --git a/pack-objects.h b/pack-objects.h
index 475a2d67ce3..1ac8644201b 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,7 +1,7 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
-#include "object-store.h"
+#include "odb.h"
 #include "thread-utils.h"
 #include "pack.h"
 #include "packfile.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index ffcde48870d..0cc422a1e67 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/packfile.c b/packfile.c
index e31e55f0c02..8133948b58f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -19,7 +19,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "pack-revindex.h"
diff --git a/packfile.h b/packfile.h
index 826eb7f475f..53c3b7d3b43 100644
--- a/packfile.h
+++ b/packfile.h
@@ -3,10 +3,10 @@
 
 #include "list.h"
 #include "object.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oidset.h"
 
-/* in object-store.h */
+/* in odb.h */
 struct object_info;
 
 struct packed_git {
diff --git a/path.c b/path.c
index 7be0e0214df..36ddfb24701 100644
--- a/path.c
+++ b/path.c
@@ -15,7 +15,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 9d058586dfa..2baa286bfd0 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "promisor-remote.h"
 #include "config.h"
 #include "trace2.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index 9b8db37a210..3022f69a1bd 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -6,7 +6,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "object.h"
-#include "object-store.h"
+#include "odb.h"
 #include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/read-cache.c b/read-cache.c
index 73f83a7e7a1..dce1056ec7c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -20,7 +20,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/ref-filter.c b/ref-filter.c
index 7a274633cfc..4ce45440ad1 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -12,7 +12,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "repo-settings.h"
 #include "repository.h"
diff --git a/reflog.c b/reflog.c
index 15d81ebea97..4f8a3b717cd 100644
--- a/reflog.c
+++ b/reflog.c
@@ -5,7 +5,7 @@
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
-#include "object-store.h"
+#include "odb.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
diff --git a/refs.c b/refs.c
index 27325d2f3c6..82a70b502f8 100644
--- a/refs.c
+++ b/refs.c
@@ -19,7 +19,7 @@
 #include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "object.h"
 #include "path.h"
 #include "submodule.h"
diff --git a/remote.c b/remote.c
index 4099183cacd..17a842f5684 100644
--- a/remote.c
+++ b/remote.c
@@ -12,7 +12,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/replace-object.c b/replace-object.c
index 7b8a09b5cb4..65b3c108629 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -2,7 +2,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "oidmap.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/replace-object.h b/replace-object.h
index ba478eb30c4..b1b059ed2fe 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -3,7 +3,7 @@
 
 #include "oidmap.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 
 struct replace_object {
 	struct oidmap_entry original;
diff --git a/repository.c b/repository.c
index dcc03fd9e0a..dbc7fa8685f 100644
--- a/repository.c
+++ b/repository.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
diff --git a/rerere.c b/rerere.c
index 3cd37c5f0ae..951e4bf8b41 100644
--- a/rerere.c
+++ b/rerere.c
@@ -18,7 +18,7 @@
 #include "path.h"
 #include "pathspec.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strmap.h"
 
 #define RESOLVED 0
diff --git a/revision.c b/revision.c
index 2c36a9c179e..cdefe7d6e48 100644
--- a/revision.c
+++ b/revision.c
@@ -8,7 +8,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oidset.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/send-pack.c b/send-pack.c
index 86592ce526d..abca2dd38a7 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,7 +4,7 @@
 #include "date.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/sequencer.c b/sequencer.c
index b5c4043757e..35f4e68d59f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,7 +13,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "object.h"
 #include "pager.h"
 #include "commit.h"
diff --git a/server-info.c b/server-info.c
index d6cd20a39d7..9bb30d9ab71 100644
--- a/server-info.c
+++ b/server-info.c
@@ -11,7 +11,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "server-info.h"
 #include "strbuf.h"
 #include "tempfile.h"
diff --git a/shallow.c b/shallow.c
index faeeeb45f98..d379756e39a 100644
--- a/shallow.c
+++ b/shallow.c
@@ -5,7 +5,7 @@
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/streaming.c b/streaming.c
index 127d6b5d6ac..29cc877f22a 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,7 +10,7 @@
 #include "streaming.h"
 #include "repository.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "replace-object.h"
 #include "packfile.h"
 
diff --git a/submodule-config.c b/submodule-config.c
index 0ee0a2884ef..09034a587f1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -13,7 +13,7 @@
 #include "submodule.h"
 #include "strbuf.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/submodule.c b/submodule.c
index ead3fb5dadc..9b1018877df 100644
--- a/submodule.c
+++ b/submodule.c
@@ -27,7 +27,7 @@
 #include "parse-options.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 76c2f4eba85..611a13a3261 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -2,7 +2,7 @@
 
 #include "test-tool.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "setup.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index fdf1b13437b..d51aaa3dc40 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "strbuf.h"
-#include "object-store.h"
+#include "odb.h"
 #include "packfile.h"
 #include "pack-mtimes.h"
 #include "setup.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index 34f1aee5581..dba227259a2 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "setup.h"
 
 /*
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index cd8ba0c54e7..bc37c00a3bd 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "bloom.h"
 #include "setup.h"
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index ac81390899a..da2aa036b57 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "midx.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 4cfc7c90b59..2920ca59d72 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "setup.h"
 #include "worktree.h"
-#include "object-store.h"
+#include "odb.h"
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/tag.c b/tag.c
index 05be39067cf..5f6868bf7b1 100644
--- a/tag.c
+++ b/tag.c
@@ -5,7 +5,7 @@
 #include "environment.h"
 #include "tag.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8fe0fdd7d4..9e05fcbddd0 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "quote.h"
-#include "object-store.h"
+#include "odb.h"
 #include "repository.h"
 
 struct tmp_objdir {
diff --git a/tree-walk.c b/tree-walk.c
index 90655d52378..34b0fff4873 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store.h"
+#include "odb.h"
 #include "trace2.h"
 #include "tree.h"
 #include "pathspec.h"
diff --git a/tree.c b/tree.c
index b85f56267fb..341b7c2ff3f 100644
--- a/tree.c
+++ b/tree.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "object-name.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "alloc.h"
 #include "tree-walk.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index 471837f0329..f38c761ab98 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,7 +26,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "fsmonitor.h"
-#include "object-store.h"
+#include "odb.h"
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/upload-pack.c b/upload-pack.c
index 956da5b061a..cec12cb478a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "oid-array.h"
 #include "object.h"
 #include "commit.h"
diff --git a/walker.c b/walker.c
index b470d43e54d..a8abe8a2e78 100644
--- a/walker.c
+++ b/walker.c
@@ -5,7 +5,7 @@
 #include "hex.h"
 #include "walker.h"
 #include "repository.h"
-#include "object-store.h"
+#include "odb.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tree.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 1edcd319e6e..01e6e378ea6 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "config.h"
 #include "hex.h"
-#include "object-store.h"
+#include "odb.h"
 #include "strbuf.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"

-- 
2.49.0.1077.gc0e912fd4c.dirty

