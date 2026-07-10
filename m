Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6B38AC83
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673369; cv=none; b=G8eichyiYj6f2IDjNVBq+duYcMSsWqX/QewgORYSzpl/wsLK0xcIlzhYUu5T6MGKmp4YHeL4z7JwEHygGKHNqQy9FUfKZPqKvxTr6Qaj33ux3whokrtg2eL+7p76D5wZuU4srw9gHL/LlV0pGZ/neTNuCJLV3lxPqmMVFVnY5PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673369; c=relaxed/simple;
	bh=dNleyz49kz/WbdgnwOUi+SoFemJeoZ7aEp/+nyeQo2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7EFlrVQ+hyt1KrLo4VgVDpob+PG8z7m1Vj6FeCzPiF4TX+svo8v6vmEyTJr2JZru2cUvfpjRf4fAZb92If5qJEopzH58W7Q3yTkOpcxJVX3CAyXiuqNPHaDl74yXqPxjUzk02dc1tXJGfyxI5DTDSqalcKaIxOoLewwovV/MbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MKrIFHFX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bu7RDJ5h; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MKrIFHFX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bu7RDJ5h"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8220214000FE;
	Fri, 10 Jul 2026 04:49:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jul 2026 04:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673367;
	 x=1783759767; bh=nujgd9CL930jUfOY/Wv0ZdNil0p3GOvSoehHb5znPFc=; b=
	MKrIFHFXNFbne5c7QR3MSJmCmYjkavfMNrVjHVVzUswulgaJUdf+VbaouZ5q3BhW
	ZczCAmG6WEVlHvBfShDaNQzVkc8SgU4UrGw1qyHl/gcRjDQHOKtTcnKZP+VnkU7c
	+nMfYFJ074YIna69J6Q2o3efEO1qjeeHY2ZtF6jEFHfzc5qjdOtkgb4dKI13F6+Q
	RECWpVWkMdDnE/zcyPNaFJTDFVqrjZAerOakOARKUs+0nGrd78UT7A7hXu929T2J
	RC72qTDgWq8/1Dw5gCcrbyw/dL3KIElXnTiWrA4E7u5D7pKr0n4h09+0/zER/njL
	mgWZIdfJ+EPL63IBFQ+3ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673367; x=
	1783759767; bh=nujgd9CL930jUfOY/Wv0ZdNil0p3GOvSoehHb5znPFc=; b=B
	u7RDJ5h3pvbQpkMnKQyrxeEScPQgbxJyJV2VGtITEgrMm8x/7M+ox88DpwKf2ETZ
	JRBO4Chegkj02702bzEeErAvMzP8Mubpd+40KJZa4xcsSB/l8c3XvVAHjYHKF3A6
	l5Q4Dr4HswBuvuu5SB2lNi2goWBR1XXMImTKSLOgE8KyMNxovN8dI7ByGxrV3/1r
	iohm96E+9Puys8VuqcMXm7J/aw9MZcelJseE49GaoITgNynRYPf1A5uL4v46kGXX
	Fodq2PGxqVaiuZPlSG+bL77kemoMdSuB5/KDphTSHAhk76pwNQJ16A0vZKgH8ehH
	PtUf37AadSKr0DvqVi7aw==
X-ME-Sender: <xms:F7JQavYnQBN5VVlu2YNtck5ofn7oU-d7NL8pmWhZPWVoktomp8EFtw>
    <xme:F7JQal3_0bJwc7TdLoRUi6FoxyAW8_7_2TESm3FCS7JetZekY_hIrtbNgP10af002
    oW2IqBqktWWtF4BVodnzMjxHZetBYfNHZLJTRsu1B7f-U5rmK6WZg>
X-ME-Received: <xmr:F7JQavVQEROJJjqOO2sZJFYkk_9fO9Wb-DVco4p7sPtXhmWZSfxLj2FyLlibGUD5gH6wyb_wzQ_qELHykw8v_1dJGaa9_VS3bvJULV2EiGOLjw>
X-ME-Proxy-Cause: dmFkZTGb4Vrx08qDmYPi9ab4YASd2IUWYaD5+JRoIRe7FbbJyO9XbgM1xNd/z3RU6mbk7z
    bE6U1CXfMdE7NeJMbBrOnmMVpvtGzdwJ5CdtO+lPSd1b46MXWof+UdyM9zCCDZpnlioVM2
    Z/+w/D7Q9O4UU/SAMZMQRfWxZ47QG39Tr8smjIKlVUgCJ20PuyOyeM8bz0cPdbGr4Ds/ON
    OhjY6GxRHw3bcJCmKq4D0ET4QUuwm3TWJicoFxOilXA7z/UHvjTPswYOOjc4s7CXbNT5hF
    sKsHPEhbnvPoa7IhgtQcgjSjkXRlr5isIrsN7kZXGgnAReTx0k7p6dtBK04pDoLPbvO2it
    QHBc0wLiPHSwAgB+wbJYtZDDYHYJTGZxn9Gujf3VtZoDeY6qqDqV5g3OeF0b56opkYGEhD
    d7RhM8TnV5LNRBciv/tgElxVMvxM63kKvdJlnpQC2Vve9cZZ9eqDhxoDwlBW6WO7lnLjQp
    30ci/oyGmklcplALRMfEWT/jsk2UE0ydieljEduWznyQhJULNKrrKggggRXyx8Dhw2pDUG
    CLRspDhRnV8LFrQN4mCiP7Pd6uWgN5EQJy2Y2qvwZHR1VdzJUqceWA8O7XiahrL5ixSGS6
    ZU7Y5DpNkm6ypFYsEWX6jpNnKdrTFRZp++WYuq991TA32hjJiVuMYXasB/Qw
X-ME-Proxy: <xmx:F7JQavUZwq3GwkhEMwDJSbY8CVJgTgetP8gvOVjFavxK6RYk3SZPSw>
    <xmx:F7JQauemNC0UxKdHyHfn9SObI0N6RSSf9EY2XemQs7aFZ0258Ih-zQ>
    <xmx:F7JQaoUb5MYdObbarCpQCnn8PSX7r-dmiN88tKgQvOJCuES-l2mQUg>
    <xmx:F7JQanc_SML9lhdeJsfTKtSAFcoGrTH7yCre13_GTZnjwvBHQJh0lg>
    <xmx:F7JQat2fOEysOqYK2cd17RjNbqjOWQTSaAjyCC_jn3WypJ_p92qePH6V>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 910ed9ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:49:00 +0200
Subject: [PATCH v2 8/8] builtin/cat-file: filter objects via object
 database
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-8-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.55.0.229.g6434b31f56.dirty

