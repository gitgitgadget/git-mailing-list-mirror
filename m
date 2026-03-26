Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64B40245A
	for <git@vger.kernel.org>; Thu, 26 Mar 2026 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538105; cv=none; b=AXZss88rTR+4VpEtGzfaqcZ5jsk7+KLSrbc2hnTvw/mfFG13O2kkytdAiD1d/5a00sJmK2KFnp0dU5lLnyH3eFfavImrJ4ogy0eLZe662HOrCnDbA0oyNIOX6AxKBVIICArOAaoFaisMmigmM0mvvWiyCAkAEPVhioxig1Enkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538105; c=relaxed/simple;
	bh=BChe+HUlPKTluAaZmLiB7rCxC4bFgXy/G5OjDff/Om0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IEnJQPqaoUIcNvfQqXK/ozVgwAmp86ReEDF3ULHX96WYH/4t3JFlV+7tdYnxp5OK9GMuKP08vmWFRQXxmarZChuFpQ54FEK1mi1BjvKwNFrF0lTgBQlqK5lagDRWAfhoQTP+D3Rg/S/kkcmM3lw+feb9TiDrRHU8weMoh4aXtTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UHWKr0on; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHWKr0on"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cfbbf35354so151432485a.0
        for <git@vger.kernel.org>; Thu, 26 Mar 2026 08:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774538101; x=1775142901; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BO0hfWrrkpCGXZy86aog3KCfiK7Ny3wAkqEO/exxNI=;
        b=UHWKr0onRcx9Xb3zQt7C1smrF+6SOm9Fg+PJtKhP/s4lVanHXzIWD3E3OihTj0sUQ2
         Kvgi/mnMgicEdM0XbjhAg3gfLeujRvL2So8JiEmEc/QAUQiLhRJifSVIt5GRwPs2whCV
         nU32XbR5quALWxhCY3Sg7BY/unjdX7BQM+6O4x77GkM7l2rBVNjtv1kcw9sVXcum1ED6
         2MBlcUyY+QS7lIFyGtKROzeUIpc2i0zMjlgf2s0dqjUtDfc+q8c5F1H3qxN7RunPvXke
         vnjXGbY5H/yvoHCfxUyyKr7yh1jBlTxRdHsChvZFijr2hruGreXOBvKRs7lnHObygJpv
         gfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538101; x=1775142901;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/BO0hfWrrkpCGXZy86aog3KCfiK7Ny3wAkqEO/exxNI=;
        b=aA0DJky8KCTWh0mBbN58teeT8B3NxgHLMQtYiH8KvWOUlklBs5NymaQrOYMByTgVC5
         kSwbu+v3vkTaXrQWi/cHshwED2nf4qD6UG5cb6wrCjIoWVp/fz+/lYjqTXo7dIbKGy3T
         MFMaWVl13jSuntqGHbYjX4BA17WrN1y7GAVmZqsPdSWbldJPAszJsr4j0vnrS1EIkYde
         RuTRIuGFm8UHaUXrrQ1tScszIoPhbZySLhSii2mpGZBB2GFglVyiY0acCwLk9LDLP0TK
         jyW9/wB4UKb2NOxYze/YeGapkzmFQdqD/evNiTC4L1URWm1+fMLR0HAT7mB8bxfCiXNR
         heAg==
X-Gm-Message-State: AOJu0YzJGCw2DIony7+Yi92dmsXT5jej+nXdz9f5Mko46GUPngEdnWCr
	fgzRSct42cIWlcQCMt7nzMAHNXkv7xBelMiwEXLMQqaqAtB2yoMKqhRSyBQBwA==
X-Gm-Gg: ATEYQzxyqDelJXy4UN8VRNffST4f7VTLfSNbtid62v55oqPjmJbJkPHLp5etppI8BWg
	ssEElu/iOeEctCx/pL3O67v5PQDPRkPDSrj/zMuze3bO/K0PO2CaLc6yfdi1sj46XmXZP8LTXRX
	JdsXOlaW/PQGOYaaRGlQVjbjtmceyTGqSQ7XQ8lp+J5ZxKbdC78i2kwE9KThISBMVs6DvWbXuQ8
	Vwux5Fe4IrZx+ZY9PYCFq1Lt3mMTdroVeWAUAzaxQwoODR7rtim+0r4JRm9qtHFNzEHy305pwY1
	b9grM190ONipqG4lU8V3zgMlU8/70+ZmLxdZima7qKCd1mRkaAZ6TlhDVRlTFh3Phaqh8VQXUMk
	mETMOIiMoNOWXTmGgdCf+9FyCRPRbVv6DrtZe77tinj2vOwEoVACqKjhbSVgTHsGGalBZBLWsyS
	Rnz4f7kje2Z7X0NIDs2x1R82tXdA==
X-Received: by 2002:a05:620a:711c:b0:8cd:bfd9:e2a2 with SMTP id af79cd13be357-8d001012861mr1186294785a.43.1774538100643;
        Thu, 26 Mar 2026 08:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.199])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d00e3d5d6asm263187685a.19.2026.03.26.08.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:15:00 -0700 (PDT)
Message-Id: <7223124fb3229fc3a06a3208a43181716cec2eac.1774538094.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
References: <pull.2070.v2.git.1774266019.gitgitgadget@gmail.com>
	<pull.2070.v3.git.1774538094.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 26 Mar 2026 15:14:52 +0000
Subject: [PATCH v3 4/6] backfill: work with prefix pathspecs
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    r.siddharth.shrimali@gmail.com,
    ps@pks.im,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change allowed specifying revision arguments over the 'git
backfill' command-line. This created the opportunity for restricting the
initial commit set by filtering the revision walk through a pathspec. Other
than filtering the commit set (and thereby the root trees), this did not
restrict the path-walk implementation of 'git backfill' and did not restrict
the blobs that were downloaded to only those matching the pathspec.

Update the path-walk API to accept certain kinds of pathspecs and to
silently ignore anything too complex, for now. We will update this in the
next change to properly restrict to even complex pathspecs.

The current behavior focuses on pathspecs that match paths exactly. This
includes exact filenames, including directory names as prefixes. Pathspecs
containing wildcards or magic are cleared so the path walk downloads all
blobs, as before.

The reason for this restriction is to allow for a faster execution by
pruning the path walk to only trees that could contribute towards one of
those paths as a parent directory.

The test directory 'd/f/' (next to 'd/file*.txt') was prepared in a
previous commit to exercise the subtlety in prefix matching.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c         | 39 +++++++++++++++++++++++++++++++++++++++
 path.c              |  2 +-
 path.h              |  6 ++++++
 t/t5620-backfill.sh | 16 ++++++----------
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 364e4cfa19..3750552978 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -11,6 +11,7 @@
 #include "list-objects.h"
 #include "object.h"
 #include "oid-array.h"
+#include "path.h"
 #include "prio-queue.h"
 #include "repository.h"
 #include "revision.h"
@@ -206,6 +207,33 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
+		if (ctx->revs->prune_data.nr) {
+			struct pathspec *pd = &ctx->revs->prune_data;
+			bool found = false;
+			int did_strip_suffix = strbuf_strip_suffix(&path, "/");
+
+
+			for (int i = 0; i < pd->nr; i++) {
+				struct pathspec_item *item = &pd->items[i];
+
+				/*
+				 * Continue if either is a directory prefix
+				 * of the other.
+				 */
+				if (dir_prefix(path.buf, item->match) ||
+				    dir_prefix(item->match, path.buf)) {
+					found = true;
+					break;
+				}
+			}
+
+			if (did_strip_suffix)
+				strbuf_addch(&path, '/');
+
+			/* Skip paths that do not match the prefix. */
+			if (!found)
+				continue;
+		}
 
 		add_path_to_list(ctx, path.buf, type, &entry.oid,
 				 !(o->flags & UNINTERESTING));
@@ -481,6 +509,17 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (info->tags)
 		info->revs->tag_objects = 1;
 
+	if (ctx.revs->prune_data.nr) {
+		/*
+		 * Only exact prefix pathspecs are currently supported.
+		 * Clear any wildcard or magic pathspecs to avoid
+		 * incorrect prefix matching.
+		 */
+		if (ctx.revs->prune_data.has_wildcard ||
+		    ctx.revs->prune_data.magic)
+			clear_pathspec(&ctx.revs->prune_data);
+	}
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
diff --git a/path.c b/path.c
index d726537622..aebb10b2e9 100644
--- a/path.c
+++ b/path.c
@@ -57,7 +57,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
 		strbuf_remove(sb, 0, path - sb->buf);
 }
 
-static int dir_prefix(const char *buf, const char *dir)
+int dir_prefix(const char *buf, const char *dir)
 {
 	int len = strlen(dir);
 	return !strncmp(buf, dir, len) &&
diff --git a/path.h b/path.h
index 0ec95a0b07..829fafd7e9 100644
--- a/path.h
+++ b/path.h
@@ -114,6 +114,12 @@ const char *repo_submodule_path_replace(struct repository *repo,
 					const char *fmt, ...)
 	__attribute__((format (printf, 4, 5)));
 
+/*
+ * Given a directory name 'dir' (not ending with a trailing '/'),
+ * determine if 'buf' is equal to 'dir' or has prefix 'dir'+'/'.
+ */
+int dir_prefix(const char *buf, const char *dir);
+
 void report_linked_checkout_garbage(struct repository *r);
 
 /*
diff --git a/t/t5620-backfill.sh b/t/t5620-backfill.sh
index db66d8b614..52f6484ca1 100755
--- a/t/t5620-backfill.sh
+++ b/t/t5620-backfill.sh
@@ -273,13 +273,11 @@ test_expect_success 'backfill with prefix pathspec' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The pathspec should limit the downloaded blobs to
-	# only those matching the prefix "d/f", but currently all
-	# blobs are downloaded.
-	git -C backfill-path backfill HEAD -- d/f &&
+	git -C backfill-path backfill HEAD -- d/f 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 40 missing
 '
 
 test_expect_success 'backfill with multiple pathspecs' '
@@ -292,13 +290,11 @@ test_expect_success 'backfill with multiple pathspecs' '
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
 	test_line_count = 48 missing &&
 
-	# TODO: The pathspecs should limit the downloaded blobs to
-	# only those matching "d/f" or "a", but currently all blobs
-	# are downloaded.
-	git -C backfill-path backfill HEAD -- d/f a &&
+	git -C backfill-path backfill HEAD -- d/f a 2>err &&
+	test_must_be_empty err &&
 
 	git -C backfill-path rev-list --quiet --objects --missing=print HEAD >missing &&
-	test_line_count = 0 missing
+	test_line_count = 16 missing
 '
 
 test_expect_success 'backfill with wildcard pathspec' '
-- 
gitgitgadget

