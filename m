Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC6153506
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742367; cv=none; b=tXaXSSCqMs/TWEAvhm030tp5Nyq0/7C0GPWBDKqZWrLVUYQETgUr366qERKs/sM0uRFgJ8tNqpaWKREdQonEuA1r8esnk+0x2nTvXl8Kb4R4dz4iA0Hqs60QB6oLdHlCugoeuUb3ElswYll9GQyv1nX1pKDq1KOjmhAbVHZDUjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742367; c=relaxed/simple;
	bh=iXvhNOncMeBzvCegxVXAagx5wypI0ZjMaAmxNsQtpRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OYHaxjnKEEc+AZsc1kF/Uu0V3i4j5u3xj1yhKE++ctFSzYbu07NKuKO6olEkMlmy8eqblRbXMrTB85xatXi7GRV6S1fQ1x5x0fMNjSxfoXZ37ojvs1EOCoufxhE2k66e2PAG1oJcjK9uWZ/XD2G9ZXcQ3NUz395AwOyy7bFmzYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axua2TqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E9U8L79C; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axua2TqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E9U8L79C"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6C65111401F5;
	Fri,  7 Jun 2024 02:39:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742365; x=1717828765; bh=uAset29Kxi
	Putse+QfdkHIaNsQbR6uMmYLmzBtBZtrs=; b=axua2TqWARJ/3mIQwswH5nCGJ5
	qQ3eE+YQTYMJ0npOp26UJHoIZ5unctU51ezz4FcH23nxn/jCiE5gx5L/3p0I6+E3
	WGrkgGRKEuZoNxy0McgByyfv+/kyjXUZr1bd11pZXuqqFiMaBZEkJwdrzmFbf3zG
	2sT5rbq/9RcnN0dui9oqTigZY4+qIM9VWg7YYYKmbr6yh7UHEvfUsfYwpGyMHN0Y
	du+CaWdQ8p+V/+fwukUZh9SxFcJjcc2BEhXHk9boJcmZxy/JcMZKsBygFkZdJDwe
	q7AwbUqdVeDW++7muEoc1tZ+RgWTVd+c1IoAxEqMlP26V4Jb1LbFV06e7YSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742365; x=1717828765; bh=uAset29KxiPutse+QfdkHIaNsQbR
	6uMmYLmzBtBZtrs=; b=E9U8L79CcG8MHkptH6nO5KLSdwBotgRq9u/LTv326qNl
	o7tRB+uH/SZ8dChDrcX81rmW3fJ5og4gmfUPDZAxfQsOP4bsWE5ispn0op2dPiYh
	Q/9/KZMhM9zgyi5o+vvVt4hh+KEwAHAf/UamMAextsv2j664uvZfmK3V7+RWhGUo
	6Upd4hV8w6Ixsq9qiq9Mu5juCISReYN6Vg1iEIzxgUrtM9zVBXJRzUWYGtvyeZ1+
	GvUGB/3CiVUoaj0eQFuqXfxKvUdZaqE0iNEUQoHQyGRylWJ3E7ruvzcgP68XY+3Z
	b/SQQu3B3hDzLBqpjoXdb2S77EojkVIW6APpaCuH4A==
X-ME-Sender: <xms:HatiZj8e8rViA935Tjsky5ksu55ALnlkcMMKoo5YJaL0DOMDuluTSg>
    <xme:HatiZvuWTctem8Qdni8uagMFIxmyxUKQ3GcVaLEIw1ZwNgV2_LTU-fWZSq4ZoCFlw
    5Jc1JbIMm6qjL5zag>
X-ME-Received: <xmr:HatiZhAjcxYm_B3RlZQp-Ambb50Xs_AELp-PT7_6QAa5gWIXpMfAwNYY7aXGneVtYxZoEPU1tsqgnTztVJ1Q4eJatZLWQc5IBiIjZOzUkHkvvJud>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:HatiZve5KXjRyCCb29JPdDcA-9JiQ-OX2xAGlM_RnZF2KPL6svcjow>
    <xmx:HatiZoPcz4Sc07Fxs3SOyWjN7BGynCNbM-B5wfGc30BifpQG6F151Q>
    <xmx:HatiZhkySbAuFe9Ag6wF5_4_0-1Mm4SorZU7A0N_XOTYHxQb1Nymnw>
    <xmx:HatiZitc1iEY6kRh2DYJJSXqGLWDf6kO31FjbNaJ4ISD46FxSEpMEA>
    <xmx:HatiZlolCdzDXHWrvswF9gfXB6JEp9QMfqv-P2prebMc26hKoSr8OaiJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7059a141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:23 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 23/27] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <04c9cfd34df33f1bc099bfd8f2729a4259584ce9.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eU5W60nKOItWDjME"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--eU5W60nKOItWDjME
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
2.45.2.436.gcd77e87115.dirty


--eU5W60nKOItWDjME
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqxkACgkQVbJhu7ck
PpTGmA/+PdjXHgHmM8O0RkycN9loC8DJuoUcvr0RTRHlAcDQiM9BLSY5Bw6do2ZP
MP34M1fM+QpEgmisF97TASxBvamqbqO5lQXxh3Ib//V/QPJo14kfrkNfXk0gG0sB
DrLi4Pvr+iPfPVLTu6FNdCX8BsDu6xGbJBDNepjUQMAxykIhf6OoGo+Kz8yTUdIg
lsZXjLezpzQCtvwd4ePlP7b2FUqNUF4ChRwNux7JKd5ktoIiuyX5YwhZaeuiyIJm
pPeFDV4vTfs9Mr21fyAF8FJRr/DYYqa/2s9uuiJ5AYPCh9q+f2u7fR3pBpjLvdLD
vvAPq2XaQBeq825P2gSjCZfcrGLTQRdi3CjB+16zIId/K839N7F/eucDsD2lJ2iM
CqLx7uSzlaJCnDQtOw7ptjSRXYINqawrzwthN/czKAUhLQ4BW6irJ7ZzV93D4fnc
Wr06vEaD1WsqJFmPt4go6pm8NPTgNK2kg+iyiw7fpgi6tr7KUpjktw+R67YHVt0G
GTGr5yDrzLv7sNKiidSdDMIhd0cewlcgDCwW6NNE3RLJlu2/OeVzE6wQIQKJzohv
GOv/TLZRI4A4t9Q2r0YOoI3AbzAoLW4+2AEcH+beQMUNct6mem62QqxSAWlybAC9
hinFJnpQYXiJ7x/IuJzoWvx083eBzFvnD3tRgmGsvmnR62Ysovw=
=XdOA
-----END PGP SIGNATURE-----

--eU5W60nKOItWDjME--
