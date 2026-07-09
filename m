Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B2239B4A3
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615789; cv=none; b=SyfeZafK0RMfzu2D3JwiOT+2OFIRgAY3jj1TJJQOrPOL8tnp9ovswfmYGVzdpF97loqOHwrxOCCgGIPfa9MiTn7WCUic0tcbigvC5iK1qrGyb4kJTGd4H6qKf+4kZ+8jt6S2ZOvdja5JYDcZMMsHCKuXnjDkHP2s96aFhytIx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615789; c=relaxed/simple;
	bh=X36FuiqaiDW8gLLqK0612jf1pUQaCVOUdfXHn5ZdeNI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=b9msEf4bZuI/rSzA0epaq+mOy6759UlWz5edxi5nuQn1undq/Nb9uLYmoI2JIY1rvUI4tvya0dfnw/DWIn/HkIFfkO38JL3MgAhq70f/M67rHcbP/tao7lSZg+8nJVuKn31wMRvwRIvvJcw2dFnykptvSBL7b6XY91wWjJ6t2IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ss7EM0X7; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss7EM0X7"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3811e59df58so73077a91.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615787; x=1784220587; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xYDVkQPxPQTPE0OcS9dqRkgirfW9gQos+7IF6WiOfbk=;
        b=ss7EM0X7lsEodTnYcC4uDAbj6pINSDP4KbRpsF04Q6SqaKJdHjtG9YjOVDbywuDbdp
         UXr8s2hICkpDmjtfwSrlF77m9wTgP5O9OB/vThERoI7m3knveLi5HfgpYlzz6Odj9816
         M5YfxQi+abbfvhBh51ydxvCA2D3XII3/1xxZMnBP8mdsaYMjapcxHQaFBm1qxZoe7YI/
         w5wryEzyDttEy6Nj6z0BSNi6+Tec9aZ1tCDNNzbfVc7oNIiXa6gzB1Ee6ciXhvsYjAKI
         WDcutmLjv19dFNinNdzUeToR3+dyMWvFJNmcACnzxAay7Q02awKd/V+WoPvPWhpNB/hZ
         Js3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615787; x=1784220587;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYDVkQPxPQTPE0OcS9dqRkgirfW9gQos+7IF6WiOfbk=;
        b=SEuY6Gg4Pcdf1lVnmN6lIQhmzl9uGwUXtUY/0jnZuv+0PPoRlBcopKFbcuR3Ibcz9H
         vrvqVyf/fRhTa8vslv2yfRvaf/PqfhMTQs0NaogC6lHsLJ6WGw7YRMY5vSAOtmqHfAni
         TYgchHPmSxhfoQQhw93lS+XHyDtgvwZHCnFY64oZuupsojwmg1UYxFaqOYi5kza4WIj0
         HZpjgOkviJ7+5+SUxcxgQi/9Z53x4xAJO65jSgraiZlmMfxMXcTFAwtsj0Ag5A4kR75r
         6vRfPNqEAcMXyWKAesWtHzbvIzO2ERh1Ao3g5TQv38KNIvdMXRvVIkft97HGZuS4Weet
         /zqw==
X-Gm-Message-State: AOJu0Yy8JeKZcoGWgxqJb0r6t24ZXcAhWczXUybgxTlpSmKITxAzLQ+u
	UfU6gNMYuuHesx9wjF66THagHi+Z8WbLeo3bTCEHYtWmd5Xd1LQFljH9iGadAw==
X-Gm-Gg: AfdE7clA8aP7/hbiyQ7wqDxzsYs1t5V2RwsdtVHDoEEOdTnprvdL/F4TyKlcmeLxOqe
	Q6DNtBXUoXoIOiHGiiLFGP3ba7nYtwaU1aysLrthvQ6L4ycMnphCfZzjLgLaXQ/RhVRTRAptgWC
	Qa6NEZG/NLs7sQ7JjwTDf611djJC9tYFY60f55eLBVl6MBd2f1uMuTK2qvMF+4VHQ6fsEyK+1Uw
	yZBXm4Z7T27Q4YpGIU2fHuBreYHZEDyyYv+QG8mPhlqQePELA7cIhH4Tg2uT55S00JJH+cME+Jc
	NwVfQhX2I6OmEVB4XVkpsnCYIfbWuEqSqXdaAxBjtrS5+XvI4hBmfMEpjymyCbRAO5xJv1/caqj
	0ifFHwbYubd0kLYQ029P0dZbhcapydL82bk4Mcu0/9MNJevib1FZ+BJCAWGY3fdIl6dZ57PEOaR
	Qpd7eY6omM9xF95Jg=
X-Received: by 2002:a17:90b:6cf:b0:387:e0bb:57fb with SMTP id 98e67ed59e1d1-389421adc49mr8004116a91.34.1783615786950;
        Thu, 09 Jul 2026 09:49:46 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311b00048a3sm2806579eec.5.2026.07.09.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:46 -0700 (PDT)
Message-Id: <4ef28865498b33cebc954fccf18a3368f3d114b4.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:30 +0000
Subject: [PATCH 03/12] pack-objects: widen delta-cache accounting to `size_t`
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

These three are a single accounting tuple (the globals tracking
cumulative cached-delta bytes, plus the helper that compares them
against an incoming delta size) and are latently 32-bit on Windows where
`unsigned long` != `size_t`: a pack with many large cached deltas could
wrap silently.

The widening is internally consistent on its own: the additions and
subtractions against delta_cache_size already come from `size_t` sources
(`DELTA_SIZE()` returns `size_t`), and `delta_cacheable()`'s sole caller
in `try_delta()` still passes `unsigned long`, which promotes.

Prerequisite for dropping `try_delta()`'s `cast_size_t_to_ulong()`
shims, which becomes possible once 1create_delta()` and `diff_delta()`
are widened in a later commit.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index e3760b3492..f89628a760 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -260,8 +260,8 @@ static int exclude_promisor_objects_best_effort;
 
 static int use_delta_islands;
 
-static unsigned long delta_cache_size = 0;
-static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
+static size_t delta_cache_size = 0;
+static size_t max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
 
 static unsigned long window_memory_limit = 0;
@@ -2688,8 +2688,8 @@ struct unpacked {
 	unsigned depth;
 };
 
-static int delta_cacheable(unsigned long src_size, unsigned long trg_size,
-			   unsigned long delta_size)
+static int delta_cacheable(size_t src_size, size_t trg_size,
+			   size_t delta_size)
 {
 	if (max_delta_cache_size && delta_cache_size + delta_size > max_delta_cache_size)
 		return 0;
-- 
gitgitgadget

