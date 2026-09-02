Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1BD377A96
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365477; cv=none; b=qZfssUEO5mOYX+fac3C2/X33l+GQzAYcnal/W5l/6+0HCl6yb/HOCZi/8RnQHTbXG825zRTILTRTKhGh4Sf1BxufpbWF5aYPvEmXdnQJLT5ZyT4zrBOfEkiWeKI6Gs7k9Z4SZzleC0uelOY2Vj/b/zeyiq0rcGBLb8Ap6rd8rok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365477; c=relaxed/simple;
	bh=ayV6jEelyqdpxQ5+MsYcLAjcWHpXX7/zef5hcc+Qky4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnTgm9kAEVWRn7Msol2faEnqIK+S0rlLvlgjzPXCaeFkHLZ5DohhkI07Ktwy+OTY3qUp95JV27hTEIeMmZC2A6ZcG1dxpr+9/F4JF9euISP8iOO/5nX1hpzhyHuOeN3+gJwwYP0WE1fUM+0ZYqtYa7dL6T1as0v8TB3AgOK9GqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcH0j62D; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcH0j62D"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49954b88fffso9478575e9.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365474; x=1788970274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tAeYfVwMCDaNTlw8HGeAEyWq8EuCGwZU4D/ve9RUGGQ=;
        b=NcH0j62DxwwgXgjuR/colZYRKEYG8ahulKOSzb1Du9/IBUhWu85Npc9+MPHzXXj31J
         niXYxuEV5bIqg3gJAl6uAK5iCrXyhKtaAUUh2gH2LTSLI9pv/wMM7JRqjAYZNJLaDSfH
         EWpVsrUcuA7/hVwve1UOg8btn9L2yzYKM44KGgTyeFpZHhusNkwAkV5lsKACZDgIEI9W
         lNBheoUa1B8MZiHIPWRvJNPI5c4zdV2Y0o2IvMxJfexu4S+YXFCCUKUKRAIvVh2sASI7
         9yRnDa7iIWVPdsKNOqLEFD/1JshxSYSAFzmbUoovNxBMSZBvh4Iz5hQSzJkfiV5RGznY
         9tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365474; x=1788970274;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tAeYfVwMCDaNTlw8HGeAEyWq8EuCGwZU4D/ve9RUGGQ=;
        b=iZ1uR2+SYKgDY4oe2Rl7UzZ91JLDTJubaeYal6x/myOgmxlWNsKSslpMUl0o8aozd9
         cgBtt6n8y7PdojFBY5siYIAhAiVQpl+xb2s4RwotQMLk5Duxtn32huYg2J+BUPviYYWt
         CVIPfkf7TeRSXPyAbWo2OxllUuui9StRwZQadDLmW2VXDCwGSwj33ZsAVZ8s18VuaUP4
         GwwSBAk68MgWqBmOIPYbWSgFXHJouxYejfYgBncb/UpuGlqfhPTn+fIP2g3CGGNpcwDG
         cWPhR9/XMr2O1rFU+Jfic5uvQpxusYSXZKa2K8JhAYvnbogpr3eunygM/97VKZgAy3BE
         hMxg==
X-Gm-Message-State: AFuF++kmUYqQ2DMOkHsYMvRIBhkmXNQ0YRAta9wuio0WONje0tmpPd65
	ApGIx+ohWpgH/RnBgl9DSWov35z9FYl0IynpgJfICDAaPuTXn4Ji3f8VSyOaUezi
X-Gm-Gg: AR+sD12gOs6eGeqzpAFRzypBTgsZD65/CJlrJKYPaKEaNVCKo9FeJ0hq7Alyd5wcxPx
	lIPpI2iJjvJDg0sJ0cwFiKTTt3KDPIQJWSyDfzcXQwfTLfm0V3Yb8Lr7a6zGkXhKirYpXLtEN91
	rcKAxi62rghvfWoA0dprBSeHhy3w+XmkjFUOYIhfOgYsC7hM3/9j8PkCpMiD4si4aVnDiUHEocE
	98sur78b3dWaw1YxHLNZbvFgWVKbL45FxpoRoAf+8JrLVDr8Y5xmbXHljvcVZdFUAPqtxANjxPO
	VwpHow6bxiH2gfx413e4M0N8Fvdpz+8zGzH9aAvxjTMHRC9yJNJ3pfg0Dp9MdMr43IweSWso7Up
	nKXIIaUIAY7AequAaJXR+IxhmijVXacaRU0trFbBbpqfxjD8/YXXVkpMaeqDjsfyAejpur4jnSd
	vFTYxAdZsJKEBEjJ+LFAqHJYAtToNXRHEjpHBOS3Vy4zy6NmI4JpoyjNE2kwpFYDr+csVqCcIL2
	WIr+czqmN+t7d91jnKMI+AoL/Wkz0SgUCvcXQqj0/B2dl43LxYAWmQZ/MLiP7lb5D8Pp9BH3/3g
	WyDJE+K/OaPbwRs8y8FNFv0seogbjedc4ZGtBHzK6QM2K4LS9abWrjxURV+AqvNsvgCfy0KAFUA
	=
X-Received: by 2002:a05:600c:3587:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ce583bc25mr105076875e9.16.1788365473422;
        Wed, 02 Sep 2026 09:11:13 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:10 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/6] Standardize early option scanning to fix argument parsing bugs
Date: Wed,  2 Sep 2026 18:10:41 +0200
Message-ID: <20260902161047.476753-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A number of commands perform an early scan of their arguments to look
for specific flags or structural separators (like `--`).

These hand-rolled early scans are often fragile. They especially fail
to account for options that take their value as a separate
argument. This leads to disagreements between the early scan and the
actual parse_options() pass. For example, the early scanner might miss
a special option entirely, or mistakenly treat an option's value as
the `--` path separator.

To allow these commands to safely skip option values during their
early scans, this series introduces a new "early-scan" sub-API into
the existing "parse-options" API.

This is deliberately implemented as a new simple and fast scan, which
has some limitations, instead of a full refactor and reuse of the
parse_options() code, because the limitations are not very significant
in practice, while a full refactor and reuse of the parse_options()
code would be much more complex.

The current limitations of the new early scan code are:

 1. short options are ignored,

 2. options with PARSE_OPT_LASTARG_DEFAULT or PARSE_OPT_OPTARG are
 treated as not taking a separate value,

 3. negated options ("--no-...") are not automatically generated,

 4. abbreviated options will not be matched.

Note that while the others could be real issues for some commands,
"3. negated options" is not a practical issue because negated options
never consume a separate argument.

The early scan is performed by a new early_scan_options() function
which takes a `const struct early_scan_option *options` array as
argument. That array can be built either by hand or by a new
early_scan_options_from_options() function, which takes a
`const struct option *options` array, when the command already uses
`struct option`.

This allows us to use the new early-scan API even for commands that
don't use the parse-options API yet, and which are the majority of
commands performing an early scan.

In this series, only `git bisect`, `git rev-parse` and `git
fast-import` are converted to the early-scan API, which fixes bugs in
those commands:

 - `git bisect start --term-good -- <not-a-rev>` mistook the term name
   `--` for the revision/path separator, so <not-a-rev> was rejected
   as an invalid revision instead of being treated as a path.

 - `git rev-parse --default -- <not-a-rev>` did the same, reporting
   "bad revision <notarev>" while any other default value gives the
   usual more helpful "ambiguous argument" error.

 - `git fast-import --depth 5 --allow-unsafe-features` silently
   ignored `--allow-unsafe-features`, refusing unsafe features from
   the stream.

All of these commands call parse_options(), but for `git bisect` and
`git rev-parse`, the specific functions doing the early scan
(bisect_start() and cmd_rev_parse()'s main loop) parse their own
options by hand after the early scan and have no `struct option` array
for those options.

If bisect_start() and cmd_rev_parse() were converted to use
`struct option`, they could use early_scan_options_from_options() and
would not be affected by limitations 1), 2) and 3) above, as both use
the early scan only to locate `--`.

Note that using early_scan_options_from_options() rather than a
hand-written table does not change how abbreviations are handled: the
scan matches long names exactly either way. Limitation 4) would
nevertheless become relevant to those commands, because such a
conversion would also make parse_options() the parser for the options
after the early scan has first inspected them, and parse_options()
resolves abbreviations while their current hand-rolled loops do not.

`git diff`, `git column`, `git rev-list` and setup_revisions() in
"revision.c" could also be converted to the early-scan API but aren't
in this series for different reasons:

 - `git diff` has a number of short options like `-S`, `-G`, `-O`
   taking separate values.

 - `git column` scans `argv[1]` for `--command=` before reading the
   configuration. Because `--command` is an OPT_STRING,
   parse_options() also accepts `--command <name>` and abbreviations,
   so the two passes disagree. Converting it would fix that, but it
   changes user-visible behaviour in a command this series does not
   otherwise touch.

 - `git rev-list` and "revision.c" are about converting
   setup_revisions(), but converting it to `struct option` first is
   likely the better way forward.

Overview of the patches:
========================

 - Patch 1/6 introduces early_scan_options(), the early scanner that
   will be used instead of hand-rolled ones, along with its
   infrastructure.

 - Patches 2/6 and 3/6 use this scanner to fix bugs in `git bisect`
   and `git rev-parse` respectively.

 - Patch 4/6 refactors some existing code into a new
   parse_options_takes_argument() helper that will be used in the next
   patch.

 - Patch 5/6 introduces the new early_scan_options_from_options() as a
   bridge between the parse-options API and the early-scan API.

 - Patch 6/6 uses early_scan_options_from_options() to fix the early
   scan for `--allow-unsafe-features` in `git fast-import`.

CI tests:
=========

They all pass, see:

https://github.com/chriscool/git/actions/runs/33612974808


Christian Couder (6):
  parse-options: add early_scan_options()
  bisect: fix "--" detection when a term name is "--"
  rev-parse: fix "--" detection when it is an option value
  parse-options: add parse_options_takes_argument()
  parse-options: build early scan options from a struct option array
  fast-import: use early_scan_options() for --allow-unsafe-features

 Documentation/git-fast-import.adoc |  10 +-
 builtin/bisect.c                   |  27 ++++--
 builtin/fast-import.c              |  46 +++++----
 builtin/rev-parse.c                |  26 ++++--
 parse-options.c                    | 144 ++++++++++++++++++++++++++---
 parse-options.h                    |  92 ++++++++++++++++++
 t/helper/test-parse-options.c      |  71 ++++++++++++++
 t/helper/test-tool.c               |   2 +
 t/helper/test-tool.h               |   2 +
 t/t0040-parse-options.sh           | 103 +++++++++++++++++++++
 t/t1500-rev-parse.sh               |   5 +
 t/t6030-bisect-porcelain.sh        |   8 ++
 t/t9300-fast-import.sh             |  14 +++
 13 files changed, 503 insertions(+), 47 deletions(-)

-- 
2.55.0.787.g3f9e2241eb.dirty

