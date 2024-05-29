Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025C16A37A
	for <git@vger.kernel.org>; Wed, 29 May 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975017; cv=none; b=SFqECIfy/WadXL2i/zQvL9JzrXTzyHVFnw3PYGvmZgeR8YIdtblz49fkcqRS9GbhkqmmADtT8fyUToYV8KWfKPhkJNkcZALG0bJo/OWcaURBYVNeXLATqp06CWWsVAUv8R2FJ3mUvxJDWM7HAl2iPrQD5rrnmziDuuwqr5UYrvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975017; c=relaxed/simple;
	bh=A3oa0Bk4og2zJIzIFTCP7dmvhDOPTiHj+8+caLq1lo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP/OR6vJkLStrroO6zhM4Y7ge3NqUc3EBkRXuC9imlt3Pn+zKvF4nEUXaCJloIq0X5AV2h24GZ30/saDoA6+9wXLpxzCA6bdmw6XoY3w53vFbsCFBYVTvQQ75mCBuZ+gzULKMvDO1TyhGWcQPvv4z2onC7e+oN+gxRO2XctprJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pBCkzjNt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dAlHYJKp; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pBCkzjNt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dAlHYJKp"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 9EF4B1C0019D;
	Wed, 29 May 2024 05:30:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 May 2024 05:30:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716975014; x=1717061414; bh=CvZjct165h
	AgINo0/F4onyHjgNn/XmQk+0aXEN3AJj4=; b=pBCkzjNtT/FWKm27bjvJvvDVWf
	dAEnpgWfPL8nKBU8HAEw7AUKgZM13mlm6PYIUh7w+BmEGa2YTNoJ4ti/4udZXY6G
	sY5+MsGVbr4NiOw5TizYiK10jF6ssrMG5PT43AQuM1ClQjo20nmXdnF1h5Tm1XYe
	6ZyZGuD2ieM3SKbWk1+2rbIuvtPVCKT0ajo5A+eEQhuCBX9PJgt30A+/R4l1wf4W
	xFYI1phMgr0GXc2GqrxWJRXvYDXM9UNZGjZEDe7t3VwmpMdxXzHmHGDVbBKN2BBV
	lPG0ZfUKd5bSefC+f4jAGa1roylBUwYp+3BgzneQPj8Cb9yNTH9yWPQfImxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716975014; x=1717061414; bh=CvZjct165hAgINo0/F4onyHjgNn/
	XmQk+0aXEN3AJj4=; b=dAlHYJKpf4Ra6xqP0kCplJKCPSRWaRDRuU41LaK8QEGs
	XhcAh+R8xAvkE+mGM6XfW+MzkQfGrxRcYtE9U++BMuRQAyBCK1LnYT/ARMlfbc9k
	xPlUM8Vde2NH/8iOvHrxEgEiozVo+JU2WwIjWDoVqotIoDzSKdq26GbIeBtyEbeF
	pz826XmB3vNiqJp7r3uWgINTG5TXkI+DI1KcM1HOh+BXCIbF1kBqt3Zmixd/ShxA
	NhWGI+vtfNBnHMdfDjlkNy4OXuD7f0sPv10yEOJebRTQFFEgZr+857ylvA9yEdyn
	j9ZwJI5qTyCD2U+eH1QugHgg6x2GGf9HpVaiJdm9SA==
X-ME-Sender: <xms:pvVWZokUorBwUl_oh2xf1jhBJ0S_XhfUI67C2hfvsPayXV9GFY2bJQ>
    <xme:pvVWZn3wt9e_Llq5LBbsoIIqtZjylmoUMZXZ2jGFVUOHaEtuqTjwysUb_5vgnqMYS
    F5mWLQjraFF45Tarw>
X-ME-Received: <xmr:pvVWZmoL_iv8VgOhs6dS-jDBqVrALAfZs6PxIWCuLR7gsbkF41NX5RYZBsNapsJ-VYAmsd36exbwjur-DCQoS79avMIklVL-49fMVtQJEd5AKVb_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:pvVWZkmEB7A7lbfRp32W5BbS8ynOwwWjN15y4WEN3D9yF2dVdDcHRg>
    <xmx:pvVWZm2tnDFcD29fGm1_130mBC8pxrEFOXJZdgjXnlJYX2vR9A0g3g>
    <xmx:pvVWZrth6MrNB7DdCcbXObzVGUnBY7Xy_dZvQj4KwlFDrQqZzmbQWg>
    <xmx:pvVWZiUwweEpWjecHjLNFeOrTI_xWyz9sS0BiC5CMimJFl7Clj6aqA>
    <xmx:pvVWZrwjV6fKU-T3OkgyiIFj3V6Xp2DvvoT0Gh1hU-BeMWSMgj0k1P8U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 05:30:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd5862f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 09:29:59 +0000 (UTC)
Date: Wed, 29 May 2024 11:30:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v2 4/4] t: add test for put_be16() and improve
 test-case for parse_names()
Message-ID: <Zlb1oiN6E4Isrnmg@tanuki>
References: <--in-reply-to=20240528113856.8348-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-1-chandrapratap3519@gmail.com>
 <20240529070341.4248-5-chandrapratap3519@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P6eqNNF4TYXbxz9C"
Content-Disposition: inline
In-Reply-To: <20240529070341.4248-5-chandrapratap3519@gmail.com>


--P6eqNNF4TYXbxz9C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 12:25:12PM +0530, Chandra Pratap wrote:
> put_be16() is a function defined in reftable/basics.{c, h} for which
> there are no tests in the current setup. Add a test for the same and
> improve the existing test-case for parse_names().
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> ---
>  t/unit-tests/t-reftable-basics.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/unit-tests/t-reftable-basics.c b/t/unit-tests/t-reftable-b=
asics.c
> index b02ca02040..8372faec8c 100644
> --- a/t/unit-tests/t-reftable-basics.c
> +++ b/t/unit-tests/t-reftable-basics.c
> @@ -89,11 +89,13 @@ static void test_parse_names_normal(void)
> =20
>  static void test_parse_names_drop_empty(void)
>  {
> -	char in[] =3D "a\n\n";
> +	char in[] =3D "a\n\nb\n";
>  	char **out =3D NULL;
>  	parse_names(in, strlen(in), &out);
>  	check_str(out[0], "a");
> -	check(!out[1]);
> +	/* simply '\n' should be dropped as empty string */
> +	check_str(out[1], "b");
> +	check(!out[2]);
>  	free_names(out);
>  }

I'd split out this change into yet another commit. Also, you say that
the test case is being "improved", but without mentioning what the
improvement actually is.

> @@ -123,14 +125,20 @@ static void test_common_prefix(void)
>  	strbuf_release(&b);
>  }
> =20
> -static void test_u24_roundtrip(void)
> +static void test_be_roundtrip(void)
>  {
>  	uint32_t in =3D 0x112233;
>  	uint8_t dest[3];
>  	uint32_t out;
> +	/* test put_be24 and get_be24 roundtrip */
>  	put_be24(dest, in);
>  	out =3D get_be24(dest);
>  	check_int(in, =3D=3D, out);
> +	/* test put_be16 and get_be16 roundtrip */
> +	in =3D 0xfef1;
> +	put_be16(dest, in);
> +	out =3D get_be16(dest);
> +	check_int(in, =3D=3D, out);
>  }

Would it make sense to have separate tests for each of the variants
instead of one test for all of these? Might make things a bit easier to
follow.

Patrick

--P6eqNNF4TYXbxz9C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW9aEACgkQVbJhu7ck
PpQzCw//b5rRK/2cRV2YxmXjfkCGJZZdE2FJanLQeLgCEQEM/G/Hx/eiRzrLPrSU
/l4qzd0qT7x4eM+Wl2MpiJXPzY2NP3n8XuVHMuv+1GQjNmaTp7KhtbrsrSECfavQ
exxF3kAWSUV5DmXgiIBcYVHjHltQhP7rM7AELirtMp+OcW2Nf+9jVXA0UuvSa7zx
Yvd7B7GHkXV17jEO9wYUFSOkfW305ZaekaCqPBqtExviyuGczsXi7DukG080083Z
l3WhS1AqSeSd2f2QGGkNs2dk1RW6KClKj4SFZk5f5h0TEI4KlK+vmvWHaxbd0SU1
IKbDEtleHcJjap0OvxNCBWQtoANA18JKmMYRLcxekyy7k2xfHlg1J3dnLeqgHsTN
/apEoLhXcRIuAjmyiapY6n2ZbVNNlECNMXaRYLL2T7yhYXd4u5N/Rxc4rTbk9LHI
/cKPwhNHbcBg9ARjM/lTiY1bS9gQf0iN+7cODrQ/cNBAnhpuk3bcGaZ2iQyUO0hH
e9WALwjAxjH/m5zSepUZ+H5E/ti9iFf/wir6vDC8xIlj7SlS7/iSNoaxYfXccKL9
XItwlCU3xb+82LtNUHRPEs7XzAWNGBslyphFeCPr7m90zFo+Y2cCAgK1c5MTo1vs
YI9gwqj6EYGpBVvUiRRWWiSz6gMxAe5ZKbuxRRLeUhqlYrJZ/Fs=
=NPvr
-----END PGP SIGNATURE-----

--P6eqNNF4TYXbxz9C--
