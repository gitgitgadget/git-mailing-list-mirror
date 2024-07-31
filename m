Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A8E1AB502
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416668; cv=none; b=h00DxZ5jNYqw2p7Aqto3aJPIYYPz/a/dk96FAXIgQacKCiEFrCvJ+cAJ57dBRIMmhCofT4SBMlzZdNUnmJF4TDHHWTcuQHRatyD/O7mbXL/yh+R0zSJwFrn3E6KRB8NH3Qc6lwFvrqq9FI7dz8mD9AHcVCuS/E+AsITwysNZXuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416668; c=relaxed/simple;
	bh=2AdryNz2M9AAfK5avLB20FCOUEiOgQjRgK82fWMGm0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THcyCX35GK4rst3FH/Ih5xV7kNBVy/UPe7SFv4FIc2FBuzILsBbdie8ifTdStAdXf2Tpo3KDxBdK/G+Uuw6W62Rd6euUbdb6i4sOaoe2YLCIkirMU7Kf0iNeyh0o9Rv7rwoxcc8A8GJ9R/BbF4Pgc3oW7I0HQoatvKYuCeieHOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i25m2mjx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YzzaLl2+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i25m2mjx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YzzaLl2+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4FB6C1146DB7;
	Wed, 31 Jul 2024 05:04:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 31 Jul 2024 05:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722416664; x=1722503064; bh=y8OqF2LHwu
	lpm+eaQXTkUJnbYjgMSbwWzLNA16va8Gk=; b=i25m2mjx9gnZatKM8262yHVXdQ
	0Ed2jyTlW2sYokQN8Gs+e4opKBe/vJ1dt7oMbElS4B6fSjj8qWSQUD7aN6Z9ovdD
	fmjvp1aAEv9K7AfiGyaWO/BH35lTclD5NU50QZsGq8eKoSxvS4KxngJiZXu+XmZs
	AIetrBW/nfxdU7yCLXyd0H1zPtr3DAWIdc1PpyiRa0un9dKWZizyQNhdE7pkz4jg
	vqLWwZsLTB1DqYxyF0yhLsFHciTkQYepXMZaywdgZXk2zsEZ4L4z1AjgEsxGC5px
	YFJLpovbGWoClNQDEMAeXUBsIyTMLLv6Nmps3dGdroeX6T00cQv0yvolg4/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722416664; x=1722503064; bh=y8OqF2LHwulpm+eaQXTkUJnbYjgM
	SbwWzLNA16va8Gk=; b=YzzaLl2+XQ5/yHn6OkocrE64Ax97sS7ZZxlYmXKyDf6e
	YLXsB93jaN5cZlIqbKvr1nD6wyB2VS82ATVElFop//RlsQoS2kHx0U0akmwWScFh
	sV5g/L877NSTAwDNWSS6Z8QFMSEZnvxvKFxHDj3flS0vz0H5h6/p+2qYMgKxFSxr
	IQi0aJ40nbVYGkPO2KvbQWa103gZpfFVQZx3CM+eZFkmP2gJMpfTA1B7LPC9lCU8
	DWBjg+qHchjotrsfW2RHlig8OnCIlHUY94vbAWJ7WAz9W4SANasAV9Wh6lz6onN1
	rzvxPQI1O7jNyZR3WJmE26c9F0OeFb6yN42isGzbZg==
X-ME-Sender: <xms:GP6pZo25dDBsqgD4OTvrZ5FrtLE_0U_eBZp5AgqARtqu7JVsh_8NXg>
    <xme:GP6pZjHLWRy8nTLo2w0ozneRqnx5JId9urfhdqqu78e-4bHWUWh24Y1ArKNHHnqDD
    TLJlYTRYIIz9voH6A>
X-ME-Received: <xmr:GP6pZg7iVYWhjndhivP1B6HOqTumzLhLviUXV-GJFblMD3EMAzxpPvFtI8Bqts997j0eTJm4jQ6LXpI92bvyhLeJvx22yeWoNY97gb6I2yIgZ0GS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:GP6pZh1Adbyo6Sr3vaqoyGKgiZB7o8Hw0QqgYHoIBFafy47p9wPKSA>
    <xmx:GP6pZrEehhKoEYC1OFQUIg1PVdkVDDhqutRRKM-csHOiavCSQVdLzw>
    <xmx:GP6pZq-zwKwXNRoC2qPyHOfnlyqA453wzK1jOgomaK8YDErwMIPW4Q>
    <xmx:GP6pZglNbYmTfttxAib30sX6KWJHWmO78_-OopJQAHe2dGUJFshNkw>
    <xmx:GP6pZg6cZ9bdSFdjtPZicj3Qvj_nrgG4A55k4mF2hdKGBoaUXSorurOH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 05:04:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 92e31047 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 09:02:53 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:04:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: [RFC PATCH 2/3] Makefile: wire up the clar unit testing framework
Message-ID: <5195d084d3c1bee76e7e424afec2c09bff8f5dde.1722415748.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4RiojoL5UZdmZ/7G"
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>


--4RiojoL5UZdmZ/7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Wire up the clar unit testing framework by introducing a new
"unit-tests" executable. In contrast to the existing framework, this
will result in a single executable for all test suites. The ability to
pick specific tests to execute is retained via functionality built into
the clar itself.

Note that we need to be a bit careful about how we need to invalidate
our Makefile rules. While we obviously have to regenerate the clar suite
when our test suites change, we also have to invalidate it in case any
of the test suites gets removed. We do so by using our typical pattern
of creating a `GIT-TEST-SUITES` file that gets updated whenever the set
of test suites changes, so that we can easily depend on that file.

Another specialty is that we generate a "clar-decls.h" file. The test
functions are neither static, nor do they have external declarations.
This is because they are getting parsed via "generate.py", which then
creates the external generations that get populated into an array. These
declarations are only seen by the main function though.

The consequence is that we will get a bunch of "missing prototypes"
errors from our compiler for each of these test functions. To fix those
errors, we extract the `extern` declarations from "clar.suite" and put
them into a standalone header that then gets included by each of our
unit tests. This gets rid of compiler warnings for every function which
has been extracted by "generate.py". More importantly though, it does
_not_ get rid of warnings in case a function really isn't being used by
anything. Thus, it would cause a compiler error if a function name was
mistyped and thus not picked up by "generate.py".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitignore               |  1 +
 Makefile                 | 34 ++++++++++++++++++++++++++++++----
 t/Makefile               |  1 +
 t/unit-tests/.gitignore  |  3 +++
 t/unit-tests/unit-test.c | 16 ++++++++++++++++
 t/unit-tests/unit-test.h |  3 +++
 6 files changed, 54 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

diff --git a/.gitignore b/.gitignore
index 8caf3700c2..6687bd6db4 100644
--- a/.gitignore
+++ b/.gitignore
@@ -9,6 +9,7 @@
 /GIT-PYTHON-VARS
 /GIT-SCRIPT-DEFINES
 /GIT-SPATCH-DEFINES
+/GIT-TEST-SUITES
 /GIT-USER-AGENT
 /GIT-VERSION-FILE
 /bin-wrappers/
diff --git a/Makefile b/Makefile
index d6479092a0..658acb4d48 100644
--- a/Makefile
+++ b/Makefile
@@ -1332,6 +1332,11 @@ THIRD_PARTY_SOURCES +=3D compat/regex/%
 THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
 THIRD_PARTY_SOURCES +=3D sha1dc/%
=20
+UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
+UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
+UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
+UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
+
 UNIT_TEST_PROGRAMS +=3D t-ctype
 UNIT_TEST_PROGRAMS +=3D t-example-decorate
 UNIT_TEST_PROGRAMS +=3D t-hash
@@ -2711,6 +2716,7 @@ OBJECTS +=3D $(XDIFF_OBJS)
 OBJECTS +=3D $(FUZZ_OBJS)
 OBJECTS +=3D $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS +=3D $(UNIT_TEST_OBJS)
+OBJECTS +=3D $(UNIT_TESTS_OBJS)
=20
 ifndef NO_CURL
 	OBJECTS +=3D http.o http-walker.o remote-curl.o
@@ -3213,7 +3219,7 @@ endif
=20
 test_bindir_programs :=3D $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_NE=
ED_X) $(BINDIR_PROGRAMS_NO_X) $(TEST_PROGRAMS_NEED_X))
=20
-all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS)
+all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(UNIT_T=
ESTS_PROG)
=20
 bin-wrappers/%: wrap-for-bin.sh
 	$(call mkdir_p_parent_template)
@@ -3644,7 +3650,7 @@ endif
=20
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS)=
 \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3700,6 +3706,7 @@ cocciclean:
=20
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
+	$(RM) $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/.clarcache
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3859,7 +3866,26 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TES=
T_DIR)/%.o \
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
=20
+GIT-TEST-SUITES: FORCE
+	@FLAGS=3D'$(UNIT_TESTS_SUITES)'; \
+	    if test x"$$FLAGS" !=3D x"`cat GIT-TEST-SUITES 2>/dev/null`" ; then \
+		echo >&2 "    * new test suites"; \
+		echo "$$FLAGS" >GIT-TEST-SUITES; \
+		rm -f $(UNIT_TESTS_DIR)/.clarcache; \
+            fi
+
+$(UNIT_TEST_DIR)/clar.suite: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_TEST=
S_SUITES)) GIT-TEST-SUITES
+	$(QUIET_GEN)$(UNIT_TEST_DIR)/clar/generate.py $(UNIT_TEST_DIR) >/dev/null
+	@touch $@
+$(UNIT_TEST_DIR)/clar-decls.h: $(UNIT_TEST_DIR)/clar.suite
+	$(QUIET_GEN)grep '^extern void' $^ >$@
+$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
+$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR) -I$(UNIT_TEST_DI=
R)/clar
+$(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(GITLI=
BS) GIT-LDFLAGS
+	$(call mkdir_p_parent_template)
+	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(=
LIBS)
+
 .PHONY: build-unit-tests unit-tests
-build-unit-tests: $(UNIT_TEST_PROGS)
-unit-tests: $(UNIT_TEST_PROGS) t/helper/test-tool$X
+build-unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG)
+unit-tests: $(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) t/helper/test-tool$X
 	$(MAKE) -C t/ unit-tests
diff --git a/t/Makefile b/t/Makefile
index 4c30e7c06f..55f740ae29 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -48,6 +48,7 @@ CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,$=
(wildcard chainlint/*.tes
 CHAINLINT =3D '$(PERL_PATH_SQ)' chainlint.pl
 UNIT_TEST_SOURCES =3D $(wildcard unit-tests/t-*.c)
 UNIT_TEST_PROGRAMS =3D $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UN=
IT_TEST_SOURCES))
+UNIT_TEST_PROGRAMS +=3D unit-tests/bin/unit-tests$(X)
 UNIT_TESTS =3D $(sort $(UNIT_TEST_PROGRAMS))
 UNIT_TESTS_NO_DIR =3D $(notdir $(UNIT_TESTS))
=20
diff --git a/t/unit-tests/.gitignore b/t/unit-tests/.gitignore
index 5e56e040ec..b8d46f7bb1 100644
--- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1 +1,4 @@
 /bin
+/.clarcache
+/clar.suite
+/clar-decls.h
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
new file mode 100644
index 0000000000..d7eecc384c
--- /dev/null
+++ b/t/unit-tests/unit-test.c
@@ -0,0 +1,16 @@
+#include "unit-test.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	const char **args;
+	int ret;
+
+	/* Append the "-t" flag such that the tests generate TAP output. */
+	DUP_ARRAY(args, argv, argc + 1);
+	args[argc++] =3D "-t";
+
+	ret =3D clar_test(argc, (char **) args);
+
+	free(args);
+	return ret;
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
new file mode 100644
index 0000000000..99d59df1b0
--- /dev/null
+++ b/t/unit-tests/unit-test.h
@@ -0,0 +1,3 @@
+#include "git-compat-util.h"
+#include "clar.h"
+#include "clar-decls.h"
--=20
2.46.0.dirty


--4RiojoL5UZdmZ/7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmap/hQACgkQVbJhu7ck
PpS1Vw//UFPoOK15LVps5LywUNLz+URl9Eyh883mvsLvOiXakKGhvZ5wsg6B9msf
Ufm4lygIrvEChULb2LPKxp/34UXq1/1FXUXoLu6FZFuapGSu3dudoyVh0WR5DOcV
L/lcPEpnztp03v9Kf1W8xupJNK4lRmmGnmuQ3CXoghQDKL7c4oAwxGEBCPfqM3o3
kXWobYpumu+qM06XNWBTL0u5WGnfL+oPLepFmovPW3pqeJZmBifBIteQfb8zSUCP
6CXVdi9brdb/UB91Czc8iThjrGtQrbv5GK1MJdw7OWhrZezsH9Old8TgbxGdyqn8
vREP6QAARFvFDyDvG1MG1BF+Wz4t5kDuHZ2fp+HFFDHp7XyW/UD01njKUNzdQy/3
A7ooHNy25+qIY4VF7Xw9xycAENyIbY2EaEObQK5x65DPJifdV/i6FQokvflJtNAC
mWszE/RLF9jiATPBHqhu59h4TChmhzXEJSPe9nWhtQAIlFhHMmABahv2tQiF339E
lPzJ5ZZtdNpCB41tOazTQJ9uqiq7bz60SpYt2Y4zO202uEXWWEULj9KAhEhD6BHU
Dx7vWLNXIFH03mAIx68dw628oKRVmwxx4zQcczkWM1zGSCIGUNTkzIK1hK8ojmsK
F3FDgvSx0xpmnHGQWSL1LfUY+aNfAzz6HuDE2exq0nIMmT99XNY=
=GclD
-----END PGP SIGNATURE-----

--4RiojoL5UZdmZ/7G--
