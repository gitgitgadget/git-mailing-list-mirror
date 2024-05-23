Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED313BAE5
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467126; cv=none; b=WcO163r7+vDMMy6bREhxMGo2NoInIePMEAvJ0NN0qYEavcBiGAQ5YZgThTsLGhh/v72zlbmTSR5+75ac0BvI4YCaOSdtAtj7SB+F0nyh9h2an+aX87iIQyJOg9c3M26UkLv2sgNYsYxCRgSlUNsO+a2Ll0aY9xNWfUyeg/RYeRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467126; c=relaxed/simple;
	bh=sAqPMSY//LZgoTsx1GHJR5vbmrBu7tSgWqO9Wla8lJg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O688f7Gx8EBK+8+HLG3UZCwS1hlyooDsHVMi/qoZKTFPSimiYakhQvKuXxWrCODv5UIsZmHtd6qd1+IfbxPmJUU34/MPNn6Ql+pBQKkku6xItzXB8iHnseXs6hJ4QLwsjAnRR0CdP6ediAO1weVBfL+uFs+ddbkWZg0HyPGY5kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f8lkMnfp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YTsrjtBm; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f8lkMnfp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YTsrjtBm"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 2272D1C0012D
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 23 May 2024 08:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467123; x=1716553523; bh=7UkbvsuBDV
	rSzzP/YRLbZon0GR2MxDe2a8Sc9eEzH6A=; b=f8lkMnfpFM0IuYgIyDKwcgXw+0
	8ppXdx8bYohbA7NzTPxiaYF0+GHTZO5QgnlYUVW61GBrGlEQd32x84aZqXcUfZfD
	yt4qXvLREY7RHTBRgDIFAgZgQdjzKO9bYaAqqEYJtAKCb9CzP7oAIyu7ZnBgbHPM
	K1RmxQQ1okQCSczfC8Ru9LS243vD10Kg+4WFsmB9jBYNmReHNL/HbBHnzp/WJ8q1
	+XoOHiobuF0Z1oy+Tgha2F05Q0FZ3pRq67HneVPKZuwyuyqQlZ6PR/aHDt8CjTx9
	iLWtyLcGoaNhD+gaJsxlSncDEw8EQuy+5KhjdhSad8c9y7FK3jphekfNibaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467123; x=1716553523; bh=7UkbvsuBDVrSzzP/YRLbZon0GR2M
	xDe2a8Sc9eEzH6A=; b=YTsrjtBmAaPrIUjULMZhSuPQAo94ZhWyQySpuyJK0XwH
	QBZ0wUzMeb/mRnBLKfb2WwCJPWvisKIaWmnskJIaE6XBkBfoC/2vjpgjx5TQlbQj
	PKedmSjH+BiBPcto697tmWC5QzIo1X6dAYNDXfrN/XOXIxwx+atgfpiAAXy3qXJD
	bJPEdZqNpo8lcpJltEZpEoD7+wapP7gp4nsfygG6DGDMUruIeetHfbAxb8xhvWa9
	7Gr6/txYeL3n5LnMgNdUVGMZe+wmNUgpAmN2Cnf9RqU+WKK5ArAzd54CXSuMQeTD
	zb7GHAUCf0/95iXw8YMp2zP9Oa64xDjmtitkhvkrAw==
X-ME-Sender: <xms:szVPZsTJrWr4kMeDcwRVEr5DTBpAdekeThZk3Eu6iGZBQN-u3cT71w>
    <xme:szVPZpwc6898X5LwEVizT66FaEQ6DwtP8h1auBTxFQs7i66eWidMG7N8hY46OKRnt
    wEJN8Sgl5duvDH1cA>
X-ME-Received: <xmr:szVPZp2u_2HxhQDuCwR5ws-jfcBR47E4fPWzfKnicraxQW0asvZHbvNCqgX3kP5eFNHPoJRgUTtxut4apRBPs05LPvUQDq7TdqvdBXfDddTpJi9EGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhephedufedvudekveetudehveelteekgedutd
    dujeelieeiheevtdeifeelieeitddtnecuffhomhgrihhnpehhthhtphgurdhshhdphhht
    thhpqdgruhhthhdrshhhpdhhthhtphdqphhrohighidrshhhpdhhthhtphdqtghurhhlqd
    hvvghrsghoshgvrdhshhdpthgvshhtqdhlihgsrdhshhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:szVPZgDTXdQUzWzA8zGLWJSByfWgB4g00H8w0BoqAJ5A943LxzOB7A>
    <xmx:szVPZlibyHdTsy5XgqIFODXndtGPuXmhjq8j8IawIPbbSPPL2971xQ>
    <xmx:szVPZsrQAUKOkZsz03xZI_fPH408nYNwAOgeALeOke7oWGpBrZJ_xQ>
    <xmx:szVPZojzMNWugZqk3AVFksIktBP2mMcNi4msKXjKDbxOcqY9ML5Urg>
    <xmx:szVPZlY-fECsUZLcWZiCiDJDIq89OWcGeQeSaurbC7ZQpQ3e7zzW9MWV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ab52949b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:16 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/20] transport-helper: fix leaking helper name
Message-ID: <05fbadbae2184479c87c37675dde7bd79b3e32ab.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W+z9vccuTVELJhqg"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--W+z9vccuTVELJhqg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When initializing the transport helper in `transport_get()`, we
allocate the name of the helper. We neither end up transferring
ownership of the name, nor do we free it. The associated memory thus
leaks.

Fix this memory leak and mark now-passing tests as leak free.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0611-reftable-httpd.sh    | 1 +
 t/t5563-simple-http-auth.sh  | 1 +
 t/t5564-http-proxy.sh        | 1 +
 t/t5581-http-curl-verbose.sh | 1 +
 transport-helper.c           | 6 ++++--
 transport.c                  | 1 +
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t0611-reftable-httpd.sh b/t/t0611-reftable-httpd.sh
index 5e05b9c1f2..2805995cc8 100755
--- a/t/t0611-reftable-httpd.sh
+++ b/t/t0611-reftable-httpd.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'reftable HTTPD tests'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
=20
diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 5d5caa3f58..4af796de67 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'test http auth header and credential helper interop'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
=20
diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 9da5134614..bb35b87071 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D"test fetching through http proxy"
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
=20
diff --git a/t/t5581-http-curl-verbose.sh b/t/t5581-http-curl-verbose.sh
index cded79c16b..724f610054 100755
--- a/t/t5581-http-curl-verbose.sh
+++ b/t/t5581-http-curl-verbose.sh
@@ -4,6 +4,7 @@ test_description=3D'test GIT_CURL_VERBOSE'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
diff --git a/transport-helper.c b/transport-helper.c
index 780fcaf529..9820947ab2 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -22,7 +22,7 @@
 static int debug;
=20
 struct helper_data {
-	const char *name;
+	char *name;
 	struct child_process *helper;
 	FILE *out;
 	unsigned fetch : 1,
@@ -111,6 +111,7 @@ static void do_take_over(struct transport *transport)
 	data =3D (struct helper_data *)transport->data;
 	transport_take_over(transport, data->helper);
 	fclose(data->out);
+	free(data->name);
 	free(data);
 }
=20
@@ -253,6 +254,7 @@ static int disconnect_helper(struct transport *transpor=
t)
 		close(data->helper->out);
 		fclose(data->out);
 		res =3D finish_command(data->helper);
+		FREE_AND_NULL(data->name);
 		FREE_AND_NULL(data->helper);
 	}
 	return res;
@@ -1297,7 +1299,7 @@ static struct transport_vtable vtable =3D {
 int transport_helper_init(struct transport *transport, const char *name)
 {
 	struct helper_data *data =3D xcalloc(1, sizeof(*data));
-	data->name =3D name;
+	data->name =3D xstrdup(name);
=20
 	transport_check_allowed(name);
=20
diff --git a/transport.c b/transport.c
index 0ad04b77fd..83ddea8fbc 100644
--- a/transport.c
+++ b/transport.c
@@ -1176,6 +1176,7 @@ struct transport *transport_get(struct remote *remote=
, const char *url)
 		int len =3D external_specification_len(url);
 		char *handler =3D xmemdupz(url, len);
 		transport_helper_init(ret, handler);
+		free(handler);
 	}
=20
 	if (ret->smart_options) {
--=20
2.45.1.216.g4365c6fcf9.dirty


--W+z9vccuTVELJhqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNa8ACgkQVbJhu7ck
PpTWVg/9GxfsyrZnNCdi9R9wwhBJ0aVfMVThO9r4QbrgpK41btbdQSJYQOCMnDxm
RaDq9CkzOhE01vXasSVda9Xl7hKWjRSCL5R7JNtxwLwARrEQkolZ8B2xY0IsYah8
KGhfeGfNF9gvU3s0W5aGG80awHkjbanzZq1uBJYCgpGBknyZTTkS4NHG2kpSAhKZ
JibolhTArBW+8qPcYutSUwVcOsrwsA3UCYaaejss3H4n3JyG+l45admEcluNE3qD
9CozDtRM+t/l5J5lgmRyd/PwM7oa37vjP4gS3L94EXBgAMX0KcabAGtssiq7XGjv
Vv3Gz/e+T8YBq7b8oka7xAYmQYmrYmISQb5a7H67GrgGeVcRo51h5kVw7gYpvrqc
W7Mu6svaSd48621o0KtVzq9VVTXntkuDYCZuw7zjWGNAoDHhFIBJJ8wgIEPsj5Vy
DlDp8ixs2ben+JGp29khZvGvCWdInyn2gxnMKxD8QfAxdodVYzZBlaN5GIQtCnRV
cGoeo6sYpwIStpwivquUpRTr4/bqIVZc75GQAhvNUs6Okiu/TDKfjoBM4MccVH7/
lLrVg/OSRbP86Fz5tYOOVBN+az9SdP0i4F4c4Arw5uc6sgT46LG9Np/vopWNaifL
DWcuzlNtsIQDkUaNOzSR5f9rkIRRda8Akq3u29V8dXuiFu4eLwA=
=wGMN
-----END PGP SIGNATURE-----

--W+z9vccuTVELJhqg--
