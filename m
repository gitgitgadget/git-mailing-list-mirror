Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8923B52EE
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785433366; cv=none; b=UsbBSCCzkGpz8YS3vluYqzp3NKdssDzp8NsDkUKOBUzW19grmIUSaUHTFRPPlj2zb9IEK7UdUp+NKBmI/5B/mVIB4cJfeQTyh3WarbjD7M/jYe0Y9k4m55RmWL9R/SVfpoWFJvCT6PQ6HY/KKkQNtyQyXPKmrjJj8hgbl+stf1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785433366; c=relaxed/simple;
	bh=vEGNS7ezR0vNm/e2jQFbfEJgQm+eolW3yKoVN0GpG+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lK9pKxTZnBsDG6Dt42EJAfu8WmlsWtMF+u3XofgnZBYC4K5Fn7LXpTqfhJaTxjhzaCxa1q+BPXwonVEdDivNzL7DbNnamH7pY13C+WMkGCIgzojZweA1Lkea4QNi8drcEBqprbtC6aGlM4sy2/RsRzgOE2GB8YgOAJthmF1Zh54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGp0mtsg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGp0mtsg"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1216904b3a.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785433364; x=1786038164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50sh6XpJNR/2yKjjoqSlDdJVHYZRO8zHDLnt+NF6OGo=;
        b=TGp0mtsgG7T2/iUQ5F+a5UzPCYv/IDp0a8J4skKd1gvvxzc80x+/LY01oK1Bg1Pqem
         T7gGeKLD4DXqHlBO1M0d434cGVjqPVLAKwVrDKxQkA4E69twXUczvOeyzXsiac84cA+S
         OI4mc4L3OnlwfaqOKIK/8Pih+1WP7VCYye7NWZS1uXh/tH84KjGcx2W+z0Z5OpDfHD5B
         T+3g/uGewZN1oaQ0rXXoJ3x08E2lHeIg1yUHJvfeKeBzRhtCxz6iFajrErsVuYP8HIke
         67NFon+xEg8cLKPlFKh9boltmR0+7e1iaIfFEjYGTKrZ0vY/OFvHblZBFHtzXo4IOkJl
         F2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785433364; x=1786038164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=50sh6XpJNR/2yKjjoqSlDdJVHYZRO8zHDLnt+NF6OGo=;
        b=s/iLSCsK8+mlqVE58X/58vNXqDqU6yBCpNYLPK9jljTGsfOW/KfUqwW5YgQwA5Etkq
         9RkCE7qmgmZ4yzwAcu6ejdph/u3z2Q2LuHDW665D/lpAemiNAgUrGu+gXYX4GmgVLk1L
         ZSrZATDbOj7D80Df1gqdE+rPBeb6AWIiPqiIRNtEe1eQzH7YFHacNVcEFzt92E/vfqKA
         AxCN8GaCaQJlO2yCOdqBVL1JmX6+gaqOqJVreB5V7MW7XVrqARrZoClY2FR/u95PTz4x
         QS50g7CVXCkovnaslaU8N+wHWacQAHY53DHBQb3L75Bw4vhP9O/UDOlGjzu8ITXbqKHT
         7GJg==
X-Gm-Message-State: AOJu0Yxhn0dZ1E0shTnQfSzV7tUmz7HRcZMifMaFL9aMzEnqdtKZWeQI
	y7QcinPi2GzkSlO6R0tFw0YyYtbvSWVD+F/KNARJg5046msWiVX994gfjn50iA==
X-Gm-Gg: AR+sD13tRsZd1PEw97YVVo3pie6bIu9XdiLv9R4boVAZkoujmEHsQ1Em7XCiXo+KJzG
	HY6Q5PajgjzBPuIoXKuTHgv0TFxeZLePPpx+ucJaVMycQwxfI6uM0ZOj7tpYXXm3kycZyLGMdJJ
	whBq+o3XjZc1DT3t5WS/Z6Zq/PTyc+mwZ+y5Htt6BOw2cKaFy1YTgqYuop0KIrnfxeBHnztpPA1
	0qTfVKzySKZ+vqO8kETKDGyoo/g9fHekwcbPry/BUsjxuES5yZpC7JQmO3K/zawg3Xl1gfcuu/5
	TBqxM1lUKUnz5w4rfWbRMPvTY/WkYqlbxocBlTzRxmvntD0NCl+idAMHBtGvgVvszvb2nEOAuyW
	42R9OgTb5XS7Rxezq05hBT+RGu5DT7fPz2GO/IFT5eNehOEXOKQaOK6Yr/8QqMd+dEepH54OZaK
	q/LB1vA4qWt+EsOeEAYat1IcjBiv9GSMex/8cHytvcTgC6agKfA46fsLQZTxzblDF1jefd6SNmf
	ESl3CmqHHxUESOarZUWKPcf8+QBy9y4MaB1HOW5Seqi3d2w++rO2mD5xIs/bNfLECLL3cVFNV4r
	hkKxFv0Crf21tkpAFfEf2M4sCdg=
X-Received: by 2002:a05:6a20:244b:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3c90d767230mr1101091637.4.1785433363824;
        Thu, 30 Jul 2026 10:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:5622:d88b:20c4:5444:d41a:b6c2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm25163964eec.14.2026.07.30.10.42.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 10:42:43 -0700 (PDT)
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
Subject: [GSoC PATCH v2 4/7] builtin/repack: enumerate promisor blobs for --drop-filtered
Date: Thu, 30 Jul 2026 23:11:50 +0530
Message-ID: <20260730174153.9949-5-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
References: <20260716132848.95982-1-r.siddharth.shrimali@gmail.com>
 <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
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

The enumeration collects candidates into a caller-provided oidset and
--dry-run prints them. Actually removing the objects, together with the
required promisor-remote verification, is written in a later commit.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Siddharth Asthana <siddharthasthana31@gmail.com>
Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 builtin/repack.c                | 20 +++++++-
 repack-filtered.c               | 80 +++++++++++++++++++++++++++++++
 repack.h                        |  4 ++
 t/t7706-repack-drop-filtered.sh | 84 ++++++++++++++++++++++++++++++++-
 4 files changed, 186 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index f25d189b07..8cb92d1a62 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -15,6 +15,8 @@
 #include "repack.h"
 #include "shallow.h"
 #include "list-objects-filter-options.h"
+#include "oidset.h"
+#include "hex.h"
 
 #define ALL_INTO_ONE 1
 #define LOOSEN_UNREACHABLE 2
@@ -143,6 +145,7 @@ int cmd_repack(int argc,
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
+	struct oidset drop_oids = OIDSET_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
 	int i, ret;
@@ -313,6 +316,20 @@ int cmd_repack(int argc,
 			die(_("--drop-filtered requires a promisor remote"));
 
 		write_bitmaps = 0;
+
+		ret = enumerate_promisor_blobs(repo, &po_args.filter_options, &drop_oids);
+
+		if (ret)
+			goto cleanup;
+
+		if (dry_run) {
+			struct oidset_iter iter;
+			const struct object_id *oid;
+
+			oidset_iter_init(&drop_oids, &iter);
+			while ((oid = oidset_iter_next(&iter)))
+				printf("%s\n", oid_to_hex(oid));
+		}
 	}
 
 	if (delete_redundant && repo->repository_format_precious_objects)
@@ -608,7 +625,7 @@ int cmd_repack(int argc,
 		}
 	}
 
-	if (po_args.filter_options.choice) {
+	if (po_args.filter_options.choice && !drop_filtered) {
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
@@ -701,6 +718,7 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
+	oidset_clear(&drop_oids);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index edcf7667c5..217fc54d7b 100644
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
@@ -49,3 +55,77 @@ int write_filtered_pack(const struct write_pack_opts *opts,
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
+				 struct object_info *oi UNUSED,
+				 void *cb_data)
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
+			     const struct list_objects_filter_options *filter,
+			     struct oidset *to_drop)
+{
+	struct oidset all_promisor_blobs = OIDSET_INIT;
+	struct collect_cb_data cb = {
+		.repo = repo,
+		.set = &all_promisor_blobs
+	};
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
+		to_drop);
+
+cleanup:
+	oidset_clear(&all_promisor_blobs);
+	return ret;
+}
diff --git a/repack.h b/repack.h
index a5a3f7c6ba..61e554e4ed 100644
--- a/repack.h
+++ b/repack.h
@@ -167,6 +167,10 @@ int write_filtered_pack(const struct write_pack_opts *opts,
 			struct existing_packs *existing,
 			struct string_list *names);
 
+int enumerate_promisor_blobs(struct repository *repo,
+			     const struct list_objects_filter_options *filter,
+			     struct oidset *to_drop);
+
 int write_cruft_pack(const struct write_pack_opts *opts,
 		     const char *cruft_expiration,
 		     unsigned long combine_cruft_below_size,
diff --git a/t/t7706-repack-drop-filtered.sh b/t/t7706-repack-drop-filtered.sh
index 65be756e33..cbdb580702 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -1,9 +1,36 @@
 #!/bin/sh
 
-test_description='git repack --drop-filtered option validation'
+test_description='git repack --drop-filtered enumerates filtered promisor blobs'
 
 . ./test-lib.sh
 
+delete_object () {
+	local repo="$1" &&
+	local obj="$2" &&
+	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
+	rm "$path"
+}
+
+# pack the objects into a promisor pack inside "repo". it is a pack
+# accompanied by an empty ".promisor" marker file. objects
+# in such a pack are treated as recoverable from the promisor remote.
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor &&
+	echo $HASH
+}
+
+# write a blob of $1 bytes into "repo", record it as coming from the
+# promisor remote, and remove the loose copy so the object is only
+# present in the promisor pack
+promisor_blob () {
+	test-tool genrandom "$1" "$2" >blob_content &&
+	OID=$(git -C repo hash-object -w --stdin <blob_content) &&
+	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
+	delete_object repo "$OID" &&
+	echo "$OID"
+}
+
 # checks for options validations before any promisor walk
 test_expect_success 'setup plain repo for validation' '
 	git init plain &&
@@ -46,4 +73,59 @@ test_expect_success '--drop-filtered fails without a promisor remote' '
 	test_grep "drop-filtered requires a promisor remote" err
 '
 
+# enumeration tests using promisor pack
+test_expect_success 'setup repo with a promisor remote' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo base &&
+
+	# mark the repo as a partial clone with a promisor remote so the
+	# promisor walk and the safety guard are satisfied
+	git -C repo config core.repositoryformatversion 1 &&
+	git -C repo config extensions.partialclone origin &&
+	git -C repo config remote.origin.promisor true &&
+	git -C repo config remote.origin.url "." &&
+
+	BIG=$(promisor_blob big 3072) &&
+	SMALL=$(promisor_blob small 512) &&
+	echo "$BIG" >big_oid &&
+	echo "$SMALL" >small_oid
+'
+
+test_expect_success 'promisor blob over the threshold is listed' '
+	BIG=$(cat big_oid) &&
+	SMALL=$(cat small_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	test_grep "$BIG" out &&
+	test_grep ! "$SMALL" out
+'
+
+test_expect_success 'locally created blob is never listed' '
+	BIG=$(cat big_oid) &&
+
+	# large blob that exists only locally must never be a drop candidate.
+	# dropping it would be unrecoverable
+	test-tool genrandom local 4096 >local_content &&
+	LOCAL=$(git -C repo hash-object -w --stdin <local_content) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	test_grep "$BIG" out &&
+	test_grep ! "$LOCAL" out
+'
+
+test_expect_success '--dry-run does not remove the filtered objects' '
+	BIG=$(cat big_oid) &&
+
+	git -C repo -c repack.writeBitmaps=false \
+		repack --drop-filtered --filter=blob:limit=1k --dry-run -a >out &&
+
+	# candidate blob must still be present after a dry run
+	git -C repo cat-file -e "$BIG"
+'
+
 test_done
-- 
2.54.0

