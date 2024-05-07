Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC9D6A8C1
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057603; cv=none; b=IJZExB1Z2StoQDL3yr1T4Lr+twFFQnTaVCXYHMeA0/iVVJEkFJdMZP/45stq/OSuSzOnajtv8LWVAodog9uftq0qCchpsZWBlF3uMN+ySEMltvolBAhG8HVWmgYvyfcLQH8WNOmA6+MEqxJ0kzjemCkfMt+x21YsqecMpW4wzho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057603; c=relaxed/simple;
	bh=956tmkVUNeefWKEKcwlJ+A7TfxGB/XAsKrOR4yPki/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbXTm6jZYnKy3796PHXHAcH1jtm7+B5S7sisYnPCGshz0N/0xi3u4UdJDmmKawBxcTm8ZDWDUzOxWcq9Qt/C65O5nm2KonrCG5ZigdiN4buakJZofjnsIh0+TUZwXl7yBWZJaH6eecPGxLuSxCypDhXtIIzdLSBtRcgaXyukP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y1N6y6Cv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ePREl3iv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y1N6y6Cv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ePREl3iv"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 438DC1140156;
	Tue,  7 May 2024 00:53:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 07 May 2024 00:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057599; x=1715143999; bh=PT0SB9neb1
	VZnjfqJKi683mf08Bhxkth5m2j6tonsgw=; b=Y1N6y6CvFJPAvXYzbqnehkJsJv
	Ox25PXqmqcWRvsZ1+uiM7Fc8S06b6/G+erlFcMbnYxb/3edY3K4IE63hdHzjDsAX
	9AeGfctHo3fuqnBpOYzZLRn/0LAdpdFs25AU5nuJd9vUp42CI3oYxgg2kxZq6Rt7
	b/cK+ITYbxxlDuTzSm9kwuCQNcYfkqKW0NDe/mLkShhLoBF3ALbTiNKXFk5c73M9
	RcO2pHcPHGPxvoSAXKj5pgjUhF/vcXjHB8HGtFWX/4Suyy+e70HULmTyAwEcOXPE
	s0MiIhGoucOBhF4k3A0MvdDgTrQTwSQzYDno+jiKsWYaR0l8rVIF9tIqxhrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057599; x=1715143999; bh=PT0SB9neb1VZnjfqJKi683mf08Bh
	xkth5m2j6tonsgw=; b=ePREl3iv+czeV2lJQLIwXl3Y3JhbCxnI6kaYmtvuMXv3
	MckPzdMo8LZiCkfrtwS4klrJf9C0GKwcJS6HGr+MwPxArRCNsgtI7DHNjnhM14Bi
	sKFeJvQqFsts1dP78HWh6aojAsUm8MRY5mmTBN5+SMucwBtzwAtJwReVBqJtgwC5
	kXYIp38SvZfn0ATo6VBha1pCYRQfD319a4+VgNukFEoLXK67VNHxIF82+ykPM8rS
	A9ZQQqh7nyqulAmLAViQDejhNsYdbWXUq38rHQGLlfSfdV6hD0WoB+lxlWXyK5ia
	O/yB1cEWScIaQacNorXn7EdGVa4MRwHzDwkmSplHew==
X-ME-Sender: <xms:v7M5Zlx9MxxG5ynlKN2IaXycRGyiDBPhhhRQ-OD9IwD0SY0GT8o6Yg>
    <xme:v7M5ZlQkU-Xs2QOgEdFxpioXVLG3wopRfOfWLSEspoJCGOD6R5x414XJ-NFtpL_IH
    Vf6iz2N_S3bWyqcxA>
X-ME-Received: <xmr:v7M5ZvVH2qOsVHwqUb5kjKOORSlPiDbh1EYtc8yE25ZBEHAHuMNuCo5i6p6xF6L1QNj2I1Zo_CycqcKhCv-nOv7KgOWZIK6VrXja8FXkSo-kIKbt9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:v7M5ZngtVvEp0nJHTgO0Q2QBNthIKUYl3J5UNRZ6v9GPKjXmgaq7aA>
    <xmx:v7M5ZnDwbmXsMJ9YUi3aElpo2aBg-dgL43h8R_qKx0wB35bPunrNaw>
    <xmx:v7M5ZgKcZyRWA-YxJLhZZ9GFyq3g25-aDaXuNh2lAFYUc43_AzUFSg>
    <xmx:v7M5ZmDKvJYrLtafBv1CdHBA4BokZV_mt4SbH80_zx-wJBEGHbql-A>
    <xmx:v7M5Zi9F2eSA6zogaexPnEV-grtRsLpKt0v3EwY8kGcA2Rul-MF7AIdW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:18 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4d3a81e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:10 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 07/13] builtin/rev-parse: allow shortening to more than 40
 hex characters
Message-ID: <61160303108133f0225aae0f0776fa15c7ee07ec.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/aEHmYQuXNrwBxa5"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--/aEHmYQuXNrwBxa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `--short=3D` option for git-rev-parse(1) allows the user to specify
to how many characters object IDs should be shortened to. The option is
broken though for SHA256 repositories because we set the maximum allowed
hash size to `the_hash_algo->hexsz` before we have even set up the repo.
Consequently, `the_hash_algo` will always be SHA1 and thus we truncate
every hash after at most 40 characters.

Fix this by accessing `the_hash_algo` only after we have set up the
repo.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c  | 5 ++---
 t/t1500-rev-parse.sh | 6 ++++++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index af79538632..7d10ee33c4 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -686,9 +686,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 	unsigned int flags =3D 0;
 	const char *name =3D NULL;
 	struct object_context unused;
 	struct strbuf buf =3D STRBUF_INIT;
-	const int hexsz =3D the_hash_algo->hexsz;
 	int seen_end_of_options =3D 0;
 	enum format_type format =3D FORMAT_DEFAULT;
=20
 	if (argc > 1 && !strcmp("--parseopt", argv[1]))
@@ -862,10 +861,10 @@ int cmd_rev_parse(int argc, const char **argv, const =
char *prefix)
 					continue;
 				abbrev =3D strtoul(arg, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev =3D MINIMUM_ABBREV;
-				else if (hexsz <=3D abbrev)
-					abbrev =3D hexsz;
+				else if ((int)the_hash_algo->hexsz <=3D abbrev)
+					abbrev =3D the_hash_algo->hexsz;
 				continue;
 			}
 			if (!strcmp(arg, "--sq")) {
 				output_sq =3D 1;
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index a669e592f1..30c31918fd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -303,5 +303,11 @@ test_expect_success 'rev-parse --bisect includes bad, =
excludes good' '
 	git rev-parse --symbolic-full-name --bisect >actual &&
 	test_cmp expect actual
 '
=20
+test_expect_success '--short=3D truncates to the actual hash length' '
+	git rev-parse HEAD >expect &&
+	git rev-parse --short=3D100 HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.45.0


--/aEHmYQuXNrwBxa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s7oACgkQVbJhu7ck
PpRtYg//Rku1/l8BsPUU7lhPCSgqnG3kERJcFlqPyhkcKRPrhmIgHkpx5wfPgnPi
3ED4LjQ5VcB8CqX9aJIRxr5C7fqI11SOg/z+Hcnscg1EfNpaSvWXBqSNmnUd6ywM
ynI1O1CywC5wF6vm3/xZFchRMWzPSlKtfFFn37dCgImlPYldz2ydlNnvhApuBLWX
X9KIbvW/SYzmtN9e1BMMvNl9fxtUtbMkzxsMg6M7kT7q/PSPrzheyvoKL14+MNHh
6EstDFXQ+gIHR7L2Z1GW7ueHPpaWvpOgDRoer+rocSkQbznf6v5CLTpc7XIx90Pz
SFYPnPCbbCft0Jx/Bpi2TwHb+Wd8eeBv++Wqt6RLJKsmt3ILddep5ZDuAvoeSOP0
kExk/UlFAKBSMDeeI3B55z7JHJhZS71ABch3aZTr25JNxyd3azlNjqYGUhOJWNwH
X/l/uAegnbMgB9gONTSUrY+5gR1UbRDqaXwSz78GlK0onPm4t6o01om8mrOiKNH5
dpk9ix3S1nI0SboMkxhYq/4lK/RGX19saSjV5lrVqDNJMqcvvG9pSgjBSxTgPpyB
Nz43nTTHdfoCBn29G3DTEUgRrm4/mJGx/06sGLq9jsnIQ2eI12gpPhNpRRn2e3ll
jyOfnmWcUJhEevLXHP2mB6NHUkwrF7/VVt2Ku84d9Es+YynUv8w=
=kAaN
-----END PGP SIGNATURE-----

--/aEHmYQuXNrwBxa5--
