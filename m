Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8A620ED
	for <git@vger.kernel.org>; Sun, 18 Jan 2026 12:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738056; cv=none; b=jjMlTIZouMWYcNxDwfjsgsB6VdiztAipUg5frOXvWuYGm/5bc8HIpVNr8bmOnNwdat/4zkhLsytbLDlx1oNe3BlH1JZg8vyWf/YhfWTcxNKT+t+zkOP+M+Eof/frXfENmwqbyR+cRfzETYc54QyzUhxGN/yqwhceILEE9t7PnxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738056; c=relaxed/simple;
	bh=rheGKsebM8NoyrB1O3cDc5Et/K881NvRHnGveao2JOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGJALl7VtBdC4bApozIJJCoaq4rbK1V+susUbujD9owxGZIb0ZHemshp64oez4iBLrzpxq8C3+0W4q180JnqQp8BqHGmNu3F84nW5NkkB/PhLs5E6qB755EEu1zN5za0eDR4tG48wMy0QNF0jHFCBcXJZvgBnD0pqmclN6AZZfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTJ/QQ7w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTJ/QQ7w"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so21796975e9.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2026 04:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768738054; x=1769342854; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cnR6Jm/g2aKQzpAfltoh29omRHvYmERSwNIoa8Brvf4=;
        b=gTJ/QQ7wIAjBcQRJLNQCX1T+xhPwh8l7lP+9zlHe4SsKF1Z7nLBTqJZthCkazE9QiF
         uXVpBBVzxJiiTkwM1BoeLPZHO8NjIMGbpAXEDLXVxL+PG14bqehcQke4/ZQFYbcxs3RQ
         s9VWYJu/7EUTw0bWUkRgBA9O8rljQrMOq5WN+qpxpBzKJyBcIfWPE9WKSaHL/0XLuubZ
         iVLNFro1M92X8hp6pLJ2l2/5BsduiUn6/wk/e6mMsV0mnd0BbLiVNVK49ye7VVho7ltv
         QHSU/lSn01gSPTjMSyo/y2iiDaHzjdgR2ZSScLC70xMH1TPSxtq5U+w36hmGDWWitAtk
         zgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768738054; x=1769342854;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cnR6Jm/g2aKQzpAfltoh29omRHvYmERSwNIoa8Brvf4=;
        b=nUjlInUonJuvFFDwhxt7x4fZIQZTbPtzIihHzCnIHv3sRi6Y7I2A4nUFSOMX5l8a4E
         jabNbyVkZEQSEDX91Obs4GRPkwLLKWK9YaJy5FOeTrek634V/12C2w50DLWf/ehw64Tt
         1EDqQRkS3u0Lt/4r1WA7nAr3Lud+hUlGABs5pnEByOWpMSIpKIrasjWFxdMou0KJbB3T
         NO+x4z7Z29XH5LGBsZzzMbfiYfMzvuF8NVUuGuMSmCO7FHCTZh0ZsDaT+A76naENPOAS
         otIhtXIRaLbFkS7bRlFCId/7VSpRtYSK23PhE2fj9ce5TxAhQqT0ci62s1f3ejcV+Ul5
         HnoQ==
X-Gm-Message-State: AOJu0YzVALZ0awbCipV5ycNtoJx+fPE/Yab0q/KtqTGTiBpqMqjKwWDE
	VvBNSkaOPQbOiIR1MZkoNHOd/cvyqMQRDf8C4ppMPnDtZ/durbKws+Op
X-Gm-Gg: AY/fxX5ALAUqvesLQVq16lFoJD8oZofK8ueNKWU2OxpWZbvNA+GQh1aqDb/upnBlfgA
	qiOWy06PupRMP0Sjc65y0lnKTdmrkmKy5D8S4rb1U7dKTrbgWfySNrSe+ggrt3M7j+glTPN97bL
	zj4Q/QG5TM4m34P2ffzDZ62FG2hIR0rjAaQhbS2tCZ3vdfqMNEI3wkhnxPNUFwfWJHJ1ix+KiWC
	bbWschyYRudhVUGLy1BwFy0j5ChhFSYrDBzGLCLzU1kdSc5+y9psRN5t9GDyJE9sp6+7gHjJbWH
	P9+pO0XHQelR7X6dqkiO39699SGzIPlKrQCpLtKRp8SN+feEstLYTknDLAxgbAef86uGed+ds8W
	4Pf9bH0Adtt0S6wjXws1KnaAlK2QEy33q6PH3rDLDXpvz1Zhqgf+mQBcjdbaa5L2ji7X3otcjyF
	AIrJt+Zh/jGYHlUIrift6qiSx6ZMxhXSVo9K5IW9Ga2JxsjtM0pBk=
X-Received: by 2002:a05:600c:4e93:b0:46e:6d5f:f68 with SMTP id 5b1f17b1804b1-4801e30b737mr105062475e9.12.1768738053605;
        Sun, 18 Jan 2026 04:07:33 -0800 (PST)
Received: from localhost (62-165-236-43.pool.digikabel.hu. [62.165.236.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e8795f1sm139018925e9.6.2026.01.18.04.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:07:33 -0800 (PST)
Date: Sun, 18 Jan 2026 13:07:22 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, gitster@pobox.com
Subject: Re: [PATCH v2 1/7] refs: drop unnecessary header includes
Message-ID: <aWzM+qePiaRWz5/f@szeder.dev>
References: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-0-925a0e9c7f32@gmail.com>
 <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116-633-regression-lost-diagnostic-message-when-pushing-non-commit-objects-to-refs-heads-v2-1-925a0e9c7f32@gmail.com>

On Fri, Jan 16, 2026 at 10:27:06PM +0100, Karthik Nayak wrote:
> The 'sigchain.h' header isn't being used and can be removed.
> 
> Similarly, 'run-command.h' serves no direct purpose here. While it gets pulled in transitively through 'hook.h', we can still drop the explicit include for clarity.

The need for these #includes went away fairly recently, I think in
26238496a7 (hook: provide stdin via callback, 2025-12-26) and
7a7717427e (reference-transaction: use hook API instead of
run-command, 2025-12-26), which were merged in f406b89552 (Merge
branch 'ar/run-command-hook', 2026-01-06).  Unfortunately, that topic
had some regressions and therefore was reverted in a3d1f391d3 (Revert
"Merge branch 'ar/run-command-hook'", 2026-01-15), and as a result
merging this topic into seen resulted in a merge commit 180b93f7ba
(Merge branch 'kn/ref-batch-output-error-reporting-fix' into jch,
2026-01-16) that can't be built.

I think this patch should be dropped from this series, and these
#includes should be removed in that other topic.

https://public-inbox.org/git/20251226122334.16687-1-adrian.ratiu@collabora.com/T/#u

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/refs.c b/refs.c
> index e06e0cb072..965b232a06 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -15,7 +15,6 @@
>  #include "iterator.h"
>  #include "refs.h"
>  #include "refs/refs-internal.h"
> -#include "run-command.h"
>  #include "hook.h"
>  #include "object-name.h"
>  #include "odb.h"
> @@ -26,7 +25,6 @@
>  #include "strvec.h"
>  #include "repo-settings.h"
>  #include "setup.h"
> -#include "sigchain.h"
>  #include "date.h"
>  #include "commit.h"
>  #include "wildmatch.h"
> 
> -- 
> 2.51.2
> 
