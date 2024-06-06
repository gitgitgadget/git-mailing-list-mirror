Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1867194C66
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669681; cv=none; b=REi0zt47+Zj0G1xzrEsFniruhgbtEhOX0awIV1LKSwZag05qMeVPK/xV+8w49EapS6GDGnlgX9NFhq/uu0gP7jnsOqMSPGkcYrMAj0vg/s0VCHoToEfKezuO8y/Do0bjHAHMJbq7iYUz9CxtBiLqrRypusTIoffKYbJXtMl49KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669681; c=relaxed/simple;
	bh=jpi6R82mCGfXl5ohE2ijPI/Dl31UGVUFrWou5LorpQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umEDlHhkXZYkXh9TUPEMQMUUm+1HNEG51mN19q7jVp0qu0j2PWVkv9+ELKMeal3B4IL8Tz+kJJhiSE3pEKkhOo+kbQDtHVRAo6UNfTD6fDogpLm6utV3HiXTx/4zASZsYGnMNE2ANmHIqeNVchPs7Q8WdhtU4OgWmbDVLuzQztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V3x5eTzE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i4K989Fi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V3x5eTzE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i4K989Fi"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D8A0A1140138;
	Thu,  6 Jun 2024 06:27:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 06:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669678; x=1717756078; bh=q0UEBiqM+V
	d3olzYAvwMSdT/WPFTkJGc9sMKOyPHYXA=; b=V3x5eTzEP6+6PvEfFTfiQL3zSc
	HY6IZsEREjmUWcPW02mTT6oyLBeR9pU6D/AuQxQfoSrVUJVpI0j6HZPL1cHMp/Qy
	3CUm/ahTSXEIGhC6RvHbe9/rfa6e9+mmFtVr2DLLz20IMRUONITggzM5EAB8NePg
	2OzXtVP8cHExKvETskDwpZIpPwPzaG8I57VW2Q1mc2l7emXm2Ns8AUHoJYvLnMeO
	PifLqpNZzimzVvyOXDFIeSeYEB8pj6ctl97zaluGqLWwBqU4A8XnRTpCewQfvd1r
	nSiAnlO+v3fbHfYHBB9Xgl4Um8f0goZEARf6lqsDITUEd2dZUPnkeDQiPl3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669678; x=1717756078; bh=q0UEBiqM+Vd3olzYAvwMSdT/WPFT
	kJGc9sMKOyPHYXA=; b=i4K989Fi9ZPu51+3SPazAB3BUFP24IB/OQ2G4i9JuOKD
	bOlBTRkV4Ubi5kFVII6Dvef2EoYQmkIIYSMBweAaXDcW4LJdZqq0CfjPXf1iNofr
	cPG5jBmVhi0E4Lac8r2jvLsJ2BKny5b7RksenkhqKAT4JYiDIzpLp30k25ghGnnE
	12Mmb8c5s+TGUwDvsV45QqqWY+5CMVceGLjrtVRY4Mml0nAEtI4dFa6Dg7cWQZ+0
	SWxMm1QtEE9k/2KZ5HVf77vP/wKgfJ+5cPXD+2QWs+IVQfRC2IvVcpV94ZRNukY1
	nmVCDjE1uvWBY/Idw0IY41KbTrF6NEamPO/QCUTD1g==
X-ME-Sender: <xms:Lo9hZkVaYp8a2F6FAihb0g7DIfhfl6Mgp18EVYBbvjA6FVARaCqlMQ>
    <xme:Lo9hZomJjI8f_HgFcTsTART14G6J9QxuklSsBwFS9zuaUWzK836JXy4IIgfjxV6rk
    8Fr9Id3Gl7gb_EpCQ>
X-ME-Received: <xmr:Lo9hZob9E_L6b1BVXB797ZmYR4Y1z2lBpnTm4POHSnerdwBK_DgsWmGV53gOsnpRlc-TdbH7FleggzIeqWpn1LWIsiS68ZXqEsZTUI7YITg0xJMd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Lo9hZjXCtDhdwytp0KFQdeIGZJZxfwl55Hbrislj3MrfhTrLjnd9_g>
    <xmx:Lo9hZukSksYFnQobaMHMvQGDFwUU09KYNK9rUaWxBQvHKKYfb8qQyQ>
    <xmx:Lo9hZof_4cZz91pmKFLIWZRM1sElsLnpPyisWkjgdw2vM_u7UEVztw>
    <xmx:Lo9hZgGo3s7NQBR0WiNvL3c631o8rR3Nyi8JkOddWyciDpeCE_jFdg>
    <xmx:Lo9hZvDVIjH_P5HGmHuF_CPE2i0iWdXp4DG0HuuYq_x5sPUdjsot4xJM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:27:57 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d0f1fbf0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:26 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:27:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 02/27] global: convert intentionally-leaking config
 strings to consts
Message-ID: <92cb0b28c65bed0f3cd10e6c4c57b98f199536a9.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kjT9Ib6XI/GEyWC3"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--kjT9Ib6XI/GEyWC3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple cases where we intentionally leak config strings:

  - `struct gpg_format` is used to track programs that can be used for
    signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
    user can override the commands via several config variables. As the
    array is populated once, only, and the struct memers are never
    written to or free'd.

  - `struct ll_merge_driver` is used to track merge drivers. Same as
    with the GPG format, these drivers are populated once and then
    reused. Its data is never written to or free'd, either.

  - `struct userdiff_funcname` and `struct userdiff_driver` can be
    configured via `diff.<driver>.*` to add additional drivers. Again,
    these have a global lifetime and are never written to or free'd.

All of these are intentionally kept alive and are never written to.
Furthermore, all of these are being assigned both string constants in
some places, and allocated strings in other places. This will cause
warnings once we enable `-Wwrite-strings`, so let's mark the respective
fields as `const char *` and cast away the constness when assigning
those values.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gpg-interface.c |  4 ++--
 merge-ll.c      | 11 ++++++++---
 userdiff.c      | 10 +++++-----
 userdiff.h      | 12 ++++++------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 71a9382a61..5c824aeb25 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -34,7 +34,7 @@ static enum signature_trust_level configured_min_trust_le=
vel =3D TRUST_UNDEFINED;
=20
 struct gpg_format {
 	const char *name;
-	char *program;
+	const char *program;
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
@@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char *=
value,
=20
 	if (fmtname) {
 		fmt =3D get_format_by_name(fmtname);
-		return git_config_string(&fmt->program, var, value);
+		return git_config_string((char **) &fmt->program, var, value);
 	}
=20
 	return 0;
diff --git a/merge-ll.c b/merge-ll.c
index e29b15fa4a..180c19df67 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -27,7 +27,7 @@ typedef enum ll_merge_result (*ll_merge_fn)(const struct =
ll_merge_driver *,
=20
 struct ll_merge_driver {
 	const char *name;
-	char *description;
+	const char *description;
 	ll_merge_fn fn;
 	char *recursive;
 	struct ll_merge_driver *next;
@@ -304,8 +304,13 @@ static int read_merge_config(const char *var, const ch=
ar *value,
 		ll_user_merge_tail =3D &(fn->next);
 	}
=20
-	if (!strcmp("name", key))
-		return git_config_string(&fn->description, var, value);
+	if (!strcmp("name", key)) {
+		/*
+		 * The description is leaking, but that's okay as we want to
+		 * keep around the merge drivers anyway.
+		 */
+		return git_config_string((char **) &fn->description, var, value);
+	}
=20
 	if (!strcmp("driver", key)) {
 		if (!value)
diff --git a/userdiff.c b/userdiff.c
index 82bc76b910..371032a413 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -399,7 +399,7 @@ static struct userdiff_driver *userdiff_find_by_namelen=
(const char *name, size_t
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
-	if (git_config_string(&f->pattern, k, v) < 0)
+	if (git_config_string((char **) &f->pattern, k, v) < 0)
 		return -1;
 	f->cflags =3D cflags;
 	return 0;
@@ -445,15 +445,15 @@ int userdiff_config(const char *k, const char *v)
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-		return git_config_string(&drv->external, k, v);
+		return git_config_string((char **) &drv->external, k, v);
 	if (!strcmp(type, "textconv"))
-		return git_config_string(&drv->textconv, k, v);
+		return git_config_string((char **) &drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
-		return git_config_string(&drv->word_regex, k, v);
+		return git_config_string((char **) &drv->word_regex, k, v);
 	if (!strcmp(type, "algorithm"))
-		return git_config_string(&drv->algorithm, k, v);
+		return git_config_string((char **) &drv->algorithm, k, v);
=20
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index cc8e5abfef..d726804c3e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -7,19 +7,19 @@ struct index_state;
 struct repository;
=20
 struct userdiff_funcname {
-	char *pattern;
+	const char *pattern;
 	int cflags;
 };
=20
 struct userdiff_driver {
 	const char *name;
-	char *external;
-	char *algorithm;
+	const char *external;
+	const char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
-	char *word_regex;
-	char *word_regex_multi_byte;
-	char *textconv;
+	const char *word_regex;
+	const char *word_regex_multi_byte;
+	const char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
--=20
2.45.2.409.g7b0defb391.dirty


--kjT9Ib6XI/GEyWC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjyoACgkQVbJhu7ck
PpQ58A/9FqafD6+u+Soi3S79rhl3E/tizRn5lK65kRk4A53ceZlaQWXen90410kB
tF78Y+S2ovkUTNy1slnCZrACBIsTrLxvo2c5s3yrTinBClAc0NG8KeBUSrktq6KW
YX+ZLNay4hl0/khpLTkw0gWV7pzG/EuFXGl7X1x30PWodb2dH2TMuldfuxiTdEeO
T9o4494T7GWZNJ+drw7r1Orfchz6dGUkwdzTrRCOaHhWAx4+qHF5r1VPSTzQnhb9
zDa3tSPv65llU07AZIQuv454XzCYInlfCWR8SWqbEKgX+jA8tVOMVUjzscm7Arne
jF8Z/t9pQQP5YmrW7apbIr63ALqY0K197PbEIz5qPQloOGtpMjp2x5d3jyXR9SCw
t73EvaZ+Rzrjv3CvE6yOmcjDFp82JE3Qt0+gMF/QaMEN7Nys+hq+6ndfcdOrDbCS
xawgeSTljmUsHMx3WPTmQA0CVPq95BbhB6gASlDfIghZSiYuVwicoG6g1Zh2rdJ6
GZCRzki3BCSa/vlxMDjf5ASQ5paeaEb/ZgG+tdjAtCnCE8FsMP6YHTWQPEInie+U
b4NdS5etlVPhIKH9q52jJa9Q60/EaljDGS/lfl3EZtuBpz0Qh/j6y7AUvWTJtMxa
5db8bmHlYwMWvrkPddWIz+auYP0RRqfiYc1iv5CVRdImyod3D4k=
=0aoV
-----END PGP SIGNATURE-----

--kjT9Ib6XI/GEyWC3--
