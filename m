Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF89C35E1AF
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351756; cv=none; b=JtESEPLNsHIgb1vqZbZgA4HhPevIwZWHaGOLEj/GlFvfnNeRsfukHo1khnfLorU8Ybpb4LqYwHFlrjH56cS7R777y4ilXBNDWnox03YM5w5plmscjoW1KtaOjOTzEfD4GB3C7hOoz2Ct4dzkN9a6rvQaeiQMwSK4EyutwRp0e5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351756; c=relaxed/simple;
	bh=qJi9FMGB9D3xPCRNpX16uMi7yxUmdnlcyEPykEr8wqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDz7Oeb6cazQXGi/lYSQyX1VnCTpkI8GjeA+sU1BxjkxyP0cEGjJd27+iZgN3BBGWzDW00senWEMluCK1GY2Sv9e+SNPVqR+mbbO9PeSSUbYTI3kB/hfFifarMjsWIpnmSS3x3veRXcHLlin3reRlJNuSTx9lHdprFAOIb4L/0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eS8TuEae; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=opDg6+A0; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eS8TuEae";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="opDg6+A0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 121071400075
	for <git@vger.kernel.org>; Thu, 21 May 2026 04:22:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 21 May 2026 04:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779351754;
	 x=1779438154; bh=61PKOZT3JEp0trinZn19shQNIDjo/tR8KcVxFKu9hvc=; b=
	eS8TuEae2M21c1wUY5QfuVKLmD6z1jrD8VslbRE3HooLg+2ViBrlbcP8m9SehRJi
	CkisjzslZ2E2kM8j/HlmOhIaLqdUHfKStWL+7cg4MGCHVp5iH89h23os6CgiKgJD
	7JPqvMCKvqjxskL/0yR49718Dv7Tm25bYHcN5Z8KWbD4GTi1kVsQ+S/It0Nkeawe
	KljZBCCKgyov9hDgUyyvIZbFfBeX6xDcbJGOFmA6Al/jytoqVn4VJyUKqgg+qmrr
	bpxdcwLq5+tmBRkVoYtP8aHxmXhv62XG4kVbNTVObcct2AjNOJXzRlRAtQYsZGX2
	wsUqF16WQxNjv19oi/u+kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779351754; x=
	1779438154; bh=61PKOZT3JEp0trinZn19shQNIDjo/tR8KcVxFKu9hvc=; b=o
	pDg6+A0h8ZuimAZ3Ip+9Xi7kVjmfJM+FbgV3UcelZQZ4pcm79BDNtJyxkNa/nKp7
	PSqGYVVcvwdEFExhgewr+G94KOgxPtHpOtkJT9TJZ41UAfehVf3gh2Ra3h1Wx0/J
	uGkpbM4VrD0HzngNhPXPLZK5ZAjdo9hicHodjQDrRVJSVXaIfQYO90F8ux1ei7Uv
	cB0sIvY9ODUHHqnmicppPS+9NAUQLAM7rRjbHECpUI3CiZqhkje94m5MIHqZhPSn
	/8mDWKK3lxeH5vjgciB5iNCrOYzz8YDBL3AWHBNAaw9wlAWqa5CdIpeEReJ/8/wq
	VAUI4Neqc0qNfSUd70inQ==
X-ME-Sender: <xms:ycAOau6J8W0a7ugonc9-vtF__ICrXggVULq9iwdylIJKcFCDc9pEIg>
    <xme:ycAOau2iywMQKYklPI_iSy-JbsRMadAh9stUKcZpGC0mqLDofsSTM_KnZHWZqhhkK
    TVxQBB38VNJ7xO0NZeMXyAPFMcgN7k7hdM-fklctMSaUUNpn0C0DA>
X-ME-Received: <xmr:ycAOajG4s8a_OCMHRNdGrmc7FQlr0tOgh0I4eCenOdqgOn_tICvYuZ9hilgQNa5M8yDU6BnqhQhdM6tpwVtf0s2p7pK0lv8SE2QwMxegrH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:ycAOagT0osWpsFdDytp0m2kMjUjLHYFQ9HS6NIlTXEfaOI-LVgWVOQ>
    <xmx:ycAOaiBzcprb-bNKkUA0uX9DhdGsZsHead20tofCaynIR_8wJfIyAQ>
    <xmx:ycAOao2xVDkeg6UMXZiBOu-6Ubco2ki4O6thC6jGlz8AOYQ0IEwkAw>
    <xmx:ycAOaoVQj4M810aSad2EfB-N-MLoKAVakwzvV0QT17xx3QK2ttS8kA>
    <xmx:ysAOanZMDOhLey_JT-Q9ckySmO9u5AdR7Y7IqymGtoMf9fHcusU3Oc-Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 21 May 2026 04:22:33 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9e32bce0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 21 May 2026 08:22:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 21 May 2026 10:22:21 +0200
Subject: [PATCH 01/18] odb/source-loose: move loose source into "odb/"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-b4-pks-odb-source-loose-v1-1-6553b399be2d@pks.im>
References: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
In-Reply-To: <20260521-b4-pks-odb-source-loose-v1-0-6553b399be2d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In subsequent patches we'll be turning `struct odb_source_loose` into a
proper `struct odb_source`. As a first step towards this goal, move its
struct out of "object-file.c" and into "odb/source-loose.c".

This detaches the implementation of the loose object source from the
generic object file code, following the same convention already used by
the "files" and "in-memory" sources.

No functional changes are intended.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile           |  1 +
 meson.build        |  1 +
 object-file.c      |  8 --------
 object-file.h      | 21 +--------------------
 odb/source-loose.c | 10 ++++++++++
 odb/source-loose.h | 34 ++++++++++++++++++++++++++++++++++
 6 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/Makefile b/Makefile
index a43b8ee067..01356235c3 100644
--- a/Makefile
+++ b/Makefile
@@ -1217,6 +1217,7 @@ LIB_OBJS += odb.o
 LIB_OBJS += odb/source.o
 LIB_OBJS += odb/source-files.o
 LIB_OBJS += odb/source-inmemory.o
+LIB_OBJS += odb/source-loose.o
 LIB_OBJS += odb/streaming.o
 LIB_OBJS += odb/transaction.o
 LIB_OBJS += oid-array.o
diff --git a/meson.build b/meson.build
index 664d831329..c85e598835 100644
--- a/meson.build
+++ b/meson.build
@@ -405,6 +405,7 @@ libgit_sources = [
   'odb/source.c',
   'odb/source-files.c',
   'odb/source-inmemory.c',
+  'odb/source-loose.c',
   'odb/streaming.c',
   'odb/transaction.c',
   'oid-array.c',
diff --git a/object-file.c b/object-file.c
index 90f995d000..641bd9c079 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2205,14 +2205,6 @@ struct odb_transaction *odb_transaction_files_begin(struct odb_source *source)
 	return &transaction->base;
 }
 
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
-{
-	struct odb_source_loose *loose;
-	CALLOC_ARRAY(loose, 1);
-	loose->source = source;
-	return loose;
-}
-
 void odb_source_loose_free(struct odb_source_loose *loose)
 {
 	if (!loose)
diff --git a/object-file.h b/object-file.h
index 5241b8dd5c..1d8312cf7f 100644
--- a/object-file.h
+++ b/object-file.h
@@ -4,6 +4,7 @@
 #include "git-zlib.h"
 #include "object.h"
 #include "odb.h"
+#include "odb/source-loose.h"
 
 struct index_state;
 
@@ -20,26 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-struct odb_source_loose {
-	struct odb_source *source;
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
-	uint32_t subdir_seen[8]; /* 256 bits */
-	struct oidtree *cache;
-
-	/* Map between object IDs for loose objects. */
-	struct loose_object_map *map;
-};
-
-struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
 void odb_source_loose_free(struct odb_source_loose *loose);
 
 /* Reprepare the loose source by emptying the loose object cache. */
diff --git a/odb/source-loose.c b/odb/source-loose.c
new file mode 100644
index 0000000000..b944d21813
--- /dev/null
+++ b/odb/source-loose.c
@@ -0,0 +1,10 @@
+#include "git-compat-util.h"
+#include "odb/source-loose.h"
+
+struct odb_source_loose *odb_source_loose_new(struct odb_source *source)
+{
+	struct odb_source_loose *loose;
+	CALLOC_ARRAY(loose, 1);
+	loose->source = source;
+	return loose;
+}
diff --git a/odb/source-loose.h b/odb/source-loose.h
new file mode 100644
index 0000000000..8b4bac77ea
--- /dev/null
+++ b/odb/source-loose.h
@@ -0,0 +1,34 @@
+#ifndef ODB_SOURCE_LOOSE_H
+#define ODB_SOURCE_LOOSE_H
+
+#include "odb/source.h"
+
+struct object_database;
+struct oidtree;
+
+/*
+ * An object database source that stores its objects in loose format, one
+ * file per object. This source is part of the files source.
+ */
+struct odb_source_loose {
+	struct odb_source *source;
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
+	uint32_t subdir_seen[8]; /* 256 bits */
+	struct oidtree *cache;
+
+	/* Map between object IDs for loose objects. */
+	struct loose_object_map *map;
+};
+
+struct odb_source_loose *odb_source_loose_new(struct odb_source *source);
+
+#endif

-- 
2.54.0.926.g75ba10bac6.dirty

