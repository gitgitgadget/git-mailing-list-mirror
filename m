Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95DC3EA95
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755365; cv=none; b=dbmte0Mc63GBOyYDfpr4ieEhQe23GLDQmlXAW1moMJRPlAGXOgD/N3k/rLiDHR1Yo9mkWTXIgCe7Ahct8G4ZSTTVCixS1eMmO1DejUHdwy97mSzrweLTkIgipoqWNjxAwBEPNGZDBRBG0utgtbHfgAwfq/06RTquvG6vB0tdtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755365; c=relaxed/simple;
	bh=icuWIoML+DF1I7XwNnS+xm1k5XZYTtJYeAmTeOADAgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JbwwkwOq1+3y/A3LrsaOqrEHzLiyWFBLuX63/egPqLlun5Nf86TH6rBqK2XtzWvo18gJ5hJSuAyImBHdEhi1ockH57dWlYpdf1WV8rtHPEKt+vHzd0IESlEH6ZGamH/IMNsfJ+A0SJbBICN1wY5pN2HPn4gTAQN9CrjX2Dd6b5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hs5JTgZQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UsnU4m+T; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hs5JTgZQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UsnU4m+T"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F141211400AB;
	Wed, 15 May 2024 02:42:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755362; x=1715841762; bh=3HeMrH7pxa
	7qQSZmqYvSuKtTodIQjOsFgMpz7lWpOxg=; b=hs5JTgZQY/QA94KOtXWL6oCvhl
	aeQpFLNHsnRySHQ+ZgeJ0eHTYDiqqXWkUe9q4gJF675eUxX76sFivbgZyBmg6j8p
	+FfX2S9DEMNVWiy9zu9JJmsTFfi3N0DTSz69wwZRfFIKSwtuKwHK7pF3P1syqsLp
	XvXs4sduX9IK7YwP0g/H6hrlJIYHYgpP00UJdG5QZuciAe50NvBZKAPCE8hSR+4p
	zEbfvanx3U5grtNhP1yEyoI8lqMoPsWFXTFZ+WAjlx+Rn5naULYz4wkkJChpaxtU
	JVFrZ4iqAOcTk9ROEH2V/aqXPM/VglqRnAAbq12pAuweukoK9vXO7MNVtDZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755362; x=1715841762; bh=3HeMrH7pxa7qQSZmqYvSuKtTodIQ
	jOsFgMpz7lWpOxg=; b=UsnU4m+TLKxhKZk3sBfg/U+d7sQlZUv8WLecZ24O7W9k
	EKQ6PThDMSnCfUxidT0YVFI6zGHcPVqNeoBqD8C3ixaGX/tAVsG6O7ZjOdxmUqUm
	dX9rOAOO/6MkLPtqAMgCabUvXsEjw17OZLpnHt+0IVZf1Kmy0u/94cVL3MWX7jJm
	FdA+6feN08iENtSpPLjR3TEqB31G28e6AE7TcBCYjwbyxf05/SocP05+dK/Q6vpg
	n2n6RwAzqbGgi/zKQlxcS3aWamx7kRVzSiUg2uidC2T92YxkZvx/hwiqXVHGTvXt
	0gW1315VDKHb/GEMYNh84hYqN+PKm+o8I9mHJ2jpTw==
X-ME-Sender: <xms:YllEZnoyeNXOpQAZAUa3Sjl9C0WdFxoOpBERxLCC47P0i8LPGV6Iww>
    <xme:YllEZho29X3sPlvNvuujjLi-2xGb7uns37jQU3uuOATC8D_iJp1B3zmAIt8nOoPFy
    kDsraFi0u-vKSJlgA>
X-ME-Received: <xmr:YllEZkO9W1OV24iHAdCEiEp7lQ5_ED9Lz9aHF4FViRvieqHYEcB3UOA8rhmXVQ9tBBoxM0lyJWtfwgBaHRR9jMaOKHhh23bOeFgRwDpJMvGbw_uD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YllEZq4zwcI_BDpdhD2AASvLODvtXbwi9ZbjYoJWkdGY12qx5W-mFA>
    <xmx:YllEZm4ZXUWQotWSt3L6f-gQPKpdupS6gvZGwYK06J9rSsDT4dD3Vg>
    <xmx:YllEZihEy4POC42_cphEAgTJO3DoHd-MzwWoItVNL_XSpeJK4pGW_A>
    <xmx:YllEZo6GRbRQIT928NTgty7I6GtI-YeO1sNAWIVIifoy8YaZI7-ZBg>
    <xmx:YllEZh0ZAGUhbsgvbIofwu0iU0B09qVYapvHPO2vXXcoibLAEMXxE5CD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c9248efa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:19 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 14/21] builtin/config: convert `do_not_match` to a local
 variable
Message-ID: <a729286cc5ba7ae374e5293bde02cdece4f38715.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3DIgsBj4b9X9ekYN"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--3DIgsBj4b9X9ekYN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `do_not_match` variable is used by the `format_config()` callback as
an indicator whether or not the passed regular expression is negated. It
is only ever set up by its only caller, `collect_config()` and can thus
easily be moved into the `collect_config_data` structure.

Do so to remove our reliance on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index c54bdcbcdb..bc80fd293a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -129,7 +129,6 @@ static const char *value_pattern;
 static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
-static int do_not_match;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -328,6 +327,7 @@ static int format_config(const struct config_display_op=
tions *opts,
 struct collect_config_data {
 	const struct config_display_options *display_opts;
 	struct strbuf_list *values;
+	int do_not_match;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -344,7 +344,7 @@ static int collect_config(const char *key_, const char =
*value_,
 	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
 		return 0;
 	if (regexp !=3D NULL &&
-	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
+	    (data->do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, =
0)))
 		return 0;
=20
 	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
@@ -401,7 +401,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 		value_pattern =3D regex_;
 	else if (regex_) {
 		if (regex_[0] =3D=3D '!') {
-			do_not_match =3D 1;
+			data.do_not_match =3D 1;
 			regex_++;
 		}
=20
--=20
2.45.GIT


--3DIgsBj4b9X9ekYN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWV4ACgkQVbJhu7ck
PpSwUxAAk2hJRxNSAM44K3tVdd+XgnSuSFlOBLajP7wzdUvTF+712bhrt4RNKC/9
1BG3UBM2LSnaTqGG7Lo+62YOWhvlsJMOFUTkRMU1ANLxjIYsPKAJjNzMHkbo/TSG
6/n5R1y0GQh1gN1r2MlKlNBQiQjB1w9OeIRIxLizLHOs+pSkVbk/fU5k92ZsnMuK
sz+5Eho+ZUzusXKQGzVKq4KRJeZTx89bxKwAOKSgDJGH/uNz6S0mxpmSa/31EseQ
RS7KaFgDEuZ725paiQBjo2VeLJisqLHiZbZLLkG5wnAmNpM5pUC0SlcWOaoHQolm
5oQclV/OGNhrxljKaH6Ljmwk7+zs3a+9zu2mBcwn35qVI8y7HSWjovxBZzIQT5/b
GS9WIgAN7rhlGhq3aGJA+rNofiNf6QHGVMAEP69hcRD57mpWGBgwhU+MVJ8nJ8Yh
WeAazRo0iMCcz5/wyzcxXUTGtHamcknFETk8PzRRxyolcUdnYKwwSqZDobvQuZ7O
OyjEgZ8S5mJZL2ap/EBbaJQj7ecXlaE4eDwmHimulMV2wAU94XtywoiIEFugwokq
dK963tf9nGnHX0CHv+TmTl4kINKov7xT3XppEn1FU5CvzloJiGSJEJNULBAc+qsz
bg8BOjA3icl/N/BvXPmKyA2IbSrOW2p5dfJkepaVRPyaqh7bRyo=
=d8uI
-----END PGP SIGNATURE-----

--3DIgsBj4b9X9ekYN--
