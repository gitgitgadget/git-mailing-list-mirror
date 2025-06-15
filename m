Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3F83207
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749998806; cv=none; b=RxD7I+ONCcC1qK5MnZiFa6qy3IZSBviwIMYUl8Zf/Cet7Kx4NlkOh+cEUGF2T2WBjGXEL05iyMb/PSHDBfiwY2DMnpMHQxqCZrm7YuxYnG343KCPzCaa51deHwkqp1u6gb6ypcq1qQgoY5jlEEIEBcSHyeoLnH3IL1vgm0RgLWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749998806; c=relaxed/simple;
	bh=VKny+31hamdSjAC9cF2TP42FtIR1ennTzkLnHXYmj8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6q2a70EXKLz5XMmgRhLsPVnOOhy8m47pLnMD3gpLXYw9Q72oep3TNALj1msaqwFNKO5WiIh0TZfY5LW3rozCKpuoj/6H8OFKIWub4Fp3/k384uYdUfVy80cWDAZ9LWNOz/Snox5nSHpMFR+B7MpPH0BreThy6SW9s+w/zl94dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aGeDYhsi; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGeDYhsi"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-73972a54919so3134233b3a.3
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 07:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749998804; x=1750603604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JkHrBnDsDFPwjUhrJPCapS5ZLUDaMQguS8LNlaoafZQ=;
        b=aGeDYhsirCo2Hws6TsrmZXbOccEwxd8p98djuV1bPn6dPE6j/gcxRsaBK12UHQGD78
         7PqAYe8DXvzBxcvAToClVxQSg8tdIthlLNgldv/fQOUPIaR+9NNjTMUmDZHKplxXnuFd
         WTZM21/02jgzFEwlW0lwTocYYekk7Ar6F90K6FZUcJTNSGy+6k9UOf3fL39sZu2TliT9
         zF966+2lIyfFpSmEPbujqp/fv+obSt6QofS3jiQfQas1QlaWSqlgf8ZmPHJjlZCi6+Lj
         UmVG8MsrooEtOW0xmLRD7XL3m7Le0q+JKZYHPvEY5PzDbU85YcxfhfdcvgxsO6kSTGw1
         DtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749998804; x=1750603604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JkHrBnDsDFPwjUhrJPCapS5ZLUDaMQguS8LNlaoafZQ=;
        b=b5J7kk/LRP5ntthzK8piHIyVmuH7W80Ve7zGqv8AnET5VYApYAyKwpMkO7+4KR9lXO
         I2+Sgj8vVsvoMlq02wiqkvP2sV8/5bH6kdu4RAmc42+N7sChEu950QHewRGyHtdCipl+
         NTd3tocuepMZvfqPD9FTH3Y6xksSR1gy5B+wemMw5HV+5lupM8OmqWsIw5Pg5tnUBUQu
         FNDRQf43o2hfxM68weEWV3yigy0LwNfKPuBYEZ8xMg4MX2xMDKGeW7YeBoGBRQ0NGEAy
         jUts/6G3WogJ2L3oBwm0JiGMczp5OPLvi3qauG/rPv3tb1VZsS1ZzW5pvNO5InBGSjVp
         CitQ==
X-Gm-Message-State: AOJu0Yy8Kvq+56UjuEvTpLf/5tqohs6lWKtUoGRDikZK0Q41BBKbT5gj
	WwWuztn5baBbFWkt5l7ME/x4RL1FqwtnoGexToJNrxl2ljKdldjBvSNwWLg1bIAtJK6UgJT4
X-Gm-Gg: ASbGncu7I6PPBb5vDb62FqASj0rTZ42s9wEscgROsG6wtGUGoBYNDLufnJAiUX9fxoa
	xwDiOY7e1E+FxC57wQccIPB3q2djbEQI8qPsDarzQRs6ybywsOl6VU7KnCa7em4+PWUVerdKd27
	gpEe5VVT1P+4swVF1WxAk9Prf0RqeioQhjX5pFgOxYmox3aQHlItXrCeQzkx5CT0J/CZGSdQA8Y
	yHh83mSoXSYrXin7aTOYU5n3wxDf645OWI/46xd354kVfUnMk4bEIekk6owwsXjAXLCNHk0tPC3
	dN1HeqoGWpIMuSCw0gLUT35jILygDyEBgrRZOjyq/fKpF8SUFxsts47YGOFmaj/gcUUe
X-Google-Smtp-Source: AGHT+IHlkrAYKchBc+jpIbREKf662dmBJN2A9+BYAc5ykAsNKf+t54fjd03bsdbb1MKRLZl1tbVZZA==
X-Received: by 2002:a05:6a00:2d8e:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7489cd5c0b9mr7965540b3a.0.1749998803910;
        Sun, 15 Jun 2025 07:46:43 -0700 (PDT)
Received: from r760 ([188.253.126.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7488ffeca93sm4950180b3a.20.2025.06.15.07.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 07:46:43 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: git@vger.kernel.org
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
	ayu.chandekar@gmail.com,
	christian.couder@gmail.com,
	shyamthakkar001@gmail.com,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v3 0/2] small fixes for git.c and setup.c
Date: Sun, 15 Jun 2025 22:46:02 +0800
Message-ID: <20250615144604.1447302-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0-rc1
In-Reply-To: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
References: <20250614050331.304405-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I've been reading through the git code from the beginning. This
patch series fixes some NEEDSWORKs and cleans up some unnecessary
uses of the_repository that I came across.

The first commit replace the use of the_repository to run_builtin()'s
argument repo. Since each caller pass the_repository to run_builtin(),
this replacement is safe. This commit also rewrite a comment before
trace_repo_setup(), I am not sure my version of rewrite match the code
semantics. So I am reaching out for help and hoping to get some feedback
and discussion.

The second commit takes care of a NEEDSWORK in setup_git_directory_gently()
we now properly error out if we hit a .git that is not a file or directory
when looking for the .git.

Lidong Yan (2):
  git.c: remove the_repository dependence in run_builtin()
  setup: fix NEEDSWORK in setup_git_directory_gently()

 git.c      |  6 +++---
 setup.c    | 11 +++++++----
 setup.h    | 18 +++++++++++-------
 worktree.c |  4 ++--
 4 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.50.0-rc1

