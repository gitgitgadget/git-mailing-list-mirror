Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CE38A717
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302046; cv=none; b=OVZBP5GtA506jFzSSl6fc0Pse7OhxoImiAfk1GC1JxtL2WS5zFSprcQHpShebs2n9CQuujQDxhVreh+CwXwLhk4gA/VaGEwm4oi8QFGY2SOHM1pq9sL4WbjoVyfTFPUeYstGo15u0wuGNq3Kx3+lnH4RAGaAlhMUZ2yolnsudTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302046; c=relaxed/simple;
	bh=FTdGjxdCuN8Zmr1K/9AVkl/OqX1kh+7E2KB7B2VGOBk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m4OXAL0mS6Q36QPl7v2hT7tIH0XYR8TWcIi3ua72kuE6ld/gyKrSs4etAwKe/nZDznrrICHa9FQBsKnl88DcpPnMy6Igj2/y9lfw7p6ZX8Ebk+pjjgEBLebYrLmnXFqNnXT5+srV92rZXAxVRtPBiT82Jmcxeuoxh1rqcpi9ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tcynwvL0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vawlntxd; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tcynwvL0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vawlntxd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AF5A7140004E;
	Mon,  1 Jun 2026 04:20:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302044;
	 x=1780388444; bh=oavfLmKvRjYj9iyuNRYPbLL+moQWYNpO7uN0bupeCNg=; b=
	tcynwvL0iUm12GDUD1CFGhys1D9xP+k0HMXJcaDhv4op56L32WxemAjFxYqlpK7L
	EbDp6d5AjER9Wp497C2vuey9noDOTyaBf5f16/tKFJD4VXEOqvEzyGm/O5AUPMa4
	SudFmXv4Fm3gX9n56tpuuKziGbxBni0S+mL/Nz+Gn2UAZvizNJrZHvHn8DPMW2ij
	JqlwdemmwY57pCEMEn3YKXLfr5jOyPFvZSR+JrikfRRrqxvR/HQo2AGwS7T5+sDL
	IabCwrPH2WVMP8aK7B4ner3rwoS6pXqCwnfcEFDeBp+c5nwaGk0P8ZPTQ4VZ76eb
	ou/u5oEHRwqyZkGdPda5gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302044; x=
	1780388444; bh=oavfLmKvRjYj9iyuNRYPbLL+moQWYNpO7uN0bupeCNg=; b=V
	awlntxd9q5PonhrCQUl+7p3SxAOXr1V45C6fuFtMJVAgb9zHwSQJ87dsbOXlAnYL
	bwHG0ko75A9pd41J9ACtNIRUTRTKxnI0DbJ+3nk8jNfMHwneDIyPELsLQYGdHW6m
	jkpDW9PPkx+aourXV5E66WNX8pJLdLl04mG9GJIXXL3VrXem8uhu3OnCokdWpPCe
	YTr0zg0CqUR47IoE/kAWXsMw4Irry9JbcyrW9xzPg0KebiuY/7ryVrm7zD1NYRFy
	pGawRO4gUGMAT6h+NezvrbnZfMW5LvkdWjFg+NZwuCHihosRY2K9s2ExG40/J8Zk
	HFD9FhupUIQPQpB+REqyQ==
X-ME-Sender: <xms:3EAdanJozPnEVsp2I8VEyVUBsdmz47MGiQPKb7wobyGzetFCA10P8Q>
    <xme:3EAdahKEiv_Qbl_H1mCk0O3nUOilC5dF4WQ8M6Z07J2cwaWMz4OjFuwnir9N-KjjR
    4WWqP1JUYe4XQoHC9_St_RB0cFJh5QCCYoUgUtUQmcEW0irx7Q>
X-ME-Received: <xmr:3EAdatVdg9HLf2yHQHoxEKE1qKKJqrtB7b3FyEH_GwmDocPqwM1x9z2Ka63EqI5JXk4wzxxc-6IbY1nB4z-l15XK_97LfRSqMOF3XolfLoaR>
X-ME-Proxy-Cause: dmFkZTGMavhG2wq0jIIx4Z9fpJ7SWU4287r52kyZjBri7FU3ikyy1OWMGhoR5V3D51ljK9
    lhHzPs57OdYeulBavUlZ6jztEphzt0JLYZFwWnMYivsF+9rVBf0HTIlwrRN3/vvoI01lE+
    IIOALdfGOcWcRa6OceRP8/4VYaeW6MzCpodqhnwzlYhwWcVbQpJ6FF+7SHRnqqJBTXZCdk
    dqfxTu13i3Y1wM62VADlbIexbmbqm6iuWiaPpCIVKETdi0dzYk/Hv4Nh4Wy1U6pVGNEGx0
    xDgzFQwnNxX16CikY5ben40siPV8AY3IjEJyeSvTcYkeFIAPi2sqT+wec2c58Zs1YGKlAT
    bv2mBsdHxDH4xknL5bUlTvRkTj1cPCV5di/cwqZcyngdDNUlwKMdYFUGcBR2EgbD+NOQOM
    +dtRHRyQL/mhG8XcECPvfqv5+bf49BuNvbYpmizd8CY7tNIs/dwjmFO2PrjrSo5I4ZodTq
    FqUqwhod4fOWnqhcLnd7IQxBBFfHpkx1SeMbZUzNAyHj8W4dbID0LZR5zj5ED1bB1dufTM
    9fTK4nRyB6GXOM80L6aQCdb/ICo9NENLeIJmuTlA7KCz6IGGfwVLiix4jNB+lkips80zLM
    bsE80TRhamwYIHDK8kIJK/o6wIDkkDzG49q4rBTYliFnC4CghluydUJ31rww
X-ME-Proxy: <xmx:3EAdariacpkRf1AIkEA1JAl6PjLyuKXWKBOdFOCOmo1lLpYY8cdEBQ>
    <xmx:3EAdag-uM2g2a5ROLUTkrBHPx0BGhbe7f6ZJtp8bm4DWfzQfmluz9g>
    <xmx:3EAdatCBzuGuKy7cSyIdu1mm52YEn9BewYh_9fCkmzLFt9cWYgAbNQ>
    <xmx:3EAdalLY4pRTjQistWzryN_9Cwl0_Ay7aY6DPj6KeGbze77H4_JTeg>
    <xmx:3EAdaqiXCCTmYxiMFoeaPaYXfRQYs95Gu7CDjj6WtbzK0QpDRU-L9Ibe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3e9aff9f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:29 +0200
Subject: [PATCH v2 06/18] odb/source-loose: wire up `read_object_info()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-6-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_read_object_info()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `read_object_info()` callback
of the loose source. Callers that previously invoked it directly now go
through the generic `odb_source_read_object_info()` interface instead.

The function `read_object_info_from_path()` cannot be moved along with
it because it is still called by `for_each_object_wrapper_cb()`. It is
therefore kept in place, but adjusted to take a loose source to clarify
that it's always operating on this structure.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 46 +++++++++++++---------------------------------
 object-file.h      | 11 ++++++-----
 odb/source-files.c |  2 +-
 odb/source-loose.c | 24 ++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/object-file.c b/object-file.c
index 0f4f1e7bdc..fa174512a4 100644
--- a/object-file.c
+++ b/object-file.c
@@ -396,13 +396,12 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-static int read_object_info_from_path(struct odb_source *source,
-				      const char *path,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags)
+int read_object_info_from_path(struct odb_source_loose *loose,
+			       const char *path,
+			       const struct object_id *oid,
+			       struct object_info *oi,
+			       enum object_info_flags flags)
 {
-	struct odb_source_files *files = odb_source_files_downcast(source);
 	int ret;
 	int fd;
 	unsigned long mapsize;
@@ -425,7 +424,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		struct stat st;
 
 		if ((!oi || (!oi->disk_sizep && !oi->mtimep)) && (flags & OBJECT_INFO_QUICK)) {
-			ret = quick_has_loose(files->loose, oid) ? 0 : -1;
+			ret = quick_has_loose(loose, oid) ? 0 : -1;
 			goto out;
 		}
 
@@ -532,7 +531,7 @@ static int read_object_info_from_path(struct odb_source *source,
 		if (oi->typep == &type_scratch)
 			oi->typep = NULL;
 		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, source->odb->repo->hash_algo);
+			oidclr(oi->delta_base_oid, loose->base.odb->repo->hash_algo);
 		if (!ret)
 			oi->whence = OI_LOOSE;
 	}
@@ -540,26 +539,6 @@ static int read_object_info_from_path(struct odb_source *source,
 	return ret;
 }
 
-int odb_source_loose_read_object_info(struct odb_source *source,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags)
-{
-	static struct strbuf buf = STRBUF_INIT;
-
-	/*
-	 * The second read shouldn't cause new loose objects to show up, unless
-	 * there was a race condition with a secondary process. We don't care
-	 * about this case though, so we simply skip reading loose objects a
-	 * second time.
-	 */
-	if (flags & OBJECT_INFO_SECOND_READ)
-		return -1;
-
-	odb_loose_path(source, &buf, oid);
-	return read_object_info_from_path(source, buf.buf, oid, oi, flags);
-}
-
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
@@ -1833,7 +1812,7 @@ int for_each_loose_file_in_source(struct odb_source *source,
 }
 
 struct for_each_object_wrapper_data {
-	struct odb_source *source;
+	struct odb_source_loose *loose;
 	const struct object_info *request;
 	odb_for_each_object_cb cb;
 	void *cb_data;
@@ -1848,7 +1827,7 @@ static int for_each_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (read_object_info_from_path(data->source, path, oid, &oi, 0) < 0)
+		if (read_object_info_from_path(data->loose, path, oid, &oi, 0) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -1865,8 +1844,8 @@ static int for_each_prefixed_object_wrapper_cb(const struct object_id *oid,
 	if (data->request) {
 		struct object_info oi = *data->request;
 
-		if (odb_source_loose_read_object_info(data->source,
-						      oid, &oi, 0) < 0)
+		if (odb_source_read_object_info(&data->loose->base,
+						oid, &oi, 0) < 0)
 			return -1;
 
 		return data->cb(oid, &oi, data->cb_data);
@@ -1881,8 +1860,9 @@ int odb_source_loose_for_each_object(struct odb_source *source,
 				     void *cb_data,
 				     const struct odb_for_each_object_options *opts)
 {
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	struct for_each_object_wrapper_data data = {
-		.source = source,
+		.loose = files->loose,
 		.request = request,
 		.cb = cb,
 		.cb_data = cb_data,
diff --git a/object-file.h b/object-file.h
index 420a0fff2e..8ac2832dac 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,11 +21,6 @@ struct object_info;
 struct odb_read_stream;
 struct odb_source;
 
-int odb_source_loose_read_object_info(struct odb_source *source,
-				      const struct object_id *oid,
-				      struct object_info *oi,
-				      enum object_info_flags flags);
-
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
 					const struct object_id *oid);
@@ -198,6 +193,12 @@ int read_loose_object(struct repository *repo,
 		      void **contents,
 		      struct object_info *oi);
 
+int read_object_info_from_path(struct odb_source_loose *loose,
+			       const char *path,
+			       const struct object_id *oid,
+			       struct object_info *oi,
+			       enum object_info_flags flags);
+
 struct odb_transaction;
 
 /*
diff --git a/odb/source-files.c b/odb/source-files.c
index 59e3a70d80..8d6924755f 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -55,7 +55,7 @@ static int odb_source_files_read_object_info(struct odb_source *source,
 	struct odb_source_files *files = odb_source_files_downcast(source);
 
 	if (!packfile_store_read_object_info(files->packed, oid, oi, flags) ||
-	    !odb_source_loose_read_object_info(source, oid, oi, flags))
+	    !odb_source_read_object_info(&files->loose->base, oid, oi, flags))
 		return 0;
 
 	return -1;
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 65c1076659..50f387ecf3 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -2,10 +2,33 @@
 #include "abspath.h"
 #include "chdir-notify.h"
 #include "loose.h"
+#include "object-file.h"
 #include "odb.h"
 #include "odb/source-files.h"
 #include "odb/source-loose.h"
 #include "oidtree.h"
+#include "strbuf.h"
+
+static int odb_source_loose_read_object_info(struct odb_source *source,
+					     const struct object_id *oid,
+					     struct object_info *oi,
+					     enum object_info_flags flags)
+{
+	struct odb_source_loose *loose = odb_source_loose_downcast(source);
+	static struct strbuf buf = STRBUF_INIT;
+
+	/*
+	 * The second read shouldn't cause new loose objects to show up, unless
+	 * there was a race condition with a secondary process. We don't care
+	 * about this case though, so we simply skip reading loose objects a
+	 * second time.
+	 */
+	if (flags & OBJECT_INFO_SECOND_READ)
+		return -1;
+
+	odb_loose_path(source, &buf, oid);
+	return read_object_info_from_path(loose, buf.buf, oid, oi, flags);
+}
 
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
@@ -60,6 +83,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.free = odb_source_loose_free;
 	loose->base.close = odb_source_loose_close;
 	loose->base.reprepare = odb_source_loose_reprepare;
+	loose->base.read_object_info = odb_source_loose_read_object_info;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

