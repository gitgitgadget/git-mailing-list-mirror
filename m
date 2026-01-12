Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF0B2D9784
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222780; cv=none; b=DVG7oLiGCP7KYX8CFaiavQ0s/Pcosz5gy3bSUvWUdKOaCqSjt6h/ATgYSuen1JQQcy9qvxkv56LBr80Tdsroz9p4fztsR51NQHrJ90jfympiledYA+1ZVSznVFZPA9TMZ9ZyipQPEVJ8ZP95tpev1YPLDfVmGfY17eutVaC/o6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222780; c=relaxed/simple;
	bh=yTmTCf39SD+lmX35uWBCf9IiSWrIoBxS1ioEEIUBIiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P93LRpg/I4LO8cgUtms+jKzoOQqu8WgbVZIJbgwEBhGnvouDATskSPo7v2JHvkcq9gNFSy3ZvkVeN+exZs51cKKPvU9SpJWwJW6SqrUNz3j2gRamcqW/RkQDb+84QBaEWcC5GJedri5E+YnsGnUlD5aeGmPRdV4CHEKzmu7nFJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw9ED5xD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw9ED5xD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso3290998f8f.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768222776; x=1768827576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QZM80HElrXbctAAqoaIsnssfuf+xCRGatxpMz93raYk=;
        b=bw9ED5xD+tdVY5P6e0Mr96fsQ2LIrSRo1ioSsjkyR7Y2jCjSIwM51VCcuKi3px1W1I
         xfAaBzhK7dbXdVVN62k/HztLTD8dF1mGGfzUz/aZVd7hbL6uoSbN5jzeWhPW00TDbSit
         /FlYhuOhnIvRXsO6vPucTsU9s3O5zeyIdFnl0MKp3DtqeWN6e8kTpx9+kxHhg0OB+SBo
         1wt5g2J0uCCacNKLCjjm8lJ7byMj1O/po9d4EDehalIK5iWj54NnxXMVW6Keev4uIn10
         u8lWaPeo/RqldbaUOaPGxnciKIgiMOin1+NQklxr+P+V9m33KlfYaVvuQ9pRhvY5cqsI
         7GnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768222776; x=1768827576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QZM80HElrXbctAAqoaIsnssfuf+xCRGatxpMz93raYk=;
        b=Cm9K7tXVknJH9M3Rni/NrcAFSIb6gvPbA2ywt1OSTlRoeOrcUbVjfXmw13GZ9T2zs1
         SAaThTYRh+SYBBoJl86Pp2loqheCPUtjPLHCY4oEeB1SHnm91ibMHv+V8nCjRFXVUnzT
         LkMU8mUbmkTKCEW37//DqApxTWSXT6Rc4BaSgKm3wsHZe18sV7rnWVzpJf8I91zpDRST
         bpcPgzs24pp0JHeg7tR97NEUk6HCTjoyIf8hSfKTgzm0UmwM5qHYey2hLvlU+1+dvL7c
         onLFNzcvhJywP0pR69S9UgtYicPgVdI8PFGgHtC+8ZA5FpMa0dwXWySSLc6JtIC6mIha
         TAaw==
X-Gm-Message-State: AOJu0YzYPjU/WTsd/ZGNpZkDuFJkFyrwmJ79W1NswA+e+kYF018H7MkM
	zjX1Oc2z4FBFe9xfzjj0QQ9Zx+Ww7T7mSkby1ilqBm7jl8K10+Zp3gFp
X-Gm-Gg: AY/fxX6oJUZRoqQIdD3KWGpxTzIFHr1NdmzJAjSvBaZFY7i9f+WL2bIdeLmg9kLldQ1
	sf+Sq6nwo0WxkUEQZbDUUlVKMENdlIL7O68iS0NQe4JGYsMeqtw6UobIXZeMw3G3sXPDwnvVSs4
	rZ8lSUQ4jMjYjVAZoKwmei1wGykQvJ6Nap9bcz1R55tZD+MoEwehJDqw1Y0wjmitXr0Sa38ZU2q
	SdL1a2umspQsrFfDvnICiG6ysDKmc94rZYrLZOywC4UdkmxRXQOyOX3FYdUzs3dzQhzkvtSOAW8
	H3/iHeKjC2NxWL39YaHuhLZB2NF4I6TAWki0X1HlxTA0kcD4odYeixD4WiZaGVGl/37f5BKP0gE
	O0+v5dBOEdUHEQPJR6Y4+pNf0feKmusERKyqLczIbjuXN2TEix+2Is2GsHu0oMrjgr9W8S22TsQ
	xLGCYSIxB5B221iK8=
X-Google-Smtp-Source: AGHT+IEU/exR67AjJLSjBMW/vNznW80/ewbf0TAEwue4twHbIg75dML59EUFbTETrej7p+ztCLva0A==
X-Received: by 2002:a05:6000:220d:b0:431:9d7:5c2e with SMTP id ffacd0b85a97d-432c379dbd4mr20508897f8f.35.1768222776115;
        Mon, 12 Jan 2026 04:59:36 -0800 (PST)
Received: from ubuntu ([102.91.81.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e199bsm38241606f8f.16.2026.01.12.04.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 04:59:35 -0800 (PST)
From: Olamide Caleb Bello <belkid98@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	kaartic.sivaraam@gmail.com,
	me@ttaylorr.com,
	karthik.188@gmail.com,
	Olamide Caleb Bello <belkid98@gmail.com>
Subject: [Outreachy PATCH RFC 0/3] store git_default_config() parsed values in new config struct
Date: Mon, 12 Jan 2026 13:59:22 +0100
Message-Id: <cover.1768217572.git.belkid98@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Git Community,
Over the course of my ongoing internship, which focused on moving global
variables in environment.h into local scope, I have attempted to move some
variables into the struct repo-settings.
However there have been some design concerns as regards the use of
`prepare_repo_settings()` with respect to when and where to call the
function, and also the change in behaviours when the variable is lazily
loaded as discussed in [1] and [2].

After different deliberations, Phillip Wood proposed creating a new config
struct [3], adding it to the repository struct and passing the repo struct to
`git_default_config()` to store the parsed config values per repo.
This would mean we would not need to remove code from
`git_default_config()`, and hence the current behaviours will be retained.

I have experimented with this approach for some values and I would
appreciate feedbacks about this approach before we can move forward
and use it for more variables related to `git_default_config()`.

For now, the parsed value is stored in `the_repository` in
`git_default_*_config()` and further efforts to pass the repository
parameter to `git_default_config()` as the callback parameter will
be looked into later on.

1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/

Olamide Caleb Bello (3):
  environment: stop storing `core.attributesFile` globally
  environment: stop using core.sparseCheckout globally
  environment: move "branch.autoSetupMerge" into `struct config_values`

 attr.c                      |  8 +++++---
 builtin/backfill.c          |  3 +--
 builtin/branch.c            |  2 +-
 builtin/checkout.c          |  2 +-
 builtin/clone.c             |  2 +-
 builtin/mv.c                |  2 +-
 builtin/push.c              |  2 +-
 builtin/sparse-checkout.c   | 22 +++++++++++-----------
 builtin/submodule--helper.c |  2 +-
 builtin/worktree.c          |  2 +-
 config.c                    | 10 ++++++++++
 config.h                    | 13 +++++++++++++
 dir.c                       |  2 +-
 environment.c               | 20 ++++++++++----------
 environment.h               |  2 --
 repository.c                |  7 +++++++
 repository.h                |  4 ++++
 sparse-index.c              |  4 ++--
 unpack-trees.c              |  2 +-
 wt-status.c                 |  3 ++-
 20 files changed, 74 insertions(+), 40 deletions(-)

-- 
2.34.1

