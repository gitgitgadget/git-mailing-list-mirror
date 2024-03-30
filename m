Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4562EBE49
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 09:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789609; cv=none; b=Ul3Z9mcwPCZDTDmueL+Ipdl7GB8bE987OyAR0xdtbUG4Xvc9zDiv0Vuwixa/gDtqXa2y8u7lDlaYAWEZSTIvWKQ+1W7KeSK0uAghLxQRowu/XiSHfUs6rTnppEgTLUBGHyfW1STriMGUipJWaGqznkwdE1RIHOIUCKAQk9TX8GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789609; c=relaxed/simple;
	bh=eut8KdExhulMp6KO7SD7NAVA8jpeR7vJMv1qWWTj6t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X5y5EzyLx5hzOYkCIvtGgWVeN7TTf2sjO3gQSIPg93AaYJmv8dAq+bZXCoQZQZps4gEo7+zrRUGR0iH3cxnXPDtDk8f91JZuBnLN5GDxBys2ys3zeeBMmzWijFYT7Fbg85/cs786+3TY+mW3u/grenOWuikPRh9K+AoPtaSRSCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YZRmuepi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WeLr1eii; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YZRmuepi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WeLr1eii"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3886A114009A;
	Sat, 30 Mar 2024 05:06:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sat, 30 Mar 2024 05:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711789605; x=1711876005; bh=eut8KdExhu
	lMp6KO7SD7NAVA8jpeR7vJMv1qWWTj6t0=; b=YZRmuepikEwgu9g8WewcFDzcGz
	zydpeevwKme5P2X+MwgoI3WJUn1EplxG+0X/X2WA7BreBIAXIFk8285dQgC0NHhN
	0iIdW9ZOSOEBYY1OaICk2kPwRnAqkGnyNbkXNMGt/rUoNk5Z7s8kj3esAtnsy4WR
	T30IYpatjw5RtBqDcq5CTr9kgRpgGLBLdNV5xR7SUGnzpfrB101xyyM6pDlMZvWg
	nTJ10IkEKS2lvyYQHmIyAq6CtOGfR6CiDzWV6pWW3aq2p7BTerb0HO3XxYrX4Tax
	p0omNj9wRH6ZyFhHHn1pqYnEC4sEHxcFJvXGJcBDSDpC54VBkbOFl6KRl0hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711789605; x=1711876005; bh=eut8KdExhulMp6KO7SD7NAVA8jpe
	R7vJMv1qWWTj6t0=; b=WeLr1eii6pR5a0VDdmn5xhYoiS8ZlDGPYBS5JrrG5+OP
	k+20Q/T2V0aYI1z7EM2AU8/rWqE1vkb1KilSc9gX5P+onfXw6OnNGKHNQ1CcnFbA
	TvPHth597mDl1hX3O6gKkLvdnbz+chWAHuicBqYEXTe/tQ8rrya7EkcV5vYy293b
	Nn1k2D9scqXMnXo+6H+imzUyVUdPOkmmB6Y1iXy15qmqtGoo88X64HOGyd8oEmCy
	e4ww5rScNavVgWC17q2f2Nf/CpHzKvWwjj5oq97HufKyMOV3tqa8MFZ/mNi7Tgtm
	t5JZamJWCeyviJqp/15dLmut4wJTlg9JaNXOWEi6Bg==
X-ME-Sender: <xms:JNYHZh4xfCxREyb4LaQbNnptS2e0gSrBMxxAhfXB6gZ4Z2F5CcOmGw>
    <xme:JNYHZu75nxie6hCX07-DsR8unJagj67MYsAHNnEXQ3ERzlAomUBR10z_FxKLq01Nx
    S6NZwC02oV2V-kqqA>
X-ME-Received: <xmr:JNYHZoeWcfksKHpmoiWHdCe14YHAo4chpiuc0JhOuDMOroihL2bBWHrTyYyX7F5AIsRAyA3EMxObcnaXGKAgc8UqqCrWoZ9M908KmgPqCvo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ehleetudefieeuhffhieejudfhleekkedtgffgleeuiedugeduveelvefhgeetteenucff
    ohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JNYHZqLN8V25ql9P4aOPjy6Ff7A06OPquT1RDC4rngISFpKqF61okw>
    <xmx:JNYHZlLeT4iuTxQwXvPxR_PzbgSsp68K1Z7BgP8oeTnLcUAsgOXl2Q>
    <xmx:JNYHZjzxPVz8xTX9e4fgTxu7QZG8LxMNXhX0ZqhQ-PndKF3YO7WiBA>
    <xmx:JNYHZhIwCcsHLjBr6OMGocmIl-hni9mO_cNmww1zzOM9xkd1I4iQYQ>
    <xmx:JdYHZs8u30Xfr2AgHoEDVHxPGNnxGuBYCrgod5Sz-SNtS1XPxa6iww>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 05:06:43 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 498c544c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 30 Mar 2024 09:06:39 +0000 (UTC)
Date: Sat, 30 Mar 2024 10:06:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZgfWH_smdZ1jXkLO@ncase>
References: <Zad1S3vCuv4KYIzx@tanuki>
 <ZfwY_h70OeuRT7mk@tanuki>
 <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
 <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki>
 <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
 <ZgfK3DoeidDcIaFj@framework>
 <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2srpJrlisc1VslhJ"
Content-Disposition: inline
In-Reply-To: <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl>


--2srpJrlisc1VslhJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 09:20:22AM +0100, Olliver Schinagl wrote:
> On 30-03-2024 09:18, Patrick Steinhardt wrote:
> > On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
> > > On 22-03-2024 14:04, Patrick Steinhardt wrote:
> > > > On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrote:
> > > > > (Sorry for initially sending this privately to Patrick.)
> > > > >=20
> > > > > On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt <ps@p=
ks.im> wrote:
> > > > [snip]
> > > > > > I'd personally rather go with the latter, mostly because it mat=
ches our
> > > > > > git-scm.com domain. I also like it better than the current git-=
vcs/git
> > > > > > because of that.
> > > > > >=20
> > > > > > So Chris, would you mind adding me (@pks-t, my non-GitLab handl=
e) as an
> > > > > > additional owner of that group?
> > >=20
> > > I'll empty out my gitscm group, make it private so that it won't be
> > > accidentally used and transfer ownership to pks-t. You can then 'do w=
hat is
> > > needed' with the group. Since gitlab doesn't support aliases (yet? :p=
) best
> > > to park the namespace.
> > >=20
> > > Olliver
> >=20
> > By the way, thanks a ton for being this open and helpful during the
> > whole process. This is greatly appreciated!
>=20
> Hey, no problem. I initiated this discussion because I wanted to get to t=
his
> solution. Just because my mirror is not used doesn't mean I don't agree :)
>=20
> Btw, I can't transfer the group, it's empty, but if I delete it _right no=
w_,
> you'll have to re-create it, _right_now_ (well within the next 5 minutes?=
).

Shouldn't it be possible to add me as a secondary owner of the group in
[1]? From thereon I could "transfer" the group by removing you from it.

Patrick

[1]: https://gitlab.com/groups/gitscm/-/group_members

--2srpJrlisc1VslhJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYH1hoACgkQVbJhu7ck
PpQC/hAAhy1HvCOBv5DR48fAwPntvmlxtdrtGA04s3UdKJarV6/S0/KW4dDERdgQ
ipnRLsUdK2gkhQo7VqOPir3GJ7BI6wOnY8pS9R1bjOAZXrHXx06Ae975M+9RYlu+
ygdZGt3wvZqJMdsD9KpYxwG1N+taziweZ1q+6IxXdWHXugARGLBzWoEJLpWwJyCa
oYHvNzdbNtOrTH1agJesyr5cPyD2RCLvWs0X7S/TJI7XhY2RYXsfXdK352i2zWJe
MK6Zs9XCiB0b25WEm1yqc5V7sGdo5Q7qORXIf1GQlFynvXYoj2I55fXRy+hCX5w4
9jfmfjxy5OoRfdy2hkbQzv+tFFqYtYUm64fvAVBMXHSlA2qCqk8d0kTKJXeKprTD
3321QBcBSPLzrUN+jTJ5zB89N3Fe9irLv1KgSTONWnl7ahhHNXhD1eUeb6wPRFDz
qSbH0TxRnrBRP+diTSqKsbUK3dSFYUIZ6jF/ii3N2id/A95kpwLCglyzMdBokvXL
hClfEKmkGiDEFKg6mVPhFqYnn2R5SxRn2/s/uzpNM5o/FQZ5aJN4GAUtZa/dDVsV
B/KQHE6IQsG4lohERPE015vitK7GVqa+0BfrgrIerqjNxw4HK5oqF35VQmYOkJwV
qOwRmGUFApoLf43lLgIo3aD3shyvmNueS3lNjGazF9ZDTQMYmY0=
=uuUP
-----END PGP SIGNATURE-----

--2srpJrlisc1VslhJ--
