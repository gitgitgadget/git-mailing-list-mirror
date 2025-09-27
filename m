Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EF92E62AF
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984659; cv=none; b=WH29rlGKsHyJN4uWMn1PBaAEUX2LWE630PG8aC+9VbDDy5A2HNi4iMm99pMZDn5fAc0gJ/Z/RmBQ/UjOW/AEuT5mSIkQXUMje+WZoqf5E1wepu9PdXvjA9+cCLpKYIqnjbnSH5iTyGKHa4BUXZE2H4P/4fz4Ch6pQWAyDBv/PzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984659; c=relaxed/simple;
	bh=/1SnD3WYBHp1TwPoq1VIuriILgy4qstGvpGLP8cKBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZiv5GAj30Ptbw4eFxRfnty9B4ywvm13PT9c7rvuDNuxUl/j9lWVABZkiCgtG4hFrk+UhapC8ZiHtGm6qO0yKz1xqJujLkauq7D0mkbwv+fSBOXYRL8ucJo3OPCzK2FZvDT7GgYdY6WLCxI2q/fX8a+wN6V7/DookxgZBXYkgzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ff3Qe4sG; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff3Qe4sG"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7a79efc43e5so2146994a34.0
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984657; x=1759589457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=Ff3Qe4sGU+QYQ4rdCVTV/nmk3gzzEHALnRUD5oNC0KDm0SrqbFqsZ3OEXKUw0XKvzU
         EmEIWj2AURUTscbhKbc1ETb85GMExCl8PGJSsqE27Grl9gbenN+9WTHaEIdI+oIkxDU2
         0fEwNwF6SwVhU0DV2ksC1bSJsc+syrkqKOHGrLYg83nI/QjjriYwx6jWJgqjjBE10ibN
         v/DA9YocTYTYnSFDBv0zoq5grxQG2uulZvcja45w4ao2b+hMkyQOgvJdHOq/MyWEBxsx
         V9MnkBzN0C9v+34rCQoUoqNnmARL88CxhjYCZu5jly5A39k5mkSc2Sa2Tldr5yFUAws1
         Mp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984657; x=1759589457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=h2xKvrVLH1J1hUpPHOzmv1V2oyDlvs0WA9lwxtuFTT8+TwENNuF0acvioUT1pUs6DX
         Rt/kiU+nKWA7024/zxEVIdza/1HP4ljUxNNGWHDOgVeAhMIiTcKziOn+7scswMzT9ofL
         imRRW2JRfzWGDygDFu80FWuxBoaNwjWpNDC/m5vTJVLeJ2j1ML2hscX/L2umPYli/o79
         ZfE1mS6N7kMqNK2/wJjmPmgZok3b9dKt3WdTbTOWx+C2o/RMoiKsiZHt0K/A00vmdWb1
         MaEKkJ3vpMojOkZHx4smgfsc+LdWZQDQtIp23ivossj00wsBPbqlibhjBIqq2nIv9m4y
         rfww==
X-Gm-Message-State: AOJu0Yz/idqgb5LscA3/MFHO3Hy2Q3Fr3IWY78rifZimiBIyRrkj3WxB
	VwUDYTQNmZz4AxmADViBAdG9ft07pTEo8mQ/sqoasAXdn1pvMC76NpcJxNZnSg==
X-Gm-Gg: ASbGnctzkLCOFsGUKswhTqJbZtmNgM/Ks5KV038+3lDC1apnxjhfAwhfMw/aTQWSPDX
	UxM9lC9DF0MhgcMyjelokVDkuPWFIqzyXzos6j4nO3/9B/JVASQZdec3dXqwtqWFACi6/FeK3PE
	SxTCWD5BGP82Llij6vF/up2hsEXKTo80fD/FesjU39SKugbnPKg49zvDXa3Y2+FcZutPWBKOkT8
	a91PdM87qsXnpwbL9kSv9p/muKr1O09Jdeip2Le+paTB51hDJsqKmbFwY98jXekTedl2CmyNocL
	8cCs5p/d2lik1dIubJ/+keqsHrXtcWZZckvI/Pi/JA/S6VDm6YggaJW65t7oGIKJ6sFX6RH0Q2X
	u+4czqJzym0NlHn9GLRNw8//7ZJ/0lNoiiEAnJtj1XQ==
X-Google-Smtp-Source: AGHT+IEpKEbk2VNC9SRcZ791o5qfG3Ho2nfIwCxnzTAbd8L9xRYEIaLR6sSo38CD2/VnAZnXmYhAnw==
X-Received: by 2002:a05:6808:d47:b0:438:2199:6874 with SMTP id 5614622812f47-43f4cf43350mr3671392b6e.50.1758984656643;
        Sat, 27 Sep 2025 07:50:56 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:56 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 2/7] ref-filter: allow NULL filter pattern
Date: Sat, 27 Sep 2025 09:50:44 -0500
Message-ID: <20250927145049.723341-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting up `struct ref_filter` for filter_refs(), the
`name_patterns` field must point to an array of pattern strings even if
no patterns are required. To improve this interface, treat a NULL
`name_patterns` field the same as when it points to an empty array.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 ref-filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 520d2539c9..2cb5a166d6 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2664,7 +2664,7 @@ static int match_name_as_path(const char **pattern, const char *refname,
 /* Return 1 if the refname matches one of the patterns, otherwise 0. */
 static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 {
-	if (!*filter->name_patterns)
+	if (!filter->name_patterns || !*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
 		return match_name_as_path(filter->name_patterns, refname,
@@ -2751,7 +2751,7 @@ static int for_each_fullref_in_pattern(struct ref_filter *filter,
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
 
-	if (!filter->name_patterns[0]) {
+	if (!filter->name_patterns || !filter->name_patterns[0]) {
 		/* no patterns; we have to look at everything */
 		return for_each_fullref_with_seek(filter, cb, cb_data, 0);
 	}
-- 
2.51.0.193.g4975ec3473b

