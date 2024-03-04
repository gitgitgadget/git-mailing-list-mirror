Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8614ABA
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 07:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538315; cv=none; b=okINyYn6M/9+5jGz3wBnwQwHOMkpBJoHMn4G31U7Perq3f2nfUuav+225WGVPd+R0mMDZnB8NBULu+p20xyU7vugfXNtYqPIEFJZd+v/oOfvvMSTOJTDuBNkGnJJdRmHVC4yz4NtUCPuMmEUwt1NONje1V+jW6+C4VaBzuFmH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538315; c=relaxed/simple;
	bh=7YkW+MZbMIVYmLWaS70EJAaeoSgSsQdV0dltDn9EFjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SofLS+tMNLabgAsuvzyNRVD4kCrVUwkxvtsj0b84xzFdMAZ72n1JP2yB3fYf0HLkCob3fQRLdJCG1x397vYp4D54oyxOi4IV1yfGcI1R0JbcvE5Oa2wqLhzEqTDSPkJPdNjtZ08jzPp3ctuE9HI2yxFTIh1JmSHfe39KOZs/wYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DZ32J/La; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IkFH1MhA; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DZ32J/La";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IkFH1MhA"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4AB4618000CC;
	Mon,  4 Mar 2024 02:45:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 02:45:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709538311; x=1709624711; bh=h+KADtG6q6
	CYzVGzRngIFTwbdtwbAt9LWXci4uXkGP4=; b=DZ32J/LarHHrT12j83LUk3vM4n
	yG9aXltV9kXArTVbyeXTwp9I/k6mHaxvsLtetPP8xApgvqWJd90D+30GPZCuq2Bm
	bipSb+sJyL5CObaC2oPhocHhnJW/dqZGypi4y6/cqK1qXtEGV/WjbPAqSEkvylJJ
	55PpLR1rg+cCq0che8KbIK6D3B47SHoodamD9dzdW1rUr0IwFF4ObeBcOQpTqKND
	fdYqi1zKPUJIyY/DomwcIYGKxrhJqHWB9lSuW8AfBI2mXOgfekdbk1ZtV+O0Vv9D
	DK4lqA5uL09xO0Xv5EXZlt5uuo90d7go+cb8hJEYUe25CacRgp5Uj/zpDF8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709538311; x=1709624711; bh=h+KADtG6q6CYzVGzRngIFTwbdtwb
	At9LWXci4uXkGP4=; b=IkFH1MhAyj3ya7FHWXkRgSrtX8KPbBZ5BvxSf2Q5fw4U
	N/vxYDtK+ZM2YQcFq3EwU6czTvHnDDdXjDGEtZciSp1buHQHprXB29Fq9UCLjq8+
	Opuy0x271DxrESHvGm5i2VmN8FTEQEPM7790gucyvI/PtiIUhG/M0SRUO9OR/2RO
	UNKnovCl9zKON021/ow9IEnP5pAAJj8KYAu7qNqGBTuqcnpPN/JHKc+LaSDXB2Gx
	JSDuUf5Jv4w6lBZgZ5ViQFYD/QMnNXRcWEMA7KsELWLAblqXw5v7mGobi2/srT02
	MTpv2EfBRHKBvfNbjE4wo8EO75YKimJ7Wy43VFI8Jg==
X-ME-Sender: <xms:B3zlZXUefINFGC-fo-rWKuJRsVK1VSnIM9wVZRSyQqPeE6Cd1HMyFA>
    <xme:B3zlZfkxCFETt3S4cYEI8YsNVu-vEhG72z9xf2HS8y4cqvW7F1b_I930GNDTtB3xn
    4mHza0VioPTJOXSGA>
X-ME-Received: <xmr:B3zlZTZVT9TfDRcuBn95AzZOw1LHhIuhGAity-uy2bnXRJKpQjKuKex8WXb8-cx2IHhLbj66GPS0fWxyLs29TFlpw0ky-0iYKgFJ1k3KMzPVWWo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedvheetgefgveeuveehtdelleeviefgfe
    eiudeigfdvffefgedvieetgfetveevueenucffohhmrghinhephhhtthhpugdrshhhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:B3zlZSU4AVObr7S2VbsXlUC3fiQed7f3jst4rRoh_FMVhBXHLhD2Ww>
    <xmx:B3zlZRnqVYQgmBpHJMeL3GTdu8GbNYxD5ALZHROQFFixM2g7iiDDkA>
    <xmx:B3zlZfe-2YaDIPjOPse1Av_znsdMGHBFjJ3SSLetr5qLh9cOML5bTw>
    <xmx:B3zlZWzB4ISsMHHgdBRY48VS1oEByDRdgbQf-hIKrBIgsbnDvDA5uSwrIR4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 02:45:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c428a5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 07:40:46 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:45:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] upload-pack: only accept packfile-uris if we
 advertised it
Message-ID: <ZeV8BNCr0QN84ZQE@tanuki>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <20240228225050.GA1159078@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rzfBL/uJZ6YbdHyP"
Content-Disposition: inline
In-Reply-To: <20240228225050.GA1159078@coredump.intra.peff.net>


--rzfBL/uJZ6YbdHyP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:50:50PM -0500, Jeff King wrote:
> Clients are only supposed to request particular capabilities or features
> if the server advertised them. For the "packfile-uris" feature, we only
> advertise it if uploadpack.blobpacfileuri is set, but we always accept a

Nit: s/uploadpack.blobpackfileuri. I noticed that this isn't actually
documented in git-config(1), but that's not a problem of this commit.

> request from the client regardless.
>=20
> In practice this doesn't really hurt anything, as we'd pass the client's
> protocol list on to pack-objects, which ends up ignoring it. But we
> should try to follow the protocol spec, and tightening this up may catch
> buggy or misbehaving clients more easily.
>=20
> Thanks to recent refactoring, we can hoist the config check from

Nit: s/refactoring/&s.

Patrick

> upload_pack_advertise() into upload_pack_config(). Note the subtle
> handling of a value-less bool (which does not count for triggering an
> advertisement).
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I suspect in the long term that we may have other ways to trigger this
> feature than the static blobpackfileuri config (e.g., a hook that knows
> about site-specific packfiles "somehow"). So we may need to update the
> test later for that, but presumably in the vanilla config we'll continue
> to skip advertising it.
>=20
>  t/t5702-protocol-v2.sh | 18 ++++++++++++++++++
>  upload-pack.c          | 16 +++++++---------
>  2 files changed, 25 insertions(+), 9 deletions(-)
>=20
> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index 6ef4971845..902e42c1c0 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -778,6 +778,24 @@ test_expect_success 'archive with custom path does n=
ot request v2' '
>  	! grep ^GIT_PROTOCOL env.trace
>  '
> =20
> +test_expect_success 'reject client packfile-uris if not advertised' '
> +	{
> +		packetize command=3Dfetch &&
> +		printf 0001 &&
> +		packetize packfile-uris https &&
> +		packetize done &&
> +		printf 0000
> +	} >input &&
> +	test_must_fail env GIT_PROTOCOL=3Dversion=3D2 \
> +		git upload-pack client <input &&
> +	test_must_fail env GIT_PROTOCOL=3Dversion=3D2 \
> +		git -c uploadpack.blobpackfileuri \
> +		upload-pack client <input &&
> +	GIT_PROTOCOL=3Dversion=3D2 \
> +		git -c uploadpack.blobpackfileuri=3Danything \
> +		upload-pack client <input
> +'
> +
>  # Test protocol v2 with 'http://' transport
>  #
>  . "$TEST_DIRECTORY"/lib-httpd.sh
> diff --git a/upload-pack.c b/upload-pack.c
> index 491ef51daa..66f4de9d87 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -113,6 +113,7 @@ struct upload_pack_data {
>  	unsigned done : 1;					/* v2 only */
>  	unsigned allow_ref_in_want : 1;				/* v2 only */
>  	unsigned allow_sideband_all : 1;			/* v2 only */
> +	unsigned allow_packfile_uris : 1;			/* v2 only */
>  	unsigned advertise_sid : 1;
>  	unsigned sent_capabilities : 1;
>  };
> @@ -1362,6 +1363,9 @@ static int upload_pack_config(const char *var, cons=
t char *value,
>  		data->allow_ref_in_want =3D git_config_bool(var, value);
>  	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
>  		data->allow_sideband_all =3D git_config_bool(var, value);
> +	} else if (!strcmp("uploadpack.blobpackfileuri", var)) {
> +		if (value)
> +			data->allow_packfile_uris =3D 1;
>  	} else if (!strcmp("core.precomposeunicode", var)) {
>  		precomposed_unicode =3D git_config_bool(var, value);
>  	} else if (!strcmp("transfer.advertisesid", var)) {
> @@ -1647,7 +1651,8 @@ static void process_args(struct packet_reader *requ=
est,
>  			continue;
>  		}
> =20
> -		if (skip_prefix(arg, "packfile-uris ", &p)) {
> +		if (data->allow_packfile_uris &&
> +		    skip_prefix(arg, "packfile-uris ", &p)) {
>  			string_list_split(&data->uri_protocols, p, ',', -1);
>  			continue;
>  		}
> @@ -1847,8 +1852,6 @@ int upload_pack_advertise(struct repository *r,
>  	get_upload_pack_config(r, &data);
> =20
>  	if (value) {
> -		char *str =3D NULL;
> -
>  		strbuf_addstr(value, "shallow wait-for-done");
> =20
>  		if (data.allow_filter)
> @@ -1860,13 +1863,8 @@ int upload_pack_advertise(struct repository *r,
>  		if (data.allow_sideband_all)
>  			strbuf_addstr(value, " sideband-all");
> =20
> -		if (!repo_config_get_string(r,
> -					    "uploadpack.blobpackfileuri",
> -					    &str) &&
> -		    str) {
> +		if (data.allow_packfile_uris)
>  			strbuf_addstr(value, " packfile-uris");
> -			free(str);
> -		}
>  	}
> =20
>  	upload_pack_data_clear(&data);
> --=20
> 2.44.0.rc2.424.gbdbf4d014b
>=20

--rzfBL/uJZ6YbdHyP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlfAMACgkQVbJhu7ck
PpR3Fw/8CT+1bn+PbBMDd23UOgnRfZQ87sznu9yfHioO+GOtHYFsHPxw1ALcmOjq
AtBklM57z/A1cxlvCol2fIwCKklBgV76kPNjWlX8AkgX7UW8GfL6klknKQVgrh9z
J8QWEPk/NYLdw4WFVmpEj1g4TCad0KotPSH/mPRjOTDqu45Oqt64sJdYMddaOT3S
zWYalSSFcWwiBN7/XDoZInTj/vErHQ5+gkgQEyTe8qrLt10zdx1hQAAAeylZNLOQ
fbaYTBNQ/dZOY/l887HKMnPQTpzok8b5L6Il2Hz/lRQlxkQde1snioKF9bfWRfgc
M6UeMAyhqhuQilkagpQ65CSHqwcDwbi9mszeIVVQKZ3AQwcPicMJUkpLiz4ptDnX
EdXrYnRjhbQnX4TQcy1u/PCN1LsoIJsoF/UWyN6ZTPM4RsHveO/nnkJ9cIBM1KfK
R6aMO7bry3HiQT0ToRGg9NR0THUtHv/yJG4JA28oGAG2g3w3GYSJp93N97MUAV41
f9ZiOiomuavmmQwoOl7b+DcWVp7c96r5HA47tC0xNg1TMftlScXPf5hH0yezw07l
wb8C1eMJ+kAjcFX+OM79YWrelLwTSnbrphu29mlKAyd/aYgoXS52/0IlgNUYOapH
pRWOq8QKtlRzajXwORvH2pUN0Nc4ZivaXYPqKzsvpxbISkM1GmM=
=0Uvv
-----END PGP SIGNATURE-----

--rzfBL/uJZ6YbdHyP--
