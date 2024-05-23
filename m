Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41902EAF9
	for <git@vger.kernel.org>; Thu, 23 May 2024 05:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716441984; cv=none; b=uoaNS43eew98L7B5WSIMnG3qCFG3qX1769vqAFCbULxtFPh8MyTE8NGd+SQ2mFrZGCIAb1Sx/EjYuidZEq1vrLjShkzg1qz2czRTlne1ROaSZpKEDB7G0hhqcoKAs7YK9si/15sm5SP0Vdm+mZXkBZc6/rS90Xyt93D7tqPxd/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716441984; c=relaxed/simple;
	bh=/4bGF1car1QW/fRBGp3cfPklrtXj65aBAyOBTSE8VEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhD4IQzunMLgjxsYQtTNc9GJbp+LZzQ0Vxy4bNQkptRNhltuKtFH1Gp5XCDP5/SBWIPOtuqOouFhwfJLOxxUG+tkW4VnfGmPAO5okh9IowvlIKaT9hS+hDQL3Mm6MB9xM/8dQ7BGZGQBsZ3O9mXuvOCjqyhmeIcZbu6FnZjaTO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=K5laxvzl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dW7pp1at; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="K5laxvzl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dW7pp1at"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id C87EF1800128;
	Thu, 23 May 2024 01:26:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 23 May 2024 01:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716441981; x=1716528381; bh=V4p8nyhwKc
	DRz9GJFJikrf2QjebBWiCrHLmicMNqNSM=; b=K5laxvzlXtRBug8OMZiTP2/7Vf
	MwScpC5rs+kBvmR/SkMFLBVfdZMK0/ee0VIjoVb99it/Pch9mcZxOHB1jPGPlkRS
	lYMzOnxHgu05bONwjH4svv98HfckOaZjuwwGWmN88OELtO76+CLvHPN8vvI6qgk/
	A/jb2u2Nbe1Yp6aht/SHXc3K8mzh5HOgZDJcMf0bRIKVLyaB7N2EMb5FlS7oLW5U
	JpD1IYGJygbn57LKEi8U4i8RMvSWCEj4k1olz6nhzR+hdMuHqmcpTNxxc49blAFq
	yBvbS/Co42r1rdK56rAf5tx60K4DPKB/kg+t9EsZ8y3tHuwqwwnU7D62POEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716441981; x=1716528381; bh=V4p8nyhwKcDRz9GJFJikrf2QjebB
	WiCrHLmicMNqNSM=; b=dW7pp1attLHOq+4vc1GOJrlSL4FOkRrMOllpEdwONfrk
	lLh1lYKwComgESk01zGOfieXrsbEOcIofWWRyFByUhOtc4L1BvhoK6mk7VbEJtH5
	V1W95HH33kWn7w8q4lDnxwG6PqxPmZDNuVUC4RlDDwcIrwcRLE8NhEmWXVRfAIZY
	8+hrEkuTO/yH3im12mKAqfYECoJpKfqQen2bNZ57nWkvpnYO5VHIcD+C8LebUJwr
	eAxaj3+xtGNtFe50XWzaZk+BUxBXVcueZD4p2pYxbWtlv7tAPbKsmH1hD025HCH3
	xMPhZo+p+CMPUVTbEZvY3U8IVkaLJYs5Ga9+N0Gk7w==
X-ME-Sender: <xms:fdNOZnj2wm1wrxUqelf3q9REKCeHt2KXwG_g8Yv1bzp5Ij8XjKKq0Q>
    <xme:fdNOZkDdCHTxax9TNxxH30DnGOXxwFGMqIoMhWjz53K-wjyqUTiNNgWSulZOuYsY6
    HM5swjt5YKmbJTOEA>
X-ME-Received: <xmr:fdNOZnEM7sxcUVAHtTTrBnouIfRb81m5LFbK2saGgHEsV8S7nx4O7sfbb_PK12a0Dtt_YtBpyf5e67ro7UIHhScZgnHdPG4PxLYUMgClGTWB-ZXspg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeihedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:fdNOZkQ-mNvB1rDZ4CkV0oiPt7mK7XQx8Qx3_OVS2LMfMzaAfp8JQg>
    <xmx:fdNOZkxft-Jlg0VxjbP3WJiyQZLjYbwXjLudahNcBaPNJSWRvA6hVA>
    <xmx:fdNOZq53qIpqAWcUgfKeDFPJxDCivC4gBIStBgtp2EGObNRusmNCMA>
    <xmx:fdNOZpzaRhDu4AkAdQug9flfaUTet70doZ1uu6ifrq91NZwZeMA3Mg>
    <xmx:fdNOZg_l2sVXo7lIH-2XCPfiXTEjuaVuvIGE_HL4KZPmspvbnnrfFX_b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 May 2024 01:26:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3aa4eaa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 23 May 2024 05:26:14 +0000 (UTC)
Date: Thu, 23 May 2024 07:26:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: [PATCH] setup: fix bug with "includeIf.onbranch" when
 initializing dir
Message-ID: <Zk7Tej-AII3Ge6Ge@tanuki>
References: <D1F5SJ52H4Z0.1NR7M8APRFTOB@protonmail.com>
 <cf182bb9ee7d4a7eb46e5dbf4f3ef5deb198d823.1716374321.git.ps@pks.im>
 <xmqq4jap1hs7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5TR46Dr5nkvInWUx"
Content-Disposition: inline
In-Reply-To: <xmqq4jap1hs7.fsf@gitster.g>


--5TR46Dr5nkvInWUx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 05:41:28PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> > +for from_format in files reftable
> > +do
> > +	for to_format in files reftable
> > +	do
> > +		if test "$from_format" =3D "$to_format"
> > +		then
> > +			continue
> > +		fi
> > +
> > +		test_expect_success "re-init with same format ($from_format)" '
> > +			test_when_finished "rm -rf refformat" &&
> > +			git init --ref-format=3D$from_format refformat &&
> > +			git init --ref-format=3D$from_format refformat &&
> > +			echo $from_format >expect &&
> > +			git -C refformat rev-parse --show-ref-format >actual &&
> > +			test_cmp expect actual
> > +		'
>=20
> This is very iffy, isn't it?  This one wants to do the same format
> reinit, but it is behind "if from and to are the same, skip the rest"
> in the loop.
>=20
> I think the "same format" loop should be lifted outside and
> immediately before the inner loop and we should be OK.

Yup, we can do that.

> > +		test_expect_success "re-init with different format fails ($from_form=
at -> $to_format)" '
> > +			test_when_finished "rm -rf refformat" &&
> > +			git init --ref-format=3D$from_format refformat &&
> > +			cat >expect <<-EOF &&
> > +			fatal: attempt to reinitialize repository with different reference =
storage format
> > +			EOF
> > +			test_must_fail git init --ref-format=3D$to_format refformat 2>err &&
> > +			test_cmp expect err &&
> > +			echo $from_format >expect &&
> > +			git -C refformat rev-parse --show-ref-format >actual &&
> > +			test_cmp expect actual
> > +		'
> > +	done
> > +done
>=20
> In any case, this "reinitialize to a different format is too late"
> test has nothing to do with the problem we are fixing with this
> patch, no?  It is a valuable set of tests in the post b4385bf0 world
> where we can choose between the two, but it is somewhat out of scope
> of the "we need to initialize the ref backend before we can do onbranch
> config".
>=20
> I'll send your patch backported to v2.44.0, plus the change needed
> to review the merge of it into v2.45.0 codebase later.

Yeah, I wanted to play it safe and add some cases I felt were missing in
the existing test coverage so that there ideally aren't any other issues
and so that the proposed change doesn't regress functionality.

Patrick

--5TR46Dr5nkvInWUx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZO03kACgkQVbJhu7ck
PpR/7w//QKIfQKvgGsb7uvg28uTMu4kqynUPWlgnCM4XZZif29BO16MP3ZLTxZv/
Pk5wjBYWPprjsjnOSE6uW4OsWEvXQtEYNRk4ic+NJibKVgGEdEZ/Xe7GVPMZyqBm
LBWg5FR55ayBoo2Op7077F5wZrWBS5O5DfAPl0y3fL5opB146GSATdm33kyw5wR4
UU31ZNoaPDOcbrefmvVyjNy2RLKXK7JjrsrI2Lg7R5Z+Z0mzKh1HHewuebjtZh2N
dsbpz4SuLAQnMZf+TORNG/EpIMwSQ8vvrzzWbeT/TMLFVqz5zGKxykA83SnMwePh
Wh3wHz7re0vW7O/HgZr2YEqEoRH/M/pgrj4n+ITFJ1NRON4hClDAi2YModpU26/a
5Y4+qSFnopv/IDCYPtXElNa9j2oOPMzGFXh2+NW7V2DdA2RJuv7N2ivlHftT9pdf
87N4ZMJ76MwBC7RXU8LCMCrXhH3+hEc/HcZbQoeLyPVSL6cW1i9qpc1xoGwK6PWl
WLUFt9SD4zu64WAn7fb6/uwHHY3bNs5cEWKWN35SVxJAy489Rd65biLr6DjMIdbu
Z9yYHJpofgHo9kUhOahLN0kqbflAWa5vVqnnTIvsPcCt/UkSjb/2qVk4kDbpuetx
pBsG/tQv/lj+os6GXICMKQwSy2gIuCS1fN1MSqS/rKVskwFeUSU=
=nCAh
-----END PGP SIGNATURE-----

--5TR46Dr5nkvInWUx--
