Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E535971
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 09:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753952449; cv=none; b=gn81TmBiSFBRgbKFh7sB/CZMRDFrnIseZYvlQM6uj1KaoSdfZATSIsgDdwwLzmpqiNM3zsT4nsukUAkkxHDXOcTyvsy87wxJNIfU1tIXf8Swf3bp6E0FxiicwiTEM1vdxTMC3kLxfxegLetRhaUxMJwn+CpoXoVGNBAq5bMyJL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753952449; c=relaxed/simple;
	bh=5gyLvzXBHWaUkemWubKAVK90oy5QIrZdgQXB+pi26Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZZr1L7l37sFjWqc0/QPUDR6ihC4tvvkNuPJzvupkFwhEeV2GJg5J/LeTDuGYVAl9N5rqx4MYtCMCWqUGa05kYErw663CYM3zvsBu/U3ObCKRHi5obV0n1Nv6eNNU7PNwpYfqajLDMyR/wxcE4oZeP7T9uZz0u7oQcLUstUeDIcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/YpHuEJ; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/YpHuEJ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc68cc9e4so195313b3a.2
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753952447; x=1754557247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5I+uc0lYhXDbC/jtgMT0YGIaR57YBVfOJqaRjYfjFbE=;
        b=G/YpHuEJvaXwF/ummTv1/0HmPz/JW5Y44Vkh862lYfuxMrfmMX25Zav4YZx4F7dJkG
         zC1hLZvY/7JhM5PJGmVJKTCsMbRtI1xUiU1Ft2no/BUdR9H6ZDs/EeX/J/emm/ANYAXl
         H0gSj7InKVh39XTXluGnyTHJCaOFzO0fVT9pvBlO5yLeTJwcTiRPBKnrXwAtVUoxGH/+
         Bu6WKygaeXbaQufR9BAwCDU7W/HnFVpweYvj8OmVOSAd+wkc37yUYLLCx17hdbCPlpyi
         wW8tRveOCzbXf3nFIBATEkcrNx9KK/pf0FTwcioGy1IiFB7dz6iFeW747TH3GlwvqNgm
         449Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753952447; x=1754557247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5I+uc0lYhXDbC/jtgMT0YGIaR57YBVfOJqaRjYfjFbE=;
        b=OFvirn9kzWwt4OCm3P+cr6qa8jMxsZUoDKAf8kvHKNsvw4dWEm5uqH9elEZvx+X/N4
         LIqJo0FTawcVqW5Ci18apXFDQnbad0GF2oJ7Oe0I+TaMLLb6pPeLKnSGhwTEd0c/M4WK
         LghJzluGM3bV1hfYnX2N4eICSIW77YedOdkDaN0a+nQ0D+0mKDy3KN1GZOGp/j65VSHW
         J3F9SI1M1jtdip3XxbDOmzg896caq6qfNxa7xjFgGmMWlLGSGaY01zqbK1MIEb/Q2rzE
         c5i5zH1S/OV156vPFJxgL+TCJme6L/nJVG5+ajtLwLFbpW9tyYeVXJ2RuZ9GwRLWN8jA
         ejBw==
X-Gm-Message-State: AOJu0YycYP9QYMAxoZiiNOr2BH+HK4/haiLK0YwpqBSHFg+u7XOUHJDR
	ZXPwZs1HYZWdnUQscr6j/GSi4zTeR1tId/pIPfyihXgWkWrVUCtGDL9rqEJrPQ==
X-Gm-Gg: ASbGncvupLT/U8E8PIm0z6QQ0Yp3daG2wdOY62ALuI/PdyqyqTl8ROXdO+K+unB0njp
	HtC776H038jks517P1LjaZvJiO/q6g0DAalLvn6pzlTESh9i5tS/k5Ickg+GTuokgSKpphXVqEn
	/iriN2mvbPo2vuRMlMinTMuhbx0D7LGlA5ENZCn54OpvADVa41yL6f2esSQOavZMYQS23vexn9z
	AFCsL1DRcsw91XM5xSdAnrkCw3QldbxA3gO3DsAmRvD78JMrOZ39krbi8W2UpLsTUcw4U2nYHHW
	xZfX/cIzMd8ScaBw8eewwHchvfAEB+5t2+tt3twEvmTmt94MjlquAVjVrXcM6BlyXHu37l30tc/
	0gMoaNlZrrv5LcD1s38yoLIiS+QX3FQ==
X-Google-Smtp-Source: AGHT+IHIZqaFJZrc+7zuVHl6YGc5FhA/3cznk1RFLyG+DxgREEAu9473IYi8XcT0o8GkfFuTWHh3Ug==
X-Received: by 2002:a05:6a00:754f:b0:769:9f87:1dfa with SMTP id d2e1a72fcca58-76ab30dadcdmr7723816b3a.23.1753952446837;
        Thu, 31 Jul 2025 02:00:46 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd22csm1057745b3a.65.2025.07.31.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 02:00:46 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	sunshine@sunshineco.com,
	Meet Soni <meetsoni3017@gmail.com>
Subject: [GSoC][RFC PATCH v4 0/5] Add refs list subcommand
Date: Thu, 31 Jul 2025 14:30:35 +0530
Message-Id: <20250731090040.1625303-1-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723064313.29866-1-meetsoni3017@gmail.com>
References: <20250723064313.29866-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

This is the fourth version of the patch series that introduces the git
refs list subcommand.

Changes in v4:

  - Implemented architectural refactoring. The core logic of
    for-each-ref now resides in a shared helper function, and both
    for-each-ref and refs list have been simplified to thin wrappers
    around it.

  - The usage strings have also been refactored. The common options
    are now defined in a shared macro in a new for-each-ref.h header.

  - The patch series has been further split to cleanly separate the
    preparatory refactoring commits (for both the C code and the
    AsciiDoc documentation) from the commit that introduces the new
    feature.

  - As a beneficial side-effect of unifying the usage strings, this
    series now fixes a pre-existing inconsistency between the --help
    output and the man page for for-each-ref. This allows a known
    breakage for it in the t0450 documentation test to be removed.

---

(v1 cover-letter text)

This patch series introduces `git refs list` as a modern replacement for
`git for-each-ref`, as part of an effort to consolidate ref-related
functionality under a unified `git refs` command.

Git's ref-related operations are currently handled by several distinct
commands, such as `git show-ref`, `git for-each-ref`, `git update-ref`,
`git pack-refs`, etc. This distribution has a few practical drawbacks:

- Users need to rely on multiple commands for related tasks involving
  refs.

- The commands may differ slightly in behavior and option syntax,
  leading to inconsistency.

We propose a long-term consolidation effort to bring ref-related
subcommands under the umbrella of a single command: `git refs`.

The implementation of `git refs list` is functionally identical to `git
for-each-ref`. It reuses the same internal logic (cmd_for_each_ref) to
ensure complete backward compatibility. The purpose of this patch is not
to introduce new behavior but to provide an alternate entry point under
the consolidated `git refs` namespace.

The motivation behind this change is twofold:

- Consolidation: Centralizing ref-related operations makes them easier
  to discover, use, and maintain.

- Evolution: While the initial goal is parity with existing commands,
  this consolidation allows for careful reconsideration of which
  features are essential. Over time, we can:

  - Remove legacy or obscure options that are no longer needed.
  - Add improvements that wouldn't make sense to bolt onto legacy
    commands.
  - Offering a more consistent and user-friendly surface.

To verify backward compatibility, this patch also includes a test
`t/t1461-refs-list.sh`, which runs the full `t6300-for-each-ref.sh` test
using `git refs list`. The test uses ${GIT_REFS_LIST_CMD:-for-each-ref}
to allow substitution without duplicating tests.

This patch is deliberately conservative: it introduces no behavioral
changes and leaves `for-each-ref` untouched. The goal is to lay
groundwork and demonstrate viability of ref consolidation within `git
refs`.

Going forward, I'd like to initiate a discussion on what the ideal
surface of `git refs list` should look like. Which options and features
from `for-each-ref` should be carried over? Are there any that are
obsolete or overly niche? What improvements might be worth considering
now that we have a new, consolidated interface?

Feedback on this, especially from those who rely on `for-each-ref` in
scripts or tooling would be very helpful.

Meet Soni (5):
  doc: factor out common option
  builtin/for-each-ref: factor out core logic into a helper
  builtin/refs: add list subcommand
  t6300: refactor tests to be shareable
  t: add test for git refs list subcommand

 Documentation/for-each-ref-options.adoc |   79 +
 Documentation/git-for-each-ref.adoc     |   80 +-
 Documentation/git-refs.adoc             |   16 +
 builtin/for-each-ref.c                  |   35 +-
 builtin/refs.c                          |   14 +
 for-each-ref.h                          |   24 +
 t/for-each-ref-tests.sh                 | 2141 +++++++++++++++++++++++
 t/meson.build                           |    1 +
 t/t0450/adoc-help-mismatches            |    1 -
 t/t1461-refs-list.sh                    |    8 +
 t/t6300-for-each-ref.sh                 | 2140 +---------------------
 11 files changed, 2305 insertions(+), 2234 deletions(-)
 create mode 100644 Documentation/for-each-ref-options.adoc
 create mode 100644 for-each-ref.h
 create mode 100644 t/for-each-ref-tests.sh
 create mode 100755 t/t1461-refs-list.sh

Range-diff against v3:
1:  547b0bbf8f < -:  ---------- builtin/refs: add list subcommand
-:  ---------- > 1:  d2fa47a2b9 doc: factor out common option
-:  ---------- > 2:  5084db4d14 builtin/for-each-ref: factor out core logic into a helper
-:  ---------- > 3:  1a15cd454b builtin/refs: add list subcommand
2:  5d5057ff98 = 4:  29c41d682b t6300: refactor tests to be shareable
3:  b9cb9cdf48 = 5:  0fd1f714c9 t: add test for git refs list subcommand
-- 
2.34.1

