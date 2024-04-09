Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F494C69
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 06:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642828; cv=none; b=ndxTPJqjuK/HMgN4Mv1yt7Z3EK21t76bdIG+sTXLTmTjxP2Kg/v5CM0L9gkiKuPirXHTwm/9+g594rMSV/TaDwuACi4w6JDrPBu84nppp7FipPYEzdMduvJDP4r64c7fvg/H+nOn+PgS3spBm1KlfOFBeOR0RuO+Pj3yfHIOifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642828; c=relaxed/simple;
	bh=OE/TrCanZPnzaXWXokXvaE4VvF0+9KOPEZDmxTumA8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcfRwQZBr9Q+siGd3LTdL3dqVjqOJdf5Xd0F/5QrSxc71ILvKVvz0ErnhfthJ8daC6q1lGMCCViblUB9JVSI0wWdu4oY1IdUaUwvoHJ7ubCQXiM5JQYH2CYBZ4LbiGFJ8AEJJNTXJmmKHsGuTp5tSzjaLC7RQ1vE/JWNFBXLT0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PM+KoCWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wYLAVlV0; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PM+KoCWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wYLAVlV0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 6025C1C000FB;
	Tue,  9 Apr 2024 02:07:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 09 Apr 2024 02:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712642824; x=1712729224; bh=hZHIZto8nC
	X4DEoO56vxVK9dTEs9TLMtEjhcraE2Gwo=; b=PM+KoCWS2LYlKH9L0tN5q0+ccs
	cfzbqCnGcxlvzXWjfaJ40eHJ5GTE6Owwa+ulSrqBWbQ59dADjjvug6fm6UthD9tj
	wFeShvxkUjReESZ3RcZ22p0o3npXu2HAWSjsoK3bLT51/FrsKlE9GgqyWtleNFU4
	UM4a1WKp5aUGXdTp8g8K5CLVL2qZbKab6UCi4/ijl0bn8cDOSGHFkO3XuAix69OC
	Iu2W81kKWGCXOu8mmGqsxs0ETBzHZfEJcLm8fu5YDSzrxTOMBNe7E9MoEVloMFYq
	f4TXHz8V49wcRP+mOi7/D+SSWRGSjCmFPe0e8cD1vT8ePGyOCLcHXHnR2L8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712642824; x=1712729224; bh=hZHIZto8nCX4DEoO56vxVK9dTEs9
	TLMtEjhcraE2Gwo=; b=wYLAVlV01Pcp5E5L5I7NR1aHAa4tjECJP+9OD1jg9koJ
	bssaPMv6mYfGjyJcJ10LynOQKLYC2Eo45KyQS6qm93Cd47tW3GhsxFaPtrcY2v8D
	d+pTQTW49tSRHQ/E0/tSHrEt91PBQLXNyckSONyH7/VUKb+WgWy/gJg/TcUNm9h4
	L/dgCX8Nj11KCLNS1Uvd9+maQW76owS26iEZDaXvWZ+qURdsNKgO1hhfSi0tA9Qw
	cqGweV2TRKf86JQjWSKw1vSGmz3BN//YzJyr95H/1MQjaLBtFWNtlRufDxa5hcyI
	Gl52pTyMWmLG4p39psGB22oYHHWgNygBhrAgGChhwA==
X-ME-Sender: <xms:CNsUZgxSOyxMfqpX0mVH6oqqC4js8HceQ65WZK02kl7lLv1A4y1jGw>
    <xme:CNsUZkTT_nMf3nO4e3RWEEXoUC6EtgytaNYRvZqD1IDwRK5cn3w8Z9SJFRodP7XDJ
    nUlKwhGPpVVbpIkyQ>
X-ME-Received: <xmr:CNsUZiVkXwd8py77U6V1F6sQNzrQltFifoE-ZXcZgx2HmR6V21mZtC41GHDrg5KyNWZgQKSbr_Jqcw9QzFUGmj7lnH7Lsl5APgvY4bTGDBOpE-DLzxI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegkedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvdfgveeuffffgefhuedvgeetkeegffetgfetgfehudetvddvvdeuieefleelffef
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpghhithhlrggsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mh
X-ME-Proxy: <xmx:CNsUZuhNloSg9zYf7x9FaeyOBiJx74viqEfRdmdWD-kxF5LMiQ2kjA>
    <xmx:CNsUZiBgIbzkVz5IxWY3lZ_-LyX4Iu7-OsDj5L5Ufl6epgnwVaTlgg>
    <xmx:CNsUZvJJ-fTlk8dP-Pkc5JYb6Ja9ppuSJUjBNkbh9DM4v4SSCOp0XQ>
    <xmx:CNsUZpB5ScA9eu_fDula9XXWeMfBiTN8Hwlx0WOsVkA6PF9KEjdb1w>
    <xmx:CNsUZk1SkQqq3q2vH4LOQE8625GxufLMOhc13b-PPjideTZ--oQo42T9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 02:07:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d86fe65d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 06:06:54 +0000 (UTC)
Date: Tue, 9 Apr 2024 08:07:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/12] t: exercise Git/JGit reftable compatibility
Message-ID: <ZhTbBIdYrKdodL8M@tanuki>
References: <cover.1712235356.git.ps@pks.im>
 <cover.1712555682.git.ps@pks.im>
 <xmqqle5n2sbf.fsf@gitster.g>
 <ZhS5Ws7e0tjwlW6y@tanuki>
 <xmqqbk6j2j5u.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oKREhdAMcJanrrOZ"
Content-Disposition: inline
In-Reply-To: <xmqqbk6j2j5u.fsf@gitster.g>


--oKREhdAMcJanrrOZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 10:34:53PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > On Mon, Apr 08, 2024 at 07:17:08PM -0700, Junio C Hamano wrote:
> >> Patrick Steinhardt <ps@pks.im> writes:
> >>=20
> >> > CI runs for this series:
> >> >
> >> >     - https://github.com/git/git/actions/runs/8595241646/
> >> >     - https://gitlab.com/gitlab-org/git/-/pipelines/1243766428
> >>=20
> >> Thanks.
> >>=20
> >> When this is queued on 'seen', I seem to be getting test errors from
> >> t0610.  I suspect that it is not a breakage in this series, but the
> >> fact that this series enables reftable tests without setting any
> >> GIT_TEST_ environment variables, that causes an existing breakage
> >> (or two) more visible.  I did not have time to locate which (other)
> >> topic introduces the breakage, though.
> >
> > Interesting, I cannot reproduce any failures with the current state of
> > seen (17ff004052 (Merge branch 'ps/ci-test-with-jgit' into seen,
> > 2024-04-08)). Was this on your local machine or in CI? Which platform
> > are you using? Could you maybe provide logs of the failing tests?
>=20
> Local execution on some variant of Debian testing.
>=20
> The tests that fail are t0610.29 and t0610.30, both of which are
> "honors core.sharedRepository" with umask 002 and umask 022.
> They expect "-rw-rw-r--", but actually get "-rw-rw----" when
> the user's umask is 077 (or 007 for that matter).
>=20
> If you add "umask 002" or "umask 022" near the beginning of the
> script (e.g. before including test-lib.sh), the tests pass even when
> the user's umask is 077 or 007 when the tests are run, of course, so
> there is something the test must be doing in the test repository
> before it forces the umask to 002/022.

Indeed, I can reproduce the failures when I change my own umask. This
issue is unrelated to this patch series -- as you mentioned, it is only
being unmasked now because we increase test exposure by dropping the
prereq.

I'll send a separate patch series to fix this. Thanks!

Patrick

--oKREhdAMcJanrrOZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYU2wMACgkQVbJhu7ck
PpQ7fA/5AckmEh+gWZSZFbK/UlYJrkx+fQVQr4JKj65aOKWgHQUyYDJcQMu62EIS
nSOZdmXam+rqCe9Y3561qaBPcLMtbY5qmAYxTyM6efVSHjsJ0OHq5JwCEWzYyVin
YF7YlY5pKlJR2j7s8T4Kz7K+QVSSU1fDm6IWzcAZsapeLI2lYHBpDufxPRVH2u7F
hEUek71UTjfOSXKc+YQFWKuAvrOJ1cDXBgUjJoCLSmL19wKnin0AQEwizQbyRaCr
DgD92L8fmfzUnoUn35PtKo8RtdLvCyayy+Q3QKsXaM6XjGHChJHGNORlwF4M8+XX
k6jtfjGnxzByqjYor2TfLmRhDewVraYxxw0++eDVgk3facgsq7oF1p2O6kPQ5pqE
GSIyfoQCUeG2JPv4oHbZqBJynOmurBDQZCPoCRc6F6Gl0G7RMNVjGr2OT7dC9CaM
EfpxEc42WhTfZd0Jn4G9SYEmWjtgJTx+zaVzhlIrz3JScic9nlx/xWZzv1f3nCbk
iwm/qgE9qlnalykoORKPbS7I8XoRIhD4hY1dhmU6f6KEJtWD+w1S4AnUwHintYIY
fX5kXU93QRlL8cVTztvnR81wQk84IhDAaM6FJYFZh9EZsNmJMo3anHrt3V/oX5FL
o8yFXVjUyGxcV1kvNXSIU5oYrUuN8rVwJ0+sU/tzztMpFxiQsZY=
=MOuq
-----END PGP SIGNATURE-----

--oKREhdAMcJanrrOZ--
