Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3251FF7C1
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124063; cv=none; b=nCS3l50P9EcTzJWnuw4hfI67MdAcDf9N0CQU41Om7wyR1Vc/jXMrifydShaK0zqem3LbyzA172kAUl18p7GAUSvtA5AoObkp0sldi9YRTqIOCD63F06y7uF6TCjaYIF77SP8x5/mkyAgH+NVyc4Ozph5VsWxwsuCfNH/gr/6YbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124063; c=relaxed/simple;
	bh=XvDfbuCWeYeeD5cIRiX5lGorqmOcaAZ6d13cXzxg7tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fLon9PIJCZd9gY7A+/jorwLl9BvvCGNYUqJ2y+Xp+ydTwR30+NyxU27gC8jfdPM1OeTA3456DHapuJBLXEvU82B5aJQV/PXnN7REmT4SPWkE7yeA9RVwedf+ngelbVZe663FkLryn0tdVVhtbAHrQgov19NFsFag2ETZR2ND2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ie2p4zpn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zP3dWeQ0; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ie2p4zpn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zP3dWeQ0"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C533A1140192
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 21 Feb 2025 02:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124060;
	 x=1740210460; bh=LbPig9wC+Kb/MDpnGpVL0WY5vLcC6eq7PS1BPhiW/ws=; b=
	ie2p4zpnf9n/Ur9cTwLCibdRmdlrysKDPSr8Y00/DG25comk/9ekur07q37FvQkD
	qM6HseBQ3vh9g8kdA/nlAX6862GKh2y+TkfkLazT8V3WRAswsKoDacEEK3aClJzO
	jKkhmDnV7T7ZM/bU3xBPJ/Qgg2QOiSRt0btLEZYdHIM+KAOpmGsfXHP6r1DsbVEn
	w5VGROKutXlI3/LRNYPLIVKbsNdRUL+AU2MG9B4HFsG1Oc6+SATDFTV385imzYKE
	EhrmmzhEg10L9tVFLykSXYiDk5bJxx+87aoi89P4QWDLOF0i0ueYcTlWb35xaoKR
	lkR6MksO5K3N8nrWtKwB/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124060; x=
	1740210460; bh=LbPig9wC+Kb/MDpnGpVL0WY5vLcC6eq7PS1BPhiW/ws=; b=z
	P3dWeQ04wprU50RgnlLBgwT1gWRSGhobw2175EJ3K1Td7nzee4Nfbb0JKnuSlRig
	162Lp05ICJt1pi4GcH2VzI/Nbv1RdfVa720sw6yZg66PwVkSTQLWMU1IgzLeTCNn
	lsWDGfDD+5K/M2iAqCiCPY3hUYgKaeX8/+RsPHfskNprFByBW+/QT/DYj8wIiFuD
	QTJMha4vj3spTAVR08OuYCdKjj7evz3ZK0firwt36uCB9sTgxoIF+uasxX1Tr4eZ
	7eiLXg7ywpC46nHj48sptRcZHMofI9xAbQbDlWtXMEFF5M8xngnDCLUkUGpM4tz2
	oJRS9c1p4eGCQknxgK+gA==
X-ME-Sender: <xms:nC-4Z7O8myZmpbiL1_Gy8o_JYvcBYMGwL67kNFC7v1ZULmNnFV9axA>
    <xme:nC-4Z19G0tJySSw4AfYH8JtDpN8slRxRg6rdxZIAZviDKmBboYkcoi3YN-Dc8nsGr
    bqPmuYR6zsZ17PHNA>
X-ME-Received: <xmr:nC-4Z6SoteeiuAdQ_DJEcjAwXvfS9CxygJa_qx1tcSj7XD9ZH-4FxclCFJ6AkSodkEI9Z1diZhj9ZhII6nG2lNysxRjwvDcfv7daryQ-fsiQXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeefhfeuge
    elheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nC-4Z_uR79EQ6PCF889FGKlluFmCBmZEXUS8oi2toL8AFxO7vY1cRg>
    <xmx:nC-4Zzdu0BnIFM7PPRnUNVJOeTEvOffC951wT5HzDL3LAWpZV3IxXw>
    <xmx:nC-4Z73zXg6djXMLkJj8LMqk7lDicECrM_30cJYVbRWiYExb-3cilA>
    <xmx:nC-4Z_8mQ3jy59Y3FYSFge0fFC603JfkmiueoBK_O8lgxnU32lTlmA>
    <xmx:nC-4Z7HBKvUPZtsmAwiqn8-4DCCtAHuM5juUfi81U-dn8qyoMAKmHQNI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e59ea5ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:34 +0100
Subject: [PATCH 9/9] builtin/cat-file: use bitmaps to efficiently filter by
 object type
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-9-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
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
they also contain one bitmap per object type encodes which object has
what type. So instead of reading through the whole packfile(s), we can
use the bitmaps and iterate through the type-specific bitmap. Typically,
only a subset of packfiles will have a bitmap. But this isn't really
much of a problem: we can use bitmaps when available, and then use the
non-bitmap walk for every packfile that isn't covered by one.

Overall, this leads to quite a significant speedup depending on how many
objects of a certain type exist. The following benchmarks have been
executed in the Chromium repository, which has a 50GB packfile with
almost 25 million objects:

    Benchmark 1: git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter
      Time (mean ± σ):     82.806 s ±  6.363 s    [User: 30.956 s, System: 8.264 s]
      Range (min … max):   73.936 s … 89.690 s    10 runs

    Benchmark 2: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
      Time (mean ± σ):      20.8 ms ±   1.3 ms    [User: 6.1 ms, System: 14.5 ms]
      Range (min … max):    18.2 ms …  23.6 ms    127 runs

    Benchmark 3: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
      Time (mean ± σ):      1.551 s ±  0.008 s    [User: 1.401 s, System: 0.147 s]
      Range (min … max):    1.541 s …  1.566 s    10 runs

    Benchmark 4: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
      Time (mean ± σ):     11.169 s ±  0.046 s    [User: 10.076 s, System: 1.063 s]
      Range (min … max):   11.114 s … 11.245 s    10 runs

    Benchmark 5: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
      Time (mean ± σ):     67.342 s ±  3.368 s    [User: 20.318 s, System: 7.787 s]
      Range (min … max):   62.836 s … 73.618 s    10 runs

    Benchmark 6: git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
      Time (mean ± σ):     13.032 s ±  0.072 s    [User: 11.638 s, System: 1.368 s]
      Range (min … max):   12.960 s … 13.199 s    10 runs

    Summary
      git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tag
       74.75 ± 4.61 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=commit
      538.17 ± 33.17 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=tree
      627.98 ± 38.77 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=blob:none
     3244.93 ± 257.23 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --objects-filter=object:type=blob
     3990.07 ± 392.72 times faster than git cat-file --batch-check --batch-all-objects --unordered --buffer --no-objects-filter

The first benchmark is mostly equivalent in runtime compared to all the
others without the bitmap-optimization introduced in this commit. What
is noticeable in the benchmarks is that we're I/O-bound, not CPU-bound,
as can be seen from the user/system runtimes, which is often way lower
than the overall benchmarked runtime.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 5 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 25d5429e391..9021fd52f30 100644
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
@@ -813,9 +827,40 @@ static void batch_each_object(for_each_object_fn callback,
 		.callback = callback,
 		.payload = _payload,
 	};
+	struct bitmap_index *bitmap = prepare_bitmap_git(the_repository);
+
 	for_each_loose_object(batch_one_object_loose, &payload, 0);
-	for_each_packed_object(the_repository, batch_one_object_packed,
-			       &payload, flags);
+
+	if (bitmap &&
+	    (opt->objects_filter.choice == LOFC_OBJECT_TYPE ||
+	     opt->objects_filter.choice == LOFC_BLOB_NONE)) {
+		struct packed_git *pack;
+
+		if (opt->objects_filter.choice == LOFC_OBJECT_TYPE) {
+			for_each_bitmapped_object(bitmap, opt->objects_filter.object_type,
+						  batch_one_object_bitmapped, &payload);
+		} else {
+			for_each_bitmapped_object(bitmap, OBJ_COMMIT,
+						  batch_one_object_bitmapped, &payload);
+			for_each_bitmapped_object(bitmap, OBJ_TAG,
+						  batch_one_object_bitmapped, &payload);
+			for_each_bitmapped_object(bitmap, OBJ_TREE,
+						  batch_one_object_bitmapped, &payload);
+		}
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
@@ -872,14 +917,14 @@ static int batch_objects(struct batch_options *opt)
 
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
2.48.1.683.gf705b3209c.dirty

