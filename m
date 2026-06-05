Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF4924E4C4
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 16:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677039; cv=none; b=a6BXaP5PMwVTaFTFfqg/3I+b68lf9arYMKubRVVQj4seV1nwoVHHI7YKLNUQ2TOUUi9qf1SycS4AkI1DSlaT7PHqy0+gE7sipbIQDkr5CDnxp69RZANChqKYS+/TBuFa5kBuPfQd7+iBhBQozwQ6A+b17Lnls3WCbOWpE4sEEpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677039; c=relaxed/simple;
	bh=J7bQLyv8U+0WyGR5PqufaNyRAoA0Tax+FRfr0AzFvKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s76mfrpj/7Py0FJBEsKtMCMoA402V0qfXDB2yGPlrh7fRiny84yUKaJ5yf/U+ilGnLvu+TkoO5lWL3ZEsvbQhECgivvlV5A14S3fc3fETCi39m593tgmurawvnafmnD26DLlgV+0JPpY1WIl66h/D7FYcBnMrZP0P84b5kZDecA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTKP6T23; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTKP6T23"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2bf125989f2so15302645ad.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780677033; x=1781281833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eYe96Muyj5T4IC6V8tqARoTL10RasI5qSc4t3Z65zY=;
        b=QTKP6T23rm5tveV2RZOMsiGGpYgRT6QUF8zWL8IhmJUZm7kDKgSGSd4tv9qFH8nmyu
         qIe8p77I2JJ2VUw5mU1xjv608+b2VUS0xo1WWqdh0uaaZLp014EXhr0Q2jWaWOxAPMtx
         gaHBJpHCsP3U5BmVGtcrumJl5ZmM7AbCXKdzoC8/ulIQdkMHarqjOVlBsdynXGlxn2/7
         rJUGfGPmnRba9myPrzWwoMr0MUfQBdpVHriBXBbvSOO72UTd7zIOveJGkijp8zzRDvMl
         CVCChvhNBQyoJqT816k3jCmBwwTAa2N34UBpwXtPcZo4HzVJWFA0fgazatm02NquCj++
         Qj6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677033; x=1781281833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0eYe96Muyj5T4IC6V8tqARoTL10RasI5qSc4t3Z65zY=;
        b=s2T8IKQ6b2j6DKVxctb0vGQW8IIHH+Mla4iFoX46UA0RJ4+7BGPyju4my5hpSNhR6g
         RrTVdPyRlza1RnBKvTYBotPpuKtGz3mjPZbqZzLADn1BSSsH9EXxZfoqzZqRsrefgU7H
         LGpHGTPh01k111siihHsVzRiC1ceufjsaMKhzXKq3CTUyvBb7G7CuOYf8FewF8EEidq+
         mS9voH3UoJwE5C3uIsL6WIlaKzKyaece797EhEd7dP1pjq6qQBaD6tr58I0Q/HBTnYpd
         1cMgXXviw1bjlv0ZJzOnF3dTVzRIIgpiZIwQNgQromCvQ3YPRg+evCKHz8j16M7NpnEY
         UvIA==
X-Gm-Message-State: AOJu0Yw+qtB3EAPFQr4e0wv7ZslRPsIxCglnpeNYvMpaMRTWTBibXmtb
	+x+TZJzUeoEI8UWpCRmt0ar5dAuf3LX+wNh+y64zbQ84JIdncxZlF2idTTY3Vg==
X-Gm-Gg: Acq92OGzCUVOXI72awc1qLg2iGhpOsORnGYgCyirtTydwjiLj+53+D0QhdOKP1K8OCm
	NH/S/eXhRbcBgvG+mdHLHmDQRC6W35ekFJBkVizYdivHFQ7HJ6rpcR87dlYr6Xm32QQ/l+Sw4os
	0rzHt7WSJv1C0HACR1fNS+AkfjKpTSojBm/y5WCpgYEBrfXpye29f80Jt0FrxomgEuZ+Cd1bbWw
	9T0leJNUCcFlL5XugpahLaFOnrlVgwhLkUyDthk4WH+dXVP63fcY4Nw1dAWYY4jjxwtraIXvYxP
	yoq+2iX5lhbauDTjMN5Cd71rTD/I3uR+DyW/6WZL/EgKsGob5ABRZYqZTSalkF+BpAuPQHzffOK
	2h1hlOym2RmvFe07IH/Aqp2dOua4Kt4I4zRPHBwSA4Tsy2aXeqN7rVqA2QtbtX8DgjoofSsyX96
	EtnXso8O+a8DtrX9IdahySikWDe8bbXNz+PDucjYwhc7N3uXr4Ix71ARnDhAcKmW+/54vbV/3LA
	VmvSBLUiu0JkVjCGMwCDBRWdqAymDks36YnoBo3jm4uvRZgeEYrH9o=
X-Received: by 2002:a17:903:4407:b0:2c1:d49c:8398 with SMTP id d9443c01a7336-2c1e78df934mr47715745ad.8.1780677032812;
        Fri, 05 Jun 2026 09:30:32 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm95883955ad.20.2026.06.05.09.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 09:30:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jayatheerthkulkarni2005@gmail.com,
	a3205153416@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC PATCH v2 0/4] teach git repo info to handle path keys
Date: Fri,  5 Jun 2026 22:00:08 +0530
Message-ID: <20260605163012.181089-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This series teaches `git repo info` to handle `path.*` keys, so
scripts can easily discover repository paths.

The commits are divided into 4 parts:

  1. path: extract the path-formatting logic from rev-parse and
     expose it via path.h with a better naming convention.
  2. rev-parse: refactor the command to use the exported function
     and enum.
  3. repo: introduce path.gitdir with standardized tests and docs.
  4. repo: introduce path.commondir.

About patches 3 and 4:
In our last discussion [1], we didn't reach a definitive conclusion
about paths in repo info, but based on the feedback, explicitly
offering both relative and absolute options made the most sense. So,
patches 3 and 4 add both `path.<field>.absolute` and
`path.<field>.relative` for `gitdir` and `commondir`.

There are still a few open questions. Tagging Justin, Lucas, Junio,
Phillip, brian, and Ayush.

Questions:
1. Should there still be a --path-format flag?
2. Should we consider a default option?
   Currently we have path.gitdir.absolute. Should we consider an
   option where a plain `path.gitdir` returns some default?
   If yes:
     2.1 Should we keep the default the same as rev-parse? Or should
         either relative or absolute be the default?
     2.2 When printing using --all, should the default be printed,
         or should we print both absolute and relative?
3. Is printing both absolute and relative in a single call using
   --all acceptable? If no, what's a better approach?

I have discussed these changes with both Justin and Lucas internally
and wanted to gather opinions from the wider community before moving
forward.

Changes since v1:

* Lucas's feedback: Added corner cases covering GIT_COMMON_DIR and
  GIT_DIR. Parameterized the test helper fields instead of hardcoding
  them. Also fixed the subject prefix to [GSoC PATCH v2].

* Junio's feedback: Added a clearer description of what the series
  does up front. I also realized the commit messages for patches 3
  and 4 explained the "what" and not the "why", so I have (hopefully)
  improved them :)

* Phillip's feedback: Changed the helper function name and combined
  the two enums into one, which made a lot of sense.

  I have also added comments within the path.h files to document
  the API.

* About lexicographical order: "Breaking" wasn't the right term
  before, but I do believe keeping .absolute and .relative as
  suffixes is a better choice. I prefer having the two choices
  side-by-side grouped by entity, rather than a cluster of absolute
  keys followed by relative ones. Open to hearing if the latter is
  preferred!

Thanks for this round of feedback guys, this has been fruitful!

P.S - I realized that I didn't add the link to Lucas's patch thread
last time :) sorry bout that!

[1] https://public-inbox.org/git/041DCF2E-75FB-4B0A-9128-FDBB1A6DAC3C@gmail.com/T/#t

K Jayatheerth (4):
  path: introduce format_path() for centralized path formatting
  rev-parse: use format_path for path formatting
  repo: add path.gitdir with absolute and relative suffix formatting
  repo: add path.commondir with absolute and relative suffix formatting

 Documentation/git-repo.adoc |  15 ++++++
 builtin/repo.c              |  50 +++++++++++++++++
 builtin/rev-parse.c         | 103 ++++++++----------------------------
 path.c                      |  58 ++++++++++++++++++++
 path.h                      |  30 +++++++++++
 t/t1900-repo-info.sh        |  40 ++++++++++++++
 6 files changed, 216 insertions(+), 80 deletions(-)

-- 
2.54.0
