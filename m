Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9F3381BE
	for <git@vger.kernel.org>; Wed, 15 May 2024 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752443; cv=none; b=BHFn9EnXebzzb4TB1odr+IwUSBVWK7wg4Ki0rBO1ypdSXP5HRgzCIexD4U9xcSrpAI9rR6oZLvXrVBb5+zp8/2uOb8oas3PvI15V5Fgf01zrk1clwWZpnMoRmUTeHZCkLencxzaA9m7vDqaTV25ylR2hy4gP0Yb0EdvUJ6FhUxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752443; c=relaxed/simple;
	bh=tgw9DRyfXH+e6TVQkiLMPp0swTckzmozs5hodI7PcSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0Pcp8+e8B46WEqtU37WTdqrJ+6vXyngi0hnXdcpWI9pPk9s8LuLOIkIhO6FMPjfsb0zaRmSWTkvAUEFtLVqbcoJADxKmT/DSW7KxhDxnzu8ocSsCzKf7WCTTMPxlmioMdfotgmUGLmmQqMJN1sNCSh1rfTbXeLAsGtfHfVglYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P0jG8S/u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e0BYIU0U; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P0jG8S/u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e0BYIU0U"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D9B72114018B;
	Wed, 15 May 2024 01:54:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 15 May 2024 01:54:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715752440; x=1715838840; bh=A7z49wvu+g
	kBSsPMuJaAnatbl+drP79PElngzm05OUU=; b=P0jG8S/uEpc+ejTH8MAuDG9jpQ
	IcKKqJmPcgapY78megqt8439Zpm9VbgtEYa0xkeQjMRx74FJ7agBeaxccLPh6XQt
	2BeJge5pbGwr9992euzYRBHIu4kCk5XCCPKc4b/1ZvtBeZ6mdrLqCtFeykDb1irn
	IfdkIlensdGHcy+Oqz2iOt4y7lu5+0jEESYxAGFXEa6DLpsQh7v4UG9s124x1lrn
	7f9X5KBZk4eej/+RH2rXAbHMVTLZXF+HTkKHtpHPAV91c/SW83u9323aZopW14Cv
	RiJPS053hkxpimf5QNjKTSPKqbgwpOEq2ZfVTZDsZOZASS8kPN/1EdVFTRIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715752440; x=1715838840; bh=A7z49wvu+gkBSsPMuJaAnatbl+dr
	P79PElngzm05OUU=; b=e0BYIU0UOsE/Kf1WUphca7YldOz+AU+9OHcl9jIRCvLG
	T6QEnNMUZ+DQase8MbyTUxEdkU1eNlHmKOdkgqrq3hJypeztU5ozoVH0nxFlL6SM
	zmLj1An63PuYRVW9TDOqVziHkcEuWSlq22ptsruEFJ5Y5zUTFOiRo24pEf7t+l+E
	22GH+Je+5Z5a1iscJY8PDXrFsZZv8UTBWJBvJ5CqfMhyZ6TfUBqdJ2PMK8IxYH+l
	nk4xFkFVxuhRKgfNoDmsAZpDB0ycya/tiktUCGJ+f4A41OXuzXUO8SlsnagWeuDA
	8wRgc9FrfUJnGrxFMXKsKGhqi6WoLt8JdhJFq/wrQw==
X-ME-Sender: <xms:-E1EZsquIqPeA4NUe4L2vAAn8YbGFq-flUZW_yGejA8IGk6vHOfQcw>
    <xme:-E1EZioE_DQ16NEq-07SQB3zCPGG8miMnG99WgT_2rbkZvflorgD9WBUjBgkdSPBT
    lfZBoDv44Z3RkgZ7A>
X-ME-Received: <xmr:-E1EZhPaIzVSkbvC0vN-Hk0t16OCF6Cz9fQWdFGHPjamoMnr0ZPJ2Y4cQsbDR4XI7jsk9x_cKPr78Xmme0yjJHZljJyB2x3D_F1D79xG2rQLTtlV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-E1EZj5YmJ6i0zR1ZbMGF9srHHDERBqhkkDv8QPf7ckXR8b0-Tq05g>
    <xmx:-E1EZr4Kkb8bfQy5OEaPE82r8PN2mQcFaulGJRqWErEZ0PIYoM3Dww>
    <xmx:-E1EZjjjdgxJTUJ894-7HhaPC-rUYkFVAN6FvD_PTIdPvdyPs6Q7Hw>
    <xmx:-E1EZl6gAJkBjX19uF3iyBXKX7-Pldqe4oY-UouSn449uFjMNBcQEg>
    <xmx:-E1EZu2cNgFC0Nh5zAp8z1P-_SEQMVObRaOPkz9TN6VI9fPzW6SRM0DO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 01:53:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 04fe6a93 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 05:53:34 +0000 (UTC)
Date: Wed, 15 May 2024 07:53:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/21] builtin/config: remove global state
Message-ID: <ZkRN8nNWiPdpflsB@tanuki>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
 <xmqqzfss78kw.fsf@gitster.g>
 <ZkN6s1OYfJOpy7x3@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="15+obIT6oAk/A/AP"
Content-Disposition: inline
In-Reply-To: <ZkN6s1OYfJOpy7x3@tanuki>


--15+obIT6oAk/A/AP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 04:52:35PM +0200, Patrick Steinhardt wrote:
> On Tue, May 14, 2024 at 07:48:47AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > this is the second version of my patch series that removes global sta=
te
> > > from "builtin/config.c". Changes compared to v1:
> > >
> > >   - Reinstated a comment in patch 5.
> > >
> > >   - Fixed a memory leak in patch 9.
> > >
> > >   - A couple of commit message fixes.
> > >
> > > The series continues to build on top of ps/config-subcommands.
> >=20
> > I do not offhand know if this iteration has already been seen by me,
> > but a few recent CI runs of 'seen' did break with *-leaks jobs in
> > t13XX series around "config".  Hopefully with the fix in "patch 9"
> > listed above the problem has gone away?  We'll know soon enough when
> > I push out the integration result.
>=20
> I think so, yes. v1 also broke pipelines at GitLab -- I didn't notice
> though because pipelines had already been broken due to the Python 2
> deprecation in Ubuntu 24.04, so I missed that there were in fact
> multiple issues. The GitLab pipeline now passes with v2, so I assume
> that it would also pass in GitHub now.
>=20
> Patrick

Oh, there is a second memory leak that I missed. *sigh* I'll do a better
job at that next time and send a v3 that fixes it.

Patrick

--15+obIT6oAk/A/AP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZETfEACgkQVbJhu7ck
PpSkSw//ZZBoBqwXtPt1X2hWunVvJpyWuCjNoGvG5pBIyKprijcySaCskaborByV
PiRJtxdDqNfjlCYQFrdUPUTlK4qM1T+9f0tm4LqC/2etrtfQ885iHYZMmKHT+zca
HZzg9Rxc93t0tDZVpp7LXw+hOgyMBkB7BhCaAfav1hqZYw7Aew9TMsBv4B7nHzJm
9yPHyYjkmVGuvjv3e8zCNbM0sBMCJdtg+e34qOj0LS8otHycBDleBYURqOzkr8xL
vRS4zX39yOu0CG9+tVPwEx4qVBRlDj7lxSvQX+FwXHROg0zfv0kWZvq5/trVsk+F
CgUhtWS5+w1RB8eKHCHvbAktF4HI4BJlIRZJvNo/wq2YE7f140bn9ZT8a72SL5hY
dzZC/I9TdgEaKFgu1ze6Pw2dbjdJsv+39mb0NCRAAxbZeLcD5N/KArKHwmOzDGMX
F85ZRLZpNdDIEhXhvLtRqpnWHOb9Hycsex5C/wTsVvcLgQ8znpn1YgqIPT2XJPR/
N8N5/RiDO6vq11cGhiwu4SQWwFJBmKKOFpynkX3I+p/in03ymXy8ZrPxLJIkpDFV
ceQI4qJyAkr0PI7QVlrQhD35QUadkCsWescRcwzOpE2BcnFIzNYEMUtJKRUOi4Fu
+t9VtbFtFlTHrLBxhZuPX+gwiWP7g4obj7XaWjvYwj8h0UoYfIA=
=p9Pw
-----END PGP SIGNATURE-----

--15+obIT6oAk/A/AP--
