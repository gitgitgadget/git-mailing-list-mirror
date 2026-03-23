Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646AF36DA10
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 08:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253145; cv=none; b=t+BMtIsaN48CUtalqDU05wo6zDfmv5VM71b3qL7rd8mYCTeFBMUCJuxW5Su8dSN+KAwMxOADuxd6bTL4ABeiPU5Ku7XhtvqlpDnQ//LFxtkLCjCjPRUTv2IQPY6qaCjKbUk7GZfk7k+QhxC5yRqv/5vd1HHLCoiXSuxzaT3s2VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253145; c=relaxed/simple;
	bh=9dEUSFXJ/T6ZbguCMAh1cZkeojMb6PGa9/yn5XBEX5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YZN029DquD53jyfIC0/xR/wX3i6rxPYRjGG4I4jgipkA4PX6blhA/HKgcXJog1Amy1mkytg3uNYWMEQ2OQnM/3g4MZbm7WdRWUXTD8CLssqUYJyGDvU4A0jQLp0lVFnYsYvVzAbehubdDSDkK7cZBlFls/oBfYdtLSlBPc5QlBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZB/nbAj; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZB/nbAj"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439cd6b09f8so2848088f8f.3
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 01:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253142; x=1774857942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNCP/mF8F0KTXP51Hf/9F99nHcQFaiCYHroewh676QE=;
        b=iZB/nbAj+nGclROtRs+haeZAqQ1W0dpwvlxrw6zg4/QPdhUwwGanD+ika5RJWRktF2
         JtN+EpAzkbdkp1ExOT/6efuq1yVssLVqZxYhCLMprHDKujGUE5Rw/lBij08T+ZtS1YaQ
         WWW+tso8oVO/asf3cNLV/MYZ9veyCr89Nh93oOwK7iN7mdAVY09Laa3FMG7Ulz5evTOa
         370XYjda1L0BF1VLeLKt03srv5F5vEpiNQksJyBRg9LzWmaoplkdr/8nmGXtZN4sS5vr
         RuPHb570Y/GaWyEZ/+JYKCP7++qIqvj5piaoDIu2Rb6k4dHEXHrnAc4MX87RffoPo17s
         AtPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253142; x=1774857942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JNCP/mF8F0KTXP51Hf/9F99nHcQFaiCYHroewh676QE=;
        b=FkVsvqGIHIR/Uw2lZ2n4IBZx8PdB+enzci6aJN6X+zKXmeV4LKD40z50ZBQxK92AnU
         kGISaSOHV12YwZwtFyPq6pfOMmHFWnK7Me+hMdaqEbESyQoL37RzU+aCXg/7FtmjdePD
         4n1L+H2Ug42CKOXxftNG4v+1yLuGlml3jMCVmKMra+kwMTh8LCvdEfAubO56IvpMwiQi
         +aJmoxg27EChkK2MTTW6RNP8wbqf+A3dFFAp6FMuQe7U+ByUeSYIYonP6d9zjBpDw8rN
         GptnbdUEcJaAEkyBfGOVYz0aeEzENBvIspTlvZ7WOKn4gOYgwuSxGzTIB5RzcPEPTmYK
         Lsnw==
X-Gm-Message-State: AOJu0Yz5f+8zV3GAkOgYnxP+Nl4smaotxiAc2leVeOd5Rxr4JTVtLchK
	251KZh1bJi8mEtSROl9X1tK1DYCfb5iQ+tE5cwbQfZGW7L5tbC6fLFOx+WUOrA==
X-Gm-Gg: ATEYQzwKwEEFUt8AHIXwMzY2db8GT1AyAi6CsXq/zFjNxR2g5HTO6HOfACoBedBeqsi
	sQ3pfFGWy5nW75bpVS2Q130if7dgFabSgk+HL0RI5RWMvcnizBGZgGSToqUzQSRpWCQMQZD1XJV
	AvdQh5dzoqbb6u8iteOhVBu6gURKEyxw5kvZb9PXIVaVikN0EfTag1R+aUdtp9FjjRxJV5ZFSGx
	q1pGIxbz/goCJW7kQeyvwTSECPsdsk7l14A8A6Hu71P0KGgDrNB/kTAkRwWe6KF7vgABbcKrNzk
	LucIS16d8cyyxLp5osox5+ZNGU5s996I1t+UhzYm5YYAdqRe9CYB6/cFnzsuHfLN4D9GEreQKIP
	TK4ZcxpaeEHDMLKic5YY3YnXm9oUU59qHqS/BVprfPBzr+JjKP7K/KZ2ndHWTeBQoRtGq7/YlQm
	24GJAMys2GFNwdfBjn0Xz74TbxkEU/yn8KR7gceIqBMgwT71B9Jma+VE+sIGyU5b15NBu8sVt/A
	RfxAb2m1EtI+1ULq3Imak4Pocz3KaKZYT3VOnM=
X-Received: by 2002:a05:6000:26c8:b0:439:bcb8:54b7 with SMTP id ffacd0b85a97d-43b6424b9eemr16562969f8f.15.1774253142392;
        Mon, 23 Mar 2026 01:05:42 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703650sm27834067f8f.20.2026.03.23.01.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:05:41 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/16] urlmatch: change 'allow_globs' arg to bool
Date: Mon, 23 Mar 2026 09:05:05 +0100
Message-ID: <20260323080520.887550-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.53.0.625.g20f70b52bb
In-Reply-To: <20260323080520.887550-1-christian.couder@gmail.com>
References: <20260323080520.887550-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The last argument of url_normalize_1() is `char allow_globs` but it is
used as a boolean, not as a char.

Let's convert it to a `bool`, and while at it convert the two calls to
url_normalize_1() so they pass 'true' or 'false' instead of '1' or '0'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 urlmatch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/urlmatch.c b/urlmatch.c
index eea8300489..989bc7eb8b 100644
--- a/urlmatch.c
+++ b/urlmatch.c
@@ -111,7 +111,7 @@ static int match_host(const struct url_info *url_info,
 	return (!url_len && !pat_len);
 }
 
-static char *url_normalize_1(const char *url, struct url_info *out_info, char allow_globs)
+static char *url_normalize_1(const char *url, struct url_info *out_info, bool allow_globs)
 {
 	/*
 	 * Normalize NUL-terminated url using the following rules:
@@ -437,7 +437,7 @@ static char *url_normalize_1(const char *url, struct url_info *out_info, char al
 
 char *url_normalize(const char *url, struct url_info *out_info)
 {
-	return url_normalize_1(url, out_info, 0);
+	return url_normalize_1(url, out_info, false);
 }
 
 static size_t url_match_prefix(const char *url,
@@ -577,7 +577,7 @@ int urlmatch_config_entry(const char *var, const char *value,
 		struct url_info norm_info;
 
 		config_url = xmemdupz(key, dot - key);
-		norm_url = url_normalize_1(config_url, &norm_info, 1);
+		norm_url = url_normalize_1(config_url, &norm_info, true);
 		if (norm_url)
 			retval = match_urls(url, &norm_info, &matched);
 		else if (collect->fallback_match_fn)
-- 
2.53.0.625.g20f70b52bb

