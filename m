Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994A9296148
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363815; cv=none; b=V2sSwaAUEZdOXgt4xwVzHrZ/m9kIzV5ffUwxzFh1PRc/jbBY/Es4JnA3A27FFtYM3diljn4Iyo0zkJsw9vD9EneegluxDJvmJYhV81uA/Ov9XFQ3Gd7MJcE5AlDDfrUsn+buYSrzuyAFBxoeNP/zwlYN81YJyYE6FH7ziEvbMv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363815; c=relaxed/simple;
	bh=NgFon5e7Sm0yJ+sXYjCM9yH7JLBgiZ7zsrcM0CBj5WY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxnVMK0e0VzUjrfYucmNGPmiTfDLiRzWVikV09BekwEzk0flRLuNPkCf/unbUCTPl1f/kSSKvwLInjPL0332Pex8obtN6x2RAEhUkbafBF1NBhsrL9kSsU/H6OUlsptQ5t7nPSVtVrskAP3Yde+1zRcWpstlTHgGpu3LZhd35eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=haPQRkC4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F9m8xY/C; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="haPQRkC4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9m8xY/C"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id ED48C11402C7;
	Fri, 11 Apr 2025 05:30:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 11 Apr 2025 05:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363809;
	 x=1744450209; bh=/AIkGlk6qg6P6v0GNlRIePMvKhQ2CM/W2+iRmeF97W4=; b=
	haPQRkC4GHm1wACgepaZQzjWmkc8RKG+AyTGVQwWMKSws+TyQjTGF57N+JG+G4e3
	wigWEX6T696A0Jofv6X4D6758kQkixhPwkrdjT3+Qf1uR3UKdJZJnuPUkgt26T2m
	HjT4l/tnFrgLMVykzzGbJ7uTLo//R+Hx6IiVI03i3qxpb4gKZyWaRdJDp62jsHdV
	1fbl8xvb6TLMXk4NXogLai5MwINm42jwy3vaRiAy0MLCQYR64RCBEaTeJsyMRrje
	fBp2KRP7xBdxjw1RWP9LwLQj0je8pEsmLLrh6DPt8UWdsC3hiwmepOEzw81UB48E
	QTga3vToUgjqV/wU4FcolQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363809; x=
	1744450209; bh=/AIkGlk6qg6P6v0GNlRIePMvKhQ2CM/W2+iRmeF97W4=; b=F
	9m8xY/C9veKeYXBNOMMVDcYj6idsiG245Y8gwn0cAs0+PcSzJDwOSgPDsfD2LX2a
	I4tC8SV7mjmmsvaB8LRkG7ZdvyMM9s/UgtUa4u2P3f9nPGNSEChluTWa94xeVC+4
	k5Vm1ZeAzugX7/yARg0xADwnjnGBu0afIfG/VPLSAdYGwN8wa63TtHJV7LH/Fkoq
	XG7DPK3zvV6kNinO/dwOpWfsXSQrq5Xoq3R6gBQmOq0zTfJharmp/nIOXPl2Ttqk
	CDk6O351M4nX70rND1r5n0hFzRHwyqmKoOgE/wkduIxxllqfQoYCNdjRnryPaXuu
	NzYeCkXxFncQhEiTdruuw==
X-ME-Sender: <xms:IeH4Z2aZFpOAq5GSZugmwCy6TVUkYjGnaJvYC9HcArfaoudTcLd8Vg>
    <xme:IeH4Z5YQbxSRCQ_J_w7FI44i7Fdl5Jcf3wAUpU7YEG3MVOm83UtfzKw6qaN2iRbb0
    4Iu_t7iJHsDhoDmQg>
X-ME-Received: <xmr:IeH4Zw8s2dFiTeo2rrf4ds9_SFLVdcGN0IGyuLmTwPt1d9PHGNOuynyjdOMB--_0LqkrynsjrE49htw0ZJcKoExQh58A12LCFaLg-lmVsnO3ozc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IeH4Z4qoxFvG_zLp1MKlxZ8HFkoVWl3lslchb0ehszJGmd1snqHuow>
    <xmx:IeH4ZxqDowlIItoT7pC9HS7pcVxSvntnyIoswhc8VYxYvM_wuToDUg>
    <xmx:IeH4Z2TKRutYDF2_r4ddRQou-U2H57uK9nlBIHpd5Oir4xao-B-ywA>
    <xmx:IeH4ZxqWx4XQiHqM1BpZ8US3NJMCKjZJ5Bw9cpsMsFpDTFbj9tWASA>
    <xmx:IeH4Z9HTJvOYQgrqPIfjb1DaXBnAqUbzoQMgOEBWQ2m0dJIG0Bz7GYwy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f31b92ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:58 +0200
Subject: [PATCH v2 9/9] object-store: merge "object-store-ll.h" and
 "object-store.h"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-9-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "object-store-ll.h" header has been introduced to keep transitive
header dependendcies and compile times at bay. Now that we have created
a new "object-store.c" file though we can easily move the last remaining
additional bit of "object-store.h", the `odb_path_map`, out of the
header.

Do so. As the "object-store.h" header is now equivalent to its low-level
alternative we drop the latter and inline it into the former.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 apply.c                       |   2 +-
 archive-tar.c                 |   2 +-
 archive-zip.c                 |   2 +-
 archive.c                     |   2 +-
 attr.c                        |   2 +-
 bisect.c                      |   2 +-
 blame.c                       |   2 +-
 builtin/backfill.c            |   2 +-
 builtin/blame.c               |   2 +-
 builtin/cat-file.c            |   2 +-
 builtin/checkout.c            |   2 +-
 builtin/clone.c               |   2 +-
 builtin/commit-graph.c        |   2 +-
 builtin/commit-tree.c         |   2 +-
 builtin/count-objects.c       |   2 +-
 builtin/describe.c            |   2 +-
 builtin/difftool.c            |   2 +-
 builtin/fast-export.c         |   2 +-
 builtin/fast-import.c         |   2 +-
 builtin/fetch.c               |   2 +-
 builtin/fsck.c                |   2 +-
 builtin/gc.c                  |   2 +-
 builtin/grep.c                |   2 +-
 builtin/hash-object.c         |   2 +-
 builtin/index-pack.c          |   2 +-
 builtin/log.c                 |   2 +-
 builtin/ls-tree.c             |   2 +-
 builtin/merge-tree.c          |   2 +-
 builtin/mktag.c               |   2 +-
 builtin/mktree.c              |   2 +-
 builtin/multi-pack-index.c    |   2 +-
 builtin/notes.c               |   2 +-
 builtin/pack-objects.c        |   2 +-
 builtin/pack-redundant.c      |   2 +-
 builtin/prune.c               |   2 +-
 builtin/receive-pack.c        |   2 +-
 builtin/remote.c              |   2 +-
 builtin/repack.c              |   2 +-
 builtin/replace.c             |   2 +-
 builtin/rev-list.c            |   2 +-
 builtin/show-ref.c            |   2 +-
 builtin/submodule--helper.c   |   2 +-
 builtin/tag.c                 |   2 +-
 builtin/unpack-file.c         |   2 +-
 builtin/unpack-objects.c      |   2 +-
 bulk-checkin.c                |   2 +-
 bundle-uri.c                  |   2 +-
 bundle.c                      |   2 +-
 cache-tree.c                  |   2 +-
 combine-diff.c                |   2 +-
 commit-graph.c                |   2 +-
 commit-graph.h                |   2 +-
 commit.c                      |   2 +-
 config.c                      |   2 +-
 connected.c                   |   2 +-
 convert.c                     |   2 +-
 diagnose.c                    |   2 +-
 diff.c                        |   2 +-
 diffcore-rename.c             |   2 +-
 dir.c                         |   2 +-
 entry.c                       |   2 +-
 fetch-pack.c                  |   2 +-
 fmt-merge-msg.c               |   2 +-
 fsck.c                        |   2 +-
 grep.c                        |   2 +-
 http-backend.c                |   2 +-
 http-push.c                   |   2 +-
 http-walker.c                 |   2 +-
 http.c                        |   2 +-
 list-objects-filter.c         |   2 +-
 list-objects.c                |   2 +-
 log-tree.c                    |   2 +-
 mailmap.c                     |   2 +-
 merge-blobs.c                 |   2 +-
 merge-recursive.c             |   2 +-
 notes-merge.c                 |   2 +-
 object-file.c                 |   1 +
 object-name.c                 |   2 +-
 object-store-ll.h             | 517 ------------------------------------------
 object-store.c                |   5 +
 object-store.h                | 516 ++++++++++++++++++++++++++++++++++++++++-
 oss-fuzz/fuzz-pack-idx.c      |   2 +-
 pack-bitmap-write.c           |   2 +-
 pack-bitmap.c                 |   2 +-
 pack-check.c                  |   2 +-
 pack-mtimes.c                 |   2 +-
 pack-objects.h                |   2 +-
 pack-revindex.c               |   2 +-
 packfile.c                    |   2 +-
 path.c                        |   2 +-
 promisor-remote.c             |   2 +-
 protocol-caps.c               |   2 +-
 prune-packed.c                |   2 +-
 reachable.c                   |   2 +-
 read-cache.c                  |   2 +-
 ref-filter.c                  |   2 +-
 reflog.c                      |   2 +-
 refs.c                        |   2 +-
 remote.c                      |   2 +-
 replace-object.c              |   2 +-
 replace-object.h              |   2 +-
 repository.c                  |   2 +-
 rerere.c                      |   2 +-
 revision.c                    |   2 +-
 send-pack.c                   |   2 +-
 sequencer.c                   |   2 +-
 server-info.c                 |   2 +-
 shallow.c                     |   2 +-
 streaming.c                   |   2 +-
 submodule-config.c            |   2 +-
 submodule.c                   |   2 +-
 t/helper/test-pack-mtimes.c   |   2 +-
 t/helper/test-partial-clone.c |   2 +-
 t/helper/test-read-graph.c    |   2 +-
 t/helper/test-read-midx.c     |   2 +-
 t/helper/test-ref-store.c     |   2 +-
 tag.c                         |   2 +-
 tmp-objdir.c                  |   2 +-
 tree-walk.c                   |   2 +-
 tree.c                        |   2 +-
 unpack-trees.c                |   2 +-
 upload-pack.c                 |   2 +-
 walker.c                      |   2 +-
 xdiff-interface.c             |   2 +-
 124 files changed, 637 insertions(+), 642 deletions(-)

diff --git a/apply.c b/apply.c
index f274a379487..2b6f4d0af87 100644
--- a/apply.c
+++ b/apply.c
@@ -14,7 +14,7 @@
 #include "abspath.h"
 #include "base85.h"
 #include "config.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "delta.h"
 #include "diff.h"
 #include "dir.h"
diff --git a/archive-tar.c b/archive-tar.c
index 0edf13fba75..282b48196f9 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -11,7 +11,7 @@
 #include "hex.h"
 #include "tar.h"
 #include "archive.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strbuf.h"
 #include "streaming.h"
 #include "run-command.h"
diff --git a/archive-zip.c b/archive-zip.c
index 9f32730181b..405da6f3d83 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -12,7 +12,7 @@
 #include "hex.h"
 #include "streaming.h"
 #include "utf8.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strbuf.h"
 #include "userdiff.h"
 #include "write-or-die.h"
diff --git a/archive.c b/archive.c
index c95e3981524..014c312178c 100644
--- a/archive.c
+++ b/archive.c
@@ -14,7 +14,7 @@
 #include "pretty.h"
 #include "setup.h"
 #include "refs.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "tree-walk.h"
diff --git a/attr.c b/attr.c
index 0bd2750528f..86b6109fc4e 100644
--- a/attr.c
+++ b/attr.c
@@ -22,7 +22,7 @@
 #include "read-cache-ll.h"
 #include "refs.h"
 #include "revision.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "setup.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/bisect.c b/bisect.c
index 269a98bf978..a327468c75b 100644
--- a/bisect.c
+++ b/bisect.c
@@ -20,7 +20,7 @@
 #include "commit-slab.h"
 #include "commit-reach.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "dir.h"
 
diff --git a/blame.c b/blame.c
index b7c5bd692e6..57daa45e899 100644
--- a/blame.c
+++ b/blame.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "refs.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "cache-tree.h"
 #include "mergesort.h"
 #include "commit.h"
diff --git a/builtin/backfill.c b/builtin/backfill.c
index 33e1ea2f84f..aaa104bc91d 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -13,7 +13,7 @@
 #include "tree.h"
 #include "tree-walk.h"
 #include "object.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "oidset.h"
 #include "promisor-remote.h"
diff --git a/builtin/blame.c b/builtin/blame.c
index c470654c7ec..4e156bfd19d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -28,7 +28,7 @@
 #include "line-log.h"
 #include "progress.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pager.h"
 #include "blame.h"
 #include "refs.h"
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b13561cf73b..c870fde260a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -22,7 +22,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "replace-object.h"
 #include "promisor-remote.h"
 #include "mailmap.h"
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3e68623838a..8136962e2b3 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -20,7 +20,7 @@
 #include "merge-recursive.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "parse-options.h"
 #include "path.h"
 #include "preload-index.h"
diff --git a/builtin/clone.c b/builtin/clone.c
index 2993acb630e..d0423a2198b 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -25,7 +25,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "tree.h"
 #include "tree-walk.h"
 #include "unpack-trees.h"
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 8ca75262c59..be06d0a811b 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -6,7 +6,7 @@
 #include "hex.h"
 #include "parse-options.h"
 #include "commit-graph.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "progress.h"
 #include "replace-object.h"
 #include "strbuf.h"
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 38457600a4e..6f9975e7a88 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 #include "commit.h"
 #include "parse-options.h"
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index 1e89148ed74..0bb5360b2f2 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 #include "quote.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static unsigned long garbage;
 static off_t size_garbage;
diff --git a/builtin/describe.c b/builtin/describe.c
index 23df333fd04..0f87fbceef3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -19,7 +19,7 @@
 #include "setup.h"
 #include "strvec.h"
 #include "run-command.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "list-objects.h"
 #include "commit-slab.h"
 #include "wildmatch.h"
diff --git a/builtin/difftool.c b/builtin/difftool.c
index 45d6ea8a801..e6e45436531 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -29,7 +29,7 @@
 #include "strbuf.h"
 #include "lockfile.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "dir.h"
 #include "entry.h"
 #include "setup.h"
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 170126d41ac..afacd228b5d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "object.h"
 #include "tag.h"
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 63880b595cc..0357211ea6c 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -24,7 +24,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "mem-pool.h"
 #include "commit-reach.h"
 #include "khash.h"
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 02af5054690..b52a32a5e0d 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oidset.h"
 #include "oid-array.h"
 #include "commit.h"
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 32d40d8f9fc..47055ebaf9a 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -18,7 +18,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
diff --git a/builtin/gc.c b/builtin/gc.c
index b069629676c..def922e7145 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -29,7 +29,7 @@
 #include "commit.h"
 #include "commit-graph.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pack.h"
 #include "pack-objects.h"
 #include "path.h"
diff --git a/builtin/grep.c b/builtin/grep.c
index 283d64cab80..bcfbe5be5ba 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -26,7 +26,7 @@
 #include "submodule-config.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "pager.h"
 #include "path.h"
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 7aa889b1b4a..e4eddd63bf4 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -11,7 +11,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "blob.h"
 #include "quote.h"
 #include "parse-options.h"
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index de127c0ff13..60a8ee05dbc 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -21,7 +21,7 @@
 #include "packfile.h"
 #include "pack-revindex.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "oidset.h"
 #include "path.h"
diff --git a/builtin/log.c b/builtin/log.c
index 06ffaa93e86..72ac45e9433 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -16,7 +16,7 @@
 #include "hex.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pager.h"
 #include "color.h"
 #include "commit.h"
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8542b5d53e4..8aafc30ca48 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -10,7 +10,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "tree.h"
 #include "path.h"
 #include "quote.h"
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 3ec7127b3a6..4aafa73c615 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -10,7 +10,7 @@
 #include "commit-reach.h"
 #include "merge-ort.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "parse-options.h"
 #include "blob.h"
 #include "merge-blobs.h"
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 6e188dce50a..7ac11c46d53 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -6,7 +6,7 @@
 #include "strbuf.h"
 #include "replace-object.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "fsck.h"
 #include "config.h"
 
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 0644f951161..7ffe6eefd8a 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -12,7 +12,7 @@
 #include "tree.h"
 #include "parse-options.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static struct treeent {
 	unsigned mode;
diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
index 2a938466f53..d98410ca6c6 100644
--- a/builtin/multi-pack-index.c
+++ b/builtin/multi-pack-index.c
@@ -7,7 +7,7 @@
 #include "midx.h"
 #include "strbuf.h"
 #include "trace2.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "replace-object.h"
 #include "repository.h"
 
diff --git a/builtin/notes.c b/builtin/notes.c
index 0dbc233752d..a3f433ca4c0 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -16,7 +16,7 @@
 #include "notes.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 
 #include "pretty.h"
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 163aab547fe..488c80f2cf3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -32,7 +32,7 @@
 #include "list.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "replace-object.h"
 #include "dir.h"
 #include "midx.h"
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3febe732f8e..5d1fc781761 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -13,7 +13,7 @@
 #include "hex.h"
 
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strbuf.h"
 
 #define BLKSIZE 512
diff --git a/builtin/prune.c b/builtin/prune.c
index 8f52da8bd66..e930caa0c0a 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -17,7 +17,7 @@
 #include "replace-object.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "shallow.h"
 
 static const char * const prune_usage[] = {
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index ee51bd76f60..be314879e82 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -33,7 +33,7 @@
 #include "packfile.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "protocol.h"
 #include "commit-reach.h"
diff --git a/builtin/remote.c b/builtin/remote.c
index 1b7aad88380..59481b3a82c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -14,7 +14,7 @@
 #include "rebase.h"
 #include "refs.h"
 #include "refspec.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strvec.h"
 #include "commit-reach.h"
 #include "progress.h"
diff --git a/builtin/repack.c b/builtin/repack.c
index f3330ade7b8..1fd2874324a 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -17,7 +17,7 @@
 #include "midx.h"
 #include "packfile.h"
 #include "prune-packed.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "promisor-remote.h"
 #include "shallow.h"
 #include "pack.h"
diff --git a/builtin/replace.c b/builtin/replace.c
index ce2948a9b2a..4204ca3605b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -19,7 +19,7 @@
 #include "run-command.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "read-cache.h"
 #include "replace-object.h"
 #include "tag.h"
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index bb26bee0d45..0170d79b62f 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -14,7 +14,7 @@
 #include "object.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pack-bitmap.h"
 #include "log-tree.h"
 #include "graph.h"
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 285cd3e4338..f81209f23c3 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -5,7 +5,7 @@
 #include "hex.h"
 #include "refs/refs-internal.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "object.h"
 #include "string-list.h"
 #include "parse-options.h"
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 570226ea166..a8d1200b7cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -28,7 +28,7 @@
 #include "diff.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "advice.h"
 #include "branch.h"
 #include "list-objects-filter-options.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 536a01ff3ae..e6b372cebf5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,7 +19,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "tag.h"
 #include "parse-options.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index b19e5cabd03..e33acfc4ee4 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static char *create_temp_file(struct object_id *oid)
 {
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 4078eab9252..661be789f13 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -9,7 +9,7 @@
 #include "git-zlib.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "object.h"
 #include "delta.h"
 #include "pack.h"
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 0b9bad92868..b38937d739b 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -19,7 +19,7 @@
 #include "tmp-objdir.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static int odb_transaction_nesting;
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 744257c49c1..96d2ba726d9 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -14,7 +14,7 @@
 #include "fetch-pack.h"
 #include "remote.h"
 #include "trace2.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static struct {
 	enum bundle_list_heuristic heuristic;
diff --git a/bundle.c b/bundle.c
index d7ad6908433..d661c4ec214 100644
--- a/bundle.c
+++ b/bundle.c
@@ -7,7 +7,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "repository.h"
 #include "object.h"
 #include "commit.h"
diff --git a/cache-tree.c b/cache-tree.c
index 4c8167ea927..c0e1e9ee1d4 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -10,7 +10,7 @@
 #include "cache-tree.h"
 #include "bulk-checkin.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "read-cache-ll.h"
 #include "replace-object.h"
 #include "repository.h"
diff --git a/combine-diff.c b/combine-diff.c
index 553bf59fed6..dfae9f7995d 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -2,7 +2,7 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "convert.h"
 #include "diff.h"
diff --git a/commit-graph.c b/commit-graph.c
index 8060c358b84..a36c2f1e303 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,7 +14,7 @@
 #include "refs.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "path.h"
 #include "alloc.h"
diff --git a/commit-graph.h b/commit-graph.h
index 67819401954..13f662827d4 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -1,7 +1,7 @@
 #ifndef COMMIT_GRAPH_H
 #define COMMIT_GRAPH_H
 
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oidset.h"
 
 #define GIT_TEST_COMMIT_GRAPH "GIT_TEST_COMMIT_GRAPH"
diff --git a/commit.c b/commit.c
index fbf4f8e87fd..00842678bd2 100644
--- a/commit.c
+++ b/commit.c
@@ -9,7 +9,7 @@
 #include "hex.h"
 #include "repository.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "utf8.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/config.c b/config.c
index accb47e2d18..b18b5617fcd 100644
--- a/config.c
+++ b/config.c
@@ -31,7 +31,7 @@
 #include "hashmap.h"
 #include "string-list.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pager.h"
 #include "path.h"
 #include "utf8.h"
diff --git a/connected.c b/connected.c
index 3099da84f33..4415388beba 100644
--- a/connected.c
+++ b/connected.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "run-command.h"
 #include "sigchain.h"
 #include "connected.h"
diff --git a/convert.c b/convert.c
index 9cc0ca20ca0..8783e17941f 100644
--- a/convert.c
+++ b/convert.c
@@ -8,7 +8,7 @@
 #include "copy.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "attr.h"
 #include "run-command.h"
 #include "quote.h"
diff --git a/diagnose.c b/diagnose.c
index bd485effea2..b1be74be983 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -7,7 +7,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "strvec.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "parse-options.h"
 #include "repository.h"
diff --git a/diff.c b/diff.c
index c361199ab1b..9f2042fd1a5 100644
--- a/diff.c
+++ b/diff.c
@@ -23,7 +23,7 @@
 #include "color.h"
 #include "run-command.h"
 #include "utf8.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "userdiff.h"
 #include "submodule.h"
 #include "hashmap.h"
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 5002e896aad..787a2cef5f4 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -8,7 +8,7 @@
 #include "git-compat-util.h"
 #include "diff.h"
 #include "diffcore.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "hashmap.h"
 #include "mem-pool.h"
 #include "oid-array.h"
diff --git a/dir.c b/dir.c
index 16ae3b5169d..1f8b6e2aa67 100644
--- a/dir.c
+++ b/dir.c
@@ -17,7 +17,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "name-hash.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/entry.c b/entry.c
index 81b321e53d1..f36ec5ad242 100644
--- a/entry.c
+++ b/entry.c
@@ -1,7 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "dir.h"
 #include "environment.h"
 #include "gettext.h"
diff --git a/fetch-pack.c b/fetch-pack.c
index 1ed5e11dd56..210dc30d50f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -24,7 +24,7 @@
 #include "oid-array.h"
 #include "oidset.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "connected.h"
 #include "fetch-negotiator.h"
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 5b63c3b088a..501b5acdd44 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -6,7 +6,7 @@
 #include "environment.h"
 #include "refs.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "diff.h"
 #include "diff-merges.h"
 #include "hex.h"
diff --git a/fsck.c b/fsck.c
index 9fc4c25ffd5..8dc8472ceb3 100644
--- a/fsck.c
+++ b/fsck.c
@@ -4,7 +4,7 @@
 #include "date.h"
 #include "dir.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "repository.h"
 #include "object.h"
diff --git a/grep.c b/grep.c
index 9284b5741f5..f8d535182c3 100644
--- a/grep.c
+++ b/grep.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "grep.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pretty.h"
 #include "userdiff.h"
 #include "xdiff-interface.h"
diff --git a/http-backend.c b/http-backend.c
index 50b2858fad6..0c575aa88aa 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -18,7 +18,7 @@
 #include "url.h"
 #include "strvec.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "protocol.h"
 #include "date.h"
 #include "write-or-die.h"
diff --git a/http-push.c b/http-push.c
index 806eb67cf1b..32e37565f4e 100644
--- a/http-push.c
+++ b/http-push.c
@@ -20,7 +20,7 @@
 #include "url.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit-reach.h"
 
 #ifdef EXPAT_NEEDS_XMLPARSE_H
diff --git a/http-walker.c b/http-walker.c
index 7918ddc0968..882cae19c24 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -9,7 +9,7 @@
 #include "list.h"
 #include "transport.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 struct alt_base {
 	char *base;
diff --git a/http.c b/http.c
index 0c9a872809f..bc18ff83c4b 100644
--- a/http.c
+++ b/http.c
@@ -19,7 +19,7 @@
 #include "packfile.h"
 #include "string-list.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "tempfile.h"
 
 static struct trace_key trace_curl = TRACE_KEY_INIT(CURL);
diff --git a/list-objects-filter.c b/list-objects-filter.c
index dc598a081bb..7765761b3c6 100644
--- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -12,7 +12,7 @@
 #include "oidmap.h"
 #include "oidset.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 /* Remember to update object flag allocation in object.h */
 /*
diff --git a/list-objects.c b/list-objects.c
index 943e62e868f..1e5512e1318 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -14,7 +14,7 @@
 #include "list-objects-filter.h"
 #include "list-objects-filter-options.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "trace.h"
 #include "environment.h"
 
diff --git a/log-tree.c b/log-tree.c
index 5dd1b63076f..a4d4ab59ca0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -9,7 +9,7 @@
 #include "environment.h"
 #include "hex.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "repository.h"
 #include "tmp-objdir.h"
 #include "commit.h"
diff --git a/mailmap.c b/mailmap.c
index f35d20ed7fd..9e2642a043b 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -6,7 +6,7 @@
 #include "string-list.h"
 #include "mailmap.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "setup.h"
 
 char *git_mailmap_file;
diff --git a/merge-blobs.c b/merge-blobs.c
index 0ad0390fea5..53f36dbc175 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -4,7 +4,7 @@
 #include "merge-ll.h"
 #include "blob.h"
 #include "merge-blobs.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 static int fill_mmfile_blob(mmfile_t *f, struct blob *obj)
 {
diff --git a/merge-recursive.c b/merge-recursive.c
index 9aedffc546b..981e57698ed 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -27,7 +27,7 @@
 #include "name-hash.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "repository.h"
 #include "revision.h"
diff --git a/notes-merge.c b/notes-merge.c
index 13750490eff..96e59322a8b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -8,7 +8,7 @@
 #include "refs.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "read-cache.h"
 #include "repository.h"
diff --git a/object-file.c b/object-file.c
index 235d29858ff..4abca6cb613 100644
--- a/object-file.c
+++ b/object-file.c
@@ -12,6 +12,7 @@
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
diff --git a/object-name.c b/object-name.c
index 91f731373a1..2c751a5352a 100644
--- a/object-name.c
+++ b/object-name.c
@@ -19,7 +19,7 @@
 #include "oidtree.h"
 #include "packfile.h"
 #include "pretty.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "read-cache-ll.h"
 #include "repo-settings.h"
 #include "repository.h"
diff --git a/object-store-ll.h b/object-store-ll.h
deleted file mode 100644
index bb5e8798a1b..00000000000
--- a/object-store-ll.h
+++ /dev/null
@@ -1,517 +0,0 @@
-#ifndef OBJECT_STORE_LL_H
-#define OBJECT_STORE_LL_H
-
-#include "hashmap.h"
-#include "object.h"
-#include "list.h"
-#include "thread-utils.h"
-#include "oidset.h"
-
-struct oidmap;
-struct oidtree;
-struct strbuf;
-struct repository;
-
-struct object_directory {
-	struct object_directory *next;
-
-	/*
-	 * Used to store the results of readdir(3) calls when we are OK
-	 * sacrificing accuracy due to races for speed. That includes
-	 * object existence with OBJECT_INFO_QUICK, as well as
-	 * our search for unique abbreviated hashes. Don't use it for tasks
-	 * requiring greater accuracy!
-	 *
-	 * Be sure to call odb_load_loose_cache() before using.
-	 */
-	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
-	struct oidtree *loose_objects_cache;
-
-	/* Map between object IDs for loose objects. */
-	struct loose_object_map *loose_map;
-
-	/*
-	 * This is a temporary object store created by the tmp_objdir
-	 * facility. Disable ref updates since the objects in the store
-	 * might be discarded on rollback.
-	 */
-	int disable_ref_updates;
-
-	/*
-	 * This object store is ephemeral, so there is no need to fsync.
-	 */
-	int will_destroy;
-
-	/*
-	 * Path to the alternative object store. If this is a relative path,
-	 * it is relative to the current working directory.
-	 */
-	char *path;
-};
-
-void prepare_alt_odb(struct repository *r);
-int has_alt_odb(struct repository *r);
-char *compute_alternate_path(const char *path, struct strbuf *err);
-struct object_directory *find_odb(struct repository *r, const char *obj_dir);
-typedef int alt_odb_fn(struct object_directory *, void *);
-int foreach_alt_odb(alt_odb_fn, void*);
-typedef void alternate_ref_fn(const struct object_id *oid, void *);
-void for_each_alternate_ref(alternate_ref_fn, void *);
-
-/*
- * Add the directory to the on-disk alternates file; the new entry will also
- * take effect in the current process.
- */
-void add_to_alternates_file(const char *dir);
-
-/*
- * Add the directory to the in-memory list of alternates (along with any
- * recursive alternates it points to), but do not modify the on-disk alternates
- * file.
- */
-void add_to_alternates_memory(const char *dir);
-
-/*
- * Replace the current writable object directory with the specified temporary
- * object directory; returns the former primary object directory.
- */
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
-
-/*
- * Restore a previous ODB replaced by set_temporary_main_odb.
- */
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
-
-/*
- * Populate and return the loose object cache array corresponding to the
- * given object ID.
- */
-struct oidtree *odb_loose_cache(struct object_directory *odb,
-				  const struct object_id *oid);
-
-/* Empty the loose object cache for the specified object directory. */
-void odb_clear_loose_cache(struct object_directory *odb);
-
-struct packed_git {
-	struct hashmap_entry packmap_ent;
-	struct packed_git *next;
-	struct list_head mru;
-	struct pack_window *windows;
-	off_t pack_size;
-	const void *index_data;
-	size_t index_size;
-	uint32_t num_objects;
-	size_t crc_offset;
-	struct oidset bad_objects;
-	int index_version;
-	time_t mtime;
-	int pack_fd;
-	int index;              /* for builtin/pack-objects.c */
-	unsigned pack_local:1,
-		 pack_keep:1,
-		 pack_keep_in_core:1,
-		 freshened:1,
-		 do_not_close:1,
-		 pack_promisor:1,
-		 multi_pack_index:1,
-		 is_cruft:1;
-	unsigned char hash[GIT_MAX_RAWSZ];
-	struct revindex_entry *revindex;
-	const uint32_t *revindex_data;
-	const uint32_t *revindex_map;
-	size_t revindex_size;
-	/*
-	 * mtimes_map points at the beginning of the memory mapped region of
-	 * this pack's corresponding .mtimes file, and mtimes_size is the size
-	 * of that .mtimes file
-	 */
-	const uint32_t *mtimes_map;
-	size_t mtimes_size;
-
-	/* repo denotes the repository this packfile belongs to */
-	struct repository *repo;
-
-	/* something like ".git/objects/pack/xxxxx.pack" */
-	char pack_name[FLEX_ARRAY]; /* more */
-};
-
-struct multi_pack_index;
-
-static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
-				     const struct hashmap_entry *entry,
-				     const struct hashmap_entry *entry2,
-				     const void *keydata)
-{
-	const char *key = keydata;
-	const struct packed_git *pg1, *pg2;
-
-	pg1 = container_of(entry, const struct packed_git, packmap_ent);
-	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
-
-	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
-}
-
-struct cached_object_entry;
-
-struct raw_object_store {
-	/*
-	 * Set of all object directories; the main directory is first (and
-	 * cannot be NULL after initialization). Subsequent directories are
-	 * alternates.
-	 */
-	struct object_directory *odb;
-	struct object_directory **odb_tail;
-	struct kh_odb_path_map *odb_by_path;
-
-	int loaded_alternates;
-
-	/*
-	 * A list of alternate object directories loaded from the environment;
-	 * this should not generally need to be accessed directly, but will
-	 * populate the "odb" list when prepare_alt_odb() is run.
-	 */
-	char *alternate_db;
-
-	/*
-	 * Objects that should be substituted by other objects
-	 * (see git-replace(1)).
-	 */
-	struct oidmap *replace_map;
-	unsigned replace_map_initialized : 1;
-	pthread_mutex_t replace_mutex; /* protect object replace functions */
-
-	struct commit_graph *commit_graph;
-	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
-
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c and midx.c
-	 */
-	struct multi_pack_index *multi_pack_index;
-
-	/*
-	 * private data
-	 *
-	 * should only be accessed directly by packfile.c
-	 */
-
-	struct packed_git *packed_git;
-	/* A most-recently-used ordered version of the packed_git list. */
-	struct list_head packed_git_mru;
-
-	struct {
-		struct packed_git **packs;
-		unsigned flags;
-	} kept_pack_cache;
-
-	/*
-	 * This is meant to hold a *small* number of objects that you would
-	 * want repo_read_object_file() to be able to return, but yet you do not want
-	 * to write them into the object store (e.g. a browse-only
-	 * application).
-	 */
-	struct cached_object_entry *cached_objects;
-	size_t cached_object_nr, cached_object_alloc;
-
-	/*
-	 * A map of packfiles to packed_git structs for tracking which
-	 * packs have been loaded already.
-	 */
-	struct hashmap pack_map;
-
-	/*
-	 * A fast, rough count of the number of objects in the repository.
-	 * These two fields are not meant for direct access. Use
-	 * repo_approximate_object_count() instead.
-	 */
-	unsigned long approximate_object_count;
-	unsigned approximate_object_count_valid : 1;
-
-	/*
-	 * Whether packed_git has already been populated with this repository's
-	 * packs.
-	 */
-	unsigned packed_git_initialized : 1;
-};
-
-struct raw_object_store *raw_object_store_new(void);
-void raw_object_store_clear(struct raw_object_store *o);
-
-/*
- * Create a temporary file rooted in the object database directory, or
- * die on failure. The filename is taken from "pattern", which should have the
- * usual "XXXXXX" trailer, and the resulting filename is written into the
- * "template" buffer. Returns the open descriptor.
- */
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
-
-/*
- * Create a pack .keep file named "name" (which should generally be the output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
-/*
- * Put in `buf` the name of the file in the local object database that
- * would be used to store a loose object with the specified oid.
- */
-const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const struct object_id *oid);
-
-void *map_loose_object(struct repository *r, const struct object_id *oid,
-		       unsigned long *size);
-
-void *repo_read_object_file(struct repository *r,
-			    const struct object_id *oid,
-			    enum object_type *type,
-			    unsigned long *size);
-
-/* Read and unpack an object file into memory, write memory to an object file */
-int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
-
-void hash_object_file(const struct git_hash_algo *algo, const void *buf,
-		      unsigned long len, enum object_type type,
-		      struct object_id *oid);
-
-/*
- * Add an object file to the in-memory object store, without writing it
- * to disk.
- *
- * Callers are responsible for calling write_object_file to record the
- * object in persistent storage before writing any other new objects
- * that reference it.
- */
-int pretend_object_file(struct repository *repo,
-			void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid);
-
-struct object_info {
-	/* Request */
-	enum object_type *typep;
-	unsigned long *sizep;
-	off_t *disk_sizep;
-	struct object_id *delta_base_oid;
-	struct strbuf *type_name;
-	void **contentp;
-
-	/* Response */
-	enum {
-		OI_CACHED,
-		OI_LOOSE,
-		OI_PACKED,
-		OI_DBCACHED
-	} whence;
-	union {
-		/*
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } cached;
-		 * struct {
-		 * 	... Nothing to expose in this case
-		 * } loose;
-		 */
-		struct {
-			struct packed_git *pack;
-			off_t offset;
-			unsigned int is_delta;
-		} packed;
-	} u;
-};
-
-/*
- * Initializer for a "struct object_info" that wants no items. You may
- * also memset() the memory to all-zeroes.
- */
-#define OBJECT_INFO_INIT { 0 }
-
-/* Invoke lookup_replace_object() on the given hash */
-#define OBJECT_INFO_LOOKUP_REPLACE 1
-/* Allow reading from a loose object file of unknown/bogus type */
-#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
-/* Do not retry packed storage after checking packed and loose storage */
-#define OBJECT_INFO_QUICK 8
-/*
- * Do not attempt to fetch the object if missing (even if fetch_is_missing is
- * nonzero).
- */
-#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
-/*
- * This is meant for bulk prefetching of missing blobs in a partial
- * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
- */
-#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
-
-/* Die if object corruption (not just an object being missing) was detected. */
-#define OBJECT_INFO_DIE_IF_CORRUPT 32
-
-int oid_object_info_extended(struct repository *r,
-			     const struct object_id *,
-			     struct object_info *, unsigned flags);
-
-/* Retry packed storage after checking packed and loose storage */
-#define HAS_OBJECT_RECHECK_PACKED 1
-
-/*
- * Returns 1 if the object exists. This function will not lazily fetch objects
- * in a partial clone.
- */
-int has_object(struct repository *r, const struct object_id *oid,
-	       unsigned flags);
-
-/*
- * These macros and functions are deprecated. If checking existence for an
- * object that is likely to be missing and/or whose absence is relatively
- * inconsequential (or is consequential but the caller is prepared to handle
- * it), use has_object(), which has better defaults (no lazy fetch in a partial
- * clone and no rechecking of packed storage). In the unlikely event that a
- * caller needs to assert existence of an object that it fully expects to
- * exist, and wants to trigger a lazy fetch in a partial clone, use
- * oid_object_info_extended() with a NULL struct object_info.
- *
- * These functions can be removed once all callers have migrated to
- * has_object() and/or oid_object_info_extended().
- */
-int repo_has_object_file(struct repository *r, const struct object_id *oid);
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags);
-
-void assert_oid_type(const struct object_id *oid, enum object_type expect);
-
-/*
- * Enabling the object read lock allows multiple threads to safely call the
- * following functions in parallel: repo_read_object_file(),
- * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
- *
- * obj_read_lock() and obj_read_unlock() may also be used to protect other
- * section which cannot execute in parallel with object reading. Since the used
- * lock is a recursive mutex, these sections can even contain calls to object
- * reading functions. However, beware that in these cases zlib inflation won't
- * be performed in parallel, losing performance.
- *
- * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
- * any of its callees end up calling it, this recursive call won't benefit from
- * parallel inflation.
- */
-void enable_obj_read_lock(void);
-void disable_obj_read_lock(void);
-
-extern int obj_read_use_lock;
-extern pthread_mutex_t obj_read_mutex;
-
-static inline void obj_read_lock(void)
-{
-	if(obj_read_use_lock)
-		pthread_mutex_lock(&obj_read_mutex);
-}
-
-static inline void obj_read_unlock(void)
-{
-	if(obj_read_use_lock)
-		pthread_mutex_unlock(&obj_read_mutex);
-}
-
-/*
- * Iterate over the files in the loose-object parts of the object
- * directory "path", triggering the following callbacks:
- *
- *  - loose_object is called for each loose object we find.
- *
- *  - loose_cruft is called for any files that do not appear to be
- *    loose objects. Note that we only look in the loose object
- *    directories "objects/[0-9a-f]{2}/", so we will not report
- *    "objects/foobar" as cruft.
- *
- *  - loose_subdir is called for each top-level hashed subdirectory
- *    of the object directory (e.g., "$OBJDIR/f0"). It is called
- *    after the objects in the directory are processed.
- *
- * Any callback that is NULL will be ignored. Callbacks returning non-zero
- * will end the iteration.
- *
- * In the "buf" variant, "path" is a strbuf which will also be used as a
- * scratch buffer, but restored to its original contents before
- * the function returns.
- */
-typedef int each_loose_object_fn(const struct object_id *oid,
-				 const char *path,
-				 void *data);
-typedef int each_loose_cruft_fn(const char *basename,
-				const char *path,
-				void *data);
-typedef int each_loose_subdir_fn(unsigned int nr,
-				 const char *path,
-				 void *data);
-int for_each_file_in_obj_subdir(unsigned int subdir_nr,
-				struct strbuf *path,
-				each_loose_object_fn obj_cb,
-				each_loose_cruft_fn cruft_cb,
-				each_loose_subdir_fn subdir_cb,
-				void *data);
-int for_each_loose_file_in_objdir(const char *path,
-				  each_loose_object_fn obj_cb,
-				  each_loose_cruft_fn cruft_cb,
-				  each_loose_subdir_fn subdir_cb,
-				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
-
-/* Flags for for_each_*_object() below. */
-enum for_each_object_flags {
-	/* Iterate only over local objects, not alternates. */
-	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
-
-	/* Only iterate over packs obtained from the promisor remote. */
-	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
-
-	/*
-	 * Visit objects within a pack in packfile order rather than .idx order
-	 */
-	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
-
-	/* Only iterate over packs that are not marked as kept in-core. */
-	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
-
-	/* Only iterate over packs that do not have .keep files. */
-	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
-};
-
-/*
- * Iterate over all accessible loose objects without respect to
- * reachability. By default, this includes both local and alternate objects.
- * The order in which objects are visited is unspecified.
- *
- * Any flags specific to packs are ignored.
- */
-int for_each_loose_object(each_loose_object_fn, void *,
-			  enum for_each_object_flags flags);
-
-/*
- * Iterate over all accessible packed objects without respect to reachability.
- * By default, this includes both local and alternate packs.
- *
- * Note that some objects may appear twice if they are found in multiple packs.
- * Each pack is visited in an unspecified order. By default, objects within a
- * pack are visited in pack-idx order (i.e., sorted by oid).
- */
-typedef int each_packed_object_fn(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data);
-int for_each_object_in_pack(struct packed_git *p,
-			    each_packed_object_fn, void *data,
-			    enum for_each_object_flags flags);
-int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum for_each_object_flags flags);
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
-
-#endif /* OBJECT_STORE_LL_H */
diff --git a/object-store.c b/object-store.c
index 17fa06a86fa..fc48925d230 100644
--- a/object-store.c
+++ b/object-store.c
@@ -4,9 +4,11 @@
 #include "abspath.h"
 #include "commit-graph.h"
 #include "config.h"
+#include "dir.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "khash.h"
 #include "lockfile.h"
 #include "loose.h"
 #include "object-file-convert.h"
@@ -24,6 +26,9 @@
 #include "submodule.h"
 #include "write-or-die.h"
 
+KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
+	struct object_directory *, 1, fspathhash, fspatheq)
+
 /*
  * This is meant to hold a *small* number of objects that you would
  * want repo_read_object_file() to be able to return, but yet you do not want
diff --git a/object-store.h b/object-store.h
index 1b3e3d7d014..46961dc9542 100644
--- a/object-store.h
+++ b/object-store.h
@@ -1,11 +1,517 @@
 #ifndef OBJECT_STORE_H
 #define OBJECT_STORE_H
 
-#include "khash.h"
-#include "dir.h"
-#include "object-store-ll.h"
+#include "hashmap.h"
+#include "object.h"
+#include "list.h"
+#include "oidset.h"
+#include "thread-utils.h"
 
-KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
-	struct object_directory *, 1, fspathhash, fspatheq)
+struct oidmap;
+struct oidtree;
+struct strbuf;
+struct repository;
+
+struct object_directory {
+	struct object_directory *next;
+
+	/*
+	 * Used to store the results of readdir(3) calls when we are OK
+	 * sacrificing accuracy due to races for speed. That includes
+	 * object existence with OBJECT_INFO_QUICK, as well as
+	 * our search for unique abbreviated hashes. Don't use it for tasks
+	 * requiring greater accuracy!
+	 *
+	 * Be sure to call odb_load_loose_cache() before using.
+	 */
+	uint32_t loose_objects_subdir_seen[8]; /* 256 bits */
+	struct oidtree *loose_objects_cache;
+
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *loose_map;
+
+	/*
+	 * This is a temporary object store created by the tmp_objdir
+	 * facility. Disable ref updates since the objects in the store
+	 * might be discarded on rollback.
+	 */
+	int disable_ref_updates;
+
+	/*
+	 * This object store is ephemeral, so there is no need to fsync.
+	 */
+	int will_destroy;
+
+	/*
+	 * Path to the alternative object store. If this is a relative path,
+	 * it is relative to the current working directory.
+	 */
+	char *path;
+};
+
+void prepare_alt_odb(struct repository *r);
+int has_alt_odb(struct repository *r);
+char *compute_alternate_path(const char *path, struct strbuf *err);
+struct object_directory *find_odb(struct repository *r, const char *obj_dir);
+typedef int alt_odb_fn(struct object_directory *, void *);
+int foreach_alt_odb(alt_odb_fn, void*);
+typedef void alternate_ref_fn(const struct object_id *oid, void *);
+void for_each_alternate_ref(alternate_ref_fn, void *);
+
+/*
+ * Add the directory to the on-disk alternates file; the new entry will also
+ * take effect in the current process.
+ */
+void add_to_alternates_file(const char *dir);
+
+/*
+ * Add the directory to the in-memory list of alternates (along with any
+ * recursive alternates it points to), but do not modify the on-disk alternates
+ * file.
+ */
+void add_to_alternates_memory(const char *dir);
+
+/*
+ * Replace the current writable object directory with the specified temporary
+ * object directory; returns the former primary object directory.
+ */
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy);
+
+/*
+ * Restore a previous ODB replaced by set_temporary_main_odb.
+ */
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path);
+
+/*
+ * Populate and return the loose object cache array corresponding to the
+ * given object ID.
+ */
+struct oidtree *odb_loose_cache(struct object_directory *odb,
+				  const struct object_id *oid);
+
+/* Empty the loose object cache for the specified object directory. */
+void odb_clear_loose_cache(struct object_directory *odb);
+
+struct packed_git {
+	struct hashmap_entry packmap_ent;
+	struct packed_git *next;
+	struct list_head mru;
+	struct pack_window *windows;
+	off_t pack_size;
+	const void *index_data;
+	size_t index_size;
+	uint32_t num_objects;
+	size_t crc_offset;
+	struct oidset bad_objects;
+	int index_version;
+	time_t mtime;
+	int pack_fd;
+	int index;              /* for builtin/pack-objects.c */
+	unsigned pack_local:1,
+		 pack_keep:1,
+		 pack_keep_in_core:1,
+		 freshened:1,
+		 do_not_close:1,
+		 pack_promisor:1,
+		 multi_pack_index:1,
+		 is_cruft:1;
+	unsigned char hash[GIT_MAX_RAWSZ];
+	struct revindex_entry *revindex;
+	const uint32_t *revindex_data;
+	const uint32_t *revindex_map;
+	size_t revindex_size;
+	/*
+	 * mtimes_map points at the beginning of the memory mapped region of
+	 * this pack's corresponding .mtimes file, and mtimes_size is the size
+	 * of that .mtimes file
+	 */
+	const uint32_t *mtimes_map;
+	size_t mtimes_size;
+
+	/* repo denotes the repository this packfile belongs to */
+	struct repository *repo;
+
+	/* something like ".git/objects/pack/xxxxx.pack" */
+	char pack_name[FLEX_ARRAY]; /* more */
+};
+
+struct multi_pack_index;
+
+static inline int pack_map_entry_cmp(const void *cmp_data UNUSED,
+				     const struct hashmap_entry *entry,
+				     const struct hashmap_entry *entry2,
+				     const void *keydata)
+{
+	const char *key = keydata;
+	const struct packed_git *pg1, *pg2;
+
+	pg1 = container_of(entry, const struct packed_git, packmap_ent);
+	pg2 = container_of(entry2, const struct packed_git, packmap_ent);
+
+	return strcmp(pg1->pack_name, key ? key : pg2->pack_name);
+}
+
+struct cached_object_entry;
+
+struct raw_object_store {
+	/*
+	 * Set of all object directories; the main directory is first (and
+	 * cannot be NULL after initialization). Subsequent directories are
+	 * alternates.
+	 */
+	struct object_directory *odb;
+	struct object_directory **odb_tail;
+	struct kh_odb_path_map *odb_by_path;
+
+	int loaded_alternates;
+
+	/*
+	 * A list of alternate object directories loaded from the environment;
+	 * this should not generally need to be accessed directly, but will
+	 * populate the "odb" list when prepare_alt_odb() is run.
+	 */
+	char *alternate_db;
+
+	/*
+	 * Objects that should be substituted by other objects
+	 * (see git-replace(1)).
+	 */
+	struct oidmap *replace_map;
+	unsigned replace_map_initialized : 1;
+	pthread_mutex_t replace_mutex; /* protect object replace functions */
+
+	struct commit_graph *commit_graph;
+	unsigned commit_graph_attempted : 1; /* if loading has been attempted */
+
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c and midx.c
+	 */
+	struct multi_pack_index *multi_pack_index;
+
+	/*
+	 * private data
+	 *
+	 * should only be accessed directly by packfile.c
+	 */
+
+	struct packed_git *packed_git;
+	/* A most-recently-used ordered version of the packed_git list. */
+	struct list_head packed_git_mru;
+
+	struct {
+		struct packed_git **packs;
+		unsigned flags;
+	} kept_pack_cache;
+
+	/*
+	 * This is meant to hold a *small* number of objects that you would
+	 * want repo_read_object_file() to be able to return, but yet you do not want
+	 * to write them into the object store (e.g. a browse-only
+	 * application).
+	 */
+	struct cached_object_entry *cached_objects;
+	size_t cached_object_nr, cached_object_alloc;
+
+	/*
+	 * A map of packfiles to packed_git structs for tracking which
+	 * packs have been loaded already.
+	 */
+	struct hashmap pack_map;
+
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * repo_approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
+	/*
+	 * Whether packed_git has already been populated with this repository's
+	 * packs.
+	 */
+	unsigned packed_git_initialized : 1;
+};
+
+struct raw_object_store *raw_object_store_new(void);
+void raw_object_store_clear(struct raw_object_store *o);
+
+/*
+ * Create a temporary file rooted in the object database directory, or
+ * die on failure. The filename is taken from "pattern", which should have the
+ * usual "XXXXXX" trailer, and the resulting filename is written into the
+ * "template" buffer. Returns the open descriptor.
+ */
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+
+/*
+ * Create a pack .keep file named "name" (which should generally be the output
+ * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
+ * error.
+ */
+int odb_pack_keep(const char *name);
+
+/*
+ * Put in `buf` the name of the file in the local object database that
+ * would be used to store a loose object with the specified oid.
+ */
+const char *loose_object_path(struct repository *r, struct strbuf *buf,
+			      const struct object_id *oid);
+
+void *map_loose_object(struct repository *r, const struct object_id *oid,
+		       unsigned long *size);
+
+void *repo_read_object_file(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type *type,
+			    unsigned long *size);
+
+/* Read and unpack an object file into memory, write memory to an object file */
+int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
+
+void hash_object_file(const struct git_hash_algo *algo, const void *buf,
+		      unsigned long len, enum object_type type,
+		      struct object_id *oid);
+
+/*
+ * Add an object file to the in-memory object store, without writing it
+ * to disk.
+ *
+ * Callers are responsible for calling write_object_file to record the
+ * object in persistent storage before writing any other new objects
+ * that reference it.
+ */
+int pretend_object_file(struct repository *repo,
+			void *buf, unsigned long len, enum object_type type,
+			struct object_id *oid);
+
+struct object_info {
+	/* Request */
+	enum object_type *typep;
+	unsigned long *sizep;
+	off_t *disk_sizep;
+	struct object_id *delta_base_oid;
+	struct strbuf *type_name;
+	void **contentp;
+
+	/* Response */
+	enum {
+		OI_CACHED,
+		OI_LOOSE,
+		OI_PACKED,
+		OI_DBCACHED
+	} whence;
+	union {
+		/*
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } cached;
+		 * struct {
+		 * 	... Nothing to expose in this case
+		 * } loose;
+		 */
+		struct {
+			struct packed_git *pack;
+			off_t offset;
+			unsigned int is_delta;
+		} packed;
+	} u;
+};
+
+/*
+ * Initializer for a "struct object_info" that wants no items. You may
+ * also memset() the memory to all-zeroes.
+ */
+#define OBJECT_INFO_INIT { 0 }
+
+/* Invoke lookup_replace_object() on the given hash */
+#define OBJECT_INFO_LOOKUP_REPLACE 1
+/* Allow reading from a loose object file of unknown/bogus type */
+#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2
+/* Do not retry packed storage after checking packed and loose storage */
+#define OBJECT_INFO_QUICK 8
+/*
+ * Do not attempt to fetch the object if missing (even if fetch_is_missing is
+ * nonzero).
+ */
+#define OBJECT_INFO_SKIP_FETCH_OBJECT 16
+/*
+ * This is meant for bulk prefetching of missing blobs in a partial
+ * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
+ */
+#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
+
+/* Die if object corruption (not just an object being missing) was detected. */
+#define OBJECT_INFO_DIE_IF_CORRUPT 32
+
+int oid_object_info_extended(struct repository *r,
+			     const struct object_id *,
+			     struct object_info *, unsigned flags);
+
+/* Retry packed storage after checking packed and loose storage */
+#define HAS_OBJECT_RECHECK_PACKED 1
+
+/*
+ * Returns 1 if the object exists. This function will not lazily fetch objects
+ * in a partial clone.
+ */
+int has_object(struct repository *r, const struct object_id *oid,
+	       unsigned flags);
+
+/*
+ * These macros and functions are deprecated. If checking existence for an
+ * object that is likely to be missing and/or whose absence is relatively
+ * inconsequential (or is consequential but the caller is prepared to handle
+ * it), use has_object(), which has better defaults (no lazy fetch in a partial
+ * clone and no rechecking of packed storage). In the unlikely event that a
+ * caller needs to assert existence of an object that it fully expects to
+ * exist, and wants to trigger a lazy fetch in a partial clone, use
+ * oid_object_info_extended() with a NULL struct object_info.
+ *
+ * These functions can be removed once all callers have migrated to
+ * has_object() and/or oid_object_info_extended().
+ */
+int repo_has_object_file(struct repository *r, const struct object_id *oid);
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags);
+
+void assert_oid_type(const struct object_id *oid, enum object_type expect);
+
+/*
+ * Enabling the object read lock allows multiple threads to safely call the
+ * following functions in parallel: repo_read_object_file(),
+ * read_object_with_reference(), oid_object_info() and oid_object_info_extended().
+ *
+ * obj_read_lock() and obj_read_unlock() may also be used to protect other
+ * section which cannot execute in parallel with object reading. Since the used
+ * lock is a recursive mutex, these sections can even contain calls to object
+ * reading functions. However, beware that in these cases zlib inflation won't
+ * be performed in parallel, losing performance.
+ *
+ * TODO: oid_object_info_extended()'s call stack has a recursive behavior. If
+ * any of its callees end up calling it, this recursive call won't benefit from
+ * parallel inflation.
+ */
+void enable_obj_read_lock(void);
+void disable_obj_read_lock(void);
+
+extern int obj_read_use_lock;
+extern pthread_mutex_t obj_read_mutex;
+
+static inline void obj_read_lock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_lock(&obj_read_mutex);
+}
+
+static inline void obj_read_unlock(void)
+{
+	if(obj_read_use_lock)
+		pthread_mutex_unlock(&obj_read_mutex);
+}
+
+/*
+ * Iterate over the files in the loose-object parts of the object
+ * directory "path", triggering the following callbacks:
+ *
+ *  - loose_object is called for each loose object we find.
+ *
+ *  - loose_cruft is called for any files that do not appear to be
+ *    loose objects. Note that we only look in the loose object
+ *    directories "objects/[0-9a-f]{2}/", so we will not report
+ *    "objects/foobar" as cruft.
+ *
+ *  - loose_subdir is called for each top-level hashed subdirectory
+ *    of the object directory (e.g., "$OBJDIR/f0"). It is called
+ *    after the objects in the directory are processed.
+ *
+ * Any callback that is NULL will be ignored. Callbacks returning non-zero
+ * will end the iteration.
+ *
+ * In the "buf" variant, "path" is a strbuf which will also be used as a
+ * scratch buffer, but restored to its original contents before
+ * the function returns.
+ */
+typedef int each_loose_object_fn(const struct object_id *oid,
+				 const char *path,
+				 void *data);
+typedef int each_loose_cruft_fn(const char *basename,
+				const char *path,
+				void *data);
+typedef int each_loose_subdir_fn(unsigned int nr,
+				 const char *path,
+				 void *data);
+int for_each_file_in_obj_subdir(unsigned int subdir_nr,
+				struct strbuf *path,
+				each_loose_object_fn obj_cb,
+				each_loose_cruft_fn cruft_cb,
+				each_loose_subdir_fn subdir_cb,
+				void *data);
+int for_each_loose_file_in_objdir(const char *path,
+				  each_loose_object_fn obj_cb,
+				  each_loose_cruft_fn cruft_cb,
+				  each_loose_subdir_fn subdir_cb,
+				  void *data);
+int for_each_loose_file_in_objdir_buf(struct strbuf *path,
+				      each_loose_object_fn obj_cb,
+				      each_loose_cruft_fn cruft_cb,
+				      each_loose_subdir_fn subdir_cb,
+				      void *data);
+
+/* Flags for for_each_*_object() below. */
+enum for_each_object_flags {
+	/* Iterate only over local objects, not alternates. */
+	FOR_EACH_OBJECT_LOCAL_ONLY = (1<<0),
+
+	/* Only iterate over packs obtained from the promisor remote. */
+	FOR_EACH_OBJECT_PROMISOR_ONLY = (1<<1),
+
+	/*
+	 * Visit objects within a pack in packfile order rather than .idx order
+	 */
+	FOR_EACH_OBJECT_PACK_ORDER = (1<<2),
+
+	/* Only iterate over packs that are not marked as kept in-core. */
+	FOR_EACH_OBJECT_SKIP_IN_CORE_KEPT_PACKS = (1<<3),
+
+	/* Only iterate over packs that do not have .keep files. */
+	FOR_EACH_OBJECT_SKIP_ON_DISK_KEPT_PACKS = (1<<4),
+};
+
+/*
+ * Iterate over all accessible loose objects without respect to
+ * reachability. By default, this includes both local and alternate objects.
+ * The order in which objects are visited is unspecified.
+ *
+ * Any flags specific to packs are ignored.
+ */
+int for_each_loose_object(each_loose_object_fn, void *,
+			  enum for_each_object_flags flags);
+
+/*
+ * Iterate over all accessible packed objects without respect to reachability.
+ * By default, this includes both local and alternate packs.
+ *
+ * Note that some objects may appear twice if they are found in multiple packs.
+ * Each pack is visited in an unspecified order. By default, objects within a
+ * pack are visited in pack-idx order (i.e., sorted by oid).
+ */
+typedef int each_packed_object_fn(const struct object_id *oid,
+				  struct packed_git *pack,
+				  uint32_t pos,
+				  void *data);
+int for_each_object_in_pack(struct packed_git *p,
+			    each_packed_object_fn, void *data,
+			    enum for_each_object_flags flags);
+int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
+			   void *data, enum for_each_object_flags flags);
+
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
+				 enum object_type required_type,
+				 unsigned long *size,
+				 struct object_id *oid_ret);
 
 #endif /* OBJECT_STORE_H */
diff --git a/oss-fuzz/fuzz-pack-idx.c b/oss-fuzz/fuzz-pack-idx.c
index 3e190214d14..609a343ee3e 100644
--- a/oss-fuzz/fuzz-pack-idx.c
+++ b/oss-fuzz/fuzz-pack-idx.c
@@ -1,5 +1,5 @@
 #include "git-compat-util.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 
 int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index 6a97b52b36d..4c7f7985e78 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -4,7 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 0dbd7c4ffe1..fb68d2ae637 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -17,7 +17,7 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
 #include "config.h"
diff --git a/pack-check.c b/pack-check.c
index 95dcbbe9852..874897d6cba 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -8,7 +8,7 @@
 #include "progress.h"
 #include "packfile.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 struct idx_entry {
 	off_t                offset;
diff --git a/pack-mtimes.c b/pack-mtimes.c
index bcea28e521d..20900ca88d3 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "strbuf.h"
 
diff --git a/pack-objects.h b/pack-objects.h
index d73e3843c92..d1c4ae7f9b6 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -1,7 +1,7 @@
 #ifndef PACK_OBJECTS_H
 #define PACK_OBJECTS_H
 
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "thread-utils.h"
 #include "pack.h"
 
diff --git a/pack-revindex.c b/pack-revindex.c
index 1ee7b49e206..37ad9c79268 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "strbuf.h"
 #include "trace2.h"
diff --git a/packfile.c b/packfile.c
index 9d09f8bc726..d91016f1c7f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -19,7 +19,7 @@
 #include "tree-walk.h"
 #include "tree.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "midx.h"
 #include "commit-graph.h"
 #include "pack-revindex.h"
diff --git a/path.c b/path.c
index 910756c8b32..1f7a014322c 100644
--- a/path.c
+++ b/path.c
@@ -15,7 +15,7 @@
 #include "submodule-config.h"
 #include "path.h"
 #include "packfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
 
diff --git a/promisor-remote.c b/promisor-remote.c
index 5801ebfd9b2..9d058586dfa 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -3,7 +3,7 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "promisor-remote.h"
 #include "config.h"
 #include "trace2.h"
diff --git a/protocol-caps.c b/protocol-caps.c
index 855f279c2f7..9b8db37a210 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -6,7 +6,7 @@
 #include "hash.h"
 #include "hex.h"
 #include "object.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
diff --git a/prune-packed.c b/prune-packed.c
index 7dad2fc0c16..c1d95a519d7 100644
--- a/prune-packed.c
+++ b/prune-packed.c
@@ -2,7 +2,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "progress.h"
 #include "prune-packed.h"
diff --git a/reachable.c b/reachable.c
index 1b26b9b1d76..16e23a38037 100644
--- a/reachable.c
+++ b/reachable.c
@@ -14,7 +14,7 @@
 #include "list-objects.h"
 #include "packfile.h"
 #include "worktree.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pack-bitmap.h"
 #include "pack-mtimes.h"
 #include "config.h"
diff --git a/read-cache.c b/read-cache.c
index 9909b56902f..9aef59cab4c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -22,7 +22,7 @@
 #include "refs.h"
 #include "dir.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "tree.h"
 #include "commit.h"
diff --git a/ref-filter.c b/ref-filter.c
index 6da8d4c03b6..7a274633cfc 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -12,7 +12,7 @@
 #include "refs.h"
 #include "wildmatch.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "repo-settings.h"
 #include "repository.h"
diff --git a/reflog.c b/reflog.c
index 1b5f031f6d7..60834a124d9 100644
--- a/reflog.c
+++ b/reflog.c
@@ -3,7 +3,7 @@
 
 #include "git-compat-util.h"
 #include "gettext.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "reflog.h"
 #include "refs.h"
 #include "revision.h"
diff --git a/refs.c b/refs.c
index 1208f86629b..14f25c499cd 100644
--- a/refs.c
+++ b/refs.c
@@ -19,7 +19,7 @@
 #include "run-command.h"
 #include "hook.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "object.h"
 #include "path.h"
 #include "submodule.h"
diff --git a/remote.c b/remote.c
index e609cf5c56a..7fc657d98b8 100644
--- a/remote.c
+++ b/remote.c
@@ -12,7 +12,7 @@
 #include "refs.h"
 #include "refspec.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "commit.h"
 #include "diff.h"
diff --git a/replace-object.c b/replace-object.c
index 9a3cdd809a9..7b8a09b5cb4 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -2,7 +2,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "oidmap.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "replace-object.h"
 #include "refs.h"
 #include "repository.h"
diff --git a/replace-object.h b/replace-object.h
index 66c41b938b4..ba478eb30c4 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -3,7 +3,7 @@
 
 #include "oidmap.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 
 struct replace_object {
 	struct oidmap_entry original;
diff --git a/repository.c b/repository.c
index 6cbaf2e3daa..9b3d6665fc6 100644
--- a/repository.c
+++ b/repository.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "config.h"
 #include "object.h"
 #include "lockfile.h"
diff --git a/rerere.c b/rerere.c
index 740e8ad1a0b..28e59c42380 100644
--- a/rerere.c
+++ b/rerere.c
@@ -18,7 +18,7 @@
 #include "path.h"
 #include "pathspec.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strmap.h"
 
 #define RESOLVED 0
diff --git a/revision.c b/revision.c
index b536c4a29ad..352e18b1f97 100644
--- a/revision.c
+++ b/revision.c
@@ -8,7 +8,7 @@
 #include "hex.h"
 #include "object-name.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oidset.h"
 #include "tag.h"
 #include "blob.h"
diff --git a/send-pack.c b/send-pack.c
index 856a65d5f5a..5005689cb55 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -4,7 +4,7 @@
 #include "date.h"
 #include "gettext.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pkt-line.h"
 #include "sideband.h"
 #include "run-command.h"
diff --git a/sequencer.c b/sequencer.c
index c112d2e1c43..925cfa1af68 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -13,7 +13,7 @@
 #include "dir.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "object.h"
 #include "pager.h"
 #include "commit.h"
diff --git a/server-info.c b/server-info.c
index 1ca0e00d51e..3048e5ee407 100644
--- a/server-info.c
+++ b/server-info.c
@@ -11,7 +11,7 @@
 #include "packfile.h"
 #include "path.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "server-info.h"
 #include "strbuf.h"
 #include "tempfile.h"
diff --git a/shallow.c b/shallow.c
index 06c3266a3e0..2f82ebd6e3f 100644
--- a/shallow.c
+++ b/shallow.c
@@ -5,7 +5,7 @@
 #include "repository.h"
 #include "tempfile.h"
 #include "lockfile.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tag.h"
 #include "pkt-line.h"
diff --git a/streaming.c b/streaming.c
index 018b794d252..127d6b5d6ac 100644
--- a/streaming.c
+++ b/streaming.c
@@ -10,7 +10,7 @@
 #include "streaming.h"
 #include "repository.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "replace-object.h"
 #include "packfile.h"
 
diff --git a/submodule-config.c b/submodule-config.c
index d82b404b73e..8630e27947d 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -13,7 +13,7 @@
 #include "submodule.h"
 #include "strbuf.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "parse-options.h"
 #include "thread-utils.h"
 #include "tree-walk.h"
diff --git a/submodule.c b/submodule.c
index 0821507ecaa..3e52ef3b036 100644
--- a/submodule.c
+++ b/submodule.c
@@ -27,7 +27,7 @@
 #include "parse-options.h"
 #include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit-reach.h"
 #include "read-cache-ll.h"
 #include "setup.h"
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index f8f9afbb5b1..50f5941bff7 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "strbuf.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "packfile.h"
 #include "pack-mtimes.h"
 #include "setup.h"
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
index a1af9710c31..34f1aee5581 100644
--- a/t/helper/test-partial-clone.c
+++ b/t/helper/test-partial-clone.c
@@ -1,7 +1,7 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "setup.h"
 
 /*
diff --git a/t/helper/test-read-graph.c b/t/helper/test-read-graph.c
index 811dde1cb3c..8b413b644be 100644
--- a/t/helper/test-read-graph.c
+++ b/t/helper/test-read-graph.c
@@ -3,7 +3,7 @@
 #include "test-tool.h"
 #include "commit-graph.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "bloom.h"
 #include "setup.h"
 
diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index fc632369618..ac81390899a 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "midx.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 2ff67c067ac..4cfc7c90b59 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 #include "setup.h"
 #include "worktree.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "path.h"
 #include "repository.h"
 #include "strbuf.h"
diff --git a/tag.c b/tag.c
index 8d9e9e29304..05be39067cf 100644
--- a/tag.c
+++ b/tag.c
@@ -5,7 +5,7 @@
 #include "environment.h"
 #include "tag.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "tree.h"
 #include "blob.h"
diff --git a/tmp-objdir.c b/tmp-objdir.c
index 31d16a4c2c5..c38fbeb5e8a 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -10,7 +10,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "quote.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "repository.h"
 
 struct tmp_objdir {
diff --git a/tree-walk.c b/tree-walk.c
index a0333979656..90655d52378 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -6,7 +6,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "object-file.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "trace2.h"
 #include "tree.h"
 #include "pathspec.h"
diff --git a/tree.c b/tree.c
index ad86ad1ba99..b85f56267fb 100644
--- a/tree.c
+++ b/tree.c
@@ -4,7 +4,7 @@
 #include "hex.h"
 #include "tree.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "alloc.h"
 #include "tree-walk.h"
diff --git a/unpack-trees.c b/unpack-trees.c
index cf5b73c84be..471837f0329 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -26,7 +26,7 @@
 #include "symlinks.h"
 #include "trace2.h"
 #include "fsmonitor.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "promisor-remote.h"
 #include "entry.h"
 #include "parallel-checkout.h"
diff --git a/upload-pack.c b/upload-pack.c
index 02ce6336028..30e4630f3a1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -10,7 +10,7 @@
 #include "pkt-line.h"
 #include "sideband.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "object.h"
 #include "commit.h"
diff --git a/walker.c b/walker.c
index 1cf3da02193..4fedc19f346 100644
--- a/walker.c
+++ b/walker.c
@@ -5,7 +5,7 @@
 #include "hex.h"
 #include "walker.h"
 #include "repository.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "commit.h"
 #include "strbuf.h"
 #include "tree.h"
diff --git a/xdiff-interface.c b/xdiff-interface.c
index 77712811ff1..1edcd319e6e 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -5,7 +5,7 @@
 #include "gettext.h"
 #include "config.h"
 #include "hex.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "strbuf.h"
 #include "xdiff-interface.h"
 #include "xdiff/xtypes.h"

-- 
2.49.0.777.g153de2bbd5.dirty

