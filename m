Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AEC4964F
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 05:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782021443; cv=none; b=V/Rr5yStuuVUeaQsAdLajPe0AiXO7aiKQs40ei4duD+ceFOqghMlNRK/SxQ+Xni9Bl858oyo5BdrtFE7qE/FeJBKztryMFgAbIkpMQjUJg+UBy2QIqHDLddy6FeERxkwigDHZWjZNTaocJtzyiklfKQ4Qo+84EWpEuAs6vHIGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782021443; c=relaxed/simple;
	bh=6wT4eUxEaBQheDxrMeDif/eULNu4jTxGlJ4b3ArWP0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7CjfekG7pyG8ERzEjPGZZZYSKavvQXredwUyTuQV6ryIuGIpEuKvQKb++7EICqsY/GbscC8+AIRdZJzQ2gWHQZC0eMyuFeZw2VKBfFcs0Sz6P7HjtI5DCXdbHIzufCSNN7tuAH0G8hoBH5gXY+Pk1qOVbUwb/WJQ9f4mRtrQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peRF+Mtn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peRF+Mtn"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8453427d3f4so1895942b3a.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2026 22:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782021441; x=1782626241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXoATSu2iI54pC0NpnGbl333ME5oy6oqPzy93EhbXig=;
        b=peRF+MtntWeCeubsTbQ5TOD30+IUaqs0+CdO7w159GOPThyUPEDez+hKkyLOlAF9Av
         Aiippu88J5n+xDiMqH6qGpQ4kSh+/P4S1+gxs7Wpai3OPsqaWhd9bJRlFBpDePMCJP/S
         20tnea5I5xSmPzlHMCTB/OQoDebb4XmT88t1e2A6DE9tQq0jl/d3v8FIe5JrTuWCS9b2
         AQOCKYvMXGWw4I+6ER60uadvCDpIwWoFLdZmPYesJZQLuRa+5QSEB7CVwXwUkISDxFHJ
         Zv7C0N2Eyu7f977kUnpDs0jD1+DmTdz76R+xGlq4tdqkK4X+Z29//dmJAUG4kC0teVBz
         JzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782021441; x=1782626241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BXoATSu2iI54pC0NpnGbl333ME5oy6oqPzy93EhbXig=;
        b=LgUWvzPuibtxQXIVN55HQB3phB+1An2vicl3wtQDTP/buTPIhjX4hkGuSYutIOxlC8
         S842BixcN6+xo/egJYZ6qEM27v1fRNfVogOI3mFU+TTtSFBr6oZtzCUoJY1K5aKVxxU0
         fL1OyUVmJTpW1hFM61Oz5Wj3qt0hFpOufVI4xEVshI+Zo40ezpoCSZdymlZZY5XZOEPZ
         0hKQI3u1GErmtViNv8QOyza8jwmmHnxintZu4uYovRsmE+al9xgqhsgDe/KRmyg4hlle
         /0h3g+Y8URIWx6X42+pq9GX3ENZwkQrKseN4nAQIn05CtoKCnKOMJbJjtmyY1TXCS9TV
         RHrg==
X-Forwarded-Encrypted: i=1; AFNElJ+Zdulpz7SG8YyQyqwNwD8tgk4F2n69teGSDOWWraShM8GT7NdJGhwWG7BZj7JaybjAg7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoMpJCqkFMASoeAU+La7/AojFVnwbR1IyvBoChjaZ0bEmS6iiK
	+JsNyGyYtpyh6gJqHX1LqCeRPqZiDohAYMd++eTqHBzsX8CZXt3CdY1o
X-Gm-Gg: AfdE7clcuQjXAxb9kuM4PFSSBW9T6fXifb8U1c48Ub/C8N78dopu/k6LrI9TR8XCybn
	oPYhTE4IAEboczvKa3y6C4SqlD5Uj1S7tRHXCspR9sdA565dmmnKPoFF6MU7A2SmW4fjXUBId+b
	TYHMAmL1cc75iLPKW7x8uKRa2UAA0NcHr2czxiL1iGz5RKLB1yk3nCGzNW3OAm7FBSdT47tQ2Ci
	X4Z2WAjCxQ5pobBEUCFWwoYmMB+3zHKzbQOH/6gQ9siVDvIXKinmeDthaKFuyuKftijy9kEiskN
	keTpTmE9NlV+HZdSIMiVVikczpsa8qM5l/32isZpxDSOfsOhNTTD/pPZQ5ROxBcMuUm6zjttSys
	D7gsiDExopl8AwZpr2Uk42aQroN5z0hn99dSt+CshsdsrI8RT1b7YkLMy8LzOXfFV3DgnIRng85
	k0S4Vmbm1L9sw5W1WNcyg7qZxmwhl7Tmlet0648zLuBvbme24MpTT6qx/TxxXrI15KDyyZ4Cnne
	URVSIRM95mefFBHqKmHacI=
X-Received: by 2002:a05:6a00:1916:b0:842:670d:f6ff with SMTP id d2e1a72fcca58-84550a07cb1mr10017304b3a.44.1782021441327;
        Sat, 20 Jun 2026 22:57:21 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564ed3bd8sm3606669b3a.56.2026.06.20.22.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 22:57:20 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v7 0/3] teach git repo info to handle path keys
Date: Sun, 21 Jun 2026 11:25:31 +0530
Message-ID: <20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.0-rc1
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

3. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

Changes since v6:

Squashed patches 1 and 2 to avoid dead code in the tree.

Tagging Justin Tobler, Lucas Seiki Oshiro, Junio,
Phillip Wood, brian m. carlson, and Ayush Jha.

Thanks for helping improve this series!

K Jayatheerth (3):
  path: extract append_formatted_path() and use in rev-parse
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc | 15 ++++++++
 builtin/repo.c              | 50 +++++++++++++++++++++++++
 builtin/rev-parse.c         | 73 +++++++++++++++----------------------
 path.c                      | 69 +++++++++++++++++++++++++++++++++++
 path.h                      | 30 +++++++++++++++
 t/t1900-repo-info.sh        | 58 +++++++++++++++++++++++++++++
 6 files changed, 251 insertions(+), 44 deletions(-)

-- 
2.55.0-rc1
