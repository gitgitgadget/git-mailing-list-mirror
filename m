Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242171EEE0
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 07:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713164774; cv=none; b=pbjmI+kFEKQPD+gBKlIpGC4zVEtcK3K7j4zGXN91tNh3lfM6PLD+o+7T5YTY9o5rehDeeztKeqbEsn0zwd+oz6w7ZlEDfQOTlHZxjs3sKbpO9OrNx1jIGR2IoNIhpvQ5b5T1Q9x+1YWJ6GlWILzgG/NFbQslsQcWcwS7WgF8WlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713164774; c=relaxed/simple;
	bh=6aDH5aw1WhV6BWuWjr7EykE2gR8mK8+CrQo87dryMfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVSObHQ6i2ICGbmUIMv/yGdUvCdq5Jj8XFgSao/mcykDGoSO3ggjFRI47O4WtQ34DRO0T3VTQkcGl+tMIZWasg/t3gz32CG8S6CkT3QAbgR9k4FTNAJc6pbmbeb9fCsolpF6sVVS2Ni41LgYvhNqzY0W7ECmJA/wtvPwf2oGo+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dVEk4WSD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=keFerOwH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dVEk4WSD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="keFerOwH"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0BAA611400A1;
	Mon, 15 Apr 2024 03:06:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Apr 2024 03:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713164771; x=1713251171; bh=6aDH5aw1Wh
	V6BWuWjr7EykE2gR8mK8+CrQo87dryMfs=; b=dVEk4WSDhXmQG8sn6SLF+fs659
	blQM5t/JCa3Cuqd1yI8nP9spK/z5IhUGVSel9cFiIeqEsV/Hax0weUr3aVpCTNUp
	WaE8f/IhjBBjWbxUclJcbPU7YjcwYqFpKtHm1irgH8eYIqcp6rfh2tcItwJ7wNPl
	tvJSc6EmSPnKkeTd8/aDWHzzLPKDmVQjkALk5cD2Oq8COuseL9BTq9T63TuH3Uam
	Ruzn+IRerCvRluxtSrUWKftPVKvEmrKWGFAH3At/Mfb/P3YfeNKOWfEkI331GdRe
	UCOHdO7zxLb3YzJQhEBVFa9lNo6z3bhFUZ13qRst518NdzGwUnkItLjIjlrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713164771; x=1713251171; bh=6aDH5aw1WhV6BWuWjr7EykE2gR8m
	K8+CrQo87dryMfs=; b=keFerOwHx4gEswf+CPfjsNZIlAbi87lNJUytENAgEVrw
	K10hxMmTrhk+0lKhtG9ntKuOfcKbLXvqi+ec9mx6YGkA/GXuWkNudYWX/m2my4tT
	3jP4mZMOR7m5+kBuOpZDNLKW1Lo+q3qHE6sUMBUDZTfvetszIJrowMBHz8uXKZuM
	4a2NBHe+Uib85SvfRrr3v3Z5X6O/9Oa2py2Rw4iHXNpuJcHJ2aHmaV01isF96/U7
	Xo16jAA7jIfTrbRKcUrjWdhfOjSXJjrLmKRnNSUzoAAVV7TFioNwkNPfctMK0cvI
	BYiwdtVx8KrpHuTDNAC/73EzWOOpSQKLOp2fS2CsuA==
X-ME-Sender: <xms:4tEcZkTGbASBS2q3D4DMF7f8fD2gOy-dSSCfK0z8GdahcieX63qmLQ>
    <xme:4tEcZhyfF6MnHthT1q9gCFWKIdUucJeuhZM5zmG6lwJJPYGTm9Pr680LGSGf9d-SC
    SwZ0UnUsk7onGUy0g>
X-ME-Received: <xmr:4tEcZh0_Mpf4kEOp3XVLui0MXSbbXEJmurzpUJG5mv0OLbX7dFm-2BrMea53fELQxaZNiXSzf4_xuju8OOiXgxiZgk6Xx6TO4h-NULtbu2X7ELo4lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejuddgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4tEcZoBZuB5WYxLYOvrEGq-LYgNtAGQy0wTBib_Q2dXpEojl1-z2jA>
    <xmx:4tEcZtjfKnMj-ztwQ7M8UVhkICuQLlFRBLekD9U_CbknrQ11bH0yuw>
    <xmx:4tEcZkr7Y7o8qKEYCae0CzutfeYV21cgsOZf1f_eF-Qzuojwm4P-cA>
    <xmx:4tEcZggMLHd5fWhW-G4TfI73VrYBZ4jR4lFw9Mkrttz5RnDO3gNBOw>
    <xmx:49EcZraSmDfCliPgyCXP_OgUtnxfmQEtKiwx2HMRdg4jLdcivhH4AFxm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 03:06:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c5be933b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 07:05:48 +0000 (UTC)
Date: Mon, 15 Apr 2024 09:06:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Chris Torek <chris.torek@gmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v5 0/8] fast-import: tighten parsing of paths
Message-ID: <ZhzR3QiuzfQ8LYgy@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <cover.1711960552.git.thalia@archibald.dev>
 <cover.1712741870.git.thalia@archibald.dev>
 <cover.1712907684.git.thalia@archibald.dev>
 <cover.1713056559.git.thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U+ppvZyc1YeXADk0"
Content-Disposition: inline
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>


--U+ppvZyc1YeXADk0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 14, 2024 at 01:11:32AM +0000, Thalia Archibald wrote:
> > fast-import has subtle differences in how it parses file paths between =
each
> > occurrence of <path> in the grammar. Many errors are suppressed or not =
checked,
> > which could lead to silent data corruption. A particularly bad case is =
when a
> > front-end sent escapes that Git doesn't recognize (e.g., hex escapes ar=
e not
> > supported), it would be treated as literal bytes instead of a quoted st=
ring.
> >
> > Bring path parsing into line with the documented behavior and improve
> > documentation to fill in missing details.
>=20
> Changes since v4:
> * Refine C comments and parameter name.
>=20
> Thalia

I had another cursory read of this patch series that relied on the range
diffs for most of the part. In any way, this version looks good to me.
Thanks!

Patrick

--U+ppvZyc1YeXADk0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYc0dwACgkQVbJhu7ck
PpTtmQ/+Pnr8/f9Q3pFgJJdr+CqH+NoCEZV1n0tgWyNvB1nnOSyXbTuqM4PFvflL
2AWdz3nvq1m1CYXnzrtBn7NPoVUzWoLH+IluTvzoGsza6W4q/i8CyLyJxBsR1zwN
W2wtYD561PLm0GtjlXx3iyBjRJkqXmAibitLWcgC3tiTdQVSMy4tIKXehOhNua0O
4Qkee6o2po3pE+0EeRb3wG4iseDdaUBnU5kpQQXqAvjiiqsnDicOmnu1Kt4copvz
sK22NMV2MfGYgzooyH/y2F7FxKBJYclNdVGw8fzhJj4EmWl5BwEZ+Dewx6FccsPe
VzD3QB8qk20BU5tQsXDD/PX/bofcRsJCuzTwV/noUhyuht4TjX4casxq+C+kT7ID
pREPEsUF+VsdpiIahhetv08DzRIgMgj+wTq/HGSGnwtGOfw98mHdldY1IhNEHxZl
ng/VILbE+nW4JsSNDv/Ig6bObBy+4cxtZKs9nWoenbIulZEygHfeWsV1iyOYgqpC
DdAoYCH3dJbOa/TusfwMaMJyOK8DVG5UqCTr0UhPEasZbJGr0n6ctsXDPPfR9aCs
/w3JuhTe5CzjdfsfF5NUkgTU3iAaym70NQL2u5iWKN9oijOv9JwoEdbgJvDQlgct
lLb8ytpazknBRYo7NVDZBDzRpLMDEW4GA5JrhP9cN7cPqhtCWxc=
=IFUf
-----END PGP SIGNATURE-----

--U+ppvZyc1YeXADk0--
