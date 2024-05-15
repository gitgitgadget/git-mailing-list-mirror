Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751C157C8A
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755374; cv=none; b=cS3YFxUb30BkonEnU0PM57kMSTF1MHUeH9kbQG98LLO3+GECN8K1h4HWHZvnEBm9coGuMlFhKsj8WGeCdhMbj2qOVGAftT7jXDK0h4D4AvTemgbQM0VoavaQ8oqWQPHbXlcMa+OiLIH5NWRCg8WQpSz2849uIonAGlA8l2sESg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755374; c=relaxed/simple;
	bh=Y+lF4DcQ6dYUz8LTRDQ+fWHuIoxRVUQNbz6c0qiXzzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbQsCw2iIxiDZCJoL8+KbznmAx4gARtyw4qOhlbiLqb89Tw/6WT+gtWpsiyaGfa4bgKDD9FBeGleIcT3omxdTAEJeOtTPuv1qAcA7ovc0KJ97BN19NZGkUzmy8OvUqphsJSfv9lCUHYBS9tbw9ubFvyYvpIAAUS9gbl9gGDvns0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=i49Kktl+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fzRYp7rD; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="i49Kktl+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fzRYp7rD"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9903E1380222;
	Wed, 15 May 2024 02:42:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 May 2024 02:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755372; x=1715841772; bh=LqrlEZvLZx
	dSKXRtElyRAzFnqaczGPdUJlfRy9qW1fg=; b=i49Kktl+8FPUjKMzOz1NKuqKsA
	g3IxodMsuHzpvSLGtHI0Nbi9tN2AUXpLetb6QlPrjclKw7lJRdTBNrCGRZO9onV0
	pscEKTwH1OnXZj4LSK5K94rsH7SxntwlU8fqlzBTRCeK83S70AaPUXbZIPFtKYc6
	kf3DgWUoO0ivZA8EQm7c71itoFWvXduA+sw1755L2FA2uPEz5tT1QHcDWOpQB8hf
	ASPHiB2p0+76j+iYSen4XShBVw8gvMyHlReqFwoGs3A0AS73/7uoE5uIb+0CnQfi
	BJGHRr/a//X9dYrzPgEN4RBOLbAHnlUyaVfuR9iX431OD/fJOOnydRgw738Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755372; x=1715841772; bh=LqrlEZvLZxdSKXRtElyRAzFnqacz
	GPdUJlfRy9qW1fg=; b=fzRYp7rD1K4XqpscjjWlp1OYtxK2vR2RDrANGw59FOHk
	nAJgNBj04VNbEkUiG3+h58R3JuXBMWAPJCsjnfnfaNWUBB4sVLCxQER5vJIkeGY9
	4ODxY8XpP3OlOmb1AnptUYldStYNFfEIAt+I697OtvM7kw28SsRmgl1IPdxKjwfh
	ENLHvk9GIyCRsgrKf33RI20y++2MGse5FWEBBMRxHQxMwWMunDjp2O+oWGm1dufD
	H2kBTel5i0guj+YrCAGZjir1w2+6CCbNcUh6gR3w8auCRSmkNBRKsfv41xnCvvwh
	QubrWBqO+sBYPNCe3YPiEkth+b2S0Cgl/1aMqAXm7Q==
X-ME-Sender: <xms:bFlEZgS8zJJwHoBNYygcX3lf-RBGiFr9GYEoiXWZSnq-SM3l720SAA>
    <xme:bFlEZtzBvYXS3hRAzw9Ury7jMM35ihky5ZQXglucG3_oOMChw-rClVFoiBOEkCQT1
    1BqR_1pJyRSMmQfNg>
X-ME-Received: <xmr:bFlEZt2KJ-SbKUWg_y3QCAN8zYeAH0bGRUfnQd7qjM7ZTNVsG2ruI-X8iYJMTySZVpMal54k0GLaGwnY7axQXQTePaX7mi9ick5lI2PCMLCq8KcB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:bFlEZkAaOJo61DIYsLqM2-3qaX5klx8_sUq0GOuZAqwbdIkbbL73Zg>
    <xmx:bFlEZphxvACNcSNwNCnUaFchmX_kcu6EtVgnN3JKFeln90kZEk1LDg>
    <xmx:bFlEZgqKUae4D6sVRip1CdN_BjVB9ukEInLjE2CjBN69dceieMuXcg>
    <xmx:bFlEZshTkt_5tq-5bhh-4srRWVUw_idlcfpLbpnU6N3osPGelVBvCw>
    <xmx:bFlEZpeTv1yoQ9_LrdwDZVBZEULpqs8iQPqbImLawUhA9vwMl5o15yg9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1c82ca6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:28 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 16/21] builtin/config: convert `regexp` to a local variable
Message-ID: <bac242caf0ed8167ee84dccc183e825652f65f0c.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s7qjf9fJT492E9CS"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--s7qjf9fJT492E9CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `regexp` variable is used by the `format_config()` callback when
`CONFIG_FLAGS_FIXED_VALUE` is not set. It is only ever set up by its
only caller, `collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index aac5f7b976..ae609c9b97 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -125,7 +125,6 @@ struct config_display_options {
=20
 static char *key;
 static regex_t *key_regexp;
-static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -327,6 +326,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	regex_t *regexp;
 	int do_not_match;
 };
=20
@@ -343,8 +343,8 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
-	if (regexp !=3D NULL &&
-	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
+	if (data->regexp &&
+	    (data->do_not_match ^ !!regexec(data->regexp, (value_?value_:""), 0, =
NULL, 0)))
 		return 0;
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -405,10 +405,10 @@ static int get_value(const struct config_location_opt=
ions *opts,
 			regex_++;
 		}
=20
-		regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(regexp, regex_, REG_EXTENDED)) {
+		data.regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(data.regexp, regex_, REG_EXTENDED)) {
 			error(_("invalid pattern: %s"), regex_);
-			FREE_AND_NULL(regexp);
+			FREE_AND_NULL(data.regexp);
 			ret =3D CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -448,9 +448,9 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		regfree(key_regexp);
 		free(key_regexp);
 	}
-	if (regexp) {
-		regfree(regexp);
-		free(regexp);
+	if (data.regexp) {
+		regfree(data.regexp);
+		free(data.regexp);
 	}
=20
 	return ret;
--=20
2.45.GIT


--s7qjf9fJT492E9CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWWgACgkQVbJhu7ck
PpSjvA//VKYL0o0rgkxRShu160gxU1EmdNJ1N4JdXr7XX7I4+b8KEgeS2AFlbPnz
reXdzpWuCiDFm/atiQly+g04ZyJ5ViyUMFmpoiX2HCO/SQC7p1OY03aw0uT2CB3T
hmeTxdeR7JQIFHri6p2OwXFl1Wixx8sq7jjxWNSb+6nAlAVdpKjqf/qTWck8yFRR
xaYYrG0Ondskrf5P//QDNhlIIp2l/d6XoVHIipJvapvF3phqKZ92p89RLvizmyJR
ap4vhTn3IWNiAGlsK8CR8gZ4jAhufvIYsWZ/TNaCVTIj7ERIVEYmrhsdUHJTGg4I
0+e6nYQm/vCp0J1yawcSQy2D9q6aFKq6kHga0FddkoDBpXflos5uztb6BgptFbu5
8UzdEdtD9+5/iKx9XzuregiZeUkBC6pjcVVIrMsmUzNxlkmEr7Y0sTLEyk0SzYMY
o338ALQTzreToWg2HgnHKA3h1xjz8R+4fejl++uaGT6FFr0cuCwgqZGs0FNfdNek
7Rr+RmDWSYWG0n/4DaiLZtBAFysMcPSIfrxnd6fkE69awG1bxCcAPUwKNI3g/U3E
ANr83mnNpdfXGklgN4P/Qphd9fFL1tm3C6mbiH/nJIBLJA+zCtS+7VSC+LQzyAPw
x3nIhz6UMTnlPJG9zjEgGY6UElEpiCT/zL/0rw77Kv+pHBGoO7U=
=WYBV
-----END PGP SIGNATURE-----

--s7qjf9fJT492E9CS--
