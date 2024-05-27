Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545394C8B
	for <git@vger.kernel.org>; Mon, 27 May 2024 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792371; cv=none; b=pZwFcnsjKhARnoDrLOHpJnikzi5jt3bP34lGUj8PYiKT/jBq9N0tH9LoxDuYNJCSelH/+Cl8KmDFmvhoOS/KercDJl1lLstBDeck5a4LcWWi4yjC1qw09h314TbDBORKYOUb/OaOSmGovsejw8HYeBxk/urCIlFbjWm4FdxPJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792371; c=relaxed/simple;
	bh=KUilpDtu99tqLWHbvJLiZrxsIFFEKfji1YCRDOPcJqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPvMXe4k00uX2salvt/VDmyKYbwvZoEtRcPjSJS52wsPUTZgKxCIdPnpppPs5VjqrqMVeBC4hFia/bQ9YIpez+FH5fHTuP7KwpQAnYeHQhFQZUsArnTnid+qQfcXdE00qy64brEefTq6g3oJiBkeqluul6oSckNJ8vOnV/XdAQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b2P12IwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AcCeeWdO; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b2P12IwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AcCeeWdO"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 611C318000A7;
	Mon, 27 May 2024 02:46:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 27 May 2024 02:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716792367; x=1716878767; bh=YqtOVWodU1
	x0KkRSMor65j0RED9gYttS0+vBkkROgfI=; b=b2P12IwHsjIxS6EOCSz+pAWqIf
	DzvBADgnYb7GKeNj6cxLAd/IG1EN5h3lKcuTmKrkdMy1y8fkfiDNcz4oz7lzLR66
	CkXPzqNn8aCFkq2Nrb8JWWk8cwNvyZKt2IuSAwRFhWi/R/gF3vOzDlf8GbZKLO+Y
	5GC+6l6OUdfTYPEhGopEn+LR52fnYxfTPGUtxM4F0wcp2bpaQyxTnDH3YpuIA/OC
	+lVl1c99BDgvp38Q+m9vFs5tQdegQoPPKLXFmTBih/gZ5120KCZFXIY4QpkyLcH/
	c8WYS99sV11PRZqBhOEEhwQMfARn68tOoPKsqWf6cbfdu5ZzXO+3hz6MtgbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716792367; x=1716878767; bh=YqtOVWodU1x0KkRSMor65j0RED9g
	YttS0+vBkkROgfI=; b=AcCeeWdOFP1sWrBDJJAyY2px0hY35w37Y/BK2yMIe4c+
	LyUG+dRDZkNpQyNM6tww6oX9eV6cqkD7B2Y7FmPxd9pJFz4A824tTnKF4QAYnc7d
	hWY8tjsL/QxLeDTeCGCRhKHNLt6YgSUThWKGuN++Tzk2zWqAj4NimCS9fS+vPcI6
	dHHvfgcFjV3KgjEpQ3qoiPQ7T4JKaR2d0/H9G2WhXznwPO5Pq5Si+IvNK5fZOGux
	L2MDIDhG0O0pFvoAogpnqbmnzkDnzDPNq3/ES0HA16Nz8biwU6jg52iBiJbDxWu8
	3ggwSyG7MUImA5vzNv6xhvKqI2XxqknaIoRpmUcbWg==
X-ME-Sender: <xms:LixUZkfTvFcsB3aJBNH79_IgihKt45xybVx5iIKxD5yXI6tGke9kPQ>
    <xme:LixUZmPboaAMPiD1o1vOQVkQLvlZAFbCLAZMcvOfVlIAGlvgrjTo5nCzg_3maIrWj
    XFaFjLzYLAk9t6RuA>
X-ME-Received: <xmr:LixUZlizqeACO5NSbrixbKIL6KHfQf0WKc0TnVR_mJB1YoHclrF5rbbG2oIU9ISBb0lz5k4R39az0f2oAUcS-w0hs-nMkPVySbN97Z1caxfRNmkn3OY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:LixUZp_YZQlQGA-bDOiPE9pcEMMGWw2Am-E-sRJVye5yj53scxbgBQ>
    <xmx:LixUZgva01Gl50ryfnQAd6kECOtuTcd4vS6n1glweV3FLnDFL184tA>
    <xmx:LixUZgFVJDozYHmep6WcgCuW_k73eoD1wJ3NEQAmN2ZNo0e0nmZtmA>
    <xmx:LixUZvOoYBP-7JJ0BGxMfXLR0XoTAZ02upsceGMwmqazadQbLhGFxA>
    <xmx:LyxUZiJDdTWwEF7_bWdFfRmTw38Duy0NisSCR7EUKdpdKO1GX-ugtW9U>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 02:46:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9e388ccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 06:45:55 +0000 (UTC)
Date: Mon, 27 May 2024 08:46:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 13/21] config: plug various memory leaks
Message-ID: <ZlQsKp2IHt2wankn@tanuki>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
 <70e8e2651306e9d221e5e472720a7610947580a7.1716541556.git.ps@pks.im>
 <20240525043347.GA1895047@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tWULT4tVM3DxiZZH"
Content-Disposition: inline
In-Reply-To: <20240525043347.GA1895047@coredump.intra.peff.net>


--tWULT4tVM3DxiZZH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 25, 2024 at 12:33:47AM -0400, Jeff King wrote:
> On Fri, May 24, 2024 at 12:04:12PM +0200, Patrick Steinhardt wrote:
>=20
> > diff --git a/alias.c b/alias.c
> > index 269892c356..4daafd9bda 100644
> > --- a/alias.c
> > +++ b/alias.c
> > @@ -21,9 +21,11 @@ static int config_alias_cb(const char *key, const ch=
ar *value,
> >  		return 0;
> > =20
> >  	if (data->alias) {
> > -		if (!strcasecmp(p, data->alias))
> > +		if (!strcasecmp(p, data->alias)) {
> > +			FREE_AND_NULL(data->v);
> >  			return git_config_string(&data->v,
> >  						 key, value);
> > +		}
> >  	} else if (data->list) {
> >  		string_list_append(data->list, p);
> >  	}
>=20
> IMHO this should be done automatically by git_config_string(). The
> current design is an accident waiting to happen, and in the long run
> every call is going to need this FREE_AND_NULL(). By doing it in the
> function the calling code is shorter, and there's no way we'll forget.

In fact, I had this in my first iteration. But I didn't feel comfortable
with it exactly due to the reasons you mention below, where often times
we assign string constants as default values. This requires us to be
extremely careful, also because we do not yet have `-Wwrite-strings`
enabled as you mention.

> I posted a series along those lines a month or so ago:
>=20
>   https://lore.kernel.org/git/20240407005656.GA436890@coredump.intra.peff=
=2Enet/
>=20
> The catch is that you can't do this:
>=20
>   const char *foo =3D "bar";
>   git_config_string(&foo, ...);
>=20
> So I introduced a new function that took a non-const pointer with the
> new behavior, with the idea that we'd eventually migrate everything
> over. It looks like you may have already done that migration earlier in
> your series, since the move to "char *" in the previous patch was OK.
>=20
>   Though as a side note, sadly:
>=20
>     char *foo =3D "bar";
>=20
>   does not produce an error or even a warning without -Wwrite-strings. I
>   think in the long run we should enable that, but there's a little
>   cleanup required to do so.

Indeed, I had the exact same observation. I've already got a patch
series that enables `-Wwrite-strings` and that adapts our codebase to
compile cleanly with it. I'll send that series once this one here has
landed.

So my proposal would be to leave this patch as-is for the time being,
but revisit it once both patch series have landed. Does that work for
you?

> The main reason I didn't follow up on that earlier series is that
> there was some discussion about maybe moving this stuff over to
> strbufs (after teaching it to handle literal initializers). But if
> you've managed to remove all of the cases that needed that, I think
> just sticking with "char *" is fine.

I don't think I managed to hit every callsite yet that leaks memory. But
I think it shouldn't be too bad, and especiall if we follow up this
patch series with `FREE_AND_NULL()` on the out-parameter then this
should be fine.

> The other issue raised in that thread is that many of these config
> variables are also passed to parse-options, which treats them as const
> strings (and we get no compiler support because it goes through a void
> pointer). So they may leak if we overwrite them, or in the unusual
> case that we load config after parsing options, we may try to free a
> non-heap string. The one we discussed was log's signature_file, and it
> looks like you split that to use two variables, which works. Junio
> suggested an OPT_FILENAME_DUP() option, which I'm also OK with. The
> main challenge to me is being sure we found all such spots (and not
> accidentally introducing new ones). But I don't have a good solution
> there.

Yup, I remember having some issues with `OPT_FILENAME()`, but to the
best of my knowledge I've fixed all of them.

> > @@ -1566,7 +1569,7 @@ static int git_default_core_config(const char
> > *var, const char *value,
> > =20
> >  	if (!strcmp(var, "core.checkroundtripencoding")) {
> >  	FREE_AND_NULL(check_roundtrip_encoding); -		return
> >  	git_config_string((const char **) &check_roundtrip_encoding,
> >  	var, value); +		return
> >  	git_config_string(&check_roundtrip_encoding, var, value); }
>=20
> This should have lost its cast in the previous commit, no? Applying up
> to patch 12 and building with DEVELOPER=3D1 gets a warning.

Ah, good catch. Will fix.

Patrick

--tWULT4tVM3DxiZZH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZULCkACgkQVbJhu7ck
PpR25Q//QvibfGGDUXuWdpn8prEq735ktPGttQb/meUBaI6QvPrWM6HTfjnoCduu
lMvEIGK7MlOx1vq8576NwkGIuM+ASRaJl7PlpA0485neLtZGuVqMvikue8Qtmgwa
5JbkTiZ/yipRE/tzlcvTIAkI18MGSvkUAPW2IC/8ZCNjzT0WzhLZl6VfydmQdAzY
gB1EZbKrISfC40d0ONcpuBPjyCEWouoe3WT4IXXomRjPL8oGPCVp29BOQqw2VZkP
751sdxp4qWD4ZftPianiUHAcInaJ/DyovGQdh+iwRrrnMWJgcme6rRQ6wMxioGfB
yKHy+Lvv7RUmtvTOxSNpZUMs+t1cRJCgkinI1fs/HYxWmLuPfU+YdO9q5K7C1J8G
BRai+rsv3OYiudQzjHt6+InWK8LR+Ezwi7VsggfPIQcHe/Roy9ONlbx9Ula2wLzj
Acvfgvd9R8m+JZWcI55j/DwJLMEuJLtN377hp9mqbl/yTf7RgfMrFotQ+AT5hJRT
rJFcXa51FwnMCzN+d+0ZRZ3myr8DdGXBdGiO0mY6E5/BqOXh8PskPsHRgT/i3Ap0
cjFVhL+wTJZA2RcdTZVi5QQYUsjZmtOG5wje8ggvRU34Xtt9O2VZy9wnJuAXbLmo
/5k4wyYTbyAj7hpjv+u0W4wEUmn/VI9bkOOCIqv1f5IunQCUM6c=
=K30W
-----END PGP SIGNATURE-----

--tWULT4tVM3DxiZZH--
