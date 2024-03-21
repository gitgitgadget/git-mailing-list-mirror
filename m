Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7583CD3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029020; cv=none; b=QCXrTUfKyv72H0Ce/Zevo00q3Dc8kbtUOsPKSSinHUmwmfH+m8sMIz6+sC7k8Ja7grZ3951Z35+Qeg7Cf72dnmSSfsxO7fv8I7LPAv8W9nEBKGm72fz9Bo/DFf4/L80/JTRfvBO9xPWc9atmumDLJ4sbt2lLoIG/NOZNCSKGXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029020; c=relaxed/simple;
	bh=oE1bpZg8zoienNWGomdI4C1u7CvDWFWFNYU3Q1lcVUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIO6tBFu4H5R/tiHXBwjMjU/tZMgPz5oZ02zsYPblDx5EDWibzfP2Ugd3f6/RmcNKgzxKRuhoUoveZJowekVbdDvmNe1k+OcNdmCjxljATEZpdPP2kZGqbVJkMJ9NBleWHDkJX+/tF8Z/mvrJYUwKNwg3a6TFPJM3CyTmgUY8Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lxb5/TaW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1CjB45k; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lxb5/TaW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1CjB45k"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id B431D1C000C5;
	Thu, 21 Mar 2024 09:50:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 09:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711029016; x=1711115416; bh=ZVJ83c1PLp
	2G/WtxZ5u+yHUpDJdtQS0QRdDW3/wdN28=; b=lxb5/TaWlANj9ZzFHm/ZkES0vd
	hcVu0L9Mj715+nhhByMEFsaV0J0+RTPqkW1mNWELy+Kk9stkrsy0KJTNnW2K6qIc
	aJ7HnWatHNznshXpnDln5HMJoZDOM+W0QWu1H7U7NQe6ImmGh9mCkgpGyJdnMHFu
	9LhdsKmx87JHVMlcc3UlbJfwgGKbsxObGs4wfm9Kzp20LULJalc8tWaZH+VrkUyM
	JwVRmPQnkZyCSUqf0WnTMGrgkk7GnVjXMEf+nyQwDhXQSRImBKKaCJ2PFQ9A6rgY
	8g7ahSwTbZmVUR0lmeil8okedato9DRL3lErlpd5PYgyVDTtBFQrgw1r+y4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711029016; x=1711115416; bh=ZVJ83c1PLp2G/WtxZ5u+yHUpDJdt
	QS0QRdDW3/wdN28=; b=p1CjB45kY3xZtFmlTaPK5qmqkXOUU+9uAJ6GGVAbw56h
	bZwieHNgYt41HWqNsKRcLo0tvRFFSHmkp3z2qDmQAPEz0/mHJxCCSKBZPqYtHzfx
	mNG96ari0fC9fl/L9gdqq6tdhlhxtj19DSbLuVMb/mLfdsffniRMl7p4IziSusw3
	3pZ1xpEWP+82KBayUPfykzMlaaFGDc1AFehCIIrbo0MFDd4MrE2SrVSbBp2Q/BOI
	28lbABZgUONrMWZ/I4XID4t8xtYzQxut8vn6SvJmdB/dsF8lFIJJGOZS1Xn/mEnk
	mT0eJbdnbW/Wc/iKtOXKXTU5392l3Nk6+BE/5aI4yw==
X-ME-Sender: <xms:GDv8ZUF4Phuno4bbrUEwCm7kfJkRilOygIATIDYtzA0TlcXIceIExg>
    <xme:GDv8ZdW1hTu79-C5-aw64QLxJ7HRb-hR5RVjEJe_puB9ZMFIe30aKU_2HS5sEMICr
    r0bJhbS1npTkk844A>
X-ME-Received: <xmr:GDv8ZeIhCMc1d3GY9xU6WxF0YvAHyBdvFO5PP_T0jPGx6VZrrcOS4ZSGNdo9QfR2X5xx4W5ATcDyiuqQFKLtBfKriUlo6ooGMLRLu8RAcrOKjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvffdvgfdvleeukeffieetlefffffgheduueehieefiefgudfhudejgfejfeefvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GDv8ZWHlIopYjkzNlyN72ktL7Y52bgJ8P6UFZd87JKQFzwKT86gI_g>
    <xmx:GDv8ZaWUoPrYuFG6vZKGW93Jjk6P1TbYFYX9zy_ftXO5IE26FEz4pw>
    <xmx:GDv8ZZMk7pqUOBzg-A0ypCLXla2fzGPdzEZz5lN03WiVvxVdwYp0Ow>
    <xmx:GDv8ZR02Y5A8xxMQKpCprXPSWt0aa-xcud8bKsmG_oEDqFK0HmxHrA>
    <xmx:GDv8Zcco3CkJtZYqh2bjO6bPTPKLlmHujJxAIIqoJPk61dsHS_KsOhsys1w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:50:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id add1697e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:50:11 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:50:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	git@vger.kernel.org,
	=?iso-8859-1?Q?Jean-R=E9my?= Falleri <jr.falleri@gmail.com>
Subject: Re: [PATCH v2] git-difftool--helper: honor `--trust-exit-code` with
 `--dir-diff`
Message-ID: <Zfw7FUtDcKBaA0-6@tanuki>
References: <976C9BF2-CB82-429A-B9FA-6A14BCFFCA3D@gmail.com>
 <0fac668f8fc021af9f9c4df5134da59816307ccc.1708423309.git.ps@pks.im>
 <20240308221229.GA1908@szeder.dev>
 <xmqqcys4fj15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CBtUwfDTZjV3Igik"
Content-Disposition: inline
In-Reply-To: <xmqqcys4fj15.fsf@gitster.g>


--CBtUwfDTZjV3Igik
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 08, 2024 at 02:36:22PM -0800, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder.dev@gmail.com> writes:
>=20
> >> -test_expect_success 'difftool honors exit status if command not found=
' '
> >> -	test_config difftool.nonexistent.cmd i-dont-exist &&
> >> -	test_config difftool.trustExitCode false &&
> >> -	test_must_fail git difftool -y -t nonexistent branch
> >> -'
> >> +	test_expect_success "difftool ${opt} honors exit status if command n=
ot found" "
> >> +		test_config difftool.nonexistent.cmd i-dont-exist &&
> >> +		test_config difftool.trustExitCode false &&
> >> +		if test "${opt}" =3D '--dir-diff'
> >
> > The quoting doesn't quite work here.
>=20
> Thanks for looking at them carefully.
>=20
> In general, when you want to interpolate an variable that exists
> outside test_expect_success, you should write it this way:
>=20
> 	for var in a "b c"
> 	do
> 		test_expect_success "message with $var interpolated" '
> 			command and "$var" as its argument
> 		'
> 	done
>=20
> The last parameter to test_expect_{success,failure} is eval'ed, so=20
> enclose it within a pair of single quotes, and let the eval to
> interpolate references to $variables at runtime (as opposed to when
> the parameters to test_expect_success are formulated) avoids a lot
> of surprises and headaches.
>=20
> Perhaps we should have something like the above as a hint in
> t/README?

Makes sense. I've sent a separate patch series addressing this issue in
[1].

Thanks!

Patrick

[1]: https://lore.kernel.org/git/cover.1711028473.git.ps@pks.im/

--CBtUwfDTZjV3Igik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OxQACgkQVbJhu7ck
PpSqEw/+LbluYBnSULXC0Sck6pK0y46N/jtQQVhntWDWn7LSEope5RqlGn2PnySh
Dabdb6tXM08Aen1h0I770xC86Rr/Lww5i7ZZ/2mIgJlBlvxx8RiS8Hxls65KoXzb
yQk+S/x62Wsxw0eRwF5zuVDwZaIq78ObX/GjeluO6Q3M/Z09f4mYa7+9s/UNVCbS
bkjnfF6eQ6u+SIkC1PTSHe2UmSsfQTdcTa8nj2qUHiJdc6I2Ic6JR0YMi0dyD8Hb
y9OjYMUVOJ1ukqEDeVb1ulp7Gq29fTCH60zX7gSbyzKmoB7WQ100wgPEc/TsINQI
hPp8d+CexYnb41IYFZq3aQb8ueyc/omurBGbFTyf5kw8R90e3a4o/6gtgnh5cxth
tOIUCtixHyJu+2HMpaUvHemsNWamP1Rxpr287GuNd1+RcyPSGJzetKRBZ5BGBwx9
xMiHleHyPbA8ayeAcAGuPFUqAsoFpcMQuGSsoMEYBxghiLPdEhERb0sFj032MMAQ
qqLWy+eMXc5mmO0lcsgsla+KN0OoneJKKajIU5Vl6Pes7zOd1+azGbE6qiftzo9R
HVnHKZujiFeL77tfBWaQLX9W6KvGU2PlQcoTO19v5/Ldx7P4LZlJYFt536bXpFWk
mZXdHmhfzAqji+IJy8Ge606KpZTlNl8qaETgZbEc26r6brg2dO0=
=AAaP
-----END PGP SIGNATURE-----

--CBtUwfDTZjV3Igik--
