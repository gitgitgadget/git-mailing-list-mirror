Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FC2146A87
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504725; cv=none; b=SVW7FuMIY1r16JIPHO1R3s6Y7USWdLDbnNsTDmWqcjq47gFJ5ptYXNv8++t0stR5OQh76NwbA+iUxIYPB/ZXe28q7RR9hK5P+yoqe+LYu0XLYz+tr9E0lpKHJMSxMJffyreZv3XK2sYdmjeyEfyoWfznrBPCLhJxUAnuixSDHqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504725; c=relaxed/simple;
	bh=gpL/3vUMsWS2xG6BkRYJq0lx+M1+pFPeuTwVmSC5/YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lEMqyNH4J2fTkRzFkXPrwUQ9zODInaAuDBVvYRU7zGZn5d3zSTnOQAjrHpi3S06BbshB4TGCEZNpbEh4wryqQH/7GipNgne71Ijs+JYLqzoyTOkUu6mC441ymkDTR60LkpNVR7aD3VzY64aqAaaE7NB7joSf6iz8m3CTCvPdI5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=maPRtBCH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjAkHW8t; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="maPRtBCH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjAkHW8t"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A405C114014B;
	Tue,  4 Jun 2024 08:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 04 Jun 2024 08:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504723; x=1717591123; bh=kSdABcTlIj
	mZqrbYaRFciluPU4SDFNCK9phJPC/3v1E=; b=maPRtBCHiDzJ4YTadKEpRurSuy
	yKTh6y52B3Fgi/52DNwNgvDeWLZEsWWvMJQCvzByUPZ8wjWCrN5X0VpfugdTo+zh
	x8y39msJnLeXWAjFrPdGHnhW2MD8RE+omn8zOQA/NQZD8d/nu9ACw/X4YZ05iPgb
	DjzLV09xI8oKhdoA7oRJ00OJh/7ZJLgyIXeygAwxAjQS0RAEro+7SL4FQBWVvGFF
	LeUoD66Mkm3+QsvVXr1wYksP/lpqv825BhzRJEvPlMqt4lWf2syFg8isnm7NicHP
	aaXI8pgDuWZomJndViYOcUoJNGZ2AdoYkM/MuL0zk4d+r5qJW7Jea3dIMvPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504723; x=1717591123; bh=kSdABcTlIjmZqrbYaRFciluPU4SD
	FNCK9phJPC/3v1E=; b=EjAkHW8t93WJAAV10udW1FH7uce05JfK0nkmkIDObyoT
	mFhDZ9zbH298gUvxCVQunIafDAkqTE9yhxUQ286Ti9MjAOyCEftEC6Ep59FA1Pml
	koNF3XPfq5kVWsa28RNT4c9V5SAs3L6XtZE+vXEH9K7xnC05bxjPbqLgXBUPMe/h
	ncvIiFC3scFyt8coqhws6xOBKMfUfJDkgBCE6FIZi+S9cDktmICUNZtoPVCnxVXZ
	/2AuSQOy6PZl1CFS/f6nSWcc/sNFcru4rsPfrBVlLsYneWt+YmHxACtI6HAq/SRo
	Vd04Z+JAbHAAvc8tT+pQhM7iGpOeWKyDmVSZBVlMLQ==
X-ME-Sender: <xms:0wpfZqR6HB-YmkMzMbIsWPv8tBWcC3-cUT5XV5PUR437Ns2pLFkZiw>
    <xme:0wpfZvyrdWQpmr-lUD7pi42yMx1xPItiVTmV4YFpclxcG1X9egn5UelnuXX9HcAN3
    EZYQH8NsujDInpEGQ>
X-ME-Received: <xmr:0wpfZn36ToqwICrC75AA_fmd5Vq3F2A8eE6z4mLG6YNBlfVFYiEBAQNRbu_K9bwotW3MyUfNp0QE25K5nulElqdyb9PFZMwdXRQtZU9N6QCPzmB7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0wpfZmBhzG5rJ_20hRrCiPYdAvTgxl8_MhIhaySGtrBcraLSJRdvew>
    <xmx:0wpfZjh6RQ2moqKEBNnMUeLIBIKZRLxfhcRzLB0aj6bvPCpL5zpfPw>
    <xmx:0wpfZir26c7t7PVmgvvNtfctsziSuMg7AOkr1rgxB-WOFfH8nw_Jaw>
    <xmx:0wpfZmgdHRowPbeYENwJayvbMXfa99NpUwQPaBadD219aMyES_ClDg>
    <xmx:0wpfZjfx_Z9daEa2cdZc4abPFhRIGWVoix7jMUxVQMQYASmkFmXAHiVe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c596fa7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:38:15 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 22/27] imap-send: drop global `imap_server_conf` variable
Message-ID: <0a69ce4b444b2924abd9275ae75f00ac2d545aca.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7t6GwHB6hxaHQcDs"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--7t6GwHB6hxaHQcDs
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


--7t6GwHB6hxaHQcDs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCs8ACgkQVbJhu7ck
PpSOMxAAj8WrZOfQ8LllEKUttjKyH3KBQgzrEjxbh/e82JFzpF7pH8ElTOvpKVww
7FB3raGd+cxOhaHTv8GqZExE3AG8eG4CsZGXkx+rD2eUhE8lf6UOlxpnWqidnqM8
qVUB5RjpgRxuMW8SYtQ4/P2w5ABsEPSLLcjgDSicYhTFR3b521NeV0wLhabR9x6+
z3Ar4Zp4b/pkVGPletJDH57OcaGeEf7ED8lNd2nMfDYWmmR3x395khHn3TPLsNF7
Grqvdt+mURYcMVkuOTTQd0O3hJZfefLxo8/LRaDKgvA3DfzVQMW1h9M9s9vapkE1
GxyRt2wtU1p5LNw8gdtWa3Fio8yNl21q6+cJvGpWsYjWXBm7/UqAlfzhdp59G3+M
sNfVrc0K4J+vnJC/xgznKR5vpfUe2NMRVGOcK4P9VcQBx/EkLmBSaD1kq2IVFX5c
kfD1UyNkCwniDwRqzCYpbmcZif3avlFj68fvT7g4YPxVv76GKGDPGujLk80rPxAX
672qPDacSdCDjLnzmQzOGm5+z7i4wmvZEE1wsbHjxd8dV/Vj9OSlvNKId8E7+WX4
2G04vWcxiVUK7Y2+EB33eWryNLsXppi2oUM19krJG6jcU9/CMhBC1A9zSuDCRPDG
LIKVqbuuxjoDE3ftDgLxkeTbkP8ydvKSskq0++qfz7LdpMBO61s=
=HjmY
-----END PGP SIGNATURE-----

--7t6GwHB6hxaHQcDs--
