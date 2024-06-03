Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6686F85639
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407652; cv=none; b=FvLBomcJTIkfdkBQoTsMgK5oIvcTl8eNdkD996eDUJ4bxIEbHO4mdwEduXwCJmT17/YDxCrnM06SGrOpYxxqW9RChsEXB9Y30BleCsJTE3vmIXrDNzBoslgIWRa8Erh4I4ZDJnm1n6GVZXKE5megAXIQSH9QbBy+bmSiMILfrJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407652; c=relaxed/simple;
	bh=20CD2wnWwUHhif/7Bg7QB8YCD/tdPYQw8pZK50IzKDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uy9lHx3v30Z/wgPWRze4mCoMuMKhhdGIyfRy++TsGz8ZXcbcukL0C/CFn0pIUIN0FXCnRudOczq5OTrSkAqvmBjjPRt6EjH3gpEB88QuNHzsTwrnIOPnFq/RL6UfOAVFV1vMIfLOgBWpBVv1E8kzj4nApU3tYfPGctr3Dk2usnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RPjG2R9T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n9Y8Svov; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RPjG2R9T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n9Y8Svov"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id B9B051C000CE;
	Mon,  3 Jun 2024 05:40:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:40:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407650; x=1717494050; bh=PC77eiZQaj
	2jO72b5OEHIrh7ZFziPhVNx/d5isAO/c0=; b=RPjG2R9TBzzvlgoiPKtvp1Gj8e
	H6TsPC6thT1jELdHPiHBVXMWrWZIil45T6CwtIjDXrMHVqNYzJ9W/QKHyI1e7wIP
	77WXZNmoUDwRjmzkrjG7G2AZbCKPMAGgMzXsUXOAxekI0o5BNtHppsQqljSjl9y2
	nMr9DT+Sh0Hc5u8ABYwijyZlD75cL8eQ2qsmjarmA8lCx8VndJ+CSql7+zv0Fs+1
	+XELna6bbxwEl0z9jwZs0aBON9sjD7f7IrrB+Khlkc76WDUJnzNeHeFi9XPZ5k+f
	DYldJbCjoFGQIlrFYn5bR39tcgG7VFK4fx0b4GyMbfVdvPskNQOvRsVBXUJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407650; x=1717494050; bh=PC77eiZQaj2jO72b5OEHIrh7ZFzi
	PhVNx/d5isAO/c0=; b=n9Y8SvovU5RcwJfdRZA3zkaN4b4mw2m58eiEECUGvBcZ
	TTYSAKRQe6/IEUlkFoE5vD71LpaZGa1qNytZmrtN3cXWK7PvMS4jH6O5N1UGSQEc
	uuLX56r2BPWpqzeT3XiNYexjmJkK6q4Qzgfh+OvpE/C3iA4XMTSiIOK0upO0lSWD
	qhbbAqsFN/BpYEgJAUZ8t+cD8r9U8e5edkBuWHJAcy5f42/dNEMoWBtoDvsPtl/q
	y4RCxJ0JJTGpRiS6VxrAPItlRgjFGud5T6GlwxcP552HNGELAmBtWyNhoWw3cTyW
	LImAMPTTzgHcqjjUmRrln3Vq7qO/u7FeyHVCBGkdVw==
X-ME-Sender: <xms:oo9dZsP9gHhsSsLL-ta3iK3T03CA5wu9fBUHBitNc1l9PPF04kDU-w>
    <xme:oo9dZi9ao4TMVF_0b0fQWgUeh1B9bfA-STfLcBP_Q-PfZzGzKlsYB7KpIuNsuVzgQ
    wOvalrEfNu3KKuMcg>
X-ME-Received: <xmr:oo9dZjT4RxlGMhB5-T1X-sQgaAyOMY2oL7R8atQB-rF17Non5gWr6Gl0imxfSDuBzWAfCgOYSdPc2loUG0OgdE1Et-vRzcZMjujaydQZxx9zDgHL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:oo9dZkvSdpk5Ox3sujFh6ZmLqhWy7-VMwu-MU3JFloGYWegw7O20sw>
    <xmx:oo9dZkew7js8AzczTJ7lVYaExQJNyiSVqiQGoYorOhxLmYG7_2v_Dw>
    <xmx:oo9dZo10W4tj3sLsh5BXO0eVY4b2QBhm_MqoCb8vob6vCVnALHi0eg>
    <xmx:oo9dZo_fQKuCy9if8_hwgy1rDG8XaxbtF1b6eIvHFHLv353G0yi-KA>
    <xmx:oo9dZs7-NhU0y9tRdgDotiZIs--LZhzHrO6XcWlM2XyoWgaOg4_bJE5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ad3a0e25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:25 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 23/27] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <9b376a313fa0d94a9fff88c32d1911b4b59fce2d.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N0REYnljZPLIZrK8"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--N0REYnljZPLIZrK8
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


--N0REYnljZPLIZrK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj54ACgkQVbJhu7ck
PpQJFg//TkL+7+sfftXEKOU4uKqEFAz5HF9rSsF3armTsPRDc1TgQw7SmAEOt5X+
3pa1J0eLJmMnFbXeeJTHVSv1yv1CXFn7oYJmFv31kt6n0UkUQpy7zmeP2R7w5r+i
ruoZ4pxv0VDUo7m1jwRiT9C6qhgFYAWGQKSxWzr3NoH6UWcyzpDilu3W++MWgpWh
ywDOFGHaDuVGxw3p9U25AD0trzSSxHaAz7jQx2KM94+RUaQGgmSGBmzJ+yKqB+cm
3R3f46AlTCmF3TqR42/8xNRalDmYn0KHObMIkNwwo4sZBUJ/C4lBiXA35X/TY+z4
nGtgWtFuftRxxfI568HyHnra0z6CnlD8ElePm898VBhGXugAS3IY/Yhu85q061ml
g1RT97bawVx59XmL+ha7zSDfjlufu2AdBtSTg5KX0vPgLpLreXQAu4nkqFK3383s
qbXTyHZlJFG2ktsFSdO0iDt4xxfl+dRZybvO7pVfzR4migEt4jy1lzdCuK/J/i80
qpuHmRJGlzQ7hF/CCO7ZUbUVrDhnAGbVo6FCDTWwotDEtYFsLrFE3TRjsbpQ9+/G
yFu3UW6sHQYv+ZsHbsKZYut7mk2VOVtSqPjIx1hrFCLd3TOsBXvsy+PP7uEzHddZ
3BOcvPJ96f0ntHX/GUMN6zaBp4sh2fzatxL6TXoW6PCB7xZ9wHQ=
=3Hib
-----END PGP SIGNATURE-----

--N0REYnljZPLIZrK8--
