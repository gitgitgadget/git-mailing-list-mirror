Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD89425CC57
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 22:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069332; cv=none; b=J7IOPI4azaFqC36iLZmoCoqSkOVDAcR+fO3JXGgF4ScRxMk/PYqffnlkF1Rk/EWCv3vm9RwHuRor1joNQx/M3ogTkqejylneQ4OM6zU8yMbSdF3OZA+6wzEci07ZxAVt4bIyq+nJBcJ1LW776cK6/Uzz+KfQvM6gUYziW5NvXvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069332; c=relaxed/simple;
	bh=hmSbXH2EWUKB9j1xDAwuEwUIYytbLmXsmJidgaGXjgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ku3f9pvd9sW04YmzKpGUAg89Zni+lgTcMdZqSjSycioq11/OHX7HGG2Kw3mSuzfCKY1DEtD518TmhzDLghjj+WRkC+vVXCfRYttL1wj658MqL+pQfUA60hs6/7pH9VjNo8OaJs0N/GzAFHTX0AGww7AxAppwDYzzr2l3QbCnguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9M9JbDj; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9M9JbDj"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-491bc1d4e6bso3343721b6e.0
        for <git@vger.kernel.org>; Tue, 14 Jul 2026 15:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784069330; x=1784674130; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=a9M9JbDj458UifEF0TEk3sPn0CVvxzLPmYzjCL3f4jl1axhkGuXo5bq0mp48UoU0lm
         e/1I2ik2s8SKptpjq93V1ESallPLkWUmSyoO9i7HQgDMQu9mt7rMtLf7F5VZYiX/o3iQ
         97Z5Fb9w+1Aeq51YchkMnXZRRQedKHKkUR8F5y0ebh3OGfKc4FWX33oD4BJsiobnZX0C
         bfFOi99A+8xPatFIyjQCOXOOar1zoLeyrcBDu9GAnvyNNigwYG8O6e1PFe9RELQubGQT
         OZCLG1n1hys0rQPEsUteOxaJKgm2OfLhpLtELKP0NxYjVP6lb4kDvK9ywhcpkTBBPAMy
         ouOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784069330; x=1784674130;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=jO3X1DUQenP9cK0QESFxVk6zd4qE4j2DVAGEtmmsNNv5EnHXH8rY8YV6H0jaMwSBHk
         Yrsq/Vt+CZD27TjFxIeXnKigaAlS9rCHzgE4N/fIEwXqbi1zGykDULDnZQgQv54hOENm
         HActP+u70gCz0kNkh3fj5VA22hClMQrK5awOTsTw59K1/fu/QpBNh3gqs9BBBSJIfJmF
         co3ssWii3mu1tjs36l2kfuoxcZhZL6t6yB+JWZvoo70LNJUgtCI25vkhs1OtUYq1jVsO
         WAAoBh1o/RZmfiosSasZaTe2pXHQtKP8yFHkYIikJjG3xLYYU3X4dhDn1/ireMxaCXnY
         bVkA==
X-Gm-Message-State: AOJu0YwENor5NsOJHyAg49La3kt2c/QMVoIYgufpRAAYF/0LejOaFeGY
	C0vjAYq2Xs5mAPePxCtyrWv+kmwlflbglRQ4Dd7KuBVFlUll3QQGMKdSh5wYFA==
X-Gm-Gg: AfdE7cm3XZ8IRaZfnH9Onqu9fwQXDIyIw/jcdYF+dTsA+6YO6Mo0JGWRhFL0Me+74HQ
	fyL34KxuxqJXNN5qnEwsua+8t/I/wI7QdryNFw3xbWND9QJtRvAk1v5wPX73+rpPZ0qNaP0QMjk
	zw+cXa2QP35BANRwJDmP2/kAikzVO6ppyuaeOevH3DpNUEwMyk7Nglys93gIJ53ZZ9SEbeaOi9r
	R3L3XCjzlaIFIrwdwTxI+WMnIIEHDCxZWO0lgj9aTcl8IWfwPfggxRXRoJc4ttwdtpVAwyAyBUE
	R9VhIxeLlo+iIeqxLSG7WKhqhYJXvPJRvhDG4iTx2Ps9HNC4PzxSS3S15haVAyoJ+6b3OREbdfr
	CzgEzMVjLNQDfmCKcr6Q+2dRTVfd0IngmsfJvbQM5hGvlq/9d4/Js/rptWq1Lpbo2laSpbM1XiR
	lVkbuskfaw4Ldca9gbWx9EtlczUsU=
X-Received: by 2002:a05:6808:191d:b0:485:4396:91a3 with SMTP id 5614622812f47-4a47a65cf7dmr2851983b6e.30.1784069329657;
        Tue, 14 Jul 2026 15:48:49 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.178.217])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1ad4ac92csm15223188b6e.5.2026.07.14.15.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 15:48:48 -0700 (PDT)
Message-Id: <e653255de19decfe45d4ef8d3277aaf69c44c391.1784069325.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Jul 2026 22:48:34 +0000
Subject: [PATCH 01/11] http: die on curl_easy_duphandle failure in
 get_active_slot
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

get_active_slot() duplicates the default curl handle via
curl_easy_duphandle() to create a per-slot session handle. The
return value is stored directly in slot->curl without checking
for NULL. curl_easy_duphandle() can return NULL when memory
allocation fails internally, and the libcurl documentation
explicitly states this possibility.

When this happens, slot->curl is NULL and the very next operation
(curl_easy_setopt on line 1632 for CURLOPT_COOKIEFILE) passes
NULL as the curl handle, which is undefined behavior in libcurl
and typically crashes.

Every HTTP operation in git goes through get_active_slot(), so
this affects all remote-https, remote-http, and HTTP-based
operations (clone, fetch, push over HTTP, bundle-uri downloads).

Add a NULL check and die() with a clear message. There is no
reasonable recovery from a failed handle duplication: the process
is out of memory and cannot perform any HTTP operation.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b4e7b8d00b..8f1d6d1f56 100644
--- a/http.c
+++ b/http.c
@@ -1608,6 +1608,8 @@ struct active_request_slot *get_active_slot(void)
 
 	if (!slot->curl) {
 		slot->curl = curl_easy_duphandle(curl_default);
+		if (!slot->curl)
+			die("curl_easy_duphandle failed");
 		curl_session_count++;
 	}
 
-- 
gitgitgadget

