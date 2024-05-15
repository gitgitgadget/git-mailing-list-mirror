Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C8D5914C
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755379; cv=none; b=bCyYObsiwvzYYLbWDdyhX3hyHc/RmaoPhsItw9kPF5QsCPaQxDrN+LHIH/ONc5R8JFJkKj+oHv9ZIuSfPpRSuKUiBPhwya63xr66QrNe1n9TES+FwAVyrRd6YS4h/Y4LMctX1DB6DCOWn3ERjvm4ZIwCnufgfn791+KsfZXUNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755379; c=relaxed/simple;
	bh=levvc7MbXQTWxQE4h0zrAaE4RpymFNHvONCJ0MwLh/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9bRKar82Zckzlzo6CPBOTmRTIyX4v7cfgLNgzDLMZNqYGOTrYryqQ9h/WC87EciluF7ou/ATxzYvslS+vbq5KM+qxC9UJKwmRBWaZxgaipVn4gC1g10R36iabn4OJWsd3xCKb7k7Z2/Y7Gxbb2CS8nWwOk2/jSwMUlKvYQmbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ozjrn2BT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XeKIxdLz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ozjrn2BT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XeKIxdLz"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 050321380222;
	Wed, 15 May 2024 02:42:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:42:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755376; x=1715841776; bh=Paeo5Qwk14
	ngxQ4fLXDBN+7fugWVbGJWD2oa+g6aLho=; b=ozjrn2BTNoomfqT8eG1MVHD5nF
	UsAoNVFase6x7r2UsurZe8R/LlxI5198OfVB8vg88H54iVDztRiKyvdFBq3dG8PH
	MwvqHOrg6mLzE5H3OOYanFn5YWgOgwXZr+L8Lm4wG1f/sSLDP4QCbar4YHpWyxcm
	y3NZJjjkydQT51Ql+9sn5Z2/3EdfrhfBS+HjYePZ78vl9anDy/4xUF31n1tD+PL7
	5YN5G7crVXIVLlK05+1fQT1RcE486YPj+XIWsxrpKs/9MEJr0lNmKQmhXs/T0av5
	sc8Vr/TX2r7RoJsnWPv/tWCOCMIwWdDXWkTRNygcIBoYPm68EjvauOB+jCjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755376; x=1715841776; bh=Paeo5Qwk14ngxQ4fLXDBN+7fugWV
	bGJWD2oa+g6aLho=; b=XeKIxdLzACo4mlAesmiAAi/I+7R3ujZ25MFT6VrcmC9X
	PbJiXxcxrENQG1TpJ66ZcACMAGMB6VZ+f/egq8vf1imyVpdgNT5sc28DPPyaj7ZT
	IY4T3H92INDWSzW9S5b73tRjds16u/e73j9p58uZaANqgusEWd7dI3bRrzy31x8V
	2FAK1MJbFxaziJTyLyxhmJgUAbKwuqM/rOOeRZvJezAhxAThF3C/jDqd/sGRZI/M
	7m85NoNP8T8KRNZTiuE4bXnjumhTSGCFNJwtK/op2S5enN4mIHJOPGRqM41bRsqf
	iM1lnxUH2YiRpSPHYhPIJjedgjU8B13nzLiSY+Gmlw==
X-ME-Sender: <xms:cFlEZsEPbsiuFvTpqv3TIvJSNmJejQ2tpQuRCJlKDjuebqwAJpM0kw>
    <xme:cFlEZlU35mQ6k5Gbe9fWKFJao8ZSUc5Cacq6JAV-Dp-EtUTGS_ZSw46QdP6ZFVk2B
    TUbfwR3Wzitu_FYnw>
X-ME-Received: <xmr:cFlEZmJFeHuyluuXYgqCho8ybW7Jbd6WYA3NSBW7srZ_9dcvPfkks59-V2S-dwId11TYwCG1YaWAsv3oN_BX20RGbtRofiA7zkAhuNYMzLyvRflg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:cFlEZuECx9cZwJaA2jQTn4MyNmYvRFmY4yK5w6f54hsZbOOSQlEo4g>
    <xmx:cFlEZiUkAq5DKsM-y51QZuJRKfS4yjbruSL36F3u8pXjm1ny5bkixw>
    <xmx:cFlEZhM-Zezpsl-xk5yrfBQUqHJcoLCe3A9EDVZDwtGAi1CXLJUYqA>
    <xmx:cFlEZp0RAsNHmA_0viByr_mDH1U2SH2ghRoXaHwEPhSDhIYC9wDjxg>
    <xmx:cFlEZgxX18-vV5dYBpmh0Gk1CZsVOyqDKHQ6m8u0VdmXWvftUv8QsFI5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6c608fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:33 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 17/21] builtin/config: convert `key_regexp` to a local
 variable
Message-ID: <746bdf873387090c80451cfc5e1950f737aea4f9.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tYSvnCmz+/2nOpZ9"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--tYSvnCmz+/2nOpZ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `key_regexp` variable is used by the `format_config()` callback when
`use_key_regexp` is set. It is only ever set up by its only caller,
`collect_config()` and can thus easily be moved into the
`collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index ae609c9b97..08a11b7999 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
 }
=20
 static char *key;
-static regex_t *key_regexp;
 static int use_key_regexp;
 static int do_all;
 static int fixed_value;
@@ -327,6 +326,7 @@ struct collect_config_data {
 	struct strbuf_list *values;
 	const char *value_pattern;
 	regex_t *regexp;
+	regex_t *key_regexp;
 	int do_not_match;
 };
=20
@@ -339,7 +339,7 @@ static int collect_config(const char *key_, const char =
*value_,
=20
 	if (!use_key_regexp && strcmp(key_, key))
 		return 0;
-	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
+	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
 	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
@@ -383,10 +383,10 @@ static int get_value(const struct config_location_opt=
ions *opts,
 		for (tl =3D key; *tl && *tl !=3D '.'; tl++)
 			*tl =3D tolower(*tl);
=20
-		key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
-		if (regcomp(key_regexp, key, REG_EXTENDED)) {
+		data.key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(data.key_regexp, key, REG_EXTENDED)) {
 			error(_("invalid key pattern: %s"), key_);
-			FREE_AND_NULL(key_regexp);
+			FREE_AND_NULL(data.key_regexp);
 			ret =3D CONFIG_INVALID_PATTERN;
 			goto free_strings;
 		}
@@ -444,9 +444,9 @@ static int get_value(const struct config_location_optio=
ns *opts,
=20
 free_strings:
 	free(key);
-	if (key_regexp) {
-		regfree(key_regexp);
-		free(key_regexp);
+	if (data.key_regexp) {
+		regfree(data.key_regexp);
+		free(data.key_regexp);
 	}
 	if (data.regexp) {
 		regfree(data.regexp);
--=20
2.45.GIT


--tYSvnCmz+/2nOpZ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWWwACgkQVbJhu7ck
PpRWdg//VmLmk/jybiCoBibUl1D3b9YgO6XqXKIBIWOcbpVNkmTBdk1PI25KoasA
szYdtzMv5HzreUBUc9l/UiYveUAGXbR8+j8BDLaXvYjhBNSZ6LLnjSmYc2WlLSwp
dZAgKLknNN6I4AEK1hveUBFsLu42UV4m3UOzDdRtxoYFRTMxpj451r3xBZm+JopP
hL5ypWV6py97TG5hNzktgUnmHFw0hAp1lC6kPBEkUzHMSg6GY08DVMzvpZyiYI8c
D7Jej7Zhc9NKKhmFKAWKtI8WSsLQoZlJpbxVATBlbSnHAS8fp4QR/BxGRDDUgHvT
xeIlGtjJbj2JGxHXleTlVyJMLkNZd2QnNGrcYDKLFyGilv/2K/tltzhxios0grri
pYB+lD5I1SvIyIX3LjyQ0p1beRBKz81KpsSPMXYFrhX/PzJfVX0LgDbO1xMxDknE
L4nqUbJZ8IYt6oraWCKl2h4l8hjwKUmAkPY09Q+sTtuubzydBX0Hdfh89XH24W/u
9w0fAW694FaZbxgO5caS4E8TclQWtd4qvwBadCyL7iG12+i3HYBv7yoOvPSlLzL3
yhaYtwoUiJSvOBcC+OZjTjFsc6eSMRXOHb+hCO2StZXOP7adFNo84exfkrSM782t
hb6QcLYSfJIorbpOj89xWCKdI09hCMTko3hELFe8J3C2cMQ8aTs=
=Vhbd
-----END PGP SIGNATURE-----

--tYSvnCmz+/2nOpZ9--
