Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED49378D71
	for <git@vger.kernel.org>; Tue, 21 Apr 2026 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776799319; cv=none; b=d5XRO/QwdGcGdJPt8pPWzxyWibeqct11cTy+pNx0zPndPjJ04riAl2H/X6ATCOmBp+X76nrD6r9Idsmb768zH69sI4VP65HmDaUKEnBB84alAZvTAZCoAKA/JqpPlWtVj/5KOAO4LqAHeRyd8yc+4XANKWclXG9TLVInqCnBnYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776799319; c=relaxed/simple;
	bh=/a595QzXjV8h7Vjkh34LAcwrS5+Wqh5yQ3Okiqr9blY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDlW//73+FnM8uetXW+Bf1lGT1LDEe9IsH+QcEAnvl4Dvo5p1Y6wKIIwvrrqFUGLFAzUiFXesIEuA4YF5/M5L4zeeWZBTaaxt3FFwtcPKT+RP+RSyaaXSL/yqxkchZyWH3kgwLFW/LmwWDCnSXeZNaJCwFwNfA2YoiHnjIHfjDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HlvzsV/q; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HlvzsV/q"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2538153f8f.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2026 12:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776799317; x=1777404117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6sZFK8xPB91x4pyxld2eOuoqtRiKleS2KbNgQEO/OA=;
        b=HlvzsV/q2fpeZqe/9OJlKe2AHF3RH1zfnjXkEM7PHb21l/w4Eu2G1O0v07rDQAJTbY
         jr4/Nf2THyf9T6dnqu4BdCycfq3MLjisSjamyjP8wnGPlVB3wvbfCmB/ReOkNmx+5ZVg
         LFAL45kzmIOn6f2PExm2Fhue7lVrNKcPQtssbIZeBfjrKKDCsKXgMNOeeKjE6IHVJx+Z
         trw/TWZxPedZpeFlkhbreSfGvQTy3vemvSwfZr1WxBiWP17felv/PTkyddrhDu6U9aUq
         BwZ6e91MoyQA7y28AuGV6Xc8Awcmt274IH6H9aVsHXAARnn43EVaYlXIaIbmelpq4F7/
         G4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776799317; x=1777404117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6sZFK8xPB91x4pyxld2eOuoqtRiKleS2KbNgQEO/OA=;
        b=XtDrKHdoifSWUy+A/AIEmHzg2mYNY9jU6qnYAKy7rlSazqZZrT/od9t0uqdONxqM/g
         nFulB1ajO5WlWEgpJqi2s5AomXbXzwEZ/LsuS77vyoKr3JwRdMwdVSz6X40wVC3OXXC/
         agzf0BcOfbvxEOp3TlX7Cbi3OsCqoDxFrneKSvxkfpHsd5TMPMYlrIoec2hfRhKkWUgF
         QDf/Az7Wa09/zaCvGhhn/FBBzuaQuhlT/ySiEkRu60oRLq9l3Dq4TTCXVLRZiL+ee4M8
         Y3uhr07kF4rCC8NSb5yYYFkS0hqzCA+MZRI6wWOaD2aF841mgFPL1PPEyWK1nUj0ZG8c
         A69g==
X-Gm-Message-State: AOJu0YwiRAM4OyvzfgrxQDrjgwGGbdgAL3fgLXYvIAAnEGEsN/vkT7Ap
	akzjCm0Zt1nJ/ZxAIiUBJoFzacbNfida8nO9/OlSVhe1vIUaNZTLy1OpvWgM2A==
X-Gm-Gg: AeBDiet2o3vmOnaGGis93BO2lyhMyj1Xe2mz7lgqTwi/z9rQxbRfqMACI3XEX87o+35
	XiVROwgYIn6PF7iUt6o+bXuZ0Kzkb0HMb45Ub57izfgGPiJRN4p9q8bDQwNZlD+p9rJ+PzzaMPs
	DrGqOa9zOVNK4xkSooQItY5ItknQ0D5UdpvQB+yAfxL3My58kvHdlGgg9+l6pFpWiuf/RJUVkFH
	5TGriCnHq+wnM+8zEwAIdGBzwklzy4YMYz4CY/D8RmAQoEFx+0dpRn5mXgdic3WE68jAuN9pHNF
	DCJfP/AFaI7bFPrZ5SoUr28n6fVich7hTqMpzIdKvoyfa9jysDKFhs7+pYoJeaBg5TZ/X19jlPp
	LoNy+P7CJIrKs2QcU1aX/GdMclMR2W31nP+6ftR2PsW59CZc7eJdaEzAF/Tbz3GQFycEeyZbo/j
	9jSuUYr9n93NjMjKMlvYnZzWqAQcPoWQVB2gI9NSuC6uE45Kt140DnHsmVdj8qgbc=
X-Received: by 2002:a5d:64e7:0:b0:43d:5ec9:246 with SMTP id ffacd0b85a97d-43fe3db2d0fmr29888830f8f.12.1776799316505;
        Tue, 21 Apr 2026 12:21:56 -0700 (PDT)
Received: from localhost (92-249-246-20.pool.digikabel.hu. [92.249.246.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm41726791f8f.17.2026.04.21.12.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 12:21:55 -0700 (PDT)
From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2] t6112: avoid tilde expansion
Date: Tue, 21 Apr 2026 21:21:32 +0200
Message-ID: <20260421192132.51172-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.54.0.655.g69726bb9dc
In-Reply-To: <20260418163236.2382826-1-szeder.dev@gmail.com>
References: <20260418163236.2382826-1-szeder.dev@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

e987df5fe6 (list-objects-filter: implement composite filters,
2019-06-27) introduced a test to "t6112-rev-list-filters-objects.sh"
that checks the output of a Git command with the following commands:

  grep ~$omitted_1 actual &&
  grep ~$omitted_2 actual &&
  grep ~$omitted_3 actual &&

Since the leading tilde in the pattern is not quoted/escaped, it is
subject to tilde expansion.  So if the system has a user whose
username happens to be "$omitted_1", then "grep" would look for that
user's home directory.

Quote those words starting with a tilde to avoid this.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
Same diff, updated commit message.

 t/t6112-rev-list-filters-objects.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6112-rev-list-filters-objects.sh b/t/t6112-rev-list-filters-objects.sh
index 39211ef989..e0a825bccf 100755
--- a/t/t6112-rev-list-filters-objects.sh
+++ b/t/t6112-rev-list-filters-objects.sh
@@ -623,9 +623,9 @@ test_expect_success 'verify collecting omits in combined: filter' '
 	omitted_2=$(echo a     | git hash-object --stdin) &&
 	omitted_3=$(echo abcde | git hash-object --stdin) &&
 
-	grep ~$omitted_1 actual &&
-	grep ~$omitted_2 actual &&
-	grep ~$omitted_3 actual &&
+	grep "~$omitted_1" actual &&
+	grep "~$omitted_2" actual &&
+	grep "~$omitted_3" actual &&
 	test_line_count = 3 actual
 '
 
-- 
2.54.0.655.g69726bb9dc

