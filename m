Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3241439BFE1
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615790; cv=none; b=iu3VX1iN5YkRGBmMVkjDifkbvojK+cq9NozKhmQx9F7Fc/nwJQOZYLHpvy8jT+lAo6nxlLnGlt0+eSKwFwQCej4gKOvojKoU1+t9LTMEz/C1z0t5EVM9L7MM0MYO/gHPBBNCB1xHj98Ba67/MXIxNXG70atraFdamU2OflEjGik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615790; c=relaxed/simple;
	bh=uUY/dFDtB22Glo0i1GVMJQyB7zgUYRhgGg1nB8LfTXs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gCxbBe+2AhW3DQb/SFM4F/j6VVjanhgntZs6k2QVw9PNs4t9dqQG4QozdlKVFqZaRJUc6eFRYQF75bvGvTWF0w9uPzL/SOxA28KzMOssdWj8it2kIou7B9/CN6faMwjsJcfHMtKDVB3jGdCF7rrFOIG5R6tSGktN4NDgV3dpHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZe2PANm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZe2PANm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-ca957432c7fso39967a12.1
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783615788; x=1784220588; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6hdLMfLyJNaWUbInt1Wy/z9G4AoixY+5/X5whJhnJ1U=;
        b=oZe2PANm7b7bzxgnXvgrgVat+MZ/7ZOOvP7smWJKOabILEP16Rdni62Mwm7jaATlqP
         /Lf3TsfXmAWHl+3ngnXmmtxQSZg9azHkb9GdIMvId7zzNMzcheEa29putxtPFQ5nHzgC
         c6b/gzuw5YHw6dSziDQM3ieA/1BOYemNepwysWVsssF+pSHZLkULn+4Pc52TkKaJczgG
         37kWpKmvaWEwKYtG8ee1A5kMZZdl3LIA2V4hJTuefPTS8pSzmrncHDY0HLm4ijx8Ag7E
         tTcBA37cQk0e6wFo50NWg7STUR7F3xh0hoasfghIy5k+OxaQX4FQdLdpO4rVR0PM+U0Z
         mcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783615788; x=1784220588;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6hdLMfLyJNaWUbInt1Wy/z9G4AoixY+5/X5whJhnJ1U=;
        b=LPQg74xYOui8STb0reFUPub2nuozJBAqbOspn2DSc4H//n4LgdU1n9KIhI88ZxrsrH
         dAJaRHoiJnRFsbWRurSTJs4OKXleMojlBqaTBgP5mw5Q0b0hUGNKTTxf6kulAV0SttlL
         4tb4jsJib1lMLM31X3Emz5kBjqzfjfTy3uoJEDRMrl/YWEOw7QWT1oDlK2pC0/xUxZl2
         R67B54Bhy7oj0QDDTZQEqZHZoIGe9WPU5llFMa0qoLr+2/9CybDtZRyP5zYQsLhVSSqY
         YfBY2MDXj2eU2Iw8k6b/M3lSodhI3WTLSSjrQR9nAw+BZsGHAqgiNXLbJhLCllI4Yio3
         f21Q==
X-Gm-Message-State: AOJu0Yz1YfNF9bPhNxsC11tB3Myk11LpK+C4SL2JLuqodHaKwrgFi0tE
	n+p0JaRyxLH9O6Rfoh6HIQ5Y0gS7uneFMGH4vniwo9+uzhu5l2SV8o1rupVZrw==
X-Gm-Gg: AfdE7cnz+pW1+Q9WKXBs7NQg5xYCnEj+Iz0qYLJiVJVCprxxohBJPyESxm2dZT53YvY
	RwTOzjPVvckM7U3mVX967AgWlc36x4hQXR1rkh2gOOGMeHfhIc8MOSvivMT92pJcsuvyuE0R/cS
	X/tRofXA65BmPIBUZqX+IPbg2qklUD+SLQRFQ7H/u7srWDn4mA48tcKm7BTvPoEJMj6lNAC3FHD
	qXD2CWOyHBkMuE/D2O5IN8CA8WAf1GrtTtLKo06918nEUxNVVh5gNdzyNnzoxMT11KnKFPhO444
	Ahmj68F8oHoopfIJqnS4KGBfZtIA3zZfXswG2GHMMvKq9deC+vdpAbW++f15LgR3Q4PgnQKtTEF
	Ez2ifuiWoHNoyPpjFlrJgGrfqSSwBDeiZzR1kgrdO/dFKcH2fzfS5UwfabeHwWUlq3Vtt+Z6KJK
	ADStjCB+Fnj6OmpXw=
X-Received: by 2002:a05:6a21:700e:b0:3c0:9c19:658b with SMTP id adf61e73a8af0-3c0bcfea275mr9969633637.69.1783615788462;
        Thu, 09 Jul 2026 09:49:48 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.59.115])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f598dsm33789468eec.6.2026.07.09.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 09:49:47 -0700 (PDT)
Message-Id: <07d01200a48c79ba6b3da594d29d685b2c5865d0.1783615780.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 16:49:31 +0000
Subject: [PATCH 04/12] pack-objects: widen `free_unpacked()` return to
 `size_t`
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

`free_unpacked()` sums two byte counts: `sizeof_delta_index()` and
`SIZE(n->entry)`. The latter has been `size_t` since the prior topic
"More work supporting objects larger than 4GB on Windows" widened
`SIZE()`/`oe_size()` to `size_t`, so accumulating it into an `unsigned
long` return was a silent Windows-only truncation on a packing run with
many large objects.

The sole caller, `find_deltas()`, still holds its own `mem_usage` in an
`unsigned long` for now, and therefore still truncates silently.

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/pack-objects.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index f89628a760..4737a6a32c 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2972,9 +2972,9 @@ static unsigned int check_delta_limit(struct object_entry *me, unsigned int n)
 	return m;
 }
 
-static unsigned long free_unpacked(struct unpacked *n)
+static size_t free_unpacked(struct unpacked *n)
 {
-	unsigned long freed_mem = sizeof_delta_index(n->index);
+	size_t freed_mem = sizeof_delta_index(n->index);
 	free_delta_index(n->index);
 	n->index = NULL;
 	if (n->data) {
-- 
gitgitgadget

