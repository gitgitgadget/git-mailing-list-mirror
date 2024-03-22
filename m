Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334A26138
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074226; cv=none; b=fBc0ypQfQZOIT46xCqllTQ0RWCZe6cDQPk8Nuk1y8Kv3el9vWTI1LZmyUswxvz8qOvjtmQ6//jvK/PSCzxrVi3PbAp1cIiMY5VotGLBCg5Xo2cyibgI3QsoMuODIQR1j+B52mSENTn/HQavhFjQtSdIFnWZJ68c4mcBJfWhx7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074226; c=relaxed/simple;
	bh=IrgggXFUfHGbDFLLauam++jvzsXZ6xrCkJuewU8ykqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ock7WFPW/3RUaxq4HwSTDFicKK0qiJFt5Bwevmuw2FdqHjY8qgfxoam8/PMNjCJ+r8cBQ9MYVNrlgpYu3FwZr4FeSRA3TMFy7Xiu9E+loNqId5PYADK8i6MXX80MRVEeD506KdfWnKPeuuXFUQOuoanx8ctbbLy3lw7OU9fFGHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ImiBIt08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h7Bi6g2g; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ImiBIt08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h7Bi6g2g"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4AAAF1380132;
	Thu, 21 Mar 2024 22:23:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 22:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711074224; x=1711160624; bh=Drs77VrjrW
	ItoAofLOW5ER/b+9W004Zczz+1OWtfzas=; b=ImiBIt08Bx4oSczrpoYFZ0+FdY
	NCXhyOO2/zxuhM5bv3qpgCsCgpCwg/WWllTiAktuHv/MV278KQmaeicduhbN5GtC
	+Vb/riNRQm6Sqsr3ARX1dcufR0ABcZuPWPtFiBNtcYCZ5kquSBnwl3CSQnS3ippf
	Qc/CGj3rND/+VsxjxjXp+ZsMGcQRlXAgOXM7oGwWOudUY+DgkIlaNMZAy0f24DLg
	nT5ypYK3nohMLqV/tgpEqdWVAbjEpwKXEo6GqF2//aVCzfOAexg1v3hB/dm3F10r
	PAwgfJpW1VjvS5c3nUN68l6t42/P1zHaMXHUO9Ya46ayEuSmDgIO4kk9fDXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711074224; x=1711160624; bh=Drs77VrjrWItoAofLOW5ER/b+9W0
	04Zczz+1OWtfzas=; b=h7Bi6g2gxEs1MQXVE6kNpej7Ln9uv6h/wgHXPpFfOqrO
	F5RiyXvdPjDuDZU+MbVdZ3Ve3W9yivVzrXm/OcyILeh9/cpXtWf1eTt6LSaI0wRI
	4OaIfUJLGF78loYXawG5JEyGRKv5cliEZGDBsJZA0UDI0m3tKst+sFcd86Zsjvfe
	/37fVkdI9YRvGIwvwHcuAI8+EnLhxnjgNWwWyIeoAldBSNaVqMozzWBPSTiur3Gb
	tfDDncuW57Z9nqWlW4MgoCwpUWiHecpJu/AKgRUgt5AL8MD+fZLS8a+gs6iBV4HP
	hUCQxKjtLBPkxjQqilq+7xnp1c3hUWr9dD6IxTgy4w==
X-ME-Sender: <xms:sOv8ZavTCZHcYPr00CVcR8hn29xnPcAUz_73RQcCrGlJvTsytWe8Wg>
    <xme:sOv8Zffd9EgfkD3NygDkdqz0ZbuSwQulLahtU1UvOFsVLV5hZYE-xnfSDn4sBrGny
    MmYlAUKuYN7SU1ZnA>
X-ME-Received: <xmr:sOv8ZVzEwtg2cZzANVnSeCawP-t3pmzrvN4oWd1XkG_2F9Lg6QIQbFvof6X2YCH3GRpsAqWaPkZKMqEp6fQ3nRsBLl-1fK3wDzj6_kCdPau2bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:sOv8ZVOvC1kCzgYU_KxTksNhTFlmwnq4aVRYEiBrKM8XQwMF0TTpOA>
    <xmx:sOv8Za_8RUDSIcB2IxB2VTXQQEfqJ9ZbBDPHRnXSMYF5tS52d0Almg>
    <xmx:sOv8ZdVsDHNdovUtIrb7lWg5k_AEUeoidHXkPAAyFRV80tKiKMbbjg>
    <xmx:sOv8ZTdGC6M3fCpgsOrEd3qsXRYiXV-7f2fVvZj7EOfkySlDvLmEzQ>
    <xmx:sOv8ZebE9Ki9bEGx6u5dKXAb5WboJepP_6HoH_GqPeSVXC6x59enVg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:23:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cc139892 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:23:39 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:23:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] t7800: use single quotes for test bodies
Message-ID: <a4ca974397aadef251c2317efa88fd9c03e8f195.1711074118.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
 <cover.1711074118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D5bXAhalKHFstmuw"
Content-Disposition: inline
In-Reply-To: <cover.1711074118.git.ps@pks.im>


--D5bXAhalKHFstmuw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In eb84c8b6ce (git-difftool--helper: honor `--trust-exit-code` with
`--dir-diff`, 2024-02-20) we have started to loop around some of the
tests in t7800 so that they are reexecuted with slightly different
arguments. As part of that refactoring the quoting of test bodies was
changed from single quotes (') to double quotes (") so that the value of
the loop variable is accessible to the body.

As the test body is later on passed to eval this change was not required
though. Let's revert it back to use single quotes as usual in our tests.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7800-difftool.sh | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 80bf108f54..cc917b257e 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -93,42 +93,42 @@ test_expect_success 'difftool forwards arguments to dif=
f' '
=20
 for opt in '' '--dir-diff'
 do
-	test_expect_success "difftool ${opt:-without options} ignores exit code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code" '
 		test_config difftool.error.cmd false &&
 		git difftool ${opt} -y -t error branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code" '
 		test_config difftool.error.cmd false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t error branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code for built-ins" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code for built-ins" '
 		test_config difftool.vimdiff.path false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t vimdiff branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D true" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D true" '
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		test_must_fail git difftool ${opt} -y -t error branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D false" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D false" '
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode false &&
 		git difftool ${opt} -y -t error branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} ignores exit code w=
ith --no-trust-exit-code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code w=
ith --no-trust-exit-code" '
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		git difftool ${opt} -y --no-trust-exit-code -t error branch
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} stops on error with=
 --trust-exit-code" "
-		test_when_finished 'rm -f for-diff .git/fail-right-file' &&
-		test_when_finished 'git reset -- for-diff' &&
+	test_expect_success "difftool ${opt:-without options} stops on error with=
 --trust-exit-code" '
+		test_when_finished "rm -f for-diff .git/fail-right-file" &&
+		test_when_finished "git reset -- for-diff" &&
 		write_script .git/fail-right-file <<-\EOF &&
 		echo failed
 		exit 1
@@ -138,19 +138,19 @@ do
 		test_must_fail git difftool ${opt} -y --trust-exit-code \
 			--extcmd .git/fail-right-file branch >actual &&
 		test_line_count =3D 1 actual
-	"
+	'
=20
-	test_expect_success "difftool ${opt:-without options} honors exit status =
if command not found" "
+	test_expect_success "difftool ${opt:-without options} honors exit status =
if command not found" '
 		test_config difftool.nonexistent.cmd i-dont-exist &&
 		test_config difftool.trustExitCode false &&
-		if test "${opt}" =3D '--dir-diff'
+		if test "${opt}" =3D --dir-diff
 		then
 			expected_code=3D127
 		else
 			expected_code=3D128
 		fi &&
-		test_expect_code \${expected_code} git difftool ${opt} -y -t nonexistent=
 branch
-	"
+		test_expect_code ${expected_code} git difftool ${opt} -y -t nonexistent =
branch
+	'
 done
=20
 test_expect_success 'difftool honors --gui' '
--=20
2.44.0


--D5bXAhalKHFstmuw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8660ACgkQVbJhu7ck
PpSjdg/+P2mo2UalE0xRHaKJHOI0lDcBWisfhAmkhNPEk0FLqSyv32dHokMWWT2N
SkPHgs03GEPlKbIQHqy1uz2VZ3iv85ca2kY51yrpWOm9z05i2GkIsiOkbnxFkvPW
jyVsih48x6nPOELEIwZS3OQSIgM7RZSOSGYfkcL59umkJCVrnR4CLiaMF9eUnlpJ
OScFTQdtHOVNp4wzA4gr6VnPuo638ax2OQ/Eb47y4mNwBXcYNz+NeR/Xety5SQPL
iHqGvL3Ze/2FIRvgFXDVWFeIk7F5io/E28jCgE/FiBweJL9t9OvNjf5IkmGEyD4Z
eglRb7IBAV6G9vU+HtdBrK+uAuEtpsVdqY23MuHKNH/sPZwu+RD3hebX5FmWOPAt
wJ/DctGz4iqEyY7RltkmejJj+c+p3lp94pEUP1Ypak1UjLAeCr6xuG3Dgs2Pg2C8
LEdxFvgDTkM0j4BcNwnjI9BqIHFmK96dIfDWBJwo9jRGBSlQ/bp5QjsxjkXKMPI1
zAIveOngmbZzKu5HSu1Qx8tW80O6UPHT/MxGb8vPLkuURHwR3dYHbHQQra350JSw
BWHN7ExMpqjArkq1fyERPEvKMU4cuLb1lz6XPBjrwiEkUz21V9sKauB608aPweCz
gS9ZdTMqeaPYfDy3QFpXCLCcj2AQaWhABydTErdDB8g9MkruFHE=
=FgMX
-----END PGP SIGNATURE-----

--D5bXAhalKHFstmuw--
