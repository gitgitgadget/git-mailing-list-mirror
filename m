Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7278115B996
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967680; cv=none; b=qTxWWcbWoO3XI7HEUvZT5IdVUU3kywosXShuZy9m+RfcYowpqlGi16cWtiXqQeGtbz+R+NktNJ0I5NyfT8hvVjYTYjlItfeOkVZ7nSM4Qckc5CPutRAjhFg7kh7mH7+yc0+91C1l91vT6uVQ5E7iqNJtWlZA6J6CKa2+iEe9Fgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967680; c=relaxed/simple;
	bh=/DEIE9zvuV0lWQR/oZgPFYfSWk5sS04/wD4zlILM8VE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4dVWb+EIo6InqKlFM6LXkNTW8xNqLRuUC/pKAWQE31tCBULTezNY9aWyPtkGcOiRzk/CPgIiG0Cvji7jnCkpfIw/1JSW7AOxDGcTKstpW1418RMJteroswrE+K8hDlV7r5PgHDVtYUZ1N1+1ykRf2I1qBqRmMwQsQ3GJWpBz0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C8DnOBLR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DpNiPfjT; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C8DnOBLR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DpNiPfjT"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1DC0E1C0011E;
	Wed, 24 Apr 2024 10:07:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 24 Apr 2024 10:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713967675; x=1714054075; bh=/DEIE9zvuV
	0lWQR/oZgPFYfSWk5sS04/wD4zlILM8VE=; b=C8DnOBLRK41ifW4uaGx7/Whjlu
	dqWTN7bZhMNjPMpuVp1esCRySjUSZAiyMgqM8Yugx3xTho7J9C51gu+P/u2MEMXm
	ZEycfb9p7MfTNrdIKggC8nLDVf1grnY6xCxXgbrnSBHnuQfBJlc5Q2mEOM4aeEhK
	9VofGwmH55DJwjrsKTl5Ji0Ra9sZ/nxsCRbxMTfAcEXf6jWlcaRfItu8bqjh8WNl
	6Ww2KW+e9EsmGeBIERAsOMTCJF1ycbv4xrQd4pwCsN5vjGyx53qwgJSgajEZcIv7
	x1hdx+0KOtAOucbmYQ1g/Z6Gu96czy2YyE3J754YhvMn/IDSLerAfhXm15qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713967675; x=1714054075; bh=/DEIE9zvuV0lWQR/oZgPFYfSWk5s
	S04/wD4zlILM8VE=; b=DpNiPfjTgekiHTYi1z4+yHqbIowLRUmh3SYIa9aO2neX
	eYF4AUEDFWgA2zxAY64mNXNjPN6zGYk/O38LV83oLuyWqmKhqxiyUC7lIPN0brJS
	W5cGSbTjjIOvl92HpmdBOkJR2Zn1NLE+TknkAsPVi8zOHOdEj7UBbC0UW8mdf70e
	vFlWEv0lIRLFg4hSI34D8KbZxsV6VRMsFm0FeaxYThMw9bfJgPoWmQ4I480YlbyI
	BWl53e7CP1W7IL4jP1OwmSQc0hbYTF7L35TauHP2jo7lx/juIGZEXP+OOl7MhzK/
	isR2ksGRdjyRYg56b5FNbhHy8UOObB6oqlhZBXeU3w==
X-ME-Sender: <xms:OhIpZnYr-k9aquRpsE_EkCd1DQX5pG-gJ7vu8ysJgOqpoGCjPcNdoA>
    <xme:OhIpZmahTn2jeHx6uObGlBJSeeD1ZqVJSlP5OyUOHQLptWPFPHPUm25BSHpQjSaqB
    YZ6V8I72IlIiTkq6g>
X-ME-Received: <xmr:OhIpZp-05DTLuSR3xxN6ZJFUrX6PNh-aMe_KIUbzcBdVuBpXN033Yntv1KN6L2me_Su3UbqKUjzMhtktk5Lj9v86sTHa8nA7b098LOe6oGvcDpHUPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelhedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OxIpZtotH6nSsh43DC8isI8AzfAF6zV9crFX9UP8ZVSMO_oj6pcJZw>
    <xmx:OxIpZiomtJIVFhJYEx7SlOwPpxfrYuNuxyGaBUNAKLquL-7Zz11Kzg>
    <xmx:OxIpZjSYnGy0rEpr1xMTgY1PgXC_DYmmVtc_UZuq1HDbDKbi0SAyLQ>
    <xmx:OxIpZqoX-cn76HsB4tEXMOqZKkUDoRyc9xZo4szQmr2fvnhLWCbXHQ>
    <xmx:OxIpZrkxUhWt-HlWBrvzdESWYF7bQ23rQ6-ToCXeGQoqHAE17i-9i7RV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Apr 2024 10:07:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 30bbac4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Apr 2024 14:07:41 +0000 (UTC)
Date: Wed, 24 Apr 2024 16:07:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, James Liu <james@jamesliu.io>,
	git@vger.kernel.org
Subject: Re: [PATCH 0/2] advice: add "all" option to disable all hints
Message-ID: <ZikSNSszRzBz715c@ncase>
References: <20240424035857.84583-1-james@jamesliu.io>
 <xmqqo79z2s24.fsf@gitster.g>
 <ZiirKgXQPLmtrwLT@tanuki>
 <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bdD3P0cOR1aR8Hmy"
Content-Disposition: inline
In-Reply-To: <7d1d2892-d486-4e91-b100-e44c1d76893c@gmail.com>


--bdD3P0cOR1aR8Hmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 02:52:39PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 24/04/2024 07:48, Patrick Steinhardt wrote:
> > On Tue, Apr 23, 2024 at 11:28:03PM -0700, Junio C Hamano wrote:
> > > Do not close that communication channel on us.
> >=20
> > While I agree that it might not be a good idea to set it for our users,
> > the usecase mentioned by this patch series is scripting. And here I very
> > much agree with the sentiment that it makes sense to give an easy knob
> > to disable all advice (disclosure: James is part of the Gitaly team at
> > GitLab, and that is where this feature comes from, so I am very much
> > biased).
>=20
> Maybe an environment variable would be a better fit for turning advice off
> in scripts?

Sure, an environment variable would work just fine for our purposes. It
would probably also address the concern that users may disable all
advice and then miss out on some information.

> > It has happened multiple times to us that new advices were introduced
> > that then subsequently caused regressions in Gitaly because the output
> > of Git commands now looks different. While addressing such breakage is
> > easy enough to do, it does add up if we have to run Git with every
> > single advice that we may hit turned off individually.
>=20
> I'm sure you've considered these suggestions but (a) would it be possible
> for Gitaly to filter out lines beginning with "hint: " when it captures t=
he
> output of commands and (b) would it be possible to have a script that par=
ses
> advice_setting in advice.c to find the list of advice names so Gitaly can
> disable them? I think (a) would still leave some advice output from code
> that uses advice_enabled() rather than advise_if_enabled() but it should =
get
> rid of most of the advice messages.

Filtering out advices would be doable. But we probably wouldn't want to
do so unconditionally whenever we execute Git commands. Which would
bring us back to the point where we have to address these new advices
whenever they come up, and it wouldn't be much less verbose than to just
disable advices we face.

Patrick

--bdD3P0cOR1aR8Hmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYpEjAACgkQVbJhu7ck
PpRftA//eThtv2d24i0VC+VbzOrIetA7zPKvTg4nJvjppNWyi1r4FJIgfzwXziHJ
itYuG7I91k0JauWh5g1TefJGcdoJVoLsPDRsnjkhC+L5yVUWbE5DZpD47nH0p4X7
VrSAJvYTaeonM2RNhLKTQsP9CqljLJPy1VNrdPi+jW4+Z5RpyTOCt+rgv4UMEhpR
EY5qsv9otbzpjSSu9rNMoV2V8+DQSMkjH/KSsv6YplHUm6639rFNRE1Npjfoszmt
KXXwZdkNmgG3+bWnX9x0UkvoGNJqnJ6tutK/eY8sTZiGB2eGSj8pheBmBUnLeNGI
I3RLW5wKJr7kHaUpuRO/8AP7cqlGWqEgNS19+r2EkPJvUlNMROh/7oh5wb/IAWDs
vdt3d1YexMKrfUxaF6Xy+e1ku2tlwS4ValJe6y5Sxg4Lr0BkiuO721D48NAZrW94
PL5UoPxJuJ2dGDySLEera0fJfTYobEVv94CUhAL8bqpy5Ut2xZU80rt6IcP9NP41
pn6j6Eag76eRbHP1LqIpidlTIYM9dSETAcerrnlhl0o+APuGJYABiYxhEIZGEC4E
AgY9UqMLO7R5VNgOHXSZYqskLTBvaaQrLtY7ZGiUjUd4yZUh33VBheTU0N0Islp1
lZHXtEFV312QIJgt6VCBMwT2Y1dlGRiYH/kdAeo0zsOn4MF7rHU=
=zJDd
-----END PGP SIGNATURE-----

--bdD3P0cOR1aR8Hmy--
