Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E874C70
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986720; cv=none; b=ktuH0HaO5l0V6hONHOzmhuIcfMnmMTHtnNUz4TdnUbfnobqwA3FZoI04EQNCTyCcTZtjlIvl1l9NbvvVrWhkNLvldkwUckEIc8b+mOHzYgJo8A/awx3cVioIyj9Wap4S7Vta4v6drUvfJ/GaLRWJRHFCHCIG8W0JNOs9M0tF+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986720; c=relaxed/simple;
	bh=yMumKXk/UvZpXz+A+LcERMwzVkI5eSHIJQBazCgQzTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQLNS1VuV/1yNDy/ybAHZnfihmC5QQYaNnjc+BrD7c0AA9DgE1LsuyxyZregaazaemhtT8ZQUkNZ293LKFwXQoV5LiB8E/y/ETwVbQG0UuLImlKEDas2NMsju/6KyvnDhW8TPkukCdW3bc+H5okpu65ZZ4FyraSrnwbk7mhZWM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZVY+Oyz7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qDJqECmK; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZVY+Oyz7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qDJqECmK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 064861C000BF;
	Wed, 29 May 2024 08:45:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 08:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986717; x=1717073117; bh=E1ftiiaA7S
	v4BodpfQLInScoIauCgc6S7a0gP8Fbu4g=; b=ZVY+Oyz7tJHxXRY3WbiCj9iaQs
	oLnG3UwroFolTT9cm4N9XV7AzOjm8kwMleJxmHh3Zbun7qy6AUGsJDP80C3b1qMI
	hh/e9sy2/f9hx6p/6zYDLWRcfQjMxCMLTWYuw86ZjMy6eHQVaCLSMxzfJla5iWh1
	wdVbx7JeB4cfx+nUSz3els2ZUkz/TTAJtjfUkNwHygdNYAxGn3G2eNJYSBjhKUWp
	HOKq+JE2OOnGLjstOPBCLaLhHvw/whEe9cHmj/l5BFSER/7UmfW1eMRwpU4gPPN2
	nTHG46jVBu3GTlYnQ8X4pt9eWHFpJGe+mgfRx6nASYKAfIY7gVPlSr8EW1Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986717; x=1717073117; bh=E1ftiiaA7Sv4BodpfQLInScoIauC
	gc6S7a0gP8Fbu4g=; b=qDJqECmKaU1x5C9JTnqxrOk7yI69x7oBRMMUtVlZhmuD
	eV1c/Y/OO6hf2osRz3NeC8Pd6nKHBitVM8VJ/eKDrsKjXkNWK8BljnFdPPkUN7aN
	3pfrPno1BfarCMgBZw6v1CZrxr2tLR5HIbgrv+z+HiHv5h9+vcC4UZYPCKy//Bkz
	jouheolCZkBQ2c5JdEEKb05FkOLFKbP8oZnl6Zjxe/0Jwsk1IKG34gxXK57TrFh9
	sqEtOGsZgqlzOxTJF9tZCGGilrH9+U75Nz48NF8pPAsEehVAF2WaYv+JjWnTxWu/
	GYhtF3k0a7Y/pBxY3yVb+cDg57soXwafn6C3dG/ZoA==
X-ME-Sender: <xms:XSNXZrNL_2lnjGeIJhnrMNcOd8qE_n8ufAjSSMsxAEoMwlRdW00fnw>
    <xme:XSNXZl8psMrddG-WPz5WHf2KQgGu73Pz80YkBjtud61xVXK3sFj1deN5UHU-WdvOP
    orX-xBHxiz2md5mkg>
X-ME-Received: <xmr:XSNXZqRPIQ9lZoZNJElxcveUoJcq0n1sQHaM7_2byD0-XaepmR-eoiTBZjFuuealo3WDHaM8MrJ6A31taiDLvssyaQdzrg0R81ISDjjXw_cFTeAv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XSNXZvusz0aqQ0dJSgsBBejwylWJUhXRRYOy-Q8K3cBpA4jHtr554w>
    <xmx:XSNXZjftfRmsOoCao2uB1QB2iO3ir0DRxochAz0qTRw-2fF5ohgigQ>
    <xmx:XSNXZr0GWN8B9igBjb3wnionLeQG_eBOG0pxOKGaGpUGSHQvEGos0Q>
    <xmx:XSNXZv89Yr3jauNKeBOsPMTv-lAbe0j4rfhwNLx1wdpFV2ms0AbYvg>
    <xmx:XSNXZkrKTq5e0JyzFIt9ryxmKXxQ03jwWYYGv5BRjhAK_iGin6IuDfFZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9f0b60d6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:45:02 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 15/19] imap-send: drop global `imap_server_conf` variable
Message-ID: <18ba9f7b3b8bc81539cd69389e9b60f953f2ae5c.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8AVZ4nlQZvEPzzkf"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--8AVZ4nlQZvEPzzkf
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


--8AVZ4nlQZvEPzzkf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI1kACgkQVbJhu7ck
PpRLqg/+OvZFwh8FJNihqzRnZh4tTlqhVNSY5h3pdy20HgmH6MjG7wlv8mPPVsox
NJENvegabWEZoRQT0g8Sn9gWoa4ArKsnA72iWhYDnCD00F6lvaSfYY4mHbgHWzyp
CwRj2kwuRIXXH8UYXFJpzdq45vEWHy4mmfcDv3+6E5JA0oc7jG9fhp678W+o+fvY
XQ4Y+q2JaFelCpnKn0wrREfnZjjFvQFaHd7bZFUl+Ox8I+nLDK5xy73bTW3fV5Ol
n1bZKyFeAICFTBySxcwDaX9vSfkuZ/SP8IW5RbWEAZsQi70S7Em8nj7OI4GNhvr2
cHGtt6ZoEfN3a50CTOnBGUZ6W7z0N4h2t+cAKGbU6DaDYImSt//OoDomIfx5x+ii
WKf+jgRsuDccPxLB0q21QM4XQ4dA/DAS/gZAyCYUV36hv0oU1jZxPY5fe4ys5LVS
l597AmM8c7Cg1yoEb2TXVJRlr1gx/aOEEY0zpLYTkzIjE+zmqg1L3HV0qo3U58Ns
aAX8QCeKM5EET24YpfezmddO49HgTnkjMhG9zxAJ6l8ttyQr+s9i18u5P6c8UOx0
rgs98M/j2iiFxE4mac9MD+5d/R5/rb48GsKcrlbgs+ilW8koaOcc1rZXb/L2j6/X
ZRViHuoQx33AzGet+vwLXIV3lbnSV9d5yNcuQViWp54z1L+nmyU=
=LhTr
-----END PGP SIGNATURE-----

--8AVZ4nlQZvEPzzkf--
