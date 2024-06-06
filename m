Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB97194C63
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669774; cv=none; b=dBjWOczhCPloAYuXvWdDahR7uUOqBdoqIVQQSvEhr4MncaohSJeNB9OFNx9YYrhUSnZCLhSBfuKeu0WjHJPPHT9Hyba2bFNO6f4Ak516eGN8uqpksWXoAEGxDbewccMhFpJk4EWv2ptL6aaGj9DBCUGQr0nsloSGb772ZfEmtrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669774; c=relaxed/simple;
	bh=oGp3nZA8i+o6vSF8Tfco11pO9eLGSKRXimtQDy1q5p4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC+4askk2dom7wlIyLxk7igNGDolUuxwwrVBafPyJlJF+aoTjvS5yWJA6b5CKqh3cBWjTV1XK3xVgyIyJFpBS+YyFh0xUvA1AtlYH44mFktQLdEWFm0arEdN05MB8uPl2MhesHijNXDaH9qu6hpfNc8wGfFHbJg2GkLt0Hchi94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WChXsGQB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q9nGNkfq; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WChXsGQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q9nGNkfq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id BA58013800ED;
	Thu,  6 Jun 2024 06:29:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669771; x=1717756171; bh=Op2eo0Z2pF
	+n3VsK5AE5CGcPbo5wMVkNKzdLEi8slmM=; b=WChXsGQBF8p4pl/CLhJyDOnhSD
	JjFcNHO88Zhk1YV5ww+dL5uQgXCnI+tQ/+Hqaq/9HvUOhzoTRuKdakNac1IXGAuX
	sv2NlgvThblbnZMJekqMV8kV5AyjIZp7JT3+tlfouQtm1cWVIUyRjPrYzauoZEfr
	l8KJ1u2JSJJQWzgx2BF33GLEOjJ3pUincTcjxJdrWzj6FoJDN5eoqoBdneEvQz/D
	eTx3QTNRB0gBTRMfeJP95O/n32znPFjFerpPpmqgOV/d95I+qG1Nh7nzWoYnaaVV
	0GbI5eVKVST9n1szyXYw3Z3n+4k6t1GB7SQy4IEz5mlACVz/J4RMfYPi/DkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669771; x=1717756171; bh=Op2eo0Z2pF+n3VsK5AE5CGcPbo5w
	MVkNKzdLEi8slmM=; b=Q9nGNkfq+15kEARgPIbeohkAOxkEtG20U6crEYGfdEKz
	11v3+8h6+K7ib5a2utTcx8S7ZCTe2gvOUgCOEzetv7eMRingggUbQ2F+3x92YV5Q
	hCh0DSR7fNK/bA6tOJPk0ksp/tHHiA35xhvMg+S2EIIarEb0zukzWnmqyPjMCx5C
	msK00D1YC0pbFC3ADMR+x31+3oi1Zzp3qmoJf7n5r14jjnWNPLZYx1F7AvpoSb6q
	t/LgMYhnD/a8R8ffsT4GHVUD48JM0muoExAtkQ/QRTJ4vJBQvl68D3d/ZieZBsbk
	HdTRIquLv7gNrN3vDtZ59yUWF8uyZ+TFvZjejXrjsg==
X-ME-Sender: <xms:i49hZhAXNjsO9rXR65Gf91cZRzOSn8ppkSgjplP-4f-SRsv2t3YoDA>
    <xme:i49hZvhNdjmS6PKUppQdAieVjjxTWJHUTieNEnoLNcoMKDuMzxDjRWdMAfiBivtzU
    1NII6Gg4neKYMEi4g>
X-ME-Received: <xmr:i49hZslabKls_FZ81PdfD-Q5KFMoXyF8wSi6-dQq2G-poMjQTY2kQSElrfCxcmzpJW1FegLeaAsYJ1iXx_B_JCgR737ZltjYsc3vU8AjRI2n1Wy4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:i49hZryp4sAc3QBQll93HQ9TAYfPK3kS_pQMUmwxwtGK9OJh40SXRg>
    <xmx:i49hZmTxlIIm6dknKA7ifMBxttkjJMUkUs6IlZYiKOLqlrYqwEnN6g>
    <xmx:i49hZuY7YSvST8YDVp-s0wC11n77-qxF6JVqXctjIUuvr__RS_-ItQ>
    <xmx:i49hZnS23PJibsHmaRrxIFlUrPzOxJC3LqTT8uj6-mkfoQ_Q8N_AVg>
    <xmx:i49hZsMfeyMZI5zgDoqvbF-vMJYPyWe_MfDCKx2Kk0tBwQxRrDsTjY16>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0b3e29c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:59 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 22/27] imap-send: drop global `imap_server_conf` variable
Message-ID: <fff2379832f2c59f7e1a442b50033c107719b360.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qCCgZlWoOgxnQwwT"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--qCCgZlWoOgxnQwwT
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
2.45.2.409.g7b0defb391.dirty


--qCCgZlWoOgxnQwwT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj4YACgkQVbJhu7ck
PpS4zg/+PAO8NAFUoCtzMMAthNBazHnZ6Ersk5xrP6qpcF1SuMcsyfblWKfLYibX
NfSuUCwVpfz9aKLugiKGlFZ9dOJ9v3SC8uz4FADIU4TSG0Aa0qXPy5Eve3ntKMOh
Bzt1eljHlqrTfEK6Lj/X3uJ+o9PxBBxMd/LbNRTRgKV0Njm/wTgD3EZIYsykJdgG
hBoGBiCvrUHKsA3wUIrNvlkBhHCPXLHxu8mA9L4NCnXEtZJ5UDvQNLSOp04qSsVc
y7gtLNewb0JN8Bj4hy/5uyhGDr9MlVE9d6k8SdhLodmuM5I2SAK327vxP5joe4Ow
f+irtd81h2eZaRwwu3i9OzDMahYPG7l+iYimK2d7Otp8UHgwyccpXIj1wbdr8puW
DY9rcY+WsFBLJmt5HGmTizoJlRmpHaik+Fxtc5L0lQpYGEEW+iUoCH9mTCp7dwNF
K5MLuNVsVX4DOpxvpQ2PFOew1qYBxLzF58P5xiOdkf3fW7wsoT8PMgU8jRipk8Ng
EuCf73Z70DbgMFRMp22P5kxqZABzzoBJqigNduL6TqZdzHQOpicqdszAf2EMNoQJ
ZuB7Lvd/qErT8FijtQh4tusYZAlYfSUjRP17w+g9KUwC5E/LGwLqQImP2kNiqham
2QiQUTMOcDH1jf8fJyEWUtHCT1mWUhdmXTIWsQwOjoVasLKZjZE=
=dXUA
-----END PGP SIGNATURE-----

--qCCgZlWoOgxnQwwT--
