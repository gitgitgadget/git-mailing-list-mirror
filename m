Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237A3F9284
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922155; cv=none; b=Fe2g8Ywto7FcF06mKbq6ztei5fCwAYa+/3+UKw+OGk2Jl+cVa5yNf+iJOYeAwRXE9X7I9JEhdMK1qi7iKZfIBuM1CDRWuJot2eBQUsAbBNntMjBJAO9iQtSW/wSh5e9HP/mgqDnUYAHo5cPJihb/pviltb/IKgCbjtiXht4uSls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922155; c=relaxed/simple;
	bh=qEMyA97QN80BJQZbvp8T92nhqr7SEs+qbflmgdfEoE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZNjkDk1iMQy2C7ZB92RvMX8zS0aNxI2Ql67XHqS4F23NutDN5ZHGKDsVZUY0G1L0El4dYnQ+61XzeZ3aYAre9XnYd+K5hKOhkE337sa+3d5NCDHo2s2JjfVKvEwKXRExxRd0FLB1MvEO8SGB5akmSUABnww8PxfpMltNOpOR0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cexoGXeB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XH/DAGl8; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cexoGXeB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XH/DAGl8"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7E011400155;
	Wed,  5 Aug 2026 05:29:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Aug 2026 05:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922152;
	 x=1786008552; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=
	cexoGXeBbrM7qYY+4EyMLxq4dRsOVNYu9JWA37pcGh/DC7FyyufwqFiS8Kp4Xiwa
	w0C3z+20mz8sG479KWYnV16B2h49f6eD/7wzgzE+rkPKFvhLRCSwe+jTWNfrGRlh
	0ZH4THXJr1A9aXuGeRjUllJZWdqsazGGnVnjCerLKvmOqLIC3mIUzD4hIC3xeCfW
	LjJsPz/rqrFSvBvFIb6rMJycBBR+nmC0oNX0B3BsfXHccI28JMqG7aLHdHLe2yIr
	4LBK8DF9QlH1tLTrlw6pDEO/skh6h3vrvv6yjLI9E3sS4pXKALLf2Znouvj469Om
	mFL3KOsnSXrML9X4m4rOBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922152; x=
	1786008552; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=X
	H/DAGl8/J+kWXz55V/K2ihPDImlVPyzCoVKomdaQau4E8N7Amr/y289aiJ4uY7Lf
	5MDISJGvmlqDhEkKKJowpplLYVtyw/dCHoxBPK7EG3UnbOS48eqCwntwWbUi51t1
	f3d2nIk3W/483ub3i4bwOMWQFzjHGK6jaZsue+7ytQwUoho3DWEviW/dDEqimAio
	OyGtQVZcP19+7bM7tZnADjf6kmGppgmiSWEAMI0I+eDuSXPZgxJRzq+dv7SbLrLN
	g7753klyFX8iFKrMV6xy0Tzhz1SY0La6raP7hRTcXrfjJKna/aUMBo8KXaH3FK7E
	wPEXGn56RZnsOnWXiYABw==
X-ME-Sender: <xms:aAJzaoodHlIs-cpBB5wkd9MfnSxrA8kJs6PPSW_TAVX4_Te_fYmMAQ>
    <xme:aAJzalpQw08DIbbXIMyK-9HZWkWq5j9hiIZAzvamJrUAYtqpraGBpiZ_ov7QgCmJ2
    p80My5UEPpbi7SdC_cA5jXL_xwtvNmHEry58gBdlwkKweZtADTEcwQ>
X-ME-Received: <xmr:aAJzaiMgPP2XpzxW0sdZxib3n7LY5J7pxEmt52K3trHQsyxk3rRQXe3S420OskdxYFooyZjH2iwYO6E-nHVK-J1yXIWQ1ko5k7d0wCyGDg>
X-ME-Proxy-Cause: dmFkZTFMVDDgcjzGyb+u0o2NlPOyghMJKRGY8OF2IZN3wXX8OG6FCq0RnyXS3DXLwcFp5a
    WHvHvWeNnAu48J9SF22nYx9A0P1AHqFjPruFaaJCQdPNwTuW9gPEej71oDylC10BQ8w2th
    K/3gZu/fYfadWKtYYHSHbrSakyvA8i53poWZ4MhlKD0RFe/ZCdVMiLO27/ejQ9DsUbOKgA
    NzrLSOwheez59ND0rXt4GQq4b3K9D5WqcJlICqMpf/WSBi5Mh9CFv1W9UmuT6kR5umLfI3
    IAEWxvxW4h3rmS/hAsX/S1lFdX0IT0wiQ/h0c23T4sWXL5mWtKQUvn+HRPFS2DzI9ZUYcU
    ljiJr+s27HNIC3DHXMq6QVwlGXCW3gbBqRhkfQj3hJJknmbEdxsk3igQfeKW/yOrL2eraW
    W6dsutYUDhPRN/1NRhvgSmt0Mvg8c1hlmyXY+zvdsltqqbgLlUe7FxLLH2nrtxBZank2n/
    ZaFnf2MZgy6ao+Ory12g3rx7PPKxj8+Jw+hbqmQSy/Uf4HJnYAT0x52MkQ89YP2NmrkgZX
    d47dfOZqt4kCBeWTHLaQOppd6cX6HV92kn9UN4cdf8d1TrNJlddLFUchRJUWr2Q9Ukj8pa
    mbAO4yODmiy0nbMtuMj+95MKLbb6/OvoUMz5nspEluvyrJraQhPEPJeHvg8w
X-ME-Proxy: <xmx:aAJzauwu3aqLIEnmIeFJU5AbDgfXGYjLRTw-gc8gyd9KzDd_TeqNDA>
    <xmx:aAJzajs4Jg_U7WIEcrtD5wK8F7v0rhkqouW8ubXeMdtbOVKmLrWecg>
    <xmx:aAJzav5AxRjHn_XKwYHqI9KUJfCPZeYwHF7Ig2LtUiQWF5qW1tdsTQ>
    <xmx:aAJzaqTzc3r5JI5KdBdjf6q68rSQQNOeWrct0F7QLU824nEJUfIMGA>
    <xmx:aAJzal79eS5HFIzcC7WM_HPK7HpezcFFCQNXa-QMArFfgrNABPfD6Oe->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:29:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6ab48b47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:29:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 05 Aug 2026 11:28:55 +0200
Subject: [PATCH v3 5/6] odb/source: introduce function to map source type
 to name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-pks-odb-create-on-disk-v3-5-c0ee3ac5141f@pks.im>
References: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
In-Reply-To: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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
index 7993dcbd65..30188b806d 100644
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
+	[ODB_SOURCE_INMEMORY] = "in-memory",
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
2.55.0.679.g6767b8d81c.dirty

