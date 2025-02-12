Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51B11FBC8D
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739340266; cv=none; b=cMfeGjEr32H4nBmBcGytUjVNKPjJczIEQdZMtz+53xiobQ5DYhegfWB2W7N3Aks3eooJ4kKM7jdtMMwW42WAoXxNgVvRp+RL4vTn3680wbOeAmBnEL2atvlqRrEVyt5bzSHd2ltCCZU9nQVbm7H4DWuvbAXOSw31mX8XzFdJehU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739340266; c=relaxed/simple;
	bh=2YbnX057ksrUFupptxYjHaoI0YSWx3mP0ofvPPL2WdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOhJEeZrtrOIyqnRKpFnp60N2H5SHtfYtd8bD7b/mVOb7Sxhxwe4cRSYTABa0aqLvg7qWd0ydJU7xGY8wQCJK9O5xQYwTZfRM8bN0jbPI8Dmh1R48g8WyoE02Yklg8CV7P3ZtpSmneE5XbxFSNooUQebgP82WGe1AdLUF2CnMHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SZdFi56A; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZdFi56A"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso9770035a91.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739340264; x=1739945064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oSH6w65KvivlXhnzYBx6S3vXnUds5Fc46isCh2g+ZeQ=;
        b=SZdFi56AXgpXKCheZ4Z3CCGYO/xWR4umccBWcDEFyau+MflEm/m/T9NeAPSHDQwMvi
         wcRAEESONAGXhHKHX1PrhcrQPFhvYPqJIpiFVtzghKGVwrk+6DGXV4KYTib4Ik4xwXiO
         CHtBaaJOtFtUaQzkHNbAgtUYQp/Z7e/VoqLK8r6r8V0a8hnmN6jjAWjRvsZ7TSONgLiK
         jwvVllm+gG11PEnKGFUcm3HO33Ptxr4X11DlePw2dKOU4sXeFLlYG+7FaliSt2VNxoDF
         v0A5w9VZQOriA9wYK1RxcfjGpJ5Ehc/eUVzvlbu5ljLwYAn0jqwMOLJ0IewHfXHFjLLz
         CaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739340264; x=1739945064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oSH6w65KvivlXhnzYBx6S3vXnUds5Fc46isCh2g+ZeQ=;
        b=Uyvh5EiBYX2j+/l9oyAgEPdjlxB96aJj0kNSb5ojnkrjmSjCbGJ+q3Tmj5lzCa+vLc
         lyNx7rbpRmCYUF6559dAoBkQqNDuY/GAQpOERo3vWa7V5W4cLwTTv26ULAMs9HIhzSFh
         E2H9/Rst04qo6S+H0LljuiowYPI/QuasO/sOJKEM30+vuWHK9GJw8N8EEjNf7rmwL14V
         omF2rXags/PLU/ouun5igSQanWzH45nQ83x41OnjdaE6tOkNz/w/L1Beq2xzJndWTz8N
         KMDvCpR4P9WLQcoZrpfwIK66/WcxAl/ZP0h8KfbdCAhv4w0RfwWujtkP8Wsgn2sdnxz9
         Ctsw==
X-Gm-Message-State: AOJu0YxCpjxzXW/fjJOi2Myg9YizHfRFgFFWlLwuV6eh7l0RrpBG4Yc+
	wmE0UrN7/uTgANTSNvsSBv/K9CpJFH/xvvWK+y/Luos7fOKjtlpOvEkw8g==
X-Gm-Gg: ASbGncvfCwIOKCPxnhunwO2WXHgsN4IM0eusuzo3SSJrWRyXujQZdcDx6G8K/AsvncA
	UJC/85lsbf7XGiD0CZ2XgJN2YHzsc+CezzIBgosBfYTufQKf6PQpU5u/dWxsbjlMfl6cjwRAjGq
	rdK24X5H6PyNH9CwCUJ10rYpAH3qjXPiYHm3m9vDFftnxZwiLFMq5ygzr7IsYNKselDcbq0e08O
	80lDeAKGoRv9brl7sDcLvH0mqU/R2qMnTBMP8gWfqIl0x5e04dU4el6S+q7MaWZKI7L+Lrkg8BH
	kIx20LPqdCzjpyn3VcS1wRbs2Q==
X-Google-Smtp-Source: AGHT+IG98viJjrZQiPBQdwCRg1+aM5tRV04j1AXzs7YGy+p9nm1j8+gUrQU6pZTsvsNbyljkPVPEiw==
X-Received: by 2002:a05:6a00:1802:b0:730:87cf:a7cd with SMTP id d2e1a72fcca58-7322c3889bdmr3873426b3a.8.1739340263990;
        Tue, 11 Feb 2025 22:04:23 -0800 (PST)
Received: from localhost.localdomain ([172.56.121.6])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ad53f6e2633sm5747411a12.16.2025.02.11.22.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 22:04:23 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 3/6] xdiff: avoid signed vs. unsigned comparisons in xemit.c
Date: Tue, 11 Feb 2025 22:04:15 -0800
Message-ID: <20250212060418.1645241-3-davvid@gmail.com>
X-Mailer: git-send-email 2.48.1.643.g32d702c6e8
In-Reply-To: <20250212060418.1645241-1-davvid@gmail.com>
References: <20250212060418.1645241-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The unsigned `ignored` variable causes expressions to promote to
unsigned. Use a signed value to make comparisons use the same types.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 xdiff/xemit.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index 2b394a4806..f8e3f25b03 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -20,8 +20,6 @@
  *
  */
 
-#define DISABLE_SIGN_COMPARE_WARNINGS
-
 #include "xinclude.h"
 
 static long xdl_get_rec(xdfile_t *xdf, long ri, char const **rec) {
@@ -56,7 +54,7 @@ xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
 	xdchange_t *xch, *xchp, *lxch;
 	long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
 	long max_ignorable = xecfg->ctxlen;
-	unsigned long ignored = 0; /* number of ignored blank lines */
+	long ignored = 0; /* number of ignored blank lines */
 
 	/* remove ignorable changes that are too far before other changes */
 	for (xchp = *xscr; xchp && xchp->ignore; xchp = xchp->next) {
-- 
2.48.1.643.g61982db19f

