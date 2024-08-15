Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B78414E2D8
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 21:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723755719; cv=none; b=XqhwIAjdWRNIv56e4m6M1D0iOGmD9OYyQah8p/tkQ8bgbolx4IXzuYwuvWhSxfcY82GB1//JXeLAebJ1tZHHKj5ACtIVLMrEYHTJzrG7S9kn2TujMO3ohaN8z05Y55pq5NOUJt9lL1WXZ32+g/hwoV8VQXKh+KkcEmpX3pBd5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723755719; c=relaxed/simple;
	bh=L/kx2bVz2U8MLc2sJPAacU3PrkSp0Ga/+8N5iUelGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3olOf1YWe+sI2wig34X0tFzuER9LX7+ZdklflqBiCyoe4bNX67krcPhmrIFkc757L2kI8igb07mSDHFBVn6xsPWSvEYIBudxX6orI+cjs9IHxiboiTrX2r1OKEt6KwEak7Ke6yiqp/om6NsalbqvYdo5kwex/nWye7OpCtaMjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=idil5nhz; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="idil5nhz"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-69df49d92b8so13094187b3.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1723755716; x=1724360516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BP9XtWEMOUHY4a+xwD5V4Twc3Akc76s2qr/cq3q+gvY=;
        b=idil5nhzRhwIO+3ZqCny7IrjbAPz2w45eDYzXX1N+i46Ceg3VVFhzAmJkVkZn2CpQf
         vFENZnO/7zgNEEEigPNTab27Hct2YeQZGmJBrpTjCUyO7rkbbwqttl4iYAiDn53h1hXV
         lkAnpyHygqNKr7BcyKAKLpd9jXLC0kVpGvrNSfTItcOcTI0U9Ap4Q71EyxVIjjhXUEQi
         RPD4Ky13qXBoU2qr5UKkJjthipoxkCA6SuOXxWpIr/fkujRrrIltodBXE0HsIErHw3ru
         rFpsAgqqKAdmtjLKnbJwQrZz17SU4clwjgogtbKUNUBcab0SLVEqTAOfiDxxxF5+5hYh
         fsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723755716; x=1724360516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP9XtWEMOUHY4a+xwD5V4Twc3Akc76s2qr/cq3q+gvY=;
        b=nblJh0Md8hANYsDY4NzZQsK8aIqr10V0VDWDsk153gWgFSPMva97tmrAs9rBALVxrB
         LbuhUIQMBMKyUeW86sm7+6boyPeLrs1zOOLjQXu6KRGsTF/GjVFi8/VR9AadlqLdi4FC
         uNm2zx1esDmbdLkNJ0n7r/CeqVHzW/MMZjGgB8kUG63nRiJUP3PEJzpFjHHMZrmgua8G
         pqHZic0u+tCix0tXID15SHURa61RBdqmU2Vi7G5UQ/rQd8nCVJqNKFGJOn7krWhv3Wd7
         2/rd641KaI1JgSbZiNxvYa2+WOmfcw0ITMwYXV7VJqlpHEjIYwo9f24mdz1CpbMKPI6A
         e/fA==
X-Gm-Message-State: AOJu0YwC4Y6tI5N71q5bZKIaNC8a0RX9rntz/avpBGrVQTxrWyJ1u57x
	Y9sS3uJ3ejwr78BZ9ko7vdK8t9qB6TB2zbo4601JaZojuz0W4GJdX02ns/GjDnZBXzrUMzE9GHb
	V
X-Google-Smtp-Source: AGHT+IEElagtaxsxzGVI5ZGRd5RlG5y1KvNrucBxERT8rUxGDdmFbKA5qxqPIO1KkDTwf/0j/zLOKg==
X-Received: by 2002:a05:690c:6a08:b0:6ae:59e5:5f37 with SMTP id 00721157ae682-6b1b823f19amr11541127b3.13.1723755716321;
        Thu, 15 Aug 2024 14:01:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6af9e0e0e1fsm3931687b3.133.2024.08.15.14.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 14:01:56 -0700 (PDT)
Date: Thu, 15 Aug 2024 17:01:55 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/13] pack-bitmap.c: use `ewah_or_iterator` for type bitmap
 iterators
Message-ID: <59a50a2ea24312eb5b643927aac3fa7143b838f5.1723755667.git.me@ttaylorr.com>
References: <cover.1723755667.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1723755667.git.me@ttaylorr.com>

Now that we have initialized arrays for each bitmap layer's type bitmaps
in the previous commit, adjust existing callers to use them in
preparation for multi-layered bitmaps.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e1badc7887..9fac43749c 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -1622,25 +1622,29 @@ static void show_extended_objects(struct bitmap_index *bitmap_git,
 	}
 }
 
-static void init_type_iterator(struct ewah_iterator *it,
+static void init_type_iterator(struct ewah_or_iterator *it,
 			       struct bitmap_index *bitmap_git,
 			       enum object_type type)
 {
 	switch (type) {
 	case OBJ_COMMIT:
-		ewah_iterator_init(it, bitmap_git->commits);
+		ewah_or_iterator_init(it, bitmap_git->commits_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TREE:
-		ewah_iterator_init(it, bitmap_git->trees);
+		ewah_or_iterator_init(it, bitmap_git->trees_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_BLOB:
-		ewah_iterator_init(it, bitmap_git->blobs);
+		ewah_or_iterator_init(it, bitmap_git->blobs_all,
+				      bitmap_git->base_nr);
 		break;
 
 	case OBJ_TAG:
-		ewah_iterator_init(it, bitmap_git->tags);
+		ewah_or_iterator_init(it, bitmap_git->tags_all,
+				      bitmap_git->base_nr);
 		break;
 
 	default:
@@ -1657,7 +1661,7 @@ static void show_objects_for_type(
 	size_t i = 0;
 	uint32_t offset;
 
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	struct bitmap *objects = bitmap_git->result;
@@ -1665,7 +1669,7 @@ static void show_objects_for_type(
 	init_type_iterator(&it, bitmap_git, object_type);
 
 	for (i = 0; i < objects->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = objects->words[i] & filter;
 		size_t pos = (i * BITS_IN_EWORD);
 
@@ -1707,6 +1711,8 @@ static void show_objects_for_type(
 			show_reach(&oid, object_type, 0, hash, pack, ofs);
 		}
 	}
+
+	ewah_or_iterator_free(&it);
 }
 
 static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
@@ -1758,7 +1764,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
@@ -1775,7 +1781,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 	 * packfile.
 	 */
 	for (i = 0, init_type_iterator(&it, bitmap_git, type);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		if (i < tips->word_alloc)
 			mask &= ~tips->words[i];
@@ -1795,6 +1801,7 @@ static void filter_bitmap_exclude_type(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -1852,14 +1859,14 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 {
 	struct eindex *eindex = &bitmap_git->ext_index;
 	struct bitmap *tips;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t mask;
 	uint32_t i;
 
 	tips = find_tip_objects(bitmap_git, tip_objects, OBJ_BLOB);
 
 	for (i = 0, init_type_iterator(&it, bitmap_git, OBJ_BLOB);
-	     i < to_filter->word_alloc && ewah_iterator_next(&mask, &it);
+	     i < to_filter->word_alloc && ewah_or_iterator_next(&mask, &it);
 	     i++) {
 		eword_t word = to_filter->words[i] & mask;
 		unsigned offset;
@@ -1887,6 +1894,7 @@ static void filter_bitmap_blob_limit(struct bitmap_index *bitmap_git,
 			bitmap_unset(to_filter, pos);
 	}
 
+	ewah_or_iterator_free(&it);
 	bitmap_free(tips);
 }
 
@@ -2502,12 +2510,12 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 	struct eindex *eindex = &bitmap_git->ext_index;
 
 	uint32_t i = 0, count = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 
 	init_type_iterator(&it, bitmap_git, type);
 
-	while (i < objects->word_alloc && ewah_iterator_next(&filter, &it)) {
+	while (i < objects->word_alloc && ewah_or_iterator_next(&filter, &it)) {
 		eword_t word = objects->words[i++] & filter;
 		count += ewah_bit_popcount64(word);
 	}
@@ -2519,6 +2527,8 @@ static uint32_t count_object_type(struct bitmap_index *bitmap_git,
 			count++;
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return count;
 }
 
@@ -3046,13 +3056,13 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 {
 	struct bitmap *result = bitmap_git->result;
 	off_t total = 0;
-	struct ewah_iterator it;
+	struct ewah_or_iterator it;
 	eword_t filter;
 	size_t i;
 
 	init_type_iterator(&it, bitmap_git, object_type);
 	for (i = 0; i < result->word_alloc &&
-			ewah_iterator_next(&filter, &it); i++) {
+			ewah_or_iterator_next(&filter, &it); i++) {
 		eword_t word = result->words[i] & filter;
 		size_t base = (i * BITS_IN_EWORD);
 		unsigned offset;
@@ -3093,6 +3103,8 @@ static off_t get_disk_usage_for_type(struct bitmap_index *bitmap_git,
 		}
 	}
 
+	ewah_or_iterator_free(&it);
+
 	return total;
 }
 
-- 
2.46.0.86.ge766d390f0.dirty

