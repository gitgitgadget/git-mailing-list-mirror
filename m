Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E8F38BF9C
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954666; cv=none; b=oo47gDJ42WrQ9rf7vHjLksirIfwyWZP4gh3wkKOHDCS7Pvd7yP0jyF9MLAue87zdzEVAcZiQnWI78Mk11tR3nyRvcCe6uH1SLzx5YGeCUQAcHPvryPWnKYTtnaauUWTeSI4FVyhvxqMnMbfbO3XZfW7YUhZTW9ExRzVfXAfcBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954666; c=relaxed/simple;
	bh=hmSbXH2EWUKB9j1xDAwuEwUIYytbLmXsmJidgaGXjgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TrQR30b5P2sIWJXToq2PwxDeXaYc0u9xCMBoIPo4PsnZx8vbR+YjhSbXn8Me82hguW438xrewtog3bJCebtHjaKmhc0fMyv/j2ipU0YUIjSUeRjff0gT7tXpqVHMBC+UndhDhr4cTbcOiTMsW95tm5WOYsrdhp7uWqqAK7V8qv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAQfIotC; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAQfIotC"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso1635784b3a.2
        for <git@vger.kernel.org>; Wed, 05 Aug 2026 11:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785954665; x=1786559465; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=mAQfIotCHSd5shn+UnGe9Lr95pdXnuuhgRYxoQwjWOtZYnINlEk1AFjV5P4vxJAE9w
         w93j/HD36L03K7Hdxk/616se6jpdWgDwD294nr4QTuqmQ1dTiQ9xxKdZx/z19y129Ez1
         jbs92Br5gp+mmRIoEXc1m9ct2QDr5RAz3lAzZa4VVNans56nkNZTMxpmO51egl/tF+HM
         6IiVK/cCsssdDt6C20q3oWv13v3aH9pUUyFi4DQKty98nNyyKJy2u6CMlATPRs8//y/W
         lNY/oGJyvSFxzizQCGDCvXXx8gytB+tG5YO0Nhp6WKN6+fnlVjg10HEYGkVlFJSdKfbX
         4BVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785954665; x=1786559465;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1F/2hg5z+y7GQEVMdvNrsCJfqGQgTDTAC1VrdddO8g=;
        b=V/YLe+qfq1ZLaAc1h9QILSxy0QuYdXGl1sjOO0GYEjTfLPnwdhoifLWOuC2a7kwFGz
         iEQFRuMzIQkzraMtMhSQHjGkTLrMAiO3BXNN0at2a3ALF9qxWLMvANe/p3rMYaTt+kgJ
         74Dzs4buUp+T5CnbfyQmhsc3b1Nb/MZEpDowgS29eBnB9LTLdOvD6duJKgk0o/3CzIKY
         e1uT0Od9GvYBuYtpIuVPBDs3VkfWFfV9p8sP+JHjpWyRYNaKGDXuQqXkOvVGwZJzXlbN
         xYTUnUJ3nfclG0Cb7AXE1gqx2rRypc0Kxr4ICBAlGRkxSowG0vbYBjnx7px80zc7aVhx
         QMfg==
X-Gm-Message-State: AOJu0YyJYHrhVyy6xN1/DZ9TnJ51DN7qWd3XLHf+Dy6s6Dnn3qBaHxNV
	3vzsT94u8eNZj/Flp2edNI55dduJKvTmM320NwXFJX8rPtjNpewkSN5I8OVf6A==
X-Gm-Gg: AR+sD10H5lhhk4V9lJRdpDOQU6O1MBwMGEn3keANGTSD8rzn/4GAQh7B0bPvV1apg/6
	tPc+t5rKC5WV+S0wGvNfZJ4xyHDRo2mh3B++nHgB4LIcTqb2/yD6eQFZgpGVdi5Ju3x+eR1Z2DN
	Qzls0fsM2YbXHGEyXghigV8pM/Q0WU8X4E8eFWX6eNm3P0c5L7hfct9F+UVJPPgBU+/MNZgUCgC
	Gkx56YsqCiJx+oi4v8p8wj1e19jiA87kPMwENLCb3eZXwvcCrddVN4pa5McwovH4zeZfG8eNzIA
	NKPdUQYxuYwm4Xd/3nGd8x0dYAbCSJWwo+Ry2Y79sVp87xU+vcKeoRrkeIu8tLWA3bhZiiivasS
	cTjW3UqzOEdSw1QXyKLBX1GMNTOyB8u/vVvq0Wio3TnhOGunjGu/QLI6Hgn6VtW6iy8k40kdBEI
	nE2k3m5Bb+9Oxs/ecyJlaz/mqCqOlwWV0HnwKGsGFJgF4v9EUz4BFFve1Ky5loL9NiqQ==
X-Received: by 2002:a05:6a00:4b09:b0:842:3a98:b34d with SMTP id d2e1a72fcca58-84f2e032626mr9764114b3a.31.1785954664485;
        Wed, 05 Aug 2026 11:31:04 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.220.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f2e2bff03sm1293080b3a.3.2026.08.05.11.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 11:31:03 -0700 (PDT)
Message-Id: <e653255de19decfe45d4ef8d3277aaf69c44c391.1785954661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
References: <pull.2179.git.1784069325.gitgitgadget@gmail.com>
	<pull.2179.v2.git.1785954661.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 05 Aug 2026 18:30:50 +0000
Subject: [PATCH v2 01/11] http: die on curl_easy_duphandle failure in
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
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

