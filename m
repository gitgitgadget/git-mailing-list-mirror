Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C186947F45
	for <git@vger.kernel.org>; Mon,  6 May 2024 06:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714978301; cv=none; b=Cw2m1zIt+oPe/BBbF+xOJK/8zmS+4EHhauC5Zq+w1tEfzwmRzxvLCnAme1hpWX7lqYRnLajcq1e+91XNbgesEjpEoaVCrI9M8OSFUT7cSV11K70JP+xsqyTynD7FLe9YC4PVeEm0nuMyAxd6YDd08z8+bK4SJrgjwKMXLEA/3WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714978301; c=relaxed/simple;
	bh=X/dCim3jrgobempJpXaUadlZppQdSX/i42/utZ/7hvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+fxmEUKKD3qhSW+7OUfLnN9dqVjhTmWXwZcFaBVB8RKWrvplI9whhKxRDWs762NIlx87t0MSllPY88o0IwdIab4D13AmDGMrWsGuh1uLvtdliV4uVhZpxVbIl0LOY465sszqW4tI99Qi4fptlzitu/6EL3IWWgSiPX7xAd8VFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cGYWu6HZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i2w8bN4M; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cGYWu6HZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i2w8bN4M"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id B7DFD1C000C8;
	Mon,  6 May 2024 02:51:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 06 May 2024 02:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714978298; x=1715064698; bh=MEe8tCMA7q
	mkBqsCJvRhnmgmjEzJ6vQCx08e41svgWE=; b=cGYWu6HZ78S1oVF53ETlYxqZ2w
	p4+AEgJAhH8vc6WarByL9nZXoiG8P0EMZksY+AQ9Nbyvnf04ZJ13yP+N16iZSHro
	dfCXW2m4W+kryLumzr9jf6igayhj6bObK2EIfULNkYsxbLqJtA3Iwb1IzI+b+pLe
	jdhjw1OrlcCvpLT/TOZzsDKN/+0K4KZF4H+BMkcygKzk/ZYu6tOASNrD1Abtuj1n
	gU9+MeRvIC5nk/IANQwKic+BqD0+y9JqbUVHHlVyLorDzFzR9Hy6unvz+zWsGtnf
	ZLaUdhbU09YgIixG9cewJCzqd/2cReHXJJghRgXo3V4bz41+GRtNN3goNzIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714978298; x=1715064698; bh=MEe8tCMA7qmkBqsCJvRhnmgmjEzJ
	6vQCx08e41svgWE=; b=i2w8bN4MCmjEYTv8WyTselt5Rdya4ynl3S/g1pBTHIrl
	uu9bstpU5knAIBckDRADYxOeuIfBl18gnKUEyYphvMOM0+/QaTVDTXpjsiPC1Rwo
	SMgT4wfxWc4Nx/O5JzgRFKGVSMTx9Vq02ycmk3htCTMrwljWYTil1bAP/Q1u+6t1
	ROOsJ8+v2NVDObj+rbClvNZYrKvSP8oNpGkjoCJVRP5BRSArilEvhjg3Kv+1tlw2
	u1hB6Db01gST+aREAbUZwKFvLPQLYyfCkOZveUSFmh+oRZVzeZYcVwLvI5Wq6gXQ
	HoLdtAfSgP6R57GpfMm+d8NoCUpxad2PInAdGBzBCw==
X-ME-Sender: <xms:-n04ZhCEsdwW2xLR6W0Zic2RSFQ2k4cGhHvyEoygb3KoWAl3DJ4b7w>
    <xme:-n04Zvi28VrTQOBrVPG3_l9Ek2KDMZyFC-oRKDvsmQRPeiWQURNMARv0yUbYQmT1H
    MZhIxMajNoKzp-H0w>
X-ME-Received: <xmr:-n04ZskPTpe11LSaiOh-nA1eUtEQIzzFXRspRcSbxTdGAHgN2F7oQIyfPCw6GutCNnfZJ6mZU7L3uZRNcOsHZMHlc_F8aeVQZ_wmo2GV0eolDZIT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-n04Zry6mq7-ES3JLROANbllse7Iksun2brS0RgjdS-POi4-450eQQ>
    <xmx:-n04ZmQuOsUk8YJYQHEoXjDTJxesJ-4JXQxotF961B1AzJvl8DJrFQ>
    <xmx:-n04ZuY0ijzdhxAWs_9MJQ6HjtSmG-y5n5Do9todTIJorYLr3iliSw>
    <xmx:-n04ZnS7BJ2uydmriYaVz0xaq5RgzSYwcc-sm8owTMWr9h9QihIqow>
    <xmx:-n04Zhckjxw0FNd8Rtn6jpsWsMRZlZliow9AtrOjjvQ72TbnVNSJyWZv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:51:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 01e38785 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:51:31 +0000 (UTC)
Date: Mon, 6 May 2024 08:51:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] reftable: expose write options as config
Message-ID: <Zjh99shqHEI1ehF6@tanuki>
References: <cover.1714630191.git.ps@pks.im>
 <ZjNA2zNH5twH5qj0@tanuki>
 <xmqqv83u4omc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Y+r65sE96RmLOltk"
Content-Disposition: inline
In-Reply-To: <xmqqv83u4omc.fsf@gitster.g>


--Y+r65sE96RmLOltk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 01:38:51PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Ugh. I actually intended to pull in ps/reftable-write-optim as a
> > dependency because I know it causes conflicts. But I screwed this up as
> > I thought that the topic was merged into "master" already, even though
> > it has only hit "next".
> >
> > I'll refrain from sending a new version immediately though and will wait
> > for reviews first. Once those are in I will pull in the above topic.
>=20
> I saw [01/11] has changes to stack_check_addition() that disappeared
> by the other topic, and the resolution is to remove the function (as
> nobody calls it anyway).  Also [02/11] has changes to refname_test.c
> that can be resolved by just removing the file.

Yup, sounds right to me.

> If there are other semantic conflict resolution needed, such a
> rebasing is appreciated, but otherwise, there is no strong need to
> rebase.

No other semantic conflicts I'm aware of, no. Thanks!

Patrick

> The mention of the name of the other topic that has interactions was
> very much helpful.
>=20
> Thanks.

--Y+r65sE96RmLOltk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4ffUACgkQVbJhu7ck
PpSuAA//fjiizSFhVYpCXGDP9fCrROJr/D7B44zq8UIJ6hQ5VLxzKW4YrXbiEuJb
L1kw5QOtAKX3zbXzDHlpuoGBi9ldlhC+e1uETpG1lGIn400krJXTTLlAvXGmRNZm
ABm+M9rnKIdldlksew4SjoXDTa/kV3wJnL9mGqXS4wwKUcM286789b4TdHsxh02S
rPY7xA2PUVhF9Gfk/PNHt0ub/oTDWbI8MSe2EaBGtsWMqEfYwwC56yl0iR1uQKOe
9EwInA8WPMC9kwNBLBrTSKBU3hw+rEqHTv2EBjL1CpzyRwr2JFdnn4m7SpDTpJmY
dGRuI+eRKfaKN+dfM+3sjSiIvWTdVM2xMBmNfzl543xunNjZnu2Ur1gS5XHkewbP
DNbEQz8RwbbKSI8Mw+WPRoGbjYawVRMA+8Ezpq6VpGrJaGdw2n9QTYleBtl8QctU
AlhvkJQ8lKWmYm+l520lseGkuUIwj4TwE8B0h0/bqWVLg5EO/l6egWA9Oa+iQLen
+43NBqojab8f4uOP1PeEcdLlHoAlko7YDKLqZi4JfNBJU1THv9GbnRKiLELFeYgG
y7YdDpI7WIZ7BNi7nZWTjkD88VOrPkpdEewt+0pB4wO+w5mrIYTR44rg4fps73e2
ZW2n9xwHpLk5fVGsiyCLj8F7uMYS+gh/Z3JUd4ZvkN9xGpGJU4U=
=JcgR
-----END PGP SIGNATURE-----

--Y+r65sE96RmLOltk--
