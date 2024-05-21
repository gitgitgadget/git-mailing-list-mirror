Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9003B20EB
	for <git@vger.kernel.org>; Tue, 21 May 2024 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716270972; cv=none; b=exvorlyq+xpmIPxr/Jmx70AQCBg45tzwHKiS8S5NnOFKvmhC7FWs3pUHnegFdGjQdo4DaoTuU3GhHqjazi0bzdWnkL0gitvoHCFP8uPq9cKELYWgyq9X6nH8ctdeLdX1BFFXYG98o2UYI+ZGHWcoy7j8IPjoFq/U2E800j5pePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716270972; c=relaxed/simple;
	bh=3DRMVRb4X6sF3Uls4EAjbJtMysow6WzCYKhVW1WCxLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qYM7Ebihyo+jU3g4+QhZeERTNFz752IqtbaGyH39yW3OMXqk8lGHeuYf9TKgCtgSQxN0zLC1GSyiH7b535andF7DjUvBXJWDbsBFXC5wu3z2WM/RsXDfic/UxS1RZxR3lOXZCdzl6Be/WVtVwB1rcmMnUY7C89/FU1F5JfvXbSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IL+JRMyn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WPcCO9EU; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IL+JRMyn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WPcCO9EU"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 555F51C00185;
	Tue, 21 May 2024 01:56:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 21 May 2024 01:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716270967; x=1716357367; bh=RGNcO/RkwI
	CQu5ECLts2iZ1bTq0eiI9UAigpXyofbMI=; b=IL+JRMynS1UaPwgwpwUIPXPiej
	fIkHtrOZ7Ze+qzK3Rcbzo9weKnHKEkWgeTuZ7w3kfv9PRR5opZ7i4q4wML5PinA2
	BHKQywydcEaY6tM/jrbkrG2ucu+wEKHICuCiPhnNKJSN6k05e5PXzPRK1/EXt+ts
	I4QoFv+eCE08efN/oONufApAEVvhnm/Da3VFiA2I6vro0oJ9la8yxakobNOaqEgO
	qaN8SxzG1augb/0lsR1qcdykxmKjxHU41JRrY9QiJ9CIY8mQti+GyxNDwi9Tov7D
	hm0IwCq360XD3bOHmn0dm/fJ8NMBXBQeXhoD3wkt6rTO8NqqteZkAkB8X7AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716270967; x=1716357367; bh=RGNcO/RkwICQu5ECLts2iZ1bTq0e
	iI9UAigpXyofbMI=; b=WPcCO9EUnQzb5osCD70X/jHnJS2LzWTxLXey0BoOeLwS
	U81JEDapJcIHco23A9A7mLW831SUt8w8kWTKzFj3kSxE5rXnN1qx7ULo7uKiVKBa
	3cFbfgKobPrZcxMpggpO5GMbqVVz2pDEnA7xYSKsFpD2Q8VrC7Ya1b+tAfMMEDTv
	/hGL2a/1RlwrRU0+hLDbIFjRwRGpgmBTyAY5y3efJdBo0dr4lD3l5K+P+4S/Ya/2
	qGlqmdt2pQEz/l7Pgbbg9W9s9bpATS4/PoIy6quvlTLoKrjFPQrMiQESoIj5iR1/
	79T7fqrYozxb+aPfldIEOwmI+4GwU6M00KOxrSKGMQ==
X-ME-Sender: <xms:dzdMZtfxuqETAucQgZ3jw1coETVpC0BqF_0zNQnHv8cSmmSFnIbBnA>
    <xme:dzdMZrM-Cn4pSJHQbqpS2ITnmop3eoW2rJR9_K6DpJ-xRLFZp_KKOJ54uHCDwA4Gc
    aFFcZ7UBqKlyHBxZg>
X-ME-Received: <xmr:dzdMZmjcFd1Cpl8YT3Yde1cPJydKJqxrN6RyetqKydbYcXxLPzp3YapLXeb_LRtxewwB6aOYVuDWE2mq4qFFnmlYops5HTFI6vqCYrza3Z6YFc9p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:dzdMZm-0F2sl-dAGcEkRqzz6ZGU2jLMSK0pyy93GY28Ntq2S8GHPeQ>
    <xmx:dzdMZptRy7m58kyz-WAhjE98EE2SCBc56hBs8tsyV3sO8NFx3qMwyA>
    <xmx:dzdMZlGdrezkofGpgNWCBIiXFzEV5MFoPu6265mt6ectlHoQGGArxg>
    <xmx:dzdMZgNTjHhq-cHxY3kpOkmboqHMQ8b1k5-ONdOv_XPjKHxJiTGv1w>
    <xmx:dzdMZq_bnJDTqaVUpyU6OcUKRW9mTBSa-0uRTXm-G7FQ-jqGIIZm_kuo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 May 2024 01:56:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 14a320af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 21 May 2024 05:56:02 +0000 (UTC)
Date: Tue, 21 May 2024 07:56:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
	karthik.188@gmail.com, me@ttaylorr.com, emrass@google.com,
	nasamuffin@google.com
Subject: Re: [PATCH v3] doc: describe the project's decision-making process
Message-ID: <Zkw3cWb_jiY1afUZ@tanuki>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <5446ca49e042b104923ac2004d845a5f9018c9d9.1715894135.git.steadmon@google.com>
 <Zkb5WeaTOLg9b5p8@tanuki>
 <xmqqy188jst9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HxXvR/OE/vkUAbfi"
Content-Disposition: inline
In-Reply-To: <xmqqy188jst9.fsf@gitster.g>


--HxXvR/OE/vkUAbfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 09:40:02AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> >> +When consensus is reached that it is a good idea, the original
> >> +proposer is expected to coordinate the effort to make it happen,
> >> +with help from others who were involved in the discussion, as
> >> +needed.
> >
> > One thing I want to eventually propose is to go further here:
> > documenting the outcome of the discussion, regardless of whether we
> > decided for or against it, in a low-overhead format. This could for
> > example be a small paragraph in a "Documentation/Projects" file that
> > points to the on-list discussion together with a small summary of why
> > the decision was reached.
>=20
> Having such a list certainly is handy; the problem is how to keep
> them current, though.

I try to somewhat tackle the issue by explicitly saying that the format
should be low-overhead. But that of course won't fully make the problem
go away, we still need to make sure that it's getting updated somewhat
regularly.

That being said, I don't think it'll be all that often that we need to
add new items to the list. We don't have a ton of large ongoing projects
in our codebase. I'd claim that we can rather measure the cadence of
such projects in years rather than months. So we might get away with a
"best effort" approach to keep it up-to-date.

> > I don't think that this change needs to be part of your patch though, as
> > your intent is only to document processes as they work right now. But I
> > wanted to bring this up regardless as a foreshadowing.
>=20
> Yup, I agree that it is probably better left out of the scope for
> now.
>=20
> If we are in the "expressing wish" mode, another thing we might find
> it useful, if such a thing existed, is a list of principles for
> designing new things.  E.g., not changing an established behaviour
> to prioritize protecting existing users' muscle memory over whims of
> the day by folks who haven't had enough time to familialize with it.
> E.g., the plumbing output is sacred but the Porcelain output is
> subject to change to improve human-user experience with coloring
> and pagination, etc.

Yes, I very much agree. One of these principles that I want to discuss
soonish is the design of our CLI. I think we would benefit if we had a
set of guidelines that show what our ideal UI should look like. Many of
our older commands may not fit into such a UI design, as I think that it
has evolved since the inception of Git, and that's fine. But starting to
think about the bigger picture here and where we want to go may be quite
helpful overall. It would make it a ton easier for folks to argue based
on established and documented principles instead of requiring handwavy
gut feeling.

That's only one part though where we may want to lay out our principles,
I'm sure there are others. But I'm throttling my push for more structure
a bit, and rather want to lead one discussion after the other.

Patrick

--HxXvR/OE/vkUAbfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZMN3AACgkQVbJhu7ck
PpTAAhAAolleUikQZF+OY4hDrPlLqqy5eNzgAp/O9swv9FDwN0d8G2lOcTtTR9AT
FtJOrGbH+1JiNV5gPRrcAq22/Ytdsay92r2MBWcWNdWLt9viPM9ec5nwjkZRDCJg
ljqgmpL8uAPjTeGDgHh/70xJOpuz0X1gOiFx658h55W3LwpxrRYGgyy4tJsV/fH0
YvDZyUdxSwxJfksXaBH8HmKb1StyE0WVxVs8mDpYKhbvxdllOpabZMVKUnzNnP9u
xtFDoE8qCKynXb6XBFvqOsnon+TTKfSSuZZ4M4/5Uk47XbEAphpcTkr9ygDzoSVY
sr94j2y8VoMr8LH1jJWaMV/nPmMhEVNA5jpkrcgilOA8sVI8moT7RnwkTWwUyQGQ
fw3zOk0fmbOpPNqNFI2g+xaO6L4F8YJbSGXNd2WBEA6tDxRVOn99WRC3vEiTjrHM
tZETdMcvE290UR0dsfd7tdEniK6Z/qpDzVvx5FECzqm/++pj7REXJO3qx1hSfuHY
CLNWKsbex5GxyIdQSkLg3MiRSaOhB5VmySvRqvA2igjOJL9WofsoUowQLDYYObqS
NSXRAgYEznfrb8xsDIJGhHFOHcMaZwXrMgu89V7cQSZLfXRb9RUxynP0lXV3PJF0
PWPqWclgtZx1Ke/bMuzxOskDn0a/e1KJmKYYxJWOuUqITLzQSN4=
=MJYG
-----END PGP SIGNATURE-----

--HxXvR/OE/vkUAbfi--
