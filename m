Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711D959173
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755383; cv=none; b=Wd4EU/KRHj2ScZR5yKnMlfqNeYdFmYu/vmpPM/ioW6Z54VahNPgLSGEyU0vurdHYDiBzKrQWYBLNZ8Pz+/gU5y/vzaqD7BYhxuo7R3DA5IrxSJ2yRCX850z6xEwckFvan6kpUmSBAVTF6pPi/UhPdNP/+59RHgxi7zRb2HQAo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755383; c=relaxed/simple;
	bh=GNZCMWsHEXP5R7EWjmiTLCPnJCH8lcO9H9Ii+Ofyq7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IOwdftSO6oPQ+0HgcqJ1SfP3si5nMqJxEzZZ23cbMDXlzkG8PdLVvcZeg+oUBLDRfbsyoGK9LzyJExwFbZ/NWMv4e5ikhvb+79WeE/IvPIQBY/3pvjNw7/2pCXGJHWrbDC4b2y2TrZKtz2icLtSEYDiJVuVpGw2BoTjJL5xfeH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WLqQugv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WIqqgZ4f; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WLqQugv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WIqqgZ4f"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9C23111400FB;
	Wed, 15 May 2024 02:43:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755381; x=1715841781; bh=ZFTSiVVeAd
	UV6uzXIYHatnLJDfJpKYQqB/UJjSja5fs=; b=WLqQugv19ku9o6LUEWUHmrovyL
	jOTslSaSFIO+pepHojw2ff09a+7e+ezlORpBCwbk9RMZ7xa24YJBaledPDxcHZVG
	jYQPP95P+PDW/Z3foyfVQyb8ZJ53Q//zs5Orh9SksIxPvWQbLNNeMDyAzCtI4yXJ
	h/MDbUr9Px0aEgMOKuAdUhRqgukKba6UT6nGGcqiyzOgcE9yjIjaSHa/UTt42W2d
	qPqBK9wM8eluJqbKB8NsaqwtOjxHst9o9C5FrNEn5ZwpF6qzMQ9tlekPhNg40WgB
	ZUvimvI6DalbS1MvugJDWssdaEwpFbTibJZFkXI2Y4BYpLdR9iWoK18LhQUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755381; x=1715841781; bh=ZFTSiVVeAdUV6uzXIYHatnLJDfJp
	KYQqB/UJjSja5fs=; b=WIqqgZ4fcfLoJmwrsTIH+rDC/+9TeqEkbGQr3WJA2m0J
	QXmR9Y0le8LNcE7KLo37M/of8CpZRNInzIHtCIn2iYNvOqjK2Y/qsOhZ/epp6YU8
	FM6z1zQKWKRzgDfERYuDrpfAfmdZFUahsT9spYH25w6Ng2ACDSe7x9C6ax6DeawZ
	v/R3cJdr73xxcUTRDWyob32rX9b6ZZVgflmgsqeEeu+qwZ6fXJGQJJCb0jXuwnLA
	ktoWnVh2V3MzFBGKKbWkW1ywplCQ8wuZlcCLaAlYaeS2tIC4PRv9COWlfd6vmz35
	Wyq8exaGjSp8Ydn+xBkxHLPgk3uA7Sy04Q0yHrIEhQ==
X-ME-Sender: <xms:dVlEZnPxYiJhagZL6jKKYssptMcK_QQrEc4BlzGz3H7Kk8NOKgh6VQ>
    <xme:dVlEZh88CCHsSC2hEFcy2EQhxepz4Qg-1cP-Lat_W6XWcLZusaSm4lKj3-xnLGa_k
    zVmB7lq6ZM1QZvRfA>
X-ME-Received: <xmr:dVlEZmTLebyBPnwTcxBv8U-9skDJDcL04U1cCg1R9ollKU4gAVkKguYVKqF-7RQ06C1Jhhpn8LwZiWakvq3AoKp5pcO2JwOwi7fXnC-HRrIW8TYe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dVlEZrvdqik9pA-ZAAYR3TzT3587B92zZXaxu51w5UHCIx7G0on17A>
    <xmx:dVlEZvcung-ebusDfNQU5HzwkD9TYkT36SDTd5Rd_gTrr0MRrVAJEQ>
    <xmx:dVlEZn2FJsNCqKQCicBVYd_UC6n4L1LygDfSnC5nw-F65UnbKUrsJw>
    <xmx:dVlEZr-1LpvjMBA6clUkyx_U9RtKRqbUIuuhi8nH0zfHYqns5h2KFw>
    <xmx:dVlEZm6dcz5mQb4MdyvJBSC4di_Oumh_BmabqZFaTDX58-tPIxovZhcb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:43:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ebf90b73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:38 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 18/21] builtin/config: convert `key` to a local variable
Message-ID: <f1f390f4998a4c87e6233373fb333f2437febe0e.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZpHmINBKfYgfhXHe"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--ZpHmINBKfYgfhXHe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `key` variable is used by the `get_value()` function for two
purposes:

  - It is used to store the result of `git_config_parse_key()`, which is
    then passed on to `collect_config()`.

  - It is used as a store to convert the provided key to an
    all-lowercase key when `use_key_regexp` is set.

Neither of these cases warrant a global variable at all. In the former
case we can pass the key via `struct collect_config_data`. And in the
latter case we really only want to have it as a temporary local variable
such that we can free associated memory.

Refactor the code accordingly to reduce our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 08a11b7999..5a03dbb452 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -123,7 +123,6 @@ struct config_display_options {
 	.key_delim =3D ' ', \
 }
=20
-static char *key;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -325,6 +324,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	const char *key;
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
@@ -337,7 +337,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	struct strbuf_list *values =3D data->values;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
-	if (!use_key_regexp && strcmp(key_, key))
+	if (!use_key_regexp && strcmp(key_, data->key))
 		return 0;
 	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
@@ -364,6 +364,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		.display_opts =3D display_opts,
 		.values =3D &values,
 	};
+	char *key =3D NULL;
 	int i;
=20
 	if (use_key_regexp) {
@@ -395,6 +396,8 @@ static int get_value(const struct config_location_optio=
ns *opts,
 			ret =3D CONFIG_INVALID_KEY;
 			goto free_strings;
 		}
+
+		data.key =3D key;
 	}
=20
 	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
--=20
2.45.GIT


--ZpHmINBKfYgfhXHe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWXEACgkQVbJhu7ck
PpS71Q/7BuHO+WhDm8U9IBJhl1gpScHxyhyVSj/r8AIoudF4B+ErZH3Jw/50gbmy
hNgH3od6exq+kFQjWQ5ljal7kL13vFQWpUoVEftXJvPieNiZw7SHkLKL9gZkdHKv
1ZpeyE1D6QWcu8kN59MA8r+fbnT5cxG6D9KnirBeQuVYxI8sIg6yvNFFELEUO4iD
mpqeJ9OFzImWoVUnXiFkAxoG0f3pAG/gGslLF3LYZl6LZJXc6ajqqCYW3oHl0AD4
s9bEltQUSLNgaMT9030eXWWkZUjljKyM3onRxQqvdRSXTfyZaoIFdPe9uPViQe89
shyKjBB6m3PbmctPTsvSD/DGB6dOReHP38WrxrdWszDVuW/QnCsQymFb4b8BRYL3
58eeeBJtP5LbuXDnm49ZBux7RbeWQk4VOFGUPBKFB5EKBSzrninwvfwxWOHNyNSg
RUjPmUYul6aMAkoysSxlILVVYMd9vSSJOJ8ub7V4rLR3ic4tploJ3xeUX3JNLjiG
fZkb1wuzwx2PC8eFHhZxdhvmg+0MYTHVp5PQp3S98LLI8YQbtu9ZWxUVCNXcYH0F
HYFuLeIzecQ4QRg/eA6j9a3/yJRv6MtYr70be0JOuP2gZms3hPjGhNf926EG8y3p
hagnvsQlgS4zdkYmwrt9mBbEE7NpoFtXhqbOrvQhOuiLUFg9AZM=
=NrFY
-----END PGP SIGNATURE-----

--ZpHmINBKfYgfhXHe--
