Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CEB328A0
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669778; cv=none; b=r9lhVj15K6zjy9xIpJdcW1nUOm/mwPg79auzOQn2wz0ubtsJu4t0Yc7ko3t98knWLK2YlkrhJr1dWUzW4946xvNlkY92EaczRXaTvXwDtILjvja7kLeRkQeNVZyIAimFIQfkktDNhrdywyRs/z1VLo0MynkDeOlH2YexrctIHw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669778; c=relaxed/simple;
	bh=P9FmDiVWNLku1A+DZE5bSFZdPiKgu/FKsJTSDgX1yP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ah6snzypEhLHz0uB7dxdCZtzazOHGJ3XPQYL0pZqXuEvy7Fo5ywaggzpX7Fp4yUZgyydkVdxT2X1+n1yfvwVgwxxLBIZuvZZTDDe6A1uFIxa0dYSs9puBt3vL0YA5Vy96d0YGDOl4xpj1qZ2svSethuK7OGa7O2XblBI8GSIhvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O/olM6yL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axexcPB1; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O/olM6yL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axexcPB1"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 246ED13800ED;
	Thu,  6 Jun 2024 06:29:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 06 Jun 2024 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669776; x=1717756176; bh=gQT0PFqkz5
	6yA30TSDNU5gLUBkBUra+SRTvNVLFjJJs=; b=O/olM6yLhmUrHvRC0y+heDbRts
	pPQGH+nFz3GHLX8VFY7w1zHvEbgCDEXOMkxScENckZHFqKJMMZjwffIzosUg9xGU
	wsE3FSgCG6BGGrEFQ6z6z6vqTf99dXTfq9qJgVq7E1LZnKNBLPC97Gpw5FMnQQok
	JdBgq6mijrPdfsCeQktdFrnkowr+iiePATK7ZtR4vdZCrBk9tRD/M5xsjZvv+YoJ
	KdKSBbt13pILpNpc1XSAj8nUdkQzsaWpy5LQUjVeH936FdcqtmHgavDFH0h7P++D
	MwAbV4fMilGQQLrgX4XI84R+rZJg14blAA1LjNoqutu9D1rt439rFmX2XUIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669776; x=1717756176; bh=gQT0PFqkz56yA30TSDNU5gLUBkBU
	ra+SRTvNVLFjJJs=; b=axexcPB1VAI/04ej582vF/NmqivaBbjjsBsj2t6jAmQl
	1F80CD0oR5koQAE2l8VYPQ2O1v/nrQHmZXHxxqpC8fZqq8F49pXAHmJlTi00SYmG
	47TALCNnCLNYxCs3YoqNGI/u4maRcav/DZ985Qfqj8Km31+YnmR/w9/Lr1Su0o5t
	kVEEOSXHTW7YH8mjstkTzkbnrD1G8RW0Hd4U9D8AtIi2xSI8oA1nMavSlPPfR33M
	D0CAivNnsOtudoh9D6PF3Opr83+QEIuaMFdSgH0XStfo/UQrFbbldHqzNLdTEPrc
	2uUsIxvvVLfBC96YVSX75DJImMdJN3xq9tMKgT0X1g==
X-ME-Sender: <xms:j49hZtfyiVDj7YPi-SeOAMVXJKC8vYb0vp2s22PAUEppLujHbgtxhg>
    <xme:j49hZrOrE9M-OH8rCKKmSW2VABYHiNkrk1PR8PdkjlBGAoU1lZUMYUe1nGlPrlMxB
    Kzm-L_xMpVwpR_64w>
X-ME-Received: <xmr:j49hZmhFBwb8yXp__le_QGozorw3HlVQVoRcRYaco3zbOGB-ziLsNWDXAcw0GEnCqTkbp1XkumnYmE92wnMJUAVMTdTWOUlqgp-BWeMEuvNAfwnL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:j49hZm9pN4rMCU5Lze2uVtox_FVYZ0sdLPRMFSRogSf1nYsXdZWkDw>
    <xmx:kI9hZpti6VJgt-ROFMO7kjSoZUTemQVCgTTtyJ9qOM8AU6QP_qyKPg>
    <xmx:kI9hZlHawM2iq0z5aKjn2IcMd57ShKwsiK2MlTzYB34J5O5mGDYVKg>
    <xmx:kI9hZgNMi9IwrMbXqh6BHzXYPa12JycEGK-c3_kc5CuvDyLKPhvDQA>
    <xmx:kI9hZjI4i9Zz93XXk_cRmyxk3BWyNFUbzr-obUyrpgEyeMDMAGXhrWn->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9777444c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:29:04 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 23/27] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <9ab84e459a330fbd65c4b3bfdf9b6efaa8c05aaf.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HkNXT/IFHyTcc1gg"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--HkNXT/IFHyTcc1gg
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
2.45.2.409.g7b0defb391.dirty


--HkNXT/IFHyTcc1gg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj4sACgkQVbJhu7ck
PpQGqQ/+Oc1BuFIIgU10qWgHgU5xxw/Mq8DbaJVzJK6AFTZonbjI+Ij83ibnFU6N
5kuTjDA9i432ZRdJOK2vCyIXD9U8E9swCtUK54GSyBxVekVYua7N5AEkjeEGmKqo
RTSkJO4mr+xLD1imfVoXz4+JkXMm9fnwXxv4t+SYnicWmEHuxhtMHKospowMx2xa
Qr/oiK558Q5VCXKiduEPBv536kBsdj134F8ufjGfRqIbTt5Vi/OWUyIxzOoBE3bq
5fu/4cRQs4fHDjHz5zm9+dJbK9AiHK4Z9hSV0Bsuvk9frmuE7IfTtd1ernkhrBBP
jcEYIrIxSPoI4cUf8cyhiUV9+zSS3NrPi4FHzCWLo2zjHJCMpPGWs4+45F0nE2xk
khJLoFxCIEU5STQjVHiVD3gU/sW9ds+R249opbcTOPPiSoHBJWro2x+d9DqB3EWa
H5SSYaDezxRlygveWtFPOQin05u1sjqQuBoxvbxk6Y/dFosA1bVk3FIPECevra1q
sHz1vm62/vqRCTkjXljhb1sYKtKffAGo9NtGbNoAc6YY5ph9TAH2NMRlU5YhFc7+
DTlAHfkq2oGL3HtboWiaDK5ko+H0QbsajB2+Hk4p8+sG9RgPUIhYimkgfsce0ZeY
mxuwigpKe2apPldR+xlGGYQMUiTrj5yn6pTyA4E60A8KpGPUMJg=
=a6f3
-----END PGP SIGNATURE-----

--HkNXT/IFHyTcc1gg--
