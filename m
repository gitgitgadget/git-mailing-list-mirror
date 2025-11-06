Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E95B1C1F02
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417359; cv=none; b=fDL4OooAN5dQbZ1kd9yxZneFnFBwVLr07Ts0y/+0ACjzeN8kuqAloIkyWk4Qj4xCdMY2SN3NtJACimEA2IOSk8OHH9FdMu0/InUIxHZSiu57FytQnCox5moq53ISJLMVdvI6MBXKYd3ueHmqW4Cug1Yy2J+Fxp8EM678qmfVfNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417359; c=relaxed/simple;
	bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kdD5c4HDCdA+UEhiI7wjgX3Wwu/lLyLrxcrt0zhx+XLUrDcYVqmj+OJqYh6NcL0rWeeYsjC4KoovJmlPHkOcO0TkUQr/ju4vW1nj69qCQBgrxfd1nasDmjXUaMqvP81D5wpGFNGzu5tYDKExpagxuFBHD1riTmddYoO18awZXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPkFHTPk; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPkFHTPk"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so998561a12.0
        for <git@vger.kernel.org>; Thu, 06 Nov 2025 00:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762417355; x=1763022155; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=WPkFHTPkgnvpDTOZwRDNpIctrK8BwVgrnmo/ha9TmHx1n2RnKDcW+yKJRRNDuZwkDx
         xoQtOu6lI54ZL7aWS1bdSNCRXyVimui03SVLGjQ4NAKuzZWa/ADDIICdPcYwbuWy27ya
         +57mVfLB+BHYj5eVyG0cjpD6aer7D4oAe2ddG8vzusBVi6+TL9nk3egpE2fTKWvwcO8z
         SfM4HkjAYX2PP/ZRjN9568GXHk0TC04Y4bfttdERapexNZMZOGWkvaU+5GwDNNGHmuII
         FtaHSlxuQPqQKoE0RCoWfkEEkaO6qo1QYltDgERAZJ+/EY2ecL3ZNtIC+0yH4BxP5p5F
         wRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762417355; x=1763022155;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=fa5qW76aMKqKDs8r8Qvi4WAxPpHMeKJdcYQkYoo+BCOCj6MyXW4AM+Q25u1fNHSDFD
         ENo8CN9/DEtFIrYyUozHEsIxbofaCLCroI1bkZ9A/3FtfbrSfqX1o6qGNR489RowUUbf
         Nj6znsEWGtzi0MzN96IFWk15D/Sq7k5K+dexlClTW8mTErCIvNc+ouBuulpKNqhr83eR
         p7RrK6Z3mSaQv8aSSU9L7eX5Cq/Vmk42dkcWgpSEkLyeUyahSTIc4PVj6hcMH0/kc+Ij
         94sdTfgl2YjajaBVCJL9f34pabDTa2DTS+D6TMzRySGpYMTOd7XmW2rqYVTOVrl8XqAu
         FaTg==
X-Gm-Message-State: AOJu0YyRA3k/MreGS/JjMxgHIdCYCmo5/8U6HakoGFHfCxVspfdWRmYw
	ERoTQNeXMNfFcrJUptwVHEc4Kx8utHN8aC2CWqngdNM6+zSA+fTPJYth
X-Gm-Gg: ASbGncuWPy0FlI/0K9km+2/aX/mbUtPTfNG/WWkAfHkji2w8kWy4EtLXAOa8ZbKagQl
	ygvdfWMeVKtjoQFZejlWLDSQXY0GN8yLbBhkUl/y5waWIVhsboy3EHJHnHYAv/BI52/qxL+4g0L
	tHSnYuLzjcOpjVZGyR63tv28S9nCeqiRENxWxZtrMVM2GiaRHexF/61IZSpuSvnaetFbx2G1VgP
	/84TXQ0n9WPlhas7+V2LK1lZV9BnG3huoM9oMQDYJd49Zwx2dQVOQtTnAlcaV1/rjyyXYihlaA3
	czzLw9VeQLOlpBG61eKzYzLZOBAzfpfFt9PFMQ6Uen3R4Y/yPuPw/743th0ENrUFTNkdHNOdTta
	sQWGhuC9Ruh6YPbjpu7Ro19v5BO9Tk9sf9MZKHgVrleJW3WnBPXDk2sNgWFwNaoOHQUYARWRx3z
	G8AfylykdUQ6G1uoc=
X-Google-Smtp-Source: AGHT+IHjbhKOGD3YHwxZcGQk8/KSsESZd63fbMfLuS8KfJKHG618H03w26s7UrRlTO1IkLxpCWfpzw==
X-Received: by 2002:a17:907:9486:b0:b72:a899:169f with SMTP id a640c23a62f3a-b72a8992787mr30676766b.4.1762417355253;
        Thu, 06 Nov 2025 00:22:35 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:107:48a1:df96:bd1c:78ca:785c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72893360f6sm160577566b.10.2025.11.06.00.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 00:22:34 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 06 Nov 2025 09:22:30 +0100
Subject: [PATCH v3 1/5] reftable/stack: return stack segments directly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-1-d611a2a95cf5@gmail.com>
References: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
In-Reply-To: <20251106-562-add-sub-command-to-check-if-maintenance-is-needed-v3-0-d611a2a95cf5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, ps@pks.im, jltobler@gmail.com, 
 gitster@pobox.com
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkMWsePvBV5DiqRs4vfKoa3GK53UzNWI9uWt
 ilk5Q0+uyZTWIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpDFrHAAoJED7VnySO
 Rox/jXcL/0VCM3qji7X8pL16sG6I/3am5wv+pZJvMr6IM8l/4K6qkgHnQWWmwWCu+jefxvxF1vX
 aWhtmnJTf/jcFqwPKkbzgHwPSV0hRLggoxG1ApoFneXbwuuc4zH3mtaPER2zSKfDtVLKKXg5SK6
 aXlPW46djf6lYCbEtsCpha66/chVIzPr/ZI2ikxZbIUWsXhP3e6JCFEj/Ml1T7G7nKb21eVnCyC
 wJWSr+Vl9WJ/PphSQLAggcxFoY39MZY6tUti3BDfI3PV2hCNxHY8Rzcw2kk4Uaki9VV8LLuxdXv
 0Z/RHlsf1B6LPjJjKtrZ8+nOJ1fQwgNzHPWxD6tPm+RrSqp+z4Fq/xsfa0LQvWt9jtlt1lToPsy
 o48VAbZRxYh6czXE9n4o/p/Hze6En3zaRsPD/3X1Ov4k+ME5ymwSVlqKZ05Sdkeyb+wLwHB3n1A
 Qkuh+U3ggaaw2n+u9d7wCTmH98v3wvLXNKOwTvYe3METyaVN5hAe6VAoacjerZkLHmTKWODg/c8
 ss=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `stack_table_sizes_for_compaction()` function returns individual
sizes of each reftable table. This function is only called by
`reftable_stack_auto_compact()` to decide which tables need to be
compacted, if any.

Modify the function to directly return the segments, which avoids the
extra step of receiving the sizes only to pass it to
`suggest_compaction_segment()`.

A future commit will also add functionality for checking whether
auto-compaction is necessary without performing it. This change allows
code re-usability in that context.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 65d89820bd..49387f9344 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1626,7 +1626,8 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 	return seg;
 }
 
-static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+static int stack_segments_for_compaction(struct reftable_stack *st,
+					 struct segment *seg)
 {
 	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
 	int overhead = header_size(version) - 1;
@@ -1634,29 +1635,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 
 	REFTABLE_CALLOC_ARRAY(sizes, st->merged->tables_len);
 	if (!sizes)
-		return NULL;
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 
 	for (size_t i = 0; i < st->merged->tables_len; i++)
 		sizes[i] = st->tables[i]->size - overhead;
 
-	return sizes;
+	*seg = suggest_compaction_segment(sizes, st->merged->tables_len,
+					  st->opts.auto_compaction_factor);
+	reftable_free(sizes);
+
+	return 0;
 }
 
 int reftable_stack_auto_compact(struct reftable_stack *st)
 {
 	struct segment seg;
-	uint64_t *sizes;
+	int err;
 
 	if (st->merged->tables_len < 2)
 		return 0;
 
-	sizes = stack_table_sizes_for_compaction(st);
-	if (!sizes)
-		return REFTABLE_OUT_OF_MEMORY_ERROR;
-
-	seg = suggest_compaction_segment(sizes, st->merged->tables_len,
-					 st->opts.auto_compaction_factor);
-	reftable_free(sizes);
+	err = stack_segments_for_compaction(st, &seg);
+	if (err)
+		return err;
 
 	if (segment_size(&seg) > 0)
 		return stack_compact_range(st, seg.start, seg.end - 1,

-- 
2.51.0

