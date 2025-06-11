Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9BE1DFE20
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749657285; cv=none; b=egRqnFYGtS64+O901aMrtj9E3ObzgEikeo2gm9G79n8qjiYHy0KdDZsdwzwMKW6Hccong8fhFdv1CnsAFyCD2jMFSLXnmhTSpj4pFVKU/EDP1rJ1p9DVyn/2crbLpRxqB2fZHqFgGB1UwjGySoox/5qy2xQfm+I2aP6nHJ19mNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749657285; c=relaxed/simple;
	bh=/sqUlvC6JIRSoBPWk9Y87fQubiM0vD5bpdOZ4KUXYC8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hn2UZ8eDMZ+WDJJmhyRnG4g7E8TMxt6UFv6I6KE/2ThKcJnnBWnwenv6rHvwlh86xBQG67t3AtxmqmHL9o4UuQZQETAEV1VwGQgprP+pwD8JXKsQ3zRB2i9X+sr2FZfQMDqvGN2eueQ2e/KjxXv8QHy6e2pic6sXkOwPXaj8rHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmSZhH8W; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmSZhH8W"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so58302605e9.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749657282; x=1750262082; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soxS2ceqQLDAf6FNVxtRWQd3UYsZpGtCncIYoIVPCVg=;
        b=nmSZhH8W95lOq4+H+q1yZmld8/dHui1ZdrjEiEvdiq2iWBvvk3GYnuY65Z5vtgc49/
         +DkiwOxfGFrP0qwT2c5f2RKnJkzK8evKY/Z7tqD7ZFzoPrtWKbkKby3chKpq2KrRZ/8Y
         LrHAD5Q7KnIdHJ3QFuXmb8tADodewaQsWenAJPteLMtiWY5xVxC5GJ1Nq7jfK+6XoHK9
         HxXSUwx6ORuhwKr/vSfNEchNTnJ/nRlXRSIs90JaTJymqcO/p6M5cr2/mjcm2U7fBs1f
         png13ardC4I3QQoTQ24/aQpyz+KwfjrXunroAE9ghuX42q+w1wwHd0KFyitLCA1DhXRU
         wxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749657282; x=1750262082;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soxS2ceqQLDAf6FNVxtRWQd3UYsZpGtCncIYoIVPCVg=;
        b=Lw9VHSaWFV22kgnZHjnWZ+gvbft6xW16+HVVfWIm/w0SpLKAJDx08Bzlo1Bx7cHKLe
         G0AgZZsjuIDOS+5swUQ9HHUH0Zs1PCZUJyAMCHw38R+CXZFcNdpiys/beeoquI32Ma02
         mTNw2yRZS96khiyVjT1Me0oesGvJv5gsLwU3eB7EOYLIVvvMLxcwvJpMXwOTLnbxJQaO
         ZlBV4b5LbjgYwWe7heM6FCdpp5YxRgZu7xJSqEJzyfgxQHQHubTWXia+UwdzU2MZOrme
         4yClmNROP5AZEQqFWVH22BLsN5YVbhg7maZrDgkXIFBP9hAHO2O5eoiPm2QFtrIdLTXJ
         XsoA==
X-Gm-Message-State: AOJu0YyyyrPZ75vHIJ54BqhaOCdM2H5wT4m5T/8sBNj+HUvUAjWFjWpI
	QwROXzqX8tRQ8/LT184/8djFegolTebCmcMVExgpnr0g0y30f+B+CsAKFJrE5g==
X-Gm-Gg: ASbGncvNKJ+uQd0leaTKH6rtvJyFVqHsui4UDqee7qmVJieS7J0z30VypcbPzDek7nV
	YZ39Hja9QIkLxOJQ82QkyVCDZjyRF6X+VkTCMwrtY/+72uKpqES8CxZGht+LA9fMBuVeqwCzE+a
	ZqQhpCYU+pwirU2VCeQWZTRaTkxJPotW92YmMkbIjdbB5K/4zvC1DyqVuENETarU/cd0h98n29c
	vN1LWVKKztUIPhLoPDYn272Tr1DOdkODlONuVnR2m5yEtE4rTdSV4xmMS8yo6DEhXtvOK/mYTn6
	XHQFkElXiErefpmYOClW0eE9Kctabxqa33UQDWPTAQJxzXLx8MDIq90jn6xQPm0=
X-Google-Smtp-Source: AGHT+IE+/klES0YbRiNf8oiutAZCR1LQ7wpBN3Z5jC+CofokurYYKOZRz9sKIbNNEmDznGtOWAZATg==
X-Received: by 2002:a05:600c:1ca8:b0:442:ccfa:18c with SMTP id 5b1f17b1804b1-4532b941335mr2690235e9.32.1749657281437;
        Wed, 11 Jun 2025 08:54:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45325228c2esm25417935e9.37.2025.06.11.08.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 08:54:40 -0700 (PDT)
Message-Id: <52c34977b48a26f3f6a1a62fb81015f319be6205.1749657278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1934.v2.git.1749657278.gitgitgadget@gmail.com>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
	<pull.1934.v2.git.1749657278.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 15:54:38 +0000
Subject: [PATCH v2 2/2] ci(coverity): output the build log upon error
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

It is quite helpful to know what Coverity said, exactly, in case it
fails to analyze the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index d8a0497d596d..01a0437b2f26 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -149,7 +149,11 @@ jobs:
         run: |
           export PATH="$PATH:$RUNNER_TEMP/cov-analysis/bin" &&
           cov-configure --gcc &&
-          cov-build --dir cov-int make
+          if ! cov-build --dir cov-int make
+          then
+            cat cov-int/build-log.txt
+            exit 1
+          fi
       - name: package the build
         run: tar -czvf cov-int.tgz cov-int
       - name: submit the build to Coverity Scan
-- 
gitgitgadget
