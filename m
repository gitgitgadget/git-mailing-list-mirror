Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960FB38D
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713500707; cv=none; b=kPJ0Ydu/y73Vh6152G6LgSCybVK6fDOBBhibKyiL5LugUGEci98l/MsZxwDrjFobFX+0eXKhdr4przgmN5DF1BCuJYA3zrLNLiiiXLlKuVdAIfDJ8xKi7hP+jskbB/vHmlcopsKb+RcGNoJcLJoKQFGxItdiEAZP+jiW04gN114=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713500707; c=relaxed/simple;
	bh=vHRp118RJtUj8TDoFGAv65DNDFtw518qadvaDGd5jeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akcnu/rdMHeTe/W7Z1+1xnTeNlEgdxbc7TMMdyDSiREPVrdG7Gx1ZiuxBzRWtVSM6bxXBex/GBKxLEqdQIUGcOq7nkwoILKqo7S6UTJZOGa7Tgrk0seZQh/7OXfxTwJQBUUN4A7hZGsYBXiqNWHXJXwWHfNEYWUe2Hn8DDFCKeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VWsKe0Iz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWvE7LFo; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VWsKe0Iz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWvE7LFo"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6100B11401B2;
	Fri, 19 Apr 2024 00:25:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Apr 2024 00:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713500703; x=1713587103; bh=qLgUgJjWZR
	vtYhte5ym86tAGaxlBrpxhMdcs12oQEU8=; b=VWsKe0IzOKDlLEExKYrpCK1G7G
	DxP2e1bFaDuYdsRYgiVUvUje9FmQqkAYk26EdJuzDb3AtQMw1vaY5bWrNHUJjCN5
	brhLp4fOQr8gew+06xiC9huMNYHPdWuRImtuAD6pkhzWVvvxZWtrECZbMeo378p7
	Q/++kGxFtdPoZxJ4kPXsr5RvWgCl1s6vcmNZ3C4Pl1xA6GU+GbbzU0Qhr3npTkUR
	qco4ZHsWb19Ww6YZOpfKayTCITY0lb80dP2VqB4ebS4OMUtn7zDo5pEzKHcFoMrB
	YFLwWaDRoZ90YP2ewbkqHgstbu/ubxRd4FNTpYkRq47m+pi03vpT5RpvQp9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713500703; x=1713587103; bh=qLgUgJjWZRvtYhte5ym86tAGaxlB
	rpxhMdcs12oQEU8=; b=VWvE7LFoF7eIOESv+Y77M5KS8ccBXFbB5KVwEXBMmyzY
	g6RAiddHwZnbNmPj3O13rQAC/C7zgFixxFKgKn5JQt1LrQLD4e/duLnurLXTAAM5
	85yczXtsOaAUcMYNfzH9IaCqK/ugEdGHUFByFFq6QWKw9qqQu1Nzhcs/vd7EZ2RB
	Pf4Tif7a5tCxmO5kpoh0hLL1urCOGVxdGn9+FXusTIzAClAkthImQPAAQzQxQAh/
	W8I0Din5Ne8G4u/fgH6gCldeUBQGIiCnSBhJAaw1v0Msq7Ml0HZOly3f/YFxYcsq
	tNQ8ptwFYTXO/s0a8VU094cPe8FKN9ZLrEfEYXAtDQ==
X-ME-Sender: <xms:H_IhZvvzQPshy3vA5VERJt0PNe3tkl0NPU0A1lcKOmEa7nISq4Ff5w>
    <xme:H_IhZgeANTOY-EizCWUCxzRsjX2DIZqaPDaF0rQr2y9l4AYQSVRuv1DYSzSmlYjd3
    zEHOocdsssyUXDlbg>
X-ME-Received: <xmr:H_IhZiwlou7m4N2zb9kz067dt_N3DX7FUTwVByVI3CLzBXWAiPweSB6tuvg2YnXrA71mwRwr9DXefTFXvs4e165QEN7beLkJoHm2fAPHTYEuUs4ntQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekuddgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:H_IhZuPH4vmbuMgjckp67qMSr47sglbooiVGJ6fWF5qV9LFRJYE-7g>
    <xmx:H_IhZv_RrIAKwikHDxBPx2OQu04GT4ITWayhIS-xuME_THDWxIx_vQ>
    <xmx:H_IhZuUfO0hGPWn-2HnUWMkIkkmRO7IGsd9FFrB8QmOQd2RyaHAbHg>
    <xmx:H_IhZgfkjU8n-W1-iPgQCIr2Npgy_hYDpB3baOqkqsBB4njp_qOMrg>
    <xmx:H_IhZrZM3wR49s6OU6qSj-1XrCRerkeDIhA4LMVCt2GUwctW7RVK_JRT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Apr 2024 00:25:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 149e0983 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Apr 2024 04:24:31 +0000 (UTC)
Date: Fri, 19 Apr 2024 06:24:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] for-each-repo: optionally keep going on an error
Message-ID: <ZiHyGFRPm_pwdGgC@tanuki>
References: <pull.1719.git.1713342535.gitgitgadget@gmail.com>
 <pull.1719.v2.git.1713444783.gitgitgadget@gmail.com>
 <abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AgFQsG7eK7NmWguP"
Content-Disposition: inline
In-Reply-To: <abd796894c857fc9ad96b9942089474df01f0506.1713444783.git.gitgitgadget@gmail.com>


--AgFQsG7eK7NmWguP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:53:02PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
[snip]
> @@ -55,8 +58,9 @@ int cmd_for_each_repo(int argc, const char **argv, cons=
t char *prefix)
>  	else if (err)
>  		return 0;
> =20
> -	for (i =3D 0; !result && i < values->nr; i++)
> -		result =3D run_command_on_repo(values->items[i].string, argc, argv);
> +	for (i =3D 0; (keep_going || !result) && i < values->nr; i++)
> +		if (run_command_on_repo(values->items[i].string, argc, argv))
> +			result =3D 1;

One thing that made me stop and think is whether the change in behaviour
here may negatively impact some usecases. Before this change we would
error out with the return code returned by the command that we have ran
in repositories. It makes total sense that we don't do that anymore with
`--keep-going`, because the result would likely be useless as all we
could do was to OR the result codes with each other.

But do we maybe want to make this conditional on whether or not the
`--keep-going` flag is set? So something like this:

```
for (i =3D 0; (keep_going || !result) && i < values->nr; i++) {
	int ret =3D run_command_on_repo(values->items[i].string, argc, argv);
	if (ret)
		result =3D keep_going ? 1 : ret;
}
```

Other than that this patch series looks good to me.

Patrick

--AgFQsG7eK7NmWguP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYh8hIACgkQVbJhu7ck
PpQz/g//VYgxLsc1s+alpcVBGtUI8IgxYkvmzJlCwfXeQ3T7A3xex0Doy0SRLhcM
8U2OTxEw/CD+MRD8bVPiJ3LSXa3jXJtrhzFPn9/WRcAn3KxKmO93mKT7nmGMyYpl
WN5/rxcy/o3aHDCjv65ffBrlkXTb0y/DLXCAf5gEcFS0ZL16fFioVOVdB97LB5+Z
J03x60X6JHCArgPNlM+DsmTX/1oW32ZVlIfVp/bMIkMssOGEfo/bi9AXoS5v0aHD
VRZlyQXEZHkGxVJliJ/Y8BN1Yc5dMwekENTz95DDGPY9ZAWh0S0Pjl5/AttKLkMS
zz9NJ+biSLRvXLdSbYv2Yx/u97j7yisWyXiz0yq5IBj6EkG6OkkUwm0j8o8jm3aF
cKjUxCjcw2iahJ+XnyyYVjxoV7BqvdcemSNsQNYnXh1v+bOsAkLUQg3aoo/6XgrM
NBwxwWhWtzu8Aum/k5WAK2sWWG1RdwsTLdrPzysq6AKI8kY9jbLzIl4zXV0J7em+
1S3XvtVbBZONE6ozEdy0xKa2b3A6vp3SRIjw1KrWS+FVosNQ1UapiW/b9Mo7/L2R
E/fOQT6rjcvtsXI3NaindlyHPmQ0rdt9siPY7tXH5ofHsVEq2Pj0r/+MparMrnCU
TCNf/1f3r0dNRVfnIBWKvR3T7nFr9E5qOwsR5WkbmqlgENDKU/M=
=H5uG
-----END PGP SIGNATURE-----

--AgFQsG7eK7NmWguP--
