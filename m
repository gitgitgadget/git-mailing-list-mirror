Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3041C33
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 02:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711074221; cv=none; b=LyyivY/WAgp1ncAPQ9cQa8qu+bckC1NWNd5Wb8ORA11kI17l9ssKe3oJZW8gs3oaElPL26N1IfTc52/+Bk4CpJa1teWFiBKVftk7gQ+OK1LNvvBPmfIvbHTNyrj7ZPKym1mICWG1ARa3x9oVtRlFPwgtOwbJTRy1wZtSMmyWewc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711074221; c=relaxed/simple;
	bh=x++DEygiYf8Gmln7/QfQlxUkvpbevD6E19CGXdMK0ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN0vWiitsB/Yj/ddqd7vNqzo2beNb51Pnxb5xPlM7EE5NDTYLitYgm65b9TjEmymtw1peJbsf0qrebVt7HjSLtGjnjgjJ94QymLz1yWnb/nNr4nUKtLhxvW3uQXLvnoITE4iwv4mxR4Eeeb+Wgo+Php8d3jGU9ofQDURzMqzqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fqGcow+o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msp/rUQH; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fqGcow+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msp/rUQH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 1E5DC1380155;
	Thu, 21 Mar 2024 22:23:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Mar 2024 22:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711074219; x=1711160619; bh=xxLw+QKRRr
	7a4NP+e8yUCpraEkDr/PA3zyBw3PVWb2U=; b=fqGcow+otQEQueEyg1+PSx7xaI
	GwF3XuT7FD1co5mgra7vKBQIewtBeZeOrBDfpM0kh8cyp+T7p/ZQzkP0OXRYDbGZ
	l/8K/EUmfhu31CpX9DHuf/bhapMkSMhoW/6554WAxkhJpoRii0nAuCx0dYnHxaP+
	tIIurbEoouU4bVUvHWeeC+oC5kvAEtSEsDqYwdicsvxr6w1Z0jSjj3my+A6iceyS
	S1hrubZghibIH93+IxdL4GnS+UtmXuXORaqBiKhhTeHfGyo1fcfb04Dqtb6VZc1l
	V5UF81rE1uNwpus7kjdrPgONEXGsHMRgGBLqxtW/vbL8eAggVg+9c/rynzxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711074219; x=1711160619; bh=xxLw+QKRRr7a4NP+e8yUCpraEkDr
	/PA3zyBw3PVWb2U=; b=msp/rUQHxB7qFi09t6SJnrUB6/c0/JmqNEM3+XY5y9BJ
	TgxpqmzH4tn5R5/gsjLIlB/QoIE6csmfV2CT+JqnLBnUkVo9/U7iOX82wXembeT2
	CYu47T9YfEAY1TRKUDPbM6qyfvuJ2UJmc7Of5DRxkPipFvMxZWAukp5L6QdnEaic
	yZYARNME6n1RORsTaRmmWkxLjaUy/vVfxW3/i0uw3z2cqxE66jIzb3IXVVGBXgCp
	t1zujYQBau4MB+J+BShSXTCsWtdWBhNcbwgWE0pZaWrukGhjGMoE/yq1vDxdL2fj
	AQwhdkEaB4Q/PTc3WCt0lvBhu7Et9jJe10lv2MNTLw==
X-ME-Sender: <xms:quv8ZWOlx1lvrDYoOq-XQaDWDDTdPnNVybY4igP_jh5QlMJHOiMEOQ>
    <xme:quv8ZU950jFgwc8V4c2r9Aafxuoh8G-2otfzXi8sqi7FTMYP30faqNEtNXGDjOUsF
    iTi58V9i0e_Rja-ig>
X-ME-Received: <xmr:quv8ZdT4zp3EIJuvmjIzcW8UM95wrjRA5zAcmsrNTmShxADPd13u83Q_0gGq2u3nAZ-GRkRkmIIRgQONpKHA8Spwh4naaGZtERTT05F1NBaIIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:quv8ZWvWAaUkldjGzLM3fIokcmVC-qE5Tlis-WLbJE37tQGREMVAhw>
    <xmx:quv8ZecxVJm8AmfXNyL4xNPcrZicdE39w_2flmsV0PJjGrPHhI-aNQ>
    <xmx:quv8Za1licF_3y2MlIUBLMVbXIXhDHhqOjgsw0utjv2IxvlBvODN5A>
    <xmx:quv8ZS9K8wwk_iEPBSbEsBeC-C-7qxYo_EBJbxqcn0-xm3wmweLXHg>
    <xmx:q-v8Zd5PLAVSS5FLHb1ox2Zzb4CMymDlYOWhlSht1mZLHVuPpOHiww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 22:23:38 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49cb79d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 02:23:33 +0000 (UTC)
Date: Fri, 22 Mar 2024 03:23:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] t7800: improve test descriptions with empty arguments
Message-ID: <fd37c2931904bc64fb6ea14331aea60278f495eb.1711074118.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
 <cover.1711074118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1dfiYYgQPN+e1VfP"
Content-Disposition: inline
In-Reply-To: <cover.1711074118.git.ps@pks.im>


--1dfiYYgQPN+e1VfP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t7800 are executed repeatedly in a loop with
different arguments. To distinguish these tests, the value of that
variable is rendered into the test title. But given that one of the
values is the empty string, it results in a somewhat awkward test name:

    difftool  ignores exit code

Improve this by printing "without options" in case the value is empty.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7800-difftool.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 96ae5d5880..80bf108f54 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -93,40 +93,40 @@ test_expect_success 'difftool forwards arguments to dif=
f' '
=20
 for opt in '' '--dir-diff'
 do
-	test_expect_success "difftool ${opt} ignores exit code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code" "
 		test_config difftool.error.cmd false &&
 		git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code" "
 		test_config difftool.error.cmd false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} forwards exit code with --trust-exit=
-code for built-ins" "
+	test_expect_success "difftool ${opt:-without options} forwards exit code =
with --trust-exit-code for built-ins" "
 		test_config difftool.vimdiff.path false &&
 		test_must_fail git difftool ${opt} -y --trust-exit-code -t vimdiff branch
 	"
=20
-	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D tr=
ue" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D true" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		test_must_fail git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} honors difftool.trustExitCode =3D fa=
lse" "
+	test_expect_success "difftool ${opt:-without options} honors difftool.tru=
stExitCode =3D false" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode false &&
 		git difftool ${opt} -y -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} ignores exit code with --no-trust-ex=
it-code" "
+	test_expect_success "difftool ${opt:-without options} ignores exit code w=
ith --no-trust-exit-code" "
 		test_config difftool.error.cmd false &&
 		test_config difftool.trustExitCode true &&
 		git difftool ${opt} -y --no-trust-exit-code -t error branch
 	"
=20
-	test_expect_success "difftool ${opt} stops on error with --trust-exit-cod=
e" "
+	test_expect_success "difftool ${opt:-without options} stops on error with=
 --trust-exit-code" "
 		test_when_finished 'rm -f for-diff .git/fail-right-file' &&
 		test_when_finished 'git reset -- for-diff' &&
 		write_script .git/fail-right-file <<-\EOF &&
@@ -140,7 +140,7 @@ do
 		test_line_count =3D 1 actual
 	"
=20
-	test_expect_success "difftool ${opt} honors exit status if command not fo=
und" "
+	test_expect_success "difftool ${opt:-without options} honors exit status =
if command not found" "
 		test_config difftool.nonexistent.cmd i-dont-exist &&
 		test_config difftool.trustExitCode false &&
 		if test "${opt}" =3D '--dir-diff'
--=20
2.44.0


--1dfiYYgQPN+e1VfP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX866cACgkQVbJhu7ck
PpTM3xAAoYd47gHAD2S/41CIh6lB9UD+4KFbxDIAqxXuoWO6G2nA54Y8zh1Y5gmz
jb/rRzpuMvINWFY987fLBDlKcd+zpDWhdgD947ffDKuuQPdfw8t+K6CpRhb47fKE
49wFPXydwYUXMrK38IJcLC5ya7ET+8zvmtC/JgytKGlJt8A0hW8LP6ywBVK/7VfU
55DfJU/UlLsDZa5UFlKlviRRY8kdrzkhiPsK3bq900zrPhxH17T3hIuXw+LeWdVA
oDhFJ76vh00InAb0DMm7OiF1k5xPfgLTYDJHOuBACyptHJWuAV/WD4/fRfh31Rqf
HxMlyNXugsG+cd42eUPDpC9Ty9qdn58MDTcrRzi6XV/oKwJ4EDe8r4QSKz0ncsen
znYNyRcONp6Bo9qKkvUCdgnMT6gt1egGJw+LaeDUkjbR7o0y4yiy59z1rElhRwo+
ipyk+2YNdGGyhMRGFiT3uDPbqLu1sJeDwaq5sGn5OfyaxNvx4JElCiI64yXlYqyZ
9ci3RA3D94f56kr/7DZNwh0f0vys6qZ+nz1CKtI+IaXPNrVF9Flu+Fi6jhM0fuLY
nfESskPbp8vBRF32cFvg9saW6fRfNeNvq8nJ4EN7VgmcflTtIovapsDh7foJrkm3
5PHBgROT09rDi6idllaCPELXVtL93NGZzJ+DmG6IC+zTWgYvotM=
=CUZp
-----END PGP SIGNATURE-----

--1dfiYYgQPN+e1VfP--
