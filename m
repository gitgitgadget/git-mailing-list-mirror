Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267171CD1E
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284624; cv=none; b=j1UxRbFgJbVersA0o2AKMtWXm/ocfP7yl7Vokoenj0IeuQErxjoX43Qt7caq3oAiosykexX5GSJ+Bj/fu1Pdjf5PArOrRLPb0O3rFS2Vc/Cy5jnf/p1P272BiRxc41YbIMWmN03HlhKAeornmWLfWccODUN5c58JhNRP8KaJ+MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284624; c=relaxed/simple;
	bh=7D5MB7sSwxltfZllQjMWCEGX2GpPavZ2hJBbbMI9pTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJtmJFIIZvGMEY/j8U7kYLnwGiqFZNecNT/FdjH/r79r0VIbavNDM0O2/iReEZZuSp8ILk/cAa05xCmdbYq225+TPEYQdLHVK6BpHEDhl64q7551A/TBFNjgaqQxJHfHmCHhcImbY0UK8z/Hz9Teaeee9rzwOueI8I0IE/W3kYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DBRA3Eo5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fW30ko/d; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DBRA3Eo5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fW30ko/d"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id CB7BE5C00D3;
	Wed,  7 Feb 2024 00:43:40 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 00:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707284620; x=1707371020; bh=7D5MB7sSwx
	ltfZllQjMWCEGX2GpPavZ2hJBbbMI9pTI=; b=DBRA3Eo5zyvR58n4ygl9nv/gV0
	4s7YTXvekKg5i1K/jOLbVvJzpVzHttDv/wMoCerCFpECBGnv2QIz5ZXqYwu1dcHf
	PGREAIOm4vJoLtUzL5IvYOTxbljR3DMMYIJm7TSdTi19haunYK486cJWU3sZbpdi
	FNzKK9TfMozlo46KrzqemHk8TNBjMnxdR+SOtOffqYtU9OjCsWhRbAE1zT3IvU4Q
	7TuxLA1zrMYgMCJX5aq3fke4p3XLRzFa95nA6HsfwWpTPFM+tRQJZN7318bYpwvp
	aewcd5Az2zikMMXduGaXdhrwTNtUcWqslCB0jerZuqwa3GuwoKvsx5hHvZSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707284620; x=1707371020; bh=7D5MB7sSwxltfZllQjMWCEGX2GpP
	avZ2hJBbbMI9pTI=; b=fW30ko/ddrJso5vf0lBv5ZV852xFAqPj0V5eSRCcadhf
	zEK7uYb5sylNYq3fQyoo/6Tqd/H5oszcG5ECWeVF9MjQlz7X2Qdo1mmJhVXMvw8X
	/uuD+3KEAkT288b6HD1uhAL6oG1+oRZSUweBp29R2mg30oBEDqKd7zGFUIs+SasB
	Y7BmKdj4WcR4Fzu0aqolFX+oE1M3jOE8HegG9OG1wdW7RRNpkZijLOh9Cmx8iZq2
	RjNqf8Gx2/1PZJwJitNroOPSgxCnrP5SAfC8OfTZCxBR7DKAg3aECejiLCXwm8IK
	/aJXdGS/dtFIgv6qOQMWWL+jd3DwEC4C0IHrq1wBcQ==
X-ME-Sender: <xms:jBjDZawLI1pbouf2oJNdmgcgteV319OE5wynX0WRqLfF0HXT5po8Mg>
    <xme:jBjDZWSc7g_XdJZUzqdT7yCpq_SnGOQsh83o-RnnM_KJXKYNTyR33nuj7Hy4q_7bz
    MxOAKMffnL3KNNHqQ>
X-ME-Received: <xmr:jBjDZcXGqgRTrHasOEvcPq2XJLrSH-NqJ2ZrTJSa7uggksOLGXH-fDVXQV-LVh4WiA77Z-fSAM_91bCo5V1JMsxxUg6gq82K24R9mjtbr6ZbEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jBjDZQgMy8O7Em1Sv32wRUKWfhUQASOUXKWH8vagiZBovliPoQ5WaQ>
    <xmx:jBjDZcAT5w2_pzYxd0c_LfKeZ1-0lqsKnANYdeMFkq5DEOXa6xICbA>
    <xmx:jBjDZRKFCL1usin03Ev1r-WacJc1mPfnL0BSpnlg3Z5eRMVowOUZEA>
    <xmx:jBjDZV6QJCqP2hmxq0mvDijTZbkfVCMGCipK6lSd-Ad0BdOclHMcAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 00:43:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 07f453f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 05:40:06 +0000 (UTC)
Date: Wed, 7 Feb 2024 06:43:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Divyaditya Singh <divyadityasnaruka@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Query about gitignore
Message-ID: <ZcMYiOxBA-N0NwWT@tanuki>
References: <B7F364DA-27E7-4BDC-93EE-32E6430B6ACE@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wrrspjqz1tJhMW4v"
Content-Disposition: inline
In-Reply-To: <B7F364DA-27E7-4BDC-93EE-32E6430B6ACE@gmail.com>


--wrrspjqz1tJhMW4v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Divyaditya,

On Wed, Feb 07, 2024 at 01:56:34AM +0530, Divyaditya Singh wrote:
> Hello there,
>=20
> I hope you are having a wonderful day.
>=20
> I apologize if this is inappropriate but I wanted to ask is there a
> way that I can make my .gitignore such that it ignores the entire
> parent directory of a matching file.

Not inappropriate at all!

Rephrasing what you say, you basically want to ignore "dir/" if and only
if "dir/a" exists and matches a specific pattern in your gitignore,
right? If so, this is not something that you can currently achieve with
gitignores.

Would you mind maybe explaining your particular usecase a bit more? This
_could_ help to find a different solution for you. But even if there is
none it might motivate others to think about possible ways to implement
this in Git if there is interest.

Patrick

--wrrspjqz1tJhMW4v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDGIcACgkQVbJhu7ck
PpSuyxAAlupmfNrkwYXNIkTWIR5Jmq4YiFDISCZL0MpW7ckDFuitboAogzLEWFVR
j8G7IMPQQFHUMJ6fUagfgqHcG7VtiNpaLAvBb3TkpSA0nIUBkEp1bJrSvyILh9iY
ex/7ntgdhwHJoSF/3b1I0PR8aPCKKfIIBtPXjSFViHSsMuhX/9vATGzvaSCKlypO
S0hSCTROmiGmTesTchmkT9TsmjvfaJri+Fn/yeRiRN7KcGVjYpVZILx39UMLSc5J
hDgk5GulXuABsCj/Y5/PtcQ/BPdoPwB7W419YzwnTVlC2hKljAjA96cCMzUbBC3D
+gYc79qc42spiXztKwAhp5mIILnDh5Lg6NVdQcibzL5D8owwoNSvd/6YJ31ycRuC
NDdQNF89JrWY3/HLzC3vqhLXcbSVeedjMPs978I1akviKeZPJozQHDUqQf4BsLxj
5x9x5XMXiNskJTHBqckt1wUYrbS8i/UP9FyCLLAXU1qfuq4mEz3+0kcAzuOrD9Hp
hCMWoX/R/yqlC6PiSw/oeW4/Se+ke15qfhomn/HKnpA6xBv8eaEe+QH+KFnMBAAI
SIpDtcLOXLew4zFblLTISJKARcmPCAFP86gfAWh8OBAzQDqZbHZoJQ4s+Voh9D1e
vAmngSlGA2hYOiTx2Sgn2SMHo7iWstGkpOdpkOpHlJj9wHTamM0=
=m7oq
-----END PGP SIGNATURE-----

--wrrspjqz1tJhMW4v--
