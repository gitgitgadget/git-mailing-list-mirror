Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0320D512
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708844998; cv=none; b=Ypoq4bPmTpoBTMQmmhtUl+uIIDbgEXrM2oSw1sYgLkdJ0h1ABa2RWt42bSRrw696h7mGShv2W/KefiK5HAWXIjTDmBcIn2q7eSiT67lnednJ0CS0KaQx5Fz7cwOeb7qLKtgLEfAsIj/cw5iSHKq+IB6cByEdiH9Ar+P5v8m9QlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708844998; c=relaxed/simple;
	bh=b1YpdyPyufgcMHab/WjX/Iy+ilxtlVljvBCRfPxca3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPeMpHg/3Gse43XRFn66Qnw1SC8AVzGjWmqCzQ+OwsbovQ6ltY2xPPpLj2mUflg72AdeEnmNj9PvsuYi7h/qVDsC3JiwPDlzHLWLQoJbLcwzF0UF4KB8lsxbzSA4gSV3qaX9ttPaXMRDAckr7lkoHXU/4BOdXZEkKC1KzdOhxc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PKF+h3vN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCkj6Ja7; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PKF+h3vN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCkj6Ja7"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id C6C195C0072;
	Sun, 25 Feb 2024 02:09:53 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 25 Feb 2024 02:09:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708844993; x=1708931393; bh=b1YpdyPyuf
	gcMHab/WjX/Iy+ilxtlVljvBCRfPxca3c=; b=PKF+h3vNaALcrbR3BLgZD9A29O
	3ZEE9fHZDQs0iR6rKs4aeq4j3BjLtUJPfMm4qoajPUvWfxh0gUxs5Xr71KCDxzv7
	RsPVVgnGKXvaT+QfQD7aWH3hJL1uJFEX5g/XV2oak54PRBDlN+v9D5ZxJbjh/EEG
	bfqWQyBXfpIpYBBjDEI6mnXcFc9It3Y4ECgTld1RFnuzMWQtKfGmpe91ZtKIjgcS
	+NoTqnSSr4lLTQmBXQG8RbwOeV0tCSMLQCoN8K5oqEAa4C4ALdhn+CQ4fjzxyj7L
	j7+IAuiWAoxraFfWtUA6ebWJBM77KWRpMZHWwkN9PKHS4AAirwu31pH2ycCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708844993; x=1708931393; bh=b1YpdyPyufgcMHab/WjX/Iy+ilxt
	lVljvBCRfPxca3c=; b=oCkj6Ja7G4XxvpQUWPljjEaCqean+MuBCaR38pHefZgQ
	oVqyzneyT4sczzcWjHh+P7B2atJSVT1eiRWLiwwFIEF/vdMK51cgf8RqByUdigSL
	+Ci/JznGvkUXwG7h6gdHuUpNZGVHhgN6lx38ohUA8a0WwYWHhYxr5xQxYigdyzbU
	hnEZdkC4/t6N30A9vf+kC/JrZZ24fBkJSiARFwTdSA2UI00aTIQzilYZ/61Z3xxl
	1EtIOpdH3MpureaBH/9fODkM2A4CVoVpIbs5wPaFl1AGgl8vnZm2xXNYkNJL+/MR
	qbWSXcS8jHK59xT/GYL1O5pbivvABQ5TU00ubZZbmw==
X-ME-Sender: <xms:wefaZf68OVL5iGmfXvsdZUZ0-8NnL-o03FdiTxjhZUG9-rVkK2HI-A>
    <xme:wefaZU7If6jj0Hv1gAOQVtSmdozbFyDn-z1PBH88mSrY7kOk4BohoSLnQq3PHRf6g
    14o3iVIaEfqS2Pv4w>
X-ME-Received: <xmr:wefaZWe1ps8OTITlexGLGBGEwNrJQ5p2jY-5JvMSTyCVVQhRzQiOeT_A-1amWM81GE6EPkevKmd1hewqwEo0xQfvQIVbSfscm1va7A7DUCtzgoUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeelgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wefaZQIzzQKKtLkT-N4BmpJsAR_C_hCObjhfRi7uiXc5jJ74byPKkg>
    <xmx:wefaZTJITov4-2bKS3vF_nPcqh6C5bDsN6ZWKSK9ExvcE8rhSczyfA>
    <xmx:wefaZZxFMBAxvISsrqFrGvr7RTffdPqxaWH7c6chlbi6tax8oL7gGw>
    <xmx:wefaZb1Cqep9BLMyg0-VTL7suVsltWniemVTxgfe-tSnjlex-4BXiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Feb 2024 02:09:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1a0dff1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 25 Feb 2024 07:05:38 +0000 (UTC)
Date: Sun, 25 Feb 2024 08:09:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <ZdrnvKRl8oGPJxOD@framework>
References: <xmqqbk87w164.fsf@gitster.g>
 <20240224051040.ftuo24smozqugbde@glandium.org>
 <ZdmOZRjJ-mClBR02@framework>
 <20240224195550.ignhzidmdy3ce6q4@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="skYHJWw+A1jf+H1z"
Content-Disposition: inline
In-Reply-To: <20240224195550.ignhzidmdy3ce6q4@glandium.org>


--skYHJWw+A1jf+H1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 04:55:50AM +0900, Mike Hommey wrote:
> On Sat, Feb 24, 2024 at 07:36:21AM +0100, Patrick Steinhardt wrote:
> > I have to wonder whether we ever
> > really specified what the environment of a remote helper should look
> > like when used during cloning. Conceptually it doesn't feel _wrong_ to
> > have a not-yet-initialized repo during clone.
>=20
> How about this: it should look like what you'd get from
> `git init $repo`.

The problem is that it can't. With git-init(1) you already know how the
repo should look like as you specify parameters like SHA1 vs SHA256 via
parameters. But with git-clone(1) it's a different story, as you only
learn about how the repo should look like _after_ you have connected to
the remote. And thus, after you have executed the remote helper.

This has never been a problem with the old "files" backend because it
does not encode the object format in the refdb. But the "reftable"
backend does, and thus we can only creat the refdb after we have learned
about the object format. Future refdb implementations are likely to do
similar things.

> > Another idea would be to simply pre-create HEAD regardless of the ref
> > format, pointing to an invalid ref "refs/heads/.invalid". This is the
> > same trick we use for the reftable backend, and should likely address
> > your issue.
>=20
> The interesting thing is that `git init $repo` does give you an invalid
> HEAD (and that's what would happen during git clone too), with either
> ```
> ref: refs/heads/master
> ```
> or
> ```
> ref: refs/heads/main
> ```
> depending on configuration.

HEAD in your example is not invalid, it's unborn. That's a difference
because creating the branch would succeed just fine. In the case of
"refs/heads/.invalid", creating the branch will fail because the ref
name would be refused.

With the reftable backend, we are forced to create HEAD exactly due to
the problem you have just encountered: a repo would not be discovered if
it did not exist. But its value shouldn't ever be read, because it is in
part of the reftables in "reftable/".

So as a safety mechanism, we want to make sure that the value of HEAD
cannot be interpreted like a "proper" ref. Clients that do not
understand the reftable format should not see a HEAD ref pointing to
"refs/heads/main" and then happily create or access such a branch.
That's why we want it to be an invalid ref.

That's ultimately the reason why I don't want HEAD to look like a proper
ref. But doing the "refs/heads/.invalid" workaround shouldn't be too bad,
I guess.

Patrick

--skYHJWw+A1jf+H1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXa57YACgkQVbJhu7ck
PpTnKQ/9HVMukwEQIIwkZXKAhebUKlJmVq7DiMEDJlPCKQW8xop6qYsiTlQktsVN
5L6rfTK9e+oGwGnC9SCAsVG61vozloLrJrWGRWffxc0XbkJEIZeMN4WVXUqzT8Wl
mTgkRIDX2eR68mPo4N8PwwieQXbRdnMeAeYWCUSIoTcny+TQr/eSDlpbMzKgdna4
luvZvdkXf4kbbLltz6nqVeW71JxGxys9wehdQmhsQzIR5EWgqLfq+2xeWPMCh3C3
kODYumr213ex5qARBcqXEckXdDfOt3ToQGtY7Zn3Lw+0cAX4SvIafVf6cxWKfCRq
PYKZEsQ7dRt6nSJjB9u67daJyjEjYGSHmzif2WFXzRzUUgjVa+6ndoMZ1xmdBGE+
jHthcaCKSIGMHuBZlF9RssA8BahOv/GtzyndeiYBBrf71K7BcDPttJ+kuTJDyr3B
W8NWXIWT1U2x7+TvK56R6w9MY5Lxt5ThmXeVCqJUo/ok4ArTRfhDuqnrYsNinVQx
ZIOwCNnzU+t4UStIMkBEkCMUoDQK2vfUjVS/XuL4c8t/WIm4cGC8l/F8DnA0d0nQ
Md2UQM4nsqBYuH0wdz/psclUws4UT0VVjh+pY/U3wvCdj8QyuGC8HvFluSNc3Li1
MWQb2ZWQ5gPtUqynMEXUAuT/mA07AU/AdQLHDdxznSAoMu6ucMw=
=c3g+
-----END PGP SIGNATURE-----

--skYHJWw+A1jf+H1z--
