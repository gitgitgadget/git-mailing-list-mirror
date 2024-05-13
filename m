Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87796146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595817; cv=none; b=PMmoEBkGtTy6UQ93N/csI0K0xdUldkP6FYttmOuQ78v6g9C9FFDxVPbrU9GdF/gS/hKx9xsju/ZAzV8cgkbfn4o0Ab2wGsEpe6tfX+XE3otTd7elgyJ/l2eKA0qAgnnACgKKr5972r+5i1BxLzLCf1Az3+rOLczhIscUxA/0NRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595817; c=relaxed/simple;
	bh=IGT8JW0SG+wTKk4SOhkG+UoZ5bU0q8U5jUVLNkxfclQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rrwn4WlKL1Ed2AnN1iYFUYSkvaV+wWifsyXizwMws6oKarcSkGUm7q7nGKwDcmFWIQY7VzZYMgs9MhjIKCtIgxcnPHZ4rBXp5KJCsKcQ2kL+sxugCrFbbCIMzyoDjRsfEJKDHc9lxf4Ky85zjpjAvAm+ZJ9nm/cTn66hOxlJfHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S4U+cehp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffkK4HNg; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S4U+cehp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffkK4HNg"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id CD53F18000DF;
	Mon, 13 May 2024 06:23:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 06:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595814; x=1715682214; bh=JoB+Lr/5Zv
	nAgXdVU3sny1hXbmlG3uyValbBqZpfqdY=; b=S4U+cehpn/cnTHrir5BmHXfoKx
	DHcN1tfNoZ0Smu2E/Qo5DywhbwZVFnES17OoDH1ldHu8CbpKQnmd4G46QeXh9KeD
	/fAX5XIPc6zE14FNc+Yli7PrLmraFvN0R2QlEncRHocVkOXdDyoS31ENBLGsRIZG
	WNoj3Dv1FQUA08q4hz7Jzocu/lANNrdLuCZHiFqMKIyyQkLVMwSmGkpr5QBNYGr/
	SaEVInqVnYTiYBlvygxfxGQ7NDUnA/4eXqsiGQC8KLAY2DlrR9FIUw+/wwIOQ/KD
	fXH83vbGQAGRosRrrX2Gz2V3oN6lD30jjK1ng3eDHX3OQmHtCFHb7sM5UCHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595814; x=1715682214; bh=JoB+Lr/5ZvnAgXdVU3sny1hXbmlG
	3uyValbBqZpfqdY=; b=ffkK4HNgMqSlCvBc4lfbBWj+LsHNV51YsgA2u2pW1Ubk
	qKT5/hw38skA9ogk6pMSl3EIDTfSwYILpZaaMW61ko0soyEtNlrlISfmlGeIbIxa
	nqeMNxsKx//6qMD1udDSe0tE2A9u7DisPgaMesK6Q5iHnsCE5dwX7WJ5oDMDmbvr
	6rELlVskDYVzG+kbzKcMQ5KA0CSCMbhm3R5mOToSnrpkt8dJf6xYDLXyj58ffMZC
	MPBkMNW2gXVgyxLcko4/HfaOS5g//hBhNSsIfWAkfFo3EbLVeDlZJfpRBL7Wui/S
	8mVcn/ZNhSUPBbiVd3ZiYKEeNL7JMkGxU/KTYxyA2w==
X-ME-Sender: <xms:JupBZn5OdsYjTwPsCp-fiRKqMLYUdm_qrly9j5Dc6HQw6GijuNh96A>
    <xme:JupBZs67ArMbAnMtNm3F26lMRyGIRFj6BeXKQDB2uHw30r84cMJJO_GV0UC6Oq-oh
    RAKYhd5RQZXjw9SgA>
X-ME-Received: <xmr:JupBZudiLWrz3Pjncbq38ECicqBBClkHT0bf50gMNd8JYWD5GEXSCl3jDhaUCm9aRt3Vf-W4ADdsZ4C8s0L-ePrm_BjtgT6Mw_s2hHPESAoIklM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:JupBZoISBsACPsVhbvWtMif36ggPvHgGwX4GsSaesTzl3ri8uznI-w>
    <xmx:JupBZrJxUj9qqG1uOZVvrQp27O7USENrU6qU3c1WZa1SYs9D1c2zIQ>
    <xmx:JupBZhzxPrXVLM8kdkxz-RVk0jje58diHdOgM7pghLZ3H7UMRLKTtw>
    <xmx:JupBZnJi2bhgu2r_raDkIhRZ2tUrTNXe4UTyJeS0Inydt24RuOMw5A>
    <xmx:JupBZoENljUKO6uJ8VbaJQaH2J5Z7MyNyHYNMzjwrl6odchcLFsnvNrv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8538f0ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:14 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 18/21] builtin/config: convert `key` to a local variable
Message-ID: <e972e63be88b75285eb22be56c2ff48747d78510.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Kkx5Fovu6Tv2PezO"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--Kkx5Fovu6Tv2PezO
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
index 8fc9ee20a3..5737574b25 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -122,7 +122,6 @@ struct config_display_options {
 	.key_delim =3D ' ', \
 }
=20
-static char *key;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -324,6 +323,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	const char *key;
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
@@ -336,7 +336,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	struct strbuf_list *values =3D data->values;
 	const struct key_value_info *kvi =3D ctx->kvi;
=20
-	if (!use_key_regexp && strcmp(key_, key))
+	if (!use_key_regexp && strcmp(key_, data->key))
 		return 0;
 	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
@@ -363,6 +363,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		.display_opts =3D display_opts,
 		.values =3D &values,
 	};
+	char *key =3D NULL;
 	int i;
=20
 	if (use_key_regexp) {
@@ -394,6 +395,8 @@ static int get_value(const struct config_location_optio=
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


--Kkx5Fovu6Tv2PezO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6iEACgkQVbJhu7ck
PpS/Rg/9HtFWmPE201JvQnaErtUxxy25Cs/Ndn2z7juXyQO14Co2p3QFJKMT0Uou
LRZpgK9nllq8kw8giUcdPHnzMmX61NIY+TsX3ciwDLDJuiEycuu+tEFwREV/vDGN
e07YAJYSJ1p5lxLAODBxn7ihuhUDs9SH8px8d/VtGI257gch1c4bmRaFs59MUy5e
gPWye6kIUvV+paZWT65A8srXA1ITw+NC26Qyq6fMV9AfzWg0nHH+/vh4kyM3Bbln
Yma/7Lg0mvBWcJatvIQm+JUQ74Ox18MbMCx+/yyIEP/ljhIJmPNGnifnN4wlzkOh
3Kh7qDFl4nIivqa3/5rxap1ibetdtnZW7eo0OBljRKfuUIaGuFoAaXMP4IpTLNqx
/22KNIiKGxS+vWwDCkhtk/zWbwOWlxUFP2n1b8fnxm7al7ORsRCrP2F2sb+mqWmV
Y2oP+FS7s98HbpDH3cryBKgBObCpFjx25hCwkBa9Q01w/UUPc1EN0XnRNqftPbDh
7ottOzFXU8dGtZ9cipMbdjDOzdGaWU72VLY10pWLOINfHzqO4RnXOcuR7zfrmUUo
79N7ITaT48LIyn4FTmlR3ZUKM5EB/97A9VzCmIxJ4nbnYPRFRw17QoVcFRo9wM9K
+TjwmNqZVBRYM2SFM9Qc6OzdSlZkuon34FW8ERUum3kMxo++2SU=
=6J8U
-----END PGP SIGNATURE-----

--Kkx5Fovu6Tv2PezO--
