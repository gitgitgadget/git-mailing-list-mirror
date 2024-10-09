Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7420B192D96
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 11:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728474600; cv=none; b=mP+qu8SR/O8k7s/9DyVg8VvMJ+Et/vZwoPD5ivJwzNgNmcWjmhaXasZZ+cNyD4WG9ResBnIbZa8umEhw3Xk9nW+lJdwKEtPd+h6BtvXRwIaEnT7Y0SaCjKKNju8CMcW+QOb+POUwQWNvT4XQhvleLxsVypYsnulR9Xy4Zsm1hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728474600; c=relaxed/simple;
	bh=KIR4qDDrQpI3H2VvXjhEud22ujTdss37Fwuw6I0ZohA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CSjevWDY4gIbeJDV2jlhDGQ/PlbpXRo9xTSKsgWVVrXCpUZXO7yMkM8LLZXg44ZQv25Bi4qq3H2X9FLHs8NvSuqiGvmY8AQBz6PTS92879K/Gn01lfUdi7WiPtPhotFW3MHP4dK1KW4nTZ/xdAOJTTKbIVJ5AbblcUDPmkNJpj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K78OU97P; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K78OU97P"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5399651d21aso6158164e87.3
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 04:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728474596; x=1729079396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9xRKaVokKtEilg4n1XnHIe7lOSqjMg63kY3CBIM138=;
        b=K78OU97P6PRUoFpUBdS3DXTpOSL1ZkzEgGz2V2onbbjjCDw0OHsOo6oRFeQ5hE0mrx
         6aGOnbuHuWxQV77+1w++LtbCrlpMmN2t0p/wX6bzgqDIcmhuH/He29ZQwild9pekc+Nk
         4/zRHDktyEYqOfEhxsNvzB8Oqn2XYAWrMmBtFXGWq0q8boy8ZMbLPPql05xj9LBv3wfG
         QOjyxBdLDyI5FJQ8D2d5ePE+77XxmYSi8Ei60oGIhuKt+XUX72d1nHdWbHh/keaKGBZO
         I8OXmCvJTfs+uXmEvu5PwZCTGrmpe44KJ05+O7aElhGcTbupH3KYwhBUuu5TAHZwF1b5
         nRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728474596; x=1729079396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b9xRKaVokKtEilg4n1XnHIe7lOSqjMg63kY3CBIM138=;
        b=VbaJlcA4Zj6+y3Xhuw/OIVrUHOpUqcsuTSk4rSwlSS7N6bV8+yKCKFXEbEVLi8ownD
         BaXefZXn5LAvvcfsROoK+C/bBCDntCXIsvpTayLlm/Fobj4Nq9p8Qtjj6THb9zpQOxEo
         bBLmZA6L8ecpz5QeBB7+bV46e2P1lXp+Pq0UW/vgkdmiXAzHpJ9PhBAy1KK0NdZ+2m75
         243QWUSwwreFw3cBKZGY8f1UIYU8r6I7240lELOZS8eZzOLNVeewwd4HzH2cgQszsK2R
         OeToqve0JomltO5nY5cDea8AIW86O+JwdDMBT1ea4MMAadChAMyuKbLaJwxWWCurFXqH
         CVZQ==
X-Gm-Message-State: AOJu0Ywvqk+1887GhKJLVBcSje3aWZqwIlCkSjJbpe/wr3ZqhJnGvRCC
	C1/54FIUHiWANJM8uNQ1+pPRqIqHSKdPdQPibCKrw4Psf8Zcoe+2w/lOhd57
X-Google-Smtp-Source: AGHT+IGedGNv0hnW2y1uy2/UTQD7fPh6aiqj1sPoh2RWYOcf67PDw4fdWHf2o5hp/wDqJ65vx5F3WQ==
X-Received: by 2002:a05:6512:3f0b:b0:536:9f72:c427 with SMTP id 2adb3069b0e04-539c48d6acamr1126002e87.28.1728474595974;
        Wed, 09 Oct 2024 04:49:55 -0700 (PDT)
Received: from void.void ([141.226.169.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a993a4ff9f7sm595800566b.26.2024.10.09.04.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 04:49:54 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 7/7] t/helper: fix a typo
Date: Wed,  9 Oct 2024 14:49:40 +0300
Message-Id: <20241009114940.520486-8-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241009114940.520486-1-algonell@gmail.com>
References: <20241009114940.520486-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments: bellow -> below.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 t/helper/test-rot13-filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/helper/test-rot13-filter.c b/t/helper/test-rot13-filter.c
index 7e1d9e0ee4..ff407b575c 100644
--- a/t/helper/test-rot13-filter.c
+++ b/t/helper/test-rot13-filter.c
@@ -9,7 +9,7 @@
  * ("clean", "smudge", etc).
  *
  * When --always-delay is given all pathnames with the "can-delay" flag
- * that don't appear on the list bellow are delayed with a count of 1
+ * that don't appear on the list below are delayed with a count of 1
  * (see more below).
  *
  * This implementation supports special test cases:
-- 
2.39.5

