Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A8932BF2E
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534016; cv=none; b=hIsr4BJJziJUrESqIkrfsdv8DIJy/c61beBlpiZXeRBshBe430s9YLskG+fRWg7/WYK7pbZ3se48tU5SsWQS3wR+/33kz51mmu+bucCGbPS9x1pQgUmxusu1vi/Bh6dCW8w9t3kEkFRBUOGUF6E6iLa7IRhr2xeRRoO6zlDfOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534016; c=relaxed/simple;
	bh=IDom+2btO8JC5M04u1OS2I46eEB+st+A/LLuS8QjBNU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YFwRjWvuWUYoIwj/uArKruaxViSkmBm3qgc+WB6fKsfH4m0kgT7lVAtD98fA+ndgC6tdHgtChXjPr4xbxf8Ssh79Q+aOxp4kWB22GWfOqo3golnmH6W2rDQCWAeNm8TWV2RqmLo5bJmux0FC6o7NRArmI/EN4MnlZVVIm6vsyTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0LR3gkw; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0LR3gkw"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-273a0aeed57so13279315ad.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 06:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760534014; x=1761138814; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+fDTyLDYA8tAHBsife2rtz6O1ws5Wb3b0R2U/ZSHFkY=;
        b=V0LR3gkwNohZMf5CKm6QENU2lu9ssZ8LWXw5FMmaJwTn/P1XsXDcKfN7C7b7O4jvmf
         ltQsBnTJUzzj3vpnAbqCVZ2UgjLmDBdyhIn+TS7s3kIeWjk+MMOvgv0xfG1RMIS9aPms
         ppuj087OGxIQWQ9bbDPKA4Zco64gMcm6HdMJlpcfByV0bg8K+32GgDsVuBASEwoeFSK8
         tJJMcKUlJUBk9EFfBjw9MUAl6HQzeP+V4PRMKZS//3zTHORroHN7rLJ1VUS/qmL6zXU8
         9lAP4pXoFrLYc27/lD5Oa/Xct0AkRqmh/dCciDnOf8F1pMFIIHCxordDnjKdQiNq/oWi
         0uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534014; x=1761138814;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+fDTyLDYA8tAHBsife2rtz6O1ws5Wb3b0R2U/ZSHFkY=;
        b=r3mJuJcrVSXgsSUchEgF0tjwZImXd2wng3ZNO9+yf/s7tiba+xEbwbseae9K2UE5BK
         mrvdZOLZOGsxnqdBuv82hZRlJhnx+7mm87Tbe2a9Vb73RlW6yKtF8voyaXf8GV8cse8I
         r2LG/HaW0O/rKm/NmZe9wcyH5obFZiFXG05yUF0ejccBIZ5WDk9yG7hTqLX62MgvlmBF
         WothX46YNSnD+scPRXR7pohsE8ehocVJeBlwZjKsAE4mzebfGfWtkqaDPhyGRF/kxqTm
         CKZxl8Uaahy2aLHEcEjFhsz9negWN0BM+nrnN9tPovWzSr6iTGxXB2n2wYfK2xCaKMNt
         lqFA==
X-Gm-Message-State: AOJu0YzbpIWLf3gYLNNGfszNplNQ8b7svel+3brZ5Mzm1kphr9WHl8h1
	vBbZh4UbS6evNrMD44dKhT3tLXorjuBvNX8cM1i++U7yVik4niPYloCJ1ttJHmoW
X-Gm-Gg: ASbGnctSjqIfBl402OebwXDIJDU9/KxSpfRgpiADxU7NV/vx3V49h3kxPvav2eC1kK1
	mSkH00iz3d9c/LBmaj1r4e0cE2tOE10WqBTKUGrfSDgXu8xoAvSYVn35v5uPt5FjKRA+VGtvvzh
	z5jf2gZiG5HiqIG8K6LcSP2FHiFmB5XOwgNIaldxk9s7kQaNZLDYY4BSPf/w6udP7SJrOLXE2XW
	YuL8sPXlH7ezWPHlP0Iyz+2Msy1/GHhBpRqBc1fiGsv0iA+IYsHMMtaM4cS/tlfWiFuUaljUwuq
	5729puEvFWKsAT0zyFLaGuYpXFcDxfZpOt0YxcnC/q+WkikqUYm0k7YlvjV5T2zZKdJGzb5xBIC
	/Hvd7QcqKVtaKBg6eGHUrBBsoRWnRA8CyVUjghniDorNH/O+MsrQ=
X-Google-Smtp-Source: AGHT+IGf/FHiMt1BuCPTMnVASPQV5iJfQIeUI4uYd8ejUwO1rp1couIlSk0rRE07OAQa7Zw4z9p7Ug==
X-Received: by 2002:a17:902:f710:b0:271:9b0e:54ca with SMTP id d9443c01a7336-29091af4271mr477995ad.13.1760534013240;
        Wed, 15 Oct 2025 06:13:33 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.60.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de5721sm196671025ad.21.2025.10.15.06.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:13:32 -0700 (PDT)
Message-Id: <pull.1976.v3.git.1760534011.gitgitgadget@gmail.com>
In-Reply-To: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
References: <pull.1976.v2.git.1759951536.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Oct 2025 13:13:27 +0000
Subject: [PATCH v3 0/4] doc: git-pull: clarify DESCRIPTION section
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>

I got feedback from 15 Git users on the current git pull man page, using
this tool: https://text-feedback.wizardzines.com/git-pull.

My goals here are to be clear about the relationship between git pull and
fetch/merge/rebase etc, make sure users know the current default for git
pull (--ff-only) since some folks still remember the old default, and to
help users quickly figure out what command they need to run to
merge/rebase/squash/etc.

I've taken a pretty aggressive approach because I think it's possible to
have a pretty short and focused DESCRIPTION section here while keeping the
most important info. Open to hearing that I've removed too much.

This references the UPSTREAM BRANCHES section from
https://lore.kernel.org/git/0ec629d4037bf5d1ccc248ca1bbd87ccc08119a3.1757703309.git.gitgitgadget@gmail.com/
, so if that isn't merged I'll need to revisit the approach here.

changes in v2:

 * Add "(excluding merge options)" to clarify which options are passed to
   git fetch (from Chris's review)
 * Say that git pull will by default merge the upstream branch. (from
   Chris's review)
 * Add some links to the UPSTREAM BRANCHES section, and to the <refspec>
   section in git fetch, to make it easier to navigate in the HTML version
   of the docs at least. The situation where we repeat the <repository> part
   in git fetch is weird but I don't have a better idea for how to handle it
   right now. The UPSTREAM BRANCHES links are currently failing the
   documentation tests, but should pass once the patch series that adds that
   is merged. (from Ben's review)

changes in v3:

Change "fails if the local branch has diverged" to say "remote branch has
diverged", from Junio's review.

I did not come up with a better idea for a word to use than "integrate" so
left that alone.

Julia Evans (4):
  doc: git-pull: move <repository> and <refspec> params
  doc: git-pull: clarify options for integrating remote branch
  doc: git-pull: delete the example
  doc: git-pull: clarify how to exit a conflicted merge

 Documentation/git-pull.adoc         | 93 +++++++++++++----------------
 Documentation/pull-fetch-param.adoc |  1 +
 2 files changed, 41 insertions(+), 53 deletions(-)


base-commit: ca2559c1d630eb4f04cdee2328aaf1c768907a9e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1976%2Fjvns%2Fclarify-pull-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1976/jvns/clarify-pull-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1976

Range-diff vs v2:

 1:  4cc87ec354 = 1:  96b2673e04 doc: git-pull: move <repository> and <refspec> params
 2:  122774d4cc ! 2:  0ff00b4ff6 doc: git-pull: clarify options for integrating remote branch
     @@ Documentation/git-pull.adoc: SYNOPSIS
      +There are 4 main options for integrating the remote branch:
      +
      +1. `git pull --ff-only` will only do "fast-forward" updates: it
     -+   fails if the remote branch has diverged. This is the default.
     ++   fails if your local branch has diverged from the remote branch.
     ++   This is the default.
      +2. `git pull --rebase` runs `git rebase`
      +3. `git pull --no-rebase` runs `git merge`.
      +4. `git pull --squash` runs `git merge --squash`
 3:  323e81f2fd = 3:  2439c3d847 doc: git-pull: delete the example
 4:  999dfba156 = 4:  2236dac4e4 doc: git-pull: clarify how to exit a conflicted merge

-- 
gitgitgadget
