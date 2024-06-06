Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFA52E639
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669718; cv=none; b=aR9oNCVUBX4Er3e07BW0zOjxVYRCF5mcusBCfaWs2bxU4XE0MCTCS0GURtoexkBQXcw0IiPyEzaYoQ0XX1m6qt5uF6ojPSxVlm4ua42FpywoP6RXl+39TJ9sTEfKDRikcRF3sZ46btx9EW6hNMOWmyfe2V4jIBLorGOUtm3OO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669718; c=relaxed/simple;
	bh=1DVkRgHu48V5Xc2sNr+3+LSXGci+H9gB0DztHPYXRKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBjNERnjPWqH+7wlqxgJsQzKeO+3CrMJ6BNhjpib0x+IcmfbL2WHzHm9msJAqpwu4wmVaNoGCEcTV2YvuiOJp8uP7A7SrRdyQOUC34h14cg9qmElonsTTT3nBoMHL0ED2Crv8ghFyQg5eBjHFYHytJrtYGwIfqEdtre467gqSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VTcOkLXl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T7PzLIim; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VTcOkLXl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T7PzLIim"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 155411140138;
	Thu,  6 Jun 2024 06:28:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669716; x=1717756116; bh=iZzA2OAZ36
	S4muzE8jCcUUo3MldwBjd66N7Mw3Lkwmo=; b=VTcOkLXlSYDoCL2A4qC8cGjY5J
	VkT3Cdcv03CtklWiYLvJRtNXU7tH3daFPmYGfMa35Z9g3yU91HFHudONFV6EKBa8
	cqWOFEcnpxG1DDpBRt7nGMSWwJL6J6BzlOG5fQRtueTKRwtF+XtaoQmfj7cfp3qB
	pv7fb/3SLh5FK0JU8ig1sKt5CQZJoQL45mY64DmaJsVRvz7snj/kh3ZncKj5J2Oo
	QaeJ9XnetemVSYaeuWE+kYeaFnagqb8L2uhEGqCRB3FTaZSzXn1a7ScjukOzkqVY
	TPvJUri9+s9oY4tmRMIKaWotPBcWZAd4qsimpYKix+OqV7i99uue6HudablA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669716; x=1717756116; bh=iZzA2OAZ36S4muzE8jCcUUo3Mldw
	Bjd66N7Mw3Lkwmo=; b=T7PzLIimVOE3DG6mpUh0Hhe1RnI3aKLL/1Hza6cM9+bm
	fgUOMu3ZzerVto2fKMI5ZdBs98Z/8P8glSZrMpC3rnAerg613hR2JeyT3w79o/NM
	x6UDAh7wY7JBn3xGh2QJxRQ4lAUdofdINEXDvPrM4pp4VEpinzPj5/l9L9op6zWD
	yESIpK98ISqDZoaXyauhzmQhrBmvFqDFKPdQkmsslV2bZDseyXG5/xPcr2ijL4Sc
	Q2+x9quwyHDZVzUVTXotUGQUclj28vURQmRlSr8tiG59mXE4G9xL58kLNuv5+zou
	+jlvT3NVhcFwCr9eKOo+64nWhfMo80rRxjkQRHomoA==
X-ME-Sender: <xms:U49hZo_2yub9-PuUOPHxmqJdWpwX6-8IfNd_oOpqpBkSYh8Gm9As5Q>
    <xme:U49hZguRuTO175uGrPHyfFzDSLcKbFtvwzlkgHIRBJ3ZIDi1jePZQXBwC0PUM9Xdy
    nIRLEs6o0CW-ml-5Q>
X-ME-Received: <xmr:U49hZuD71vWfPsYSbriLYjvWZn9F3Ev-8yen1wCRmfX5PqC1UjNxg2zHZyBZ0xFb-M2UfNBdkOXucJRMkw_oM5wyNOMRIOs5F21L0FmGGxjs_eh1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:U49hZofqN4qX6VAS6si2iKWgaCFOdymRvJss5VpQ8rfpsPwfOqsYJw>
    <xmx:U49hZtPpO5mHdgxwgrLvJusQS7F5QR-XgAMw1DlfqeSd70EfDsdezw>
    <xmx:U49hZim9ABzGzKtNtQsVLmdtDCewW93DPEpJAxv_AOY_CmDQpSRSPw>
    <xmx:U49hZvvxrPgm3BuhfUUDTgiuEYdP3ML-xbeBje-rxzSvMnf-eVCigQ>
    <xmx:VI9hZiqlzqssRBdkcd-wO_88BvXmiQBSIc8T0TqU437HyBzkHEj04Rpz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 91b1bb32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:04 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 10/27] entry: refactor how we remove items for delayed
 checkouts
Message-ID: <b46dd3210d3e6f73c84fba6aaa8f21929f7052bb.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sa80UHfbE7wFQKH2"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--sa80UHfbE7wFQKH2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finalizing a delayed checkout, we sort out several strings from the
passed-in string list by first assigning the empty string to those
filters and then calling `string_list_remove_empty_items()`. Assigning
the empty string will cause compiler warnings though as the string is
a `char *` once we enable `-Wwrite-strings`.

Refactor the code to use a `NULL` pointer with `filter_string_list()`
instead to avoid this warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 entry.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b8c257f6f9..f291d8eee6 100644
--- a/entry.c
+++ b/entry.c
@@ -167,6 +167,11 @@ static int remove_available_paths(struct string_list_i=
tem *item, void *cb_data)
 	return !available;
 }
=20
+static int string_is_not_null(struct string_list_item *item, void *data UN=
USED)
+{
+	return !!item->string;
+}
+
 int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs =3D 0;
@@ -189,7 +194,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -199,7 +204,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
=20
@@ -225,7 +230,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D "";
+					filter->string =3D NULL;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
@@ -239,7 +244,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					errs =3D 1;
 			}
 		}
-		string_list_remove_empty_items(&dco->filters, 0);
+
+		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
 	}
 	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
--=20
2.45.2.409.g7b0defb391.dirty


--sa80UHfbE7wFQKH2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj08ACgkQVbJhu7ck
PpT2dA/8DVCjyZwDHoKOItLHs8EztQf8HoQo+ypKGwc3ofkOJcTR8XtGBclbXUEr
ss/4KmUcYFQv9KvGR1S2U/xFA7+uLjG2GlSCvt6aoOs2EKjRqIsIl95zQXpl91fl
KbB6DqAcjStS1OO4U5396MXOg0XYZmiSjCsaWTVsM/DqFRUyj40iTxrPlmAuZbJ2
zqovEelX49UGViBYGthZz7ne/xvNPYWyq03iOO2kmiFotAxl7WwG3hMIY+ipAo1i
hx2DdpBd7lcvdzDioJJh7/Bkkqjfg8DECboEN4kLvLQqcEMrC3EdAtispzSJeI28
WxtTInmS6mf01iHQH6ICDAG2bzyIGDEX4lAc4QDj43gAFuVcZsbvO7VqjFaxL/t2
WGel7kOIE6iHp/THXVim8R71KeAajwE5VRZHl8pxX/GvB1ByGS1U8UjWqTqqpcCp
JW1PC+uevXYa/b2IfvEDOQKLSiNrB+HCVVmJ/L3rfwKiNysBV659B8YsfN6wcC3S
bkejnJcD5obGVfuInHkKan5kYH8PTWRw8zBPsfyVE4eU4nZb6dgbzDDfn0q92DOL
RQX3QjP8m+y/wq0t2GqqS/UHbXOF8usgh5eCjBuLwob/Bbv5aPj5zV3DjW2VCpVz
PQhdUGmrN16q1U2pKR4BRznVBSyX3weBAMZCxnMmGO6b7XhOn4w=
=yyxC
-----END PGP SIGNATURE-----

--sa80UHfbE7wFQKH2--
