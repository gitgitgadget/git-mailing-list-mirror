Received: from pfout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EEB1C767C
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725354880; cv=none; b=Kz9Uw9dZsvdGfQufzJQOYrgN3L8ZqBGPSFyjn58RVRjuxrX90C+BvZl9zK2OKDilhOvmQ6BU9uR5qVdcevrB3BSHbY04RTN/lEghLOYR8kbBu1Wk7NQdu8kjtW05MHebJaR6qWRzc+LjT50lmqw4n81B+Z7eqS+99uK1xxkD218=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725354880; c=relaxed/simple;
	bh=2WK1OeEM5FNWbbToMUKPOG0S0qlhsBEYU1u2QnhRPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZEBY2ax5eqMFRjkia281BOIiARQe1yhsFx7aVnv+RHQDwO8n4wYIUApLceaw2sh24bDwFP1if/jR+yQHRBKGfQBHCipijPt62xZ7IdMaYh/QDpAXoVrAfKLPhjri2shHyzp6T1WZwCMZKZQ6XyqjyarJGceT5h+BOPmoeqO9i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hOvpr2VI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+v7gEBa; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hOvpr2VI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+v7gEBa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FB7B1380393;
	Tue,  3 Sep 2024 05:14:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 03 Sep 2024 05:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725354877; x=1725441277; bh=lbJ/0ptIi6
	LBrvhFiKsBIqsphi/B5TNPBu6CqpGC/ho=; b=hOvpr2VIDmuEViKfrufocyV72b
	3sDR2xou+4TS1dWoA8NwoNUNtVrNLLykBKQ5XI0jWTYZS0OE/xxcNaAEY1WCqwOq
	AqmnoEAsAdxO83LpresWIcz/TtI+jRPdwyCKXrRA8LCcapBQAlBTzAdKnel4mAVF
	AOh3Gw/BIi72lBXjKf06B0SgR7dBnloNyA0PIBxymSJYrsbq3rT/e5Lwh8L+uqI+
	LLn+mp6JsynFqbRaN42oaOlMudlWpUaEJHneIGVqijN2iwNeVshJB4HnpEuN+3nM
	M1hnbCq7jZbYU8mr2xlEsY43yuosFQrv1O/FEOnuDde/H+Z3JYv8YpqkzcNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725354877; x=1725441277; bh=lbJ/0ptIi6LBrvhFiKsBIqsphi/B
	5TNPBu6CqpGC/ho=; b=F+v7gEBaagpl7JgjLpdmB7kHuHoU3/VkJv9chrV1MvsD
	pWXu+gDOB2fxmX65YpsCUQ5NwvN6N3c9T1tRrGKXnJTdn2TxLqyfOBF0guslIR6C
	sFl8dHTEPgDyvoaZwYVzNh0JI7rfg24E9Q3+QJLt9u718V3bKeMrbf2yEZX2EbEf
	Fkei5APwOQ5sUCiPKV6CX3rn5eKHznIz26W3ys2gXhZdJtq5ixFgjQoWf8aDnuMM
	LeszeogzqS+EYupQ5+wDfUDvY/68GPz8lnOR5tKF4SRfkyNe3qYOxa75b0QfDEss
	20njlCTxKgYsM36h0VvG0UQRU6s4Jzvxe1z2j+yzDQ==
X-ME-Sender: <xms:fNPWZshFLMSGVZXRRtxA6BWQfuKsXU6DnLijUUpPHRHOcGbO9BYyEg>
    <xme:fNPWZlCC4Vke9kYJF8F2mpBI-N48ZcjOhnQbI4r8FLn9LIdAlikV8kqV2iZeoHOG6
    2mxAXefVP6vOgLhIA>
X-ME-Received: <xmr:fNPWZkG0OFm8J896VoalnXMRe7rkFz_2kb1Va495MQNCUcnpXyokr0xLU3-6jf1MGj1UL0CdDGpBz2phXnG4AQPLQe94o9XtMm2ycPcsyw3zLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhr
    ghdruhhkpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepshhtvg
    grughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghho
    ohhglhgvrdgtohhmpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgughgvrd
    gtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:fNPWZtSR5r1T1n3Pu2ixLHwUNuWSHfbKV8hj5q2yk2GBjHPpiGiDcA>
    <xmx:fNPWZpxT5IX9B8Y83ZnhNcwXnBj7cwYuomgdAIrbQj0r8dQAFZV_DQ>
    <xmx:fNPWZr5dDALo3dttv-z-ve06bkXxhjxIV0RJNmJHxrQlmssJ7vc7cg>
    <xmx:fNPWZmwvQp1v0BWAMdmcuMqqguegZbHhsOV6TlY0_grWP0cQXODXFA>
    <xmx:fdPWZpfP07Xe1KXcaTeHf5K0vjhinEqPee_hCy5TPmdT36XrYgBj-StE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Sep 2024 05:14:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da5fd14f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Sep 2024 09:14:26 +0000 (UTC)
Date: Tue, 3 Sep 2024 11:14:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7 00/14] Introduce clar testing framework
Message-ID: <cover.1725349234.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>

Hi,

this is the seventh version fo my patch series that introduces the clar
unit testing framework.

Changes compared to v6:

  - Add some explanations for why we introduce clar in the first place
    to the second commit message.

  - Split out implementation of the test driver, that is the main
    function, into a separate commit.

  - Reimplement argument parsing ourselves. This allows more flexibility
    and gets rid of some options that do not make sense for us.

  - Add an empty line between declarations and code.

  - Improve the test messages in ctype tests to also mention our
    expectations.

  - Adapt `cl_failf()` to not use `xstrfmt()`, but `snprintf()` with a
    static buffer instead.

Thanks!

Patrick

Johannes Schindelin (4):
  clar: avoid compile error with mingw-w64
  clar(win32): avoid compile error due to unused `fs_copy()`
  clar: stop including `shellapi.h` unnecessarily
  clar: add CMake support

Patrick Steinhardt (10):
  t: do not pass GIT_TEST_OPTS to unit tests with prove
  t: import the clar unit testing framework
  t/clar: fix compatibility with NonStop
  Makefile: fix sparse dependency on GENERATED_H
  Makefile: make hdr-check depend on generated headers
  Makefile: do not use sparse on third-party sources
  Makefile: wire up the clar unit testing framework
  t/unit-tests: implement test driver
  t/unit-tests: convert strvec tests to use clar
  t/unit-tests: convert ctype tests to use clar

 .gitignore                                 |   1 +
 Documentation/technical/unit-tests.txt     |   2 +
 Makefile                                   |  53 +-
 contrib/buildsystems/CMakeLists.txt        |  53 ++
 t/Makefile                                 |   4 +-
 t/run-test.sh                              |   2 +-
 t/unit-tests/.gitignore                    |   2 +
 t/unit-tests/clar-generate.awk             |  50 ++
 t/unit-tests/clar/.github/workflows/ci.yml |  23 +
 t/unit-tests/clar/COPYING                  |  15 +
 t/unit-tests/clar/README.md                | 329 ++++++++
 t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
 t/unit-tests/clar/clar.h                   | 173 +++++
 t/unit-tests/clar/clar/fixtures.h          |  50 ++
 t/unit-tests/clar/clar/fs.h                | 524 +++++++++++++
 t/unit-tests/clar/clar/print.h             | 211 ++++++
 t/unit-tests/clar/clar/sandbox.h           | 159 ++++
 t/unit-tests/clar/clar/summary.h           | 143 ++++
 t/unit-tests/clar/generate.py              | 266 +++++++
 t/unit-tests/clar/test/.gitignore          |   4 +
 t/unit-tests/clar/test/Makefile            |  39 +
 t/unit-tests/clar/test/clar_test.h         |  16 +
 t/unit-tests/clar/test/main.c              |  40 +
 t/unit-tests/clar/test/main.c.sample       |  27 +
 t/unit-tests/clar/test/resources/test/file |   1 +
 t/unit-tests/clar/test/sample.c            |  84 ++
 t/unit-tests/{t-ctype.c => ctype.c}        |  71 +-
 t/unit-tests/strvec.c                      | 241 ++++++
 t/unit-tests/t-strvec.c                    | 211 ------
 t/unit-tests/unit-test.c                   |  45 ++
 t/unit-tests/unit-test.h                   |  10 +
 31 files changed, 3457 insertions(+), 234 deletions(-)
 create mode 100644 t/unit-tests/clar-generate.awk
 create mode 100644 t/unit-tests/clar/.github/workflows/ci.yml
 create mode 100644 t/unit-tests/clar/COPYING
 create mode 100644 t/unit-tests/clar/README.md
 create mode 100644 t/unit-tests/clar/clar.c
 create mode 100644 t/unit-tests/clar/clar.h
 create mode 100644 t/unit-tests/clar/clar/fixtures.h
 create mode 100644 t/unit-tests/clar/clar/fs.h
 create mode 100644 t/unit-tests/clar/clar/print.h
 create mode 100644 t/unit-tests/clar/clar/sandbox.h
 create mode 100644 t/unit-tests/clar/clar/summary.h
 create mode 100755 t/unit-tests/clar/generate.py
 create mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/Makefile
 create mode 100644 t/unit-tests/clar/test/clar_test.h
 create mode 100644 t/unit-tests/clar/test/main.c
 create mode 100644 t/unit-tests/clar/test/main.c.sample
 create mode 100644 t/unit-tests/clar/test/resources/test/file
 create mode 100644 t/unit-tests/clar/test/sample.c
 rename t/unit-tests/{t-ctype.c => ctype.c} (68%)
 create mode 100644 t/unit-tests/strvec.c
 delete mode 100644 t/unit-tests/t-strvec.c
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

Range-diff against v6:
 1:  e48a6461137 =  1:  b67f10ec0b0 t: do not pass GIT_TEST_OPTS to unit tests with prove
 2:  1710e9f9ff7 !  2:  55a9b46e65f t: import the clar unit testing framework
    @@ Metadata
      ## Commit message ##
         t: import the clar unit testing framework
     
    +    Our unit testing framework is a homegrown solution. While it supports
    +    most of our needs, it is likely that the volume of unit tests will grow
    +    quite a bit in the future such that we can exercise low-level subsystems
    +    directly. This surfaces several shortcomings that the current solution
    +    has:
    +
    +      - There is no way to run only one specific tests. While some of our
    +        unit tests wire this up manually, others don't. In general, it
    +        requires quite a bit of boilerplate to get this set up correctly.
    +
    +      - Failures do not cause a test to stop execution directly. Instead,
    +        the test author needs to return manually whenever an assertion
    +        fails. This is rather verbose and is not done correctly in most of
    +        our unit tests.
    +
    +      - Wiring up a new testcase requires both implementing the test
    +        function and calling it in the respective test suite's main
    +        function, which is creating code duplication.
    +
    +    We can of course fix all of these issues ourselves, but that feels
    +    rather pointless when there are already so many unit testing frameworks
    +    out there that have those features.
    +
    +    We line out some requirements for any unit testing framework in
    +    "Documentation/technical/unit-tests.txt". The "clar" unit testing
    +    framework, which isn't listed in that table yet, ticks many of the
    +    boxes:
    +
    +      - It is licensed under ISC, which is compatible.
    +
    +      - It is easily vendorable because it is rather tiny at around 1200
    +        lines of code.
    +
    +      - It is easily hackable due to the same reason.
    +
    +      - It has TAP support.
    +
    +      - It has skippable tests.
    +
    +      - It preprocesses test files in order to extract test functions, which
    +        then get wired up automatically.
    +
    +    While it's not perfect, the fact that clar originates from the libgit2
    +    project means that it should be rather easy for us to collaborate with
    +    upstream to plug any gaps.
    +
         Import the clar unit testing framework at commit 1516124 (Merge pull
         request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
         will be wired up in subsequent commits.
 3:  5c21aa87aa2 =  3:  f24401f0a87 t/clar: fix compatibility with NonStop
 4:  06d2bce0d82 =  4:  658a601c541 clar: avoid compile error with mingw-w64
 5:  f88b3421a09 =  5:  0b8a6ac5fed clar(win32): avoid compile error due to unused `fs_copy()`
 6:  5fb4c55be33 =  6:  c50e7a0ea68 clar: stop including `shellapi.h` unnecessarily
 7:  e0dcbd5ca83 =  7:  b8f3f16dd27 Makefile: fix sparse dependency on GENERATED_H
 8:  77a03f8df70 =  8:  3d3fe443b9a Makefile: make hdr-check depend on generated headers
 9:  c91dd7327e3 =  9:  7d0f494850a Makefile: do not use sparse on third-party sources
10:  115c15aa9ae ! 10:  9c74c5ae019 Makefile: wire up the clar unit testing framework
    @@ Commit message
         anything. Thus, it would cause a compiler error if a function name was
         mistyped and thus not picked up by "generate.py".
     
    +    The test driver "unit-test.c" is an empty stub for now. It will get
    +    implemented in the next commit.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## .gitignore ##
    @@ t/unit-tests/unit-test.c (new)
     @@
     +#include "unit-test.h"
     +
    -+int cmd_main(int argc, const char **argv)
    ++int cmd_main(int argc UNUSED, const char **argv UNUSED)
     +{
    -+	const char **argv_copy;
    -+	int ret;
    -+
    -+	/* Append the "-t" flag such that the tests generate TAP output. */
    -+	ALLOC_ARRAY(argv_copy, argc + 2);
    -+	COPY_ARRAY(argv_copy, argv, argc);
    -+	argv_copy[argc++] = "-t";
    -+	argv_copy[argc] = NULL;
    -+
    -+	ret = clar_test(argc, (char **) argv_copy);
    -+
    -+	free(argv_copy);
    -+	return ret;
    ++	return 0;
     +}
     
      ## t/unit-tests/unit-test.h (new) ##
 -:  ----------- > 11:  8bd5b3e2b29 t/unit-tests: implement test driver
11:  b3b8df04872 ! 12:  3c3b9eacdfb t/unit-tests: convert strvec tests to use clar
    @@ Commit message
         clar-based tests looks like.
     
         The tests are part of the "t/unit-tests/bin/unit-tests" binary. When
    -    running that binary, it generates TAP output:
    +    running that binary with an injected error, it generates TAP output:
     
             # ./t/unit-tests/bin/unit-tests
             TAP version 13
    @@ Commit message
             ok 1 - strvec::init
             ok 2 - strvec::dynamic_init
             ok 3 - strvec::clear
    -        ok 4 - strvec::push
    -        ok 5 - strvec::pushft_pushf
    +        not ok 4 - strvec::push
    +            ---
    +            reason: |
    +              String mismatch: (&vec)->v[i] != expect[i]
    +              'foo' != 'fo' (at byte 2)
    +            at:
    +              file: 't/unit-tests/strvec.c'
    +              line: 48
    +              function: 'test_strvec__push'
    +            ---
    +        ok 5 - strvec::pushf
             ok 6 - strvec::pushl
             ok 7 - strvec::pushv
             ok 8 - strvec::replace_at_head
    @@ t/unit-tests/strvec.c (new)
     +#define check_strvec(vec, ...) \
     +	do { \
     +		const char *expect[] = { __VA_ARGS__ }; \
    -+		cl_assert(ARRAY_SIZE(expect) > 0); \
    -+		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
    -+		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
    ++		size_t expect_len = ARRAY_SIZE(expect); \
    ++		cl_assert(expect_len > 0); \
    ++		cl_assert_equal_p(expect[expect_len - 1], NULL); \
    ++		cl_assert_equal_i((vec)->nr, expect_len - 1); \
     +		cl_assert((vec)->nr <= (vec)->alloc); \
    -+		for (size_t i = 0; i < ARRAY_SIZE(expect); i++) \
    ++		for (size_t i = 0; i < expect_len; i++) \
     +			cl_assert_equal_s((vec)->v[i], expect[i]); \
     +	} while (0)
     +
     +void test_strvec__init(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	cl_assert_equal_p(vec.v, empty_strvec);
     +	cl_assert_equal_i(vec.nr, 0);
     +	cl_assert_equal_i(vec.alloc, 0);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__dynamic_init(void)
     +{
     +	struct strvec vec;
    ++
     +	strvec_init(&vec);
     +	cl_assert_equal_p(vec.v, empty_strvec);
     +	cl_assert_equal_i(vec.nr, 0);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__clear(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_push(&vec, "foo");
     +	strvec_clear(&vec);
     +	cl_assert_equal_p(vec.v, empty_strvec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__pushf(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushf(&vec, "foo: %d", 1);
     +	check_strvec(&vec, "foo: 1", NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__pushl(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	check_strvec(&vec, "foo", "bar", "baz", NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__replace_at_head(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_replace(&vec, 0, "replaced");
     +	check_strvec(&vec, "replaced", "bar", "baz", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__replace_in_between(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_replace(&vec, 1, "replaced");
     +	check_strvec(&vec, "foo", "replaced", "baz", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__replace_with_substring(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", NULL);
     +	strvec_replace(&vec, 0, vec.v[0] + 1);
     +	check_strvec(&vec, "oo", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__remove_at_head(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_remove(&vec, 0);
     +	check_strvec(&vec, "bar", "baz", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__remove_at_tail(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_remove(&vec, 2);
     +	check_strvec(&vec, "foo", "bar", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__remove_in_between(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_remove(&vec, 1);
     +	check_strvec(&vec, "foo", "baz", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__pop_empty_array(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pop(&vec);
     +	check_strvec(&vec, NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__pop_non_empty_array(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_pushl(&vec, "foo", "bar", "baz", NULL);
     +	strvec_pop(&vec);
     +	check_strvec(&vec, "foo", "bar", NULL);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__split_empty_string(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_split(&vec, "");
     +	check_strvec(&vec, NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__split_single_item(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_split(&vec, "foo");
     +	check_strvec(&vec, "foo", NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__split_multiple_items(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_split(&vec, "foo bar baz");
     +	check_strvec(&vec, "foo", "bar", "baz", NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__split_whitespace_only(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_split(&vec, " \t\n");
     +	check_strvec(&vec, NULL);
     +	strvec_clear(&vec);
    @@ t/unit-tests/strvec.c (new)
     +void test_strvec__split_multiple_consecutive_whitespaces(void)
     +{
     +	struct strvec vec = STRVEC_INIT;
    ++
     +	strvec_split(&vec, "foo\n\t bar");
     +	check_strvec(&vec, "foo", "bar", NULL);
     +	strvec_clear(&vec);
12:  1ac2e48a7f2 ! 13:  c8360db2f86 t/unit-tests: convert ctype tests to use clar
    @@ Commit message
         on failure:
     
             # start of suite 1: ctype
    -        ok 1 - ctype::isspace
    -        not ok 2 - ctype::isdigit
    +        not ok 1 - ctype::isspace
                 ---
                 reason: |
                   Test failed.
    -              0x61 is classified incorrectly
    +              0x0d is classified incorrectly: expected 0, got 1
                 at:
                   file: 't/unit-tests/ctype.c'
    -              line: 38
    -              function: 'test_ctype__isdigit'
    +              line: 36
    +              function: 'test_ctype__isspace'
                 ---
    +        ok 2 - ctype::isdigit
             ok 3 - ctype::isalpha
             ok 4 - ctype::isalnum
             ok 5 - ctype::is_glob_special
    @@ t/unit-tests/t-ctype.c => t/unit-tests/ctype.c
     -				test_msg("      i: 0x%02x", i); \
     -		} \
     -		check(!class(EOF)); \
    --	} \
    -+	for (int i = 0; i < 256; i++) \
    -+		if (class(i) != !!memchr(string, i, len)) \
    -+			cl_failf("0x%02x is classified incorrectly", i); \
    ++	for (int i = 0; i < 256; i++) { \
    ++		int actual = class(i), expect = !!memchr(string, i, len); \
    ++		if (actual != expect) \
    ++			cl_failf("0x%02x is classified incorrectly: expected %d, got %d", \
    ++				 i, expect, actual); \
    + 	} \
     +	cl_assert(!class(EOF)); \
      } while (0)
      
    @@ t/unit-tests/unit-test.h
     +#include "strbuf.h"
     +
     +#define cl_failf(fmt, ...) do { \
    -+	char *desc = xstrfmt(fmt, __VA_ARGS__); \
    ++	char desc[4096]; \
    ++	snprintf(desc, sizeof(desc), fmt, __VA_ARGS__); \
     +	clar__fail(__FILE__, __func__, __LINE__, "Test failed.", desc, 1); \
    -+	free(desc); \
     +} while (0)
13:  131036c398e = 14:  d51c146cd9d clar: add CMake support
-- 
2.46.0.421.g159f2d50e7.dirty

