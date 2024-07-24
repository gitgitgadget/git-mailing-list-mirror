Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB65157A58
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721826764; cv=none; b=sR5zyovdc6H2io3pi9BL2ufQJD8ZMp49P5jSVwlfd/8mupH6fH2kxLCALkWvPe6QhxLlhVzPpIRxZ+hhT/BWzOWsj6QUiub+zny0giKbX7OaDpcEeSwjAYLeig9O9ZyHX26srSOWodaEqtY93RGHFBi1NMpUu1UMjdpSwT88V/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721826764; c=relaxed/simple;
	bh=Dzs7Hl0am1IgBNIIUFwh+WMUnjUNgiOMvGDDZq4u2Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYNTh2r2qpEeiHOwQPWbjGQ2pJAO6HYaFp2dY3TYn9zZMscfxjXlVcri56bY00AzUPnw+OEHRndJhUFP0cQcVuPMCEBNA366vIorNRKMV6GcZDf0DVMoO/JHF7NpbNI7BFyzM6Ydbbngg4C2izaJQKo+wMH90L0p2IR9HwaoMFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GMAjbwh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rBR75RLx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GMAjbwh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rBR75RLx"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4E2081140154;
	Wed, 24 Jul 2024 09:12:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 24 Jul 2024 09:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721826761; x=1721913161; bh=I3tYf6SeZ6
	hIbO0PWKF7f8UfHUzuqicJRPPiqUinXsw=; b=GMAjbwh4CU9IxGCafH+NUNjIqq
	qh2QQ0nnnWDbXroC/kLh5RE+HrLpvbxDjUHZ0sD27Sls91+qQd6qinrGdEDJPoVg
	uCvANiBSoL5IxFNqNFTv0IO5mp0GnfoG0xWFqb89AbE8f5rMp0qsmohtpTKdPK8L
	z9lZao92/KGJPYOP+SvoBoQxPTMQFL0n3QzPOemfcTTzQcEpQC/uOzi74Aq7GPzP
	1Vyx9eVIRXWt4s66p0gWDNwc2DPUCzip7lGaAcAbX9VQCSaPu4zRzr9mul2APxQ+
	tH9bCPB3hMNXNrxHr0LFbFuZQM7ZtIsCAvUK0kMybPuseLB3iJA78gJf0eDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721826761; x=1721913161; bh=I3tYf6SeZ6hIbO0PWKF7f8UfHUzu
	qicJRPPiqUinXsw=; b=rBR75RLx1A8mzQRaTRd9LXp2HypdKiTstLCdLYAVPtsO
	MnGFzU5EmhJmIUigEGleEptUHTdOdiVwqehYi/qSUoTixjNSS6drXYtj0HUvYkgs
	U8qT3yU3JKVYg5bgbKcpMsO6zGmdFnGK+8ZFHBDYmJmO0nCjNuQZmB1CEtk5jWu/
	XnY7VKPWkvgQ8sP3lRaHOnqF2ic9tYrDU8r1L8pmLHZ5aXQzVJokrpR38/RhEwhJ
	pNkLrhbPNQfSxz/irH5Vobw9rHqxFxViLszAqZL8fJo2KehKdnyVpWbt8uPcIlFN
	rLCsrJbdlQzSd/AABqX9RzaUuAZ2CON1/Br5wzudPw==
X-ME-Sender: <xms:yf2gZuaEJsEbLa6-TJwhHp_MbWYOFHX-NIfzRk8pIc-wuRjp5xiEOQ>
    <xme:yf2gZhZWyxh6J3lMtddaAenvisB1weWWzHzqLDOv-BKqwvXsjpBRFytxX81JfQavp
    UnbWnO_67QIm6IgOA>
X-ME-Received: <xmr:yf2gZo_Dk6WbokfjfsbXCdekDThFK99VR0JsuGbgaYy-cs83S8Bd__euDmUhj_IO9M-DjmzcC9QJPTe-TFYuuYLK16ywij9ghX0KI8lp1vQZgIj9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddriedugdeivdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:yf2gZgoqVNBWAViJ-AUSqqevUpo6PfX0Kpt-If1T0bIKgUbea_HmRQ>
    <xmx:yf2gZpqmFvsomTSVyEKOmK9b6HXW3FPI6dClQeCj4pi9FABZf716zA>
    <xmx:yf2gZuTnMeU8cVAQ5KvP-h4yD0D-oXGYoubk2A9qC-rHqS5yqOBeXw>
    <xmx:yf2gZpolZF3d13BxjLsJLxLhc9fJSby2YumA4q0b-8qumsIuRio4bQ>
    <xmx:yf2gZg0tcuZiXzmPN8NP5olHn5YH7KDAZjbChlUaxCJEEO5ksQIKdwhJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jul 2024 09:12:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 34ef374b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jul 2024 13:11:23 +0000 (UTC)
Date: Wed, 24 Jul 2024 15:12:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] Documentation: document naming schema for
 struct-related functions
Message-ID: <ZqD9xMeFiaTUKPQw@tanuki>
References: <cover.1721818488.git.ps@pks.im>
 <7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
 <CAOLa=ZQn1uYSd0089+jOguVBSnKfZjak4766V3B8mXn2hBgAkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VF4soWD3pBdCI+Si"
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQn1uYSd0089+jOguVBSnKfZjak4766V3B8mXn2hBgAkg@mail.gmail.com>


--VF4soWD3pBdCI+Si
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 04:42:29AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuide=
lines
> > index 1d09384f28..34fcbcb5a4 100644
> > --- a/Documentation/CodingGuidelines
> > +++ b/Documentation/CodingGuidelines
> > @@ -541,6 +541,25 @@ For C programs:
> >     use your own debugger and arguments. Example: `GIT_DEBUGGER=3D"ddd =
--gdb"
> >     ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
> >
> > + - Functions that operate on a specific structure and which are used by
> > +   other subsystems shall be named after the structure. The function
> > +   name should start with the name of the structure followed by a verb.
> > +   E.g.
> > +
>=20
> Nit: It would be nice to add `<struct>_<verb>` here, since we do something
> similar in the next patch.

Makes sense, will do.

Patrick

--VF4soWD3pBdCI+Si
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmag/cMACgkQVbJhu7ck
PpSTzw/+IHzJzeUAfG5Zx1M95hRz8dKSvG4Jbt1sAMqONt8lZqhsS6oP/S978a8n
7kVXL3/+7AR4VQP75Hw/QRzbJMbLigG89mdxYHVIsheQcOZj1QjwfhhOisQ3zL82
yv+/Q5CjTXeGjq/0JAMeph4MtnpS2wrC4bibNlTpzNcsZ059rY7urera6rRPCfyK
1F7OPfDScydq6uMxywHIuZ2AXknaENUUisvk1oxj1RAlajX+VCtktCmGa7y/SiqS
0pyF6sEUdqw7SUDwf3Vv7rd5PmWbsTsWfuVwz8hM/klKgOVWeWo8uDoqc/F5qZyq
qQzoDujLoEd1tsaV7QIShbxPaEwnk7rCfNSHX/ObNnzDUrvzLgDJlOZDBtVeiPmR
Jhyk5mbPIhSdzst7XKBpMnEB0N6QCB6mu/wvvYsPmOcC3BaWwHrMYkMVLJ5rgalG
k9LIBTX/gQ0q5IhA3cOBW6d0qsB5We7AGaQBKYcrrRc8sKyyE2/grPspylTndQuT
lyEyP/KhbHqn6qtzz+xIffl9GTSCPPVtGP/ceGR3UunM7XXnja/6dJo/06WvKyte
ZDO5LIb17/bu9CDwxCft/SctNOyWntFIfJ7sGygcspgaGW2LkOVExA3dcD/Sh3RZ
FdniT4nf+IarBFbszhy16aYJUadPWIKL+RXWC4LEs65vgZ7v4ro=
=d6eq
-----END PGP SIGNATURE-----

--VF4soWD3pBdCI+Si--
