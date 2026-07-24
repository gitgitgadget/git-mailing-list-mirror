Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B4C1FBE90
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784864957; cv=none; b=FIz1LpzJ9/u4RJovFms641ThyAwaWHzB50bl6Gfsnhpmq6jSsm7mQwUycTpSYWUmnWR0bfeKh92QZQYw2qP7MnMYuz6Ns8jDGuDvxBb6pkVvfHqpqnl+COSIKQ+04PdOTrxJlSOwcE87r5sPGJ22YocXHw1KejO7Pg8g3PzfUXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784864957; c=relaxed/simple;
	bh=jkm0ySpzzqXQEUvjhi16gzTwXuEKhwXqTrra33WfkRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bps+PoF7FDiWwEIHfSCq2oGL4MEWT2fyPMA2o0fya3ZkqPZdudna3PdTYEhX5+9u9fks14K+xfts3n0gsxh+22gPGvz8RJHXmAh8kfz15dTcTaoPV4WT6Gt3Al3Jc4bGg6LyHAiJfKQ+D0W0NBw1S/1tw0/IqVdIfguHbqw/dNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZgNNNK/Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LOblnXfo; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZgNNNK/Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LOblnXfo"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 522527A0329
	for <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:15 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 23 Jul 2026 23:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784864955;
	 x=1784951355; bh=oXHgD2hBpRpOIMcwjpI1c3LvAVLlJhfVAR6Qa0pROWo=; b=
	ZgNNNK/ZDp1LKVDsjHsuNHPcVSUjkONtRx2JhOV4i5R9fRTgQZGXue96iPizQlwS
	X5zFvZNbILTVNFd8mzZdLfvV75c/UE74JVtW3JcFf7KWi3ywWVWNS6V3pGLSdGy6
	VAu8XU65ozqx/m+8zi2SfnrBFrGBKR+RdFGWycH0B/TdI4HrsihyjmSktBQ0fypX
	o0ukxnUEc0c4H+brUtbcDnW6943UQYXkjgFa8vCkzZGOAWnWmF6wDk57MrDlMJQE
	1eE5Y3B2o54QYtPm+e01qjaSqKR96Ql/C8I/WR2S0VIl5zGzLuJrIxOY88/17g+P
	+1jfCYQWg0KH66GgSvQ2cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784864955; x=
	1784951355; bh=oXHgD2hBpRpOIMcwjpI1c3LvAVLlJhfVAR6Qa0pROWo=; b=L
	OblnXfohRniwUdTyxEH2zCU1P0NRQtYwaA/JdVM6KOtKYugpaCd/HZycU0r63sLZ
	wG+aS/Lq/nxhPDhxfECBZbgv3w4rjfU5fuAkKiFIBQ/rgJSd6JtSqvIqp7hMHYj+
	HoJLhttqK8o4V2EOMqU7Rptwpc+aPmp1LSGQsrhYFvt1Edoj4K+lyZHYD7U7xKpL
	LymkU2Cqgi/BhySPpTNAwAgjSCX/qX3imL0SB6Sroll1jXy9qrpp4YY61/wizxeb
	yoKJiqsNG8h5NfolgiH+fBHLYEcdsmD6kYyVQV8EQdW4glPcSBvRGBzlxrSt/0Sh
	s52n4Rvz/yqHpsEPlnGGg==
X-ME-Sender: <xms:u-BianMrHeKcTK_-GPwVXbzC8kdYY7eN1wbeSEbGT72dVtLnPhB99g>
    <xme:u-Biao7mGOq2ivZbwIigFi5ia3s0EugxD3tY8GQ1Getcf2Zi5bRtIIy5K0vUVrHxc
    kkSU17tpQoaZu4SCEy48Zxgj9Crrd-PXH6fpnM40MCsZLrWoGPBMA>
X-ME-Received: <xmr:u-Biar4pyDY-wlXghNaWdTQfmYYfHVtbRiinNHNzBls4t31I33I3QG8hhtJ_VimQqvZt9jCBlWYczJgWhI0-lLjKd_xnjUWbqn4LZGpgX68>
X-ME-Proxy-Cause: dmFkZTGsA7YOejt2deRbD0qRO7BTn1ESxOOsCG4Sh3Klkpquyv+B5/ZDpPA7rcVYiMYDcT
    kCh2Erp2PQ1lDgLUAUhPkgxrgeyBboGotfYvjqdvKL3QOziy0obOZCEb8UcNeorntwDaMq
    7cu8qp+kgR8MeIwhilP3trcWOMHOy7tOoDRiXe+ovhp7uoUyfHvqnoOVjxwP8jVrhi7LLE
    5H7zxTH5TfwS2scWzeZNfkVqF/pq8XIfpND2rVDeDES3SDvMEzkE+cNvsDGeTVRgXChJ1F
    pX66cp1VPSua5kfePO7q4C45VqUpEPSkmNcprCUf1azSM8kU7h9LFbPPkZPe1jrJdX6lZs
    +Q5FAHTHPCHXE6gF7yaMqefxquQ+arI55hli0SbkRCO1iKRr98BVSq/8JPuppgj/B8fzKg
    216u/sJbnrwqxUBgwhti+J0xvWTPfZ77UCSStJU+3mrF1eNPTsza1ZtlGuzgLs7t/jyW/F
    cq+bcdov+/TEZYmRiOBKSa1F2eoe1Z4OK9rk2lWAX7RneA8bgve/17kIoLFzck7tpdA3AP
    4GK8i+eNUgptZsL9Qxde7krGLL2DA7NVY1sU5EDPZy+UYR6fAhJaAPvBZ8vKRb/0JFlEKH
    +5lTCdEBi66z0jTMcZ4KvQmcktBbOZ9uQ4JmOuVWsuUuTiFL7FQOTNVfeDGQ
X-ME-Proxy: <xmx:u-Biag37V9BTYW_ogqbK0XzRw6feypuO5ldqiblojv2mPGMWq_HaUg>
    <xmx:u-BiavWHJBj089Iy7CWvfOhUpVlOyzROKXKxwwvF9txcwWiuNZosRA>
    <xmx:u-Biaj7uOqdwCKSSqO3FItiMXbQ9xWz5rnY9TmavOI_2eCCbLQvYgg>
    <xmx:u-BiauItSppP8o2DgM_t7v0FSN8P52GdIlW4LXNZp83ZjLfVVTKY1A>
    <xmx:u-Biar8nJZqYs9AMuBTFxTlNvUjScT6YKMfSurTidEcXXj7b8wDlEX7e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 Jul 2026 23:49:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c239f3f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 24 Jul 2026 03:49:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 24 Jul 2026 05:48:43 +0200
Subject: [PATCH 4/5] odb/source: introduce function to map source type to
 name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-pks-odb-create-on-disk-v1-4-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Introduce a new function that maps an object source's type to a
human-readable name. Use the function to provide better human-readable
error messages for the downcasting functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.h    |  4 +++-
 odb/source-inmemory.h |  4 +++-
 odb/source-loose.h    |  4 +++-
 odb/source-packed.h   |  4 +++-
 odb/source.c          | 19 +++++++++++++++++++
 odb/source.h          |  6 ++++++
 6 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/odb/source-files.h b/odb/source-files.h
index d7ac3c1c81..6a803afdda 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -28,7 +28,9 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 static inline struct odb_source_files *odb_source_files_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_FILES)
-		BUG("trying to downcast source of type '%d' to files", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_FILES));
 	return container_of(source, struct odb_source_files, base);
 }
 
diff --git a/odb/source-inmemory.h b/odb/source-inmemory.h
index a88fc2e320..adbad23e8b 100644
--- a/odb/source-inmemory.h
+++ b/odb/source-inmemory.h
@@ -26,7 +26,9 @@ struct odb_source_inmemory *odb_source_inmemory_new(struct object_database *odb)
 static inline struct odb_source_inmemory *odb_source_inmemory_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_INMEMORY)
-		BUG("trying to downcast source of type '%d' to in-memory", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_INMEMORY));
 	return container_of(source, struct odb_source_inmemory, base);
 }
 
diff --git a/odb/source-loose.h b/odb/source-loose.h
index 6070aaf3ce..3cf2e1f8f1 100644
--- a/odb/source-loose.h
+++ b/odb/source-loose.h
@@ -41,7 +41,9 @@ struct odb_source_loose *odb_source_loose_new(struct object_database *odb,
 static inline struct odb_source_loose *odb_source_loose_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_LOOSE)
-		BUG("trying to downcast source of type '%d' to loose", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_LOOSE));
 	return container_of(source, struct odb_source_loose, base);
 }
 
diff --git a/odb/source-packed.h b/odb/source-packed.h
index 77309ddd09..a0f6b5096d 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -78,7 +78,9 @@ struct odb_source_packed *odb_source_packed_new(struct object_database *odb,
 static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_source *source)
 {
 	if (source->type != ODB_SOURCE_PACKED)
-		BUG("trying to downcast source of type '%d' to packed", source->type);
+		BUG("trying to downcast source of type '%s' to '%s'",
+		    odb_source_type_to_name(source->type),
+		    odb_source_type_to_name(ODB_SOURCE_PACKED));
 	return container_of(source, struct odb_source_packed, base);
 }
 
diff --git a/odb/source.c b/odb/source.c
index 7993dcbd65..c300e836f6 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -4,6 +4,25 @@
 #include "odb/source.h"
 #include "packfile.h"
 
+static const char * const odb_source_names_by_type[] = {
+	[ODB_SOURCE_UNKNOWN] = "unknown",
+	[ODB_SOURCE_FILES] = "files",
+	[ODB_SOURCE_LOOSE] = "loose",
+	[ODB_SOURCE_PACKED] = "packed",
+	[ODB_SOURCE_INMEMORY] = "inmemory",
+};
+
+const char *odb_source_type_to_name(enum odb_source_type type)
+{
+	const char *name;
+	if (type < 0 || type >= ARRAY_SIZE(odb_source_names_by_type))
+		type = ODB_SOURCE_UNKNOWN;
+	name = odb_source_names_by_type[type];
+	if (!name)
+		BUG("name missing in `odb_source_names_by_type` for '%d'", type);
+	return name;
+}
+
 struct odb_source *odb_source_new(struct object_database *odb,
 				  const char *path,
 				  bool local)
diff --git a/odb/source.h b/odb/source.h
index cd63dba91f..ab16d152f4 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -25,6 +25,12 @@ enum odb_source_type {
 	ODB_SOURCE_INMEMORY,
 };
 
+/*
+ * Convert between the enum and its name. Returns the equivalent of "unknown"
+ * for unknown types.
+ */
+const char *odb_source_type_to_name(enum odb_source_type type);
+
 struct object_id;
 struct odb_read_stream;
 struct strvec;

-- 
2.55.0.407.g700c83d4f3.dirty

