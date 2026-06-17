Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF2C3B6BF0
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678433; cv=none; b=s/9NjARJZOpJDRgLjiPHfnRmVPwWfGlkmOVLPDK3BTlyQ5T7OBy/DGA4Hrq+Zx7ztkkDWaG20AumfNA/rV0iD98a3H78nyyixjdsMO/gcIevO7qXWf+qSnQBYb2Ym8zAwAHv0TXWlaLTU4G38EED0hx4rrgHBKI4LX45ljSnPqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678433; c=relaxed/simple;
	bh=RRE6Q9RYfG1GD4RSzJN3SNqcoShYjQ1HMTUsun3qNvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fE8DW7kpQ32THntdiTMiPunPMLXdIEVI5ZcriRCrBE97ia+phZR0+mGE4G+syeNHgoGeVoNTPtWCdvicJv19JqC12EHZR7WJURgsrMSOkTPJDUkg1CQxGRtH/3rFtCwuIJme9XkCssbO8tJhLJ439LrdMXIQpeY/3Ion/InFsI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U95tmNNh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CToSYm5e; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U95tmNNh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CToSYm5e"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 037397A00D2;
	Wed, 17 Jun 2026 02:40:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 02:40:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678431;
	 x=1781764831; bh=apO377f5FiaSjFXp5BBG8yHABpA8Q4+4dAGng02/AgQ=; b=
	U95tmNNha9+LuOBoHLPEMwEC9RHpZdbmePHK4jGroXSylhmPWdmvmJ3UN33vXB3V
	d8sWZpLRkBok7A2B20lX5+VRKZWU8yXORevLnreHqP5eBDTZoGx7VuQ3gNMHDEUZ
	MZ0hBK3CGoOpK6aABb/teZMJkrugdfqtHf+Bbe56mKK0gWs+sDfpfcqiWvUrJptV
	fhdkOQxHNrLSE9GNvDODC/9cdokSolCeZO+PmGnoNo3hwwXhoZ1n8N8FWgX+ydai
	DaY7fTtaNNoxH5j3MYjJa3hFaHjcZ9H7+37DkXnr26FxWzHIdC5LpdZNy08hGntA
	K03UJONTMQOBYvGd6xzz4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678431; x=
	1781764831; bh=apO377f5FiaSjFXp5BBG8yHABpA8Q4+4dAGng02/AgQ=; b=C
	ToSYm5eTYQ6hOfYpTzQcjR/JAIOGZZP9gIY9ug4BltNdzfYPi1lpGDeHqoOO6la4
	giCcY2pEL/5i9jlO9/AKFA8gOPEw5hxVwjhU1tpmPRg3DCL8f37AuazzjUeONTm2
	g2U7PkYmTbRPr3XgclbCZMteUcojWdy6OxQLV7d6bWLCGrpsK/BQJ/WXhJuFivKz
	tcbeG3rJl7cfnZK+i2ZKV8l15toXKSJV1euLxqhh+JQeH5MKsgAq4lUH958oiUuT
	9Llw5Wk1pOZ91zcCEzNwGc7VBvT2xQhEW36eH5f5nj8k/cLHQmViQ2kpB8MoiTEs
	0RZNUuIFaCIJNN3Se0JZg==
X-ME-Sender: <xms:X0EyaizRuat4bWF_WxOplxT4WYKIygZGuFvOuD7OXIITT97PRhiaGg>
    <xme:X0EyaluPbb50PC1EjPToRKSxJdmpnYcpno3-NhvaYGOijtmCNnJUI4b20eX0dh-HR
    agzi09mj-vhbjZL74qrL5mzPq9ncaNBUuifcpJhugrBE4NI2ArO>
X-ME-Received: <xmr:X0EyahvU08lBLMrqIQaR598gSXnNE5GDyH7XlCXM17kiebyrMuESQz6_VRE8phZ-xCXiemdxXfnruSwal03ENP2p8Ki2BNkuXlO2GkY>
X-ME-Proxy-Cause: dmFkZTFl07ipAIi9xJGEFtFdeXJ32YlTxjlf2nx1N6xtGXKrOC1bLbDlVvbrzzA5+wU1Co
    Syg+K8Q1ZQCASKzRK2+jUlv03fQMlni6m1uSDG9ZfsMez+CExN6BaOaB4dWww+dwFVrBWc
    MDEQgterYVrJX0duTt2YYH5sPQ0va9XcOu2v8cjr9lrtGWO3H/PAeE6gOAmLvw2VMk7fmQ
    bS0Z8M1QPaN6dBkHxm/qp0BwBioAlyPsS5cJKvA0SEp9LqrehZotcHKdpFgJTmQDXUKsqa
    EmWuysjWltbEijcyaQ8KC9W9onfmQCiSXmKIDwQVCz3CkB3vqB4j2FCfjXy4ARgFAuRieN
    t4Up16w483bIsPGptRX3hyBpFcRmziOZomm0sZGHHIRXLyJpZQrYbdD9sL72Ezv7GhJjXE
    RL8bvtYUs5/+NKP+BBCoQv9BE6TDA9btbOvL0OxXWUXlk4kCpvYSRWZNGXKo2eAvelh0mY
    HL8jfhASrV67FnCJTB6sXw+vlMh+BnWDsB/9txWLxfX3JoSRGnQketb7GHsIRI26RSQUYh
    tDdqZfTeqgi0t7NbxsCkg6Z6B8KM0mT27obGcUPmDFjo96HT6xFVgh4Z5IBK3HdACltuA+
    cCDUpShVJ1zWSk31i22C2fdqX/RoQKYX/CgkMNdqxFYd/4wQFJDI0Fc5t5yQ
X-ME-Proxy: <xmx:X0EyaiMVcBuigweknPjn8U3Aq6QSzX20icytFtG5Q_J3E-qjhyT_EQ>
    <xmx:X0Eyan3tW6KRUUV_IG02vk4NwUL_Vx_Cl868qvSl7rz4PlKx3uqCeA>
    <xmx:X0EyamPtTxhnU7__EGIzo4c4RH77WzzK4tEJa3r-LTxnQDawO769Lw>
    <xmx:X0Eyav0OZkh5z2xow5g-XnovwILr1g1eKplYJ_5H9i5UUZUCvUILqw>
    <xmx:X0EyalKl9R0EhcGb4lBPaaHhr24CIRe33cvr-egsGj5yuoW3ib6DZjTn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9f7c3091 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:57 +0200
Subject: [PATCH v3 14/17] odb/source-packed: wire up `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-14-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

Move `packfile_store_freshen_object()` and from "packfile.c" into
"odb/source-packed.c" and wire it up as the `freshen_object()` callback
of the "packed" source.

Note that this removes the last external caller of `find_pack_entry()`
from "packfile.c", which means that we can now make this function
static.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 26 +++++++++++++++++++++++---
 odb/source-packed.h |  6 ------
 packfile.c          | 16 ----------------
 packfile.h          |  3 ---
 5 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 8ad782dc7b..fa2e18e71b 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -152,7 +152,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 					   const struct object_id *oid)
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
-	if (packfile_store_freshen_object(files->packed, oid) ||
+	if (odb_source_freshen_object(&files->packed->base, oid) ||
 	    odb_source_freshen_object(&files->loose->base, oid))
 		return 1;
 	return 0;
diff --git a/odb/source-packed.c b/odb/source-packed.c
index b801b62023..e40b52e445 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -9,9 +9,9 @@
 #include "odb/streaming.h"
 #include "packfile.h"
 
-int find_pack_entry(struct odb_source_packed *store,
-		    const struct object_id *oid,
-		    struct pack_entry *e)
+static int find_pack_entry(struct odb_source_packed *store,
+			   const struct object_id *oid,
+			   struct pack_entry *e)
 {
 	struct packfile_list_entry *l;
 
@@ -482,6 +482,25 @@ static int odb_source_packed_find_abbrev_len(struct odb_source *source,
 	return 0;
 }
 
+static int odb_source_packed_freshen_object(struct odb_source *source,
+					    const struct object_id *oid)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct pack_entry e;
+
+	if (!find_pack_entry(packed, oid, &e))
+		return 0;
+	if (e.p->is_cruft)
+		return 0;
+	if (e.p->freshened)
+		return 1;
+	if (utime(e.p->pack_name, NULL))
+		return 0;
+	e.p->freshened = 1;
+
+	return 1;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -695,6 +714,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.for_each_object = odb_source_packed_for_each_object;
 	packed->base.count_objects = odb_source_packed_count_objects;
 	packed->base.find_abbrev_len = odb_source_packed_find_abbrev_len;
+	packed->base.freshen_object = odb_source_packed_freshen_object;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/odb/source-packed.h b/odb/source-packed.h
index f430ee0b94..9d4796261a 100644
--- a/odb/source-packed.h
+++ b/odb/source-packed.h
@@ -90,10 +90,4 @@ static inline struct odb_source_packed *odb_source_packed_downcast(struct odb_so
  */
 void odb_source_packed_prepare(struct odb_source_packed *source);
 
-struct pack_entry;
-
-int find_pack_entry(struct odb_source_packed *store,
-		    const struct object_id *oid,
-		    struct pack_entry *e);
-
 #endif
diff --git a/packfile.c b/packfile.c
index 7f84094e53..a577275d4f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1892,22 +1892,6 @@ int packfile_fill_entry(struct packed_git *p,
 	return 1;
 }
 
-int packfile_store_freshen_object(struct odb_source_packed *store,
-				  const struct object_id *oid)
-{
-	struct pack_entry e;
-	if (!find_pack_entry(store, oid, &e))
-		return 0;
-	if (e.p->is_cruft)
-		return 0;
-	if (e.p->freshened)
-		return 1;
-	if (utime(e.p->pack_name, NULL))
-		return 0;
-	e.p->freshened = 1;
-	return 1;
-}
-
 static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
 					     unsigned flags)
 {
diff --git a/packfile.h b/packfile.h
index 79324e4010..71a71017ee 100644
--- a/packfile.h
+++ b/packfile.h
@@ -132,9 +132,6 @@ static inline void repo_for_each_pack_data_next(struct repo_for_each_pack_data *
 struct packed_git *packfile_store_load_pack(struct odb_source_packed *store,
 					    const char *idx_path, int local);
 
-int packfile_store_freshen_object(struct odb_source_packed *store,
-				  const struct object_id *oid);
-
 enum kept_pack_type {
 	KEPT_PACK_ON_DISK = (1 << 0),
 	KEPT_PACK_IN_CORE = (1 << 1),

-- 
2.55.0.rc0.786.g65d90a0328.dirty

