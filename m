Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3447D470
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356132; cv=none; b=k6LGreS6qt2FqbwCgpBgT+R6PYNB/f8FOgz6VXCkZAkUe6MPciJRlKPDPLO6GIjFVI/tHOSWXquqXYEWU1bfxksUJYDkmvClzy0c/GPRoJ4hFo1PC/0TvA9oHgFg6RKR0sPaykf4skMJS2pgFCW6vhWLiVZW/4sg4IbxoLiqkk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356132; c=relaxed/simple;
	bh=3MU9hm5+lBPkXNKjZmYXVZhuF1mwmfFAxDPDWjVyMUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aF3+KcULbTWiX27SWycynSNJmSknEpv6UhEgg/+rUBGcDbM8FEKfvw+S0ti7gnUbI5k09cR5j6VyC4bjfjgicSLMnKCZEqKOuSIzs2cApe1E81usTh3wle9UmQ+xUEVUrdaxNT2PCj7MVizRvJqJLhCUFadmMciWrH+pQCVAGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aY5LLsXd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bZiQm96U; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aY5LLsXd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bZiQm96U"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 102BF7A00D7;
	Wed,  2 Sep 2026 09:35:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 02 Sep 2026 09:35:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356126;
	 x=1788442526; bh=3r53k2ssc5zA6pyrlb1SUGv7aDzsL3Ya7x6QsMYh6pk=; b=
	aY5LLsXdhkskY9VuujYQIsMQVQzEyjXUzMxXWoJPxwJKEd71qfOPM9/i5Smuf3do
	ZW4GQaqYA5AOXm3X6qP3e5ZFzakN5W9XWY9AO9fhPlCQSWKRV1s9ptH8S7ecw3Ut
	E793iumsLObJ2SKRHZN/2wxoxtKO4otocP4tsS1Jx0mWnMskuHTHor2KWgD8Yafx
	UPtOp30qY27lXjZLtIS21EzyI/WBMFeVR3qgA/gOV1aNCt1L9FIb06bh3Pk9O/NB
	sDFQtrUD9KeRCf7ACPT8iRYS9iJJXzU4t5wCSM5bJNDZffGzZL6vyZcPsASNdDaH
	GQK+dlEW5TCAmCub/Wf8OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356126; x=
	1788442526; bh=3r53k2ssc5zA6pyrlb1SUGv7aDzsL3Ya7x6QsMYh6pk=; b=b
	ZiQm96UPdd+ewSqSb6izAR0QvSrvcODys4dNL7jmFihP6R0AD22pLilAwXiRCDDE
	F2I2jouOsXalzr2PmxT7em+gcl9eUGD95Nsofz8IcLQ+VrDe+JLQ14bXEevQuLn4
	D5YtbP6ULYfwk6qaWHrIX/VGdlSIWHr330VmEDClsrhZR8zKY4Gew4Xm+GguNwiM
	06uQaMlUFVUZ2vq2i6ULC0m3+WJ8FxCKbxuXJ1TRZiQk/LWjSB1Yv+09bqN2mYb6
	5hp52yC5UXA9Jvj7f7Fa2kw0vfqbx5sBGUEOp4WfNs+1OJWpxL0NDhAnZ5UEQQNC
	TO9uR7xp7Z8Jm1WBPib9Q==
X-ME-Sender: <xms:HiaYape7dP4lOCcncMgExxnWDBt6EvxIuiNGx_W-82aMdwv-oNElYA>
    <xme:HiaYatMoBfLwpmv7TBXINUN0aKbvIBoRbC-cxvUJVxwUFvGvAG9w0rfUM5ROsCmw7
    39PW7nEx0orPMm3yBIpOHgUXam3JUkktBZkiQT9C3WkTaiIJu7ZkA>
X-ME-Received: <xmr:HiaYagLqrH8aFtlqaJv-xH-fx9koJ060OHuhxI_Pq32sKVYJEgFoQnFgCMO6RhHLuyUXklY>
X-ME-Proxy-Cause: dmFkZTGarp81zQ7N+tVloiKE1UqEKo0TVx0DnqHMpG6tMyQeDzUmcFcqTqyBBzbj/dcO5i
    LbwQfQxzSJ/F7OuO0073mk61IQ/Y8QnqdvT0Cr0J/Ktw/2nNIdZkmNKQbG5Lv0TtSadPXV
    YJt6BUBe6YFSCSD1qpSFa/W35EhkQFVZ98mE1SmX6MccP/ThCItsxEprn1+jCE0GLkhjxp
    eKRtFU/89dfPD68WyuyQKALyLXoqw1wCy6OPvHcwWR8+2ZpQeL7r9dqYEF6p6YoRGIlX8w
    o8emwGeKpvI/scQeTi2FSXkIEvCq8KSzb2gwGhf9Hz3p6vR0ZHYB0fTSrgYYu9P2x0jiq2
    lSpRwOZiU9Bf6fo+Gs7vl9ZKr4tQAgZwJ6LgSBwa3kXX7PDrZmPMMMdYn4cMRVGCgfllt4
    JJVAJ6NwkUTr6/zenn9q9YnGInmx25OF5m+VMR+AAaY5eBDTH3t3CsqBapRDwmPYtvCg/n
    ASfJf+ED4pHPtcksizy150TrlsvEmXBAt/pd4yNV7zRHABOqE0pLo3EnrwzEuQYR/1Sly3
    xqrVXf2gRg+eaXrxz2vFWq3e5sJsd66wDEW7L+E6YAjEEUcxxAROqDmbqVW7ubOGAsK5yr
    izCDs2O7yLifMIclPQ0gkJ1bGozROdQzdYjCdh7SaQPysvungkUnkAK2XRPw
X-ME-Proxy: <xmx:HiaYauG3j1Sa_aCVZ1k_zGQmFcAlzIjTpbQSEqTuymFpOG9_njaS_g>
    <xmx:HiaYaoTul6tUYIQT__dvZfUyj_DytI0mcygPR4tDOk65ye-KSEm83A>
    <xmx:HiaYaqERQ4da6PhifQof82_TgLv2t3vRba5AcqPb30S_-8iVq6iq0A>
    <xmx:HiaYak_aZZMQr_zfsa95_YUsqtSOJjS-aCQTy9MG3ZUaK2RHhgIOZg>
    <xmx:HiaYak1hms4zonnvJkgaUvGNY3U8wmdGV-pQouCYcnVwJZq02HmMF6V7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f64cc23a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Sep 2026 15:34:59 +0200
Subject: [PATCH v2 11/13] t/helper: adapt read-midx to not link ad-hoc
 source anymore
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-11-c6ca12fdea4d@pks.im>
References: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
In-Reply-To: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Same as in the preceding commit, refactor the setup of ad-hoc object
database sources when accessing a multi-pack index in an arbitrary
location to not link the newly created source into the main object
database anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-read-midx.c | 43 +++++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 12 deletions(-)

diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
index 27a05da957..1f7a1927e4 100644
--- a/t/helper/test-read-midx.c
+++ b/t/helper/test-read-midx.c
@@ -5,34 +5,42 @@
 #include "midx.h"
 #include "repository.h"
 #include "odb.h"
+#include "odb/source-packed.h"
 #include "pack-bitmap.h"
 #include "packfile.h"
 #include "setup.h"
 #include "gettext.h"
 #include "pack-revindex.h"
 
-static struct multi_pack_index *setup_midx(const char *object_dir)
+static struct multi_pack_index *setup_midx(const char *object_dir,
+					   struct odb_source_packed **out)
 {
-	struct odb_source_files *files;
+	struct odb_source_packed *packed;
 	struct odb_source *source;
+
 	setup_git_directory(the_repository);
+
 	source = odb_find_source(the_repository->objects, object_dir);
-	if (!source)
-		source = odb_add_to_alternates_memory(the_repository->objects,
-						      object_dir);
-	files = odb_source_files_downcast(source);
+	if (source) {
+		packed = odb_source_files_downcast(source)->packed;
+	} else {
+		packed = odb_source_packed_new(the_repository->objects,
+					       object_dir, false);
+		*out = packed;
+	}
 
-	return load_multi_pack_index(files->packed);
+	return load_multi_pack_index(packed);
 }
 
 static int read_midx_file(const char *object_dir, const char *checksum,
 			  int show_objects)
 {
+	struct odb_source_packed *packed = NULL;
 	uint32_t i;
 	struct multi_pack_index *m, *tip;
 	int ret = 0;
 
-	m = tip = setup_midx(object_dir);
+	m = tip = setup_midx(object_dir, &packed);
 
 	if (!m)
 		return 1;
@@ -91,29 +99,35 @@ static int read_midx_file(const char *object_dir, const char *checksum,
 
 out:
 	close_midx(tip);
+	if (packed)
+		odb_source_free(&packed->base);
 
 	return ret;
 }
 
 static int read_midx_checksum(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *m;
 
-	m = setup_midx(object_dir);
+	m = setup_midx(object_dir, &packed);
 	if (!m)
 		return 1;
 	printf("%s\n", midx_get_checksum_hex(m));
 
 	close_midx(m);
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 
 static int read_midx_preferred_pack(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *midx = NULL;
 	uint32_t preferred_pack;
 
-	midx = setup_midx(object_dir);
+	midx = setup_midx(object_dir, &packed);
 	if (!midx)
 		return 1;
 
@@ -124,17 +138,21 @@ static int read_midx_preferred_pack(const char *object_dir)
 	}
 
 	printf("%s\n", midx->pack_names[preferred_pack]);
+
 	close_midx(midx);
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 
 static int read_midx_bitmapped_packs(const char *object_dir)
 {
+	struct odb_source_packed *packed = NULL;
 	struct multi_pack_index *midx = NULL;
 	struct bitmapped_pack pack;
 	uint32_t i;
 
-	midx = setup_midx(object_dir);
+	midx = setup_midx(object_dir, &packed);
 	if (!midx)
 		return 1;
 
@@ -150,7 +168,8 @@ static int read_midx_bitmapped_packs(const char *object_dir)
 	}
 
 	close_midx(midx);
-
+	if (packed)
+		odb_source_free(&packed->base);
 	return 0;
 }
 

-- 
2.55.0.979.g7e5102b832.dirty

