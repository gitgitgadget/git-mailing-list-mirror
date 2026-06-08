Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADAD3C13F2
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780927033; cv=none; b=LVdu0rXDHuzQJeBD2w+mnBjGp+gViANdSbHC/L1Drk62AjixBmHvZKX48IgWIaSnn27OsrsClGhs0yrtTSa/ToUl4hpbNRZ3YvM9MDuSPwklKVG6e54fQZr2Mf/EuG3j+7pJwdKfv+QXxa+HY5svOZXw35wweO5f43WIB/mHe9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780927033; c=relaxed/simple;
	bh=46WeZe0kmt+bOYfhiI/ot7Tl/8Rv6RRKFtDIpQ9+gJ4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=MhearRfCVVkUBjOaEoqFH+gSSweNj1MQnlwxCB77t7a+L2vsqSMU/XhQ2/KmZkWn7ETqRp+/8hK4RrPJpIh0WGrHldHhwzzszwnmTAG8nY9EGPAVixbLWZxEDBG1nN+aa7PWLgwzFV+O0T3tA7PuFOFHDJnEgw3Ki1bZZ17x148=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDMMYDj/; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDMMYDj/"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6607e80a846so4322615d50.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780927029; x=1781531829; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=elqsK4YUE7u+pUjC5IhXl4XH/pWGXU4rq924jhC8Qnw=;
        b=WDMMYDj/NbE7z5nNI9KU/x6ZjiFUe74i/HoWznF6xC/sVWzIsa0hn7ztSDBQokBCfb
         czO1+WaUXOCz2nYIvH15U3lgytARiZv8pC6ZkfIda0HN25AjOPfIwUokCfPgBn//BZ7b
         8HNm+UPjhAI7qhhETOm5xeJBpONEUBA81/yR4fVBggx5kR6FkVyFFhRVPTWghccNOYdI
         yE0KJPN33y7Nvnr0y0ws5nWWL0p1VfMwMNY4/Y1fvLlAin09UjA7qWkVcVJtW3+rTGnx
         2MCXjSQKeYkY8y9KfrhTni/gy/D41y7JTMUz6qX2bNQT8XcHCmEpfFSEg2naDDK8q+Gf
         v1oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780927029; x=1781531829;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elqsK4YUE7u+pUjC5IhXl4XH/pWGXU4rq924jhC8Qnw=;
        b=QtRMLFZMpETVnsUIXQ71+BHmqPXwfwdj/s3/AT6uRYC8kaYthjSHe43TWtaHrSQpyG
         LbspJW7i3OZYCBaI+GNcchyZlTohod6WLGd3YBf/MLSlO2D/hCwH26V+dwOWHLpPfzzn
         6kgTLt+pbeEVLorW6/GqaZa7mkWajJGpwnmTGDrwnT9+D9IoGJ7ORgZDuMji2+RfsSzk
         EnAiDaqGlHD5uUojvJN+PIDcEiVtgA8AZw8Lpp+qojdOH44HeSZtdyDl/Q33uzlNxj7w
         ddhzs+uUZGDa8oGpXBtpgnX9i4vy/raO60BDR+qKFPMq9VP7vjHxlzAox9JArBxao4zJ
         da5A==
X-Gm-Message-State: AOJu0YzT0nsgwbvsZmSlZZkEllB0K1moUFj7ZiLHqdVXhBsAztEFziAU
	68olPiOp/ue9036v1VBTM0aaGcX8h4mc6155+t85GgLB+tltuqlC56OAdOF6nw==
X-Gm-Gg: Acq92OFcpp8iKDvHp5fVKJT1E4jccn0WrIbkYfhhcSgJ8aHfQHMdRn9ODqtIL1o5ojZ
	bTg6GQNLViST2PYwHslcFCm5dHPIJgcgJmkQT9YvPctRcny4LNHEucmmUQbtyL199ulb/hHKYR5
	QPMG2xUK7EBDM7VHSSxz2fvY1oFVb751T0YaktyXPZxDpZh1IIGinbpk9g62g4FEsg3QIOgaCSZ
	hWK9HlWVvFKQmRnwN95r+WKctWZpIYrmGEn9LrRhpEqlM+Nfd4FVmVfVnx/14H9y9wrP54aiahg
	+CJlHbfwh3GBY3Osc4M5y5GcDYzv1AkOor79R2+9pNhQwdAibIW8wzTlmaEl1uGRiek3WMtemxe
	AeOm+p16n6Sv46i/vXy/1TStuq8NbAmz2wFwGq9YcBJvRE0U+p+9iSTGL8SqntbZmCgOvOCMiXZ
	W6rXd56blSpEtxqs1vIsd2YF02kAkMRSLj9mC6UA==
X-Received: by 2002:a05:690e:e84:b0:660:321c:46bf with SMTP id 956f58d0204a3-66106f95c76mr13505010d50.62.1780927028604;
        Mon, 08 Jun 2026 06:57:08 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.210])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d62046fasm9473003d50.13.2026.06.08.06.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:57:07 -0700 (PDT)
Message-Id: <pull.2139.git.1780927027.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Jun 2026 13:57:03 +0000
Subject: [PATCH 0/3] config: allow disabling config includes
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
    Derrick Stolee <stolee@gmail.com>

This series introduces a new way to ignore config include directives via two
mechanisms:

 * GIT_CONFIG_INCLUDES=0 in the environment.
 * git --no-includes ... in the command line.

My motivation is from a tricky situation where users want to do the risky
thing and include a repo-tracked file for sharing aliases and other
recommended config. They are then struggling in a later build step that is
running Git commands (under a tool we don't control and can't change) that
then cause filesystem accesses outside of the build system's sandbox.

While git config has a --no-includes option, that doesn't impact the
behavior of other Git commands. We build upon that existing logic for
disabling includes, though.

Having had recent luck recommending GIT_ADVICE=0 when running Git commands
from third-party tools, I thought that a similar environment variable to
disable this functionality would be helpful, too.

One thing I do worry about is whether or not this would cause a significant
break in behavior, or if this is a relatively safe thing to allow.

The three patches are organized as follows:

 1. Patch 1 has a small typo fix in the config documentation that messes
    with the format of the bulleted list. I include it here because I add to
    that list in patch 2.
 2. Patch 2 adds the environment variable and tests it via 'git config' and
    the use of a Git alias.
 3. Patch 3 adds the '--no-includes' option at the top level.

Thanks, -Stolee

Derrick Stolee (3):
  git-config.adoc: fix paragraph break
  config: add GIT_CONFIG_INCLUDES
  git: add --no-includes top-level option

 Documentation/git-config.adoc |  7 ++++++-
 Documentation/git.adoc        |  6 +++++-
 config.c                      |  7 ++++++-
 environment.h                 |  6 ++++++
 git.c                         |  6 +++++-
 t/t1305-config-include.sh     | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 63 insertions(+), 4 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2139%2Fderrickstolee%2Fconfig-include-override-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2139/derrickstolee/config-include-override-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2139
-- 
gitgitgadget
