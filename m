Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88678215077
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760047084; cv=none; b=NqJG7YnbFosyfSq1+hucRPrPS0Ud0wRm5PImyDJlkOzU4UpQpu9TSniBLLIhOX4+ENuwA/2tFGQjs+IWj3D+CGIy3BiFuzIkcbuLI4aOMnIDIR7PL7JQokF/5m5DkzlNXiG77n6I8kCQvckI8LU1B5OEtLzKCAJ/r+bNAB0lnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760047084; c=relaxed/simple;
	bh=b/5FfmW+qs1frX41vLUkyXCEbh50ZiKJIhGnhiu2R7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kB3tBrV4alCNdMUnolKbUm5T+A5kHfP4QJNYowKfhVEqRTbXXXtE3sFgKBDir7oYNtw0qaRYruHaBOaxlVh3F3bzXATanRWykzEfzdpwrQ1gbEJKj4eTKqUa68XzSisJPghy5wXKEhlxaNcFjReHxOGpGlHRxQ8RxrILh5dzKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYSaryeU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYSaryeU"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e29d65728so8652815e9.3
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760047081; x=1760651881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACtBqHSBcK/DyoNIhoRuQIEgXk+gYvMZKRxF71if784=;
        b=EYSaryeUw0xhg+hDWU7ab8wStZiRlR0bv2RzqNzLlqR5JraoMD6f5Sk1xF1VYZ4lhU
         cMYu24AVlUZaDsI0WMrJVkhhBanV3VaVtn2L3MvJcBf3wX9TRRIHQ7ND8IAY/zQvGr9d
         8GxuqsDMKu3zgr0eFnFBU+GaUVTHUuy2/+RwkQtssyN8VQHmg2wxn4rJvuNjLQpjWP7g
         dJawx8JpHxFBZSf8MpZwosrwXjyuvsZCW7oNMhp1KFVXlTERuq26KatLp/G2erBc/Nhb
         vJs8+dosotI3NCuWnq/tC0tSfnpHnqmPVBK3rNgQwDZUzlscdORoHR6uGx5sK/PgqsPi
         b/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760047081; x=1760651881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ACtBqHSBcK/DyoNIhoRuQIEgXk+gYvMZKRxF71if784=;
        b=tC9W4H9lfD9Lv+OFwOpBqiBmkx5UZ5KDzvbxYJJR39w5hNNmaT8GfcWGD8yrk0uah9
         iTdl4i5pGXysDtkm2h8QvoOYjHuvimdlX+DkYgqNGGgn9Cu61NbTlb0PxXY+ly+FwXju
         /9jtTF7xovUWub+YkawTLq7lbGA4LtTcii35O4bYU7mpGe7wXVM2Xw1/PIKnvVJmbMcD
         W1GtadIXpfyYsm0QnjCkN9t4exrtJIRzrplm56oflqLsMTpKRgHOgpgv8R4RdJxKJI4T
         9ZwVwO7XPor3LtLxh5ss/p42tBCTTUUaOs+jHygQLod2irLUs60lkxfmxzoHkbCF54Wc
         kPnw==
X-Gm-Message-State: AOJu0YxAoaSpE0XtYP4Xcux9dj2EXPfO/r9lOe3hVYAxyfMzhvq3vO/2
	sjP1bxZLBFBHLR+hUxmaTSnK9hgHxGRqK0JCx2h2NfDwzdbWqsPDkvJh
X-Gm-Gg: ASbGncsCAWA6mIFMeMIjvj0fzvqJ87VY/Ktp0GJiIFSS0pWJqsPROB634UDJ1btFMde
	WVmMntY1rLlUjf3AaCaNzsl+yrDADm4KLNwV9P0oymQjZQzX1tbJiWVHfuxjXh3a1JbcloBglwn
	2g9cHgiJ6MOHgj4cxmAz3cFZZWL30KFMiC8NcjrCEsuf64iApCcuwJolexkoAcVZzvWDlR0Yx3U
	DSUtp1Epbd+1usjWUcJgluwXfM9aN3YuNWjOkZJ6WkuvctwNBtlqmGih+SWptv1VXhhCB1Us+rm
	IPkZRxXqfoLsq8P4CsxuJg9qw35F/ikmctGs1S/lHva859p8r90eJzvJbFlxWEKxwjX2gFxKfiF
	9MkqgR5Bm2bQXNNWeAvG8JK1AVUXXSA87qcv+ckAYB7yh9R4O/tLPQHIt6ZHZceB8NY9Jamd57X
	gvHcKdutcQRpvL+9/7MAkL1U+V9U1sqK3RqVN6LQ==
X-Google-Smtp-Source: AGHT+IGaCPvjFa5OSYKRRc+1GFdlB9hDEMNp/9R2abXVqFqDZ8Xmb5ETho0q4W+6dNb412+CuuUf0Q==
X-Received: by 2002:a05:600d:416b:b0:46e:4922:6855 with SMTP id 5b1f17b1804b1-46fa9a86398mr66995525e9.3.1760047080751;
        Thu, 09 Oct 2025 14:58:00 -0700 (PDT)
Received: from localhost.localdomain ([105.113.99.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8a06sm934604f8f.55.2025.10.09.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:57:59 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org,
	okhuomonajayi54@gmail.com
Subject: [PATCH] [Outreachy] patch-ids: fix const correctness
Date: Thu,  9 Oct 2025 22:57:20 +0100
Message-ID: <20251009215737.1196464-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
References: <20251009214445.1190274-1-okhuomonajayi54@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix const correctness warning in patch_id_neq() in patch-ids.c.

Changes in v2:
- Removed NEEDSWORK comment
---
 patch-ids.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/patch-ids.c b/patch-ids.c
index a5683b462c..b6b808332f 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -41,8 +41,8 @@ static int patch_id_neq(const void *cmpfn_data,
 			const struct hashmap_entry *entry_or_key,
 			const void *keydata UNUSED)
 {
-	/* NEEDSWORK: const correctness? */
-	struct diff_options *opt = (void *)cmpfn_data;
+	
+	const struct diff_options *opt = (void *)cmpfn_data;
 	struct patch_id *a, *b;
 
 	a = container_of(eptr, struct patch_id, ent);
-- 
2.43.0

