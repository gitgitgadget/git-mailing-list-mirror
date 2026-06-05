Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765433F0AB7
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685374; cv=none; b=e6uvNE3PdqiL/7lR/K9yyKN7r9WuE7saAF5dDiVOa4RGy2aV6gD00y9QBq7gRtXo5nD5LAIv+y1aXbhQFtzTGP/AfrS/mo6uE+8q/NbtBhHn4DyGFfMfNs/kn4H3aiyA9azS+IvD57m4ox34DW5SRa9SakS+rhiPH0UxRyHkD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685374; c=relaxed/simple;
	bh=MF+0MBt6+XVGE1DjxCOw4bbhbcS36pRWQlwX0Kaoe7s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=tBIzHYyzTl4nawa1P3+W//mYUeIO1TD1YoilgjGXB1kAJsm4LNWpRlF1U1HlXqtY3hPzlPGq2vFLG+yqTugqXB50YdBfjzJ9yEJq43vFioMzdxA/7OigapCTKaMdFL8G3kvsKmL41ZR1uBZMku9VBbPnB9IV2S6bd8VkpCbE+r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXLNHfol; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXLNHfol"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ced8f44da0so23560096d6.2
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 11:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685369; x=1781290169; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4qVO2Lb1IruPPuvNogcIdRlaxpDr5RNABY0mEqzSW9s=;
        b=dXLNHfolehtE/YD0JD9JM7wnQJEmcVwZbBcOQtx8eq9rGsxEvfaMzOOPI1sCEi207k
         tbvlZOhJMr5kZ2vWfaDlGy9XTeodDZv6jTRVorG5MGwh5fbqianwPIHG0NJWrn4r6N8u
         xxz2N1sVnzZBXzilqtVzAPY63ZJaIIJRAcXUhYVMhSWorT8RqgQogsthHRPLofH92W1A
         yAfkzSZ3wc1OP5NtD6DKYlDdF4ywYNtHWetfM+mUsdAYi6YHvnQ6Ou9rr6oIt7mjNWqo
         f8epkp2RzCNnSduer6twDSNI+wIaZPx7qwFScRiNnt8+z8B3tVN3wZesZp4JdPIOTvi4
         PYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685369; x=1781290169;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qVO2Lb1IruPPuvNogcIdRlaxpDr5RNABY0mEqzSW9s=;
        b=mA5JcfTZGqJFumfEwls9qLqRRfJiJboy3S66rxNdHOWp6cNt/3kFMIF96FidL6Abm3
         AFsiIi+HLAOM7wFuXRRqLTXyCo22PEOp8DnwWOadRdEzFzT+g1PpCcDwFKmqughTV5zq
         oBhG+uXPjk/3MCOMhUQR/FKfUkdYRyzUTcASCOnE9zzA7I7Nw5z1LGPwbK7LFf5Q6K1I
         rzXWjdnP4tfQp3jbmNtxKlV1h4Ygw8vrFKtb2C750mD6gYn4rds6owI2kcmQf8uiXjLF
         HmNkJR31xcIAwKXGsw+AGNhS7wJV+s3Aq62IxETrOHuxwoX0AoZ8HQIDalI29Leu+FMY
         dkmw==
X-Gm-Message-State: AOJu0YwWx0Mm/Du5u4pFWWoEIt/fZ+PiDBtoATkzMUYJdC94OINOz496
	hYUfJBSJ0wn7yJCOra1P7o5lQzGEAIFPqARpFkRUjmb8Qrl8gW24PHuzK8uAVw==
X-Gm-Gg: Acq92OEUFajeyK6zaHxyHPMPmH6pOKXdConV61GY5T7LyeBXbS0NbK6tRmPizH+Klon
	X2hhKcAfF+1IhJZzfsp16ISDG2IHlguCQWqQMNA7q293pOX4PplSBavpuz58iUkq33nLQ9TzTHf
	nayET1pWOJ8wXfb893RhzEkvcNxJhYoFZY2kxReMdLf01UZrG0tqQqY56Qvf8uVIhP2qqXGzLy0
	n2X4go4eAKlZE4kWlRRg0Mm99+gO5t8W5UAtjHa8r2AJg3M5AuyNRsce81vbwgyFIMSlQdnLWvE
	aBXhOo5/zIF4e9VifOJVjoOBW9ziw73C55SgUuxuTC65COjR/O81OocZgE3vIE4lg2iAStFsegE
	qkP5HqpPY/w6g6Z9/6ibm46ouoJ8qAcuFtGLN2dPrpqEYVGBYR83n1ZtcTu22I/0hFlCojgtQ0D
	+nuagqZrQMegW8ij1C4RIkTiqoZM4YC+YoYwBf
X-Received: by 2002:a05:620a:7083:b0:915:9125:e65b with SMTP id af79cd13be357-915a9dce7b6mr854886185a.49.1780685369264;
        Fri, 05 Jun 2026 11:49:29 -0700 (PDT)
Received: from [127.0.0.1] ([74.235.126.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a381febsm943957685a.23.2026.06.05.11.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:49:28 -0700 (PDT)
Message-Id: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 05 Jun 2026 18:49:26 +0000
Subject: [PATCH 0/2] worktree: copy-on-write creation and shared-branch worktrees
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
Cc: Jason Newton <nevion@gmail.com>

When many worktrees share one repository -- e .g. a fleet of agents each
needing an isolated checkout -- "git worktree add" is costly at scale.
Objects are shared via the common dir, but the working tree is not: each add
rewrites every tracked file, so N worktrees cost N full checkouts of disk
and I/O. And a branch can only be checked out in one worktree.

Patch 1 adds "git worktree add --reflink": on a copy-on-write filesystem it
populates the new worktree by reflinking the current worktree's files and
index, then "git reset --hard" rewrites only the paths that differ from . A
reflink_file() helper in copy.c uses FICLONE (Linux) and clonefile()
(macOS); elsewhere (other filesystems, Windows) it is probed up front and
falls back to a normal checkout. Defaulting is via the worktree.reflink
config (true/false/auto); --no-reflink overrides.

Patch 2 lets a branch be checked out in several worktrees, for parallel work
on one checkout. A branch mid-rebase or mid-bisect elsewhere is still
refused.

Benchmark (Linux-kernel fork, 93k files, ~33 GB tree incl. build output,
btrfs): a normal add allocates ~0.9 GB of real disk per worktree (~5.3 GB
for four, linear); --reflink allocates ~0 at any count and also carries the
untracked build tree. ("Real disk" = btrfs exclusive bytes.)

worktree-reflink-bench
[https://github.com/user-attachments/assets/e3e721c8-2206-4b78-ad08-21677ef30753]

Note: patch 2 changes a default (same-branch checkout now allowed); two
t2400 assertions were updated accordingly.

Jason Newton (2):
  worktree: add --reflink for copy-on-write worktree creation
  worktree: allow sharing a checked-out branch across worktrees

 Documentation/config/worktree.adoc |  10 ++
 Documentation/git-worktree.adoc    |  47 +++++-
 builtin/worktree.c                 | 257 ++++++++++++++++++++++++++++-
 copy.c                             |  65 ++++++++
 copy.h                             |  13 ++
 t/t2400-worktree-add.sh            | 119 ++++++++++++-
 6 files changed, 493 insertions(+), 18 deletions(-)


base-commit: c69baaf57ba26cf117c2b6793802877f19738b0d
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2317%2Fnevion%2Fworktree-reflink-cow-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2317/nevion/worktree-reflink-cow-v1
Pull-Request: https://github.com/git/git/pull/2317
-- 
gitgitgadget
