Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C98A2F50
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 05:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723093528; cv=none; b=ITKTSdQvpx02gUUcXNHfwryYnUrTFP5MzPj/7DNhSetgCVErnzpgzwlazVzODXwDgKfV4gqeXCAXYtYkSeCGIhBSPgS8vLZiubt4J06K/1w2GqZomIkIBeo3x+69kkY/P/RZXhdb4SNSRJMbdjwGMgC+7pD4yA3I36a19cuTSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723093528; c=relaxed/simple;
	bh=r9fKhFxVc9wASN+q+kEEEJpWEV886Sf6CtnZXUX+CBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aU2PQxXzez5GWhaM82+G8mbtpUbuJ/x+1m9Q/FREOCoUlaiseg6dYiMEfy17depGR/tIJcU5W25hZJsT+J0adNEynkahqWH+9Xz/p0tnTAzgDbLyA1tkoKXFxCYCSO0n2gDkB56C8PDPQ0z8FsnSbrQHg/3dAIMHo+oN1S13rcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NKBNQ0V0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gbzRNX25; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NKBNQ0V0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gbzRNX25"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8495F138FD8B;
	Thu,  8 Aug 2024 01:05:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 08 Aug 2024 01:05:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723093526; x=1723179926; bh=r9fKhFxVc9
	wASN+q+kEEEJpWEV886Sf6CtnZXUX+CBo=; b=NKBNQ0V0j76dnct0HHAV27kTYG
	JuTBElfWuJH3PuHPO+AGjMMjGpdko01sYX+q9vr2zX4AqYl6mXF5vGZcndGZV2ke
	hKSLBX0WzfDDhw05f7mV652t/QFHOp4OILNhZEn5xiraD5trjfawaeSjpA0C2Ac+
	1cUvNGEbwoklf0kzTTXpipwqbF6OBzb01Haj8Fk5BsrqxBz7kfz+FJy4taTJ3z62
	8srCYus5SQ5wrb2tSuuLzTkj68dDu3OEP0VukUBFFvZT7dIHgXGHciBNljT/zRpt
	7DtMOAZoOJNFuoDGUwi+IVhyyMFrjlnTwAMBjXZB6GwKlgTvvKol28lb0mQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723093526; x=1723179926; bh=r9fKhFxVc9wASN+q+kEEEJpWEV88
	6Sf6CtnZXUX+CBo=; b=gbzRNX253IoGUTPknJDxxmo/+urMG8K+V9v96eGG/AGW
	h6abs6iYX7H7LK1ujsg0S9i9jHYJ0BwSFT9wWZWmDfaFSVBJt2GUHxpQa6SfSVK8
	CvFWZV71iVRBiXdrDCI6u6NcVC+w39mxNtPQWTt3aKVV6V759wU5KS044w42OrdG
	MIJWjzCqK6TcC4yWB/VFoxhnY7O4J3b5ivi4GxWHQREXC4pMmAlaDHaCNO41EoYi
	3zH2t5ZRkq19d+L341rTe+dVG4G0dERlGI3OSb4BdGyfYPensR9JTbBEGBq0Cj6s
	0IJWLB691/HuG0Al/O04ORkoZyz5RDokJLf9sYxyfw==
X-ME-Sender: <xms:FlK0ZiWDUwpFWZkXn1Zos0WI1P1AX8JD9MzejlVIYY330ynDuIGVhQ>
    <xme:FlK0ZukwdLEe9pZhNBv5ix9OOOIs4JfgWTayAVrwJE029_izydc4CDhE8O8b53doJ
    MmoZOnGjpir9ay7lw>
X-ME-Received: <xmr:FlK0ZmaBlg51L7l1fpfKalHge6iDGzG89WvqR0nCYPAl6mL-vxFOby8GE8iHic-icIhbiLEy9MyRylvx-1u5Wk9tJ87D8OlXeheDZPZpoKSkDJTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:FlK0ZpUoQnERiRgkzunpDakBkguD08NdvaV_lRr2FywMiy_5tDQU0w>
    <xmx:FlK0ZsnpQIXsoLlNb39O4rBv6GAVRwBmA6zQgaj2BOyWiED77cjbQA>
    <xmx:FlK0Zue84GIwxbC28K6O9Zr4MEh6Y-uURS7ZvMChj1k4X_rEOaCzxQ>
    <xmx:FlK0ZuGJ-ex9CsfzZ57WTxtNrU3zELNJwvNfD-IYE65kNyYwpW4toA>
    <xmx:FlK0ZhwHatxuQICYObL3Rh7PItQiy7yXo7tA8VsAzgf14jLq_oxul6fu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 01:05:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c8ae0c5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 05:05:19 +0000 (UTC)
Date: Thu, 8 Aug 2024 07:05:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/22] Memory leak fixes (pt.4)
Message-ID: <ZrRSE0etqno-yFiE@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <D39KMJ3FXBZC.7S74VUTPEQHY@jamesliu.io>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IS/YwfUo1tKVbxLF"
Content-Disposition: inline
In-Reply-To: <D39KMJ3FXBZC.7S74VUTPEQHY@jamesliu.io>


--IS/YwfUo1tKVbxLF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 07:27:32PM +1000, James Liu wrote:
> On Tue Aug 6, 2024 at 6:59 PM AEST, Patrick Steinhardt wrote:
> > Hi,
> >
> > the third set of memory leak fixes was merged to `next`, so this is the
> > next part of more or less random memory leak fixes all over the place.
> > With this series, we're at ~155 leaking test suites. Naturally, I've
> > already got v5 in the pipeline, which brings us down to ~120.
> >
> > The series is built on top of 406f326d27 (The second batch, 2024-08-01)
> > with ps/leakfixes-part-3 at f30bfafcd4 (commit-reach: fix trivial memory
> > leak when computing reachability, 2024-08-01) merged into it.
> >
> > Thanks!
> >
> > Patrick
>=20
> Thanks Patrick, most of these fixes make sense to me! I appreciate that
> even the minor changes are accompanied by context.

Thanks for your review!

Patrick

--IS/YwfUo1tKVbxLF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0UhIACgkQVbJhu7ck
PpSPPRAAgsE3LsyyxUNUSlgvWox+3P5fmneuG9kofT0upvSeeY109Je1SKTRSKRz
qmR2jgoCw2fSPUzG1HJzxqps/dwQdePZounJmZGmMjxc4SExVHX9Ln1vUrAx7cmp
sm15rkdYzJL6OjrvC3fNB+RNHwSXeL8kFtobWn5+4gOrc/B3FkAA2jy6AOnNMHGk
zFB9XAelxRa7LKwby2pGiOX0cNul9K/tSL35O8AIZvlD+OZaZKgaZyOGACtRRRz7
9nGUfArFeit2LcW80vAuw28hcQsHM9FmutKKjJR655IEQfIu+uxif5spWlu7gbyW
Rc5jijvAeOFxzHjtD+OszOzrgs3VfeKkGgFDQMjVsWDpHktTK+EQ7v1r6ARBJkIh
xWLo6vgMuUKVYLP7WISGfd9sWpjOTfrrn/+K4enCE+kKMnF+2CwNEYOOSdWNtXmw
gxQMYE0PQksTRZ7MoXaLWNcci8nZq/1i0CEGOvdu7k826EoIiyJGOBonXd0cykAs
bv6KvC8Iq0kSEnECUWoV1C+i8WLTeCs+WiLpP24qciJuIiEYVQug35sfRGVSKPm5
QS2jcfcbR9711S7ayeX9I26w95eiemCScnPnqb1+eGwNgXQKid2MsTl7Gmx0KjWX
FyWwAMyL1CF6StgE/DvM7WLLPQYR0SmPL9C01dO6CGW3tgiO9HM=
=iHjP
-----END PGP SIGNATURE-----

--IS/YwfUo1tKVbxLF--
