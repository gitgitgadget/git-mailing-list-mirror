Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D33115A5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 08:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762245852; cv=none; b=FeFEzPBhwBUFXNq0YqnnFEZGQwLDHUMgPHob34JAJIzuenAvbv9PcqrKA8xDV0JYJqvBMOmAt9uaRoDpYhOXznkgWh73Gf5pMeN4osLFVpdf6C+hzcDlU3UQ20W3OUeoUvw7KpZNLWvofeDm3vJZisgyjQGixw/pZk/tc+5BlWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762245852; c=relaxed/simple;
	bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qc+rW3/FJPhsn2HBNg2zPj4qMQVt6G537nDwubBAsgwB69m4dwiSgNj1VgfiEgE4eWZ0qct5aeAviG4+GjSkVnPs4qMp6ok5TX5zTQzYYYb09YosTQoCPmx//uIR0IRB9a0PES9AWC8siCm/9sC9gQUndNCtPoCODXbVkWWsLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLMGqSc7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLMGqSc7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso2201915e9.0
        for <git@vger.kernel.org>; Tue, 04 Nov 2025 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762245847; x=1762850647; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=MLMGqSc7K53DcQk7GcBY0624atoJQlDyzlY3hyr5iCjIhwBXQaHBWcu0JCA7MUtlO2
         q1O4RDa4IH1Bstp/eD6gIpsX0/L2cVazXSu3I3R7bI0e4tuK55f2eRpPPHX+aom3hP2W
         o7pTs0B3TBnVQL9wgu1ktq4dsUsaACevtx0sfoT9lnT2HvNw/X5IEHixk1eYQCMpaNzv
         WGKqrpJEECZlhubEf9Dpgoqs6JOzkP9Z5l1OoHzh8CbzQlPxDeoWk7naSzIMf31FM74s
         FnAwE4z4IxG6t1jIRoQ2iY7kyst/i/yjkYCyJ9L2Tr5PZzj7cm9HJCsxDxwYX+qnWHOv
         SKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762245847; x=1762850647;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=DX+howFS/6qqk8IaST0ISByW7jx6adYbNcGsqwXa1/LSriR44nhouy/fAvFjEBO5n1
         Iarq+SDZ4wGKJz37UuTAprYJxs5L5VvyMKuA20dF+W9m0LbslwS+0fnAejrERP4anFXf
         nDUDkOLqNV7ENgiPEHw8bkVJdltZ0VScEchvggy+aw1Jqjoa28Hwutysvz4qlHB1NuuP
         rqFf03KzKkR1XmGMWV1v3x6kwHNr5gMJMvR67sY/8r+2ag46NAoke0yjEODkN0c4WygE
         JfUaOITlVYDkdEmDrXjbimpO4UKleTDvPR2O+s8MVlHlnqpM91hoepXWp9hHGgthZJ4V
         hZnw==
X-Gm-Message-State: AOJu0YxfY9IhJHkrOQgobSHLzXkUFH8arLYcX2MJGMl3n81ht3wZCgTY
	ci6rsQLH34gM/YDeAOfj+iuIpsd5Q8RXFmRgzqbysPhIdSFj4Ws6uZOh
X-Gm-Gg: ASbGncvX6qUWy3s8mkZ0LJeJ0fJzDIZl5pO0DIFgv5NSy8ZJEoHTJoMmcEiAhVNvXrt
	bA04Ntv8zwAUlOTVS1dluKT2Icimbeo6GzZUS9clE5RvlWKVGZyA13hHMg4vyMQ1BFYLNC2dNXQ
	U95I2PfYZCV/rSPm7Y1m/ql5gE3TEfx/KkFUBAW1lD+zMLT0VfqvH5yaW/m5xpKyxXxO/anMZo2
	3/2rpnOrA7ZkqHCfxzb5WmkeekRtqnd98x+ZjkmFgUWRhga5MWDseBqrqPRiIgw3CcIoLCQuc2f
	Frn7QU6SaRE/+9vPWxRgaJv7QHrJcDkg3ASm9fgJh5meRNXudez3R1rGsDBDgDvu6SuaKFUofN/
	08lJmXM02Hw+iQ4Uu7Y5FdT5S6dxmayHekTG22Xu+P8fqsOxN+vwIEZhcT0wuktCpzSOu39MurM
	TxTM1q
X-Google-Smtp-Source: AGHT+IGTHIYz1CyrHIvI20zEfFDduSL2/1uPanhTS40TqUXSKKv4TA4au153s5yTl/fhp7Jc8JogVg==
X-Received: by 2002:a05:600c:828c:b0:476:651d:27e6 with SMTP id 5b1f17b1804b1-477308a8967mr135705685e9.36.1762245847208;
        Tue, 04 Nov 2025 00:44:07 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:b03:96aa:b9b4:f746:b8e9:7f4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm193379035e9.13.2025.11.04.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:44:06 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Tue, 04 Nov 2025 09:43:56 +0100
Subject: [PATCH v2 1/5] reftable/stack: return stack segments directly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-1-303462a9e4ed@gmail.com>
References: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
In-Reply-To: <20251104-562-add-sub-command-to-check-if-maintenance-is-needed-v2-0-303462a9e4ed@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkJvNSO6//huNgbqV6ZdlOO1cRS6i1JvPKt7
 PCo7d9tBmfdJ4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpCbzUAAoJED7VnySO
 Rox/51wL/1P+T8VNemm2Sb30DzzLs5j/QcQncZgkYcFvoq1gK5Ce3wVR/NXawHPN3sKYDe49RTv
 0iM7R8qDCVjwx24aKA03SXCopdWgDhfAbVvKpX3sVbwlJB4r/mYskWm671nkKhM+gDGCoqzRQXs
 itCUPnnkGNJm+YLOz2L6yqG9IJiTSXw/AvMzLv07vTDs+2Q1ug01UQ1W2zhiobVd0oRpOhIS1Jp
 jhMIgTxoQHwhUoEhb0E8A2fo+9rtD4aDLQI2nv9NxUaCEKG3a28Mr4/04yLnxZL6AVKOfh36ovk
 o5lbp797nuBPOblbjyN62Fm2zml2sZIugzlGVHlQmtMYOH4ekbrlrqD39wFQNp+w5r7stsBaQ6D
 3e3SuOB1uvkg49nv6VmAFxmE/N7JLl2IndcVPi7uSX4jlcwA96JGkz6bLcuXqBLFd2HOtDTAurY
 otZKgRK2HZxHxWlopz7CwXw6bhBUso7/oNmZNaHFOSJYwxAejvwsOidngox0sVWIRq/qx5vtcd7
 Ec=
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

