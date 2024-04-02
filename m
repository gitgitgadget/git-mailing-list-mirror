Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF259154
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712052282; cv=none; b=QbEJ9HjNYXzZLuEpiYvFmVVET78LdwjdHs1yZiZ1dMxm9lNykJ51gt1Q9BAKB0EOnGkTRT4ZafocqStHyjrJBx7PJVUjWcasfhjXUzOnnR/EWRd0OiesiMCL0X5oo4SSfQvIZYkm1czaGTGuGYqttC+dWvNEmiI3G4ROnYUpOW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712052282; c=relaxed/simple;
	bh=0QPpOehE24ka5umaTgBwirzQsNPW+N9wZZAZleho4Yw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VcqEazaH6sUudYuAnyDNhcccVEVcUzrxe6PpzerKCZw9vilDDPCJ29iErpvMeQI3wBcmKQvYAWQ7wfWM9qPVlyuYibP3N4muMX1ncLDNdmsjtiRXWtWseZ9PYMQb1HsAPzHBgHj0NS+qs1pue00LIMW17Rq6GIMH5B+tJnaHThM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=md1VEW2o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xpsKfYgS; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="md1VEW2o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xpsKfYgS"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id DE3091C0008B;
	Tue,  2 Apr 2024 06:04:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 02 Apr 2024 06:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712052277; x=1712138677; bh=+UW+EQYOjh
	hLHwIynToS+kYlTjuke+IRBiXNeYs43rk=; b=md1VEW2oFw+gObMdvM1F4n5cOU
	976BKNj/pZCLGa4VcRvqzmZkborEA8DCNLLShQXIvQionXKbSGGA6L/l/oB9Gyt/
	ngrpNZSS86iL8ARhgvT7pcdHCyqrbV9qdpKA9TAhgOJNWwTlgcu599iu8WmizgDv
	viMITotD4tCw9QG6PnSwVGlR4tQAaFlYEsCZPkjunbW61+HxZq2ZTAvTgRI/1R3K
	egl1Ytj2yOaH9GHYFe+di8DNIDbSAzQWbAVyLMWYz8AZXOCvtuGbcn2kyiFS0kJk
	gKoexFgIFKbcDKj1DBiGaQT0zLp5wZIrz1JBmDDzFRmYeWINERnDBU8KLkDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712052277; x=1712138677; bh=+UW+EQYOjhhLHwIynToS+kYlTjuk
	e+IRBiXNeYs43rk=; b=xpsKfYgSe1TT3TKAIROobTnyqslz8xK6+LIaJ2dyxrRM
	zu8U7Z4sGdRTEOmaYJIsau5v2MSxBjVNcd75KdLxdMuuLZo00qsrpnq0qtleLo3C
	Wwn0708yQNw3i3FRUi/bVeNa5BFVHQ9i/tIDLLAywC/A1u3WskrxUkltJCBnBGrc
	E6+RYw2LQ+KbmpQiDwUn2+/QolE/T3+2iYVGSCVEMcoTNJxotBnb5HkMF0MpBzY0
	12y4oukLnWmALIiqnAmhq1dTOT2jcfk0dpq3M9F/YVzjQPplrTVBg58TeOjZfxMo
	ua0OGUl2QU0O6XiCQ77YNehBYJq+E87sN9Ji+XwA8A==
X-ME-Sender: <xms:NdgLZsFHfO_g7yWW7LlWYAm0AunnFcvrNfQB_Iijv3R-751cCCv5HQ>
    <xme:NdgLZlUPRGzDRgXdfWEieQoEV5PEJQ0-KQXbi5TXIhgxCz8eE7moRvIcPeNDmHcbB
    hjYxtoMshq245VW-w>
X-ME-Received: <xmr:NdgLZmI9fQ6OdokAO_o1iKrsije_lURrg-h3IQkOzls9aJhJq7DfeShL5CXl1Y1Vq-Vgmcr3MQy9qGA480IpiZN4YLL83vGiixzM4yJ2pE0j5F4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:NdgLZuGatIewVhI64GsXRiKMczPg5SVWJr5nSmXd5vbUxpI_tQyVsw>
    <xmx:NdgLZiXcuyzPf3LtIUlXNyfj1rH3MmmDm97OqTXGivof6vwjdsGN1w>
    <xmx:NdgLZhOWyFyaqZuSG72ygywREVnKsjbEmDtODsAnMiH29Hta8IJj8A>
    <xmx:NdgLZp2JXv4yelKdQw6skynExVNsmhIyzXQcPlO-vUBHLFwUZqNU4g>
    <xmx:NdgLZkIf_1U-LsItufL6zjC-gvpJgkYdkquTqEnYsc4pILtufCZ6Q579>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 06:04:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a2053b74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 10:04:25 +0000 (UTC)
Date: Tue, 2 Apr 2024 12:04:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <ZgvYLxfNwBcOB_s1@tanuki>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
 <ZgPSn_D8luXQyZGf@tanuki>
 <ZgSQr7uQdIA8oVNn@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fMF4nnydMnnhe0wS"
Content-Disposition: inline
In-Reply-To: <ZgSQr7uQdIA8oVNn@tapette.crustytoothpaste.net>


--fMF4nnydMnnhe0wS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 09:33:35PM +0000, brian m. carlson wrote:
> On 2024-03-27 at 08:02:39, Patrick Steinhardt wrote:
> > On Sun, Mar 24, 2024 at 01:12:53AM +0000, brian m. carlson wrote:
> > > +static int credential_has_capability(const struct credential_capabil=
ity *capa, int op_type)
> > > +{
> > > +	/*
> > > +	 * We're checking here if each previous step indicated that we had =
the
> > > +	 * capability.  If it did, then we want to pass it along; conversel=
y, if
> > > +	 * it did not, we don't want to report that to our caller.
> > > +	 */
> > > +	switch (op_type) {
> > > +	case CREDENTIAL_OP_HELPER:
> > > +		return capa->request_initial;
> > > +	case CREDENTIAL_OP_RESPONSE:
> > > +		return capa->request_initial && capa->request_helper;
> > > +	default:
> > > +		return 0;
> > > +	}
> > > +}
> >=20
> > I think I'm missing the bigger picture here, so please bear with me.
> >=20
> > What you provide here is simply an `op_type` that indicates the phase we
> > are currently in and thus allows us to check whether all of the
> > preceding phases had the capability set. But to me it seems like a phase
> > and the actual capability should be different things. So why is it that
> > the capability seems to be a mere boolean value instead of something
> > like a bitfield indicating whether a specific capability is supported or
> > not? Or is all of this infra really only to support a single capability,
> > namely the credential capability?
> >=20
> > I'm mostly coming from the angle of how capabilities work with remote
> > helpers. When asked, the helper will announce a set of capabilities that
> > it supports, e.g. "capabilities stateless-connect". So from thereon the
> > client of the helper knows that it can assume "stateless-connect" to be
> > understood by the helper.
> >=20
> > I would have expected capabilities to work similarly for the credential
> > helper, where it announces "I know to handle pre-encoded credentials".
> > But given that I have basically no clue at all for how the credential
> > helper works there may very well be good reasons why things work so
> > differently here.
>=20
> Let me explain a little bit.  There are two possible flows that we can
> have for a credential request:
>=20
>   git-credential input -> credential.c -> helper -> credential.c -> git-c=
redential output
>=20
>   git-http-backend -> credential.c -> helper -> credential.c -> git-http-=
backend
>=20
> Let's look at the first one (which might, say, come from Git LFS or
> another external tool), but the second one works similarly.  When we get
> a request from `git credential fill`, we need to know first whether the
> requester supports the capability.  If we're using an external tool from
> last decade, it's not going to do so.
>=20
> If it _does_ support that, then we want to pass that along to the
> helper, but if it doesn't, we don't.  That's because if the caller
> doesn't support `credential` and `authtype`, the helper might
> legitimately want to provide a username and password (or token) instead,
> knowing that that's more likely to work.
>=20
> Similarly, in the final response, we want to indicate to the external
> caller whether the capability was in fact supported.  That's useful to
> know in case we want to pass the response back to `git credential
> store`, and it also discloses functionality about what the credential
> helper in use supports.
>=20
> We can't assume that the helper does or doesn't support the same
> capabilities as Git because it might come from outside Git (e.g., Git
> Credential Manager Core, or a site-specific credential helper) or it
> just might not be capable of storing or handling that kind of
> credential.  By not making the assumption that the helper is implicitly
> capable, we allow users to continue to use very simple shell scripts as
> credential helpers.

The intent of this is quite clear to me, but thanks for re-explaining
the bigger picture :)

> As to why this functionality exists, it exists to support the two new
> capabilities in this series, `credential` and `state`.  A pie in the sky
> goal for the future is to support additional request signing
> functionality, so it might learn things like method, URI, and TLS
> channel binding info, which would be an additional capability.  (I might
> implement that, or I might not.)  All of those are boolean: they either
> are supported, or not.  If folks in the future want to expose
> non-boolean capabilities, I don't think that should be a problem.

I think you misunderstood my confusion. I didn't meant to say that there
should be non-boolean capabilities. I was rather missing the picture of
how exactly you can advertise multiple capabilities with the infra that
currently exists, and why the infra supports per-phase capabilities.

Basically, what I would have expected is a protocol where both Git and
the credential helper initially did a single "handshake" that also
announces capabilities. So something like:

    HELPER: capability foobar
    HELPER: capability barfoo
       GIT: capability foobar

Git would only acknowledge capabilities that it both understands and
that have been announced by the helper. So at the end of this both have
agreed on a single capability "foobar".

This is roughly how the remote helper capability subsystem works. What
this patch is introducing seems quite a bit more complicated than that
though because we have "staged" capabilities. I assume there is good
reason for this complexity, but I didn't yet manage to figure out the
reasoning behind it.

To ask more specifically: why would one side ever announce a capability
in phase 1, but not in phase 2? Is the reason that capabilities are in
fact tied to credentials?

Patrick

> > > +/*
> > > + * These values define the kind of operation we're performing and the
> > > + * capabilities at each stage.  The first is either an external requ=
est (via git
> > > + * credential fill) or an internal request (e.g., via the HTTP) code=
=2E  The
> > > + * second is the call to the credential helper, and the third is the=
 response
> > > + * we're providing.
> > > + *
> > > + * At each stage, we will emit the capability only if the previous s=
tage
> > > + * supported it.
> > > + */
> > > +#define CREDENTIAL_OP_INITIAL  1
> > > +#define CREDENTIAL_OP_HELPER   2
> > > +#define CREDENTIAL_OP_RESPONSE 3
> >=20
> > Is there any specific reason why you're using defines instead of an enum
> > here? I think the latter would be more self-explanatory when you see
> > that functions take `enum credential_op` as input instead of an `int`.
>=20
> I think an enum would be a nice improvement.  I'll include that in a
> reroll.
> --=20
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA



--fMF4nnydMnnhe0wS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL2C4ACgkQVbJhu7ck
PpSNeA/9HtQoogU4oH8D9h1NOTDIMy/vDoXKUIFasLhORvOmp33UkvMUjpZ8ZcPr
yFKoitBzvYEWSzoirRVZcqRLflKl845AExFI8MK3KuruTcz/wrh6jih6eCmKK7M4
R7jwB+OkHTh5tCqIQhcdAsRDeqB9ukE844+9nuUyQiU4QHsVZg6gUchOBA9A6Hjl
PC3cJxNRm78QGbdlCPSb/9sw3p7c+Chyk0jPR9wWFlI6VRcvw5wplMgWBF6y2bx3
mnlv9JNF3jlcyN6sydUaOzpGHHr6Qx6dCmqP9qOsSwy4Khj3+RBR2goXkZSX4mmg
SCtjXf734U2jMIBRTmDlezw5ii0T3kA18yCbez6EcBR62dd/EET5aCn2fozToq3L
rD01ouScb1dXmmByiy8PWxRWv1dflOLYXtijLGIBblC0cnf4QevSKAPqRj4uAaSG
OoeYROVHrOIfAsqGPR2zF89NXu3N37lQgOv3UvTWkeogaOOufs3CnwS0s5kN7KDr
z4SdCHpnvtvql47i8Z7hCycw7URJfmSh4ASk2tr0vT5xL2pXwam9CZy7A1T+loP0
HZnRTbO/LsxZEdIRn4QlPxURjewHiZFtC/fvxs2x/6QwAyFZ1quF3KK12akWfc3c
aJ7cfTkA4YfOO2pG6RU2NCY9JgdrUBrFlovpmo+bF59+X48Qa28=
=dR++
-----END PGP SIGNATURE-----

--fMF4nnydMnnhe0wS--
