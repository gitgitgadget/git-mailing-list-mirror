Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727351791F4
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 20:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714423452; cv=none; b=jB1fqqji0GKbCB8uU6ol54gSsWw3DPfA+9/+q8+BQHhByVoN+GnLOWoidKgoha9+PGvHCJSm8U5XKFEOh1PUGnKZDb95s7jpr8E7fmpkNZZt/d6A2EHCdgqbmP+G6j95FccwVVzQkVvHxpmlzXvC3r9eXxnIOTf84YApjB6FO7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714423452; c=relaxed/simple;
	bh=qvHkiGfH34O/NdIvEh7yQVzzOtcrFJNUIdYbo1N7ko8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j67PXz0P/6lEjvSVpAltYWAzUvn0iDFoEtsjZBGmO3QvNAF2ZxI3Ly5rRfE+GHJkUBCLSTyUXbS92exc246RCgp6KCnXB9UWdsPts19wPFtzEfprffmf0T2BLlxcfCEjxggIK/UEPloygyUoQ5MxgmtIgh0KGx8oEqpO2mM7RPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=nd4gvblt; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="nd4gvblt"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-434d0e3f213so19637011cf.3
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 13:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1714423449; x=1715028249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4iHzmZIKJuASomErhthoWyZfpL6c5BEwFsZ3tXJaKVQ=;
        b=nd4gvbltl7VML0koLEIE3JTlEwIIkaQxHJcRUZwvcNH6iomaYqVS6VGu4B3fEa2rXh
         DZYABx8ntE0NG7QOIwZUnY4elFrscm2qZxcRqsL87GdoSOnaueEBEmz//dPzoPEHDhP+
         5/JJkwrg5UA6H79ySICQ4g/CAFT70i36GxsAgNT4095dg+k5cVMnIxNGngbvapdqWDNc
         juMt+3zKG2zCXYLZJjtHCQNhhaI60lki7aM9Oh8qOmfax7ok/Ut9n06qXQTkpwfDroNu
         Y+fw4kk5AOuEgdb/Qg2okHZq+RK3/5/Pov6BjRP0sqbOBt2xN06RsxL+zgzI/4kXbzDa
         i2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714423449; x=1715028249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iHzmZIKJuASomErhthoWyZfpL6c5BEwFsZ3tXJaKVQ=;
        b=ZO9qgUFW4LtvYvSQYqA1dmuIzZf4l1JFnHUFf+hiZan/pUbA3P+OBfbhiL+VoycaS6
         Ibx6GUQhcy8otf7//d6qjQmuxGEg5cVXQyTnDY7lpcCkMUlCGW49cIs26hF7mOtha21w
         F6O2Lu10lTwDhOha+760OX6YdG4FP7R4g6vKQL74+5swgcdawKFD5BJREpmvI04dvW72
         8qo1GP+qTYYJyk61YZXkN4JpuwsMQKRzkoJzms5uxFsKENc8iPO2cAe1p8QnlE9Ui3AU
         wG8HpHuUmeKWNS3YG7hHeQd7MUzgiloWKUIeZw5f147hRXiB2X65TsKXKvvT1uXq+QV/
         WP0g==
X-Gm-Message-State: AOJu0YydeQ66UqUSOHEhW+eSb5oM7h4hMTaiXXhOUNjREyFwSdPunw0F
	6DUEWe/NBzmcFsStXFTheJWyrrZJMIdB5SJa7UZwwyEOKALdsz8q1nJ9q3vSJ5RDhcF946Ry+1h
	Ibdw=
X-Google-Smtp-Source: AGHT+IEoRWCeSB+5PvqYsMgX5NB+xUH2QAypOePBRhiP+AHrPsk/MM6kp3zVxm+dnacOx4xUw8m9PA==
X-Received: by 2002:a05:622a:1a83:b0:434:e522:3c26 with SMTP id s3-20020a05622a1a8300b00434e5223c26mr12784305qtc.19.1714423449574;
        Mon, 29 Apr 2024 13:44:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l6-20020ac87246000000b004369f4d31f2sm10817941qtp.50.2024.04.29.13.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 13:44:08 -0700 (PDT)
Date: Mon, 29 Apr 2024 16:44:07 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/23] pack-bitmap: implement test helpers for pseudo-merge
Message-ID: <7b5ea56d053bc023780c34385570be4617da6705.1714422410.git.me@ttaylorr.com>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1714422410.git.me@ttaylorr.com>

Implement three new sub-commands for the "bitmap" test-helper:

  - t/helper test-tool bitmap dump-pseudo-merges
  - t/helper test-tool bitmap dump-pseudo-merge-commits <n>
  - t/helper test-tool bitmap dump-pseudo-merge-objects <n>

These three helpers dump the list of pseudo merges, the "parents" of the
nth pseudo-merges, and the set of objects reachable from those parents,
respectively.

These helpers will be useful in subsequent patches when we add test
coverage for pseudo-merge bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c          | 126 +++++++++++++++++++++++++++++++++++++++++
 pack-bitmap.h          |   3 +
 t/helper/test-bitmap.c |  34 ++++++++---
 3 files changed, 156 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fc9c3e2fc43..c13074673af 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2443,6 +2443,132 @@ int test_bitmap_hashes(struct repository *r)
 	return 0;
 }
 
+static void bit_pos_to_object_id(struct bitmap_index *bitmap_git,
+				 uint32_t bit_pos,
+				 struct object_id *oid)
+{
+	uint32_t index_pos;
+
+	if (bitmap_is_midx(bitmap_git))
+		index_pos = pack_pos_to_midx(bitmap_git->midx, bit_pos);
+	else
+		index_pos = pack_pos_to_index(bitmap_git->pack, bit_pos);
+
+	nth_bitmap_object_oid(bitmap_git, oid, index_pos);
+}
+
+int test_bitmap_pseudo_merges(struct repository *r)
+{
+	struct bitmap_index *bitmap_git;
+	uint32_t i;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	for (i = 0; i < bitmap_git->pseudo_merges.nr; i++) {
+		struct pseudo_merge *merge;
+		struct ewah_bitmap *commits_bitmap, *merge_bitmap;
+
+		merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+					 &bitmap_git->pseudo_merges.v[i]);
+		commits_bitmap = merge->commits;
+		merge_bitmap = pseudo_merge_bitmap(&bitmap_git->pseudo_merges,
+						   merge);
+
+		printf("at=%"PRIuMAX", commits=%"PRIuMAX", objects=%"PRIuMAX"\n",
+		       (uintmax_t)merge->at,
+		       (uintmax_t)ewah_bitmap_popcount(commits_bitmap),
+		       (uintmax_t)ewah_bitmap_popcount(merge_bitmap));
+	}
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return 0;
+}
+
+static void dump_ewah_object_ids(struct bitmap_index *bitmap_git,
+				 struct ewah_bitmap *bitmap)
+
+{
+	struct ewah_iterator it;
+	eword_t word;
+	uint32_t pos = 0;
+
+	ewah_iterator_init(&it, bitmap);
+
+	while (ewah_iterator_next(&word, &it)) {
+		struct object_id oid;
+		uint32_t offset;
+
+		for (offset = 0; offset < BITS_IN_EWORD; offset++) {
+			if (!(word >> offset))
+				break;
+
+			offset += ewah_bit_ctz64(word >> offset);
+
+			bit_pos_to_object_id(bitmap_git, pos + offset, &oid);
+			printf("%s\n", oid_to_hex(&oid));
+		}
+		pos += BITS_IN_EWORD;
+	}
+}
+
+int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n)
+{
+	struct bitmap_index *bitmap_git;
+	struct pseudo_merge *merge;
+	int ret = 0;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	if (n >= bitmap_git->pseudo_merges.nr) {
+		ret = error(_("pseudo-merge index out of range "
+			      "(%"PRIu32" >= %"PRIuMAX")"),
+			    n, (uintmax_t)bitmap_git->pseudo_merges.nr);
+		goto cleanup;
+	}
+
+	merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+				 &bitmap_git->pseudo_merges.v[n]);
+	dump_ewah_object_ids(bitmap_git, merge->commits);
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return ret;
+}
+
+int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n)
+{
+	struct bitmap_index *bitmap_git;
+	struct pseudo_merge *merge;
+	int ret = 0;
+
+	bitmap_git = prepare_bitmap_git(r);
+	if (!bitmap_git || !bitmap_git->pseudo_merges.nr)
+		goto cleanup;
+
+	if (n >= bitmap_git->pseudo_merges.nr) {
+		ret = error(_("pseudo-merge index out of range "
+			      "(%"PRIu32" >= %"PRIuMAX")"),
+			    n, (uintmax_t)bitmap_git->pseudo_merges.nr);
+		goto cleanup;
+	}
+
+	merge = use_pseudo_merge(&bitmap_git->pseudo_merges,
+				 &bitmap_git->pseudo_merges.v[n]);
+
+	dump_ewah_object_ids(bitmap_git,
+			     pseudo_merge_bitmap(&bitmap_git->pseudo_merges,
+						 merge));
+
+cleanup:
+	free_bitmap_index(bitmap_git);
+	return ret;
+}
+
 int rebuild_bitmap(const uint32_t *reposition,
 		   struct ewah_bitmap *source,
 		   struct bitmap *dest)
diff --git a/pack-bitmap.h b/pack-bitmap.h
index a5fe4f305ef..25d3b8e604a 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -73,6 +73,9 @@ void traverse_bitmap_commit_list(struct bitmap_index *,
 void test_bitmap_walk(struct rev_info *revs);
 int test_bitmap_commits(struct repository *r);
 int test_bitmap_hashes(struct repository *r);
+int test_bitmap_pseudo_merges(struct repository *r);
+int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t n);
+int test_bitmap_pseudo_merge_objects(struct repository *r, uint32_t n);
 
 #define GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL \
 	"GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL"
diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
index af43ee1cb5e..6af2b42678f 100644
--- a/t/helper/test-bitmap.c
+++ b/t/helper/test-bitmap.c
@@ -13,21 +13,41 @@ static int bitmap_dump_hashes(void)
 	return test_bitmap_hashes(the_repository);
 }
 
+static int bitmap_dump_pseudo_merges(void)
+{
+	return test_bitmap_pseudo_merges(the_repository);
+}
+
+static int bitmap_dump_pseudo_merge_commits(uint32_t n)
+{
+	return test_bitmap_pseudo_merge_commits(the_repository, n);
+}
+
+static int bitmap_dump_pseudo_merge_objects(uint32_t n)
+{
+	return test_bitmap_pseudo_merge_objects(the_repository, n);
+}
+
 int cmd__bitmap(int argc, const char **argv)
 {
 	setup_git_directory();
 
-	if (argc != 2)
-		goto usage;
-
-	if (!strcmp(argv[1], "list-commits"))
+	if (argc == 2 && !strcmp(argv[1], "list-commits"))
 		return bitmap_list_commits();
-	if (!strcmp(argv[1], "dump-hashes"))
+	if (argc == 2 && !strcmp(argv[1], "dump-hashes"))
 		return bitmap_dump_hashes();
+	if (argc == 2 && !strcmp(argv[1], "dump-pseudo-merges"))
+		return bitmap_dump_pseudo_merges();
+	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-commits"))
+		return bitmap_dump_pseudo_merge_commits(atoi(argv[2]));
+	if (argc == 3 && !strcmp(argv[1], "dump-pseudo-merge-objects"))
+		return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
 
-usage:
 	usage("\ttest-tool bitmap list-commits\n"
-	      "\ttest-tool bitmap dump-hashes");
+	      "\ttest-tool bitmap dump-hashes\n"
+	      "\ttest-tool bitmap dump-pseudo-merges\n"
+	      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
+	      "\ttest-tool bitmap dump-pseudo-merge-objects <n>");
 
 	return -1;
 }
-- 
2.45.0.23.gc6f94b99219

