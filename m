Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046E24A0E
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 07:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004573; cv=none; b=Cvy4jKLaeOlAE5m+oVRkaD8qrWzEyt4ukpAj3eTkptIjtVTrCWvQc1j79HZM7pvFAMOkBuKddL3HGiQB9WOFmlHHrDpDO8u3PEugYiZnyN54AqJjYh/0OycYbO/0GafXilAcLytztQoxtHTg4bHWvC4ET1FGCCRVBcfDZHR73Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004573; c=relaxed/simple;
	bh=Y/JO0zt+KAtF/g3gVIKedqlZxF2EY+NpngMnBea2CL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6Pu3ZcLGfbYGpddHI0vveLwCI/8EMu1daP2GV03Ig37u5X8Np4MMPW32xex3hlhBxC1zfb/bQYRYLOn6vl6KvHRCeYlCT5OPCAD9bMHgK7gmJ/jMFoJvky/tLmUIH5bCPP/Vnch8oM7ZfYAmrlYwRKrsLdxv+U2ZZN4d+x1fbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lwmnYXYP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bLk9PBfO; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lwmnYXYP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bLk9PBfO"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 196141800114;
	Mon, 10 Jun 2024 03:29:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 10 Jun 2024 03:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718004570; x=1718090970; bh=qhPzkEgI6O
	DgKcAAIKXNuQbsBWW71IT0gFsrbhAL6h8=; b=lwmnYXYP3jy29eyiJa250jUwFJ
	9ANHTp88IFb98g79jEeRw8FYtKXplya8+rI+S2SuXnQe4dEYEJ32oM9XzLzT1NXq
	Y38rz8NpKNhJJYjphotdYi6BbqwFcGKNb3HNo3R+xa0UMpM6uziR8VBax0/VAiRW
	JChZ/TBlIQaag7hTJr7buGqiIOaOLeRtsmOkx8tg38IGskKn7UN3gPPFea+xA6po
	GbqDMSejiavtYVyrF6gF3vyvNdQHd+mIYEjJVd9WnSi4xHL/k+z36N1s9LehttsW
	ILxpws+7pzDcWj3dkyiSGJ5PDXcsr3cUAAiJ72bIRMseztB1U3ILbYHn9OCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718004570; x=1718090970; bh=qhPzkEgI6ODgKcAAIKXNuQbsBWW7
	1IT0gFsrbhAL6h8=; b=bLk9PBfOrkxyitPF2IZKubMzEUvslep8RHahgqNzLq1b
	2q+GD9vd/Oqw16xz168PojsEytDtp4QFz5yRPrc8EBDNPT4psrz+bQpi6e0+Chf4
	7prJXc+pOGcoF2UHr8qR/SYGgCeYrPe4zYJ1LrgqB2l99cKo+KVkH5FZ8H87Tre+
	5Y2C1KkD7shG0JB8agyBHMSE4gH8PPTuMDy5qYobZwyZ2C+YaVe8/4pU+MI8ji6p
	4upOymCURwTzrxrxMvaouLfFe+JdMnaPej84hrLO5d4p+IS6N+eiezSM7xuIJXH2
	MzUmQqdYUhxDo4LBw13GFsP+FMqJxtdhv/yiT9J1Tw==
X-ME-Sender: <xms:WqtmZkDLp_jWRHj-njD-7eJVVKgyijTmFbK-W9_spJbAENTXDOReOA>
    <xme:WqtmZmgmA8ec9w9PwGKNLaahijHZvBAo92qDaNoYyodJEOFW0N_-iGCi0TnXUntRt
    rM0_Kk09OUQHzTWHA>
X-ME-Received: <xmr:WqtmZnkiGSDeQIALCXlfD3IK4uo6Ibdwe3xxtucYWl2tDuhJFYS7N5ZKn5cZfkhiFvWOsh5q1cugZWGJfrJ9E4oZT7iToSc-sQcN5r6sVSS4utSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtledgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:WqtmZqzPGzqwPs7R1GMHT4bUCjyhm25GTQOGfpzXmVBOFq8XC39drg>
    <xmx:WqtmZpS4P5FYLwZHy1wa02p-8GSfThVPlz9uTWWAXYM1y1JPlIK-fg>
    <xmx:WqtmZlYrTRk9u6m8iy3CzN3wRLEiiHBXUnr4Kbl2rxdbtA_KcEjOIA>
    <xmx:WqtmZiRJsBQ3x-koT0kKmAXsEPVK0Mah3ZPuKiHMXRApJS7PDtcZqA>
    <xmx:WqtmZkGbKY9OGvOUKqzPBzvrmm5ytVaDyE9DloNGWI01F500q7Z4vZLc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Jun 2024 03:29:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4925067e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Jun 2024 07:29:20 +0000 (UTC)
Date: Mon, 10 Jun 2024 09:29:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: John Cai via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Jeff King <peff@peff.net>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
	John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/4] refs: add referent parameter to
 refs_resolve_ref_unsafe
Message-ID: <ZmarVcF5JjsZx0dl@tanuki>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
 <011c10f488610b0a795a843bff66723477783761.1717694801.git.gitgitgadget@gmail.com>
 <xmqq34pqlyou.fsf@gitster.g>
 <xmqqv82mkk15.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eSA88yJOtx+z6YrE"
Content-Disposition: inline
In-Reply-To: <xmqqv82mkk15.fsf@gitster.g>


--eSA88yJOtx+z6YrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 06, 2024 at 11:23:18AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >>  29 files changed, 64 insertions(+), 52 deletions(-)
> >
> > Wow, the blast radius of this thing is rather big.  Among these
> > existing callers of refs_resolve_ref_unsafe(), how many of them
> > will benefit from being able to pass a non NULL parameter at the end
> > of the series, and more importantly, in the future to take advantage
> > of the new feature possibly with a separate series?
> > ...
> > That way, you do not have to touch those existing callers that will
> > never benefit from the new capability in the future.  You won't risk
> > conflicting with in flight topics semantically, either.
>=20
> The same comment applies to [3/4], but I do not want to fix the Cc: header
> again, so I am replying to this message.

I wonder whether we can future-proof the code a bit more by introducing
a struct that contains everything we want to pass to the callback
function. That wouldn't fix the blast radius of this patch, but would
mean that we can easily add additional fielids to that struct in the
future without having to adapt any callers at all anymore.

Something like:

    struct ref_data {
        const char *refname;
        const struct object_id *oid;
        const char *referent;
        int flags;
    };

This would also allow us to get rid of this awful `peel_iterated_oid()`
function that relies on global state in many places, as we can put the
peeled OID into that structure, as well.

Patrick

--eSA88yJOtx+z6YrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZmq1QACgkQVbJhu7ck
PpSShg//cxPwYUtN25Q5w+vJ5GWJN6I5C4B0YYiDx2h8BuyUP9gU7ZG5dh4kdVyH
1WwnWP7t7YQsPtJvrpVu8aINCLphvV9897lHPgjQx1d/EM3zagGiF0D7oUVxgyDY
e7RNBeUJIHzt7HhHyYuUzpBA4a2OmCJG4/TvkA3FBWmieMDKMnXPkIcRv34YRP3L
PvdvrYPEpBkCTLEapZXaYdMC+ryrVc6ZgNPx1VfV4MCGL0LFzk1pDcGhhssm6pVB
566qI9cTVhggAK9+zvjHxvHwWZVuO7S/WUIIrS+c5wQ/XkNnNENsYDGlIobjTMSH
BUWf70pMeHEVj/m9Il79Cw29W8cwR4HLNZ2isVPQ5i75oik1jJaKUf3fEQMaz6yF
gel9XRxWx6W9Hx0cHJL6k1Prz5qOsdcIZH9z+oJyqDdTeuUhI1EFRwQHK4ZGkqaH
vLVL6KJTVB3PKewYyluSZ8ADOMt65xvZO220ncJC5uRL999DNrdAWsIoIImGJ0uj
3u/qOaBgve7umZDjATGlpw++cE+32jjTMmIjMXHZw+F6YQ2k+hnesfDx7xDMyfB2
6g6m0z9JhSkC2Ocv/RXwoJjYsXyA8+JUBqXm+/+0aKW3zS9umkciQX8K87kc6n7n
0tGerJEKsUzD5zSmJuWLR7eTVeFTlz3RBvAdpSjtsyUeTx3HCY4=
=tk+f
-----END PGP SIGNATURE-----

--eSA88yJOtx+z6YrE--
