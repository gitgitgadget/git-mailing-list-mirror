Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD34485510
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632988; cv=none; b=rhbNSz8G9L1T3YQ36qtwRLDqaFIxVW5vQQ9DDlusN+PtZ3EYBMSYYmiM+osJK5zLpsqSUqT3w9GRg3mCHQ/mfk8zaSSrcU8sKij2Cqp95lndZaC94f9l733E/0qV3OOhWsUivt5X+2dTdcx0g761gvTVnqETkiuBxx6HJQbV/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632988; c=relaxed/simple;
	bh=Us2cznKWTfG2jJFptMoS4fMFlf9ugXfM3DWKnR3iTtI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UI9faHtq9lMVVr7s5TzZzjofao8WQB90PZSqWBpyW1rEdwTqMoiI+N4zTbsxgSMGTQ8vvJCZUgwA3T/ImIien4UZAXIxYHsshRFF9k6BpPRXkT8f7DtG7UxTxpVKALcs/qUfnl7S1+PBX9j4Fcf24NOWnQ9QfuwECYwe/ZbzdgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YK3UKJfL; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YK3UKJfL"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4513435cdd2so1376838fac.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786632970; x=1787237770; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=YK3UKJfLZnlLAGTD4XrDtCLY4M2HI8cY5WHI6mliu/fgTKg7FVvIKyvFMv+57QzMhT
         pWfLgmfpvHiTwzgiPlyjXJZg62T9+RlfpOIk0gIyrrKRNK+Mnv1+6v1iH6p8hvMZqnKa
         cqXDqk2MSOpyejflVR8EGzH/IJ0vOqify9EJ4GjVk+/JarmEjDOfG4NxufZ/WZB4HLGj
         jcEwVtHLCWMbh6sP/uCR8Qqq0vz7GDaHCYOEN360YanwwL9RZEFnLYEp9R7Pw+cIQcGF
         do9ODxgYwx7fBLyzfeKwQTp2M07+uCxJbBtuvzelxFSIduh02m3mYj/wIVm4wRaVpMdo
         JYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786632970; x=1787237770;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78y+UXU8Pjw551aJ7/d3G2Co+yhJcCuhcOkF2xIMHxM=;
        b=PsrzZm5Zyb80IAKq1wugcGJGFCDROAE+ZTx1yNCrs58t5fiHslXrXyBSatHQjHX/Ke
         KqxgN5vpwxM52Per7OXlVKKa8Te3w4rJ38o+RnaxFG2+VzfAyJF9fDwtOcLvQXjD2SHn
         zV+DhC4YGCN+VzrH6vi+lTeKfr53aiQy5tA5n/A/v+9iOhQ+RQ6DnEIyoPOlmR1g5OwR
         qg0Q/VOduJ69P1wSUD9OC6xoQchunbKPFY4dIXZ33JZtOqRW32/AH4uPvZYf6WH96nke
         ouP0WNPFQW36g3a5KawtDeze4za2iAwZayr1IPsbtMFGPjV87myzMbVYHqUnHIM7oMgF
         Mk7A==
X-Gm-Message-State: AOJu0YzkCG1SALqbtMYezcbEXB0Ww8s7CKtojrpxeBDVvQ/3w7VHeLbY
	sIwb8kfx+EffVbu1yvymKBJsvMEY44MhBR7qgJkMdE7qdFzKUWtT/jlrZRfr3Q==
X-Gm-Gg: AR+sD11YsYNGhbex5rscBMAJF/f9xcm7Bnu+/rh6PeG3/ckZOf0SR7ATVjmPodjpjR1
	wMITMcxFwSNGQQ1FJk1cNIz69B5E0EO8X6x7Ebqb2LyWBqJ0fk6LyfIRlfrwlSpmLYR7JjutkvY
	zUQ+IyeImzwgmlqZN/fwJw95SLjyJUuVQYghFbI6fHfY+B2QmjBKG49dJMboxOJZvaO3QpkmE3Z
	3bjlZsRRz9cQ/T9W70NFvDJGbKGP/M4088fo6DAZ+T5654CaFa/SEuFw8QSn23wqA/Po7AS1UvN
	T360nrU3O1WSJJcqiQXVPtYRCeU6LDMvl0JKkJLKJfoWzxXIHE1aq2JGCpWWajcMgGdP1tkzHvc
	6mm6u1drb31WrbgUQta9jre30dN+aidtUoydR2j4C+FftwXw/RO576JeO/Bcv1NZujHBcTv/1Yo
	Ic7oamGMyHDFJcOLuDXKgn91HNrpbKshpshEDqjRRzk4tGnobAVSo7rieLxRpNuTUq
X-Received: by 2002:a4a:ec4a:0:b0:6aa:48b4:63a3 with SMTP id 006d021491bc7-6b0c42f7be5mr5561056eaf.17.1786632970484;
        Thu, 13 Aug 2026 07:56:10 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.160.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-45e64efc9adsm1751871fac.3.2026.08.13.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 07:56:10 -0700 (PDT)
Message-Id: <f4f2fa75f4814ccd67501d23743eb90fda35aae3.1786632952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v3.git.1786632952.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 13 Aug 2026 14:55:49 +0000
Subject: [PATCH v3 11/13] t/helper/test-pack-deltas: widen `do_compress()`'s
 maxsize local to `size_t`
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Prep for the upcoming `git_deflate_bound()` widening to `size_t`. The
local is only ever the return value of `git_deflate_bound()` and the
`xmalloc()`/`stream.avail_out` sizes derived from it; widening it has no
semantic effect today.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/helper/test-pack-deltas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-pack-deltas.c b/t/helper/test-pack-deltas.c
index 5e0f726842..959705feca 100644
--- a/t/helper/test-pack-deltas.c
+++ b/t/helper/test-pack-deltas.c
@@ -22,7 +22,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 {
 	git_zstream stream;
 	void *in, *out;
-	unsigned long maxsize;
+	size_t maxsize;
 
 	git_deflate_init(&stream, 1);
 	maxsize = git_deflate_bound(&stream, size);
-- 
gitgitgadget

