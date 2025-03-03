Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695FF1D799D
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039311; cv=none; b=hL7Y5y8vOOImKZINACGjyo2sugjm2tJLX8zZnPjXcmwzVfxc9rGr2CE29URqJfpy44Rl4hVXNHx9Q+ft3+3fxZ13NDBvyZSopee2OdiNJ0SM6h0X4Op1oQ4PFJZo4pX1jb6gInna6chMMzMrzlZyPtmMkz2t+3UpFZ/zinbUZtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039311; c=relaxed/simple;
	bh=R4YTWUoJ4YJra0NSaBqsMU2sC5GQkO52K8swbH3mor8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4GMuOligWUZqKaRqKZP9ijfHtIObr8+FEUqnF6BVVSP0jdNZYPpW+QfgSCwpULYdplDO8PhhplyjIjM7nDIWnELqrch5/dqUU8osRz3sEOQb14NmP+oN1LZfqkNeVz6UUjHyLd/HhVyjCtGHrLl7lRWISr9amU7UbI5tt8O/38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT2J2nFD; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT2J2nFD"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22349dc31bcso86624485ad.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 14:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741039309; x=1741644109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KC+3u4g+dkgLQPM389VXbApe1EUEKnrrM8rYJlRvxE=;
        b=fT2J2nFD0zgIzlF6L0Dvkui1Imt9MAn0aPWtEh5jQXpdLQ04I8g/DZJ6KxHEwntiC/
         /0WUX2kaRg6QLhgbGstj2nUXDbXSEic7BeLTHLQGFinh+nNIwQENTl9JzIgutFdlQ/Kx
         /4gEAyOnsAbtr2RIaA+k3FOTiBLoPQwMUix2V/y5xf4N+TrSavy+l0ohaaMtw35dy9M5
         zG/ik/HNOoGw3Q0Jj3q+r1Y6/JuGzSvjNz3qqYQSj9tTIkOPMB+jQW5cgva7l//5brrx
         UqQhZQyeYEj1H85S7uYoxErPHf6XesHb2qPw2a3NJYjXiFMu4U8okErNhnnqEg69vtId
         N8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741039309; x=1741644109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KC+3u4g+dkgLQPM389VXbApe1EUEKnrrM8rYJlRvxE=;
        b=vEjswuYHIxVxRZxQ4TV2Hhy3ybRxYGwtC6M/sya5ehJwZFxWJzOIKilXsP4GLEbNCq
         sFjHsi3b0ppgKk+RnqQHpbN/vk87kImPpxfZ0J0fSqB3I9tmpwGsFRUV1n2BE4qPf93E
         CaiZnqAZRiidTqz8xoJkawj6vK/l00kowa5uHtlL2UaX0MFo3V7jLB1Nc2wY3BNRCGQT
         BFGgu7heBB/Plb/2x9xEfFyAqbGIzYEdb3HQ8seFcLsC+SA/J0HiRtFGSqc3WWD7u/04
         3SkyTdvcEiAU1tXHdud8JITItijddSkjaOZ/bkABFVJjt0n3Tko8Vck3fjfoqeI1MkYQ
         +nDg==
X-Gm-Message-State: AOJu0YwXgtx0RkY4eGK5bfDYcb/IDuZPvimBKe/D1icM+ZXPtXqsC8c8
	WPYoaa4EWvjuAE8UyRdwfh8WfJsY55+97LaMdlMznzJ6JX4yB6avHJ3pVA==
X-Gm-Gg: ASbGncucFAkBTRjW66LzmeVlYwEqurWLUSjfKmfht3bU+SIb4fxrxHq7TxxWm4YCOXH
	EqFiGuScbHxdY2Ee04LpozYePmKU+Tx/IIQE5kgq1VdPlWhlPskddFoqxurTbLQ+EmV2Kl3y41P
	LYGxFVH3/lJP/zX2sBu/lD6xGZV9PgDG+01eQ81394gfTyY8dmRqP2yhQ4HLoE9P/7t2wDLGPN1
	Lm7DqSKo4+3csfHPmbc+E5mxsoUqloweuDp80y+J7Mmle3PhMsBKTOGpbBz2IB94WXLqIREJitX
	hmlWpU0/GzA4SY62mRoXNWUxUkfwjd7fQH4JoSku66W8/glnRsoGGohvAx8+xzQlRcTVp5SF4Ja
	zLzOK5TqMYw==
X-Google-Smtp-Source: AGHT+IFv8U1+MGDR92QOfOg3SG2lJkVuLE4rJNt++CAsBoBwDBsl0SvrYixpAZJfWgutV4ym8NHiMw==
X-Received: by 2002:a17:90b:3c4b:b0:2fe:7fae:59f7 with SMTP id 98e67ed59e1d1-2febac0a421mr25763747a91.33.1741039309258;
        Mon, 03 Mar 2025 14:01:49 -0800 (PST)
Received: from localhost.localdomain ([2804:7f0:b77d:283:5dd5:8e9e:2c56:864a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc7e1sm82746565ad.176.2025.03.03.14.01.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Mar 2025 14:01:48 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC][RFC PATCH 4/6] builtin/log: fill subject extra prefix in format-patch
Date: Mon,  3 Mar 2025 19:00:27 -0300
Message-Id: <20250303220029.10716-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the `struct rev_info` is the responsible of holding the subject extra
prefix string, copy to its `subject_extra_prefix` field the string provided
by --subject-extra-prefix when calling `format-patch`.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 builtin/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/log.c b/builtin/log.c
index 52dc0301cf..034ad44ef0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2205,6 +2205,7 @@ int cmd_format_patch(int argc,
 		rev.reroll_count = reroll_count;
 	}
 
+	rev.subject_extra_prefix = extra_prefix;
 	rev.subject_prefix = cfg.sprefix.buf;
 
 	for (i = 0; i < cfg.extra_hdr.nr; i++) {
-- 
2.39.5 (Apple Git-154)

