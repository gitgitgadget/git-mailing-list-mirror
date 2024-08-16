Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592C7E0FF
	for <git@vger.kernel.org>; Fri, 16 Aug 2024 07:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723793776; cv=none; b=hznnQzx0mfOq4cwK9RDVe4z6qrnX7duoVzyaHpg1Ou8982XJ86nltVe9mmitaYEn2/y7nLtdRCkXUOwaoJw5opGGnB7BeTpX8X07vHC1we0/rz3iJnJ9lQqGloRGAPlYEbGEUIylkcj1mKbUqTtrDElrd+W+kn9sP9HAYuOxbAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723793776; c=relaxed/simple;
	bh=YouVAwT5FQ+rXh3toseoJ0CPGAndIryC1fy6m4IPsh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6XdOKcOBWftaPBYgr5r48jr9AQXDyGNnhdel5rJuCM2LEbbG73pfkIVK0CkXeAM3o+tLngVPLo3e4v1EtSWjqCk2rtnnbHdvVA9/euNk5qp6i/SVOtXekhUj365Sy7oLOBGIs2fZ4uM++zul/VaVFBxZRulFd0pGdjkx7+D4pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ImaDiEY4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RsQAhlDw; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ImaDiEY4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RsQAhlDw"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6A007138A657;
	Fri, 16 Aug 2024 03:04:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 16 Aug 2024 03:04:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723791879; x=1723878279; bh=EBd/SmdyIg
	r/P2oBj0e8qukGpwJQJ28cW6Kbj/n9uvg=; b=ImaDiEY44TBBqokzORUdwIcwXX
	HpKanrM3nYkGvVK7N4pPtE2HcZciUhoh6KgxKgeDnvcD855XXOhj3MZxYrCAxCA1
	519yHg5wFO/ga3yXeV5CySf9LNUV3IuUaew5T0Cq56VMaZ8xxAND1b0U3piooVyi
	M9LA6QNj+iecCK2RUTR+1c29f2wOxb8xQ2Aw6t6oWg4Wj3dgL1HPxdD3zmARFOwU
	vmrmMh7YQ9Uirg2JvVqVFKpCNH2tqwcZkZZpRIyBqzBwSYGdXLTHB38LuIqZwiOS
	ZpY0l6kAlo4BEvRS+vKopBETbuZ+5ZGZD2h6aK/dE+3ZZaShy5jAlSrLBhEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723791879; x=1723878279; bh=EBd/SmdyIgr/P2oBj0e8qukGpwJQ
	J28cW6Kbj/n9uvg=; b=RsQAhlDw+VYCSy9LdbPu2G0GsHwmCayhTsy1Bi/vTyIS
	RwzXMhLosd74O0Q4Lj7/ag9dKqnZyplnpV79rgexdapTQKEWjl9EeJ4mQfej2YKg
	bJDdwewKi1RpRoC6o/tbqbAuE2+pTzqeKkhvMUxHec0zcjVLjDSSZRBjuTXJgSsE
	oYByrtrRolmD6IMCrT0CoBtyOrUkapwpVPrIv0hiQ2CsfGpU7eF5mKBCuIyfQ6ny
	nA1pbRjwYpBWbYYrOqA6S9oLTHtiCpg4DuKMi9JVWXXHatWx77bFSB9+uBqiMgzl
	we5g5yqe8iilIkRoZY36lFoaMrtBGpuz8timzjNXBA==
X-ME-Sender: <xms:Bvq-ZnBUfe7028Mrc_TlTPhFe8RQCHV9s_LSOfa8MhbVkrob-KNL1A>
    <xme:Bvq-Ztivb2S_eZY86ou475w6Fpj8hJUqaiyxlPHAHhEd83fY7AqE-RY548e6Oxwgo
    KK2mx6hFXIQFSamaw>
X-ME-Received: <xmr:Bvq-ZilHCn4hGX_6AXpCBJ2g-707O5Ts317pQMzqTgERyxDZ6iTFAJ0jT98emzf7W2lSg5F6rom3h8-yv2i2Nr4pkosywUyOSNfWOT_fRIT11bQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtjedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhiefgvdffvddtuefhlefgleehgfefveeuteffudfg
    heetgfevlefhueeuveeuvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggs
    rdguvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprh
    gtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshhonhesvggufigr
    rhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglh
    gvrdgtohhm
X-ME-Proxy: <xmx:Bvq-ZpyO_lJnt7WdegTx-v7Bmnbku2dnTkmFNPnPfJ6UWsiNliKj6w>
    <xmx:B_q-ZsSklgZHyMK5yaaW4Dq7SGXSqHF61U90OQUyxISqhtr2eec10w>
    <xmx:B_q-ZsbbwoNRFFPKQUPG_204Z5iMema1237wRjqhqQjTXGl0yi2nXA>
    <xmx:B_q-ZtQIkewZ1PL9nBEwXy54YXj58FWgCuD7VRtBuapgyvyNskftwQ>
    <xmx:B_q-ZvFLbevnc_GtMK3sIGiTQIriB82Pat7iaLaJ79SXX6HCBZ0nBP7C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Aug 2024 03:04:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a73775c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 16 Aug 2024 07:04:13 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:04:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v5 0/9] Introduce clar testing framework
Message-ID: <cover.1723791831.git.ps@pks.im>
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

this is the fifth version of my patch series that introduces the clar
testing framework for our unit tests.

Changes compared to v4:

  - The whitespace fixes have been merged upstream, so I've updated the
    embedded copy of clar and dropped the subsequent patch that fixed
    them in our copy. The NonStop compatibility fixes have not yet been
    merged as the pull request needs some more work.

  - Both "clar-decls.h" and "clar.suite" are now part of GENERATED_H.
    This brings removal of these files via "make clean" for free.

  - The "sparse" target already depends on GENERATED_H, but in a broken
    way. I've fixed that in a new commit.

  - The "sparse" target no longer checks external sources, including the
    clar sources.

  - The "hdr-check" target now depends on GENERATED_H, as well. This
    avoids having to manually wire up dependencies on generated headers
    per file, which seems rather unmaintainable to me.

With this, the "hdr-check" and "sparse" targets all work on my machine
now.

Thanks!

Patrick

Patrick Steinhardt (9):
  t: do not pass GIT_TEST_OPTS to unit tests with prove
  t: import the clar unit testing framework
  t/clar: fix compatibility with NonStop
  Makefile: fix sparse dependency on GENERATED_H
  Makefile: make hdr-check depend on generated headers
  Makefile: do not use sparse on third-party sources
  Makefile: wire up the clar unit testing framework
  t/unit-tests: convert strvec tests to use clar
  t/unit-tests: convert ctype tests to use clar

 .gitignore                                 |   1 +
 Documentation/technical/unit-tests.txt     |   2 +
 Makefile                                   |  53 +-
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
 t/unit-tests/clar/clar/fs.h                | 522 +++++++++++++
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
 t/unit-tests/{t-strvec.c => strvec.c}      | 119 ++-
 t/unit-tests/unit-test.c                   |  17 +
 t/unit-tests/unit-test.h                   |   3 +
 29 files changed, 3166 insertions(+), 102 deletions(-)
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
 rename t/unit-tests/{t-ctype.c => ctype.c} (71%)
 rename t/unit-tests/{t-strvec.c => strvec.c} (54%)
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

Range-diff against v4:
 1:  086dd728a7 !  1:  832dc0496f t: do not pass GIT_TEST_OPTS to unit tests with prove
    @@ Commit message
         environment variable. Like this, we can conditionally forward it to our
         test scripts, only.
     
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## t/Makefile ##
     @@ t/Makefile: failed:
      	test -z "$$failed" || $(MAKE) $$failed
 2:  5c22e0b3b9 !  2:  3690607933 t: import the clar unit testing framework
    @@ Metadata
      ## Commit message ##
         t: import the clar unit testing framework
     
    -    Import the clar unit testing framework at commit faa8419 (Merge pull
    -    request #93 from clar-test/ethomson/fixtures, 2023-12-14). The framework
    +    Import the clar unit testing framework at commit 1516124 (Merge pull
    +    request #97 from pks-t/pks-whitespace-fixes, 2024-08-15). The framework
         will be wired up in subsequent commits.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ t/unit-tests/clar/clar/fs.h (new)
     +			ERROR_PATH_NOT_FOUND == last_error)
     +			return 0;
     +
    -+		Sleep(RM_RETRY_DELAY * retries * retries);	
    ++		Sleep(RM_RETRY_DELAY * retries * retries);
     +	}
     +	while (retries++ <= RM_RETRY_COUNT);
     +
    @@ t/unit-tests/clar/clar/sandbox.h (new)
     +	static const size_t var_count = 5;
     +	static const char *env_vars[] = {
     +		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
    -+ 	};
    ++	};
     +
    -+ 	size_t i;
    ++	size_t i;
     +
     +	for (i = 0; i < var_count; ++i) {
     +		const char *env = getenv(env_vars[i]);
    @@ t/unit-tests/clar/clar/sandbox.h (new)
     +{
     +	return _clar_path;
     +}
    -+
     
      ## t/unit-tests/clar/clar/summary.h (new) ##
     @@
    @@ t/unit-tests/clar/generate.py (new)
     +    suite.disable(options.excluded)
     +    if suite.write():
     +        print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
    -+
     
      ## t/unit-tests/clar/test/.gitignore (new) ##
     @@
    @@ t/unit-tests/clar/test/.gitignore (new)
     +.clarcache
     +clar_test
     +*.o
    -+
     
      ## t/unit-tests/clar/test/Makefile (new) ##
     @@
 4:  75e097dfa4 =  3:  db53673294 t/clar: fix compatibility with NonStop
 3:  e0f99874cc !  4:  b6199c88dd t/clar: fix whitespace errors
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t/clar: fix whitespace errors
    -
    -    Fix whitespace errors in the clar that make git-apply(1) unhappy. This
    -    has been cherry-picked from the upstream pull request at [1].
    -
    -    [1]: https://github.com/clar-test/clar/pull/97
    +    Makefile: fix sparse dependency on GENERATED_H
    +
    +    The "check" Makefile target is essentially an alias around the "sparse"
    +    target. The one difference though is that it will tell users to instead
    +    run the "test" target in case they do not have sparse(1) installed, as
    +    chances are high that they wanted to execute the test suite rather than
    +    doing semantic checks.
    +
    +    But even though the "check" target ultimately just ends up executing
    +    `make sparse`, it still depends on our generated headers. This does not
    +    make any sense though: they are irrelevant for the "test" target advice,
    +    and if these headers are required for the "sparse" target they must be
    +    declared as a dependency on the aliased target, not the alias.
    +
    +    But even moving the dependency to the "sparse" target is wrong, as
    +    concurrent builds may then end up generating the headers and running
    +    sparse concurrently. Instead, we make them a dependency of the specific
    +    objects. While that is overly broad, it does ensure correct ordering.
    +    The alternative, specifying which file depends on what generated header
    +    explicitly, feels rather unmaintainable.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    - ## t/unit-tests/clar/clar/fs.h ##
    -@@ t/unit-tests/clar/clar/fs.h: fs_rm_wait(WCHAR *_wpath)
    - 			ERROR_PATH_NOT_FOUND == last_error)
    - 			return 0;
    - 
    --		Sleep(RM_RETRY_DELAY * retries * retries);	
    -+		Sleep(RM_RETRY_DELAY * retries * retries);
    - 	}
    - 	while (retries++ <= RM_RETRY_COUNT);
    + ## Makefile ##
    +@@ Makefile: check-sha1:: t/helper/test-tool$X
      
    -
    - ## t/unit-tests/clar/clar/sandbox.h ##
    -@@ t/unit-tests/clar/clar/sandbox.h: find_tmp_path(char *buffer, size_t length)
    - 	static const size_t var_count = 5;
    - 	static const char *env_vars[] = {
    - 		"CLAR_TMP", "TMPDIR", "TMP", "TEMP", "USERPROFILE"
    -- 	};
    -+	};
    + SP_OBJ = $(patsubst %.o,%.sp,$(OBJECTS))
      
    -- 	size_t i;
    -+	size_t i;
    +-$(SP_OBJ): %.sp: %.c %.o
    ++$(SP_OBJ): %.sp: %.c %.o $(GENERATED_H)
    + 	$(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
    + 		-Wsparse-error \
    + 		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $< && \
    +@@ Makefile: style:
    + 	git clang-format --style file --diff --extensions c,h
      
    - 	for (i = 0; i < var_count; ++i) {
    - 		const char *env = getenv(env_vars[i]);
    -@@ t/unit-tests/clar/clar/sandbox.h: const char *clar_sandbox_path(void)
    - {
    - 	return _clar_path;
    - }
    --
    -
    - ## t/unit-tests/clar/generate.py ##
    -@@ t/unit-tests/clar/generate.py: def write(self):
    -     suite.disable(options.excluded)
    -     if suite.write():
    -         print("Written `clar.suite` (%d tests in %d suites)" % (suite.callback_count(), suite.suite_count()))
    --
    -
    - ## t/unit-tests/clar/test/.gitignore ##
    -@@ t/unit-tests/clar/test/.gitignore: clar.suite
    - .clarcache
    - clar_test
    - *.o
    --
    + .PHONY: check
    +-check: $(GENERATED_H)
    ++check:
    + 	@if sparse; \
    + 	then \
    + 		echo >&2 "Use 'make sparse' instead"; \
 -:  ---------- >  5:  06364b2b72 Makefile: make hdr-check depend on generated headers
 -:  ---------- >  6:  88ea94ce16 Makefile: do not use sparse on third-party sources
 5:  5b8a64ae79 !  7:  05bcb5bef6 Makefile: wire up the clar unit testing framework
    @@ .gitignore
      /bin-wrappers/
     
      ## Makefile ##
    +@@ Makefile: REFTABLE_TEST_LIB = reftable/libreftable_test.a
    + GENERATED_H += command-list.h
    + GENERATED_H += config-list.h
    + GENERATED_H += hook-list.h
    ++GENERATED_H += $(UNIT_TEST_DIR)/clar-decls.h
    ++GENERATED_H += $(UNIT_TEST_DIR)/clar.suite
    + 
    + .PHONY: generated-hdrs
    + generated-hdrs: $(GENERATED_H)
     @@ Makefile: THIRD_PARTY_SOURCES += sha1dc/%
      THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
      THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
    @@ Makefile: endif
      
      bin-wrappers/%: wrap-for-bin.sh
      	$(call mkdir_p_parent_template)
    -@@ Makefile: CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
    - HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
    - HCC = $(HCO:hco=hcc)
    - 
    -+$(UNIT_TEST_DIR)/unit-test.hcc: $(UNIT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar-decls.h
    - %.hcc: %.h
    - 	@echo '#include "git-compat-util.h"' >$@
    - 	@echo '#include "$<"' >>$@
     @@ Makefile: endif
      
      artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
    @@ Makefile: cocciclean:
      
      clean: profile-clean coverage-clean cocciclean
      	$(RM) -r .build $(UNIT_TEST_BIN)
    -+	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/clar-decls.h
    ++	$(RM) GIT-TEST-SUITES
      	$(RM) po/git.pot po/git-core.pot
      	$(RM) git.res
      	$(RM) $(OBJECTS)
 6:  bc4e23d666 =  8:  8f56b4d626 t/unit-tests: convert strvec tests to use clar
 7:  0a7fe8775a =  9:  ca09d19fd5 t/unit-tests: convert ctype tests to use clar

base-commit: 406f326d271e0bacecdb00425422c5fa3f314930
-- 
2.46.0.46.g406f326d27.dirty

