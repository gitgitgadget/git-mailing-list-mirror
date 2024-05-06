Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4F91420CC
	for <git@vger.kernel.org>; Mon,  6 May 2024 08:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714985765; cv=none; b=ddo78ndp9F3MsuRvbL6GkgLOmTR0GhlRiVjPY30DLS64sbUTtQBmjerMlBQoTZVv75jpW+C7CJa3E9x1BMfVPwfJ2maZcf6WX17gTjzHKDzAETVAMad2clNfLfimtO6zIQ1yzZpUCwxGC7pkG+qJAmn4q5kWYCwcUcSPjLfuC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714985765; c=relaxed/simple;
	bh=BiNrHvwoTLRRTF6OHbcyN3rxPF0JayGxnQ8pBO9UKAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk/O/KZOO66WDNX3Km+daPJFESpOaudIRnc42O1HXYRaETOmR8KRGsJlFXAifAszjFjla0n/TRk5PPAebH16oH7owWsrUmA8vAIpGquFHajXokhijya4lQ4KP+LxGte8bX8TpsSZ1SILz6aFtdz/6zhYPcJhY+IbrmdfT81Yccs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeJzwWvb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwUFcx5j; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeJzwWvb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwUFcx5j"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id B5EF71800087;
	Mon,  6 May 2024 04:56:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 06 May 2024 04:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714985761; x=1715072161; bh=YHhsVFupoN
	/dJT89AUFNXki2jckbC2sSFswvSzD1MGc=; b=eeJzwWvbwFzzW4WxYm92atvdhi
	An0d8FteoIi8+VP6HGwYe1DDs7JMeS5012mM5KiFMQiw9Ay9F8sSYCSNJfzDec+l
	gTbvQaItPU8zrZIsXoaXJrSCqyZRqQKolD9slKp7I539O+7MrvbFX03FAtqMvX6s
	vjvDQHrP0evSQ2S9PPcjocPGrFcsmK5hp8ielODdGADBE1Hwve9mEkNwoAS3gu94
	HhHBy18IISj0gWcGnOTEu6V6dmZDuv3Tpxtwk/u6rvyuB7UuxzLDdm8PKWd7P5tH
	dWg59iiym7eggkmOHFQUFY/hIjsAkwKPFcxDSxfW3woAp+GPOOzRKaDDDVEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714985761; x=1715072161; bh=YHhsVFupoN/dJT89AUFNXki2jckb
	C2sSFswvSzD1MGc=; b=CwUFcx5jEg4yBWW/1SHjBu8N08ohTn25JGSiUhc1HUJ3
	2a8gtf15g4MRnACiyNI8Ld+NOTcov3fnjim1T3CO1w2HquvlTueuVntY5JuDl/yL
	Bk2F30aVuYYq41MgqLpzZoDSKUCV2RgLmH1t8xxJAWKlA7HDUHMA46VJV99kaqLW
	LtkiSptyuSDQ8vNj/1ne6PxL88eWKYvBdyeeD5lPm1QYOZC+NOMy8OJSnzWz80Mf
	EDwXKLAw4q+lLqkkzPHobTEA9wqmneuJwupHmSw5ZA5s2PQinxC1vM5XdBlein2t
	eBsGo97YkszWw47kl4M/HX1NVvsVxovHqX2QPMhYpg==
X-ME-Sender: <xms:IZs4Zl4BMFRkVMyJ2MgEFUrOkJltm8nT9V49kesA_sdV4f3rgOFCtQ>
    <xme:IZs4Zi4lSQiP37jDpddQVNqLicY1EQpf9H7J85T5GGsh6XYobgeXazaBQ9qu8ddSJ
    tgOa6UAE5GZM7XZKQ>
X-ME-Received: <xmr:IZs4ZseAVGBCw4dRShbyfQPHqN4wf15miFTOmNEF7vNSIZ4eq4feU-i60mWNiv41GLUaiBdR5Jik2_KB-wcyWGpTO5B7BEorgJg6TRLKkemkYobY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IZs4ZuIKBX7YgFWhxQtJLFyMTLLrIwYSjtH4BMziZlvLqM4x0fFm-A>
    <xmx:IZs4ZpJyiHCg4egKWO9frL7jfHMdc_YqbEOQXwMM110ys6f61T4bKA>
    <xmx:IZs4ZnyQhjyEaBztDaH89bYh_Tx69ikrAcIFT0xQbZ6BQLmHYXqe3g>
    <xmx:IZs4ZlJ-CNguAmlNHQvuJwks2zOX6FaJMW2G2d-OYUHLyGO0YzmZOQ>
    <xmx:IZs4Zg8pUVCBJUjemfk9vZut2niW8YiJFZOQXqfh_0thvon1ErZTWUGX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 04:55:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 38d6c36f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 08:55:53 +0000 (UTC)
Date: Mon, 6 May 2024 10:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>, rsbecker@nexbridge.com
Subject: [PATCH v5 01/14] config: clarify memory ownership when preparing
 comment strings
Message-ID: <881d2b5426e2ee690e5ef37cd795b7141064d05f.1714982328.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714982328.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RUsaYjNebAIXO7uR"
Content-Disposition: inline
In-Reply-To: <cover.1714982328.git.ps@pks.im>


--RUsaYjNebAIXO7uR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The ownership of memory returned when preparing a comment string is
quite intricate: when the returned value is different than the passed
value, then the caller is responsible to free the memory. This is quite
subtle, and it's even easier to miss because the returned value is in
fact a `const char *`.

Adapt the function to always return either `NULL` or a newly allocated
string. The function is called at most once per git-config(1), so it's
not like this micro-optimization really matters. Thus, callers are now
always responsible for freeing the value.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 11 ++++++-----
 config.c         | 16 ++++++----------
 config.h         |  2 +-
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0015620dde..40456c0770 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -44,7 +44,7 @@ static struct config_options config_options;
 static int show_origin;
 static int show_scope;
 static int fixed_value;
-static const char *comment;
+static const char *comment_arg;
=20
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -174,7 +174,7 @@ static struct option builtin_config_options[] =3D {
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file,=
 standard input, blob, command line)")),
 	OPT_BOOL(0, "show-scope", &show_scope, N_("show scope of config (worktree=
, local, global, system, command)")),
 	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use=
 default value when missing entry")),
-	OPT_STRING(0, "comment", &comment, N_("value"), N_("human-readable commen=
t string (# will be prepended as needed)")),
+	OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable co=
mment string (# will be prepended as needed)")),
 	OPT_END(),
 };
=20
@@ -674,7 +674,7 @@ static char *default_user_config(void)
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit =3D !startup_info->have_repository;
-	char *value =3D NULL;
+	char *value =3D NULL, *comment =3D NULL;
 	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
@@ -799,7 +799,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		usage_builtin_config();
 	}
=20
-	if (comment &&
+	if (comment_arg &&
 	    !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL)=
)) {
 		error(_("--comment is only applicable to add/set/replace operations"));
 		usage_builtin_config();
@@ -841,7 +841,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
 	}
=20
-	comment =3D git_config_prepare_comment_string(comment);
+	comment =3D git_config_prepare_comment_string(comment_arg);
=20
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
@@ -993,6 +993,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		return get_colorbool(argv[0], argc =3D=3D 2);
 	}
=20
+	free(comment);
 	free(value);
 	return ret;
 }
diff --git a/config.c b/config.c
index ae3652b08f..13cf9eeb16 100644
--- a/config.c
+++ b/config.c
@@ -3182,14 +3182,10 @@ void git_config_set(const char *key, const char *va=
lue)
 	trace2_cmd_set_config(key, value);
 }
=20
-/*
- * The ownership rule is that the caller will own the string
- * if it receives a piece of memory different from what it passed
- * as the parameter.
- */
-const char *git_config_prepare_comment_string(const char *comment)
+char *git_config_prepare_comment_string(const char *comment)
 {
 	size_t leading_blanks;
+	char *prepared;
=20
 	if (!comment)
 		return NULL;
@@ -3210,13 +3206,13 @@ const char *git_config_prepare_comment_string(const=
 char *comment)
=20
 	leading_blanks =3D strspn(comment, " \t");
 	if (leading_blanks && comment[leading_blanks] =3D=3D '#')
-		; /* use it as-is */
+		prepared =3D xstrdup(comment); /* use it as-is */
 	else if (comment[0] =3D=3D '#')
-		comment =3D xstrfmt(" %s", comment);
+		prepared =3D xstrfmt(" %s", comment);
 	else
-		comment =3D xstrfmt(" # %s", comment);
+		prepared =3D xstrfmt(" # %s", comment);
=20
-	return comment;
+	return prepared;
 }
=20
 static void validate_comment_string(const char *comment)
diff --git a/config.h b/config.h
index f4966e3749..db8b608064 100644
--- a/config.h
+++ b/config.h
@@ -338,7 +338,7 @@ void git_config_set_multivar(const char *, const char *=
, const char *, unsigned)
 int repo_config_set_multivar_gently(struct repository *, const char *, con=
st char *, const char *, unsigned);
 int git_config_set_multivar_in_file_gently(const char *, const char *, con=
st char *, const char *, const char *, unsigned);
=20
-const char *git_config_prepare_comment_string(const char *);
+char *git_config_prepare_comment_string(const char *);
=20
 /**
  * takes four parameters:
--=20
2.45.0


--RUsaYjNebAIXO7uR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4mxsACgkQVbJhu7ck
PpQSmg/6ApF1ZdqxAi/Bh8BXx5x+vcXpg050pp1/hODuK6cVyCVQwVXfn0XHWDjC
26DI3iP+CzRQvSTGUqt7Ky+VRooFu1nahXEZTfIC3o/w+G2aNn10eD/YWwBvgV32
/t4Df512WQQk01/lgfCi34MGBhGcbrY7Lc8mjwWHSTQxb55uh3CLbZTjO7seWxOT
KJoDFFEWNr1SSxankL6sOEdIm+6DEB2gtHshwuDHzhfrzPjBqCtTmCH8XJ5ykULU
uonWn4uQ0ccozOht7g4VrEJZ3V78V/jMGt8fOcKP9abNOZOCRM8HxG4TNOdJocwX
77qW0hA1FT4kkBmEb/v2NGCV5e2Hs+UQFRqY7qN/U8jRlRNMCLCEWK9VuddmfD8x
o/ZuzNz5Z6zM491sqj72LDeXnqpzhST6K6BXgw4NULMCHBx1tJQhpC1TlnkN7V5/
bNChuSySUkVLo1TDOc7Kp5jifWw2WfPVlpXRiCnajTkgZ3ihPRokwKFrNVhsenl9
20eJ8eCJW0ISL8q2ENts14Fib7BOWWgyafvcqF0fO91YlHUjEPUJ2FUBWWzr8gXX
QWoO0whWNQT+zWzMQlInZCCvzyxNaFwDN0i4IHX6zsc3Gn6SX9HjUkvFNoIq3WU0
xuCTR17/1FsC8/PBZlz6/gtEbWxymfwPGACkOxUuaBKSO6GyTCE=
=pnnO
-----END PGP SIGNATURE-----

--RUsaYjNebAIXO7uR--
