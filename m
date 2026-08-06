Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E653B9D95
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 07:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002685; cv=none; b=jBiC/E/VJfhIfymSAOT4LA9LlubOxNzW/wlYlcSq50iLeFEFmrOgNblbgOQ1MmspcycAqJk8mpbR7PLROHol6eC/0e83y1w2hQ2/JGJgN4/QsIoFEoHG/8bg4f23/fq61yMMkTYo4qCqOBRWIpS6Y3ut9pH9O6NjjVEe52ltNVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002685; c=relaxed/simple;
	bh=qEMyA97QN80BJQZbvp8T92nhqr7SEs+qbflmgdfEoE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7LMxfuFjjqLlsjVZdHIGFBLycoFnjBnb3dQxm/m2zJvSIz8uNefPHXvYdHgjq5wJz1vzkp4sBalYh3sVHiknQLr+xgVwc9b1yF+tvTlFhEzTpCdSNxUYY+cXhZc48lmAReBDMZ/fLoxfKhqxll6dkhMGHJNbXZzjlIlCIhSTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TyXexPwr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j4t/fphs; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TyXexPwr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j4t/fphs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 75E477A0054;
	Thu,  6 Aug 2026 03:51:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 03:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786002683;
	 x=1786089083; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=
	TyXexPwrRrsM04NJzxegQ83dP/ixpOjqgSDi13vGG+2LAAfsmyRRbXMei9eIaVEu
	mSsyLoEogygZqxxbAN7tohi0nIGGQ0lSo7tezM9ryfnZrfMjLT1kk6+g7lPw0mO7
	fXmuTcQEUYLR2zY8k7bphwdg4fuHv4P3iyj783EqiQW5ttuxLlmNTyGZZVCsi59x
	4Un/qJi4KifJ83x7rdINl7eKnpNMUc6WyDCB6Y/y12UBFaaSkPq2oxEaDmo2yTs6
	5ovHrW+PiwMrBLekjyjdg8uzi66qDF2YQnkhbNd0ARJqNIreGT6zJMHu8iWsip2A
	dTnz7q2x10BRDM7G+jDscg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786002683; x=
	1786089083; bh=pTAr58wGrCKh5H1Da5ffVwMx0AjfhYJ10pjz06p0144=; b=j
	4t/fphsg6TBu/xUn9f0FaKOrIl0M8ua9K/xDq+mFeYWzcTqnHTVrPJl/3CsDpEtw
	sSiy4r4obzI3VDnAXULcTuUaW5S0Yec+aeTV2vbDhCh1YwtJqnM05laStCDsMmMz
	d05j//M0dcyPGtyvtxnJhhcCG8JbJ/4Jh/FJ1qdz8M1j3TxNQeqffjGvR433w1KM
	mPKUnadhmFByT9fZzivWA2QjPdQTXU9jL99ddyU63bzDlHRzgxYbLpkfsPAXwPVa
	9jUYSW7eAQxswvqTSe8RrXRAObWGdWDpFGvRAs0a745K1QI/7g4VrwXrZIZuwqd+
	tBLLd/U/KySoCu/W37wUw==
X-ME-Sender: <xms:-zx0avzj-CjxhPfi4KX7dx30ek1lpMEODexXhJDzY9LBXVs63UT3Aw>
    <xme:-zx0auQ6TCZBb3wOdLKJB8dk_o0KgvfS18Kj8PVazmtQcviuJJ9R67pLaLx-cvdH3
    k3Ixnod3mCvTI9023Uysai5-9yCDrmXOq9LK6108SNlE-AerFL_Rw>
X-ME-Received: <xmr:-zx0auX4dzvHJu_DmjCZuLNNmhc-BeeBkEfX1dpbSe8Q3taqdw0OTcdNbxByCuAnmy9CXDC660HUy0dhapnmLGCDYxmyq8Jjq1EOCiVWh7U>
X-ME-Proxy-Cause: dmFkZTEtzha/e+/fLcr4yLYpFwljivEi4kiTD7GQZPS8Iw0t2O9ajSX2+zUSgp9R1U7o7/
    hmHI+bz0bFhYZWQWsopHriyW8MDU5aGaxS/Ka5E1xvBCiYuRw74vzVpofzEXygJ1CwqDlG
    9MK5XFO9NkVkUvYdezd7H/YB5y5u+Kd3CVS2NtPW3YgPmy5Z8yRnFeh6G4pRMZORW6pnsn
    MVklV1UcYGQBbOa6rKltEdQPLJLC3eZHnHD7G+UXpSJ2eKBLWwYzrr+h2+pufPwNDlElaq
    hGTFGng084YkBjiId1Qpsg1lA0yeLxZrliGnN9/Z1rO+VHoSsgHcG3jlFfU1PzSAzMckNT
    DcVd1ORiAUr3PAawq6OXT9zsEOsWghuRhRePbCX4R+AaNAeSaZc2dOjB9yiQdY8KVIe6A6
    qsMwZogbAo+PpRLCa2C9AJC5gDdliVOhgn4hol7+QfI3j/DQLnX+93cEIo51HqMIO/NcVe
    WMGuvH3LPo3i6t5s0h3vymSMHsiS0uHU7PSBQynaRjHKXAC0l8QrLTtl/RDbLw8QlzILRx
    EL2EfUeDNIE0/zmzZxFOsymWAnP7NhhZVUddlreDaC7SOj0Y6Oh7yJA0+52cM30x1lBawW
    7wOe03DzdkEFPkLHq37WoBslGUevZTjpdFOXrWzKvtbCfHgGWp57u4rcVXrQ
X-ME-Proxy: <xmx:-zx0aobF7v1-_crH_k03zpak_0LMttisp5Wu7AhMd4iD9GPF6taeSw>
    <xmx:-zx0as2z6Zz1itwrRQjacB2nDJoysnproQDSVRAEd9bCKr3fotsE7Q>
    <xmx:-zx0aigKnpxzjsVyOYNUVD1Rb1Z0k62ld7uXb4EYJ8yg8yQOst55xw>
    <xmx:-zx0aoZWNUFSFYCqvEPaMNCSGlXwPHubakQFtuA6p72MAcVjhGvl0Q>
    <xmx:-zx0agkINMAoIeT0XJLghcxmy-mNTLwQnsYc-HZPh7SSEibeoeJMU6CL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 03:51:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70cd41bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Aug 2026 07:51:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Aug 2026 09:51:03 +0200
Subject: [PATCH v4 5/6] odb/source: introduce function to map source type
 to name
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-pks-odb-create-on-disk-v4-5-ba8b4fdd2e3c@pks.im>
References: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
In-Reply-To: <20260806-pks-odb-create-on-disk-v4-0-ba8b4fdd2e3c@pks.im>
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

