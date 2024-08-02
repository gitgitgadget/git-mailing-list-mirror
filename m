Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533A38814
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 04:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722571858; cv=none; b=bzy7dkkNSuZycYC3ZgWVth/FP82oHiLcj5joF0Kl+93qiUfCJ2zYqd887qpMgTsqeWZUph8Ys1RcYGGaYiQyP498n4NYM+CF4DG6o8C9YQ2TaI2BzdcKvQ/NDGjIjCmFMT2BVYnyAZI0ya8xjs7p6d2XBE3xLRkczfAII50vWN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722571858; c=relaxed/simple;
	bh=kUlbqEnNJpJeSFITTiS5ZQNgJxMIzMGAEvy64ZnlDvI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Kew5t8X4+cf45L2U5yMU8BALcw+f8GXJE9SxbNG4FP4Rj6VI+ItebQTyVlwvyTtkl//DOwWVWR2+RdqFjh6Im6QgoWxpTKGR8s1cfrl0kuwXTIgPXcUx6vyjUqCT6H/PnVJLWxe7dwVysYDk7DJGJymrk2J2C5BSoG7UXB0oL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1kd6E/1; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1kd6E/1"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso88195291fa.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 21:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722571855; x=1723176655; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2OxjDnKw8+0e0/ZY4zIW6het1N4UV24uaHoYhwbn69I=;
        b=W1kd6E/1VW9O5V1Hl6EVP9Na1Y4F89XAWmyOoL8QIyMf+8W9wC3c1EGLx3mqLfwWrb
         40YzHmajorlEY+iYChuxeWbWKCY9W3YcDIDxwVTM84P0LJfyOwGNBaBVJT1ou1W7ACzS
         beVtKWSfNNl3Bdw+9eiCDZOsKGV7hgS4Xn9l4liLhdltezgC3S643Ka7WIqwb5r+uIlu
         o+VWt4Qb3jHowTAlWoEWK6Vz7V6zR1wMXDqy+xyXYmobeD5I7miBEXY+ZlP03BTjN6qh
         +WkBIe43/5D/qkXJ2E+5wVf9UDS7TFJaqH8gXKhwc8W47kzED4HNTg5qmI6c1eFKaz/p
         /pZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722571855; x=1723176655;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2OxjDnKw8+0e0/ZY4zIW6het1N4UV24uaHoYhwbn69I=;
        b=H2mBFNdZ2Z95zdSjo7tx9QYwtQDkiWM+Sx5cQv5s/TTySH8U4AXY10ZseEuxo5OlV3
         z8lXzN+pZH7O7I4XNmLZXACbCmt8gQsB/XMwAO4H9Wk9UQpcHg7VGa64OTUHGphHEYEl
         +mkou/tphY8OWAlLTnAU9R0U3F2fr9Bl5cnPkBw2c1QoO7n6fgMn+3yk6vBagGFhkn9X
         vJfP+/NrgAlvwP6dySRWGzwGAYY/bem19j/m0e8qknSTcmT5SaM0Ktc1OPBE5DPAXYp1
         m2Tp9w/nQSOuPe2CKLBkHyRZ3kbGpvLiI919gx7GFK24At+s4NOdTUJfWI9Q0QWBvtSq
         a4Vg==
X-Gm-Message-State: AOJu0Yzp7PCKvK5U/I3G6/B2HBtGBAJy/A9xcL2dz+Goc1qSQiZZV9xl
	HrsyD4HkNUnWxS50L1DvbNIICrC3B4fgXIeh9oY5bg+ipaheTvfY6acwgw==
X-Google-Smtp-Source: AGHT+IHWSWS4Ia5DOYG/DD9zPaDkaVp49nSIAQ7rstL2usuN5U5nK4aWt7EXhPGv145jdnHh6asWhg==
X-Received: by 2002:a2e:8703:0:b0:2ec:1810:e50a with SMTP id 38308e7fff4ca-2f15aafdc9fmr14847221fa.32.1722571854799;
        Thu, 01 Aug 2024 21:10:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a946sm79155395e9.6.2024.08.01.21.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 21:10:54 -0700 (PDT)
Message-Id: <pull.1756.git.git.1722571853.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Aug 2024 04:10:50 +0000
Subject: [PATCH 0/3] Small fixes for issues detected during internal CI runs
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
Cc: Kyle Lippincott <spectral@google.com>

I'm attempting to get the git test suite running automatically during our
weekly import. I have this mostly working, including with Address Sanitizer
and Memory Sanitizer, but ran into a few issues:

 * several tests were failing due to strbuf_getcwd not clearing errno on
   success after it internally looped due to the path being >128 bytes. This
   is resolved in depth; though either one of the commits alone would
   resolve our issues:
   * modify locations that call strtoX and check for ERANGE to set errno =
     0; prior to calling the conversion function. This is the typical way
     that these functions are invoked, and may indicate that we want
     compatibility helpers in git-compat-util.h to ensure that this happens
     correctly (and add these functions to the banned list).
   * have strbuf_getcwd set errno = 0; prior to a successful exit. This
     isn't very common for most functions in the codebase, but some other
     examples of this were found.
 * t6421-merge-partial-clone.sh had >10% flakiness. This is due to our build
   system using paths that contain a 64-hex-char hash, which had a 12.5%
   chance of containing the substring d0.

Kyle Lippincott (3):
  set errno=0 before strtoX calls
  strbuf: set errno to 0 after strbuf_getcwd
  t6421: fix test to work when repo dir contains d0

 builtin/get-tar-commit-id.c    | 1 +
 ref-filter.c                   | 1 +
 strbuf.c                       | 1 +
 t/helper/test-json-writer.c    | 2 ++
 t/helper/test-trace2.c         | 1 +
 t/t6421-merge-partial-clone.sh | 6 +++---
 6 files changed, 9 insertions(+), 3 deletions(-)


base-commit: e559c4bf1a306cf5814418d318cc0fea070da3c7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1756%2Fspectral54%2Fstrbuf_getcwd-clear-errno-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1756/spectral54/strbuf_getcwd-clear-errno-v1
Pull-Request: https://github.com/git/git/pull/1756
-- 
gitgitgadget
