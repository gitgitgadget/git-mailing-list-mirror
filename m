Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9963F20E4
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995100; cv=none; b=eI/JZJUmbkKkwoyOl3I1Vrkn27ifK/pumSTqVx19I+rd21PHMti+rxStRPVZQ3oVKv2gZ3KB4xvsoIsG6/rowVFR2e2rzmTO9oraLNPZta7/3B+Ipkk0V2ebXRvUDLgEGCOoly5KerGssa96B3XUHOTl4gJRM8v7ynZejOFzfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995100; c=relaxed/simple;
	bh=BAUzrWAt5ROcULyPhg2R08otArVH0LBBhrOuROSqtlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D19Go4xrJRmVIoW+fvjVEhmupLziSuoAMzHEX5O58wOWEogBC68cPUQmRLd2J2ZDREU/Ox4axifMJOyn5PVrSerFj/WGF/QT5847JonD9M85dmCLdEkNqJMEL2FZpnsMyENFors1MpIjaLwgg4k2VESdwPhZpWcSPQuT/cAcUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kKFB3UwU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XSUVKv7V; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kKFB3UwU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XSUVKv7V"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 965261D00124;
	Tue,  9 Jun 2026 04:51:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 09 Jun 2026 04:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780995098;
	 x=1781081498; bh=yej+riTjTwoHFp8K7tll58TVPZCNL1c6Qnt4UB3HxLI=; b=
	kKFB3UwUbgJn8wqOC2wU8y6wemTni5JGmHHKwxsSaynjz/g7vvpq8mWKN494kV8I
	2WNfzOxSt2IZjtDY63F9L7NLoL+T1BXuAC4XxKe/b/slkWQu3psQlqBQzwnEQmWF
	M8f/Ca3fyWmCiz48MD2clGyAXfugjTRJJtUQ052y9iI8kU9Y7mV4N3DRQdg2o0Yi
	36+hFVkBbTv9Du7HAMQnDGY28y/Zw7GRPuRnbFO9TGgRFs38YvqpwpuXjo7wNd0S
	6fU7KZOynjt40pY8gYHzxBiNgsMW4n55EbLumCwCgAy0C+e9uetaGMjj8hNn+ZqV
	4ahopMfm5s3rpGi2enZ3+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780995098; x=
	1781081498; bh=yej+riTjTwoHFp8K7tll58TVPZCNL1c6Qnt4UB3HxLI=; b=X
	SUVKv7V1jB1B7HluXXeN/Cpp9rsYV1m67yFtWuITgV8WXxyZP8GGA3gurB449B+e
	beNQ/GFESpr/0Ygt9ghi+AO2BD2GMfeN2q0yKkQunaOgFBc+YmvlVDgMnplq9ZMP
	5zdGuCOAa+S41X78vC25PpB7ie50EIxubyAdaiTwZFFd3iCARJ0MsHKDAT9rv4Sc
	7+nb3if4pVI5ZTekbYpsvVjLpv8BjP/xznF1WfoCI0BQ+0/RIPGH03NTfOscATUf
	MA1yUUASDlg6CgpofDUDFWF8w5qLeLintp8esrkIsuNWzzWtzWlwcUAO96bc2bqZ
	A9uuOLmweO6Uas+pL3jrw==
X-ME-Sender: <xms:GtQnauudXj7u6eU56UZdQJTok-G0bM7PfyIl0rCtMqmoqopTY2iCAg>
    <xme:GtQnapf-YceNyCr4pLkrjQK-IXYYyWF3C9uGcKfZTLOXdnKIjf1zEbyFZVuonYJ2H
    XI-pWOWrDDZlOlqTIYNv9qU53npVgA5ZE8WNkFj9NbAUoKcNw3NWg>
X-ME-Received: <xmr:GtQnanYG8shioN-_vjRTEWx1sD1JEwEPPf2IKtDFfydUOBSySJIAra7WtH3TpXlF37SkVTRFyn6dh42AnWOhKXkS9cJEZ51Q-95yu3mN0b8>
X-ME-Proxy-Cause: dmFkZTGj8XdmJ5+YFOKcKCr/PQjtoS31kmVFBcBBMXBn9g4dcT2itNqRFQ6tT26fp0L/ke
    L9jBWAKPmiaTtvSIqZvkXdlrjGPnZvkli/ene235VDRC/kBepsTNypTdxTRg3BOgMrsFsE
    SA2a/4pN2q/LfCqjRK0o3V8NU2YESK7s1bQGdvxXT3Lbw9/qDIa+X9cU8dYVFtyp2Zdm/m
    XLuCPCGsOmwQjLX7tELpb0BgcO3xN3L3fIClRiuTpZ+VuiaRApj/QQfCUe9C4LoCAMlta1
    6XWv5B1t/eLDY9+IJLZ9mddbnJZu+dqgh1ffXXwbYjC7tEFPumTSnfkClxYn/WcG0GknP7
    327Y7T9XgDr06OLjgamXoPplbAAU1VmQa4j0Kbn16cnAArQqb2S3P31wi9yZKc9fUcHbm/
    y2LALHqlY7s3585Px8gmgkvopd16+DsZRwdzuo74qPufm/y5UnT7roLvIXfybcpPA+aZNS
    tCGZSGvAigyiVfYr1iLmyQ2mrbcy/g3Mi/JGW/fqPKou3nnwcnMY1hMU6Z2o2otbnJzim5
    0MBN2YpjCPg/pW73ji09YrCGWrtxYGeBh7uohLtlXKJ++1rdgrEcneJjN09W8Gs6amzcxA
    6aS7DwR0jpYqGOCwvtOyW6OZWtfo6q+rmELUCR6Ov1hxC7j9b1HsWk0qBaTA
X-ME-Proxy: <xmx:GtQnakUNfXF9VhfimVpX5qmXs23XZmFjo_J14Jsq2DzbxMpzNadJ_g>
    <xmx:GtQnahgijae0LBAMHRyBChtSe_fNJKAzKcsY_sS-cEbWK_8FcyhrSg>
    <xmx:GtQnaqX_cP8np2hp1AGmYHh-7UrSVMckys39Uz9iLHr0LiOd42V-AQ>
    <xmx:GtQnagPKe-ZP9556Fe2IcdNDhJpnu56Ww24L7iF7vZWsLpMX1gwX-Q>
    <xmx:GtQnapc_gNpPQYUGnL_qSOgEs_v1mhCrE2FtVEOxLo0UqAdh93YzQp0X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 04:51:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e77681a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Jun 2026 08:51:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 09 Jun 2026 10:51:05 +0200
Subject: [PATCH v2 12/17] odb/source-packed: wire up `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-pks-odb-source-packed-v2-12-839089132c8b@pks.im>
References: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
In-Reply-To: <20260609-pks-odb-source-packed-v2-0-839089132c8b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

Move `packfile_store_count_objects()` from "packfile.c" into
"odb/source-packed.c" and wire it up as the `count_objects()` callback
of the "packed" source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c  |  2 +-
 odb/source-packed.c | 33 +++++++++++++++++++++++++++++++++
 packfile.c          | 31 -------------------------------
 packfile.h          | 10 ----------
 4 files changed, 34 insertions(+), 42 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index c73a7e5f90..274923e0ba 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -103,7 +103,7 @@ static int odb_source_files_count_objects(struct odb_source *source,
 	unsigned long count;
 	int ret;
 
-	ret = packfile_store_count_objects(files->packed, flags, &count);
+	ret = odb_source_count_objects(&files->packed->base, flags, &count);
 	if (ret < 0)
 		goto out;
 
diff --git a/odb/source-packed.c b/odb/source-packed.c
index a61c809c8c..070a4e3958 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -338,6 +338,38 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_packed_count_objects(struct odb_source *source,
+					   enum odb_count_objects_flags flags UNUSED,
+					   unsigned long *out)
+{
+	struct odb_source_packed *packed = odb_source_packed_downcast(source);
+	struct packfile_list_entry *e;
+	struct multi_pack_index *m;
+	unsigned long count = 0;
+	int ret;
+
+	m = get_multi_pack_index(&packed->files->base);
+	if (m)
+		count += m->num_objects + m->num_objects_in_base;
+
+	for (e = packfile_store_get_packs(packed); e; e = e->next) {
+		if (e->pack->multi_pack_index)
+			continue;
+		if (open_pack_index(e->pack)) {
+			ret = -1;
+			goto out;
+		}
+
+		count += e->pack->num_objects;
+	}
+
+	*out = count;
+	ret = 0;
+
+out:
+	return ret;
+}
+
 void (*report_garbage)(unsigned seen_bits, const char *path);
 
 static void report_helper(const struct string_list *list,
@@ -549,6 +581,7 @@ struct odb_source_packed *odb_source_packed_new(struct odb_source_files *parent)
 	packed->base.read_object_info = odb_source_packed_read_object_info;
 	packed->base.read_object_stream = odb_source_packed_read_object_stream;
 	packed->base.for_each_object = odb_source_packed_for_each_object;
+	packed->base.count_objects = odb_source_packed_count_objects;
 
 	if (!is_absolute_path(parent->base.path))
 		chdir_notify_register(NULL, odb_source_packed_reparent, packed);
diff --git a/packfile.c b/packfile.c
index b8d6054c16..2da6bbe2b5 100644
--- a/packfile.c
+++ b/packfile.c
@@ -866,37 +866,6 @@ struct packfile_list_entry *packfile_store_get_packs(struct odb_source_packed *s
 	return store->packs.head;
 }
 
-int packfile_store_count_objects(struct odb_source_packed *store,
-				 enum odb_count_objects_flags flags UNUSED,
-				 unsigned long *out)
-{
-	struct packfile_list_entry *e;
-	struct multi_pack_index *m;
-	unsigned long count = 0;
-	int ret;
-
-	m = get_multi_pack_index(&store->files->base);
-	if (m)
-		count += m->num_objects + m->num_objects_in_base;
-
-	for (e = packfile_store_get_packs(store); e; e = e->next) {
-		if (e->pack->multi_pack_index)
-			continue;
-		if (open_pack_index(e->pack)) {
-			ret = -1;
-			goto out;
-		}
-
-		count += e->pack->num_objects;
-	}
-
-	*out = count;
-	ret = 0;
-
-out:
-	return ret;
-}
-
 unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, size_t *sizep)
 {
diff --git a/packfile.h b/packfile.h
index 0097de0b27..0613fd3c63 100644
--- a/packfile.h
+++ b/packfile.h
@@ -141,16 +141,6 @@ enum kept_pack_type {
 	KEPT_PACK_IN_CORE_OPEN = (1 << 2),
 };
 
-/*
- * Count the number objects contained in the given packfile store. If
- * successful, the number of objects will be written to the `out` pointer.
- *
- * Return 0 on success, a negative error code otherwise.
- */
-int packfile_store_count_objects(struct odb_source_packed *store,
-				 enum odb_count_objects_flags flags,
-				 unsigned long *out);
-
 /*
  * Retrieve the cache of kept packs from the given packfile store. Accepts a
  * combination of `kept_pack_type` flags. The cache is computed on demand and

-- 
2.54.0.1136.gdb2ca164c4.dirty

