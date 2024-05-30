Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D56E17F4FF
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073504; cv=none; b=q557ZMm/oEd6acRUVmTFscZNtcKRMzhp1VL0C7ohYvGPXxqmyzj6ulGX3Y8gPc5/pvTcG4htrdVV5yRlVulAgxkW9UP1V4/PSayZXH1yhrRGg5pUp7U8dxky+BXNZD6uTePSEuBEb1QTbgt/EudqLSYA3dDbOQ/jbl8nDG+vbwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073504; c=relaxed/simple;
	bh=S8WYj4f2MNNNw1J6OWue2WGlA21z8MwoV0EK1FaAr6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQGikgAE1i4Z7ByApyctZ1GAqUTZyihBG+Lp1WxeslzbKENzHt7RLqJKIFUhgqqN5OakAJT0ZTT9PeuP/WWZldPkSAKC/o8+aYwXWY1S3ZxBTSFA5PMt0h5gTlpaSfKEfg4wRj4rN4ExKSPTTBOGXSrVJRul8IwsjJexaOEWL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=on3gXTEe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NCBPjlzY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="on3gXTEe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NCBPjlzY"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7199B1140143;
	Thu, 30 May 2024 08:51:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 30 May 2024 08:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073502; x=1717159902; bh=gDN/yHBtHk
	NcgBHQ3Znf1wmqOf0sNrtuXJuBlhnC8LE=; b=on3gXTEeqkdjEletnbrNMa6aVm
	YpqfJh5aHGEWyb3r3kY1tloYwH/KA5dfhiQCd+LIPkesFuLXSWCpo42QW7hhGfp1
	Y29z4J2GMQ5CjgMTdyxgdLruMznCQhFrSeXdACNHEBio3pCbjg8k4ZBBqd4Nt95c
	FhDWyPU3anTo7TO037WUefsxbq5BRmNeUwnMVw5M1seucN9n1nrY5H70/cMY/a/A
	mYWukeKj90tnhjCRHa3Aq8fzIHhLKOuvb1ZSXOyNjt5uc96gtPu/Nmwx6UYUnXrQ
	UTnV+z10q8ch+8x0PMyPZOhfkkvJLGGNIFBcDg6gruFcwnEXbSFxDN9TBZMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073502; x=1717159902; bh=gDN/yHBtHkNcgBHQ3Znf1wmqOf0s
	NrtuXJuBlhnC8LE=; b=NCBPjlzY8CNVycTOCoDA4mpyMBMTj4gRjSokNU3Ksr5e
	Q36z6RScXzKaqdTwcQrn3JirBGOpedz7mvd8tLqEixYJKw5fKVSLvE6yzAvz6Pnv
	eK7F4b4x+VQ5igcqWgzq3a+UG0edzoy8X1xXxwyXm9kWNh3oP/mfOxjwxZiQtP55
	XuU7t1Gof6+3WQ8+Qvrb55Jv0ZgAJEwa7ExeGrbWgMB1ePE1WJJik9e9bxc7VfWe
	37jnu2XL/mOA2/aAHI46ZS0igrgo/uWpye+4mg+NQwBOQMtyzhC/t6H0Ec9MQHcz
	3J7KftAW2Ha/BcqyM7dbwQl+LvI6b2HZ/CV4nVb+ew==
X-ME-Sender: <xms:XnZYZi_TeGE0mW8_-e9votK7MqqxsFA_8FwZFTt16WMHChtxIaR_tQ>
    <xme:XnZYZitBeMdgv9sP9v-spk7M-ekdLJsHA_0E4uZqqFe4MdzL50HzyP-hF3kYpJXBu
    Ix_HiFRM-roVZNqYw>
X-ME-Received: <xmr:XnZYZoC5xE1CEURclBdO8Zd6g0gMxZ0KXaeEsNOItnkD7j_lQsCTNzLyd4RKiNCBsPgLwNno_Y6FIIb2OFd8w9J5uQDO4psduHmcp3AR3kvcNZ08Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XnZYZqdnTyKRmttbAT_rA3Am3ndTPvAXVrHmZou8GwIgBeAqrRWtPA>
    <xmx:XnZYZnPwJo_pKCvLm1LrQZbSvasg5-knI98Q-TNmBhMiMiZ48W-xqQ>
    <xmx:XnZYZklPhtSaIBxroBI-MjFvT4zfLWmuSKf8cYpTKjS3-uflL-EK3g>
    <xmx:XnZYZpvpVACcMO0I9aDmrW7vXad_1WntPTBCYqD4Kg0YPB3Bayk2Sw>
    <xmx:XnZYZgr1w4LQNI34DhaP7uKUdYyNSgOBYDeFgyrgG1hl3fGW9IAhg-mv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9cba654f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:24 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 14/19] imap-send: drop global `imap_server_conf` variable
Message-ID: <c0fce9b87eea3d4dfc5b2ae5eb947f7d1495491a.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WOAG9w3Nz6R3pdZp"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--WOAG9w3Nz6R3pdZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In "imap-send.c", we have a global `sturct imap_server_conf` variable
that keeps track of the configuration of the IMAP server. This variable
is being populated mostly via the Git configuration.

Refactor the code to allocate the structure on the stack instead of
having it globally. This change allows us to track its lifetime more
closely.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 imap-send.c | 57 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 8b723b34a5..67a7a6c456 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -82,10 +82,6 @@ struct imap_server_conf {
 	char *auth_method;
 };
=20
-static struct imap_server_conf server =3D {
-	.ssl_verify =3D 1,
-};
-
 struct imap_socket {
 	int fd[2];
 	SSL *ssl;
@@ -110,6 +106,7 @@ struct imap {
 };
=20
 struct imap_store {
+	const struct imap_server_conf *cfg;
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
 	int uidvalidity;
@@ -194,8 +191,8 @@ static void socket_perror(const char *func, struct imap=
_socket *sock, int ret)
=20
 #ifdef NO_OPENSSL
 static int ssl_socket_connect(struct imap_socket *sock UNUSED,
-			      int use_tls_only UNUSED,
-			      int verify UNUSED)
+			      const struct imap_server_conf *cfg,
+			      int use_tls_only UNUSED)
 {
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
 	return -1;
@@ -250,7 +247,9 @@ static int verify_hostname(X509 *cert, const char *host=
name)
 		     cname, hostname);
 }
=20
-static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, =
int verify)
+static int ssl_socket_connect(struct imap_socket *sock,
+			      const struct imap_server_conf *cfg,
+			      int use_tls_only)
 {
 #if (OPENSSL_VERSION_NUMBER >=3D 0x10000000L)
 	const SSL_METHOD *meth;
@@ -279,7 +278,7 @@ static int ssl_socket_connect(struct imap_socket *sock,=
 int use_tls_only, int ve
 	if (use_tls_only)
 		SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
=20
-	if (verify)
+	if (cfg->ssl_verify)
 		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
=20
 	if (!SSL_CTX_set_default_verify_paths(ctx)) {
@@ -306,9 +305,9 @@ static int ssl_socket_connect(struct imap_socket *sock,=
 int use_tls_only, int ve
 	 * OpenSSL does not document this function, but the implementation
 	 * returns 1 on success, 0 on failure after calling SSLerr().
 	 */
-	ret =3D SSL_set_tlsext_host_name(sock->ssl, server.host);
+	ret =3D SSL_set_tlsext_host_name(sock->ssl, cfg->host);
 	if (ret !=3D 1)
-		warning("SSL_set_tlsext_host_name(%s) failed.", server.host);
+		warning("SSL_set_tlsext_host_name(%s) failed.", cfg->host);
 #endif
=20
 	ret =3D SSL_connect(sock->ssl);
@@ -317,12 +316,12 @@ static int ssl_socket_connect(struct imap_socket *soc=
k, int use_tls_only, int ve
 		return -1;
 	}
=20
-	if (verify) {
+	if (cfg->ssl_verify) {
 		/* make sure the hostname matches that of the certificate */
 		cert =3D SSL_get_peer_certificate(sock->ssl);
 		if (!cert)
 			return error("unable to get peer certificate.");
-		if (verify_hostname(cert, server.host) < 0)
+		if (verify_hostname(cert, cfg->host) < 0)
 			return -1;
 	}
=20
@@ -895,7 +894,7 @@ static int auth_cram_md5(struct imap_store *ctx, const =
char *prompt)
 	int ret;
 	char *response;
=20
-	response =3D cram(prompt, server.user, server.pass);
+	response =3D cram(prompt, ctx->cfg->user, ctx->cfg->pass);
=20
 	ret =3D socket_write(&ctx->imap->buf.sock, response, strlen(response));
 	if (ret !=3D strlen(response))
@@ -935,6 +934,7 @@ static struct imap_store *imap_open_store(struct imap_s=
erver_conf *srvc, const c
=20
 	CALLOC_ARRAY(ctx, 1);
=20
+	ctx->cfg =3D srvc;
 	ctx->imap =3D CALLOC_ARRAY(imap, 1);
 	imap->buf.sock.fd[0] =3D imap->buf.sock.fd[1] =3D -1;
 	imap->in_progress_append =3D &imap->in_progress;
@@ -1035,7 +1035,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		imap->buf.sock.fd[1] =3D dup(s);
=20
 		if (srvc->use_ssl &&
-		    ssl_socket_connect(&imap->buf.sock, 0, srvc->ssl_verify)) {
+		    ssl_socket_connect(&imap->buf.sock, srvc, 0)) {
 			close(s);
 			goto bail;
 		}
@@ -1068,8 +1068,7 @@ static struct imap_store *imap_open_store(struct imap=
_server_conf *srvc, const c
 		if (!srvc->use_ssl && CAP(STARTTLS)) {
 			if (imap_exec(ctx, NULL, "STARTTLS") !=3D RESP_OK)
 				goto bail;
-			if (ssl_socket_connect(&imap->buf.sock, 1,
-					       srvc->ssl_verify))
+			if (ssl_socket_connect(&imap->buf.sock, srvc, 1))
 				goto bail;
 			/* capabilities may have changed, so get the new capabilities */
 			if (imap_exec(ctx, NULL, "CAPABILITY") !=3D RESP_OK)
@@ -1299,23 +1298,24 @@ static int split_msg(struct strbuf *all_msgs, struc=
t strbuf *msg, int *ofs)
 static int git_imap_config(const char *var, const char *val,
 			   const struct config_context *ctx, void *cb)
 {
+	struct imap_server_conf *cfg =3D cb;
=20
 	if (!strcmp("imap.sslverify", var))
-		server.ssl_verify =3D git_config_bool(var, val);
+		cfg->ssl_verify =3D git_config_bool(var, val);
 	else if (!strcmp("imap.preformattedhtml", var))
-		server.use_html =3D git_config_bool(var, val);
+		cfg->use_html =3D git_config_bool(var, val);
 	else if (!strcmp("imap.folder", var))
-		return git_config_string(&server.folder, var, val);
+		return git_config_string(&cfg->folder, var, val);
 	else if (!strcmp("imap.user", var))
-		return git_config_string(&server.user, var, val);
+		return git_config_string(&cfg->user, var, val);
 	else if (!strcmp("imap.pass", var))
-		return git_config_string(&server.pass, var, val);
+		return git_config_string(&cfg->pass, var, val);
 	else if (!strcmp("imap.tunnel", var))
-		return git_config_string(&server.tunnel, var, val);
+		return git_config_string(&cfg->tunnel, var, val);
 	else if (!strcmp("imap.authmethod", var))
-		return git_config_string(&server.auth_method, var, val);
+		return git_config_string(&cfg->auth_method, var, val);
 	else if (!strcmp("imap.port", var))
-		server.port =3D git_config_int(var, val, ctx->kvi);
+		cfg->port =3D git_config_int(var, val, ctx->kvi);
 	else if (!strcmp("imap.host", var)) {
 		if (!val) {
 			return config_error_nonbool(var);
@@ -1324,11 +1324,11 @@ static int git_imap_config(const char *var, const c=
har *val,
 				val +=3D 5;
 			else if (starts_with(val, "imaps:")) {
 				val +=3D 6;
-				server.use_ssl =3D 1;
+				cfg->use_ssl =3D 1;
 			}
 			if (starts_with(val, "//"))
 				val +=3D 2;
-			server.host =3D xstrdup(val);
+			cfg->host =3D xstrdup(val);
 		}
 	} else
 		return git_default_config(var, val, ctx, cb);
@@ -1497,12 +1497,15 @@ static int curl_append_msgs_to_imap(struct imap_ser=
ver_conf *server,
=20
 int cmd_main(int argc, const char **argv)
 {
+	struct imap_server_conf server =3D {
+		.ssl_verify =3D 1,
+	};
 	struct strbuf all_msgs =3D STRBUF_INIT;
 	int total;
 	int nongit_ok;
=20
 	setup_git_directory_gently(&nongit_ok);
-	git_config(git_imap_config, NULL);
+	git_config(git_imap_config, &server);
=20
 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
=20
--=20
2.45.1.313.g3a57aa566a.dirty


--WOAG9w3Nz6R3pdZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdlkACgkQVbJhu7ck
PpRVfA//aq0Hhj6oHteQwQn0USrei2C9RbjxUnxdw/ltLvpMeUgxGmGIhF4Q0aHH
mNTNBXvIIj/v7RQ350NqQS5ppzfWyAWZT+0oMFNxSQG99FZSV5wUzKt4d0MBH6I+
ieZIsdfxugAaCmP5sT3HMqSnRq/pf2Yd9v5GoisoXSQIlpFkxgpGsnl/VUxMoOly
/507rUaw/qx/u+SIRmgZPFQ8GoHzZTkjOPmXkMV5Hz1C2QPaFJs57F24X/8yWTjg
dvNi2Nq24bnhYyN0ueyq/Ujt2OinbQrUlK83KYIqo8GjWsWuV8zQYGIR3DENv/Tp
a0IACuW3EsFxYc/7A45UYOO3XY7gh1GG7BbPXHYqzJB6hpgfMtm7I1+/flQr68FH
hiorhldX3s+jLfcwCw929n69UyMO8Ss1TnMUTDwVOhTNJCruEWPHvjAoWKWp+P79
KQIpfGsRlqB1uQzDKCuzi7mVhj4Ri8OKiYPvR7cHbv/PNY7Iz+qCtsLy66KRBm7X
JyhaMmA9Upm68C5KTqJ7fp4ryzQuw5BquNO2P7CqrFc44FGf1FX80YbZOleE/cSp
u94Icbnp7k64yLr0f3ra4GVmSo24erzMGWj7wScaZ/m1q8+BiRAFDbRHuFgN0gUn
tAaPHsgFx9ggxgXLDwZtQjTEhSmfuL2p+Hj3N+5Ct2WqjP1h19c=
=dLPj
-----END PGP SIGNATURE-----

--WOAG9w3Nz6R3pdZp--
