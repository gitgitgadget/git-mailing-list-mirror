Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624A2EDD74
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092041; cv=none; b=Qg3/7R4mi0OsJ9hcu7Q9BaMyLDsFy67sGBjQ+xABoNB+iF1DQ14bGTd9jHFpjmyUdp12sPrtrIQk4dM0XnDp23/za5e6bncLzE9cKAzaVZSZyB3g8HAhiW9CozgCglkNJCdu05/D14OlrWeZ9Yif3UaLVEYCxJYWGwc7cXsAnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092041; c=relaxed/simple;
	bh=zua7ilbCHpFNF12Ra3UwKnqATx2EjHG5fzvz+g4Dx3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IcIHu+3Oijykxt0skJfkkLQuinjIR2t8abUK0hRc4GiQxSMZHRtmPiuOnpFlSrFf6XTQQiqoxyYCnkDKCC5yfL96QPgcixy82jyt4e6BhUSveICQa7TkBUkwB8tFiiyIhXxbyCnHV0qd85RWHrjyeAgVQqDqpdGROxdo6Z6lZCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBVwA0x6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBVwA0x6"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-636535e4b1aso4465915a12.0
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092038; x=1760696838; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UFeQnvznQXTTyHMGXlCuyPXuUsjbdZn43C2bL5p06g=;
        b=LBVwA0x6/Btm0ziTHAvt60smn/tdCC6xWyd1BWD3WBSk0tYn7oRxiEJzEKXU4FUO34
         6l9gbOacZD/ntpyhUINqne/TT4PGaHZs3hLUXYUTZpJ55A1yIIntT6WgAWaOSgaXfff8
         TzH7nrPXdvvg8JrVN8CpCu3BWl5vi+E4DfyXAADgagnCiwDQb2SguDCpkYn0jprDFtp6
         AmfcGhL+nS4rGBs1bqpXaIwnyqcWB5iUlNDk7h/ZWo6+R3M8+XTZSsAveHi5Ut4xraoA
         fvqw9MbzFG9Zv9mN9QcvufAZJtYmGfPm2dQlpIkZrZc6xahzIdobwrgSHKKfm4RBU6Gp
         aWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092038; x=1760696838;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UFeQnvznQXTTyHMGXlCuyPXuUsjbdZn43C2bL5p06g=;
        b=RFvdExXA9WHAt1jWcdwEhVXLNIpwYenlrTaW1lg4+1eP191DBEESCFWEhZeMLdZLmt
         TxUBq9ulIsMWuNLB3HARayNs+tsOgm7EHu/4MhTuc4e3WffS4qWMuf6T8tM6iv5kHm9Q
         90FaNJPMwERXePQvwqs2V/8kGJeiKtc7q4sHEMj/WB22cnYGfhZZ5xY+XMj9cHbkxnEy
         4hHitaDmxnBwNvTruDOc0NIj/snVlDIJZZrkUaCfc5OmlVNqh/YFyd0CAyg0d4VuNMVg
         N2lkeGj3ACiAUpP+3ADKOyETslnNjAyRgwDTOmdgoNhVkq5uAbvb4KvjKy6EC6M3bGz1
         KOnA==
X-Gm-Message-State: AOJu0Yy8lQR/RpYOysGW8WHScA7xEoOskOjc2utujSWc96TNQ/qVVyeA
	TScw6m2NaIuKkiGhGZbnQZmYJmLZ2uorSEy42/8BLVpDS26hyZ3FCFWltW2Y9RLQ
X-Gm-Gg: ASbGncuw8DTpbWtaD5SrbhAJPRoyxI4PquS5MrXtIJovnulfWySktQEnhTcGkhnLyxM
	3wkgfbtAQclaRoAhQVGgRPeCW3cFf1T4R8CUo8OIQfsSVy1iqYfTs7a7VkA/fV4nqxjkDWZZ612
	Lhb4tlMMc9+sG5WmgjlsvCoC6CP5g/vacjPYV3sKhJ/OsXCbpW6U+K3P1lXoi1oF2jAa5UBkQZk
	ykzVHwc6UgCOZ3Ep/zEfs6hADw5k396OnC66uoGY1dtVy7Bsmei4+m1s2RFY927EYP2M3SxVd0z
	YFOo8A9fvJd6ZLLT4vWEvSx1X66Olb6QUWjxtusXVXIrYSY+0PXYhQwG+bAoTfgGp638u2Jr2B9
	/NIEOUQggP5zgJxWBCaKq2+9l/49k8Bb88YvxV4eh82xwM13tylzwsKa0x6HWogzVTrk8
X-Google-Smtp-Source: AGHT+IFLU0Sll8tf1feoLDyOoM/726L7Vs3A7w6aZbrzweOI6KvrRBZqJsZk2mYqRD6426+2oLVH6g==
X-Received: by 2002:aa7:d45a:0:b0:62f:8bad:76e5 with SMTP id 4fb4d7f45d1cf-639baf07534mr10921636a12.5.1760092037618;
        Fri, 10 Oct 2025 03:27:17 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:17 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:10 +0200
Subject: [PATCH 6/9] reftable/stack: return stack segments directly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-6-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2355; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=zua7ilbCHpFNF12Ra3UwKnqATx2EjHG5fzvz+g4Dx3s=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo33/UI1/tfYmBAJgl0cLK3M+a0leJwBkuy
 F3dOJ5UlW+tgokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/+Q4L/2DypFIVMtjP7icuwnFw8sR07MA6TEREF0ogFoFj964uSZ8nBurRYCSCxz2jaJ9d8Bb
 /es3nw217q3AREbs1b4oJK+1bAZnUsKVp0yLpNwZSgfX49f+11e67uRuXNZf6aF2ZuWsIOv6qeC
 oE1Xvro9n+wIJWnMv/dpIePrsVlCA0nLkHjYEjMszF1+hGc0yKRLEhh7sD/a0rsCEuyMtyeab2b
 hwDCkkVcoodUlpvo+eryV9SK5mjNHdopuUYBRmtD5lpK91g6kBxcLC1ucbqLCmorgNSY05F4XkV
 cjRCdWOJj3mwyF6LR1BbhiQ4I3jHg/5irTv+XIN3zACbGsTxErf4+qWl2vVEuwq2en//Yjy8XhM
 zwlpyuPOqRUxNwiIWGLZregijxM4aFLQAkvoxp1S8/Yp3FQDWOrPRAZHERIpsW4IVXstozjVWDd
 6yrxTe8CcUiful32EVkcin2FL3ouniasmR9s9qif3rV8JZKbcLa9WKNI5qQsPLsT37gOnIjpRo7
 qo=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The `stack_table_sizes_for_compaction()` function returns individual
sizes of each reftable table. This function is only called by
`reftable_stack_auto_compact()` to process the table sizes.

Modify the function to directly return the segments, this avoids the
extra step of receiving the sizes only to pass it to
`suggest_compaction_segment()`.

A future commit will also add functionality for checking if
auto-compaction is necessary without performing it. This change allows
code re-usability in that context.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/stack.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f91ce50bcd..9d9326ce0e 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1631,7 +1631,8 @@ struct segment suggest_compaction_segment(uint64_t *sizes, size_t n,
 	return seg;
 }
 
-static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
+static int stack_segments_for_compaction(struct reftable_stack *st,
+					 struct segment *seg)
 {
 	int version = (st->opts.hash_id == REFTABLE_HASH_SHA1) ? 1 : 2;
 	int overhead = header_size(version) - 1;
@@ -1639,29 +1640,29 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 
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
+	int err = 0;
 
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

