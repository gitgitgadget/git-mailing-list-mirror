Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FF74C63
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179417; cv=none; b=MHh9tURMA7PYXVt0jhKNj1sXz5jrVVt8g1MSu++VhSid3SFN/9ToMHXgBmT9EBLYFVB9GoVd99R9NTx9ONbseWiTV7/xYiZWx43iPNSNZkikKZBzppircIM7b2heB4DqkhdBOge1uNpbaWTbpcEc6vEK+tDRJx7+1dfaBfK0KsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179417; c=relaxed/simple;
	bh=s040zfoMXTy6c4VuGPjHQsbxYV8k0DuUEjrNYuz4xdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtNqTJkAKMq4svzxf6aISbk/OQ6Q1ox+Q0+WH1R2MMFUh9JUU5de0lFr0rGp2oCQMJyC0pEIcJGo4HsZXbit/sBIBAtSeT3e0bWTFCHFkOiHNktES/roISnxfHk7unMyzFefS/2fRAPONkSraX9yYLvyyme8RJj0LmK39tCYaEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GXSo93mc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HWv0vHCO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GXSo93mc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HWv0vHCO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2BA5013800FC;
	Wed, 12 Jun 2024 04:03:35 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 12 Jun 2024 04:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718179415; x=1718265815; bh=DjoEtAMor0
	ldAWdXpi0x++sFQCNnX1sMW2hAUhcUpuw=; b=GXSo93mcTKn/C+d571cwzr1s5D
	dZeN8mw+TLu73GuLXMjE32I4aQbAZYzaSBO7bUMon3HqHTB9xzp4wC2Bau4+w50Y
	Yf9whIM1n08stD23t8JNJ9ThwG3N3PvDQj4P+sewuwzRQWGQLBkxCHUo4vLlwri3
	+yjTKEWg5ChzDMdcD3jTuG73P+wZuOAthka1qHVPHC+8o+vjnKQyUxd0PEYx0UMK
	DDLp3Hj7Ga8Bic5t0pkSZq/Tqw2OCJyPSXvT40TchBrA5Toow8xBt9Pc1s66ZeEr
	fVq6X/Ise56a9+lwHvZwAAlE64KDceGB52nee4VdQm+NFumq6usoFw7yR7SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718179415; x=1718265815; bh=DjoEtAMor0ldAWdXpi0x++sFQCNn
	X1sMW2hAUhcUpuw=; b=HWv0vHCOpGvAz8PkcUllgZbYbbRg52W8MvWSNd8YF593
	8/vepd8x715AUj5wVDYBRtK5bKtk3KPFUC7UCEJLBEjW+DJJ50v38YLeIbnk2pBX
	53SvJ+/u7tR0GSoY5rOaMm5knSi6CgR9NHbTuchpiym63YQTyKmoqotky50f6NEN
	FDdsD5aLD+7sp5XDK02R5uLT5MbGQQm0yacA8vVg46Hl0B0HAVrJGkrEp4PeMhuU
	qRH7WBKn3AJmy+iBh0OJEh727BrNQsdOOYTtyTkl4LzhhwHwOHIyqSIHDH5tBrS3
	FIAqaxfPt61F6NlS6xbV7EDPmZPZBWGDsdHFpSkAJw==
X-ME-Sender: <xms:VlZpZgrcr6BcwzorIl7_9nbdfdmZxTYeMKYd54_rwNR8njRtuvKWmw>
    <xme:VlZpZmrIvzedEFAAms-7nfKEvnEm4tmbYEmn55kJl4NaLnHJQCgdGQSnIOS5iPBqy
    -13hvmnR5ls6QjLeA>
X-ME-Received: <xmr:VlZpZlPpz6-KxXemcMen-Ok5KvI85c0sEg8XHOJtZqSb7u9HR4U0E1Jb01t_a6-qDo0oFlVtoISnZFZp04emk65PvtlZBStxN4dT5T197DEK_SeZJUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:VlZpZn5Wjv48GHjSzNOcw1BRq7vzecZp3WCOaN8omi2jVv1Pl_OzlQ>
    <xmx:VlZpZv7Lu4DNx9LjFGb6A0m1mehYnGse9wEwJAuAEWi5sPO6Vh1hvA>
    <xmx:VlZpZnirSlwZ1ZYYpDqcrbLX0XiEflICQm9jh7nKGJsfPm6JCB5_aw>
    <xmx:VlZpZp5jFvdMb7ev4TUN35E2j_bBiSR3PNWLG3uUIWeP6KGkMpVw9g>
    <xmx:V1ZpZhkIIHwYo39zGzFo2evPaWmzg3XsJjao8-BD045otmmcHCTG0TYr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 04:03:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 441d1ec9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 08:03:23 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:03:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] parse-options-cb: stop clamping "--abbrev=" to hash
 length
Message-ID: <92860256a61f14b60d6172d396f3ba5fd7be557c.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <cover.1718178996.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j+yoq447CiK9sX+c"
Content-Disposition: inline
In-Reply-To: <cover.1718178996.git.ps@pks.im>


--j+yoq447CiK9sX+c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `OPT__ABBREV()` option allows the user to specify the length that
object hashes shall be abbreviated to. This length needs to be in the
range of `(MIN_ABBREV, the_hash_algo->hexsz)`, which is why we clamp the
value as required. While this makes sense in the case of `MIN_ABBREV`,
it is unnecessary for the upper boundary as the value is eventually
passed down to `repo_find_unnique_abbrev_r()`, which handles values
larger than the current hash length just fine.

In the preceding commit, we have changed parsing of the "core.abbrev"
config to stop clamping to the upper boundary. Let's do the same here so
that the code becomes simpler, we are consistent with how we treat the
"core.abbrev" config and so that we stop depending on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 parse-options-cb.c |  2 --
 t/t4202-log.sh     | 12 ++++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index d99d688d3c..b2aa62a9dc 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -30,8 +30,6 @@ int parse_opt_abbrev_cb(const struct option *opt, const c=
har *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v =3D MINIMUM_ABBREV;
-		else if (startup_info->have_repository && v > the_hash_algo->hexsz)
-			v =3D the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) =3D v;
 	return 0;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index e97826458c..51f7beb59f 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1243,12 +1243,24 @@ test_expect_success '--abbrev-commit with core.abbr=
ev=3Dfalse' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--abbrev-commit with --no-abbrev' '
+	git log --no-abbrev >expect &&
+	git log --abbrev-commit --no-abbrev >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--abbrev-commit with core.abbrev=3D9000' '
 	git log --no-abbrev >expect &&
 	git -c core.abbrev=3D9000 log --abbrev-commit >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success '--abbrev-commit with --abbrev=3D9000' '
+	git log --no-abbrev >expect &&
+	git log --abbrev-commit --abbrev=3D9000 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'show added path under "--follow -M"' '
 	# This tests for a regression introduced in v1.7.2-rc0~103^2~2
 	test_create_repo regression &&
--=20
2.45.2.457.g8d94cfb545.dirty


--j+yoq447CiK9sX+c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpVlIACgkQVbJhu7ck
PpRjVw//RaynvdlFTXqJrBCFCunCmTwRhVWr5wyZ9HGIp9w43XK2LRYZp7XmwpPJ
OXSs0wTyHRmn9/VJwvTcXwbe4a2pdCUjGzvFTdctXAHa4OFZC/QG/VLCxZe1HHJU
pxGgtYsSN2hbLoyI2vDRjASyaedkD4lUo0M0272oVIUGg9JwBRNDqjWqmKCnYp2g
JDHFZKr5E+Rs9vZxDwevbHHx0ssCwu9DqtcbidxzLmGAyXd1KgDU+Z3nLfnDj3Tn
XHwGe426/p8T6aYDl3AvYrJwfftDWWmVk0DF/J195yEr4v6LRfbDsIohdMBxqQKI
AOAdesfIvywLcCoYKK4BIfUgKsA2INGA8orztUXzkvyzPvtLK4PY9ipPUaHQ8WbS
yKdWKOa0zvo7nmg0aDReXD29hvkHUxRON8BjSQjSW7qBuiTYIYKHEec3wCMjFRtC
n/bsMw7NPtkBiMlmKefSVxMQBuLW3sCKdSWfBfIXalBTgWDQRiZEpNp7qXYVPE1P
Q8DBeJjzTf6WA9Loq+KgFLUlmY0X6ImFddSbrywhqoQNzgo1QYcKtKrt5mi4WxQs
QrfSrHBGXMeMozjQ+XZ6pm0jucSwuOTrtg+o2XeozvSHPQmRZ7Onwqr6X8bvJiGn
FQCUMWjVlbSi3vV7LsQf8FSHNzpMAxu6gAovr7N+OrwYZB6cFXs=
=a16B
-----END PGP SIGNATURE-----

--j+yoq447CiK9sX+c--
