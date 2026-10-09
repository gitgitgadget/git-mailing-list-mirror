Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1C4E234D
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558567; cv=none; b=Ur5F1jY0QdH4sI+rl88yo5kFusN32uqQqPIdSr7kMPQ0c1Wpw4oadlZ+45rnATcnW6boPUgmNZ71tdDXfCzWmznz7KL3OUqrwzDsEN90r4hUG81eFkC7e5h4uzWYgMOyq+ZrepbuGvwy8+SEm+7fxO0CIw7mEuLufqL1LpIfQkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558567; c=relaxed/simple;
	bh=PYwJxQmrr8WVlVkzeEFSWRMUGKlOVuulyHjYuVd0P3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdQ66E3l8l8QXtLImupxG+u0pnbyUcvCb0rRlSU1/TgMAaLbzsbbAUahgvTAL5XX+IWINBRwQIoZP9FEo+o8DTgHl8nY/Nb0JCLXMuNCTX/4kOsYzWOeBFbV0YctugLWW1VtIb2MNuSlgPjp+WBQtuJSSvEb4u4DDQffhROqHNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+qlljUz; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+qlljUz"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso2962884a91.0
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 08:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791558565; x=1792163365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3S3e7w6fexUwo0VHKzhCgqgPN0S44icaVB7ezlFEidM=;
        b=G+qlljUzP0i2kW8bC+GO3lGk3xypmuW0TyCnv9NLcm8s3EVaQFd47Tj1dd1qm22f52
         9fAvYoBayMk6M0D6ZoTVN3E01rO+9WmGcRSjqOV9aX9p6oHeWKbDSv88oHxRbs2gDRMN
         3ZWLEgyTbeoxXB/QKyM6KaFXp//H7Wq1W18AWReEGeHLNaEVkiQovUiBvLrkVzA6F0vY
         6HIML21e1VTodVV173t8NBKZApdM0WwfDVwea2EAIfieSh1DM6dIZzHsQWQCHkOQSB+a
         NwH+GdFwkyT+0EBoF411x/PwbbUh1IESingTOdjoXof+CKiI1JGFeb4ArjoxXxbdY3zC
         Rn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791558565; x=1792163365;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3S3e7w6fexUwo0VHKzhCgqgPN0S44icaVB7ezlFEidM=;
        b=aJVGoRk6Z9nrkou6Dv4XX5zHjG0gWJ7pgAgxvQ72hz6kM0MX7P8GwJZl7DmhV6Jqcw
         v4iev/1Dg21EHFOc7zaEtrdDf9eNRD9ImBv4qD4KTfyuoaxIjEKbqsMVJS01Lj/Hq1eo
         0mTZyF+VUZY7EBZ56UvrXTcJp37jmnWAPSy8jboK2gulOgETWt0mjQGdxYF+vVaOGic4
         lmcse+wwe8uG0Y9yv2DFQTiNAiZyRDg/65/+7u+HBtEGHNCXoEw8i9yH8tl7JM4I/GBt
         FCrMhOPANz2ZFRPL3yoRtkTtjbWVBzJi5DUY9GNdKUoqckq2NwNbr9YPQtek5i0z+/xK
         bkZQ==
X-Gm-Message-State: AFq9FYKDVVkpqsO7IjJeCOmSW0Y4t90NZkLgPJaQhWVePpFxzteXUfeG
	eefE99MTIyC6IuaNcRcKAMVcKRMmLbgVNKXALFcMK4/0om4CcxMNoZKRVYy0/HYyURM=
X-Gm-Gg: AYBFou17kAf4wo8Ri3uJbwF3CnsOs11hVo8pnHwh0Rw+EBD5Vqh59hwaQB2PGaD/F35
	AsDTHqLh//DD1Ifw9AU23CMUt9ogOhaw0ooB6Y7aNXoe7qXVuXAI7jXCmJdPhYZBH5qvrLHABMa
	COh9NWIb1cqkp93KlY0fmfrZraWYq9mbV1fjJmRsUxcdZW2qMsAUhu0cAhKcfEbekHYTT/Hubt1
	6PiTU+L6A4SY+ujRxO6G2kakkxw6mUgGtKNgGafXJoR8hs4guFZ8AoG9VLqQliHq+diV2Qum84J
	XoKN/1T/mwarapFw+hTsHfyHmHfkfevKsjjqL+o5XuJLZfhO+Ges6ITIA77RJH3v2C7tIZM330Z
	UvzVUnkDOCN3AncaGfgHUwWNWR49SY9RKG6W6Vxw36/W+YDXezMkQnWfdpPUXhvBO13mW5ATNOC
	gT5QEArvFw5cMkGCyyiU/4ksurJ81ZkTPyJzDHw4sn2RQgr/ZNltxfMCnXM/gpp0sKVsPEsmrL2
	TVk0QA=
X-Received: by 2002:a17:90b:4b92:b0:3a4:a525:56fe with SMTP id 98e67ed59e1d1-3ab3a359f94mr2180940a91.5.1791558565340;
        Fri, 09 Oct 2026 08:09:25 -0700 (PDT)
Received: from archlinux ([2409:40f4:3151:37e2:36ef:bf3c:7f30:217e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da03f449sm1113553a12.28.2026.10.09.08.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 08:09:24 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v3 3/4] mergesort: cover empty and small lists
Date: Fri,  9 Oct 2026 20:38:49 +0530
Message-ID: <da42c96904489fcd37506916d5aac5be197df382.1791556668.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791556668.git.dilsheddilu123@gmail.com>
References: <cover.1791365181.git.dilsheddilu123@gmail.com> <cover.1791556668.git.dilsheddilu123@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The existing tests use at least 100 items. Add empty and single-item
lists, reversed and equal pairs, and a small list with duplicate values
and integer limits. Add two sorted runs whose values need to interleave
during the merge.

Also check that the debug version sorts a two-item list and calls both
the get-next and set-next hooks.

Signed-off-by: Muhammed Dilshad A <dilsheddilu123@gmail.com>
---
 t/unit-tests/u-mergesort.c | 63 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/t/unit-tests/u-mergesort.c b/t/unit-tests/u-mergesort.c
index 50bca1db46..1a5c0a60a8 100644
--- a/t/unit-tests/u-mergesort.c
+++ b/t/unit-tests/u-mergesort.c
@@ -9,6 +9,11 @@ struct number {
 
 DEFINE_LIST_SORT(static, sort_numbers, struct number, next);
 
+static int get_next_count, set_next_count;
+
+DEFINE_LIST_SORT_DEBUG(static, sort_numbers_debug, struct number, next,
+		       get_next_count++, set_next_count++);
+
 static int compare_numbers(const struct number *a, const struct number *b)
 {
 	return (a->value > b->value) - (a->value < b->value);
@@ -103,3 +108,61 @@ void test_mergesort__random(void)
 	for (size_t i = 0; i < ARRAY_SIZE(sizes); i++)
 		check_sort(input, sizes[i]);
 }
+
+void test_mergesort__empty(void)
+{
+	check_sort(NULL, 0);
+}
+
+void test_mergesort__singleton(void)
+{
+	const int input[] = { 42 };
+
+	check_sort(input, ARRAY_SIZE(input));
+}
+
+void test_mergesort__reversed_pair(void)
+{
+	const int input[] = { 2, 1 };
+
+	check_sort(input, ARRAY_SIZE(input));
+}
+
+void test_mergesort__equal_pair(void)
+{
+	const int input[] = { 1, 1 };
+
+	check_sort(input, ARRAY_SIZE(input));
+}
+
+void test_mergesort__interleaved_runs(void)
+{
+	const int input[] = { 0, 2, 4, 6, 1, 3, 5, 7 };
+
+	check_sort(input, ARRAY_SIZE(input));
+}
+
+void test_mergesort__mixed_values(void)
+{
+	const int input[] = { INT_MAX, -1, 0, INT_MIN, -1, INT_MAX, 0 };
+
+	check_sort(input, ARRAY_SIZE(input));
+}
+
+void test_mergesort__debug_hooks(void)
+{
+	struct number nodes[] = {
+		{ .value = 2 },
+		{ .value = 1 },
+	};
+	struct number *list = &nodes[0];
+
+	nodes[0].next = &nodes[1];
+	get_next_count = set_next_count = 0;
+	sort_numbers_debug(&list, compare_numbers);
+	cl_assert_equal_p(list, &nodes[1]);
+	cl_assert_equal_p(list->next, &nodes[0]);
+	cl_assert_equal_p(list->next->next, NULL);
+	cl_assert_gt_i(get_next_count, 0);
+	cl_assert_gt_i(set_next_count, 0);
+}
-- 
2.55.0

