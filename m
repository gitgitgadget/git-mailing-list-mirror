Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2EB38910E
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783673367; cv=none; b=RRG8rEfPbbL8HJWKaHOiaYXEpcJnbJVq10wFBX90Qx5KKLFYUelbkkjyMnnQAQyIkJjASj0052brUkto4vWYL9xxEEqtjHSs+EINIHPSFFSb8OHVTnJBw16oPzfOTzRfAZB6suraljmdEAEq55hfvjZnDd53oMdT5mtnE7/X9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783673367; c=relaxed/simple;
	bh=GJCOKl0oWkakBR9n57QvitCLtI82eaRvacx46ZAnQ3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tQ73X0h/w6vq5r3PhaheMb4RNBUEUoxIQq9xXVP8u5qXuSv1nuN7kQBfx78gnIOMMT1ADeaBunArSeDy9u85WxgiemhdcauXX4YQaf4bLAqxGJy93i/rlO2acS0TRBfT7VqA4LvfHpRgivXwA9s5KKWXyU6dk/pNr62MoaOvxwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CY9+qV8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cx3yN7tO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CY9+qV8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cx3yN7tO"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 695CCEC0112;
	Fri, 10 Jul 2026 04:49:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 04:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783673364;
	 x=1783759764; bh=AMoglJYXrZFOTH52DITK2EnwvKmtNMDRxkGUemEnoVo=; b=
	CY9+qV8khGTUTTyEK/9NpWw12snNUqfdkUWxq2YS7digcE6cvItJJk1beKxe1h02
	oVLrZbKwYZtsBLJ6H/BpIzc8k3gdDLnNrnD6Up2rGa+RtraEKO2c8Og4yisGcxaG
	sLS12UHjpVcrB5T4WrkofgUJ/Jg5/evQZxhCBmY3v24QSL/mIpct1jRn+c6CIcxj
	FqRGZl61JeR8XFDb5RxXHgLlKmfXALVp/Ej2bdKrsWdca0kO0kn2XP5DvQV5VT2H
	tDIFBebZrcIjyHeMVxzYzbSFQ8fefVhuzxpwp1Uht9soxbtmr7gx+yWBh/jDaURP
	k5KnXQ3X3i7bLPO6tHFc5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783673364; x=
	1783759764; bh=AMoglJYXrZFOTH52DITK2EnwvKmtNMDRxkGUemEnoVo=; b=C
	x3yN7tOns06pm2qcRij9YqYLHqbHoGDLj4hJJ3AaqjR4e7iKP9Nx3ChxKjLHj6HV
	bQxnBffAXgqcpt0550wW5Xyn2dnJvSMo+//cmxdFeCjpDIS+8MzQcRqDrIBo2EIr
	tScMGxYBFp6Ti5G/8/V42iUxvATVCvfca5S6Q1c8NBKSPydDbklQqOXVDkgVkHmt
	QtPyf2seg7nHgQ7NcfOBSXHk2XsITBSrhMUODjLDq9cHgthLN5pN94nrazD9Coon
	3wRtEP577cKEaJBTqfwkQV+b+PU+LxoUBxu1e3W59XTsMFy4VvREkj7rtCyjNsmd
	QTvEWGJA+mzbivtAmOWBw==
X-ME-Sender: <xms:FLJQamMbhsk-iMggPXVAx0pmOwL8huIBEcxLU3gip8HqFqJmJZOAGg>
    <xme:FLJQasaSyhVWSDX7feq0jd1c7-yEgm5so0VOx6M-TtD6LHBcBJiYEziwXzsBXVx0n
    nA3g_trP2WPyxak5y9tQxs3LDOfE_tslayjQxXbAK2iCoJf8HI>
X-ME-Received: <xmr:FLJQaqpqJH7XyH6UHwzeb7PY3WhLQDevpQc-5adLUOrUiu-aP1AEjwZ4EGwnMNeH2SpYrxla6qpogmU3SDD7a67jEZinqmXmdmoLKp0L7IkR6A>
X-ME-Proxy-Cause: dmFkZTF4Ax4MwJ4hl6AAre2a7MzkopWuOn7hsXFT0jb8UXIULZLoVDJ2NNJ6fxNt00vy0/
    8/Pk1Jo702eKIDP/Y3BAL3xdIR50I6XQxyN45wkEWgPwmqA+v+zcxhazideEmKF8rD7D+n
    ySDgA3L6uiMSVAXDUVpxFxC9bBa6pD6QNi33TzOrkwk2p8Jy3jw8zHKQ/E9QVLoBLatL58
    mequ/qdelGKzzbi9Pnf2N/SoSFCbGwKjnTMbMeFKLnkVWltJHUbCow0r6k58XPZBXtgW6f
    RtSZLK0vhCrqsPTxt9uGccoOIQ1vdTsj3dhI1Ppdr6JOd0LBBK3RiK+LgiuQof2zNGe+bz
    j6e1PmjQiiAeqxn3gN1XMyu1uv3QQSC/iJhP5iyU3zq5MBqVWRbYjE8HtMsTw7hV/1C+Sh
    aPQFoJ7EGj7Ry5vI3zJ14f8Dvse1qkRtbJK3vGIeYDNq9DhXu5pEIz8ud2MmCPrVpGDvm0
    /TKYCw2ZaWsHJnSYWNHtH00AKt1pu5vW6gNJsZu2eV9wqNND41hfipkj8o22DTL24zYQp6
    XyIQgUYzohI/aOozQRw+jNBatRQlqOK1C4mXAkxxyvIb9m40GbHCeLuVKfd/Oi/BHOH+6W
    VuvQ2NHbKOwoya1jTwOVZSMo1TZIoDQ22/eAzolwkfGctM+GQYECQ4o9OWRw
X-ME-Proxy: <xmx:FLJQagaq2BZ-W8DZXaIcd6wwnA_AQ_bhVG1_zb92iQ816h-Iocip4g>
    <xmx:FLJQaiRE676OAS03Sy08M-FMj2wXsdFwl69Ze9bYglTVVIpVcl9idQ>
    <xmx:FLJQan7cJb0teBQnIknF6DzQQ5LTIkNgZG7hSQqwGQd3gZtWAity4A>
    <xmx:FLJQanwfM4P6pfJVvM7zIVktBj089xnveHjWXMXHsaOpsJ-fxVqTuA>
    <xmx:FLJQarQXn9f_hoydzUV89i4AkFatoJPtcBUU9HLo43UKB12po7743q5m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 04:49:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54938961 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 08:49:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jul 2026 10:48:59 +0200
Subject: [PATCH v2 7/8] odb: introduce object filters to
 `odb_for_each_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-pks-odb-for-each-object-filter-v2-7-3710a9cc165a@pks.im>
References: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
In-Reply-To: <20260710-pks-odb-for-each-object-filter-v2-0-3710a9cc165a@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.55.0.229.g6434b31f56.dirty

