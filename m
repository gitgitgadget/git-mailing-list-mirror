Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550A21514FA
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107797; cv=none; b=OaZ4wIC/iw7oMuzStqzJK1hQS+ZlQqrA6BhWkaq0v78MpKpWMLDm2jMDwt9QCdlPWovcFjKlBlX9lk7MtDw2gW+ldi9I+dWvKhgxOV8nnWLq3jncSC1GKeJdN/K5M/BiS1xPVSDGdYaoTbu1aSixnWOLaPW+cHyUsfo42g2uKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107797; c=relaxed/simple;
	bh=X9F31TJ60Fb2z/GSzzISO0z2zjaTau2UMKFzSI3IuWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVcqOAw5whz1FwYbdZxfTlS8+36piadeXLrtPEidijRCcsIS5yKfQW6Trz1ZtdOLFQzZOn13CQ2MqUZXKxZdDYeLB/Zk/40a3yJlrYKaEb3FlzgkHDbDFKNrrKCcSmn/cnChuWXIin4ezqLrI2iZsqCcruVjCAvzQk4yAstfny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mjG3zM+d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UKq5zGwe; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mjG3zM+d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UKq5zGwe"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 53FBD1140203;
	Tue, 11 Jun 2024 08:09:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 08:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107795; x=1718194195; bh=gTS+xNkViA
	/EFbJGHstkfc88Dhq4nvXozDivwTr/CSQ=; b=mjG3zM+d5aXph6/iBpU8w/Okak
	poGyr5oFaw/8W3dZMG38n6SDacaURcIAlQmK94lYtOR0eceJjRWpNGSJ0sUB+OWp
	X5/XCEmL6DUzntymbarWujGgdq/AdYkbIFPKeF79zf86kiIyZ9ZmmNcHDcPZArVN
	wutt8arVMPeSnxEcMCEbhGBhjAKflGJ6b2E7hBuE3fd1dsgs3L0Qy0XoueuP2Puv
	pGnFKDRrJmwIU7HKybxR5WtJmU7ersdHhotWIi0zPXz2e78NAyfPsmAfBMLrtEec
	6rE0+uhBrgxiDlDBxZzV4w7QflsPpTNzbiGy8fVGfg3X/Cm1sapupiITAhXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107795; x=1718194195; bh=gTS+xNkViA/EFbJGHstkfc88Dhq4
	nvXozDivwTr/CSQ=; b=UKq5zGweOTWNRqFLrd2GVy6h+5nrMD2xqvW9x48jcUN9
	pvMdYWlG7NX2iad1LU9L+5u2yOWx1xLoEGsSNqHAVDWjiYrgY4tO5ox/GSoFN9sj
	GvXQU0mhKBGPQ0iQD5HP7vL8zJAwOLeQANAwL0W7jFI7t8qGK/7ZTMi6lyGvZ2h5
	LfV6ZohCGvz1tdw1oKdllkoumPLRtZH4DGJH4LeohVihFYIN0lEatfl+I1iB8vpz
	y4hxA6OkMqPzo/6IS/sssQ50bhRuiVZoHJXXESXjDjpB/1F0P/afbCl3UgT7xpTU
	Jn9T0rCkzmYK2br3/mYnI9TsDVZzJ1t/arUr03LT3A==
X-ME-Sender: <xms:kz5oZicQ7HHT73nHzvTV4XJGOQPjvEjhETakI9U6hz7KQ2Lu1s0e9g>
    <xme:kz5oZsMG8JVzAVBr8gDQtcDY3tlqwTDV-XR8YpmDthcSPGJsWOuB_onvCfTWlkKWl
    kAYleut74iaJk1iaw>
X-ME-Received: <xmr:kz5oZjhraspIVIYWE3ijCUEAdP4l3CjxkZLAPevEIvavWI_fXpPsRhm6yzzlkZIYZMlKC7Mg1vyf50WNlE_Ey8yE3l9cFOvHQqTWrlT4ah7v96jNsa-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeiveektdfggfeluefgvdelvdeftdfhge
    eugeefveejleeufeekgeefffehgfelgfenucffohhmrghinhepkhgvrhhnvghlrdhorhhg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kz5oZv9iJ3iFZpRU6ucFTGXeEdXKGSFC3TCaHbX-x-eNPKnUrtDBGA>
    <xmx:kz5oZusEDi1eM0SOBBV0SD5odlDnpHyLA7bCrN6gVGC7CcogVKf3JA>
    <xmx:kz5oZmHW7ZoSYVmYbA0uaAhZsu_Ev9TN2G1FXd3dzB06DmVidP1jSQ>
    <xmx:kz5oZtP-6Nd954C9KLSYSZuOFFeGs5M2lDdFF9XH0RpsEpXExU28qA>
    <xmx:kz5oZiJHfNGhYLWK7JKsMFb36M_MXy-E8TFg2fkC6q3rl4PDT-k-j575>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 08:09:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 75f161de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 12:09:44 +0000 (UTC)
Date: Tue, 11 Jun 2024 14:09:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] DONTAPPLY: -Og fallout workaround
Message-ID: <Zmg-jl83UA0P2Dnk@tanuki>
References: <cover.1717655210.git.ps@pks.im>
 <cover.1718001244.git.ps@pks.im>
 <03270d3414117ae7229d87127cff81e349557039.1718001244.git.ps@pks.im>
 <xmqqed946auc.fsf@gitster.g>
 <xmqqjziw3arr.fsf@gitster.g>
 <xmqqsexk1s43.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RP8Zx8Ye3Zj6e3ue"
Content-Disposition: inline
In-Reply-To: <xmqqsexk1s43.fsf@gitster.g>


--RP8Zx8Ye3Zj6e3ue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 01:05:00PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > These "workarounds" are to mark variables that are used after
> > initialized, but some compilers with lower optimization levels
> > cannot see and report "used uninitialized".
> >
> > This set targets "gcc-12 -Og".  For the reason why this is a wrong
> > thing to do for longer-term code health, see
> >
> >   https://lore.kernel.org/git/xmqqed946auc.fsf@gitster.g/
> >
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >
> >  * Even though I said I won't do the actual patch, since I had to
> >    gauge the extent of damage, I ended up doing so anyways.
> >
> >    As I explained already, the size of this patch, i.e. number of
> >    places that need the workaround, does not really matter.  What
> >    is horrible is how each of these workaround will hide real bugs
> >    we may introduce in the future from the compilers.
> >
> >  builtin/branch.c          | 2 +-
> >  builtin/fast-import.c     | 4 ++--
> >  builtin/repack.c          | 2 +-
> >  fetch-pack.c              | 2 +-
> >  http-backend.c            | 2 +-
> >  http.c                    | 2 +-
> >  pack-mtimes.c             | 2 +-
> >  pack-revindex.c           | 2 +-
> >  refs/packed-backend.c     | 2 +-
> >  reftable/stack.c          | 2 +-
> >  remote-curl.c             | 4 ++--
> >  t/helper/test-ref-store.c | 2 +-
> >  trailer.c                 | 4 ++--
> >  13 files changed, 16 insertions(+), 16 deletions(-)
>=20
> And depending on the version of compilers, apparently even this is
> not enough.  I do not offhand know what GitHub CI is running for
> linux-gcc-default (ubuntu-latest), but this gets flagged for using
> (try to guess which one without looking at the answer below) ...
>=20
>         static int parse_count(const char *arg)
>         {
>                 int count;
>=20
>                 if (strtol_i(arg, 10, &count) < 0)
>                         die("'%s': not an integer", arg);
>                 return count;
>         }
>=20
> ... count uninitilaized, since the compiler does not realize that
> strtol_i() always touches "count" unless the function returns
> negative, and die() never returns.  Exactly the same pattern
> continues.
>=20
> So, unless we disable -Werror, let's not continue this experiment
> with -Og or -Os as the damage seems to be far greater than the
> benefit (which I haven't seen any, but that is largely due to
> timezone differences---I asked "what's the real bug you found with
> this" a few hours ago that is past EOB in Europe).

The real bug that "-Og" would have been able to detect was reported by
Peff via [1]. In this case it wasn't "-Og" that detected it, but
Coverity did. But it would have been detected if we had a job that
compiled with "-Og".

But now that I see the full picture of this with different compiler
options I have to agree that this is not really worth it. Especially not
given that Coverity is able to detect such cases, even though that only
happens retroactively after a topic has landed.

Let's drop this experiment.

Patrick

[1]: 20240605100728.GA3440281@coredump.intra.peff.net

--RP8Zx8Ye3Zj6e3ue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoPo4ACgkQVbJhu7ck
PpRVKBAAg93lsOoifJVkqGhKaeDvPlhThirVqqSrkIFEA3BpFev/p67Bu2C8rhsl
ro1Pykx15iB6bC+AWKjS9M2SHd0jjg79DSoMfUAO4UvB7+lIxF92ZOUmEjb4yRi9
wOOcYK9ClzN2arKZi62sopEFZFNx5p1TdJricHBzLotrc/9i/VxdJh0ZsOt0aNt8
FHWhA5o2u6Tcq/QnsP3Fi04QH5GrYm3TSOgA3JQX/VK+uclomOkA2blxXc3+TpGx
lcY3uHBUJmAjjLmixW/xadlc7F9KKH4pDc6qF4Df39vfK2eznkaueJ3BD5p+CIbQ
30F6aZ2oMXcrvWSiitzRLlp2+AbDzE28lVw73MaLJK2QiUOiQ8+aBN59lfse8L1O
MM+nFwWB9vDqEAMdMPlu2zeY61gAiGhkJGqb5yW5j1RTVlSCDl0Tf4ChQh0KAOf9
9c+x+9n4uwAOzPH+v1Qz/9j1Ia/+QmnriO+hs1LKtv1Mtg9HUcy7jBjUVIeVu/9m
2ZEOu4abNho+4VwG74KCJY+RaSFSJFDpHsrNvOF1CdGc3oVdsQlr95FNCa26IINK
kUMOqn9D9Kj3XTFxe8LCABFdkyHV7V+buwhEsExfeP6j2hIza8A6ZTE6sTi+vLo7
J+AHBO5y9yvT2ThYT+SIU32wIZU6cxPgacuaCaY5s3jGVyMNiLQ=
=m6ee
-----END PGP SIGNATURE-----

--RP8Zx8Ye3Zj6e3ue--
