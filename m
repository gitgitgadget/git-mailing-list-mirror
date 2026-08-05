Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDA6481236
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946506; cv=none; b=dh0+R1/CxFI9uTeVpFvv5F2WoLqAcpH0tRRedJUur0m7MnBEWdfnUztAzhGzYqjU7iR77ROmYGGsj+TBy+kuSY7VNpFCzheyn55bW72SVzNbcsUGQMlKLzvDo5S7SH9IacAWfaU0BafLg0Hki5Fh1JMrtHHG21n7HB2HF3VHEJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946506; c=relaxed/simple;
	bh=2sOwCqcRrAPzEpyqVb2L253d74ossFImQrmVFcG9tRU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Jwuups7yUUVAsgwndS59I7io6+pDaOjr1F4GAt1pq1jUMu5sBVoLRZ+qVGnZlxiipXewMEGqhUUwGe8AluCkHdvXoAoj2hGCOWraQp2H2RsRnRIqAIo31TCRTMx24SN8HUXvANnrfa23K6XmGXwUD0gYVxB+fRmbjsMmz/VtXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUI7No0u; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUI7No0u"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4896ae35be9so405340b6e.0
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785946495; x=1786551295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=pUI7No0u0XhAL/1EU1051A+L/x6uGK5IS9OSvhoIrmCCKgY/kzgTiUt0t28I3fzT84
         igJLNlrUGMOCOYNehCFGAoRulpCKl5vg+me1LNvzuxR2E6FRgNSZMYFbhAyRW6Bs+xHI
         TFNCWDVs8jD86LbkmdR+vZi5o8+l5xfiaWodyKANtA+u8+qSELJkv+0jZpfugAUgtrij
         VD7W5jnEG591JqOapx1SE36Wv75eM6kgkP+FYhk0MwSenDwL1TzGhAfEeGGnGdE50+k1
         qSrTCSrkKU1mmCv6H8EeOUOCILvWSDEkR6zddaPy+LAomTGCFjItdk9MwCjTUlM+CpEe
         R8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785946495; x=1786551295;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0QeFPLjkX+BN2XZOxoLWKjLvEHX3v/R4r47jelAKP7Y=;
        b=cMsltotDD93pdHLSPADwA/PrcZCf5x2v1qnPnQ2oS2fbCaD1Z7lVCKBZiD8JjMR8xk
         KVbgfYu8aV1v/G74oBNyMrECA6coHTYWLeAwUBKSuw9Fei7jwojnMkQmtQM/pVpA4wt5
         6gtKnx931J0IdlpBhaHS9NZuhHh++Z8/IAeIiMqw7zzjMKzV6HoUuWpfNUZF02z9DGOm
         gSuItMk1u0BK/gLK62nixwTsVeCDTq9UWUKv6W5bcvkGcZV5EagoYwvnspoeEQzCKbj6
         2cs3o4vgsWolER+OuAdUFzS1Yixe6zWcVvmwHBx2QDYr2KcQhSGFNn13CVX5dvmX0Qaq
         SQ0Q==
X-Gm-Message-State: AOJu0YySLUmmyYAupXgNcs4SMd38j/GtvRD+u2dgcqj/7tyZrKuisZ7J
	E0/VUjhshYa1BwC84b1OAM+OzAgb4BV0NjhelkKAcOaLQiZX4VoZgcfKcyS1Mo01
X-Gm-Gg: AR+sD10zhJk/9C1gxBcntiRkoVDGtNlCGkdwsXZxKthg2V7kx+Qbhx3DnBi/MU2EGpx
	dtf1Ri5FelBVYPElqP0hUEhsaWDSEbQn+xyYFA2S7tq8iXsBf7XTKvgxCocIDSdVeJs1zjRqwTB
	FXTbk0u7mWsgSjSR66B9qtAqhSpA7AFI+ZoyN5nKXcs+9V9EP5mNk+GhcCiJE3W77FbN6hkvQv7
	G9VzWmh32z5Mf14jy9mkL8U8MztbUfBT68EY+cwn4hJEvZwj/VAgqRZ7LNZyNXN4rPjcjgoedGT
	eY9OfNg4jelIdo0r4vkMNscdxuANSJ8aqP/8qYBqNtaRVnFO3oPECEmh6JoBwVSij8LJYv07UWS
	UMIF1LvMXnDTxI9NWx65f16qbSxbNgy2t9Z/JhYiqQj1rVZBkWxluOp4S3gb6bQViz2/KIj3eS0
	qqu91m0IwotBqRDjM6aTzaenNSFfvGB8hgKGN2ch7ZwMasHhxA7R/mokwbxcMHbZ94Zg==
X-Received: by 2002:a05:6808:3199:b0:489:5d05:552c with SMTP id 5614622812f47-4afae235a9fmr4770121b6e.18.1785946494596;
        Wed, 05 Aug 2026 09:14:54 -0700 (PDT)
Received: from [127.0.0.1] ([172.212.142.251])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4afae4b2b68sm2357408b6e.5.2026.08.05.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:14:54 -0700 (PDT)
Message-Id: <ff103a0ee1f99f70b4d7110dc41c184cfd053703.1785946479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 16:14:36 +0000
Subject: [PATCH v2 09/12] diff: widen `deflate_it()`'s bound local from int to
 `size_t`
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

Fixes a pre-existing silent narrowing from `git_deflate_bound()`'s
`unsigned long` return into an `int` local: anything past 2 GiB has
always wrapped negative here and then been re-extended to `size_t`
inside `xmalloc()`. Also prep for the upcoming `git_deflate_bound()`
widening to `size_t`, which would extend the narrowing further if
`bound` stayed `int`.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 69eb2f76a4..c14f69719b 100644
--- a/diff.c
+++ b/diff.c
@@ -3609,7 +3609,7 @@ static unsigned char *deflate_it(char *data,
 				 unsigned long size,
 				 unsigned long *result_size)
 {
-	int bound;
+	size_t bound;
 	unsigned char *deflated;
 	git_zstream stream;
 	struct repo_config_values *cfg = repo_config_values(the_repository);
-- 
gitgitgadget

