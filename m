Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEC13B71C9
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 06:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678429; cv=none; b=C3WZPhwoRzIC1YS0WQ/SxXotINJg1kG00kgaPW7ldt6Fm81chuwdBMOnigLYZpB/tn5zTACuRR1MQ6D13HrVxMhhMl+5Obr/ve7f6VGrSSQs0hMd/ZDGsv86CuzwhCvhCmsyiCgeymDE2PoMTTbrh4LW6F0hPiwbl58Of6vypmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678429; c=relaxed/simple;
	bh=uMZNfy7KglaN9NQh+aDolqytxQRNBMzoBTgE6pzGQmU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=szI7f2dFoNLX69Rmxf61OCVpbfU1b0CYNQx5/I7SKBXIG9M+n0KW/uM5YRIDTSZZzJjoizAnC7z9gRvSizBy3w+d3OUEGI5W51jqPfhLIXVF108B6c2aG+zspgY2AqTDorvvra9ZTaMVOKMSjtSMB+6+fXiFHlWT5bBf+phK1Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z3EdD+52; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z05jIyBR; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z3EdD+52";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z05jIyBR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 80BB11D00121;
	Wed, 17 Jun 2026 02:40:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 17 Jun 2026 02:40:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781678426;
	 x=1781764826; bh=r7AknkjEe5L+KtC6QbqhhZFVGCSAdc0De5quVYaUViU=; b=
	Z3EdD+52VmtLy2AgC5XjJOjtWEWo0QHI1zKbs4b6F4kqxDoyYboV2xEhlSzZENiQ
	4cS5QfMBNq2pI5J2OisAf+6v8fVxnbpgjqzowgJfUqdBedsTI8pALZLn4c58yq/e
	bxvC3l4+aqYbIH9M9E5Bp40+A/G92yQscHMb23p15KfH2CpUMwdCL+RpMV+AHtvl
	QxAvrJh4io1zBxwaL1tmNOgSx2CY+yGRygevZkiLZqLyJ/4nzXz16/nyRmsKFhDQ
	762dhAROHmzK7545W4883jAYpKQpOwbjAc5UY7QOtk5DPivFD7STDOm5Ge6Ba67m
	zCSju09f//Vqd0MCqndyQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781678426; x=
	1781764826; bh=r7AknkjEe5L+KtC6QbqhhZFVGCSAdc0De5quVYaUViU=; b=Z
	05jIyBRgkdq6AU82mIYaav8JI3msdJ7ryLBomtdO2adqzA045M3K+Cqq/J0EUgRo
	bFBs3kAeF8wjPoXOC3luSYwUMfnCMyK+YtEwNwJktMSy0JAI9OjjZjZ/P0wQ3rGX
	JrzqrlFgDirzzrDfnndhQaG1uTlCJrKtsW36gNH3R04MFqp4eOPnyea9rxxEn3Wa
	tmqFZWRcaaPMHFCI2Zu9Gfc/ywKZi/wXztOQeH9n1V1Tyw7BGe2q8EE5dxPqIjBh
	ENwcVHWXk6h0vM2Nx0X4DKdKqks6vcSitgbYd+A+D4IsPdnTvHt73RvmO7VnXpEW
	ITs9LzMUlRfkq0hljC1Gg==
X-ME-Sender: <xms:WkEyakgmiGUIPTT7Xoov_5L_hBWZbW-PtQQIyk6276MTJXIaTgNhOw>
    <xme:WkEyakf0jvkjOiHNyjCTBbXzBC8q1dW15u7NwpHQs3zW0DuI7ebz3JokC7QWR-0UV
    dGgAMcJB21IjIa_o1pxY7fNc835hy2gCIzz1gij-5x4k3nNY_sg4w>
X-ME-Received: <xmr:WkEyapfUR6mQXW7BTIg1B9otnK3R7q9KvhC1Fkgb2wsEKDlKgV59kmIvQSUxpLdnfJULWjjrCE6jL45BOV0tVjCPdbCG1eg9y4ciqZU>
X-ME-Proxy-Cause: dmFkZTFl07ipAIi9xJGEFtFdeXJ32YlTxjlf2nx1N6xtGXKrOC1bLbDlVvbrzzA5+wU1Co
    Syg+K8Q1ZQCASKzRK2+jUlv03fQMlni6m1uSDG9ZfsMez+CExN6BaOaB4dWww+dwFVrBWc
    MDEQgterYVrJX0duTt2YYH5sPQ0va9XcOu2v8cjr9lrtGWO3H/PAeE6gOAmLvw2VMk7fmQ
    bS0Z8M1QPaN6dBkHxm/qp0BwBioAlyPsS5cJKvA0SEp9LqrehZotcHKdpFgJTmQDXUKsqa
    EmWuysjWltbEijcyaQ8KC9W9onfmQCiSXmKIDwQVCz3CkB3vqB4j2FCfjXy4ARgFAuRiTI
    DWb6mCO7IcYrv25m2B0x/81byUnOn0YKS90eajYO+XMp58/37gZWXOBXlD+1Gny0tSfCnC
    jBSMPIGhmx7EOhsAOQL7lzJQOn3eabDhPA5/r6Fdug3ZaqzxUMsjE0J8edxRPfuYaVyl55
    E85ZuLMCwIRcZMoubrxWhmODNXgwjYuaYAv+/vhN8I7ecCZfwY3dfTVEiV4pP8ruyymzCq
    lrAjYGdFhp3zbSbA4daiw4FbEUrGERV1IUO7/vrMaHBLJKweha6C5rvRn3Jt55MP6O/NZz
    4GCozJk/5qcxI70tMgyqmzdQ9z4EG/4WJrV1aBmmDFwMtmg1o3ouDoznY5sA
X-ME-Proxy: <xmx:WkEyau-xk3J5640WUxcVKhRmfUMSIqUMaCuE4iDBe09hJRAoC8hZLw>
    <xmx:WkEyaln4dC82ekMCZNeZ4Jtj6jVsPGz5FGVKNFFMdabA-g0-woHMtA>
    <xmx:WkEyag81i3bPeuRMUhFWs47fJeTIzHSnUB2-NVktM3CD6q1KxIVL3Q>
    <xmx:WkEyajkbmOR55Al8pNUb32CFaLNrleCZ9OXEgha4pyO8-b8n2SxRBw>
    <xmx:WkEyav54PiO4yaT2kYdhnxQ9xIo0NPvzDSuUDe1XaalzfCKWYBooQcsQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jun 2026 02:40:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0483ea10 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jun 2026 06:40:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 17 Jun 2026 08:39:55 +0200
Subject: [PATCH v3 12/17] odb/source-packed: wire up `count_objects()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-pks-odb-source-packed-v3-12-b5c7583cd795@pks.im>
References: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
In-Reply-To: <20260617-pks-odb-source-packed-v3-0-b5c7583cd795@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
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
2.55.0.rc0.786.g65d90a0328.dirty

