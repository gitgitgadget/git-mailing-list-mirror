Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2F9846D
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 08:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707466112; cv=none; b=PcNnuCeSRqsA2jlcfMYeEIEHo3keyglRiNrJdJEpPfVNqsWhQl/W/nGCwZlBSDyiExtetirXLikjEid6RkhbVtZKfxZtqxgbLaf5WHEE3U7k6mykFRTxfmNL6qWAR7mkWlOWHPh4E4rbnpc7tvASPhw5w9n7M00cETum1HxMRvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707466112; c=relaxed/simple;
	bh=rfi1xktKj5OBx9NmkHwFcraHU0BYdZ5zozLNAucfHBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WK9lmCl7u5YaL0pXz2TFQzRbNuIwRYVpqus6U1yWA9EKuJTyNkjR3fBDxS0D9HFzLRuKWO9YvZ3jKJJ1ArXMbvrW6NApuy1XcDDBap0PI2wrXaXbP/vgBQh7fpQ4omWEjtK4nyfazfROrmZ/tA2FErPh7hyGRiYj88KQgvKdAaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LMDvI+JK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IGIEzFgZ; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LMDvI+JK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IGIEzFgZ"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8E0BB1800073;
	Fri,  9 Feb 2024 03:08:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 09 Feb 2024 03:08:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707466108; x=1707552508; bh=X+bwr6L59i
	mE5JIVKBuaIGI4BTZG/ir7kLxA2E0Q7Og=; b=LMDvI+JKkyPVFEHJs0/VcgS3ll
	u4O9Bo2AzQFAY6p0jeou1Z3ZA/7A04mHlQ+DWuSPx0b6XgWNXkSzedZ77rIhEDTK
	qWufB7ELEtkot0fiPoNx31r22BPa2/w9lWcSM9qtph56pwO86c01GfAAAU1qL1WC
	KS11QhJn7TwzXRLGjgRmpn7FZLmazAKzxb+VJyPXorEJ2N6rsan+e6N0M+4BhXen
	10xQRFN4ZKpac877PIXAU1meLYNxTseozPJNKjAFO4erR7aIvFcRpeL/YtCYTJz4
	Y48j3CGkfgAp2Zmwkt3wjwSIPKhuEazlKloTedANjxauCYrWNiMfWteAYU2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707466108; x=1707552508; bh=X+bwr6L59imE5JIVKBuaIGI4BTZG
	/ir7kLxA2E0Q7Og=; b=IGIEzFgZ3Qc4WAGVbUUXpueH9LIGHDPTEZk4oLF72eLT
	6B4OSpVD9vGJSm/x1Z6LZOnO2HxJR95gfWM8fvwwWKpG3uJqRopR0kKTYBupsw7H
	Ezqtw6bxiz+Q+GNclt5JWp9IjXSQo6uJ+WCs0WHzkgpAzQhXGA9yVWOGRQ8O5k24
	C3BxZVSM3FntimQMSnufQnOUAUcorkWtmDy2s/KjieaIbEFweX7bUUG2DXoHl1Xt
	DknGFNxM0/w9j8f0jJFJMXfLqUGozJiK0MJSuhUgklkXW/7nIDmRRyETtyRI/Wog
	v782h7Iaw2jwLYP/UqwqJLNqTmEUBUZS0uC7dquZcA==
X-ME-Sender: <xms:e93FZeI9F2dpw4hB1es3BbkWQR9IyKPoyaazUJcydttL1wmdRG1EZQ>
    <xme:e93FZWKBzBbvM1v3_F9p3rLER5wD3iWSSEB1g7NfgN0_IYUCcDOQBx--KwrC8X9vo
    3VYBhTgbXRPtUdtGg>
X-ME-Received: <xmr:e93FZet6CatVR_C8nSY9gm1x3-BASo2iq_Ac0f7bd7HbgiseivS47waondKAvGToWAwznz_MTJM8URHXZvTN4UHuUmJFD2TwrXwLVABbGrdODxo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:e93FZTbk_7ZMRSJeQ8vZmbWtlV3xNXfj-qW8l3THzNIqjO_49aCZXQ>
    <xmx:e93FZVZzCES5mPIpnPKWzFXJGo_F42WFLXhsXj537QThoykktI3-wA>
    <xmx:e93FZfD7ZvexoDU3BD-IFVnYOql04ZBKu7uL14gy0tZi0AvROcqyiA>
    <xmx:fN3FZYz_zaUwEnZKtKYpJPaTuk6By7Sov8KJVObIrR1CdMGxBMPspWXLn5g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Feb 2024 03:08:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8c77077 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Feb 2024 08:04:48 +0000 (UTC)
Date: Fri, 9 Feb 2024 09:08:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: [PATCH v3 4/4] for-each-ref: avoid filtering on empty pattern
Message-ID: <ZcXddvQzlt6j7T7L@tanuki>
References: <xmqqcyt9fdc7.fsf@gitster.g>
 <CAOLa=ZRcWYmEYnxh_=ykOerahZ61xaanLCj_JHHLvtrvN=Xs-w@mail.gmail.com>
 <xmqq1q9oe029.fsf@gitster.g>
 <CAOLa=ZQzz7_L_9cBmK+pgFwd_DFqfWDVRiaZMAxU+54kBq6Pcw@mail.gmail.com>
 <xmqq1q9ocje3.fsf@gitster.g>
 <CAOLa=ZQaXxwrXmbmFvGR59EDo3Eqa-Xfc3OG9+6ES-veDU8Bhg@mail.gmail.com>
 <ZcSVx4slikt4xB3D@tanuki>
 <xmqq7cjeq43t.fsf@gitster.g>
 <ZcUOP_rWUwymhe5c@ncase>
 <xmqq34u2onaj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SD9yQVqnDkvfyZCZ"
Content-Disposition: inline
In-Reply-To: <xmqq34u2onaj.fsf@gitster.g>


--SD9yQVqnDkvfyZCZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 09:53:24AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > As I said -- this is a bug, and I agree that it shouldn't happen. But
> > bugs happen, and especially with the new reftable format I expect them
> > to happen. What I look for in this context is to create the tools to fix
> > problems like this, but `--include-root-refs` doesn't. A flag that
> > unconditionally returns all refs, regardless of whether they have a bad
> > name or not, does address the issue. Think of it of more of a debugging
> > tool.
>=20
> OK, "--include-all-refs" would be fine.  And without bugs there
> should not be a difference.
>=20
> Where does "all refs in this worktree" you mentioned fit in this
> picture?  Should a bogus "ref/foo/bar" be considered to be worktree
> specific, or is it an incorrect attempt to create a ref that is
> specific to 'foo' worktree that is not the current one and be
> filtered out?

Good question indeed. The reason I said "all refs in this worktree" is
mostly that I don't think we should also be returning refs from other
worktrees. I consider their refdbs to be separate refdbs, even though it
is possible to access them via the special "worktrees/$wt/refs" syntax.
So I would say that such an option should return all refs of the current
worktree's refdb, plus the common worktree refs.

Another important question here is how the "files" backend should behave
with such a flag. Should it try to read all loose files as refs and
return those which just happen to look like one? That feels really wrong
to me, as we would now have to special case those namespaces where we
know that it's not a proper ref, like "worktrees/", "rebase-apply/" and
others.

The alternative would be to make it behave like `--include-root-refs`,
where we do a best effort and live with the fact that the "files"
backend cannot enumerate all refs it has created. This would mean that
behaviour between the "files" and "reftable" backend is diverging though
because the latter can trivially figure out all refs it contains. The
question is whether we are fine with that or not.

Depending on the answer, I think we can go one of two ways:

  - Accept the diverging behaviour and add `--include-all-refs`. The
    "files" backend does a best effort and only includes root refs, the
    "reftable" backend lists all refs.

  - Double down on the fact that refs must either be pseudo refs or
    start with "refs/" and treat any ref that doesn't fit this bill as
    corrupted. The consequence here would be that we instead go with
    `--include-root-refs` that can be implemented the same for both
    backends. In addition, we add checks to git-fsck(1) to surface and
    flag refs with bogus names for the "reftable" backend.

While I seem to have convinced you that `--include-all-refs` might not
be a bad idea after all, you have convinced me by now that the second
option would be preferable. I'd be okay with either of these options as
both of them address the issue at hand.

Patrick

--SD9yQVqnDkvfyZCZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF3XUACgkQVbJhu7ck
PpRZMA//beCeU6z0VEeePZWVw9AQykyGYJ6tzC3yLgo0WDNqIZa/TplIkmgBM/yZ
emGWgj/1VmO2EEymVP1iDNNwxEEnGTqpC8ppEGxMVSRTllK9FQcVWpQt7yvg4c73
ESSrqePhp4lvEqiFcvRIJca6bpVmcXs6t/PxogtSEyS2Jf+pHyh9T02mlTZqQwDc
vPc3dcqp0j+8cedl2DQCgC2g8sjyrkinBdJzyLVyKV0JAYjM0fCBi6ThSZ/Eofzk
0MMPNmWRHuf7uZt+6t6KPWaTE20YEeFZ1PEq0m82kb8qjhLRlpEo50L/BOCM8Cor
Q2KYBny0XXUgt2wvtYFYsXfLzysVM02qAclRNITaa+u9OnkRcGq2Gimxd6CX4tMx
Ss80YK8Sbp1smSplHScc5NUhCYoISSrpl0pM/GRYZ+DGVPfZhSfI9v4z3rUAjK7V
WzAgb1KauquxwP8OApx8xOY6jBzSrlfHdOdBzvXYPgrXTconC2yB3dBLm1u92SeO
RD8PZVzD53G31zZZFsOGDv/8VquwyFdmSc0AZUzSn2LKPOoO2OAMlfln8DSsiq++
e0g0txkmmzZJkkxanurPNVsViQ0e22a5w9vQxLF5ySbjfcpkKgv1ckhc19RZfhzE
M39Oyu50Fk5Un0aFoskA61ztA425AWmp7vJxq0HoyV+jLwzAock=
=ssbI
-----END PGP SIGNATURE-----

--SD9yQVqnDkvfyZCZ--
