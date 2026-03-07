Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B40204F93
	for <git@vger.kernel.org>; Sat,  7 Mar 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772845342; cv=none; b=nalUT3P+6//PgFkPp1flhSEzf7wSo8TmimV9LZ70PakEYUb0V0AU22ZrNELEEIYyWKM6kZk0ZAwnGdrfoJwE3HRJtc4PJivohiZ4wATouEsfMr/2jZp1govoy+zkjZa61TYaevgx4uxqkO6KrIXishLqf139xJjkt/UeHvYm288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772845342; c=relaxed/simple;
	bh=4kP57Rq9pVkYBnVnR4qX5UuW/yEQi6A6WByPS6grll0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=QbYURV2i/1gksbkiKA995Qms82wCqgkRs0BSQvhrzqh8oSgBn5Zp5htPEVgnuzDWY9KXfTehrGCHusP8J5rgBGhM2/SQWRYvXkzN4GZnZed7pkZmo8rSFg72dfeRXgUlHVNXM9OzWTkGwmLAIqchtk+YyJuPdf/5qnK0jhqOwa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5g4aMQZ; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5g4aMQZ"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4648447e29bso3890331b6e.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 17:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772845340; x=1773450140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eDiO2zRsyamit2sqWC3iu8kkTvAIp5Yzjs5q9beMnjg=;
        b=b5g4aMQZdjJFCSzAPwl8BXq7nyECA2rRw7Cytm+TK+crwLPEWZB1Mk9ARD2B+Duyw/
         gc0iZm4mfkFyENRhlZnJ/Cp6rk6/qqu97CxgSh8DXCsPNXE+/2PHosAUd6fmiMWf9Vf2
         IqJ+zaXKN/UlJKScBhHP7yMUbH1DQa27pMNcZw7CfDMFDamO7ZBlxPnvoTuRiH+E/whN
         y5Monu5o83sT8NHdY/6tTU+2McPCz99mUaYKJNJ2TNbx9LnuJ8eVYGZhLdcKCdPrsn9Y
         MHgULNgVJ7CGBh5vuDgQaLuOzWACWTfVTIuSiNvwquPxicp80OBF5tlFVTRJx/mQArRf
         cGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772845340; x=1773450140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDiO2zRsyamit2sqWC3iu8kkTvAIp5Yzjs5q9beMnjg=;
        b=rz7qxb9OzMEE0ExAk3T/V1871+UVnDq/k5Ffy16RPrfUD7nU9YXHs5Hw4hYVhpP9iB
         /Xq9wldRv8aKi+PHLY7hGKmksjrv28fIx4zH7T0Z506mltxsk1H5meeL2n5MT+PYnk4d
         4slweuPN+ar62rCpra2QhYPb2gfGdRS//tFnHADdqu1qj2lr6UvuoZ8cLOcsOXfMur2P
         Okzia0DnQ55QDTD5aCMxuBPySrujrM7XnAS5SyGvVGWgFxV5v/81qU7NJ3+ins8KLQib
         KPDzRHBD7fVqZNmhh0zVD2ewQ46OsXcaVwg+89kLHcfTX/QI3sImtz8G4c+Acg8M9ajA
         bFXQ==
X-Gm-Message-State: AOJu0YzlNAM60KxCVf2hBg40lzju3XH17/O/i0u8Mqoqgzpoa+AaRyer
	9/LIkAn379vq7Xd2hhu6Lo+MbXg0+4mjvtHsglU1x3pOxF8HGjJKWQZWoPI9WA==
X-Gm-Gg: ATEYQzye97E8E+jzOEOM+9FLl1upHmoHHR+wDJ17+GUh5SQWHS/0ibCD27Vdw1wluVW
	CdZl++PrAceGHaakOnxfaUqWrly4s84QTlwMwOacrmZITmVZBrczmhDb6Ps7Jfr3AGDH3V6LZf9
	Rwkivy7AYDwvkQg3UU5okdMpwfmt8zMZ1fr24FvNQpaawyzm83pa08/y8X7waBfJNiVrbpYONod
	TgeclNUjp6cD/8dCjz7M5BItbmzg9r+P9+L1eKIr3tHFzpH7dvcmI7lzUXbpalI5KQoYfeyn7sG
	jHwFaqL8fMKlOaHYJa+gsqXNWnubQ40ftiTPKoW6FZz8Y67SeF1HN+ahqc3ZkWFAh4xmW1SIUo6
	54hXQYLZOW3bSDS1MKTXDHlVIPvA4ZU8Rfp9fJ7SbSgjzV1Omuyy6dBhkEM1tcS95yLnsjyxrvI
	Ups2pmQPYGxxd6G0+3yMpjl1EthLRCLoMLezvSAA==
X-Received: by 2002:a05:6808:2228:b0:45c:9b88:d368 with SMTP id 5614622812f47-466dcbadd86mr2125258b6e.39.1772845339656;
        Fri, 06 Mar 2026 17:02:19 -0800 (PST)
Received: from [127.0.0.1] ([172.212.169.147])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466df93ce67sm1723033b6e.1.2026.03.06.17.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 17:02:19 -0800 (PST)
Message-Id: <pull.2065.git.1772845338.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 07 Mar 2026 01:02:14 +0000
Subject: [PATCH 0/4] line-log: route -L output through the standard diff pipeline
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
Cc: Michael Montalbo <mmontalbo@gmail.com>

git log -L has bypassed the standard diff pipeline since its introduction,
using dump_diff_hacky() to hand-roll diff output. A NEEDSWORK comment has
acknowledged this from the start. This series removes dump_diff_hacky() and
routes -L output through builtin_diff() / fn_out_consume(), so that diff
formatting options like --word-diff, --color-moved, -w, and pickaxe options
(-S, -G) work with -L.

This replaces my earlier series "line-log: fix -L with pickaxe options" [1].
Patch 1 is the crash fix from that series (unchanged). Patch 2/2 from that
series (rejecting -S/-G) is dropped because this series makes those options
work instead of rejecting them.

[1]
https://lore.kernel.org/git/pull.2061.git.1772651484.gitgitgadget@gmail.com/

Patch 1 fixes a crash when combining -L with pickaxe options and a rename.

Patch 2 is the core change: callback wrappers filter xdiff's output to
tracked line ranges, and line ranges are carried on diff_filepair so each
file's ranges travel with its filepair through the pipeline. diffcore_std()
runs at output time, so pickaxe, --orderfile, and --diff-filter also work.

Patch 3 adds tests covering the newly-working options.

Patch 4 updates documentation.

User-visible output change: -L output now includes index lines, new file
mode headers, and funcname context in @@ headers that were previously
missing. Tools parsing -L output may need to handle these additional lines.

Known limitations not addressed in this series:

 * line_log_print() still calls show_log() and diff_flush() directly,
   bypassing log_tree_diff_flush(). The early return in log_tree_commit()
   (and its associated NEEDSWORK about no_free not being restored) is
   pre-existing. Restructuring -L to flow through log_tree_diff_flush() is a
   larger change that would affect separator and header logic; it is left
   for a follow-up.

 * Non-patch diff formats (--raw, --numstat, --stat, etc.) remain
   unimplemented for -L.

Michael Montalbo (4): line-log: fix crash when combined with pickaxe options
line-log: route -L output through the standard diff pipeline t4211: add
tests for -L with standard diff options doc: note that -L supports patch
formatting and pickaxe options

Michael Montalbo (4):
  line-log: fix crash when combined with pickaxe options
  line-log: route -L output through the standard diff pipeline
  t4211: add tests for -L with standard diff options
  doc: note that -L supports patch formatting and pickaxe options

 Documentation/line-range-options.adoc         |   4 +
 diff.c                                        | 279 +++++++++++++-
 diffcore.h                                    |  16 +
 line-log.c                                    | 196 ++--------
 line-log.h                                    |  14 +-
 revision.c                                    |   2 +
 t/t4211-line-log.sh                           | 342 +++++++++++++++++-
 t/t4211/sha1/expect.beginning-of-file         |   4 +
 t/t4211/sha1/expect.end-of-file               |  11 +-
 t/t4211/sha1/expect.move-support-f            |   5 +
 t/t4211/sha1/expect.multiple                  |  10 +-
 t/t4211/sha1/expect.multiple-overlapping      |   7 +
 t/t4211/sha1/expect.multiple-superset         |   7 +
 t/t4211/sha1/expect.no-assertion-error        |  12 +-
 t/t4211/sha1/expect.parallel-change-f-to-main |   7 +
 t/t4211/sha1/expect.simple-f                  |   4 +
 t/t4211/sha1/expect.simple-f-to-main          |   5 +
 t/t4211/sha1/expect.simple-main               |  11 +-
 t/t4211/sha1/expect.simple-main-to-end        |  11 +-
 t/t4211/sha1/expect.two-ranges                |  10 +-
 t/t4211/sha1/expect.vanishes-early            |  10 +-
 t/t4211/sha256/expect.beginning-of-file       |   4 +
 t/t4211/sha256/expect.end-of-file             |  11 +-
 t/t4211/sha256/expect.move-support-f          |   5 +
 t/t4211/sha256/expect.multiple                |  10 +-
 t/t4211/sha256/expect.multiple-overlapping    |   7 +
 t/t4211/sha256/expect.multiple-superset       |   7 +
 t/t4211/sha256/expect.no-assertion-error      |  12 +-
 .../sha256/expect.parallel-change-f-to-main   |   7 +
 t/t4211/sha256/expect.simple-f                |   4 +
 t/t4211/sha256/expect.simple-f-to-main        |   5 +
 t/t4211/sha256/expect.simple-main             |  11 +-
 t/t4211/sha256/expect.simple-main-to-end      |  11 +-
 t/t4211/sha256/expect.two-ranges              |  10 +-
 t/t4211/sha256/expect.vanishes-early          |  10 +-
 35 files changed, 864 insertions(+), 217 deletions(-)


base-commit: 7b2bccb0d58d4f24705bf985de1f4612e4cf06e5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2065%2Fmmontalbo%2Fspike-xdiff-line-range-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2065/mmontalbo/spike-xdiff-line-range-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2065
-- 
gitgitgadget
