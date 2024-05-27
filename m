Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747E7152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810364; cv=none; b=fjtl9PuI2O+azKvaKXU3LbtlZBTenguaXgvQkP/tMz4t/imIyPCkl+kG1sb0gkfo5rbiigXXnNJfXuM+b7ihLx2P1EDDgOS5CxKdUnYikzfer3/jHwlLaXR2MFRiyja4zT1WAKncxMWAS5uA7Y+x87tb3np6qtMT6q2AxZNFjN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810364; c=relaxed/simple;
	bh=PmyQFv/TA1mIzP0GLz7tP7re9l2ZlyJ2J5sDFruJmV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHLNUHS44EbtLblSiqFrk4qQr5ZpC24e1Yf87aAmzWyf2KSB/5PMc3CUnfpsJucvcpTGmBFbM9+4Qy8CtVt7rAo4MWYmNWhOCDSYXRHFPWCboghdbSZMIU13yUibkY65S7EWkcziSVi+gOdhBEx2+bmyvNnjba/oOXRs0T4uQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IyjqJ/Nv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h93VJq8A; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IyjqJ/Nv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h93VJq8A"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 5A61E1C000C8;
	Mon, 27 May 2024 07:46:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 27 May 2024 07:46:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810360; x=1716896760; bh=w6y/BuqqxK
	i+ulIjm2SveuxIS4ECvdUGD8zIqJqhU4w=; b=IyjqJ/Nv7OEjHhlsifwFWP2Y6M
	k+Ac8jEmWWiiq/+7gAZJHWxOnzZsFLL+104abZx0MUwFrAiEdiJMYsPRtU4N+v8d
	RlUdaRnjBNp625tRpyIL0Kq9REtM0ydXjaSoO3NJ5g5nBOMXZHk1Fx+A50CkPKyF
	D0QBNcUHan/i9lOPTiO4mREGQ8ifP7v9D4puVn5n6xfnSJxR9fz9NpbzvRZ1yMKn
	3csVKpxGPmBLNXYHweU/zxNDEWlLzwn8ROVAT4Rp2dtjt3jdbor20IW+0xi9zTS5
	9L5xFoFPB5tk7HsDJHCrH2YTIzoZXbkoesWU7lzoDLQcv4X1Onxek4SXHW9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810360; x=1716896760; bh=w6y/BuqqxKi+ulIjm2SveuxIS4EC
	vdUGD8zIqJqhU4w=; b=h93VJq8Ah+e+fJRl9+5+CveA5X6YEBZ8acE+vzRzgzuu
	x6dEsg8qItukRTdKDWDWOMfmQnMRaRQqGuQkhfLBbhiwaMAgp4pBNU5VBB//+WNj
	SzypF8WFkd+nBQDyltlhs9gGaELU7jczyoHCl6C/CiUZJzL+cSbsd/GYVphxbhBw
	gKYHJuib8ZwLvNzQTeGRe5HSPneorDLE95cX0d5dS1HYym91WbXzJ4Vmb62cWdIk
	76YeRJmpy+8gxaCwCY9XOfnwHMy0yw5sSJ22tq6PldTaTzeT4lFVoQ8ep1YpDko8
	whd3jeGiEU3MoTjoLAXvGZWPRlkrVgehQmjTJEluyQ==
X-ME-Sender: <xms:d3JUZty9vQESfy3vaUCPT_o-ySUYFRT8DCgvRsP8INCqwaWSva5TAA>
    <xme:d3JUZtSaI03cPuUjulFSdKUoI5tUyqwaFFwZkptRtuKIXG1zJvz5P3n84D6EVnucF
    Kg6O2V8e6D70oxniQ>
X-ME-Received: <xmr:d3JUZnW8E2Bs8TIapnPuHPtlvyhIASeqYkPZIyPm4d-EIEZgMwQszCZsLVJ2eQBlrUzn7tj-Mgy-IedeJD6ka3YB5iyAljTYl-MrsjbLsjev0zH2C2I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephfekheevlefhteetheelveeujeejhedtueduvddutdehheefheetvdfhudeviedt
    necuffhomhgrihhnpehhthhtphgurdhshhdphhhtthhpqdgruhhthhdrshhhpdhhthhtph
    dqphhrohighidrshhhpdhhthhtphdqtghurhhlqdhvvghrsghoshgvrdhshhdpthgvshht
    qdhlihgsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:d3JUZvjHdxoErvwD3aWRxK0MJJ2DzlU5bbnJWRvDKnYIjUBCxgK2qw>
    <xmx:d3JUZvC4jIfG_8IgGon42TwUMg4u4mq4lvmA8RifG84IoegqZ9F90A>
    <xmx:d3JUZoL6OEMrdH9PnRjq2O7swAS-OkWdNZltneS9PNpIFwEEM2tXcw>
    <xmx:d3JUZuAGye4WOxgLY7CnXQ5L8U0Gad9D_pdeUkvrIwhzvqyiMKgvAA>
    <xmx:d3JUZq43PlvQYl0iUZmTJY7BliJXd9Uo1TmsC1HX_nwz8cPJnAIYZXtH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:45:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b1fdd625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:45:48 +0000 (UTC)
Date: Mon, 27 May 2024 13:45:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 03/21] transport-helper: fix leaking helper name
Message-ID: <9e946c1a835bbdc23fbc6773b714eb2175ae33f8.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4Wg4kP+hPwJBG7xr"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--4Wg4kP+hPwJBG7xr
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
2.45.1.246.gb9cfe4845c.dirty


--4Wg4kP+hPwJBG7xr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcnMACgkQVbJhu7ck
PpTDsBAApdddN4HKamIU5QM2Vvzwe9qn5raFuhjsWpE8ABGZjq+yIDBZvE0EnWYt
55BWOE80IW4b6jvIgITR1pW+QSSY+dVQzqr7bJORje5smCADXyFF4fH++wLv5HHe
WCX/OKLX+4358glkfwvNoLZbbwOd5lyLKcSG1Yp1dlZDJc/GkD26r/QTfonTK4uS
D3VZmqZJQWatFEPCj+j3M4Z3Zuq9pe1NBwU+hOFRaO9y8jgbJcw/tKQhihf0uB82
WmXXNPwY+NHXQGCGCAoOnMOajvkY3h4+wCisF5LTk3AXwE4bmd0AJnD4l215wvIq
q0zcrYW/hSiAV/vQ0b+YCc5dXGG/RJ4M6MMlIDwku37B5On9OUSK0vVkETo/PJ+3
8nb8l5UL7PHWyY/cPgbTN4lAkufyzioLQbcHOvnuJL8+k9C+WB1I/mbwJ24Vrrgq
ir2e79Od1XdsJHXXAjJV7L42uoMX9RTl7i2w6gWriYVJklbqRJz0Sf33TQLnh9pa
0sfBORaDIjZhjpmBLxTBQeL75w+6vDptjWU7gswvnjp6EglZlLjZjHSlqMjWWBKQ
4cJy2p0C4haZlCwBrF7e8D3fa1JfnFEChcwO9AdStcnFBs9zwrW6+VIex8rTZ+aS
v2wPyXOEgplPoQ8/9a7fvBvVxGSSP9FHEt1wyT+jaGF+Lcob3QE=
=3Y6T
-----END PGP SIGNATURE-----

--4Wg4kP+hPwJBG7xr--
