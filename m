Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6FF183980
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073509; cv=none; b=dgUaZ6fvuzEvD07FByr87FmhCzRyHDvz1lD3S35wSn/yAFlFikTKv8wHrCx3kelyRqpg/qTdc5H7x1UinkXUzO/ZzJw/Jv6U3tmHVw+CjR2TEwJCp43dekfSmq+khpgBizJJkvsdNA04ihQUGQR9P4D5xLVuDaA6LG28rLok5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073509; c=relaxed/simple;
	bh=hurqW/4nA/k1mEpg2zPVCPRskN3+33blm7Kpqtr1g88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjM+b6r4UNMBS7L/7fLAOoeyUjVMoOOM4j/xHdA0A3FTdu3I6B0MElSn+nqSo41uvzo/wjIs8OKzRWDNDq7aqkMpyrDdJbdzb9og4INSfU+afTr00jDDvjUSPKOWvIuyRr9aGsZeZN6ChOrkJTY9A02QJEGSKawIyWE57WDrEY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ptqz6rFx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VbhZ/t7U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ptqz6rFx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VbhZ/t7U"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A05791140149;
	Thu, 30 May 2024 08:51:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 May 2024 08:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073507; x=1717159907; bh=eC+ME/OD9S
	me8iLAhXCTey766KmI5oSeLyq76Bx2aqo=; b=ptqz6rFxLFCl1VckhKIxetv53C
	RD5haFf/d0bTnwLnQD/Fxvc19qH5VrD8ZG/n9DxmdTV4MpTg4r71Ey+o70bRFYiw
	OJJ28X4ghDVF7ujcoyusi7bN8lIqZ8f+1j2dyp2CP5b9XO2fKVdSPO+CZNniOc2D
	ocqYvZhSsjIX3npaPzEl+maEnOKKNqM/nPW/2+c0ZTCsZiYSaGQPUBPl003Un4dZ
	BCY8vgl3/B4O1inl4qqz1rKI3o6tZAYmjuGDCg1Lr1yfq4EFvr/9+QsyBcf4L4Xc
	hTx6CIL5A4jnj+C8BIQbN6z0F9Y5CA0XC3JcF2TJ3csjlYzoKjYUeZWHW90w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073507; x=1717159907; bh=eC+ME/OD9Sme8iLAhXCTey766KmI
	5oSeLyq76Bx2aqo=; b=VbhZ/t7U7+TiGfRoH+myEZgTrM5AMcb0f6kKqPKBXLCm
	sZxZZAW21pQ1vXrGASgRRIxBt39IpSPaJj6yB6I3D72Q6GGgln5CaApXClfzjdY+
	uXGLD5MVYof8Z665jKqT0A2xKWi3gxUgnm8f+3LSNOEFdCcncQ6FQu7tAQYZiJab
	FVkDg6PyEc96bea6T1N6QUFoAGIAzU/14e4skQRffRZiNaoDRvVp3605JKSe3GBH
	5wJc/yrc8C+AvkTpaWrPJaK3q9ns9Cct6y6NVnh8PjBGehqIKeVcqcmsyvfJewRS
	vdySHzURnfg2rBd1dsSTyH3jFF/Y4+24WqiW87dnxQ==
X-ME-Sender: <xms:Y3ZYZnDGFuzO1CByknOBBpPrYfvt99F4ajx8EqLa1M2mH7GMVhELyg>
    <xme:Y3ZYZtg5MVPOr-2tYO6pxxiu4AR38s3PdSrtgZS6-JPV8X_aJOgJwfOlibEF1L39L
    MKkIqIUG9wmAZ0Wow>
X-ME-Received: <xmr:Y3ZYZikJbkA10DNEKdn5Y0DqSoFR7XqJkjXbJhKO_bK7q3tQU8M_ptvl1_B-FY8miJqLpdGMurvLwtZ_wb_pYWFmH4pFe1GVzPBkXBVIsT72THzLJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Y3ZYZpwoxI_zFMUzxwbv3tmgNwuANJDFZAq4IJk6fPQVfA0wS4p3nA>
    <xmx:Y3ZYZsQ2FWfMPmBMiR1L9dIK5d-6Gd3Wu835vXxcOzc3tr2VfA0G_Q>
    <xmx:Y3ZYZsYF0-h7FBtixQsIPJT0RJBjhRbs1BOzU6k8vbBHB7tLtNjl2g>
    <xmx:Y3ZYZtTqLjKyuue0uu0l1pIazRM6jNkWN43-kKIK2p61FimX4eCWuQ>
    <xmx:Y3ZYZiceEMn29R07XrDXP7h_yc6Cr3l7oZn973eDq2vEr8BfygqnMLA7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 29878e74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:29 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/19] imap-send: fix leaking memory in `imap_server_conf`
Message-ID: <e0a5b83f0e5179f84b2c7fdb80cd01722bddd0b0.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qrgel2DfsmRERcih"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--Qrgel2DfsmRERcih
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
2.45.1.313.g3a57aa566a.dirty


--Qrgel2DfsmRERcih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdl4ACgkQVbJhu7ck
PpSOKg/+MxxlfcFl8XDKtaMaqmn6ClRVdS1IZ+ad+lyOf31oFPXXl9qFE3SgzXCy
OxKvuxmxcTu1aOLi/xGrxImZu7kXUcRwXWmYpimAkAoozzbEBScbpf5UC2FrcOeX
VlFt4NyNZhld7DwMc+zZRmTzWudYbBYB5oDBLld+YZhlo6qak32LDuCLACa3ByF9
LtodxPwQHBMeVGYNkOA4R55EBm4Z3FF6IAYPAaDS8e5iIsECbWX7EysM5i+B7O2M
VEupTIhHQxE3NfpMVO/2jSrSRPLIrbaGh8v+wP+HoiLvxYqZVBptNtDvxtMOrJ6H
KCYdDU+HtrGotWo1RMeqI3QXDqfRnlxBF1YzMBXevZ889v/mVVlX0VftqVY8i+z9
8EkBLaZjmSuxtUdjhfRFYaOmPMDNKClsRn/951h8jD4/q2h2QraADPxXALdK1O2l
z4jbTYJmoxXEeLy+GbCY0MIFXjYj/HeLyGE0MhLH+6uJlsRXRIFbKGRmg4JEVkWK
VXs2Bx9GdQv4Xy+UEBsIZjQFNGcAuWLIG+upp0TYjXqDCWHv/Cd6HcHb/43aaxdq
ZLXeuN0UHefgyLVa1IGp29okg3LcNdpRmM8aOmvmhDDVunARMda3s/Od6deuZb3R
U/PXX9xRmTRRd5vVbd+AJFVrhn2xZYBKj03S5hmVGRhWC3k6jV4=
=R3RR
-----END PGP SIGNATURE-----

--Qrgel2DfsmRERcih--
