Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60D15278C
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742363; cv=none; b=mvzQ0C0SFrYQ3eKUaWeMkWJazjhXkxmWx5iSZhYC/9OqyZrq0owDcJ376lMzdyzu/UHx5AuKIQZP6WYlZoAXwdPyrNf+7hQ6pUJXjE42A4F9b9Axn+OYNB+/C4JxC2TuHs6hHIm74R07lGYK9ThXX3Sq6W8cVJp1MxfyDmP0N/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742363; c=relaxed/simple;
	bh=zN7NjxhUiHxZTVKhNvDfJWvGk22VfAzWXUDgTwnbjsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7t5v8+J2S7swUJm5utu6hE0MWf2DEwqaM+2nFCt2S5Nlk8Fnnw47v6/26HtU+CxhW4XUXVXnMmcn6bEj8k167R2jCN/R2HVqh8jbnne3vw0W+OHYFL1/2I9F/1iwhNzxpT+an3//647GG7PvvVi+aZXxVdbxG17ekSvwOVOGYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IFxXSFvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WxZDz9yP; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IFxXSFvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WxZDz9yP"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1E0D111401EA;
	Fri,  7 Jun 2024 02:39:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742361; x=1717828761; bh=lV7wZSj6IG
	BUpyBJdC3V66tUw2wJVYLMp8GeQGvmils=; b=IFxXSFvvvS0/KcE2QYOmHpa7z2
	KkoYKjfI+5mtVwmeOfai4pxlXtiYGRO+dB0aciU6CGyTCHw516TpksCXvb4OYMNc
	WK1Phv5Et0lsMg6Nfxhy7YbsrbNMe8NRVNlzwJXdyHKq06a6ViBFtqfHkXsVxOaL
	OLsiNpMimzFUU98WxeVOaUANcur22rj/oiWkAUqrtDvka7GPBz1tlOX1yTz4jUBl
	mCy7Sb2xquVSPWSi2PQOTMyGNOmO4XkNIUUo5Ju4txUy3MHiNOUKtRXOOCbkt5I+
	6zhGONJ9DvNnok/4XbqQaJbjiVvuaBHXhXPh8rREmP6gyX4rSxGawLIEuGfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742361; x=1717828761; bh=lV7wZSj6IGBUpyBJdC3V66tUw2wJ
	VYLMp8GeQGvmils=; b=WxZDz9yPlgIwPks/iwwPCa2Sc0k/wn0WhRClWEeINIL4
	1K6w3YRxAnIErGRl+XCvfDEn5/jGnOUgneiwotlyg65/23wmoTR4xkr1XgW52aZ0
	WmiOtOiPfwzuqv/eZ/7JlaPXE84/6txXlSIjt5c1gzZfzZ0ds2/Q7DgnIrgtZE7z
	hkEnLW9guQlx3XK/BBN+Mi66u30X4V2CaFyy//TNqnxlmVLAXt9O2TjAfUn4cuRO
	qTFCWbELduqtKDTUJ6J4RqKpByEuN3mk+QoTif0Brm6JOzLKIeY+J0XayyiTQoK+
	cB9HbHfvEGfJOF+BB4Gt8YolWL4cLRwutf+/0D5+Iw==
X-ME-Sender: <xms:GKtiZqlKOAgVLMVEpH3D1TxNCTHjcfhZ80o8C2qCI1zUSyo5s2nhTA>
    <xme:GKtiZh28zbw5Bn1ms2rmiWRBnzOB5Pbu6Vx4ZjZ6-gQNRi8r8yxHXbZTBHGyQLK4f
    8bxp3vF8ZvSKNC5Jw>
X-ME-Received: <xmr:GKtiZop-t8L6ncHofbfGzaJX1kUwns4UZWEcGP_FvrvbEvzb8uCRkRBHUxHgAErBRL7EyXTkOkcmk_Pe__ibNNLgfIYp6euLLR-U5Z2LZ1kTTcSn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:GKtiZulI7FsAU1RMfs4oIjttUb_7uyfvgJ5DmSynaZZb5fs4CJt1LQ>
    <xmx:GKtiZo0lLO5dbZv56Hxag7qRwwQGiDzCK69RMg2KMGIAV1eiIZ_xuw>
    <xmx:GKtiZltHa3e9dlqsIaYWKQ5uK3VZsCVE13qFxqlrgZtOu_oDT2aK2Q>
    <xmx:GKtiZkW1Sl_yM_lGtShWXLuc9i59JGjQfhZnBH0PqlCnIDsF1zoEHQ>
    <xmx:GatiZrTHIRLp8pBDHRhhQ0JnUN0sLMhO5JD_tMyWXBNPxQ9H4inn8KLq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:39:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8c33d1ce (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:39:18 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:39:17 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 22/27] imap-send: drop global `imap_server_conf` variable
Message-ID: <8059e013a1fe8e60d49c5e1f435334bee488fbed.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fJP2pswuWICLRbWs"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--fJP2pswuWICLRbWs
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
2.45.2.436.gcd77e87115.dirty


--fJP2pswuWICLRbWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqxQACgkQVbJhu7ck
PpS5BRAAoPUSm1jzwxwkTRTKvRyPhDfcFl6a8FhaqSIg78sgH/OFItBZ6Bp+GS7p
iiz2gKrBcPNWzeFOw7GcXzEU0ruCsTxoubF3XCg7WI9yFJzLwKp1BR/uTDzJbWkP
hrCoA4QxhmDtqFKom16ymArpGJAG9fjHZYBXzTUqza/ZbyA00zI51ZB5IlLcx0nk
Bccl5zzXHO+GU+DyNi1orB/YxbeXNTd6ECPh95Be2wBBv7pqNmNUSCn6hAWPPYFO
KQBHJLc6pPodsr5a74kFRfXcIiYea0r+pg85BwpdI6WuDbeL5mwN3epy2z/893MO
EgShsGKUNWIotER/OPcE45cJWJBi2xXwCBHdY1xD8RuQNwLOS6++FCgqQnZP26MA
EuDniNdHdakkev627hbgS1L3ubGEddnZFJIiUuUJtlMV6PeoK9iTDzo9o2D2NmNE
EjdsoNvHipNquZfesPR5z1ml4Pd0MS6fh1vHPoy9ZX+SzJOaJoGWAXFrLR2sq+vY
xAjoYBxypuLiyvPds6z75HZeBZKBMfs8DeSHlKEdnbdSOOHHRBm4ujiW55YBeI1L
whBaOU1qEjeOFqMnR7pmeCuKJs5Qhiy7lOdqiRqLkVfHKKBzxikyQBBBusBQgtYr
sdbKueePOpE8liC4fI8YRdN1AOKcQ2IRkmRki0wprmnoZGksc90=
=RqSs
-----END PGP SIGNATURE-----

--fJP2pswuWICLRbWs--
