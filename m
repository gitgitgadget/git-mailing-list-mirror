Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9087241F5CB
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208579; cv=none; b=dApeYsW9NDTLmwT/u60ngXE2jqGj0x0euMOZWLEE0Y9cUQQdSUvmo9JW/0hLbky0VejDj1XknXmo714lhbQq5Wh3fpUYWuVBYIYJ/yGERsEaGt/8Qx70IJVZZnkAznlwvJuqNk3ceuu81kRXYohKD+/Jr68AVo9eJUCfpaBJSE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208579; c=relaxed/simple;
	bh=x4t/r5n/Od95WLtKHdmwUPLPzbRX91u9fXGhnqXjQHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KMy+qNJIiZJToIM0MusmDaMnhAAzLGJ3N+RBYoaABJqcBqofBabMKN6xnC7UKVisikNZIHEvLRN+V8Ka3yUy6pIBxH5ekt2I5W5Z7m/600l7bBLiOCKpHe94l3JuJu/0MIcm848qu4tfT68FCrVPf4zvO3dv71aSqGZkg9XVa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVMckjas; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVMckjas"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca12086c06eso5568029a12.0
        for <git@vger.kernel.org>; Thu, 16 Jul 2026 06:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784208578; x=1784813378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzbM5wGSkR4TqvEejDSqM/JZ/pmdZ/RCDFdv7kmzGGQ=;
        b=VVMckjasmcs5UCxQjPtroYC3KSXMhcwbrYv4msJ3qmqIy7fke97kASFqGRiksmOz70
         BQKU6b64tHOPtgWVBi0NXPGiuyePuwE3IqzacBzn8+Do8tkcdmgxgfA6PRyHuVPLGr8V
         Ve9Emc3wjNRgFciYZoclqtRwFWvXlgQcIxeTGmqk9QuYEip1b6ywC2xtfng54+tzJvzg
         rj25E+ZdpB+Z2KY4xRdk+Z2HlSMO0VjotVWR0OC+7ew95216wBfFGZoVXfyB9FjiP8Xf
         47xvf2adDGwXeSsSc00s6Q1/K/29cNSL5BP8g4V8bIzFwE2w4TsVm4jgKAZf2GcOZUgh
         BC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784208578; x=1784813378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dzbM5wGSkR4TqvEejDSqM/JZ/pmdZ/RCDFdv7kmzGGQ=;
        b=VUv6+eVza6Fz8gM+LQ73ENkSpdd49bHyJCHOpvj7eLc2O0fLN+dWgAgjzIV91FwbMf
         hl6qZ18Txmp+d6WL3Q/0MysIV+DZglTUeWU4FoYodgg1EQ9NCHz7jT1d2JX2Sxk+P2Og
         J5/fsGSp1D/tPx5Fy7Dp0iaYdcZwyJrbFbVkXKcUAEb6Ak3uHr6hmDMkEt/K+GcMKHEu
         bYd4sUa9fvS34+vxDLkGvnmiMwwmj4X6WjIVOAy6fM5EBRwW64WNcHgxwKQumX6+7Ahr
         RueuBECnwiG/C8nsYUlSiwxXpS9GLHBm6ACXenvDjmJWz8yDu/UGdtvaSpUFZuTfqf9K
         XHUg==
X-Gm-Message-State: AOJu0YyV8gz0ZPTU3+CVBg8yD4RO2iuGGPHPEDA88BtFxFBM3jTtd/xl
	+pydNvd/ohjXZ2MWkZ8KXvQpVzjo3bhlBpvhXJ9Ee/PCItUsU/FPHogwx2ree3ZG
X-Gm-Gg: AfdE7ckyGnEoVQZO+weq/DVjceXbXNSDWdE7aPCpvEcSNhse+3gaR3LAjh+bNEexhtd
	aXaQOhK/2VLzd5Qsx6/z/E+W+0OjEVujZIOw7Sfaxxd+j+/qhyxJpTU/0dIfofuomdS/SQHxFqu
	trcu6kHe+oC0GLaEH/0KKlfpUcxXDkJuBNpJCSGPF9K1zYv5Wu9b5+w4CdVwxq6xnOYk5R9DuwL
	B4CQYFNqp/PnuVH5z9wfsgzLpQ+5bT0n5Lbfs1EOkFwS8pZvFIJrKgxCJREKOTz3IkJ8i3s8Pr7
	ya8fH1YMJs9colG5oedlHVsMoOsWnN7trCcsbPJ4vqz9QTWNhzjZxd9MHlh8cfYCtZ2RUx0ElFH
	sogbnrLRKFTxeUkYKrp9ZEVnOvlgqktSDfgu0YPgHvBIQvA5aYYHGOCPrgJf5bUY8HMY532/bMq
	1FbqM22RRHJdtp/esO+dWRuk+cBf//VAefJDf6OD1P+o34thNJnt/0SY4aRbsNNpQ+/41ViuaaP
	x6DX+YQO1mEYHiFGY7qveugIk3MYOfW5YA2syJmdjKJ
X-Received: by 2002:a05:6300:2293:b0:3bf:5539:f93 with SMTP id adf61e73a8af0-3c36c34e851mr8145668637.38.1784208577850;
        Thu, 16 Jul 2026 06:29:37 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:88fb:4543:3010:936c:4da8:7aa1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fcd31sm13291188eec.4.2026.07.16.06.29.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Jul 2026 06:29:37 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [RFC PATCH 4/7] builtin/repack: enumerate promisor blobs for --drop-filtered
Date: Thu, 16 Jul 2026 18:58:45 +0530
Message-ID: <20260716132848.95982-5-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add enumeration logic for --drop-filtered. In --dry-run mode, print
the OIDs of locally-held promisor blobs that exceed the filter
threshold, as candidates for removal.

Reading from write_filtered_pack() cannot work for partial clones.
git repack routes promisor objects through a separate path:
repack_promisor_objects() repacks them first, and the main
pack-objects run uses --exclude-promisor-objects. By the time
write_filtered_pack() runs, the promisor blobs are already consumed by
the main pack. The filtered pack is always empty on a partial clone.

Instead, walk promisor objects directly via odb_for_each_object() with
ODB_FOR_EACH_OBJECT_PROMISOR_ONLY, collecting all promisor blobs into
an oidset. The blobs exceeding the filter threshold are then selected
using list_objects_filter__filter_oidset().

Every object enumerated this way is a promisor object by construction,
so it is guaranteed to be recoverable from the promisor remote and is
safe to drop. No separate is_promisor_object() check is needed.

OBJECT_INFO_SKIP_FETCH_OBJECT is passed to every object info query so
enumeration never triggers a lazy fetch.

Deletion of the enumerated objects, together with the required
promisor-remote verification, will be added separately.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c  | 41 ++++++++++++++-------
 repack-filtered.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++
 repack.h          |  4 +++
 3 files changed, 124 insertions(+), 13 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 433b2c8205..c2b07477d2 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -590,19 +590,34 @@ int cmd_repack(int argc,
 	}
 
 	if (po_args.filter_options.choice) {
-		struct write_pack_opts opts = {
-			.po_args = &po_args,
-			.destination = filter_to,
-			.packdir = packdir,
-			.packtmp = packtmp,
-		};
-
-		if (!opts.destination)
-			opts.destination = packtmp;
-
-		ret = write_filtered_pack(&opts, &existing, &names);
-		if (ret)
-			goto cleanup;
+		if (drop_filtered) {
+			/*
+			 * Enumerate promisor objects directly rather than
+			 * going through write_filtered_pack(). The filter
+			 * machinery cannot see promisor objects because
+			 * repack_promisor_objects() handles them separately
+			 * before the filter runs.
+			 */
+			ret = enumerate_promisor_blobs(repo,
+					&po_args.filter_options,
+					dry_run);
+			if (ret)
+				goto cleanup;
+		} else {
+			struct write_pack_opts opts = {
+				.po_args = &po_args,
+				.destination = filter_to,
+				.packdir = packdir,
+				.packtmp = packtmp,
+			};
+
+			if (!opts.destination)
+				opts.destination = packtmp;
+
+			ret = write_filtered_pack(&opts, &existing, &names);
+			if (ret)
+				goto cleanup;
+		}
 	}
 
 	string_list_sort(&names);
diff --git a/repack-filtered.c b/repack-filtered.c
index edcf7667c5..f5a1dae5b1 100644
--- a/repack-filtered.c
+++ b/repack-filtered.c
@@ -3,6 +3,12 @@
 #include "repository.h"
 #include "run-command.h"
 #include "string-list.h"
+#include "hex.h"
+#include "packfile.h"
+#include "list-objects-filter-options.h"
+#include "list-objects-filter.h"
+#include "odb.h"
+#include "promisor-remote.h"
 
 int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
@@ -49,3 +55,89 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 	return finish_pack_objects_cmd(existing->repo->hash_algo, opts, &cmd,
 				       names);
 }
+
+struct collect_cb_data {
+	struct repository *repo;
+	struct oidset *set;
+};
+
+static int collect_promisor_blob(const struct object_id *oid,
+		struct object_info *oi UNUSED,
+		void *cb_data)
+{
+	struct collect_cb_data *data = cb_data;
+	struct object_info info = OBJECT_INFO_INIT;
+	enum object_type type;
+
+	info.typep = &type;
+
+	/*
+	 * Use OBJECT_INFO_SKIP_FETCH_OBJECT to avoid triggering a
+	 * lazy fetch while collecting promisor blobs.
+	 */
+	if (odb_read_object_info_extended(data->repo->objects, oid, &info,
+			OBJECT_INFO_SKIP_FETCH_OBJECT) < 0)
+		return 0;
+
+	if (type == OBJ_BLOB)
+		oidset_insert(data->set, oid);
+
+	return 0;
+}
+
+int enumerate_promisor_blobs(struct repository *repo,
+			const struct list_objects_filter_options *filter,
+			int dry_run)
+{
+	struct oidset all_promisor_blobs = OIDSET_INIT;
+	struct oidset to_drop = OIDSET_INIT;
+	struct collect_cb_data cb = {
+		.repo = repo,
+		.set = &all_promisor_blobs
+	};
+	struct oidset_iter iter;
+	const struct object_id *oid;
+	int ret = 0;
+
+	/*
+	 * The caller (cmd_repack) is responsible for validating that a
+	 * blob:limit filter and a promisor remote are present before
+	 * calling this function.
+	 *
+	 * Walk only promisor objects. Every object visited here is
+	 * guaranteed to be recoverable from the promisor remote, so
+	 * it is safe to drop.
+	 *
+	 * We do not use write_filtered_pack() here because git repack
+	 * routes promisor objects through repack_promisor_objects()
+	 * before the filter machinery runs, so the filtered pack never
+	 * contains promisor blobs. Direct enumeration via
+	 * ODB_FOR_EACH_OBJECT_PROMISOR_ONLY is the correct approach.
+	 */
+	ret = odb_for_each_object(repo->objects, NULL,
+			collect_promisor_blob, &cb,
+			ODB_FOR_EACH_OBJECT_PROMISOR_ONLY);
+	if (ret)
+		goto cleanup;
+
+	/*
+	 * Apply the filter to find which blobs exceed the threshold.
+	 */
+	ret = list_objects_filter__filter_oidset(repo,
+		(struct list_objects_filter_options *)filter,
+		&all_promisor_blobs,
+		&to_drop);
+	if (ret)
+		goto cleanup;
+
+	if (dry_run) {
+		oidset_iter_init(&to_drop, &iter);
+		while ((oid = oidset_iter_next(&iter)))
+			printf("%s\n", oid_to_hex(oid));
+	}
+
+cleanup:
+	oidset_clear(&all_promisor_blobs);
+	oidset_clear(&to_drop);
+	return ret;
+}
diff --git a/repack.h b/repack.h
index a5a3f7c6ba..d08e25b852 100644
--- a/repack.h
+++ b/repack.h
@@ -167,6 +167,10 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names);
 
+int enumerate_promisor_blobs(struct repository *repo,
+			       const struct list_objects_filter_options *filter,
+			       int dry_run);
+
 int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
 		     unsigned long combine_cruft_below_size,
-- 
2.54.0

