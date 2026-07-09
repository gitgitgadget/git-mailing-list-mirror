Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908D3F12C8
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586187; cv=none; b=nduc0GS2n+vbulRlyp8Bb09o//Bg7kqayp1AJNlVy12sOGE4T1wMZ3YyeZiukqLTTGNdwEBCzoc3MkwGYBOgdLssIlJ4oU+BNPFqoA7nQPEATjDjfWjjP+RLx9g8Vnf+ShMropfTFtzwSM19f6/+aMDnprWlY1SaLiQTSLJdPps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586187; c=relaxed/simple;
	bh=FcIdtsWkd4TYH17OJkLOHc6UxeensAYjEadRWBgxSXI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkEtDQizKLgAg9tpunerQyrZ+2w6b55zV4EvP5iivrRDiUk0HseoWU7SEdc7gllUH7kseBCeLKxbf+MajbU+0VaghdRVivCkxjN8FPKljOI16uTtkwFkSnRcOdg9V/A7YZHsMsOY/U8/CAyZwPrGrPZ8pYvxELb7RA9ZRqG5wQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AjJ2IZ22; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IMXKHNv9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AjJ2IZ22";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IMXKHNv9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 896A11D00067
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:36:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 09 Jul 2026 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783586185;
	 x=1783672585; bh=/y44EspoWuWbqVc/nkmWfriSKTbGPlwquwog3c2xmYo=; b=
	AjJ2IZ222HrBVw3DL+hnKP8DxJ8hlsqrP+3lVd//koJfY+DHp/t2XHrDKFyHmDbm
	nr9UgbfHJXWES5s0fCXuyx72/tR9fk9YXUC4T00/GaK4f7ThkUhoUXTUFLTHFJtM
	as1JKSxhB0GmgDwxKGgtnPBYPjTSJ0PHhJExhF/OKeKM73hUufTJwJ+c/1r5WUC3
	k3LYe7f69pHymlKUvfzdp4DEQ7Pfmpf7z8rWFmZR247azVgQLlfbIYCAjfRhf7jo
	Ah62lfpNn2m+jGU88UxTlOMO931SUnJNqM4Q2SLGU1u42rIM54GQankYFMZt/0AI
	O4vsQpvJElkvq9mmbtCurA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783586185; x=
	1783672585; bh=/y44EspoWuWbqVc/nkmWfriSKTbGPlwquwog3c2xmYo=; b=I
	MXKHNv92ZLl5UI/niEhk5lXjCWWctqCHVGRujJ+gAVA2I0g1FAv/PcHBarffHzgm
	5Y0/10kXq7XZvLdgTJOI/94DVhV7DAouu1FtuPn2oc1Xzp/E4ADBEqHrjuN7zly1
	/dWY+GxLr5fKD8adpYFCW97Qv1eFwvtYYtD8bdoafmffHHDJ0PHY+YpQ9xGJPi0+
	mJ/yHo/NZzube2UE9mTXkpO9s99bcmBfpXhNIyJBdD4f576phonl28U1tXO1N73x
	5LMvllSX7q2JbUHvZoNbefmABW8uQ4PNDwIP7kcLLiWU75MOAwUadlc7m42vjpmZ
	poZfaZZ4Bbx7fO6H5bo3Q==
X-ME-Sender: <xms:iV1PamOng6rmcD9jq3KfbeOyIDSqhDMsKfkcjT15o6O9eE-xhkvtaQ>
    <xme:iV1Par5LVbIe2GaM1qtxqn031S5mtUBlwqy6djGtAHw55-DheZbsj3YEg8K3X2uFC
    -zv80O4BVxPO6j-kAqYtOIHUBvnBrB-cEQqJfcC9csA_pl3JE-J3w>
X-ME-Received: <xmr:iV1Pai5fqKNYTfR-Na0aen2x1ZOt8Nq_d5iqKxnWx0AoO0ClCtzDS2C0yi4mTmHqAdzgYGXZ8wgcaaLsHCfYni_uZiDD8GWea3yCJ_gKUw>
X-ME-Proxy-Cause: dmFkZTERAXgz+jqx7twuzqzZZWwinz5BYbUmZ3g1Gxq66qFgrU2diQmTj79Ode2lApTOyX
    aoUComxu4uH6Q83MWcPPg+06UkVBNZaiAkR45rwnGwZsZJciVEfPqNeRiz1fUEsAKoGEJZ
    aOizjiaGw7vG6Z2P9l6B3KT0VTEXEW17JykLl1ZuYjHiEbpljCDiAL4+3iNb6KXB4vE0Jo
    qe5tHesWOlhA1OQ8lmwgo/9fTdQOeEnLkrU/fC2BxSvTY3i5pBl0dz+XE0Knlvr3DCbMs1
    RKH13xRrIkwnZxjdcEpFbSYxGLuZCgehtwm6NAiy7a3IaxQeldU1FaBBBUfXVnsHr+OZMY
    9/oS42yOpf06xUfwD2iwHEHK4QjqKbNOWH8kombvtJCa+3sJCvY5DITRTrGVd8VD2ie4Oy
    Dq/Bk+uumlwXYfMqf/cEc/0ZGhuQlKT8JuKZriy8AAl6RZElRVRRw1WbbCc2ATuHnwpVqk
    AALk2pxbbdvrXLPWMKf/qlbUI2aUaJHtz1vc5eiBSYtDM5gT3TAMOLUrWnMWx5In1AREIT
    nS1b7jr48iPMBXQVJ4EwpXtgMNzSuScDoHtGmt1Auo9XI4zsoaZncuoVMGBp0YrJtKsZ8O
    XI9nEpDfdL9l3JpfUKMIPkO7JNxWaLW81ECpUpP+qHXFulYnZ8NOIidxLIJQ
X-ME-Proxy: <xmx:iV1Par1bEf9aVqXYcy7y9y8UUTbt_GJhb7HVSe1RGv6K6-gUIuROhQ>
    <xmx:iV1PauXSMEzo5UEVRxKBdJ7HoCsJu7rBez6EaIVSR0P4VHnj3kOVNg>
    <xmx:iV1Pam52ChFg4PlP3nCsqgm4q5DQxMXQetUcruxOQ1z0FZIMiofCYw>
    <xmx:iV1PalJKQkibDnA-Sai8UhCEIgVV1nBAWB69lKcGNdVINvyWd5ngNQ>
    <xmx:iV1Pam8UuLk8l1KAYSq4UaU-Hg30okqRZd1O2GBxhJWlks5hZffjzVGz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:36:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98ebd30f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:36:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:35:26 +0200
Subject: [PATCH 6/7] odb: introduce object filters to
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-odb-for-each-object-filter-v1-6-82fe014b12b3@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
In-Reply-To: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 5d2af96e2f..ac9da9545f 100644
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
2.55.0.175.ge4962bd3d5.dirty

