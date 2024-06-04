Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CEC136E26
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 07:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717485098; cv=none; b=GAXVkBQhwOwmTAVYvjjn2jemNuWEa4E5jxTB3MbXSb8jcH6WSF1ka5TXjq6mrY2HzzkqKTQgww/OF2wzFlvnpKr7usjNuYkGQ07JvpJbX9kZhkRc8285w5EG/S4HJa089HbRjFpBPNxoFj49HJct10cFEi+msdp35S7J9WcJuFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717485098; c=relaxed/simple;
	bh=SWwsEbUxN2CjTLdM2tctdsTIa77JALILlcyJFTDNDw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k7uNDE+TkNmRPgHdv8SC9wj7/+TLVEBn/owiUVT4ZryYvcXZLXwr9Po6ppM5RAZqwqpb0/LiaDW1AwnEQj5FcCDnD10ZTyVMWYYWhMdJX+ZeWQxE66ECgDhmat64hMIkJjLQL57OBj1jeBr99ISIrAXRWvek01O+JrakckWsf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EE1nqCF6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LxI2LEF4; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EE1nqCF6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LxI2LEF4"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C4EBB1C00199;
	Tue,  4 Jun 2024 03:11:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 03:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717485095; x=1717571495; bh=fJxi1WZBxm
	bQv1k1Nryx6XPQxzaQ0vcWaCuuWtTS8Sw=; b=EE1nqCF6k+zPII365YbELdbRnz
	x0hDymKyzRPPPybqnXnuaCHobD3gPSZiUBKg6+kLBFtDvl/vMrnj32CnRufGGg3d
	qvvmjfEi7uzRHRdrec/cRwhqTWB6v65COSzxEsF2UTgaHOANd7O0ZaD+w8GbdK7y
	RKZIn9jOYr6zrzPGJH6bX1SvP3ltt/J9kobu4rzUJn+75AED8/VM7bOdaZ1et+5Q
	jev+mjOj+FO3DANEx3AjT/5w3/AakdvjadZoDHT7y9oxuc24tDlpMo15vDRO5MS5
	ImaQ7nZlUh3rf6OdjmNZ13SoLodtWNylIOiZR6mBHHIvQ6PcwlIubTIjYPWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717485095; x=1717571495; bh=fJxi1WZBxmbQv1k1Nryx6XPQxzaQ
	0vcWaCuuWtTS8Sw=; b=LxI2LEF4xr1qKSk+9tBetvNj+smlTyP8UrgYH5C3/qtS
	cLrKO1Wxb7z5rmvn4gV23mL2Gn5ompTc0NGb2WxPXaG/Kwy/bhMoQ+2i38YYxYGK
	JdDugDnmZjuEcT1haA1y/ivDiYz3v0eR/nw4ay8jE+B6NqbqSD5+8JrN/rzWtGtw
	fKu6hCzZWv7kGphVT0gb8haO+GHn3YMcW20Xl+mWMSr8jh/0vPVd4LPsEsZc4lw/
	mDt69j76BY3Kbs12S9NsGI8HgIwI6hJqukqBNQEZJzsFKbX00YFYHPBaOvHPBcIX
	Am0JUdV/afdAemEoK0HSEY/+5Fdc3aJJToZ+MKiP/A==
X-ME-Sender: <xms:J75eZl0HplTzOElJ2hQvNbzLs4p2bu0VyHaTnanxrM7ILMWnbe9PzQ>
    <xme:J75eZsHMAO2L3vmpHdCYO4o5dPi2xMthUQItuAqkzeC6EasFA95P2xZXh08JJuBkf
    xvHb-GUCOSCGl9uKQ>
X-ME-Received: <xmr:J75eZl7smLiP-dK5Az1wb7STQXSRJMnwXj0cjpIyylOuFG9QA3TnV79D8Aj8sviocwMbnaZ7YF6BPyXhKbW3awszyIwSmJIn3GOSFh2Zw1uKtDfi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:J75eZi2EBK0y-Pp5DiOC8RVJL80TskdNwBUaEp_OKrsX6mISgzg2HQ>
    <xmx:J75eZoF5bNU890VVwhbrc9BX-QfXDITrdwc3cEVEP_fdsdmsa9ZjoQ>
    <xmx:J75eZj8-LLawSCsNS_iS0yAXPDe4GKgsntPvwz2U-5BIdAEWoOc6rQ>
    <xmx:J75eZlmsdMe_qDujnWH5r9RN8-c3zSy8_Ee2YuU_ev-ycO0X9c5NKg>
    <xmx:J75eZmao86KFr-D_YSFl_4U2rwmADkscnZY-HzFJ5c2DbUeLIosVHqwb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 03:11:33 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eb09c965 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 07:11:05 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:11:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v5 4/4] BreakingChanges: document that we do not plan to
 deprecate git-checkout
Message-ID: <Zl6-IXA_REOy05wh@framework>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
 <9ff94b6f320d76e6b7c767e855038f33b69f4155.1717402497.git.ps@pks.im>
 <xmqqo78i3r5a.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gFy5CVX6Ogw74XSx"
Content-Disposition: inline
In-Reply-To: <xmqqo78i3r5a.fsf@gitster.g>


--gFy5CVX6Ogw74XSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 03, 2024 at 09:52:33AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +
> > +* git-restore(1) and git-switch(1) have been introduced as a replaceme=
nt for
> > +  git-checkout(1). As git-checkout(1) is quite established, and as the=
 benefit
> > +  of switching to git-restore(1) and git-switch(1) is contended, all t=
hree
> > +  commands will stay.
>=20
> "As a replacement" is probably a bit different from the truth [*],
> but I suspect that the reason why they were introduced no longer has
> much relevance.  How about
>=20
>     The features git-checkout(1) offers are covered by the pair of
>     commands git-restore(1) and git-switch(1).  Because the use of
>     git-checkout(1) is still widespread, and it is not expected that
>     this will change anytime soon.
>=20
> or something (borrowing from your proposed log message)?

Fair enough, let's add it like this. Thanks!

Patrick

--gFy5CVX6Ogw74XSx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZeviAACgkQVbJhu7ck
PpThBxAAoKV80kZHN75hzmzjnAmaeAhWrsbPWzrwvE3qy9THDV2UzL4LRW9s9Tky
uQkq0M+fEoY1ZJ8OSQnYja4MQY3V3GXYGWu52lAubIWjVAdqbAmeLh9zSFJLT5db
rC0xxw49Dw9kQ7UC2oIlOuCi9Iyk5Th7A4Yup9TrAK3qL4n0Dwq/ievZgK2opu+f
KtHz3FTmL8RNcE/CJ1fu0imjbXCQahmQ3BbsCzx8SipZnYDMRbEbxtn9V+MvFWJY
DJAMkKtlh5H0ENLkwxKyGH8+ixFnrn5mD2aFnEEgFDqI+reY5AhRFU006bm4rbrX
TcTpY2FubrY1peJW8QL4EPjW0YS7b/XVdF8yqyl+pkW/qRveoufWaTNkpd82ZE8L
G+Rob8HJZ5aNdvRwyMT4grEfoFw/gzexvZiTCPecfHHnsfQ8PMrFvTuD8uEx48F7
NQWpwxVTryYlN/UVuqvyrT8zRJBmajN7yJvIzywIhWYz2G25cN+dVOxs3/tjyque
Ur4vbNjmkBRq+XgHZFkgD7hrqn+EvtSacBwP+rHg3ikCRvV8ShPQ+v01Se69KQkE
6COnq5FtUcHJwNg0AMMvvFoJ8+QIQjmxbGfDbghh1gWCQkiUKKTGLkVLkhPqkbsl
4TZy5/VDocpgZzQ0/zVKBRP3VhTXw42kecBPqNICRZ7Kes9li8Y=
=dZI/
-----END PGP SIGNATURE-----

--gFy5CVX6Ogw74XSx--
