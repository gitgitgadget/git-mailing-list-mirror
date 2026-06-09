Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FE03E9C0E
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995105; cv=none; b=Izi+7wPbNvDLEI3Ws+n1JfAO0ToP8TzPHl2048v5filo1Qsssw29cR3REhZXPdy4PX5pdo2K37g1CYWKxM2RdXLyLeiXBFLXyGjEVxbZG/jzXxDoNvLM+IkuCrU9H6cjMTw9/X4Y4qArBWhsCu/M8pLox3YWnZwzVzPCv+0H6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995105; c=relaxed/simple;
	bh=DM4hTY4bY2Mpjw1uu+MH/BgmS6/vKly0uERJVUAEunA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uoBQusOA/91O5AECf35yC519xOHS7Qj5X+eYL+4aL56g8QNdlkQ+P8sHXon3JTurXvehK3wtnlEQwAjWRBQ8jq3kHBDfBU0npInoap8mr17AYxYk+Z+c0AQYqqx1b8hyRd/SgpORxi/mfmbRIt/Z2GVHm7knksALjWg72K+GHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RxK5A0qm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eylq8uKt; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RxK5A0qm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eylq8uKt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCDB37A0184;
	Tue,  9 Jun 2026 04:51:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 09 Jun 2026 04:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995103;
	 x=1781081503; bh=mTPSJ9omNSkouLSHgjbuBLpntGayRDNT3IcC6KHk1rM=; b=
	RxK5A0qmRt2IbTuAlTVPyTm93UMm/Br+fUR3gd1e9ZnZ8PWzKANYee8b8P8x81n1
	INAGL/evUTTe6BjJGlQz/jwxRG8m5lKOvGcj2mRGhjKDEMv0I8hziHlzyHUG8IOY
	UU9+36r4KfOXEtr/2GSax/4HXBHzB/8DH/hmh4eh158Un01bK69/mBGPWrz/vmlG
	7VuilEhp14uOJkXhr7fCWjus3zWgx4ziKJQYPG/iVvJTHM2fohur+zmHQ+b/6oV9
	9kdsCgkmDW3jXetUTyQzouRP0nmizxXcz7gIP7n9xq3YPiBmjgKRpEDx97BAxD3C
	KiqR6vFmLn8sW1eSMlyI0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995103; x=
	1781081503; bh=mTPSJ9omNSkouLSHgjbuBLpntGayRDNT3IcC6KHk1rM=; b=e
	ylq8uKtahXxa6Ct/T4JgbiFB5CUENJA1+egz5JEY3/t2MZyMHtFJC62uwvzo73ML
	3Hp+xrq3vEQrn0GLNwXih3UCkQXRcnssVCl3Zd5pfLqaP3e/NbWHf4mIbDRaXF/1
	TZwYNoxnqWrrPLqWbYwi7d7LObU/PnH720E9+ufqVtveNkCWEs/rmnNSC7z93bxq
	0a/ndD5zvmc115XfMwgjxnXEYmpfBO4hdtZL2gk5n+CDU/fk8y7EWgeDBgSjFldx
	DWQPTAWOE7B1PcfiDUYOQgQHv6boi9Z+c39LEW/PNuSYjA8K5dNbJHzJb9ZN17rC
	6GOWb4U2NRXYfsXAbySCw==
X-ME-Sender: <xms:H9QnahXkoG0nb7yge9gyMGUtxfeG5oRPaunerwXQV8wNpfIAWD6DSw>
    <xme:H9QnanmaW4xSQdRjVsAFbR-ArFlzWhzkIf0Icc_Ksh3uPZDapmIHwK5A5rb7foePh
    sF39JuAbkBr3tpxk3xauCfo1zzh2HkucHDjENj1JuvXu2wUyt7xyQ>
X-ME-Received: <xmr:H9QnarBxnpl2N5wIAOFD-hkNnItGi4BsuFdq_BGtoLwqQxBZ4QVy6j8SuOTwXZ24nm4tdos4Zh7vxTfNv0nLsDEa2viu2prLdzBaNOaYmbg>
X-ME-Proxy-Cause: dmFkZTGj8XdmJ5+YFOKcKCr/PQjtoS31kmVFBcBBMXBn9g4dcT2itNqRFQ6tT26fp0L/ke
    L9jBWAKPmiaTtvSIqZvkXdlrjGPnZvkli/ene235VDRC/kBepsTNypTdxTRg3BOgMrsFsE
    SA2a/4pN2q/LfCqjRK0o3V8NU2YESK7s1bQGdvxXT3Lbw9/qDIa+X9cU8dYVFtyp2Zdm/m
    XLuCPCGsOmwQjLX7tELpb0BgcO3xN3L3fIClRiuTpZ+VuiaRApj/QQfCUe9C4LoCAMlta1
    6XWv5B1t/eLDY9+IJLZ9mddbnJZu+dqgh1ffXXwbYjC7tEFPumTSnfkClxYn/WcG0GknMz
    uG9qaqpn7g/OT+8n65T05Dxf9NdL3ymBHqrY4xmgLZeRkPsGelH0JtVYzGcAev4kVxcOoP
    +5zcmNwYxqyoKs4OV162x9UwM5aF2kBkKsAiZKx1HFf1L5isXNCNdq7luB26/mKbSzOsVo
    HCH/EN3L5AeMPj700g8itrUeacw2T2d1NRXvKjij7hfG8R3rU8R3oRg6VpbgNbXEZawOFm
    JqygShctaQ6WXPcEM0G9Q7Vvp4i4qVvMel+ulLLzveyKG35W5p0dDFRn6ITeWSBNINjid9
    HEW7h9aBZr79Vm/EM38JfR7MnjIITXVWNIqjXuM1vqKOrJgIXW2GpgjOyllQ
X-ME-Proxy: <xmx:H9QnavfQtFhxQq65hOKJLzAI3haB8zyNVU_eauY0eAiloL2cWcdA9g>
    <xmx:H9QnauJgNfir4JnUgIn00TlUwd1dnEnUOeZ1qQCK2q22W3KHi7K36w>
    <xmx:H9Qnaqc3tY0iznXljIZ-T15dgk47E0SCvO68vvjF0xu_nN10-icfjA>
    <xmx:H9Qnat1usSHkDtftG4xt-W6Am4jz4SZO3wLt582BRxLuce-vqM0lrA>
    <xmx:H9Qnat1ml2oNR56Kp0g3lQEhnW9V2NgjLo4C0tXe5t5BjjdPtgkuB9BI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b678a414 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:07 +0200
Subject: [PATCH v2 14/17] odb/source-packed: wire up `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-14-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
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
2.54.0.1136.gdb2ca164c4.dirty

