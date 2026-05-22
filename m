Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2D19004A
	for <git@vger.kernel.org>; Fri, 22 May 2026 02:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779415888; cv=none; b=IRfadXKz0KNypDgZc5zJYnZO1/vSqDnWWI2fGFiP/pBPSFDJ+Fqr2WPi0ZYjraMhCb5DwT82LrPzyRNsDftVoDI30z3cuQuUekbG50vaLCsuoaQQycuZlL9EN9SDq6N/Q1m24JXV4mmvtZTDKhSoAVNlcXKCyzhMTFHq8fRqzUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779415888; c=relaxed/simple;
	bh=/gkf6DAGFy9OTbTSsZ8b1gCCyOP9bGGdow8tCSqBREU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JZdyzYVAv0iAkKe4mQRQakUQxrrctZMnxEtBtTIRbgh7SyE1GlSJuh+gYG1uAdWOXq0/QKx1psc4yLdwugGYi2TzZTfoHq+XZeE3b1B+ggAwJLUEnc+loDiJFmndF/S66UJliKThealxilH2KlP6vQVcp1nEEh8UVlx02a31Zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHDcZtct; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHDcZtct"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-90fbf21d9d3so1123774085a.1
        for <git@vger.kernel.org>; Thu, 21 May 2026 19:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779415886; x=1780020686; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2HNHUGEMU/nBXc763rRMiNz2/MbYCLF87PPVooZct2o=;
        b=XHDcZtcttKgcGhgUEltansZK9GfzFcImzidPgFe044xGFFUfVfnSXI/uKF1WeYDQlr
         zXtIyMBWMmrrTjEsmWDQX0pxasw618WmqpbcP88dGDhUXUXy2kZPf94JnCznh1e/hydT
         7mdQxh1OQ9oiei5MZMGj2GYaFqwoMZ1tBE5jDH20o5QzIc4aQiPzwEIwBuVrswsrF6ri
         nMU5HRG0QoOGpBNyky1dOuJtsaGNraHHKlRBU15sxdDW75Y4IJSp3HWSqlWb9uRGH2LE
         IoSEY5tlRGsm/MshBHnRUxza8erg49UHX16vuNTR2c7UKep0n3xIH7gBe8J2Zz0OWfWI
         eR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779415886; x=1780020686;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HNHUGEMU/nBXc763rRMiNz2/MbYCLF87PPVooZct2o=;
        b=jtLzB2gB4VpmnyQvs9510SbeyAgridjZRk4mPxOoQ+o9ILEzQqB9KgGFpTZPq+JSNx
         /aqmWD8C4RAFlmxzw18QLD+jYm0pA6A26XRZaAvJM0+BbGqsgzjEbPiiSTwHTLo2eEee
         h9zTrpdFsrsa94beuIIMSFAKrdm73sDnsfoxD/sDWZp3XF00nBTwkp4Xjqw8xFQcsP6p
         DC1RRUH5/tON5ouRkKLOWTt09NkTVMmjjMVvM2+f7bLnXRmZ5KEzWgmrxUZA7pJA9nG5
         F1kZU9awHFbNGZtfCTB5UGaRtbaVg+D70KYJZ4WYJdmh9Bgq2FLCCHiXr+GAs8e35qGJ
         oSKg==
X-Gm-Message-State: AOJu0Yy+uDoDxn6jdDFYuXtfeEmUSbT8Wd8C5+i7zqpBrsiSgLdsYDMD
	Z16FaQlMK8W3LK0f3J5/avRCFSSdH/S5UmwmU3HVCBUjmecMAj5uKjGFcUVHHw==
X-Gm-Gg: Acq92OFOqe4dIoDQK1/mR21jAyJb8Zse8DsrTK0xxSp6yolfTLDAHNoHDvCYHEdufNZ
	hr5tOnqKNSSIgWyy+J+Srl777ugsJtniXqatnN3mw+iSfG43jtv1fWEeMaTXtMJUU2c+D3hdMXo
	3/7QzOa8/U1ndZss9tUnNYVfbJP78GTmRw2QPm9N44NLI651yFPCgSwRgNEhNlbBrViswAY2RiH
	x7hfgTEWKUGTG8/TrscRIwSUSuonx9Ku8pufoiDzRjAV7hvQ89V9dVX5sYYv3q6R+X80kuNiGjH
	FHSmvHb3RCOXOrcXbkjXKlcD70WcyTtQ2xAPvzH8D7Dd38SdEW0maCQj09nasdfedqVs+IXyweV
	BVrNXOnrgE0Hlmrd4xov3uXe8YPZbjp/rfSCougPRES5Pha8QSPq1tQi+OMo81LD2cQC2fWVLfb
	QfBg4K0JaeL+FTtYn1tCJPfIrgm0qatWx2D4Y=
X-Received: by 2002:a05:620a:254a:b0:8cf:c451:cc1c with SMTP id af79cd13be357-914b49d2121mr286295685a.58.1779415885975;
        Thu, 21 May 2026 19:11:25 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.117.81])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914b6017b2esm63480185a.32.2026.05.21.19.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:11:25 -0700 (PDT)
Message-Id: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 22 May 2026 02:11:19 +0000
Subject: [PATCH 0/5] [RFC] diff: add diff.<driver>.process for external hunk providers
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

This series adds diff.<driver>.process, a long-running subprocess protocol
that lets external tools provide hunks to git's diff and blame pipelines.

Over the past 18 years, git's diff pipeline accumulated many features that
operate on hunks: word diff, function context, color-moved, indent
heuristic, blame. External tools can replace the pipeline entirely
(diff.<driver>.command) or select among builtin algorithms
(diff.<driver>.algorithm), but there is no way for a tool to provide
line-change information into the pipeline. Tools that understand code
structure (tree-sitter parsers, format-aware analyzers, tools like
Difftastic and Mergiraf) must bypass git's pipeline and lose access to
everything downstream.

The protocol follows filter.<driver>.process: pkt-line over stdin/stdout,
capability negotiation, one tool invocation per git command. The tool
receives file pairs and returns hunk descriptors that git feeds into the
standard xdiff pipeline. All output features work normally.

Zero hunks with status=success means the tool considers the files
equivalent. git diff shows no output for the file, and git blame skips the
commit, attributing lines to earlier commits.

On error or tool crash, git falls back silently to the builtin diff
algorithm. The feature is opt-in via diff.<driver>.process and
.gitattributes; unconfigured files are unaffected.

The series includes git diff-process-normalize, a built-in tool that
compares files line by line ignoring whitespace (same logic as "git diff -w"
via xdiff_compare_lines):

[diff "cdiff"]
    process = git diff-process-normalize


A whitespace-only boolean flag could serve this specific case. The
subprocess protocol is more general, allowing any tool to participate
without further changes to git.

Michael Montalbo (5):
  xdiff: support external hunks via xpparam_t
  userdiff: add diff.<driver>.process config
  diff: add long-running diff process via diff.<driver>.process
  blame: consult diff process for zero-hunk detection
  diff-process-normalize: add built-in whitespace normalizer

 Documentation/config/diff.adoc   |  10 +
 Documentation/gitattributes.adoc |  58 +++++
 Makefile                         |   2 +
 blame.c                          |  43 +++-
 builtin.h                        |   1 +
 builtin/diff-process-normalize.c | 143 ++++++++++
 diff-process.c                   | 203 +++++++++++++++
 diff-process.h                   |  28 ++
 diff.c                           |  25 ++
 git.c                            |   1 +
 t/t4080-diff-process.sh          | 430 +++++++++++++++++++++++++++++++
 userdiff.c                       |   7 +
 userdiff.h                       |   2 +
 xdiff-interface.c                |   7 +-
 xdiff/xdiff.h                    |  13 +
 xdiff/xdiffi.c                   |  98 ++++++-
 16 files changed, 1063 insertions(+), 8 deletions(-)
 create mode 100644 builtin/diff-process-normalize.c
 create mode 100644 diff-process.c
 create mode 100644 diff-process.h
 create mode 100755 t/t4080-diff-process.sh


base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2120%2Fmmontalbo%2Fmm%2Fstructural-diff-backend-clean-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2120/mmontalbo/mm/structural-diff-backend-clean-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2120
-- 
gitgitgadget
