Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AFC1CD3F
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713986058; cv=none; b=KkgnvrLZsGVK0Q3qmwJWVI3Kmx1AdOA2CINnJecGBm5VgFWXsw7DBwU2VP+ndXtdPRVKwDYiv9YPXCcvXax9e76xtx+mZtm7qJz4OtEiQErCezKZOQmaXkqVtUXoQCs13238xtM7s1DUmJxv861NMUPe4RmESESKGL6K+fcQdMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713986058; c=relaxed/simple;
	bh=/zgrP3ku+hN3u6v95bEroJYgGSASbiwDw4gNVOeZgFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDdAJij88oBZhDHlt3FRSwsAntuj0o4B7sJBfcdxrxlSucdLZyaPwBv5DsoHE5z2SZiEiSy2AQNEjlOYbk30jNrQ80NxV4w2FElFSwSndeznN44Ac4jUhdsIMNTCB7De9sorNkwSEFtWOW1VhuLdC6EABBLGqX9ZKIHEFlF+Tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qkIo507b; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qkIo507b"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b32e7f94bso2787457b3.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 12:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713986055; x=1714590855; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWMv6pW2z1DvSg8RBOJRy+usfjVhPfDKvNJNKOGT9iw=;
        b=qkIo507bE8YciU9A8utSACJ9zWttagqcZTe9wmx7hlG8RtaEsGPJRJ5CThoiBVmNty
         ICkuMp53fdP2TyCXH5PWVQ8mg25RxcN3Kec6IfPhvXntkduQ3xMsVD8gCuv/IdNsQ3W4
         MFB3cQ3kBSV9rhdcBpvJo6pghJquVK4f0PMfeEC02nTQPTxd56vnGGnTE3pserjJNlDk
         I7i1h6LnwievSw51LqYu/ptFGB7+PddNnhSWUD3EcA4lzDfchMugBv7n6f1yTtgAJ1i/
         xj1nLcW2xLCZUfUwNqAcaB5wHC9DsY6BdSMQM1M8Kh1PnxNSnRqx70WgO+DjlTQFSYLx
         BP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713986055; x=1714590855;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZWMv6pW2z1DvSg8RBOJRy+usfjVhPfDKvNJNKOGT9iw=;
        b=n//Kr7fI7ylxhe2iG2jLwhCiSdN2YDSVtxmeCbeX46iivexRTYNAQ+MvZEVUrTJpEQ
         fDjB2QmWrn2ZwsEbWMszikvlfaneqfHeNUZ6DjSNx0/FZIkLQ5PDuniA9dUatL0klSi4
         HItwcIjFolb5uJEExorYZEhbdrSIYARTiK9q/CJ9IWZhlFztDUNC0wG3nuBecboDxmLV
         pTmccfAV8DYAY2ossbI+N3IRJDRMnsdxbsDi2QCyHkO1F0K19csbxAGtIWn/V3xh9osz
         RZ5Te1ZGHy7EfzglewufQmGvU9cCbPCoeewpMnreItcr3grKLs9CvYJ9/fupEqwIFEeH
         Qvaw==
X-Gm-Message-State: AOJu0Yw1VIQqPKNGxkUbUrXhAKX4J5uKnYGOJ1BtO0rI2TxacrJc8t7/
	BcW6FUq70k+d8vV9YzMeZhSXawW+tBt4PWPzJqdJAXVOAxA7/ZJu4g/R92XJnNfLsYi++k4UX8e
	/UXhvMpnFp3yUwMHD1I0/anugSJR6ud8roe4Ur/Fic41EQ97cI78MGbHDzlrJ+GPuTyFVgFHD+j
	NuIzyHITu8BS9SZdBdt8BfdxzZm58myX2kN9wYxQk=
X-Google-Smtp-Source: AGHT+IEfLrreWwWcxFXhhgL3BNT4F6FhjaCubzKuJqvEUNC7ehFN0qKLeO9X4HxrqudSY0Kj6xdrfdynrUKALg==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
 (user=steadmon job=sendgmr) by 2002:a0d:cc92:0:b0:61b:24a:fd7f with SMTP id
 o140-20020a0dcc92000000b0061b024afd7fmr834195ywd.5.1713986055461; Wed, 24 Apr
 2024 12:14:15 -0700 (PDT)
Date: Wed, 24 Apr 2024 12:14:06 -0700
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <cover.1713985716.git.steadmon@google.com>
Subject: [PATCH v4 0/7] test-tool: add unit test suite runner
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
 t/run-test.sh                                 | 17 +++++++++++
 t/t0080-unit-test-output.sh                   | 24 ++++++++--------
 10 files changed, 71 insertions(+), 29 deletions(-)
 rename t/{unit-tests/t-basic.c => helper/test-example-tap.c} (95%)
 create mode 100755 t/run-test.sh

Range-diff against v3:
1:  6777451100 = 1:  6777451100 t0080: turn t-basic unit test into a helper
2:  24f47f8fc7 = 2:  24f47f8fc7 test-tool run-command testsuite: get shell from env
3:  4a16a3ec24 = 3:  4a16a3ec24 test-tool run-command testsuite: remove hardcoded filter
4:  abc9a7afe8 = 4:  abc9a7afe8 test-tool run-command testsuite: support unit tests
5:  a8bbff2c6b = 5:  a8bbff2c6b unit tests: add rule for running with test-tool
6:  cfcc4bd427 ! 6:  0e32de1afe t/Makefile: run unit tests alongside shell tests
    @@ t/Makefile: failed:

      prove: pre-clean check-chainlint $(TEST_LINT)
     -  @echo "*** prove ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec '$(TEST_SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
    -+  @echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
    ++  @echo "*** prove (shell & unit tests) ***"; $(CHAINLINTSUPPRESS) TEST_SHELL_PATH='$(TEST_SHELL_PATH_SQ)' $(PROVE) --exec ./run-test.sh $(GIT_PROVE_OPTS) $(T) $(UNIT_TESTS) :: $(GIT_TEST_OPTS)
        $(MAKE) clean-except-prove-cache

      $(T):
    @@ t/run-test.sh (new)
     +
     +case "$1" in
     +*.sh)
    -+  exec ${TEST_SHELL_PATH:-/bin/sh} "$@"
    ++  if test -z "${TEST_SHELL_PATH+set}" ; then
    ++          echo "ERROR: TEST_SHELL_PATH is not set" >&2
    ++          exit 1
    ++  fi
    ++  exec ${TEST_SHELL_PATH} "$@"
     +  ;;
     +*)
     +  exec "$@"
7:  cbf37e0ddc = 7:  c562515293 ci: use test-tool as unit test runner on Windows

base-commit: 4904a4d08cc085716df12ce713ae7ee3d5ecb75a
-- 
2.44.0.769.g3c40516874-goog

