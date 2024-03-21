Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C784FA9
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028855; cv=none; b=QsrV4wkftkU/DUU4OeAOqLJovj6CiK7luYPZsIoESynbI1eDXqnU0p0LZfbB1gp+yG/B+7YGM8UjhvfgSLvydZKK/oKu8NmLjwINn/IwUqfHhSdmIeiYHAg+7i3YPQZDF1w3Q2uEwWwEJTktWqVNp9ENorOBv+9bO8mGt/ttp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028855; c=relaxed/simple;
	bh=M2Mzzlup+KQZK+nXQuQb+o9yVbXxPuHk9fAUXmgghvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mwjh45zB1/+nmQn5GxOneXf36hD0ynvx0yPK2c0yidyTGn2nloqiAVpVQD0gy/D8Ij5jzCSRTJbHy9fz+q7JMKJ0a/zk9Q4kyTaKTBe4GKekshSBwZ7gRIJi2nk6jKkU4OlLHG8B/19DMF6UxOWPOO5AA1g9P2psdNVpqTyPe10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=J2MboYHK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KbZuak7E; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="J2MboYHK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KbZuak7E"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id A90891C000C4;
	Thu, 21 Mar 2024 09:47:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Mar 2024 09:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711028852; x=1711115252; bh=//uFPDVylF
	Wkai6bSfEO6/e0iWyYJ9BsfqVrGhIzh88=; b=J2MboYHK2PPYF4k1eVXi0CvqOW
	7fW3IFvbnA0Tp3JCX0V6yNn4ya09hzLaUrppjisPb3485QUY5dbeaEZqZH7DXz7Z
	cjPrHdZWZOvWd287+H1eRHwhBVeGc2K8o6AEQZG5VxYs/GZ0RrUtoLoaRwKQXslp
	xUfT0QLoawOiRaChPjy9nML3z412pW29qZHWIQUZwyCpkapgqT9lml4xk5g6Voqc
	spwCj2lIeMF8j9aRz7SSZwl5YN95zdx0K5wYZ9KUsjxe0zZDEQhDqDfmMTYqPzis
	kjyc5k2P8sFqpJIwJ422NFEny2Y9X8xfWIChEoLey0kQA84cRuwZ2HF7ORqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711028852; x=1711115252; bh=//uFPDVylFWkai6bSfEO6/e0iWyY
	J9BsfqVrGhIzh88=; b=KbZuak7E3MJ4oFwGxFwSr+eRhcrImwXgt2CC3jZ/7og6
	biGRBgS02afSUmGHBPvSbhnIW6lB29/RxNO/3U18GxkdwP4a0yfpcQKE6VzHp4v0
	kV0PG4LoTQIuS+Jt30RkbBIBXH6XVW6ib/bTc9K33PKaAFN1m+mJG3xiKWEGMuYh
	RUUPgv+tJl09R/x3em6FsuvYvc1aCFgNexg5H2CcFzEupYfU0NkrkFOI2jyLQddx
	O1CsnDST3c52x0C+zz4HjhOgqV5KCh6JAj9agwDVlsnWCXY11UeiEtUwsxD2DMtG
	JSEtASNtw2qWe1j4x/kosjJ6f55ugCc3zjjGs/V8Zg==
X-ME-Sender: <xms:czr8ZcghK-CWvE6NUrJDzKXY3MA9a9Ivze4kMJfHEOXu0CMYAEGDaw>
    <xme:czr8ZVAuDQ8435SylO-PBOT-sOvVTIqexku1Fr-OSFg8o_E8NlkZzxgWYvmlOb-nZ
    KQ-_nyOLD7DysQmsQ>
X-ME-Received: <xmr:czr8ZUHwWElKZ_k6yzFbQGOu980RHLe5R9fFLFalGHQ-HSfg9hRY4mtOQx7sUXBY4DnzDy7d7r5ErEAkzkqw1OGZ6pFPWwbx9GSU9bXmShWiKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:czr8ZdQdiEGdKSrpngeGdnVGAstkj9O6x_RHNK4-zLmVNufjH27lkg>
    <xmx:czr8ZZzvdMV7Rdx2zjChRd2r3f42i0FGWLNXoJee-8jfXtOVaWxLsg>
    <xmx:czr8Zb7Jxs4hhDLHEOgcmS4YB9YTEHChAZZdfQdhVUSWe-QhGodXHw>
    <xmx:czr8ZWwrqtWzQLSgH5y0ZU4Kv6ATncrExQkQ0wUPjFHxZCYzkJFnUQ>
    <xmx:dDr8Zbs7devUAf3RYVFlk0nGsF5O3O3OQIAXySB9BrXmaNRVn-8Xa5T8ALw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:47:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6109a2ae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:47:27 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:47:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/3] t7800: use single quotes for test bodies
Message-ID: <a4ca974397aadef251c2317efa88fd9c03e8f195.1711028473.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7YVoNtAEBaiSyDCv"
Content-Disposition: inline
In-Reply-To: <cover.1711028473.git.ps@pks.im>


--7YVoNtAEBaiSyDCv
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


--7YVoNtAEBaiSyDCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OnAACgkQVbJhu7ck
PpR00w//SiA9rGiZrOw04CJOUBBbQwqPHK/2GPs+PCilUTK6nbl2NHAUbRpFRGjP
FRW1e4eC6HFCgnqvX7QPHTTHJtVjU3ODlKopPzoDjm2l08gjZaQu/9C5AgQJc+md
s0UpWdGTXFi+r8hkox7T2S6DYR/Yn2Xi2ozWhlqltRHe0EeEKXB+TdvxRGaSZUyx
B6JcJqtoHdRQTkS6Jo2kEd5Ve81ddnOz2HM0mF3M1dGaAc3PPgsG4581Rq18oiy7
nDwNq9ZkP1kj/dVgTaUfnxtUEEstAs0sRDW73BjcaNoLBOjpyXvs408gdAuIED6H
ctZIhkiWrmMORxyyefxEAk2RWvVmYyGbZip0ag8zwOtcNaQ/52+P5+ZGG/uXfcsc
GySVtLTODJXE7OI1/zgpIJZe/GmvCOq11AZiKBuq0UKQWLf5Fl6NXS8/QrmXwQqo
QqV36Nbu+p1Su8ExqmC0yifQplljkQsg4EnoBjSlTpQwFHZfGE6MDKxgcN8Y/Emk
7KXzEb5IImmc9hIS6MLhdfd9vG9boHCKZU+55+F5DG7L44er1OvkvBnwEpW1HEHT
5TD2crqHQZQms6vuUUXMRyWrwPqhdJSccpi0pbSqGI2jpnN6fenB3snKPnHipfOX
UJCr9cqGgYPhb7PUbK2n3CY7RxdyKa9EFvVW0QTOiWazQHSnFmc=
=Jq0B
-----END PGP SIGNATURE-----

--7YVoNtAEBaiSyDCv--
