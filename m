Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA094477F6
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 11:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015358; cv=none; b=bqwv7J4ovQO2TPI1uNuuR3M68VyZrqb6YdgBzTdCTSVwZVhu2IMMdKQonVJk7NzD3ek1Epb22zVlvUKyrjY78EBr2OYGXINptpgpHmVJGEqlhMzMDDoNu5Zm+WuC2mhXLaP//iVHrBzQTrscyXxaTGxS/bOt2E/O2tx7nrmaUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015358; c=relaxed/simple;
	bh=bYWfl6bkD+5FjZYZm2Pqg2ms8rYRduEg6vf0MfSyOH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I5P71lgL2fqxzr4JVOq/O08U0SmmnSmFW5R+1918IBDBJ949S7v3RJNMdnQJLGLM9Ptj8y1cFig2Gxn1858dsRMI5NULJ2yYdwXrQH+OU2YgBALhj9UTWYawDj9RU7r8QEl6OWLKpa7JG432Q1gMzyL8+FYZORdpGkqyECmRkrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XitvWM7V; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XitvWM7V"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1544118a12.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 04:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786015355; x=1786620155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kKzrfhXydm0yRPoRiPuqzsQqBiaVJMbymuOYKMhHDk=;
        b=XitvWM7VkTbEeJAFtox2SqySXb7MNielI1H1qRF/GcLd/s/5HNGgfYFXzH7/5LR8Z5
         0kPu6UKbap4Dt+dQAnPnwozfRiWdcRzTY/YEBdHopEebiPX0KzQ+/RQC5gMENUbMcQYg
         1uFIiMjSrIQigZQOXF4rCAD2PDO+DFZ+lGYw4TVuZ6qv1UU4GAzQxjW2ShRf7l2TSW3H
         5aq56AkJDW8yjh4tIkEiuw4GLNuR6eQ6fgTYQzfvim5rK9aV6K6XD8dpFxpwBGvQJM8P
         RHhMC58CktLqTfRaJskUwM25pIA4rpE3LRbkITYHIH4m/E09g0fhyvNCYAWMdRLFvrDO
         QMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786015355; x=1786620155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kKzrfhXydm0yRPoRiPuqzsQqBiaVJMbymuOYKMhHDk=;
        b=felmYNwmYbqEgoDCNdYUhYWWjXYFow1iqD7530wI0yR+q7bgSnIeArzI0KrkYe+DCx
         Zl52RVsq/XDkr6Paa0JRfeSOpLeddhOKwj+xS7o1PvLAYUhLb0L+s0WMChcDxYkFgmyy
         lGAidmJrFFphGOIzR9Jov1Cc+XKooP8UThaGPIjlemMEiVKqm2nOebJ0Qxn2in9XS4FP
         M7qHLuIf5Bwzu5hSMiSHSCU9hlBqC6SrsO+9TeMcLNeHZXvzrIJtkKZLA3S8s5lyqBT0
         aoKX0xGgYASdvStDfPBwocJ9dBBL9ykzPD6aCBCCjUGGi4ryaUFZmT6U6RTsee/HTPrA
         02Ig==
X-Gm-Message-State: AOJu0YxbFm60ujttRsBFT3IemlXIy5Wq+ITZPkwlMhNmvXPqkyL9neSX
	AQAiZIBBAn6+XS0Bebr2o9SNu1J3ftDFYvrgfiz3U1rYEsH8q1Zg2TWBbKbCCLoq
X-Gm-Gg: AR+sD104Y+2aPosC/Tn/uGZxkTquGcQT3jxW1vwUbv0S5QIqgtHiuxwXfWoDZGmMz0P
	FkqtSs3Cpjg4ImW6EF31tF8WLjinWBJ7a0zteo2cDKtilATyRQBterj98BxOWsBCIZphLlLz6Rj
	LJ5/8us351regAO9/ww2NLwVP71oQh+mzsJ83HUO/BHWKDZF3Pq1E1BZz9TVEbyfsscwbZre935
	lpyanpv8FWQwlsrsVLuIMunLRw7Eu6v3N+QRK1KpK+aAD/xNZO1U0NFXlCOuwYeicQrii+KSC6x
	4fT1ctEPHCoVmQFi1FdcOGrJmEDNpdBfuD6ctl5boi7Xo50FlOnPUBcl5M7J4BoeAOaqBk1W0/y
	cT7cLktEGwaI+csQGKpp8cyA0jmiurmzNfafcTEcxWW1/8TkSZVuuUXF0K88JQG48mbnC3Eu08Q
	MbEVXig35p52XerqI1CRqPIW8wUOqItcTmlGiI0IPOrAo8ZJ5XA4iqsiFaMTH0m8PPNj5sH2QyX
	rvRBkgzI+Z+hght9iGE56f1d/H507fpzObsx/jDAUAPvq6bY4YyAZ3hr26p5/6GPn+dbQoaLgf8
	BqjgymdW6buN
X-Received: by 2002:a05:6a21:329d:b0:3b2:8685:118b with SMTP id adf61e73a8af0-3cb85ea362fmr14301791637.20.1786015355189;
        Thu, 06 Aug 2026 04:22:35 -0700 (PDT)
Received: from localhost.localdomain ([123.252.204.197])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca8df89asm42490376c88.9.2026.08.06.04.22.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 04:22:34 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	me@ttaylorr.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v3 4/7] builtin/repack: enumerate promisor blobs for --drop-filtered
Date: Thu,  6 Aug 2026 16:51:59 +0530
Message-ID: <20260806112202.75067-5-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
References: <20260730174153.9949-1-r.siddharth.shrimali@gmail.com>
 <20260806112202.75067-1-r.siddharth.shrimali@gmail.com>
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

Every object enumerated this way is a promisor object, so it is
recoverable from the promisor remote in the same sense as the rest of a
partial clone, as long as the remote still has it. This holds without a
separate is_promisor_object() check. A future implementation can verify
availability against the remote directly once a client-side
remote-object-info query exists.

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
 repack-filtered.c               | 81 +++++++++++++++++++++++++++++++
 repack.h                        |  4 ++
 t/t7706-repack-drop-filtered.sh | 84 ++++++++++++++++++++++++++++++++-
 4 files changed, 187 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 0a4dadb896..c5f39cef00 100644
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
@@ -159,6 +161,7 @@ int cmd_repack(int argc,
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
+	struct oidset drop_oids = OIDSET_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
 	int i, ret;
@@ -317,6 +320,20 @@ int cmd_repack(int argc,
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
@@ -612,7 +629,7 @@ int cmd_repack(int argc,
 		}
 	}
 
-	if (po_args.filter_options.choice) {
+	if (po_args.filter_options.choice && !drop_filtered) {
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
@@ -705,6 +722,7 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
+	oidset_clear(&drop_oids);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index edcf7667c5..79ba6d90aa 100644
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
@@ -49,3 +55,78 @@ int write_filtered_pack(const struct write_pack_opts *opts,
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
+	 * Walk only promisor objects. every object visited here is a
+	 * promisor object, so it is recoverable from the promisor remote
+	 * as long as the remote still has it, the same assumption the rest
+	 * of partial clone relies on
+
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
index f27b09a30e..453053cc18 100755
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
@@ -52,4 +79,59 @@ test_expect_success '--drop-filtered fails without a promisor remote' '
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

