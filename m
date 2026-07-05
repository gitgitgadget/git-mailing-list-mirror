Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC09136EA84
	for <git@vger.kernel.org>; Sun,  5 Jul 2026 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783239885; cv=none; b=pvSNWvCEeFMKCCs/JiV/gaC4IB9sf85orUxUur9pVjhtluDOeH4lFnUoHVrTJ9/iMrV3KlagOpVQ1EZ2Cv7zr/F53R6RijyKkBiUGh7HobdsdzPxjsveUG4AxTP4wcaIfSO/697qM7TUvcNhNntiY9C4jgfSTroH6r1LbUP0H1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783239885; c=relaxed/simple;
	bh=aaFfy6YpyDVMgvlQ5YUO6T+kpehXyIehzXR1DaAE9ZE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=SI8oPm5a29O7ziuDSHtmHhTUUo5Qy8pIw5CpATH8p1V27GI4SJgtnMryrQnb5efVlPnPPNwr7UsTduRWOa/RtRxm3rdMcJEZNwBAY1WrYkxoyZKhdc6S8i1URPpT3iAg2y10XhPmT5FY7dX7xsjjT4kUMFN0Bt++2SK5x40JoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+k54759; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+k54759"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f23e851626so15503816d6.3
        for <git@vger.kernel.org>; Sun, 05 Jul 2026 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783239883; x=1783844683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ9fgpHfhqrImu5EBEaJ4HH2V6u7g1aSBQpnuRbIJkk=;
        b=L+k547591cFHVcD3HMblRNb0wZt7ljpBdAtA+0gJ1YYefTNvI7nb1bVYLSQNIQN8dk
         DPqo6dBglkvSqI6PTPEJfaboPlUEnU7X893JACNZxXTqM86Es9ELSZWvqTeVPGAnFy3n
         SbWU/jzOR56RmTc6V+T0JdRMmEySt1sH9lpdSyolAEO6rP1OIcOLDr4GYtOBo/XFZkSP
         so7PyOn7Hb8z0BZUEKSdTeqADZRHRhcgHHufvrRAa5+1PgJGKI8ta7hTmeXRGpfB0MD/
         IBzl3PMjq27LXRoaMwakjxDKHSfiOJdqN/xFQ9xGIYb83VUMPPM5wr4wT8I76KUVg+eA
         gt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783239883; x=1783844683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZ9fgpHfhqrImu5EBEaJ4HH2V6u7g1aSBQpnuRbIJkk=;
        b=Dq01/emNt7oaYbLj8bF6XjAR32T8JotTR3BthfIgpsKVsCJY0CMpADCp49QUgyaOEr
         ZQpwkWtUaZacTA5mrkO/tpf4Jymbi9yKqR8St9ON1FxS7GeV33azxBthb0ND0OZ//RAv
         QdWIYf6AGyV+Lub1/jnC1a8wrIGTgCgO1GSXD4rUaYHMiU5O7M7mBFyqGrYacFaXFLAo
         cpQIsBwztiSTbYGeN5gV0o+1miEP51AD4ft+QNjfsBiaz0bMNTAaUm9UQ+EHxIQLXbI2
         IHGJcOkPRko97Vsk9trnqCuI95M3o+NcEmzXAr4S1nJhtlgLbuF7GQJtJdvIRfhXhFnL
         URPw==
X-Gm-Message-State: AOJu0YzZh2noo+5QvXR7fQVq03FVvayhnvjfkNirLHtnKjQ0vV5naaLU
	64OugEugrsm/QiyNfpOskcUBO7+H7SMekhQQb1Sx80Dj/XG7Cd6qJ7f6oa+xDA==
X-Gm-Gg: AfdE7ckmTDTii29mw3CoAJ5r97RRE6w90xMAykKdLrud5Rgqv5UgvEDwM33gFQoricJ
	UABUkMh8VLRRi4RN2Dh9FGrgX2aScnqW/7X11ZdAke4xBUyzWtUgo/seY0F8XZes6Dhx/ppUEO0
	A8Zl0B6V6c7uxcUAIkmrezjZKacKt4bCJeJWjV8HJszDN+fKqSoqGkk5ZegnwQJHlBAcvDJ4S88
	wq7R5zMdTVV+DFxqYTLj04nYXKFx3lDfxIvYGyowUn+/Cm0T730ohL9JKEqv/YYtdo7Q2AiOFDa
	SoC/EeA17oVOG7YAEH5NBumHmZq9mN0P1bYOUxF3j4YZJNuuBBgJbSsIBhc5XEd8loE+SGqLXCh
	JuK4CTQS++VbR8X0UTQYm9okbMzKsLVwg9MWQ8wS70gp7gkM/ck02ou5knaIzpywXW3RDHKJp6p
	VWiTkwI3LVUG/wrf9AHg==
X-Received: by 2002:a05:622a:250a:b0:51c:1cbd:5fdc with SMTP id d75a77b69052e-51c4c1d8d58mr92636861cf.10.1783239882730;
        Sun, 05 Jul 2026 01:24:42 -0700 (PDT)
Received: from [127.0.0.1] ([135.237.130.145])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d2d688sm63038401cf.17.2026.07.05.01.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 01:24:41 -0700 (PDT)
Message-Id: <8a8fe2d3e342b912de1013082ac838e8544d7031.1783239870.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
	<pull.2163.v2.git.1783239870.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 05 Jul 2026 08:24:23 +0000
Subject: [PATCH v2 06/12] dir: free allocations on parse-error paths in
 `read_one_dir()`
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

Two of `read_one_dir()`'s parse-error early returns leak ud.untracked
and ud.dirs. Plug them.

The other early returns in the same function are fine: they occur after
the `xmalloc()`+`memcpy()` that copies ud into `*untracked_`, at which
point ownership is transferred to the caller.
`read_untracked_extension()` then releases everything via
`free_untracked_cache()` on failure.

Pointed out by Coverity.

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 dir.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 32430090dc..23335b9f7a 100644
--- a/dir.c
+++ b/dir.c
@@ -3792,13 +3792,18 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
 		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
 
 	ud.dirs_alloc = ud.dirs_nr = decode_varint(&data);
-	if (data > end)
+	if (data > end) {
+		free(ud.untracked);
 		return -1;
+	}
 	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
 
 	eos = memchr(data, '\0', end - data);
-	if (!eos || eos == end)
+	if (!eos || eos == end) {
+		free(ud.untracked);
+		free(ud.dirs);
 		return -1;
+	}
 
 	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
 	memcpy(untracked, &ud, sizeof(ud));
-- 
gitgitgadget

