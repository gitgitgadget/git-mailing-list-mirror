Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C32113D2BF
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479070; cv=none; b=r/aky89hBk2P8i1ucFZqLPAMmJNt7eYLoN4TYclUSP89+x3AQ5KaDVTt9exccl3JBFyvLefao3VR6kjUujvrLxsop+rST3+7jENKkP7ZGcZCTrH3/dWtlVDQaj+9ACC9QIxsosaY5xX7CixDK0K3UEOG9dF2gNMeQiHcDvSAdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479070; c=relaxed/simple;
	bh=n8U/PsT2z4Ra3e/8wkKDrgdojb6VtswgLbFCj4YgwEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jvbq2bruAI53vr7Bi+V2zZ08W5X0zV2braavHYY+BhrVBTNATTT4Mo5sTEvrSdd22nbWz7LxQXXmkBejAGm+123Ef5IAugqYN8g8ThOJrNhv8s3xWC5SG0HedPOgao2FkvWYMxpYYtm0kckOV+oyxwCOV0zvQkAG/RqOAj9eHMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NbojlmW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ONmCZ9ll; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NbojlmW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ONmCZ9ll"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 56C021C0016C;
	Tue, 30 Apr 2024 08:11:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479065; x=1714565465; bh=zL0fQEmI/+
	TADbFF+ybtYZhibxwh6emLYfsjSIYn6CY=; b=NbojlmW3vgY4ooLYDpFeSv13Dw
	rjQ/lYFJB/N2b/M1WEhPiYepK/8ELm6PTMGEve+uj405lL2a0ns5mew64AQtPtHn
	t9C7UVEJzkkAheRLvi5gESjsoOnuFkY873YNWsdLIaZzK3aTebQyzD1yFaVFA1NQ
	iZhnBLB+corCbanmzRIzG2YpWcUYeothYvgVvIo2reWWe+yGjtXZxqCJY38bDIKg
	80hFmuTdE/O/gnSl1Nt/lRocQ+0lueHq7ihQSeyp0cN2ONZOSsgi4m5f/iufl+8Z
	Il0pZFDafArD/+1DKr4/qaIo53bmE4hgapR0Xq2PhZLRZubTGSYyOf9TxfLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479065; x=1714565465; bh=zL0fQEmI/+TADbFF+ybtYZhibxwh
	6emLYfsjSIYn6CY=; b=ONmCZ9llRGy40mwlNrfBExDhVjxIQsmg9kP7mmDTEzFH
	eLjLUWKFpf2FdOda3OEZXCY9sagZ6zNJT1NosSHeRJfzs9gJFOlzGRVzkoTwNmqY
	TJCftIUCRYpL9wWfcETuk/wouITNvtypp555DvQh0N8oEiP6bnGJI7kRUlN0lwuM
	0lqoihRGS/78JCNkFrOuiPJxaX01eBy2X0ylOqinS7Ku3M8K41ceOWsUUPfZo253
	uGMl5H/uDW3E/C2aNeNN+r5sXPXCG2lmg8Pi4d7/rFEpmSwEywqbiaRMCMeuejlJ
	xIJuVRBhfIVS2J1d3BFyZpQvql+7xOparbB7Fi+O9g==
X-ME-Sender: <xms:2d8wZjdqGqeUh45Ec-Fk583vkXcmP8ixWT0WfVz634F56ln_gR35yg>
    <xme:2d8wZpO_VsZ-RlUVx9XgFDeI3d2kDMScUQJ5FIJbW8YaUL99VqATvY2NK0KpODxfL
    zK6f3qD8r_4QWv_wg>
X-ME-Received: <xmr:2d8wZsj78W9HE7SSJFOrI1LmXE8Fqi67MyB-bb55ys9Gek_kXAZ9C1Yo0WhZHdZ2xdgFR1-9ghATxlEEyaQY3Bd6ql8uaZhsgZJp0-rty27SxS4hBFIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2d8wZk9QgeNMDFFll3m9ub9bPIMRKZoEaZ18h-N7EWEPmbE7109lhA>
    <xmx:2d8wZvvvTdNDU8Zv0MArA7TeKhpaz7zocCxOsudS0XF779esY7Cz0w>
    <xmx:2d8wZjFMFWRkthpgcUIJE51SA7bJI_Q2fq6DR8pEDP74YLYiNzT33w>
    <xmx:2d8wZmMIT-1u2shVuL7MQgfNlrPvht19YoDIh-cUDrkwOSFdQ2hIHA>
    <xmx:2d8wZpIgprXlrcCuT00XcrPi3GmYXD319eShYIbcbKHihabsKjiyKLqW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:11:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5ef6dc7b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:10:41 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:11:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <ZjDf1TIqTTRMqZ1E@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
 <ZjCd_drNT6kyjNa6@tanuki>
 <e9c70778-3414-48ae-8a7d-6b6f0dfaad63@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JBNV0vxNafqaiUdT"
Content-Disposition: inline
In-Reply-To: <e9c70778-3414-48ae-8a7d-6b6f0dfaad63@gmail.com>


--JBNV0vxNafqaiUdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 10:59:36AM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 30/04/2024 08:30, Patrick Steinhardt wrote:
> > On Mon, Apr 29, 2024 at 04:12:37PM +0100, Phillip Wood wrote:
> >=20
> > > This changes the definition to allow pseudorefs to by symbolic refs. =
When
> > > is_pseudoref() was introduced Junio and I had a brief discussion abou=
t this
> > > restriction and he was not in favor of allowing pseudorefs to be symb=
olic
> > > refs [1].
> >=20
> > So the reason why pseudorefs exist is that some refs behave like a ref
> > sometimes, but not always. And in my book that really only applies to
> > MERGE_HEAD and FETCH_HEAD, because those contain additional metadata
> > that makes them not-a-ref. And for those I very much see that they
> > should not ever be a symref.
> >=20
> > But everyhing else living in the root of the ref hierarchy is not
> > special in any way, at least not in my opinion. We have never enforced
> > that those cannot be symrefs, and it makes our terminology needlessly
> > confusing.
>=20
> I agree HEAD not being a pseudoref and having special refs as well as
> pseudorefs refs is confusing. I do have some sympathy for the argument th=
at
> pseudorefs should not be symbolic refs though as AUTO_MERGE,
> CHERRY_PICK_HEAD, ORIG_HEAD etc. are all pointers to a commit and it would
> be a bug for them to be a symbolic ref. It is unfortunate that in the move
> away from assessing those refs as files we lost the check that they are n=
ot
> symbolic refs.

While I agree that conceptually these should always be "regular" refs, I
feel like that is higher-level logic that belongs into the respective
subsystems that write those. I just don't see why the ref backend should
care about the particular usecases that those higher-level subsystems
have, and I can very much see that there might eventually be another
subsystem that actually wants a specific ref to be a symref.

No we could of course start to hard code all kinds of refs into the ref
layer. But I think that this is the wrong way to go, and treating the
ref store as just that, a generic store where you can store refs,
without attaching specific meaning to any of the refs, is the proper way
to go.

> > I think I'm going to reroll this patch series and go down the nuclear
> > path that I've hinted at in the cover letter:
> >=20
> >    - Pseudo refs can only be either FETCH_HEAD or MERGE_HEAD.
> >=20
> >    - Refs starting with "refs/" are just plain normal refs.
> >=20
> >    - Refs living in the root of the ref hierarchy need to conform to a
> >      set of strict rules, as Peff is starting to enforce in a separate
> >      patch series. These are just normal refs, as well, even though we
> >      may call them "root ref" in our tooling as they live in the root of
> >      the ref hierarchy.
>=20
> That would certainly be simpler.
>=20
> > I just don't think that the current state makes sense to anybody. It's
> > majorly confusing -- I've spent the last 8 months working in our refs
> > code almost exclusively and still forget what's what. How are our users
> > expected to understand this?
>=20
> The current state is confusing but arguably there is a logic to the vario=
us
> distinctions - whether those distinctions are useful in practice is open =
to
> debate though. I wonder how much users really care about these distinctio=
ns
> and whether it affects their use of git. I was unaware of the distinction
> between HEAD and pseudorefs until I reviewed Karthik's for-each-ref serie=
s a
> couple of months ago and I don't think that lack of knowledge had caused =
me
> any trouble when using git.

There is some logic, that's true enough. I just don't think that anybody
understands the logic.

Patrick

> > > Are there any practical implications of the changes in this patch for=
 users
> > > running commands like "git log FETCH_HEAD" (I can't think of any off =
the top
> > > of my head but it would be good to have some reassurance on that poin=
t in
> > > the commit message)
> >=20
> > Not really, no. We have never been doing a good job at enforcing the
> > difference between pseudo refs or normal refs anyway. Pseudo refs can be
> > symrefs just fine, and our tooling won't complain. The only exception
> > where I want us to become stricter is in how we enforce the syntax rules
> > for root refs (which is handled by Peff in a separate patch series), and
> > that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
> > They should still resolve when you ask git-rev-parse(1), but when you
> > iterate through refs they should not be surfaced as they _aren't_ refs.
>=20
> That's good
>=20
> Thanks
>=20
> Phillip
>=20

--JBNV0vxNafqaiUdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw39QACgkQVbJhu7ck
PpTrUBAAmklJ8yxDVL7n3PrOkmyR+oT9HvC/jit3lS25TlRxfJ0Hpdx+vL5U6g3Y
Lbus8PKsB6awXrwXCitGlX7Vk8xvThHkpIfHYl6bI89okcpDd65sNmEGcYjfbrLS
qwUn9N+ptM1MnhVB6zHjkl8Sz/azCNE6ML/kNKFuoYYvdImxWWd3whfiq8gYaKnq
0cxfQqmn9VbovkwpR6JJ+uoaDKPZP3B204aHYMAFz8ufOrn6M7WLmeZahJmVW+W/
ZSkbXU+rhxqqkBvpjCR6ZuYFL3vwyb19VUPmvRl6aQDMAB3yMsekOB8wWawY6WoI
ksO5FqvqPcIJJg6AUC0vyZlUlF/j0dZZuk3nASvHC2wINYn1gsqcHi8idSwi4Tag
4gtCtZ4rPJuGO9yPEs9kULEOmUpg9iqcK54biVuGVRkV+v6pU6Te1R+6n6Es0lyw
YZoIu2Jf+81YuXBKFAPZF23OuEE2jT2y293VUekEpY+LXrhx88aThJZAwoyfb+SG
66UvR+zdhqHbRv/YeizsBnK9WNat3ZA4EX+GgcJ6DPe1ymiiqnqit2QY4OIIu8zw
8tuID7OdXKkqTWJd/vB7mo111QpMsx8qF4jfKYPBBomQafs11ur6Gps8+s/2tCmM
877JP0tC3h3i1ftWZcZCj62dIwgI01PwT5cAA16d/LOdvYA1600=
=lYM7
-----END PGP SIGNATURE-----

--JBNV0vxNafqaiUdT--
