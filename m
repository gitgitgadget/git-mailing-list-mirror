Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B3A4C9D
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 06:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521381; cv=none; b=GgQKW4HCjxdCYLPec7vLLmmXpB+VI02Q82GX/dKQVtArwMBCAfXcHsch0FZGp2gYph5u6mL9qzKWjUiReDC1hkz9R6qtYqe8apKn6Q0GjAZzSV/QZrtod3XoYR3DVyPQinYuzGM0C5cX/6XzKYqr/OcKIR3PY5shkOc0rUrM8Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521381; c=relaxed/simple;
	bh=cnKufyD4dlsugydRqpRb3QbIGu0s3y/KOgtf2qQyAiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uJm6hBWBmXbAMwzyq8/PuiGa4rLF4eXCOawL2hieZqj4TYzGO9POcN44d/+WIKlwvrHFZQ/b0NacdEPft7IvKehORRr5vsuOJ1QhYvBELtrdIhUW1a066b+/0ybnyucXHVwnFL+ypU9JQTVAmk44maeLU+EAiafdb2Kx4to3Ick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lb8fP3hE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rhyLfQsI; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lb8fP3hE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rhyLfQsI"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C879D1140170;
	Wed, 27 Mar 2024 02:36:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 02:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711521376; x=1711607776; bh=cnKufyD4dl
	sugydRqpRb3QbIGu0s3y/KOgtf2qQyAiU=; b=lb8fP3hEJz9hpqOfZcLXXP06iV
	H4QSZOMtbr5ks/84kZ2EqR1IqI34FZODH+x0penuO1Lq42+4j2Y2SJ3R9/L+tmR9
	0l7WxnUMZusQ55dzIqvh5A1MK2eeFWf4AzkpHiR/KDXR7SMiWeVFWRMOMvGQIija
	5o3BsfYqHbAvuXmDDsYsqagPJQpHZAhQ/66z/1argPmbD0WzVMpA8pfzlrkJkH3c
	LhYB+/mLq63yueYk7tH57Ffb9TXSpYm+4H4iIdod7x0zpB19J+PO0/ffeHX+Gcmc
	fyZXXTPWDeeOeMjgiiuGknT6fn+y3HtH3sp2CgsA+IoSb8Qqwkuu+rWZPRbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711521376; x=1711607776; bh=cnKufyD4dlsugydRqpRb3QbIGu0s
	3y/KOgtf2qQyAiU=; b=rhyLfQsI6dVc7KGVyGusciYPG9TSv9URrzbhL2uIxsQH
	mzbDQgQsUml1vUYhHe3kQ1I9o/ubaduHtQ7s1Wa7d26cM/QPLdxt+YVvU41g/RSj
	MUy/EotdLpWHfX/Tq+N4Y3u02YZYcFTylek7HBw03aFNqgRCtFAwa9952Ud80S5z
	DCjHIw62mSWvvapq+n4UYXEZO9Sg6a7uolEU1rWfAb2bk3ejR8x759y4Afj5eWoW
	MdEyS046jrRHqBi1vhHxudaARBmWe7uvORjnWQkRYUuvHNyvhg7zPndfW7iWei94
	1w66CSCtULEnnqVpDM8iW12lW/6XYTnYrKY3Z0qWnQ==
X-ME-Sender: <xms:YL4DZqYEMwcyEe2IknIeqwfEUK1km7ca71QlgGoszTewOBROR-ROKQ>
    <xme:YL4DZtY65GuWMB2j7QFNndR3uGAmvngZh_2dKqarBUJKxbbZid2tjRbvNvmKMpATy
    Q0GB-t2yM4g4dS5Ag>
X-ME-Received: <xmr:YL4DZk-pscU3ToF8PkMUqeou1KiV2Y_b4l86GxOw0qhp0LZOgn5da7V8D3g_1b53ZZZzzNRjghov3xm5mdqg18U-tYpzVIE-0rBGoOVluuAIXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepfeehhfehtdeggffhgeehgfdugfdtleefhfehieetieethffhgedvkedtfefhudeu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:YL4DZsp8eaZ2u7Yg_SWMIIa_GVsAVPXaMu1sleeV4yMLta-W_uMwZw>
    <xmx:YL4DZlpiU3oa15oYZ8wSsdjDtAh5turFhAR45CU3tasHPc6Ol7VihA>
    <xmx:YL4DZqRYvDdnVZV4aZ0QPTNz5BLwKL9bwPNYgDNistYO4zbbk3fl3w>
    <xmx:YL4DZlqnolR645Xi7poMT4wGlqNHIJVJ3DfNK9wr0BNUc-cFlgGGZw>
    <xmx:YL4DZmkH3FnhQgXXo0ITG_m8gAVV2RUCfNJ0REkhcpPzcncCDIgSeA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 02:36:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f7b3cbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 06:35:59 +0000 (UTC)
Date: Wed, 27 Mar 2024 07:36:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: vk <g@vkabc.me>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] Microproject help
Message-ID: <ZgO-W3E-CeT3n7vl@tanuki>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
 <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
 <a344deea98bdd2daa7671fae45c0bf11@vkabc.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0u7Qvot4CP5pG8yE"
Content-Disposition: inline
In-Reply-To: <a344deea98bdd2daa7671fae45c0bf11@vkabc.me>


--0u7Qvot4CP5pG8yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 07:56:19PM +0800, vk wrote:
> On 2024-03-26 02:25, Karthik Nayak wrote:
> > vk <g@vkabc.me> writes:
> >=20
> > Hello!
> >=20
> > > Hello all,
> > >=20
> > > I'm Vk and I work as a software engineer. I am interested in
> > > contributing to git repository. Apologies for the late start as I only
> > > stumbled upon GSoC recently and git project interested me as I use it
> > > everyday at work and it would be meaningful for me to contribute to
> > > it.
> > > Even if I am not chosen, it will be great if I can start learning to
> > > contribute to git open source.
> > >=20
> > > For the microproject, I have looked into the lists for 2024 and it
> > > seems
> > > that all the projects have been taken except for `Replace a
> > > run_command*() call by direct calls to C functions`. However, it seems
> > > that the issue has been solved. The command I ran to search throughout
> > > the repo is `git grep 'run_command*('` and the search result returns
> > > run_command functions which I assume are essential.
> > >=20
> >=20
> > When I ran the same, I saw around 135 results. Are you saying that
> > they're all essential?
> >=20
> > For e.g. In `builtin/gc.c:maintenance_task_pack_refs`, shouldn't you be
> > able to replace the `run_command`?
> >=20
>=20
> My bad as the example uses `run_command_v_opt` and upon further inspection
> it seems that there might be similar situations like the example that can
> save an external process. However, for the maintenance_task_pack_refs, the
> command being run is `git pack-refs` which is a write process unlike the
> example which is a simple read only process of `git show-branch` to get t=
he
> current commit? I will be searching the codebase for similar read only
> `run_command` and see if I can replace them.

Hint: the `maintenance_task_pack_refs()` can in fact be converted to use
`refs_pack_refs()` instead. I was briefly considering doing that in [1],
but then didn't want to do such an unrelated refactoring in an already
long patch series.

So if you decide to do that you should probably build on top of my patch
series to avoid conflicts. The patch series is available e.g. at [2],
branch "ps/pack-refs-auto". So if you decide to give it a try you should
build on top of that branch.

Patrick

[1]: https://lore.kernel.org/git/cover.1711360631.git.ps@pks.im/
[2]: https://github.com/gitster/git.git

--0u7Qvot4CP5pG8yE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYDvlUACgkQVbJhu7ck
PpSQtQ//VabxEuamf7fIkw0dOd1UvilZxlQHlMLEvlztwfVNSSyLvTcZ0fZpNvwM
ztQi1RgW8BQLSeAjv+XB2DT7duL7DmVWYv4P3jIaliwg9cF8U3H+We7SEsyv3m3U
qqW01Ql6qTuWQZhNOYMji68J+9Iq4nnUbThULejdXaS/nrlUX3gSxvHXLIuqtmxv
WNSjMcY1D9qNQGa7+/4E7SvzQfTAMJa16teploIPs3JQO9zmbM2jhT+LBFVEikeT
LtGnGnvtrsJWNP/Nct/b7Myto1LtwLWWeT2c0EiJ9pV5bcJjFskpq/NnFkMhAz+m
6XFl9v5YDvNedONffdNaB7NlHrd0rBhUA7XQxlIlGwBh0Gymn3L2vQVA03C3VTTr
wL6vwXCHFAvv0G8glL38R9stfPd5YOx2wOtn6LM8cEyxEFLq3q/4M7kjrBzJOHs/
eNqto2CvIVH6WF7w+DXOyBR84n/6o5WeFS7KJRzc9jUVqPmjd78JF5dslfVH+oPf
5vEtRhVe9mHCZnYlceYDsGSgkmhTYtyGwRfGkTbcCUDgf+fOauwkgHCJRrbkSpVi
wmu1pxiOjbyOYwf4uyqmnimptj/juVTouozVvbewxIDGnefB0iRmf9fcSWxQCmxz
34Wi4NmlhN0UMt/qnjt6ES176RWR8pvdORWab2xz4SYyBRK0tZ0=
=S7aM
-----END PGP SIGNATURE-----

--0u7Qvot4CP5pG8yE--
