Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831F31ED83
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 20:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786651752; cv=none; b=fYDzTQ4fP8YYdhycBQg6W+xcsybeRE8AUdq1i0akp8iGywF+bd1xEp9fiouU6K3MF6KlnrbJLteAOfNQvivBWMWKizdd6s+aUo7/I6w215DfvyekZoOjdL8Mn22Ymr2ENAUtn2001HJ4RYOsZyRNlopWMiKHOhCXPvuI8AOdXkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786651752; c=relaxed/simple;
	bh=tLRnAF8n7CzSF4Gwwb7X9J8MSjY6WQvkd7PC7Ct8hXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9+2VuQ1KT3XiEOmb9JA6Ka1BtppnMi8pcyyo3a0WAmre3tBjR6YQ5bECkc4EK44R0D/M0ifEp6HOwluI71skp0X50VjsQy+eX+q+nNzo3bZ6v4uFtUyxEEB6ijrkuuLeO7NY1ZJNWI57o7LDxgi4G5QMvyOsDIWGq/0LwFKrUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SNnDwL96; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SNnDwL96"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38e88b60121so193803a91.3
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786651750; x=1787256550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZfEuYkNS0MGUHuKTBQ9t7S3Hg+7ddrhCX39lr24HSE=;
        b=SNnDwL96TPnwKfXG8IjyNsXiV6auChXZGfVz8ziDlx5SFqwqXYhMC5cPEqr6zMX7T9
         7ZksHmFfS9Ib3nfaFSF9CF4+A75A5NbaCYetYGGi/AOmnKEQVICGj2xbI9habXHqxL4p
         XO1oZw7EO3u5zHdsN+uIldrvY0zrTA/+w3/0VTEdv/EtrOP5K9QV1irLEkMP/kGKXQmk
         zFFZUtq2S7xyE6LRHECeL7xqYCYXJcDB4fd3BUwe+M6HZKDd5PGdOy3bIHxo0lRRsrZk
         UK4zLnFpUW41x8pq/9VAvMyDfYVk2sEiwxEjdO+XgQhqDz5lGxuKKwDXJxaIMlOQOpw2
         pANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786651750; x=1787256550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZfEuYkNS0MGUHuKTBQ9t7S3Hg+7ddrhCX39lr24HSE=;
        b=NO1AZIZV5KC57dg2gHAavDYeB4wWtOOfqtzA0D/5NPiuAzI6U/UQFoNe/UwyrtqInk
         en7sq5ss+aWItoNkCEVqCQ3xsG++JT+a3/utAE/toxw4aASOcxm8LdjITb/NExGb4gyC
         JyQ04UEjUplcfcaWNQLxqVFv3FxTPRW5bH8KOznbpvHSR6RdRPKseNxBAfZTQSieSt7/
         jxZLBgNWkt6heIZPMemMZJEV+V+KUhHiW2+ZddPVwCrviCPQA9iPpj1ihZDdWFNzWHXm
         HCh1ixxNhN6TFim1Izxww81vhOAhtrH8RLdxqSEq7MbjY4et6GSJ2cdy0xYPiJpNvuLH
         760w==
X-Gm-Message-State: AOJu0YwotnwaGkUlZ7U1v0PsQdlj2OmtbalJDk5Bu0KOjkZo4dqExep2
	EZcVEoRfc+hSmVAvN4UmtEl8XX5J6sOJfKapGImpi/9TWIKVtLsBVelYLIac3A==
X-Gm-Gg: AR+sD13H22kbiCpfqbzkysG5Syd7xp2ZGw6WjluirDfJ3KImzP8bfcpcywhziST766a
	7iPJ9ohnSSPtyuFMLqOoMWkj3/hwhxgL9UVpz/MXaEnO3Dg7zCFHbe0rT8a3cOgP4DNREtvh1HD
	ozYzpHUuTKxd2sX24XoIVcAaNgv1iTDMH4RC1L+sH3aigys70vBoHe/LswZxW1M3SGFdIcdOgs2
	eGVLM5V053GhgR/SbbTk7eXY5I/4pqYfw+V0k/He/kJpVg7nVfDlTC6MLy4HX3tlAXb3uUArUjk
	umWBaoJ331X0eidJjsezZchLSVf6tx5HVzF1d7c1TV6bPAzd50X9CJm9lQ6tk4NIDx7ZR4LILs4
	PYa/P9/aLu0R8hZ8arpQ4QCW8Q3OSs/fRG0+eiZ+K1Gc93Km2NtAgnXF5fMB5+oexC+UjOw5mg0
	Q8y6vN35LihLW9K50SLDi0KiVo1Ov4RoVxP3YrnTQqc9wc2bHuvaW2Xc9GyVLd7FOk8V3yPwSgm
	WoITCxLpMYMru0nltZrusCnk5SQBXk5hK0ybiy6NLlk1EH6nL36mO2ALRJCIwfQscJCWoJIsSjQ
	vwiJ5HqrlRCj1ohWudcb2CdyYYAqCEv0
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-3933b6e9788mr673289a91.2.1786651749997;
        Thu, 13 Aug 2026 13:09:09 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:ad47:4055:841d:89ad:96b0:2f73])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387c6f95sm1533440c88.6.2026.08.13.13.09.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 13 Aug 2026 13:09:09 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	siddharthasthana31@gmail.com,
	ttaylorr@openai.com,
	ps@pks.im,
	johannes.schindelin@gmx.de,
	l.s.r@web.de,
	r.siddharth.shrimali@gmail.com
Subject: [GSoC PATCH v5 4/6] builtin/repack: enumerate promisor blobs for --drop-filtered
Date: Fri, 14 Aug 2026 01:38:28 +0530
Message-ID: <20260813200830.84348-5-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
 <20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
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
 repack-filtered.c               | 82 +++++++++++++++++++++++++++++++
 repack.h                        |  4 ++
 t/t7706-repack-drop-filtered.sh | 85 ++++++++++++++++++++++++++++++++-
 4 files changed, 189 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 2ad6358535..3633b17ce8 100644
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
@@ -160,6 +162,7 @@ int cmd_repack(int argc,
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
 	struct existing_packs existing = EXISTING_PACKS_INIT;
+	struct oidset drop_oids = OIDSET_INIT;
 	struct pack_geometry geometry = { 0 };
 	struct tempfile *refs_snapshot = NULL;
 	int i, ret;
@@ -318,6 +321,20 @@ int cmd_repack(int argc,
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
@@ -613,7 +630,7 @@ int cmd_repack(int argc,
 		}
 	}
 
-	if (po_args.filter_options.choice) {
+	if (po_args.filter_options.choice && !drop_filtered) {
 		struct write_pack_opts opts = {
 			.po_args = &po_args,
 			.destination = filter_to,
@@ -706,6 +723,7 @@ int cmd_repack(int argc,
 cleanup:
 	string_list_clear(&keep_pack_list, 0);
 	string_list_clear(&names, 1);
+	oidset_clear(&drop_oids);
 	existing_packs_release(&existing);
 	pack_geometry_release(&geometry);
 	pack_objects_args_release(&po_args);
diff --git a/repack-filtered.c b/repack-filtered.c
index edcf7667c5..869b9fc6e3 100644
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
@@ -49,3 +55,79 @@ int write_filtered_pack(const struct write_pack_opts *opts,
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
+	 * Walk only promisor objects. Every object visited here is a
+	 * promisor object, so it is recoverable from the promisor remote
+	 * as long as the remote still has it, the same assumption the rest
+	 * of partial clone relies on.
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
+	 * The caller has to_drop and is responsible for clearing it.
+	 */
+	ret = list_objects_filter__filter_oidset(repo,
+		filter,
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
index 07a976874a..6352f1fdce 100755
--- a/t/t7706-repack-drop-filtered.sh
+++ b/t/t7706-repack-drop-filtered.sh
@@ -1,9 +1,37 @@
 #!/bin/sh
 
-test_description='git repack --drop-filtered option validation'
+test_description='git repack --drop-filtered enumerates filtered promisor blobs'
 
 . ./test-lib.sh
 
+# Delete a loose or packed object from "repo".
+delete_object () {
+	local repo="$1" &&
+	local obj="$2" &&
+	local path="$repo/.git/objects/$(test_oid_to_path "$obj")" &&
+	rm "$path"
+}
+
+# Pack the objects into a promisor pack inside "repo". It is a pack
+# accompanied by an empty ".promisor" marker file. Objects
+# in such a pack are treated as recoverable from the promisor remote.
+pack_as_from_promisor () {
+	HASH=$(git -C repo pack-objects .git/objects/pack/pack) &&
+	>repo/.git/objects/pack/pack-$HASH.promisor &&
+	echo $HASH
+}
+
+# Write a blob of $1 bytes into "repo", record it as coming from the
+# promisor remote, and remove the loose copy so the object is only
+# present in the promisor pack.
+promisor_blob () {
+	test-tool genrandom "$1" "$2" >blob_content &&
+	OID=$(git -C repo hash-object -w --stdin <blob_content) &&
+	printf "%s\n" "$OID" | pack_as_from_promisor >/dev/null &&
+	delete_object repo "$OID" &&
+	echo "$OID"
+}
+
 # Check option validation before any promisor walk
 test_expect_success 'setup plain repo for validation' '
 	git init plain &&
@@ -52,4 +80,59 @@ test_expect_success '--drop-filtered fails without a promisor remote' '
 	test_grep "drop-filtered requires a promisor remote" err
 '
 
+# Enumeration tests using promisor pack
+test_expect_success 'setup repo with a promisor remote' '
+	rm -rf repo &&
+	test_create_repo repo &&
+	test_commit -C repo base &&
+
+	# Mark the repo as a partial clone with a promisor remote so the
+	# promisor walk and the safety guard are satisfied.
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
+	# Large blob that exists only locally must never be a drop candidate.
+	# Dropping it would be unrecoverable.
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
+	# Candidate blob must still be present after a dry run.
+	git -C repo cat-file -e "$BIG"
+'
+
 test_done
-- 
2.54.0

