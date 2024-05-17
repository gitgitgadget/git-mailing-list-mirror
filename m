Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A801E891
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715987762; cv=none; b=JyuiO4FmnXGxFz0zsiiS8vTwqchzZybxvVna5XRqgZKzB16epHeskuFvyd1CPc2vZdKGeo6MgT5ewnKeRHJl+T3fPSxx6VRWjib1tG8bibC8NOTB1VIkVygvTxyJDsfjzuTNnKRBzJWeZZXCVHCcT6xJDibnLTb2OkklKrw3iAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715987762; c=relaxed/simple;
	bh=QNN4deBq7ohU5/zLCumMlA1i4k5BkAtU1ZAzq33qmt8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tVbhJeVGPLZQZ9EyQzB1pL7pJQSSnj4cMYgV7ZupGYbw9is6c3KT+MV0+dWbmVuN4tqGfMT0rysu4Cqoyf73mopVEkvvxyFjCUiIqh7tY17qEeIjrojmq4J3twD5m8xWvrH/nm5BXV1rgNBHhz0BPQ10aaevnIfAKJDYj+aOyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRD8pijj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRD8pijj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-420298ff5b1so8421345e9.1
        for <git@vger.kernel.org>; Fri, 17 May 2024 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715987758; x=1716592558; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nbkqGCUIcI0rOG1oeMqdqND6duYv/tdEvYWZ5TX+KJI=;
        b=JRD8pijjXSWPimmKsXUCqdnTv46fEmVFgCADh/uSsIScM9FObAUF4mxkTf00Unp8ft
         BVlJWojSaPmUPdXjhAW5+0LHPnMPQgWxF7fmRHwc1LhqCT8KFLP2VYRoKS/N8kNwwZT1
         8KEV2GSGzHRhwnTVzXewfl7ktE90wmz1y+TwDASNUk5XU6p0qt2eMmgmZB7Q8W1NWnvO
         pij+sk9jrhs20ukT0VPIZs106CrOR/i/a4B5J4+uy+2qq5o6TpNU3GlhX78FXeND4rnJ
         6o1xtYCdtTKYHhetyCjIHKn1q/e+gxjAY24m54P8XDj6sZAvtVN442v4GFsbGjeAfsn9
         o1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715987758; x=1716592558;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbkqGCUIcI0rOG1oeMqdqND6duYv/tdEvYWZ5TX+KJI=;
        b=VdqrNlDYQ3k1u2dHAy6XikoVVbLFzdjDjfYIxFvQ6W6U0xvI+u/JWsHRlEE5aJVr/w
         OntThWYRw7xUXrhv1wki9MeQP9UdXR4ssSu/4j9+xiSW0f4lV91ZUBkfIpe7c/16QRgz
         IiW61dCjAnLGJ1Fpy/WMfSAf8FsknorfvMiIA3+sJqYy3VhVEMVZ4eQ2vyQV5iyZ0P16
         EqzsWCqq9+1Z2Oh7vLvZwWPbfBYZpXYkg4WOZs3bRiLSqv8h/XbMtPvw/2+5NfxdV3qq
         p0GEXv9nfVU9q3bvGCimdxmLBHNVsabt+Q144fP1/uotzZ1hNzC4RqsJAO3XTOKlnfg/
         9FHg==
X-Gm-Message-State: AOJu0Yybi7S0WynaMVDVrNnL4hslXZOp10sbt6pIXE5JHTxqfaM2tYfa
	MopHYkabsPFnKSdF5e9KYjFGOmKvcG8vY2yI4LfC6FG3SbquNX/MhfmA6A==
X-Google-Smtp-Source: AGHT+IHe97MuHllp0may0Rtugy6gmVUbx6imFsQDrLuiNWsCMnDThgSgrbvdeXKCBOx7fueYz5davw==
X-Received: by 2002:a05:600c:3b86:b0:41c:2313:da8d with SMTP id 5b1f17b1804b1-41fea539615mr235155135e9.0.1715987758127;
        Fri, 17 May 2024 16:15:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fe36f373fsm298802595e9.20.2024.05.17.16.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 16:15:57 -0700 (PDT)
Message-Id: <pull.1732.git.1715987756.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 May 2024 23:15:48 +0000
Subject: [PATCH 0/8] Various fixes for v2.45.1 and friends
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

There have been a couple of issues that were reported about v2.45.1, and in
addition I have noticed some myself:

 * a memory leak in the clone protection logic
 * a missed adjustment in the Makefile that leads to an incorrect templates
   path in v2.39.4, v2.40.2 and v2.41.1 (but not in v2.42.2, ..., v2.45.1)
 * an overzealous core.hooksPath check
 * that Git LFS clone problem where it exits with an error (even if the
   clone often succeeded...)

This patch series is based on maint-2.39 to allow for (relatively) easy
follow-up versions v2.39.5, ..., v2.45.2.

Johannes Schindelin (8):
  hook: plug a new memory leak
  init: use the correct path of the templates directory again
  Revert "core.hooksPath: add some protection while cloning"
  tests: verify that `clone -c core.hooksPath=/dev/null` works again
  hook(clone protections): add escape hatch
  hooks(clone protections): special-case current Git LFS hooks
  hooks(clone protections): simplify templates hooks validation
  Revert "Add a helper function to compare file contents"

 Documentation/config/safe.txt |   6 ++
 Makefile                      |   2 +-
 builtin/init-db.c             |   7 +++
 cache.h                       |  14 -----
 config.c                      |  13 +----
 copy.c                        |  58 --------------------
 hook.c                        | 100 +++++++++++++++++++++++++++-------
 hook.h                        |  10 ++++
 setup.c                       |   1 +
 t/helper/test-path-utils.c    |  10 ----
 t/t0060-path-utils.sh         |  41 --------------
 t/t1350-config-hooks-path.sh  |   4 ++
 t/t1800-hook.sh               |  40 ++++++++++----
 t/t5601-clone.sh              |  19 +++++++
 14 files changed, 158 insertions(+), 167 deletions(-)


base-commit: 47b6d90e91835082010da926f6a844d4441c57a6
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1732%2Fdscho%2Fvarious-fixes-for-v2.45.1-and-friends-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1732/dscho/various-fixes-for-v2.45.1-and-friends-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1732
-- 
gitgitgadget
