Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5611CF93
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 09:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722416660; cv=none; b=eH8PP8Z7RnAEo4DWCn8x9kCGnFTO8j7zrCPJ78uddAXrn5mLYrXTJnuml3ar2L/Q9t4Npo0Dv5wBj6IzYBEHcGKTPAW+V1TT3+7ZmGqq5et7RThJYeeJvORPXFo3fliTiHqVK3L51t3CPWJYtsu9nmLqV8J7YuNLiedPKe6XMyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722416660; c=relaxed/simple;
	bh=EbIcgNhFwwlMy3RFznQN0Jy7rIBxvzQMB2DFg9e3M7E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BxSOMUYZstg7UcoBTuCby77BKiIFucCqsSq95uf7J5o3FPF2uJQliv5syIR9OwCmgJrbL1r42yhG30ukS0xS6wZS514oHnD1mLdzzTvu4kUS5PUHI4vZaLZE4IEaDXkNhkw4555F+ndTmzdCO4fvdHXAeU/5ZxvVVFdJornMh4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IjeFvZbQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AAzksFJI; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IjeFvZbQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AAzksFJI"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 071271146DB7;
	Wed, 31 Jul 2024 05:04:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Wed, 31 Jul 2024 05:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1722416657; x=1722503057; bh=5ORKJ9uJ3KeWN63qSaqB9HTwzPQYHYKu
	0rHag1SqVm4=; b=IjeFvZbQDIU4L2Ls41bsxG1TXDKAeNlw9pV9iYCmMLNujkfQ
	3x0FCi7eY8m25DC+At9LEo3BAZxOoz5bgrffr8CteARgGtD5mjSnNVS4NQcGbxTo
	j1tpBGhlLtf1oTmHs+SvZCtKimUZ4DNJBlxp6smJkkJ7wBzut/T7IfDa2ygvkqEd
	yJI+s317ZG5yCL3Gb2PyolmKuKbfA9KBWf4b+0V6dZ6RpIQQQuKmoZpuYfLGXk2s
	/rjYBDenjdJaU+37Ctlj/6dRn5vWIpxihihalPyLdRVsKZUwnFJZ2Dl21pWPV2py
	CHHHB9ienH0YOCA0wGnqVOBBUwQkor9OAcqc6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1722416657; x=1722503057; bh=5ORKJ9uJ3KeWN63qSaqB9HTwzPQYHYKu0rH
	ag1SqVm4=; b=AAzksFJIrdfnwfI7DKqN+AkswspoFV4Uv5fcmJ0iVBq7V+Q2Lsp
	YecVcION3RHH2S9mdcK+JKB3Hnw2qGx8CMRe+KMmBpADuNThakTZVBMDDLQ6wk0C
	QXRCzvLuYVeGgt9sKK/BdWjVucDY9qAy/Xv5NJKFDa8UnBxJ33O5sK5k9yL8abYi
	A43K/6x1Usp2pCq54aJgdjgesrSRjWTLX3EWFWiX6gUyVPAhUrNU2JBuZexM/g2U
	BWoijrTZwII2NcQOwxx+WOkHicr4+xtuDG0TjeVwxfxzc5RZ18ymj2PnxSZMXtCE
	HGJdLjk59SxQcCGPhYwA2tXzXNCRbq7f4qQ==
X-ME-Sender: <xms:EP6pZjHwGjvJaK_O82NQbSpB5AyOXCXSr6ulTh0cnU-HB1e4AwUg_w>
    <xme:EP6pZgVnZpFmaAfx00tkqciJd49N8DX7grTVV-wSC9sDR1vZZ_y44RM--l1ZlH-aU
    vv8kO486l_YCypoiw>
X-ME-Received: <xmr:EP6pZlKzJC-9n5tz61cHi9YyYN8KH-0NqYJmDTKNSVF8lh55iSvEE-39eEBeEOlH5yBqnvlUGQGi9nHSUUBLNiZEesz81j16Pr3GUjcgRB9rcW8_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfggtggusehgtderredttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    euueehfeeuledvvdefueehvddvvdffhfetffekvdfhjeevhffhtdejvdduvdehueenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:EP6pZhFyN7yA-hsnI90vT52QuANTTFbVgkL7FGC-RShNPOCi3k2E7Q>
    <xmx:EP6pZpWbBhbMV67uF1lpOYTuWF0j1xq1BKX15FJcSnlCvwnIB5Zwcg>
    <xmx:EP6pZsO42nQj76lSeE4iJ7V7aiGCqblpUI7y29FJOVHADqEyRDI9yQ>
    <xmx:EP6pZo1ugSMLuZ1RqVIM_8I6hWFFxX0lgwcJpo0pA4DfodZ6uvdzpA>
    <xmx:EP6pZrLDWBk9tBAmD6_9ZV6NvGrB3X8IOq6reNHbrR24mvOG3nS7eX-F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 Jul 2024 05:04:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1d4b45f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 31 Jul 2024 09:02:44 +0000 (UTC)
Date: Wed, 31 Jul 2024 11:04:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Josh Steadmon <steadmon@google.com>
Subject: [RFC PATCH 0/3] Introduce clar testing framework
Message-ID: <cover.1722415748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WJkRa8i4VrKZAQzw"
Content-Disposition: inline


--WJkRa8i4VrKZAQzw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

there's been some discussion around extending our unit testing framework
to avoid duplication when declaring test functions. Right now, a testing
function has to be declared and then wired up via the test's main
function, which can be a bit annoying. In the thread, Ren=C3=A9 proposes an
alternative that gets rid of this duplication by using macros. And while
that does solve the issue, there were some concerns about things being
too much "magic" while at the same time not being flexible enough.

Part of the discussion revolved around whether we maybe want to have a
proper unit testing framework in our codebase instead of reinventing the
wheel. As I quite liked the "clar" [2] testing framework from back when
I was still developing libgit2 I proposed it as a possible alternative.
This patch series wires up the clar framework as a proof of concept and
converts the strvec test suite to use it.

The magic to avoid the above code duplication is quite self-contained in
a "generate.py" file. This script extracts function declarations from
all unit test suites and then writes those into a "clar.suite" header
file. All that one needs to do is thus to declare a function with a
specific name "test_<suite>__<name>" and then everything else gets wired
up automatically.

Whether this is better than the solution proposed by Ren=C3=A9 is probably a
matter of taste. While I'm not a huge fan of the macro-based solution,
I don't want to veto it either (not that I'd have that power anyway). So
please, you should rather read this as a proof of concept to see how
alternatives could look like such that we have a better picture of where
we want to end up.

Some random thoughts:

  - The mandated Python dependency is suboptimal in my opinion.
    Rewriting the script in e.g. Perl should be easy enough though, it's
    no rocket science.

  - I prefer that the proposed solution results in a single binary as
    compared to one binary per test system.

  - The clar gives us the ability to pick which tests to run via command
    line parameters, which I personally like more than picking the
    specific binary to run.

  - The clar replaces some test assertions that we already have. They
    feel a bit more mature, but overall there aren't all that many
    assertions available. If we wanted to pick it up, then we'd likely
    have to add some more wrappers.

  - The clar uses longjmp instead of manually having to `return` from
    functions in case there was an assertion failure. This is easier to
    work with in my opinion.

Also, note that I only tested this on my Linux machine. I have no clue
whether this works as-is on Windows, but I do know that libgit2 tests
run on Linux, macOS and Windows. So it should work in theory, it's just
a matter of polishing this series.

I'm happy to hear your thoughts on this, even if it ultimately ends up
being shot down.

Patrick

[1]: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
[2]: https://github.com/clar-test/clar

Patrick Steinhardt (3):
  t: import the clar unit testing framework
  Makefile: wire up the clar unit testing framework
  t/unit-tests: convert strvec tests to use clar

 .gitignore                                 |   1 +
 Makefile                                   |  36 +-
 t/Makefile                                 |   1 +
 t/unit-tests/.gitignore                    |   3 +
 t/unit-tests/clar/.github/workflows/ci.yml |  23 +
 t/unit-tests/clar/COPYING                  |  15 +
 t/unit-tests/clar/README.md                | 329 ++++++++
 t/unit-tests/clar/clar.c                   | 842 +++++++++++++++++++++
 t/unit-tests/clar/clar.h                   | 173 +++++
 t/unit-tests/clar/clar/fixtures.h          |  50 ++
 t/unit-tests/clar/clar/fs.h                | 522 +++++++++++++
 t/unit-tests/clar/clar/print.h             | 211 ++++++
 t/unit-tests/clar/clar/sandbox.h           | 154 ++++
 t/unit-tests/clar/clar/summary.h           | 143 ++++
 t/unit-tests/clar/generate.py              | 267 +++++++
 t/unit-tests/clar/test/.gitignore          |   5 +
 t/unit-tests/clar/test/Makefile            |  39 +
 t/unit-tests/clar/test/clar_test.h         |  16 +
 t/unit-tests/clar/test/main.c              |  40 +
 t/unit-tests/clar/test/main.c.sample       |  27 +
 t/unit-tests/clar/test/resources/test/file |   1 +
 t/unit-tests/clar/test/sample.c            |  84 ++
 t/unit-tests/{t-strvec.c =3D> strvec.c}      | 124 ++-
 t/unit-tests/unit-test.c                   |  16 +
 t/unit-tests/unit-test.h                   |   3 +
 25 files changed, 3041 insertions(+), 84 deletions(-)
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
 rename t/unit-tests/{t-strvec.c =3D> strvec.c} (54%)
 create mode 100644 t/unit-tests/unit-test.c
 create mode 100644 t/unit-tests/unit-test.h

--=20
2.46.0.dirty


--WJkRa8i4VrKZAQzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmap/goACgkQVbJhu7ck
PpR8phAAqSxkH/MsltMWw2UBBpwGIev/I0Py03epPDrElC1uqeJwJt9I2AyqTbyB
E9HV/A0e5qP/wphpUODtMxiRSfaQxkR/9Ht8Ski5bC/Z7dcVjS2Pebf7Kjdv2INS
P0I2hPX8cEj3Xv2e9sDx9N+0B1zMB9B6qtvs9DWcTWEDNKrfIgCdzNxlyCStwQU6
IDyjee3ZUoGDOdKCYpvm+YaXdpljezngWF5vOx1njs02sb3jQJqNDmEYSi4+ArPw
oDSW3RfuET/c0F1rOwviDLM64tqgv47dTZ/hx7qtqz2fUHIrnPW2ExlY52Pua4PK
gXHSWhPzlA7Vw00Stsrtb/WL+gdhVjHd/gQltAzQioJgmPxY2/YMmXoqNc+DXyGO
G2fG9HDHGPY2oWY6FMKqbKfuRI/Rjho7wWBystTpF+AjjlnvtEX+2w/cEeMPXUmP
a9vLFPk1eVL1WoQRSm/40v3NNWCy1zCLN8e+qStt9SgikTze4+T3LsiHGKbPoNY0
1c46kSeoUXU8Nem+X8suKooqKpUyoHjWUhb7oF4NxRQwDV1XemrfPHaCcfjwowa7
urJ+OEcT0AYdgsFvDr7aGTThyFRXLwBeVaLKRscnF8a71fWR6E9GAGwKeNA2UsHG
AEisZWSiPRqPQUkmqTN+aS4/5qWrPNT2sKJMSzXrjbQ2HlamiWI=
=XALu
-----END PGP SIGNATURE-----

--WJkRa8i4VrKZAQzw--
