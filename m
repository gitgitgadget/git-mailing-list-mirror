Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D015E7DA79
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720876; cv=none; b=jfTqfmRpb1QYZ8PilnEiGrj3RX8c0VyFEmVGrXOKkWrNIGaq5spwGXuMO3muZfCcCneCwacamfOFJU6OuRbw83uLeorPlwPpyX9AuAbMQ7mHNIfH0LPBe4ds5zpLG2EV+fbAhu5hh+7vNhZXSNXmZWiLxwG4Qq87Oj079c33Gc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720876; c=relaxed/simple;
	bh=oWzoLVMBdBbkHLITodUFhIMR+22SvrLdlCkGfI3Ppgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KA4+tb8KgVMKcBfN1R9n/x27iqmOPGfpIYUn7Moss9uiAfPi0768919JDtOPC3JUhsVN0SsT5tJb0AQl99uLl8XBohLCwcC2u0xJk1OGYGcyYhsR8jZyEUN86SML7pPuXM2XRHuVuKSek3tNeakme5z/89+YEjCCjaLnwztwfXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b4kHe721; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CHRPH+zE; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b4kHe721";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CHRPH+zE"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8B25138FC6F;
	Thu, 15 Aug 2024 05:47:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 15 Aug 2024 05:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723715256; x=1723801656; bh=bXWIe/zU8I
	BIs/2qxZVO1ShUI6q0ONSCKSQpDOSj/jA=; b=b4kHe721g/+c3HNoPbtAUf4UIv
	332fuMBlBnr6QyDUGrEI3v6qLFBkZbQZFJEKCLVQgXMn94j0LzEmnWtI5UsbkeYy
	yVIfQNsUAwX8z3gMcpoQxFatgbmIMDI4QRJCBq60w5SSsEFnXTfb0c4oBJZBqHof
	hnl78yJL2ILr7PkiM77OlYWqwz6rZeOSX45OCPoBF/4M/Z9UCkRNFE0IUe93yYyo
	IheXsxcd1hgBLZgiFkOMYdS8EXsQ/psGvVQM96AkoYf9Fo6YlPY7L0qtJjZU7byX
	qLkQsbzdgxzzXnKmEy197LJZBGFXVi01cUp51UT+Ff/zO118JUQV0fWHV1wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723715256; x=1723801656; bh=bXWIe/zU8IBIs/2qxZVO1ShUI6q0
	ONSCKSQpDOSj/jA=; b=CHRPH+zE8moC3pW9IIRst2eKHcyC8LBKcfnSGjQ3e2es
	RyqyhWhCNYNWLqrQBaOiGHKUjjasuZAOZRsw7kCBVxdKV9nrwB6GdmrcXKf+Lirg
	mP9N5Qu2zy6S7swJbJIL7F8pr9Shcd7FGkkEfdibLVoM9MHANavvbOTvD225BH+t
	QIqs8OINl/Y7k/3JI22mpNtdVv9vVUu5A3ZJMaN1KX8T3bHFShLFnyO+70MGSfGz
	vXtam7uKpekx/p1k29Xi9PlQdQTf1F8LHr6vznKQR4zgGKi9owE+Xe4up5Gwbq6L
	H4takFi9TwCfjVkShtraTvpPxlAR+WXdEsplZHjXWA==
X-ME-Sender: <xms:uM69ZgWyIAvjz7vWVvdx9yzTB_UYl2JqRj-7FGdTDmA5-IaSZh3Hlw>
    <xme:uM69Zklmbtci9U0jQnq2U9rssR2SV0kHX6pzSKOhhOBLZi5HXz60ztjqt4YeeM8Vv
    00dwB7pN_iJevwSng>
X-ME-Received: <xmr:uM69ZkZ7k3orCSupXK61n0W0TQ3J9iDdtrlUgBJC2o6NMXNYANjy1HGzzqCNtCVHtK-GnvOJEMX46VZeujQXeaTXVBElYkRiciicR9Vh2eGWAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopegv
    thhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehsph
    gvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:uM69ZvXM904_la4-4ku0zEayOTn7huPKzwylVkKLzAO_Dr2qIF_w0Q>
    <xmx:uM69ZqkmxuXNUUdJ08RuY6czAGaSnYQiTUXJOt9aDRj3kMWtVQfQKQ>
    <xmx:uM69ZkfozI7mXpepL-BFaOMRPiFAwvMHnjkGgjwub1nVAi9TzF-1yA>
    <xmx:uM69ZsFBAAynwfpPbrPQXx2k7_VdbgiOb-HoDGGac0fqlG0K2LXzNQ>
    <xmx:uM69Zk7Bz5nogAVGvT8Fq7M3Uj4-lWmvpmhUa7bhL7EGXPFf2jGVlL7J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:47:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 821c9006 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:47:12 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:47:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH v4 0/7] Introduce clar testing framework
Message-ID: <cover.1723712012.git.ps@pks.im>
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

this is the fourth version of my patch series that introduces the clar
testing framework for our unit tests.

Changes compared to v3:

  - Seeing that the overall feedback seems to be rather positive, I've
    now dropped the "RFC" prefix.

  - Fix another whitespace-damaged line in the clar unit test. I've
    adapted the upstream pull request accordingly.

  - Fix `make hdr-check`, which failed due to the missing dependency on
    "clar-decls.h".

Thanks!

Patrick

Patrick Steinhardt (7):
  t: do not pass GIT_TEST_OPTS to unit tests with prove
  t: import the clar unit testing framework
  t/clar: fix whitespace errors
  t/clar: fix compatibility with NonStop
  Makefile: wire up the clar unit testing framework
  t/unit-tests: convert strvec tests to use clar
  t/unit-tests: convert ctype tests to use clar

 .gitignore                                 |   1 +
 Documentation/technical/unit-tests.txt     |   2 +
 Makefile                                   |  43 +-
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
 29 files changed, 3160 insertions(+), 98 deletions(-)
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

Range-diff against v3:
1:  78a9cc1162 = 1:  086dd728a7 t: do not pass GIT_TEST_OPTS to unit tests with prove
2:  b6c066ee4e = 2:  5c22e0b3b9 t: import the clar unit testing framework
3:  35682b7686 ! 3:  e0f99874cc t/clar: fix whitespace errors
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## t/unit-tests/clar/clar/fs.h ##
    +@@ t/unit-tests/clar/clar/fs.h: fs_rm_wait(WCHAR *_wpath)
    + 			ERROR_PATH_NOT_FOUND == last_error)
    + 			return 0;
    + 
    +-		Sleep(RM_RETRY_DELAY * retries * retries);	
    ++		Sleep(RM_RETRY_DELAY * retries * retries);
    + 	}
    + 	while (retries++ <= RM_RETRY_COUNT);
    + 
    +
      ## t/unit-tests/clar/clar/sandbox.h ##
     @@ t/unit-tests/clar/clar/sandbox.h: find_tmp_path(char *buffer, size_t length)
      	static const size_t var_count = 5;
4:  7a76c21bcb = 4:  75e097dfa4 t/clar: fix compatibility with NonStop
5:  68b3c65951 ! 5:  5b8a64ae79 Makefile: wire up the clar unit testing framework
    @@ Makefile: endif
      
      bin-wrappers/%: wrap-for-bin.sh
      	$(call mkdir_p_parent_template)
    +@@ Makefile: CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(LIB_H))
    + HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
    + HCC = $(HCO:hco=hcc)
    + 
    ++$(UNIT_TEST_DIR)/unit-test.hcc: $(UNIT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar-decls.h
    + %.hcc: %.h
    + 	@echo '#include "git-compat-util.h"' >$@
    + 	@echo '#include "$<"' >>$@
     @@ Makefile: endif
      
      artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
6:  4a0888380e = 6:  bc4e23d666 t/unit-tests: convert strvec tests to use clar
7:  f423b01c05 = 7:  0a7fe8775a t/unit-tests: convert ctype tests to use clar
-- 
2.46.0.46.g406f326d27.dirty

