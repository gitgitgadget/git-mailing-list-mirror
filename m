Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD3643C07E
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953715; cv=none; b=aq1qRJ2XvqWLnevYmKx9rIsVs0MrYzuIzCj47cKNdebUqLYqgwD/QUUNiGcZTabSGcbmehCzk1UoBYfNTNGhufYkdHNrcqcpwJUPhvuhHuSSq9oFUiPir1/xqFvXCsTKMf2A7kVCkHfd2c6rRNTFgp2RDUl3RoT26sFBhuGQIQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953715; c=relaxed/simple;
	bh=URd7NUetNXCkfyOsr5kpbwVmJZz3ATWm9YiwPVgrTlU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UMJCZ7AuUw2cCLXCe2YHzJ2iQU8x4fWgUsWsF02NVLmLyR0yswILtSEo5ljdaboSDjiGJTaPyfBQIxOKLTtuJ5Fe5nypZFq3tdPrHxZHmfVIFvRrjHB11o8ojk736HAHPAiP6oXgnJH/eC9Dws1Eg4DF9FhFBsj6S6EpcYXubLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eWwrCBvo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oqndfdHs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eWwrCBvo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oqndfdHs"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 79A967A00DA;
	Mon, 13 Jul 2026 10:41:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 10:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783953712;
	 x=1784040112; bh=8cQKbIu1LnJh/FswRtSSt28ZYLM0wvnZ/VT/qpzd/9k=; b=
	eWwrCBvopJMHOeMZNbRRXyDH99t/rwA1KO3WKBmmlpTgzM/sMRgPi9BRYUAv1r2P
	w0KDfwxRhx+los/3o4X2hYiyqnlFnFvWiSDByT5kr5ihbXsqKa2NsxEtV6dBwDQB
	tmS+D0vS9Ft9mVmSrOT7GJBEne2WnI29wx3VN5KLtcZlHf/VpkKQBzkzRVk4Qctu
	U/OXh8uTxJ2u3lzCmPDS8GJTAeD2keL1FQL7gsh7Nhk8+sDCwpg+OgnpgAPACo5U
	v8dCup9/JuZNdEkjP8mnm6K2cF5QL2vTjGfKlWXhqam8ARA/r2/3HWvCvI6+MV8r
	xvZWhAQ+Pi9PeZNd2ICdvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783953712; x=
	1784040112; bh=8cQKbIu1LnJh/FswRtSSt28ZYLM0wvnZ/VT/qpzd/9k=; b=o
	qndfdHs0Ou/1q3oRfYI2pxHxalayiAtRbxo4IXfIb74pwCJHvpogcAB8kiF7FpFt
	nKtWFMqwHUEjcRsF13k3KxPNoHxEt7BdjueEAkIXJhT7HQZlO+xaZMHNbJrOw1Z4
	VFf8rHG5xhkP5GINIsjQL0oykacdKq+UDJ1KiUzLDdRj9Fuu8ZePzc9C4jGBncU5
	WygTrCTOF8aN9c+fDFVuhQVL1wo1HcNX3PoXM6szGNgVSY4NLUy9/cY+m4r6wuZZ
	qpdo42j1gbGshHuvZg5XlI4u15nvGf+qfoJ8gRQWsQCZkIcd+eGRo4pVRVpraUSJ
	jDoVlKmRtxpyXrrsISojg==
X-ME-Sender: <xms:MPlUatGeH894y8Lb7KJ-s-8MCB7w1PaoieAImIkmz1slg_UhuVsMLg>
    <xme:MPlUapNL_1oJTd1cjN58vq2tPDdP0QnfoQDJqfsaRig3FLw0AsSFN5QaeHS1PbgYg
    7G_0U74UuMQggs_dkyNUAwo2YFhZANNcF_q8Sh7wR1Kc2YWsT0b_g>
X-ME-Received: <xmr:MPlUanfSL-WadXPSOjKk2zXwHCqJwrpGNdYq58PlTHt2YWKRCSEJNZhJB_FQa1I7bgGaMYa8F4UszKkllKkDfEnnM0K7E54pSm8nFJcQ>
X-ME-Proxy-Cause: dmFkZTEyUfeo+nFVwKGye+0k1jIsu36Yy7Ivqapi3smNK0zISSOUmCDeqV89h5/hLAk9Jm
    dCVQkHqrb51YByvUYzhhLo4X4y63WYedE4fMYjiPPkroRb5pB5CgWqru+Xaz9lpnQCZwQ/
    6NBTpYvRSXJiLwAqRxtb5lupBGYdRPxvxBb6gJ1lugtUXaTwKKTSZCYxgQb+r8FvXOOO0g
    WYNbDRc4o7hMJVl5TLOs1utbYjaz8vUJyTM0j2dAU+lrbFcaUHongdN2PwmqlIri44Sm1T
    4IacYbYUepbjqQhLVLee6OBohQQaoHzaj3iOLAKl4fEVf2bp/F5dy+o16s4bD3VYN5DHZH
    MFp7JBy+P31gZBztIznXAVNlPRDxo6mn4V//hh+vg0X2aXrsxpKNPUUY5P+RCg08PJQJIK
    gxcdt4n17VaEkK74tpV0UauquJNtwJ+3zlrGD0kNxPyO48UbWJNwimBQEWch85NFs8meff
    7J90hYKFh44CSfJ8IqciRsApseQpy4l7qpf2smwXCRtFuSlS9vVOfaYD+PG3mfnrdAbpAS
    2lgmQL4dbupLexUeK42MfVcOwtRdDIy4Ye4pZ7YiTvYOKKGptcKvECLXg/+bbrvb2lfpFB
    kwUYpXB8QwMOMpEDLz2KI6IIqhNyY7188hxAK8Nd3FOj/dhGaCqcAsn27fMQ
X-ME-Proxy: <xmx:MPlUauuwyEnK51usEsJyzzBF5jvR_h6af4xz1CdT9u9zAj6igib4rg>
    <xmx:MPlUagkzINEZaiklzya-YNRImppTpi_kyBQq2JfPgdbSE7auVD4IuA>
    <xmx:MPlUaowq2NauXMlxyFbWNSS0909e-PsBdLtzyP-a5eleaGJhUxhxVg>
    <xmx:MPlUaqMtjafl1MKM8BWgB4UdEwlnDDwi-n_7NAWx0afBRKEDpdAOzQ>
    <xmx:MPlUapDYoVYqhRl6Z1vKVF5Ut23-o8rtbdKSnQcykqX49N9eEPAMuOV5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 10:41:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb20e1cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 14:41:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 16:41:32 +0200
Subject: [PATCH v3 8/9] odb: introduce object filters to
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-pks-odb-for-each-object-filter-v3-8-b3c65c641073@pks.im>
References: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
In-Reply-To: <20260713-pks-odb-for-each-object-filter-v3-0-b3c65c641073@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, Taylor Blau <ttaylorr@openai.com>
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
function `prepare_source_bitmap_git()` to open the bitmap: as the
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

