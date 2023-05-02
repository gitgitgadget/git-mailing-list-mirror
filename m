Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CE2C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 13:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjEBN1c (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjEBN13 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 09:27:29 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D522D6196
        for <git@vger.kernel.org>; Tue,  2 May 2023 06:27:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f09b4a1584so24326625e9.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 06:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683034044; x=1685626044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9oQO+VmjoW/VflAHMzv0K8yXzyGZRYygsoT+WhDqWk=;
        b=ZRZWgH8dqnVNY0KyAo/PtjkGG1uMSyFxCJ8WjjQGR+mfCk4huFQmpfbqf6wMc7eyKf
         Njelu9GcWD8/W2OvPUGHG6ZQp60QUV4FF//UggW1qsXay/gZzhiO5hkdx5oE8qBGLNo2
         s968cud+6svn6IcQ+SJRGg/oRl/kDCP0OzxoWV8qLdk1TSNPQLKlmZX7bJg4ZbzzSAI9
         VbCcVHB4B1v6SuEVo9kfm+hewM9ZdXvP97oLv6G0Q77lk7PsqJgodEZKlWABwKs7N6J+
         DILVeyInpmME5fuNeuRXdrsf+nRr6tAyTJYRa/Ppg/F3K+n7tHIxHKjmnpVEghKJhOoH
         UgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683034044; x=1685626044;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9oQO+VmjoW/VflAHMzv0K8yXzyGZRYygsoT+WhDqWk=;
        b=jfZQhKggZoaR23NYvRLB+GCKx++W6ycWRAR5NAeP7nQnncUDbvzGWaXCh+mLty6+a0
         j5oSwsJVw8hE4OduF28EIviISHFZCgtpl5hloVY8m7cEvpQCuGzMVw3FYUfouciaYXvV
         f6NlnfEbXPxyL5iiBOTeC0yoADLfrJywEEdiNhDUuFYe0xtwF034W3lyHEjQnPkZQu4+
         y/3apduGxujMVJztPWGNySQe5EzT7P+jnukzVfgP+ZGkl9L9Nv1M/pDbTYcntFql2YZC
         dJIv9c6d6wsdhf4WFjMCqL7U4hb600RmBVZPsllq9Q4OIQI7Zal4cwyLoev6fZvrD7Tk
         KhRQ==
X-Gm-Message-State: AC+VfDxYgXnFIg6Zoj95vX2tf/JvhFpNi6b5ywG/93YSfvK5jIlIkzkm
        fAjz7EsjID1PRE9LV2nC9hE+OupBPN8=
X-Google-Smtp-Source: ACHHUZ5yk087hOxsnteq0PSGeJvWuY9ySF7DxZGiq68kDkNSvKncB5wL6Is03hUjhZRcZFTLiH+9WQ==
X-Received: by 2002:a5d:468e:0:b0:306:3a9c:4c6e with SMTP id u14-20020a5d468e000000b003063a9c4c6emr1049763wrq.68.1683034043895;
        Tue, 02 May 2023 06:27:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm35317870wml.48.2023.05.02.06.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 06:27:23 -0700 (PDT)
Message-Id: <5d6d66586332a411b05b1f345e7456fda858ddb3.1683034042.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
        <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 May 2023 13:27:21 +0000
Subject: [PATCH v2 1/2] fsck: verify checksums of all .bitmap files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

If a filesystem-level corruption occurs in a .bitmap file, Git can react
poorly. This could take the form of a run-time error due to failing to
parse an EWAH bitmap or be more subtle such as returning the wrong set
of objects to a fetch or clone.

A natural first response to either of these kinds of errors is to run
'git fsck' to see if any files are corrupt. This currently ignores all
.bitmap files.

Add checks to 'git fsck' for all .bitmap files that are currently
associated with a multi-pack-index or pack file. Verify their checksums
using the hashfile API.

We iterate through all multi-pack-indexes and pack-files to be sure to
check all .bitmap files, not just the one that would be read by the
process. For example, a multi-pack-index bitmap overrules a pack-bitmap.
However, if the multi-pack-index is removed, the pack-bitmap may be
selected instead. Be thorough to include every file that could become
active in such a way. This includes checking files in alternates.

There is potential that we could extend this effort to check the
structure of the reachability bitmaps themselves, but it is very
expensive to do so. At minimum, it's as expensive as generating the
bitmaps in the first place, and that's assuming that we don't use the
trivial algorithm of verifying each bitmap individually. The trivial
algorithm will result in quadratic behavior (number of objects times
number of bitmapped commits) while the bitmap building operation
constructs a lattice of commits to build bitmaps incrementally and then
generate the final bitmaps from a subset of those commits.

If we were to extend 'git fsck' to check .bitmap file contents more
closely like this, then we would likely want to hide it behind an option
that signals the user is more willing to do expensive operations such as
this.

For testing, set up a repository with a pack-bitmap _and_ a
multi-pack-index bitmap. This requires some file movement to avoid
deleting the pack-bitmap during the repack that creates the
multi-pack-index bitmap. We can then verify that 'git fsck' is checking
all files, not just the "active" bitmap.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/fsck.c                |  4 ++++
 pack-bitmap.c                 | 45 +++++++++++++++++++++++++++++++++++
 pack-bitmap.h                 |  2 ++
 t/t5326-multi-pack-bitmaps.sh | 44 ++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2cd461b84c1..75b30d1d00c 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -27,6 +27,7 @@
 #include "run-command.h"
 #include "worktree.h"
 #include "pack-revindex.h"
+#include "pack-bitmap.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -57,6 +58,7 @@ static int name_objects;
 #define ERROR_COMMIT_GRAPH 020
 #define ERROR_MULTI_PACK_INDEX 040
 #define ERROR_PACK_REV_INDEX 0100
+#define ERROR_BITMAP 0200
 
 static const char *describe_object(const struct object_id *oid)
 {
@@ -1056,6 +1058,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 	}
 
 	errors_found |= check_pack_rev_indexes(the_repository, show_progress);
+	if (verify_bitmap_files(the_repository))
+		errors_found |= ERROR_BITMAP;
 
 	check_connectivity();
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index e0fad723bf3..999f962602d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2346,3 +2346,48 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname)
 
 	return 0;
 }
+
+static int verify_bitmap_file(const char *name)
+{
+	struct stat st;
+	unsigned char *data;
+	int fd = git_open(name);
+	int res = 0;
+
+	/* It is OK to not have the file. */
+	if (fd < 0 || fstat(fd, &st)) {
+		if (fd >= 0)
+			close(fd);
+		return 0;
+	}
+
+	data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (!hashfile_checksum_valid(data, st.st_size))
+		res = error(_("bitmap file '%s' has invalid checksum"),
+			    name);
+
+	munmap(data, st.st_size);
+	return res;
+}
+
+int verify_bitmap_files(struct repository *r)
+{
+	int res = 0;
+
+	for (struct multi_pack_index *m = get_multi_pack_index(r);
+	     m; m = m->next) {
+		char *midx_bitmap_name = midx_bitmap_filename(m);
+		res |= verify_bitmap_file(midx_bitmap_name);
+		free(midx_bitmap_name);
+	}
+
+	for (struct packed_git *p = get_all_packs(r);
+	     p; p = p->next) {
+		char *pack_bitmap_name = pack_bitmap_filename(p);
+		res |= verify_bitmap_file(pack_bitmap_name);
+		free(pack_bitmap_name);
+	}
+
+	return res;
+}
diff --git a/pack-bitmap.h b/pack-bitmap.h
index f0180b5276b..84591f041bf 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -111,4 +111,6 @@ int bitmap_is_midx(struct bitmap_index *bitmap_git);
 const struct string_list *bitmap_preferred_tips(struct repository *r);
 int bitmap_is_preferred_refname(struct repository *r, const char *refname);
 
+int verify_bitmap_files(struct repository *r);
+
 #endif
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 0882cbb6e4a..f771c442d41 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -434,4 +434,48 @@ test_expect_success 'tagged commits are selected for bitmapping' '
 	)
 '
 
+corrupt_file () {
+	chmod a+w "$1" &&
+	printf "bogus" | dd of="$1" bs=1 seek="12" conv=notrunc
+}
+
+test_expect_success 'git fsck correctly identifies good and bad bitmaps' '
+	git init valid &&
+	test_when_finished rm -rf valid &&
+
+	test_commit_bulk 20 &&
+	git repack -adbf &&
+
+	# Move pack-bitmap aside so it is not deleted
+	# in next repack.
+	packbitmap=$(ls .git/objects/pack/pack-*.bitmap) &&
+	mv "$packbitmap" "$packbitmap.bak" &&
+
+	test_commit_bulk 10 &&
+	git repack -b --write-midx &&
+	midxbitmap=$(ls .git/objects/pack/multi-pack-index-*.bitmap) &&
+
+	# Copy MIDX bitmap to backup. Copy pack bitmap from backup.
+	cp "$midxbitmap" "$midxbitmap.bak" &&
+	cp "$packbitmap.bak" "$packbitmap" &&
+
+	# fsck works at first
+	git fsck 2>err &&
+	test_must_be_empty err &&
+
+	corrupt_file "$packbitmap" &&
+	test_must_fail git fsck 2>err &&
+	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+
+	cp "$packbitmap.bak" "$packbitmap" &&
+	corrupt_file "$midxbitmap" &&
+	test_must_fail git fsck 2>err &&
+	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+
+	corrupt_file "$packbitmap" &&
+	test_must_fail git fsck 2>err &&
+	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err &&
+	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err
+'
+
 test_done
-- 
gitgitgadget

