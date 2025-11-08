Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA271F0994
	for <git@vger.kernel.org>; Sat,  8 Nov 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762638729; cv=none; b=snP9exgAwPC2e0Bxl0+fQkF3m6CAhPkOcy7C1Vx1vfKwO9u/yhCuWg72rU1QV8Nzj/h+q9do0aBLSUgZCCKv5rDzGuCKB3xEhW7mfy0HgtG6XwnVCGZ2/+ktiG1tSwBJ+BPXNl1bpqvy4jku++iuXwd8uaxQdzgzXhlF8gyyBl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762638729; c=relaxed/simple;
	bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KDoSpPa3nJbjcl8ihKMFMS04/xNM67V6lVDKLBSSI9Pi2714kiz6Ho42sRoYVqdMtmwXdrP7+Qf31L3d++7n7o0MhoqcId+4yAcm3WWTeN6yfhWJR+SwGOpgFPko/+bSG6URKtwvaZnV+lXSOTKII9MTaGErmFIV+zc7NQNkuDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHxunnmj; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHxunnmj"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso666854a12.1
        for <git@vger.kernel.org>; Sat, 08 Nov 2025 13:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762638726; x=1763243526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=PHxunnmjhhAo04RmX4XlCSNl67M7p6YHYl5pFmP3zc4RCxEUmcs0qeIDvPz5qBj9Wi
         qyhTwHrWN/68LT/wVpQf0+vBfBDn8g8H/DdWt8VdbSq43ROkkmTs8fp6lI3eOupHkVD5
         bHOkYh9xfkTuXMMEDpUdu/3NIFj+Sl7Q0gpJvw1rqy/blGXTMCDbEL4rZFiTRqW2XKyk
         wqtfCs7Xps0sKx6hIG5bhhUnc7RHaF7WIBU8c9BJO0Dpp0bDIir9YOrKeaUv+rRH3eiM
         MF0XZJd9ZZh5FsveSUlyE+59Nf//DfvIyV1YOyw1MJLpKWfCnN0UDxuz/VhE3N/SHT2H
         8vNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762638726; x=1763243526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NykvUQY1FpKBsuCy6iARb3IY6LOyKL6sHkpwgpSkMdE=;
        b=A4AZQzY6pGi7e/ozhX+/sJzT7JijJ17TrsqPtshQpAREdahDeHX8QNdOWAK8E3DUjX
         5HzYjCiBohXZ3fvbuRkJPjxTMqg5YJOWFucVkH7Q9ekW8fA19j5G0hletB95F1eMTmxq
         O1K6fe9Auh7Fqur31BCbJzhveZVV5phdczOQuycJhMhWlsgZE3jTM8WsYTenFQT3hO2c
         TyM7iiAM+mQUWXzC1B+cMGglXn8Jp/9zD+nrD2Rne9RFI7LGnmW+uTgMbAeEEaxZ1YyG
         Vdvo+X1tLqgexio5C7ppSIY90txaMrsUDLEXf0SVWJJwu3w/hjNEPcyP772YGCkIp9mT
         hGZg==
X-Gm-Message-State: AOJu0Yw7P+mNH6gXn4a1gNEsGe7LWbsw/p81vJIo0EGo24ASd5lV7QzH
	NDJ4xdKgApfebwfSKHHaME9KF/lYabvaw6hXvp1tM3tD3KNxZzNaWcbDiV0KjpQW
X-Gm-Gg: ASbGnctAJyVhmCX/bHK3XlBq5YxlHylVezr37tRkaNU/bg+AJ0gIh6o1aWoEXEZP4l3
	L/0dlOd0Lu5IHt27FlhJ6P194TaK003hpVdeH84hl5vr7eA0s6V8p4VQ+SqnsA0uRjULxYhzOfh
	891KFtCjUgArFg2uTo8WH2S+l5H6HA1LxjCNva82eeEsZfG/nXyemybY2V7dXc+Mg9ZiXllsjRS
	NPhZtIbMXJ2IIfqRxxeiiYjeu9/YTMFTocKPQ/NXEG28TpwVqbryhbRIOMGp9x+SLw4RkWvOKuT
	y7zDLmMzf8GGiaUaG306OIP0N5Eecl/pPJy3WrxmElpOKWQfw36ci1aySMA9ppX5N9FuUccDQNh
	Q1wveQYSIrPfNNuvdQDXJQF9055xjnYZRwyiWhEDgx4tmEcA7Uc78sXHoHkWeDWGDfXiPNdkrFm
	16P6Dd7R6IAaGo7Z1qK/e95s6EsQ==
X-Google-Smtp-Source: AGHT+IHPhCSqDjiFiAd1MzmWp6HZMr5vFXn/ozB0wGPBBXRlV+VUWKz+ArSxijPgr2k4461CZbueoA==
X-Received: by 2002:a05:6402:40d4:b0:640:980c:a952 with SMTP id 4fb4d7f45d1cf-6415dc12aedmr2574126a12.11.1762638725622;
        Sat, 08 Nov 2025 13:52:05 -0800 (PST)
Received: from [127.0.0.2] ([2a01:599:102:72e5:c961:8164:6be0:9490])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6415b69c366sm3056371a12.23.2025.11.08.13.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 13:52:04 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Sat, 08 Nov 2025 22:51:53 +0100
Subject: [PATCH v4 1/5] reftable/stack: return stack segments directly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-1-a90f229b6023@gmail.com>
References: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
In-Reply-To: <20251108-562-add-sub-command-to-check-if-maintenance-is-needed-v4-0-a90f229b6023@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, gitster@pobox.com, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=nXv/D0964WDF3I13tKcI4dvcGkfsN3K9G1mgppaxm7k=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGkPu4HxgbvOLAQ9byj5uryGEJshxQuuv/y/b
 001jL/ifhDXnokBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJpD7uBAAoJED7VnySO
 Rox/d/AL/1MOIrhK40YYSWc+q7IyW3Se8mNW7/2mqts2c61wSNlX2b2i5SNE359rJdKSNfAwG6M
 6oxYCyw1mvO3yOaViidlWYQNWaQI6c1Y1xMaCVVE1EknOdrpg3BpnCKfoyn+1OpfCb40uhwDvn/
 vwfW1hOAITm2S/zuPBMY1yVZZ+H8ievg07xy5DfXYjpqsTUavAehzX1l8WB/9YH3tsEXs8ZeAgW
 F+OCqHoyhRlx2J1DsfVKmZvnC0HjzGPtcxfSZHpp4pBDypI+GLqJMl5H3jjM3gWdJhAWEA0Nb0N
 heOnKks7Ms9CEXklO1JK6zL8yOe2K/GIZqeUSY6wFs5I75RcPjON1ClsNdzQNqgWVJ87NnVSwXl
 TIWSCE5W9L9N5BDC5FlJjGrfYZoOe1oG3R4rx4ilNIteL54HDnbPG0s2L3R99NOzaVsTWhpzKCz
 V07Ff9FvGdEPuUp/xJTRiF2uibO8jSymmibMLFxsgD+Dn4H1/EYNlRJGCoPpV+S9Suc+qdMxfh5
 c4=
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

