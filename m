Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAC821CA03
	for <git@vger.kernel.org>; Tue, 17 Mar 2026 00:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773707371; cv=none; b=BDlhVV3cPEnOFmKIc/qyu95rscUHPHTjR4mLWsUnWrGMmdU4QeTEp+NM4Hw0yOzPThrkh2ZPV8OpE3xck+WToNO2Kxqj3T2QMe7hFD3WH0+sZ0FyEWdNyMlemylA6IZSSPfhm4u42oH7S+yWk3dXG3FiHFBP+up3APDeP4Ao8+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773707371; c=relaxed/simple;
	bh=U5ASi/ku5Wnk2GZiLPeT2h6iaSTdhnt3/FqRe/qz8ow=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gfobJCZObqMU99XBuBn0Hgm3Gy+kTX9bygp7ibGRA39oYCY3D8K2cvcjhR4ULkpPmHqEqm8FAuQ3dj9Kp6GnpO1x5rXRsHAB0DveZbNRjyL18Uisisl9X603L+b6DdlIkqN1Af9HhKHVXcLoZHeD1+CTHsCLqdrbV0lUzcyHU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aq40eE4q; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aq40eE4q"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-128d2e3082eso5977533c88.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 17:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773707369; x=1774312169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6m6D69OcDQiL95FZVknQImGF0RhEYJjd1kwtt60TvA=;
        b=Aq40eE4qQdz/6b6uJrZey2voJBJHHwXMjkUzaMZ+NML+pP0mibwMqZS02354yuVXxm
         HXK60HSe3g3NwZ3V3tg34OtjXgtTAZeVb0DOqtRN9vFjzJ2oqEwfsLV1nC2nN6PqZK2L
         1+KtbPpuE+psSGMEAUARZLdtnqdtkQuekiSo5UQ9CtRtrSxCC0n5d60oosNvmn2ZqKNI
         ozvQGnvCEESmpS8K5sTeIvJgAi3By0KI0ksoUaqi6Zxe3GwvXrAJVdtYcmGcOVQE4pgh
         D130F7vDsGfH+rmpjMCLAh+8nxpdb/xZRVheCRCmD9bpMPGx5ImNte7pcxuD8Csg/rvy
         gxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773707369; x=1774312169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6m6D69OcDQiL95FZVknQImGF0RhEYJjd1kwtt60TvA=;
        b=UgOIbSZGRu8mHvYRd/MRVGNRETeFtph5wGytWEb/tgn/3gL6ZLplW9kNWsE0SBTGl2
         pgaKpoPQDAWRuIV2O7tBVfQyV8b+ywnR+oLsZJkEHFwbvFBI4EwTngQ2kHO37jjxXqpM
         oCfjkCizW2w/eXJ3x8Zah9csuwWYoVszQamirT1kkNayx9xjVPjUS32Uz10hteZoCgPD
         AQiZXOtl4AcfWuEy/4W7G+6oqvr/MaGHSie4mBxrY/IGlKtSmGY20LPBZo2Ze6giVnFr
         92Wv/3Faq/D9rCtBOh8aQXF86pH0nKcvgEpH+M+IfEYYhhamK+qDP9tUY2SYkhDeBr6s
         MDcw==
X-Gm-Message-State: AOJu0Yy99q3fAV8W3JM1rRCEN0HzUFw1syUEXwU/OthRKh9G11dbJdaS
	5ivtjDBCadYpmkfE3jwPfukwo3Q2tKgMprO/j+/8DgWekKPxs8Qv62NVDJv/Hw==
X-Gm-Gg: ATEYQzxJ7pLzSgykpEOlLo26KVgiZEJMcV5a6bqeHDUOdUk2g22CeRUPYlrVUqSVQVf
	Sj8QbdmDIrK8GgluuC9rlpxs29dXPze2BxcYBdRmCyVK43ZB03ZJTO7HERm4C7zqOTSgIXdKCMc
	5nss09NdtpANMEuCLeO/PXd9DIf//ikFGL4Fz5f1v59M3s4+tb+lH2f87D0GsgwBOYBsiY0V0o5
	MqM+C0HKgMd1sUObjQ8/sR8Mkk9XtY4DgtP5ptf6sUBryNuYGWPE0+nd/X+b/Gm/IFkDNgZ8+RZ
	Q2enrnW4dIR+TakDW56Kd/Rw+NQXRPcuWRw1TJgJeZsfu6Al+mT7CZ7T6oc7jMT0HKWUo0eWijP
	fxqo0k9fjT6frQFJS7U2ZT9tn1ILPgZoStZZEaM5Ko/u6/9ucjxr/Y3PQE6Omh1d9LFTzTEgMsz
	7PMZrWD/XAQZHiqOCBtzcSFYzsHA==
X-Received: by 2002:a05:7022:b8d:b0:119:e56b:c749 with SMTP id a92af1059eb24-128f3d5702amr7760446c88.14.1773707368493;
        Mon, 16 Mar 2026 17:29:28 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.136.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f618f01csm13957558c88.0.2026.03.16.17.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 17:29:27 -0700 (PDT)
Message-Id: <977f62faa550ecc4ef7774b4ecf53a9a520fc62a.1773707361.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
References: <pull.2070.git.1773707361.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Mar 2026 00:29:20 +0000
Subject: [PATCH 4/5] backfill: work with prefix pathspecs
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
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

The previous change allowed specifying revision arguments over the 'git
backfill' command-line. This created the opportunity for pathspecs that
specify a smaller set of starting commits, but otherwise did not restrict
the blob paths that were downloaded.

Update the path-walk API to accept certain kinds of pathspecs and to
silently ignore anything too complex. The current behavior focuses on
pathspecs that match paths exactly. This includes exact filenames,
including directory names as prefixes. Pathspecs containing wildcards
or magic are cleared so the path walk downloads all blobs, as before.

The reason for this restriction is to allow for a faster execution by
pruning the path walk to only trees that could contribute towards one of
those paths as a parent directory.

The test directory 'd/f/' (next to 'd/file*.txt') was prepared in a
previous commit to exercise the subtlety in prefix matching.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 path-walk.c         | 55 +++++++++++++++++++++++++++++++++++++++++++++
 t/t5620-backfill.sh | 16 +++++--------
 2 files changed, 61 insertions(+), 10 deletions(-)

diff --git a/path-walk.c b/path-walk.c
index 364e4cfa19..e1ad4b0208 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -206,6 +206,49 @@ static int add_tree_entries(struct path_walk_context *ctx,
 				 match != MATCHED)
 				continue;
 		}
+		if (ctx->revs->prune_data.nr) {
+			struct pathspec *pd = &ctx->revs->prune_data;
+			bool found = false;
+
+			for (int i = 0; i < pd->nr; i++) {
+				struct pathspec_item *item = &pd->items[i];
+
+				/*
+				 * Is this path a parent directory of
+				 * the pathspec item?
+				 */
+				if (path.len < (size_t)item->len &&
+				    !strncmp(path.buf, item->match, path.len) &&
+				    item->match[path.len - 1] == '/') {
+					found = true;
+					break;
+				}
+
+				/*
+				 * Or, is the pathspec an exact match?
+				 */
+				if (path.len == (size_t)item->len &&
+				    !strcmp(path.buf, item->match)) {
+					found = true;
+					break;
+				}
+
+				/*
+				 * Or, is the pathspec a directory prefix
+				 * match?
+				 */
+				if (path.len > (size_t)item->len &&
+				    !strncmp(path.buf, item->match, item->len) &&
+				    path.buf[item->len] == '/') {
+					found = true;
+					break;
+				}
+			}
+
+			/* Skip paths that do not match the prefix. */
+			if (!found)
+				continue;
+		}
 
 		add_path_to_list(ctx, path.buf, type, &entry.oid,
 				 !(o->flags & UNINTERESTING));
@@ -481,6 +524,18 @@ int walk_objects_by_path(struct path_walk_info *info)
 	if (info->tags)
 		info->revs->tag_objects = 1;
 
+	if (ctx.revs->prune_data.nr) {
+		/*
+		 * Only exact prefix pathspecs are currently supported.
+		 * Clear any wildcard or magic pathspecs to avoid
+		 * incorrect prefix matching.
+		 */
+		struct pathspec *pd = &ctx.revs->prune_data;
+
+		if (pd->has_wildcard || pd->magic)
+			pd->nr = 0;
+	}
+
 	/* Insert a single list for the root tree into the paths. */
 	CALLOC_ARRAY(root_tree_list, 1);
 	root_tree_list->type = OBJ_TREE;
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

