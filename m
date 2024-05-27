Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A5813A3EF
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810386; cv=none; b=pmyyBDo+CrJufiNC51Pigns2997+L/kzpCMq1F5qCxs9EailqWzhd9kYlKb9AB59tzA+ir7+hVa4Di9kfWKfhEwmZM+kMa+H1X5DdcKwwa8bD4tjTu26DwVlEw4XpDOQIS2WIY/ew1byabYGfSX68Syu6unVb8EnuS0JVl5Tq3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810386; c=relaxed/simple;
	bh=IPKzTR3RZuOFOq1tOt6lH3EazSlyNP2lidJIBoRVG6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOPxUc5mBsjMTa3oaJxaidKA52awg6NxxfbWVDQ/R3E80we52ouQPSVDQr0wBz8AfhYEXcda+voSNjqbY2RNtUqxOfKAwc5AUNsFazK5GpauxuCmd6Jl3PvUWh4IYJNQMhoPLpJpivip2dVpPApzEMCzszaXz9isdOQ34ct9EbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DS7f1xwC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1AvKg+7; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DS7f1xwC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1AvKg+7"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 5FDFB1C000F5;
	Mon, 27 May 2024 07:46:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 May 2024 07:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810384; x=1716896784; bh=yixZoB7gM6
	J56z3hBunB92hAaEqzE2n0rF+bucD87Zc=; b=DS7f1xwC1vgdKG8CPILesIfQL1
	sLiDNgMYino0XCVV9SjeHnXIiJ80Fi5UNDPDKgbphdXlhLLplFVjSwfQAlOBk00P
	PpyPqCuNqM9EQUTNxxzEpjOFRtnMg0ICda7IXsEX4ec2vG0HlkOZdPXpva37dETP
	NskD5lQ5AI8FU9xXjtxg2aADBVUqn5JMywbd4cSlIJRoy5E1iNsrlCAj91l5M6bo
	4/Jm1PbvwbWr9yIK72wQWJMEHw5EhmPDPTF8Gm4PV+bXwZlGHYNTiBje6dkPkoF1
	vXav8NN+MdoRP4Z9a0XdjslZJi3U2vavfampCosLp6pxvrpXgXlOVKvaRbLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810384; x=1716896784; bh=yixZoB7gM6J56z3hBunB92hAaEqz
	E2n0rF+bucD87Zc=; b=g1AvKg+7jCbkaW3QW4/S105rzdFaotbOasr3Vi1T9VgX
	sVZtQGC5crdF18H9b+eT/k6RYetIfSCuWk1NL7blWqHQUXoIcwBy1MS5ruMOKehN
	sRXN+2dxkWBzM3mzk9LkqopxLlpiON/j0/wfNg0njQRaLUCmFEHUecO31oVvz2fr
	uYlvCXzhwRzKFCnKVAdawKrwZJGHR38ogIvISX93zgDZpLJ6HLYUYHUd+lsjqI8Y
	ye2WSsacMZp/uccG2RVVtq2nKGYZEmE4qcNwYAqMgMsKULXhGDdza+styI+4Lv2w
	fhfmkQhtLM4D6mUYU9396HkEiayp1Dvri3QCKpAwRw==
X-ME-Sender: <xms:j3JUZsGRa0PD7QEBydTrVU1ZpZZOhA674H_fL6rrn-FBL4Ga8EbI_g>
    <xme:j3JUZlWRol2bX2c8HhmHV0H0htDUVcJP3mfdEL-vojK21p99uisuPiThN4kA5xrPj
    Y7lr7QEW43MbFOz2A>
X-ME-Received: <xmr:j3JUZmKXhpT1YCxHCU_1gqKU_tBtQAwHhlSCfJoazRFzqWpWofNDAf5fEhJ0HcHZRoDMYgRCbselkecpO1e0UE8aTDUPKzUdtTLsO-cex8GCaV5br7U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:j3JUZuHsi_htgQxhYACu70IOcKfDUS5jYkEaoeUJA3iwqY3q8UB8QA>
    <xmx:j3JUZiXGFUQAUFyS240jKfwP2Rhz-Zp4SV_OLb8yLr5b6WoR8CxY1Q>
    <xmx:j3JUZhM4Tc4r6jUoEyuI4hLlGibml3ET7NSXsop8F0J3xM25nM4fXA>
    <xmx:j3JUZp2DY9VugVS5lrfeqdigTSfB8PALFLtZjDB11nzAcXI4hb_SSA>
    <xmx:kHJUZkeYDkbq7Z_Bic65r163K8E-fTJ2oR5Ly13lZwNoYV8lJe85aQtm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19659ec5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:12 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 08/21] diff: refactor code to clarify memory ownership of
 prefixes
Message-ID: <feec7e971f04b0f8c8da429f9bf58db745b99112.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t7luNXNB9yahjHTQ"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--t7luNXNB9yahjHTQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The source and destination prefixes are tracked in a `const char *`
array, but may at times contain allocated strings. The result is that
those strings may be leaking because we never free them.

Refactor the code to always store allocated strings in those variables,
freeing them as required. This requires us to handle the default values
a bit different compared to before. But given that there is only a
single callsite where we use the variables to `struct diff_options` it's
easy to handle the defaults there.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diff.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 902df9286a..679ef472f4 100644
--- a/diff.c
+++ b/diff.c
@@ -62,8 +62,8 @@ static char *diff_order_file_cfg;
 int diff_auto_refresh_index =3D 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
-static const char *diff_src_prefix =3D "a/";
-static const char *diff_dst_prefix =3D "b/";
+static char *diff_src_prefix;
+static char *diff_dst_prefix;
 static int diff_relative;
 static int diff_stat_name_width;
 static int diff_stat_graph_width;
@@ -411,10 +411,12 @@ int git_diff_ui_config(const char *var, const char *v=
alue,
 		return 0;
 	}
 	if (!strcmp(var, "diff.srcprefix")) {
-		return git_config_string(&diff_src_prefix, var, value);
+		FREE_AND_NULL(diff_src_prefix);
+		return git_config_string((const char **) &diff_src_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.dstprefix")) {
-		return git_config_string(&diff_dst_prefix, var, value);
+		FREE_AND_NULL(diff_dst_prefix);
+		return git_config_string((const char **) &diff_dst_prefix, var, value);
 	}
 	if (!strcmp(var, "diff.relative")) {
 		diff_relative =3D git_config_bool(var, value);
@@ -3433,8 +3435,8 @@ void diff_set_noprefix(struct diff_options *options)
=20
 void diff_set_default_prefix(struct diff_options *options)
 {
-	options->a_prefix =3D diff_src_prefix;
-	options->b_prefix =3D diff_dst_prefix;
+	options->a_prefix =3D diff_src_prefix ? diff_src_prefix : "a/";
+	options->b_prefix =3D diff_dst_prefix ? diff_dst_prefix : "b/";
 }
=20
 struct userdiff_driver *get_textconv(struct repository *r,
@@ -5371,8 +5373,8 @@ static int diff_opt_default_prefix(const struct optio=
n *opt,
=20
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(optarg);
-	diff_src_prefix =3D "a/";
-	diff_dst_prefix =3D "b/";
+	FREE_AND_NULL(diff_src_prefix);
+	FREE_AND_NULL(diff_dst_prefix);
 	diff_set_default_prefix(options);
 	return 0;
 }
--=20
2.45.1.246.gb9cfe4845c.dirty


--t7luNXNB9yahjHTQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcosACgkQVbJhu7ck
PpTgvRAAjt9GKgr0Zve6cWjunc48JfK+FN/cZ+Gu6X3JE+DBgsn08y/tZbimoYyd
Smhfkpl9JaVfziK4jxn4z4Jx7vDqSSEsWwWfDkQJOsXcGIL36AdPBxGyfpf5CsAK
plU+CYAtbLykqFlytBHF5fMcqSJ8YcAGjOq5uB9V73vMxNl5lG3i3OsykB1ypz8l
jvNoFESHX1AFHjFjT9F+Wm1VZyWVpxcqpmcpPKMOz2m7wndglxszaOBBIMk73nrU
jYpgnb0n/uQLGMt+foMVhysdMCqjsCSYM8NvpWpVOEnlFTl4z6FbsXqBHEy4lZ9X
EiM5+BEYA4n/AAv3toi4mH6a5zv8hzUP5FUZA+bfAf/eGmQFd/RXj7lmC3e+4I1p
IBWWrMS5qUOl4hKX7YBjgCsxpZcZCOy6apy5Zyvo+ibMwxApLpiMt94sFlRPDXmI
iIJO9grc1UrbxlrcP3mECnkuVRacAowFXkQ49kaxOPe/TkhHzX7hgYFkSTel0LH3
mkxCosWwfSZLTSojriExFkSKlUjBEWWiModlu4OAo2KpVHafwD0uzsK1GYYGfKJB
SpBirHYmW+kXDb5+ogyfXmOAmfH4pXSr35mXMM9y7+/UAmb4I8JQkRWDsz4xyDHv
NKWwEpVyohUJ3+NY74YQ4aCLRRM5teM3xdGUTJR3/X37/ptWgJE=
=F72N
-----END PGP SIGNATURE-----

--t7luNXNB9yahjHTQ--
