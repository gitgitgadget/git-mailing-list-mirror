Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD30E83CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545024; cv=none; b=tjMylzVch04WJgFI7vlE4FZaoTUnk2LTGaO4u3XaA56lKJ9hj2k5rIFtQhBTihFL0DaNI7D+y1VjcA8hX2NQttVcowAwIRgvnZmTPNr9g5LJ1pAFom8Ij4Jq7TFV0LuWSWzX+3DwYk5O/hcx7GKKk7Wnzo5Tl3KLjpiA4ohw0g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545024; c=relaxed/simple;
	bh=yUPNCcBqNK3gE9iwZ5J1mkVdrTQlAQ+hGcYIU9E1ZaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ+Vxu34OyUZ854GJfwywaUC6g7TRAtQJox6JHqWU6L7yMGyxJyFEWOuJI5D5fKoorg9W6ScMQj2q58jnqP8Gr6GMlSCtzosgS3fvyZJsboZbHTSjJWppxa+VGjZrHlmtUDkEs4XK1AEAtdkW4/JOOUS3hTtdAqw5RReYn1ZGnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DnI2jjrc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qy39Pz4f; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DnI2jjrc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qy39Pz4f"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1BBBC11401A4;
	Fri, 24 May 2024 06:03:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 24 May 2024 06:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545022; x=1716631422; bh=bf8yypvRoE
	TVoXMGOxNJsIn1E7pGHD8k/gX08L0OSS8=; b=DnI2jjrcBnXH1Qo5KakpRh4iqP
	bqAuEmE2KYb/sy5q+mM0GDNw8L1TYGLjohHuDhpeQrQgACQatOQieNnReIFjQpCI
	Srd43FnNnUYjAvFipgqor3PN3Xdwg4j7qKcM2wdhi/n4lW6H6yzdtQx5oQ4Zmynf
	SJqS/SM8CapkH1nZIadllS+lc9EEiucwS2irhoxLkTSi12MLwFTEy0jwwcmGJufs
	ScV3hGg9h5krnbkh7L1XrsLI3TEkGsRhcuYE/roeyvfQ/5A9N7XQZViD9FcfUny2
	z334bdljF9lCtzrlSzV2vFDG9bYEMNXqjeZdlp7diKwn6cbb435v6oks72Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545022; x=1716631422; bh=bf8yypvRoETVoXMGOxNJsIn1E7pG
	HD8k/gX08L0OSS8=; b=qy39Pz4fG8E9HwSjLH5Ok1GAlUp6lEzlHAJTyTAwJTrX
	jxMLnIeJc1h4QQ/JTCQPaWMWGZzrBOlLqIJMcYb7keKO//oQUP+ibGUrN/g92lNY
	fuuIzuKzYnZ6HpGLBCYxQhcb2bE2nylLetPxYp7V30HW7oaPuFCKLY9zxZ6qBwSN
	PGmtazAnGGxdOVk25P7ba+lcxLlyQr1cdjz8VgKWzGVN7CLLyqfLfCx2ghZ6+Z1n
	220QVHzA5dIb64C5SgP1hnkoYckm1n/SdRB44YV2UmsqnxuUNkzggYSu23FLKcLw
	XxR6Z0YPVfVJC2b1MvQU+YfgqyMoHOhV5fJ8VkdVrg==
X-ME-Sender: <xms:_WVQZnm9qTge-kBQrDaN1ziUGWDAK7YQp9EXcWRIK6-h_47TPU6VMg>
    <xme:_WVQZq1-AoIZxL0iWgrPkdFPUWkwOmzqSIiB9T5aX4AF_p93LNDG8bCCXtBP3dvrd
    Zc7x66mHhkj-j0XPg>
X-ME-Received: <xmr:_WVQZtq1u10aW7YmBf5YPA2wsA4oOV7a4aNjQ8E_KUC78D5WAXXnS8gevtKDZ6NbCUf73ZyzMGVhFo0yPVWbCdTmewJplWFDbpRUlOVUOSXZVnU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_mVQZvm1KYSPltr1FwcaP9EbOleafdLvg_0sQ4zyI1Kmo4gHulD5Hw>
    <xmx:_mVQZl31D6vsRea9c1MRCgM1_qgJRyHXC6t8k0us-jrfkF8tbjC78w>
    <xmx:_mVQZuui34QBWq4e4yEi8NPsgILEnt-zkUbEM3E-mxQqL_Bru5FYVQ>
    <xmx:_mVQZpUR2eybCUUC-6lTiQfP5gdaUfuayeAHgqKyhu80ddLHs9uZjw>
    <xmx:_mVQZuxao20hwY06OJPrF6bmOOrGoG2iuEXasKzsN8bSoTqLxDmVZ0oK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2e4c0e6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:38 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/21] http: refactor code to clarify memory ownership
Message-ID: <141cae2de1acb5a181d9c4f4c2a75dfab6b561af.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+j+cZXDgYSI1hQOk"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--+j+cZXDgYSI1hQOk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are various variables assigned via `git_config_string()` and
`git_config_pathname()` which are never free'd. This bug is relatable
because the out parameter of those functions are a `const char **`, even
though memory ownership is transferred to the caller.

We're about to adapt the functions to instead use `char **`. Prepare the
code accordingly. Note that the `(const char **)` casts will go away
once we have adapted the functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http.c | 62 ++++++++++++++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/http.c b/http.c
index 752c879c1f..db2e2f1d39 100644
--- a/http.c
+++ b/http.c
@@ -39,8 +39,8 @@ char curl_errorstr[CURL_ERROR_SIZE];
 static int curl_ssl_verify =3D -1;
 static int curl_ssl_try;
 static const char *curl_http_version =3D NULL;
-static const char *ssl_cert;
-static const char *ssl_cert_type;
+static char *ssl_cert;
+static char *ssl_cert_type;
 static const char *ssl_cipherlist;
 static const char *ssl_version;
 static struct {
@@ -59,23 +59,23 @@ static struct {
 	{ "tlsv1.3", CURL_SSLVERSION_TLSv1_3 },
 #endif
 };
-static const char *ssl_key;
-static const char *ssl_key_type;
-static const char *ssl_capath;
-static const char *curl_no_proxy;
+static char *ssl_key;
+static char *ssl_key_type;
+static char *ssl_capath;
+static char *curl_no_proxy;
 #ifdef GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY
 static const char *ssl_pinnedkey;
 #endif
-static const char *ssl_cainfo;
+static char *ssl_cainfo;
 static long curl_low_speed_limit =3D -1;
 static long curl_low_speed_time =3D -1;
 static int curl_ftp_no_epsv;
-static const char *curl_http_proxy;
-static const char *http_proxy_authmethod;
+static char *curl_http_proxy;
+static char *http_proxy_authmethod;
=20
-static const char *http_proxy_ssl_cert;
-static const char *http_proxy_ssl_key;
-static const char *http_proxy_ssl_ca_info;
+static char *http_proxy_ssl_cert;
+static char *http_proxy_ssl_key;
+static char *http_proxy_ssl_ca_info;
 static struct credential proxy_cert_auth =3D CREDENTIAL_INIT;
 static int proxy_ssl_cert_password_required;
=20
@@ -112,7 +112,7 @@ static const char *curl_cookie_file;
 static int curl_save_cookies;
 struct credential http_auth =3D CREDENTIAL_INIT;
 static int http_proactive_auth;
-static const char *user_agent;
+static char *user_agent;
 static int curl_empty_auth =3D -1;
=20
 enum http_follow_config http_follow_config =3D HTTP_FOLLOW_INITIAL;
@@ -381,17 +381,17 @@ static int http_options(const char *var, const char *=
value,
 	if (!strcmp("http.sslversion", var))
 		return git_config_string(&ssl_version, var, value);
 	if (!strcmp("http.sslcert", var))
-		return git_config_pathname(&ssl_cert, var, value);
+		return git_config_pathname((const char **)&ssl_cert, var, value);
 	if (!strcmp("http.sslcerttype", var))
-		return git_config_string(&ssl_cert_type, var, value);
+		return git_config_string((const char **)&ssl_cert_type, var, value);
 	if (!strcmp("http.sslkey", var))
-		return git_config_pathname(&ssl_key, var, value);
+		return git_config_pathname((const char **)&ssl_key, var, value);
 	if (!strcmp("http.sslkeytype", var))
-		return git_config_string(&ssl_key_type, var, value);
+		return git_config_string((const char **)&ssl_key_type, var, value);
 	if (!strcmp("http.sslcapath", var))
-		return git_config_pathname(&ssl_capath, var, value);
+		return git_config_pathname((const char **)&ssl_capath, var, value);
 	if (!strcmp("http.sslcainfo", var))
-		return git_config_pathname(&ssl_cainfo, var, value);
+		return git_config_pathname((const char **)&ssl_cainfo, var, value);
 	if (!strcmp("http.sslcertpasswordprotected", var)) {
 		ssl_cert_password_required =3D git_config_bool(var, value);
 		return 0;
@@ -440,19 +440,19 @@ static int http_options(const char *var, const char *=
value,
 		return 0;
 	}
 	if (!strcmp("http.proxy", var))
-		return git_config_string(&curl_http_proxy, var, value);
+		return git_config_string((const char **)&curl_http_proxy, var, value);
=20
 	if (!strcmp("http.proxyauthmethod", var))
-		return git_config_string(&http_proxy_authmethod, var, value);
+		return git_config_string((const char **)&http_proxy_authmethod, var, val=
ue);
=20
 	if (!strcmp("http.proxysslcert", var))
-		return git_config_string(&http_proxy_ssl_cert, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_cert, var, value=
);
=20
 	if (!strcmp("http.proxysslkey", var))
-		return git_config_string(&http_proxy_ssl_key, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_key, var, value);
=20
 	if (!strcmp("http.proxysslcainfo", var))
-		return git_config_string(&http_proxy_ssl_ca_info, var, value);
+		return git_config_string((const char **)&http_proxy_ssl_ca_info, var, va=
lue);
=20
 	if (!strcmp("http.proxysslcertpasswordprotected", var)) {
 		proxy_ssl_cert_password_required =3D git_config_bool(var, value);
@@ -476,7 +476,7 @@ static int http_options(const char *var, const char *va=
lue,
 	}
=20
 	if (!strcmp("http.useragent", var))
-		return git_config_string(&user_agent, var, value);
+		return git_config_string((const char **)&user_agent, var, value);
=20
 	if (!strcmp("http.emptyauth", var)) {
 		if (value && !strcmp("auto", value))
@@ -592,10 +592,10 @@ static void init_curl_http_auth(CURL *result)
 }
=20
 /* *var must be free-able */
-static void var_override(const char **var, char *value)
+static void var_override(char **var, char *value)
 {
 	if (value) {
-		free((void *)*var);
+		free(*var);
 		*var =3D xstrdup(value);
 	}
 }
@@ -1233,11 +1233,13 @@ static CURL *get_curl_handle(void)
 	return result;
 }
=20
-static void set_from_env(const char **var, const char *envname)
+static void set_from_env(char **var, const char *envname)
 {
 	const char *val =3D getenv(envname);
-	if (val)
-		*var =3D val;
+	if (val) {
+		FREE_AND_NULL(*var);
+		*var =3D xstrdup(val);
+	}
 }
=20
 void http_init(struct remote *remote, const char *url, int proactive_auth)
--=20
2.45.1.216.g4365c6fcf9.dirty


--+j+cZXDgYSI1hQOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZfkACgkQVbJhu7ck
PpRGNQ//fEox08NXJmFiKE+iSqQDe2R8rGWqvCgds5D32uTooIYsha5kK/bLLtmz
LNg8orqo8oOvTtkvjKHc6n4oeQtkcTJOJG3ud7kJTLLyxEOpDaMOwfY4T9053UFF
/WRuzk6lQUcnzLWBKkMt+ac0uJZ19fNDZtmvahVhlmAymXbg5bIbCMrPM82gtO/X
ZZY00BrX6ADGNpHpZcT+944sfx1uxXa4IHWJzK2ZiAXeIdNPnbHt1Flx4CkXJcTN
lcIr0H1wAlDTLK8gwmjbe8DQUAu4MtU0dIlvyWs3LJdzobruvZqhK8CzfchwM4Ug
zjJHLspYsmHJuKwii648RBm41VpBmLIAaoFeUPNIxgV/1rdmo2dv7ldA9Ls/Cala
yoFBHCRqs0UOhqRL2jSlIOO26TteO0UkzhA2T3uwgZP2gyOLYIWiUIIVW6yyctbL
peqCD9x5UnvgGz2lRvIMRlsakbq1dINSspkk1slCxhbolvdBftz/5dRYkQ693XMp
3MBlQi5fHwR2jNKEmlvVL/aRFcFKrFhhiZepfnlRBflmnSM1lYOgdJ6GuNf0tsry
fvE6aALpKKK3QHBYobryTjHlNmWVR3D3HQjvTzMeLb4dR8cxi24Dmkx8I01xGeOh
C3w7q6e9nwk86ADNwf2Mc/M1dreu3WswEFmbZBGn26ZHkLCHAFU=
=/FBi
-----END PGP SIGNATURE-----

--+j+cZXDgYSI1hQOk--
