Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4622FAC14
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140407; cv=none; b=lt8GiLZuL3vNgvPUs49z5eTAJ8tba2YJkdvP2lrYKauwl+qk6a0hPcSYZYQB1CWqNb5t7hV4cnBA0eS3/g1SmX2LvKwWkCWqu9Z8NZ7FObr3ZQfA6oAoIZPk5Ss5nQKuz3cSFQBSSdZsX7uiaCiA3Mn/fxdZ1exYEIZXSllTPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140407; c=relaxed/simple;
	bh=p2GVdyJ4z1G13wGB3W1/eLKHEBVQhMNABgC0Zqi/yHE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=bNbyA35lf1Wa90g5nmAKthpvRx9Ypz4atocpSuG7jBcuRpeRsI2S18XmM37McBepOi0mTYqwS5EylRFC9kD7d3H/EmhKpN1yf+K8XoliD/wyykZ9XknvDetvz1PExaHtxtYaoz4q5dGpI25eW1dyzZRDQnkisqv3M8y6pbTT7O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgcxtMUX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgcxtMUX"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cfc085395fso87890985a.2
        for <git@vger.kernel.org>; Thu, 02 Apr 2026 07:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775140404; x=1775745204; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qQHDTY4OILi3gEQAIsmfqxvqCqNyYcNyqqKfjqRcG8Q=;
        b=fgcxtMUXwRr07dVfOZgaLCGSnznvMLjrZLoZG6buoRIayp/LNpwuZuhtG/+rnvph0f
         5I3ESYRk5KfY4ygoFP4ICuAG+G7opsIgh4+L34CBroUScG7kbqnRA6G9e8qoJ07k+EF2
         oWIDaH1MgQAn49iweJ+kq4Og2XrytBq2oI0rXtH1tcM5FEG6zl1oys/p3O5v/hvMWA77
         5w6BYiCEOya5zvUduop1edQr1JluH6o9DogewrdqWRQK10ouUPqGRpdn2Q06eDD+W3bK
         ciiI1wMF+2/K2n0G/th+zP1+J3ZbDVVq/cueU/bta6Zfa9oWhw0b1eUNEsGbBLbcy5Pm
         aZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775140404; x=1775745204;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQHDTY4OILi3gEQAIsmfqxvqCqNyYcNyqqKfjqRcG8Q=;
        b=oBHQoa72JVAIQ2J9ofcQCdGOVn4JKhdP3UvsgP+TOHxtC6GaU6KCcd6sNdKYLxgFAS
         TDOUzdUonTwEPCZGzLk8R8WcxRvR0eKyoh8X5NC73pCeKh3cXOSP2SVLeEMHDp+8a1HG
         Hlv7zx/gVfmK5w7guk3WmI8WHbK8VdsQAyy81yJ4dvz2yPz56aJF0+CnAfEMKM38Lt5D
         edr2fUujznreORSFpLf4nhB3l5pqhGEDZ8IE7hlY1Ki/ytx+ELTPNjYiSCcxE+zKCcTw
         bKIY9XkSHTB1uUrrsOFg3dKXmQjzCfPQzxPlA3nYsM9JookKFvSrybTDqCejtHnreQC+
         MliA==
X-Gm-Message-State: AOJu0YyXlNwLF50ZoftzwV473apSL8DFGzSVhXLQjSOGEivMpf0vzA40
	l/cHAxKVwWgq5wbEuqbT8ayNkGHsYkAZ7cgr8W1OT0IA81gYviYs9ufmBPFXQw==
X-Gm-Gg: ATEYQzxYeajv+0Cvhlb2WycdU+R15NGQSgyQauaD1q3ka4jiP20g4YTqbH0ZveYIqF0
	w1VUmjIQcd1nAqeBEZ1LaOTSpoG9DyNn8YFGNTV61XNruCPfSXcSlixmfk8VOlR9dqkZuwDfqzU
	PoO6n3wRfsvcjhTesiQtbL1pPkFhxgQCqVfZReuk/Neie9YLg72kBl6SSEUNRoy6S4ZPEBFgQ3A
	HaVp6bLb0eHF8puvhG08Cs0I6SqZeVfmRsORe5KtAbWeOnhVYWswwI5MRpNy12JoZh2zf2R8QV0
	0RyuNpokD58BY9nwMqE2QxwOOF00Kf76luK+jPrSh6UyLLvNSmaCkvrD/KfpccYNAc9pVRPccqW
	eWrQGmJy9gCELz+AmRjEz+lk5zP5EQ0/QghYjrArP384nWUwWo72LOGUxTrDhJTF3Ml8e0bMLfC
	+p3bsi1Yp0E2iVqo0J7mBxVfNWvzqEctE380jLNw==
X-Received: by 2002:a05:620a:298e:b0:8cd:9060:522f with SMTP id af79cd13be357-8d1b5bce9a2mr1159637985a.56.1775140404408;
        Thu, 02 Apr 2026 07:33:24 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.114])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5393a07sm228222085a.4.2026.04.02.07.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:33:23 -0700 (PDT)
Message-Id: <pull.2076.git.1775140403.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 02 Apr 2026 14:33:06 +0000
Subject: [PATCH 00/17] tests: access bare repositories explicitly
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

The safe.bareRepository configuration variable (introduced in 8d1a7448206e)
allows restricting implicit bare repository discovery. Its default may well
change to "explicit" in Git v3.0, at which point any test that relies on
implicit discovery of a bare repository would break, even if the test
subject has nothing to do with bare repositories.

This series adjusts 16 test scripts and git-p4 so that they access bare
repositories explicitly. The techniques used are:

 * Replace git -C <bare-repo> ... with git --git-dir=<bare-repo> ...
 * Export GIT_DIR=. after cd-ing into a bare repository
 * Wrap commands in (GIT_DIR=<path> && export GIT_DIR && ...)
 * Add test_config_global safe.bareRepository all in the few tests where
   implicit discovery is genuinely part of what is being tested

Each commit is a self-contained fix to one test file (or a small related
group).

This patch series is part of https://github.com/gitgitgadget/git/pull/2072.

Johannes Schindelin (17):
  t0001: allow implicit bare repo discovery for aliased-command test
  t0001: replace `cd`+`git` with `git --git-dir` in `check_config`
  t0003: use `--git-dir` for bare repo attribute tests
  t0056: allow implicit bare repo discovery for `-C` work-tree tests
  t1020: use `--git-dir` instead of subshell for bare repo
  t1900: avoid using `-C <dir>` for a bare repository
  t2400: explicitly specify bare repo for `git worktree add`
  t2406: use `--git-dir=.` for bare repository worktree repair
  t5503: avoid discovering a bare repository
  t5505: export `GIT_DIR` after `git init --bare`
  t5509: specify bare repository path explicitly
  t5540/t5541: avoid accessing a bare repository via `-C <dir>`
  t5619: wrap `test_commit_bulk` in `GIT_DIR` subshell for bare repo
  t6020: use `-C` for worktree, `--git-dir` for bare repository
  t9210: pass `safe.bareRepository=all` to `scalar register`
  t9700: stop relying on implicit bare repo discovery
  git p4 clone --bare: need to be explicit about the gitdir

 git-p4.py                                  |  1 +
 t/lib-httpd.sh                             | 12 ++--
 t/t0001-init.sh                            |  5 +-
 t/t0003-attributes.sh                      | 66 +++++++++-------------
 t/t0056-git-C.sh                           |  2 +
 t/t1020-subdirectory.sh                    |  5 +-
 t/t1900-repo-info.sh                       |  7 ++-
 t/t2400-worktree-add.sh                    | 21 +++----
 t/t2406-worktree-repair.sh                 |  2 +-
 t/t5503-tagfollow.sh                       | 13 ++---
 t/t5505-remote.sh                          |  4 +-
 t/t5509-fetch-push-namespaces.sh           | 12 ++--
 t/t5619-clone-local-ambiguous-transport.sh |  2 +-
 t/t6020-bundle-misc.sh                     |  4 +-
 t/t9210-scalar.sh                          |  2 +-
 t/t9700/test.pl                            |  9 ++-
 16 files changed, 74 insertions(+), 93 deletions(-)


base-commit: cf2139f8e1680b076e115bc0b349e369b4b0ecc4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2076%2Fdscho%2Ftests-explicit-bare-repo-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2076/dscho/tests-explicit-bare-repo-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2076
-- 
gitgitgadget
