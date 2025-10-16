Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F92350D7C
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629700; cv=none; b=PtR18S1l5wZlvaqMT5ZZk6weJNDdaAL91iNilectJ44L9lJolfdqRgBZCgke2tOgTifMGC/r9TwvneIIg+jJtqXWa0lkMPFt3TuaJ9sfnaZkwaX/SttQcpBTvHgEG/etIDkf0vKS2EF28rBxXNl4t5LAj+6xUrpN/ELD6SB0vjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629700; c=relaxed/simple;
	bh=1S/IUZKG3K8vl9P1wxP62+3EoUPeOIa7VayY45oHZuQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jSTcvAN1mtRlaSukH4ZgSDFEcjtd+bIHQvile7iwzvbFn/K3dRtoliJM7t9NjOvBruG1wRLIdiswpgexkuIJ/ZAEWyVPGqA0HyNLbblI8EkJW09mmNfvMm2E6NLx5Vev6mdzhGQNa99lbZgzfyZSS3A0DF6VxI1Rgj6/qkX/ue8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCM4ERSI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCM4ERSI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8599c274188so132547085a.1
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629697; x=1761234497; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTqHFmZ1iLIH8MjEbF8iim6WJrAYuLtI4x5+GEyiDs0=;
        b=NCM4ERSIeWU8jUi+OjLRUcbXHY6lrNY+Fm+qeOXQhRwtAW2skiehHKFZ8QXbBQKoWa
         VQ1mnIhJwzvSSrJCdAaI5fMXYjN+Hm9hjDCvVsL6jKCXVM6D6KI29oUWdWMpQFihN3wC
         H5LRS48I6EOu59Uvk/ekYXUDki33ezJ7FcxRG+to+0YwmPnOy4OqNU/WHFzdIKjiAaMU
         qsEQA6azUfzdfKQZMAWjlxJ1ZP8D2VcaQrA5EBFiBAipnEze5fmqodpucNZiR8WTejDc
         un2nGrvMvrQTkV2Mixz8FMdKJjHILuLrqjkTKwSrK2ZCtk+wl942Wsmsu3Qp2LK7OHxM
         5RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629697; x=1761234497;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTqHFmZ1iLIH8MjEbF8iim6WJrAYuLtI4x5+GEyiDs0=;
        b=YXu06miqPgjb+zycACD3G1+ZJK61YElRbAXzcxIXxdnDG/lXPzZEuxBqO1M8BK8FYD
         9dFlbwJCmA7SwOgKJOxzj8461y4dNY9p5d6PeCXmLsm3QAJho02eKBdM3xSEUPRU0s9r
         xQFv9LyhTI5JvyBtfxvz4vMN+acwFhhBpKgPohQKqZw1VB5TRYvXboZoTjX4Hd39suH+
         GjGdJKkR+mtHruKNsFnQSvOg9OOj3BvRhoS1wPoKll2fUaq9ju0kI2sYBWaRMBidCwmc
         JAJMcJeRE4aMXu4wCBy6cCsjnFTcvvGGQe3rvgLEQP+wANN65wof4kUHoPUvDtKwzz1y
         H0pA==
X-Gm-Message-State: AOJu0YwnrDtlqlltrYj5qfngUl/jX803O8xpO8xjI/YX2gEjU3sIN4j/
	4Vnlyk0ZjDwvGWoC+FmquKhuJuTtwyVZ+jX5Jw+UTf4VMsEtV1SbCvCaAtdluw==
X-Gm-Gg: ASbGncsXMm1uQ/8p+ALBkKJ4N8cANVR+txtUenvw/fSXAMQAzgf9uVFIYAXuBCX5Rr2
	oPpLODHJGlcPmyQNeZfGZru8yo37hp4PFFTw8J30oAAx/brx9calLxqHHD39T4ZmiASXoYjxCEs
	FZEgDeKaUA5VneoXkA8+OPOqdhm4bjyVc6HDc77cazdm0ZNNgqbHYl1Ky3Q8gtW9dolA6hc67PH
	pB/7zDCUsYeb72WjLm72FGsKPIaPapDjqifZ+6sGPed1aRLFqNcOAJpLmCx6AyMmsfqCZtQQl9L
	h5nHN6orV0WLlsqRVfChoUPp1ug32IJ5vFdFTLdVqNleyVH9cUsQScJNoiNgB4Hkk6m8n3UztCK
	k1n2fmM0F4/ERM+Hk8ihTM4hXStm3C46EeJCjoyksPyg6EWWfzov2KL+UkQ09NXznMKEeG5hcnK
	6EG+l0j4qXopHW
X-Google-Smtp-Source: AGHT+IFFyaNSHKTlLMC3vx5EIswBcu40ZTqw56qOfGAQ+oF5o5LDUpg+zDFVdi9lWdJlKsPRhhzrqQ==
X-Received: by 2002:a05:620a:372a:b0:858:b701:ef9f with SMTP id af79cd13be357-8906e4c8472mr50779485a.19.1760629696934;
        Thu, 16 Oct 2025 08:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881c76bfesm42994381cf.10.2025.10.16.08.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:48:16 -0700 (PDT)
Message-Id: <e358306c5258a6f902fb1134c1e160e0fbcc4c20.1760629692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
References: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 15:48:11 +0000
Subject: [PATCH 3/4] build(deps): bump actions/setup-python from 5 to 6
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

Bumps [actions/setup-python](https://github.com/actions/setup-python)
from 5 to 6.
- [Release notes](https://github.com/actions/setup-python/releases)
- [Commits](https://github.com/actions/setup-python/compare/v5...v6)

---
updated-dependencies:
- dependency-name: actions/setup-python
  dependency-version: '6'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 6bcd129b85..4cdb1dcb5c 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -259,7 +259,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v5
-    - uses: actions/setup-python@v5
+    - uses: actions/setup-python@v6
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
@@ -287,7 +287,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - uses: actions/checkout@v5
-    - uses: actions/setup-python@v5
+    - uses: actions/setup-python@v6
     - name: Set up dependencies
       shell: pwsh
       run: pip install meson ninja
-- 
gitgitgadget

