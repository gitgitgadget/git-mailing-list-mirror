Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02B1487D5
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046420; cv=none; b=mVqd8KsHr/3371QwMZr+LugXjyVhfoT1ZbzS+XdamiyvksPaK2M8JvelDwzFkW2alKK+51QY3qozWoew0Nz1dhetX865IukqdA6sxKqlZoVEaejyyCbzOpd/skMhb5nyU9Vj+vM94JqZRdeqcCvj44M8dLgt//Cbi/6S3oyFAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046420; c=relaxed/simple;
	bh=1fNfgntGirVyJUjKcEVOw/Yoyf7ld8XeUgPTYFbGbHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eafGmwIfU6fHjVYzawZlRytco1PMuXLlDIozflIuUEErizto20O0ZHFR83qc8jymbHaW5RH2Y+Yrw3biMHm0Ywlwu3Fg13xMzSzR6G7VZpYlWCVwo9a5mllATuWRtevapy6kSNkcZzP65JPbyfH+mUyLE16wUeqTHykNUitUDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LzJv6UJL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rxrmXYAf; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LzJv6UJL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rxrmXYAf"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id D7C143200922;
	Tue, 27 Feb 2024 10:06:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 27 Feb 2024 10:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709046417; x=1709132817; bh=Ji/jbGu0ZO
	qX54dJV1fXdrNeYX6FgHCVECLnqzJKhjs=; b=LzJv6UJLCjQfL1EIEuvvYnpmEj
	k2QtfO0QOucgwSvH3VgkhI6wf+LhhrC9idJ52Vk54M6AxasLw5GTqnpyGXfQTACK
	CpBtEY7T5pZO68KPbnRUeeWFnFoiQgfcbjNZiRkmM0xiOHmT1S/1/pAlkK3kZvdy
	SYkZrXRuWxyj/Jv98FUCHUuHukC/Z31NeoLzIZZj/ZhwzGW+Mc9FtAQUqL9lCFNW
	mOjSWTfEfi7tG0GrIw307gbVBlFO/6gTmF8qB+tszIebCnrMPmWhrN9PBGtEMhhi
	0czFUfXKTvH8jAIImSnXJXBwgiMYavyqFn0rsQQJu8yJRDsTfeylt3i9fKfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709046417; x=1709132817; bh=Ji/jbGu0ZOqX54dJV1fXdrNeYX6F
	gHCVECLnqzJKhjs=; b=rxrmXYAfrqkyRowL3qmjCFpVzKBmOc8A32FHZ0kvhMZ2
	S9pq+8zjI3GSoyDZzvC5rkTCylWia0NNNOCh9BSpP3iSzaaWHGU667hrq04PqDJ3
	K9Js+2Zq2V3V3UIMMe3mhdEWhHFXQIk8q47yfxCAf9exueISRWZv4D/gzJAatWbt
	RL7OjkIVwvX5pXbFnKi19LbUyAXIZ2UFgo2zghAgQgrHJOEgIkM8MdquFaDzXm7S
	d9qY6jOQ+1O9x4lc9D6rd0yIiKXNLCclxtBk1EP1J8kQPK/c68ft49EOIAN0gVOO
	quknFsHfHajOQItXtQQlvSSunDkAzTlBQy0Y2j6pgg==
X-ME-Sender: <xms:kfrdZX5RkBndAkmhLSCn_t0FpXMJjrp5v9u8JsOU-uG9Hq38XcctsA>
    <xme:kfrdZc4CyDfGuE4P3LJMj8E6mJ3sRlsq6qS4WOkZ_DyUJthBIS945Xs65OQESJgPj
    onnH7wivKXT3zm2LA>
X-ME-Received: <xmr:kfrdZeed9qMRUAPSX9pdtjKx8BsbkFi12p7d_zw-62LsCnHlknpDV4bnGgfYSbwv48MLMYLg08myzt5TKfprEq5dLAXydzfQgHnsi1cKjE26fr3y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:kfrdZYIxtomHjxv-pMePw--JpCN2IwchDTOBmM9OP4HPsOX8EeDH3w>
    <xmx:kfrdZbKkKe8Fq2g1DAuvGgregaszdoTZdsTaZjLqX2nMLczqAlg9Cg>
    <xmx:kfrdZRyose87JY6zteDynLSV5VKM4sbPkKOyoUYHcQ5blz-UoNAfhw>
    <xmx:kfrdZRgrXeow7xjULnN5lKQT_Pxwnh5YGiJtKKFPDFV4yWvKkIO1sQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Feb 2024 10:06:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c37f06f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Feb 2024 15:02:39 +0000 (UTC)
Date: Tue, 27 Feb 2024 16:06:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 10/13] reftable/record: reuse refname when copying
Message-ID: <35b1af2f0612e51bc0cf87afe9c44197b2b8ccaf.1709045927.git.ps@pks.im>
References: <cover.1707895758.git.ps@pks.im>
 <cover.1709045927.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7raOtV7zMCemVA79"
Content-Disposition: inline
In-Reply-To: <cover.1709045927.git.ps@pks.im>


--7raOtV7zMCemVA79
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Do the same optimization as in the preceding commit, but this time for
`reftable_record_copy()`. While not as noticeable, it still results in a
small speedup when iterating over 1 million refs:

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     114.0 ms =C2=B1   3.8 ms    [User: 111.1=
 ms, System: 2.7 ms]
    Range (min =E2=80=A6 max):   110.9 ms =E2=80=A6 144.3 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     112.5 ms =C2=B1   3.7 ms    [User: 109.5=
 ms, System: 2.8 ms]
    Range (min =E2=80=A6 max):   109.2 ms =E2=80=A6 140.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.01 =C2=B1 0.05 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/record.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/reftable/record.c b/reftable/record.c
index e800cfef00..3f2a639036 100644
--- a/reftable/record.c
+++ b/reftable/record.c
@@ -205,14 +205,26 @@ static void reftable_ref_record_copy_from(void *rec, =
const void *src_rec,
 {
 	struct reftable_ref_record *ref =3D rec;
 	const struct reftable_ref_record *src =3D src_rec;
+	char *refname =3D NULL;
+	size_t refname_cap =3D 0;
+
 	assert(hash_size > 0);
=20
-	/* This is simple and correct, but we could probably reuse the hash
-	 * fields. */
+	SWAP(refname, ref->refname);
+	SWAP(refname_cap, ref->refname_cap);
 	reftable_ref_record_release(ref);
+	SWAP(refname, ref->refname);
+	SWAP(refname_cap, ref->refname_cap);
+
 	if (src->refname) {
-		ref->refname =3D xstrdup(src->refname);
+		size_t refname_len =3D strlen(src->refname);
+
+		REFTABLE_ALLOC_GROW(ref->refname, refname_len + 1,
+				    ref->refname_cap);
+		memcpy(ref->refname, src->refname, refname_len);
+		ref->refname[refname_len] =3D 0;
 	}
+
 	ref->update_index =3D src->update_index;
 	ref->value_type =3D src->value_type;
 	switch (src->value_type) {
--=20
2.44.0


--7raOtV7zMCemVA79
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXd+o4ACgkQVbJhu7ck
PpT2Ew/+L5G/jIz+knxw9ZI+EgIR83olJFFufhChirYo7t47d9cG9HpoY7i14Nt7
u21RC7umFUv2SmIkSh7lfKcu0SnnckqDm+2TTlwk00rCcSOdK8kR0M6FSHdz23ae
CoQpXkUy0ck7ea/milutBQ9KUKmSlgEW6jURLhDM5A1FSVupgzanwn49d/YoTBfW
Hafi7QVl0lBJdHZ79ryypNx+m+tRcHnzXPepDM96CPAj42l0JStis9C2auZ4tncj
x0o/7hNQMLp/vNNGHl+3fOTomRs4ArTZTSCvr6E8m//zIMyjFK2uTgadsmVXqTHS
YMhB4+g0HLts52ooWnlloF0yIUSNe3gK8hiKcgBJYGUgVA11XFnhKCAEfSHS1EEV
1AOnMmveoqEcLDX28Xy35KljG6DtSWECUwbUkUn9imOezr9JrpMsHCRWvrnmI11/
3sRKPudO4yIUq2S/SpzW92azXsiECI6oYEmiWSl8kWinZYH5sfmjBCj6rAfJLdpZ
2nzp/i1MOwavgU2JKecxtGp30/d30JdpkgGYpVNXuQUEsVhIwbJoJmeWFr0g/5Q2
QiQTKQDMbRWe3TBTThbnDk03/Pg8J/tN61wEyNX8ya3dhiNHsnOUPITxxkmSrFBv
MxBBsbg2PP41t3NelWO6shWQ1egEDCA+HCt6/493H3eVooJMHPk=
=U3Ea
-----END PGP SIGNATURE-----

--7raOtV7zMCemVA79--
