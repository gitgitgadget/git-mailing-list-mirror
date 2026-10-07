Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377CB369997
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390932; cv=none; b=VTLQxsHnK20uwOEKcvF+z/d7TWHfPYY5xjMlTE+1DG1U2Om9hOC1IVSE/wvVQDWZi8jK/6GKCK/mf0BomMUYeLscRfsxPnXy2eSLJjF6U3+iF6djF8TJs5lTGka/Xo4qig0lb4dHXBSuocr2u7cmP9A5YyNig/V3nNvQ6AzCq0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390932; c=relaxed/simple;
	bh=OB1y5sGxLMkm15yegKG9CSxKul44wKSx7e4VIGbVGyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOBOhEGct/voG85vNf/7v9nxnLRsek6r4/NE+mhqlwZyuxyTVXMHKPIpgdxfHF//4IZPqdAMcTbRzao4Zpv1QYvTdGOzsjIvygD9GustKeg1K0bGwxHKXIEKHybTTDMVFBlN40lOleoOlWoaz4oa97PFwiCyxQjS8UL7wady8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YKYkvna0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKYkvna0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so14240325ad.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 09:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390930; x=1791995730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca/0O2V1ZAe4Yb79xG/6S1JRbQT6NnG4wVarA+/G4Mg=;
        b=YKYkvna0Wafte5k1sby0jAVYwI1B1ZQNiqU1LVBBzRFeB1wElxzlkG/c0lrKsoDmJH
         6JMBf/bodemgaUBNiSZBJ3UX7gmbkg9KfWnOitHN4PSNXX+u0ob2GQcgaKM1AOYTCpzj
         XJ3zxTimPCCrlMcOrh6cZIaJAdEVXVRYx0g5wdwd6fWsGQpX18jfah/9QuYDtNFg/BJS
         UGq9KnTDR7faJMAQ2qq3+G5BkpIpK5upgtEn06fPWLTyZo0sy65hovpNAc8B5usNlXPC
         YHB2P7/nelylFcPoLPYDU9Jf5uOkFXOl/aat578Dcde1vFLt4D1/pKW/mYsGHu99c6VZ
         ITgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390930; x=1791995730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ca/0O2V1ZAe4Yb79xG/6S1JRbQT6NnG4wVarA+/G4Mg=;
        b=O2oftlLHbN+SsA/olwBHcnmnjiuWlWNJNVcPLLhjrsmZxwh5J3R+oEp32rnVVEdy0x
         HKNlYTIHcIt/Cgkblb/WdOkWeHx9fjLvy6GM98uwwem6mXiYO7Mk79JHFbgoDY8nqEX1
         2Nls42iC/vhXGol6bEFkv1PxHg8NANSHzmL9tg4KOkUbedTLp1oO7XpcZOAcFK8TQhjT
         R4LAGh8flBIiUrOkMQNQuzJT9RrSTBG35gsOHYp39KwIghD1X+fBduXBqs2VsfYRshy2
         JQ/pw358eY46y6f4oxtTQbBkhe1lMy2Q9oT/pKaWFl/PjqKVFP1tgSKpIxX7z2321zDp
         Hkhg==
X-Gm-Message-State: AFq9FYIQnSzP4n9V72I+1LU1ZKoPrbxx+5kryyktBCxmLQs7DRffLUF5
	t1QQi5dg+qUAi+hv44GDv9KpMBgWkqX12UH81oB1G3f/eJe4Vr1dFRERa6mCtmLSzYw=
X-Gm-Gg: AYBFou2S2L27ZBhCeJv18dbuEFliqOVCSy/K21FoBdj7scvv05vhshsY3Yf4tFH/8FS
	NxxZVNOhrN0xRe/fd0/NcZkoI9Zhmmjp9OVh7Ud2fMJ6d6hXKS2n3JbI2lMUWOF9yxEAJmN5Eul
	y27MwDN7Mgpk/UarBugkwwA/NCSGmxOaE4aFw67SSnRh6YjpQfuUEvub0/ZZhAZGBadn9Bw4Fr4
	gD2TEK3ym3hmB3Pomrb9PFBpmvyVmHMDbh33QmJE2N2/g2+X/3nyCUmF8wujYucDhHy4Miwd5Ea
	RoTT9p8SDheZoQvfZsaxVjMi4oaEHs0iJWMpQUbOEeiC8hKz4f3ePO+5TXhpoPAR0khVGlVHh2S
	8M3+3n9FtcvdYbzr9ZDM/yYuYTq8g5VnPmAyovLh4dVcamRgEVWtI7cY3aWOZNu7Mj5n8drVXFB
	zoUEWS6x7gf1YrCsfcHP455sDgz3Bm9/UlhImLLYpI+3WIM6bDnZiyv3hWwSFGt+9mQyoX5DjJC
	UyMePo=
X-Received: by 2002:a17:903:2449:b0:2e2:dd21:50cd with SMTP id d9443c01a7336-2e60059e3e4mr27086675ad.56.1791390930208;
        Wed, 07 Oct 2026 09:35:30 -0700 (PDT)
Received: from archlinux ([2409:40f4:314a:a1e2:9855:ada9:1db7:a1fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604948613sm14826555ad.63.2026.10.07.09.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:35:29 -0700 (PDT)
Sender: Dilshad <hello.dilshad.in@gmail.com>
From: Muhammed Dilshad A <dilsheddilu123@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Muhammed Dilshad A <dilsheddilu123@gmail.com>
Subject: [PATCH v2 0/2] combine-diff: honor relative paths consistently
Date: Wed,  7 Oct 2026 22:05:12 +0530
Message-ID: <cover.1791390459.git.dilsheddilu123@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <xmqqld89bmd1.fsf@gitster.g>
References: <xmqqld89bmd1.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for the review. I checked the path handling and reproduced the
cross-directory rename case you described.

With plain -M, the outside source is filtered before rename detection.
With --follow, though, Git searches for renames with an unfiltered tree
comparison, so an outside parent name can reach the combined output.
The revised patch prints there/file as ../there/file when the prefix is
here/. All displayed names then use the same base. The tests cover both
discovery paths, including raw and NUL-separated output.

The index rejects repeated separators, but tree entry parsing does not
enforce the same check. The helper now skips all separators at the prefix
boundary, so it does not rely on there being only one. Explicit prefix
arguments stay literal, matching ordinary diff's filtering behavior.
I also wrapped the added C lines to fit the coding guidelines.

While checking the two discovery paths, I found that the fast multi-tree
scan bypasses the relative-prefix filter entirely. Patch 2 fixes that
separately and adds tests for outside paths and repeated separators in
an explicit prefix.

Changes since v1:

* Use relative_path() for parent names outside the prefix while keeping
  ordinary diff's literal-prefix behavior for matching names.
* Preserve /dev/null, skip all boundary separators, and wrap long lines.
* Add cross-directory rename tests and the separate fast-scan fix.

The developer build with SANITIZE=leak succeeds. The affected suites pass
all 77 normal tests with SHA-1 and SHA-256. A separate run with
LSAN_OPTIONS=detect_leaks=1 also passes without a leak report. The existing
three-parent coalescing failure in t4038 remains an expected failure.

Muhammed Dilshad A (2):
  combine-diff: honor --relative when printing paths
  combine-diff: filter the fast scan by the relative prefix

 combine-diff.c           |  70 ++++++++++++++++++---
 t/t4038-diff-combined.sh | 130 +++++++++++++++++++++++++++++++++++++++
 t/t4045-diff-relative.sh |  62 ++++++++++++++++++-
 3 files changed, 251 insertions(+), 11 deletions(-)


base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.55.0
