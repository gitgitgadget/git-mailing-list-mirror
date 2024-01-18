Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C2825750
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705584580; cv=none; b=h1z3Ig6P9RyCezMurbuyV6u/i3rL/sd4C/BRufNna2sCkUWzNYJ53SOd9782+SMCYCLwbbExHBRL8TDZp0/d0iozH/ehAS9NmNfn5f5o0B7/ehqlRA+ZQ0gxwkTOXCxR14h69KHP5Swe/aRu6lfxfsNkWKjX93+DQwYyD7FHdOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705584580; c=relaxed/simple;
	bh=xRiKGm8XguCFXfK0GzE+g0pMipI1zVi38al2x8d3pLY=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=p4+DVCvFG9C9OTlEUWGkSWOZfl8IIdlG7Mt70zehJK4ahMI1uLkiBMA475UYOFJdsuGD4HMSarVkVQqX3IcAC4SrGrbilftSYchSiwL3WBkxjY4A/8TsmOiOsaUQDccDGEKfmO0CwZnhxbUF58eLjeml6YlrwxbMjtGacey9oSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mIKNYw5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kVwAiOky; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mIKNYw5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kVwAiOky"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id A60283200B4A;
	Thu, 18 Jan 2024 08:29:36 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 18 Jan 2024 08:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705584576; x=1705670976; bh=xRiKGm8Xgu
	CFXfK0GzE+g0pMipI1zVi38al2x8d3pLY=; b=mIKNYw5ShUfw2Qvr+mh42Vbsj2
	nltcCFWhUVrWTT0WwVBw+doi5Bj0c7hcbI3fs7CFWEX5LnKP2ZId+s77iw1Zcluo
	WhK/7qE5POUI3G2g3kXdOCDhoyf9oAdhlsdZFMT2JWSidwQvybFFl2rxsJXKHhtR
	hWlaOh1AetwYjr1LuUxM/UbbiAld8X1RI3TnNKPNc8wCkBxv59IxDu9+b8y16l9m
	ilrwEX6VdEfH79Wg+rY0hniXSxKc8OYSf/IcSYjwq5u9S/ZB4JD4cg3UktQu5UPN
	AtEElpWtfxpz13H52N4wYqUS8jejHlEHwUfykzU9/liulsUwH4CTeZWxQZ5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705584576; x=1705670976; bh=xRiKGm8XguCFXfK0GzE+g0pMipI1
	zVi38al2x8d3pLY=; b=kVwAiOky3ceXF5uW7h1g7X2NYh1tp7PdHjheSkN+ztYr
	jTKBC1TBDc7GTJe0t+P3ltCwXVRLs9jeAI38FMIhJUXb/MIXuRiD/deAwLXN4a/n
	TOzeA4DFi4WjgldpWGRSyM7PEpVY4rD9jP+utV+HFbKEcJ/TJD2QbbFcCrvvDSOw
	gxjqxL516VvEzbnJsoyxUX9aENTi14pd6FVaAgPQO5kUN0FD14YU4B2xlM8ByDKw
	FlyzCD+ERYEn4f2R/Ga0PAVwEkr+vSIJTyXDpsaNY61Ko1UENZ32cWVx+Vksm7RX
	a9qaHci5FXETVL3iUPPJY03/nnpkSr0jIxHc2e8QPA==
X-ME-Sender: <xms:vyepZU_G3-Ltncimy7aoO3Hda5N1URw2f5m5DEJJsJKBsK7Unyl02A>
    <xme:vyepZcuFPEBNQRI7uYTeoSLBcHfNCiI_1l_oPeFMcbROIM6YYbU0UshaOtCu-bKCX
    Y370skEeVA6oxXu-Q>
X-ME-Received: <xmr:vyepZaCxfRJB5qgFGuOyTixRTez5fwJwFEc1-r7QMuJWzqguW-QOVzm8RK6wqWsYFsSsDWKPEr4r-Bkuo6mXIMJNJf8IJYzRpuAwGiavtld6NgY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vyepZUfNfZEV6FcpVHcjXrAoOPZk2WA2u09LbzFVqaPWD6d5b8IGzw>
    <xmx:vyepZZP1tQTT1u_J5zCFiKqgXErklb7LIf0sMhMCmWO1XvlDObgbPA>
    <xmx:vyepZek9htqeIq4Uv8mqF0W8TO5gjQC-d1HymMJDFbIWDA4bOtAjfQ>
    <xmx:wCepZbVi86cQdjxZcC6vWelvUWRFjndAMuOvAMKsGe2T6ZvKhYITkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 08:29:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7745e6d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 13:26:37 +0000 (UTC)
Date: Thu, 18 Jan 2024 14:29:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Konstantin Kharlamov <Hi-Angel@yandex.ru>
Cc: git@vger.kernel.org
Subject: Re: How to execute a command on git am/rebase/cherry pick --abort ?
Message-ID: <Zaknu0nwBucHVJPP@tanuki>
References: <d66ef46827fc7391bd74ece943afa2c5245896d6.camel@yandex.ru>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+0lDh32YORIWvLow"
Content-Disposition: inline
In-Reply-To: <d66ef46827fc7391bd74ece943afa2c5245896d6.camel@yandex.ru>


--+0lDh32YORIWvLow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 03:53:21PM +0300, Konstantin Kharlamov wrote:
> (please keep me CC'ed, I'm not subscribed)
>=20
> Hello!
>=20
> There's a well-known problem of git not fully checking out changes
> while doing e.g. `git checkout` and similar commands when you have
> submodules. So e.g. if HEAD changes a submodule commit and you do an
> interactive rebase to HEAD~2, you may be lucky to find a submodule
> commit change in `git diff` (because if you don't get lucky, you won't
> notice that and commit the change to the unrelated HEAD~2).
>=20
> As a workaround I have a `git submodule update` inside `post-checkout`
> hook.
>=20
> Now, the problem is I still often finding myself having the wrong
> submodule ID, and I tracked down that problem to commands such as
> `am/rebase/cherry-pick --abort` also not updating the submodule, nor
> executing `post-checkout`.
>=20
> I looked through `man githooks` but couldn't find any way to execute a
> `git submodule update` during these aborts.
>=20
> Any ideas how to fix these?

Are you aware of the `submodule.recurse` config? If set, it should cause
git-checkout(1) and many other commands to recurse into submodules and
update them accordingly. This should both make your post-checkout hook
obsolete and should also work with git-cherry-pick(1) et al.

Patrick

--+0lDh32YORIWvLow
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpJ7oACgkQVbJhu7ck
PpTlEA/+KaUBegaeMFOdo5lIPJxMPnJcdrQS9dOmSPNIsYl5tgmyrZD1alAPf+Fy
cWE2HmlCfu5dsiZDFCn2HTE9vAlcdK9xyj7EgOKYVgWg40x5OAGeaS5mjY5BsFTl
QC9qRd5rlZUJre8Ko2pcSPcYqoYDvhFQ+ZHONwZCBJNNsFF13mCg4MYTbd/TLlPJ
l5nx8/hqotl7kB02wX4NdTY3mAuCXq5YU0G7U45cUfVuX4lMZ0LuQjFM1VjiuP16
ii1PvyFqHoIPkr0BRbOE0TaCuKP7vToV58e4/ZGiFWA6ftcmnnzHfJfsOQEzQoCb
EEbBaqVMNUWWXFrlP6lk//QeD34HTX5kzln6tAVBapWj0jXvQAAORp9tSVOKjQbm
4+WAbqrObkuJ4WFWa4m2RDWHC/d05DOdBsXkJCqX0KyLQfQ7UJOBx/mJYSNi1dNY
KDRJD2OgXoT27hVTgrOjkkHNBU375x7hS6U/mZUS0W/89nJEt86clBo67JHCseUB
V+hOvM/PNOIiYCMPiJA1X4xh8bUC+LNG0vyUEDeXLAw42ocABfNpJRKuH4VIcj4f
DzIQQFL7Vb8/0wlItzE6Urr2MCq4KkECXXH0Zfm7QhcADNQsuRQXZCTYMcb//0wf
A5H6ensrr+OnxN3Hs+TRcAQUChVXDGFM63sLrD3HBdh51XSDTzw=
=SFo4
-----END PGP SIGNATURE-----

--+0lDh32YORIWvLow--
