Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA9A181BA8
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095518; cv=none; b=fjVkZ2oD+sAZ5MZyLwXeorngl86Dq+PIlneRjqFee1xgvkaRQInlSjjOfoay3DSVBHeTigkfmPAUye+qMVlFMzVxTptSgMIpWdmqjJt5r3cwbpLewXjNX4o3OyrZdplM5PZ/N3E9S1OWRrJB9KqAGhxVEay1OnrHM4fmw3v3IVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095518; c=relaxed/simple;
	bh=H37J1D0XGP41r8iNESdnrWOxO/TUeF0naV1pdTlgaCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1TjNVnBGugx4qn/2cifqzuB5Oyuh7JEEyMG9K3GGjsbjf4uSrt9S4ENj4xe0ae38/DF9RpW0EcS8qFH+3qkCpWpL5O+awzCIy1+vtTvuWBVM7ZRGehJO+sU4MQCb/AdLdbOsTCv5AMwmuNJOHiWxBVR77j6Tecuw5u7qb2MsOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SY6k3AK+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YUX+iwzA; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SY6k3AK+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YUX+iwzA"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A52A51151C6D;
	Thu,  8 Aug 2024 01:38:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 01:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095515; x=1723181915; bh=JjVTyY/bZq
	maD+1RUhfW2NgLTcJPKWgTb2SPdPwb3vs=; b=SY6k3AK+b/4SoropDmQSdwR0dg
	noN2lO1RG8G+wBoZYVNi67/q34V74IY0RDMrWFe2I9GhvNi3ZhrHwK8okP//ym0o
	JNEZEfoh1Ahsuv6SGHKX0Iv3eA9NpA+GCd8KMiM/WUZ9mOcWFQc6qyPJcy9kKKQB
	OS6jmwmTGEK3m7i564cRPNXW//I0LnmE+F1+SVRwJLt+yDJYNeZ62rXGuIvGB5UI
	ngyz64S32rVL26j0skuL9Gqi4nSIf1OSaypUnyg7aVrraW2lwYQhLLN11z3mocmY
	j9YEDbjz0/CBpBsMSrEAAGTKbbLrt9acEBqbVm+vIt9Uo0Jnhddo9Tgh0b4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095515; x=1723181915; bh=JjVTyY/bZqmaD+1RUhfW2NgLTcJP
	KWgTb2SPdPwb3vs=; b=YUX+iwzA3brORtAGk27AcaPjY6lQh1q1H727B7wz3w21
	yf3850TFcIyCHtltkurHQC7oEGkMjW0ADcSHhKDIf51Sap0CYANlQEKvjuD314zD
	pWN1REjlfTcxuWG9eyej7ZmjeSh62z9o0JxIaleZweF5sGtVZGvGxtQ/m/V9lvvG
	jpO4OKnehC+e/PchgFT/rsM1tDJtfkpYdk2sRRHehwKkFZn4ocjxh+GmNFViV7B1
	tYNiK4g8WdVziNc7bAog2yhCnwq8XybtubJUHdoeyzatq0r66aRAMdhhDhX/ogFm
	b49wqhNWpGTMEitNt/OQcHyZxXj2FfBprN6tFAB15Q==
X-ME-Sender: <xms:21m0ZncMwwHnADOqAU0lRMiDy_H8j5jfdcvANm23fpKGw1mwY0RgjQ>
    <xme:21m0ZtNU6fRB7xNg5erI_6y9kdCer6ob-k3rN7y9FClHkWmm9etJVIY0JZoS6JYSZ
    csRY-myzfEQr22HxQ>
X-ME-Received: <xmr:21m0ZggIcw0HHCL0qbJ_FOG5E8YRgbJQdKI5ivJ2nsgT5eQZCvJgCwZyhRWJpmuY_G0PRW5ESrH785CAwQb_ExyvbbzTjiupwNsmweFbsvBsHgws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehlrdhsrd
    hrseifvggsrdguvgdprhgtphhtthhopehrshgsvggtkhgvrhesnhgvgigsrhhiughgvgdr
    tghomhdprhgtphhtthhopehsphgvtghtrhgrlhesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvthhhohhmshho
    nhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:21m0Zo8Hda9mbmRugJq4EnlQXksm5F6ZT60fQl653cQu5HDBba-kTg>
    <xmx:21m0Zjt2tg-Wr4E-CD9BSa0vkYijI6UG4vJv9KmyPo8EFXlZptdDCQ>
    <xmx:21m0ZnH1M0g4gitTRRIw8mLcacwc5pAYn3TtLan_BOQqSN8lrB1QcQ>
    <xmx:21m0ZqOYbCG_fxcYTfD-lv05diGeDBT17BnA2jhmPRiHkTHubftPXQ>
    <xmx:21m0ZpAClCug7sjkTCw1bnslk5oa-019wZhm71qLu1o8PUgSOt2niv6_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a5a0e534 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:27 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 5/7] Makefile: wire up the clar unit testing framework
Message-ID: <68b3c65951b590e75d61ee493aa252618ba72118.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1723095269.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VUqNFxrX/4uWDSS3"
Content-Disposition: inline
In-Reply-To: <cover.1723095269.git.ps@pks.im>


--VUqNFxrX/4uWDSS3
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
 .gitignore                     |  1 +
 Makefile                       | 34 ++++++++++++++++++++---
 t/Makefile                     |  1 +
 t/unit-tests/.gitignore        |  2 ++
 t/unit-tests/clar-generate.awk | 50 ++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.c       | 18 ++++++++++++
 t/unit-tests/unit-test.h       |  3 ++
 7 files changed, 105 insertions(+), 4 deletions(-)
 create mode 100644 t/unit-tests/clar-generate.awk
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
index 674b0ac4e1..d343703215 100644
--- a/Makefile
+++ b/Makefile
@@ -1334,6 +1334,11 @@ THIRD_PARTY_SOURCES +=3D sha1dc/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
 THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
=20
+UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
+UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SUITES))
+UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
+UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
+
 UNIT_TEST_PROGRAMS +=3D t-ctype
 UNIT_TEST_PROGRAMS +=3D t-example-decorate
 UNIT_TEST_PROGRAMS +=3D t-hash
@@ -2713,6 +2718,7 @@ OBJECTS +=3D $(XDIFF_OBJS)
 OBJECTS +=3D $(FUZZ_OBJS)
 OBJECTS +=3D $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
 OBJECTS +=3D $(UNIT_TEST_OBJS)
+OBJECTS +=3D $(UNIT_TESTS_OBJS)
=20
 ifndef NO_CURL
 	OBJECTS +=3D http.o http-walker.o remote-curl.o
@@ -3215,7 +3221,7 @@ endif
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
@@ -3646,7 +3652,7 @@ endif
=20
 artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRAMS)=
 \
 		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
-		$(UNIT_TEST_PROGS) $(MOFILES)
+		$(UNIT_TEST_PROGS) $(UNIT_TESTS_PROG) $(MOFILES)
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
 		SHELL_PATH=3D'$(SHELL_PATH_SQ)' PERL_PATH=3D'$(PERL_PATH_SQ)'
 	test -n "$(ARTIFACTS_DIRECTORY)"
@@ -3702,6 +3708,7 @@ cocciclean:
=20
 clean: profile-clean coverage-clean cocciclean
 	$(RM) -r .build $(UNIT_TEST_BIN)
+	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/clar-d=
ecls.h
 	$(RM) po/git.pot po/git-core.pot
 	$(RM) git.res
 	$(RM) $(OBJECTS)
@@ -3861,7 +3868,26 @@ $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TES=
T_DIR)/%.o \
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
 		$(filter %.o,$^) $(filter %.a,$^) $(LIBS)
=20
+GIT-TEST-SUITES: FORCE
+	@FLAGS=3D'$(UNIT_TESTS_SUITES)'; \
+	    if test x"$$FLAGS" !=3D x"`cat GIT-TEST-SUITES 2>/dev/null`" ; then \
+		echo >&2 "    * new test suites"; \
+		echo "$$FLAGS" >GIT-TEST-SUITES; \
+            fi
+
+$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT_TE=
STS_SUITES)) GIT-TEST-SUITES
+	$(QUIET_GEN)for suite in $(UNIT_TESTS_SUITES); do \
+		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$$\)/e=
xtern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
+	done >$@
+$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
+	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TEST_DIR=
)/clar.suite
+$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
+$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR)
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
index d2212de0b7..131ffd778f 100644
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
index 5e56e040ec..d0632ec7f9 100644
--- a/t/unit-tests/.gitignore
+++ b/t/unit-tests/.gitignore
@@ -1 +1,3 @@
 /bin
+/clar.suite
+/clar-decls.h
diff --git a/t/unit-tests/clar-generate.awk b/t/unit-tests/clar-generate.awk
new file mode 100644
index 0000000000..ab71ce6c9f
--- /dev/null
+++ b/t/unit-tests/clar-generate.awk
@@ -0,0 +1,50 @@
+function add_suite(suite, initialize, cleanup, count) {
+       if (!suite) return
+       suite_count++
+       callback_count +=3D count
+       suites =3D suites "    {\n"
+       suites =3D suites "        \"" suite "\",\n"
+       suites =3D suites "        " initialize ",\n"
+       suites =3D suites "        " cleanup ",\n"
+       suites =3D suites "        _clar_cb_" suite ", " count ", 1\n"
+       suites =3D suites "    },\n"
+}
+
+BEGIN {
+       suites =3D "static struct clar_suite _clar_suites[] =3D {\n"
+}
+
+{
+       print
+       name =3D $3; sub(/\(.*$/, "", name)
+       suite =3D name; sub(/^test_/, "", suite); sub(/__.*$/, "", suite)
+       short_name =3D name; sub(/^.*__/, "", short_name)
+       cb =3D "{ \"" short_name "\", &" name " }"
+       if (suite !=3D prev_suite) {
+               add_suite(prev_suite, initialize, cleanup, count)
+               if (callbacks) callbacks =3D callbacks "};\n"
+               callbacks =3D callbacks "static const struct clar_func _cla=
r_cb_" suite "[] =3D {\n"
+               initialize =3D "{ NULL, NULL }"
+               cleanup =3D "{ NULL, NULL }"
+               count =3D 0
+               prev_suite =3D suite
+       }
+       if (short_name =3D=3D "initialize") {
+               initialize =3D cb
+       } else if (short_name =3D=3D "cleanup") {
+               cleanup =3D cb
+       } else {
+               callbacks =3D callbacks "    " cb ",\n"
+               count++
+       }
+}
+
+END {
+       add_suite(suite, initialize, cleanup, count)
+       suites =3D suites "};"
+       if (callbacks) callbacks =3D callbacks "};"
+       print callbacks
+       print suites
+       print "static const size_t _clar_suite_count =3D " suite_count ";"
+       print "static const size_t _clar_callback_count =3D " callback_coun=
t ";"
+}
diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
new file mode 100644
index 0000000000..32a81299e9
--- /dev/null
+++ b/t/unit-tests/unit-test.c
@@ -0,0 +1,18 @@
+#include "unit-test.h"
+
+int cmd_main(int argc, const char **argv)
+{
+	const char **argv_copy;
+	int ret;
+
+	/* Append the "-t" flag such that the tests generate TAP output. */
+	ALLOC_ARRAY(argv_copy, argc + 2);
+	COPY_ARRAY(argv_copy, argv, argc);
+	argv_copy[argc++] =3D "-t";
+	argv_copy[argc] =3D NULL;
+
+	ret =3D clar_test(argc, (char **) argv_copy);
+
+	free(argv_copy);
+	return ret;
+}
diff --git a/t/unit-tests/unit-test.h b/t/unit-tests/unit-test.h
new file mode 100644
index 0000000000..66ec2387cc
--- /dev/null
+++ b/t/unit-tests/unit-test.h
@@ -0,0 +1,3 @@
+#include "git-compat-util.h"
+#include "clar/clar.h"
+#include "clar-decls.h"
--=20
2.46.0.dirty


--VUqNFxrX/4uWDSS3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0WdcACgkQVbJhu7ck
PpQdJA//a8VeULFrglYR+Wv3h0Ln8yxTxJVImT9Z4j0xZ7OOwxtUUB8571r8m+3V
atxacTQ+3keRKv0RQ562xxcbAD4t+OBAbkn0/O9iozJkur0DwFWRNUv+m1jL6HXa
v8HH2IBtenc3qtLSZgcvLXtbiOMgsZBwcYZVK3SDCVxXHPpCd+8d75aeFqdVty1I
6z4qCd5Jt3NJJYSkVhh2XnIxWND45LKJwebSdPRhlDZV1wIfelC+cG1M3fibj9G1
+IPhk4sI4CPC5xaCS1QSfZfFYB9bwPvCYvTP34PmWlsJPFpENJS4UjiOfMxKYL37
yhlg/kwUOxiS/Zx7jrUbUp7bVp+lN4Py+MiOv199jHMCzl6TS5R3NdoQb/qvVnzw
JVxtn3xzSs12/fWhFPhKe47fJHIlNwtnlaSe5/eOoKCsAlObaYGMUk9RElEzppqa
PlU7xvFBgwMX3+0WCSqOnf6QsnWVoZ0OCK4x6jnpfmkwyFexO7th+VmWd6/gP7Mq
Qqj7/TC6Rub2sA2MJKL+1rbNKsFT8TI7e0K8oOgS81udaQvww5n+/cpkf7VlFgFi
/srbSlqQjHcbHzcWIuPg6GMUAPAuNI7SmepoY6aLYC1XKAC00BVrJgTN8oqZv9uO
4/IovMQhbw06NqXp0nocKS7zhws4jVYUSGElEU/4ExfWCQjMSI4=
=h4Q5
-----END PGP SIGNATURE-----

--VUqNFxrX/4uWDSS3--
