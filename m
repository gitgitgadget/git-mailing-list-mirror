Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACBD20309
	for <git@vger.kernel.org>; Fri, 10 May 2024 04:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315496; cv=none; b=n+C3jpeh1RGkr6y9y+/8XxzaZH8hiTXNU2KFx2LDXZWac5d7+z51gw3EWUNCmRE7gHG+Oa9HsoSuh5rbsr/OG5LUuJiKzVm67I0nt38si5zyIs7I/0D+3n4FuOOfK9iC7YaW1GipWkTa3KaPvbU1A4ZFP5Hg4URKrbtB2pXFMRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315496; c=relaxed/simple;
	bh=/riem3IETkP6DZsf7TLwOWtVLSAwQybe3y+H4cR3dv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HakFFAahx60cLpT4Bs9SOQNUBMn1/wOqsL5BEPOw/BwMbTm8dPyl1vYtO8xeV1BfFG7PPY9Wmyr+/qdkMxZF1xEAUh+YCmh+ZRovlYKgHZnmlVVPYgs+mR3gN/tSDDSG4SL3/QQbaya4YiLekrHXK7DWY1suJQBsGOTS5Od8Fng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H3QVK3Tx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BRYPyr/d; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H3QVK3Tx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BRYPyr/d"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 32807138012B;
	Fri, 10 May 2024 00:31:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 10 May 2024 00:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715315492; x=1715401892; bh=/riem3IETk
	P6DZsf7TLwOWtVLSAwQybe3y+H4cR3dv8=; b=H3QVK3TxfSiTPpHdtUnin13dYT
	RMKcRPRnf4FCHpsD4mrfihjpzOYDmr+t7YGkXuxHsrC2lE6z26XuOguGN8TQCHvY
	Lg4C9p/Hz/zgz7nnIWajixu8AC9Il4pnF4VfXwrUQLvn9R3sCkrNbqS6Wq46Z0rh
	VcNapTff5sHn8G9IAFo5XiIBkiLj9s9fwlEvdko2yCCQ3g1HPOQSSs7FQdVl5vMz
	RrJwEUvztTF+VSMdB0i0tnSmJOpUEEXCmPk1L0F3rTNuh7F16rod1YqO69Dn2Nzh
	DhaMG6sac27QDyVFMX0WAk+X76OPTSq+Ym/eQ6ZeXaCQtcIrl/QSmoEFfNeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715315492; x=1715401892; bh=/riem3IETkP6DZsf7TLwOWtVLSAw
	Qybe3y+H4cR3dv8=; b=BRYPyr/dY4oHV7m+vrM4EkIqoy4pOUIsHWLLk6kIaG7E
	K/AXvgs4R11SKhBQq3l2bin1X/xQkUOh6w31GovlPqus9H6aSabBCDvqE3L17Wb4
	zdbOhtMd9WGwAiUW1mQzlMBmvuS2rNwdF8odzHIhXrIsv7aqoTwmyG5YdYP3rZQH
	mGiwntP0FgIMzSKTLYuixY+fzvChk/sDhI+m7asXuIxNlQq+AV4m4wY3Z4k0IdEM
	b+7fctEU9ZOnZFYtmORnbq6Om8rV1Kn53mXR8aZkQrmV/CDhSGVtqPk3LEzQNngi
	q65Dv4ARTFSaEVOmHjRfBqr4g+M/5L1OpN7wWgRxmQ==
X-ME-Sender: <xms:I6M9ZpaNM0FzESy-0PAqgy-GR-pAUDC5ztedp--qIcPT7i-4AIE_gg>
    <xme:I6M9ZgYpZvbLzLbQy1ML3kRhP47FFINnKNg5uGVldF_kmq8CgpE8wDE73GTgYCWU6
    CEGWjQUOIIC_mcR9g>
X-ME-Received: <xmr:I6M9Zr8zQ6-ALmlNOJTyH9AZyxljIu_WkETFomvU4vr__gTN7aiEcvH4zxniVeGxJUBE1yEwW4ynm72Jx_7IXI9kj2KpG-qHfG30R3DwuAGNPqcGUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefiedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:JKM9ZnoOEpuUNIBPIv3CLVBVN-BkqHvb4TvwD558jz0vRVQhVYySqQ>
    <xmx:JKM9ZkqKbaCSscgiiOodBCjdsHGlmuzAN5BKWKmcvrnaf2M59RjmnA>
    <xmx:JKM9ZtT5AOJousF3zUR1A333gnDyC6jnxU8BrLYzEg62ryN_rtv3gQ>
    <xmx:JKM9Zspo7LQ2ps92yWkUoprisTqjYgGMpiizkn5mOtszY8JQDOKZew>
    <xmx:JKM9Zr3Wf2ZrB06njELSV0iY7nuXvu_2Kiqha6w-fpq2lzicLTkEkjl_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 00:31:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fb2c8dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 04:31:15 +0000 (UTC)
Date: Fri, 10 May 2024 06:31:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] ci: update coverity runs_on_pool reference
Message-ID: <Zj2jHXYBW-lUNXWT@tanuki>
References: <20240509161506.GA1707588@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pZzEo+kes6vgZpfq"
Content-Disposition: inline
In-Reply-To: <20240509161506.GA1707588@coredump.intra.peff.net>


--pZzEo+kes6vgZpfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 09, 2024 at 12:15:06PM -0400, Jeff King wrote:
> Commit 2d65e5b6a6 (ci: rename "runs_on_pool" to "distro", 2024-04-12)
> renamed this variable for the main CI workflow, as well as in the ci/
> scripts. Because the coverity workflow also relies on those scripts to
> install dependencies, it needs to be updated, too. Without this patch,
> the coverity build fails because we lack libcurl.

Ah, I missed that one. Thanks for the fix, which looks obviously good to
me!

Patrick

--pZzEo+kes6vgZpfq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY9oxgACgkQVbJhu7ck
PpTaYRAApawsH092CN1ZLynRQ1Xx2bzK3h2/GmctDmGjbhFZeJpuUye/duFRf5BP
vIOjc82V9iZffGmsaR/AKEUp1RgbtXpg7/YH5qINCarJirh6ibEXiWZ8kKeEMoth
Kyi1hqaVwAJnMZxtF4w62w47ddt8ZAzldidUr5Agw1iqaMOMkliTDOj0T9ZTXsed
+2o3t9xP9uJBsBUD5vhNqBgFP6x6s8INt5oyCwbSnW0pD5Rc+lpTNlAZQmv6LFvT
qNEdobCd7sloacB7AXeErQucafM31oRlF9s3SEMEiTAiZ3nq1S2cr/ZwclQp3jHj
caPrsoPu9oo58O4iAhEDGNpzJpJU3LQi1hFjdzxNF11MEO5Z8fuaqtFEwbH2Gwx+
9VhCAh7wAn1Ig3tyEySDefAb7vIWhjdGK6Iel3G8JeCwRrNYzV7VxHSTlNP/YnGH
rODk1P8MxKmsnGl6S9aUaDQ7N4xO0TJCbWWL2ONk+slRJUEaUjqXF3ufWmxs1lOa
K0PUsuds480jVgAKrhBvRNWn4Imgr8Lh0INyqvDLyJJcyzoxMsFX7UTgVUzcDb1l
t3W8el/BR/dBqZWesoHRJDMh2UpUWqYXpibWqp5D+aJi/0NnMqpIoPIAtpdvNtUr
4Rz9M5NlrU/RNWhTRuvyw3bOEszK2j5/ojkf6qn7rEtjbLV7g2I=
=Jcn5
-----END PGP SIGNATURE-----

--pZzEo+kes6vgZpfq--
