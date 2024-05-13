Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4544F146D76
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595806; cv=none; b=oq68SQP+EzcfW8CZ7eRpl8ZPyfEmNNWbmoJppMMf+7eA8DeuzKc6w9EEf4Gb58UhoUgM+WYisjE11pcNelgZNsC988QoyERyhiNs9J2cuCDCrjwqQ0UbGGcr2+jFRVtRxX5Bprl/puePM5fAncsgBxzgwulhB1LXXmnmkd+xpgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595806; c=relaxed/simple;
	bh=ctAyA9tsAXCcSNCEOaQf83JWUgXOijoj53K3UmWY3mY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uaq1oOtqM/FBfrS7WHRjqYM9cqx6Zt8DQHgPTuBlJZxUmPXtXjTZtyEvVSO8eI0uEUV5lD7cgQLmQd3bwXKE7YqcsN6mx+S6SIzmXkmMNJywsm4PqW9XQP0XbJEOlyA3w0XGoLyDcNIQY/POvXQe6UWAEzQTt9GJDfCMvrI6vb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=POkGRJHs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1erpRQZ; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="POkGRJHs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1erpRQZ"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 933B31800103;
	Mon, 13 May 2024 06:23:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 06:23:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595804; x=1715682204; bh=C6bFk9ENLL
	roUqHc9D4tejsxeOcr6tdqhusZeUl4+KI=; b=POkGRJHsaCsMXHpGMxdtd+TOBK
	kddlegA+QUOKYP51HOlNHSJmmb0oj+LbRiee+i2dcHa2KVCeqeKXNi+vJ2AnX7eG
	cHjKTa8BRTc7QhHHaot2xdbAjVi3Al6yQ5yD9tnWx6cqD6NWVSlzc8P7DDTNYCbp
	gO0m0OosVt0wgS+a3eBYnd0vjngb8g1H2z4hu8VB+DfJG4bg7rCv/5FlxfU+dTRP
	hYCTQ9nXKKE5Rkg/xMpzDBU+m0cRqCe8bQwSaYRM3iWVakzjgULpDGk7GWzdSn+B
	Wd8D+CTEvatQeTJzSciL00Mg5jRR2OS4h3RMOixRDIXGa0IRCpOvH2rK5jvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595804; x=1715682204; bh=C6bFk9ENLLroUqHc9D4tejsxeOcr
	6tdqhusZeUl4+KI=; b=Q1erpRQZA5z2G5ccYmVRkecDO3W3BlCfNi2/d1G/MgJq
	OvaC/BRm1O9yQv/Qf9158h72v6kZe7OSwDa3C9U/cTEuApdMtnAfmq/Wwk7XwE4M
	cjpiULES2AT8OpMSVAlFznrY+qHU8jP4eNKa3dtM3kU764XXDbUFPlDshwP71xOk
	qDmEBNTPz+M1H4YntLXySGWAytaFWQ3qcQSw11uIbJFlkozIOsEx/HTdB5Z/gkBe
	PSRD7oHlNb9SjyqGphrMjt6Jn59w4n7KaXserUilCoXU1kypDlaP406D2Fl5PTNW
	MvErdDY0fBPBdKIhUNFvDfp3767UBk+qgi3JFp/H1g==
X-ME-Sender: <xms:HOpBZkjY7NJVPRiHSRif4AKcFeG_uecojWvmap_2eIroRjIw8yI50A>
    <xme:HOpBZtDifrN9bEjpTqBg5eNhAh_g0B8kcyp87XtLAIyh3PWFTB8frZ_WfVSqywGgX
    97NMaLS9YZpsleWYw>
X-ME-Received: <xmr:HOpBZsHK7dvWJTJiWWnPHUxEl9VvH2XD3M43T2ndVCt04w86OSqaKv0f8vNBQNTdoy3p59yuy5RLaAahTX5vy92sxTODbfRzfJUc-nVMCbd7Lo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:HOpBZlQmONXw8X_13G-_gpp5zKk4sJcySUNuPkqgWs3_2_ZKPIMAow>
    <xmx:HOpBZhyOC6W_l8ozxtxGVqgRFs1Bc-V0YT_AWeni1Hkxxc2_v4l2Ug>
    <xmx:HOpBZj5GT3IlpkJStb_PnBEVvdWdZgVJDhImXTNkgJdcArQGx2dDkw>
    <xmx:HOpBZuwtotw0O9mykhwaKH0aAW0u-40IjNItdXBH_37ZdsW82Mh9dg>
    <xmx:HOpBZjsOe7fWQqFAp-PvLhZc02cJ1Q2_eNEzHeHOlAn2UU_qwbl4Mipm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 36018e40 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:23:04 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 16/21] builtin/config: convert `regexp` to a local variable
Message-ID: <b56a07bda0be898c2b999c63fd844cc0ee7d420a.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LKvXyDOY/vPJJEOu"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--LKvXyDOY/vPJJEOu
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
index a17e274ece..1909de22fc 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
=20
 static char *key;
 static regex_t *key_regexp;
-static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -326,6 +325,7 @@ struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
 	const char *value_pattern;
+	regex_t *regexp;
 	int do_not_match;
 };
=20
@@ -342,8 +342,8 @@ static int collect_config(const char *key_, const char =
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
@@ -404,10 +404,10 @@ static int get_value(const struct config_location_opt=
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
@@ -447,9 +447,9 @@ static int get_value(const struct config_location_optio=
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


--LKvXyDOY/vPJJEOu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6hcACgkQVbJhu7ck
PpS+oBAAq7tY0hfHDRXUIeawNg9W+F60VWfb+Qq9L6FeRNHWb/dW5hX0wi0HHY7m
1HaSKPxJwfu5OxA/zmWkr1Cm7jyaJQQR/4vAU7hENTvfzZxjkW8XXqAaynMx310t
Nc8DR4MAOEPwaG3Wf3w/r5fuqKgX3WFTgqFyUGCV+2IiEGlyViG/bbYJlMk/dqq5
plRdvEdWI9SD88tReNh37Dw+1j8bZDNlYPD2ei+zwjD397KYMIGwWeo069RCULZT
d6RQHNXGeTMExfd0biRNJe//83LIEhAAhI/74sTJYpgVl6edAVIwaUexa3tguB7m
JSnGaGPfDfZNPrNIQ5vJ1VJOT8bzCcERn4nVCCkpxvIPKc+vE70pIz/voLKnolTK
Esh/4FeGP+6+a6TGZCc2fHKmbB2q7hpK/V0cRB0sNrdnWwisXj3NnvtzCc/tpafs
j9krfo6Gh1dQ6BQqjbpr2s6dZj8YZRgg3/tlWwX4Xvm7D82mPH4gVvJfMphtGjjj
BrfupwouTcr+VoyJqinoo4U9XabfUyIVuiDisB53iAK/ZMwJnqHakpp3KIPDfVDj
q0HS19vrVYvWDg3tfIbdHtpHNVhwsJn+wTppmQygHkiQChYFRlJO3AaCoO2lUFI/
7DaUllzM/4PmQMI51NvKSFN+yXpV6J4fF4ATQI/Ovkh1QPeJ42o=
=8WnC
-----END PGP SIGNATURE-----

--LKvXyDOY/vPJJEOu--
