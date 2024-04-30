Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8D8199E91
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714506962; cv=none; b=b1YOEPmN+iFB/UN5JtewwHq/YLNYlce9Mx7lfPjB4X/WdxLLY88LY8utwZ5+bN4xY9FM3FLeROlxbmc3gZmJSt/Quck+Jvr//z3XXF2Rnfz3eplJ9OnY0jbqTf/CyGxgAGKn3z4fEvtYU/R/Cp9TzI4JVjb+5Xe+tter2Fe1pKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714506962; c=relaxed/simple;
	bh=xxu02c+vD6OfxkvzqpdofVnA8KmJHIDMIhsfFn6lJ00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=M/18wLw31J4hPipkj8qgafkYnYMEg42g+UEDPfXWF3gM5EzJc/5LPl7Tssz+wjmdE/wutO0RZTyAqj2icrw1997sJQJhrwydmNuC6v9xbRE9ddRCi6oAGhQsIiDRuhgFZA0W2AfbKAVPacie9mMkdXz/PF1hylov1c07Qh+yIEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0YvaHXkH; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--steadmon.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0YvaHXkH"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de5a378a948so8390635276.2
        for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714506960; x=1715111760; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsKZXM6LpY5FtF+wnXfVbl/Zkp3jUReDOzmbHVwNC6I=;
        b=0YvaHXkH8gV1zdBG3pobVbrAISjMCF20xyV9+XGtuV0Ko75cvs8pOzkF9ZWCKvcHQh
         4cFXCx/UI2gh1T5yS6WxkhToY/JGdJxIdmgtgmp1d9NclYgAdntkTpBKVDgZkEbDMGJQ
         JCpeiKFOw6B8X1WB08H8mdK9FAJQOUbF0H3KbZEnSbwMvYbZiHwe0JgHov33ARjM+ZQY
         0IdjWZ32iKYsPVOHjsN3QqlFoA9hbzdl/82XTOR+XaIe1ObDp/+Ldr5gHZfsCdM5+3KN
         J3cJhd2Q0pgPsKW0J1sswEqnKTTN9mtAeo032vV34WBKCWqgm7+Qly0UNx1JmV9Yxn2M
         xDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714506960; x=1715111760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsKZXM6LpY5FtF+wnXfVbl/Zkp3jUReDOzmbHVwNC6I=;
        b=lsHzgtJndPnJZ3jzw1XKbGTYFs1WXspHljbp67wiEAWkcsGNrlMfPrK54LjhuZPTLo
         4c1oxU/vMve8Mgri+vLKOVl0afV92/jKTQUWYFm8V5KWzw9OSM7YselLCaU5Sy7kbDty
         LJlK1LABF9MbPBWtb1Iq1Jq40k0JHdv7fAV7nnD1i7VphG68o3A5xikF0qNx6K1sev2z
         qdwU6yjNXHvu4r+6Nuf35hzqhdySJph/ivpEVhKvxISREyP3gAfnWTaXyAD410IkjYa+
         MYZjW4klgVkFjdiEf505HvnwX1eIRW+r5f2pKBsjja0oHlxDtz9rNpN7asCMNnwN6PUk
         51Tw==
X-Gm-Message-State: AOJu0YwshlvjxrqZeUKjYNlPjJKMWCS5GuvM+38SsbMNVS+8Exy9tHU/
	TpP6HT+hYIcfoWmaeS4FVkIGuYx4wBltHRelfi44XCx+OWRe1t03GcXBfeAdLUq+GBlj5V2aaCu
	kmmXB7yrGVVwhHpGQuY6aaRB57EH2gue6LzdnLNXDK9L9qKj2UGUnhauSAmFv+Ls5Mp20dD7EK+
	A7DQNLR62tWn2muOi63YS27VgKMwRZlgV59jn/FEk=
X-Google-Smtp-Source: AGHT+IFll+zTru7Xab1mzOsWbVnfdoVh8k6GoyFwJv4AKpkdlDdkcajmuumqWbRvwXeVn4q4oPtFXeh4Xkkslw==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:3e48:fe18:8aa:8a0e])
 (user=steadmon job=sendgmr) by 2002:a25:c713:0:b0:de6:1646:58b2 with SMTP id
 w19-20020a25c713000000b00de6164658b2mr65455ybe.13.1714506959875; Tue, 30 Apr
 2024 12:55:59 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:55:50 -0700
In-Reply-To: <cover.1705443632.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1705443632.git.steadmon@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <cover.1714506612.git.steadmon@google.com>
Subject: [PATCH v5 0/7] test-tool: add unit test suite runner
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

Changes in V5:
* Style fix in t/run-test.sh

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

Range-diff against v4:
1:  6777451100 = 1:  6777451100 t0080: turn t-basic unit test into a helper
2:  24f47f8fc7 = 2:  24f47f8fc7 test-tool run-command testsuite: get shell from env
3:  4a16a3ec24 = 3:  4a16a3ec24 test-tool run-command testsuite: remove hardcoded filter
4:  abc9a7afe8 = 4:  abc9a7afe8 test-tool run-command testsuite: support unit tests
5:  a8bbff2c6b = 5:  a8bbff2c6b unit tests: add rule for running with test-tool
6:  0e32de1afe ! 6:  c6606446c4 t/Makefile: run unit tests alongside shell tests
    @@ t/run-test.sh (new)
     +
     +case "$1" in
     +*.sh)
    -+  if test -z "${TEST_SHELL_PATH+set}" ; then
    -+          echo "ERROR: TEST_SHELL_PATH is not set" >&2
    ++  if test -z "${TEST_SHELL_PATH+set}"
    ++  then
    ++          echo >&2 "ERROR: TEST_SHELL_PATH is empty or not set"
     +          exit 1
     +  fi
     +  exec ${TEST_SHELL_PATH} "$@"
7:  c562515293 = 7:  4a92131ab9 ci: use test-tool as unit test runner on Windows

base-commit: 4904a4d08cc085716df12ce713ae7ee3d5ecb75a
-- 
2.45.0.rc0.197.gbae5840b3b-goog

