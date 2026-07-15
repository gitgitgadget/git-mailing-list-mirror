Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AFD32FA1B
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096584; cv=none; b=qYnugWOt3xpJlCVS9rUNSFACAW9+hNx3Zhe7+UiwLXitzh6tv+fll8GbSTRmZNSJpGtG85P5O52vs47dbavmfGsNc5Wr5ob0SliCrbUll4fzI2LKs5wGy0aafjq3iKWsfzxyxZFkMRhsF/YkTj4nSYKkOQKZ5p4eASkfxmyqJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096584; c=relaxed/simple;
	bh=qba9Tx5IHISGgmVNTeqh9uYvcbeCWakCuaot9ihk/zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rxM0o8PY+27FZrIHH6bqX/wYYmjQbOnBBXOy3TFMu/qq7yd4n1EXVAP++3hDnS3p20NyZ9LU97vG5FqFjhX6CTRqlqthZQYMwHWg8onEH0G4opLZlqo/H0gFEwRUefd+i1TlfZwYBO5Ezgc1YeI98bOQnrnzt53ZVED1qS61Rb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HvjzU9xW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6N7COy2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HvjzU9xW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6N7COy2"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BE2567A0144;
	Wed, 15 Jul 2026 02:23:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 15 Jul 2026 02:23:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096581;
	 x=1784182981; bh=b0PhXLhU8CiPYYskVIl05ljLfAF8cFGMGYIs9boMYmc=; b=
	HvjzU9xWgwfQNyAjTPGuOGgkU/0uJ1cqNWXA/cSSBGhcQISKNfm+w8TTxi9+rFVx
	n3W6Aw3viTUOWiOa3NHOvbixgfqfGUWhTWBDYdE7zCrUu3nuySWVlWRC/PrEPpei
	1si1tLHb2oRxF2ns9K2A2I0vvgOaCDnWvM8L0YHVnFZyfc/RfjKjHycXDtvqPTrB
	HZf17nYIsRxvObyjPbkn55JnA9umnJpXavhlZb4fjR2yHszl9XUEbCRT5xnGhI0l
	9sB6LCexpQFASElnNgHO12SIWGjoEm1rPeu/hPAp6y8+BDEHj33ZK2/oyHTPI6Rv
	lbcHAzyO/gq902B/EJ5Ubg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096581; x=
	1784182981; bh=b0PhXLhU8CiPYYskVIl05ljLfAF8cFGMGYIs9boMYmc=; b=h
	6N7COy2XWMICcy0I1fsOkTRuloaoARPfe0ZeeT9DHjkFh4IrNIwDANwIJaJRozXf
	4+mppuZ9hhiuScaP80/HLgXPNhZ3p2kuJ3BwCVXfhXkRq1gFV2eN55ZLK4XEMXNY
	EgMjixKqBqWegpF7fRSx/ocNNPxzL2JFz8wM2PoBVcHIiyujZ2SXXK8P9OFNmftp
	oFOfNbZuFS9AA1FPbs+OE3UUtATCUDXsufwheKELhR2uLsgLaKX7JhcP4tewopu8
	wmHCqwbrYlN5Ol4qI8q0Gf+RwvvQ8jPWWXSzGTDSQSXC+QOiBARr6T49enAgEB6f
	0TQMxxVrbSCkVfn6gpcUw==
X-ME-Sender: <xms:RSdXal9iz1jUBiaAuTsu4cjs_zB_y4i3uBv_C723b2-1kFrblPdQcg>
    <xme:RSdXaiKXBX3Ulyo3XyXR-DkVdq-FB3CFy7KEKjSoRpeyhtrK6NBsTDbO14aCOlpcc
    NFz0YSSGhiimAToW5Y39lorqAEj9PA7qVidzK0vFZneH9p7NvKc1g>
X-ME-Received: <xmr:RSdXajdVb_TM3HHU-WePK3cCDMoqSyaJ49nKlS2Yz4og47H6KQ0f6A1j4Abo-MDlvwUK9ssM1vib5KLWqt41A9y849nfICedux4x2jEK8Ow>
X-ME-Proxy-Cause: dmFkZTEQYQwCz9KUQ/yBYnsuppgPaPKAJyyViWG5j0ZP7V1tl+11JRvXkZezmWq5tXHE72
    QMhu63gQtg3Egl6ZZwWQ3LmMghtll0A4CSZnlOHwAvmaiKI22qqZYHOZYwVPvUKXMIyFjF
    oTKhXyE3luAhKdymIfeWPgVRb8nit3T4/2gYsWI+Xt/VEmFb2avs5qq2cA/HnRVsRSfZPS
    ylGKZFkNe7PckkJTHJEZ+bDuY5AVBUhGfTU9nacVV8unWH5qmTEUi7eSJNrsJyb8+Lhttv
    quQ5cSmcS5deC/b77HpW4cAQy0a34173yb3oKlxoDL5ku30XbAAWfgQ1cIBc/lY9wijHYn
    o17y2NRSMkHtVvc7uoqQBtlC1KKFsYgd/tcmYM0/EzFaXe1TCDoo/MGknw75bvh3QtBzMH
    JbLEVhDtne3CKp7IFAzHHax6aIt1t3xXr0/pH/qqGuWTdBXeeeqYGpuseicz7hLQaEwVM/
    qJdteqWw61gopWZ3A0Ai/WiAbB42pqfX86mvliGG69mff6xx3O1iqvCgg9pLw71gGBz36N
    AKqQ6H8joTdw+3LSUy8rJv6LrSg7xjVtJWrbNwHQ/er+1QpajU5pgHugE+b9nx0SlJdjnb
    1mPt5nGHg5OrYHxUlgytdsQutGtW9nS41FqJq6IPpawtUcm2vKxBLbiJ4KIg
X-ME-Proxy: <xmx:RSdXap-BIMFJ30Fy_4sX6JLdLe8m8dTXWV_ghSA-J-xyMEvUsFtyhQ>
    <xmx:RSdXaoopEF9tfuBfLhHCw9rDf9WNwjsXij5VD4b7CHU5tj8BV9qv0w>
    <xmx:RSdXamAidATap-qZSTF2khG-tJKYujKw4xJS5gOUhhoRVSBZL9_TBA>
    <xmx:RSdXaiznoivoiN3WDStOI33OPCRDfKPN5pnOdu8dQCtZWF2yFDEj7Q>
    <xmx:RSdXakmLRn8Y0d7jvoPtJsBcLHkzc-6I3qHd8y_iS4e6SCm-Wp7pJHDA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:23:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 06d5e92f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:39 +0200
Subject: [PATCH v4 9/9] builtin/cat-file: filter objects via object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-9-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When batching all objects, git-cat-file(1) reaches into the internals of
the object database and manually manages bitmaps to apply object
filters. This creates coupling between the command and the internals of
the respective backend.

Refactor git-cat-file(1) to use the new object filter option when
batching all objects. This significantly simplifies the logic and
ensures that we don't have to reach into internals of the "files" source
anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 76 +++++-------------------------------------------------
 1 file changed, 7 insertions(+), 69 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b4b99a73da..1458dd76d6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -20,7 +20,6 @@
 #include "userdiff.h"
 #include "oid-array.h"
 #include "packfile.h"
-#include "pack-bitmap.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "odb.h"
@@ -844,28 +843,6 @@ static int batch_one_object_oi(const struct object_id *oid,
 	return payload->callback(oid, NULL, 0, payload->payload);
 }
 
-static int batch_one_object_packed(const struct object_id *oid,
-				   struct packed_git *pack,
-				   uint32_t pos,
-				   void *_payload)
-{
-	struct for_each_object_payload *payload = _payload;
-	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
-				 payload->payload);
-}
-
-static int batch_one_object_bitmapped(const struct object_id *oid,
-				      enum object_type type UNUSED,
-				      int flags UNUSED,
-				      uint32_t hash UNUSED,
-				      struct packed_git *pack,
-				      off_t offset,
-				      void *_payload)
-{
-	struct for_each_object_payload *payload = _payload;
-	return payload->callback(oid, pack, offset, payload->payload);
-}
-
 static void batch_each_object(struct batch_options *opt,
 			      for_each_object_fn callback,
 			      unsigned flags,
@@ -875,56 +852,17 @@ static void batch_each_object(struct batch_options *opt,
 		.callback = callback,
 		.payload = _payload,
 	};
+	struct odb_source_info source_info;
+	struct object_info oi = {
+		.source_infop = &source_info,
+	};
 	struct odb_for_each_object_options opts = {
 		.flags = flags,
+		.filter = &opt->objects_filter,
 	};
-	struct bitmap_index *bitmap = NULL;
-	struct odb_source *source;
-
-	/*
-	 * TODO: we still need to tap into implementation details of the object
-	 * database sources. Ideally, we should extend `odb_for_each_object()`
-	 * to handle object filters itself so that we can move the filtering
-	 * logic into the individual sources.
-	 */
-	odb_prepare_alternates(the_repository->objects);
-	for (source = the_repository->objects->sources; source; source = source->next) {
-		struct odb_source_files *files = odb_source_files_downcast(source);
-		int ret = odb_source_for_each_object(&files->loose->base, NULL, batch_one_object_oi,
-						     &payload, &opts);
-		if (ret)
-			break;
-	}
-
-	if (opt->objects_filter.choice != LOFC_DISABLED &&
-	    (bitmap = prepare_bitmap_git(the_repository)) &&
-	    !for_each_bitmapped_object(bitmap, &opt->objects_filter,
-				       batch_one_object_bitmapped, &payload)) {
-		struct packed_git *pack;
-
-		repo_for_each_pack(the_repository, pack) {
-			if (bitmap_index_contains_pack(bitmap, pack) ||
-			    open_pack_index(pack))
-				continue;
-			for_each_object_in_pack(pack, batch_one_object_packed,
-						&payload, flags);
-		}
-	} else {
-		struct odb_source_info source_info;
-		struct object_info oi = {
-			.source_infop = &source_info,
-		};
-
-		for (source = the_repository->objects->sources; source; source = source->next) {
-			struct odb_source_files *files = odb_source_files_downcast(source);
-			int ret = odb_source_for_each_object(&files->packed->base, &oi,
-							     batch_one_object_oi, &payload, &opts);
-			if (ret)
-				break;
-		}
-	}
 
-	free_bitmap_index(bitmap);
+	odb_for_each_object_ext(the_repository->objects, &oi,
+				batch_one_object_oi, &payload, &opts);
 }
 
 static int batch_objects(struct batch_options *opt)

-- 
2.55.0.313.g8d093f411d.dirty

