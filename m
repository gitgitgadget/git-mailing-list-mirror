Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9625F55C07
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614082; cv=none; b=HiAfcOWfdux6E4i5arG5IhQdDdVRtDKrZHGM3PtydvjSjxwpod1gxc1lqq16p5n3Pz4i5LC3Ar2IhNTKv4zcwngyCC82TLwnYNvMSaXyhRzxw8s/Pf1gDqQ4dp1P+xD3mdVYLzZm/eC8NoFWvQfgSYfpmWL+785pr/S48SyHtTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614082; c=relaxed/simple;
	bh=yVY8rx3NFeCJqiUOVQbBq0lNLeIX9alfO2neSG5RzaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV3DavFddxue4rYfsxDSEwt/86ZHe2OV7pPOuGl/Kbye1HcMYxe1y9ZCpqAH7RLU1muMXXJE0fzlmuG6jlkDTBT6eRisHHV/ZEkQiVVhxL6WvPKsHSVxUFE+1E65Ll+Y/iXxvZxnERyTp4uxrrx4JQVambb39ySxlZA/71/0IMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=On7PSFaK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ofJAmatW; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="On7PSFaK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ofJAmatW"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 7A5711C00078;
	Thu, 28 Mar 2024 04:21:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 28 Mar 2024 04:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711614079; x=1711700479; bh=iCGHx4Mzus
	WRMgRkdhGn+fp1052371X4rEmamrSWTvo=; b=On7PSFaKWdjfKZAJMGPQ9Xpn36
	J1intnGqLQi/T/NdQZDhxThChSQXtVR/cywm9LaRPaWp18NaaXrcApqySyy1kuGH
	Xx5dHMFFpWPBmn/9b2iUB2lqnPXg+KUMxXL/b4CMStn0/I5YyW75b316tY9ltQXE
	8ck5y5kT4JjVqiNAlZWZjcqo5nH5WMMJAju/VZLsW103BrreshD1skcOA1grCt8X
	TsFRrGwWtZe5wVwtCMdYOD3u/7BTu36LP4OhSGylYNMp8+UtRhOkyczb5zN5SrX9
	xzXZRarGzqjGmLNAC87g7f9ENPvwruoZCUlIMeE7J3v8XYuIEoHbp/Vi03jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711614079; x=1711700479; bh=iCGHx4MzusWRMgRkdhGn+fp10523
	71X4rEmamrSWTvo=; b=ofJAmatWwxP0Dy64TUZA7hlpF0lpvGbKc5RvFVRM3ToI
	ea1mr0g5Ex9cyl/kpcwcCeqCrijpZXVorajGVOLq5BmsMK54MdTPKVDBX+LIEI+O
	Truz951Z4kqbUwlOV9jFANeZwwiutjVrpVcwsZ52VCybVZvY9CNtX0+e1kdlFAH7
	9V0W99hTto8o4jvtufggizXo+7jUmDv4NqzGuGjfKkBM1wRtQm9jA7UIQm0ASYOe
	onuawlsCrvs+sD/ij2NA5OmyvaJUWxKK4k5DOpuIG/40ijWqFLzdi3w4zJ0rAzSG
	dy5UVETgcumBjETN9qG167B/yquw/d7cGx/SjKPjLg==
X-ME-Sender: <xms:figFZjZeFKcCLtAOdOaRiIvDfBFelspgFw1QKWh2dxSLAsyg9cXuUg>
    <xme:figFZia9DmZcdMWSqEOngewOdA_6A8inESjxajimowN7ynBrHgkOHXlpN1za7CXj0
    TqH0hvYKvncGusBSQ>
X-ME-Received: <xmr:figFZl8Fn_wIyeS7CHuYH4mhkC9191zQusRfNYN_72RI5tsGvA1nL9UvRSeNskJQSpXuh6BfuuNQA4PBTLELJTab0o1kJfxjgIuhesYByH_RdOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:figFZpoPAAlazIr-fvGezd0ZbLT0zDWlYOciBVJ8GcfgayFLiirQYA>
    <xmx:figFZurERg2Fod_u6mziJFMx6DcLZoJMXCrs_77C7_ElB-1snB4zIg>
    <xmx:figFZvSvqjByfpFzoDJEE_TWa2lDtxEUVrbEVOHN1vmo9xWR7R14yA>
    <xmx:figFZmq0T1LDNDloILCO8XWfsO1xPlUqosC_rRaiMvoqPa2W392Bbg>
    <xmx:fygFZnmml1sWtHFQ3MpnS5aSyfbwZc6sQI3KtdOqE2iz2PVQTIAvp0HMqDM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 04:21:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c933da2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 08:21:16 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:21:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/6] fast-import: remove dead strbuf
Message-ID: <ZgUofCh36-W7f-yo@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <20240322000304.76810-5-thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qywt3Zy7KOfRhHPK"
Content-Disposition: inline
In-Reply-To: <20240322000304.76810-5-thalia@archibald.dev>


--qywt3Zy7KOfRhHPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:03:40AM +0000, Thalia Archibald wrote:
> The strbuf in `note_change_n` has been unused since the function was
> created in a8dd2e7d2b (fast-import: Add support for importing commit
> notes, 2009-10-09) and looks to be a fossil from adapting
> `note_change_m`. Remove it.

Just from inspecting the diff it's not clear that it is actually unused
given that we assign `p =3D uq.buf`. The message here should probably
mention the important detail that `p` is not actually used after the
assignment.

Patrick

> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index d6f998f363..ae8494d0ac 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2458,7 +2458,6 @@ static void file_change_cr(const char *p, struct br=
anch *b, int rename)
> =20
>  static void note_change_n(const char *p, struct branch *b, unsigned char=
 *old_fanout)
>  {
> -	static struct strbuf uq =3D STRBUF_INIT;
>  	struct object_entry *oe;
>  	struct branch *s;
>  	struct object_id oid, commit_oid;
> @@ -2523,10 +2522,6 @@ static void note_change_n(const char *p, struct br=
anch *b, unsigned char *old_fa
>  		die("Invalid ref name or SHA1 expression: %s", p);
> =20
>  	if (inline_data) {
> -		if (p !=3D uq.buf) {
> -			strbuf_addstr(&uq, p);
> -			p =3D uq.buf;
> -		}
>  		read_next_command();
>  		parse_and_store_blob(&last_blob, &oid, 0);
>  	} else if (oe) {
> --=20
> 2.44.0
>=20
>=20
>=20

--qywt3Zy7KOfRhHPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFKHsACgkQVbJhu7ck
PpQfqg//f8nnX7aY2eq3V/ZfZ83Wmjc/Q2sJo7KzEI01a3dIBLkcTRlmEmNbMbpi
BiaA5H18vHxRdlSosEhVyjth08vA8NzoIOa9jRal/MFrJPvjiD1ASj3+rJ/7CkKX
HGBVgufTsrcXBSyiNfUOxvGkhwODEYu1anTrpBezYasigPDoJkTDhcgfScXvnuTA
YddUukM6gfxdJtRUNIItvQLzcG9qInECDEWX/mZaypWHG5BLfDnXcgNnXRxyc/8v
NBsih/sO6lw66TieKlaMwgeFJae8khLtrOXaBv42HZOimhfCWtYRsvCxuWS3j5FU
yHEIIAeny6z+l2ox8vsnjwEkz3IA5j4DoFZtLezlPPrP6Iasf2AzfJNS47/h2Ouz
sTXWpuGusQn3KjS6rJCBK9TMJpYRwcUA1b3WU/2G3shc8PwOIJgZiEHJVzojpDe2
5N99IZCkcE1Dd173cep4dQsUr5kZpE/WdOc6sZMc19VG1F0/XIplPBpwbTOW2kSx
LwG3LnU0wuFP09dyH/uPF/YV9DvNoFAcqVWPAEFA6QQFL0qU/Syry3yxvq4TGibX
Zf0XZuOoDyFjF1fRdXTVDOy8HX4zaUHTxqT1/ku+5XyxL99V088kq0lRkZWkkZFJ
MggneliIvVX8AKj1uXxdX5s6gUStwxuCsmyy8hXpBf+C1c3s5SY=
=N+RR
-----END PGP SIGNATURE-----

--qywt3Zy7KOfRhHPK--
