Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B57D3451DF
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071199; cv=none; b=G8Eh4h3mCGU+hsfPycPEjPWah6eoKFDx8jOEicLX8l6vDmxUiY92npi4BNbkOMJI6oAt7ApTZXGDVSEioB29mLXS0MF9bdEhbLi4Y6oFnYPx5m7BlDwdmMgfZbGd7FSXa00aIIXUBvMra3yqXNIoGMEYwNOLP72eu3NpeeaF/Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071199; c=relaxed/simple;
	bh=/1SnD3WYBHp1TwPoq1VIuriILgy4qstGvpGLP8cKBOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iGVY4oSHl/WC5FMIFpSU+z5w6Zpm2vZj5IdrRVahY1vnADDKcCNhwhY/20HMknsdHS0hlWrTgz9DHFvCC9isqfRSLMxH+8WrGVwpPh/LnexzpFG4dH7a6BWSioWh5vwYstntktFNJySKEdclqdMx+CbKDkDwu/ADaJ8ccSDYLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDoA5A/t; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDoA5A/t"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7c288d3f249so2219661a34.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071196; x=1761675996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=YDoA5A/tTGuZt7PaVvl+1ijZhPOPgnbw3JtzFzw5FaiWJA5c7Pj4+/QXiX+ANWA9+m
         6fvYzZAFVk4VzVT6v3/6gPO5N21n2PhocnNQeu9fOCwY7TXwpWKK/dvaoIfUG7NfzsK/
         h1PaVHDCywLR5iu54MdvwbRD25VCjSkK06vBgbhWEJxr2PXZVSUPaPew91VbEa12bxW9
         wVzNgsz9L55kDeeWCtgkb9KZNoULL4g6nGvSaWLkUrEutcJI/PrSkBQe/8fAKYMUHHyq
         h8XFJvrqRNbo4Tw2kI16S6cSpEnI2x+HVuBydP9GUVHsirVPiD2/PEsaWt42TYKiVczP
         G1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071196; x=1761675996;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hY2YdpRXIoSdDtOeSL1Fzj0grP/ivSC2SYohVHa3Vss=;
        b=cDMJxMMBGTI+qpKwsi8o124SdHahXKuIn+m/v6GlpGwsiDlbj1Wj9K442NW6C7hxZ9
         RFtmSobu6oUrJS/FquPMIQG/WxNOvwX4vwbkUJaPTCe49fBLExTF6K3TphpztQeHn722
         JeIeGdCcnThpY5m1/4o+QALTxKjzqN2e4G5aQYYvPWCzuhMTCs4+kzMt2oi9ZH4S1Dx5
         uynGjS2hdGMl1gjZGAk7ShV9kDGBPGonlsmliBfFprJ54d9iT/K/y1aXF5oXpdg+iXqH
         SwwClNHm+T9fiYFEbbzbbpX6b7FvlLgvzLZR2TgPB/OGWflF2KUkMk3TdOsn0thSOBd6
         k0NA==
X-Gm-Message-State: AOJu0YzaeF8ftT9VFwSIiiW9Ct1jkV9ysrDWS35IMBS7ZjzPFTIykD3g
	MZmZYw4iku66uwOgWYm4fmsviq0WoKKaye3oaB/q9TGC1w9tF6kBi2TwDfIRHw==
X-Gm-Gg: ASbGncuD3dDKsB4oJ54IwOirl2snpOayWNvhAT2RvzLwg4sKedELjRsM+Zzaly2Af/W
	bcHG5qYh10wlzyl37FRjoq+0tReAbAEz8d/1GxNQBkSVN82nVzFy/VcZH++KJqznYjpaCzO68sJ
	zGjAVVV8N17rjJTYiv19NawuuME/aoUI8c+G5Ig/deidwj5RyYs0rYcMesTMgQ+bopiIg5hIjNT
	KfUG+dBhl2OZ9CkVn060MUWrQOtySOKR7etRtoJbBahobQm6D0828fKLbjfAHYnFSbbNuUTnzaC
	icZrwnmoKFvMtqeIcqyJYpJ0vobGfE0npSJfdthTf3KcrMmVMscHkLybrDvzWRNM4Jl38FrWW8F
	bybHXmGsRDz1C1B4Ki9dKrchBtrx40wFnJKNSF1cLBpJf5M15oppKee4jyjiVPdO9ev51sFv2ug
	kyeet+kae5
X-Google-Smtp-Source: AGHT+IEEF8Fpu2/0XHoogxmNRRcMgvr1hxPBRgr0Iq1a0sMpri9/dA9J8CTahYR3GGkOnrXZeB3uyw==
X-Received: by 2002:a05:6808:1993:b0:43f:ac2d:dd3a with SMTP id 5614622812f47-443a2f44ba1mr8925991b6e.26.1761071196459;
        Tue, 21 Oct 2025 11:26:36 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:36 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v6 2/7] ref-filter: allow NULL filter pattern
Date: Tue, 21 Oct 2025 13:25:56 -0500
Message-ID: <20251021182601.2687284-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
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

