Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313FB23A98D
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592436; cv=none; b=OKnSK4F5lxjaSC3uFcC1dgGURm51Z6epb/Fz95awdIow5hIpCkMOseCdLJRzE/yylq4V2eHuFF1GBjAwXs4D3MhXaqFzFV0oSYI6PHO+cabHxugVxMIuFvhGqXXSG6Qk/yBGO185U9n+qeL6mWcEzEmRKfuZENDTfK6QNwrSNdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592436; c=relaxed/simple;
	bh=SnOse+p2YjlwB9qxOrfU/1Wfd24EJicdAOXCD6/00Fw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ipi0q39fvMZpworJQoEqGddOVdcQ4iMkaYy2xsQfddctqpNHUDDP0XvXwRzLlSPQgt2PhVUOu8JQVdEol22Wn2hpG/4QAHCsjp4CBpmaRpZp+zJqObfPJ+M2no/hE5cPWvxlXeJ/couFFHNk480cfhtvl1rq9iEJ+TqKDfQr6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aD6X4N1p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u1X1Ri80; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aD6X4N1p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u1X1Ri80"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 27DF22540255;
	Wed,  2 Apr 2025 07:13:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Apr 2025 07:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592434;
	 x=1743678834; bh=MBjPtLnORP71Tnlk9Nv4AAobxzecUQ4gmNBAquFbZI8=; b=
	aD6X4N1peSBR3rASakDC10JHa7JuVGko3dwcPKQtck6BcQKZ13f5deFPcgxRvYCB
	TIFzUvfb/bjAkTm6ToBGWClYrjEzyFy31qCu4ASM6il/fUVXym5hCg74z3Sis0sM
	n47RH6TkqRHq+yTKJhb0EKrJZSThv+SlnHI+3YC5D6WhM+GBDQtAevS5IkOKGDPM
	lt1mwVIao9x3qHkhdA8fgAnbqgYIE0sIVwJjWTiH8CNJRKKg3zbm/6P9LOh4982r
	u832UAS9HTOhrHlGGmJROaHexZj9uEiZ5TmJTRcI+B9sHDHxtl+uq/5vKS1tPxp3
	Sm1Q1pqmeidjXYQ9t7be6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592434; x=
	1743678834; bh=MBjPtLnORP71Tnlk9Nv4AAobxzecUQ4gmNBAquFbZI8=; b=u
	1X1Ri80Zk1e5z52/rVkYx7jOPLC+j19luEPILQAagU2RfLqQEc7mHP9dggpIYBBZ
	W7wbhBQmVN/hWr4uB3yfzg3tusflTsnjHN01yoADUFUscn/h+VK+7T+CcExUD+mY
	1K6QGT1NoyBBLCEZohsmLC0ADSp6fmWddTLQU4bkaOCB511M14cVsl4fvBVgFSDo
	ifejmfToI6rqrGfRBRjveOQu3YpUwnBeYBGGK9V9/QZ1ZoUvmYlx2uTuC0i1bwkX
	Dcx1ZFN8e3VdiqKtknbFrwKclATiceQtO3vM/U1uq6heo+SDU/WkBHVNkm3sBih8
	7DyDr096w6CcTiEb9CAuA==
X-ME-Sender: <xms:8RvtZ32VWBYPUbbSaOBmnff48mQv2yPmpGNL1QvjYOy5A4vzKRAXNw>
    <xme:8RvtZ2EQOJeNq4jUTQaez8af3pI_uVIqiKj1PRm2JyFHjUK5UxaiZCVEvhnt7_INt
    qN3scP1VJABZbMTfA>
X-ME-Received: <xmr:8RvtZ353YvBfdtG6AEWDyeuhV59VO-IloiJQvfsob28mzxSCwSEZCHcy6LfILMr-pfRM23riGufttEN3M0UYMB_HENyxgdXB1jQ3T9bjHYw0UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgv
    sehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:8RvtZ82AU4L05Q6sVsp_zK4BAeF2x1uJHRFIRQlT5VllaM53GGOhAQ>
    <xmx:8RvtZ6HJhULw5vS49qI1StUOFKEd1caOyhyw57fc5mhbQqUVSi7BwQ>
    <xmx:8RvtZ98bcIW6WLT4gj6ypMWOyZ6Rggjo6wcIHgNnKu1ar5JEhu7nhg>
    <xmx:8RvtZ3nJ9w_0qn589E3uifxmCmjpG84P3FapYrzjNPbz_pzAL8bNCQ>
    <xmx:8hvtZ1qtdL0ug0Iaz4Dgp2LNgatPC02Kb8JznFTpjyoeCcTrS1YczqPU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b63d38c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:46 +0200
Subject: [PATCH v3 11/11] builtin/cat-file: use bitmaps to efficiently
 filter by object type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-11-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While it is now possible to filter objects by type, this mechanism is
for now mostly a convenience. Most importantly, we still have to iterate
through the whole packfile to find all objects of a specific type. This
can be prohibitively expensive depending on the size of the packfiles.

It isn't really possible to do better than this when only considering a
packfile itself, as the order of objects is not fixed. But when we have
a packfile with a corresponding bitmap, either because the packfile
itself has one or because the multi-pack index has a bitmap for it, then
we can use these bitmaps to improve the runtime.

While bitmaps are typically used to compute reachability of objects,
they also contain one bitmap per object type that encodes which object
has what type. So instead of reading through the whole packfile(s), we
can use the bitmaps and iterate through the type-specific bitmap.
Typically, only a subset of packfiles will have a bitmap. But this isn't
really much of a problem: we can use bitmaps when available, and then
use the non-bitmap walk for every packfile that isn't covered by one.

Overall, this leads to quite a significant speedup depending on how many
objects of a certain type exist. The following benchmarks have been
executed in the Chromium repository, which has a 50GB packfile with
almost 25 million objects. As expected, there isn't really much of a
change in performance without an object filter:

    Benchmark 1: cat-file with no-filter (revision = HEAD~)
      Time (mean ± σ):     89.675 s ±  4.527 s    [User: 40.807 s, System: 10.782 s]
      Range (min … max):   83.052 s … 96.084 s    10 runs

    Benchmark 2: cat-file with no-filter (revision = HEAD)
      Time (mean ± σ):     88.991 s ±  2.488 s    [User: 42.278 s, System: 10.305 s]
      Range (min … max):   82.843 s … 91.271 s    10 runs

    Summary
      cat-file with no-filter (revision = HEAD) ran
        1.01 ± 0.06 times faster than cat-file with no-filter (revision = HEAD~)

We still have to scan through all objects as we yield all of them, so
using the bitmap in this case doesn't really buy us anything. What is
noticeable in this benchmark is that we're I/O-bound, not CPU-bound, as
can be seen from the user/system runtimes, which combined are way lower
than the overall benchmarked runtime.

But when we do use a filter we can see a significant improvement:

    Benchmark 1: cat-file with filter=object:type=commit (revision = HEAD~)
      Time (mean ± σ):     86.444 s ±  4.081 s    [User: 36.830 s, System: 11.312 s]
      Range (min … max):   80.305 s … 93.104 s    10 runs

    Benchmark 2: cat-file with filter=object:type=commit (revision = HEAD)
      Time (mean ± σ):      2.089 s ±  0.015 s    [User: 1.872 s, System: 0.207 s]
      Range (min … max):    2.073 s …  2.119 s    10 runs

    Summary
      cat-file with filter=object:type=commit (revision = HEAD) ran
       41.38 ± 1.98 times faster than cat-file with filter=object:type=commit (revision = HEAD~)

This is because we don't have to scan through all packfiles anymore, but
can instead directly look up relevant objects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index b0c758eca02..ead7554a57a 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -21,6 +21,7 @@
 #include "streaming.h"
 #include "oid-array.h"
 #include "packfile.h"
+#include "pack-bitmap.h"
 #include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
@@ -825,7 +826,20 @@ static int batch_one_object_packed(const struct object_id *oid,
 				 payload->payload);
 }
 
-static void batch_each_object(for_each_object_fn callback,
+static int batch_one_object_bitmapped(const struct object_id *oid,
+				      enum object_type type UNUSED,
+				      int flags UNUSED,
+				      uint32_t hash UNUSED,
+				      struct packed_git *pack,
+				      off_t offset,
+				      void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, pack, offset, payload->payload);
+}
+
+static void batch_each_object(struct batch_options *opt,
+			      for_each_object_fn callback,
 			      unsigned flags,
 			      void *_payload)
 {
@@ -833,9 +847,27 @@ static void batch_each_object(for_each_object_fn callback,
 		.callback = callback,
 		.payload = _payload,
 	};
+	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
+
 	for_each_loose_object(batch_one_object_loose, &payload, 0);
-	for_each_packed_object(the_repository, batch_one_object_packed,
-			       &payload, flags);
+
+	if (bitmap && !for_each_bitmapped_object(bitmap, &opt->objects_filter,
+						 batch_one_object_bitmapped, &payload)) {
+		struct packed_git *pack;
+
+		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
+			if (bitmap_index_contains_pack(bitmap, pack) ||
+			    open_pack_index(pack))
+				continue;
+			for_each_object_in_pack(pack, batch_one_object_packed,
+						&payload, flags);
+		}
+	} else {
+		for_each_packed_object(the_repository, batch_one_object_packed,
+				       &payload, flags);
+	}
+
+	free_bitmap_index(bitmap);
 }
 
 static int batch_objects(struct batch_options *opt)
@@ -892,14 +924,14 @@ static int batch_objects(struct batch_options *opt)
 
 			cb.seen = &seen;
 
-			batch_each_object(batch_unordered_object,
+			batch_each_object(opt, batch_unordered_object,
 					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
 
 			oidset_clear(&seen);
 		} else {
 			struct oid_array sa = OID_ARRAY_INIT;
 
-			batch_each_object(collect_object, 0, &sa);
+			batch_each_object(opt, collect_object, 0, &sa);
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
 			oid_array_clear(&sa);

-- 
2.49.0.604.gff1f9ca942.dirty

