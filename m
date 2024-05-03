Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145D414F9D8
	for <git@vger.kernel.org>; Fri,  3 May 2024 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714730212; cv=none; b=h8llbpFGoTtD8/yyN8qjqOTLzQLA+Bx166SC4ullQsLCzHaY5/Tx6GK5/GtxmuDJMDe+58K6ls+0+HwpirollB+uMXtkJ1AG6hw9dK7CHWGFRFwGyQiq3Mqv44TD+8vVQhkfBOa94Q3FxuR7tKqRRyFhuIolHGuYzTUK7KLhtR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714730212; c=relaxed/simple;
	bh=+9U3DQvT+Pju05MkyfgjV7Sp8n1yKy8b8ChMhCnC6F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnEQlHa0qHoJQw7oDXYJnk5msUYKE/q3qoquE01WGCHJRx1ZuyWth+8SNykZSjxe15Zq3Irw645X/fgUDeD24P2GkqH6/R/0c7KEDjC3dYIUWw9oyWeM7Nl6d/YlOGQ7/Jz7seEO8ridA1Tth4GQOhNmNRDMLhLjalAw68SV4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hl3/4HX5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0dLcvad; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hl3/4HX5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0dLcvad"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 067B31800137;
	Fri,  3 May 2024 05:56:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 03 May 2024 05:56:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714730209; x=1714816609; bh=2tjCFY5VRp
	SyCzTR3kEnvxi9Up7DyGJsFuwOjMEEID4=; b=Hl3/4HX5LJgszE3c2YeUYPl3Jz
	UIcGh0opW/sdaRFftIA18z94/YyxBhxFjDFHodObAv3gOD5hIVj6jTlcyz4EyXqH
	02QZzkW7QRskP8491+im/zodLVsxXp2XntqooBLL687i0ZazDPwh3ECNjmtK0DY9
	Btc8K60gIHnHZw7a0jXq3a602GKQnYKWgV9wuMjCfEFvK5YE/b/KrG+7/aZmnjhM
	Ylgh/faDmw83JckaNM6CiRaTovwbDjzCbTwZSGajqNoRxoDpRPI6GYlAuFz2Y3Bu
	SG5o1UkVzO8Y6HQeDr80RrbA/15jW1fp2/vJIvaDFD4pWgRt6Rp7o+/wFr5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714730209; x=1714816609; bh=2tjCFY5VRpSyCzTR3kEnvxi9Up7D
	yGJsFuwOjMEEID4=; b=B0dLcvadMHMBTQiw9VKS40h2uqZsuj9yBNCVB4r7hNs/
	oQDG4kaAY8FtujHVDWeBq376ESAzzRB1Zxd6lD+GqWvJ1hSxVepa5ovNkX5hZkKT
	1iJT+wwBlmFDixevCx7vHGH9B47zytLKUG4zQmMpfqfEl7059EJyX89Hg3n1OkVs
	PU2Myu3PltE+Dmno2VoLNUaX4YIVJSUpzFHoNauhlCn953R/O5HVbEh9PVD/1ef/
	cC+xPH6w646PfoOCd+HgtnCOFMyOXYZCMboe+BwOsEukINZ3C9wacYia7Yyuc8El
	YsaEdjPtYa0oNoulcXQjPPVDhGM+xOxJFwmRc6jXQw==
X-ME-Sender: <xms:4bQ0Zo0qglj_wjXFUGMmfQpc3TK29uEBY9fxL66DSa00eaLENcMhsQ>
    <xme:4bQ0ZjHomGmYc1AeNd1pcK6oP5RifrIZDg_H_FQMqFqOOiBhHQa6DUQ_AIHs_RnSu
    PFaG89z-LttvUa5Og>
X-ME-Received: <xmr:4bQ0Zg47Q9nkRH4UfKt3bWYg3UlTiBgAgXhGN1QmD6Ob7SDawhvjCxPyi9GUfP04pw_peEtDnhdT6HhTLnya5hVUeMwUWceSApZRmBJuCWD_RUqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4bQ0Zh0lesJ7NDhtA-H41jsZoiz2ZpZssBm-_t8zNN1oKEj_bDPluQ>
    <xmx:4bQ0ZrGfWSR3V_bO8owI5R7TjDlN_tzJ8PSuD5LvOqZsrmUK0U9jZA>
    <xmx:4bQ0Zq-gtDXWsv1IyfPIz9JXcy_0wlwLyjaHp2b1Ri4aoTPAHALaKg>
    <xmx:4bQ0Zgk2N3wNrnW9_wRRFtE7X2dEQNQC8ix1BL_9v24xAMzzoZA6KA>
    <xmx:4bQ0Zg5Ns1AaXHdVUtAVtUInBRH2SUpOQTDAEDYpBUsxulgeyYOA2IWR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 May 2024 05:56:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 847dcd60 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 May 2024 09:56:19 +0000 (UTC)
Date: Fri, 3 May 2024 11:56:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 01/14] config: clarify memory ownership when preparing
 comment strings
Message-ID: <3aa26d5bff21e0b93736b1502fa90694f6b2cedc.1714730169.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1714730169.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EAMJVtW+IomQwSQ0"
Content-Disposition: inline
In-Reply-To: <cover.1714730169.git.ps@pks.im>


--EAMJVtW+IomQwSQ0
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


--EAMJVtW+IomQwSQ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY0tNwACgkQVbJhu7ck
PpSqpA/9HJmmPUCqubJFbCbLTqBcM9+Hf8sRjr5e8XMDUngC6L3BAxjForfQKBam
vldDo6jv0KV4LfSlFT6V1yVVFNABnnF7F71CXgs9lhPtdx66SgC6FZ/vPnhmpfEO
/vfONq4YsILAFiEy6xebqWRP496UwedLfWxYI5LXKPavG0CF6j0jwKCUXXSXrHvn
af5MmWLEPNOuZ5414WRPa8GVwaU29t/dkPCxSKE8CXQ3hacmtrSb3rZ13fKzIy//
uFqlc30w74k0pBVn6J80aR8CCs1eiW9aLK+tbmrehiNeLmcKBcIbupJVjNbRHptS
JQQXg9exBZl3CN7b2CDybKAF7wqjVyupEExvIIz53YZsxN2W6NALPp6oLW8GO8mQ
PDZonBFNAHyiV5r/c3FZ1SymS8MEwFXTonB4IJxIAN92GHkSXykBTTfwZcgCxy7z
buI4LqCdhMu8aMgQkTmGv5lVhw3GUPBpfhVDFqnHw+oe9jTkkFAQ5E9T0gU7dgSl
cF6zZTlwtGO2/l7VelTd+dX1KqbhyVSGYEoD0venGe6EQe7pL2ej1fWPO5nJK3gg
Nzpt88YzTAXfd8jXlboyBZUCoLXGk61051cAM/NCB7r0lqcBDIqwJ1+tRSz2dB2V
z9FYPmd0n6qG7U6OwYFj0SPHQWxB5mRaGiMcgAy0pshpmUEeIdk=
=vUAz
-----END PGP SIGNATURE-----

--EAMJVtW+IomQwSQ0--
