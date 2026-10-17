Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A92430794
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 07:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222359; cv=none; b=f9U7E1+u37Uhq/jdQ6VAxyNcuVtlT9+LcWFTojnALEDirkMfXi7a6Dnj9Ju01b1jWKKDw8xLWJCcRV9EATgDKDPCgwYOs07xrPVNRpCmdkJoKL3EoabFcafNUBupCDe+nktvhT9gAoZS/Pd/i21jOZ2lm5ZwUmm2MCf+JHSDWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222359; c=relaxed/simple;
	bh=NvKECzAlZ9nRQOFmS0/2xLzYY9V47+QuazArTvjkgHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtEGVjg/S+Ot0LCc7/2jj/4RGpaKqsLMBHW8dQq9bxa3YJ25RtWeFzMN4zEr2fSN6BfjkjT349xeKyM+sfH/nBOpUXA5vLMtCxkyXvjp8O2yRnhlPT2tpAGY4iliETLzST2/9ICATOkqpMpCCyBJVbTxjTrBt1GGbS/WxxSU1ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTH5QEoO; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTH5QEoO"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e91e422859so273279e0c.2
        for <git@vger.kernel.org>; Sat, 17 Oct 2026 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792222356; x=1792827156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pb/rkbq6QpqCFvPmNYYww+NFBrwA1OgLlLEkpyKdXRU=;
        b=TTH5QEoOHTDuqFxEZaVP2+Dtjad9tU0/uJO3FBmqKrWbPNH1Kin87mS/eFmgFt5JDj
         CvAP3imEwoLD3NqVLmOzyR/N38N2mO5gYaPOiTsoFDKeGJN1Ec7amKyYlEmAXqlxkxfu
         vDYgzHwWni4/YQYbRWa1CikS50gOulpoQ/be70+J/9mnlbKcRlaQQ61Pxe+7+Fr0deE+
         dQOM7JnztF9JPVeK284jaZQR/x+hRABSs8gVj990dpMQMxAyd74cH+hajPpmpDW9txRV
         +dz+aYhioUyeiDl+xsT4pOJiDuMjV76CE538/DJDEPUguF7qCH8qX5uqIpbvTiTm5G9k
         u5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792222356; x=1792827156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pb/rkbq6QpqCFvPmNYYww+NFBrwA1OgLlLEkpyKdXRU=;
        b=1f1QM9NsO6ynU3h96nhgkJsJQ61f/Jp1I1RoY5uqqTKlejEWcnMj89Jrn9YdcBwL0p
         Th0xObhpVVGJte+KXWdrkor7TODu07529jolBryPZRS6OklrFZM5JfDTktd9BQOVl9U3
         +735sc9jhVYxBrT/t+hPiozoMwwQcZCPJYNhxnTLuYcSfCg/WYcdRbsfG05p+MkFFRFj
         rNPaEmSubIHSJ2x1CaDLF4Ai83aWrnzJYVDmQmc9ZDaLecX4T7P9D0l2VpI3mnqnDO4q
         WnNlnwpIy90CPvlnYQjQD1UnL1iF8H1FZ7qPC3NIyHB3MjOVAEijz83E1EEnhQTXoME5
         guNg==
X-Gm-Message-State: AFq9FYID3ZGPUwYoGsM+s56Ghu/EdfRhXkq5XeoLpIbym6zKljGm+EWF
	G22k6UQTEsSTVOJdmm978ehimaIdL6LujAuVeFdBFK4V20qzgqH0vksCOUjTbg==
X-Gm-Gg: AYBFou2qHmlmKpSPxlR42lbkau+2WG5sVtTBn3iEM5jS0FXd6sQylnldZonw+L5rAhs
	AjuR+zoZSNSDvDrebCs4ll0yzMDl56aPThiGtuneHexVidKikI7mf5i0LEuPJLyA7qMQv/kMhk0
	uqUJ28SqLWq3V2Wy9eGl/3k2AOp6ozDkyRpjetPX64KxW9Uf57ovaU8WY0rTmQpP1uX3bWhwecr
	2fPa5AqDRQXxPScPf/K83vF2Hk8YwenBq6eAEoAiieyf/ZRUixLdlxHOekQ2koG+EwQFMwvXXUa
	aSDjVq6zrFkz7gT62QUJ48xDxFz4fzR3BNUeCs4YWDrJgFE3XVKqjC3JysOSxvvX3zbJ9CdZ0on
	q1sEUF0geFLFPQVM4W0U9ZoHuwgP5/rRVuW3+bg6UoMePsLs11uQ7GipTjWf1skfE388wSFAFoJ
	e/J7bD5gBG5os5m0rwTE2KDyHFq+33dlD8qJCxdKrUUEIR0h9wp0KcT+AGrBLt8amGj1bfvHjgb
	Q2+gqVtjtEo/uqCYq3e9IzCJLKkCTH9ibYM3BzAlO3YXq5MvTzPApHnWmOGW3ZghQ==
X-Received: by 2002:a05:6102:80a5:b0:7cc:ccb:ce5a with SMTP id ada2fe7eead31-7cc36a700a1mr429352137.28.1792222356342;
        Sat, 17 Oct 2026 00:32:36 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-990835c2180sm3379305241.3.2026.10.17.00.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 00:32:35 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	peff@peff.net,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: [PATCH v2 0/4] Wait for the index lock instead of failing
Date: Sat, 17 Oct 2026 00:32:27 -0700
Message-ID: <20261017073231.3357477-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013172315.2997446-1-quark.zju@gmail.com>
References: <20261013172315.2997446-1-quark.zju@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Wu <quark@meta.com>

When another process holds the index lock, commands like "git add",
"git checkout" and "git commit" fail immediately, causing user
frustration. This series lets commands that must write the index to wait
briefly for the index lock (core.indexLockTimeout, default 1s), to be
more user friendly.

"another process that holds the index lock" is often "git status" run
periodically by an IDE, or a tool. Today, such tools have 2 choices:
- "git status": risks making "checkout", "commit" fail more often.
- "git --no-optional-locks status": because "status" no longer writes
  the refreshed stat info, "git --no-optional-locks status" will become
  slower and slower over time, assuming no other commands refresh the
  index.

This series aims for the end state that:
- Tool authors can use background "git status" just fine, and "status"
  won't become slower. They can still use "--no-optional-locks", with
  no behavior changes.
- End users can run "git commit/checkout" just fine, without seeing
  command failures due to the index lock.

Conservatively, the new wait behavior disables itself for commands with
write race (typically "read (index) -> lock -> (no reload) -> write"),
so those racy commands stay unchanged, instead of getting a larger race
window (between "read" and "lock"). This series fixes the write races
for "commit" and "reset" so the two commands, together with other
commands that already properly lock before reading, all get the new
wait behavior. The trade-off is that "commit" now lstat() the working
tree under the index lock.

Changes since v1:
- Explain details more clearly.
- New patch 1: make "git status"'s non-waiting behavior explicit.
- New patch 4: fix "reset" write race, similar to "commit".
- Patch 3 and 4: use "write race" as motivation.

Jun Wu (4):
  repository: add repo_try_hold_locked_index()
  repository: add core.indexLockTimeout
  commit: fix write race
  reset: fix write race

 Documentation/config/core.adoc |  6 +++++
 builtin/commit.c               | 11 +++------
 builtin/describe.c             |  4 ++--
 builtin/diff.c                 |  2 +-
 builtin/merge.c                |  2 +-
 builtin/rebase.c               |  2 +-
 builtin/reset.c                |  7 +++---
 repository.c                   | 33 ++++++++++++++++++++++++++
 repository.h                   | 11 +++++++++
 sequencer.c                    |  2 +-
 t/meson.build                  |  1 +
 t/t0031-lockfile-pid.sh        |  4 ++++
 t/t0032-index-lock-timeout.sh  | 42 ++++++++++++++++++++++++++++++++++
 t/t7400-submodule-basic.sh     |  1 +
 wt-status.c                    |  2 +-
 15 files changed, 112 insertions(+), 18 deletions(-)
 create mode 100755 t/t0032-index-lock-timeout.sh


base-commit: c51408889c3b372814bc20b9431c3b74d0d268eb
-- 
2.56.0

