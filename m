Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC4118D627
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 14:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953680; cv=none; b=sUlakm8SuLIFbsIsS4OSpSRf7U9ULbx4XnlKBx+Tp8HDa4pAGHb0ZONj59X8k+0LJGwmGWTyeDCoeSpf2jXbLznkwPJQvQspsnUgwqLnGyN4zUHvdlIYzT3NP7ny7oO5FVuBK6kiWh5+/pyDrU/e1L3LNSjpuSwGExTgklSu4g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953680; c=relaxed/simple;
	bh=haizOnMb/uv6pbCK4tzkfpysiWTKbaIe6/uLAnC+Baw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBhL4WL4g4UqAQ9CRbkJkZuobZPH4Vu9dPA1KeXo3KroL/tlOEaQMIVj+vc5py6bKYhHFXfgf2hW3k4DhvPYPAMVMewh87DlvJD7ldq8OMPD92/F1DrVEtdsYZDlgsKCIjRX5PNwVHnTPIlDnDMyp0/SLNWvCsr82pJndtTHhvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IjcF0had; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iufj8QGB; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IjcF0had";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iufj8QGB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B7A38138DD0D;
	Tue,  6 Aug 2024 10:14:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 06 Aug 2024 10:14:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722953676; x=1723040076; bh=261S/zjrdp
	om+LQC37Ts+Qoatct3bUP0JPiZmXlDsgw=; b=IjcF0hadgJ+4OIlTcPL1Ma4XNj
	CRyOYmhWLUudk1eNLQEZuEb3UBGWdu47UhTWVdw2gGWnVb0n0NdBTeu7Wzu+k3mh
	+32EUpVg5cPmfuNEwqdXUJCuE/6yVF+XpASgtnHhGUUVylTBaX19Dble+IUM1hkq
	Y2XkabTQw1zr9tYfPKtwp8dI0gVuNuv/6AJacRqo1DS+dD2Kcf/mBp/y5iF49RQ/
	AxvNhokQf1IAC87aJCBrjB/R0QRUU0HIx7llfbcZ0x8QeFerukCgQjY0zJWaKx4/
	DtF8JbM3q41+S8wn66QBf0a5COQrMy/4uKX2Subih4/Hb1Rjq1WOlsMW9ong==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722953676; x=1723040076; bh=261S/zjrdpom+LQC37Ts+Qoatct3
	bUP0JPiZmXlDsgw=; b=iufj8QGB+nDUM2hVNY0V+BGnqryXFC1/R9XjkfsX1rRG
	5bAyiQC9wbSLJc/+yoY9IemrfjRZGyxZ6/JvS0pvfM0in1ycTMzEe6kzLuCu4cYV
	/GYl68Nz3PBtyaTRz8cx/GyTawtFxdfy4+BTXXPklEEN/bjV7VrxK+n9c11oU24s
	KtJIZ41TrNmBE2EF+8ORevHeY9hVY/L13IdpRltSV6a1Tts0A5vw3Gdcr6Sjc/X3
	9HZ6+8j6m8UbQkldyWCgk5QI6H4m98Ta286AQy1Hi2HNJZE9DRO3KwmWskxPaShv
	s6Y9o18M4P9X/dbEqqU3RSvHSMHleUG1ZY0qSEo7Mw==
X-ME-Sender: <xms:zC-yZoD_HlaiXkQd_rVpGyJEjrvGvfNP36MfEtvEPZzGgmPJw73t_g>
    <xme:zC-yZqjltVajyLWJg8XpiVVVY4qUqWKa0TeNLnEgl95MtTiLnYqbTeZjDUvxw0ctW
    -9MDBjpn8we6pC-Uw>
X-ME-Received: <xmr:zC-yZrkQCLZB0mB_aPYXnsigubCAx7cMx4xyknWBaHZqVsGNQlwt4Iab2JxG_s6FtgdXLcgTHEkZbkJFS-mAXMyCAA-XF93G6rakBtPY9CwB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeekgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpeffhffvvefukfhfgggtuggj
    sehgtderredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoe
    hpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedtledtjeeijedtkedvtdelleek
    jeduleetiefgledvudekkeekuedvgffhhfelfeenucffohhmrghinhepghhithhhuhgsrd
    gtohhmpdhgihhthhhusgdrihhopdgtlhgrrhdquggvtghlshdrhhhtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtoheptd
X-ME-Proxy: <xmx:zC-yZuzA5N0qchcWj8ua2o68CERtshClcFlWlqLEjiesIYf7vEDmTw>
    <xmx:zC-yZtTwjb2a__UKQWbErUjmgHc_2AP2MfLYHZD5fCgRMw7mmBzxgg>
    <xmx:zC-yZpaeJJhG9FzwYTs20c-nbxS3zOnfKXZW0gM7SkCLJZU9YyTO-g>
    <xmx:zC-yZmTb92Y0p-DgF3gc8qo4qFLegFs5OcH_YynJDTNMRqfv3lboIw>
    <xmx:zC-yZoGZsHPWbQ9X0iFR1-pIgncX6B_2THY-lM5EaLb6DfzILGiqP7Uh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Aug 2024 10:14:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d13c447d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Aug 2024 14:14:29 +0000 (UTC)
Date: Tue, 6 Aug 2024 16:14:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v2 0/7] Introduce clar testing framework
Message-ID: <cover.1722952908.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/vy9RAG4D91ihLvr"
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>


--/vy9RAG4D91ihLvr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my RFC patch series that introduces the
clar testing framework into our unit tests. The intent is to not have to
hand-craft all features of a proper unit testing framework, while still
not painting us into a corner. As such, the clar itself is small and
extensible while still bringing some nice features to the table.

Changes compared to v1:

  - Convert the ctypes unit tests to use clar, as I had it lying around
    anyway and Ren=C3=A9 was asking for it.

  - Adopt the AWK-based script by Ren=C3=A9, replacing the Python-based one.
    This gets rid of the mandatory Python dependency and at the same
    time also allows us to be more flexible going forward.

  - Wire up the third party sources in our Makefiles such that they do
    not get linted via hdr-check or Coccinelle.

  - Fix t/Makefile to not pass GIT_TEST_OPTS to our unit tests. They
    don't know how to handle those options, and clar-based tests error
    out when they see unknown options.

  - Adapt Documentation/technical/unit-tests.txt to mention the clar.

  - Rebase the series onto the latest master at 406f326d27 (The second
    batch, 2024-08-01) to avoid some conflicts.

  - Cherry-pick a whitespace fix that otherwise makes git-apply(1)
    unhappy. The CI job is still broken because the first patch that
    imports clar continues to be broken. I've created an upstream PR.

  - Cherry-pick a fix by Randall to make clar work on HP NonStop. The
    fix has been proposed upstream in a PR.

With these changes, the CI jobs at GitLab all pass, except for the
whitespace and clang-format checks.

I've also Cc'd Ed, one of the maintainers of clar. I also noticed that
I'm a maintainer of that project back from my libgit2 times, so I think
it should be relatively easy to land changes upstream.

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
 Makefile                                   |  42 +-
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
 t/unit-tests/{t-ctype.c =3D> ctype.c}        |  71 +-
 t/unit-tests/{t-strvec.c =3D> strvec.c}      | 119 ++-
 t/unit-tests/unit-test.c                   |  17 +
 t/unit-tests/unit-test.h                   |   3 +
 29 files changed, 3159 insertions(+), 98 deletions(-)
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
 rename t/unit-tests/{t-ctype.c =3D> ctype.c} (71%)
 rename t/unit-tests/{t-strvec.c =3D> strvec.c} (54%)
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

Range-diff against v1:
-:  ---------- > 1:  78a9cc1162 t: do not pass GIT_TEST_OPTS to unit tests =
with prove
1:  4e3862991a ! 2:  6a88cf22a5 t: import the clar unit testing framework
    @@ Commit message
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    + ## Documentation/technical/unit-tests.txt ##
    +@@ Documentation/technical/unit-tests.txt: GitHub / GitLab stars to es=
timate this.
    + :criterion: https://github.com/Snaipe/Criterion[Criterion]
    + :c-tap: https://github.com/rra/c-tap-harness/[C TAP]
    + :check: https://libcheck.github.io/check/[Check]
    ++:clar: https://github.com/clar-test/clar[Clar]
    +=20
    + [format=3D"csv",options=3D"header",width=3D"33%",subs=3D"specialchara=
cters,attributes,quotes,macros"]
    + |=3D=3D=3D=3D=3D
    +@@ Documentation/technical/unit-tests.txt: Framework,"<<license,Licens=
e>>","<<vendorable-or-ubiquitous,Vendorable or ubiqui
    + {criterion},{mit},{false},{partial},{true},{true},{true},{true},{true=
},{false},{true},19,1800
    + {c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{fal=
se},{false},{false},4,33
    + {check},{lgpl},{false},{partial},{true},{true},{true},{false},{false}=
,{false},{true},17,973
    ++{clar},{lgpl},{false},{partial},{true},{true},{true},{true},{false},{=
false},{true},1,192
    + |=3D=3D=3D=3D=3D
    +=20
    + =3D=3D=3D Additional framework candidates
    +
    + ## Makefile ##
    +@@ Makefile: THIRD_PARTY_SOURCES +=3D compat/poll/%
    + THIRD_PARTY_SOURCES +=3D compat/regex/%
    + THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
    + THIRD_PARTY_SOURCES +=3D sha1dc/%
    ++THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
    ++THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
    +=20
    + UNIT_TEST_PROGRAMS +=3D t-ctype
    + UNIT_TEST_PROGRAMS +=3D t-example-decorate
    +@@ Makefile: $(SP_OBJ): %.sp: %.c %.o
    + .PHONY: sparse
    + sparse: $(SP_OBJ)
    +=20
    +-EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/%
    ++EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UN=
IT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
    + ifndef OPENSSL_SHA1
    + 	EXCEPT_HDRS +=3D sha1/openssl.h
    + endif
    +
      ## t/unit-tests/clar/.github/workflows/ci.yml (new) ##
     @@
     +name: CI
-:  ---------- > 3:  a52ee59bf4 t/clar: fix whitespace errors
-:  ---------- > 4:  02fb86dfbc t/clar: fix compatibility with NonStop
2:  7a5dfd5065 ! 5:  848dc673c4 Makefile: wire up the clar unit testing fra=
mework
    @@ .gitignore
      /bin-wrappers/
    =20
      ## Makefile ##
    -@@ Makefile: THIRD_PARTY_SOURCES +=3D compat/regex/%
    - THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
    - THIRD_PARTY_SOURCES +=3D sha1dc/%
    +@@ Makefile: THIRD_PARTY_SOURCES +=3D sha1dc/%
    + THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
    + THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
     =20
     +UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
     +UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SU=
ITES))
    @@ Makefile: endif
     =20
      bin-wrappers/%: wrap-for-bin.sh
      	$(call mkdir_p_parent_template)
    +@@ Makefile: $(SP_OBJ): %.sp: %.c %.o
    + .PHONY: sparse
    + sparse: $(SP_OBJ)
    +=20
    +-EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UN=
IT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
    ++EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UN=
IT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar=
/%
    + ifndef OPENSSL_SHA1
    + 	EXCEPT_HDRS +=3D sha1/openssl.h
    + endif
     @@ Makefile: endif
     =20
      artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROG=
RAMS) \
    @@ Makefile: cocciclean:
     =20
      clean: profile-clean coverage-clean cocciclean
      	$(RM) -r .build $(UNIT_TEST_BIN)
    -+	$(RM) $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/.clarcache
    ++	$(RM) GIT-TEST-SUITES $(UNIT_TEST_DIR)/clar.suite $(UNIT_TEST_DIR)/c=
lar-decls.h
      	$(RM) po/git.pot po/git-core.pot
      	$(RM) git.res
      	$(RM) $(OBJECTS)
    @@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)=
/%.o \
     +	    if test x"$$FLAGS" !=3D x"`cat GIT-TEST-SUITES 2>/dev/null`" ; t=
hen \
     +		echo >&2 "    * new test suites"; \
     +		echo "$$FLAGS" >GIT-TEST-SUITES; \
    -+		rm -f $(UNIT_TESTS_DIR)/.clarcache; \
     +            fi
     +
    -+$(UNIT_TEST_DIR)/clar.suite: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UNIT=
_TESTS_SUITES)) GIT-TEST-SUITES
    -+	$(QUIET_GEN)$(UNIT_TEST_DIR)/clar/generate.py $(UNIT_TEST_DIR) >/dev=
/null
    -+	@touch $@
    -+$(UNIT_TEST_DIR)/clar-decls.h: $(UNIT_TEST_DIR)/clar.suite
    -+	$(QUIET_GEN)grep '^extern void' $^ >$@
    ++$(UNIT_TEST_DIR)/clar-decls.h: $(patsubst %,$(UNIT_TEST_DIR)/%.c,$(UN=
IT_TESTS_SUITES)) GIT-TEST-SUITES
    ++	$(QUIET_GEN)for suite in $(UNIT_TESTS_SUITES); do \
    ++		sed -ne "s/^\(void test_$${suite}__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$=
$\)/extern \1;/p" $(UNIT_TEST_DIR)/$$suite.c; \
    ++	done >$@
    ++$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
    ++	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TES=
T_DIR)/clar.suite
     +$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
     +$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR) -I$(UNIT_TE=
ST_DIR)/clar
     +$(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(=
GITLIBS) GIT-LDFLAGS
    @@ t/Makefile: CHAINLINTTESTS =3D $(sort $(patsubst chainlint/%.test,%,=
$(wildcard cha
      ## t/unit-tests/.gitignore ##
     @@
      /bin
    -+/.clarcache
     +/clar.suite
     +/clar-decls.h
    =20
    + ## t/unit-tests/clar-generate.awk (new) ##
    +@@
    ++function add_suite(suite, initialize, cleanup, count) {
    ++       if (!suite) return
    ++       suite_count++
    ++       callback_count +=3D count
    ++       suites =3D suites "    {\n"
    ++       suites =3D suites "        \"" suite "\",\n"
    ++       suites =3D suites "        " initialize ",\n"
    ++       suites =3D suites "        " cleanup ",\n"
    ++       suites =3D suites "        _clar_cb_" suite ", " count ", 1\n"
    ++       suites =3D suites "    },\n"
    ++}
    ++
    ++BEGIN {
    ++       suites =3D "static struct clar_suite _clar_suites[] =3D {\n"
    ++}
    ++
    ++{
    ++       print
    ++       name =3D $3; sub(/\(.*$/, "", name)
    ++       suite =3D name; sub(/^test_/, "", suite); sub(/__.*$/, "", sui=
te)
    ++       short_name =3D name; sub(/^.*__/, "", short_name)
    ++       cb =3D "{ \"" short_name "\", &" name " }"
    ++       if (suite !=3D prev_suite) {
    ++               add_suite(prev_suite, initialize, cleanup, count)
    ++               if (callbacks) callbacks =3D callbacks "};\n"
    ++               callbacks =3D callbacks "static const struct clar_func=
 _clar_cb_" suite "[] =3D {\n"
    ++               initialize =3D "{ NULL, NULL }"
    ++               cleanup =3D "{ NULL, NULL }"
    ++               count =3D 0
    ++               prev_suite =3D suite
    ++       }
    ++       if (short_name =3D=3D "initialize") {
    ++               initialize =3D cb
    ++       } else if (short_name =3D=3D "cleanup") {
    ++               cleanup =3D cb
    ++       } else {
    ++               callbacks =3D callbacks "    " cb ",\n"
    ++               count++
    ++       }
    ++}
    ++
    ++END {
    ++       add_suite(suite, initialize, cleanup, count)
    ++       suites =3D suites "};"
    ++       if (callbacks) callbacks =3D callbacks "};"
    ++       print callbacks
    ++       print suites
    ++       print "static const size_t _clar_suite_count =3D " suite_count=
 ";"
    ++       print "static const size_t _clar_callback_count =3D " callback=
_count ";"
    ++}
    +
      ## t/unit-tests/unit-test.c (new) ##
     @@
     +#include "unit-test.h"
     +
     +int cmd_main(int argc, const char **argv)
     +{
    -+	const char **args;
    ++	const char **argv_copy;
     +	int ret;
     +
     +	/* Append the "-t" flag such that the tests generate TAP output. */
    -+	DUP_ARRAY(args, argv, argc + 1);
    -+	args[argc++] =3D "-t";
    ++	ALLOC_ARRAY(argv_copy, argc + 2);
    ++	COPY_ARRAY(argv_copy, argv, argc);
    ++	argv_copy[argc++] =3D "-t";
    ++	argv_copy[argc] =3D NULL;
     +
    -+	ret =3D clar_test(argc, (char **) args);
    ++	ret =3D clar_test(argc, (char **) argv_copy);
     +
    -+	free(args);
    ++	free(argv_copy);
     +	return ret;
     +}
    =20
3:  1c2a510547 ! 6:  578e657269 t/unit-tests: convert strvec tests to use c=
lar
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## Makefile ##
    -@@ Makefile: THIRD_PARTY_SOURCES +=3D compat/regex/%
    - THIRD_PARTY_SOURCES +=3D sha1collisiondetection/%
    - THIRD_PARTY_SOURCES +=3D sha1dc/%
    +@@ Makefile: THIRD_PARTY_SOURCES +=3D sha1dc/%
    + THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/%
    + THIRD_PARTY_SOURCES +=3D $(UNIT_TEST_DIR)/clar/clar/%
     =20
     +UNIT_TESTS_SUITES +=3D strvec
      UNIT_TESTS_PROG =3D $(UNIT_TEST_BIN)/unit-tests$(X)
      UNIT_TESTS_OBJS =3D $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(UNIT_TESTS_SU=
ITES))
      UNIT_TESTS_OBJS +=3D $(UNIT_TEST_DIR)/clar/clar.o
    -@@ Makefile: UNIT_TEST_PROGRAMS +=3D t-reftable-basics
    +@@ Makefile: UNIT_TEST_PROGRAMS +=3D t-reftable-merged
      UNIT_TEST_PROGRAMS +=3D t-reftable-record
      UNIT_TEST_PROGRAMS +=3D t-strbuf
      UNIT_TEST_PROGRAMS +=3D t-strcmp-offset
    @@ t/unit-tests/t-strvec.c =3D> t/unit-tests/strvec.c
      #include "strvec.h"
     =20
      #define check_strvec(vec, ...) \
    --	check_strvec_loc(TEST_LOCATION(), vec, __VA_ARGS__)
    -+	check_strvec_loc(__FILE__, __func__, __LINE__, vec, __VA_ARGS__)
    - LAST_ARG_MUST_BE_NULL
    --static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
    -+static void check_strvec_loc(const char *file, const char *func, size=
_t line, struct strvec *vec, ...)
    - {
    - 	va_list ap;
    - 	size_t nr =3D 0;
    -@@ t/unit-tests/strvec.c: static void check_strvec_loc(const char *loc=
, struct strvec *vec, ...)
    - 		if (!str)
    - 			break;
    -=20
    --		if (!check_uint(vec->nr, >, nr) ||
    --		    !check_uint(vec->alloc, >, nr) ||
    --		    !check_str(vec->v[nr], str)) {
    --			struct strbuf msg =3D STRBUF_INIT;
    --			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
    --			test_assert(loc, msg.buf, 0);
    --			strbuf_release(&msg);
    --			va_end(ap);
    --			return;
    --		}
    -+		clar__assert(vec->nr > nr, file, func, line, "Vector size too small=
", NULL, 1);
    -+		clar__assert(vec->alloc > nr, file, func, line, "Vector allocation =
too small", NULL, 1);
    -+		cl_assert_equal_s(vec->v[nr], str);
    -=20
    - 		nr++;
    - 	}
    - 	va_end(ap);
    -=20
    --	check_uint(vec->nr, =3D=3D, nr);
    --	check_uint(vec->alloc, >=3D, nr);
    --	check_pointer_eq(vec->v[nr], NULL);
    -+	cl_assert(vec->nr =3D=3D nr);
    -+	cl_assert(vec->alloc >=3D nr);
    -+	cl_assert_equal_p(vec->v[nr], NULL);
    - }
    + 	do { \
    + 		const char *expect[] =3D { __VA_ARGS__ }; \
    +-		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
    +-		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
    +-		    check_uint((vec)->nr, =3D=3D, ARRAY_SIZE(expect) - 1) && \
    +-		    check_uint((vec)->nr, <=3D, (vec)->alloc)) { \
    +-			for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) { \
    +-				if (!check_str((vec)->v[i], expect[i])) { \
    +-					test_msg("      i: %"PRIuMAX, \
    +-						 (uintmax_t)i); \
    +-					break; \
    +-				} \
    +-			} \
    +-		} \
    ++		cl_assert(ARRAY_SIZE(expect) > 0); \
    ++		cl_assert_equal_p(expect[ARRAY_SIZE(expect) - 1], NULL); \
    ++		cl_assert_equal_i((vec)->nr, ARRAY_SIZE(expect) - 1); \
    ++		cl_assert((vec)->nr <=3D (vec)->alloc); \
    ++		for (size_t i =3D 0; i < ARRAY_SIZE(expect); i++) \
    ++			cl_assert_equal_s((vec)->v[i], expect[i]); \
    + 	} while (0)
     =20
     -static void t_static_init(void)
     +void test_strvec__init(void)
    @@ t/unit-tests/strvec.c: static void t_push(void)
      }
     =20
     -static void t_pushf(void)
    -+void test_strvec__pushft_pushf(void)
    ++void test_strvec__pushf(void)
      {
      	struct strvec vec =3D STRVEC_INIT;
      	strvec_pushf(&vec, "foo: %d", 1);
    @@ t/unit-tests/strvec.c: static void t_detach(void)
     -	TEST(t_detach(), "detach");
     -	return test_done();
     -}
    +
    + ## t/unit-tests/unit-test.c ##
    +@@ t/unit-tests/unit-test.c: int cmd_main(int argc, const char **argv)
    + 	int ret;
    +=20
    + 	/* Append the "-t" flag such that the tests generate TAP output. */
    +-	ALLOC_ARRAY(argv_copy, argc + 2);
    ++	ALLOC_ARRAY(argv_copy, argc + 1);
    + 	COPY_ARRAY(argv_copy, argv, argc);
    + 	argv_copy[argc++] =3D "-t";
    +-	argv_copy[argc] =3D NULL;
    +=20
    + 	ret =3D clar_test(argc, (char **) argv_copy);
    +=20
-:  ---------- > 7:  238de33b93 t/unit-tests: convert ctype tests to use cl=
ar
--=20
2.46.0.dirty


--/vy9RAG4D91ihLvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmayL8AACgkQVbJhu7ck
PpTGOg//TFe7Ega5mWE1k2/smsLWrl08KKQyyyUGg3J1Ls6JGnGaEJ++QYYZIqLy
5nW3WwGUBba0zt1qTzbZ7kje+nzhqLq0tOBEIrSnxW8HL+CNd9cwUU8VL9j5SNMK
4+I8nlmreNIvpH3yide5iHO0RyW8T6P1WWUgJxLbicGdunF1eR+bBiAUl9oBKQkO
OEfEeE5K7pc46V+ApdtCdDqo0+QRcdJ/ztzMza1uNbygJ+guT1Ntc3p9Ia1Uq4FR
qg02jdLn89CQafD6Y5KQfHs2xAyR+J6Og2esY0gs5fV+cZfDDvc38ErFMgsiGZs8
+SP2EGq6aBhDkL9baI2/VZCTFvXIKglq4h6QkNPTN8AGrBhY9OYb34zS7nZaeAiJ
DTj6s++Q292HqxxfF4dajixtkFrmFu+x0zQ2vwHyLBxnxOTW2RspoHylkud1QMiA
1y+nduNfbA+wjFtJP1Y0Zkyj5Po7tWmOSQjuC8hbZV6APfAlsDmrTL7ZuzM3dxtX
fPnEN6wOi+NMPPMvOk7Vce1Ojl8RjRv9llQxfNXzYC5jULxWl3smloNcGeA21vCQ
rJYv1eDk+li45wGh12UXdh1LOwoJHw5KarbNSJQ8jsjQPztBKhobbmUDYgRzIPkc
qCxlN8detUTNR/d6pQ5k9RaUI8NxBeEuCeaA6+gV7yYmHvuKD60=
=fofh
-----END PGP SIGNATURE-----

--/vy9RAG4D91ihLvr--
