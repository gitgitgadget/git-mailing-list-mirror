Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF8BA27
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476952; cv=none; b=Bd+dLuDicUpSLxcczKuWWFptf+1qRn07naXil7lqNRmXFog7LqYKU+vSLqbQT9cb/HHma3Nd+qFG5LGPe/TexfeRwGcKbE5E/qmP4rgWmT2z0VkzEQdttFczf3O4SvL/5f4i4FaBVWUcQ/aQyK6iVRQY4Ew32j5KC+XtTUEXdCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476952; c=relaxed/simple;
	bh=zJByQ+4B9lLP9m4lY77j7B8P2NsK8XN+aOHZletqv28=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=ewVi1uKGF4s1jOvbdBpu1NwpCVlLpUifIldlQPsO+VJfJl6c69hcHOnq9L1BZ7MKnh1HGP3d3Lkq+qECNsJ3DiZW2Ssh4SObLNn0jHjoBqKV8m/XqTUB441TDWLQqk6Q4EbrOgAwun221jtX2I92/AO2aux/h6WpMx8I87i9mSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XNyD40v2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bW6VXTeM; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XNyD40v2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bW6VXTeM"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 342A23200AC1;
	Wed, 17 Jan 2024 02:35:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 17 Jan 2024 02:35:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705476949; x=1705563349; bh=EcKsGydQDA
	hAtxZVIyyxriqCEFEuULjJUBy+Z2Jtt/g=; b=XNyD40v2LZLxONH4aBhJMd+ttI
	FIJlfefUsk76KkG2V/Y6ZhydTOouU9UXY3bCw4dsEiDaoU1kBktbyVwraFUiKE7o
	xgxUCs2g22Ty7HyRIzFdZ7lZL6mt3OuOE/tk5p3gPZB4oVWhw+4Q7qDXaAkl1W5W
	51hTge8ocBxcvwPJj6RvCdRV/aZ4NWBfDYs6PfaPwAo7fxbUSXZ2iGHsGfyXyJKn
	takrqliPvgtESw9XMgrmn9JS0uWetcNvhYvlw+q82JITuI4zuCb+Xe4g/7vSXV/V
	nRuBNer4ntk9KHM4EqGbNMzeBhfPhmNs3X4tKpuebkx9Hq/STctbjUBblv/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705476949; x=1705563349; bh=EcKsGydQDAhAtxZVIyyxriqCEFEu
	ULjJUBy+Z2Jtt/g=; b=bW6VXTeMk4XFBvPeNxnbCNT2dRy++ahz/gi6cm2Pj0Dg
	g4AD2S74n3+nQ6PiEpwAh8U6lmp4O71zz0WaRZCkTVo29wve/G398ks7wyGJyyMY
	kSkQM1tvCNcZ5fC3qz27+3uOVzoFEyMuNprLUKBHYAMMKVdWy4nTFXfVJRSfYZ+r
	Ab/4Lnl1kwbLbYnofwNT3143RQh2r2pv9lmp0ZEnJewYZlDfMV9UY7Zn+D8Rnh5S
	MZ5ZZgd1bKvnDZyfXxsQGbcJ1HWVFeBqDcLtFC/klXy8UL0py35ub91WMilFAcGq
	NPYgD/9Myz0dDt2L9xSlLfDQtyCG1bb/jQraVE4wIQ==
X-ME-Sender: <xms:UoOnZctHeipJ1-qHIdNAjGXzEay6PZh0ADv3Qs-4F54L7PAxeCz4Pg>
    <xme:UoOnZZcPq3Pn0cE6TFjPQAqFeG0LK3czate0NFU0I9nbUQ078PpxOCBrzs5Y-4XVw
    J-FEvjzgh3IHhV-FQ>
X-ME-Received: <xmr:UoOnZXylazhcm1MjTeyR4ofuIqM5RUwkHQncNbeATX-cseIpD5-XWKR5VBgAF3yFMtMldsaKrsW_0EKsKN2Ot_-nGjTyI_M3RtBYBqmflCNkdDhzKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejgedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UoOnZfNJthcu-elCvty9lvQsVC378H47umoKa_abOgXpDSyB-aO1aQ>
    <xmx:UoOnZc-SVQGVNMAKrH9b1NMU5ekkffwY3fsVkeSrxMJOnVYU0VLYHg>
    <xmx:UoOnZXUYEM0lr8ju9RO7xxOQjt8v_p33ogvfM9NhXp6_4llPNdQZaQ>
    <xmx:VYOnZRF24TgJNPro0VRRvEG0l56X6mmCyXzR6T0-tWlCWik1RgsTgg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 02:35:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dbbcf148 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Jan 2024 07:31:37 +0000 (UTC)
Date: Wed, 17 Jan 2024 08:34:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/3] ci: add macOS jobs to GitLab CI
Message-ID: <ZaeDBO_8-WONiV0l@tanuki>
References: <cover.1705318985.git.ps@pks.im>
 <d196cfd9d01fe3b52c75a1e4e0aca9f67567ab43.1705318985.git.ps@pks.im>
 <61115e68-3d63-4e08-85f7-ae6650f3724e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2Dgv9f43aYwbqMwk"
Content-Disposition: inline
In-Reply-To: <61115e68-3d63-4e08-85f7-ae6650f3724e@gmail.com>


--2Dgv9f43aYwbqMwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 02:58:53PM +0000, Phillip Wood wrote:
> Hi Patrick
>=20
> On 15/01/2024 11:45, Patrick Steinhardt wrote:
> > Add two macOS-based jobs to GitLab CI, one for Clang and one for GCC.
>=20
> This doesn't match whats in the rest of the commit message where you expl=
ain
> why there is no gcc job. The patch itself looks good to me and it is nice
> that we'll now be testing on arm64 with the GitLab runners.

Oops. In my first iterations I still had an osx-gcc job, but I could not
get it passing due to the architectural difficulties explained in the
message, so I ended up removing it. This sentence is thus a leftover
=66rom previous iterations.

> > This matches equivalent jobs we have for GitHub Workflows, except that
> > we use macOS 14 instead of macOS 13.
> >=20
> > Note that one test marked as `test_must_fail` is surprisingly passing:
> >=20
> >    t7815-grep-binary.sh                             (Wstat: 0 Tests: 22=
 Failed: 0)
> >      TODO passed:   12
> >=20
> > This seems to boil down to an unexpected difference in how regcomp(1)
>=20
> nit: regcomp(3)?

Indeed, thanks!

Patrick

--2Dgv9f43aYwbqMwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWngwMACgkQVbJhu7ck
PpQHWA//QMXvyHPUv6YNZ5BDZ+PsQ3T3pIt6sov+eqC3bzpRoEgrT/JuUJxx8Cda
k52zLVg4ta2W/s1cH7f9FROJzqum0YvbhAJrV4e+wI64w4Nt9siVx0+8qtba6jP1
bLkBXjAtAPJInwc1Obwiev9zxqrg3HI/qqUYRoQyaMzu7ESWUhWzc2sk0TlrmBhA
GlAo4DQx6YThdCa0KN1N6hxGA09vBOKKP2mq30QHOj7l4k5y+Pij1QWVZaqMMmhK
kYOBz5KMF3rQoyV91VRPSSxX55HVx/9s9Wjf7V8XGGn9oUn3FfN25msMM+K36Z3r
AKbwzYCGTeufkJeTtuwC8gE9jO5QkeDpl1psm2EAtiwLb4uMgkuKqdHY5264ayZy
ebDblW3+71oP2U94tA35vDj38qAWQNWy8/fkt2oblMQsxEyqBda6rTo+xC/jhBq+
Ui1jhBZ+nm84TwcriiAg/4AwYsZUG8YR7LgERvLZOd9FDJSgcVzvvDh0Orii8vhb
0EIL63i4ubxZ+c/nlTGrTO79mRo8qvg07GDrB8x8otfaBUPs2K0dbFiPcK1pMJin
ATEWYHXCRWzIFzTLNz6Jap7hs+YRvV4FtpCGdy/5moz00jWCKkYSFJCcMwG0z/mb
Pp9HT1uSLZHLuUVuI7WlHwX38elCIHxegmIznFu8XOk/YSUDNGM=
=juka
-----END PGP SIGNATURE-----

--2Dgv9f43aYwbqMwk--
