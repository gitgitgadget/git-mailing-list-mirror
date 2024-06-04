Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD83E1474D4
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504731; cv=none; b=XU+IEbyJhtNSwlR8fKfUoZRqfretpdwIoQhFZuGSzIymXD2RiZXTmSBejK2IRxikC04tNcTPNXgw0gfsPOdqJye7uGeaEFtoCLaK3/OHRHLt51hdaycMBKSaUpFZmiIMFBn82YWf7w/jVBDUiULSYGoxUJ60eDj4J9p2Z7Zk1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504731; c=relaxed/simple;
	bh=/QEg8vv6a8dtLA5RxuFUT9OI6D2DWPIowYG0N3EYTyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lsQ6W343dICn84DMMypoWApNz7/4k4yjFiGI7VYA/DWVv0BaMbibXoY5lxym/PqoAC/N9n4jlQikmKgdBH2XhSze7LT6nvKqRrNffzZ1oR9DHMxb39GHcbG7wXYyPS22cVKzlXtm6MNzA79vRDCkXPGHC4qYbov0fJq0QbI0YSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HQvkikkl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pXiuNczt; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HQvkikkl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXiuNczt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 089191380157;
	Tue,  4 Jun 2024 08:38:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504729; x=1717591129; bh=h+jZ+lJ2yu
	COZce18nC2xoeqtiULWyw6soRz8b053yU=; b=HQvkikklpSOuo3C6+XRqxlVmtx
	5XflIpkdHIYQJXsiSWjDmTXcCjVr9c+SuKmKRcPzCjuYXTTt4k6ml4KhuHlV2h+d
	n1aliv45zqa1a5MOV1TnY7MRTQqkrtexWvHQ3bUpT4x08JL3UmXJOEzRAYcoCfQz
	AEAYl90ZoU7cufkbu6FVuFTAHOH2GH9/ldl8zBpmSoBUMO3PkTaB5McZISgyzjio
	Oxzad4HLOgOjdbyn4K29o2Mdl+mPvSb7ti/zHvGGpEPqegFrh+H+t2YL8Y/Mo6Gl
	/YRW0kLQItm+0EFN1bw/C6qE6v30I6chhi66QF1WJV3/gxiPkus3P5F0XTlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504729; x=1717591129; bh=h+jZ+lJ2yuCOZce18nC2xoeqtiUL
	Wyw6soRz8b053yU=; b=pXiuNczt4Pp+Pw/3Hiz2A7J3zgAuJzlvMJcDlej2JFme
	jsP4fLDH9u9KVcQEkTCKGe19PTYO+NIcY5LAKRDEog8YcC56VCHi+iN5CphE7fHz
	B+bjl+Z63XTl7uzPXEzoQZCoCAEBcsi5SWhICLb4Py6Dhm14gP0uiXefXEJFeCRY
	TeOqlcQ+yswd+kPUXmjjoS2XZ88xFzWu2YT3STIUAwAlOG5li6Q0/oFSp/3F3SLQ
	AvNCb4xd3gEzi3IpA/bfFLaHV38cR6U95GmamMHzns/Ev1Q0B5WmLKAzOoNudFIO
	2KJV28cYws3kspdH4HugjT70hxKaGZsN215CXWRR9g==
X-ME-Sender: <xms:2ApfZiT4eq2_hDx2D2KLTb_TZFDJDUfsIpzgQns3Awfdj7O8BAP_KA>
    <xme:2ApfZnwbcplzLgQuOQMVbNcoXK0xLSA4ItTVBriiIeWckNt6ZRTXGPI58B-Rqhywk
    T7vd5n_I5GApEhXtw>
X-ME-Received: <xmr:2ApfZv1z9698YjMm8ui640ERBmfaU0QC6W_0Qm-DtOf7-ic6OKaP1QmOAryc1--MszX_wDNz39DsKknW0RZeSZDPfhAGgpdwy-KDUZL6EE0DHSL1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2ApfZuAcsdah5v51qoiG_E-8KPLXVgJNNJTRw_P55sPTgMYVHZYogQ>
    <xmx:2ApfZrhPHqQIVE2clKFnxRfxzRcY-oJKh2tsSAP9DpJ5GO1UkIzhgg>
    <xmx:2ApfZqrdDavffwrFvdl1yYp2RVBY526JausNNOavrEiiLBa2yUzMHw>
    <xmx:2ApfZuiuY4GXVmwWPnd413DDfnOMslEfQe-G8AnjflFxswexrqRrkQ>
    <xmx:2QpfZrcy9Uu7TpPNzhjW2pt78muiwM9i0gFNqRLfTxC9hnQxu1JSRvc6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:47 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 23e3498e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:20 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 23/27] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <9ccafd286b3d15ccf6da83b9d2c0cba26672f35f.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yCmW0t7gtC+XHcof"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--yCmW0t7gtC+XHcof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free any of the config strings that we populate into the
`struct imap_server_conf`. Fix this by creating a common exit path where
we can free resources.

While at it, drop the unused member `imap_server_conf::name`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 imap-send.c | 65 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 67a7a6c456..da3e7ec17e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -69,7 +69,6 @@ static void imap_warn(const char *, ...);
 static char *next_arg(char **);
=20
 struct imap_server_conf {
-	const char *name;
 	char *tunnel;
 	char *host;
 	int port;
@@ -1300,23 +1299,28 @@ static int git_imap_config(const char *var, const c=
har *val,
 {
 	struct imap_server_conf *cfg =3D cb;
=20
-	if (!strcmp("imap.sslverify", var))
+	if (!strcmp("imap.sslverify", var)) {
 		cfg->ssl_verify =3D git_config_bool(var, val);
-	else if (!strcmp("imap.preformattedhtml", var))
+	} else if (!strcmp("imap.preformattedhtml", var)) {
 		cfg->use_html =3D git_config_bool(var, val);
-	else if (!strcmp("imap.folder", var))
+	} else if (!strcmp("imap.folder", var)) {
+		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
-	else if (!strcmp("imap.user", var))
+	} else if (!strcmp("imap.user", var)) {
+		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->user, var, val);
-	else if (!strcmp("imap.pass", var))
+	} else if (!strcmp("imap.pass", var)) {
+		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->pass, var, val);
-	else if (!strcmp("imap.tunnel", var))
+	} else if (!strcmp("imap.tunnel", var)) {
+		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->tunnel, var, val);
-	else if (!strcmp("imap.authmethod", var))
+	} else if (!strcmp("imap.authmethod", var)) {
+		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->auth_method, var, val);
-	else if (!strcmp("imap.port", var))
+	} else if (!strcmp("imap.port", var)) {
 		cfg->port =3D git_config_int(var, val, ctx->kvi);
-	else if (!strcmp("imap.host", var)) {
+	} else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			return config_error_nonbool(var);
 		} else {
@@ -1330,8 +1334,9 @@ static int git_imap_config(const char *var, const cha=
r *val,
 				val +=3D 2;
 			cfg->host =3D xstrdup(val);
 		}
-	} else
+	} else {
 		return git_default_config(var, val, ctx, cb);
+	}
=20
 	return 0;
 }
@@ -1503,6 +1508,7 @@ int cmd_main(int argc, const char **argv)
 	struct strbuf all_msgs =3D STRBUF_INIT;
 	int total;
 	int nongit_ok;
+	int ret;
=20
 	setup_git_directory_gently(&nongit_ok);
 	git_config(git_imap_config, &server);
@@ -1529,42 +1535,55 @@ int cmd_main(int argc, const char **argv)
=20
 	if (!server.folder) {
 		fprintf(stderr, "no imap store specified\n");
-		return 1;
+		ret =3D 1;
+		goto out;
 	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no imap host specified\n");
-			return 1;
+			ret =3D 1;
+			goto out;
 		}
-		server.host =3D "tunnel";
+		server.host =3D xstrdup("tunnel");
 	}
=20
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
-		return 1;
+		ret =3D 1;
+		goto out;
 	}
=20
 	if (all_msgs.len =3D=3D 0) {
 		fprintf(stderr, "nothing to send\n");
-		return 1;
+		ret =3D 1;
+		goto out;
 	}
=20
 	total =3D count_messages(&all_msgs);
 	if (!total) {
 		fprintf(stderr, "no messages to send\n");
-		return 1;
+		ret =3D 1;
+		goto out;
 	}
=20
 	/* write it to the imap server */
=20
 	if (server.tunnel)
-		return append_msgs_to_imap(&server, &all_msgs, total);
-
+		ret =3D append_msgs_to_imap(&server, &all_msgs, total);
 #ifdef USE_CURL_FOR_IMAP_SEND
-	if (use_curl)
-		return curl_append_msgs_to_imap(&server, &all_msgs, total);
+	else if (use_curl)
+		ret =3D curl_append_msgs_to_imap(&server, &all_msgs, total);
 #endif
-
-	return append_msgs_to_imap(&server, &all_msgs, total);
+	else
+		ret =3D append_msgs_to_imap(&server, &all_msgs, total);
+
+out:
+	free(server.tunnel);
+	free(server.host);
+	free(server.folder);
+	free(server.user);
+	free(server.pass);
+	free(server.auth_method);
+	return ret;
 }
--=20
2.45.1.410.g58bac47f8e.dirty


--yCmW0t7gtC+XHcof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCtMACgkQVbJhu7ck
PpTzAA/+K2TZHh4mbVjwdx6eIXZlmfIfjWJiRRaHbFGt9FZTc6I5kJ5Mmsxzzusr
ph4GgqjGdsdog309z6Eu5ma/6X5+uhyxjCs4lUG5jZ7BTBf2nsGUIvw1DdBwMuWi
xSharMmEG6x96udNVC0j48yYfh7bbJdtixxUngO4FfLwuwZI9M7ikOZgZxRQseQG
r3OhRAmYDm1ihU7Q15TYewqcSZ3RqXl2y1z1vslcmj8x7btFvE72pukmetAYDoV2
+8Ttl0+AVicr9wgNxEzmDz8THLdnDC+4CVrKohoABsrCv6XoqHKilk2KXkeGXE2l
BFHN6CObk/o8ra/PRVgHtl14DeTbDM6rAwS5DpoRMIvGNxHXQXKh63FqskROXTFY
0/6w43CV57quJ1r10aoyLFgpzhewOMjap4nzkKwj30QWSWhVHKO+KRvhtkEJpXS0
xxyif7gqORZHvj2AauYO3mx9tXnFklgnuyvrRgetXFEvLPIPgyvwoHPyslrQp3yl
3ogezu+vlipbeHPm0FfJaUIEq5L7nU2+NOJQw0ZqglpsrIPcllaCu10gRVil4yVe
UnwKpKazJzeV/sTvDl2OJOJ3sNleozfak/9ipVkfSVfTi54IEIsJ+KuuEzbgpHPa
ixrK7yKdO7fjF6QF5qFzEE6gRECcvJ1wqmFIve+Eu2WzKaoMjJs=
=fyoi
-----END PGP SIGNATURE-----

--yCmW0t7gtC+XHcof--
