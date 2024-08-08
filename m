Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ECE1A276
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723095497; cv=none; b=R7i5EaL1iotzruh+1F0OwoHN5Rr3HSJqsHkDdr3YQQ9LbE16h4hKPXR+DFal/BwTffP0ySOGYnHqj16fEnDDAddWNRSPDvMWGkaBB0YZA6vm6Mx2opoP/EBzUDjcPMG+zhxZProA3j2Yd4EzAjt+h3aHelpf1vgkcL7pnFVdBWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723095497; c=relaxed/simple;
	bh=OV9/Gc1jsmM64VVu0E/nMmPCtxivBs2PD0jG1t2tV7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIg4UXeXK6SIWnlb+mok4ZJCj0HNjGQ26DMoDSOLMGMgRMROrkl7eQzASbliFHR0IdBb2dnM1GnSx9CjFMCmanFpvdISczw8sDHE3kd1v8KbTBE4lrOhCF+w6LNpUTwWA0R2IoXAHUR3yK78J9nOr+uEz005tkDfd5G19CdF+mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K8HJBvS/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MZFQZdEk; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K8HJBvS/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MZFQZdEk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 969351151C68;
	Thu,  8 Aug 2024 01:38:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 01:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723095493; x=1723181893; bh=jdxHQXUkEf
	FJyWKyYASP+i7yqX9DxK28NgXiZW9YJ30=; b=K8HJBvS/ZEm/VIrqTckNBTikdc
	h7wTGy5Nd9d39nQUCAoUwelcdoU28W7ommSdZ4s3hkehJyddMd7ayolEd9cGJx8P
	6gyg4qDLdY8BIRoYIsYGFKSh5BEBU1Za2UurYE28FW+JowLpr3J8/PvYV0F/CvPq
	Si2FqvgIlSQ1Lr1UNKMBC44fVrspTrs5zSSbucsa4V10j3Cte4vCjYcpS+sPh5mN
	/E5t82k8Q8x0XVCZNnfLdx597wLxBVSkfIbTBa2h+d6bcCubMddamLCzEcdZVowl
	7l3MMjAl5SwPRxPzlqSMtxqzKQuaShmbo+I4+zD2+zuJh23W4TM/RJ/EL0rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723095493; x=1723181893; bh=jdxHQXUkEfFJyWKyYASP+i7yqX9D
	xK28NgXiZW9YJ30=; b=MZFQZdEkcoZE/5OCekrelBfygW5d74tEexXgV7hE7CYm
	opbQqFoqyB02Tyij6CVr5IcWlPh8kOc5Lk3MDKvLxA9GvY/Wwh/1vPqH8zVCukFs
	GeB8W5VRFopuC8UJYEdtJyatZnQJZMTPqCNAMEI3Q22xyzUe353mnXCHWeSs95FM
	uZ0qTOuiKv59tv6mWOJzP1ZD/RhsQOzwuYiCEWnuLTPCvPPHjQyuhtZAqa9reV7g
	IwnJXrD8EmOo5Frjs/Ylm+veKDUbhAyTFFDMog2r5LOCldIwXgiLVTJy7lTt1ogK
	+2sk/pax0Y/CqArPrC6PtrP/15LrqKWCZYUmngP8zg==
X-ME-Sender: <xms:xVm0Zm4K0uF-kKOaBkupkFGS-HrBmKweM67oYUSMwc0ye3yLb0gmTw>
    <xme:xVm0Zv5gKyVBgpD3Ss5Rz7W7LVrlXQYZiZIvDrQGFSAO3TwJsS04rSsUvjSkAvKSr
    -UcfrSIlcla_cYEMw>
X-ME-Received: <xmr:xVm0ZlfYJHLijTQcD2Dfz098Dal0XOmq6v3-3aDdPPc4FRhkbZuT7zuaeq9LvUwtxr9FrB7Gsj87SOzyXOHNzNmGSRYTaLw0t4dQM-ao3lI3OGec>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepshhpvggtthhrrghlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehlrdhs
    rdhrseifvggsrdguvgdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehp
    hhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopegvth
    hhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehrshgs
    vggtkhgvrhesnhgvgigsrhhiughgvgdrtghomh
X-ME-Proxy: <xmx:xVm0ZjKzJdvSWJ6ow5ivKS9udstu_CsRWCSlODsnosc2UGzdkoSB4g>
    <xmx:xVm0ZqL8Z_igEHCCKyvwsKxD5TnkjP8y25pbiwCWNKjRzEDbEeqJqQ>
    <xmx:xVm0Zky5fhPgZgzKSRxQVNc6_KXBX2h1OCTjplwONsEPA1QJYyif_w>
    <xmx:xVm0ZuK-HFSs1XUdSQQatv-Tr1c5CRsZMzM05XTmgoAG74eE3CYbIA>
    <xmx:xVm0Zp-EJiQkempSTbJ0V2JBBy9Z6t-QlkIaCIwN4q0oz2fbxu6W94xr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:38:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e75cc74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:38:04 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:38:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
	Edward Thomson <ethomson@edwardthomson.com>
Subject: [RFC PATCH v3 0/7] Introduce clar testing framework
Message-ID: <cover.1723095269.git.ps@pks.im>
References: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="acUH2pmAdRxQD89g"
Content-Disposition: inline
In-Reply-To: <cover.1722415748.git.ps@pks.im>


--acUH2pmAdRxQD89g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my RFC patch series that introduces the
clar testing framework into our unit tests. The intent is to not have to
hand-craft all features of a proper unit testing framework, while still
not painting us into a corner. As such, the clar itself is small and
extensible while still bringing some nice features to the table.

Changes compared to v2:

  - Fix a copy/paste error for the clar license. It's ISC, not LGPL.

  - Include "clar.h" via "clar/clar.h" such that we do not have to add
    "clar/" as in preprocessor include directive.

  - Adapt strvec unit test to use `cl_assert_equal_i()` instead of
    `cl_assert()`.

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

Range-diff against v2:
1:  78a9cc1162 =3D 1:  78a9cc1162 t: do not pass GIT_TEST_OPTS to unit test=
s with prove
2:  6a88cf22a5 ! 2:  b6c066ee4e t: import the clar unit testing framework
    @@ Documentation/technical/unit-tests.txt: Framework,"<<license,License=
>>","<<vendo
      {criterion},{mit},{false},{partial},{true},{true},{true},{true},{true=
},{false},{true},19,1800
      {c-tap},{expat},{true},{partial},{partial},{true},{false},{true},{fal=
se},{false},{false},4,33
      {check},{lgpl},{false},{partial},{true},{true},{true},{false},{false}=
,{false},{true},17,973
    -+{clar},{lgpl},{false},{partial},{true},{true},{true},{true},{false},{=
false},{true},1,192
    ++{clar},{isc},{false},{partial},{true},{true},{true},{true},{false},{f=
alse},{true},1,192
      |=3D=3D=3D=3D=3D
     =20
      =3D=3D=3D Additional framework candidates
3:  a52ee59bf4 =3D 3:  35682b7686 t/clar: fix whitespace errors
4:  02fb86dfbc =3D 4:  7a76c21bcb t/clar: fix compatibility with NonStop
5:  848dc673c4 ! 5:  68b3c65951 Makefile: wire up the clar unit testing fra=
mework
    @@ Makefile: endif
     =20
      bin-wrappers/%: wrap-for-bin.sh
      	$(call mkdir_p_parent_template)
    -@@ Makefile: $(SP_OBJ): %.sp: %.c %.o
    - .PHONY: sparse
    - sparse: $(SP_OBJ)
    -=20
    --EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UN=
IT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar/%
    -+EXCEPT_HDRS :=3D $(GENERATED_H) unicode-width.h compat/% xdiff/% $(UN=
IT_TEST_DIR)/unit-test.h $(UNIT_TEST_DIR)/clar/% $(UNIT_TEST_DIR)/clar/clar=
/%
    - ifndef OPENSSL_SHA1
    - 	EXCEPT_HDRS +=3D sha1/openssl.h
    - endif
     @@ Makefile: endif
     =20
      artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROG=
RAMS) \
    @@ Makefile: $(UNIT_TEST_PROGS): $(UNIT_TEST_BIN)/%$X: $(UNIT_TEST_DIR)=
/%.o \
     +$(UNIT_TEST_DIR)/clar.suite: $(UNIT_TEST_DIR)/clar-decls.h
     +	$(QUIET_GEN)awk -f $(UNIT_TEST_DIR)/clar-generate.awk $< >$(UNIT_TES=
T_DIR)/clar.suite
     +$(UNIT_TESTS_OBJS): $(UNIT_TEST_DIR)/clar-decls.h
    -+$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR) -I$(UNIT_TE=
ST_DIR)/clar
    ++$(UNIT_TESTS_OBJS): EXTRA_CPPFLAGS =3D -I$(UNIT_TEST_DIR)
     +$(UNIT_TESTS_PROG): $(UNIT_TEST_DIR)/clar.suite $(UNIT_TESTS_OBJS) $(=
GITLIBS) GIT-LDFLAGS
     +	$(call mkdir_p_parent_template)
     +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$=
^) $(LIBS)
    @@ t/unit-tests/unit-test.c (new)
      ## t/unit-tests/unit-test.h (new) ##
     @@
     +#include "git-compat-util.h"
    -+#include "clar.h"
    ++#include "clar/clar.h"
     +#include "clar-decls.h"
6:  578e657269 ! 6:  4a0888380e t/unit-tests: convert strvec tests to use c=
lar
    @@ t/unit-tests/t-strvec.c =3D> t/unit-tests/strvec.c
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     +	cl_assert_equal_p(vec.v, empty_strvec);
    -+	cl_assert(vec.nr =3D=3D 0);
    -+	cl_assert(vec.alloc =3D=3D 0);
    ++	cl_assert_equal_i(vec.nr, 0);
    ++	cl_assert_equal_i(vec.alloc, 0);
      }
     =20
     -static void t_dynamic_init(void)
    @@ t/unit-tests/t-strvec.c =3D> t/unit-tests/strvec.c
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     +	cl_assert_equal_p(vec.v, empty_strvec);
    -+	cl_assert(vec.nr =3D=3D 0);
    -+	cl_assert(vec.alloc =3D=3D 0);
    ++	cl_assert_equal_i(vec.nr, 0);
    ++	cl_assert_equal_i(vec.alloc, 0);
      }
     =20
     -static void t_clear(void)
    @@ t/unit-tests/t-strvec.c =3D> t/unit-tests/strvec.c
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     +	cl_assert_equal_p(vec.v, empty_strvec);
    -+	cl_assert(vec.nr =3D=3D 0);
    -+	cl_assert(vec.alloc =3D=3D 0);
    ++	cl_assert_equal_i(vec.nr, 0);
    ++	cl_assert_equal_i(vec.alloc, 0);
      }
     =20
     -static void t_push(void)
    @@ t/unit-tests/strvec.c: static void t_detach(void)
     -	check_uint(vec.nr, =3D=3D, 0);
     -	check_uint(vec.alloc, =3D=3D, 0);
     +	cl_assert_equal_p(vec.v, empty_strvec);
    -+	cl_assert(vec.nr =3D=3D 0);
    -+	cl_assert(vec.alloc =3D=3D 0);
    ++	cl_assert_equal_i(vec.nr, 0);
    ++	cl_assert_equal_i(vec.alloc, 0);
     =20
      	free((char *) detached[0]);
      	free(detached);
7:  238de33b93 =3D 7:  f423b01c05 t/unit-tests: convert ctype tests to use =
clar
--=20
2.46.0.dirty


--acUH2pmAdRxQD89g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0Wb8ACgkQVbJhu7ck
PpThshAAo4w0vo4gvQHKSv7Ya+bTNSM4I3hrc3TmQHoFRGze3XKbhL1go6A8nyHH
Zl8xBCgPccTFJGtx6WXC/+kLWRHk7K29NBpxGQUziX2VN6V2MJCQcPxBW7WbArwd
9rh7PXEq/yDyBSGoPIGhOHogsfY4usR9stePKLxMSBYt2Lgi5GpbvR0VcdaOCNX0
mte+YydjnpZOWQvL4PQy6SfYFsoI5/oLmr35nBT5IoMeYjoRB0GzA6pmFA8oOQij
fdbs9ebBE+f/YfoEwbUe58a0KJdTWBNBS6ICG/bVTBB9h4jXPQTQF536tGJ1i88L
cr4rhNO/lOyI30B48/dTNh7HRAXmB0dBcsAC208A/kOAjTnXRq4HHtlIDD8Kp3F5
MQ3qkO1CRAQWdQ8knQ7L4jbQBzoreDOmiJGhSKAvq5VyaQIwXe9HFCIWAxymzBKO
2xKEJik2Q4Q87AV5w3R4fXxSNzJmdLVgPMIEcJW7cwlVHuIAKTnlRL7NoUjGQaqt
114gm3fw/tWJ9MmjIrwNkabuNHJ3kvLEd6B46qbl1HJ6ylYFiGqBqoKRMe4zkGcd
5uzBOVLJUK8yFyPBg4YACEk2A3mC1/GixU7H1zaqNlvDxwu7Y6MDNynsm2tQh00I
1fARyHekA2reo7saaB3vWhXIRGPWT1TYtHXrOb2v9J0NWYIYZE8=
=ZHE0
-----END PGP SIGNATURE-----

--acUH2pmAdRxQD89g--
