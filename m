Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C8C2638BE
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 19:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739388605; cv=none; b=gKcYBknfGwTiQtR1kzk0WSYitVbXptWRlKJmucU8pkr3yqJeDb3JOS4dfoboWrc+uhOQraBbZkTu7P/ckAS0xfwiAo47faWWcmvfwt4rguTktaBP4DWbdYX3/Dr2/xZI+oNAT61waJcl29G4nwBsGT/F/e/+R59xiEZf1Yrqb6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739388605; c=relaxed/simple;
	bh=/pJCAxrvgdO//7bU1EyBuCElKgpm3kB2S0e0KUrPbdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxcTPb+EX/yRWvmV8IxB536dY0x9m7kfjiYT97bnTkELo8nKP0r49Ur0qxg2C9jnC2T4MiGqvRT9JKFS0lEksl4/Sx29qfElgTmlNBHEeVF2pAuAENf3/BJb4Idrrxc0/9qOPLv0NaJ5SXta3NmwKREwi8vUeQmvxXlOYZxHbBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5st2thv; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5st2thv"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21f40deb941so579025ad.2
        for <git@vger.kernel.org>; Wed, 12 Feb 2025 11:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739388603; x=1739993403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Nqc+8U7T+RtRudHqeUCOS/eqfpd9WZi/8VVAsOzDno=;
        b=R5st2thvy7iP9ki2e6m4ToqJVnOc6wEUbs+mAyWiBa5qE2RPpqceKRwYyS+6L+6sfY
         V7mRMUVaga5iLtjOYHWMJuxBMOohcpMR9ev5rfVtI8JmJuBMOVAitdtPlHnM8EpRYZ/8
         leaHEXkVVVBij/xHKFvcpglGeEI0PysMT8r6JzzqtuYgls0u9maOGZZGu5DMkefOGwV3
         izfidMrkGa7V/BnjRtTZbh2gu94We0oWTsjuYXk+IEp9KnwOWidN6bcM/OpVrmYFOFN8
         fg5PCIwyGwG/xaMxCraAOddiOdDCDBcIYKuvQUVIpp0cMjfbzhIPnBp89i6RoTVW1Q/y
         6QDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739388603; x=1739993403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Nqc+8U7T+RtRudHqeUCOS/eqfpd9WZi/8VVAsOzDno=;
        b=NTgoF/DMoLMK+AzSJR7ChVAKazm0X3C8KuBpMZbgXDUJ973aOW1li23U7rBhgl1wKf
         7qq84yoBSLpWUYxUmkwrCs+30CmgewCzDr31KNGkeGNHECovqsjKtut+Ul/wBoyRtA54
         VL3qUzV9Lm6Njff7pzsvB9fyLhU693GjWkC5g5H2/I3hJjawVodZA7icIPk7EsGxiDCT
         ll7YOT7r4T0KYDfSmFNnMaKtKxOPMHxphO8Cx5C6YvfKzkHm1ay711cl8hIwzsj58YPA
         BsJg/IlRi0/4yUeHPWj+vQfNmS7ghXiygPZjrO3pbiEUTBDVL61dbxyUndp03LLgBDZH
         E1Rg==
X-Gm-Message-State: AOJu0Yw7ltPlO5fIwz43+l1hJy9cfqE+WL+EtYJYgQlZhe/KmywXF7nO
	918tHT39jQeYjrpTpqEn4OdMuP4bqhNdpxb8oMzKYnIiSS0Nqpsb2RJMXg==
X-Gm-Gg: ASbGncvSYqK5kNyK/x0HgMMuKRsSUxH8Qaa3x8RFH/SQKFCHQRV5BNGKgugWPar+jhK
	2X50lsRE6U8bYDQTCSrrTsl/GilhRtU3gMITgF8daCupOMxsLywOEwRX+Cj+bayOtnq9LA4ZYDL
	wNb5Y/6GlFuEcWF7pTumkMC9xbQGCHgPJMuqR2S46iiyBDleKIU8dFrqRBOBTI4aGxmnU9F9swT
	la67RC6wfBcH8GFKhriQBT3y98bxJ9sQFey9xEt0kV0gQipj7i8nqzZZ3d8DRrmoHQCerBinbVh
	pygwy5nsU5ci61t1LBAdlMEULkDX
X-Google-Smtp-Source: AGHT+IFM9HbEWxAWIfb3rRoCpYAVuzAr/PS0Lu9hlhpEtQ4wbaoWHA6WlLY7oc2Ie49LUFRol6Ouag==
X-Received: by 2002:a17:902:d58c:b0:20c:6399:d637 with SMTP id d9443c01a7336-220d2132be5mr7675825ad.40.1739388603045;
        Wed, 12 Feb 2025 11:30:03 -0800 (PST)
Received: from localhost.localdomain ([171.60.232.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650ce87sm117633245ad.36.2025.02.12.11.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 11:30:02 -0800 (PST)
From: Moumita <dhar61595@gmail.com>
To: git@vger.kernel.org
Cc: Moumita <dhar61595@gmail.com>,
	Abhishek Kumar <abhishekkumar8222@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 1/1] commit-reach: use unsigned int for flags in paint_down_to_common()
Date: Thu, 13 Feb 2025 00:58:40 +0530
Message-ID: <20250212192841.8321-2-dhar61595@gmail.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250212192841.8321-1-dhar61595@gmail.com>
References: <20250212192841.8321-1-dhar61595@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `flags` variable in `paint_down_to_common()` stores bitwise flags
(PARENT1, PARENT2, and STALE), which are defined as `(1u << N)`.
Since these are already unsigned values,`flags` can also be declared as
`unsigned int` instead of `int`.

Signed-off-by: Moumita <dhar61595@gmail.com>
---
 commit-reach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-reach.c b/commit-reach.c
index a339e41aa4..a4aaae2737 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -79,7 +79,7 @@ static int paint_down_to_common(struct repository *r,
 	while (queue_has_nonstale(&queue)) {
 		struct commit *commit = prio_queue_get(&queue);
 		struct commit_list *parents;
-		int flags;
+		unsigned int flags;
 		timestamp_t generation = commit_graph_generation(commit);
 
 		if (min_generation && generation > last_gen)
-- 
2.48.0

