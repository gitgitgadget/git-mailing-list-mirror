Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A1C139D12
	for <git@vger.kernel.org>; Thu, 19 Sep 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726770904; cv=none; b=ZutD0yEAJOsx5F7QdR/9wxUDP20wJJfCpLMxEnCN4jCZG4QlgoZ/KZMpm0ZA553bOwQ9YSQj+d/pK9jfB2dEq2/PHNTY8rf7TgwvVpcG7C0NclcmjwFqjxJHS7EzC2JO7qDouwEjfMBJrWWXkHnrItQrgduuI3a2I+ocWkEkOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726770904; c=relaxed/simple;
	bh=WX7xOHzrEW1yCJmVohcQg0fTQn+jrYOy9LBJNmMoYSI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qkjZK7fIQzr0qg1qF4v5xfqirtrpgerS8xU7gb50zTkQj3gykoZy2C41IO9NA3vzyWv74LiH7QUdme3qwOTtr6Wv61Hsal7NeGbikOYelkRylcJgRdzNDtyM3ozWRZZsX9XlDebruHDLeSdrydKStAGAKdX67KB+dVq79NHzSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvzU29xO; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvzU29xO"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8d6ac24a3bso205995066b.1
        for <git@vger.kernel.org>; Thu, 19 Sep 2024 11:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726770901; x=1727375701; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZuW+pEE/2jsidLem5aksw9oPw5QtcTT2+KjXuwL0cXo=;
        b=OvzU29xOzWp0wYcSrsenLICWvRZ+TofHU1wZVKJQWciig5Dlm8PvA5l8J6RKN/+enT
         J2X7icAnU1yCF5P7ea5uIah++/fofaLwmHxOMkosjYOYekqjhbaT/G1yoD85z8vI4Vbj
         41mQGV3g0TnicFzsOH+mC8Xu6rqYgNSKYnafchYIITpIvSUF0CbOqKXxjjRQji7BTSms
         ax3u4iyaw8549Rf2jlHYFdAPxYsDwqNPwn0lo2YSyACx84fNV7E935lVeWsWRH/3+zxK
         ztNeQiB+A+JnRhKLp+j35ZN511QG2BMVWzn32AephYl80AAcrzq//GXvzWm/1jebycQO
         q1OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726770901; x=1727375701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZuW+pEE/2jsidLem5aksw9oPw5QtcTT2+KjXuwL0cXo=;
        b=eSHlSCPkbjRdLusG5rbGIv4VP+rGbk73NRpKYD70edBS2lwoqFk3gAAaKEcfQh1j1m
         yPtDkv/PFP76mTy9LUiUQwi6ApYBHGUR45IeQYqtMZlgA4gPjdcJ4MAPQXci1LF+BzEy
         YSsSv4m32DRgXfJbWYIbuLZIv+ViWlAB5G4vICbBLFBjyzvv32RCgaOwBLvm9JN3DM+1
         2CZ9eyy46QMinJQMTU0Jle2hRHb3psR5zNMLoV/6au9WceaUw6IGy2sCwBjtYl2egN3L
         mbkG3H+8VKIxRFdLEweRF2b2gKbL1AmVEQUz1q4A0YwKCnpwVdFuQMo5qEKIFLPhzZ+0
         99sA==
X-Gm-Message-State: AOJu0YwV4QpV16XM6L77jzJEcrUON7u1d53e1Blh+UXfaU7pQMduXxJ3
	I5ksWC2IHURyor4+OLNH0dOu2Bo0MYOXnFTTycAF9i1KzXqmfqu+YXC3Fg==
X-Google-Smtp-Source: AGHT+IGTtg39RX2pKr87tN5+uZ6j9p8cs0mPvuKKSssm6xabe8IyPr9tiZvLEJYXXjO7BU98RBg+Aw==
X-Received: by 2002:a17:906:478c:b0:a8d:4cec:fcec with SMTP id a640c23a62f3a-a90c1d6ee1fmr460921766b.26.1726770900618;
        Thu, 19 Sep 2024 11:35:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061096979sm760350566b.18.2024.09.19.11.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 11:34:59 -0700 (PDT)
Message-Id: <d219753e4f8338ad2f960f7d3b2c6481645da871.1726770881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
References: <pull.1794.git.1726770880.gitgitgadget@gmail.com>
From: "Andrew Kreimer via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 19 Sep 2024 18:34:38 +0000
Subject: [PATCH 18/20] setup: fix a typo
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
Cc: Andrew Kreimer <algonell@gmail.com>,
    Andrew Kreimer <algonell@gmail.com>

From: Andrew Kreimer <algonell@gmail.com>

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 29f86739212..b7084f03126 100644
--- a/setup.c
+++ b/setup.c
@@ -518,7 +518,7 @@ static void setup_original_cwd(void)
 	 * directory we inherited from our parent process, which is a
 	 * directory we want to avoid removing.
 	 *
-	 * For convience, we would like to have the path relative to the
+	 * For convenience, we would like to have the path relative to the
 	 * worktree instead of an absolute path.
 	 *
 	 * Yes, startup_info->original_cwd is usually the same as 'prefix',
-- 
gitgitgadget

