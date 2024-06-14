Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6FF42064
	for <git@vger.kernel.org>; Fri, 14 Jun 2024 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718344368; cv=none; b=mwiWrwwCjJuiA3CLbOzkRJDJyFk3UVPACeg46FkFC9OLYtBGGiokE3j4WaTiPo3fG4orxvOhPPiha8DMMwrp+sBwT4eXA0TSO4VR/jjk+lyMKj9NIA7ZvzT4SxWEnAPkrSq4fEDE0shN6xwGQEieAOB9OGeew+CkQXbpNK8pJwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718344368; c=relaxed/simple;
	bh=mVK8J5ObI4GKtNLF2lDhI+nzDd3CcJirNwaV3uP1nII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJUFCUmjHC5kloV8Pwu8hsZA59+/rLa8vzKxlxyEGzRwMM7Go+OBxwM95OT2n6crI+dLDi4fP6m+weZkcm86NskhDLKUwd9ltrREW+PMCOIqj423Xg7VaJukqzHo9QO57vgvbNDDAKRNJkb9EJgnbtlCsy0XYkV96Wab0gTPW3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H8MGSF2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LHQMfOrZ; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H8MGSF2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LHQMfOrZ"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id E349018000E2;
	Fri, 14 Jun 2024 01:52:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 14 Jun 2024 01:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718344365; x=1718430765; bh=UM+rPLjIlz
	flSiz8W5B6+eB1D8pUPulQxdbj55tFAuY=; b=H8MGSF2XuDBLJXfYhcSJLxGbjE
	I5lW4VmTuTMF3U3dUPQsxNn08ffDbwUMVZawmYgH42ncur553A/KU4/Dj5SGswZ3
	T/w+ajXfknG2R0rsmJKASFeuszc6Z0ZRUcFyzU7KJDjsHolKrJpjWfJyD/Z4yKe1
	5+ICjyxXA35kt/poMDz6SjwqTcAtkwY5YnMBxDcuRV9Q/GIvg9ZKGzOS/mjBrFzS
	nouKrHp5f2fYpbf6+3PnZzx7dWwZpKSvpq8vRRHKAGENAFrbyio/HeNtDv23XADS
	tS/s2xlpA4i66H7u4u+iLWCV4z4WQLK3PXibXD7NcGNxz02+7zzyDL16CUjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718344365; x=1718430765; bh=UM+rPLjIlzflSiz8W5B6+eB1D8pU
	PulQxdbj55tFAuY=; b=LHQMfOrZxPQ7bhKsJd+sLEkzY2GuloujcUEPfeUgtyn4
	WpxctKEf/mggRYuMVm8dEIypB/BwzDONWRAC4MBwjy2WzLkUDz6wCTEVuSQ942W0
	7n6EMyyFV6ZIMsqZbhmM3p9lQcybol1cuqOBrNyyEnFaV7aqsp5fr8bRwMFJk9FV
	T57LN22pDKyD4HOoftyYf7ZPsv7HfY+rbnlzNglrMWrraLQlUCB6B4W8elZUiBTt
	KrSsuT3gxNNlC1dvuJZ2dWGtcckI4lzpjEcFmbOJmR0a37IotfnEadsIpKc9METH
	/D10nWKyNZh3Ba+OX533Ld6wG4ri63ha8VQclt2brA==
X-ME-Sender: <xms:rdprZjlccsysQyiTgvdClHjnuiM3esJpZdXJIteBvHFOQjNKFiD5Fg>
    <xme:rdprZm2WDoYeyRqSDzBEoxePI-Jr2-K3oG9kODdcPAKBps4ZwO7pFcJdTAZdLFEVb
    sgJI6LoOx_nNTXrCw>
X-ME-Received: <xmr:rdprZppSOFmCt4amKvLlQKUxD3vV1ULn0cG01eZ_vLnrc6W3nXNeVxUfW_W6XbMX3VdNRKnA_FZ9EemEgitfdQ11LPYy8QIpNpwER9GjfaUweg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedukedgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeikeejkeevfeevfeegueffheejgeefhe
    etgfevheejueetffeuleelfedtgfejteenucffohhmrghinhepphhkshdrihhmpdhkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:rdprZrnzDI4z2tEQ8N10q5FDohuCEl5N0GmJhKmVYCiJ9L3M0-46Zw>
    <xmx:rdprZh3AS3c1_oVl-lJ7Wnq0Y5jG8L4bDtFiPyaYhR1Be0CMPAP5EA>
    <xmx:rdprZqt2fZs7jfTevbjEOpHdYQSMOBgyq0iulJuA7mTXguA7LOZ1gA>
    <xmx:rdprZlW6Sg_z4Cct1N32ToPqjdCb3pE2yhTp3aCiKyNsWUtW400dmw>
    <xmx:rdprZvDTEfED8X688Up6dKrgCT4OyitxwwCgAuVUiZM8o-WIbubmY9Kb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jun 2024 01:52:44 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1de21646 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 14 Jun 2024 05:52:28 +0000 (UTC)
Date: Fri, 14 Jun 2024 07:52:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #04; Wed, 12)
Message-ID: <ZmvaqZpEZ-TfwDq6@tanuki>
References: <xmqqcyolofar.fsf@gitster.g>
 <ZmqJDVTAiBrYJGRW@tanuki>
 <xmqq7cesoojc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="72CDCHH7rB4e+yvE"
Content-Disposition: inline
In-Reply-To: <xmqq7cesoojc.fsf@gitster.g>


--72CDCHH7rB4e+yvE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 08:22:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Wed, Jun 12, 2024 at 05:30:04PM -0700, Junio C Hamano wrote:
> >> * ps/document-breaking-changes (2024-06-04) 4 commits
> >>  - BreakingChanges: document that we do not plan to deprecate git-chec=
kout
> >>  - BreakingChanges: document removal of grafting
> >>  - BreakingChanges: document upcoming change from "sha1" to "sha256"
> >>  - docs: introduce document to announce breaking changes
> >>=20
> >>  The structure of the document that records longer-term project
> >>  decisions to deprecate/remove/update various behaviour has been
> >>  outlined.
> >>=20
> >>  Getting there.
> >>  source: <cover.1717504292.git.ps@pks.im>
> >
> > Just to make sure I understand the status: do you expect me to do
> > anything in this context? The latest version did have some final
> > discussion, but from my point of view there wasn't anything actionable.
>=20
> Yeah, the only thing from the discussion that may be missing is this
> one on [1/4]:
>=20
>  - https://lore.kernel.org/git/ZmE8myG5c99UJeCA@tanuki/
>=20
> But otherwise, the typofix for [3/4] in the thread has already been
> amended in when the topic was queued, so we are almost there.
>=20
> I do not know if we want to explain the version number scheme there
> (in your first response [*], you said you didn't want to give the
> impression that the jump from 1.5.x to 1.6.0 was a huge deal,
> implying a move from 2.45.x to 2.46.0 can be equally huge, but in a
> later response [*], you seem to have liked the explanation to clear
> potential confusion.  If that is your final position, then [1/4]
> needs updating (with a reroll or just saying "yeah, squash that
> update in").  If that is not, we can go with what we have, but I
> haven't heard an explicit "even though I said it is a good addition,
> explanation of the historical version scheme is a bit out of place,
> so let's scratch it", either.  I have no strong preference myself,
> but merging it to 'next' will close the door for you to say "ah, I
> forgot about 1/4" later, so that was primarily what I was waiting
> for.

Oh, right, thanks for the reminder. I definitely think explaining the
version schema is helpful in this context, so let me add it in and send
another version of this patch series.

Thanks!

Patrick

--72CDCHH7rB4e+yvE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZr2qgACgkQVbJhu7ck
PpRf8A/8CLZw/GNWHdiSMdlf7D8GCtZH+DHHZ7lm6I2IIr3gLAqnTkep52vJl36b
f4m/qqHWlJzwEQwwQaMEzyo0cy2SK3N3Z/jrHvBeJC8dDCAs2H2G3wUNjWYEHViT
hHoyqMlmEZRoCmzUoN39FxmgEmrnh4ivHB5yth9xl5Bzt0kIVU6NU18+16eBB4tX
JwNnV/qZN9VOVAAQAwqs+KLsPp8HeYz0y04IB++TRAruVodk7qWSCPBOL14X0yu0
8gifga0yhkC8/ssoh2HsOV01nIFYJc1Od1tEbPI9uRq0LRcrQnEJBWRp8kgHxHpY
HTctS1gX+arTyzHZa1tXFr3K4Ttu9+7A3ny4ejfHgNOz0uwdItDakcmVIwHLJvQ0
XCj2kw0TMCFB6meTmBJIDr2+yLsBsPr9KSU8Tbjz0DIPN0B503C0cjimGY9/sCeJ
Sl+wU7HgfeZ8uts0PsnAs+vapNUmZLL6x26Oa8/JoubpXLjhkJaiuQt/3Dfa6iEd
rlQANDo85iiE1LeCK2q4EL1yKt0euC3rXUkj0m+Gcp7UoAxcVxNoE2Z7d2TNNbTl
ER1Maxr+PkGODK031lnQhfPlzERjPKUeqfvt2Dx4G2jTrrQmZOjIpzK35lgoFJ/6
Tp5bnR+eOZUrAxDkGPz6x4Alqq4mtVFSwNv44R7K8p50ApQwSw4=
=S6R7
-----END PGP SIGNATURE-----

--72CDCHH7rB4e+yvE--
