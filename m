Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4B318D62C
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953701; cv=none; b=ls+BgLrtyNn5RuRby/bY4XiM6qFU53Gz38unxf3eKU1c7pWnOBC1Kb7gJHIDc3gCSK5pXfP/VOU5NDsCf4U8htquEw78atEuvQSySr35bMQruKsON20t5i4IsztxaJTNJ+wiuO6YpGPB7BeB51efcO0ZE4V5u5a8kr5yHu3g270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953701; c=relaxed/simple;
	bh=PsZcA1K/DOxDUYF/TEHvpGdVG88ict5qdd0iU49bOEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqQNztZ/hCak9XhiEHAt6v4oLPlsjHe8pwSpB2ZuMvcXyJOFsm2qiYlE1w6hOcq0Ve+6U330hiutyt57B1rbU1RejNLvR4BQq5GnGATzidYBzugGqXPiCwg/dTrLnIhDQzW2PwFKtvqjxtAbYQZqzFHiR336N36Fj19khPSpbCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G5aZLeG3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YivJmlkr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G5aZLeG3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YivJmlkr"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 56CC211509B2;
	Tue,  6 Aug 2024 10:14:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 06 Aug 2024 10:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953698; x=1723040098; bh=GJn6mMPYcm
	KTXfmbljy0xTc48oLoFkxyJVm9XuZhgKU=; b=G5aZLeG3TNcgWr/13rSSABIaWa
	TOpx2mB1+lmCL2NyILvFM3Qk537VVdQAQRL3MluRfOB3eqQqHjStl0fxx0ov6dgy
	MdhuhNvpKxdVrKZnD8PwjWJzCAPJNP2r1O6SaQMsdobnfAO2Ro4Ye3/GYKEAmY4G
	UQe8tlGD9frDxeiFQWZarOO1/H5wgm8WRHVu5jkkrj0Xy1O5+l1KDwZgMwPvpqm7
	JKTL/y4EkAkXRRc4ZlcyDq4Vs44wbrODAvw+8txh9Rh0gLuAeE2d0w2J1Tyienc0
	raoiBw3xcavmZ5/RgGCTObMokjmSqk9BhJ8mcJsITCNMdGWHjNHBAPwyl+Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953698; x=1723040098; bh=GJn6mMPYcmKTXfmbljy0xTc48oLo
	FkxyJVm9XuZhgKU=; b=YivJmlkrfXMd3+R4b4QOcCPwiMZfQOXATpGAdBY4vK02
	X0U8v+Wq3L/oQdiaC7dwrJJOghq6uUy2+xr9GzPk6rqV4eGmWhdrX9mOYj6k2pHn
	ZVhzMdP8FMTxGKZwT+jsM6156Wi1GvuWcB8qb3rHjL6elPSBlZ2LvYZ9DBPyuL9A
	n1xe79i/R+LjMcqBVj4ncdavccEI2n8mm0/ruz6FhBV/ZzChGmXTZGt4Bn1pJ/c1
	q1M/f82/89nQtvE2V1oY1eNXdWcZpJyf/H/MFh0TeF0BNoOHb/h5GYe0I63B96kv
	ppi6joyXXCShxvGsIolGHVXdHTveNHim/IUmV/u9Cg==
X-ME-Sender: <xms:4i-yZteCf88Z1SixV82Tlqs4B6PsnkGXPwguSm9YTsUuq81Qk534aA>
    <xme:4i-yZrP7AUEC1BMeWMQzTT7qwbJHlhovA-EVMdoOINs3eHmMFCGb5V9SrHOuDyi5P
    GPaxfPsfnK8ntRvyQ>
X-ME-Received: <xmr:4i-yZmhVX7DgaeDbOG7qmpwdD34n2lgHiujY3dRj5FyweN7--ryWdDPkSFcMse1lJXdAPyBTB4YOiLWP4FUTQrlFP8yOWc5DBRHScY0INQSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:4i-yZm85FvAQuC0UyRjOZNG8uMIKDflVuaQ--8dFZG_ye4EVZ-JWDw>
    <xmx:4i-yZpvyp6ELSPV6RLSGJ9rlngRZdtBHFKD_42ApIGpoGm7NCsCTlw>
    <xmx:4i-yZlEqREqzBXQEv5LK43ZpAX3ikBHCdckVRDJsgJnlKTDDMGXRGg>
    <xmx:4i-yZgNcVJB93_wyrs9YooMJfl2VlUGOxZcqa9DpGFcB9AMpqEHeAw>
    <xmx:4i-yZvBnrnH_Ti5pXbo3sBQe65tTNtk-lffwo1nCVHk2E0J0SZff4fsK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:14:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1053f1c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:14:53 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:14:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 5/7] Makefile: wire up the clar unit testing framework
Message-ID: <848dc673c494d7771e1c1c64e8cd56788f9c6b8e.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
 <cover.1722952908.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7pnCfArie3e8/faD"
Content-Disposition: inline
In-Reply-To: <cover.1722952908.git.ps@pks.im>


--7pnCfArie3e8/faD
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
 Makefile                       | 36 ++++++++++++++++++++----
 t/Makefile                     |  1 +
 t/unit-tests/.gitignore        |  2 ++
 t/unit-tests/clar-generate.awk | 50 ++++++++++++++++++++++++++++++++++
 t/unit-tests/unit-test.c       | 18 ++++++++++++
 t/unit-tests/unit-test.h       |  3 ++
 7 files changed, 106 insertions(+), 5 deletions(-)
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
index 674b0ac4e1..f56b14ad6d 100644
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
@@ -3262,7 +3268,7 @@ $(SP_OBJ): %.sp: %.c %.o
 .PHONY: sparse
 sparse: $(SP_OBJ)
=20
-EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UNIT_TE=
ST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
+EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UNIT_TE=
ST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
 ifndef OPENSSL_SHA1
 	EXCEPT_HDRS +=3D sha1/openssl.h
 endif
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
index 0000000000..99d59df1b0
--- /dev/null
+++ b/t/unit-tests/unit-test.h
@@ -0,0 +1,3 @@
+#include "git-compat-util.h"
+#include "clar.h"
+#include "clar-decls.h"
--=20
2.46.0.dirty


--7pnCfArie3e8/faD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL9wACgkQVbJhu7ck
PpTZjw//XKbNdIoU1VHZCR9A0+WxqNw/LOYR9zINNMfufnGq5TS3QgFY7hQLbAVE
2YwqeYxkOsZDs/FGp++HeGvcwCFY/jXRMrBF44Sda1a3yVdW8xG1a/enX8DWVB6n
1Uq4k8JbINCr62m87jZEtcVekEjWBb8PrXGO3CVgYKavXlhkQOg3Hc53/RJEn1PD
QREa6WAObUs69n+GQbrs+1SC2fTo+Q1L6M01Uoft9EMl+26fFbV0INNagaSDWvF/
ecA/LB/8lxmeNij4E2tp/sHlpejGeyFxDQ8gZTYTDqzs3ifpK2gZwb4TitGzn6P6
/wM2dI+RVFiZJ3wXKoTWu5pnvea4R0D7vhWpt9udZ6aMYFHnLZTZFAP6vvp8XZ80
Lazu9BerpXIEPHDDjrUx8XJPnE4rX/p6rtnOwzM7d8jZfaYKP3Dq+Fnnns2dXKxo
4bPRGxCLU75fWmfWzp7c7JcN0SWqSmQDh1BkIjqpecW7qW1vlLEXgmotjEBX2UuG
R7zVzhikSq0+ccITry9MAWKTheY67DsCqVdu7lxRfNWkpEcCi8rP5ct1HkS71faY
LQMtX3jRnjaME8Ctfo0EOhdASPJZ7KTdomQpKawLo5qWsIexQmPWrvY+IH6HdO/6
51Gil5e2HgsTD6JEa25o6R6ulBpRJdHQHuZQHiHGnOL1ypsRNU0=
=cU+1
-----END PGP SIGNATURE-----

--7pnCfArie3e8/faD--
