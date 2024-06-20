Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAF1B14EA
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899883; cv=none; b=CQH8VzH4slqfx3bGcfXW3A+yQEq9IW0foBEE3qE3nLvoLHFIP6ELm4EcALgw5w67RytdxT0RERLO7yGzk62JD223qv91YLnEgG9QbJxIt7Ee4/HJRPPHm5X3K54EZuoNvaBzN9Vs/J4g19QfVe+NeVIGvzaNrpTV4aoMojsXtFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899883; c=relaxed/simple;
	bh=RWVHq+LWB04qtl4DrQEs/AhppPYHSTMRezycPno5jTM=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=OMQTO99PUVy8jriJ9ZGZjZZgtgp7IfECHRGEptYATeqP49eCpK+pfQr8vjTiqPocD4fPZ/K1p10gLJZq5lZdVxVRqrS6+sn3bXE+qYUDMqKHICHEZE0HM6uN0Yvn7fas6Xc1PhNFsQSlMcvLpTa6rrPPcyvdi4QgpFFo6WPn65E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ptz0fhXt; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ptz0fhXt"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso13867955e9.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899879; x=1719504679; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U+YAI442eCIGr639NAhGWVP+HzCFWWfw6SdhFjZtKLY=;
        b=Ptz0fhXt29Wv0gchyRTN7RzWYf5Hi5mruAc/pVzepJUbIlFwk9M0k5nou5INoUxLpO
         +dwiz0y7zXCCkrUBo4vZwihPaYsB4BW5pubCqXKZL6SLKTE0bGv1Iud/Y7f6UX57D1Xy
         CdncFInpnIrQ7sTGL0/SkPSoxkr/iiLcGHpUEvLvbWCvkn9q7MGj5Skq9CSAIIg4JZlq
         WY0R0+h/nV8i2zfW61M9awu4Meu9FfkAwFd6C71x7L2zpBYwP4KlQhTxsrgu6QtRVL65
         WVe/vhIt9qTiYzl9RgzoQ8W5F9h2DAxAF4niF5LFxAeT3q8vN6Vnlog6OZz1ZewNDbNn
         AsWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899879; x=1719504679;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+YAI442eCIGr639NAhGWVP+HzCFWWfw6SdhFjZtKLY=;
        b=tZb779N0ub2q0QTBr3mMWNFAvPwLmv8JisBRjDpuK4YJS801JGxVj0V3m2gkaOa0nz
         eKm9DikyE8Tfq3sJwPflC6evUUumbPFWa1xtaV4PZjRkHtAqDmaaXy4Y9O9iIKEy3eN2
         sQE0r6oICoXDDzhFFZSu6j17g4M9hC8KLbsDNtN9/GaT0bGqSaF7rtQqqF5yNdrEPHk4
         b9eW0BucpDSsDliJ6s+MAEAq8In3N7FXt4Qmb6uHMh9vrYgL01yGdJcUw0RtDMaoX5N+
         01HcyJvbJDNjXW4Aow3HOHTba6s+21mYPK1ZOwNkh+S9X0yt3dzK5JKT/kugaSKPbXCj
         LSLQ==
X-Gm-Message-State: AOJu0Yxrn8QI9qFsCUdU0dNEpBHfN+cKpwMhs59reuJbLVkmp9Kjibi/
	a7+bd8/uGQj6utODg4XhFFd/Rto1SBp0XiMYpUxTcRUCRIJW+IVLpV5eyA==
X-Google-Smtp-Source: AGHT+IGDz13tQ12wVQumZ4wANm7paHGMhs8i7wF4gMFpllNS0uCQkH5d3ZwBdNlnVq94Pjz+IYvIXg==
X-Received: by 2002:adf:f78b:0:b0:360:d15f:e650 with SMTP id ffacd0b85a97d-362fc3a501dmr5367856f8f.0.1718899878935;
        Thu, 20 Jun 2024 09:11:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3654a0b7cf4sm1353639f8f.31.2024.06.20.09.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:18 -0700 (PDT)
Message-Id: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:12 +0000
Subject: [PATCH 0/5] sparse-index: improve clear_skip_worktree_from_present_files()
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>

While doing some investigation in a private monorepo with sparse-checkout
and a sparse index, I accidentally left a modified file outside of my
sparse-checkout cone. This caused my Git commands to slow to a crawl, so I
reran with GIT_TRACE2_PERF=1.

While I was able to identify clear_skip_worktree_from_present_files() as the
culprit, it took longer than desired to figure out what was going on. This
series intends to both fix the performance issue (as much as possible) and
do some refactoring to make it easier to understand what is happening.

In the end, I was able to reduce the number of lstat() calls in my case from
over 170,000 to about 6,500, improving the time from 2.5s to 71ms on a warm
disk cache.   Thanks, Stolee

Derrick Stolee (5):
  sparse-index: refactor skip worktree retry logic
  sparse-index: refactor path_found()
  sparse-index: use strbuf in path_found()
  sparse-index: count lstat() calls
  sparse-index: improve lstat caching of sparse paths

 sparse-index.c | 220 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 167 insertions(+), 53 deletions(-)


base-commit: 66ac6e4bcd111be3fa9c2a6b3fafea718d00678d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1754%2Fderrickstolee%2Fclear-skip-speed-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1754/derrickstolee/clear-skip-speed-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1754
-- 
gitgitgadget
