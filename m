Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A52384FAF
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545010; cv=none; b=ugaJo5sfwvAh/p4JdYc6F3XLAnjbqRN25WtkaS1NZakskK9HrrWMYvnCCsKa2jTxEm7THzh8zt/tGSwuRSKNnJJR1zgFhc2bwa2t8JbyX94v6LaHgGjTtpuLhpyB6FDZ+iirgGMFgCowOpaXcZAmpmjrhfWJlmbnKpi/Ah9xstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545010; c=relaxed/simple;
	bh=ltG1kpkZD8nRDs3l5dyJBakNE7n8BnekE6fzyJDQDHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DVfaSFyw28725n1DRKv9zYSsissl6t5GkepVq200YaMdKIdiuYqnenTFRVL8K4nhd3EZkshf/RC180o4ZtAOd4irUK7FNzgFaG9xt6RKXhBwsV2/ot+q5liWACDL4Sax/Bh3sZTzKgBSduM1+Q3mJHfsuuqup3KrgmT6BArvfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LtIXc6hL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H3HQc1fu; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LtIXc6hL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H3HQc1fu"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A40221140189;
	Fri, 24 May 2024 06:03:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545007; x=1716631407; bh=SR18zO6rtS
	BM5OGuwF0i3HmeH0AtP4IALKxFWIhAHEM=; b=LtIXc6hLQAebd4Gn5ALzRejfkv
	kXD1+ur34eB41aeEVRaFqL7JecrBvci7isIBQxG7oPPQPqqCFH9pAxGaatAc7JVJ
	1srgcSvtE5iMctC/tEmzrmD5zqYpBN9UEFvrU+l5pu+jLNz+/Dawu5RKu43qwOh/
	se2N+aOtXXjEGkQJBNyUMy8xp7BSvVEGkHqqPRoHFI7hncsdHfL7wFaNQEBwbuH3
	GO7lV4ta05lpUzHCU/oM5UGW48Nuarbe3/ETmSCGlJ0rSJy1vnXCaft3/7PonCx5
	C6ndTvbDxd66lPoQvBPQ2HvXt+Fav0ts55EWxNo5b6f9zJpga1fg3AlyIjgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545007; x=1716631407; bh=SR18zO6rtSBM5OGuwF0i3HmeH0At
	P4IALKxFWIhAHEM=; b=H3HQc1fuZVmhQ/yAz3Bk6XWS3k2Ap2dR5HBgMwPr9OYM
	4e/X5NzsuTRRq20yftPtZiV0kDRl/w/rc+65KqXwQGSSAyplaQMDDoBc8yYZdglO
	f6wMv+rxD2SXAxOZm+ViKmeP8a9RZeDlijzsWHv5FaaWkcNp75NBBVqdhh41dkCl
	aqKcAv8jmfs/bAzczsF6meMKBncgvoHss0pLd6fEvrbp+njevPmE03sUtkGeX2wZ
	CCLyWqG90T3Eb2KCRJJooaXXlJhP9I8hvQJg5zIAONYqWCR+p3ppEuok81Usjm4v
	7VuTUE+2ePewEKeozx3myt71kMUR/Mt9xf8KrXz3RA==
X-ME-Sender: <xms:72VQZgQffXOCSWfUJHcnoDd0FSljy0HQHdhuwuSfYLH9x-XNhKIS3Q>
    <xme:72VQZtzoye01Q9Vy84RXJTPggpgh_awXPz8ukle-w-Gd0XyYSK_2B8tozJ0InF--O
    r6izf26vp1yDC93eg>
X-ME-Received: <xmr:72VQZt0lXhARm7PU9mVANKq1613XJ75soOGlFHD0tXmNdb9IYVu81lhN51_7BbiTdVDlzHcogAiYArSUZxcvWETXiZBbZOGff98O38uHvSq0De0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephfekheevlefhteetheelveeujeejhedtueduvddutdehheefheetvdfhudeviedt
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhpdhhthhtphdqtghurhhlqdhvvghrsghoshgvrdhshhdpthgvshht
    qdhlihgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:72VQZkAZumD9gaCQi-05NVExb-rXb36ZGxXsvI-IstiFq9g383TrmQ>
    <xmx:72VQZpgEMGX9fj8-BRyUL41l5O1-Eng6OsLypCSvw3-30xajz_pCDQ>
    <xmx:72VQZgohmcaSSeGBb_2xFN-a_BE-4RU50h5AQ1NburZ3Ug_MyR0hoA>
    <xmx:72VQZsiet7YTqhRQtmBdACvLTFl1vJYUr714ubeXwXJgnqsXjh_KlQ>
    <xmx:72VQZuvdXJfxlJVLtF9CuqvrZj5u4EoM-Jgvv2FUoT6dtFo5hZrjeCfT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 96c8d73f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:23 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 03/21] transport-helper: fix leaking helper name
Message-ID: <a96b5ac359bae75ffe30f9549a231c971d883e44.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ys9EzrXm/jNV0Ju"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--6ys9EzrXm/jNV0Ju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When initializing the transport helper in `transport_get()`, we
allocate the name of the helper. We neither end up transferring
ownership of the name, nor do we free it. The associated memory thus
leaks.

Fix this memory leak by freeing the string at the calling side in
`transport_get()`. `transport_helper_init()` now creates its own copy of
the string and thus can free it as required.

An alterantive way to fix this would be to transfer ownership of the
string passed into `transport_helper_init()`, which would avoid the call
to xstrdup(1). But it does make for a more surprising calling convention
as we do not typically transfer ownership of strings like this.

Mark now-passing tests as leak free.

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


--6ys9EzrXm/jNV0Ju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZesACgkQVbJhu7ck
PpRcWA//WR95COnJRo+3DevSjOMP/npNz+eawLG9sj2m3VfS/wI2hJQU07mHi0PK
JyZzg9Fp/GHzVd8PB7wwdE0oSeEJljRn8ikO6Y0by4c0n+AKR+P0V3JO487/NvWx
Dr0mahaBGQeQTJUEzbCavUFwJPaot+ciuEtdf5rM1+kGmJfp+DBSJ0Mek+Yaosd3
Ini7ErRYvYx4eSE5C1OxMc85bM9ZTg7hI2h2a2CFD0YxfPKeCQpG1N18JbRWAN8l
DV85w198CCvGgjRFSR2MxltK9otCVFT1uOrNJxgEFdfwj/41TCw72k1rJ0lSNdKn
d+ahbExt23grXMDif4tkifMVb09EhfI5mTWwbcVeGs22anaVYKKHeSIXsMGYXSFq
6lUwf3pI00k9yhEaqbptxA/8uwENfbzRDmD29vT1fJdu7u15do2kDrWJkmzCdRVH
RQoU3NE2aX1JaKBkXwt7cIcD/ZPUb3mzh8bmaBlHLsJiGqev34p1bDNKCPtRReF8
9OT8fYv4Lv2DqAK7vezf/hdhQV8CEuug2qORjJXQKaSTrBbaVyBkainzMERfxsPM
pRhudeNNeZ6tXptiNq29gkJmb28yuszbp5LW4mWWK78Q/ZrjMvThCgDGTyC7rpRn
Qgn2EjaRO+tgybLzuICZP0geDmlrrbHZN0qCdCepH3x0k3aQNn0=
=7DXd
-----END PGP SIGNATURE-----

--6ys9EzrXm/jNV0Ju--
