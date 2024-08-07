Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE00191F83
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 05:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723010161; cv=none; b=C5Qm3bE/NEncS3vGFgUgjvSe/CD7iFXSzokpDHlXOvpZY08WTq1HeMv0fievkQBZKCaDuSyNWGENEMiZqiOG9wzrvagYADO0iq00i+kPYykEfZIvTJNhV+hlLaH+JPMQDQIYtqZXgjnQd1Igg2umNtThM95/4FLqvNfWC39HY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723010161; c=relaxed/simple;
	bh=oBMR5fwWWIivSEvCsfJv+Awdl4YdU9LzwQC3suPTD10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sy9hcpf7pcUFetbQ3/2q6aJmQkWljEsqcc+EpAcV++T/8nhPCDkuLuoouNZao64vaJEhZgSBZtuHGU9goevDwLWGi5gqvpONOY6i+e6hjs+oJJE5yJme5OYYHTep6jSTtv8oHlxdhr7qywTZsHCIyhu6l3LGycKev181eJ7qtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lD3Qdsi9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=te9HHo4V; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lD3Qdsi9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="te9HHo4V"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 98D5A138FD35;
	Wed,  7 Aug 2024 01:55:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 01:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723010158; x=1723096558; bh=hs+0ejnt1i
	Girrad59SPgGlFGbN7KjxmJpYI2HQnsmI=; b=lD3Qdsi9OLmJmbbKvej14weJeL
	VTwkxMZBBEMPSkl+5m/w6VfRjV1VITjexf6Cc/nymqOQrPvcjDWicfAyWwtTQC2I
	HofAAuM9114vZpnVylaT9+i7sG6gFjdUoFloaH3H8jZJ13P7MvVb7MZznxutgd6r
	sXX5ZKBoaUiTGcQqFoLgfuLTQxFelyd8uWjZFKwX9GJ6Z+XO3w4oRWnnRMloIFPe
	cDQ5tnb+WSWWQPzBjH1aoeNwPzMuX8BWCAjab2bPAS+z9SB91Cz8vIc5WhsHJIZm
	ejsBuZGYISi9/+2h2hlueDyU6tCd6Rmmpuh4CzYYhfg05Bee237QWgNloG9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723010158; x=1723096558; bh=hs+0ejnt1iGirrad59SPgGlFGbN7
	KjxmJpYI2HQnsmI=; b=te9HHo4VDd2Ap3XHex2R/5z0l6Hidb2IpeZREJP9v4ra
	L1/G/a8sAuk2JdyR5JyzyOD66Pvsr86xhPW6ZF+Jq2VjZzw0lSv+W+BMVJwEq4l0
	0Z7f5GnsyjAZu2XcHW+TtJ4IBNiSfmQlRijHFP9QlO5oRpMR4W5zFInnrLK2Zv2f
	On1AE719z4y/sxM5lBTR69U1rRsEcgL67dV9fhkIZItKshoy15uu3/QCuJ8Ng0+3
	t04TLmrAmbM1/c6PgofI82ckto2cD6S6RWpkX9pzrXiUQm/Q6ehYdHtaG/+wkXnV
	lWpvhV4DqooyqdqWdliFLCO2GCkWNmTalPsostpRYg==
X-ME-Sender: <xms:bgyzZkcJ1n-jxMeMqQ1jJWif7bGOQvY0pHmTkMmy6T9YuoHYRl1KVQ>
    <xme:bgyzZmPZ4SFlWIYwHrsCGGNF-Y2bp4EBEHJtolGftJr0UTiEgqhwsaAK0tljKtHw_
    s2m-YfQ-YfofWyPAA>
X-ME-Received: <xmr:bgyzZljZHI8gKK8frk0dEcKnZhvh300wXN-qkM8vSUzG0kLBjqrTmpnwzeOup4_b9FDF-1JkJP0wkZqhcv9OI2wLQkV6_y0ekRXm6qkAqTGZ5thE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:bgyzZp8GkcxnaYWP3MS0W-4oxg2KW-UeIgZCETUYSiRA5pKJmZa99w>
    <xmx:bgyzZgtwip7Izo0bMRfpHY5KQHwcZiT-9Szimvz5ahCggXrPI1pdhg>
    <xmx:bgyzZgEzpjZcQPmOTNWRhiB6rgcReDnR41cEDZSQ0Kb1mSIdyPhx8Q>
    <xmx:bgyzZvMuIOyLftSoQF0mtqwXdDxtQgFXPvmMb0LkxTOBFaX7GehhGg>
    <xmx:bgyzZkhOBKFpxkfHy7SIOhqZ2xW1pKFwSu15cZYjU8AclzomK0BUq-e->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 01:55:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d76b31a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 05:55:52 +0000 (UTC)
Date: Wed, 7 Aug 2024 07:55:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v15 7/9] builtin/refs: add verify subcommand
Message-ID: <ZrMMaubE_V7wUZ3H@tanuki>
References: <ZrEBKjzbyxtMdCCx@ArchLinux>
 <ZrEB16WGGc28dxu2@ArchLinux>
 <ZrHRpnpGkH19godh@tanuki>
 <xmqqsevhy6e7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8626L+SvbwaK0suk"
Content-Disposition: inline
In-Reply-To: <xmqqsevhy6e7.fsf@gitster.g>


--8626L+SvbwaK0suk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 06, 2024 at 09:15:28AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> +	if (argc)
> >> +		usage(_("'git refs verify' takes no arguments"));
> >
> > Junio has posted a patch series [1] where he wants to get rid of
> > messages that simply say "no arguments" or "too many arguments".
> > ...
> > So I'd propose to make this:
> >
> >     argc =3D parse_options(argc, argv, prefix, options, verify_usage, 0=
);
> >     if (argc)
> >             usage(_("unknown argument: '%s'", argv[0]));
>=20
> I probably should have said that I am fully behind the intent
> against "too many arguments", but I am not 100% behind the
> particular messaging used in the patch series I sent out.
>=20
> One potential complaint I expected to hear, for example, was that "a
> is unknown" given when you said "git cmd a a a a a" is not all that
> clear ;-).  To alleviate, you would have to say "git cmd takes only
> 2 arguments" if 'a' you are complaining about is the third one.
>=20
> Also, many people would consider that "unexpected argument" is
> better than "unknown argument".
>=20
> I personally think the message above is absolutely clear and good.
>=20
> You say that 'git refs verify' takes no arguments, and for somebody
> who said "git refs verify a b c d e", there is no doubt that all of
> these a b c d e are unwanted.  And there is no room to misinterpret
> the message as "'git refs' is ok but 'git refs verify' is already
> unwelcome with extra argument", either [*].
>=20
> In short, I think the message in the patch here is good, and it is
> the other "war on 'too many arguments'" series whose messages need
> to be thought further.

Just to clarify: with "the patch" you probably refer to the current
version that Jialuo has, right? In other words, keep the current version
that he has and adapt the message in the future, when we have decided
what to do about those "too many arguments" messages?

If so, then the only two I had were some spurious newlines. I'm not sure
whether these really would be worth rerolling the whole patch series.

Patrick

--8626L+SvbwaK0suk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazDGkACgkQVbJhu7ck
PpRPcBAAonRH5Zk+s+fwKcPQoydOycL3pmxvF8U3SndmA+Yf1CHVUMhv7AkmB8TF
wcDS6Zrv1ZrZYyqJBd5bWWyxMG5+GlvJ1rcgw9K/T6Py/VR6at6QEvOcgfPdnUlJ
xpqxBBb09n9+zhY1BtJl3egcOIIrgjJj+tbLRHT1NiKOtFV/wFu3IjgQ1XFkBR6C
Lv+f///a7sB0tOhYyU6ATq23Ij09aWRBXE98xUqJLlDXNclf8akgBMEC3bPEHZaq
iCpTqPulABgUEuBCaeIFDrICaDCob7XSa4Bv0ftI/RWruKogAddqZ7+OSsvdacgr
woX6M+0FGjHmmdteXsgMJGNJU5b0wX/H0ya3pYN4BJ1b4SFB5eDAy/YeAYNLbVB7
7J6wmaq8EffNX5joYB+5tB0NMbtNrP94ioTyeSJ/5U8hs301EAVyyYri6XlTOQJB
MnLchuWbxM+sZoVLMGJFyOVWawxtDrOEOHDn1ygzUKeH5D86oy2KafOCMsfqLQgx
oPviK3G88AmMSUhGDeE5k7fTyrDSKThxhN8RAEivKtJSttPMIoTcy+IGiEnUhtgq
iDZMXOagHd8S9vk4Slbk2hQD5sg0Sqsz+wv6R67HSZ3ok7kgliDTpacnKFmBGnYj
pRm5O5o9wOoip+shSM4fNdXnTYitVrS4aKoaFz+IaZ28/eutwOQ=
=rd+e
-----END PGP SIGNATURE-----

--8626L+SvbwaK0suk--
