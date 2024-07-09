Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6613213A
	for <git@vger.kernel.org>; Tue,  9 Jul 2024 05:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720503576; cv=none; b=CRmHsKlXwIite45bWYns7mMv6n4qOO2qW7zaxUMbh3iMla3qQGwuIdQm3NfNYysSv3mjMxY1oxVupEUHMgVz4bpfa5X7JzJzHDXXTWgslQhE6/wLa54XmGUue4dP/ejh/XLYlbnCcxathTvF6fGe+NcHvc+Tf9pRyZS7gwZz0ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720503576; c=relaxed/simple;
	bh=YGe8pze5q+b4jKpydQ7OkP24+FlYAGDlTUNh5OY1vlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sU6U7dT5PCYV+0o+a3faxg219yVNIJOLbI2wUkEZJTQexdDuvEmljE6jChTewvlOjLttW0qS9kK7g3sw7TkKt0QwiBjuafcjnTtqFBlqqB9EHzZrF6EgoT0hHNTsakXLc9pJESUacEq9Y4lFEjE56pxm8tRw7uUZu0qxNe2jB/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz1WWCfM; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz1WWCfM"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f8d0a1e500so4337980a34.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 22:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720503573; x=1721108373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aVjcw9U0YRb6Z7P5tNfEtoFkMcmH/GucwULlZQ3hCgI=;
        b=Hz1WWCfMegH7lGn/A6n3MWYBoZbw/j32yeMiezwoclNvnHUuOpvDMsXn7O4NdlwFca
         gN3lCwN+PBprFOfahwKGohBnGVYQ8GYqdwAxfn0w70eJ8m1DHdh9GCuobA56lQGw2nnW
         TQNeny/CPj77Bu5opIWpuGYJuYneKfPK//xW80GQZgqqo1MPImODcgS491UCYmC8Ag0x
         i0w2HZznuW4GgQQA6DxBrEpGLlMekc3c9tiRNm7D4iGA+oWwsiYfb4PVpZ1PILSG+dbg
         rB9D3Sb9Gto923BzXu4ymHg3jKL92EdXC8pqyUcyFJcj4aRF4xeDMIB7uHqVjFAzypp6
         hrGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720503573; x=1721108373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aVjcw9U0YRb6Z7P5tNfEtoFkMcmH/GucwULlZQ3hCgI=;
        b=faE5nO9u61enB1eBLDjkvEjgAvdcCscgDlO1nDyUuPcZemwHlL9vJFrR3M/rRQKdCA
         cJ+stuC4uj5F7hOYNZVFTB+qZjeT/vltUsdOw1Mys80KMwixF43x9GZYMqRtye2xOaLb
         X5RUKkKrFDC65htVJPPgPBwa4NhphRRnZ3uY7ml9TLSXouZDaxsRT+6Vi0GG6MmaTqox
         /PN3medKJy2urudDOcTjJ5ARPwN0NIVe+HF6KDgsRLMmt875wIv2ey+jHoaI0bWFuiuK
         vjB3zjA8KYs9TpWtOYKTeHC7YF94VI/i4ka7MMvE+VvQ4A9/F4H7It7MqCz4qR8KKnwN
         shkQ==
X-Gm-Message-State: AOJu0YwV+d2cgvDZjrlL4QpI39fm0QEwbBOqWKnmHmIrDRuMuhB9Bdwy
	Ze8agkEThLL+mWRpTLFWqmPBxNikBvGNOhmPCsIsfOdlqHW0uPUPxmaAxA==
X-Google-Smtp-Source: AGHT+IHFkr2Qt0ziLuQCF6F17sz/PEz4bPMuKoFbqpb8b6wh+qp6xeiqUnX+OEr8o+8hetpPVBD5tg==
X-Received: by 2002:a05:6830:1389:b0:703:5d25:659a with SMTP id 46e09a7af769-703759faa1fmr1909868a34.8.1720503573201;
        Mon, 08 Jul 2024 22:39:33 -0700 (PDT)
Received: from Ubuntu.. ([117.96.144.60])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-77d61922ee6sm718448a12.46.2024.07.08.22.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 22:39:32 -0700 (PDT)
From: Chandra Pratap <chandrapratap3519@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	karthik.188@gmail.com
Subject: [PATCH v2 6/7] t-reftable-merged: use reftable_ref_record_equal to compare ref records
Date: Tue,  9 Jul 2024 10:58:45 +0530
Message-ID: <20240709053847.4453-7-chandrapratap3519@gmail.com>
X-Mailer: git-send-email 2.45.2.404.g9eaef5822c
In-Reply-To: <20240709053847.4453-1-chandrapratap3519@gmail.com>
References: <20240703171131.3929-1-chandrapratap3519@gmail.com>
 <20240709053847.4453-1-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the test t_merged_single_record() defined in t-reftable-merged.c,
the 'input' and 'expected' ref records are checked for equality
by comparing their update indices. It is very much possible for
two different ref records to have the same update indices. Use
reftable_ref_record_equal() instead for a stronger check.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
---
 t/unit-tests/t-reftable-merged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/unit-tests/t-reftable-merged.c b/t/unit-tests/t-reftable-merged.c
index ffc9bd25d2..e0054e379e 100644
--- a/t/unit-tests/t-reftable-merged.c
+++ b/t/unit-tests/t-reftable-merged.c
@@ -158,7 +158,7 @@ static void t_merged_single_record(void)
 
 	err = reftable_iterator_next_ref(&it, &ref);
 	check(!err);
-	check_int(ref.update_index, ==, 2);
+	check(reftable_ref_record_equal(&r2[0], &ref, GIT_SHA1_RAWSZ));
 	reftable_ref_record_release(&ref);
 	reftable_iterator_destroy(&it);
 	readers_destroy(readers, 3);
-- 
2.45.2.404.g9eaef5822c

