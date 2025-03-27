Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C222615
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068655; cv=none; b=biKgvvB+qUjn4lRNiBrFzgDhJhm2WbHcSmEHAtGQ6MF/1fTU6nqc54PmSVocxK+ztKGKWeY2Lwrw5LmJpUSzqXPUMIM3fbKO2oW72Y1t8Pp8zStzXDfLAY895CeCfz9FaOYEjlPt+I5U5ovHd1ZZRJ2S5K0T4DW05rdEY2teuWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068655; c=relaxed/simple;
	bh=TeDDryDtuTtxXnXFaW+fZ+CdYiBYsVl2DU61CuN6g20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m0LpFXvyvPUxZ5BmTE7pRNhDtyMvCK3S/hj7D6XV/ZsZ1MAnBpQEbHOp2v7Ry3NUuNcNVipLvKQoZvdCkv+DsytDjJQ66/8uRWA5t80M3MhNHGwGA1Cq90YF57nljD+XjQPkVVp0mAFeQBEIxw6Uwrw5Ck9hsensP6MnmtU6cYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=exO7Mmb+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tJyCCxNG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="exO7Mmb+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tJyCCxNG"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 87BEE13838F2;
	Thu, 27 Mar 2025 05:44:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 27 Mar 2025 05:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068652;
	 x=1743155052; bh=BWxV2AzFWooSadnCkpO9tk7Wmsl/rTGP/2X5UmsaaY8=; b=
	exO7Mmb+z1aZlag71H0cz+OaUm/qgoyjz0BVwZ3GDiSOiupguzzkz7oo271Wzt/T
	oXzl9zdrqZDlr9PaTsQmf0oyVhT9CnHysEckIccb1pitlD6B/uidBg3mbHoWdHGi
	SjXeaz7kHKIs6wxKuN8bHlRrxUrcCAhIfVHed7trGVktw1L3Tft0RJhWJ+uyGgrE
	8MLPv4yVXRRmZIkYXmb7s0JFe78Qpw3pfjxhzexDs960RBWzI+qPt/kiuZolqTJG
	72SnOMEwyUST3Lt4P6ojzSA6lQ+ZUdpi5bdRol/ltCJUSi1zPlscNDaVpBzs8p0p
	hxn6xbpqJHoxR38XryPSLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068652; x=
	1743155052; bh=BWxV2AzFWooSadnCkpO9tk7Wmsl/rTGP/2X5UmsaaY8=; b=t
	JyCCxNGA41xk4nzmU30/dNYL17tAXQRk44JndOC07CytI6EdHXKQbf6DL4QHLyQt
	DA4uoTbJnCxOZ4YYTlWFOebkyUbPkD2BCMY6kv/jRjtZzJqp+Xq6tBR3wxQ71DgP
	BiVuvS9moFRxYQglaVPBDwXgvfD7jax4ghpyCp7VJbB6bjvlg/NloxTkNMw2OY+G
	vVgn1UrqE5CNUb0T827WN+mPDAMmf0ELWh0yOLQOuJ0eb79iinexFzqPBW6QxLnp
	v64rIyspQhkDDuCUy2gZe7wQMpRDp7eEfvKFMg0Rrv7n4DPvEZ+EISIuMZk7N0T0
	9ny45YrTZ3b5PmLQQubfQ==
X-ME-Sender: <xms:7B3lZ0yIcfc17bpyld5Djdc9QuF8yUiHfMFR_CvIxjfPDuAfgZK5yg>
    <xme:7B3lZ4Rs0TF8dzYzHwWOcsYqTk8b121z2f4OMFV0BpM_QKf4AFyoPc7c9juvCm8e7
    F_4hFt_GnERdjXGLA>
X-ME-Received: <xmr:7B3lZ2Ukuta8mxQ2g4DUqeX2T9tL-UI-rNZ5OKc2lvZupLwFu_gO254oEsspgpqlepBqrzGNTo214Sl0tNoTl5RSgzshXDl65aG1DGEuDF70cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:7B3lZyip8xEFDj8U708URP7bI9kocxqNC4EamAZ1826x3AOwXczM8g>
    <xmx:7B3lZ2C63GsgT-JAXyapbL9xdUGVHi7EigfX2pR7X4F5tQosPP2ypg>
    <xmx:7B3lZzI31M3k179upphMGm7i8zm4jxKKjjPRqLKOFlS-hNXCmFIB5A>
    <xmx:7B3lZ9D9p_0uVwArUTFJnMoC_3-FpwPW3kcyN4EeyWHg8-tT4P5abg>
    <xmx:7B3lZ95RayMY3ajljPHlg3ScZ-fEvEOS529iRBnz6dHXCGdtUFD81YLS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9efb5434 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:05 +0100
Subject: [PATCH v2 10/10] builtin/cat-file: use bitmaps to efficiently
 filter by object type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-10-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
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
index 6f5dbc821a2..eb6f0536c9e 100644
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
@@ -805,7 +806,20 @@ static int batch_one_object_packed(const struct object_id *oid,
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
@@ -813,9 +827,27 @@ static void batch_each_object(for_each_object_fn callback,
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
@@ -872,14 +904,14 @@ static int batch_objects(struct batch_options *opt)
 
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
2.49.0.472.ge94155a9ec.dirty

