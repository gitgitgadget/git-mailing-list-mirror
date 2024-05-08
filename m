Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA5884E07
	for <git@vger.kernel.org>; Wed,  8 May 2024 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715176506; cv=none; b=UpdJDXMLNLK/EGewhTnvF4dkCI+yt9l3fJm5CeQV9IHZhYUBhjy6352CBT4gjCGN1a1jL3bZ7rkZadpyoqJV1jH/qzVwjLp9BGimhjTWIFva1aKuGukY6eB2K5DVvn8gwQluybxWdQS4rT+6CZu4DYMYBAGqDMsqsc9jhw9Q5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715176506; c=relaxed/simple;
	bh=rhvzzMiJFzjNa7OIKtvH6n0OdxAZ1dnf5m157pS7Aao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3gXRjk6SCVZNhmsIK5DgBzal0INgE9UOchyFzzI2vlXv/5FY5ICvvhBTj+U35anOThhNxIdG5mAPT8ApfufoXHDR8SXX7Ym4TGNcCekhW1aJIkGXYDv0TuWFxnOsiWFU3Jv2d5RyeL7gKvcLZhtgxP1HT9+Luh0/cCdHEn4yH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FlyW4ru6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MH5AvKhm; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FlyW4ru6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MH5AvKhm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5A0961140148;
	Wed,  8 May 2024 09:55:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 08 May 2024 09:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715176502; x=1715262902; bh=OqGIvDqUyZ
	CdGlaewiqRVIYqMm0dMAAAdeeOR4r3SFc=; b=FlyW4ru6o1pl28WytkxfiDlo6r
	UVgVJjsIxL7bZ7M1TSypdzuWRWCWINOGo9OdCzP7h54DZAy4D+B+h/hfh/MM4Kl/
	RMnPAs2iYtumJAvo09Jbe8cYYHxOEqlYiik68kG5mAi7AXURK0y2yVusj1VS4tRR
	H28xii8d2MYs1X7b/5fZdeLVJfdsXTO1lsH//L9LZkyLYB0fQkUiho4ugEfwjw/e
	zjxRIwnt9gKsP5/DWdN/PVojIB+6WDqh7brMMKMYYXNvEeqF3HWxJi+KvE4NyIq9
	Aq7MkDWdrCTREvsNtFS3WocZ0xDbixzZoPkfAqK02F0ZHgdHo5UGdGQAqfeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715176502; x=1715262902; bh=OqGIvDqUyZCdGlaewiqRVIYqMm0d
	MAAAdeeOR4r3SFc=; b=MH5AvKhmABAeu0htm7xT7zCuI7aFLyAcZkDKkQddYuwo
	bMXXHnu6cAvS8WxSh7Ys0NRbvp+Tcagu2nfr9cVizyr9VlyGd+jieGR15T6TtIsc
	EFVrhTSF+RdDPxWkCxyQZGlM9PLT/mdNTYPq5zvutms80TfWmbc2EzEOohM+0nz0
	3evsUEt0p9HStNVKecibRaL4Aah52MxJccMhvsjDexfW22qsvVCu36h+d5SmtWqw
	ttICGZO6xiKb3qjDpOE1Ky+/ZRpuTGT5flMlIw4ylUtgdKSNZo+tQKIWqTBA4cpD
	/BA4mNKPAEZn2/POBnJcZAkJPMgSRanstE8c2K7IsQ==
X-ME-Sender: <xms:NoQ7Zj8TAYlbRA1Kby7yyPtvRkNANRnZlkaf4K_i9jxHynfXpSXoQQ>
    <xme:NoQ7ZvvnyfQd2js8iitLhHu7hVN_JAh5sGkUpRO4IkvY1h0ruMEdIptCknD-G6Ry8
    gDr3EDxpVY0Syd7nw>
X-ME-Received: <xmr:NoQ7ZhCgJx2Ld7vQxodLdRQKEFkhL4s14OSbrkOpkszhUPngriFRMaYRapGqvre3yn6r4BSdQvwS2roYJEtmi3P8ogtxnWZfTwTHgsitMHmLoCbe9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeftddgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NoQ7ZvfyULeJyqw3bLtO4X0dPMwqrY01ftLgYOBEGIhtQ85_J-0wpA>
    <xmx:NoQ7ZoMhuTEtYJ9T5KyeZ-JZOdkBvy-6lwyu4vbQ81dSySV6LBmVQQ>
    <xmx:NoQ7ZhmTmX-bSskatMjfRcftTkcyfvC8dXNm97eWLQqAlCtVbD8k1g>
    <xmx:NoQ7ZiupNQof3ofgU11LZWAJYBAEiZbAMWf017NGzijEdqiZi29gDA>
    <xmx:NoQ7Zha8Z1aeoYOV3WIeDGVNCAwksofKupARKNjYL75zv2iHRwvJT21g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 May 2024 09:55:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7da5b143 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 May 2024 13:54:48 +0000 (UTC)
Date: Wed, 8 May 2024 15:54:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <ZjuEMNsw-KARJjwx@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <xmqqle4lnuvy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="//xaYgW/Mbby+E/V"
Content-Disposition: inline
In-Reply-To: <xmqqle4lnuvy.fsf@gitster.g>


--//xaYgW/Mbby+E/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 03:02:09PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Over time, Git has grown quite a lot. With this evolution, many ideas
> > that were sensible at the time they were introduced are not anymore and
> > are thus considered to be deprecated. And while some deprecations may be
> > noted in manpages, most of them are actually deprecated in the "hive
> > mind" of the Git community, only.
>=20
> There may be a new way that we hope is more suitable for folks who
> are learning Git today that achieves the same goal as an old way.
> It rarely means that the old way goes away, even when the new way is
> more capable than the old way and the use case the new way covers is
> a strict superset of the old way.
>=20
> Such an introduction of a new way is *not* a breaking change.
> Everything the first paragraph talks about is a "deprecation" that
> does not break anything.  Documenting them is worthwhile, but it is
> worth pointing out that it not what the title of the topic "upcoming
> breaking changes" covers.
>=20
> I think you should explicitly say that we deprecate but rarely
> remove and old ways are kept for backward compatibility in that
> introductory paragraph.  Then propose "But we may want to remove old
> ways and deliberately break at a large version bump every 5 years".
> That will lead your readers more smoothly to the next paragraph.

Agreed, I'll something along these lines.

> > Introduce a new document that lists upcoming breaking changes to address
> > this issue. This document serves multiple purposes:
> >
> >   - It is a way to facilitate discussion around proposed deprecations.
> >
> >   - It allows users to learn about deprecations and speak up in case
> >     they have good reasons why a certain feature should not be
> >     deprecated.
> >
> >   - It states intent and documents where the Git project wants to go.
>=20
> Another thing we may want to describe in such a document is what we
> do not want to drop and why, even when a new way that is a superset
> is available, which would give newbies with a natural "why don't we
> force everybody including the old timers to adopt new ways" question
> a reasonable answer.

Okay, I see how that may make sense for some parts. I guess one of the
motivations here is things like git-checkout(1) and git-switch(1) /
git-restore(1)?

Do we want to give this class a separate name? Deprecated may feel a bit
too strong in that context as it does imply eventual removal for many
folks (including me, I guess). Is "superseded" better?

Patrick

--//xaYgW/Mbby+E/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY7hC8ACgkQVbJhu7ck
PpTulA/9HgMAdcOzhKUkbF2N9hWyv2d7uV5JSF4FcK6nGF0R+4pG4cdXcvazPok9
OPxEXAxDiCV32NsNMRUbiQhMDcGvGkSM1tr/LQUvUpZ6qlUmU/zo35oPfi7QqyYn
gtUfEOKxgr78/kT4+krtGB07nC8ChK75NQR+ET1aIABkdYDiyqaYjyEjrIdGfF5t
l1mUZxwHbJl+mC/86s3uHwc5znGjeYRMQLdPIiaOZWOk2OXKNIThY3Tvg/OyBpC0
mO4A/3bks9L5dLO4oJU1UmvA3FJgDoooDt0Axa6hIq33Ec18VEgYK68fAj4kYdat
wzud4DBv4fyCcaMVA8VR5CY6LSQCulU+cuyZlOrjfg4julEkCTIMKXh3SL2weX+J
AwSKRI0MVYC1AXzUd3hXz9nic5cIUUkBXkQL6Y4nD9Bgf2HD/K09BSeTy6EcmQpr
6O4tUPDlJgtyJwxsOles4mxa51GYPghECFlZhYZhprBeul/o9sDNKQ73+Io4/svs
hsRfes6rZBn48DbLsTvRioNrYP1a/SryJ3ZTw+e97z9SeppjRkq1M2z1GFYTW+RS
C3YJHFeRHDdvLWa5s2VITNnKD3rSWLoINjENA5UgBwEO0z6D6+CBG4OtwufiLO7i
6PYNAcWhz/8Jq1oG+nmbVqJF4sptusXW/fMZjDoQO6BqqNX1gaA=
=Dgce
-----END PGP SIGNATURE-----

--//xaYgW/Mbby+E/V--
