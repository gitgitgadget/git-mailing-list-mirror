Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D16DEDE
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179409; cv=none; b=nNJi1obuWnbGmjsb31CbmLL/Ggl26AhcdF/iB8W2VHlZh0WUiZo8Ed4X4kvLARTDvyzYjPFfFV+1Ht+A4koqvTC9KsIsCvfrTkUMiDCD54+uG4HE/ZKeLQGNZQ0yEni/dujs166xFS1/BZd96278K6KxvDU9NO5Gevf62QcDRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179409; c=relaxed/simple;
	bh=5zGctpDrL1iI4VjGKVQmkbZP4uiCd4O9sDeT1iTCHjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbUTUQ0u4BJuwBUtAshebWQJpFdk3lnbos8qoFa2reVQPQpfvc30MTv2HiEohcw0zxZZKz91yt3PU5iJ49q1brm4LCSOew5B6oU4RZj12ZpPbGy5PW4IWmgmIlh7aaQ6oUfxPLqCvG8DAK4CsrcoDOFEks7BHqGUSXvIGc/+040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fDOsyC5I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YAxZ98hV; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fDOsyC5I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YAxZ98hV"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id E73181380153;
	Wed, 12 Jun 2024 04:03:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 04:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718179406; x=1718265806; bh=xbhjltAIUf
	HnDJig1OhBBkMn/eJoo/s90NMTvY6fyBA=; b=fDOsyC5Ida0Ss/1NyZLIn/Q81k
	vt4oizo+s/SdBhzrN4VHGVvec0btqKq00yz/9y3fCku8nCrUp9VbdKm+qfPzp7ky
	ltKhCXN/Yq32D/f80ZBzuizOdGNbaR99LLF6bXoFrs1UfnQS1R1cJedVzMOFw7s8
	sUijk1GVsoUwOzWFDczaKJAEI1ttU1iRcQgAqSrl2Zxo/scZ1XsT8KACabpqj94s
	o1zDh9+nXHM+V4AW7GMi0A2S6VENMMpbufo5pSAum6SAf+KKN0SLzYnOOovGBxj3
	bKzhAmZQKdBinj28QDk09J2iai8WKW6QUzQ/wL141uF5JmqIOQBVYO3m/Nvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718179406; x=1718265806; bh=xbhjltAIUfHnDJig1OhBBkMn/eJo
	o/s90NMTvY6fyBA=; b=YAxZ98hVrFhlcrWkO+gP3cYySpnVbEvl4z0VFdXcc603
	6PmOqJPCiiy9QdCCQwJF2Fanv8jVLGLCU7I5WiM1QXe2KLzgXNH3FivJmu8N/inW
	VEMBDWGJkKOrAJRwuCAg7AuxRg3cznos89CeZmYJApQ5n1FKJjAZGGzRwyomeCHh
	Dnz46JnfiWDflFAaBRbpZUQepaJxjL11+DlqL2wI+Jf8P1jTO5Walym8s+Y8BEWQ
	1e14Yi3a13LO+Lnl8VndrDishsIBTIRYpimIbjEkuXL4v4gDo4glayp5vSf3HGOA
	opuWWuyd5PRZgKMK3HEQd+346EigenfAWZPK520VLA==
X-ME-Sender: <xms:TlZpZoYpYf367cPknWmfWGlOaZWEvVDXXKPNrrh5tu1ns1xxezwF7g>
    <xme:TlZpZjYuK_G4Ry_UHx5VchBbgulDn02DNpMtVaxwO0uYy809J5kfv9gzPG7KbDJ33
    sX1c7fg6-lXcFGQvQ>
X-ME-Received: <xmr:TlZpZi-JD-BEXGZN5w4h8saas0Jwo5Oj4Jv7wQ8qmtEm-spx95yYpdRkrAPE3II6BjL8tL3SJYlcOORWX61xlEpimK6Xph7g0D0offJS8VIxgDIijSY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TlZpZioPFdoYl8RjLZZA4r_X9rQ4j403MZyW1tZZ2ehoBpR3N2D9-A>
    <xmx:TlZpZjr1kmn59_MnutxzdXID5XVJ6ubrwKjAUyeHPAD4nwuo__UJng>
    <xmx:TlZpZgQiQ9pFfaBCg8YtTr_YPR5kXUFP4d8oaUVVvY-e6h-9n6pGOg>
    <xmx:TlZpZjqlcoXX2IkRzPHET2XQO7J_azk_OdbfgKNGLi0oE1c0S6BW3Q>
    <xmx:TlZpZiVEBCEKEawGizQEZ95AckSDCcdPUTmMgCUve0AKyeDkBtPY08rQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 04:03:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8a4a2fd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 08:03:14 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:03:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/3] config: fix segfault when parsing "core.abbrev"
 without repo
Message-ID: <b48c50dd92769c7acc5c561f746a7d64dd4d2263.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <cover.1718178996.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yFcfiHMxN++urF6m"
Content-Disposition: inline
In-Reply-To: <cover.1718178996.git.ps@pks.im>


--yFcfiHMxN++urF6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "core.abbrev" config allows the user to specify the minimum length
when abbreviating object hashes. Next to the values "auto" and "no",
this config also accepts a concrete length that needs to be bigger or
equal to the minimum length and smaller or equal to the hash algorithm's
hex length. While the former condition is trivial, the latter depends on
the object format used by the current repository. It is thus a variable
upper boundary that may either be 40 (SHA-1) or 64 (SHA-256).

This has two major downsides. First, the user that specifies this config
must be aware of the object hashes that its repository use. If they want
to configure the value globally, then they cannot pick any value in the
range `[41, 64]` if they have any repository that uses SHA-1. If they
did, Git would error out when parsing the config.

Second, and more importantly, parsing "core.abbrev" crashes when outside
of a Git repository because we dereference `the_hash_algo` to figure out
its hex length. Starting with c8aed5e8da (repository: stop setting SHA1
as the default object hash, 2024-05-07) though, we stopped initializing
`the_hash_algo` outside of Git repositories.

Fix both of these issues by not making it an error anymore when the
given length exceeds the hash length. Instead, leave the abbreviated
length intact. `repo_find_unique_abbrev_r()` handles this just fine
except for a performance penalty which we will fix in a subsequent
commit.

Reported-by: Kyle Lippincott <spectral@google.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c         |  4 ++--
 t/t4202-log.sh   | 12 ++++++++++++
 t/t5601-clone.sh |  7 +++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/config.c b/config.c
index abce05b774..0416b0f2b6 100644
--- a/config.c
+++ b/config.c
@@ -1460,10 +1460,10 @@ static int git_default_core_config(const char *var,=
 const char *value,
 		if (!strcasecmp(value, "auto"))
 			default_abbrev =3D -1;
 		else if (!git_parse_maybe_bool_text(value))
-			default_abbrev =3D the_hash_algo->hexsz;
+			default_abbrev =3D GIT_MAX_HEXSZ;
 		else {
 			int abbrev =3D git_config_int(var, value, ctx->kvi);
-			if (abbrev < minimum_abbrev || abbrev > the_hash_algo->hexsz)
+			if (abbrev < minimum_abbrev)
 				return error(_("abbrev length out of range: %d"), abbrev);
 			default_abbrev =3D abbrev;
 		}
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 86c695eb0a..e97826458c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1237,6 +1237,18 @@ test_expect_success 'log.abbrevCommit configuration'=
 '
 	test_cmp expect.whatchanged.full actual
 '
=20
+test_expect_success '--abbrev-commit with core.abbrev=3Dfalse' '
+	git log --no-abbrev >expect &&
+	git -c core.abbrev=3Dfalse log --abbrev-commit >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--abbrev-commit with core.abbrev=3D9000' '
+	git log --no-abbrev >expect &&
+	git -c core.abbrev=3D9000 log --abbrev-commit >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'show added path under "--follow -M"' '
 	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
 	test_create_repo regression &&
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index cc0b953f14..5d7ea147f1 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -46,6 +46,13 @@ test_expect_success 'output from clone' '
 	test $(grep Clon output | wc -l) =3D 1
 '
=20
+test_expect_success 'output from clone with core.abbrev does not crash' '
+	rm -fr dst &&
+	echo "Cloning into ${SQ}dst${SQ}..." >expect &&
+	git -c core.abbrev=3D12 clone -n "file://$(pwd)/src" dst >actual 2>&1 &&
+	test_cmp expect actual
+'
+
 test_expect_success 'clone does not keep pack' '
=20
 	rm -fr dst &&
--=20
2.45.2.457.g8d94cfb545.dirty


--yFcfiHMxN++urF6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpVkoACgkQVbJhu7ck
PpTn+Q/5AWO3s0rSwkMuiG/XuNfJGxdA7YadVR1bGpS9NOoLT12y5+bhUxamwAhx
m/Rq2qEdOkIptyCXOaP7FXRV/P7yDQWwmZW3C0SwHi41yc9AonSZ6Bj1FdtwN3tH
bWboe9J6rIoxEm35nyR01nkp8RvaUnZ49buSsmubgQrbuxJWyvBhwzYnBECkzEmF
7Fwx1PeejEMKesNloB1DFZqATsa0pbkHyPJOjJHb8dAVvV2OLjhmhOOEqyyVT6RD
uStgRBx4ky9PhsemhiBhWaHBQCytV/x5dPRYsMRaKqfhmiC2pL6+VbEaBBNzoIPr
lC/Mfc6RMreXxsYwmNbA08kF62mTgHKt0KQ/E0ofE4NaQj9Vd8vMUe9Q+CBIs5qM
XLuwk0p3EuGHdpMUYUw902dog/iJsqCAMl1T/c78iAPzhlcLfaG5w1QEF5RyZcw/
F4oqa/Wjzi/TzHSlmm/NeOK9j+pcRg4ady++nqsN82TnvH0FHMZ2JgxZYAAeqEz8
gHOC1UbGHsbmHwZUMl8vznZQ2ZsTVmWvBvn1GQgW2jz6cfodEGF09Qnv8e3ZTndX
961fqDfuyr8h/jHesT1gRmoEDZmqSAOcTEwc8VMgiJm/ZcR5yU95DSWyfDsFvees
mcJS7DkFCJRqfr3YOIe4aUp0w2Jhv+0LSTydwGLYQkiO6bvPDEc=
=d7MT
-----END PGP SIGNATURE-----

--yFcfiHMxN++urF6m--
