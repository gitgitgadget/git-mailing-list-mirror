Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EEE4F1FC
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755876; cv=none; b=drbcVLLAla7msSr1e1+DmTauBncD9D7zCnYO502VxH7C+YScw1N60W24gnJUZ+VGDJP5IGjkia2dcaUyb7raHVnnPA9dkBmFzGFWfSZSqmaCaTB6ppSHligfv36RgsM9Icab8IbgTuk9UpGQdZD3YufYj/3omcv2/6MlG8pu7wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755876; c=relaxed/simple;
	bh=zQOg0n8UU2e0fYUiJFRXDOOmeQ+0kge3FQjwVfsVpus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZzyfq6Nk+KiVEyWAx5rw07/sDjASCklklYhHKZfOttEOYSH2i6qLJ2WMbaeOQN9RUqZREn4BJTdGMt2e9KxsDG/zzrz3Vy9vdKSEd7AJWjBnVlT2l/EsBXSqfBBVRDUaVEvfpms6/D1k2893SNcFY9F3jtKHOZ95Tuuiq5RglM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kmJ0vgAn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cOWrYokH; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kmJ0vgAn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cOWrYokH"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 05BED1381171;
	Wed, 15 May 2024 02:51:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755874; x=1715842274; bh=5IP6Gy8Ldk
	cTh+X5ZsPykC0IRx1WnEAXLECn+tlhf9w=; b=kmJ0vgAnZ5arYOdttEkdpiC8aT
	Vu3HZc9xjAuNNYT4VapAc6MViu6PeQHhR9uqCf7l8yd7nI/SVeCUU7yv2zvOCLwg
	brJ2IFj5tmXfzf26tG3W/2oV2NWfMt7YokhlNvOjRoYYGLk0x7tFl+AQl5kUAx6c
	BtVl56uX2XcOhbof/AzPyQ0HM5jeLT030HMBJvixFKR4l4e1RlceTWT/YFggBvuU
	LAcYipt+lCiFnXry2U5woe6U27V02oz42/v1QcBzs8Af7V3QE9mXhWrFFGr69PQm
	Ef32YRPrOlX06auV+z7BIrnUPcUH4dxodWhd9VeUo78CzGKkGcugjYQUEuyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755874; x=1715842274; bh=5IP6Gy8LdkcTh+X5ZsPykC0IRx1W
	nEAXLECn+tlhf9w=; b=cOWrYokHqmQQcjDUxA2C/P6+RpB1BQ8woQO96iYpT6t9
	RTs5+38+wT7ZUUgpLj6fROAjAzE9/XJKQbboDRqjvwV2ba76abEt3cQb/a5zItIM
	DlN85QjH1szaHnONO44qMNhnw0wzmQQdoeDeP4fW+8tslOcRDVIo20p/aQUudH30
	hKZ7amDyz5eSr3995wgoKd3ptrTLBZzqWJFImWWSaLrQnfqt09DcJqpS9cwUo9+b
	af00STkcv1ogtZ6JZnBw8dJF5Kh2iV4zUW+9TI9biYb61yV3Tvo+Iqi7F17nwGLA
	o5URw9/88rLczYayu/0GfxIUvAy0+DjulvN/FjqnMQ==
X-ME-Sender: <xms:YVtEZjY-yKH4vgQ1wRkeyGJHT4zK3fregHN56UOdfUulH0BMtkEJ8A>
    <xme:YVtEZiYd5T-nYyTEqhH_M6_5F17a9YiKDPBbeoyxM9vo4H3WZblF_Sb-UcmmZQnB_
    tOoQ2ysCd5GjM-v1w>
X-ME-Received: <xmr:YVtEZl_lJddEito7P6CxUD73i5y0Llp2IKnaprQf3mVcCFClfG7qZEeg2MUAlBQaU3FpPT3Zrks53TBXySSM26zyNP0dVC2Zsr34D9mdfDLAQOoS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:YVtEZppvrcGtxMcHhJn1xgwOCDR7U8PD7BkxMxCZ0mTscAzyUryyTQ>
    <xmx:YVtEZuqkWPNTxXDF9bx-Cy0dbp--AQcG_2KzYy5o2c37cUIrRWIUdg>
    <xmx:YVtEZvQPh7VnpGnWDhGS8IULucV15rL7ML3nyUsDzHEhJY3UcW_Jqg>
    <xmx:YVtEZmqUZGJyLT1H0usDTcbjviOJg61vQo9H_sark7AJNoQZ7cS-WA>
    <xmx:YVtEZqfjJLM4eGD0vvrowr4Se80hxJKDOs2CzbbXPGuilpK2ld8e9YXQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:51:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c91f9eb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:50:50 +0000 (UTC)
Date: Wed, 15 May 2024 08:51:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v5 10/10] refs: refuse to write pseudorefs
Message-ID: <15595991dce11b7666d8447691e5977635cef1ca.1715755591.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715755591.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OB1SHNCjHxUk0xPd"
Content-Disposition: inline
In-Reply-To: <cover.1715755591.git.ps@pks.im>


--OB1SHNCjHxUk0xPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pseudorefs are not stored in the ref database as by definition, they
carry additional metadata that essentially makes them not a ref. As
such, writing pseudorefs via the ref backend does not make any sense
whatsoever as the ref backend wouldn't know how exactly to store the
data.

Restrict writing pseudorefs via the ref backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c           | 7 +++++++
 t/t5510-fetch.sh | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c13b8ff6d8..9abd9e5b86 100644
--- a/refs.c
+++ b/refs.c
@@ -1263,6 +1263,13 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 		return -1;
 	}
=20
+	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	    is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return -1;
+	}
+
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9441793d06..2af277be9a 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -518,7 +518,7 @@ test_expect_success 'fetch with a non-applying branch.<=
name>.merge' '
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [1]' '
 	one_head=3D$(cd one && git rev-parse HEAD) &&
 	this_head=3D$(git rev-parse HEAD) &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -530,7 +530,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 	one_ref=3D$(cd one && git symbolic-ref HEAD) &&
 	git config branch.main.remote blub &&
 	git config branch.main.merge "$one_ref" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -540,7 +540,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [3]' '
 	git config branch.main.merge "${one_ref}_not" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
--=20
2.45.GIT


--OB1SHNCjHxUk0xPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEW10ACgkQVbJhu7ck
PpQvwQ//UFa9leEQCVk/vFiNNp38VQjMuv4USEzFJ9vpx0409AC5rJ5pSh1JhW/I
UiQAQUuQpmNz98Vk3C4J+2563auilbv0V7WlOY2YV4lOwTBKgBWLVIutu3WnUcPd
A6XQgvZOHOqAPQQCLTyzvOnTfhAdOGCAA7osixmtodP6/95s8vSD/FntldZYqDIQ
PIxRl63Onx9eLFGf9siMe51vXa8DaT6Xh5Xc5pFb4wBo9Zgic+T/F67nK4ACQDSr
tUP6iFwNfjysULdq5y8I7ZZFpwUOmYBdDDVNUrSNCr7iTFv+Bs8CHyH1TwMJd0Aj
VET9wlDVTIc+9+ijQUJ4QX8MrJZcph7uRC8emLBI2Be0C8OmJRVur9HGaIYynXZv
vyUAxAsDUp8t3xChgqnLa+gE84DLAJ06IBdq9E/bKwa+V4qciWjUDn2zI8p3avZf
Az4rq1wM30wo7KTbXJQipeS0hHx7H4FubwYBp5Dd341UeqiafacGmuY4h+3mOwpD
PoFMAZfXGUWgMj8VhGU17DekWRsM5bVwldp+uwdQnapUmjFrBZXG+FF15L0imeqD
c1xym1IGAGWXvu3uelQvKcPofVJ764XDp4bzbYZmV48pDo8ReTQ2GgSUWEtgtdZm
iF8mszCbYXC2YOg5ATmto6uBKOPA2efSQWatTFLh0IguDtvR9O0=
=ESg9
-----END PGP SIGNATURE-----

--OB1SHNCjHxUk0xPd--
