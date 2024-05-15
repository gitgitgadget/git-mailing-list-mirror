Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7308D4879B
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755397; cv=none; b=aiV/lkTj1KvJOVIEl2ZJ4sVHkkMBPdNH+YYiZZM6BfQRz+7ZNBTbNxpH8k+WuPymDBsggX2LTwmT6HDaY3Lf9yvOZTXYcqwi35Kck0xq06cfkchrc202Up1xELnSa6DF10205M1fpgmCU0Rpp0FU71QM035CQ2QvBXxwFX1uTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755397; c=relaxed/simple;
	bh=YLCGG69oNerK5GkXKbJZfxJSRZzjHz3wXtJJdJKieAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGtc9KXDbD2n/rGtxRljMNLXQtMj55u1DY5mNq2JlCuR6x2uH3lt9STyv9Wqo6be7T8yKck52SVM1GO6ZNK2P7RmbRXuzpqcjcQwlyDXgrwi5j3X78zVu82zO/alWgnn8y+0O0vd/8CCa7ELgeQCy3mh5ilRKYR6ePyh0nql9Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/TIi2I9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vfv4cNp6; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/TIi2I9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vfv4cNp6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id B8FD01380278;
	Wed, 15 May 2024 02:43:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 15 May 2024 02:43:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755395; x=1715841795; bh=zXlaXT/CdV
	jpQpkSPamKGNLknER9KmW1aAHklEknXSs=; b=M/TIi2I9LFpzIy8XRKOsBu5SiP
	qUWNqUhNwsqw80cOvylOGtwIbTiOmy+/Z0HrG6izXQPqEglKJREtaDwnFp+mZ2qT
	5xMJ9bxx9FsnJchqd0VeYCo57t/FqQI1EnwGzdPos3OJBKbJ7TFTgSkTZRgYPr93
	By8F9jwuypGcE85FZUmblgKUazY64hsTbf4kvFnXE9sY9CF0/cSc3xOSEfBFt1Qj
	/b1Ek1tGkZFBmnETqN5YJTLtMVAuse/Xsfm1EnSHfZvdjBAQk1mSX55mLDz8iIYl
	OBvN1/nKkCJIlZW0ljSM7a/1du1qHTN+SHp+koZFIpMyIDEqhH0/kH45UxNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755395; x=1715841795; bh=zXlaXT/CdVjpQpkSPamKGNLknER9
	KmW1aAHklEknXSs=; b=Vfv4cNp68r/UhJ7CRoifMu4wk71jYiGOTYnklG5ujrxP
	ac4p2ryj8x/92Tl9HpUgCiV4L4iKEJaKgDfJveICERe3uJjYqH3cmO8LvBfMZrf2
	yMkCOqPBZmFzH3lhc5+4AyGGZR8wpb0CgQfb6/BZsT34r5qgTR9vOqPaxtG+NLmr
	ciTgSDm8BKqMDGtQp5Id/oR2yX+CNDXNqssheLYCBoRa1VMukvsTMLvoNoEu2LIx
	/9i1atZgC807qVjR/jGq3EWhtj8Jalp5FiorZVF3w2dCdvmbyvPrVNu3JTvxbbUQ
	eDj3rznOSPDE6sIS9lG2NdLW2gUgGVMcOJicettIwA==
X-ME-Sender: <xms:g1lEZqONmq_moiQMMgXkzAdUIGrxzMTSj6aP1IjYlUHHnMdLH4sq7g>
    <xme:g1lEZo_cSNTfnfEcl0CiODY8S4kcoFjWdisswEutte979tRx29Mv-dZW1rGYDndB6
    SuIewkm7WAHkqSnfw>
X-ME-Received: <xmr:g1lEZhS7YibbaxPzMZBRoCdiCVLmRYCtQxo1r7UGM9QocFxinGbtv7e3PBDKMWDcdOCdRaH-7fP5H59Zhzy43Du3X5yUYzqiOkZJ_riWfuIaac64>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:g1lEZqsLcR9h78TeOp44lCYbVYoZ91p90fi5w_3fwg7FOAessCiUFw>
    <xmx:g1lEZidehTtREBCGGn5zMTH18ZE6JEWoiQQaywS4x4CJBq7yEykILw>
    <xmx:g1lEZu28OklhtLtCk8ffwA8W74uPJLdN2kRE8BgQruVUiZNNqnfgVA>
    <xmx:g1lEZm_w2BYnRU2GnsHux5trAQQu__lAtMaElxTYJKXXMrixBHvrDw>
    <xmx:g1lEZh5-SLXmj5YzTZqKKbHHpJAZiT713kng9lu8i7TMAeTtA1B6zvW3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:43:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8c1f9035 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:51 +0000 (UTC)
Date: Wed, 15 May 2024 08:43:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 21/21] builtin/config: pass data between callbacks via
 local variables
Message-ID: <a5cb075fcd5ff3ec3da1cc299caae7c3c24dfedb.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKPqMKAyxG8GyBvp"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--gKPqMKAyxG8GyBvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use several global variables to pass data between callers and
callbacks in `get_color()` and `get_colorbool()`. Convert those to use
callback data structures instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3b588df8cf..c38264c999 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -518,21 +518,24 @@ static char *normalize_value(const char *key, const c=
har *value,
 	BUG("cannot normalize type %d", type);
 }
=20
-static int get_color_found;
-static const char *get_color_slot;
-static const char *get_colorbool_slot;
-static char parsed_color[COLOR_MAXLEN];
+struct get_color_config_data {
+	int get_color_found;
+	const char *get_color_slot;
+	char parsed_color[COLOR_MAXLEN];
+};
=20
 static int git_get_color_config(const char *var, const char *value,
 				const struct config_context *ctx UNUSED,
-				void *cb UNUSED)
+				void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	struct get_color_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_color_slot)) {
 		if (!value)
 			config_error_nonbool(var);
-		if (color_parse(value, parsed_color) < 0)
+		if (color_parse(value, data->parsed_color) < 0)
 			return -1;
-		get_color_found =3D 1;
+		data->get_color_found =3D 1;
 	}
 	return 0;
 }
@@ -540,66 +543,77 @@ static int git_get_color_config(const char *var, cons=
t char *value,
 static void get_color(const struct config_location_options *opts,
 		      const char *var, const char *def_color)
 {
-	get_color_slot =3D var;
-	get_color_found =3D 0;
-	parsed_color[0] =3D '\0';
-	config_with_options(git_get_color_config, NULL,
+	struct get_color_config_data data =3D {
+		.get_color_slot =3D var,
+		.parsed_color[0] =3D '\0',
+	};
+
+	config_with_options(git_get_color_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!get_color_found && def_color) {
-		if (color_parse(def_color, parsed_color) < 0)
+	if (!data.get_color_found && def_color) {
+		if (color_parse(def_color, data.parsed_color) < 0)
 			die(_("unable to parse default color value"));
 	}
=20
-	fputs(parsed_color, stdout);
+	fputs(data.parsed_color, stdout);
 }
=20
-static int get_colorbool_found;
-static int get_diff_color_found;
-static int get_color_ui_found;
+struct get_colorbool_config_data {
+	int get_colorbool_found;
+	int get_diff_color_found;
+	int get_color_ui_found;
+	const char *get_colorbool_slot;
+};
+
 static int git_get_colorbool_config(const char *var, const char *value,
 				    const struct config_context *ctx UNUSED,
-				    void *data UNUSED)
+				    void *cb)
 {
-	if (!strcmp(var, get_colorbool_slot))
-		get_colorbool_found =3D git_config_colorbool(var, value);
+	struct get_colorbool_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_colorbool_slot))
+		data->get_colorbool_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "diff.color"))
-		get_diff_color_found =3D git_config_colorbool(var, value);
+		data->get_diff_color_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.ui"))
-		get_color_ui_found =3D git_config_colorbool(var, value);
+		data->get_color_ui_found =3D git_config_colorbool(var, value);
 	return 0;
 }
=20
 static int get_colorbool(const struct config_location_options *opts,
 			 const char *var, int print)
 {
-	get_colorbool_slot =3D var;
-	get_colorbool_found =3D -1;
-	get_diff_color_found =3D -1;
-	get_color_ui_found =3D -1;
-	config_with_options(git_get_colorbool_config, NULL,
+	struct get_colorbool_config_data data =3D {
+		.get_colorbool_slot =3D var,
+		.get_colorbool_found =3D -1,
+		.get_diff_color_found =3D -1,
+		.get_color_ui_found =3D -1,
+	};
+
+	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (get_colorbool_found < 0) {
-		if (!strcmp(get_colorbool_slot, "color.diff"))
-			get_colorbool_found =3D get_diff_color_found;
-		if (get_colorbool_found < 0)
-			get_colorbool_found =3D get_color_ui_found;
+	if (data.get_colorbool_found < 0) {
+		if (!strcmp(data.get_colorbool_slot, "color.diff"))
+			data.get_colorbool_found =3D data.get_diff_color_found;
+		if (data.get_colorbool_found < 0)
+			data.get_colorbool_found =3D data.get_color_ui_found;
 	}
=20
-	if (get_colorbool_found < 0)
+	if (data.get_colorbool_found < 0)
 		/* default value if none found in config */
-		get_colorbool_found =3D GIT_COLOR_AUTO;
+		data.get_colorbool_found =3D GIT_COLOR_AUTO;
=20
-	get_colorbool_found =3D want_color(get_colorbool_found);
+	data.get_colorbool_found =3D want_color(data.get_colorbool_found);
=20
 	if (print) {
-		printf("%s\n", get_colorbool_found ? "true" : "false");
+		printf("%s\n", data.get_colorbool_found ? "true" : "false");
 		return 0;
 	} else
-		return get_colorbool_found ? 0 : 1;
+		return data.get_colorbool_found ? 0 : 1;
 }
=20
 static void check_write(const struct git_config_source *source)
--=20
2.45.GIT


--gKPqMKAyxG8GyBvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWX8ACgkQVbJhu7ck
PpSVOw/9G2ybpJGy3YYt60ucg30qKRjp5akskCqRf7j7CH/hVTa6VnaBqhwKBq58
uKMkJNjHF+P7BYhDOPpTievM39QAZ7EdAiaE35BTJ5V+Jn891WgfkNE4I/iP5wwD
j6wHmwcD5tVh0KJawFdccV+IuyHyBHJlPpjvMVoGdq2m9LdkDsvRsQQR7uj37SCL
08vm7m9M3nUf1bvB4xehgF5hVH/7GudgWYJ48oil3b/GZBQCHg8QcEYsrA/lBXT2
GSTVnyv2jm7/cfcf8J5m+1OGIhr0Ew9alHzsI80W0TdgfkdEc1ZGaJBxsuyORra9
vcbJLUpbMfj5ESbgS7+P9xcWGar//UZEb141pfR0YFf2GNovHDnxwd5u/RZ4LcEh
Oog+FgN2FqPuEhK0wrLLRJzBGBTQOtNs1broUR9Yps7ljP4Ia1h3rrqiINb8srFl
pAcab0YWLj9VEdXCfPmdOrnZFjv1+heiFYVsv5SmHdnTP0zXa+hdKB6vfq8igLGY
Vcz7KyBTKTzH2xSc0j+7EoTXjvH+SJlq7+vHkesXKfW9uWIHTERQ4LOpkruUi8J/
reA5XPW6wAkE6rWUG2ybI3LL66GWRhogYkNonePTM11ppg88TKo91TT0k8nFiJ+w
FIaWeoBjY8yAaX64EKyMNvyNQTUJbTs8TPA6PXX8Y4JjLqC5QSE=
=7nYI
-----END PGP SIGNATURE-----

--gKPqMKAyxG8GyBvp--
