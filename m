Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB73EFFDC
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586191; cv=none; b=sKId5v64IgWKGEBjRu8cksGzJHYbOFaVpSE1GtH7Zo1hi5iKiOnCx/xjLlBx1BcPPgKWIdkBrcWW6gnF8xbbD8h3gyMVnOhUe2kZQBLtDG8hrWou2v8AfdeN7I8CmjIuNbln5LFhiJVq3tXQVYvEoVilTdUaZNbiA0MF6CEQN+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586191; c=relaxed/simple;
	bh=ldIvxunXjxueKqIi20H8HRQ072jVqh8mghYQkM44lDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NYupgeHMnwAC9Inma8iwn0NVf8if9w16C9S1jqsWdDm5jqV50MlalkwbXOhFFBQkxu75Ib9mewxWQF7UKi+XVk70+txgl2gpi2byfHvAX0ViDG0m3fPH9vWPBZsIEM3PJM/bWP2ccxSJL/FLQNA0ZgIT5WGFPsZsJQP7MjpqDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XStbcTnq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ym+aEnQA; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XStbcTnq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ym+aEnQA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 7B9AE1D00085
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Jul 2026 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586189;
	 x=1783672589; bh=j8pGmfbEIEpTUOgCQ2GCS0OvFejMRh+zewjyoHiJHh0=; b=
	XStbcTnqC9m/lqlbC3xa8YfXqvUwndh9JjUHKlraPHgV6RT7jKGeE/tN5gyS+meV
	5uFrGcY450Ndre82+4njAcLpYkqMy4isgK99yGQe3gyebdHcle5P2xYO1Rl6XTWq
	vZRPwbw51XuN8yOKUVAJdV0Cc7Mqa8Y3WgA1oZSPO/w9LkFGmasLdL16ES2et2Rv
	EjXz8of63X9hxekEXMXqoriaPQZ/y+u8wy4PKwgESDhDRZJ6xCVpqqom8Ze71o/n
	nAMblYYV7x69yGlnoobrJ9SUUGt3K0PvU29E4Nfl/oBsmKbdmRSYdI2El09qbSCr
	aRw6G/NXWewAncf43Hs+wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586189; x=
	1783672589; bh=j8pGmfbEIEpTUOgCQ2GCS0OvFejMRh+zewjyoHiJHh0=; b=Y
	m+aEnQAEjbPCdzbNyTbV3cwolL0REbgAy0KXwK0BczSCeHEc1itpElVHB1g7WLzJ
	FeC+uJLCcKXq+BTv6tp4HB4x2UnK/zk9M8CtpXAUS3s1T7ueYY1iIae5CEjDAH+F
	liWatbd4j00DFOrgj7w56cDdCDdRlXqjM+SiAD1352xa8IAZlgfru0pv1CklO1Wp
	RP3K1Mp3CUD7OrYGLQoXkSsCscURC5dh2cP2QD7qiDNOJcGXHu5RMHqP+6m1+K/W
	2kaxeVE/QvyWJFa8w/ZoPzJ9risqcazMB+lkvI0TNVvmjK61hkpxvd0TyHt7FbTy
	G8ArThQ6cBc1nSq2I5Onw==
X-ME-Sender: <xms:jV1Pami_WKxK40RQs15jG-LpnzcN7-Zn9fdgEcI7zw4iVmAXegLvrA>
    <xme:jV1Pat8DQWif56uG_E3kdr1B21xmvobc9HPzSsD_hZ086A7S0Ki1bO0oes_x3a8UP
    2QtAm3mOQnRiuP3qHWZOJqmKn08_LqKwAhVL27kGsrQWkLrCrRx3g>
X-ME-Received: <xmr:jV1Pajtr3zwhgXWd_v-_H4g59EyGdEGwVhRfc0XjLv88HbLchLGKKiZyeZSiMD-5D5MdzZZD42oOCxaFzrtqtvCZ2E2d_Dvj1OMPHYlwQA>
X-ME-Proxy-Cause: dmFkZTFFQiIaXA2kJuzdxv+CB4EkHm+WkliQn2zzSje2lI+5hOJQNGxFJs7lGm1nu0zqS9
    QgBfKnUvsr2XfbkruCqRbMwqlSeMEsVSsKjPmcedAnBj/q34E4uYlz7Cf74I1D+m45Awto
    w60lDzKo7Xd2KirHxyPNi8grPToJ8exFqNeXEmnR5S+wmoJjnOYxjMDGq+o+SBFah2mQA9
    jQEJN7iSFV1ikOuVWPaynX2XIEjC0KLcC5L61ObkMfQpp2zHFJnoHl/wjmaaCOXBjmVl+A
    Kv9qfest66CSAWH4nHrWvX7yAfqyA3/UAOruRuvvQ0qNR28e1i5wP6fNJY86jZvR0PuqIs
    +qXy4xziaIzPr+PmEYPIKLkYGIzMN99vcWYicHR0ShTssjb63aWuNTvYxc+CmGWsBrZ6Gz
    foao2sWf29UyzNKRHvAWX8vU53+CLD0yQI5imqa6605NUKBuzEKUGec/GGcBRCMvLf9nW5
    98R3ANTTSvIv4de/Zz/7/dO9cnmWkQM8wk7E3i2Nb5Jw2EOdwJ34KUf2ACVGhh55/Tiupf
    nTHDD/8IX+QgcfqK/ju4ZergMLYNeZgEG4rQSt+rsWtgL8HIjIrUkFuXceEJn/pHqqLcrq
    S51PfSHtr+Evx7mzicJHkUKpe7IyhZSsBOF2Ngd+uBhu46kh93BVnBYZm/Ew
X-ME-Proxy: <xmx:jV1PakYrURJGyQ0eQAU8WkDcimr8e0DnWRMgzX_UU8LgQS1dglRQWw>
    <xmx:jV1PajpGHfMp6gWAdo5Mk4Ww7x1zSbCP_R79ldYhUJdD3qdOq6coDg>
    <xmx:jV1Pap_vsZuo5h5bgaFNZxhQ9YUrEhkZSNqBdrfwnu8cKX8_6RbXIQ>
    <xmx:jV1Pai_qnv8fcM2mF_k-ex0YzB13cimxJOKQFRiW1opoAkhuUTxGew>
    <xmx:jV1PajjYnoZvmLAoftP6K0W8heuF7orG-CaOvFLZYl9XeYnursWz5rs4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cd33d3dd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:27 +0200
Subject: [PATCH 7/7] builtin/cat-file: filter objects via object database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-7-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

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
2.55.0.175.ge4962bd3d5.dirty

