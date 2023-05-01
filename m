Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E445C77B7C
	for <git@archiver.kernel.org>; Mon,  1 May 2023 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjEASVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 14:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjEASVl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 14:21:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E752E19BA
        for <git@vger.kernel.org>; Mon,  1 May 2023 11:21:39 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f19ab99540so26765255e9.2
        for <git@vger.kernel.org>; Mon, 01 May 2023 11:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682965298; x=1685557298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIbw2rKeKBxScjKsj3O1GA9OKSFAhWPWbfzhE4pMUd8=;
        b=HM9U9qEAB1WjDHZfRPzUAkMn1i6+zLHzbiMipT/5IDKepQ8iQ0zPRuD39nHwkiAOJU
         z3hEtbBB7KXbI/avbP5VvX/iybzC7qdQPMAONdr4uZQreDChW4C7KPIihjBu0ymQuqls
         uBveyoGMYhCzv9sJUd75fuoVC/j7art9ak2lnVpXs28+G04k19OYSbNoj8enQLz9vZ+c
         Gs5CPozJd/vgoyA+n7Zfs2AKcpqLzWnvieVD9+7wHGGyXD420+0FcUa5Xk46BpqPy8SD
         UCOhmVmbc+k2MRmeZe/jLfS9j1pf0SEG84Ebc0reFT+1YPtBSRAzY3xOpMYIiKa7ue6X
         ZG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682965298; x=1685557298;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIbw2rKeKBxScjKsj3O1GA9OKSFAhWPWbfzhE4pMUd8=;
        b=kIuMJ2BI83UIqt2eTVMPwaMnIpReP1QAbMw4XQwfpduDHkzTopGvq02vTReiIeVAxA
         sUYLHy0WFW6nHnWumqPAmLNLeRvPdldIULpcwQd/TPEPUxQ4QcTyckhegw9hMDyH27rk
         qkRW6xXgGapPf9BimviAaTEixWUH8KN/xHA2yNstxJqvm9WtQ2evf3P02+9Wx05mRU6u
         XKH+fGVO8lEwGvKeKv8Oq8WrLfIAr6NhD5Le5DfoqFxK69reIzLi3bE9fmIN/qeXkelQ
         niWS+wko9kZwZj6FRp6Tz4/7iADcSeE4te+mThh43dRl8LNdK0PqigcV3G76/F3BIMP7
         k4oA==
X-Gm-Message-State: AC+VfDxozLXgRJUxZXebm8rtZYlNlZsB6VJg96gCSwZccdvLHUOhuR+L
        LxYSOz9OXdQigfOKWrNaVtXlNxc7QSM=
X-Google-Smtp-Source: ACHHUZ6YCWC1gGl5mHeSPMW/hlt3Su0BTpNpFfNG9AeIKpg2FdaH7eahHLMGwgEISd4aLafxMXVQow==
X-Received: by 2002:a5d:5410:0:b0:305:fbfb:c7d7 with SMTP id g16-20020a5d5410000000b00305fbfbc7d7mr5279268wrv.44.1682965297855;
        Mon, 01 May 2023 11:21:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7-20020adfdd07000000b003062db9cc21sm3088105wrm.92.2023.05.01.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 11:21:37 -0700 (PDT)
Message-Id: <d608d2faa8602df6a52117c8c57c0ca8e43beb4f.1682965295.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
References: <pull.1526.git.1682965295.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 May 2023 18:21:34 +0000
Subject: [PATCH 1/2] fsck: verify checksums of all .bitmap files
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
 pack-bitmap.c                 | 44 +++++++++++++++++++++++++++++++++++
 pack-bitmap.h                 |  2 ++
 t/t5326-multi-pack-bitmaps.sh | 38 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)

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
index e0fad723bf3..ded58929a81 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2346,3 +2346,47 @@ int bitmap_is_preferred_refname(struct repository *r, const char *refname)
 
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
+	/* A non-existent file is valid. */
+	if (fstat(fd, &st)) {
+		close(fd);
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
index 0882cbb6e4a..d7353d8d443 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -434,4 +434,42 @@ test_expect_success 'tagged commits are selected for bitmapping' '
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
+	git fsck &&
+
+	corrupt_file "$packbitmap" &&
+	test_must_fail git fsck 2>err &&
+	grep "bitmap file '\''$packbitmap'\'' has invalid checksum" err &&
+
+	cp "$packbitmap.bak" "$packbitmap" &&
+	corrupt_file "$midxbitmap" &&
+	test_must_fail git fsck 2>err &&
+	grep "bitmap file '\''$midxbitmap'\'' has invalid checksum" err
+'
+
 test_done
-- 
gitgitgadget

