Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B14CD53E
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986725; cv=none; b=hGI0sabTO8nw6deLG4M2SpyRXo7yyVmUSQlN80VfCJNKCxcoDAuod62y7dkqBteb7FqjepXncoB7H7C1dYEZYbbXUTKOf6dL1FXc6dtS2SH9cLOLM3DKfH6RhGZ8DMqn8KD1rjZLrsGxCxFwMFNTC7YdCYGOxgxN576uigBZ83A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986725; c=relaxed/simple;
	bh=BeBkimuBCKfvoI2swUJQhGJ7vBPZswX7hhmbwZUcyfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcQHKkW5NGfU9aiwgWOk6/Ia2does24gmn/SDoY+oNhghMCbih6Odevf4kE5SFUQMj7MAD6ZkIPJuHceQ4P0WD4gHfPnLWHTMGJXeHTh1fL/Itoou8wz+7TcY3ypr+grmUNlHrUuPUprSjqiroZnCWtTbTDrxHZwZJZNmY6MMHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c1LGw+Fb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MyczqFda; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c1LGw+Fb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MyczqFda"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id C26CE1C000BF;
	Wed, 29 May 2024 08:45:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 08:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986722; x=1717073122; bh=IlgB8xJagF
	MZowOS2UKIPQCWu1xA01C9yK/DRIYjt/g=; b=c1LGw+FbH99OxLLEj4xXuB+dyH
	moLxS8w86osoVmdv7d2P9T7v++aABGCxpjCCJdtAFECBZyKyYU0dZrMkmbdYsO2G
	YsuBCQpctQAtYcRd1GyfrqMb8gGHvH++VVczLsRMRr2vuYen6Yfxp0SMCL8CwO7k
	PjaWdwiIVMDsswHQcu17bSMga/trggrpxYJpWwMd4lEjucHuTDVj026uwFFudokq
	kDJnIxXTyo5QhXSdE8aacKy3IR4VFxj5qNbkNcjmVBAiFRYZ1KhcMFe1lVfHDpC6
	hAkHV+tX//NOqfguC+Fhpzsg47aLGb/BUqZquKbtooszT3wDYY5wXJNIEu1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986722; x=1717073122; bh=IlgB8xJagFMZowOS2UKIPQCWu1xA
	01C9yK/DRIYjt/g=; b=MyczqFdae25+K+EurreudXPyftbYoA3DPnp/og8Rol/n
	wPB1aCEF2+Dfa1zlAHwUVw5muJd7otZhlCMk+CGDOPvNKjKnogMQBrQNEkwpb9yL
	381nTwKaDD+PUTlzGh7gDvbKwEC9tfQLDUIr8Lnellrfyte9SDxPST6IDGS08sKR
	CsIn+ffeF+7FQxEh1FjN1wSaDTJQjAYuw7+VlcM0qYHxLBp0E90jXt6ED3wcS4XG
	ZmddWpBazDqHmGDfQ1PmKBcnsbsf8bJyhfz6JQHiE0tkmNfuBw1PNNmQo/jeSK4X
	Imteg9pEzBFHrB2++Apl/mizjnOYVv+Z1qcSAzrmQg==
X-ME-Sender: <xms:YiNXZlfO7BTHD2CrnVBI-B-AWP3PT26RYGGAtyGK52XTpuOsvvlWsg>
    <xme:YiNXZjMhYJwmlWIho90dJ2ukIG2ootU-6Uz5fHc60_QHPR5plC9AOdPf5W-ieVTYk
    kDztfCG0Tu9LiIaOA>
X-ME-Received: <xmr:YiNXZuhMJr-J9wkPlsDFClFjFpYVyk0f1iKIO0-tcV1kKwMqEHMic_U1tP23RJuu9vA3qiv6CE1XD0EDVtgIGodafTCGmWdtKrYEUd0BIoItg5P2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:YiNXZu-aKic0GqNToL4RFStepV4yLhYfGEXi_-HAuKNOsC9JJEPRdQ>
    <xmx:YiNXZht27kbWKSDUL6uvnxQgcSENIxfLNtfL48d4wtDPmkwb3WTvaA>
    <xmx:YiNXZtEnbz2lqOFz0UjFLidwa1_42pB6ubeQDvs5b4mj9JN8cjuWew>
    <xmx:YiNXZoNLY2uo9tvXcNQJlsT3mkC_-GwQiegl8xrLuQxnCFTuFwwXxA>
    <xmx:YiNXZq4LytN9Du8wWl8tR8Q76_uTjiIAnzaTgo8Xwng6CKFNPgKKdIb0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0ca2dd84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:45:06 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 16/19] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <357d69fa8b538baba23cd110b8d16174234a58dc.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gmL5WJorDkugqE11"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--gmL5WJorDkugqE11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We never free any of the config strings that we populate into the
`struct imap_server_conf`. Fix this by creating a common exit path where
we can free resources.

While at it, drop the unused variables `imap_server_conf::name` and
`nongit_ok`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 imap-send.c | 68 +++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 67a7a6c456..a6fb33806c 100644
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
@@ -1502,9 +1507,9 @@ int cmd_main(int argc, const char **argv)
 	};
 	struct strbuf all_msgs =3D STRBUF_INIT;
 	int total;
-	int nongit_ok;
+	int ret;
=20
-	setup_git_directory_gently(&nongit_ok);
+	setup_git_directory_gently(NULL);
 	git_config(git_imap_config, &server);
=20
 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
@@ -1529,42 +1534,55 @@ int cmd_main(int argc, const char **argv)
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
2.45.1.313.g3a57aa566a.dirty


--gmL5WJorDkugqE11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI14ACgkQVbJhu7ck
PpQv6w/+L5ezXKIlVVlrSKytYRJn6YRneo/MBLTU5bnNK/Z+fonWGVFTPHoJTTYn
MwuJ1lchwLTVK6AbarISR2TPj6rHL5azTjDSOpGaDAmodFhLgz2uJ1dIP2ETrYgF
vT2KJS1isU8fI7MctUjw+QdBOJlKBezek8Q3l3o6r5ShQV/ql0JOZx7s/FS3CKoX
cXSeXWgCE9w8bctO/XZqbr+mOXVRvHW11qjS/r3lUDhJF0+Rjgjs2szvH1jxqtr7
gCRrYXRBkFqXnwmPL0bfMG42qjrVPHvwxI7RQnm6V64As5SoPcFaREt82gKJJCeE
MNdE2DynMhfUBhk3YIBppannI7NQooT771XcrMs0I19Ih1QDwyYHwVHZ4Ar8tVkx
MQ8/4oLT6j2c6aqZm0VemFMmKmnRwuUHONj3eQfQDHpa1OawMAqoM1zawNfaFcH3
vW30IBTPSotYe1JseOXlvbjQvNyMdntfdDXWP5YJbkSJ4iE0oU06NjEYxYYIwz87
U8c5jMMYZhfjxzr3vS5b+bjhU/rzYTGrhWr1o2zOAzPMjLn2kZJeAkAva0Cj6BAF
F5+7gNcYkANRtZ7L4D1LHDGVeM9xiHBZkK+ovHBs0U5uMEVPc0Ol97KAaPi+6WkX
UHckg79jOd+PTiqJYWjz2UXHR5nHXNkpkIW9fuX0FtckAHAvNnM=
=Wf1+
-----END PGP SIGNATURE-----

--gmL5WJorDkugqE11--
