Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E551B392A
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 10:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734086497; cv=none; b=AQ8e92Lwsa2/CswlcGbJdyvZmCljWzBmB4AuGc9irFOZpSUhp74IlC/+6ukkFCVRyhXIQjqAPIRu43KO3mnY/bL5jU+KkyR/7pdzE+tir6wimtmogQsfx/qF8/hjdHTu2BHEbdGkmKzcdzHkJfggwjFePS5zonYNZOEI3++CsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734086497; c=relaxed/simple;
	bh=kDFU+5ZQmzur6sP5WBF7ZBwt9cXceuqsfwTdIT7Z7WM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=texF6C0JeZJwYleNUiyStBXevJ1tfXtQ3m6RGjvoFXjf9O8xnIMOKNbKX3g/VOcgJzpS3MIOPsm+SY9PsTMWW5EUv3Nxs22l1BBCGfCFYNS6bohww2tcJohDCvmsj7mZNV0+Mm7ZwBMXTKzx11UXazep1RCMvjZBbh6QeRdvaGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fgRO9JZ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1EquDcjg; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fgRO9JZ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1EquDcjg"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7074A254009F;
	Fri, 13 Dec 2024 05:41:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 13 Dec 2024 05:41:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1734086493;
	 x=1734172893; bh=sEXD2QjxzdsRkZuA/6Oq3NWsWLozlsff45HXP1f3H5M=; b=
	fgRO9JZ31a2Ehfc1vxjjihBMkcRgMJ6mEc1tGLSPbAxdWpGOI39h1wvrz59/lvDX
	1n58HgZwUGHPBV+hcvprKqsRfZWFkvryqI7jqOgFI9rZ0jVOQ33Qbivefnvr2knV
	SGeOZzvXJWsMnjBg9ODna6BjAHOWhCF8n1zX/lYy1fejOV07TtuSmLhpC2t1y0yj
	bp+66FyBXl0kGKge4Wa/jowTHhwe5siFPpnCZuphU96dKwYLBsltuwUiX1mhs97b
	i2z+m9hy7UQM9PFc/wP1O08FqcbqNjM0hvp2M8lKgxFUy7ZiNIqQfcgivB/kWxwj
	KxIoc8WJfcsOElFOPuFfMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734086493; x=
	1734172893; bh=sEXD2QjxzdsRkZuA/6Oq3NWsWLozlsff45HXP1f3H5M=; b=1
	EquDcjgKX6aPSv3/+P2PmGBc29KVdreuFoRhPerRsmGhfvxhXsebIG17oL9vDKis
	e2uBX3abiPzX5NWMsxzUam5+JVEJ6Mz1k6U6EjHje1+PtqnoSLd0EMvsXmhgaU+x
	QicXe4mDv8HKOBkZobeS6U5FkDfuH4QH78lyUKl9zAs/gAUOEnLXjs3p+WdG50oS
	SKs7nYEgtq3CEiHhdeUyAxKdRqkuM+989QDcaxSiF4UGtK6ogXq/MRUjiQ8WpeWA
	TO8BQBhvlo/EIv9GzUvWoQeXpSLWOceAen/c1E7Ot1D/73lPIvSzKDmanJchMlwt
	ROtVJ4YSUuTH3FqvUfEwQ==
X-ME-Sender: <xms:XQ9cZ3TaKBr4i0lNgZsYafg1XQFKhzbPbjIkRqQkFmkPwkaqCZQQcA>
    <xme:XQ9cZ4xXjxpvm24v54APYHYrpg64f1W9CIlPeeP9XDiBl398TZDvHloTD-gK0EJjz
    h3eXIifjtP8WUP9sw>
X-ME-Received: <xmr:XQ9cZ81mICzRk1eWbRSga-Xhu9E8lOAQNA88g0qkRfzt-SuUaGHb7LPo8GRE5g3j6ylpIg8Ga8FsAZB5xCqDDpsLvzuuzBqRnoI2qYcmQ4Cw2eE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdehfefh
    geffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrg
    hrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:XQ9cZ3BfB7bjVR0WJ1IYvMYFhpfuwNA_8npSZiwvue7HoCKP6OnQcw>
    <xmx:XQ9cZwgHZnikENv7G4pR8narW4pwz0Dtkm-XXj4gYs2Qu2vz8S3GOQ>
    <xmx:XQ9cZ7rKCNrSpfA1D7uuktf_xupPrBl5GcKFCCHMA7TvQ8jwwJMDwA>
    <xmx:XQ9cZ7j-9l2lTEy_q1r9Tqkob1YAiO6WOlCaoKGju4d_MMu26CV9kw>
    <xmx:XQ9cZ5sNlkm4XF1cVtocwGL6gFVWMX9CQiZsLGK3xY4Xs6X7Vme0XuHP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 05:41:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0e143115 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Dec 2024 10:39:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/8] ci: wire up support for Meson
Date: Fri, 13 Dec 2024 11:41:15 +0100
Message-Id: <20241213-pks-meson-ci-v2-0-634affccc694@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsPXGcC/1XMywrCQAyF4VcpWRuZxFFbV76HdNFLaoP0wkQGp
 fTdHevK5Z9wvgVMgorBJVsgSFTTaUzBuwyavhrvgtqmBnbsibjA+WE4iE0jNop1ReLd6chdLZA
 mc5BOXxt3K1P3as8pvDc90vf6g5joH4qEDjlvKa994Q9nf03vvQ5Qruv6AfoIxQylAAAA
X-Change-ID: 20241129-pks-meson-ci-ba1e40652fbe
In-Reply-To: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
References: <20241211-pks-meson-ci-v1-0-28d18b494374@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series wires up Meson into our CI systems. The intent
is to ensure that it does not regress in functionality as the Git code
base evolves.

To help with keeping it up-to-date, both Meson and our Makefiles learn
to detect missing or superseded test files in "t/meson.build". This
should give users an early notification in case they have to add a newly
added or removed test to these build instructions. Overall I think that
this shouldn't be too much of a burden given that adding a new test is
trivial.

One gap that still exists is newly added code files. Due to many sources
being added to the build conditionally it's hard to have generic checks
for these. So I refrain from doing so in this series -- the build would
already fail anyway when we're missing code, so at least we will know
that something is up.

Changes in v2:

  - Improve a couple of commit messages.
  - Explain why we remove `-x` from the unit-test driver.
  - Remove unneeded `CC_PACKAGE` variable.
  - Improve error messages when tests weren't found.
  - Link to v1: https://lore.kernel.org/r/20241211-pks-meson-ci-v1-0-28d18b494374@pks.im

The series is built on top of caacdb5dfd (The fifteenth batch,
2024-12-10) with ps/build at 904339edbd (Introduce support for the Meson
build system, 2024-12-06) and cw/worktree-extension at 2037ca85ad
(worktree: refactor `repair_worktree_after_gitdir_move()`, 2024-11-29)
merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (8):
      ci/lib: support custom output directories when creating test artifacts
      Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
      t/unit-tests: rename clar-based unit tests to have a common prefix
      meson: detect missing tests at configure time
      Makefile: detect missing Meson tests
      t: fix out-of-tree tests for some git-p4 tests
      t: introduce compatibility options to clar-based tests
      ci: wire up Meson builds

 .github/workflows/main.yml                  |  7 ++++
 .gitlab-ci.yml                              |  8 +++++
 Makefile                                    |  5 ++-
 ci/install-dependencies.sh                  |  7 ++++
 ci/lib.sh                                   | 14 ++++----
 ci/print-test-failures.sh                   |  2 +-
 ci/run-build-and-tests.sh                   | 31 ++++++++++++++----
 meson.build                                 |  1 -
 parse-options.h                             | 12 +++++++
 t/Makefile                                  | 18 ++++++++++-
 t/meson.build                               | 40 +++++++++++++++++++++--
 t/t9835-git-p4-metadata-encoding-python2.sh | 50 ++++++++++++++---------------
 t/t9836-git-p4-metadata-encoding-python3.sh | 50 ++++++++++++++---------------
 t/unit-tests/generate-clar-decls.sh         |  5 ++-
 t/unit-tests/{ctype.c => u-ctype.c}         |  0
 t/unit-tests/{strvec.c => u-strvec.c}       |  0
 t/unit-tests/unit-test.c                    | 19 ++++++++++-
 17 files changed, 195 insertions(+), 74 deletions(-)

Range-diff versus v1:

1:  329404a926 = 1:  43562781da ci/lib: support custom output directories when creating test artifacts
2:  71a8cbc131 = 2:  f1655e9338 Makefile: drop -DSUPPRESS_ANNOTATED_LEAKS
3:  29e75b59e5 ! 3:  f5403a7ce0 t/unit-tests: rename clar-based unit tests to have a common prefix
    @@ Commit message
         t/unit-tests: rename clar-based unit tests to have a common prefix
     
         All of the code files for unit tests using the self-grown unit testing
    -    framework have have a "t-" prefix to their name. This makes it easy to
    +    framework have a "t-" prefix to their name. This makes it easy to
         identify them and use globbing in our Makefile and in other places. On
         the other hand though, our clar-based unit tests have no prefix at all
         and thus cannot easily be discerned from other files in the unit test
4:  644903d148 ! 4:  99a4ffdc2a meson: detect missing tests at configure time
    @@ t/meson.build: integration_tests = [
     +      endif
     +    endforeach
     +    if missing_tests.length() > 0
    -+      error('Missing tests:\n\n - ' + '\n - '.join(missing_tests))
    ++      error('Test files found, but not configured:\n\n - ' + '\n - '.join(missing_tests))
     +    endif
     +
     +    superfluous_tests = [ ]
    @@ t/meson.build: integration_tests = [
     +      endif
     +    endforeach
     +    if superfluous_tests.length() > 0
    -+      error('Superfluous tests:\n\n - ' + '\n - '.join(superfluous_tests))
    ++      error('Test files configured, but not found:\n\n - ' + '\n - '.join(superfluous_tests))
     +    endif
     +  endif
     +endforeach
5:  afad056353 = 5:  ce27e9c1a6 Makefile: detect missing Meson tests
6:  e398d80f77 ! 6:  8c46997ba4 t: fix out-of-tree tests for some git-p4 tests
    @@ Commit message
     
         Both t9835 and t9836 exercise git-p4, but one exercises Python 2 whereas
         the other one uses Python 3. These tests do not exercise "git p4", but
    -    instead they use "git p4.py" so that the unbuilt version of "git-p4.py"
    -    is used that has "#!/usr/bin/env python" as shebang instead of the
    -    replaced shebang.
    +    instead they use "git p4.py". This calls the unbuilt version of
    +    "git-p4.py" that still has the "#!/usr/bin/env python" shebang, which
    +    allows the test to modify which Python version comes first in $PATH,
    +    making it possible to force a Python version.
     
         But "git-p4.py" is not in our PATH during out-of-tree builds, and thus
         we cannot locate "git-p4.py". The tests thus break with CMake and Meson.
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/t9835-git-p4-metadata-encoding-python2.sh ##
    -@@ t/t9835-git-p4-metadata-encoding-python2.sh: python_target_version='2'
    +@@ t/t9835-git-p4-metadata-encoding-python2.sh: failing, and produces maximally sane output in git.'
    + 
    + . ./lib-git-p4.sh
    + 
    +-python_target_version='2'
    +-
    + ###############################
      ## SECTION REPEATED IN t9836 ##
      ###############################
      
7:  efa4698fee ! 7:  357f8e7e67 t: introduce compatibility options to clar-based tests
    @@ Commit message
         fail in case it is passed an unknown option. Stub out these options with
         no-ops to make our life a bit easier.
     
    +    Note that this also requires us to remove the `-x` short option for
    +    `--exclude`. This is because `-x` has another meaning in our integration
    +    tests, as it enables shell tracing. I doubt there are a lot of people
    +    out there using it as we only got a small hand full of clar tests in the
    +    first place. So better change it now so that we can in the long run
    +    improve compatibility between the two different test drivers.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## parse-options.h ##
8:  d6f7685eca ! 8:  c1c27341eb ci: wire up Meson builds
    @@ .gitlab-ci.yml: test:linux:
     +      - jobname: linux-meson
     +        image: ubuntu:latest
     +        CC: gcc
    -+        CC_PACKAGE: gcc
        artifacts:
          paths:
            - t/failed-test-artifacts

---
base-commit: 2fcbf72f13e8ce3bf1cda9a689f392f8f6e5c65d
change-id: 20241129-pks-meson-ci-ba1e40652fbe

