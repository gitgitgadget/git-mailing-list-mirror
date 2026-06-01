Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526A389DE3
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302034; cv=none; b=kn5f1lExFs3kJlAnbZd/18/Hi84QAhO9Sr+vVd1tcyHCH6d4eWQfPMSmu/0IZ6ixL5xLAy4D1xzDKN075+mg5ArEq2Klf6gengWj+HUjnaIPxCYW6Q4WhSkOl8nyjHwsD7mJ+Q5my0Uonrr5BX2MNyia5BJd9wMRYeadbvJJC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302034; c=relaxed/simple;
	bh=qJi9FMGB9D3xPCRNpX16uMi7yxUmdnlcyEPykEr8wqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PXtpTbYUONgRsckFO4slpraIe8TgxbUkb6zbQFCyRrzwUGpWAM4SDm6gMRmg8ATleNMUWBvgJuvydlN7jVi514+rcd8fhXSCxHKaXyHOvNhj+pcUb5VFMhkTIzGz7bnqJ75vXDADwLxfxgQU+G33gtqoDUeu6wsPmpmO24CX7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M1fVKVNS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z0vqluFj; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M1fVKVNS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z0vqluFj"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 53C2AEC01B5;
	Mon,  1 Jun 2026 04:20:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302032;
	 x=1780388432; bh=61PKOZT3JEp0trinZn19shQNIDjo/tR8KcVxFKu9hvc=; b=
	M1fVKVNSzjGakpdD4R0L1Qbr+xrvQioelLMwWb6YzZJGaDehIH6kaXByQyLLcaVl
	zAUPm3w6cU9G7jPBokUXrabn7ILe6wzx33Ba2CdrUPLps9tZ5m3E+79olS00lFm+
	j9x0G9AhWIXH4R7grTCQOSNa4mg+3cskfT+mu2YikzDyLz30rAQCnjPI4VWH+Qa5
	2qKaoe+faZlou6miYWT+sluef6P44wrh0PV4D2sdVCDhWnarDAwfkOq/3VVJ4Qk1
	88rj3bbfGsoVTQXy4gAz14EE9bPQv0QIXjkTdw5Q4v0NzRxrtEo+LnsRVeu6j7Dl
	cnO/NEwLbn0dopSmsMe+UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302032; x=
	1780388432; bh=61PKOZT3JEp0trinZn19shQNIDjo/tR8KcVxFKu9hvc=; b=Z
	0vqluFjRrCFNr30H8iTl6iksSOgGQxsLb0y37TR3gXuqdyM2NBlj9kuS9A6FDGHS
	nT9cvEHMWoLYDjFvQQAAjcZt0A2hmrZ+Cq0i1tdiWyM3rTAz9xFwtVQGv56bMRTb
	YXUUnpKZ3A+Rm7dBLZFsQGwecrMg8tlvwrFdh5o3YyhYhuXJDvyFIiytjloi6BKp
	PfKe0VUh6wZcDqrmtiqeNmMOlxSSBZeJ/G1DbYS44h71NG2lCiwm3gH8ibw9l0jW
	XmBML4WgpvQ9SzRmKXl1nhCCnFi66YZlRhnZbM6mibpMP9ZZ0aN/xx19NQ9HvHau
	8/XRzJ2OL0/cUTvGiCRWA==
X-ME-Sender: <xms:z0Adam3K0IfZnLucnm643JpIptxNVn2y7Ky63Ci5PqFPieNu8e3hDA>
    <xme:z0AdavG902TF1F8TjGBp2d0X-nmU6qxdB07PrbZg8XAwvl8B_rDjKUiwuuuVQ36gl
    jNrvtTEPY1gsKTZ9W7WBx8oMRRv4Opq0wNQHUeWeTFM_mE7V8s>
X-ME-Received: <xmr:z0AdashbQ3d9KFIGDvYQ1d0DSTT4tYEMe6vp6IfGyQ1-DG0j_v34hDQMdqvAi0GwdybSU_WfkVFrxpQWjj3ZCSNQCfZfpkV_we4atUktN0eF>
X-ME-Proxy-Cause: dmFkZTGoVC3PWkC/M98GLpgwKSp8+X2EEbK9QrLPRCVzfq6z8mGb2cg1WSKI0P1YF6K99Q
    xKY18KC2TzQ71gWxrLtHBcpqPwInMMILQwQmN+IaQps5jv2t4yhm/OcWnxr3PAuKdie/5H
    xdZiEXHfq3CyGlKpLwv2vL5myW19uyY8AtAnQMD9jV84wJQFe0QGymylYpZQO++m8ND1Hj
    j7fjS2tB+vIBobG7JpZXtzobTDeXEGy6yi7zeMBs162gs+xcsIodAA21pY4HTX/IAVCIU8
    kOLzJFDG9r9Lr/xlbzdlHVCtb2SlM1MPmdQV95SWFIB7kaTFV8arUy82aX0eqGVCnq+Ehd
    0kIC0cpKvVBm6FtLFC6QVAaVDX8lpfK197m7uHRRSi9DCW6cSqMxlavdjwuKYhsD292qHC
    dP3EVNhd+bQRsdNZpKDjeXRJnZgLjtw9hENM51shqIyb67Tn2xWmhQVl2xdZA/lx8f+rfc
    jUTqla10yfl1fjkEH8G3vPqpnVWA/vzxnPLvZmbuz0Tc4XdjfmkpSkBMf1vm/aT61/taj7
    DeZ8l84XJAszed3ayYsyuak+jua8sVgoh338c+88vhn4IA2ifzLTb/9IWBI7JKmVohPTOZ
    88Wfhm8K99iww5hF+yZhtdYqNJ/0Xinif/I2u4GDcZ7d4FpW9u8s4QJNV6gg
X-ME-Proxy: <xmx:0EAdai8NXoAbwSvTZE-itN028_YawU1IqTHCYp_SEX7uealX2xn14A>
    <xmx:0EAdarpU_voir6jjVHPwSRF170FaoODz1ZbDqnraBnewusd_jPAOeA>
    <xmx:0EAdap8aeWMQ9HsqtXIEieraQslEtyVGVwDD9Wf1PS1mnn0MBXjb2A>
    <xmx:0EAdanXio3D_ETIqtpKHPlz3tCGmzWauRexEHw_3q90OZSbC_Rw1lA>
    <xmx:0EAdaiOTRM-93EarPTya_F2PxkbyckrBj3Y-SVjnMSrPOB8yvT1YQCBz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2729e2d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:24 +0200
Subject: [PATCH v2 01/18] odb/source-loose: move loose source into "odb/"
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-1-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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

