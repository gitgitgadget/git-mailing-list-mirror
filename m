Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41557581B
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 14:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190515; cv=none; b=pUKT2JIoGix4KwthoTt8rVFSIGi4RT8EtUWvGhuR3yOxpZXD4E64T7vThEPRX1JSb3/IT/LC3ksgEINfordbPB4RmeuGZjR5z+0YEOj+DS6qBhPVkOrr6AVOQnRDG/EONqnBjD7KYTPrQGyvlwhk37zVYM6Panl8xy81PnCF4yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190515; c=relaxed/simple;
	bh=gaOEU9qYoEZ4bVkdM9vWOpbE/x4NVPwu4HoHzi4Vr/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFl/7wanze7cWexS5ieZ2ayms7xPytjVmCCKK2yZnevFFAkuMiOQyjNJ6jjTTyxN4LfFo8BtHsLMuX394XcHUzpaHaPMxgFHSwIdo2n+czAeKVfMrm1kjmZXIeCdErNLmn1aZEp+iLvnZHr45tdXAD4OkakT9hPi3PwTEClovQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqTOMk/b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XawwtljN; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqTOMk/b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XawwtljN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 89E5718000B4;
	Mon, 15 Apr 2024 10:15:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 15 Apr 2024 10:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713190510; x=1713276910; bh=gaOEU9qYoE
	Z4bVkdM9vWOpbE/x4NVPwu4HoHzi4Vr/I=; b=cqTOMk/b5PhqiSFdDdbikGU7iZ
	X7a/GXNsBiKZfRcDU5voayKKPkXn9+N+L5G2ldAP7WGzFxXwbDY8HHnIyi69TLWG
	l2ViWMamt6uBD4vQkUzpH1EKPH8+23PV6Rr+W0sewt5O/RAC/0hnlKDhYxnN7xd8
	EYmrLAuAbjsSa/+ITGRk35yPyz7ajzGNEaqCHVB06dxrEpH4n5oviEiO3ZSZ2KPH
	52lb/s7k3YueF9sW7oOASlEYMN+Z8EU+KTx8nAJaeWcG5zI8d+foz6FqVHyDo0qx
	6RqcgAlX0I1XG+SoMSdM522gwRcKJKdWzmzrl76NwrHlWCkD5vIXSgjEkt3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713190510; x=1713276910; bh=gaOEU9qYoEZ4bVkdM9vWOpbE/x4N
	VPwu4HoHzi4Vr/I=; b=XawwtljNoe6tPwCTRcbTQijszUcHzR8wlKTR7LYStLP3
	jKSpXodspv1HGTJ+uQiHtasdYEhBPmubcK/tvOTXP8Uq0/SZXP0iDFr4VnNdiFej
	jYAWSduPCOMPmMMlBYlM7FCYNKrN/A8cxLvSVTarsTGByvV1XlsuziJ6g6F++Gc0
	UPg2FAZebfLPrGQAh4qK12ivPW4odfaF4mpQv2KCBCGiJSde37pPUhGQmdpwDVqB
	ntOfP45Z0mcolqHfnYjXHajOr1crUVgZVBeH8ulrCl5kJUSHaBXXk5hvkDKyhrZ9
	JWibsMXS5M4CvflRGqeAr3oqScGIl3Fr6xioU7P9nA==
X-ME-Sender: <xms:bTYdZpXrR7eAEUm4G2CML-mc08mLExUcOgFjFYoELorqHWMakEu1TA>
    <xme:bTYdZplImVLtso2VVTJWE-YX5wNYaGD7utDdsIPlO1Kvzzk_et5GJi_gaoy5OoDdF
    10Vt0-4Jxa_GnUyNg>
X-ME-Received: <xmr:bTYdZla36XQQREwd56PYnuCkCTO-uPMIoMP1QrCV8GX1b-5W7J_6-Qz4HZZo-vamLa5qWPM7g-ROBKq-xYjnt2fHHRu5IQrjKdpQ3z_9UHo52zlBtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejvddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:bTYdZsW_ZZ4I_IYg3UvVrw3emdWZMz_kSd5cpiS6eroTraO_fj6bCQ>
    <xmx:bTYdZjlpfbe3pOSGdUHoQnnFr_RTkVxRHD14XNp7Hvp54NoITI215A>
    <xmx:bTYdZpefYbzA5oTwPTkW8MAF_eJoJ-NlgGx1Yi-zCuD6kVfpVp6rOg>
    <xmx:bTYdZtEuxG5iSXmPAfwdEcniw7AFz_Qd5YnaE9mrAQ9CiXBJwiqYEA>
    <xmx:bjYdZowEjeTKXUG-X5J5R9ZE229xSwKQ4UYkEZy8jXCqdOx9KpW8hmpB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Apr 2024 10:15:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 39a01e19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Apr 2024 14:14:44 +0000 (UTC)
Date: Mon, 15 Apr 2024 16:15:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] global: drop external `the_index` variable
Message-ID: <Zh02ZpS8x9H7FpHJ@tanuki>
References: <cover.1713180749.git.ps@pks.im>
 <28541f00-9054-4aa0-8e47-348043b5f863@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h9/gum44lhBNeNem"
Content-Disposition: inline
In-Reply-To: <28541f00-9054-4aa0-8e47-348043b5f863@gmail.com>


--h9/gum44lhBNeNem
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 02:55:07PM +0100, Phillip Wood wrote:
> Hi Patrick
>=20
> On 15/04/2024 12:42, Patrick Steinhardt wrote:
> > The motivation of these patches comes from the introduction of the ref
> > format extension. I found it really hard to reason about the state of
> > `the_repository` and would like to continue its deprecation in favor of
> > explicitly passing down a `struct repository *`. Getting rid of
> > `the_index` is a first easy step into that direction to make things more
> > self-contained.
>=20
> Maybe I've got the wrong end of the stick but my impression is that it is
> the use of "the_repository" in library code (i.e. the files outside
> builtin/) that causes most of the pain. With that in mind would be we bet=
ter
> focusing contributor and reviewer effort on eliminating "the_repository"
> from those files instead? It would need to be done in carefully in stages
> but would bring real benefits.

I see these two things as orthogonal. Overall, the target is to have as
few global state as possible. This requires us to over time remove both
`the_repository`, but also `the_index`. Removing the latter is a ton
easier to achieve than removing the former, and so I took the easier
step first.

Whatever we do, we have to do things gradually anyway and thus we have
to start somewhere. I've already got more things in the pipeline, where
the next step for me is to touch up "refs.h" so that we always pass in
the `struct ref_store *`. And here we will be introducing more uses of
`the_repository`, as well. But I think this is okay, and by working from
the bottom up we will over time get to a state where the lower levels of
Git don't require globals anymore, whereas higher levels like e.g. the
builtins still do use them.

Eventually, we can then introduce a macro `USE_THE_REPOSITORY_VARIABLE`,
similar to `USE_THE_INDEX_VARIABLE` that I have just removed in this
patch series.

Patrick

--h9/gum44lhBNeNem
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYdNmIACgkQVbJhu7ck
PpR2xQ//fvXy8+sWS2NnfEWwAu145GAl4C7tdpJZZgbwdgnRfXpHoS0walBycaaA
rI1p5SPlMUJArnuSUkcMo3XN8emi8bVxFnbLx5TMJ8ACmWbSjEmXpGmFrjguYkXu
ok4CSeHwEQd25s0O0z6yeDHQXB61hM8X9k6OWeh4XnigngYCS7+hZZonuPGAGEa2
MZa2MZU1yZeQUxyMmnE+VyuhSN2rO+/qjwONk6Am5m2RXyQecifN7jt1nc0Br2ht
CzPlYQqC4VmjZQo/NtdN7AD4dL3QJAeALtzwxVAYI8Mv+ravEFEH6n13ta1P9dlo
AXCXXje80rVAs3NSqtBRSg/V2BKaUOgFhNF0iJtCEG+s5ukiFwEHX+jZwsM4dZSv
M5K4FgOyS8yCmHpo89+HgO95A/H377QQIS4LKGXdPrGOMWCcEY5afOgDvEKY1Vi/
u/MuR353P8w4Phij9gemSh7aHIHUnQR1P1nuy3gmnoqRm7jBWTzn7ml+EsNbyhRv
ZxJCGKf50Vjwm8V3g9Uxt4nxVZgdR+aQBm8bE1meuWLANmWC9AnL9fz4JI5xKyo3
5riJCzW0shA1vgo00zwAuQf4TRzBdRFCSvO3QCegl37ha4zHKq44krpCt8Sped+d
ctkDVkQK3K7T9vh6W7C9X0WJLgrsLlN1Y3RNtXD4kr6yHjxslIM=
=o7Mw
-----END PGP SIGNATURE-----

--h9/gum44lhBNeNem--
