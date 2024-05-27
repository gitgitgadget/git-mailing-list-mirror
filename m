Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8888713A3EF
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810377; cv=none; b=lM59pPKZ3zJKQw4DxTZlbcwvOhenv9kM+O9PUd1kAjryYw9rOOoG9WXm9CXNqTkwaxJDtfiL4gKr1KuIMlvCWhdcC4nziy5wheIkskW0MjaRzn1q1SZCcvQoD3q5bVuqdt1brtztJEhcy6oTUeshqkCZC7p13LNRUPKwp6bQDSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810377; c=relaxed/simple;
	bh=U0Yq52foY48be+fBFT7baqopcx2545LLpwhy5dtwMRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk6E0uDXh3DJfevbXvGN/brL4JR+h2qKvnAME6PWbEphUpUoWpmfQzu+4pWYaLMyvKmYfK54P8Tpcl/g/CXakErJ/BTpjCaCzqcG8N6pqXH+s7J54JlfJfIBq23sDajKjfEHMgP8AFpe5yR7KMeyqzWOXWfdmWnvA9bWSgaf7xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bLoGbyxe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gRbOc/U/; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bLoGbyxe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gRbOc/U/"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 904AF1C000F6;
	Mon, 27 May 2024 07:46:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 27 May 2024 07:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810374; x=1716896774; bh=UWjcAxfkht
	tcxfGYVLFLS2IFnWFXcetmGCVj1Cy1ZAk=; b=bLoGbyxeGMOo7eeWhXsdryqyMC
	Cu4u4U5Afsg/xCPESyleWuYJwjc5YuyJL9B3ed7kq//5c/3VhapBXYSB6sm7tCHk
	zL9NOUE7fug6ztOBbQNNv1hY6IQSdAifRpy2fU/SCiRri2+6ggIzWhcidsPja+pp
	A+TkV34pEZv+d9uFoiylpdlQHyyuj8nYS02aTe/29Uo70+TbvXcqrC6lPkZLtsaD
	h3vimjBbMEa2WVftc8lJdWHxBZ8cmpSErsnjwB/PM9+zVVdlPVQgzkRSI3NEfOdZ
	+xFyx6wpVdwaAMbxdk3bekx+ZcpnimJDps7o5h0oRN5pV7vijPVdnClQuDaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810374; x=1716896774; bh=UWjcAxfkhttcxfGYVLFLS2IFnWFX
	cetmGCVj1Cy1ZAk=; b=gRbOc/U/ATT+vjAop0la8vMP0vRwjY2VwTtWxOY5jXVM
	PdlRhwmnraLlDUCpXoIo7hY4jtZ6bAV7ezjxTl4Q+Da/aEGzldun//9KQLiLDB/f
	slccYiViAt1/ilWwn0yrH5DhyLEjKHlH1FBIPFF4K1AZaC0H1wIAqNN1SN2Fs4Iy
	XYFS7/2F7+ctbNGiAe0OS6SV6KebUR9J9jaaXhTplp5KU1S8rNFcEeQZ/5H8Wgk1
	iunP87phklzVBirn5zhwyf/L9LOwNqsf6fPz8XHqxEY0l0fKHRmqj0aT8At4zJJ3
	zR69Oea+zupeTR66mJ07eXbyO75C8RjtFQ9NLDZH0Q==
X-ME-Sender: <xms:hnJUZnHJo6FAWVm_d_z9KPJsCsZ_a9E5bkjYcRwUfjskoIXm8C6itQ>
    <xme:hnJUZkVn2vNuVOVksB1L22jbKvTmcRXaFMUfJ8T3v59kVIVzPbDbwSODmPmcsgn3O
    hCtN8Arpr9Gzv4NUQ>
X-ME-Received: <xmr:hnJUZpJOwg1Bif_MLcAByIPtM_t69_vqvmnd8-Ax_nKtoiqgKuWXJ0EBworAMFUueT1O9gcLjm_cM8KbXJW4EzHPa4CpvNCMzNigcra9_FY1cc1YJoo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hnJUZlEMzr24hOlrUN7ClWLAL0pHjNcoDmY60wABJENjsyT7OVD03w>
    <xmx:hnJUZtXIu8SkOvJoVV5_FVrM9jpf-R0XkJj9_1im2EYqCuMsupX4Lw>
    <xmx:hnJUZgN9ptX93EbSvR7Lq3drLTKKW_QeqnQVyZiGdsEyufp_SIutnA>
    <xmx:hnJUZs19ldemi9j6TdtWHTEByVc0lx7qJ1o4zQ5SysaTb45nfXQRNA>
    <xmx:hnJUZrecwSEb-NVEkue-pwxHuG-lOlfA0ldtZMBZUVj3PhomfbQ-Jy8B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5c610e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:03 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 06/21] http: refactor code to clarify memory ownership
Message-ID: <fa91a3942edd2c26389a25bb2a5c1737151e7c12.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/+LqOqW05K904s00"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--/+LqOqW05K904s00
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
2.45.1.246.gb9cfe4845c.dirty


--/+LqOqW05K904s00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcoEACgkQVbJhu7ck
PpRZJw/9GrsUzRXukgbSc7gr3FXpxfWxjlYxV4LTWbAq619gKV4PlmZHxJL8YHtE
ojjDt1TNGEryv5sGkHXvKCEJq3FUrYY0AmhOADDhp45W3BA0JYxZEQpSvPrcs+xS
HgPzxfk4GS6gC3anyUFp1gLPM+C8Lc3337IKIHDuF06Fbik1W8E5NQCPmtpnawnS
dPc2/Kd52Z4Wz4t27VhMeg8z8V4DJXQFsbD5HM8HhGT8rXw57kj2m4n+M0xB+nlU
Eana7gABQfvpzOyapYcRhDgn44XJYPjlw1XciZE8ekG9p+RSFuI82ibCvIW33g0B
uutMskiksgsbJbJVNFZGCMLGG8SIXHTF9rgg1hBalhMwnMB+QSaLbbMlGZmFqieo
y1WQa5uu3fLQsXIJZgqjH+1QM+vuLxHWPOcLxCNzqo0cvNzQj6M5iJC5RWIdeYoA
wUCiWEpEJmRoVGA6ASmKBwRrFPz2mqsoJR7Vwcy1c3Wxxw2L/Zz3WpGWX3ZvF9sW
s+g0ysqI2xhGFHO9QZaaNPS42tZvWzrloOMkrEP/cVGlri63cro8hSZDfFifZ+Np
IWW8/N/zxxiCED8WvgBN86Ngahfld98HeoN+dalY6MZdvqNaGMwnW41C0jm3OIOT
adnfLDBP1upYX9OjipuLWJdz5gNfQ+hv17GzguIYLsM5srBmVow=
=VT7P
-----END PGP SIGNATURE-----

--/+LqOqW05K904s00--
