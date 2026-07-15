Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC8C311C35
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096581; cv=none; b=iHn+NI3yu8evKTrn+B8yMqLbCfbBG7fzCqdYjh3yI+zw7zrz/GbiKWrfAzxOrD9arONMMVmMOQ21AdUdBj1cwNOAXR1NFk1qz74NUGDQPFLxyTlE3IV3OsJDYgDcWSaJd2ZRc8/u7gDywoFDumaZiEq4rwVHNBCk9/m7c9x89GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096581; c=relaxed/simple;
	bh=MFGRcc7qOAJik/zCOlTunMmC/P4gnzjsRbSNrlv1EY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jex6WVozqyR2/imZpOY8UbKXDMTKU2V8bkAjb0IrPk8e9iq2gkSfNs5ti9H+SAmD3dPlybT2sEqMGm79a2cNo9qNeu/3NthrCPny5dBsR+Ccp0ZVaBrA4mfNzIzxHuV30NY54HRg1w/O7IgWfLu8pwWXYCLABHigOJsux+ezH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ptp+eDs+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NH1e4c3/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ptp+eDs+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NH1e4c3/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F04347A013B;
	Wed, 15 Jul 2026 02:22:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 02:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784096578;
	 x=1784182978; bh=iDEamwJKxikHtvvuoyXhCBDbKzR7zemyj74XrtmlUMA=; b=
	Ptp+eDs+hG2CdMIRL8mQvV6V8t7N4lWnKUo/YM6vTpcVVsi3tdV3sNu1/QTjP3Wq
	d7gFQUThyk4yLNxFKzNrY/SC4qNkSYIqg2FxI4mnjfjFm2eXe4dYR3n1kJWBCsyr
	U0Mn/3GmOgz2iPwIPsJBDHjKnE1AdWsTs1lfO4yIvxAfy0ICvEuRpBZRfP0R4j06
	7P6cnv1iSKJNS8C5/YAZa437jU92oWS1ZrlmCpd/8mryp2fANVxpP2XFH+cHpqr9
	GwJEiNu96kK+uV3dWGFqraQ9SPs0M14GfUCoJ6mgq8Hw81w1X4Ol4QQnNneu+6/9
	o3nZmdWoGO/Tr2vGxWZ4GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784096578; x=
	1784182978; bh=iDEamwJKxikHtvvuoyXhCBDbKzR7zemyj74XrtmlUMA=; b=N
	H1e4c3/CrDmJpvBOcXrPenjI24jpRqHx/9XunFnLfmuW3PYyi8xHdpqyv+n36eRw
	7pOmS0zimJHkU/coPLFCC1Rc6D3y1CuyfNSHO9no129pVHMnwMZA8jEvl5naClmd
	Xvo/BBSy/8H30nG+7lQyFZDAcsIgKBey+9wbsmevEXholbVCWS3s6rj3HR2GcvZ+
	DIO1trN0QC+78lsNF3nd8kddr9lKYm2pGgmwema+871cXbA4w9cyE+MS2A7LXfeC
	nz9JT8OAZnNQO1brOfOy3EYhcr8WfGBiaVWnBYSkny+ZFKmD95QjjSs/YNnwCkSj
	7F3BMFrxn9lUhmACu4JWA==
X-ME-Sender: <xms:QidXaj2uMq0LVAHgrrl__Yp-zXZde-V-HvD-YCcTBhyl6IJdhRXoCA>
    <xme:QidXalw_zMR0OXBLzSSCLIiXqbRhFJhwEzV3fRnP99Dw2wFgiCsRXu4vfAIwsSkNB
    tjZ1rNqDivfOzMnvDzLt37rigWoh_59ljWTtsH8lnzlbnpTRzHCWQ>
X-ME-Received: <xmr:QidXatv8dsWoRDs5VNn-MPbm0hKnGDQYCOkHbYawR5j79aFa29Xq1ocznmSlrwAnfGqw5vGU89AD3wEiCXZwWr2zoLJsE_D-zxZG1IPNLGU>
X-ME-Proxy-Cause: dmFkZTEH99AV7eEZSs2OrOj8lIdDEmZ++yUrgwG/3l15NJxWw1X9JW1nKaJkUzGZD5Drwb
    NxKZLdfzpfYhiQ5kLvu4XK6nj8cp1osIJSWmS+X0U63O7I5s05fepgAyrAhTwH/Kxx2zRZ
    kbGcZaIk8JtfvvT7jn+zW27xywc/mpV2/V95rEUYF5fFy9FxW/ag9TztQM7IS7UFltfPp7
    ToxrHdgvRq480ekyPulhgsam/R7QRbX5xGsJ0sMTbs3w9GmR+sEG6IP0nkOJa+epbNCxLH
    vs4EzRh2Ec+nzmQaryBOMVj1DXK65yl/4QArGIQ35NWqYXAYpkAfDDi6DHWsNAraoLprrL
    yAmuxbBmjIQYCGpy3ZGy2aX6HAwHuMdYRKd1/R6c9iYbixp4nA7ob+PHhdi5/4lxx1bWx5
    nn+xLBCLWrtbrkynbAJfgMjQu5lCvxqPoevvjPNdaJgLn5o2xGn7OgsnOficxMSK0UW+9x
    TfmEv03rr1NT/jgkcBnbwh2lXTktRD8HhpsJ+QN2dtOxtGHdW28/yUBY1jUAFlRaL8+eW1
    hymY54YDW+JCFAcnhepsUmG82D0XVf3rFxF18gxGpY25CeVdR5qOzUfe0ZZysjtsiDmzNO
    0PWGeVlvA+CHHGtOz4nVTwWEWpVytcUPf6Z8p63kO2B4L7mYWi9OXZOnH9Ig
X-ME-Proxy: <xmx:QidXavzap-LeDbOwKry9Y2CEhwhwF07e95M_QBvYMNQtj6lmEw0Kfw>
    <xmx:QidXaoB0_B6iICkzZyvXDIN6cW5_prcm5U1As0XJnV9PiMZox5MVGQ>
    <xmx:QidXale5WPcMRaapITTnPAPWWN5a1EryZAi7q-jJi0J20l-cIVYWzg>
    <xmx:QidXaqmKh2Py-jSycpG5c3foloSO7tVK1ad32ht3bj1rcc73wbP4Hg>
    <xmx:QidXams5OTYNDA6Q_7UuUSbUaUT_yrSJRG7Di7AJRaPwit4F9TjAMBgr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 02:22:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9a810041 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jul 2026 06:22:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Jul 2026 08:22:38 +0200
Subject: [PATCH v4 8/9] odb: introduce object filters to
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-pks-odb-for-each-object-filter-v4-8-616d7adf7fb7@pks.im>
References: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
In-Reply-To: <20260715-pks-odb-for-each-object-filter-v4-0-616d7adf7fb7@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The function `for_each_bitmapped_object()` can be used to iterate
through all objects covered by a bitmap. The benefit of this function is
that it allows the caller to efficiently handle some object filters. For
example, this can be used to filter out objects of a specific type with
some simple bitmap operations. But callers are currently required to
manually wire up the use of bitmaps though, and to do so they have to
reach into internals of a given object database source.

Introduce a new `struct odb_for_each_object_options::filter` field so
that the interface becomes generic. When set, then a backend may
optionally use the filter to skip some objects that it would have
otherwise yielded.

Note that the respective backends are free to ignore this field if they
cannot meaningfully optimize for a given filter, and consequently
callers need to verify whether they actually want the returned objects.
While annoying, we cannot easily lift this restriction anyway as the
object filter infrastructure supports some filters that cannot be
answered by the object database alone.

An alternative might be to limit the filters to only those that _can_ be
answered by backends. But ultimately, the filters that can be answered
efficiently by the "packed" backend are completely disjunct from those
that can be answered by the "loose" backend, and consequently the set of
filters supported by all backends would be empty. Furthermore, it would
require us to make assumptions about capabilities of future backends,
which may be able to efficiently handle more filters than current ones.
So in the end, this alternative would only limit us artificially.

Implement the logic for the "packed" source. Note that we use the new
function `prepare_bitmap_git_for_source()` to open the bitmap: as the
backend operates on a single object source, we must only use bitmaps
that belong to that specific source. Otherwise we might yield objects
that are not part of the source at all, and with multiple sources we
would enumerate the same bitmap once per source.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.h               | 12 +++++++++++
 odb/source-packed.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.c       |  3 +--
 pack-bitmap.h       |  3 +++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/odb.h b/odb.h
index a1e222f605..67d0b34942 100644
--- a/odb.h
+++ b/odb.h
@@ -8,6 +8,7 @@
 #include "thread-utils.h"
 
 struct cached_object_entry;
+struct list_objects_filter_options;
 struct odb_source_inmemory;
 struct packed_git;
 struct repository;
@@ -490,6 +491,17 @@ struct odb_for_each_object_options {
 	 */
 	const struct object_id *prefix;
 	size_t prefix_hex_len;
+
+	/*
+	 * Optional object filter that allows backends to skip yielding
+	 * objects that are excluded by the filter as an optimization. The
+	 * filter is a best-effort hint: backends may use it to skip
+	 * excluded objects (e.g. by consulting a reachability bitmap), but
+	 * are also free to ignore it entirely and yield every object. As a
+	 * consequence, callers must re-apply the filter on yielded objects
+	 * if they require strict filtering semantics.
+	 */
+	const struct list_objects_filter_options *filter;
 };
 
 /*
diff --git a/odb/source-packed.c b/odb/source-packed.c
index 9cfa02b7a2..4777395053 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -3,11 +3,13 @@
 #include "chdir-notify.h"
 #include "dir.h"
 #include "git-zlib.h"
+#include "list-objects-filter-options.h"
 #include "mergesort.h"
 #include "midx.h"
 #include "odb/source-packed.h"
 #include "odb/streaming.h"
 #include "packfile.h"
+#include "pack-bitmap.h"
 
 static int find_pack_entry(struct odb_source_packed *store,
 			   const struct object_id *oid,
@@ -315,6 +317,37 @@ static int odb_source_packed_for_each_prefixed_object(
 	return ret;
 }
 
+struct bitmapped_for_each_object_data {
+	struct odb_source_packed *packed;
+	const struct object_info *request;
+	const struct odb_for_each_object_options *opts;
+	odb_for_each_object_cb cb;
+	void *cb_data;
+};
+
+static int bitmapped_for_each_object(const struct object_id *oid,
+				     enum object_type type UNUSED,
+				     int flags UNUSED,
+				     uint32_t hash UNUSED,
+				     struct packed_git *pack,
+				     off_t offset,
+				     void *cb_data)
+{
+	struct bitmapped_for_each_object_data *data = cb_data;
+
+	if (should_exclude_pack(pack, data->opts->flags))
+		return 0;
+
+	if (data->request) {
+		struct object_info oi = *data->request;
+		if (packed_object_info(data->packed, pack, offset, &oi) < 0)
+			return -1;
+		return data->cb(oid, &oi, data->cb_data);
+	}
+
+	return data->cb(oid, NULL, data->cb_data);
+}
+
 static int odb_source_packed_for_each_object(struct odb_source *source,
 					     const struct object_info *request,
 					     odb_for_each_object_cb cb,
@@ -328,12 +361,33 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 		.cb = cb,
 		.cb_data = cb_data,
 	};
+	struct bitmap_index *bitmap = NULL;
 	struct packfile_list_entry *e;
 	int pack_errors = 0, ret;
 
 	if (opts->prefix)
 		return odb_source_packed_for_each_prefixed_object(packed, opts, &data);
 
+	if (opts->filter &&
+	    opts->filter->choice != LOFC_DISABLED &&
+	    can_filter_bitmap(opts->filter))
+		bitmap = prepare_bitmap_git_for_source(packed);
+	if (bitmap) {
+		struct bitmapped_for_each_object_data bitmap_data = {
+			.packed = packed,
+			.request = request,
+			.opts = opts,
+			.cb = cb,
+			.cb_data = cb_data,
+		};
+
+		ret = for_each_bitmapped_object(bitmap, opts->filter,
+						bitmapped_for_each_object,
+						&bitmap_data);
+		if (ret)
+			goto out;
+	}
+
 	packed->skip_mru_updates = true;
 
 	for (e = packfile_store_get_packs(packed); e; e = e->next) {
@@ -342,6 +396,13 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 		if (should_exclude_pack(p, opts->flags))
 			continue;
 
+		/*
+		 * Objects covered by the bitmap have already been yielded
+		 * above; skip them here to avoid duplicates.
+		 */
+		if (bitmap && bitmap_index_contains_pack(bitmap, p))
+			continue;
+
 		if (open_pack_index(p)) {
 			pack_errors = 1;
 			continue;
@@ -357,6 +418,7 @@ static int odb_source_packed_for_each_object(struct odb_source *source,
 
 out:
 	packed->skip_mru_updates = false;
+	free_bitmap_index(bitmap);
 
 	if (!ret && pack_errors)
 		ret = -1;
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 09ba15d26b..f55a0859ea 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2039,12 +2039,11 @@ static int filter_bitmap(struct bitmap_index *bitmap_git,
 	return -1;
 }
 
-static int can_filter_bitmap(const struct list_objects_filter_options *filter)
+bool can_filter_bitmap(const struct list_objects_filter_options *filter)
 {
 	return !filter_bitmap(NULL, NULL, NULL, filter);
 }
 
-
 static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
 					      struct bitmap *result)
 {
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 9f20fb6e56..1385027c1f 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -92,6 +92,9 @@ int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
 
 struct list_objects_filter_options;
 
+/* Check whether the filter can be computed via the bitmap. */
+bool can_filter_bitmap(const struct list_objects_filter_options *filter);
+
 /*
  * Filter bitmapped objects and iterate through all resulting objects,
  * executing `show_reach` for each of them. Returns `-1` in case the filter is

-- 
2.55.0.313.g8d093f411d.dirty

