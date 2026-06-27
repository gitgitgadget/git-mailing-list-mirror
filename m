Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5E41A5B9E
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782580680; cv=none; b=qkleRqI6Izhacc0EHa8SCMCKZZW3DtMJfuM98jhn+RIRgj6tScdnvmiHPU7sBjlIQFA4EyOrWwKWjHJ1sX2WNwCqOifLI69Z7fyzx5mS1y8zHcS1oBHhtyhlRVT4Oy5Grh5Mh4Bt8IGPPo0+leVsDUdN5f63rvnyCSrlypENZJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782580680; c=relaxed/simple;
	bh=AfdfJqutYuMxutT8o2T6yHfqTeQzTGloKD0O0do5xfU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SgQyyb1HZme31gsFdHTCdF0CkTx6AkmCPHWNGn4b3s0zLZM9LEIpQiaY/glXNIKdXR80Tj3l6WFDwU1vuk6UANiTJVBpzXJuVyWoI3TQR6Yh4i2vYiR54YMNXQlDE1nzHH/MNGe5/Zd107F8dfn6NUBn3KbRXAB+l9mbvHo59dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlhFvUoK; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlhFvUoK"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30c9c8c2697so2258678eec.1
        for <git@vger.kernel.org>; Sat, 27 Jun 2026 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782580678; x=1783185478; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux9aK2fbRRt0jXN3myozcaLObP6aXFFoI0y1+pnUw4g=;
        b=jlhFvUoK332na6SsGsknFU1kHgyCRBuoEsbtKrkWAFg5jBtcG5RSTSXFAfSqMkizzL
         JiR4xh+VuY2ng+tYjYxYMa27EiY8VlLaUEaf/oPQeAIYQDrGgcAQw/w+s9Rh/S6x5WvS
         esjoP6pirWXQ34X7RWCIa+2ox6NEMLEy+rhsyoxmeGmtJyeVVlhAiKq/WDb9FwD2ZOaE
         y1LPeM6bEvVdGqN73CUTZyT4GXvJ5n0d6bzDNMyQYje7MYJ487myUzjlxL7MJW+w6ALt
         1HHCuN4RTuhVVLHcmVi1CNG/5U0Z4JtKO2IwBvLrnPN07kTo6vbPSs97JfXCSbzqCL+g
         +NLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782580678; x=1783185478;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux9aK2fbRRt0jXN3myozcaLObP6aXFFoI0y1+pnUw4g=;
        b=RlvsnrM1iIoOCzWZYLdi6KgpY4FTE70+fBQBl5Kxhw1R2rNm3eRC+tg0YmGxQEm66J
         cWz0M6eCpkJY66tmE1RvytFe0JMtwd1RmPuj6QHfaY1nOWbJlrqf4E11qKLQfIjRgY3r
         r5QJhwEMQwMevKPOa+A60TUr1EmiN08Ae6NsXUOMP6XV0GFuGeG0ee8kAiRBgDYiFAZ9
         4PGfKtm8PhIOAC7TTv0y/1iAP3rObjxEQg34//PGXgau4e+VWj2WzP7gGjNsLyrjng7V
         8rYTHIOMOezsRZiwfh3lxUdh95Vr3u1T4BL3eHRusoNF2O62RaYJL5dltIRWFTKes0yS
         Eohg==
X-Gm-Message-State: AOJu0YzfModhmlfEXzEeya9rDJdY14iavMHloT4NT9Gp4ks0StRDA4dS
	31TzIypglWVkW5gJm7SpudPJPM0A1YGr0Cvx8ePJW/DgaKHuWIBK/0YawZC9eg==
X-Gm-Gg: AfdE7ck+dVllXZKZf3T+zw1uujE9JRTijVovfbTF/g65PPn05egzsFmoNu5EIgDFsBw
	0vKwbLYnXxh8OSaB/nudAVvoDkzFHfhCq2MvkCvFGmp6ExyGo/aRebCvIbEPSdCgYjB7sQ1L7mB
	ikDcP8lw22TpRdUM6ZHPRXLoJ0uMCjoCxmE3uUB/TJEUjXBAVQoji80cSPBCWe8Mz5++XTKrjlm
	0vMxCLivylr/v007yOeKwYCcZhIfw7PuBysphj7hz2hB5HkoPPKX+eOTkm17YAp22ze2IdNGtFk
	C8W54SmkTbpe96QtXuqLYFJLu9m28odrHNHo1juaG+Q7QUC325JHyDKG67Ejmag0YCV2OKI0yE7
	4fs7sfvZbL2fOdnIwNczlGHf1ol9wv2LRbDltAuMIEqgCuiKBfiETeopBPC6ubzQo1Pl2uHrhhh
	fejF+QvBjbfc8nXA==
X-Received: by 2002:a05:7300:760a:b0:30b:f0c6:12c8 with SMTP id 5a478bee46e88-30c84ba31edmr10748824eec.9.1782580678257;
        Sat, 27 Jun 2026 10:17:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.83.162.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm33405359eec.8.2026.06.27.10.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 10:17:57 -0700 (PDT)
Message-Id: <pull.2161.git.1782580676734.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Jun 2026 17:17:56 +0000
Subject: [PATCH] http: accept https:// proxies again
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
Cc: Aliwoto <aminnimaj@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Since 663d7abe07ea (http: reject unsupported proxy URL schemes,
2026-05-05), set_curl_proxy_type() returns 0 only for the "http"
and SOCKS variants via dedicated early returns, and -1 for
everything else. The "https" branch configures the CURL handle for
HTTPS proxying but then falls through to the trailing `return -1`
intended for unknown schemes, so the caller in get_curl_handle()
treats a perfectly valid https:// proxy URL as unsupported and
refuses to use it.

Noticed while looking into a Coverity report against the same
function; the unchecked curl_easy_setopt() return values it flags
are orthogonal to this fix.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    http: accept https:// proxies again

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2161%2Fdscho%2Ffix-bug-in-validate-proxy-url-scheme-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2161/dscho/fix-bug-in-validate-proxy-url-scheme-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2161

 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 8e5a4d8bcf..8c0f831365 100644
--- a/http.c
+++ b/http.c
@@ -802,6 +802,8 @@ static int set_curl_proxy_type(CURL *result, const char *protocol)
 		if (has_proxy_cert_password())
 			curl_easy_setopt(result, CURLOPT_PROXY_KEYPASSWD,
 					 proxy_cert_auth.password);
+
+		return 0;
 	}
 
 	return -1;

base-commit: 663d7abe07ea376c2657019a03297ae87037c993
-- 
gitgitgadget
