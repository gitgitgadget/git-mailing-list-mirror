Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BB200A5
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 07:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291770; cv=none; b=JEy+jThLKrqKqtxFyR6PZy308zQ1wE3VVW19ICMqz60k2pOss1HaY1Ck9uDTaWBqF8vhyeSeWv5FVB6WfcFKpD1/xSOW/cO/hUufxSTY2traStmi96kXDlchFC7r3AQljlJcmLMDQBsJbQVD22BXztEaeumWRL/svgXNzO6Oa3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291770; c=relaxed/simple;
	bh=fwY2ryeMCYszMXtofC6YuyTcDL25JFTWJXPgA0UASQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd2ZLDyPvREct0mRV39LWcpgn5CI9p+3qWz5JEkj1bwrYDYc6ZDxNUb+oPVedu27eAxlw69/zpBmkUjLQiu/7B2I3xz+Ohdj1DEpt+u9fCxs6aLHyhKchfgEv0wPXZnDKr5rMGaqRGlDdzCQq6yhsSRY7VwOufrlus6v4V1sEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cMR5pisD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yvtcl4bt; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cMR5pisD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yvtcl4bt"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 93F315C012E;
	Wed,  7 Feb 2024 02:42:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 07 Feb 2024 02:42:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707291768; x=1707378168; bh=fwY2ryeMCY
	szMXtofC6YuyTcDL25JFTWJXPgA0UASQw=; b=cMR5pisD74mEFqHH5ytqwO4LYQ
	9biSnfrTizsmAhyLTld5IuqhHwP5zlZyTAipI0nVBvLUJW7M1ZYQIBbj63/1VHPF
	e81zP0QlZpO4Lt2cDQjjFwajz9cVQZWsdjO3mw/KsZcftmdrppk9Y64eQ5xvGJdt
	jMWlIoli3qZXXZKeSruxCqQNhRSEbts/YYvYKkKx3VaZkZcda4ETdNP7GPZqB0U6
	kXC1saCvfp6qJcCoygP/QECb3jp3E+86Dxuo3UmwJMP++6dSaHJ/svApUg4fm62V
	S78GbVl7krmTUH4SboG67L4U4G3XgJdJbBQLLN6EoChOE+eqrtuJl7shFSDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707291768; x=1707378168; bh=fwY2ryeMCYszMXtofC6YuyTcDL25
	JFTWJXPgA0UASQw=; b=Yvtcl4btzqJsBYw9GFIQkeeOkSQmA6kHwAIUx0Hf08M7
	Wf0FgJgYWCp2SpJyUQC5WmtZcSI2ldz5ElU2y10TrM2lhwciQdeeT1JzwgwhDciA
	WIsLYI3gzi00lvPqFlMJbpnlrXDFxzxrmYXYEo2NKddKpzMoFZ9hCDBSwKqY5NzW
	b8LyDtSrNximbhzbrlJz11l2CxlM/6b0xFKnoSoRkzhD9RJXvbBjV1tTRLyfoGpe
	HKiTIIgShQZLpmtOZ8INWLu2+TOMLPMFtq89M4vvnrWkDniKxxob1sLGwoedw2MZ
	PQZd5wZfCaTp202HrgSNBCHrZOIfmhFphzIzfupcwA==
X-ME-Sender: <xms:eDTDZWlB69D_d5FRij9RJFIcxOr8fpL4ol1-yYyKDr6zWypSCH550Q>
    <xme:eDTDZd1LsfNcBGmQQhDGinlZrBc-jxSO906PpCcBIlI3JdkkftnZgQE__x2amRTrV
    YP7t0MUK89Uu29UiA>
X-ME-Received: <xmr:eDTDZUozwpmxHrRAJxvtR8cadP5bi16w1qLJD-GrOMisSIrpcGmmzjx6MuTHywToT-jBwnKecpJqvHfC5xLRZAUMGNoHiFCdSZqK-fHKZhjZDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eDTDZam-36pt8WsHrz94NpGBjWOaMA6XblA2fj_7s7XhifEdUc927w>
    <xmx:eDTDZU3In1R1i8Y5WHZ0rjSSwCa7cVWLu01N938hf7MYL9MfUqmLgw>
    <xmx:eDTDZRsT4IP5vfksqVIG2p9cXz-XGh6NZbb19bB4eaYUz-HieukU8g>
    <xmx:eDTDZSCy7KiLcYMkG51J4KKrEWRLXKk2O1kXIm-yI3cX1QsFf05i8g>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 02:42:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d045b935 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Feb 2024 07:39:16 +0000 (UTC)
Date: Wed, 7 Feb 2024 08:42:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/4] merge-tree: handle missing objects correctly
Message-ID: <ZcM0dvzqJy_PuEEc@tanuki>
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpXdqSaTPBsEJU3O"
Content-Disposition: inline
In-Reply-To: <pull.1651.git.1707212981.gitgitgadget@gmail.com>


--LpXdqSaTPBsEJU3O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 06, 2024 at 09:49:37AM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> I recently looked into issues where git merge-tree calls returned bogus d=
ata
> (in one instance returning an empty tree for non-empty merge parents). By
> the time I had a look at the corresponding repository, the issue was no
> longer reproducible, but a closer look at the code combined with some man=
ual
> experimenting turned up the fact that missing tree objects aren't handled=
 as
> errors by git merge-tree.
>=20
> While at it, I added a commit on top that tries to catch all remaining
> unchecked parse_tree() calls.
>=20
> This patch series is based on js/merge-tree-3-trees because I introduced
> three unchecked parse_tree() calls in that topic branch.

These patches all look good to me, thanks! I have two nits for the first
patch, but I don't really think that those are worth a reroll.

Patrick

--LpXdqSaTPBsEJU3O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXDNHUACgkQVbJhu7ck
PpS3Kg/9EbP4oFR5OEDmALhMhrNYRmgmJeErTIz+altefV8akv+hUH9EDApfPhFh
G/ZpKigSVcwGfff7sv6LuoAgAPx0t4VrQvQ1DjhRiQbKSF4wdnaQnKQJb+1KGzWA
zaHysgWf4wCY71bj+1AFE8C2klA36Lgn0UJ9smGSS8B/EsfWCkaNe7dc4S6f09cs
UHzjj+H3QfCSVLqvuT5jts+zvXuzUqH6xj5i0We2uRL7lG562Ze0jqFdPbo19yro
/CPT2zR4ikKzOLv19RR66gJHdVU5xey9ruCJO+JIGMVaXfZHJEc7YQXOHBvZy68U
kZzlMG2bg14E+Y6Ta8eU45NFBqRUIlFEAYcJb9zQFRMY7unrp2jPeoSW3CEtcvNt
IOtKRvIgTfdiOXewDARltkL7vzgweOs8tZ586hz4AbelcnnE5P2Tqx06IubxUL5C
JQ4W3v0hG5hAElRiHYn9zOM+kbBL6UwM/Db5grM2kOFeUIhmxz3qNFBWWbI1N6YK
CXE02JuGdGTi2NYhR7+9Nyyse62tpRZD33CiL1IYq8/prZIUvC7TSfC928UX3Vy/
8QHD0ZG5hGHJSt4UagntisAlEPwXSv7PUDmUK54//ROG6qtdShzFn4Givozs1IR0
kSNWJb9A3huhw6NHRghDSWh/rQDAobUpcDibOZ6Q9afvZxFN5bM=
=CFcV
-----END PGP SIGNATURE-----

--LpXdqSaTPBsEJU3O--
