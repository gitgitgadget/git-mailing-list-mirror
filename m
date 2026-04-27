Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B013B95E0
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293692; cv=none; b=POoZqVcwoPnvbh6gwQ0mRklMscW91o8AWrDAkN2xWD1/hSYnHR5RR6lOSGlmZ/mMACNaQyBlEVOjJkW51wcz99nJj1LrLnQPgo9tYaeWeMImdLIGJoVsboqV8qB9PiROJwYFRtlUGJKODfy+Y14YvekeGtnu0PXOavYrnHCG2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293692; c=relaxed/simple;
	bh=LamYNJyHf5VkogCGi1TjgpBpeINlZc23XdkD9mpV1XI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ueu1+Mu8rmifGIKLQgRSJwRbW+6ilDFce54ti6UmaB0oIH8XPZZDUi8MdDNIEQGL05NnlqYvPkd4Y8cbK0tASOhmqUwm3l6Iif3ZiEkyYjGjcrb4bt0DwhUSOS0TY+g/OcSHGPjIElU0K+VPBwmgjr1GCm6fVOm1q1faXvFDkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TBVRREXW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBVRREXW"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso11447623a12.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293689; x=1777898489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXO4qcLPVw1QMuaG9x0euw2dZCLNHOgh6d4gypd7vF8=;
        b=TBVRREXWZOw3Ut9pTDpWBs6ZjI7Weu9A77cH47w7tS/re7IQD4hZLyLjjQK1sov0dU
         MfJNSqh5UpmGUdZc4nTxLVss907Hfg7vRLYD4XdRVPgiANiai7i1vVVr1Wap7oX+Fr1J
         tu6a3cnCtIogDVX33h+OI05y6fVXTytLuUpZ1G4tL2XmAhjdm6mu+XrgUGN0pvq7KhAf
         jG3etR+lJwvFMzF1KO1a2DkD5W46F2EvTxMt6ICaeZBVZyCJl2guR5dacPx5+tjI756U
         Rs8ZKhPKULS2ywTGTJxzTNZdBpx7MwHTstWdoctsqmqmIXizltlVvP4BNpvGtq7IfQwe
         mPIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293689; x=1777898489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bXO4qcLPVw1QMuaG9x0euw2dZCLNHOgh6d4gypd7vF8=;
        b=eHNQcNcIMH8KUYQZPOJWAB88KzYWJPfrPcAL49nGZRIqhZzUNmRTxMWPzRAOC19xJj
         OWbwHajM3k9i2hmWWCb6wJNNIMPVbZLU/Ph/QYqHytklfN5mPOl5gcJf4Ljb6uw9DeeR
         WRwEcZPbO7bSYbvJKWjgqyBb1QalwAua6G8XUj5Vw73baOxlc1TyBN0secQ81LKVu0HM
         RxV/TAY1WEjup0rRhvS3OSkEjV+GxtjDhSt+SQk/+jXv2p0+qjGehJYmAQ2awObfkiwJ
         q16wascQGEC3x7ZDUQ4sjb/ExSk87w33FjDNZXNUKeBVFetHUzRels/ob2VBYEdC6ylA
         c29g==
X-Gm-Message-State: AOJu0Yw7DLHrr+cDet9GItijqUvINR/j97ClQcZa2YfRuXizwwM/SM92
	Hik5xnZmSgeferqnzYsEZYkCWIwFjs6r0aQW+rrfD8uBanvy/PCLbOF0+i3VUw==
X-Gm-Gg: AeBDievjM2QCYQ5Z5Ge1TmphPfsxnKvaIyGhoMMjgLuf+zAdxKlhnAZK95Xz62SvCz1
	gkvpdoYZqk9vmchrqCRoygjltX2zOSoqKVI3xmbJhOeyC2AaTJIF00jKcNS/M44w+XLRDC4+FdU
	MGPU/5DEJXQ99VBIsSRvUQ/hap3h7fftP70gw2jDw86KCQufEdLYEARpXLzKQmR04yFVyd9G0ad
	STW3mIbvHB8iBszEi3Z3kw0d1U9AvTWU/5gdfiLUqpepU62Q0L0L6XxyDlFBuqFGRVDTASynCb6
	XO9vOl6jsrsnYL/JX9tquztMB/6vK2dYegGMTdqis6UqfzbhxPpzy1uMtrYylKDUjrHHwopFGL9
	MYMU3k6JxiHSj4Tmvj0k+TfSloV4dbPAynzb+80eabC1ItqX57fh9mciqNFjU7uQ0vHE1Stns9t
	ASFKqvWzu2R0OUhy4rjbknoAjO1P1pXmxRoXRHW9egeRZ0zmvlKWIFHGN+ggPPLGwN7VcSlhxrR
	Z/dA+ftMHfvfMJzy9zMfYYmIcWwcA5sZV6bRdjVW31+webLnA==
X-Received: by 2002:a05:6402:5017:b0:66e:a5c3:f002 with SMTP id 4fb4d7f45d1cf-672bffde63bmr17593662a12.6.1777293689104;
        Mon, 27 Apr 2026 05:41:29 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:28 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/8] urlmatch: change 'allow_globs' arg to bool
Date: Mon, 27 Apr 2026 14:41:02 +0200
Message-ID: <20260427124108.3524129-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
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
2.54.0.19.gb68b9497aa

