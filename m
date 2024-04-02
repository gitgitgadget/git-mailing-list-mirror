Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FCF5D74E
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712054109; cv=none; b=pSyLujoZ0kNqsqnTs07mzEBz50OuJP8wGzEEIJsAkfknjq/EsAgDzUPzR7H/DoFGm6VRb2jp3mV2mQOWScY0xZIozUyTqar/jWOohm6Z9npPOQoeI1NXRd+f/OBVEloqffIA0OiDh30hya1qOb5Weir7M1U+rcbrsIw56SExwcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712054109; c=relaxed/simple;
	bh=Cr87wbwd4QVRIjOtF/8s7BaLcC9ibTBH6Hg8UWGcPVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2IrxmE1lZYaBMNLahiCx0VUWhWCrFjEEzVEIN20hHSL5/nfUfxh52IneKaT/gePcZyR4YLXwAhsJLy3a8yJdLBUO/EGxZn4pz/1KfFMeYOisQXD+mAwH0Zq/WpNRnotqN7bI5Yx4WpbUTswasQEr4YDkgzN9oPoR+BEO3s4aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oQ5WPa7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bN+0uPYo; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oQ5WPa7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bN+0uPYo"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9F98A1800098;
	Tue,  2 Apr 2024 06:35:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 06:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712054105; x=1712140505; bh=n+1sGQPnST
	s6v89c/OcRPYk5WtiRpmeXbvpZeQmKbh0=; b=oQ5WPa7vvSCom6ea99uD1Y8Qep
	Z/KsxWHt/0kbSartsjG1XfAMNipw4Yx0wRNal9J7P2TB9kB4Wpcsbs9/sZFLVyiJ
	zdZtYioIC0lPra34fsorFKG4upRVCFg82sGvwYONeq4GMtrtcfZ0z9O+DI74oUge
	Svyv0Z6eUdkcayk1uf0h4UwCvVHArbA3VK4t+9kNRrsERF63cHYBIXO9A0jRBAMk
	AyMGuIp4RRUsSqLkcECa/G0J2imn0ZJZvgw3ecdRvuDiAy3YzKxhA7lhngoqTsM0
	+lSF1nsolQomoDh9DzpFW39k1QOduEpAJoFwwb1ybBzes84qtrTR2eoR4GjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712054105; x=1712140505; bh=n+1sGQPnSTs6v89c/OcRPYk5WtiR
	pmeXbvpZeQmKbh0=; b=bN+0uPYocd7RFqcSCM6P9Lvzq1yheYEdsFv+IFUl4G7G
	kIgM3xYrQ2X21+sqreg0ZMJmody45H20AftPDAusqOeRb4P7N+Xs3qgfQYNhmKze
	1bmP9rxBKJrjtqrWxXA/Nw+/QpEicT5NR66v7Aod/kQl7rz/jEFEtozZdlNZ9ZCM
	+NHgGtLV4p+XLAKC440NlSyFs0lBv1FrIP80cd1WifOmKzjMqPuJ6CNiEqonL2gJ
	qSggxOc5Gw4qB73t6Ikw2uh/Ie/i2id1Loe80/UX9tv2/Antw79g55SG5wdMJ3PL
	GS5Y4jlaYEt5YhSJQ5a68t/PkmVtoPQX4SUKDkzQOg==
X-ME-Sender: <xms:WN8LZgAAbrHrio7hWqEYXSKWsg0tWAeg9NLLX-5ohkgXhFF4teE5wg>
    <xme:WN8LZigczKd4yEaSOsZ0_bbXhwe6GF6pSRbp5dJdO7l62NrQlh8CypUBxIajYpdSA
    SrDPgICVJnjJp-TKA>
X-ME-Received: <xmr:WN8LZjlFdG-vh2dlQP-b4W8bIsVEtEE9CtXcfipc19nrALRJ_4qf8q7HIwFLIxSvDQmxQT9QlipUk7wvXGneTfDst6E5gkeUUB5Ryk8ThtVzhqI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WN8LZmwbIm6sKiZBAthgaad_M8NKBLwSxOW2tgBn450kTo3Lcfzk-g>
    <xmx:Wd8LZlR5_LTT_-PdqiG53uA-_B864xA2Pid-k0SxbzGDrfeseTKt9Q>
    <xmx:Wd8LZha91xbaWAdtsRVSXKQqcznva_6lsMfgNEg9FmVUnm2mF9VXyQ>
    <xmx:Wd8LZuTXomSTh6gEAbsRWZEmZB4YgfbpnjALUZyRkfIJ0e_j_poW_w>
    <xmx:Wd8LZndvFtSS1_Q0NhCtqqKvOyXzPjcEDlwXoj32E2d8y_HDKAopoe89>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 06:35:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3d6a036a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 10:34:54 +0000 (UTC)
Date: Tue, 2 Apr 2024 12:35:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: vk <g@vkabc.me>
Cc: Git <git@vger.kernel.org>
Subject: Re: [GSoC] Microproject help
Message-ID: <ZgvfVE4ZmOUPri0U@tanuki>
References: <51647635a10e31e800f87e8bd4a2e62c@vkabc.me>
 <CAOLa=ZRrmyZ48C5r8MWioyjySWdKtLxhtDBg5F2tRsExHaR-fg@mail.gmail.com>
 <a344deea98bdd2daa7671fae45c0bf11@vkabc.me>
 <ZgO-W3E-CeT3n7vl@tanuki>
 <80f0bb12243eedbc4ad6580cb06abeb2@vkabc.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nKumNmHoIhafPZeW"
Content-Disposition: inline
In-Reply-To: <80f0bb12243eedbc4ad6580cb06abeb2@vkabc.me>


--nKumNmHoIhafPZeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 11:57:31AM +0800, vk wrote:
> On 2024-03-27 14:36, Patrick Steinhardt wrote:
> > On Tue, Mar 26, 2024 at 07:56:19PM +0800, vk wrote:
> > > On 2024-03-26 02:25, Karthik Nayak wrote:
> > > > vk <g@vkabc.me> writes:
> > > >
> > > > Hello!
> > > >
> > > > > Hello all,
> > > > >
> > > > > I'm Vk and I work as a software engineer. I am interested in
> > > > > contributing to git repository. Apologies for the late start as I=
 only
> > > > > stumbled upon GSoC recently and git project interested me as I us=
e it
> > > > > everyday at work and it would be meaningful for me to contribute =
to
> > > > > it.
> > > > > Even if I am not chosen, it will be great if I can start learning=
 to
> > > > > contribute to git open source.
> > > > >
> > > > > For the microproject, I have looked into the lists for 2024 and it
> > > > > seems
> > > > > that all the projects have been taken except for `Replace a
> > > > > run_command*() call by direct calls to C functions`. However, it =
seems
> > > > > that the issue has been solved. The command I ran to search throu=
ghout
> > > > > the repo is `git grep 'run_command*('` and the search result retu=
rns
> > > > > run_command functions which I assume are essential.
> > > > >
> > > >
> > > > When I ran the same, I saw around 135 results. Are you saying that
> > > > they're all essential?
> > > >
> > > > For e.g. In `builtin/gc.c:maintenance_task_pack_refs`, shouldn't yo=
u be
> > > > able to replace the `run_command`?
> > > >
> > >=20
> > > My bad as the example uses `run_command_v_opt` and upon further
> > > inspection
> > > it seems that there might be similar situations like the example
> > > that can
> > > save an external process. However, for the
> > > maintenance_task_pack_refs, the
> > > command being run is `git pack-refs` which is a write process unlike
> > > the
> > > example which is a simple read only process of `git show-branch` to
> > > get the
> > > current commit? I will be searching the codebase for similar read only
> > > `run_command` and see if I can replace them.
> >=20
> > Hint: the `maintenance_task_pack_refs()` can in fact be converted to use
> > `refs_pack_refs()` instead. I was briefly considering doing that in [1],
> > but then didn't want to do such an unrelated refactoring in an already
> > long patch series.
> >=20
> > So if you decide to do that you should probably build on top of my patch
> > series to avoid conflicts. The patch series is available e.g. at [2],
> > branch "ps/pack-refs-auto". So if you decide to give it a try you should
> > build on top of that branch.
>=20
>=20
> Hello all,
>=20
> For the build on top of ps/pack-refs-auto, do I commit to this branch
> locally and get the diff for submitting the patch?

Yes. Generally, what I do is:

    1. Check out the `master` branch.

    2. Merge the topic branch you want to build upon into the `master`
       branch.

    3. Build your topic on top of that merge commit.

When sending the patches to the mailing list you would mention that
dependency e.g. in the cover letter and then only send patches from the
merge commit to the tip of your own topic branch.

Note though that, as Junio mentioned, this is becoming more involved
than the typical microproject. You can of course still continue to work
on it if you want to, but definitely feel free to switch to an "easier"
target to work on.

Patrick

--nKumNmHoIhafPZeW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL31MACgkQVbJhu7ck
PpQ1VhAApa90H30PWG2Shz8IwSHPwUAafPNXAucJPD9XgCVmBfe+Mpgijil8y4sg
WRxeS7+d4cg7+hjwbvHEWgdt5EPCLoDBMPH1R8fWthZOB3m/DVJizkf7uiRAQ+3c
coHVcfXpmYsVCi9CyTR/ULYBJas3BpVzlbpdO1YCOyjqEGYQ33+M2skgiJKFJLaa
RXx4I4x9CKVTlI6HR1w1jz2oW/CWVvSq0AqkBIFgrFHvoDICxoj5Y/bGH+M6pZUl
XPkG6InSmhuRINHS9WjgGUc/Cw/sz4jHaLQQAzKKq5eOQVWgGpH9x2FRhMzkNfpy
UiBat4cQypFk3KJHcVXiqJ7A2i705DgRnw6oyhAbjw0LFRrn8F0NJ3IfzNP97Hlo
J1Y1c9rk7cCG9Z6FnL4SS8KdPMWT8W6DbYQJbiyGS0hPqaTHKbhjjMKSCkpBBSr1
3XuRskKvcQqFymkA6XN/SG3vuBg4nw9fkOxLbkCmqxckfp+A7oseUifl/fVWIzO9
Aw3ZwNFCEbt9WTrb6CVp0rSiptossohCk51UyZti5zGIE1ceLjRb39TJFsf1f2NK
n9cnaXqwZBWbGt8tEqX4r9blL/09oYqvwttKKKM2HPfJ0rHgFGGG6LI6Non2/RCJ
fJbdCTqgV2yAOxGEp9TW6iNjnWmZ24Ra9MqCGxI0rNYujDQ4y+U=
=kj7H
-----END PGP SIGNATURE-----

--nKumNmHoIhafPZeW--
