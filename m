Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB3175D37
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725949435; cv=none; b=UEZ8FTdt4ujtyOPgQ00gNzRehPhYWKwT4rra9sO8hKS+OAO6I/ctsAE/804GzO+0U00votplBlUqmIuktZeI3YwuSjIW5a2UXnRSruAXOKbznXLUzdPncstQqJt5IGrL9qHgGggIPq7STraEaQhwNen0mt2wy9w94NlqEoeHeDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725949435; c=relaxed/simple;
	bh=j+hFkWKX9Qf+cs/kaOaYZIl/e2nnWJHzpRE1mOpQ3LI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dNorssIboJRp3GVEbFlAebQiZqMbqDSeeXNfi4WAjqH0/cghHckMYMZdhM2Knt+I/4HhrhDymlRD/aje87TRttqzJqEzWVi90LzvW6SefyrjHgf5oIu/JjtP2uIfeeAa5IrUGd2muebBj+uTox+y6TE8feOda1kTpCW4IyOj5z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DQ+QpaqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nDzawz3f; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DQ+QpaqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nDzawz3f"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 947981380352;
	Tue, 10 Sep 2024 02:23:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 10 Sep 2024 02:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1725949432; x=1726035832; bh=dpSrp2on/ZKKmBz2TUsjXYlM/tg94IXC
	3Kdv7kIjlAQ=; b=DQ+QpaqOQXk4uJQ1VyLPfHMPnZmMQUXKR4wPTesr6cK5SFsF
	yISBQa9dYYWjUkT7lYqO8LF2Q14vafZG5TzUOhjfkkpC020YI+96D9MY8AFuGfIf
	5khrHZxkdFBDAy9Q1px8nUhTpdi1KJm9HEa4Qw2BkFN0x0AgtoK/DzAnBJjTcDgW
	uOMno8SB3bQLBairRZ8h1et1TlLDkgFgd5hF6HsOzpyBw58PJyFzpzkfANpyVPYs
	I9lmLwb/F4xFuGeCwnPSHlzQSOjblyMPX5JV/uhEmg3qzYelufklEdc7jwQpHvqS
	wt5BgwvuxLZDki0LfYJ0hplu7C+4lMrroa4CTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1725949432; x=1726035832; bh=dpSrp2on/ZKKmBz2TUsjXYlM/tg94IXC3Kd
	v7kIjlAQ=; b=nDzawz3fRhyj0e74EOi/aMbywzlgatJWWpGb1TMfVgKYqhC+Hdi
	DGSl73sXNe/bryAl8pI2aNLFiU2WUmBC0R/tTkn05aSlTmROIcI9V71x5wQFtNJR
	Y+zrJXMZx6yLteWqmEYzbJY2xKrtF624jNhZqlHCzBLaUy6M5cMqjP7FWN6zWoR8
	4MJvaYVX7blNrtmNpyc4rkslI6rjjWEt9Ww/7DiaTEtKhY616mVdzWuLJ7Wsik0H
	/skEiGN7mXppeYyW6QVy2PJrEHvbLz2h3quxE3BlTOOmzNP0Ks0UrV4lAH24jj8r
	miaoP+/OywqavuIawIY5hLDBztPDqHhiayA==
X-ME-Sender: <xms:-OXfZr1Ybc_c_ZFpxxxqwSRFnIyh9GRuJBv4WTup-p3Ps0dlDV27vQ>
    <xme:-OXfZqGyeovajybHYkRIVAEvzBy6nkF4DWRGdp2815yTbi0bDQdrVIu5nL4rp52cF
    zEim_Yso0L9r4jLrw>
X-ME-Received: <xmr:-OXfZr4Mh-G88fmHh7nLbohwVRZqnTK36FEodzlSsbVkRUK73_CwhF-mwHT5vwM_13_2b2TOGOGU_17werdCQE8zIzbNcTDgxqb2vZNRHIeZzuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfggtggusehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiuedvhfetteelgf
    fhhedtvdehlefhtdffhffhgfeljeefvdetfeevledtueeivdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:-OXfZg2N_iNfFYjWbW0dwctEY46vyMxhdipAmyMrR5fSOR12mUMM4g>
    <xmx:-OXfZuGAW5BH48aYla5ohGS04orfCIr6Hgyd2ClStPZxDL9xRxtQ_A>
    <xmx:-OXfZh-iEhsXH1PrRo_tNUw2JqKwqTUhvvlk57tAPhmeNFzrXeiSKw>
    <xmx:-OXfZrlyyA1FxZR82rDPTr94fXoNhh2AbyH2KGvdER8TFdwKpqxbaQ>
    <xmx:-OXfZjRpJ41CnIMUZimxi6xMEC_fPIsHn-GjmBmxlMB_4nCb9xE2oUUJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:23:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8a3f3369 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:23:46 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:23:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: rename clar-related variables to avoid confusion
Message-ID: <0ee5282c64c51a2c8c06582510b3ca7ec7173c42.1725949388.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The Makefile variables related to the recently-introduced clar testing
framework have a `UNIT_TESTS_` prefix. This prefix is extremely similar
to the prefix used by our other unit tests that use our homegrown unit
testing framework, which is `UNIT_TEST_`. The consequence is that it is
easy to misread the names and confuse them with each other.

Rename the clar-related variables to instead have a `CLAR_TEST_` prefix
to address this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

As discussed in <xmqqfrq8r8s8.fsf@gitster.g>. This is based on top of
Junio's ps/clar-unit-test at 894deb76a0 (clar: add CMake support,
2024-09-04).

Patrick

 Makefile | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/Makefile b/Makefile
index c841cf7006..4ef1f1dfe3 100644
--- a/Makefile
+++ b/Makefile
@@ -1336,12 +1336,12 @@ THIRD_PARTY_SOURCES += sha1dc/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES += $(UNIT_TEST_DIR)/clar/clar/%
 
-UNIT_TESTS_SUITES += ctype
-UNIT_TESTS_SUITES += strvec
-UNIT_TESTS_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
-UNIT_TESTS_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
-UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
-UNIT_TESTS_OBJS += $(UNIT_TEST_DIR)/unit-test.o
+CLAR_TEST_SUITES += ctype
+CLAR_TEST_SUITES += strvec
+CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
+CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
+CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/unit-test.o
 
 UNIT_TEST_PROGRAMS += t-example-decorate
 UNIT_TEST_PROGRAMS += t-hash
@@ -2721,7 +2721,7 @@ OBJECTS += $(XDIFF_OBJS)
 OBJECTS += $(FUZZ_OBJS)
 OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS += $(UNIT_TEST_OBJS)
-OBJECTS += $(UNIT_TESTS_OBJS)
+OBJECTS += $(CLAR_TEST_OBJS)
 
 ifndef NO_CURL
 	OBJECTS += http.o http-walker.o remote-curl.o
@@ -3224,7 +3224,7 @@ endif
 
 test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NEED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
 
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
 
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3656,7 +3656,7 @@ endif
 
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS) \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH='$(SHELL_PATH_SQ)' PERL_PATH='$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3873,25 +3873,25 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)/%.o \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
 
 GIT-TEST-SUITES: FORCE
-	@FLAGS='$(UNIT_TESTS_SUITES)'; \
+	@FLAGS='$(CLAR_TEST_SUITES)'; \
 	    if test x"$$FLAGS" != x"`cat GIT-TEST-SUITES 2>/dev/null`" ; then \
 		echo >&2 "    * new test suites"; \
 		echo "$$FLAGS" >GIT-TEST-SUITES; \
             fi
 
-$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_TESTS_SUITES)) GIT-TEST-SUITES
-	$(QUIET_GEN)for suite in $(UNIT_TESTS_SUITES); do \
+$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(CLAR_TEST_SUITES)) GIT-TEST-SUITES
+	$(QUIET_GEN)for suite in $(CLAR_TEST_SUITES); do \
 		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
 	done >$@
 $(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
 	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR)/clar.suite
-$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
-$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
-$(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(GITLIBS) GIT-LDFLAGS
+$(CLAR_TEST_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
+$(CLAR_TEST_OBJS): EXTRA_CPPFLAGS = -I$(UNIT_TEST_DIR)
+$(CLAR_TEST_PROG): $(UNIT_TEST_DIR)/clar.suite $(CLAR_TEST_OBJS) $(GITLIBS) GIT-LDFLAGS
 	$(call mkdir_p_parent_template)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 .PHONY: build-unit-tests unit-tests
-build-unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
-unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) t/helper/test-tool$X
+build-unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG)
+unit-tests: $(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
-- 
2.46.0.519.g2e7b89e038.dirty

