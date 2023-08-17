Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68630C3DA65
	for <git@archiver.kernel.org>; Thu, 17 Aug 2023 18:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354483AbjHQSiE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Aug 2023 14:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354472AbjHQShb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2023 14:37:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEA31BE7
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:28 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c8cbf0a0dso23541837b3.1
        for <git@vger.kernel.org>; Thu, 17 Aug 2023 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692297447; x=1692902247;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBOaXWWd2vWrevhZoLBbsrVmPNPdP6V7ftQYf0JoXBM=;
        b=5M7vhpl3/t44tUWkUdwGZzmKcxXvveEoJ2cmlHWgL/WPWV6bNEOXTj1Av/o3CXEPZ2
         /fk9VIVUpxcaAwrfmQMIvRnHGXJ9NlAd8ftjmMcshCowKt7nbi/O8ZhuEiK12jOYM7Pq
         3IKfBRwY8fuerNykLAZH902YOSWncBTo4TPXdTrruNsTm9g1R6emMQ0GnMbRncR1VMZW
         ZrD3utizvazEEshbin2rWUSdjD8JUsQeBaS+dP+P9MLzyd1dTMe4Rwp7CUG2sMndVj79
         xHBW8EobX8o/4mMfQFhjVN8vZeoZO7RaY1MfoE9GZpKDVLytJ7QTNAIxTnuFmKjqO5s0
         8umw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692297447; x=1692902247;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uBOaXWWd2vWrevhZoLBbsrVmPNPdP6V7ftQYf0JoXBM=;
        b=ON5NT0M2YcFyCB1dhbF4bi12YVrtrxrBZdtj+nA52lbUITP/2le4yduaBMgLAj4t4f
         OrhCno7rf3KPnbUKeyGKY3S0P53Z5TgpYv8R5qQTsSTbLpdoPbvCZdzncGDY/HNqbtK3
         mqdSFJLAtz1gY2CRsxZ01UkV2HBC+hQK3+YVzHkqiKYuXeGe25Vt91w405inq7on38f2
         Bgs6vUf/ca05O4JjZhrTQu6h2ywg+iYH5hEFBrNhx98NGtIqXFax1nxMyHV+u4OFTlHI
         axFvX2CaecBLJPKslbhZPH1MElcakCH9VdEXW9RqbxsYPi92V2EmTM8RxipjpUB4jGWr
         JnXw==
X-Gm-Message-State: AOJu0Yy3rrHxj1+/fY7ehO7qPmk+8+wO1DpReswc9vQmozXOHK0GwGDE
        iRblniW0Mpn+JC3a968szai+q1PagglFQ9jIwwUTtqgjnqmDYraIiDhSYBrwR7WcGcN66PyJX3H
        JuSeHqvwlphf08fszJnSZ/zAQ5qDgsNsX3+54ziqhKDMOuKQFI7JNbv66sSrecio=
X-Google-Smtp-Source: AGHT+IGH/YjFsl7nQf7VJg0r3S5j6xp4O3vVjvKELyJ9Cr8ZLE3TYJyotVZgRmS6jWLDIZ0/VHZ0vX3ANkfgfA==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2d3:204:e60a:f80e:4b7a:6509])
 (user=steadmon job=sendgmr) by 2002:a0d:ec4a:0:b0:56c:e9fe:3cb4 with SMTP id
 r10-20020a0dec4a000000b0056ce9fe3cb4mr4306ywn.1.1692297447180; Thu, 17 Aug
 2023 11:37:27 -0700 (PDT)
Date:   Thu, 17 Aug 2023 11:37:20 -0700
In-Reply-To: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
Mime-Version: 1.0
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <cover.1692297001.git.steadmon@google.com>
Subject: [PATCH v7 0/3] Add unit test framework and project plan
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

Changes in v7:
- Fix corrupt diff in patch #2, sorry for the noise.

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

Range-diff against v6:
-:  ---------- > 1:  81c5148a12 unit tests: Add a project plan document
1:  ca284c575e ! 2:  3cc98d4045 unit tests: add TAP unit test framework
    @@ Commit message
         Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
         Signed-off-by: Josh Steadmon <steadmon@google.com>
    =20
    -    diff --git a/Makefile b/Makefile
    -    index e440728c24..4016da6e39 100644
    -
    -    --- a/Makefile
    -    +++ b/Makefile
    -    @@ -682,6 +682,8 @@ TEST_BUILTINS_OBJS =3D
    -     TEST_OBJS =3D
    -     TEST_PROGRAMS_NEED_X =3D
    -     THIRD_PARTY_SOURCES =3D
    -    +UNIT_TEST_PROGRAMS =3D
    -    +UNIT_TEST_DIR =3D t/unit-tests
    -
    -     # Having this variable in your environment would break pipelines =
because
    -     # you cause "cd" to echo its destination to stdout.  It can also =
take
    -    @@ -1331,6 +1333,12 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
    -     THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
    -     THIRD_PARTY_SOURCES +=3D sha1dc/%
    -
    -    +UNIT_TEST_PROGRAMS +=3D t-basic
    -    +UNIT_TEST_PROGRAMS +=3D t-strbuf
    -    +UNIT_TEST_PROGS =3D $(patsubst %,$(UNIT_TEST_DIR)/%$X,$(UNIT_TEST=
_PROGRAMS))
    -    +UNIT_TEST_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TEST_=
PROGRAMS))
    -    +UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
    -    +
    -     # xdiff and reftable libs may in turn depend on what is in libgit=
.a
    -     GITLIBS =3D common-main.o $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB=
) $(LIB_FILE)
    -     EXTLIBS =3D
    -    @@ -2672,6 +2680,7 @@ OBJECTS +=3D $(TEST_OBJS)
    -     OBJECTS +=3D $(XDIFF_OBJS)
    -     OBJECTS +=3D $(FUZZ_OBJS)
    -     OBJECTS +=3D $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
    -    +OBJECTS +=3D $(UNIT_TEST_OBJS)
    -
    -     ifndef NO_CURL
    -            OBJECTS +=3D http.o http-walker.o remote-curl.o
    -    @@ -3167,7 +3176,7 @@ endif
    -
    -     test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PR=
OGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
    -
    -    -all:: $(TEST_PROGRAMS) $(test_bindir_programs)
    -    +all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
    -
    -     bin-wrappers/%: wrap-for-bin.sh
    -            $(call mkdir_p_parent_template)
    -    @@ -3592,7 +3601,7 @@ endif
    -
    -     artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_=
PROGRAMS) \
    -                    GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_p=
rograms) \
    -    -               $(MOFILES)
    -    +               $(UNIT_TEST_PROGS) $(MOFILES)
    -            $(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
    -                    SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PER=
L_PATH_SQ)'
    -            test -n "$(ARTIFACTS_DIRECTORY)"
    -    @@ -3653,7 +3662,7 @@ clean: profile-clean coverage-clean coccicle=
an
    -            $(RM) $(OBJECTS)
    -            $(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_=
TEST_LIB)
    -            $(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_P=
ROGRAMS)
    -    -       $(RM) $(TEST_PROGRAMS)
    -    +       $(RM) $(TEST_PROGRAMS) $(UNIT_TEST_PROGS)
    -            $(RM) $(FUZZ_PROGRAMS)
    -            $(RM) $(SP_OBJ)
    -            $(RM) $(HCC)
    -    @@ -3831,3 +3840,12 @@ $(FUZZ_PROGRAMS): all
    -                    $(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_=
ENGINE) -o $@
    -
    -     fuzz-all: $(FUZZ_PROGRAMS)
    -    +
    -    +$(UNIT_TEST_PROGS): $(UNIT_TEST_DIR)/%$X: $(UNIT_TEST_DIR)/%.o $(=
UNIT_TEST_DIR)/test-lib.o $(GITLIBS) GIT-LDFLAGS
    -    +       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
    -    +               $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
    -    +
    -    +.PHONY: build-unit-tests unit-tests
    -    +build-unit-tests: $(UNIT_TEST_PROGS)
    -    +unit-tests: $(UNIT_TEST_PROGS)
    -    +       $(MAKE) -C t/ unit-tests
    -    diff --git a/t/Makefile b/t/Makefile
    -    index 3e00cdd801..92864cdf28 100644
    -    --- a/t/Makefile
    -    +++ b/t/Makefile
    -    @@ -41,6 +41,7 @@ TPERF =3D $(sort $(wildcard perf/p[0-9][0-9][0-9=
][0-9]-*.sh))
    -     TINTEROP =3D $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh=
))
    -     CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,$(wildcar=
d chainlint/*.test)))
    -     CHAINLINT =3D '$(PERL_PATH_SQ)' chainlint.pl
    -    +UNIT_TESTS =3D $(sort $(filter-out %.h %.c %.o unit-tests/t-basic=
%,$(wildcard unit-tests/*)))
    -
    -     # `test-chainlint` (which is a dependency of `test-lint`, `test` =
and `prove`)
    -     # checks all tests in all scripts via a single invocation, so tel=
l individual
    -    @@ -65,6 +66,13 @@ prove: pre-clean check-chainlint $(TEST_LINT)
    -     $(T):
    -            @echo "*** $@ ***"; '$(TEST_SHELL_PATH_SQ)' $@ $(GIT_TEST_=
OPTS)
    -
    -    +$(UNIT_TESTS):
    -    +       @echo "*** $@ ***"; $@
    -    +
    -    +.PHONY: unit-tests
    -    +unit-tests:
    -    +       @echo "*** prove - unit tests ***"; $(PROVE) $(GIT_PROVE_O=
PTS) $(UNIT_TESTS)
    -    +
    -     pre-clean:
    -            $(RM) -r '$(TEST_RESULTS_DIRECTORY_SQ)'
    -
    -    @@ -149,4 +157,4 @@ perf:
    -            $(MAKE) -C perf/ all
    -
    -     .PHONY: pre-clean $(T) aggregate-results clean valgrind perf \
    -    -       check-chainlint clean-chainlint test-chainlint
    -    +       check-chainlint clean-chainlint test-chainlint $(UNIT_TEST=
S)
    -    diff --git a/t/t0080-unit-test-output.sh b/t/t0080-unit-test-outpu=
t.sh
    -    new file mode 100755
    -    index 0000000000..c60e402260
    -    --- /dev/null
    -    +++ b/t/t0080-unit-test-output.sh
    -    @@ -0,0 +1,58 @@
    -    +#!/bin/sh
    -    +
    -    +test_description=3D'Test the output of the unit test framework'
    -    +
    -    +. ./test-lib.sh
    -    +
    -    +test_expect_success 'TAP output from unit tests' '
    -    +       cat >expect <<-EOF &&
    -    +       ok 1 - passing test
    -    +       ok 2 - passing test and assertion return 0
    -    +       # check "1 =3D=3D 2" failed at t/unit-tests/t-basic.c:68
    -    +       #    left: 1
    -    +       #   right: 2
    -    +       not ok 3 - failing test
    -    +       ok 4 - failing test and assertion return -1
    -    +       not ok 5 - passing TEST_TODO() # TODO
    -    +       ok 6 - passing TEST_TODO() returns 0
    -    +       # todo check ${SQ}check(x)${SQ} succeeded at t/unit-tests/=
t-basic.c:17
    -    +       not ok 7 - failing TEST_TODO()
    -    +       ok 8 - failing TEST_TODO() returns -1
    -    +       # check "0" failed at t/unit-tests/t-basic.c:22
    -    +       # skipping test - missing prerequisite
    -    +       # skipping check ${SQ}1${SQ} at t/unit-tests/t-basic.c:24
    -    +       ok 9 - test_skip() # SKIP
    -    +       ok 10 - skipped test returns 0
    -    +       # skipping test - missing prerequisite
    -    +       ok 11 - test_skip() inside TEST_TODO() # SKIP
    -    +       ok 12 - test_skip() inside TEST_TODO() returns 0
    -    +       # check "0" failed at t/unit-tests/t-basic.c:40
    -    +       not ok 13 - TEST_TODO() after failing check
    -    +       ok 14 - TEST_TODO() after failing check returns -1
    -    +       # check "0" failed at t/unit-tests/t-basic.c:48
    -    +       not ok 15 - failing check after TEST_TODO()
    -    +       ok 16 - failing check after TEST_TODO() returns -1
    -    +       # check "!strcmp("\thello\\\\", "there\"\n")" failed at t/=
unit-tests/t-basic.c:53
    -    +       #    left: "\011hello\\\\"
    -    +       #   right: "there\"\012"
    -    +       # check "!strcmp("NULL", NULL)" failed at t/unit-tests/t-b=
asic.c:54
    -    +       #    left: "NULL"
    -    +       #   right: NULL
    -    +       # check "${SQ}a${SQ} =3D=3D ${SQ}\n${SQ}" failed at t/unit=
-tests/t-basic.c:55
    -    +       #    left: ${SQ}a${SQ}
    -    +       #   right: ${SQ}\012${SQ}
    -    +       # check "${SQ}\\\\${SQ} =3D=3D ${SQ}\\${SQ}${SQ}" failed a=
t t/unit-tests/t-basic.c:56
    -    +       #    left: ${SQ}\\\\${SQ}
    -    +       #   right: ${SQ}\\${SQ}${SQ}
    -    +       not ok 17 - messages from failing string and char comparis=
on
    -    +       # BUG: test has no checks at t/unit-tests/t-basic.c:83
    -    +       not ok 18 - test with no checks
    -    +       ok 19 - test with no checks returns -1
    -    +       1..19
    -    +       EOF
    -    +
    -    +       ! "$GIT_BUILD_DIR"/t/unit-tests/t-basic >actual &&
    -    +       test_cmp expect actual
    -    +'
    -    +
    -    +test_done
    -    diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
    -    new file mode 100644
    -    index 0000000000..e292d58348
    -    --- /dev/null
    -    +++ b/t/unit-tests/.gitignore
    -    @@ -0,0 +1,2 @@
    -    +/t-basic
    -    +/t-strbuf
    -    diff --git a/t/unit-tests/t-basic.c b/t/unit-tests/t-basic.c
    -    new file mode 100644
    -    index 0000000000..ab0b7682c4
    -    --- /dev/null
    -    +++ b/t/unit-tests/t-basic.c
    -    @@ -0,0 +1,87 @@
    -    +#include "test-lib.h"
    -    +
    -    +/* Used to store the return value of check_int(). */
    -    +static int check_res;
    -    +
    -    +/* Used to store the return value of TEST(). */
    -    +static int test_res;
    -    +
    -    +static void t_res(int expect)
    -    +{
    -    +       check_int(check_res, =3D=3D, expect);
    -    +       check_int(test_res, =3D=3D, expect);
    -    +}
    -    +
    -    +static void t_todo(int x)
    -    +{
    -    +       check_res =3D TEST_TODO(check(x));
    -    +}
    -    +
    -    +static void t_skip(void)
    -    +{
    -    +       check(0);
    -    +       test_skip("missing prerequisite");
    -    +       check(1);
    -    +}
    -    +
    -    +static int do_skip(void)
    -    +{
    -    +       test_skip("missing prerequisite");
    -    +       return 0;
    -    +}
    -    +
    -    +static void t_skip_todo(void)
    -    +{
    -    +       check_res =3D TEST_TODO(do_skip());
    -    +}
    -    +
    -    +static void t_todo_after_fail(void)
    -    +{
    -    +       check(0);
    -    +       TEST_TODO(check(0));
    -    +}
    -    +
    -    +static void t_fail_after_todo(void)
    -    +{
    -    +       check(1);
    -    +       TEST_TODO(check(0));
    -    +       check(0);
    -    +}
    -    +
    -    +static void t_messages(void)
    -    +{
    -    +       check_str("\thello\\", "there\"\n");
    -    +       check_str("NULL", NULL);
    -    +       check_char('a', =3D=3D, '\n');
    -    +       check_char('\\', =3D=3D, '\'');
    -    +}
    -    +
    -    +static void t_empty(void)
    -    +{
    -    +       ; /* empty */
    -    +}
    -    +
    -    +int cmd_main(int argc, const char **argv)
    -    +{
    -    +       test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 1), "=
passing test");
    -    +       TEST(t_res(0), "passing test and assertion return 0");
    -    +       test_res =3D TEST(check_res =3D check_int(1, =3D=3D, 2), "=
failing test");
    -    +       TEST(t_res(-1), "failing test and assertion return -1");
    -    +       test_res =3D TEST(t_todo(0), "passing TEST_TODO()");
    -    +       TEST(t_res(0), "passing TEST_TODO() returns 0");
    -    +       test_res =3D TEST(t_todo(1), "failing TEST_TODO()");
    -    +       TEST(t_res(-1), "failing TEST_TODO() returns -1");
    -    +       test_res =3D TEST(t_skip(), "test_skip()");
    -    +       TEST(check_int(test_res, =3D=3D, 0), "skipped test returns=
 0");
    -    +       test_res =3D TEST(t_skip_todo(), "test_skip() inside TEST_=
TODO()");
    -    +       TEST(t_res(0), "test_skip() inside TEST_TODO() returns 0")=
;
    -    +       test_res =3D TEST(t_todo_after_fail(), "TEST_TODO() after =
failing check");
    -    +       TEST(check_int(test_res, =3D=3D, -1), "TEST_TODO() after f=
ailing check returns -1");
    -    +       test_res =3D TEST(t_fail_after_todo(), "failing check afte=
r TEST_TODO()");
    -    +       TEST(check_int(test_res, =3D=3D, -1), "failing check after=
 TEST_TODO() returns -1");
    -    +       TEST(t_messages(), "messages from failing string and char =
comparison");
    -    +       test_res =3D TEST(t_empty(), "test with no checks");
    -    +       TEST(check_int(test_res, =3D=3D, -1), "test with no checks=
 returns -1");
    -    +
    -    +       return test_done();
    -    +}
    -    diff --git a/t/unit-tests/t-strbuf.c b/t/unit-tests/t-strbuf.c
    -    new file mode 100644
    -    index 0000000000..561611e242
    -    --- /dev/null
    -    +++ b/t/unit-tests/t-strbuf.c
    -    @@ -0,0 +1,75 @@
    -    +#include "test-lib.h"
    -    +#include "strbuf.h"
    -    +
    -    +/* wrapper that supplies tests with an initialized strbuf */
    -    +static void setup(void (*f)(struct strbuf*, void*), void *data)
    -    +{
    -    +       struct strbuf buf =3D STRBUF_INIT;
    -    +
    -    +       f(&buf, data);
    -    +       strbuf_release(&buf);
    -    +       check_uint(buf.len, =3D=3D, 0);
    -    +       check_uint(buf.alloc, =3D=3D, 0);
    -    +       check(buf.buf =3D=3D strbuf_slopbuf);
    -    +       check_char(buf.buf[0], =3D=3D, '\0');
    -    +}
    -    +
    -    +static void t_static_init(void)
    -    +{
    -    +       struct strbuf buf =3D STRBUF_INIT;
    -    +
    -    +       check_uint(buf.len, =3D=3D, 0);
    -    +       check_uint(buf.alloc, =3D=3D, 0);
    -    +       if (check(buf.buf =3D=3D strbuf_slopbuf))
    -    +               return; /* avoid de-referencing buf.buf */
    -    +       check_char(buf.buf[0], =3D=3D, '\0');
    -    +}
    -    +
    -    +static void t_dynamic_init(void)
    -    +{
    -    +       struct strbuf buf;
    -    +
    -    +       strbuf_init(&buf, 1024);
    -    +       check_uint(buf.len, =3D=3D, 0);
    -    +       check_uint(buf.alloc, >=3D, 1024);
    -    +       check_char(buf.buf[0], =3D=3D, '\0');
    -    +       strbuf_release(&buf);
    -    +}
    -    +
    -    +static void t_addch(struct strbuf *buf, void *data)
    -    +{
    -    +       const char *p_ch =3D data;
    -    +       const char ch =3D *p_ch;
    -    +
    -    +       strbuf_addch(buf, ch);
    -    +       if (check_uint(buf->len, =3D=3D, 1) ||
    -    +           check_uint(buf->alloc, >, 1))
    -    +               return; /* avoid de-referencing buf->buf */
    -    +       check_char(buf->buf[0], =3D=3D, ch);
    -    +       check_char(buf->buf[1], =3D=3D, '\0');
    -    +}
    -    +
    -    +static void t_addstr(struct strbuf *buf, void *data)
    -    +{
    -    +       const char *text =3D data;
    -    +       size_t len =3D strlen(text);
    -    +
    -    +       strbuf_addstr(buf, text);
    -    +       if (check_uint(buf->len, =3D=3D, len) ||
    -    +           check_uint(buf->alloc, >, len) ||
    -    +           check_char(buf->buf[len], =3D=3D, '\0'))
    -    +           return;
    -    +       check_str(buf->buf, text);
    -    +}
    -    +
    -    +int cmd_main(int argc, const char **argv)
    -    +{
    -    +       if (TEST(t_static_init(), "static initialization works"))
    -    +               test_skip_all("STRBUF_INIT is broken");
    -    +       TEST(t_dynamic_init(), "dynamic initialization works");
    -    +       TEST(setup(t_addch, "a"), "strbuf_addch adds char");
    -    +       TEST(setup(t_addch, ""), "strbuf_addch adds NUL char");
    -    +       TEST(setup(t_addstr, "hello there"), "strbuf_addstr adds s=
tring");
    -    +
    -    +       return test_done();
    -    +}
    -    diff --git a/t/unit-tests/test-lib.c b/t/unit-tests/test-lib.c
    -    new file mode 100644
    -    index 0000000000..70030d587f
    -    --- /dev/null
    -    +++ b/t/unit-tests/test-lib.c
    -    @@ -0,0 +1,329 @@
    -    +#include "test-lib.h"
    -    +
    -    +enum result {
    -    +       RESULT_NONE,
    -    +       RESULT_FAILURE,
    -    +       RESULT_SKIP,
    -    +       RESULT_SUCCESS,
    -    +       RESULT_TODO
    -    +};
    -    +
    -    +static struct {
    -    +       enum result result;
    -    +       int count;
    -    +       unsigned failed :1;
    -    +       unsigned lazy_plan :1;
    -    +       unsigned running :1;
    -    +       unsigned skip_all :1;
    -    +       unsigned todo :1;
    -    +} ctx =3D {
    -    +       .lazy_plan =3D 1,
    -    +       .result =3D RESULT_NONE,
    -    +};
    -    +
    -    +static void msg_with_prefix(const char *prefix, const char *forma=
t, va_list ap)
    -    +{
    -    +       fflush(stderr);
    -    +       if (prefix)
    -    +               fprintf(stdout, "%s", prefix);
    -    +       vprintf(format, ap); /* TODO: handle newlines */
    -    +       putc('\n', stdout);
    -    +       fflush(stdout);
    -    +}
    -    +
    -    +void test_msg(const char *format, ...)
    -    +{
    -    +       va_list ap;
    -    +
    -    +       va_start(ap, format);
    -    +       msg_with_prefix("# ", format, ap);
    -    +       va_end(ap);
    -    +}
    -    +
    -    +void test_plan(int count)
    -    +{
    -    +       assert(!ctx.running);
    -    +
    -    +       fflush(stderr);
    -    +       printf("1..%d\n", count);
    -    +       fflush(stdout);
    -    +       ctx.lazy_plan =3D 0;
    -    +}
    -    +
    -    +int test_done(void)
    -    +{
    -    +       assert(!ctx.running);
    -    +
    -    +       if (ctx.lazy_plan)
    -    +               test_plan(ctx.count);
    -    +
    -    +       return ctx.failed;
    -    +}
    -    +
    -    +void test_skip(const char *format, ...)
    -    +{
    -    +       va_list ap;
    -    +
    -    +       assert(ctx.running);
    -    +
    -    +       ctx.result =3D RESULT_SKIP;
    -    +       va_start(ap, format);
    -    +       if (format)
    -    +               msg_with_prefix("# skipping test - ", format, ap);
    -    +       va_end(ap);
    -    +}
    -    +
    -    +void test_skip_all(const char *format, ...)
    -    +{
    -    +       va_list ap;
    -    +       const char *prefix;
    -    +
    -    +       if (!ctx.count && ctx.lazy_plan) {
    -    +               /* We have not printed a test plan yet */
    -    +               prefix =3D "1..0 # SKIP ";
    -    +               ctx.lazy_plan =3D 0;
    -    +       } else {
    -    +               /* We have already printed a test plan */
    -    +               prefix =3D "Bail out! # ";
    -    +               ctx.failed =3D 1;
    -    +       }
    -    +       ctx.skip_all =3D 1;
    -    +       ctx.result =3D RESULT_SKIP;
    -    +       va_start(ap, format);
    -    +       msg_with_prefix(prefix, format, ap);
    -    +       va_end(ap);
    -    +}
    -    +
    -    +int test__run_begin(void)
    -    +{
    -    +       assert(!ctx.running);
    -    +
    -    +       ctx.count++;
    -    +       ctx.result =3D RESULT_NONE;
    -    +       ctx.running =3D 1;
    -    +
    -    +       return ctx.skip_all;
    -    +}
    -    +
    -    +static void print_description(const char *format, va_list ap)
    -    +{
    -    +       if (format) {
    -    +               fputs(" - ", stdout);
    -    +               vprintf(format, ap);
    -    +       }
    -    +}
    -    +
    -    +int test__run_end(int was_run UNUSED, const char *location, const=
 char *format, ...)
    -    +{
    -    +       va_list ap;
    -    +
    -    +       assert(ctx.running);
    -    +       assert(!ctx.todo);
    -    +
    -    +       fflush(stderr);
    -    +       va_start(ap, format);
    -    +       if (!ctx.skip_all) {
    -    +               switch (ctx.result) {
    -    +               case RESULT_SUCCESS:
    -    +                       printf("ok %d", ctx.count);
    -    +                       print_description(format, ap);
    -    +                       break;
    -    +
    -    +               case RESULT_FAILURE:
    -    +                       printf("not ok %d", ctx.count);
    -    +                       print_description(format, ap);
    -    +                       break;
    -    +
    -    +               case RESULT_TODO:
    -    +                       printf("not ok %d", ctx.count);
    -    +                       print_description(format, ap);
    -    +                       printf(" # TODO");
    -    +                       break;
    -    +
    -    +               case RESULT_SKIP:
    -    +                       printf("ok %d", ctx.count);
    -    +                       print_description(format, ap);
    -    +                       printf(" # SKIP");
    -    +                       break;
    -    +
    -    +               case RESULT_NONE:
    -    +                       test_msg("BUG: test has no checks at %s", =
location);
    -    +                       printf("not ok %d", ctx.count);
    -    +                       print_description(format, ap);
    -    +                       ctx.result =3D RESULT_FAILURE;
    -    +                       break;
    -    +               }
    -    +       }
    -    +       va_end(ap);
    -    +       ctx.running =3D 0;
    -    +       if (ctx.skip_all)
    -    +               return 0;
    -    +       putc('\n', stdout);
    -    +       fflush(stdout);
    -    +       ctx.failed |=3D ctx.result =3D=3D RESULT_FAILURE;
    -    +
    -    +       return -(ctx.result =3D=3D RESULT_FAILURE);
    -    +}
    -    +
    -    +static void test_fail(void)
    -    +{
    -    +       assert(ctx.result !=3D RESULT_SKIP);
    -    +
    -    +       ctx.result =3D RESULT_FAILURE;
    -    +}
    -    +
    -    +static void test_pass(void)
    -    +{
    -    +       assert(ctx.result !=3D RESULT_SKIP);
    -    +
    -    +       if (ctx.result =3D=3D RESULT_NONE)
    -    +               ctx.result =3D RESULT_SUCCESS;
    -    +}
    -    +
    -    +static void test_todo(void)
    -    +{
    -    +       assert(ctx.result !=3D RESULT_SKIP);
    -    +
    -    +       if (ctx.result !=3D RESULT_FAILURE)
    -    +               ctx.result =3D RESULT_TODO;
    -    +}
    -    +
    -    +int test_assert(const char *location, const char *check, int ok)
    -    +{
    -    +       assert(ctx.running);
    -    +
    -    +       if (ctx.result =3D=3D RESULT_SKIP) {
    -    +               test_msg("skipping check '%s' at %s", check, locat=
ion);
    -    +               return 0;
    -    +       } else if (!ctx.todo) {
    -    +               if (ok) {
    -    +                       test_pass();
    -    +               } else {
    -    +                       test_msg("check \"%s\" failed at %s", chec=
k, location);
    -    +                       test_fail();
    -    +               }
    -    +       }
    -    +
    -    +       return -!ok;
    -    +}
    -    +
    -    +void test__todo_begin(void)
    -    +{
    -    +       assert(ctx.running);
    -    +       assert(!ctx.todo);
    -    +
    -    +       ctx.todo =3D 1;
    -    +}
    -    +
    -    +int test__todo_end(const char *location, const char *check, int r=
es)
    -    +{
    -    +       assert(ctx.running);
    -    +       assert(ctx.todo);
    -    +
    -    +       ctx.todo =3D 0;
    -    +       if (ctx.result =3D=3D RESULT_SKIP)
    -    +               return 0;
    -    +       if (!res) {
    -    +               test_msg("todo check '%s' succeeded at %s", check,=
 location);
    -    +               test_fail();
    -    +       } else {
    -    +               test_todo();
    -    +       }
    -    +
    -    +       return -!res;
    -    +}
    -    +
    -    +int check_bool_loc(const char *loc, const char *check, int ok)
    -    +{
    -    +       return test_assert(loc, check, ok);
    -    +}
    -    +
    -    +union test__tmp test__tmp[2];
    -    +
    -    +int check_int_loc(const char *loc, const char *check, int ok,
    -    +                 intmax_t a, intmax_t b)
    -    +{
    -    +       int ret =3D test_assert(loc, check, ok);
    -    +
    -    +       if (ret) {
    -    +               test_msg("   left: %"PRIdMAX, a);
    -    +               test_msg("  right: %"PRIdMAX, b);
    -    +       }
    -    +
    -    +       return ret;
    -    +}
    -    +
    -    +int check_uint_loc(const char *loc, const char *check, int ok,
    -    +                  uintmax_t a, uintmax_t b)
    -    +{
    -    +       int ret =3D test_assert(loc, check, ok);
    -    +
    -    +       if (ret) {
    -    +               test_msg("   left: %"PRIuMAX, a);
    -    +               test_msg("  right: %"PRIuMAX, b);
    -    +       }
    -    +
    -    +       return ret;
    -    +}
    -    +
    -    +static void print_one_char(char ch, char quote)
    -    +{
    -    +       if ((unsigned char)ch < 0x20u || ch =3D=3D 0x7f) {
    -    +               /* TODO: improve handling of \a, \b, \f ... */
    -    +               printf("\\%03o", (unsigned char)ch);
    -    +       } else {
    -    +               if (ch =3D=3D '\\' || ch =3D=3D quote)
    -    +                       putc('\\', stdout);
    -    +               putc(ch, stdout);
    -    +       }
    -    +}
    -    +
    -    +static void print_char(const char *prefix, char ch)
    -    +{
    -    +       printf("# %s: '", prefix);
    -    +       print_one_char(ch, '\'');
    -    +       fputs("'\n", stdout);
    -    +}
    -    +
    -    +int check_char_loc(const char *loc, const char *check, int ok, ch=
ar a, char b)
    -    +{
    -    +       int ret =3D test_assert(loc, check, ok);
    -    +
    -    +       if (ret) {
    -    +               fflush(stderr);
    -    +               print_char("   left", a);
    -    +               print_char("  right", b);
    -    +               fflush(stdout);
    -    +       }
    -    +
    -    +       return ret;
    -    +}
    -    +
    -    +static void print_str(const char *prefix, const char *str)
    -    +{
    -    +       printf("# %s: ", prefix);
    -    +       if (!str) {
    -    +               fputs("NULL\n", stdout);
    -    +       } else {
    -    +               putc('"', stdout);
    -    +               while (*str)
    -    +                       print_one_char(*str++, '"');
    -    +               fputs("\"\n", stdout);
    -    +       }
    -    +}
    -    +
    -    +int check_str_loc(const char *loc, const char *check,
    -    +                 const char *a, const char *b)
    -    +{
    -    +       int ok =3D (!a && !b) || (a && b && !strcmp(a, b));
    -    +       int ret =3D test_assert(loc, check, ok);
    -    +
    -    +       if (ret) {
    -    +               fflush(stderr);
    -    +               print_str("   left", a);
    -    +               print_str("  right", b);
    -    +               fflush(stdout);
    -    +       }
    -    +
    -    +       return ret;
    -    +}
    -    diff --git a/t/unit-tests/test-lib.h b/t/unit-tests/test-lib.h
    -    new file mode 100644
    -    index 0000000000..720c97c6f8
    -    --- /dev/null
    -    +++ b/t/unit-tests/test-lib.h
    -    @@ -0,0 +1,143 @@
    -    +#ifndef TEST_LIB_H
    -    +#define TEST_LIB_H
    -    +
    -    +#include "git-compat-util.h"
    -    +
    -    +/*
    -    + * Run a test function, returns 0 if the test succeeds, -1 if it
    -    + * fails. If test_skip_all() has been called then the test will n=
ot be
    -    + * run. The description for each test should be unique. For examp=
le:
    -    + *
    -    + *  TEST(test_something(arg1, arg2), "something %d %d", arg1, arg=
2)
    -    + */
    -    +#define TEST(t, ...)                                   \
    -    +       test__run_end(test__run_begin() ? 0 : (t, 1),   \
    -    +                     TEST_LOCATION(),  __VA_ARGS__)
    -    +
    -    +/*
    -    + * Print a test plan, should be called before any tests. If the n=
umber
    -    + * of tests is not known in advance test_done() will automaticall=
y
    -    + * print a plan at the end of the test program.
    -    + */
    -    +void test_plan(int count);
    -    +
    -    +/*
    -    + * test_done() must be called at the end of main(). It will print=
 the
    -    + * plan if plan() was not called at the beginning of the test pro=
gram
    -    + * and returns the exit code for the test program.
    -    + */
    -    +int test_done(void);
    -    +
    -    +/* Skip the current test. */
    -    +__attribute__((format (printf, 1, 2)))
    -    +void test_skip(const char *format, ...);
    -    +
    -    +/* Skip all remaining tests. */
    -    +__attribute__((format (printf, 1, 2)))
    -    +void test_skip_all(const char *format, ...);
    -    +
    -    +/* Print a diagnostic message to stdout. */
    -    +__attribute__((format (printf, 1, 2)))
    -    +void test_msg(const char *format, ...);
    -    +
    -    +/*
    -    + * Test checks are built around test_assert(). checks return 0 on
    -    + * success, -1 on failure. If any check fails then the test will
    -    + * fail. To create a custom check define a function that wraps
    -    + * test_assert() and a macro to wrap that function. For example:
    -    + *
    -    + *  static int check_oid_loc(const char *loc, const char *check,
    -    + *                          struct object_id *a, struct object_id=
 *b)
    -    + *  {
    -    + *         int res =3D test_assert(loc, check, oideq(a, b));
    -    + *
    -    + *         if (res) {
    -    + *                 test_msg("   left: %s", oid_to_hex(a);
    -    + *                 test_msg("  right: %s", oid_to_hex(a);
    -    + *
    -    + *         }
    -    + *         return res;
    -    + *  }
    -    + *
    -    + *  #define check_oid(a, b) \
    -    + *         check_oid_loc(TEST_LOCATION(), "oideq("#a", "#b")", a,=
 b)
    -    + */
    -    +int test_assert(const char *location, const char *check, int ok);
    -    +
    -    +/* Helper macro to pass the location to checks */
    -    +#define TEST_LOCATION() TEST__MAKE_LOCATION(__LINE__)
    -    +
    -    +/* Check a boolean condition. */
    -    +#define check(x)                               \
    -    +       check_bool_loc(TEST_LOCATION(), #x, x)
    -    +int check_bool_loc(const char *loc, const char *check, int ok);
    -    +
    -    +/*
    -    + * Compare two integers. Prints a message with the two values if =
the
    -    + * comparison fails. NB this is not thread safe.
    -    + */
    -    +#define check_int(a, op, b)                                      =
      \
    -    +       (test__tmp[0].i =3D (a), test__tmp[1].i =3D (b),          =
          \
    -    +        check_int_loc(TEST_LOCATION(), #a" "#op" "#b,            =
      \
    -    +                      test__tmp[0].i op test__tmp[1].i, a, b))
    -    +int check_int_loc(const char *loc, const char *check, int ok,
    -    +                 intmax_t a, intmax_t b);
    -    +
    -    +/*
    -    + * Compare two unsigned integers. Prints a message with the two v=
alues
    -    + * if the comparison fails. NB this is not thread safe.
    -    + */
    -    +#define check_uint(a, op, b)                                     =
      \
    -    +       (test__tmp[0].u =3D (a), test__tmp[1].u =3D (b),          =
          \
    -    +        check_uint_loc(TEST_LOCATION(), #a" "#op" "#b,           =
      \
    -    +                       test__tmp[0].u op test__tmp[1].u, a, b))
    -    +int check_uint_loc(const char *loc, const char *check, int ok,
    -    +                  uintmax_t a, uintmax_t b);
    -    +
    -    +/*
    -    + * Compare two chars. Prints a message with the two values if the
    -    + * comparison fails. NB this is not thread safe.
    -    + */
    -    +#define check_char(a, op, b)                                     =
      \
    -    +       (test__tmp[0].c =3D (a), test__tmp[1].c =3D (b),          =
          \
    -    +        check_char_loc(TEST_LOCATION(), #a" "#op" "#b,           =
      \
    -    +                       test__tmp[0].c op test__tmp[1].c, a, b))
    -    +int check_char_loc(const char *loc, const char *check, int ok,
    -    +                  char a, char b);
    -    +
    -    +/* Check whether two strings are equal. */
    -    +#define check_str(a, b)                                          =
              \
    -    +       check_str_loc(TEST_LOCATION(), "!strcmp("#a", "#b")", a, b=
)
    -    +int check_str_loc(const char *loc, const char *check,
    -    +                 const char *a, const char *b);
    -    +
    -    +/*
    -    + * Wrap a check that is known to fail. If the check succeeds then=
 the
    -    + * test will fail. Returns 0 if the check fails, -1 if it
    -    + * succeeds. For example:
    -    + *
    -    + *  TEST_TODO(check(0));
    -    + */
    -    +#define TEST_TODO(check) \
    -    +       (test__todo_begin(), test__todo_end(TEST_LOCATION(), #chec=
k, check))
    -    +
    -    +/* Private helpers */
    -    +
    -    +#define TEST__STR(x) #x
    -    +#define TEST__MAKE_LOCATION(line) __FILE__ ":" TEST__STR(line)
    -    +
    -    +union test__tmp {
    -    +       intmax_t i;
    -    +       uintmax_t u;
    -    +       char c;
    -    +};
    -    +
    -    +extern union test__tmp test__tmp[2];
    -    +
    -    +int test__run_begin(void);
    -    +__attribute__((format (printf, 3, 4)))
    -    +int test__run_end(int, const char *, const char *, ...);
    -    +void test__todo_begin(void);
    -    +int test__todo_end(const char *, const char *, int);
    -    +
    -    +#endif /* TEST_LIB_H */
    -
      ## Makefile ##
     @@ Makefile: TEST_BUILTINS_OBJS =3D
      TEST_OBJS =3D
2:  ea33518d00 =3D 3:  abf4dc41ac ci: run unit tests in CI

base-commit: a9e066fa63149291a55f383cfa113d8bdbdaa6b3
--=20
2.42.0.rc1.204.g551eb34607-goog

