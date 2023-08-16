Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84FFDC2FC02
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 23:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347236AbjHPXuo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjHPXuP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 19:50:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43D810E9
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:12 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d63e5f828a0so7984140276.0
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 16:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692229812; x=1692834612;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Fv4NZjFdiCQckOWn0FEGTAom4/TeFO3mBA0tIRuLLw=;
        b=cLtIc4dlzX/z41Z1Z8+fe/EUZlUNdxZWy+GP1VXhRQuqmpsIIasgwpb2k+LnalkeXd
         nXUhvnpEm6zqA0ccHRmMOukaodopEYhzgVvGekbYcD36EF5uGELyf3KmplSLBNYG97Nf
         IDzv6UgeYpQwBSc88R471o7Gd0eowTqUKjTXQ5R41z2ilgO0oo8jGkPFtSi1eKB69HoB
         V3q+17BJSK3KYzMXmhgb5H2EjrmI5Vt0rzybqHCZHr6GgPpOJ9Z9aXpJzprAjTi/BKVc
         X9SFphAygmCqDSB2Pn8sgAlez2JrilDx+nrvpQN6S8uKgZMvs91nYZlrkBtFPD+NbEpH
         2e9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692229812; x=1692834612;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Fv4NZjFdiCQckOWn0FEGTAom4/TeFO3mBA0tIRuLLw=;
        b=a5KX271OplGc/a9g4Ru8RPhr6d7QV1DMthEr31KvNDv21Nkz7l/iaoHTgjjJhqcD3a
         jAbVl1Cs9xPitNRbaW9RWSOTCStIm0Bs7/64dfXneLVAjY3k6q/Ofzi1BM70Zn1seDDe
         9i7teSY6WmjDm8r0kVqpPMPHtmfsUp3wH9FYV3erba0tfqIApaT5ljDoVQexdx8YaZG0
         29YftJdjvV7EK75ix33s3rWIL8bRrvV19dNPHTLDup+bMK1okQrq4gT/mBJP/Mf2nmYx
         Nwg7l1Y/+IzyKRzghLgsP5dxz3q0uEH87H7WF6VCLqlZxOS19lLTt8ubxqMCPSMguHi5
         9Z0Q==
X-Gm-Message-State: AOJu0YxeX/CRC/FqXqFq3NJ48kRXIlbVS057r6HhWknBPebeNZco7Wiy
        yh8KToSuzt+LV7TFrdqobPqHFA6qIygDX8TjtbKoD0vYn6NK5ZpXtAZJ+KLEDtpxKVKctdCcm6E
        t7bhPBLJKX6jbHyPD8QgGErrZ5m0pcjoomgCeMwf9nMou8ebI65uMfMKk/WmCde4=
X-Google-Smtp-Source: AGHT+IEUu9FRhoomFHChBQPuiWd3OqH2VLVq5v0N6jgP+V8jQ37IvqugkJagbGzWLkme1grPH4dgtDwjd+7FRA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:378f:b204:29bd:7043])
 (user=steadmon job=sendgmr) by 2002:a25:fc26:0:b0:d58:6cea:84de with SMTP id
 v38-20020a25fc26000000b00d586cea84demr47867ybd.11.1692229811714; Wed, 16 Aug
 2023 16:50:11 -0700 (PDT)
Date:   Wed, 16 Aug 2023 16:50:04 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <cover.1692229626.git.steadmon@google.com>
Subject: [PATCH v6 0/3] Add unit test framework and project plan MIME-Version:
 1.0 Content-Type: text/plain; charset=UTF-8 Content-Transfer-Encoding: 8bit
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     linusa@google.com, calvinwan@google.com, phillip.wood123@gmail.com,
        gitster@pobox.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In our current testing environment, we spend a significant amount of
effort crafting end-to-end tests for error conditions that could easily
be captured by unit tests (or we simply forgo some hard-to-setup and
rare error conditions). Unit tests additionally provide stability to the
codebase and can simplify debugging through isolation. Turning parts of
Git into libraries[1] gives us the ability to run unit tests on the
libraries and to write unit tests in C. Writing unit tests in pure C,
rather than with our current shell/test-tool helper setup, simplifies
test setup, simplifies passing data around (no shell-isms required), and
reduces testing runtime by not spawning a separate process for every
test invocation.

This series begins with a project document covering our goals for adding
unit tests and a discussion of alternative frameworks considered, as
well as the features used to evaluate them. A rendered preview of this
doc can be found at [2]. It also adds Phillip Wood's TAP implemenation
(with some slightly re-worked Makefile rules) and a sample strbuf unit
test. Finally, we modify the configs for GitHub and Cirrus CI to run the
unit tests. Sample runs showing successful CI runs can be found at [3],
[4], and [5].

[1] https://lore.kernel.org/git/CAJoAoZ=3DCig_kLocxKGax31sU7Xe4=3D=3DBGzC__=
Bg2_pr7krNq6MA@mail.gmail.com/
[2] https://github.com/steadmon/git/blob/unit-tests-asciidoc/Documentation/=
technical/unit-tests.adoc
[3] https://github.com/steadmon/git/actions/runs/5884659246/job/15959781385=
#step:4:1803
[4] https://github.com/steadmon/git/actions/runs/5884659246/job/15959938401=
#step:5:186
[5] https://cirrus-ci.com/task/6126304366428160 (unrelated tests failed,
    but note that t-strbuf ran successfully)

In addition to reviewing the patches in this series, reviewers can help
this series progress by chiming in on these remaining TODOs:
- Figure out how to ensure tests run on additional OSes such as NonStop
- Figure out if we should collect unit tests statistics similar to the
  "counts" files for shell tests
- Decide if it's OK to wait on sharding unit tests across "sliced" CI
  instances
- Provide guidelines for writing new unit tests

Changes in v6:
- Officially recommend using Phillip Wood's TAP framework
- Add an example strbuf unit test using the TAP framework as well as
  Makefile integration
- Run unit tests in CI

Changes in v5:
- Add comparison point "License".
- Discuss feature priorities
- Drop frameworks:
  - Incompatible licenses: libtap, cmocka
  - Missing source: MyTAP
  - No TAP support: =C2=B5nit, cmockery, cmockery2, Unity, minunit, CUnit
- Drop comparison point "Coverage reports": this can generally be
  handled by tools such as `gcov` regardless of the framework used.
- Drop comparison point "Inline tests": there didn't seem to be
  strong interest from reviewers for this feature.
- Drop comparison point "Scheduling / re-running": this was not
  supported by any of the main contenders, and is generally better
  handled by the harness rather than framework.
- Drop comparison point "Lazy test planning": this was supported by
  all frameworks that provide TAP output.

Changes in v4:
- Add link anchors for the framework comparison dimensions
- Explain "Partial" results for each dimension
- Use consistent dimension names in the section headers and comparison
  tables
- Add "Project KLOC", "Adoption", and "Inline tests" dimensions
- Fill in a few of the missing entries in the comparison table

Changes in v3:
- Expand the doc with discussion of desired features and a WIP
  comparison.
- Drop all implementation patches until a framework is selected.
- Link to v2: https://lore.kernel.org/r/20230517-unit-tests-v2-v2-0-21b5b60=
f4b32@google.com


Josh Steadmon (2):
  unit tests: Add a project plan document
  ci: run unit tests in CI

Phillip Wood (1):
  unit tests: add TAP unit test framework

 .cirrus.yml                            |   2 +-
 Documentation/Makefile                 |   1 +
 Documentation/technical/unit-tests.txt | 220 +++++++++++++++++
 Makefile                               |  24 +-
 ci/run-build-and-tests.sh              |   2 +
 ci/run-test-slice.sh                   |   5 +
 t/Makefile                             |  15 +-
 t/t0080-unit-test-output.sh            |  58 +++++
 t/unit-tests/.gitignore                |   2 +
 t/unit-tests/t-basic.c                 |  95 +++++++
 t/unit-tests/t-strbuf.c                |  75 ++++++
 t/unit-tests/test-lib.c                | 329 +++++++++++++++++++++++++
 t/unit-tests/test-lib.h                | 143 +++++++++++
 13 files changed, 966 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/technical/unit-tests.txt
 create mode 100755 t/t0080-unit-test-output.sh
 create mode 100644 t/unit-tests/.gitignore
 create mode 100644 t/unit-tests/t-basic.c
 create mode 100644 t/unit-tests/t-strbuf.c
 create mode 100644 t/unit-tests/test-lib.c
 create mode 100644 t/unit-tests/test-lib.h

Range-diff against v5:
1:  c7dca1a805 ! 1:  81c5148a12 unit tests: Add a project plan document
    @@ Commit message
         preliminary comparison of several different frameworks.
    =20
    -    Coauthored-by: Calvin Wan <calvinwan@google.com>
    +    Co-authored-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Calvin Wan <calvinwan@google.com>
         Signed-off-by: Josh Steadmon <steadmon@google.com>
    =20
    @@ Documentation/technical/unit-tests.txt (new)
     +
     +=3D=3D Choosing a framework
     +
    -+=3D=3D=3D Desired features & feature priority
    ++We believe the best option is to implement a custom TAP framework for=
 the Git
    ++project. We use a version of the framework originally proposed in
    ++https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmai=
l.com/[1].
    ++
    ++
    ++=3D=3D Choosing a test harness
    ++
    ++During upstream discussion, it was occasionally noted that `prove` pr=
ovides many
    ++convenient features, such as scheduling slower tests first, or re-run=
ning
    ++previously failed tests.
    ++
    ++While we already support the use of `prove` as a test harness for the=
 shell
    ++tests, it is not strictly required. The t/Makefile allows running she=
ll tests
    ++directly (though with interleaved output if parallelism is enabled). =
Git
    ++developers who wish to use `prove` as a more advanced harness can do =
so by
    ++setting DEFAULT_TEST_TARGET=3Dprove in their config.mak.
    ++
    ++We will follow a similar approach for unit tests: by default the test
    ++executables will be run directly from the t/Makefile, but `prove` can=
 be
    ++configured with DEFAULT_UNIT_TEST_TARGET=3Dprove.
    ++
    ++
    ++=3D=3D Framework selection
     +
     +There are a variety of features we can use to rank the candidate fram=
eworks, and
     +those features have different priorities:
    @@ Documentation/technical/unit-tests.txt (new)
     +** <<adoption,Adoption>>
     +
     +[[license]]
    -+=3D=3D=3D=3D License
    ++=3D=3D=3D License
     +
     +We must be able to legally use the framework in connection with Git. =
As Git is
     +licensed only under GPLv2, we must eliminate any LGPLv3, GPLv3, or Ap=
ache 2.0
     +projects.
     +
     +[[vendorable-or-ubiquitous]]
    -+=3D=3D=3D=3D Vendorable or ubiquitous
    ++=3D=3D=3D Vendorable or ubiquitous
     +
     +We want to avoid forcing Git developers to install new tools just to =
run unit
     +tests. Any prospective frameworks and harnesses must either be vendor=
able
    @@ Documentation/technical/unit-tests.txt (new)
     +tools installed already.
     +
     +[[maintainable-extensible]]
    -+=3D=3D=3D=3D Maintainable / extensible
    ++=3D=3D=3D Maintainable / extensible
     +
     +It is unlikely that any pre-existing project perfectly fits our needs=
, so any
     +project we select will need to be actively maintained and open to acc=
epting
    @@ Documentation/technical/unit-tests.txt (new)
     +conditions holds.
     +
     +[[major-platform-support]]
    -+=3D=3D=3D=3D Major platform support
    ++=3D=3D=3D Major platform support
     +
     +At a bare minimum, unit-testing must work on Linux, MacOS, and Window=
s.
     +
    @@ Documentation/technical/unit-tests.txt (new)
     +more platforms, but it is still usable in principle.
     +
     +[[tap-support]]
    -+=3D=3D=3D=3D TAP support
    ++=3D=3D=3D TAP support
     +
     +The https://testanything.org/[Test Anything Protocol] is a text-based=
 interface
     +that allows tests to communicate with a test harness. It is already u=
sed by
    @@ Documentation/technical/unit-tests.txt (new)
     +further.
     +
     +[[diagnostic-output]]
    -+=3D=3D=3D=3D Diagnostic output
    ++=3D=3D=3D Diagnostic output
     +
     +When a test case fails, the framework must generate enough diagnostic=
 output to
     +help developers find the appropriate test case in source code in orde=
r to debug
     +the failure.
     +
     +[[runtime-skippable-tests]]
    -+=3D=3D=3D=3D Runtime-skippable tests
    ++=3D=3D=3D Runtime-skippable tests
     +
     +Test authors may wish to skip certain test cases based on runtime cir=
cumstances,
     +so the framework should support this.
     +
     +[[parallel-execution]]
    -+=3D=3D=3D=3D Parallel execution
    ++=3D=3D=3D Parallel execution
     +
     +Ideally, we will build up a significant collection of unit test cases=
, most
     +likely split across multiple executables. It will be necessary to run=
 these
    @@ Documentation/technical/unit-tests.txt (new)
     +parallelism can be handled by the test harness.
     +
     +[[mock-support]]
    -+=3D=3D=3D=3D Mock support
    ++=3D=3D=3D Mock support
     +
     +Unit test authors may wish to test code that interacts with objects t=
hat may be
     +inconvenient to handle in a test (e.g. interacting with a network ser=
vice).
    @@ Documentation/technical/unit-tests.txt (new)
     +for more convenient tests.
     +
     +[[signal-error-handling]]
    -+=3D=3D=3D=3D Signal & error handling
    ++=3D=3D=3D Signal & error handling
     +
     +The test framework should fail gracefully when test cases are themsel=
ves buggy
     +or when they are interrupted by signals during runtime.
     +
     +[[project-kloc]]
    -+=3D=3D=3D=3D Project KLOC
    ++=3D=3D=3D Project KLOC
     +
     +The size of the project, in thousands of lines of code as measured by
     +https://dwheeler.com/sloccount/[sloccount] (rounded up to the next mu=
ltiple of
     +1,000). As a tie-breaker, we probably prefer a project with fewer LOC=
.
     +
     +[[adoption]]
    -+=3D=3D=3D=3D Adoption
    ++=3D=3D=3D Adoption
     +
     +As a tie-breaker, we prefer a more widely-used project. We use the nu=
mber of
     +GitHub / GitLab stars to estimate this.
    @@ Documentation/technical/unit-tests.txt (new)
     +https://libcheck.github.io/check/[Check],[lime-background]#LGPL v2.1#=
,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#Tru=
e#,[lime-background]#True#,[lime-background]#True#,[red-background]#False#,=
[red-background]#False#,[red-background]#False#,[lime-background]#True#,17,=
973
     +|=3D=3D=3D=3D=3D
     +
    -+=3D=3D=3D=3D Alternatives considered
    ++=3D=3D=3D Additional framework candidates
     +
     +Several suggested frameworks have been eliminated from consideration:
     +
    @@ Documentation/technical/unit-tests.txt (new)
     +** https://github.com/siu/minunit[minunit]
     +** https://cunit.sourceforge.net/[CUnit]
     +
    -+=3D=3D=3D=3D Suggested framework
    -+
    -+Considering the feature priorities and comparison listed above, a cus=
tom
    -+framework seems to be the best option.
    -+
    -+
    -+=3D=3D Choosing a test harness
    -+
    -+During upstream discussion, it was occasionally noted that `prove` pr=
ovides many
    -+convenient features. While we already support the use of `prove` as a=
 test
    -+harness for the shell tests, it is not strictly required.
    -+
    -+IMPORTANT: It is an open question whether or not we wish to rely on `=
prove` as a
    -+strict dependency for running unit tests.
    -+
     +
     +=3D=3D Milestones
     +
    -+* Get upstream agreement on implementing a custom test framework
    -+* Determine if it's OK to rely on `prove` for running unit tests
     +* Add useful tests of library-like code
    -+* Integrate with Makefile
    -+* Integrate with CI
     +* Integrate with
     +  https://lore.kernel.org/git/20230502211454.1673000-1-calvinwan@goog=
le.com/[stdlib
     +  work]
-:  ---------- > 2:  ca284c575e unit tests: add TAP unit test framework
-:  ---------- > 3:  ea33518d00 ci: run unit tests in CI

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
--=20
2.41.0.694.ge786442a9b-goog

