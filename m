Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3B850264
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055915; cv=none; b=I1MHYK6KIr/IheMjf/9hiXiZBxztqqdSjMcohn+Vl2UFFOLDVU2n0vuC9oGbg9knuE8wS5r8R7iI16pQRdxSBYmTWPo1DtLi2hUjac08Mx7frWsGx/fsVo17xHcTo0QpqoABpbpoXJrSfvmmoP2rxx5ZPzlurYWNPckvfgLkllg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055915; c=relaxed/simple;
	bh=WWUO9TSVOdSI5o9B4g9bEdJsuoLpAlPOLXWau+/u0Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNF2AB0TMCQdEA8Mo5jFL0yVQK1bEfudh/OYCOFaQ12qMHvvGu2FxGv3fElI58fDiSkp6B4SnqH+CqSKT5Uk9SXJYBKtjI+kyeFKf8OZnnIztChgELL10AsE0Au7ekrRvprEMYramskc8nrTJhQjWLQAl9ZZ5zpsVSeMMKzcV9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gCpJ9im5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jw78ZWao; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gCpJ9im5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jw78ZWao"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8627B11400D3;
	Tue,  7 May 2024 00:25:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 07 May 2024 00:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715055912; x=1715142312; bh=xeKCi4hw9s
	l28lyJ6LBsL1ppD1Gmw7l6puJgZlO0iCc=; b=gCpJ9im5rbPeBgu9vjWJaIZn8L
	Gq0JNQNf/4y2vvZI4YSMfWNUxE1UUpEVMPazak15Nzvgi4cCKF3Yn85aja24xzGe
	6fGZvwU+UIoeowxnrPWjY4Dbapx3WLrypSoZ19E5a0DP53JCvWRlhZX98zYLnDfc
	6g0coABlNShuLyWdEM9souFETwuVf7TB7/yVQSBYuzLR3RwdqYoUinQFxNo3jnNo
	H7WPqApSr6+FHlEi99rbiokOQGUZ2tzTUMd64Vjdy8NUwVJFJXZeGFvs1jjNmlli
	57oG8rXvB6dcLMpuxhvFiGIiGxtBq5ESteD3fyjBx8+XKThnW0OYaQGPaMmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715055912; x=1715142312; bh=xeKCi4hw9sl28lyJ6LBsL1ppD1Gm
	w7l6puJgZlO0iCc=; b=jw78ZWao9hiULhlHzDti1mcExgqk3WBD3sI0MJabYusa
	l/PFp9vBet6MpA2Yt2g9DGd7wQzSjDUqHrBZMQ30r7xknwdC2C6re1pLq3P7k+/r
	tU4qUsA9Lrf794Sclqh97UvpmNECx7usJJ0dyyxUr/R/dGbFjKMO0DSUFTtvS7tg
	voe3L6eZ2EmBaE69Ac+5PFKdvt7YlZq2x6NakW1IVEE9SBAE4RZSQr+vaGl/+sxF
	AaBMOMtz5G6AorJu6myqzbXFzOqBK6D2j+3/k1HX2Vee/ltH7CHIftcIsuUgkIC9
	ZXcGjlFd6kcbuHVZEJTSvoSYzovbjiRyHg0UCHhAqQ==
X-ME-Sender: <xms:KK05Zlggto41NSxXc3AbeR3uZ5hjV5sK5dorCr58qsoWzj-N-trYgQ>
    <xme:KK05ZqDxsM3IAmuGECUzu-fII6XWueKSmZd9LVxNcysQv8kgHJ-GnYZJM4C7zHOgR
    8xph3ge7Wp-Kge8_g>
X-ME-Received: <xmr:KK05ZlH5TAQn63Cg6Sus4qEtuYfgbg3IoMBGG9H2N_n2K7p6qsoNv0uFiRhYi8-qxs8ZBVY9dcUrWLN-5lp1Blrq3TbU02tjjafpURK0N4BauD4nkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KK05ZqRZVFYoMHcJep2EsV0a4qQ7_yydNiBc4OQtlSdd5LGfTZUAmA>
    <xmx:KK05ZixH56Fuj2ea4PPKO8ySpunYKR7huk6temgU4Kcpm_PASFsPWA>
    <xmx:KK05Zg5y4f4x9HcgrmDZmG_LyeLUr8_BGd3oxZQyb1Hh-DQe3-Rf2A>
    <xmx:KK05Zny1-83RYVj8p1LXj6Oewsnp2iwTMixOZWoXU9Uqyb-V63zJ_Q>
    <xmx:KK05Zm_LlPQ-aJrbEMfJJwXYNOBcycqrF_j3IQtT_51mVXSAg4wA-1KG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:25:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4d4f6843 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:25:03 +0000 (UTC)
Date: Tue, 7 May 2024 06:25:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Feature request: secondary index by path fragment
Message-ID: <ZjmtJFF7rv7B8Nhj@tanuki>
References: <robbat2-20240506T225759-090424131Z@orbis-terrarum.net>
 <xmqqttjawmos.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9Sf3HOSWmwmt8dIK"
Content-Disposition: inline
In-Reply-To: <xmqqttjawmos.fsf@gitster.g>


--9Sf3HOSWmwmt8dIK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 04:22:11PM -0700, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>=20
> > Gentoo has some tooling that boils down to repeated runs of 'git log --=
 somepath/'
> > via cgit as well as other shell tooling.
> > ...
> > I was wondering if Git could gain a secondary index of commits, based on
> > path prefixes, that would speed up the 'git log' run.
>=20
> Perhaps the bloom filters are good fit for the use case?

Yes, Bloom filters are the first thing that pop into my mind here as
they are exactly designed to solve this problem. So if you rewrite your
commit graphs with `git commit-graph write --changed-paths --reachable`
you should hopefully see a significant speedup.

It does surface some a usability issues though:

  - There is no easy way to enable the computation of bloom filters via
    configuration, to the best of my knowledge.

  - How would a non-Git-expert know?

It makes me wonder whether we can maybe enable generation of Bloom
filters by default. The biggest downside is of course that writing
commit graphs becomes slower. But that should happen in the background
for normal users anyway, and most forges probably hand-roll maintenance
and thus wouldn't care.

Is there any other thing I'm missing why those are not written by
default?

Patrick

--9Sf3HOSWmwmt8dIK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5rSMACgkQVbJhu7ck
PpQ3nA/+MVt+jbiMF7Fd2SKxXph4cmUDl0JAfkmoMCP1tMeg368RWtXwZ0/kg20G
iJQ9V2bg1ri/bDsDlx2y1z3djVOXV9VIp2T4qstqNiHyx6dRJDUYkb3SzS4UO0Gj
bKCOicXEZG4JG9o7x+Qwx8fjm+I82GcmGRGh0aIED7804F4f6C/IevdiDReebiQz
ot29Jyq6ItebBYM9BrjdaBpcZSparN03Ly1BnMz5ZqxEgPzjEqY8QZOqLZ8PQN1s
kkMYG9nLB5FTZIThFYpIcJOdVU0a05MEVpkIBgyX5yTTHOIYBpC71sSBuF0ws1N8
uVc7cWxQ6Ntaddt6AEAevHA+2q8LQ1PzFmcYkEkbSqVio6ooNt6OA45b6aT0Xqxm
JjoR0seYfrUX0lcn1U7t8EF+dTaIWHZ5Q1am+Q9MlFBFcfL1BiWrQCNpdY/l4a19
xtru1h6Z59HxXvPhqR313J+Mj5WNuyD3IFqPWOxeJMBzLr/jqB39eHgzQumDOzSP
fdZgr0rDXQWEO4M83oi8cg1hIgcjyIAMEc7De31eNiq3VknqOkrv3B5/UN6mFiYk
ceQrec36yRlRBf6AYbyRjQ52fppDy/HqVGNErsMzHSIMTYvKuc77nQ4I+xUH7qeO
h+u0dzGNQ2265xwF+sjwhPeHbfUoGvy0yB3085lShzo+YHOyYFY=
=5oRc
-----END PGP SIGNATURE-----

--9Sf3HOSWmwmt8dIK--
