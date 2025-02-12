Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394021DC9B0
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739330839; cv=none; b=OkMuk8Ib9eIbHQlJzO8tGhiCh3j73pxwP4xOWmvMq6WlDo99iX9epKyj27ad6MbFUUIRTY+nTV7RKG0VFouWsCK0IFpTnwx+NM6N6JshzK+TsQmYaFbtt7Cj2QDXC6KMHRLn1BG4tLBGluQOaHjyWzbb2Sy8+WeXpbAHUtuG8SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739330839; c=relaxed/simple;
	bh=17N7VocmfZJeVnuHq/f0+bycl3xpueu5wz51Z3gMyA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArALWMKPIbipctzEjbitaCUqHckHfPFeUNfDqeY238kSt/E3EMqIS4d3nXDKPRRL3W/YQ/78PCmwk8e9/19c/eR3/5VdoIoo2cgvGWK5ckH9FBmOfbxl2K4eyGp3ZNHA/MfSfX9bYvGtWnwxFfAuX0nc5eD5QsAuAemTKs12bJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZudPFNc/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZudPFNc/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-219f8263ae0so112115045ad.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 19:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739330836; x=1739935636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTlfV8sxLAVM5HmOqiScCyvjUdi07C2Elp61HaMzN3c=;
        b=ZudPFNc/+7q5jPn18pqjHxwDv57Joq6e2dpqj87kkVJ1VFn9X/opHrwsuiRHJe58M2
         QQWuJHCJ2Ne1Lqq5X9TpAQ4ljjGgB8BllvA4FBLzoYcYGSAwMR8uD5m2CFg2vvhuGgTP
         +E9oX3KMPhFqNaGr97yo1/HNpEr4tV1rDamkbcs2hjhAJrFOGk13bamsDjo2GiJ8M6GL
         /hQgcpUGbjbMyWObtvJ1C8Ytq83L/HI99JFn2Nt0DFWl/11EYvEGO46ApNp+S6pVTIb4
         J0ZYcAsql1H8kaUbifedpMC6Riz0mfn9fCSKo+CPns+DRPnPUKgaDfGTE9TabcghbC7r
         eCuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739330836; x=1739935636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTlfV8sxLAVM5HmOqiScCyvjUdi07C2Elp61HaMzN3c=;
        b=V+1Vm2RWianPC8zv92eJ1nZeM96+Ul5cM7Aq0VTpZhKE72qJKusFm/djA0qlsHJnTK
         RvNBdtaGAgTRCJzES4JFsNlngAX2giZKZzThpVIYgCd5GCmdQxwypdZiQ5G3dKRId/o2
         vTgDn4rVCZiFCTbwnDgD1yJYn65p7R5TMHEHj3ZdeUJ3cHhbDZEagjduJGz32LXzrruL
         1vvwUlfc++UmKsidv9+YksPD8yA7KQeXU1wLBDS/nc1CA2Sy+5YOFokrZjwldFoKBq27
         8G+HbTBz488W9Hud5sLOHgfkPdWxmFd2iH8x7iHr0DBd0PN/Vk0S23rJWZ6pLEcXpNhb
         W9UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQIQyWNs3CXSJuXpqNcaR8PlMewWdhQk/sykEIbJtq42DVhsDg7SUBkfGaIkmKYhCv5IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcwvBrh25XIHD0Oxx0LQdG5CBsQVvS1BttdzW9kwjl/q9MMuRh
	HHQc1lTB2fJtV4fH2C638e9zwsaB77OgLwd/5Qo+yezvLjUEVgiFumeQ2LPOZGQ=
X-Gm-Gg: ASbGncuT87ufYBs1HCak31O2d3ydxXO+ELgAve/oXiisEkR5BqrtchJ6yN0J+lBiG4A
	rDTIxN369II8MfyWFVaUdoZVvIUDbY3eDuWE4Yellb81nNLpcjUv27BPVN29OfDX19fP1MpYxVX
	8HiHH35bwKEbZfCsxE7Kw9JPcHtvqM3HdVspFj30YZRPv3LHg/iioY0955O3svRtZyx1/MEsdiv
	CoYGfm0OB6yc1w++bd147ZQsemERVQjre5qtOM6DWHJJR293gu6/4sZAwxrT3OgaaTsFgoEnNka
	BF7yXesmaNRhZsSt7ol7NewKj5/beN7eGCtzMLk=
X-Google-Smtp-Source: AGHT+IHgG+cqhHLTM5GhL+QCiY9lQGQ2IdfwmRDB5WhiuGHnCCHz5+WA+EQ57NRlEGqlsXw2RJZzZg==
X-Received: by 2002:a05:6a00:841:b0:730:957d:a80f with SMTP id d2e1a72fcca58-7322c3752famr2437374b3a.2.1739330836310;
        Tue, 11 Feb 2025 19:27:16 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:508a:741e:539b:1c5c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048ae7f6esm10129577b3a.74.2025.02.11.19.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 19:27:15 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v5 03/10] diff: short help: Correct -S description
Date: Tue, 11 Feb 2025 19:26:47 -0800
Message-ID: <20250212032657.1807939-4-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250212032657.1807939-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
 <20250212032657.1807939-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`-S` shows changes that modify the number of occurrences of the
specified string, rather than only those that either completely remove
it or add it for the first time.
---
 diff.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.h b/diff.h
index 0a566f..49ece3 100644
--- a/diff.h
+++ b/diff.h
@@ -606,7 +606,7 @@ void diffcore_fix_diff_index(void);
 "                try unchanged files as candidate for copy detection.\n" \
 "  -l<n>         limit rename attempts up to <n> paths.\n" \
 "  -O<file>      reorder diffs according to the <file>.\n" \
-"  -S<string>    find filepair whose only one side contains the string.\n" \
+"  -S<string>    find filepair who differ in the number of occurrences of string.\n" \
 "  --pickaxe-all\n" \
 "                show all files diff when -S is used and hit is found.\n" \
 "  -a  --text    treat all files as text.\n"
-- 
2.45.2

