Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E41198E60
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743791991; cv=none; b=C09p4/9sQ8SPSISTlhxJl90T4Xxdy2OYWX3byl+1zAY2OYKOii0w4ciTc/5dGGvo2ufFLeAFrCpblKs26/UxnBvEGWAU3eDAA8P6ZNPcBNzERwLramaNzS+5W5E2Zx07AlR2OEZ/FvoeJCJRlzJWNbwH9BBdoRwK1aIgPqAUdbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743791991; c=relaxed/simple;
	bh=Q5VLPqUKnuV3RZYGhj8OKvgnW7HRXakwlBbrNV6DA0w=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=ssFyBflYd+IiZUXUvfO3LJtHf4CCPG4LyooWH/rabCBvCOCdGmVwUiR4PVNz3QLyqFOCZ21r2MoOJrVDi7mLva3qN5oj7HoNnt1nCHNNE1TECcE63PaW64xLZJ/hLch67g3XVR5wmUbCOSVEcLSYYCEx3a5iGZOnuTHsYlKWaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR8I3f2B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR8I3f2B"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cf257158fso16448655e9.2
        for <git@vger.kernel.org>; Fri, 04 Apr 2025 11:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743791988; x=1744396788; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tDhNpGCp3uzxS52SzVsZVAv2lbCSO2h7mLkYU1s17iY=;
        b=SR8I3f2B0lJPLJFGhfJmUmNioHIVgJ2luiwjFMd2+iNbLoy4vQQldkmKmKi0QZJZqw
         AGKYTcIwvDRCZF3qY1UopoFu5VpUbaAB99OUVVbAGyeQsvmwfJ8Nt9CRYfMQhti3BP34
         9DKyFhuIBmOA42DHpQa0absXlPjSsWRhBuw8BaCwV+kTTt1T+VJGSUh3uQ9rOs/CzBKe
         rH8UJV1b/cXb3i4Z4YXJWwtj4MGR27h1/L7qkbPUsOwDKsjzmRTu41pRK3u5hVE+li5I
         IFS9mAdzAcHLYnkrEwDt06gmYkTaM6jPOWgrsA8lS6YrJB17S1FzR0r817UjpG0jZS9i
         EOWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743791988; x=1744396788;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDhNpGCp3uzxS52SzVsZVAv2lbCSO2h7mLkYU1s17iY=;
        b=JVVGjaMlpR8uSm6MG/97J+OkeUKNA3nmgKostegU8uV6mzONA4rLxPSpunj8iN8dxB
         BEc0Rlk0PIjOaSyrnvt8GEIhq4ROgfB/aQo5BL3AQqAEDr88pjNRefccgYR7qKnMV9U9
         2Ea+gD1reln+IyaT3yCvn7DY8j5EXGIQMxY0VdwsjGLBQmG0hOhLzrRSlIhAK57ns6yA
         VoCcwtsHUKO2z0Am6qOatioTaJzObHKpDUK10nAFgHseexgzjKW9mch6uH8V2bZZ9UEp
         ZJBF+/vD0VmTtJsb9reIilSXEfeFMQypsmKoF2Lab0I3x6GehA4aiVdGk+M9lbZz6pEe
         R8xQ==
X-Gm-Message-State: AOJu0YwngK1tMXsY2Suiag1AK6Q3bJuv1Vl4lLdhg5BbZsVp8QMfS9ug
	n9lLvTM1bxUS4/BqBmtuL0IdlOxoN/ezj6IJR0IyOnWDXa+9NWAofe1OWw==
X-Gm-Gg: ASbGncvil7PktvS+6kGx3ecS47t2QJZvpoR5hnPWSOfVbwPngtQdGbajtiux2U6YwJ9
	AjIv+sLZwxGbrhQZ+750TKmYybKhajjQOXuCkl52bUY9WwDSm40UYYR6FI74eHOBj7RE9N8EMxT
	wNpILPrBkl9+8S4VY2fbCrdXoEheQzR3/guV+hzl2UcuxDXqMcBrRy3ZI+hLMjAF0zupkugLWGP
	0dxaFX30F6gFhcQwRzandb0weQvdDQvQsikTSsItaddty4zqCx1XXrqgk9SZGneTz3pqrVUZmCv
	bs7aBSB/WjgZRaWZGctHmbbTEQR/Fct7mchnQleVVEbyHQ==
X-Google-Smtp-Source: AGHT+IFq6W0dntKrBhrhdeVSV1YNGo0PPyXlBcZ/qOVnn76EfUlD8yFAJXGyIk5xuoLKZ9qkcSpRTA==
X-Received: by 2002:a05:600c:8719:b0:43c:f85d:1245 with SMTP id 5b1f17b1804b1-43ecf8e7321mr47426365e9.17.1743791987795;
        Fri, 04 Apr 2025 11:39:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec17b18easm55593675e9.38.2025.04.04.11.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 11:39:47 -0700 (PDT)
Message-Id: <pull.1940.git.git.1743791986754.gitgitgadget@gmail.com>
From: "Christian Fredrik Johnsen via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Apr 2025 18:39:46 +0000
Subject: [PATCH] refs: fix duplicated word in comment
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Christian Fredrik Johnsen <christian@johnsen.no>,
    Christian Fredrik Johnsen <christian@johnsen.no>

From: Christian Fredrik Johnsen <christian@johnsen.no>

Fix a typo in a comment in refs.c: "checking checking" → "checking".
Signed-off-by: Christian Fredrik Johnsen <christian@johnsen.no>
---
    refs: fix duplicated word in comment

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1940%2FChristianFredrikJohnsen%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1940/ChristianFredrikJohnsen/master-v1
Pull-Request: https://github.com/git/git/pull/1940

 refs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f0fe77bd7cf..5c0fd545965 100644
--- a/refs.c
+++ b/refs.c
@@ -2549,7 +2549,7 @@ int refs_verify_refnames_available(struct ref_store *refs,
 
 			/*
 			 * If we've already seen the directory we don't need to
-			 * process it again. Skip it to avoid checking checking
+			 * process it again. Skip it to avoid checking
 			 * common prefixes like "refs/heads/" repeatedly.
 			 */
 			if (!strset_add(&dirnames, dirname.buf))

base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
-- 
gitgitgadget
