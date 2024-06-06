Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114BF194C63
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669699; cv=none; b=D0//XpYmowdu/yjLigQWKufEgfxDBvD4cvdbHSUi/kH8qb6gRfwo51XNENKCbxE7IkTIyUR781j2mJ6hMpyPyGiqbocpF+CP6oSaX5pR8izChC+GDYIqjth4aR6nn9O1L770UJk1QXt05/BnJkIde8VCdWMCGSKzTqhexYnNhas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669699; c=relaxed/simple;
	bh=0bS7aRYM3Q8tJpoWSI3o7WBrHh/0am1NVRPSJ5vQeYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHm2IrtJ7UW9lGEKtiRiSLS+LAiOkc9K+ne5xz6/cW7sONbrmDmLGcRQf1Czgl7piNQ+DABBMrRk2e+XpPQOBWNf8NkDaayKdMM5cZjbDi9h9UQjPsBYe3enzVh+gvHBrWnjo83til4CU/PA6eCmtr9XLPb0HkanUPV8BiUU83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AkKjQlVR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cjcIH69g; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AkKjQlVR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cjcIH69g"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5CCC11140138;
	Thu,  6 Jun 2024 06:28:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669697; x=1717756097; bh=fVkiEtQ/HB
	K5UD8HhMs9EzhPtmEzqQ0/JCdWJd8OyVU=; b=AkKjQlVRvfAG8cIDCaGh26P5Ok
	Q5PAUbExP08cEUS+KceGDYzLGtw2fotOIHjhpBzKODf8Ki2MtxH2IWRqQFwLQSlh
	Kcz2j3XJv5xm6lIS4IeP4pavvNLfnvLyYiOFfQuMXTMbAuGArRj3cKL8+JHCfhgq
	dgz3Q+MXtJpY8H0+TBEw5jclvjlkJ5tks7jXj/Mlz/mFxVYxgBfOOp9me3e82oBr
	MD5cq/d5dNVgTvWaVUMXZM93pOPNsiiP8ZNfcCk1s87b8J42C9JqWcHwUcrQIXE3
	klCRMUx0T9Eyz1d3em6QBcntMtJDLKWthfTWJvsRcP9icXb9Xll12lgknRhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669697; x=1717756097; bh=fVkiEtQ/HBK5UD8HhMs9EzhPtmEz
	qQ0/JCdWJd8OyVU=; b=cjcIH69g2NmkVH6PPGSTRaZ61153FtIS4erqSU3jwUPk
	STxYqNWbPryJO2tybfSVy8tRgDk3ikKFGHISIepDErHEERR2H2dqCuBpBEt1D9+j
	FxyzNqSbR5dPn/XhkHTBz4nT44NKzLxeTjNZa2aZYFsOBEXGfb3G3HR2sHyR9p+H
	+zIUJBnn3EjvWroy+Oc7LaqRgfMW2HgHkx2zdRTqZjRX+TZA5uFOI1XF2ueDfOIC
	NBrLXH8O7FbPDKgeHpBhalgxNRk8o+KibOfWPBL2TxpZi4o+GcsChuvQgUg4e6th
	6+gqUytd9TwbJh0kgYTxAqNtt90ZS8xzwhG8l/26rw==
X-ME-Sender: <xms:QY9hZsY4wwJAJTlMi991styzp1LHXd8Wogk8Vv4NLoqiOPR4Oq4aSA>
    <xme:QY9hZnYsn-RaK90IrRbhusNEid92QtQ70lz5GZnCa41rdG7nr_98cvaWqXrqW1r1m
    AmmOWdkanaeAVc4xA>
X-ME-Received: <xmr:QY9hZm9K4KEx30PPMd0xumApyMTK24IJhEYTJZLazXFnGmQgFLONlhroDQwmWeuiEa3ETve8959S39-plCQx9ijLtc6jhywPlWCXGbT58gglfcHp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QY9hZmrXlpT9aqSB4Wk8T6Gky6GVbx7-BP-4WPZ-mb-xspLQKhysbA>
    <xmx:QY9hZnq4vocfF_OSNPnYwl7K5KfEJBnTJKBGMgYKt-ijy6lhclOVaQ>
    <xmx:QY9hZkTEUIMh5iHSKrN4FpEpx28sJ5nwOBrPTqKNwGMPh5iPxy5hGQ>
    <xmx:QY9hZno6BtPJNj67-sn2krxykaQlZ0bJ1fsl9MHp5jT7N8rj-LMfJw>
    <xmx:QY9hZonesqBbqR_yP8kbacPRXkB1TvjrwtMQnWDQFhiRGA4u6kk9yPVI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7487993c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:45 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 06/27] builtin/remote: cast away constness in
 `get_head_names()`
Message-ID: <7cb5df9182e5739f54be089832d85e0447efe46d.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2XJ97WAJMfcaUbnk"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--2XJ97WAJMfcaUbnk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_head_names()`, we assign the "refs/heads/*" string constant to
`struct refspec_item::{src,dst}`, which are both non-constant pointers.
Ideally, we'd refactor the code such that both of these fields were
constant. But `struct refspec_item` is used for two different usecases
with conflicting requirements:

  - To query for a source or destination based on the given refspec. The
    caller either sets `src` or `dst` as the branch that we want to
    search for, and the respective other field gets populated. The
    fields should be constant when being used as a query parameter,
    which is owned by the caller, and non-constant when being used as an
    out parameter, which is owned by the refspec item. This is is
    contradictory in itself already.

  - To store refspec items with their respective source and destination
    branches, in which case both fields should be owned by the struct.

Ideally, we'd split up this interface to clearly separate between
querying and storing, which would enable us to clarify lifetimes of the
strings. This would be a much bigger undertaking though.

Instead, accept the status quo for now and cast away the constness of
the source and destination patterns. We know that those are not being
written to or freed, so while this is ugly it certainly is fine for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d52b1c0e10..b44f580b8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -493,12 +493,13 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
-	struct refspec_item refspec;
+	struct refspec_item refspec =3D {
+		.force =3D 0,
+		.pattern =3D 1,
+		.src =3D (char *) "refs/heads/*",
+		.dst =3D (char *) "refs/heads/*",
+	};
=20
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.force =3D 0;
-	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D "refs/heads/*";
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -507,7 +508,6 @@ static int get_head_names(const struct ref *remote_refs=
, struct ref_states *stat
=20
 	free_refs(fetch_map);
 	free_refs(matches);
-
 	return 0;
 }
=20
--=20
2.45.2.409.g7b0defb391.dirty


--2XJ97WAJMfcaUbnk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjzwACgkQVbJhu7ck
PpQBARAArAC9Shhgz4apT2oP+QUehwyLfxkEydwVzf9lk1QJy6a3NjFzXUfYSWJp
9jfTXlIc1/+FhFk1i2ri/qIU4tuGjhMmNvNH7Vl9uczy8fVk5Y9uSN9OQF4504Om
xPdZVvWgUSYHDibp8OGB4SMRTf/GM/2Dc28x0Y8R0JkRPCF30o1tUD2YYf/cx18A
uWEgsBiPLGXeZFaxyT16gsW3h9/tK16wous2wWGsjGyG9ALg64/ggBtwM88tvqWz
RJJmi9GjGmdK0ZKbDX3l9nVDDk7vgI/weMnHmKhrxPoPSTT00nPVOeuzbxiU9q0t
vnUCAXO1GDLhN9hH0Ihyuy2Vv/AC3Ag26gVZvUcMwjbKCC9O3pxmp1jFNURelyLL
Y/5xjHI6Db9OmT/QyMRbcejvFaJEGvg3wvicQB8ZVk17HGF3a9Ohjnvm+4mfwJSM
AFazKxSLMJiyFurBMF/v6bNE4B10AUF8WDrKmdDHKxxm+s4YxvZBVfoBXVivaN0N
ZTpivc/d09ZNDEmNzNh5CoFE1APYAAfnlWEf9DXbDP0Mtf2xMiDyNNXyWvnyLYzS
ZRde3TfdTdPe8uSE57vyIbtgiIYV2NrGAS+1BDrYyIAhgiaZRKnE2Ha3PLhdLDQH
dUd3gZgqemWTC9FEnCy/O3fVkg8rtp71l82hb6aXhjCmzvHgUPU=
=N0J1
-----END PGP SIGNATURE-----

--2XJ97WAJMfcaUbnk--
