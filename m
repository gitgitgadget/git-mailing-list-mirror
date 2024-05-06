Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2580B15ADB9
	for <git@vger.kernel.org>; Mon,  6 May 2024 19:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715025461; cv=none; b=VTNSol+sf71RCdIGh4EaP1uUsGg6UiIKyotRqZOFmzVJn89LmBnG0UcQC+SYsD41Xuo6sXs60ckxLYLCcIFxnHRh8vBI1Ca14lDYkqj8WJhhyjTS8zE1h4ttbLO942X/O7KWwp2TRsY+DGFQqGGnCUeenNCEYUSwtZ8Q7T1xsiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715025461; c=relaxed/simple;
	bh=auQsekh0n4Gt6xgH+dlokr66zj2sEqIzPgWNWBWTjP8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jPetaV3CuMe6pcZEh8EnFe/AYtk44zKgqnUWQ12V1e5bxQPfy356wkq5Ir4fXjsV0kF+U42RGILCJlZR6gf3YMkDxvrErFG+bRsQsUkLAAYkb75qJVUFpPvT/6nvT/NPvsw+RlHn1Y2XeOt6I0qSJXnqZ0W+EBgh35BTFqnmBCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=24aw5KxD; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="24aw5KxD"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61e0949fc17so45582747b3.0
        for <git@vger.kernel.org>; Mon, 06 May 2024 12:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715025459; x=1715630259; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju6be7mwtSO/iOPHJBiPZdjRbWNu1UBwi6M3ZKrR5Q=;
        b=24aw5KxDHIofyjDD9Im9CRQJBncJ3eUFS7/cbfy4cqkRAeFDMaw+7q8+eW/zl5xOXT
         IRhbZ94ZEV7t1KxeW+rcD/mF5h0mrQmvPXMs2Euuuvt1DA7iM/5binTd/mCg4qcDInul
         6EFVo7N+Ovvx/DHlWwZd3glv+H3zg40BgUyO4GcU8keYxA2g9BxQFQFUd1mAcemRZcx/
         LIUWOVgVr/Cdvo3+7JxaQZOYN3+yWJKFXEpTrfHuX7BAuePXkIR1v0p3KKPFNCqlKw6N
         JAvsLZkGhaGdoq69l/N2wGSf96zDrWPfnuhKNIL+cbnQJAW11BpdoBMCAMW3sU6NNHra
         Lkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715025459; x=1715630259;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Ju6be7mwtSO/iOPHJBiPZdjRbWNu1UBwi6M3ZKrR5Q=;
        b=w2d2UQp7Zl1HkDixD8rKzpTPClVtG/q7X6ZeuLk1VVth9GNpfC4Wjyb7coCyX+93nc
         XL9byA8E1MXRZ0P9/vGNFO0JHjsEhr2zTyqsfptyDl6lt6yfhZ7mCK4PM2w+GPo+KCMb
         +y3WqmYBAiS6pl+PH5gnC3jpwlrMtUq1XTKmN1Tqpkp1epb97apPjk0d5hTohPxON1gc
         j2s3TtcIoq2xJrVvmBA94CbAHN1JcKM1iWESfpFQ/RDWS1yRJAmtW8XlZELpbfy8Sb8t
         9M8ehR1q0wWMny44M66376YAeLuua8h1psMDZXqaECYMCwy1DHX+TjFo/5HOBs4HC60i
         9zeg==
X-Gm-Message-State: AOJu0YySBwsFZCCkp/9FeZtxgXRL6fZxF6/sy+9BbEEhTpCacvOZgxrR
	wv3ydjoRpiZqMJmr+TKv0Yvm/AIOenoGJHr5CJG7yrKMPoL0wYk2mgSNaXec+52X8GXiIoGBmAK
	pPun51jTbthi74SUZFTopDBdll5qY9UCzKzY6VYpJywogqyoBS94WVpwLxlPode0t4cB5novCQH
	WzFix3SUMjxlg0HzXv/4U7vLwBCs8ZdsDpTimWLW8=
X-Google-Smtp-Source: AGHT+IEugBxs+i7hNkUhmlhZ9+HKv8C6ve3pAl1iR3p7xWJa+IHP68LaF0auKd+9DS/NAm9d2BO5rsl+BnuYwA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:cf3e:6b4e:994:dc81])
 (user=steadmon job=sendgmr) by 2002:a0d:df87:0:b0:61a:dcd0:5a61 with SMTP id
 i129-20020a0ddf87000000b0061adcd05a61mr2634685ywe.7.1715025459042; Mon, 06
 May 2024 12:57:39 -0700 (PDT)
Date: Mon,  6 May 2024 12:57:30 -0700
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <cover.1715024899.git.steadmon@google.com>
Subject: [PATCH v6 0/7] test-tool: add unit test suite runner
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

For various reasons (see discussion at [1]) we would like an alternative
to `prove` for running test suites (including the unit tests) on
Windows.

[1] https://lore.kernel.org/git/pull.1613.git.1699894837844.gitgitgadget@gmail.com/

This series extends the existing `test-tool run-command testsuite` to
support running unit tests. In addition, it includes some small
cleanups:
* move t-basic out of the unit-tests directory
* don't hardcode the shell for running tests in `test-tool ... testsuite`
* don't hardcode a test name filter in `test-tool ... testsuite`
* add a test wrapper script to allow unit tests and the shell test suite
  to run in a single `prove` process

Changes in V4:
* Set TEST_SHELL_PATH when running the `prove` test target, and error
  out of run-test.sh if TEST_SHELL_PATH is not set.

Changes in V3:
* Added new patch (#7) to use the new test-tool runner for unit tests in
  Windows CI.
* Restored the explicit sort call in t/Makefile, for backwards
  compatibility with older GNU Make versions.
* Rebased the series on the latest jk/unit-tests-buildfix branch.
* Fixed header include order in patch #1.
* Removed a paragraph in patch #1's commit message that is obsolete now
  that we're building the list of test files from the sources rather
  than by globbing.
* Added a note in patch #2 that setting a NULL suite.shell_path will be
  used in a later commit.
* Clarified up some sloppy wording in commit messages and comments in
  t/helper/test-run-command.c.

Changes in V2:
* Rebased the series on the latest jk/unit-tests-buildfix branch.
* Patch 1: move t-basic to a test-tool subcommand rather than a new
  executable under t/t0080/
* New patch 2: get the shell path from TEST_SHELL_PATH in
  `test-tool run-command testsuite`
* New patch 3: remove the hardcoded filename filter in
  `test-tool run-command testsuite`
* Patch 4 (previously 2): simplified now that we no longer need to add
  any command-line flags to support unit tests
* Patch 5 (previously 3): avoid trying to run cmake *.pdb files by using
  the unit test list built in the makefile in jk/unit-tests-buildfix.


Jeff King (1):
  t/Makefile: run unit tests alongside shell tests

Josh Steadmon (6):
  t0080: turn t-basic unit test into a helper
  test-tool run-command testsuite: get shell from env
  test-tool run-command testsuite: remove hardcoded filter
  test-tool run-command testsuite: support unit tests
  unit tests: add rule for running with test-tool
  ci: use test-tool as unit test runner on Windows

 Makefile                                      |  6 ++--
 ci/run-build-and-tests.sh                     |  2 --
 ci/run-test-slice.sh                          |  2 +-
 t/Makefile                                    | 14 ++++++++--
 .../t-basic.c => helper/test-example-tap.c}   |  5 ++--
 t/helper/test-run-command.c                   | 28 +++++++++++++++----
 t/helper/test-tool.c                          |  1 +
 t/helper/test-tool.h                          |  1 +
 t/run-test.sh                                 | 18 ++++++++++++
 t/t0080-unit-test-output.sh                   | 24 ++++++++--------
 10 files changed, 72 insertions(+), 29 deletions(-)
 rename t/{unit-tests/t-basic.c => helper/test-example-tap.c} (95%)
 create mode 100755 t/run-test.sh

Range-diff against v5:
1:  6777451100 = 1:  6777451100 t0080: turn t-basic unit test into a helper
2:  24f47f8fc7 = 2:  24f47f8fc7 test-tool run-command testsuite: get shell from env
3:  4a16a3ec24 = 3:  4a16a3ec24 test-tool run-command testsuite: remove hardcoded filter
4:  abc9a7afe8 = 4:  abc9a7afe8 test-tool run-command testsuite: support unit tests
5:  a8bbff2c6b = 5:  a8bbff2c6b unit tests: add rule for running with test-tool
6:  c6606446c4 ! 6:  dae670fcb1 t/Makefile: run unit tests alongside shell tests
    @@ t/run-test.sh (new)
     +
     +case "$1" in
     +*.sh)
    -+  if test -z "${TEST_SHELL_PATH+set}"
    ++  if test -z "${TEST_SHELL_PATH}"
     +  then
     +          echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
     +          exit 1
     +  fi
    -+  exec ${TEST_SHELL_PATH} "$@"
    ++  exec "${TEST_SHELL_PATH}" "$@"
     +  ;;
     +*)
     +  exec "$@"
7:  4a92131ab9 = 7:  2f5853a7fa ci: use test-tool as unit test runner on Windows

base-commit: 4904a4d08cc085716df12ce713ae7ee3d5ecb75a
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

