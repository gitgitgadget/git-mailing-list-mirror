Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2508418A33
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925207; cv=none; b=eI2/JqflIXF2szuQxucWUgcSf1NNhQU4qszd6ZUm9wkg4MtCfVbCn1g1bYm18GG79PThPkU6OBz/7KCSEt9sNbUag8itEbgnxhN8W5nkL08XkdtbiDwsxUGgpftiaIhZrs3b+ieui4aRHP38NYShWEllyA4zWRbhxcDJkIsTh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925207; c=relaxed/simple;
	bh=s88rGe0pTVOaLKhhPAxztD070bpXuBQU+Kw47PsSkKs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=oK8vyLaCG/qnEbdQpDezOL2WvBl87JraSl9XxUnYcGLSSUtXV7nkqPBG0IWVcyam0hzge0zkgEZUjLK+YV4vssJumPpXnuwEMPobqSzQDQJSlrNLEhzCScI376JFwOL1Grx2ROaUhVwBeVOYJNHufZDxH1ng967l2xPYuoiqRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQiUkCO2; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQiUkCO2"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso7235671eec.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 00:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790925200; x=1791530000; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gMt/Cdu7p/XgyhSZgWuBLQQjViKuhcnfM2Dop3h1Vyk=;
        b=IQiUkCO2VD5sou8/BeQ9UB6IIb4vx89P0sF5mBRZ+FgJd/TOSjShE3oNmYm6GM2Sg2
         zbwZr4HFfl199zRAarCjBA1fyh45IwZwWD44MhVvUBhEk4E0fDAGuu9of4GIAKGuy5mT
         sJXUla3TlAh+hy8mDv56H2iqwnOTFRD6PtXcJBeEJLJliN98O7V5MyMbRbmiGAO19+p4
         DJ8owchTXYMyEL/2Wu0z+VO7Hzz1zi94A5yffHud44mkeNiWcBwkfb9oRAuFEV87WGe2
         DlWx9hMenV8l5EtzVdi4ODhoOJJErOvNwIktffIR941Ozh+Q8mPRFTpFlTnYDG0k5mWN
         37Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790925200; x=1791530000;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gMt/Cdu7p/XgyhSZgWuBLQQjViKuhcnfM2Dop3h1Vyk=;
        b=y6fXICAvABdPw5xNUHukF6j2LBGuvkGrnOlVWzFYxY2Yh/rPZNl8is5OcUpTNXyeAB
         mTViJatj/MWGd/w1FQfsaNmvc1EySZJ0ltQjnnVyGoAoiU5bj1o/cP2DaiSIo4MuQ+7J
         YpofsW0JGQm2er9iKSxb3U95c0IPl00Y6F44yWr9svEefP+aj3rIgjtJLtjyCa6e9kV3
         SWPHPGQE8iOyt/9e5DmLZIDEbmHzMqkqZWgkMckACQu1Zx6/RKGIXXMUdb2re+x9jbZd
         cgKpjry836QS0IK1CSQ0BqX5jOZPyNzoi2NtTJTHv3nwi+LPNyMknaaOfiLJRJePrV9y
         qxkA==
X-Gm-Message-State: AFq9FYJMk2Gee6S6S4JvhHNRjzzpE9YbUeCZdb9jcQi9p+CyMdQWBw24
	fAad+ceZp2/+qFQu6+ntnDNCofNxM993pdQ5HZt5sihNVS9M8n+QPP+d+4IFPA==
X-Gm-Gg: AYBFou1efv6KCMMqWu65+uEYe+r4A0tWR1702rwzQWaJjrsKH9byyviFfRyiIlxqNx2
	b5lpgHfGJ9FZh+1UyA9jXcyWKn6dNMTfHSsUY+gG5+aNE+fOaJ7oK0FJMtI0N/L3tafEbpoBKX7
	vLh/q7ANLtdAuhGZ4+U0qDwyRe9WwPj8ezFwLhgyi53orKpX1sIXumd/UgfPSHIYf710GXXXWi1
	vRFO4Ge5/gcVSmfOS/r7RYdeM2Zj5uobrg/96NUHMCAWg6TWNMSPeSUn1k5y7INJMdyUwKzUO1N
	PQTs/1hYrUvvrIWTzsZZQmBcUen8wn8jwnXSEbjMCHerI7bq0CP+IPPoj+tHU00RCJzx5kUANu/
	8hmVhHGGusy61EDIcbMbDbqRcSLsR9J1/HSyb08pNw5X1syTNUTNAdif1brn5Mw9GVucuNFBsPf
	0SlIggNHtyJHYfuzPBB99jaIn0rIbjP0XzQ85Mp7932OtJayBVHDGSjbpmxswmd8GBFztbR2Kn0
	ag=
X-Received: by 2002:a05:693c:62db:b0:33b:dd20:f79c with SMTP id 5a478bee46e88-34f150ab86dmr1588463eec.12.1790925199877;
        Fri, 02 Oct 2026 00:13:19 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.209.71])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14fdb478sm3775077eec.22.2026.10.02.00.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:13:19 -0700 (PDT)
Message-Id: <pull.2412.v5.git.git.1790925198.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 07:13:14 +0000
Subject: [PATCH v5 0/4] fetch: avoid fetching every branch of a new remote in a shallow repo
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Avoid fetching every branch of a new remote in a shallow repo.

Changes in v5:

 * Renumber test file from t5585 to t5586.

Changes in v4:

 * Removed the automatic default-branch fetch. A fresh remote fetches
   nothing until you track a branch explicitly.
 * Fixed fetch report showing "new ref HEAD" instead of "new branch "
 * Reworded remote..refmap docs and commit message.

Changes in v3:

 * Replace the special ":"/"+:" fetch refspec with remote.<name>.refmap,
   reusing git's existing --refmap mechanism instead of inventing new
   refspec syntax.
 * Split the change into 4 commits.

Changes in v2:

 * Replaced the opt-in fetch.shallow config entirely with a new special
   fetch refspec (+:) that git remote add now defaults new remotes to in a
   shallow repository. The new refspec fetches whichever branches any local
   branch tracks at that remote, plus the remote's default branch.

Harald Nordgren (4):
  fetch: add remote.<name>.refmap
  fetch: infer branches to fetch from a refmap-only remote
  remote: add "git remote add --limited-fetch"
  remote: default to --limited-fetch in a shallow repository

 Documentation/config/remote.adoc |   8 +++
 Documentation/fetch-options.adoc |   5 ++
 Documentation/git-remote.adoc    |  14 +++-
 builtin/fetch.c                  |  60 +++++++++++++---
 builtin/remote.c                 |  31 ++++++--
 remote.c                         |  41 ++++++++++-
 remote.h                         |   9 +++
 t/meson.build                    |   1 +
 t/t5505-remote.sh                |  76 ++++++++++++++++++++
 t/t5510-fetch.sh                 |  17 +++++
 t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
 11 files changed, 363 insertions(+), 18 deletions(-)
 create mode 100755 t/t5586-fetch-refmap.sh


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2412%2FHaraldNordgren%2Ffetch-shallow-narrow-refspec-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2412/HaraldNordgren/fetch-shallow-narrow-refspec-v5
Pull-Request: https://github.com/git/git/pull/2412

Range-diff vs v4:

 1:  d48a7004e4 = 1:  d48a7004e4 fetch: add remote.<name>.refmap
 2:  45b26e2bb2 ! 2:  fecdbc43b8 fetch: infer branches to fetch from a refmap-only remote
     @@ t/meson.build: integration_tests = [
         't5582-fetch-negative-refspec.sh',
         't5583-push-branches.sh',
         't5584-http-429-retry.sh',
     -+  't5585-fetch-refmap.sh',
     ++  't5586-fetch-refmap.sh',
         't5600-clone-fail-cleanup.sh',
         't5601-clone.sh',
         't5602-clone-remote-exec.sh',
      
     - ## t/t5585-fetch-refmap.sh (new) ##
     + ## t/t5586-fetch-refmap.sh (new) ##
      @@
      +#!/bin/sh
      +
 3:  e2f072c254 = 3:  b45f3cf0ab remote: add "git remote add --limited-fetch"
 4:  43b9711a2c = 4:  8c2a144eb7 remote: default to --limited-fetch in a shallow repository

-- 
gitgitgadget
