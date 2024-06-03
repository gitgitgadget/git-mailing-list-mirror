Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B058185277
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407648; cv=none; b=VkLPxK1GyFm976/Zhqj8KpYSPM/0lpZClh2DtqP5JLBfaMzA+eAqQmbVMEP4Pl6oFGSN7YOurJD8khpNm3AYx4yHEU+gfJv9UkRfp+wEsagbkLz2V7M1kdrXoWQGNLRGVHYp3aDzSkIxziSzAs8YNMS0eLG0Koeycga5vAF4mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407648; c=relaxed/simple;
	bh=F5Z0C47SpR8rc8TyodYqD0zsI9AeoL/jTigeB4RHYKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idWIH38TUfyj2G190H9aWjkkeH08Ihq01+bkWYehO9fRUaK9MmLNj5/E/8pwoCP33G6gFduB2RGUYqp1coqLdoRiYkogpIr5pUQ+WT98E+d1qLV27AfLP3kMtpknnFU7Pk4r9qO06PMLXpcKovdT9ZAt9XqaIt2hU73CcpkaTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gR+JkcEi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DXNKcXbH; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gR+JkcEi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DXNKcXbH"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id F0584180009D;
	Mon,  3 Jun 2024 05:40:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2024 05:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407645; x=1717494045; bh=V4YhW84Slu
	SOg3Fk4lPlpiJlgNx6w2vSW2WZB0xJ4gM=; b=gR+JkcEiGmcjwzggV6n8lapUw+
	VVZGxhD527vRrCoYj/Ga11GVIFxftqTT2MCCh6LqmVY8MtjjRY0nPWi4Ma7MIQAz
	1WX8I2eBppZTAXBnW4DTSgTADZgiOfqSrjaiA/9YuEzKJTvT/H/jgAaXsFmTqEwx
	R+oYXcr4rSTNslEmDPaD+cMxcKo1Oo8IEcr/3Vh4/gvTi2H2Rv7kMjc6G7o3hC7O
	lHlmxLrOJ2ba3SN3/jYawfgtnqgl2O/zwEAch8GF6hn454GZqyR1Ofiyjf40jfJx
	zvxAmQ0WlZ/YcRKYfy+QvTkyk4HmylxklqY1gmUObK31okcnXQAZ+5r8JFrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407645; x=1717494045; bh=V4YhW84SluSOg3Fk4lPlpiJlgNx6
	w2vSW2WZB0xJ4gM=; b=DXNKcXbHb0/3qWqrwd5pgiz27HnGryn47oA1KWCEN3S6
	63+fa1QgHy1vqVQmy+N/1NaGVJTUhw1kCt8zxg80LUG0aXy9qPDI1z4eWVyh5Lg/
	rU/ODBdhaQaaSrqDA1h/4jXCGALVlDwbFlBDKfu4SbStIOc0tnR6CL+WPzgv6jE9
	blHIabsbRICDWo1On0kPUlgytGBS0lbM6MNkGjNxzh4k9wAsA4c25eULLpDhjySe
	JvKEAYRU65naeLvhR7+78yJCkiGZUp8CxJIvvSQyBWdBoqIuX1s/ew+3snqlqRvo
	Sa79SKp732dLjgNt4aZR4j3ecXfQmLtndMZ52+vA2A==
X-ME-Sender: <xms:nY9dZr_hr68vjyZueRi12fTvLZLKymq9AxqEewx-KPhm8FylPaDolA>
    <xme:nY9dZnvUvtioK2vCXyLT20dmBMFV_1rG3Nq9OoPceY9Tm5nsezINuz35ea9Sfw_zU
    ZhgTDl4Re_MSIiBLQ>
X-ME-Received: <xmr:nY9dZpBS6z6kei3NcnnjIV7aPa327bmedrlDFfhmvd6ZUaEFmzIV2lSBYw8dZw-LsoY-WAMok2__vWTFJAymMinuhleRATmo-7G7QQSIw62x8hDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nY9dZnfzAnibShQ_FpyAWpUK-yNX1FHBoOv2Vem1DupmH7oTipn9ow>
    <xmx:nY9dZgNY9p8fUn3MVQdT4sXO0nxNcKIJVewIGCyOGbTZ-RbPYaEBdw>
    <xmx:nY9dZpnHoKx8MZTuBc7466faUteu0AXQs07VRsY-igyMIZ-FTpciNA>
    <xmx:nY9dZqsDchXQoJFt49fDWIadjqP2AQVPiz4mPiIcn_PtbxU7HcRK4A>
    <xmx:nY9dZlond-ICZfyUY_QKckTzZePP59-CuI_p1lmCN01bQwoV4mC87ruI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e9a0492c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:19 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 22/27] imap-send: drop global `imap_server_conf` variable
Message-ID: <291030faa76da72250ae96dfd426b47d7eed032b.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EdzxYTRoh98XR2qi"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--EdzxYTRoh98XR2qi
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
2.45.1.410.g58bac47f8e.dirty


--EdzxYTRoh98XR2qi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj5kACgkQVbJhu7ck
PpThzg//UCkonsnm0+ml/ggPhrr+Qv+hb3rmEMI9BE3G17K7u/gRSW9NvzY0UVyI
5sZtwsj7h2IYbcGIC41cObd7ftkJrcutDBAjyA335KEq//59Y+OnwJudyd35Fgjg
eDYb9hBxq3vLfrHozXteV8/3L+FLrSu4e0egZQBPLQnCPkHhoQamdUm6+4jfMUEB
sUNqhuWrn3WsIaZxSnS4olnttmYr7uCigWVsQ0KVAiHGY5IrlTcoK6hEShT0jSk8
hUe/nnUyFA6VU3z7wGj6sLi6tkxuPMHSn4JUIfmQNVtM74tIVtYrG9dfilZVPiIv
qlWuHwjyUFyvYAVJ/Mb/BM33Jqv0T18XZudetwx8R6puB6J2kUoYji5k817uuYIt
UILd54HagcNk7Ho85HuXLJ7iB6ynInVwfHNtM6C0xny+Ni3AXGU08r3DlJIxKZ1e
SMkwM3s0TmJlFeqPybi4RnMkNrnQVSg5vDJSMWB7EEWhSQG1IZ/3fwlOA7xi/AuL
LUp8oNs8kjTyR9+IrAzset0Rr88TtsRi1/1y9WtiLBcK0QH7unY8v9BSlB+UnCmP
ZtdWzrEGq5Gosrhzd7GMAtl74Bhb9RXBxTWlo+zau7YoHFEa6wXEmFbXRSyOxzyI
TrFg5ESevuNJIDJRIh4VtT2DxzmOOjr+7FrGZmxHZRIzXUevfW0=
=haXX
-----END PGP SIGNATURE-----

--EdzxYTRoh98XR2qi--
