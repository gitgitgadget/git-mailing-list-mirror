Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E126143C04C
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953717; cv=none; b=dAp6VEaykIbDhhFWaWh/Lz/21IJaqRk3HcLy7NZ1nqbUpo9sOPo+wbUd41YyFPPzWGgAUtP9SbUXIdL0hJRFAWbFPz3kvUiyg9xOPkr3yYM9OPt5PwZffH5V4rq/m2sVwVtguj0LSoKEh9EHRsfLRA/mQ7oOa4tKqHqLlP89NEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953717; c=relaxed/simple;
	bh=qba9Tx5IHISGgmVNTeqh9uYvcbeCWakCuaot9ihk/zg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8R7CiIEgCWXP9OghYBLBa5ElAg1GFF7LWJM5N3Ngtp/ls54RgASyM/zG2QkXVsVZ3IrBoH6WxjozN5netSOntBz3ZzUrm9KlDWFEoSMarr51Q+0IrbVXhEQRfVIkh+op2YGh0zElgeY2VJw4hfE+jJeu7/r7Y/LDrdM97twvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ssj2k9nj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EznPe5yI; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ssj2k9nj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EznPe5yI"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2D8117A00DC;
	Mon, 13 Jul 2026 10:41:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 13 Jul 2026 10:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953715;
	 x=1784040115; bh=b0PhXLhU8CiPYYskVIl05ljLfAF8cFGMGYIs9boMYmc=; b=
	Ssj2k9njp4gqvZMWfNirOAkCYq0QEj/+vtfr7drmocf7wdS6MechN2+X0gwhxFDp
	Ao7acJKHWR9IWbmlZL5PBo+hwbZVn4E3UWQE9UuegXIEpY09ybddrrXFGzdZcZj4
	dN9lCJg9/eKzoahFru1rZFP9O0lrwLKWtRxFacPnZReKr2VTac/acW1skSiroKC8
	AJNhSuOKF3meRSXASuH1fMDLkVKBwGxfViBdAXyRzXqvSYp2UlgJP6SvFRyqNBVx
	uuE3slM0LaK8cWZe781a/eaowS8+zX99/qDlrWbVXzjmQfRFb1qf/OPJcMB4mF1M
	vBGuIoygXCHkiLhJ+XtmVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953715; x=
	1784040115; bh=b0PhXLhU8CiPYYskVIl05ljLfAF8cFGMGYIs9boMYmc=; b=E
	znPe5yIr036GGX5ne5mh7mW3gL3MZEGC8a8Pa3HxgMv00CjYMBVAovlpPpkce0Vz
	tSWVJV2apeNlMiGWwXAidp8uCLGehIA1yI/ZgYit3dhXaNjiIr4jrIqZjk9MoNlO
	rM0n7KcaInqNH3UCucPWQguj6N8Wt8CqeIlUcwinjf8f9IQD0ZFoJQzNVWVXPFXG
	+LwI0AzwmA3ai80YhCMB8B1cwdn6JtdZOSK004pds1jBOpW3x8u+jqbT0kUJIT7N
	GaTI/ezvW5+LWaB3XwB+ejR68CO8NMfjjWhJELpl05XLAvaIfP/5ClipifgP9kou
	ubz/ZCYdoKXlPfHf+B/tA==
X-ME-Sender: <xms:MvlUamOnCV9h9TS0tMZl8XS25hJx_ijJGh0MNWrphopwaw_6sNqGeQ>
    <xme:MvlUar0d8GeemOAS2t-78x-XBkmBFKSMCXzp_H8d8anc2DFpo989sQrQfO11o6XY3
    4ItCUJ9JTVYEZSL4QUsIUs_F2jFJeJ5WfXS0hxNPEY3OpjqpexJqQ>
X-ME-Received: <xmr:MvlUalkKQ-_Xo1UxJpAzE0PDuetGBMZY_SN81nhElsQ2Ay--ZvDtjn9gogirWMsdEXhC3kxc-D26qsr_bc-OXDONEh_ElsmX-p-TuPFp>
X-ME-Proxy-Cause: dmFkZTEQFI6EIs86vsGniSFo/i+zUpd/VWvrb9jxGzILEdXtmZycl73xbCE91lPUPVeS4f
    lt4T/NwZ9gyO/ZAnSUjwXLObW/sZbJJUYr9IQgbVmBYJoUyOoEKYMrB7YiHLHOvVI4hd16
    AewehM6HcbjQ4NWMsondWRJRVrj7Qpjbjj8ak+MePMr6rV6+gvOP+1ctGFG+0B85CPVxZA
    mrpCGjv8EgZQzCYk76hxQRCFDwEmP5cTKRBwPFJWE8ofEdk3PegPUsbONN9cXbBh/Qhz/h
    UNK7lnzA00X8El50mB1BDNvelBjjyTa/VzizSkWfIPgxxoA01GrYVfRjJUobZd2NhRV0Eb
    U0s5jdkATBip0vKZd4W9fOO/2O+aGx4JMdmXyO7ee35Cx9riJqcobQDXBGAryzczuv3tld
    0KVT4SEIrKhDZHHQ0vTcYalFfHVsG6DZRRZ3MIdFA3POVdwU41A9c66V04ZkHDEcw+quge
    CXPBUDvoFPWL7+7q0OXhK3Kq+rXnkz4fxSQFaapfBnhTzzxP0nMP8CFZ7Yns5uKj9VXNCi
    aXeI6zO9Uj9210DqcGw3Dx2zfUTv6f+XLQZ4kRDkGlVMxv6thwtTslbYu+3BuXRukUDuww
    mcqgXLh1UQZtNt/rGp8/65njRiMG+0LIvaYHl4K3FiUqBjzaVtn1bhaVmdoQ
X-ME-Proxy: <xmx:MvlUaiWIhFg_Hus58Sf9TNZKMFp7b9msuD9JQSevLyt1wB-FwtqAxA>
    <xmx:MvlUarvy8I-cKDNEegtpVQ6FZaROU3vsQTpy0yMafrAb_r3FRqB36w>
    <xmx:MvlUala1C7aKRf0CGaXBcecNG1CHdLWhMIXOpc-3lbBPsbHPvgnqcQ>
    <xmx:MvlUaqXBaB1zQ8WxIEAAwF3LcDhpwrDj8baeh8cuWh5awX6jtZxz3w>
    <xmx:M_lUaoi1t2yHLABlsNSiTM_KZhF3GuzFgh7DdPGELPirjIPoGwFzT9RU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee017812 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:33 +0200
Subject: [PATCH v3 9/9] builtin/cat-file: filter objects via object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-9-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
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

