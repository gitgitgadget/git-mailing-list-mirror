Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACC1DFC5
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 18:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711822022; cv=none; b=ZD5KwCL5fo0iAT7HqwYrqhaTwy3/OURyfp9XARDr/hjQJuFdJS82MNCbOGDvmPyAikhS75wKlWpakJDwA55rznmPlxcK6TwoGyY4CvSA+fOmnjynnxDBgpcW7L79GzNOpgCsexVnz4t5MedqwLHcms2KdtD2N7ZWce4uBlp++ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711822022; c=relaxed/simple;
	bh=GEbl93yTnV1V4sC4kr3glvRRovr8tVDFSgx6+rPSU9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKDg0XKy+Nc3KcL/tSg2ZvzCzKlthlJzbsyrqDRXhtExOctiP8MGuoo61k2yPD53+Iowiyur5DgCi2/Uyoxg7JWujDqd+TZCLqNKabDneO5WfCwar5wcSZRPpTn65V0b6DVsQNSVC+XDy2ajFrVvdnuB7dOHovwY5QgjwSFtLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LQ6AQQfK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KKLpGikc; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LQ6AQQfK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KKLpGikc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id C3C5A1C000AA;
	Sat, 30 Mar 2024 14:06:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 30 Mar 2024 14:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711822017; x=1711908417; bh=GEbl93yTnV
	1V4sC4kr3glvRRovr8tVDFSgx6+rPSU9s=; b=LQ6AQQfKoxtDA/Uh03yRsdamPn
	Dd9QZHKU4CYhNBtwgHOwPXRk0RWcCvoGNjZDImfIclU4g1EQkcV3TwGR8G9gAMXo
	Zffr+3jyy0+DJ+onBpsXDhd84PBdi24xU8h8B4TqTg4+mHXKkERsknOUSZI2vpxV
	H1QsXrR4qLNrNhKNe/dUO7LQvqDGvG7bNznQwhmXjUl4PwS96AsL9dpBX46kHGoa
	x1Gx7pMRuVYxpBTYqSD2CySHhlG2AcpR6BPGDcZZkdU67joncbiZ8VCRUcoGjzgA
	6J4qJtaIRHpkFwQrJfmDFbM7Zpx3/X6lfnrYm/B2HszYuK6O2xnR58QpHTTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711822017; x=1711908417; bh=GEbl93yTnV1V4sC4kr3glvRRovr8
	tVDFSgx6+rPSU9s=; b=KKLpGikcuEaARhBzHvt4PPLNXNcrtdxyo4/6/WMmbDVF
	FHM2nuimkx6bsoFE+CQozn95u53/LJqvQYGtfFI8sVuU4EYYeyBIHCCpe/Af94GX
	vlKkSNsUUznK4E6t3C0Hf0cIU73GF43L6TM1SVQxGNtG6cy/+jj4UiVIKQnT627G
	rAiw0jC44Abs3udiwDifz+W2rIiOTj2YQM1QXRcMVaiZcZfuiiKGuMr9jp3AzBgw
	zB+gTkfRmXc+2gky58a7ZAXBOfjvQKw+EVsbUNbXb52B0mrK+WIUTNYGfB8t9A6Y
	6MQ/0x1Tmq1xGR0iU4HA3xjHPKz4oq0T5/KnwI3AqA==
X-ME-Sender: <xms:wVQIZvWs8zbVgqVaa-RCnY3RpmC0cqUsKTLVTPd5FnvONVAVJ6Cp9Q>
    <xme:wVQIZnne9oJzf_sZagMG9PZqx877n1-ppuvr7b1fgb287FwevXawSTXmiJHi8p2kE
    MvyMiSFTas1oKNzMA>
X-ME-Received: <xmr:wVQIZrbH6YsPdZa8zLnY4suje3yegcyV3fVqoWojn2vsFOw4rMrg5FuJTGFs7Mf0pJIWBiyESnjGwbBYPAKXRqLFZdldco87ZufSAJSt9lM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvhedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wVQIZqX4otBGGKWWpJ_wyBgsenREKaTgsUGS0Ow1RlN4eCBXSONCMQ>
    <xmx:wVQIZpngJ8tEjtlJYteg_VShITNLVFK0ynTX3ImbxcYle2Vb4Grg-Q>
    <xmx:wVQIZnezto8QzLeGy-xMYxRqojc3aM7mhB1HZpxh1wjx0PfjF_X9mA>
    <xmx:wVQIZjHlWGyPHd161DRHCR_QE3nzHRcww1fkom2ca2Mr8m_3D1PRiQ>
    <xmx:wVQIZr4JElBdrJHh6uDbLIRLgVOucHRlT0TLsMQ_IUa0ue8IlIJGLUQUU_Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 30 Mar 2024 14:06:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 118b1aae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 30 Mar 2024 18:06:51 +0000 (UTC)
Date: Sat, 30 Mar 2024 19:06:51 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	psteinhardt@gitlab.com, Taylor Blau <me@ttaylorr.com>
Subject: Re: Git mirror at gitlab
Message-ID: <ZghUu7Ae5PYga-Ji@ncase>
References: <xmqqy1aba6i6.fsf@gitster.g>
 <E5C00398-536B-4CE5-AB25-FE7FCD55CCD8@schinagl.nl>
 <ZfzUb9HkZLq1UIed@tanuki>
 <CAP8UFD2LmapWutRpfveL6ChSg8xrCkQXyQaJwHyEp8JA0p_Osw@mail.gmail.com>
 <Zf2B5oksaJRDH5WT@tanuki>
 <1d6a282e-afe6-4d43-a61c-d0259131b11c@schinagl.nl>
 <ZgfK3DoeidDcIaFj@framework>
 <f283d6ed-54b6-4bbd-8b14-67c9c8d50a2a@schinagl.nl>
 <ZgfWH_smdZ1jXkLO@ncase>
 <68563c5e-af74-4300-84c4-a0d75434167f@schinagl.nl>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EUDBzrFPySxpQD2v"
Content-Disposition: inline
In-Reply-To: <68563c5e-af74-4300-84c4-a0d75434167f@schinagl.nl>


--EUDBzrFPySxpQD2v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:59:51AM +0100, Olliver Schinagl wrote:
> On 30-03-2024 10:06, Patrick Steinhardt wrote:
> > On Sat, Mar 30, 2024 at 09:20:22AM +0100, Olliver Schinagl wrote:
> > > On 30-03-2024 09:18, Patrick Steinhardt wrote:
> > > > On Sat, Mar 30, 2024 at 09:14:47AM +0100, Olliver Schinagl wrote:
> > > > > On 22-03-2024 14:04, Patrick Steinhardt wrote:
> > > > > > On Fri, Mar 22, 2024 at 11:08:34AM +0100, Christian Couder wrot=
e:
> > > > > > > (Sorry for initially sending this privately to Patrick.)
> > > > > > >=20
> > > > > > > On Fri, Mar 22, 2024 at 10:41=E2=80=AFAM Patrick Steinhardt <=
ps@pks.im> wrote:
> > > > > > [snip]
> > > > > > > > I'd personally rather go with the latter, mostly because it=
 matches our
> > > > > > > > git-scm.com domain. I also like it better than the current =
git-vcs/git
> > > > > > > > because of that.
> > > > > > > >=20
> > > > > > > > So Chris, would you mind adding me (@pks-t, my non-GitLab h=
andle) as an
> > > > > > > > additional owner of that group?
> > > > >=20
> > > > > I'll empty out my gitscm group, make it private so that it won't =
be
> > > > > accidentally used and transfer ownership to pks-t. You can then '=
do what is
> > > > > needed' with the group. Since gitlab doesn't support aliases (yet=
? :p) best
> > > > > to park the namespace.
> > > > >=20
> > > > > Olliver
> > > >=20
> > > > By the way, thanks a ton for being this open and helpful during the
> > > > whole process. This is greatly appreciated!
> > >=20
> > > Hey, no problem. I initiated this discussion because I wanted to get =
to this
> > > solution. Just because my mirror is not used doesn't mean I don't agr=
ee :)
> > >=20
> > > Btw, I can't transfer the group, it's empty, but if I delete it _righ=
t now_,
> > > you'll have to re-create it, _right_now_ (well within the next 5 minu=
tes?).
> >=20
> > Shouldn't it be possible to add me as a secondary owner of the group in
> > [1]? From thereon I could "transfer" the group by removing you from it.
>=20
> Done and done.
>=20
> I'll remove myself, or you can kick me :( one I know you have successfully
> received ownership. I tried to invite the group git-scm but that couldn't=
 be
> found, probably you can do that (and then remove yourself :p)
>=20
> Would have been useful to transfer ownership of a group, iirc you do that
> with repo's as well? Under the hood it could use the invite + remove memb=
ers
> thing. Though this works.

Thanks! I've added Christian to this group such that it has a higher bus
factor. I guess it should probably have the same owners as the "git-scm"
one just in case we ever want to do anything with it. I've also removed
you from this group now.

Patrick

--EUDBzrFPySxpQD2v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYIVLYACgkQVbJhu7ck
PpQFwxAAkf0ZhQ7f10/5Rv0uvhMAu6ZhC2nxKoEwzxftZTrLE1Kq+0x0JYw3/iIg
XffyPkP/s3t0ao53bwMxvUOwJ31ZYLh4rmsYQrzOoqA9Tg8cIF1fGa3i6k4231yy
rjLXKViG/Cd8U09P5IxTXstg/ED1xyCHq1uHs4JSGHOQ2LQzsoaChi2Up6P55wK8
PY9ErnMd7yrwjabPryUKWLfia1o12Uzi+bALrYP6SN55r0ic8YJAMcsjksFqiX4m
q4F139VvKxj2ImaB+Jg2NqJ6Ztv5ijYW1igmAFwlIkWhyBAxGgsizZnSf32M0my2
NYt+qj8yOuQtQnLQfvbqt/a+FVi3gWjLMU7lh6KVaf/6Ye6MvyAtpu7skTfHhOUV
fc7YNr+7HAKhp7qkOYVqSkab8yGHtXxeKI09z18HZoNg5tcNIL7Ct3KKU4DDvfGW
i2rZ0yuKWHjGLjZHg1ei5FpBcvcoFXJu9h+4Y/5lilLszH5U2wlJ4XC8UMNNBJ6B
pud6Gdq7l8LR+Bz0DCjF/s/j92Cx5UszS8rn26/A78dcIUEpMV6pCqBrx7fgMd1C
+DFwUBxVIdMNCIWbNaJEqf0RRQi2E0+5aSS6pBscKNxDBdjNy6mliSR7JHFtFG/t
bhOUMAHKFnWpS52ECP7S9COsCig6d4V0FKOPVLfjkouCdYa+jS8=
=LITd
-----END PGP SIGNATURE-----

--EUDBzrFPySxpQD2v--
