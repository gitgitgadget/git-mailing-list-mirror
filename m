Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAAD3DC4A2
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 15:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327248; cv=none; b=tyqkY2EkjmFFrqlr5ndcvi7NVVNM4IHbr5sNdlnlxwoc2l/2CchFY0FnLdE1lQ1LfqbZ4ECrYht7mOd5vdlm4X2WOP9+atZ8pKTCaOXQ4p6hZzpXe2PJZEdOyi8pE3jKIlc6NKAfbTZVEZ3fp4oFOELpJMb1rJePQCO+2jkTCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327248; c=relaxed/simple;
	bh=6KGY5SwtTIDND0tGrUIvuAtMXdjBjuKtZyORZTqMmiM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KSgnWXV5B5tnRXOziysRsKy4oV1nctPNjricZJwFuggyXgjF/vKXSMZ3MDVs2j6sgE6DsKZ9EzUNeYKkU1uaP9ITGwfHpSRAzHHgypDiwyBUJelXWJU3Zf3YH3vpR/Llfx+FBluuufowK3laZavdgqtgb+6jFCemHiGRUbRSlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BL+MIGr9; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL+MIGr9"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c85b2139015so397577a12.2
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327246; x=1780932046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kQajjPjFDQnncpGqb/WjfpNnitY2Zj65O00YzWFtulc=;
        b=BL+MIGr9XGfHOjd8dcv//bPLSSqKS94lEf5twjLaOoIjGMyZMQs9lGMMiOuWl1VKtX
         LVzXrC699DIZvF423pd8YSMyPNix8EZu4nMI/+TkbtSxVTsHbx/7ShV7jAe5xaOiDZg+
         5iUsgeEz2+wDzBBrHOby3POTg0jEhif1Jhjyml2MIty5kvS7/aQNntdFvnFDzbqUEV7P
         Ue/4hMLa7+LcTukKyEa623WpSEgcp8pnuDGfpd8xNGvRLetDfO+wQEQTRpqIIADY5zjk
         SxxHTOQ56pA7UbiccWhPRIFSjXaRFolALIx1/6OoH5RHr5dyHXmLt3cKUbbgCAxxjaPT
         jrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327246; x=1780932046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQajjPjFDQnncpGqb/WjfpNnitY2Zj65O00YzWFtulc=;
        b=or6SA+R6q4eGNKhVgn0mSMoRQkvpasVx5AqtIRo0Kn8Bwu5RONY4PFiHAmddlPSuTX
         1n9eA2Y/UmFPoHl6nMFE7vh1d4URXLvfkKo/W60Xq+5MZETne0iUZ5Kqj4hV9pOnozdH
         SGDJQtPWOX9eaYJRqY5SrAzjj/s+UnLbYzuEZYMZJ8vQVdgeyHdQ3JrSCX1Z3htbPxi7
         srigyYnffRlQV3O2hppk+anw0bMvcOk83RRee157NpKTjOeEqP4A0m6aqEtoSMNbWP0m
         XUhy7a5MIgMfiIUlD2LRAvxU55igmhOdlM08bRddMf6N8jqwpJga4a1ETt1vqAOYPKNY
         PAMA==
X-Gm-Message-State: AOJu0YwLDtkMT2NdWtaUZzrjwZ3oelCRuhDxLpU4u+2AFjlS7fXhZzAL
	6FPNfzcIL5647Z0Jt1qv0E+41fDPE6l8K7GKTlyDOxJm+pbowuA9nmGZsKEPhg==
X-Gm-Gg: Acq92OEql9YScHgIwQc8/Tzyn0md0kPI/CmVzmJjJp9/t9tXArKcFUeSU65kOZNCLdu
	re9AOAYwmpL9jEm7ywheaStOyqgeHZ/KtJn7gV6qDck7IXZv7MlfuMz43agAK/x4VzHm/UHYOFW
	XD20KXG8Vj3mXJsmX3lV5kzt0A1xRlwZ/YBEWUG5ojWVWRhSZ1TcteQBRSRzI3PTYB4KAqP4VcM
	G+pYGrlA/nI3GJKLZ4kgwRW+XdbLLz6L85/tn1mDIvLT2pCeQM8kcql59Tn9HJfEHhP4h7XiwhS
	ey04l+LkD/7Ox++6ZtBiUBUte4aipZpvGXLp7aU4mcuOACjK7RijzNOn7hTvuWTwXnCWMr5IAOp
	h4mbty18UwUTyHK7NtxRR6sLnNX+sz+tLPS7Ge6Nt0IBqCObAg93FB5zccoyohjYlOe6f0LHHfr
	yzcFo+GMfwmcGxCgNpsrpwbZHgl3IDUTQyzvLNYlZwl+7MMSIcUB3T9B60YcrOq9Qvf0j5WB+kE
	Kv7ZD8QVYxIz9IFNS4sgFzHu/6qqh5yHMS7PtBw97TB
X-Received: by 2002:a05:6a00:91e2:b0:842:2cda:7aa2 with SMTP id d2e1a72fcca58-8422cda7ea9mr8300447b3a.30.1780327245916;
        Mon, 01 Jun 2026 08:20:45 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84232ef8172sm7352779b3a.12.2026.06.01.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:20:45 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC][PATCH 0/4] teach git repo info to handle path keys
Date: Mon,  1 Jun 2026 20:49:46 +0530
Message-ID: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

The first and second patches are self-explanatory, so I will
focus more on the third and fourth patches, which introduce the
path-related fields to `git repo info`.

In the last discussion [1] we had on the mailing list about paths
in repo info, we didn't reach a definitive conclusion, but
adding both options made the most sense based on the feedback.

So in patches 3 and 4, we add both `path.<field>.absolute` and
`path.<field>.relative` for `gitdir` and `commondir`. Initially,
it was proposed by Ayush to use `path.absolute.<field>`, but
this would break the lexicographical order of the internal field
array. I tweaked it to place the variant at the end as a suffix instead.

There are still a few open questions that should be addressed
by the community. I am tagging members who were involved in the
previous discussions:

Justin Tobler, Lucas Seiki Oshiro, Junio, Phillip Wood,
brian m. carlson, and Ayush Jha.

Apologies if I missed anyone; I included everyone who reviewed
or participated in the discussions of Eslam's and Lucas's
patches.

Questions:

1. Should there still be a --path-format flag?
2. Should we consider a default option?
   Currently we have path.gitdir.absolute; should we consider
   an option where a plain path.gitdir returns some default?
   If yes:
     2.1 Should we keep the default the same as rev-parse? Or
         should either relative or absolute be the default?
     2.2 When printing using --all, should the default be
         printed, or should we print both absolute and
         relative?
3. Is printing both absolute and relative in a single call
   using --all acceptable?
   If no:
     3.1 What's a better approach?

I have discussed these changes with both Justin and Lucas
internally. This series is presented to gather opinions from the
wider community before moving forward.

K Jayatheerth (4):
  path: add strbuf_add_path for formatting paths
  rev-parse: use strbuf_add_path for path formatting
  repo: add path.gitdir with absolute and relative suffix formatting
  repo: add path.commondir with absolute and relative suffix formatting

 Documentation/git-repo.adoc |  15 ++++++
 builtin/repo.c              |  50 ++++++++++++++++++
 builtin/rev-parse.c         | 100 ++++++++----------------------------
 path.c                      |  58 +++++++++++++++++++++
 path.h                      |  16 ++++++
 t/t1900-repo-info.sh        |  32 ++++++++++++
 6 files changed, 192 insertions(+), 79 deletions(-)

-- 
2.54.0
