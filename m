Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0542D13AE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372488; cv=none; b=rFboi50sVr189EwY2/ofLuA1RadaepHMR68BkX9M/0a8NoLp+7yeywT6uquNyRjZGfM4NQouVDGw8oBsyhQMS8kapmaEiAgXz1RZTXMLocZfasEWtNh5xR0ZFk7MyZbbIuyLslbSZey2Ej8mzo3UM7rd6G161uuJp2OQFS74be0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372488; c=relaxed/simple;
	bh=tSDRliLxIhUCDjWxT5ARtO7C3bgl8AHy9/WMdEuBe70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeZqWfhajIAPdhd52tyTztTvBv1P26t1PAEaSrjcoVZ5DQtRpLQLO0dwufm7FX8zCosoNojwT+v/356r+z+oS0TXjexma6dG58ZJJsUNKBW+71+AQ6tF81xoErq5KLLZB0zuGzGdp1OwSogAnwA/O0sUCIyoHGPvLEe9EfZy+Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pYNDTEoY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=elI9cLIg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pYNDTEoY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="elI9cLIg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2B4A911400D9;
	Mon, 29 Apr 2024 02:34:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:34:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372486; x=1714458886; bh=aVJRDcm+Rf
	hQBJ3c+yeW4INrUnwSr8b7XQ21nJLsuEM=; b=pYNDTEoYVZt6eTPoXymvxFes22
	9RuWN1F9rBLSFLTBxvV8c6gcPqwLg2xpECyv9CN6XYn5sYO0jW5ECBO1mmMI84NF
	50jZNUyTFhc+iscp9JvqMEL9ZQ5H28Qh8t0GkeEH+V9wK5HkoTeenozsQnf81/jm
	Tve7xmTI7PeN6DZfBHYcPAZZboBrpN6T2VhNiMSun+kVPkiTfQ3gTtnE+16UB2j4
	QddUi7W9QCHIlUTS8WqRBPHY9niI5Af9J0zRKTXYwAU89Ng6CSyQ3L6BNA/0Jyoq
	i/i3poUE543JYPbDtuz5HOVPk3JMTU7XnwJGV/YcnUSWd5paW/o5HBMBxodA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372486; x=1714458886; bh=aVJRDcm+RfhQBJ3c+yeW4INrUnwS
	r8b7XQ21nJLsuEM=; b=elI9cLIgG58qWMUto9mvG/i8CAJ/mhK9xdFKrCGGe+JQ
	O9tazADgK1HgoVmfyIVtQqGpnynwwNz53tuX6DdEAUNkXjYVuByiQeVZLFbx+qkB
	PJ6LKc8B+jqaS3TapknOW6+ix2JT94ltlcwydtuYlVonUIEKTO9m+WjiZ/2bhE8Y
	s6+7JLeT8R8cUlvwgZs+m372P0bHwx5EMM0FQPL112nXwI+Uf9fP8iwK+FVyc7y/
	NI8qU9QCplIXEtxjQ0tJ6lEeI6xhVbYxBguW8nxcbOvI3R4KMG8oX8IduIM8BzP5
	riRuFznQd0cED3mq+ygpBcyaHjF18gc7s0f9hj6nSQ==
X-ME-Sender: <xms:hT8vZoRxSbOWH_EjJiypsUi5XuBrQzLH8MqxBw2S3j4DOxpddxbf3w>
    <xme:hT8vZlwJ6LdldYBY1uEsJ_PXvwmX9G0cuu4tCxtLXjyUZ5KPD7sYSUqhf8dsiMllm
    3B67t9ntOBJk84z8A>
X-ME-Received: <xmr:hT8vZl38ZCZmoR8NiJg8T9HVhylHKmp3hwbVKPDYse0AjFoScbK-7ylKLNwhnsQvrptjrEDZNkm--s9ADITDqjQBYqT3vD6iAYZjdNI1UjtlLDKj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hj8vZsBtWqQa_ynz04eLcsfWYTmMC5d3q5mwG0pu6F_Ay0gRAQPHSQ>
    <xmx:hj8vZhj_XiIL670JtV7WgUwvkEFf7jQGJO6vkJTxXWw-m1TdNE_wLA>
    <xmx:hj8vZorJqHaVAAW-sfcEuiujDI4FDBObVQNvMAoUcjBPhRQqZV-C2A>
    <xmx:hj8vZkhdxRQ9U5ig-UEQH63cOlGkEqyJn9khZHwsDS1gMVk9-wcJYw>
    <xmx:hj8vZhdNusqaR65hHzUzvSxPk1d6ymUVD0QucJxQVw9pWus9o1n3bI5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0ab7dcf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:26 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 07/13] builtin/rev-parse: allow shortening to more than 40
 hex characters
Message-ID: <1f749607604b80517b60b3b696b22287aca0ab54.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="snmPIcBwP+0aUVWi"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--snmPIcBwP+0aUVWi
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
index 624182e507..d7b87c605e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -687,7 +687,6 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
 	const char *name =3D NULL;
 	struct object_context unused;
 	struct strbuf buf =3D STRBUF_INIT;
-	const int hexsz =3D the_hash_algo->hexsz;
 	int seen_end_of_options =3D 0;
 	enum format_type format =3D FORMAT_DEFAULT;
=20
@@ -863,8 +862,8 @@ int cmd_rev_parse(int argc, const char **argv, const ch=
ar *prefix)
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
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index a669e592f1..30c31918fd 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -304,4 +304,10 @@ test_expect_success 'rev-parse --bisect includes bad, =
excludes good' '
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
2.45.0-rc1


--snmPIcBwP+0aUVWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP4IACgkQVbJhu7ck
PpQdLw/+LJSCGOmHG+Vq+7Tjdx/qLNQoGZ2AsR45hhfPsRyVREIQcqxrecAzp/6P
410be3PXqirRcveFzIZFnJTwINyDYEYKJfrwxH3AtcGmhU+Vm5/lgeknrzs/F/pm
yIXIGNcUR0X59+QMm3j78nx5Hz2BbDpbkFlLpObQCOFqKg1hI+BKnRZp5Wv5nSDG
xYNIwvVYxfvtW2A8si3vEwLWpKAXBAotSgFhGTC3vKm0CllwroIzVgNNoVnPojL2
zRYQ1htsMlSgYfzOQwUUs6/rzowBbhwQi1T2ATzgpG98Sb0UHl7ncMcREfB99AUw
IbejmusHAM8QpP8pg6nVrKeBv4ceh6iWxXVdOFVcQd4yRw7TObzOw9S7aR3KGPSY
cR4zrPwP5tCftZK50fygJOI/0ukKQcst07sRHBBW2Q2Mqzy2e+Cgk8E32QPXBLDB
gg19YDJycogUac1fZIBz35RGf0gkT61Z3PSX9+oAP/CKKS4j0Fvcc57L1c0lc2Pj
texkbjHrwkcDs3qGQWS1REAs2FfIB3E2oNx5/RF/mQ8f0Kmm//ledgs2RhcNzH7M
lXVYZcVYnp/GuNc8TIpVMemNRWiVMFBahzE5NW75i5SGl7FOaW1b7fecCdbSqbqb
8Nr+1W7H/EHdDbWQYq25QjChEV5BzYg7LFye/Ta73O38NMYrwLE=
=LUU0
-----END PGP SIGNATURE-----

--snmPIcBwP+0aUVWi--
