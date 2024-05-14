Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFAE12E4A
	for <git@vger.kernel.org>; Tue, 14 May 2024 06:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715669455; cv=none; b=nsH6MQ2l8yLVXjaD+yGOQgNW2gHFJ6FWtMP6BezMsUDDiyfB1yNIfT9I2B2C5etUoKKQlETivqUsydQOfDXa+U7ByEipTO7jS4oHq7rNiTnWGykpg9MNmbm/BBrYwufhUBvuaBd6eKdZmIzeRJakR6vS1Oly1I2IoOs+hTOZ4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715669455; c=relaxed/simple;
	bh=fxkbu5EYuDcoKOcwhWZWTJOZzvHL949Uv0XaHSp/IEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8hkQbPh/PXRlcYFnZRmplnwjYSG+de4pChG6UOrfEeYQHk2pJxeWgmTlSuJ7k0/5VaZfcgWqLUUq7LK2BJ7TeQ10ufEeoDp5yZd/c7ZUGgO4IfDxaNHszCrKsWhD4RZD6xYJgW+oG4sk9v4tDjErQfit+Z7HTvqqmDPeT5+3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UyyxUdC3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlzZGQUf; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UyyxUdC3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlzZGQUf"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 54F071381493;
	Tue, 14 May 2024 02:50:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 14 May 2024 02:50:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715669452; x=1715755852; bh=uU0srnd2lF
	CIwaz6vdtE/g0wkG42Ojo7mOticFdlE/8=; b=UyyxUdC3jlho+X8k52DzqVJNcY
	z0c4xDn6DKCuBjAc5eSyoCCQ8mm+J+j6Ya68XgRRMYCAMGrbMXrAXF0ZS5WfH6Bo
	oFjO4CUKKoyAsn6PtH7OKgVj/OVGvzq7ANMfvizZoG8IDVDTUw9ehMyWRU06ptVz
	e3KjVZwoozUGYNtFzpEE0TzzBIbs2lBwMIZMpwGQWdrqRLiKicNvvvXSue59NgD9
	Cu12c/mG8UZZwu9yiwDbLa12aWhfADI4wo7/o9w1C+Tqdm2SvqP3wLptuXUUadR9
	pBnYRvkiP3WucABKFYTw2+TWqrD2Vi/NjM2+7qcfSM3+w3qY8n37A+s1A/uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715669452; x=1715755852; bh=uU0srnd2lFCIwaz6vdtE/g0wkG42
	Ojo7mOticFdlE/8=; b=YlzZGQUfVq4OibAfBTcyYdlrG0goLoEN/dnLADbquDhS
	GREgUvhRyHNwfW5gzch4pN2B52x9goGuxWlNHAYISgfrNpIbN0MLRK+ibYXZKU0s
	8gFIHaBLxHoKW2zLE1/ubtdNzh8qXurcyENeWVOQHaIEAxNmqs7u5YHPuTusX+zK
	SFP4VoG2wzUNARMyIx0JFx5Bcp9Wb7fFZo3zTCN/tsekkTaXOYFf0NkILRidEyNS
	feeQDkD810Mq85J/UYsMfgM0oeVpjgauaCjFybxwqCgZMPc1ScNMjYaeU8qQd66W
	n/PkHaUyu1ysNfuIDU832AJJctxf71DE/1EUdeDj0g==
X-ME-Sender: <xms:zAlDZkI6If_is29DUkwU8IBrXq7ktdijpJPLx8zqiSAotr-YxriFXw>
    <xme:zAlDZkI2S7Ra97Ky592WS5xwOHGv7d3hCcgmykviWiZO86t9644Vf3zCzwPr7fiFV
    OMSZLq2Dbs1MjESvA>
X-ME-Received: <xmr:zAlDZku-_Y5qdCB_kN3nkLaVA54GQrO8f4sO6Lq_RGwhLVrq5qW3T3JKszXYkU7pMmuhO3SeH6ybsM0Doe3IWSGTEY-jyyi3ZCo9CSdiOTsgH3xat7lc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeghedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:zAlDZhbUCJfwZrcupxhCf-uVtnLIDK75g-qnyLh6g0fHJVvSCe5j3w>
    <xmx:zAlDZrbV2RHNObD223fo8EqVxsb52I9K3BKuFteA3ryCVkhVZlSH6w>
    <xmx:zAlDZtAecKglcJPJsiXy9lxOMDq1BfFHPtGtx4u_vJBmMP89UgLC6A>
    <xmx:zAlDZhaQya1wtnKpKum_Ib701tcmLIoA7lDqCFLYFVQQMPN788oLFA>
    <xmx:zAlDZnGOT-PxbeSARUvUoQ8IMAb2nao_B2Y5dCJIoOZzIsqdlzi0nEtc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 May 2024 02:50:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b05eb5a2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 May 2024 06:50:29 +0000 (UTC)
Date: Tue, 14 May 2024 08:50:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH] docs: document upcoming breaking changes
Message-ID: <ZkMJxxKdr2hd1mzR@tanuki>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <obsrinbe2uvemiq7q22zrbcln2lmfaukn6lqn7nagrassoicb4@ihwb6ifpjomc>
 <xmqq1q6aqnm2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EnB7oxiabEToPBCk"
Content-Disposition: inline
In-Reply-To: <xmqq1q6aqnm2.fsf@gitster.g>


--EnB7oxiabEToPBCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 09:47:49PM -0700, Junio C Hamano wrote:
> Justin Tobler <jltobler@gmail.com> writes:
>=20
> > I would like to see the double dot and triple dot syntax (".." and "...=
")
> > removed from `git-diff(1)` as I think they get easily confused with
> > revision ranges.
>=20
> I tend to agree that the double-dot notation does not need to exist
> as it can be done with a pair of bog-standard revs.  But triple-dot
> notation needs a replacement syntax that is just as easy to access
> the feature as the current syntax.  After updating a tip of a topic
> branch,
>=20
>     $ git diff topic@{1}...topic
>=20
> is extremely useful (in addition to "git log -p" and the like, of
> course, with the same range).  Also during a conflicted merge
>=20
>     $ git diff ...MERGE_BASE
>=20
> and its reverse are very handy.  Having to say "--merge-base" is
> probably a usability regression.
>=20
> If somebody wants to pursue this further, my recommendation is to
> treat the two separately.
>=20
>  * Deprecate and eventually remove double-dot notation.
>=20
>    - First, notice the use of double-dot notation.
>      builtin/diff.c:symdiff_prepare() is the place to do so.  Issue
>      a warning about deprecation and possibility of an eventual
>      removal, and tell the users to use "diff A B" instead of "diff
>      A..B".
>=20
>    - Gain consensus that the removal is a good idea.  Finish these
>      steps long before Git 3.0.
>=20
>    - Remove the support for A..B.
>=20
>  * Deprecate and eventually remove triple-dot notation.
>=20
>    - Introduce a new syntax to allow an access to the "symmetric
>      diff" feature just as easily as the current syntax.  Wait for
>      a handful releases to gauge its acceptance by the end users.
>=20
>    - Then notice the use of triple-dot notation.  The place to do
>      sois the same builtin/diff.c:symdiff_prepare().  Give a warning
>      about deprecation and possibility of an eventual removal, and
>      tell the users to use that new syntax we introduced.
>=20
>    - Gain consensus that the removal is a good idea.  Finish these
>      steps long before Git 3.0.
>=20
>    - Remove the support for A...B.

I'll leave these for a future iteration for now given that there is more
work that needs to be done in this context.

Patrick

--EnB7oxiabEToPBCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZDCcYACgkQVbJhu7ck
PpRITxAArtCY7UN+yqJq06Sx48/N8JUuoD/+b78Jumny+mUxgQLUIU+2Zkdszw7p
B1upd+jhYwsO3bc+SwNROObd+0VcBfgy2PW2V1CKRYDgDKTyX3wPN0H03bzLhhXu
tq2nisVLoElaFkXPO//BNsADWaHoEs9lhjcezNa7R9jMtjIsHRlH5rrTf6ips2IL
WnKaPRM7Pkhm1WtyP+WgMnE4bNy/aNumNBU/qtwC+HQZafDcph06FD+0HJ2uaDS8
ffMc1PCXdzeNjo1wcdvOWwhF2RFm6MYLeY7Yy0g/QfG3sZ9oJW35AvUQKQ70c18q
KcIIHj4Nf3jUx70neIXQ9CMhCXgdTPKUo/rhzAuPjSxyeSeNcCpyuaWsSF7nytNX
En5CAxBWtXYt+jYrpKMKN2Ut/Ky2SxRzQhZLXNGm8978RQQ9G/Glp7LE+HhZRFas
uXB5wmAGzh+U1zbszRF8YumBmMkvJ8wg0iUhM9xhmXFZ65Ky+pPgAiZELg6v074Y
OTa4bPwYH+lrNSX7VmQCnBa3x65k6Dh4HY9ZrCPA2nTYcX5XY7GV8in282SXjLDH
n201sMkIOLAXg5Ku5gejIPerJVWYnfMqHY3yfX5z9wZAOtDKZBSQrrD/2jjYTprS
78Npxo8Yt4nX64s2gidMHB9fOsSS5C0W6wbh5pQKr75pqtkLBVo=
=gBph
-----END PGP SIGNATURE-----

--EnB7oxiabEToPBCk--
