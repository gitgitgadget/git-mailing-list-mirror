Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB21B3126C2
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205113; cv=none; b=RA2NgyrySCxKaGlce/Lqqj3zImIfNKa6Nou+FrGEy8puU846KfEL7M3sGxXjOuMiZPlcK3TQlVbJ/97EzE1dsPNwaGx6LDQL2ChtQWd87LtUkQXFoKf6dAAf0Qo1Hd0Ba02AzenIjgojBUWMCwI4MR/stxDRmtysxpbKVHEeGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205113; c=relaxed/simple;
	bh=c7TPP8pm3twVQbJ1K/oMrCMJxTHFPf4BNUrhrcfnjds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nM62tyhQj5FTm0AMP8K3i0FSN03QhdIY1BcgzpbUgt4dyzUZpQ/ABY/Yf9ftVMpEc6jKpJ+E9dbmgmfcqORIMyOIA3k+54ACbu+1a3QsYhie5tpLzOrdb69rMR+DOcPRMioJx1/9ig45QYaLUg0QtsmLhdP+ib4SvDqDH2YgfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDk8V4OQ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDk8V4OQ"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-67bc8609a9bso7737709a12.0
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779205110; x=1779809910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K2zcIeP7bxKErgtbMwr2aIPG04JpwgZTguQf429yreI=;
        b=PDk8V4OQmWDfzBEDuF6s1zyh4ob6xsQ1mFnYeGNDPmg45PJPEneLnBBasfHBjB1eSS
         Z059Yxc8aEaeqQZXQkCnWvCfGlJV4ExfieMqHiahPZEqpxorqtvcmGAng0Hfxa1GqSaN
         tlU+C4T12+IVq9W4UlEUDOaeOXakD6cs/6GaKfEwW/DtLKX38yWymcruHri7sAlDE1pf
         GrcfuPftiok+I0MrueyAW2ZbKC4iK745Ibxnck9hH/kf9fHEVYrNiKRzwaR2sk7jAJVR
         152pfz/MLEvsRcbA1TwWpvCE6g8Lgg2vD7l3c0Qhrey9FX1iEdxIVTjvfU77OkEhqXGq
         4RaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205110; x=1779809910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K2zcIeP7bxKErgtbMwr2aIPG04JpwgZTguQf429yreI=;
        b=OwFDr0AZC1nV7ppi6Y24n49U2KoK9ettNqUIH+QtqRrhSdqTjz9oL2CB/HRSMGTo6d
         mXl7/HOh93/I6GaaJhHeTV/UUmoQ/I+3hRvumk7KxM3xe6PEZYBLqP4v6kzKQEaNvLMU
         eQCQsFOe1P+rsdz1A3K5MDAMB5OJlxYVm7EoRZv9e3BoyD8OWAVPKnAXi0+NfUWlbFcQ
         Gtz6Tdx6i6QHXbPa2+q1m3FHPV3FP+mEYN25WgzPI5u+fYeNHsvApQGGHYht+yB0OYed
         Y/NlfTIdPOR/9qOZ1Xdgn+cQrZt5/L0b/bNAwWU9TttKtGBl8D/efdmYR3/j/QaEZaIi
         6myg==
X-Gm-Message-State: AOJu0YwRIhEQcPDZHE5BRN91FVeXYJsyuuxJMIHp43bRg3ig1H3w0/jb
	uGZDYViytTPQkqHs3SBU5pyS1Cijtk+twRXfJd2naXtLkCjHSEkzhxh3ogFj0g==
X-Gm-Gg: Acq92OE8BeThw5kJTEg8ToPE5JoCuvr+SrMwm5puoMvDuJXUc4ozfN89jfAvliBCuuJ
	VkSYZIOnJdxUFXPeack4VKgIZxspvbak7TfRsXHUPh8UVI/zDm2KxdHDHmDps81CkS5WqC6TU3b
	WyGMZCIvWAAGZpBIAbqeoXFlPQ+te5LvuocdOU9Rj5FBOcInNH6d0V1dfRVX61YQQgah+Bt+lVM
	C7RRYwSBvvsuFlh+S4v2ePMGKcsHzHHJPvE3ZLTl+6q6rhGC/0ZSc/HqUV0A19FwXBd4tJ0L5/D
	/DIjyLTBD5SgSHWleCeMhbd25CksZvqWUbE5Wb/62cI5YjJ+XRnvwoXWba8pUAPBAi29aDfHNKN
	kzo3N2rwg0YsQ5+vGgasPHKZXwgoV6UBFf3h2YTjYCZs901uXMGPd3frd+2vcz2FwmTOBaSx/kH
	+KMZ2CEhtDGA4omYnmPpun8du5hKJwLltv07dD5Wexw3Rp6LAzUIQgQ6nYMDdCS2QdcvdwVs3Ov
	shdGWvhWkvo12i0dmbHhMGhV/gvNnLrdvbaNDA=
X-Received: by 2002:a17:907:82a4:b0:b9c:b069:8ac3 with SMTP id a640c23a62f3a-bd51780c97emr747923266b.3.1779205109669;
        Tue, 19 May 2026 08:38:29 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd7bbae7a93sm281403766b.22.2026.05.19.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:38:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/8] urlmatch: change 'allow_globs' arg to bool
Date: Tue, 19 May 2026 17:38:02 +0200
Message-ID: <20260519153808.494105-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.136.g92075d88d8
In-Reply-To: <20260519153808.494105-1-christian.couder@gmail.com>
References: <20260427124108.3524129-1-christian.couder@gmail.com>
 <20260519153808.494105-1-christian.couder@gmail.com>
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
2.54.0.134.gbbe8e27878.dirty

