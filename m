Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03143446CF
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488407; cv=none; b=NDM6bhJzzxCOnGJ7y2p7prFlFOV7MUKd7yFz6fGOvwx18AsCFfaKNVM/4WcC+DkBzb+WjdBzJ718Yv55YNt2RRL/tND2kkHG2PsLYhBBVkXl05qEYuE5KbFFLddnr2YhlJnuHZMCoJH8l3Lq7ZOhnN5ZXXwiji6qTmtpATE90H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488407; c=relaxed/simple;
	bh=O7mCRJot+U78yT7h6lmxtQqmX/UKjmnAdv/oVylXUvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5S+k5VYqMwOkjOOT2i+JDJEhPefjPSl7uIkdj+29AaifIRi14v4CMHamd8rMorWeERJ6UyBekLhMtX6BsGv8O+mTubXD+R4yCzDGf5XaSDC5KZ4Sc6N221kmRWkHBysyoaXkzNWgs9O+z8DE5TI7/gnAP2Ml7Bt1DvEkokXoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aFekJwTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHBzoa7W; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aFekJwTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHBzoa7W"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 275D4180016C;
	Tue,  4 Jun 2024 04:06:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 04 Jun 2024 04:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717488404; x=1717574804; bh=Nx2AF/lczh
	2J1pMTFzECYIXELNo8Suij4wem1rKfnB4=; b=aFekJwTIXxEML9mlvHwTqGEMQV
	pTKeh03eXZvhfui2Yi6oRWWoUfAuiNFSYvTLn4qKvvcyJDdmdnuZEtyNGG5bKgrs
	HvHtEpBeMfmWOjBZmZkeIWn0iNpHK59mRt5BWIC9h3I2krmtf4VwGEzSSKSJO6RZ
	ylyw44v+qayzEGHiOdK3YarXQZJ6FBgL03uiJ84h9AO3QEiOQBPLhfotgQhIwIhy
	GRqd6MaQmGBtBRWgPIPxLcE7/hdnKv611Ys7AW/eHxI1GwoI5mtqUBtagdbp/Wmk
	B5pZ4b8NXWmYqogsTitM19zybuFchncvtgxwZMxvawEoqeDNmfrzy678GGOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717488404; x=1717574804; bh=Nx2AF/lczh2J1pMTFzECYIXELNo8
	Suij4wem1rKfnB4=; b=lHBzoa7WiCBrLNENac34JbnOBnx6HO1lf+SsBDOgwxnp
	b5JjXZVDvoFh7sWP91IHttAthEryEWrM5IZ5JSXXri/7Wf1tDfUhZ+Bl31dbI/0N
	TSAROTirtJiIYsuiFzKmI10rlmINS0/xpouO+iWrtWUh4eNAFAOhUQPbjdF89x/L
	UHRacnv+AtJsYvSv93COJ6ZXQRmVarz1Xm0+6BJtnQy2UV7HlU2YpmIznCq0aNQX
	yZR5NxiwVqNHbxhYPfINxAeSuatzn+QUwQEMnQSWUZ0f+iul7FV9uH+7YfjA32Gf
	S+xh2T3QNqJm5kgcBdc3pe2uUIW0YBF7l3gptJAl2g==
X-ME-Sender: <xms:FMteZg-wa3VRCqgwICeh3-OCcizw878sEShhUFv1xHk4U__bUkYXFQ>
    <xme:FMteZouM0VaYsrtJjgLx8A5S9-EwoSCWhLLw7I-rNY1UC-kpS1M5b3wwCHZMUl3hU
    Mj67PTwpn_wndCsEA>
X-ME-Received: <xmr:FMteZmARAk2vcp9YteVeaxlad5FaWK5Q1y8pwIDO6i1QDC1RVwq3lDDPIy6pc_wdZAMKV3aHu5h84ojbQeoZcOmxcqm0XEB7UeaO-iGZ4vWylg1Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepudevtedtjeevffehfeduvdfftddutd
    ejheduieehfeelfedtueeigeekgfdvfeevnecuffhomhgrihhnpehmohhrnhhinhhgrdhp
    shdpphhkshdrihhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FMteZgcS4S5bEQfvuh_QS2rRN1p8xPt4ZX9VZTwQN6OMBr4DJvn0Gw>
    <xmx:FMteZlO7vhihssWgMxJh50p0HFwRinB9v2fuQC0rGlYzP24MrnZgKA>
    <xmx:FMteZqnw7BCRT6HhexiebrS4gKnYQMGSApaB9B1_15LU6VNNDHwm4g>
    <xmx:FMteZnvfg_EIvOGsKLkw6VKObdyg0ycAMcAVmOgkvSwsxAFwx0Bofw>
    <xmx:FMteZua_uANILh_Io6rVd-CKqb7OFn4MiqofKtmtktI_LHwdEW-A3LB1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 04:06:43 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 477deccd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 08:06:16 +0000 (UTC)
Date: Tue, 4 Jun 2024 10:06:40 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #01; Mon, 3)
Message-ID: <Zl7LEHFq4FcXMvGd@framework>
References: <xmqqo78h1bdg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q7L38taTBp+eFsej"
Content-Disposition: inline
In-Reply-To: <xmqqo78h1bdg.fsf@gitster.g>


--Q7L38taTBp+eFsej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 11:16:11PM -0700, Junio C Hamano wrote:
> * jk/sparse-leakfix (2024-05-31) 14 commits
>  - sparse-checkout: free duplicate hashmap entries
>  - sparse-checkout: free string list after displaying
>  - sparse-checkout: free pattern list in sparse_checkout_list()
>  - sparse-checkout: free sparse_filename after use
>  - sparse-checkout: refactor temporary sparse_checkout_patterns
>  - sparse-checkout: always free "line" strbuf after reading input
>  - sparse-checkout: reuse --stdin buffer when reading patterns
>  - dir.c: always copy input to add_pattern()
>  - dir.c: free removed sparse-pattern hashmap entries
>  - sparse-checkout: clear patterns when init() sees existing sparse file
>  - dir.c: free strings in sparse cone pattern hashmaps
>  - sparse-checkout: pass string literals directly to add_pattern()
>  - sparse-checkout: free string list in write_cone_to_file()
>  - Merge branch 'jk/leakfixes' into jk/sparse-leakfix
>  (this branch uses jk/leakfixes and ps/leakfixes.)
>=20
>  Many memory leaks in the sparse-checkout code paths have been
>  plugged.
>=20
>  Will merge to 'next'?
>  source: <20240531112433.GA428583@coredump.intra.peff.net>

I've left a couple of comments on that patch series this morning.

> * ps/ref-storage-migration (2024-06-03) 14 commits
>  - builtin/refs: new command to migrate ref storage formats
>  - refs: implement logic to migrate between ref storage formats
>  - refs: implement removal of ref storages
>  - worktree: don't store main worktree twice
>  - reftable: inline `merged_table_release()`
>  - refs/files: fix NULL pointer deref when releasing ref store
>  - refs/files: extract function to iterate through root refs
>  - refs/files: refactor `add_pseudoref_and_head_entries()`
>  - refs: allow to skip creation of reflog entries
>  - refs: pass storage format to `ref_store_init()` explicitly
>  - refs: convert ref storage format to an enum
>  - setup: unset ref storage when reinitializing repository version
>  - Merge branch 'ps/pseudo-ref-terminology' into ps/ref-storage-migration
>  - Merge branch 'ps/refs-without-the-repository-updates' into ps/ref-stor=
age-migration
>=20
>  Allow migrating a repository that uses the files backend for its
>  ref storage to use the reftable backend, with limitations.
>=20
>  Will merge to 'next'?
>  source: <cover.1717402363.git.ps@pks.im>

This one is ready to go from my point of view.

Patrick

--Q7L38taTBp+eFsej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZeyw8ACgkQVbJhu7ck
PpTQlA//VuYU9jaCmu9ZSyBGjbYSKbceCMuKBNJG4LvleQMLpasMXyz3ChqrNk2q
VJDOVUkodcKv4zBYhHEksGuuXWrhs39r7xo44/mxNv/mualp6JuKBMjyXQaZZ+NV
+gXBckd5S79qgMN/s3FWNcKd30Unj25WxWrbYvhbRxxhoRjeCMMb/PTZA4nlhgjw
P7NXrqSzq11lgkZK37EpTi274F6a0gLX9QsdMTENMPQggQiDCw+c5soaGMeYIYbY
pllptwuvBOG03I8rKGUkhVhRK9arPeiVOSBYHAFqK0HeDgKfrwXF9zDYG/4E3H5M
xGV42p9tgzJQVKVrwl5DMV2Gn3jHjb8+B62wgG7iISP9L+ekM/jp6zJBwip84rG6
wk7qci2mv/W2aBrPFexyuCgcdWdSiLABedTjSRBiHu79k2Ov9oCIh0S0mtGm7mza
qynXFkI9f6bBvRAwPKPdFYxVF0VFyM8tAXS03m5APT90mCiUDKp3Nv1lWlhDZbgK
oI6bJDxdGGE0Nr2rBFBWWZc2ui5/OYDQA0WE4UkfzZ4scLetKvTdnMF6aeb54kYe
uw9Q3XGlePTre9kotFTOxEvttPsXzUOgCXv9+kQczTyMb8kSx4pGBfyC+tztnwmz
2a366Zqnt57zUgfmEiWTCisxZAEjvs3eoZJ9cqTmgMIPIhkEdc0=
=jrK9
-----END PGP SIGNATURE-----

--Q7L38taTBp+eFsej--
