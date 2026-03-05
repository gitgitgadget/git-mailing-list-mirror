Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84B2517AA
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 14:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772720425; cv=none; b=aXyMLOhtpS+N7N2R9MpFmqkxPzzDuJPOUx21biQR0cj5gafwe7m6szUgNNAl3UTRaLxm7COWUcirW9K9wEnSNeaW5weGnswQpH9YuozJE2XE4uvgryU/IGsqOocLIL/5djlUp1GuW1wKVzhJQG73x8hezJ+gWxiF+I3fP0+ORXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772720425; c=relaxed/simple;
	bh=B+tBbaw+uV5X5hvkGFryg8zynA/FExnJq/AmSv5pWiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WhwPKYKZ00gV6gX2pVoEiQYEXW670duQmVkr3wckygA5owDCd1ZmN/hThZgs6oGn0OW3FGsfLzMdB3eVVXwO+9M4qyoW1FZgRYXAEgd/Q1BNhfzjKrSZ31SLi4JLFkZnvIKN0d4T38qGbUepgrhGeJJ8qvu4NEMIwOCGVQ1fxE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWmERf+h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vdFXiXSw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWmERf+h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vdFXiXSw"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 97BA97A01E2;
	Thu,  5 Mar 2026 09:20:23 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 05 Mar 2026 09:20:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772720423;
	 x=1772806823; bh=oDrtitXslqRNpEJZh/fMiL5ks/BzXv8erwobLN0Guhs=; b=
	kWmERf+hCHTakqBnKEGn/ZDrjDoH0IPdh/AxjW8scOtOOYyxDvieynfiLVuZRRnf
	0sCFwdENWftX1ck8u0MNFz+J6q5sOnm0G2GpqwpZF38b0b8gdQpCbPRpZVkv0qKD
	yG5Ibh1JEYANMSyjOhAZJImgflpxIOoRn1ivOeTHDwXzVHVH6Us/rCQ+HpQl1BFL
	qTnt1Di+Tb4qwUQyKOqWV3dwge7xCOQGfUjkjA96i6F1QgdSTY7H+Bm7rSJc5iHh
	8vEcW4c3negsoomGhQjDLsSIrDWDjxmb10MhmVRIAxsnKkOxxO7X+fvfBytQ3DL+
	PI1M1tTd4mGT06Lyh+2Wbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772720423; x=
	1772806823; bh=oDrtitXslqRNpEJZh/fMiL5ks/BzXv8erwobLN0Guhs=; b=v
	dFXiXSwGpxOw/XMcvQm8YBn3KG2pznHat+0REaoOmkl9Mau0ScJY+O66EFp/RcM9
	jjlQXaBDLViOZ1WGVQKUsztgG9ZnKO1ErotiRVEVUsBvM9Yqm+c3Tu6Xd7G8f/dr
	2u5hZp+qRehNFJ69l1wl0bg992fSNWlsluEbWIK/hgLwllUeiuKcDm9d3mRJtRvU
	3YCLEb6Gg7eTgV4i9IKt+eisbYawrQ71Js1DDrqkgCpAPOmQrOzbgbBLaRbAJh19
	fUqD/p9/21sANJmydjc9QiMAeGAIa4s6vhODEBWjHgqVAmpRE45t/rDCn5Ju7BEC
	iennkeouY665MSmKq6KJQ==
X-ME-Sender: <xms:J5GpaT3Djuo9t6N4IarQFy682MUJwylWQo9vuMDGW4VYzQ8v6hhJrQ>
    <xme:J5GpaZGvnGfsThsTerhbbsFte68HUWTKN1neG-H7T1hIfGvabZBswJfmVWIpguotB
    l_wNpjUYEZgF7oXMGhgYXiymCTgSSEmY3-NvQWe4jkCPIWQLcg>
X-ME-Received: <xmr:J5GpaY4UCekkrbPJA65ouIJSOtCF8FJzwfKweWc5H5bJKm5w0pMGNBWrNwmxv6fxHM9zkFlCkDCjzRYHuSbQBkyVTfgmJBtfeZk7drej1PTO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeiiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J5GpaXtiXVEHvhDuBdB8-NKJ8GV7-CDwYby68RUa-JWAeNMwEwhqZA>
    <xmx:J5GpaR6m4quVTStgAkRhjOBGBU-i6_7Y6Z62zTlMxoBS8VkPbe9yBw>
    <xmx:J5GpaaX8_Ubk4v8mKfRZKPb7QwRnh8TdB74gBY-I_ArQY462lZFuZA>
    <xmx:J5Gpab_jJ_Fx5wqh5L_BvKg9QoXV0ptf_1OLY5Z9q5VFVKDbtFyMKg>
    <xmx:J5GpaUY40DgVBod5q57TcM6QhhXj20cbPqvNkUxUFOSvCpt4_jcorRlq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 09:20:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3c758b34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 14:20:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Mar 2026 15:19:53 +0100
Subject: [PATCH v2 13/17] odb/source: make `write_object()` function
 pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-b4-pks-odb-source-pluggable-v2-13-3290bfd1f444@pks.im>
References: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c              |  4 ++--
 odb/source-files.c | 12 ++++++++++++
 odb/source.h       | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/odb.c b/odb.c
index c9f42c5afd..5eb60063dc 100644
--- a/odb.c
+++ b/odb.c
@@ -1005,8 +1005,8 @@ int odb_write_object_ext(struct object_database *odb,
 			 struct object_id *compat_oid,
 			 unsigned flags)
 {
-	return odb_source_loose_write_object(odb->sources, buf, len, type,
-					     oid, compat_oid, flags);
+	return odb_source_write_object(odb->sources, buf, len, type,
+				       oid, compat_oid, flags);
 }
 
 int odb_write_object_stream(struct object_database *odb,
diff --git a/odb/source-files.c b/odb/source-files.c
index a6447909e0..67c2aff659 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -98,6 +98,17 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_files_write_object(struct odb_source *source,
+					 const void *buf, unsigned long len,
+					 enum object_type type,
+					 struct object_id *oid,
+					 struct object_id *compat_oid,
+					 unsigned flags)
+{
+	return odb_source_loose_write_object(source, buf, len, type,
+					     oid, compat_oid, flags);
+}
+
 struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local)
@@ -116,6 +127,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->base.read_object_stream = odb_source_files_read_object_stream;
 	files->base.for_each_object = odb_source_files_for_each_object;
 	files->base.freshen_object = odb_source_files_freshen_object;
+	files->base.write_object = odb_source_files_write_object;
 
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
diff --git a/odb/source.h b/odb/source.h
index 7f2ecf420b..c959e962f6 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -1,6 +1,8 @@
 #ifndef ODB_SOURCE_H
 #define ODB_SOURCE_H
 
+#include "object.h"
+
 enum odb_source_type {
 	/*
 	 * The "unknown" type, which should never be in use. This type mostly
@@ -198,6 +200,24 @@ struct odb_source {
 	 */
 	int (*freshen_object)(struct odb_source *source,
 			      const struct object_id *oid);
+
+	/*
+	 * This callback is expected to persist the given object into the
+	 * object source. In case the object already exists it shall be
+	 * freshened.
+	 *
+	 * The flags field is a combination of `WRITE_OBJECT` flags.
+	 *
+	 * The resulting object ID (and optionally the compatibility object ID)
+	 * shall be written into the out pointers. The callback is expected to
+	 * return 0 on success, a negative error code otherwise.
+	 */
+	int (*write_object)(struct odb_source *source,
+			    const void *buf, unsigned long len,
+			    enum object_type type,
+			    struct object_id *oid,
+			    struct object_id *compat_oid,
+			    unsigned flags);
 };
 
 /*
@@ -320,4 +340,20 @@ static inline int odb_source_freshen_object(struct odb_source *source,
 	return source->freshen_object(source, oid);
 }
 
+/*
+ * Write an object into the object database source. Returns 0 on success, a
+ * negative error code otherwise. Populates the given out pointers for the
+ * object ID and the compatibility object ID, if non-NULL.
+ */
+static inline int odb_source_write_object(struct odb_source *source,
+					  const void *buf, unsigned long len,
+					  enum object_type type,
+					  struct object_id *oid,
+					  struct object_id *compat_oid,
+					  unsigned flags)
+{
+	return source->write_object(source, buf, len, type, oid,
+				    compat_oid, flags);
+}
+
 #endif

-- 
2.53.0.797.g7842e34a66.dirty

